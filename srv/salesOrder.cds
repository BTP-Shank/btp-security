using {API_SALES_ORDER_SRV as salesOrder} from './external/API_SALES_ORDER_SRV';

service sampleOrderCap {

    entity A_SalesOrder_Full          as
        select from salesOrder.A_SalesOrder {
            SalesOrder,
            SalesOrderType,
            CreatedByUser
        };


    @requires: 'authenticated-user'
    entity A_SalesOrder_Authenticated as
        select from salesOrder.A_SalesOrder {
            SalesOrder,
            SalesOrderType,
            TotalNetAmount
        };


    entity A_SalesOrder_Restricted @(restrict: [
        {to: 'Viewer'},
        {to: 'admin'}
    ])                                as
        select from salesOrder.A_SalesOrder {
            SalesOrder,
            SalesOrderType,
            CreationDate,
            TotalNetAmount
        };

    @(restrict: [{
        grant: 'READ',
        to   : 'admin'
    }])
    entity A_SalesOrder_Admin         as
        select from salesOrder.A_SalesOrder {
            SalesOrder,
            SalesOrderType,
            CreationDate,
            TotalNetAmount
        };

}
