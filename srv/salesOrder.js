const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
	const { A_SalesOrder_Full, A_SalesOrder_Authenticated, A_SalesOrder_Restricted , A_SalesOrder_Admin} = this.entities;
	const service = await cds.connect.to('API_SALES_ORDER_SRV');
	this.on('READ', A_SalesOrder_Full, async (req, res) => {
		const dataOut = await service.tx(req).run(req.query);
		for (let i = 0; i < dataOut.length; i++) {
			if (i % 2 === 0) {
				dataOut[i].SalesOrderType = 'EN'
			}
		}
		return dataOut;
	});

	this.on('READ', A_SalesOrder_Authenticated, async (req, res) => {
		const dataOut = await service.tx(req).run(req.query);
		for (let i = 0; i < dataOut.length; i++) {
			if (i % 2 === 0) {
				dataOut[i].SalesOrderType = 'EN'
			}
		}
		
		return dataOut;
	});

	this.on('READ', A_SalesOrder_Restricted, async (req, res) => {

		let ordtype = req.user.attr.SalesOrderType[0];
		let response = [];
		const dataOut = await service.tx(req).run(req.query);
		for (let i = 0; i < dataOut.length; i++) {
			if (i % 2 === 0) {
				dataOut[i].SalesOrderType = 'EN'
			}

			if( dataOut[i].SalesOrderType === ordtype )
				{
					response.push(dataOut[i]);
				}

		}

		console.log(req.user);
		return response;

	});

	this.on('READ', A_SalesOrder_Admin, async (req, res) => {

		
		const dataOut = await service.tx(req).run(req.query);
		for (let i = 0; i < dataOut.length; i++) {
			if (i % 2 === 0) {
				dataOut[i].SalesOrderType = 'EN'
			}
		}
		
		return dataOut;
	});

});