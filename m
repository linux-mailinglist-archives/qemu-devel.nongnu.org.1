Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7C082F073
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 15:19:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPkHh-0002Kw-It; Tue, 16 Jan 2024 09:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPkHf-0002Kd-BV; Tue, 16 Jan 2024 09:19:19 -0500
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPkHc-0003go-SO; Tue, 16 Jan 2024 09:19:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ7mGo/ZQW1o82Uo7OPIc0pwFDbRA3IeIG+FpuoHcDYHbmCk7mQPg5oIQ8hygfbC+kNXxH6YvhZoeA3nHHAaHA+68dLBEs+PlIbf9DkUhRQXXTcBxF9PCtXZqzE8V3ZkPw9747jz4ibui/OMke10cD9LyxMaXByL1GfU0wj/K6NxGgkkh+ARYuuErXugzyUKyl0E1M2+w7F9+TEK7YRNw4oDtvXDm8xJ053yO+anbMLI3mhrYuVIPoOTNpXiSKl0khXY9O/+Nu4GXKS2vECeaeE34dw6zvzIPAKIHfcjTa+aR01xjSNGIDJYo2UavNUzDpInOS5Iu/nmcoxze/hHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2d6xOPbLdtTC4e1cXwNiku2VepksxlNvQUSqQefo1h0=;
 b=TCvD9QF6bJxSgrcOOvypv7Hi9U/XcDVFoTZubiwn6p3+gusxWlzi90Zoi9KHCME4JK6fwFgbTfr+kCHx16F9oRA1ZEfKCkpByZM4UOJWwB9Il2x4NYmqEZHTRzg44jzCwMB2tM7OAHwHYBGPZMhBsntaoPpXbEE+tbA5CIgXpxtFFLkQ8hSKq3fYMEOb2sEFIHxivNgZVA1/NWHDl/YZHb7SHvsQhWXI9Umh9AhwjhWs1DFFGfWPSVhkoAIyFtHsx22ZWt5ZJMJFj8D0p2wfpD7jWbXzzR2O0Sr0ZB3MSW5iquxEcQX3U7P7XdAGqghI01GBz5m1uOY0cEDf5LtvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d6xOPbLdtTC4e1cXwNiku2VepksxlNvQUSqQefo1h0=;
 b=bu9XP5YSVazlYBoPpE8DRXkQC4qFSYbclQaSlO3LI10toTa5o6o3GtmQ+qupXKG/LEy1lxEdg46QTcTEFxMC3HokH4/bT8UJeapwVEDDQpOHe6cnvSvv75bp2n4XRBzqIK/ydli3zOrHLCjOcNxIpG6mpj08BRXW6Po0NPpD0iuJ41OvTTyIZV9xLwzRzEhUNnjlrlD1gVkOQnpISG25w7hjhcEsEt0COrGGcIWlrNZyXtTl1Yb41BRiE/ruDJq2bqjx7qC9TIxspHZ2KELJPvcROV+imU/F6U+drYGLIIWYHkbsbYcIi3pwQb+mCVlS5ncHhCYMxXZDIoyQoIw5OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB9PR08MB7469.eurprd08.prod.outlook.com (2603:10a6:10:36f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 14:19:11 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 14:19:11 +0000
Message-ID: <7e45e157-229a-475b-9449-b6e87ca8fc9d@virtuozzo.com>
Date: Tue, 16 Jan 2024 15:19:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/21] parallels: Move host clusters allocation to a
 separate function
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-7-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-7-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::16) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB9PR08MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e21bf0-713d-427d-22f7-08dc169e1c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBcZ2bktDuub3k/4LZ1NHFE9dxUKe3raXuRo9PzJYvdzPwzhBNu33XVuY353C/FBO+QfUnSOPWwIDBBWjnjwX9N0Kz+8drGrvDirEiSBtIh8rd5N3uELtr7eeNPqRaaJTzlQQYwLYrreF796sqxSUNPJCR6U7Ldxt/NSIpkzZ2RWpQPGebJeT2ofKWoz7hx5Bvb9eq45CddxT0vN3KD9r5l+E2DNUzFvfyrVVUjUzNvK4sAcdhnYC5VPTWgbMSrTJLGLexmoGghW/Y117UzFJt3pwjZWuJD9XwAOPR57YQA0U27+UmYeFZPcjmiH+2BXd4lci4FUPWy+50xpjM9ODKUM2sgACBm1vFNPrS9kQH4I3ug/rzGBN/DA0KGrmLBf/anVl4Xk9PiugmANhMUTp1NoehxCs9PLl/eINbKGXiKfx0EQGneiLUNFBR58q3PeSSoT9G/8wvAaIQMn/5tsJkwy5hmrkPUDl3Two7lb6Goj/S2H0jaHWwmXpnHErpPR/J+3PznvanvNsx09cTyH0BgGgsGJuPOvyyXUfC8vcUdj779gSlBy/eO9swtcL8Q5On+73GiUoKCRHUdLBDyUXFTXU7TyDdooHRqA/kmyc/CqV64O40JMOul5G03n+qtoWuVtJauB6FO2RWfBQEKbHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39850400004)(396003)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(83380400001)(41300700001)(36756003)(86362001)(31696002)(38100700002)(26005)(2616005)(6512007)(6486002)(478600001)(2906002)(66556008)(6506007)(8936002)(66946007)(316002)(53546011)(66476007)(4326008)(5660300002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0hQT3AralJmbmZFZEtoeUJ2ZGVSaU5CakZ6YWl6RW9YaHNCKytTdE9xeU8v?=
 =?utf-8?B?MVZscDBqYUhpVDIyMUo5bC91SHVzZ3l5eHgzdHpNT0NSYTcrTGtLeWYzNUo3?=
 =?utf-8?B?TUZETk9UMnEvSFB3RzhiZndxK0wwTDBjKzhvMTI3am85RTRLUzRDSmlNWEhv?=
 =?utf-8?B?a0xtYjJ1UThjbDhQWGpSUUNDVTVrRWpOV0NnVTM0NUZaRXF2MElROWdwRnJM?=
 =?utf-8?B?UWJhT254c3gyd2ZHL3VGck1vbzIzVWZOUGhGNUE4SHdxV1l4Z2NhbWhpcWox?=
 =?utf-8?B?NHJabHVoRWRqSERidVBlQ2RUZWNKbGpwYnlSbnd5TVpzUERJYW8yazlkOStT?=
 =?utf-8?B?QTVSNkJRMXh6WlV1U1hKYTVjLy9OWTErUloxL0ZFT1krR04wcnN3YkNWVU1h?=
 =?utf-8?B?QWlPVHR0VGs0bHJwc2RvNmNTVjg5Wkt1TWlmKytjbUFaVWtsNnlHemZwU3Nl?=
 =?utf-8?B?VU5ubTgyOGhrcUU2eDNnc1pGb3Y5WHEvSmsxY0taWkxIT1BGeWlLY0oyUXNr?=
 =?utf-8?B?U3ErMHlTYlVjVGowbjhwTHhEVEVXYkRhVUVZMmlXV3lxS3gwM2VZUG5ZcFda?=
 =?utf-8?B?VWp1cW5ua3RRaTIreWEyNlZzNExFVkc5Uk1hcm5RaFQ5aktRMUYzQU1FOWNU?=
 =?utf-8?B?T09oa3RnT2tmWktjQUpGdS9HMk1tMzZ2YnhuZnoxTHdEK1YycDQ4QkE5Rzdt?=
 =?utf-8?B?ZWhaekNNbGJOcVovZkxQTklsekppK1F6eGthVDh4d0s0UmZTWTVpdGM3Ym5w?=
 =?utf-8?B?VHQ3UStKa2JsWjdoYVpmZElKRHc3UnpaNlkzcktJOWsrNVFqbHFEbFJFSXpy?=
 =?utf-8?B?ZXRMYTR0S09oTUl2UVc5Y3E5YVZ4UXNyVFdqcmR1L0RVSDhwYTlEaHk2SExP?=
 =?utf-8?B?MEp3QjFYK2JMekgyTGx0MnhPQjY2R1dIb3RCQzQvbWFsa1VkbDdiYWRJLzRo?=
 =?utf-8?B?bjRUZFdkSEg0OXRqUWpLOHYwakNtUUkwSk1jeFhrb2poWkR2MzRDM0ZvZGQr?=
 =?utf-8?B?RERMU0NScmlhUWlmVXhReWNWa1lsbVhmOG9xRVltQ0xMeFEwNDJjbEs1ZDVY?=
 =?utf-8?B?aVZ3VkhYenExUHBnYTdnV1FBdjAvMkZib3VVTTZkaWtwNWZLbUNxME1QWm9q?=
 =?utf-8?B?ekh0S3NvV1ovTU90TzhodytKWE1KRnhiRDFvMGV2MWMxdGpMQ3ZUby90YWxk?=
 =?utf-8?B?dDU3cDVTS2F2WnZ3S1Rpb3UvRVlNVkFOcGRBb0F0c3AvMHp2OC94L3M5aVd5?=
 =?utf-8?B?bG4xQTl0RlNCNDMrTkFyUmgwK242QTlYdDZRNmJ6anVzeWZFZnlBT2gvekxX?=
 =?utf-8?B?L1VVM2hxTHY1U0kzUTdkRW5hMGJrWVJDRmtVK0VlWmpmaVRJRmh1VmVpZHBB?=
 =?utf-8?B?TVBiYzVYbmlkaHVMRnlwRWxLZSs4TnpORmxPbmJ2UlA0RzhxVzRralpzeHJy?=
 =?utf-8?B?Y0lEVkxWMjhKZjA5RlZmRXArTGxGN2hrVXFNZmV0UitJNmUwVGtyMm1vT2Jr?=
 =?utf-8?B?blFoV1NJUkhrb0lJMFZmQkZqSG5VNTRPR3JUYlBxeFJmajJaQzd5eHBBeXBQ?=
 =?utf-8?B?OVp4MjFGV1BycVZySmZPSVIrcHF1TjV4NUkxaUU4VEtkZ2xVNW1IUy9na0t2?=
 =?utf-8?B?RDhnWlhCOUtjTm02amZLclExTnNoNktscEpMN2NDMVQ4QlZCRWRJVHdmTHIv?=
 =?utf-8?B?czdKZ3dscG1pcTh0WU0xN3M0dEduWUNwTDJkOGlYNlNrWkQ5ZGdjWUhkUlhI?=
 =?utf-8?B?UnhpTDcvWHZhNDZFNDZmVGRYTzFldmIvVmtXOFFZREZ6YWwweEtXUG1hL0c4?=
 =?utf-8?B?NjlvbDNuVER3M3cxZTQvek1xQVpqY3MyVVlkMGcxOW9nNnd2UFByR0hFQUtv?=
 =?utf-8?B?MGZxSDJ0SDJkUFhIZU90MUVPdTBHZ3NrWUUyczcwRnE0dzNtVGFvd2psQ1d0?=
 =?utf-8?B?SzNsSXRCa0xXYlFJRnAvMVhkbjRmTFpnTnE4R2dGUExMaXYrVmJ4OEI4aDZx?=
 =?utf-8?B?UjBvU2x1bHE1bkJmZmViRno4L1FURk1GWlE0V1E2cEtJNlFtbll0WHlKRytM?=
 =?utf-8?B?dmtRZmVSNGt1VUlSUUdQUVVQMEl4M2s5SVFhMXBqSUFhejA1NkZHdk8rN2pQ?=
 =?utf-8?Q?OVBYx8W4lt31Z8k4bj+wtKuYc?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e21bf0-713d-427d-22f7-08dc169e1c3b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 14:19:11.5278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBPe/6x6+wFHS2kUaVrETyOoC7TnN/ic2EQQxCAsLgUZLHvHOUa43tHGOGPp7eFu2aVhPDsy/2SRaqdumqgrGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7469
Received-SPF: pass client-ip=2a01:111:f403:2613::701;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 12/28/23 11:12, Alexander Ivanov wrote:
> For parallels images extensions we need to allocate host clusters
> without any connection to BAT. Move host clusters allocation code to
> parallels_allocate_host_clusters().
>
> This function can be called not only from coroutines so all the
> *_co_* functions were replaced by corresponding wrappers.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 128 ++++++++++++++++++++++++----------------------
>   block/parallels.h |   3 ++
>   2 files changed, 71 insertions(+), 60 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 13726fb3d5..658902ae51 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -268,58 +268,31 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
>       s->used_bmap = NULL;
>   }
>   
> -static int64_t coroutine_fn GRAPH_RDLOCK
> -allocate_clusters(BlockDriverState *bs, int64_t sector_num,
> -                  int nb_sectors, int *pnum)
> +int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
> +                                                      int64_t *clusters)
>   {
> -    int ret = 0;
>       BDRVParallelsState *s = bs->opaque;
> -    int64_t i, pos, idx, to_allocate, first_free, host_off;
> -
> -    pos = block_status(s, sector_num, nb_sectors, pnum);
> -    if (pos > 0) {
> -        return pos;
> -    }
> -
> -    idx = sector_num / s->tracks;
> -    to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
> -
> -    /*
> -     * This function is called only by parallels_co_writev(), which will never
> -     * pass a sector_num at or beyond the end of the image (because the block
> -     * layer never passes such a sector_num to that function). Therefore, idx
> -     * is always below s->bat_size.
> -     * block_status() will limit *pnum so that sector_num + *pnum will not
> -     * exceed the image end. Therefore, idx + to_allocate cannot exceed
> -     * s->bat_size.
> -     * Note that s->bat_size is an unsigned int, therefore idx + to_allocate
> -     * will always fit into a uint32_t.
> -     */
> -    assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
> +    int64_t first_free, next_used, host_off, prealloc_clusters;
> +    int64_t bytes, prealloc_bytes;
> +    uint32_t new_usedsize;
> +    int ret = 0;
>   
>       first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
>       if (first_free == s->used_bmap_size) {
> -        uint32_t new_usedsize;
> -        int64_t bytes = to_allocate * s->cluster_size;
> -        bytes += s->prealloc_size * BDRV_SECTOR_SIZE;
> -
>           host_off = s->data_end * BDRV_SECTOR_SIZE;
> +        prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
> +        bytes = *clusters * s->cluster_size;
> +        prealloc_bytes = prealloc_clusters * s->cluster_size;
>   
> -        /*
> -         * We require the expanded size to read back as zero. If the
> -         * user permitted truncation, we try that; but if it fails, we
> -         * force the safer-but-slower fallocate.
> -         */
This comment seems useful. I'd better keep it as is.

For now (if we will not have a re-submission, I'll have
the comment back in the code). If the code will be
resubmitted, please add it back.

>           if (s->prealloc_mode == PRL_PREALLOC_MODE_TRUNCATE) {
> -            ret = bdrv_co_truncate(bs->file, host_off + bytes,
> -                                   false, PREALLOC_MODE_OFF,
> -                                   BDRV_REQ_ZERO_WRITE, NULL);
> +            ret = bdrv_truncate(bs->file, host_off + prealloc_bytes, false,
> +                                PREALLOC_MODE_OFF, BDRV_REQ_ZERO_WRITE, NULL);
>               if (ret == -ENOTSUP) {
>                   s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
>               }
>           }
>           if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
> -            ret = bdrv_co_pwrite_zeroes(bs->file, host_off, bytes, 0);
> +            ret = bdrv_pwrite_zeroes(bs->file, host_off, prealloc_bytes, 0);
>           }
>           if (ret < 0) {
>               return ret;
> @@ -329,15 +302,15 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>           s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
>                                             new_usedsize);
>           s->used_bmap_size = new_usedsize;
> +        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
> +            s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
> +        }
>       } else {
> -        int64_t next_used;
>           next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
>   
>           /* Not enough continuous clusters in the middle, adjust the size */
> -        if (next_used - first_free < to_allocate) {
> -            to_allocate = next_used - first_free;
> -            *pnum = (idx + to_allocate) * s->tracks - sector_num;
> -        }
> +        *clusters = MIN(*clusters, next_used - first_free);
> +        bytes = *clusters * s->cluster_size;
>   
>           host_off = s->data_start * BDRV_SECTOR_SIZE;
>           host_off += first_free * s->cluster_size;
> @@ -349,14 +322,59 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>            */
>           if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
>                   host_off < s->data_end * BDRV_SECTOR_SIZE) {
> -            ret = bdrv_co_pwrite_zeroes(bs->file, host_off,
> -                                        s->cluster_size * to_allocate, 0);
> +            ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
>               if (ret < 0) {
>                   return ret;
>               }
>           }
>       }
>   
> +    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
> +                              host_off, *clusters);
> +    if (ret < 0) {
> +        /* Image consistency is broken. Alarm! */
> +        return ret;
> +    }
> +
> +    return host_off;
> +}
> +
> +static int64_t coroutine_fn GRAPH_RDLOCK
> +allocate_clusters(BlockDriverState *bs, int64_t sector_num,
> +                  int nb_sectors, int *pnum)
> +{
> +    int ret = 0;
> +    BDRVParallelsState *s = bs->opaque;
> +    int64_t i, pos, idx, to_allocate, host_off;
> +
> +    pos = block_status(s, sector_num, nb_sectors, pnum);
> +    if (pos > 0) {
> +        return pos;
> +    }
> +
> +    idx = sector_num / s->tracks;
> +    to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
> +
> +    /*
> +     * This function is called only by parallels_co_writev(), which will never
> +     * pass a sector_num at or beyond the end of the image (because the block
> +     * layer never passes such a sector_num to that function). Therefore, idx
> +     * is always below s->bat_size.
> +     * block_status() will limit *pnum so that sector_num + *pnum will not
> +     * exceed the image end. Therefore, idx + to_allocate cannot exceed
> +     * s->bat_size.
> +     * Note that s->bat_size is an unsigned int, therefore idx + to_allocate
> +     * will always fit into a uint32_t.
> +     */
> +    assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
> +
> +    host_off = parallels_allocate_host_clusters(bs, &to_allocate);
> +    if (host_off < 0) {
> +        return host_off;
> +    }
> +
> +    *pnum = MIN(*pnum, (idx + to_allocate) * s->tracks - sector_num);
> +
>       /*
>        * Try to read from backing to fill empty clusters
>        * FIXME: 1. previous write_zeroes may be redundant
> @@ -373,33 +391,23 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>   
>           ret = bdrv_co_pread(bs->backing, idx * s->tracks * BDRV_SECTOR_SIZE,
>                               nb_cow_bytes, buf, 0);
> -        if (ret < 0) {
> -            qemu_vfree(buf);
> -            return ret;
> +        if (ret == 0) {
> +            ret = bdrv_co_pwrite(bs->file, host_off, nb_cow_bytes, buf, 0);
>           }
>   
> -        ret = bdrv_co_pwrite(bs->file, s->data_end * BDRV_SECTOR_SIZE,
> -                             nb_cow_bytes, buf, 0);
>           qemu_vfree(buf);
>           if (ret < 0) {
> +            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
> +                                  host_off, to_allocate);
>               return ret;
>           }
>       }
>   
> -    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
> -                              host_off, to_allocate);
> -    if (ret < 0) {
> -        /* Image consistency is broken. Alarm! */
> -        return ret;
> -    }
>       for (i = 0; i < to_allocate; i++) {
>           parallels_set_bat_entry(s, idx + i,
>                   host_off / BDRV_SECTOR_SIZE / s->off_multiplier);
>           host_off += s->cluster_size;
>       }
> -    if (host_off > s->data_end * BDRV_SECTOR_SIZE) {
> -        s->data_end = host_off / BDRV_SECTOR_SIZE;
> -    }
>   
>       return bat2sect(s, idx) + sector_num % s->tracks;
>   }
> diff --git a/block/parallels.h b/block/parallels.h
> index 02b857b4a4..493c89e976 100644
> --- a/block/parallels.h
> +++ b/block/parallels.h
> @@ -95,6 +95,9 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
>   int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
>                             uint32_t bitmap_size, int64_t off, uint32_t count);
>   
> +int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
> +                                                      int64_t *clusters);
> +
>   int GRAPH_RDLOCK
>   parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
>                                   Error **errp);
There is a difference in between what we have had before
this patch and after. On a error originally we have had
data_end unchanged, now it points to a wrong location.

May be this would be mitigated later, but I'd prefer
to have data_end updated in mark_unused. That would make
a lot of sense.

Anyway, with data_end dropped at the end of the series,
this would not worth efforts. Thus this is fine.

With a note about comment,

Reviewed-by: Denis V. Lunev <den@openvz.org>

