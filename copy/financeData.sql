IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE [name] = 'insiderTrading')
EXEC('CREATE SCHEMA [insiderTrading]');
GO

create or alter procedure sp_deleteDuplicateTrades as
delete from insiderTrading.Trade
where trade_id in (
    select max(trade_id)
    from insiderTrading.Trade
    group by filingDate, startingDate, price, quantity, 
        insider_id, company_id, tradetype_id
    having count(1) > 1
);
go

create or alter procedure sp_updateCompanyLastFiling as
with t as (
    select insider_id, max(filingDate) insiderLastUpdate
    from insiderTrading.Trade
    group by insider_id
), t2 as (
    select max(t.insiderLastUpdate) companyLastUpdate, i.company_id
    from t
    inner join insiderTrading.Insider i on t.insider_id = i.insider_id
    group by i.company_id
)
update c 
set lastFiling = (
    select companyLastUpdate
    from t2
    where t2.company_id = c.company_id
)
from insiderTrading.Company c;
go

create or alter view vw_tradesByTicker as 
select c.ticker, count(1) trades
from insiderTrading.Trade t
inner join insiderTrading.Company c on t.company_id = c.company_id
group by c.ticker;

create or alter view vw_purchasesByTicker as 
select c.ticker, count(1) trades
from insiderTrading.Trade t
inner join insiderTrading.Company c on t.company_id = c.company_id
inner join insiderTrading.TradeType tt on t.tradetype_id = tt.tradetype_id
where tt.code = 'P'
group by c.ticker;

create or alter view vw_purchasesByTicker as 
select c.ticker, month(t.filingDate) month, year(t.filingDate) year, count(1) trades, sum(t.quantity*t.price) val
from insiderTrading.Trade t
inner join insiderTrading.Company c on t.company_id = c.company_id
inner join insiderTrading.TradeType tt on t.tradetype_id = tt.tradetype_id
where tt.code = 'P' 
group by c.ticker, month(t.filingDate), year(t.filingDate)
order by ticker, year desc, month desc
