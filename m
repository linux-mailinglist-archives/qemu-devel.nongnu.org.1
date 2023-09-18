Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC59B7A4AFA
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:07:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEt9-0007H9-RZ; Mon, 18 Sep 2023 10:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qiEt7-0007G9-GZ; Mon, 18 Sep 2023 10:06:09 -0400
Received: from mail-vi1eur04on0727.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::727]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qiEt2-0003uF-7L; Mon, 18 Sep 2023 10:06:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEaCx3Xg650Vh/pTPTcn8Z/3rN3pVQ4ytc6573gZW7wXqAuxNEvDnIYaZ0RY5b1bIjni1g5MjdQSUkn8RWnsKXHNJlC/ldyIjsvM6fhVt9u3Aa4jXjVNZFIvxblyuymU1sf7QyfEAtVD7s77PvXg7aA9bd2PPQdrUnNb14e3oYzyTwQ0t8DXRNCFfq1D1WnP6zcJRWSh3RUEQjhvhksISnzbVS+OdqjQ6RcFnsdV8YULIT/pXikt2sMm+8HavJB0L2/fsbocde5PliGFh4VXl5vV1HQk6UFKZfm2fXobKjHJ0kUtMKgLZAXihPXdvgvEFOvVjrEgU/0XddH6CjvkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO2g9VXNbJTR0FZn20qtC6NC5XNCAOXb3Jr8nCzM9ow=;
 b=EP27zRKanrZwwqDQOtCLaCzuH0DzLJAKvqj91aDR0h6ZmGHz64X3EX4WsILf2hYdQQ2Jo6a6P/IrPQEi4wrLqPrmqME0D61ZdKdEMe/vOeTltfGgEbUgpDXkVC+4lh7tKUhML9Z9RWFiY3wNKwT5Am2laglx6HSL77/tbkC2mcAEtP9K5GSz4hnhcHVP7sFvfSTiAEJzJidG0qWbh04E64S/vIrohWkn/E2IoabGXdSegNJ7FXGliUnBhFlQ3KS4mMJCMomaqW838BXlh2ynwtHejQLlexPo9eXQW8B76JBtH2kkydbLfM/sTrccncQTlMxVx73XmKq9kq+KrRp0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BO2g9VXNbJTR0FZn20qtC6NC5XNCAOXb3Jr8nCzM9ow=;
 b=umKb5kpzCUBoW3JCDzXswXxCsatn5/x0RuDGVgbPjfBwj/fQ3klDHPMggSZ3TdtLhj2HuvuZ9nmsamBRNtXZgCnTMwJzr2LRzVjUcfDNfLYo/f5it6pK+oBo7NQ86lq8QEF/gGxADv2ROy3LVgl+1gJjoCLWS0Bqi2e4dNE8jEriHc+ikC7QvDBfTy6LvCCVF4oGfIXceu+lY+tRwIql7Go0bnE7h+GrO9tBItub0x46DCoe/61+MXxwsXZ0Aqx1DKwct7NJIdEypymwQTAwYlLrUy9WVBVKFI0F0zazjXQcIT77BQAGnbVPOgMgmeEUcHzWFgBrnW/87ZmwZyMdtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by GV1PR08MB7939.eurprd08.prod.outlook.com (2603:10a6:150:8c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 14:05:57 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 14:05:57 +0000
Message-ID: <43b94fde-74bb-1a99-3abb-b6cd9f6c03e3@virtuozzo.com>
Date: Mon, 18 Sep 2023 16:05:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 18/21] parallels: naive implementation of
 parallels_co_pdiscard
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-21-den@openvz.org>
 <d32c69b7-097a-89a8-356a-8a8eba326e65@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <d32c69b7-097a-89a8-356a-8a8eba326e65@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0154.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::38) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|GV1PR08MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: a955a8f9-d241-46d3-b4e7-08dbb8506165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scsQuReATqyK+2NbNBqW8fkkw+JUv3OI3tNwmhMbg1290VZNrFIX05j5t59eN1NJAkyIalbMps7djRekZ6RDBBYNKG6C0NtkZ//U0GSu3ZvDTFhyrRB/3AHLgAbdDJ89Fqtg924JpCSgfh8ORApG0k+6YhRfd4vlnGdGj/3SS52tJ+XgDHcJ8+LBLVJeKO9DGIAJHaHhSwCbKBVOiilX8U1PH2wS4bY+lU4IPSKDQBvtBn8TBAWnwbHEJw4kOAezFVO5avwyb/w0gh5lm7zqzpq78JpCrG9+B0zZU/xBqYVCYFrH0YJZMBQP43wC1D8Uu0PrPUUlgEefbZLAM6YI2bI9TWrAq6j5WkFBKz+Gkqa0et592JiNx9/3X3IdD2TO4sVFVI3eixU6/1OxwsIRvlP9mx6tO5kcwQyX8zN5gF8hUL43Bwp8hRS16S9NwMRMk42l2a83wRqDpCBpfC6HSssBzuZynbQ/CLxALd2rg7PIXjpA4IXU2IL558O+x3LT3PfobZG8MylX8r2mNlAQ4Bl3OnxE6bREla/xeCHBQjkiUAyApPvAscwZbZLfdbtwkrDR2lP9Q0PAuVUEHC6P0pbsNPshYoX0JgS+AJgV3GjdtbVBsNNtTFG9MmQY1OudEb2alpXh4bgcYbyVFPgTsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39850400004)(451199024)(186009)(1800799009)(53546011)(6486002)(6506007)(66946007)(110136005)(66476007)(66556008)(6512007)(316002)(41300700001)(31686004)(478600001)(4326008)(8936002)(8676002)(26005)(5660300002)(36756003)(38100700002)(83380400001)(2906002)(2616005)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHRsakxTM1FVU1dodzJkYlZaWFZOTDhXUyswWVNKU2FaSTlDeG1vSlkzQ1lw?=
 =?utf-8?B?Y2ozb3FDSVpjRUlYQ0JzWDFzNWJ6ZnZvRmlKaDk3MThZWEloS0Q2bUJQTjRu?=
 =?utf-8?B?dithbHMwWHU3L2NZbU1BVXBYWEJTSGFIUFc5cFRFUkU3bkMzdldTR0s4UHIr?=
 =?utf-8?B?cXMrSXd3cm03eU5QY3hzOGlDRWlla2M5eC9sK3F5RVkxcnBzNklYUkF4cG4y?=
 =?utf-8?B?SXRTUFA3RUh0aXZDWm1nTlpCT3NFMEYzMTFkcGpVcUN2VEMyNGI2dFExOVRa?=
 =?utf-8?B?cHhubjFYekNqMVI4YjVTMG16N0Y0MUdPT2xUK0tKOGRYVDN1S0xsZWdtelRX?=
 =?utf-8?B?aUt1ZXIrTzRnai94VnljdUk2UGtDeStKcXNSQVpweVdIcmpHa0U1UUtKR3B3?=
 =?utf-8?B?aGRSNzI4L2tFMDBHbStoakk1OWlXZlN5VjUvSEMvZW5nMWhwMVFVOG5DVmp4?=
 =?utf-8?B?WktrcWZtTFBEYkVNbHFhOEpJdDJIWUlnTktNaXl2ckNWaWo2cy9QUkZISEdT?=
 =?utf-8?B?cG1VRHplYjc4dmZjck5IdFZUb0tqb0NCa2E4OU5lR1haaTRZYmlOSjZpaWRv?=
 =?utf-8?B?NTdDbkZjVU9oT3pTVmhCVFdQMVFOeWNWb2pKYitlbXNnMVF2WVRGZlR4SmVy?=
 =?utf-8?B?RFZFZmhNSUpaeVFsR3dlbzF1aUtmaEtCSUcxKytDRDh5QTBMVi9CRkZQNW1L?=
 =?utf-8?B?dVJBM3NBSG5yVVpaWTU5QjlKcStxZ0xZTVZVUVdpWHAwVGVWTDlkdU44REph?=
 =?utf-8?B?WFVDYlJwRmVTeU9rQzdWWTlobHV2Mit5b05pWlAyWkpaTnhKSHZVWGdFVGp0?=
 =?utf-8?B?ZzdOaU1WQ1ZPbGJ6U3ZCSkdiNE92LzMrVGR3SUxsV0I3ZUlvanFQbHE4Y1I3?=
 =?utf-8?B?MGdpTUtTcWkreUlWL2ZuNmdsa1NxdGVkenJVWnZrckZFbnBsOVdqT2hDUnJZ?=
 =?utf-8?B?ZHhXbzgzaUNoTDMzTE5MU253UGdVVU11OGg1VVd4RFlRRGlwaVhGZ2Y1UXJH?=
 =?utf-8?B?S053VWlWZzBsTWs4QktMOXBYSTdiRldtdHNOMFNrOGYxbmQzUjlvbWRMK1FQ?=
 =?utf-8?B?RXByamdnQ043V0g2eDhSb0JuTVpkSVhkaXBtTFBpdk9lNVRIcjhzL0h1dEVZ?=
 =?utf-8?B?azBUZlVLeWhGV2U2cEhoTkovWVMrYldWRlhzU0FpdFNhK3R3SnpPMkhIUmtN?=
 =?utf-8?B?eFdIRUR4UjVkcHZrS08wazkwQ1Q2cjVVZnY3NU5MVm96OHBvSFdVdUxnRExB?=
 =?utf-8?B?MWI5dU5yQ0h6aVYrUjkrcnhJNm5iYUFIZTFCMDhQSUhWaVA5K2pYQ3MyRlMy?=
 =?utf-8?B?MmF3TGdzMC8zc2E5bi9UN3NkaVNFMCtuZ2didjB3MFJPUkhZSituZmhmYXpR?=
 =?utf-8?B?WE5RQ0EreEcyVWlvRDZwM2JWbVU5WkkzZlo1RGs4UHlBNlhTdkxwcDN1VXJS?=
 =?utf-8?B?eEl3S00ySG5rdDlsWHhsMENBR2xKWUpteWEyZy91OEcxZmZkMHBjZzFGcVRo?=
 =?utf-8?B?ajhZdUhTTUFwcU1XbnpLellMZHZOUVlzMDVSMXZjVkhoSzBad1BETE5OdHZz?=
 =?utf-8?B?QUtXYkZobmpMNk1qb1c4WUJxamR4VHlJcyt2Tkw1Y0tEL2pUN0ZScldoL1Vl?=
 =?utf-8?B?a3dBUFdXSE1iTmpnbVYzdGptNXk1VkgyTzg3RjRjaGhobktlV21FNThyeFJy?=
 =?utf-8?B?VzdxMExIcCtaNFc5RGNzdGMwU0FiSm43T0hGL09aU2FOTTgxUko4Rzg2K2Np?=
 =?utf-8?B?RVY3MC9mZ0tzOU9qaC82bjBhVUtPcDIrc2NEVTlrSGo2UEVKcUNvQ1NYdmxi?=
 =?utf-8?B?MXVsWFl5QnB1WS9DL3UzSC9xTzFZOVdiVFlzUEUzQTZCWXNLaGg1SXRUWEJs?=
 =?utf-8?B?WFViNTFpR1JQYjRPSWF4Y2RJc3RyNUdyQk5NUjJWZ05nNks4Rnl2TzFUbUJ3?=
 =?utf-8?B?c3E0QlpkQ3RWUGRlRlBuZy9CY28wUnNIMlJuWFVMbXhJY3A5Y0VyYVFhd0dK?=
 =?utf-8?B?enJ0UFp2VGNMY0t0SGt4N2kySDR4MFFIZm5PQ1Nma1E1LzJwMEJpODRaeWR3?=
 =?utf-8?B?enBFR1FVZVZiUjBUQnpPUWxpNUZ6ZXZnK3gveGsrVDk4UFcrbmErR1FMN21P?=
 =?utf-8?Q?BkMsSmebFAq57+VN6ib7C66iS?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a955a8f9-d241-46d3-b4e7-08dbb8506165
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 14:05:57.4791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/jbK8Sv5COCuB9Mlx3RWiMJt6ePrXyY9YAbiRe+6NVJj1wZgbN6sgirxDgucuZhqyUc7OvSLC9dVcPMoyFY4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7939
Received-SPF: pass client-ip=2a01:111:f400:fe0e::727;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 NICE_REPLY_A=-1.473, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/18/23 15:57, Alexander Ivanov wrote:
> On 9/15/23 20:41, Denis V. Lunev wrote:
>> * Discarding with backing stores is not supported by the format.
>> * There is no buffering/queueing of the discard operation.
>> * Only operations aligned to the cluster are supported.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>>   block/parallels.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 76aedfd7c4..83cb8d6722 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -537,6 +537,52 @@ parallels_co_readv(BlockDriverState *bs, int64_t 
>> sector_num, int nb_sectors,
>>       return ret;
>>   }
>>   +
>> +static int coroutine_fn GRAPH_RDLOCK_PTR
>> +parallels_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t 
>> bytes)
>> +{
>> +    int ret = 0;
>> +    uint32_t cluster, count;
>> +    BDRVParallelsState *s = bs->opaque;
>> +
>> +    /*
>> +     * The image does not support ZERO mark inside the BAT, which 
>> means that
>> +     * stale data could be exposed from the backing file.
>> +     */
>> +    if (bs->backing) {
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    if (!QEMU_IS_ALIGNED(offset, s->cluster_size)) {
>> +        return -ENOTSUP;
>> +    } else if (!QEMU_IS_ALIGNED(bytes, s->cluster_size)) {
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    cluster = offset / s->cluster_size;
>> +    count = bytes / s->cluster_size;
>> +
>> +    qemu_co_mutex_lock(&s->lock);
>> +    for (; count > 0; cluster++, count--) {
>> +        int64_t host_off = bat2sect(s, cluster) << BDRV_SECTOR_BITS;
>> +        if (host_off == 0) {
>> +            continue;
>> +        }
>> +
>> +        ret = bdrv_co_pdiscard(bs->file, cluster * s->cluster_size,
>> +                               s->cluster_size);
> It seems, bdrv_co_pdiscard() should be called with a host offset, but 
> there is a guest one.

correct. On top of that unit test should be modified to catch
this problem.

Den

