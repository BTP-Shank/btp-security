using { API_SALES_ORDER_SRV as salesOrder } from './external/API_SALES_ORDER_SRV';
service sampleOrderCap {
        
    entity A_SalesOrder_Full as SELECT from salesOrder.A_SalesOrder
    { SalesOrder, SalesOrderType, CreatedByUser};



    @requires: 'authenticated-user'
    entity A_SalesOrder_Authenticated as SELECT from salesOrder.A_SalesOrder
    { SalesOrder, SalesOrderType, TotalNetAmount};



    entity A_SalesOrder_Restricted 
    @(restrict: [{
        to: 'Viewer', where: 'SalesOrderType = $user.SalesOrderType'
    },
    {
        to: 'admin'
    }])
    as SELECT from salesOrder.A_SalesOrder
    { SalesOrder, SalesOrderType, CreationDate, TotalNetAmount };  

}
