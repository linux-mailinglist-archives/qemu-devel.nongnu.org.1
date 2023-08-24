Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9199786768
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 08:21:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ3hy-0000lO-QF; Thu, 24 Aug 2023 02:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qZ3ht-0000lC-Qe
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 02:20:38 -0400
Received: from mail-dm6nam10olkn2082b.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::82b]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qZ3hq-0006M4-KJ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 02:20:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWPxdAaNndQnEMsFm3OIrYjvECxBsXoZY6ZoVdNw7APGHkQxKQpe3oLnnPkHr6dP9BsOuJPgytyoXnRIjzmGtyrDhu0EzCyvK4BUbKQnnVa1sZkOO8updEDFVCCyMs8nNTaXNTmSW41rdijf3APGzysAhc7ENUbr0wkVsHINVBdDXfl5f9Dtd4FhcPINVWfdH6il4R8ioTYYn1XAhMBTQZ1p/KbeJxhRa4GZSF/7PRQ3GWaIq1YQBjdbs0vgXg+7qsHXRVDOpo2sXjofKB9Dwi9+uC4oayzGoZptdpzAjanambYEBGDFRI6GsbDNrSoLgVbs+m8bfJJonUhrt4k3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yj2TvI2/9Qtl7vtLQQUbUOU/7WFubNKgyaz1cMtNC1Q=;
 b=UJ9JdRqrOFWejyowYtNLyIbkq/mwEadK1LwsL/T4Yj++NX5q0yf2Je+HOoUMwxaKHTbvWT3YmoIhSQOPCSyKRO/rCbu1rX6LPBkHaplwLC2LPQk6ng1EX26unCkHz89CQnBk2hz8gdADDgyQmh9ziYmJJHukRcr5lziW606icYUrLMXDh7upJpv3na8zouD+99PyhsFPl9x/I5uQxWL8NvZXkkitgTz7rMX462OhSEAqhfJrEnwz61XYRCcF0RoLAQwglQw0ylGZOy4zg7a079W4tWu+zUrCJdpyMvf2TD5zX5XEdFtoURzeBo1VwYA7FNQ93Krp2fXSfc8IyEv5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj2TvI2/9Qtl7vtLQQUbUOU/7WFubNKgyaz1cMtNC1Q=;
 b=IormG+qG6lUBr76Z0n6TiHXWKgPF1qhPrrr4icrcm3JvBRl98w/Hd9YC8Uit7SWzHe8txPfazKIQjWH9dAs/XGywxUDIEQwp9OFP/zRpzPTGaAQbKyHk7aXai16ut2DSef3AeKs6E4sDKjH4x0Wp2AWDdfEIunCZ2qr1IafYgcWfXdakVZrP8QbZm3QWbOveDdxfm4HX4W1pcNwNGTXLw+pUdXMkavZqkCww7+5jMYNi2E/gewnwFGsRC3i3O/vSpQDhLVp3Y1P3Yj8ZCBdVkPAQRJc7TUQFRw8dA0DJUGDoz0P9BmMkDl+K5aond2ZtEwO9flQLdTTTLNwDs9NBoQ==
Received: from SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14)
 by SA1PR11MB8255.namprd11.prod.outlook.com (2603:10b6:806:252::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 06:20:32 +0000
Received: from SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::df85:2db:d56b:38bf]) by SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::df85:2db:d56b:38bf%5]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 06:20:32 +0000
Message-ID: <SA1PR11MB6760CEB9F79C83210EBB5A43F51DA@SA1PR11MB6760.namprd11.prod.outlook.com>
Date: Thu, 24 Aug 2023 14:20:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] softmmu: Fix dirtylimit memory leak
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, yong.huang@smartx.com
Cc: qemu-devel@nongnu.org
References: <SA1PR11MB67606FB284BF14ED9F11D436F51CA@SA1PR11MB6760.namprd11.prod.outlook.com>
 <26ee7b25-c92d-ddca-5257-cfc12b54d18e@tls.msk.ru>
From: alloc young <alloc.young@outlook.com>
In-Reply-To: <26ee7b25-c92d-ddca-5257-cfc12b54d18e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [gSoKV0F4OwnPNbl/9/51a1pPlDW1L2aggkfL0mnaUvE=]
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To SA1PR11MB6760.namprd11.prod.outlook.com
 (2603:10b6:806:25f::14)
X-Microsoft-Original-Message-ID: <d7db2d54-958a-9665-f2c7-f346c5db9109@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6760:EE_|SA1PR11MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 885b4666-89da-4f25-2b12-08dba46a380e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7SGGel6fuwoHvl1Q9Ug/pICiHr4t0br+kWjAEJBzPwUu/8Bkv/plueLiESH+ad5qDDNb67oSWEx7HGHU6d8TNgHMWHzwSk3jpc9p4uyAy1z3btKLL94q6ERSfmPr2hYtpAHGip4UGBYj4MBbtoBUZfUTv6JBt1uunO24k5qCQjK6LONlJqzWnsuGQLCYb2ONsfZzfkjZflLEYLiqxK7JmiQ/jNdW+nKmbPYbWVB1h8HdJxFIG9Vqj5I7e49qsLYN5QT9+PXYPv2DsA7CrGJ8ZSn0x7q092nfUP+D5IdPdG661SDoJ9iICg0dKHXt4Dz8ph5pN6TdYETab4hKo7d9Y+IlJyBjxRX42YzyNK5PDCqrHtRUBR9WROldBCe2NzT+3Kvj4RjAmE/kdapLtlHqroiQqlu23mQTf18XDHYZKK2Cl4xV3+G1vfoBTFcWynGD9PCmxxJA18N0dxG70RcBmT3q6mASfBluMs7dP2MRGzlepIiFWz+HLTESI6hQfqagnaNORqGxneZrAx3YxOVdkEci8aFZNF3F5rO4QcrLIGQKpSVkhhHG9wLsl5mUJI46
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGNOcDN0QjRBUktHb2xENHQ5RnNuTENOdkpUYnpoOXlqVVhBQjc5MEdZYjN5?=
 =?utf-8?B?cEdFMDZ3b0U2eWVyUGJRSGFIYnRFcHQvSkNEL29kV3J5WVVUejNYeGdTc1Zx?=
 =?utf-8?B?NDl5R3VsdS9kWWJJL0hoZElHTGd6clhxUThYSDFQaHRGbHhVVEE4eXZPSFBN?=
 =?utf-8?B?cGlmd1ZOK09zQnVyODVtOFFrUDczWXB4K1Bnbi8zSkNmTTNMT0xBRWE4bUVs?=
 =?utf-8?B?MHcwdHEzczA5Q3cyS210Y1RINE80Z2dWajBkM2g0RDNQeFBzMXNzR2ZQQlM1?=
 =?utf-8?B?L3VJSUxSUnVtTGxINEl2N01FNzIwU1pGWExYZlFLUzhGRlV6MkV5R2FiYUxC?=
 =?utf-8?B?VmE0RUh2VzdvMFh0ZTRnTkRxLzBBMFNBTENnTHFETXlEbFpneGtQVjNVeU1s?=
 =?utf-8?B?cHpjLzd4ZTBqWS92dDRmSTdSQWJ3Yk9LZXdHSDN4bTh3cVJTR2pOV3ZMREFj?=
 =?utf-8?B?QzdIWFdsZ0lMaEh2dGVMRCt3UGtiSnZ4ZW42MzFnV2lhcGZ0MXpocHZJbHBi?=
 =?utf-8?B?MCs5YllkaEtlVGRyeG5QdDBiWHpNanp5cmQ3OHFIdHlTUk1HTENNakdSMFFB?=
 =?utf-8?B?dVkzbS9vMXphdzZyR0VpQ01qOHdYRHE3WHl2OUljYWhRTkdDbHk2UDJueHJH?=
 =?utf-8?B?Y2cwN29WOCtpL0FFR1Y2TGZMR3FsQWtDYlhUYkRxejJ6cE11N0g0NnNrV3pQ?=
 =?utf-8?B?NmZkVGR3S2ZKZmdCQmxFbURENWlKbFVyNVgrNnRWQ3JkNzdqM3lUclpMdGRi?=
 =?utf-8?B?MkEzbW42T2JOUFVJLzFtNVhjeURyZlFHTEJTZHJoWGpzQjJRQ3ZvcnVIb1Nw?=
 =?utf-8?B?MnV6eEtQQ2xqTFlsMkx3dWpvWXhNYWl2QnZYYzZhZlhLS1c1Z2ZOV0FzRUJ4?=
 =?utf-8?B?ZFlsZ3pFU0N2NjhCbTZ5STJTM1pNRVhtUUlUb01XV3RuOXJTcklWbkN6cjBj?=
 =?utf-8?B?NitDdit1OE1Zc3MrRU9jczRLM3NtYjlTa2VJeDhWRkgrUXlPSWlRcnNiajVs?=
 =?utf-8?B?Z29WcUZLV0M3cklsQldSUDEyeFAzbnFCWmdkODhONW1Rc1VVNG1pelZKRjk1?=
 =?utf-8?B?b2Z3dEF2WUVsQXN0UjByU2Q1K01JRXhQdkNYdENlWmRGc05OS0JwbXZ4N3Bw?=
 =?utf-8?B?VVRCcUk4S0ZMNWJqbGVoU2NqZFlPZU03MGJTdyt3UzcrUHMxZE5GUHdQL1ZS?=
 =?utf-8?B?Z0svVXZQNmdpMjZueWVsSjFpODgwRjQ0SDdyNVQzdjhyc3NOY2JuL1U3YzNI?=
 =?utf-8?B?VmlodHc3RUxoQ1dyVDg3cDdOdUdaRGFsV2VJb0FqRFZZVEhjUUxrWWUrOFV2?=
 =?utf-8?B?aDF3dVNzbjYvV3FJVDFGdjBtQ3lQUXEyeWRFUTdqa1J1dUNubkQ0WHkrMjFn?=
 =?utf-8?B?dStnbnZGT3ZUQ21NQnB2S0t0Snp5QmlMRU9NRDE1dlVyaHNudDMxTlNDYkJj?=
 =?utf-8?B?NTF3UE16d1BCYmJZTWhlK2g3ZGduWmthc3Vxb0wrcDJxcHBiQkFlbHVRZ1Mr?=
 =?utf-8?B?dkxrU1VZSkg4MVFQR000cCtBeUYzbktVZWM4RmxFeTZFY2tid1Y3NHFwaUM0?=
 =?utf-8?B?TUhJR3VkUko4emtQbG1vMXRvR25IZGwwWnpzR05LUzl2MVBTeWNqZ0ljcVZz?=
 =?utf-8?Q?UEKOfkEJ0WaC9AyqBKXNUby/7j/JniClgmbtmh4TKkSc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885b4666-89da-4f25-2b12-08dba46a380e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6760.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 06:20:32.1185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8255
Received-SPF: pass client-ip=2a01:111:f400:7e88::82b;
 envelope-from=alloc.young@outlook.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_MUA_MOZILLA=2.309, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.684,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2023/8/24 13:16, Michael Tokarev wrote:
> 23.08.2023 10:47, alloc.young@outlook.com wrote:
>> From: "alloc.young" <alloc.young@outlook.com>
>>
>> Fix memory leak in hmp_info_vcpu_dirty_limit,use g_autoptr
>> handle memory deallocation, alse use g_free to match g_malloc
>> && g_new functions.
>
> "..use g_autoptr TO handle.." ("to" is missing).
> "alse" - I guess should be "Also".
>
I'll fix these typos in next patch.

> I think it is better to split this into two parts, one fixing
> the memleak and another converting to g_free().

Ok, I'll make another patch, Thx.

>
>
> /mjt

