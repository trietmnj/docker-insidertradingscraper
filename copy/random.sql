select c.ticker, month(t.filingDate) month, year(t.filingDate) year, count(1) trades, sum(t.quantity*t.price) val
from insiderTrading.Trade t
inner join insiderTrading.Company c on t.company_id = c.company_id
inner join insiderTrading.TradeType tt on t.tradetype_id = tt.tradetype_id
inner join insiderTrading.Insider i on t.insider_id = i.insider_id
where tt.code = 'P' and year(t.filingDate) = 2018 and (
    lower(i.title) like '%cfo%' or 
    lower(i.title) like '%financial%' or
    lower(i.title) like '%finance%' or
    lower(i.title) like '%acc%' or
    lower(i.title) like '%treasure%' or
    lower(i.title) like '%controller%'    
    )
group by c.ticker, month(t.filingDate), year(t.filingDate)
having sum(t.quantity*t.price) between 100000 and 100000000
order by ticker, year desc, month desc





-- -- -- create or alter view vw_purchasesByTicker as 
select 
    c.ticker,
    month(t.filingDate) month, 
    year(t.filingDate) year, 
    count(1) trades, 
    count(distinct i.name) insiders, 
    sum(t.quantity*t.price) val, 
    sum(t.quantity*t.price) / count(1) avgtradeval,
    sum(t.quantity*t.price) / count(distinct i.name) avgval
from insiderTrading.Trade t
inner join insiderTrading.Company c on t.company_id = c.company_id
inner join insiderTrading.TradeType tt on t.tradetype_id = tt.tradetype_id
inner join insiderTrading.Insider i on t.insider_id = i.insider_id
where tt.code = 'P' and year(t.filingDate) = 2019 and month(t.filingDate) = 5
and (
    (lower(i.title) not like '%10[%]%') and
    (lower(i.title) not like 'dir') and
    (lower(i.title) not like '%director%')
)
-- --     -- and (
-- -- --     lower(i.title) like '%cfo%' or 
-- -- --     lower(i.title) like '%financial%' or
-- -- --     lower(i.title) like '%finance%' or
-- -- --     lower(i.title) like '%acc%' or
-- -- --     lower(i.title) like '%treasure%' or
-- -- --     lower(i.title) like '%controller%'    
-- -- --     )
group by c.ticker, month(t.filingDate), year(t.filingDate)
having sum(t.quantity*t.price) between 10000 and 10000000 
    and count(distinct i.name) > 1
    and sum(t.quantity*t.price) / count(distinct i.name) > 100000
order by insiders desc, year desc, month desc


-- select title, count(title) from insiderTrading.Insider i
-- where
-- (
--     lower(i.title) like '10\%' or
--     lower(i.title) like 'dir' or
--     lower(i.title) like '%director%'

-- )
-- group by title
-- order by count(title) desc

-- select top 10 * from trade

-- select * from insiderTrading.TradeType

-- select * from vw_tradesByTicker
-- order by trades desc

-- select * from vw_purchasesByTicker


-- select 1
-- where lower('10%') not like '10[%]'

-- VIC winners analysis
create or alter view vw_VICLongWinners as
select 
    c.ticker,
    month(t.filingDate) month, 
    year(t.filingDate) year,
    convert(varchar(10), month(t.filingDate)) + '/' + convert(varchar(10), year(t.filingDate)) monthyear,
    count(1) trades,
    count(distinct i.name) insiders, 
    sum(t.quantity*t.price) netval, 
    sum(t.quantity*t.price) / count(1) netavgtradeval,
    sum(t.quantity*t.price) / count(distinct i.name) netavginsiderval
from insiderTrading.Trade t
inner join insiderTrading.Company c on t.company_id = c.company_id
inner join insiderTrading.TradeType tt on t.tradetype_id = tt.tradetype_id
inner join insiderTrading.Insider i on t.insider_id = i.insider_id
where 
    tt.code in ('P', 'S') and 
    c.ticker in ('TPNL',
 'TSM1T ET',
 'EGC',
 'REGI',
 'BXC',
 'ATTU',
 'JCG',
 'HCLP',
 'TGO.',
 'OCIP',
 'EXAR',
 'ADES',
 'CKEC',
 'AHGP',
 'TOWR',
 'CNNX',
 'AMG NA',
 'KRA',
 'SNC',
 'WIN',
 'EXTR',
 'QLTY',
 'TSE',
 'KFX',
 'GTS',
 'PERY',
 'AEPI',
 'CSCD',
 'AVID',
 'BOVESPA:GPIV33',
 'CPS',
 'JGW',
 'MSO',
 'CALL',
 'STCK',
 'GSAT',
 'LIN',
 'LGND',
 'SVU',
 'CLMS',
 'FURX',
 'TFSL',
 'ADNC',
 'TMS',
 'XPO',
 'SRPT',
 'NXST',
 'MTLQU',
 'TREE',
 'APLVF',
 'SOQ',
 'TRID',
 'ZGNX',
 'CLNY',
 'GYRO',
 'GY',
 'KCG',
 'KW',
 'NATR',
 'ISPH',
 'COT',
 'RJET',
 'HUGH',
 'VRTS',
 'HOS',
 'IOSP',
 'SFI',
 'SRT',
 'MDZ',
 'CASH',
 'KEME',
 'SIGA',
 'BBEP',
 'UPFC',
 'ASPS',
 'ACAS',
 'RJET',
 'COWN',
 'VLCY',
 'SSCC',
 'BLO NO',
 'GNPH',
 'VPHM',
 'C.PF',
 'MVCO',
 'MTRMP',
 'DLLR',
 'CPNL',
 'EDA',
 'DFC',
 'LGNDE',
 'POLGA.OB',
 'BRST.PK',
 'ATN',
 'VDM',
 'MTLM',
 'MCPEQ')
group by c.ticker, month(t.filingDate), year(t.filingDate);




-- select title, count(title) from insiderTrading.Insider i
-- where
-- (
--     lower(i.title) like '10\%' or
--     lower(i.title) like 'dir' or
--     lower(i.title) like '%director%'

-- )
-- group by title
-- order by count(title) desc

-- select top 10 * from trade

-- select * from insiderTrading.TradeType

-- select * from vw_tradesByTicker
-- order by trades desc

-- select * from vw_purchasesByTicker


-- select 1
-- where lower('10%') not like '10[%]'



create function udf_clusterTrades (
    @month int,
    @year int
) returns table as return
select 
    c.ticker,
    month(t.filingDate) month, 
    year(t.filingDate) year,
    convert(varchar(10), month(t.filingDate)) + '/' + convert(varchar(10), year(t.filingDate)) monthyear,
    count(1) trades,
    count(distinct i.name) insiders, 
    sum(t.quantity*t.price) / 1000 'netval($k)',
    sum(t.quantity*t.price) / count(1) / 1000 'avgnettradeval($k)',
    sum(t.quantity*t.price) / count(distinct i.name) / 1000 'avgnetinsiderval($k)'
from insiderTrading.Trade t
inner join insiderTrading.Company c on t.company_id = c.company_id
inner join insiderTrading.TradeType tt on t.tradetype_id = tt.tradetype_id
inner join insiderTrading.Insider i on t.insider_id = i.insider_id
where 
    tt.code in ('P', 'S')
    and year(t.filingDate) = @year
    and month(t.filingDate) = @month
    -- and c.ticker in ('kmi')
group by c.ticker, month(t.filingDate), year(t.filingDate)
having 
    count(distinct i.name) between 3 and 10 
    -- and sum(t.quantity*t.price) > 0
    and sum(t.quantity*t.price) / count(distinct i.name) > 100000