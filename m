Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E5A7E6A9B
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:32:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r14Bn-0005Sy-Na; Thu, 09 Nov 2023 07:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r14Bb-0005O4-HD; Thu, 09 Nov 2023 07:31:06 -0500
Received: from mail-vi1eur05on2070a.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::70a]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r14BV-0000TU-TX; Thu, 09 Nov 2023 07:31:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjxPF/Tsf04m2v/hXGacIjZzqeYduOSO6nnl+wa5bOgDDdK8V5rhdVgHDgjaiIzzNe1Mp/HG6CVteG5r2lxLra9Gw2iiMDScEyQL+wV0RJlWHGEiw5VDKvHIGUKf6V7SgE4oKn08cMonAoWGg7EJvqyY6sFUnbBxygob3Nf36CeowaGt/BkS/w9nqBe+/qA12V9Z4SgW6T59lKlnTaGQjsVXCaEgB8yrfri9x8GWZNkg0fRpedyM7nNBK6b8xm+5+OShDBDF12e/ST+SN/rGV4WYZ2cPxNqKpqaLvRR+Znsab0R6t/v+ITyk5PIm0BwY8+eqDgdKBwHNd5HQK3B7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga6/qz6cQxCc7anicV2oRh2IoRW9Iuo4DAcPnw0NP38=;
 b=kpnK3YltAhfdhz5/RxpMP005yXDSKZXlf4E7Pp9cxJGY21jrSDq/SENUaAgbeNr+qUlg2zOPN1xSV7NlPKPEYXdTNopXIJbXFlvE6NdiKqgn/OdV5YObslkCdIpVI8+41nvmCiHZlTLWnuGOC+9vT7WrvEUQh8dKISOGfVxn9pgF6bqM0Y+kVdX7kkAJvqtMromzADQXSHL1XXa7iQBMn+XhAWRwmUnVMY5ky2LG3CXUujRKFMz0yw1vqA9rwitVXiR2pcOgXh5XJFUIbK3jEhWv4SL74Z4vgtPlRkSeP3n1wTLgwiDOiIFopLX2aQQ3E+cDi8h6VO/gHexO3ELmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga6/qz6cQxCc7anicV2oRh2IoRW9Iuo4DAcPnw0NP38=;
 b=ykqLnLZml84jyySGjOCSvq3aAa0HrawrTUAuxo9aeMlNSfN7pEbJqLroNMvKTl6jUvSCMMv+eJ8lA1w19pK0Zd4/t9EMZpLYopr3luZQQ0dEgtKWzXiD+eUGigEqLzKQBSQfdcItztMZscwDFA3zVzahp/9lOgKKovGEME01S0lE3gGpz+UPGCFPnA8WnLKVCVSgh/xNOD8dgbSjbH/pobmD7cqAgnBqT9RE7KKlDPtmNgq33RXL6PREIWm6F0Dow/WTNcsudr7quGpGl8XRO60XrPRbUQbaA4i7hcEbRWHOZWH+CUJpSMsMbbjrVOchsIzVNAx1l5Pe0Z3siwJbDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB7322.eurprd08.prod.outlook.com
 (2603:10a6:20b:441::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 12:30:49 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352%6]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 12:30:49 +0000
Message-ID: <2da5d469-fc95-455e-92ec-346901904a8c@virtuozzo.com>
Date: Thu, 9 Nov 2023 14:32:42 +0200
User-Agent: Mozilla Thunderbird
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH 2/7] qcow2: add get_sc_range_info() helper for working
 with subcluster ranges
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-3-andrey.drobyshev@virtuozzo.com>
 <28ae9906-0880-4143-8573-f880a9d1798c@redhat.com>
Content-Language: en-US
In-Reply-To: <28ae9906-0880-4143-8573-f880a9d1798c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: b2dc7901-fe14-47a9-776b-08dbe11fb46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ABpjJM53kxXc0/rHlWtx/GhSsdUvjCwVcXaHlqNZSj7Zi67xoxU/uLAGAyitmiePeI5WlUMVvn1EetGoKf6YxDNLOyKolKDE32HH1uOzYKuOvbSKpAL3tTe5/dvu5jH1jM0Kqe+5PACcyOTtJ8iI66cG66/ryQHBdAmzZdbKc0qzzxAJqKyaCK3UxGHgJSPzqMlpl1/aLiAiR9exPilpaSDiq1pCn1ynCGVyGOO8okreaOh0WrihPym6Bvsw0v6TZ9UK4TLEQ8xE4x3NWc+M3LEnS65qVFz0OocMNbQxsxAwLzrlPeNIvMm9K34Za6aSmi4w63FDIiU0sD02tXYVdEnphmQSodGhwjccSkV3ymWXlE5oDpF8Y5btm/D+ICYDbDsaKKuT6gxJud4dqYWoFYbqh80LKG+3K0gP2zQXMALZ1IEn73XxBS8IGboMgwHUmPPKwShDD0a9a0UZ7fUWSLVt2McPmv3KpRsRS2984mjaAo79GYpJdX3F1L3GNO8ZiYZYmio9rVe5kjQZ5paVFe7mXi+E+xPUWZc5Yc97ZZ7D/mBLGmVbNBGdvX6/eAzeavETnKKo/zLUAhRHaEUheNdhe8FQE2uelZSsPgRQ6ZCr+Kg53U7bpMPG1MxQ4DNBOb2dZEH1vjgdjuTf0lLzFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(136003)(346002)(396003)(366004)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(66899024)(55236004)(478600001)(66946007)(6486002)(86362001)(36756003)(31696002)(83380400001)(38100700002)(4326008)(6512007)(2616005)(66556008)(53546011)(6666004)(66476007)(19627235002)(26005)(107886003)(2906002)(6506007)(44832011)(41300700001)(5660300002)(316002)(8676002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0VocmUvVmFVMFRlSXp0Y0FOT01MQVR3emx6Q3dRblNXT0JJOGxieVFBcEZS?=
 =?utf-8?B?NVZaMjhuZG1UeERpeGtsSFdEZ0VYT2NTZE1PTFNuSldpamcyc0Npd1J4SDdx?=
 =?utf-8?B?WGxMVlJLakRLRGc1bVp6Q3Z3NEVsZ0REUkF0WkprT2JqZXBmcjd4aEVSSTAx?=
 =?utf-8?B?cUtrVnBsTlh5b2dJakVkdXNtNmM5aXQvYlQ2RkV0dFVTSHNsNm4vQVRock9z?=
 =?utf-8?B?SE8yU3JKbTAwRG0yQWFTM1NSa2hSSTBvSnhUYnB5d0xnazZ3RE9EWE9JV1lI?=
 =?utf-8?B?aGhKMFFpV2FHWUt5Q2d4NXdyM1pyZmx1OEllckdXOU5IOGdRWmF4WWdseE8z?=
 =?utf-8?B?UFptNEpzMCtodzV0R214VXJtcHNHL25WM3NyYzl5K1NDdFYwZHkvT2hKUG44?=
 =?utf-8?B?aXY2NTU4M0grR2ovTWdYWHl3KzVBWVV3U0Yva3MvTXhJT29uNFZxcXZRRVBy?=
 =?utf-8?B?K2pseXhDQTVaVTZVZ3lqbGMycEtHQm1HK3VpQmtwZ1MrRmdvRjh6UnVKdUps?=
 =?utf-8?B?L1huMkdpK29HY0UrMkdrc0tZRzZFek0xK0RlbzBMcTB3blQ5cmNlZlN1VWZE?=
 =?utf-8?B?NkdzUDk1MFpFbXFOZXhpOWJFVVozb1N6cTJBVDJjNEh6amRLamVYQm45SENn?=
 =?utf-8?B?eXhHdWt4ZEM2SGJaTVV4UEpuWWdYZ3AwZ1c1RjAvb3dhVDFaNnFaandSMVRH?=
 =?utf-8?B?NzZTdWpTWGtHcEtBR3dCM3NYSktBZDZsUU8vSGNUOGQyVlVqTU1ZY2svMmVu?=
 =?utf-8?B?dUpQSURCdmFrcDgxUWdJVkRkNjROZ0pDWlVGQmhHL3NLall1VWN3Ny9OMTVT?=
 =?utf-8?B?N3dKTmRMZXBOdE8rbG1VT3dsZ0xDbVFWS2p6MFYydnVFZFJ3enZ0Ky91aDlG?=
 =?utf-8?B?VXdBYllwMFZtWnpaU2QxZEI2Tnh0R21majQzdnl2NWRrbS8zbm11T1dJSGdS?=
 =?utf-8?B?aGlkeXNmalNIalJkcENUZkZ4RzcvUUhsMXlibHQ1MTM0Y200akhMRVpwdit5?=
 =?utf-8?B?Ykl5Y3B2bEQ1NHBUNklaRjlNMFNWYzd2UzBDS0VlNUFXcG9XUm9ib0NBeVV2?=
 =?utf-8?B?VC9YcWFNWktiZW9YRzVCYW9PWWJ6eFpNRmFMUVRYbzI5VkN6MDc4Y2Q0WGlC?=
 =?utf-8?B?SlozYWZDWGVCeE95SENtQkg2TXJlaFBYdksvMndGRGhhQTlUV3N3eEUwNnlH?=
 =?utf-8?B?ZzRIbDNqQ2dOaXFiYXpwL0wraWJlVXFXUGxVKzBoSU96cVhtSFk3RDF0WkxH?=
 =?utf-8?B?bHAxcWU3a01DWVNmRmo0L3pYWFpSMGZFMDlTOFRCSTdOMmJMeXZmUlN5a0JL?=
 =?utf-8?B?L01pTGlpUTR3VzBoQzUvNmJtYXFXajRMdXdkMGJkK1RUdVFOY2Q2UEtjWkxZ?=
 =?utf-8?B?VEYzOFR1TE9pUHdZUzNKTXJTLzFPcmY1NkVHQVpJVk5oWk5qUk1qcFVJYWtH?=
 =?utf-8?B?UjhVMUNhaS91SjNmVk56aGJLb0U0YkRzVUwxblBNdXlBSk1NSjVPL2ZNZmdj?=
 =?utf-8?B?MGd6UWVUNU9UVmRVenBQUDdaV2NQenZLNHNZV2NKTmxOaGxHMzluRFJ2RmpN?=
 =?utf-8?B?MklqanhyRVJNeTJHeXpiRGVzYU1TaElmeERCL1p4WG9nS3QzV1E2d1pxTXRw?=
 =?utf-8?B?dGswdytiNWdtSFQzeEd6c0trRFVBcDBGc2c2NDQyZjNtSG1EWnV2Y3dlSnFK?=
 =?utf-8?B?endzVzllOHViWlQ1eE9rbnY0TXNlREtIT3phbmFQS0hmQWl4TjRvMHE0WXJr?=
 =?utf-8?B?Y2paejc3SjdtU212TGVFYnZwYi8wUlQ5YWhKM0V2cGQ5U3RzdXozWFh2cWNC?=
 =?utf-8?B?TzlOWUlMSWVWZ25SWEtWTitaYngxUThTUFRGSy9uZkVzNndyZ0JLNjVBNmpW?=
 =?utf-8?B?UE9HTkIxamJpNlNIaTV5Z2dVTmZTZG1LNDZ1MnVQODBYL0hoQ1htckVKMGlw?=
 =?utf-8?B?Qm12YkpzZCtabXdQTlpVUDdoSU5uZU5BVTQ5RkVZNDc4VGFBNzFZallDSWJZ?=
 =?utf-8?B?R0dVaXlVcEpQYVVzbmpuT2NyWDYzcS9GeFo0Z2M2VHdwc0VjMzVaZ2pyUC80?=
 =?utf-8?B?UVVDbEd2Z0dEK0MrM3JQMXNzbGtoNjJqbDZ6cHZ2ZWVZYml0YWdZdDROWVJ6?=
 =?utf-8?B?TUtSS1BVaWNuUnBOS2g5SVpUS0ZHNnpqQXJuMmtITnBtUEdEYkdtQWhqRDNQ?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dc7901-fe14-47a9-776b-08dbe11fb46c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 12:30:49.1488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRG/YbON5lEsJy2Uy+uKpPHQQyIrEf0a31DxE0/hHH0HcLNDIbiWxBOefqw8wDQvlgAvUhq93AovQph+hLrOPBJVI4JQs7MlOQV/GBtUI9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7322
Received-SPF: pass client-ip=2a01:111:f400:7d00::70a;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hello Hanna,

Sorry for the delay and thanks for your thorough and detailed review.

On 10/31/23 17:53, Hanna Czenczek wrote:
> On 20.10.23 23:56, Andrey Drobyshev wrote:
>> This helper simply obtains the l2 table parameters of the cluster which
>> contains the given subclusters range.  Right now this info is being
>> obtained and used by zero_l2_subclusters().  As we're about to introduce
>> the subclusters discard operation, this helper would let us avoid code
>> duplication.
>>
>> Also introduce struct SubClusterRangeInfo, which would contain all the
>> needed params.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   block/qcow2-cluster.c | 90 +++++++++++++++++++++++++++++--------------
>>   1 file changed, 62 insertions(+), 28 deletions(-)
>>
>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>> index 904f00d1b3..8801856b93 100644
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
>> @@ -32,6 +32,13 @@
>>   #include "qemu/memalign.h"
>>   #include "trace.h"
>>   +typedef struct SubClusterRangeInfo {
>> +    uint64_t *l2_slice;
> 
> We should document that this is a strong reference that must be returned
> via qcow2_cache_put().  Maybe you could also define a clean-up function
> using G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC() that does this, allowing this
> type to be used with g_auto().
> 
>> +    int l2_index;
>> +    uint64_t l2_entry;
>> +    uint64_t l2_bitmap;
>> +} SubClusterRangeInfo;
>> +
>>   int coroutine_fn qcow2_shrink_l1_table(BlockDriverState *bs,
>>                                          uint64_t exact_size)
>>   {
>> @@ -1892,6 +1899,50 @@ again:
>>       return 0;
>>   }
>>   +static int get_sc_range_info(BlockDriverState *bs, uint64_t offset,
>> +                             unsigned nb_subclusters,
>> +                             SubClusterRangeInfo *scri)
> 
> It would be good to have documentation for this function, for example
> that it only works on a single cluster, i.e. that the range denoted by
> @offset and @nb_subclusters must not cross a cluster boundary, and that
> @offset must be aligned to subclusters.
> 

I figured out those restrictions are derived from the number of asserts
in the function body itself, much like it's done in
zero_l2_subclusters() and friends.  But of course I don't mind
documenting this.

> In general, it is unclear to me at this point what this function does.

The sole purpose of this function is to avoid the code duplication,
since both zero_l2_subclusters() (pre-existing) and
discard_l2_subclusters() (newly introduced) need to obtain the same info
about the subclusters range they're working with.
 
> OK, it gets the SCRI for all subclusters in the cluster at @offset (this
> is what its name implies), but then it also has this loop that checks
> whether there are compressed clusters among the @nb_subclusters.

Look at the pre-existing implementation of zero_l2_subclusters(): it
also checks that the subcluster range we're dealing with isn't contained
within a compressed cluster (otherwise there's no point zeroizing
individual subclusters).  So the logic isn't changed here.  The only
reason I decided to loop through the subclusters (instead of calling
qcow2_get_cluster_type() for the whole cluster) is so that I could
detect invalid subclusters and return -EINVAL right away.

> It has a comment about being unable to zero/discard subclusters in compressed
> clusters, but the function name says nothing about this scope of
> zeroing/discarding.
> 

Maybe rename it then to stress out that we're dealing with the regular
subclusters only? get_normal_sc_range_info()?

>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    int ret, sc_cleared = 0, sc_index = offset_to_sc_index(s, offset);
>> +    QCow2SubclusterType sctype;
>> +
>> +    /* Here we only work with the subclusters within single cluster. */
>> +    assert(nb_subclusters > 0 && nb_subclusters <
>> s->subclusters_per_cluster);
>> +    assert(sc_index + nb_subclusters <= s->subclusters_per_cluster);
>> +    assert(offset_into_subcluster(s, offset) == 0);
>> +
>> +    ret = get_cluster_table(bs, offset, &scri->l2_slice,
>> &scri->l2_index);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    scri->l2_entry = get_l2_entry(s, scri->l2_slice, scri->l2_index);
>> +    scri->l2_bitmap = get_l2_bitmap(s, scri->l2_slice, scri->l2_index);
>> +
>> +    do {
>> +        qcow2_get_subcluster_range_type(bs, scri->l2_entry,
>> scri->l2_bitmap,
>> +                                        sc_index, &sctype);
> 
> I think there’s a `ret = ` missing here.
> 

Of course there is, thanks for catching this.

>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +
>> +        switch (sctype) {
>> +        case QCOW2_SUBCLUSTER_COMPRESSED:
>> +            /* We cannot partially zeroize/discard compressed
>> clusters. */
>> +            return -ENOTSUP;
>> +        case QCOW2_SUBCLUSTER_INVALID:
>> +            return -EINVAL;
>> +        default:
>> +            break;
>> +        }
>> +
>> +        sc_cleared += ret;
>> +    } while (sc_cleared < nb_subclusters);
>> +
>> +    return 0;
>> +}
>> +
>>   /*
>>    * This discards as many clusters of nb_clusters as possible at once
>> (i.e.
>>    * all clusters in the same L2 slice) and returns the number of
>> discarded
>> @@ -2097,44 +2148,27 @@ zero_l2_subclusters(BlockDriverState *bs,
>> uint64_t offset,
>>                       unsigned nb_subclusters)
>>   {
>>       BDRVQcow2State *s = bs->opaque;
>> -    uint64_t *l2_slice;
>> -    uint64_t old_l2_bitmap, l2_bitmap;
>> -    int l2_index, ret, sc = offset_to_sc_index(s, offset);
>> +    uint64_t new_l2_bitmap;
>> +    int ret, sc = offset_to_sc_index(s, offset);
>> +    SubClusterRangeInfo scri = { 0 };
>>   -    /* For full clusters use zero_in_l2_slice() instead */
>> -    assert(nb_subclusters > 0 && nb_subclusters <
>> s->subclusters_per_cluster);
>> -    assert(sc + nb_subclusters <= s->subclusters_per_cluster);
>> -    assert(offset_into_subcluster(s, offset) == 0);
>> -
>> -    ret = get_cluster_table(bs, offset, &l2_slice, &l2_index);
>> +    ret = get_sc_range_info(bs, offset, nb_subclusters, &scri);
>>       if (ret < 0) {
>> -        return ret;
>> -    }
>> -
>> -    switch (qcow2_get_cluster_type(bs, get_l2_entry(s, l2_slice,
>> l2_index))) {
>> -    case QCOW2_CLUSTER_COMPRESSED:
>> -        ret = -ENOTSUP; /* We cannot partially zeroize compressed
>> clusters */
>>           goto out;
>> -    case QCOW2_CLUSTER_NORMAL:
>> -    case QCOW2_CLUSTER_UNALLOCATED:
>> -        break;
>> -    default:
>> -        g_assert_not_reached();
>>       }
>>   -    old_l2_bitmap = l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
>> -
>> -    l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
>> -    l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
>> +    new_l2_bitmap = scri.l2_bitmap;
>> +    new_l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc +
>> nb_subclusters);
>> +    new_l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc +
>> nb_subclusters);
>>   -    if (old_l2_bitmap != l2_bitmap) {
>> -        set_l2_bitmap(s, l2_slice, l2_index, l2_bitmap);
>> -        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
>> +    if (new_l2_bitmap != scri.l2_bitmap) {
>> +        set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
>> +        qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);
>>       }
>>         ret = 0;
>>   out:
>> -    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
>> +    qcow2_cache_put(s->l2_table_cache, (void **) &scri.l2_slice);
> 
> qcow2_cache_put() doesn’t look like it’s safe to be called if the table
> is NULL (i.e. `scri.l2_slice == NULL`).  We can get here if
> get_sc_range_info() fails, so that may happen.  I think you should either:
> 
> (A) Implement G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC() for the SCRI type so it
> isn’t an issue (at least I assume that could solve it), or
> 
> (B) Call qcow2_cache_put() here only if `scri.l2_slice != NULL`.
> 

Since in patch 5 I add the code path zero_l2_subclusters() ->
discard_l2_subclusters(), option (A) would only be valid if we manage to
skip SCRI param on this call.  If I understand correctly, you're
suggesting adding a destructor for the SCRI type so that we call
qcow2_cache_put() in one place and one place only when this structure
goes out of the current scope.  But even in this case we'd have to
perform the '!= NULL' check in that destructor, the only benefit is that
we do this in one place.

> In any case, I think it also makes sense to have get_sc_range_info()
> only return a valid table if it returns success, i.e. if there’s any
> error in get_sc_range_info(), it should clean up `scri.l2_slice` itself.
> 

Yes, this seems like a sane behaviour.

> Hanna
> 
>>         return ret;
>>   }
> 


