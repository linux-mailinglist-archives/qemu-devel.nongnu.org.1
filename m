Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1B7749E2C
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:52:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHPOY-000502-Oc; Thu, 06 Jul 2023 09:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qHPOS-0004xE-Fh; Thu, 06 Jul 2023 09:51:36 -0400
Received: from mail-db5eur02on2070d.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::70d]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qHPOO-0000cW-IK; Thu, 06 Jul 2023 09:51:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlZ/IIJJ6qeS1on/bgXZ7CYHmhe2ntWbIOA71IJsnUUqZ9bjdpLyi6rH7Oyas3EbOuJAySiDypQjRAkho/Hk/+69Ie7OAmQEEPSorquL09hy1ssUfsLmXn2Cgsg+oKIoNQuRHeX/78BKZ4HBSFqr3g/IcTAaFxn3bRuRTtbljOA9TAHFuzk1HKpMcQillqzC3S3e/ZhjRIg4/ngSyL6i4s9k3l3GW/isC2P7zMd60gLEPslMIFUQtPFeuOj0KqLev8WKNkHMAnOoY2N8UvO6m9VMpsKMMWxPf7j3mKW5F+YzXnT5iCRG9S7HKudvd4Hrib6q0SqJN3l5XkifnXUF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6Lg0PiXhDeHjJBw3r9kQVt9ph1h2QbmC4TyMRZHZHc=;
 b=QGszFqtZaNy6eGaHma36PMIXo5yHAK6SJqPk/m5nelpxHy2sdUx38IWuibVP8A+iCbIzpx9B5Da2fxUk6cWBJBf7e7ILyrt0kWiW4u9plLY1S6Ao71My+SNo+Py8DnKvzTt6PGwe8xF1HmBr6bGnHjbXFCJ0suXOYXsLAclevHjfvIDnliNDl7t449ZVxZws5w3BUmHhJ9fvnA+lgRWmOtPSOF/6HYM0uX5DpLg5rtzdL/TirGo44uuQA2GZHDlY62njjFvBU8JfO0PIJ1Tqqpj62P2LAFsZR/n+xnl9IeQUrsEDfjR+lI5Nat/TUXEbCzBk8A0u6iv+9MvOIC89Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6Lg0PiXhDeHjJBw3r9kQVt9ph1h2QbmC4TyMRZHZHc=;
 b=ACExINigz9XStv8Depy6uD0zISRiJ9rUq2WKDP0N8lacK38BdDqBAohRVKIhXxdPg0b2POzMArPuvgCkVD+M8aGkJE4/+8+CVmRZUyVsbMfKXJB4XwF2XS97Bfxp9ByUwDANfv8pbQsmQRBR9KHA7dr+1xvGuAM5VTi+WKsV6AqpmXineqsAZyL7odES19QI/5ww2Lga/dpo0F4vfDkI4Qu+pmyDzWnZ8h8jwmnaM19fee3/rjmxOSNz02pMKwxbl35cDuENj2vuQMQDsEP7+W5YAvQYkaKa7cKHCABBmH0kd131gv7pFac+cbepE8yqiGSnckSkCsDmV+Dzv5wIHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB7862.eurprd08.prod.outlook.com (2603:10a6:20b:52a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 13:51:27 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:51:26 +0000
Message-ID: <09cb5985-1bbe-31c9-0f18-6afbe656e893@virtuozzo.com>
Date: Thu, 6 Jul 2023 15:51:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] qemu-img: map: report compressed data blocks
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
References: <20230607152627.468786-1-andrey.drobyshev@virtuozzo.com>
 <20230607152627.468786-3-andrey.drobyshev@virtuozzo.com>
 <0398442b-50aa-fe28-0379-3b57ef749564@virtuozzo.com>
 <e05d3f08-2d08-ec64-e8ca-882aa6a6378a@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <e05d3f08-2d08-ec64-e8ca-882aa6a6378a@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0224.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::45) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb10ad9-40e3-43f7-657d-08db7e2817e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfHQm8+DAoTx+EXmyNBa9DIvDOV3dKEKAaAc2nrKFZf54oq0FvFpUG1VRJJEAqJhZ/DBgSmlCQ8CGJXGaIhV+7eLad022jqbBDzJ5ROKESHY0KXeWvaA6H9P9qoq8XeZIqBXZGet/3GL8CajpVk4i2RBkIiTqUa0obKStlHd0XwFjnoX4j1HVbGKp2Jvu8hoGnHuw1teTJW2eDoplOXgB/baZutYEOxHgZ7mUnBD6aYo3e3LpZMb6BiTUGxl3nVl/Wr1S3jNjF+wJX0E3n/+qerg1nF3WYkicklJxYnCSMkJcQmxrT8khgWwB+kaFoQlcPZX0AZaI4IUuFXhAnPdGxKNpw6JdscEPgQUd1wTbJTLMY520zp8IyOkieBOANovtMn4Tlb7ge6gCQyyEetz8dX1Ld7ieb/YjkIWPHGrk/h1umvrxJSJAeaxQCuQYA0exsgzOw4S+KXF42V7AYh6IMEoDkZrH+gUOscF3LIr7lxBOviXlW2UDeCfyF4RB4jnBV0WzqzTWCHs78Xb+NdLB0kQl0qQ8jewFb9CHOCdZUSK2xh/RBVGacnst0jX8IJwf3np2XwW7weVV//PsTGeKpYk2CMitCS0UvaNpo8l89/GymP87S1xn6y1SqCjO6sXF4c9pPHN/LsvUHzaYaGpqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39850400004)(346002)(376002)(136003)(451199021)(38100700002)(41300700001)(8676002)(8936002)(83380400001)(316002)(2616005)(66946007)(66556008)(4326008)(5660300002)(2906002)(31696002)(66476007)(86362001)(6506007)(186003)(6486002)(31686004)(36756003)(53546011)(6512007)(478600001)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmo0d2dPODFaa2hORUEydkdGeXlQRFBXUUhuaE5hd25hT01ITnVPbDZtUVR2?=
 =?utf-8?B?VWoyNVNSNFhnSFNDZzhwT09wUzBWWTBSMUJ4ZUtrSXhCOWwxUXBhcVZtVUs3?=
 =?utf-8?B?RFhFL3huV0RHcVNtN0JOUmdFL2ZqSC9BZCsvMlBGVmhDT0tvd2YzL0oxby9O?=
 =?utf-8?B?TUNpODNqbkE3U1ZiYjRHRnhLc3lmYytUR0pyaTlWdlYwUkFlRDFrS09SQjFo?=
 =?utf-8?B?azRtUFBYcVUrZ1BFMUs0dmgvd1h6SGdLSU1OTS9EWGFBejgxTDdVUkhBWm9L?=
 =?utf-8?B?WUIyd3Y2bEtKYWs4Y1M1bDU3d0FKdTZkTnJUTlBINTJqMHV3cWtVcFM0cUFB?=
 =?utf-8?B?ZzZnSzI5SEk2RmEvWlJPRjZGZFM1T0ZOWHk0YUhKWHlsMmwwcndTUFBTZTZS?=
 =?utf-8?B?UUdPTU9HZmJobTlRamU1ZWdUUnltK1dBbmlLRU9JZS9ra3FDQkU0VmhrNi9w?=
 =?utf-8?B?bnlWSWwzdlBQdVFaNHRFRUJoazNOdDI1TTlzTzY5dVo3bkVkNUZTMEhqWnVx?=
 =?utf-8?B?RU9kU0VWbjFvcmVGZHFwUzQxSHM0VTlJODVIWDdIWmF1ZjBzazl3V0pXRTd0?=
 =?utf-8?B?K3hvdkhEdHlmUmllMk5zc3ZqVFUvQzlnZy9PcCsxZkZidllMdk5QWTgxQk5G?=
 =?utf-8?B?ZFdCWmRxLzUzN0FwTTF1a3lRaVlRL2lVVTlBM3VteFg0UnBjM1VHR2lUamgy?=
 =?utf-8?B?TnZYb0xoY1dRMlYyWlhXQUY3OWQwNDVhbUY4K2hoUjcrT2wvYnBpSm51T3kr?=
 =?utf-8?B?eU5lbmJGcUIvVnRKSDQzZXlPN1dkZW9Zb1p3UldHS1JhNytMSm1ydGZGYk1v?=
 =?utf-8?B?RnkvUUJMU2Y5L09QT0hTZjZzclN2U0V4enlUZ0tFTERwSTB1Q01UbC93bmwz?=
 =?utf-8?B?Wk9OK3VjUi9oZHYvd3VKUjBtYncxSlZNMm5pWlBaNTYzWFBjWGxnMVFoS3k1?=
 =?utf-8?B?d09Nd3Bxc25wWGV3WDdzbDNLZkk2b3BSYmNsUnUra1FUZkR6S3VNTVhzVDk5?=
 =?utf-8?B?cHExUFlPSEVxUkdRN2dXZHNVMWpHRmJPRW5sVjdwTXUyZ1JFZ2Q3WVZpQnd0?=
 =?utf-8?B?Sk1mOFVkaE5BdDJHcHlOSlZXeVpsdWxBWlU4T2J0LzNTVkVNUUNhL3d2NSt6?=
 =?utf-8?B?cUY0S1Fnck9xcjhQenozaXZQNnpybmNjOFVDVVRmdC95aEsvUmZQeWNFUUkw?=
 =?utf-8?B?aEMzcTVMeloyMmoraGVTcnp0cmhMUVBJUENCeUNRTmk4QmdUUmNsMll0NHdm?=
 =?utf-8?B?akdkcjUvZnpyZmFzdmgyNk9ITlJ2ZmlHUThNeTJYSG9IKzNZSnpnSEtETzlT?=
 =?utf-8?B?OTFZRTQ0RVJSV2RYUUJxSjkyQjFwK1ZmY1ZzMEdwRnZ2L1BtUkQzSjlBS250?=
 =?utf-8?B?em1rcU03V09SUVYvcGMvOWRlN2s1VzB4RTMvMjE4bkFPZ29aTVJaQzBTVkRx?=
 =?utf-8?B?bmRSa05uVXhYbUhXMnRzaForQUV5MnUvVExEZzRldmZMaGNVZ25yNERvWGo1?=
 =?utf-8?B?aVB6WjByQ2VXWS9XdlV5TDY1RE5ranhFTm5iVVcxM1lEVmMyU1dUM3RvcUVX?=
 =?utf-8?B?dGd3QitTS3ZhMFg1SFgydTZlYXROSE1QNGZaZEYrRnhOQ2w3Z3YrTCtRL2JL?=
 =?utf-8?B?QkVUU2pnaXZVdDZxK3d5OUl4ZXVvQ1VtenFGZDkxMThjb05LZ2tuNkR6czIy?=
 =?utf-8?B?VDhGNVYycFFhcVBIaGk4RUxjQ0dRb1F2QmphUnphbEZPcFljZHFHNW1KcWkv?=
 =?utf-8?B?U2JMSXZOWjZCd1JreHJNK2hPQ2VtVkxQT3ZUelNpZjZBWUZVMzdZUlkwVm1Y?=
 =?utf-8?B?YlFUc2svVnBlTnlPUitNMWQrRGhsdXZ0MzY4ck9nYkczanB3SEFsSGFEY2Jj?=
 =?utf-8?B?SzlldGVjZFQ1OXQwUUhxUTI3T0JuLzhNSGxleTk1S29VZ2NKRHBZTTduQ3pj?=
 =?utf-8?B?L2tvR1lmYlVYUDB6VktMbHZWU3VYa2VwU2NYN2c0dm8yelhzVlZIdEpZNFk5?=
 =?utf-8?B?VVUyZkNId21ucFFQcU5tWFlzb2puTU1pY2lpVGVhT2cyTnhxUWdpTVcwaWhk?=
 =?utf-8?B?Ulp1MklIMWtObTRsb1ZHZmVpbzhmM2FkQW5vMkhucmF0L054OXdYbjZMOEt0?=
 =?utf-8?Q?zJ8D7YEN7ZldD7M3y+M+gDOVu?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb10ad9-40e3-43f7-657d-08db7e2817e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:51:26.9364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRuzEe1ts4VlkvpxMbQM/qElI13Yo9ZT2+NP3G1iou+6RUubmyRYk2tBabM0swu4A7zhoMXtNjCjXiMevY74jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7862
Received-SPF: pass client-ip=2a01:111:f400:fe12::70d;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 7/6/23 15:10, Andrey Drobyshev wrote:
> On 6/21/23 21:12, Denis V. Lunev wrote:
>> On 6/7/23 17:26, Andrey Drobyshev wrote:
>>> Right now "qemu-img map" reports compressed blocks as containing data
>>> but having no host offset.  This is not very informative.  Instead,
>>> let's add another boolean field named "compressed" in case JSON output
>>> mode is specified.  This is achieved by utilizing new allocation status
>>> flag BDRV_BLOCK_COMPRESSED for bdrv_block_status().
>>>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>>    qapi/block-core.json |  7 +++++--
>>>    qemu-img.c           | 16 +++++++++++++---
>>>    2 files changed, 18 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 5dd5f7e4b0..bc6653e5d6 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -409,6 +409,9 @@
>>>    #
>>>    # @zero: whether the virtual blocks read as zeroes
>>>    #
>>> +# @compressed: true indicates that data is stored compressed (the target
>>> +#     format must support compression)
>>> +#
>>>    # @depth: number of layers (0 = top image, 1 = top image's backing
>>>    #     file, ..., n - 1 = bottom image (where n is the number of images
>>>    #     in the chain)) before reaching one for which the range is
>>> @@ -426,8 +429,8 @@
>>>    ##
>>>    { 'struct': 'MapEntry',
>>>      'data': {'start': 'int', 'length': 'int', 'data': 'bool',
>>> -           'zero': 'bool', 'depth': 'int', 'present': 'bool',
>>> -           '*offset': 'int', '*filename': 'str' } }
>>> +           'zero': 'bool', 'compressed': 'bool', 'depth': 'int',
>>> +           'present': 'bool', '*offset': 'int', '*filename': 'str' } }
>> after some thoughts I would say that for compatibility reasons it
>> would be beneficial to have compressed field optional.
>>>      ##
>>>    # @BlockdevCacheInfo:
>>> diff --git a/qemu-img.c b/qemu-img.c
>>> index 27f48051b0..9bb69f58f6 100644
>>> --- a/qemu-img.c
>>> +++ b/qemu-img.c
>>> @@ -3083,7 +3083,7 @@ static int img_info(int argc, char **argv)
>>>    }
>>>      static int dump_map_entry(OutputFormat output_format, MapEntry *e,
>>> -                          MapEntry *next)
>>> +                          MapEntry *next, bool can_compress)
>>>    {
>>>        switch (output_format) {
>>>        case OFORMAT_HUMAN:
>>> @@ -3112,6 +3112,9 @@ static int dump_map_entry(OutputFormat
>>> output_format, MapEntry *e,
>>>                   e->present ? "true" : "false",
>>>                   e->zero ? "true" : "false",
>>>                   e->data ? "true" : "false");
>>> +        if (can_compress) {
>>> +            printf(", \"compressed\": %s", e->compressed ? "true" :
>>> "false");
>> If compressed field is optional, then it would be reasonable to skip
>> filling this field for non-compressed clusters. In that case we
>> will not need 'can_compress' parameter of the call.
>>
>> Ha! More importantly. The field (according to the metadata) is
>> mandatory while it is reported conditionally, i.e. the field is
>> optional in reality. There is a problem in a this or that way.
>>
> Yes, I agree that making this field optional makes sense since we do not
> include it for formats which don't support compression.
>
> However, I don't think we should entirely omit it for uncompressed
> clusters.  If we keep it present that would be more consistent with the
> current logic, as with '"zero": false' field which is always included.
you right, that makes sense

Den

