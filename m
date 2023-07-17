Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC35756972
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:45:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRK4-00014m-Oq; Mon, 17 Jul 2023 12:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLRK1-000126-1y; Mon, 17 Jul 2023 12:43:41 -0400
Received: from mail-db8eur05on20723.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::723]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLRJy-0004st-Fd; Mon, 17 Jul 2023 12:43:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/7m5L45kgB4s6jR/WEjucrQaR0Ifo+KDJRBHEcYlsfAT/L8P/wJwrL8Eo5aCfZbIS3aLM2Okz0/i6qIlxpJjYutKDndjah4tvWcLutoycBbqa5nAiDZM5kEwE2wzGaArJY9DferFr8p9T/gG+gvwfI6hgEMZgOQMdB/pwYHddlpEPlQ06EC8vS7VIKiBsihkj2kri2D4+/21jCiirn0lhUbChztXvFImL/X/YcN0Qr03h7+ElbaFgyKKEY/WgFNnfotucKfKnu+7L9imIcM1s1m56L3v41eZIkbSGkfnQkQqFaG1eXE09mIaX6ZBbAwwJkesW11Etd6aWHmbV/CbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYKvQEx+zlihAKO6enZZ4WaH91KDYn4eFq37KsowDXg=;
 b=T4dXxX0izxsT75NA5oPbcO7zPUg26rKI7fmwOfKuHj7LFjiVyx3BJ4RVQE4WlvTxxPLOnPIfFtPMnFovRCgd0eWAqsF3bxCz89PqtzDZnS1stS0BBZUvew+QBBIWSYWUDD3wGYV1fYDpmeNYVYyVY9UtbcKzxa2Angulb96dcUWIjxg2D/fv/sxPUUgXac+Vikmb5Wpbhi/n3Lh3KZ/tH8+PITGZ3P3fwIIPt3rfOtxyZVWnPo2j8LWKqxRl1j5RJDtq/aCLDB+DDRpw5C/tWzzwTAcJKWxRnXFqhassJeM2Ufb1C4/p/Q3SJnr25RhG9RoV6F8UGJYD10OdS5bugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYKvQEx+zlihAKO6enZZ4WaH91KDYn4eFq37KsowDXg=;
 b=wKDy99Y4Vb0qL3AV6CR1UxVjVsmAyaRo1ESLf35MxVixfjf2F5/qV0S6+OcS4aLDAMGn29rHqJ1z7dAJjTDvf+Jm+h88UaW3vLvcXpKafYQHf+R5wv+CcYyeqtFtlvgMKZtAXlC8Cghv/k1bA79Xz3GnDynjhCsUwYheD/o5rCnCIsOOki7l9D2UpUdcfW+6OssY/w80KZWBmKBtG82zt0FvJrnfbkQdBwehrbPdOkaOrBz9NTkPzU1hYze66wkTkEGsGuml2Sw9glFiSpQxAU5SA18Hj3e3+aCN9ULaR6Q8eQTQ1MKycGL7siKdXWK+aVv1nRqTztEoUaNvr2plUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS2PR08MB10295.eurprd08.prod.outlook.com (2603:10a6:20b:647::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 16:43:34 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:43:34 +0000
Message-ID: <845f324c-c786-5e58-5dde-514005fbe69e@virtuozzo.com>
Date: Mon, 17 Jul 2023 18:43:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 5/8] parallels: Add checking and repairing duplicate
 offsets in BAT
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
 <20230701100759.261007-6-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230701100759.261007-6-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0097.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::14) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS2PR08MB10295:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bdf4104-b2d9-4258-21ac-08db86e4f611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntNZoiy5kQJADbvZn1JEIjwcvaRSiwwJUUzE+L1LUfON1t8N0K1VSF6s7iP8x+2RryZ/IMe1U9IJS7HEIUpwcQnaaubLZYazB3rSCMFDXSkCe42gVcXdCMh/J1zzwsbPuB2ZFXz0z194ZiYl7vldhS9C49QoWRX++Kh09hEmPng95gxfqyPvU0fahG7LBJoQxh78QvGVMuUpFOtSsVA7iiIB1VH1wB1yZ2OVyc9s6+WnmJKtVWs+5MIbR3GZr3pVaDf2/KfYwjwNdM6zKop9MFpptDlUwK2teo4nAFd6SGBWtETCL2Tu5N70vOVo3tOEcYSrF52sfBnx5MIW2o+7PTAX6aKOJu4/XJuqyVinNuRiBJhRZpsHcEDC05PKQrgfcw3znXMxPRS/vMhKYRNW+ahmWxSIsxAkfT2yCOLnMEasJmDl3JcezIED0UAuzbIzze+V2uJRdJghCYeoYwV4ToK4BFiG3U1/5CWSjNIiNrsiwLvejLsNwOuIL/E3OHh/0HybRZQUVbjMg5EcgikQMCM3BKgSJAcfnFP67oyTvw8GZdSSLzscKaiEfd6vqaaMv0XX3WazI30XiYErH3Q9aYRVSFxyctgNXOt1FSGYu4BGypMk8h4EO93IGUsiZEEndj11jzvE284IXS6svcKTvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39850400004)(136003)(396003)(346002)(366004)(451199021)(6512007)(6506007)(53546011)(26005)(66556008)(66476007)(66946007)(36756003)(38100700002)(31696002)(2906002)(316002)(5660300002)(8936002)(8676002)(4326008)(41300700001)(6486002)(86362001)(478600001)(6666004)(31686004)(2616005)(83380400001)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STR2dnlwdjB6U0x5NjJkUjF1OWdmV01rNnhha2F6NjEyVC9pOTIyUFBZSkU1?=
 =?utf-8?B?TTZzRDFGRGhsSVlqajF3cXJVcVRtVytYL1VJL01rS1puY3NxVUlvcjdUTVVW?=
 =?utf-8?B?SC9MK1dvR3oyd0RiVExSRmx5dXMyb3p6UkE4WnRTSjQ4ZzlRVVQwbTdpelEx?=
 =?utf-8?B?N3hubmpiK01kcmF3aWR3azdGb0VaR01HOEVzSHRGYzN4TlpkT0ZWOW5SQTdV?=
 =?utf-8?B?anBrb0V1WEZiR243TnJlY3NDSFg2Mi8vNnpRdUt6V2NsOHFDYVVzR1pSNW0z?=
 =?utf-8?B?cVZzaWdVZkYxWGR4bktKWG5NK0ZJaE5yQ2JKaUlLNjR0czY5VFE3UktFeXNG?=
 =?utf-8?B?QTl5Q0Frd0JZSmhITkVJbjkxQXRLMXZMRVI5aFlsd2MrdGcvMFRVYU9BYnNx?=
 =?utf-8?B?bnIxeEsyREs3ZFppYUhSQlJURTNBZ1R3WU8ycTl5R05JWWd1N1lPeVBzbnd0?=
 =?utf-8?B?bThPU3UxTUJpZEFPWDVZUWRCSWpiZTlPblBuQnBGUzZFeG9SSmJMYTlpajRv?=
 =?utf-8?B?NzhacnZjdXZra1RLdThBUW90Z1k3Q1NkMm11bVN3TW9FYmJQbDBQb0RQdFZ2?=
 =?utf-8?B?RGhBaXdtdUZCUjVrdlFGaldtOGk3SUdNMnkva3RUdm9aMTVQMENqYzJzcjNS?=
 =?utf-8?B?a2l1T3BWRDNZWmF0QXBVbVptaTM2ejNXY1ZydW1rTlJlb3QySlp0eDFsZ1A0?=
 =?utf-8?B?UUhxNUc5SE90ZGlKdE9KaWNOSEJDN1NUVmpRVGtwaEdMa2xwRElSOE12ZHVQ?=
 =?utf-8?B?cktKeFN0OWs2K0FPV0VWdUlMR1I3STNrSkoxVit4KzcvSDd2UHhZZXhxWUZr?=
 =?utf-8?B?QllDR3hXMzg2VXFUZFpJMk85cEpqQmlDN29KU0Q2RVhBbmwvRE9HUTg2bXdC?=
 =?utf-8?B?djNPQlFqR0RZRkpHYWlTbndtMEFMYXZOUWxOVXMzSEJNMjN0d1BXLzFVY1dL?=
 =?utf-8?B?Q3FDdnRmOUNMRWEyUEcyKzR3aUUyckwwY0lkM01VcDRwaWxMeWtBaVR5NUk0?=
 =?utf-8?B?Z0Q1dmpSSFFVd25ybmhNamNiLytwUW5PbWxDOFlzZGRsVFhuT1NXNENleFk1?=
 =?utf-8?B?cEx6WnUwenJGWXhEMDJaU1FRWU5WbG1sQ0dVU01lVzAzTHZ4M1B3N3U5RHF5?=
 =?utf-8?B?TUsvMWc1b25aWEY3S0hjcWdZNk8xWkdtZXRnZW1kRnRHVm4rV3E0cWl5U01W?=
 =?utf-8?B?aW5jYUtId0xSSFkwdk1uOHFjN3N2T0FRREZPOXBWMjdHbkFaZXhkeGVQamNL?=
 =?utf-8?B?QThHaktNSUxQUHp2eU5FUDIydTFxaGRjTEdXVUEvN0Zpc2RkTEd2bkNEUCtG?=
 =?utf-8?B?WGU2ZlRWY0tYTEVGL0NJc0hDazhMQ3pJcUU3TUMwZUpDYnE2Rmw4QlgxL1RD?=
 =?utf-8?B?VlF3S1BZUks5ZzFPQks4citiaFZvbW4xN1d2RkYxV1FVMUJsMjhPY1R2Nlpw?=
 =?utf-8?B?ZmZ1VzlBQlBlZHh0WmppSlVPMmpXSzd1dWVWbGFHQ2QvMXhkR1Y1a09mM2Fk?=
 =?utf-8?B?cVRZV3J2Q2ZtaUpQS2M5OS9wdy9WMmNIN0REUGgzcUF1REtmdEtlcVUrTktq?=
 =?utf-8?B?aExwZEEwSnVqR2ZqdHFIRTBmcHZIb0psaGhBRXdJei9GMVE2Rmw3aUtHcTZy?=
 =?utf-8?B?ZzVmcGZZM0FCWWlKNmw0blRtb25HYnJYZzdZK3RIcUY0NDdyTkkxS3FzY2RB?=
 =?utf-8?B?REo1M0NZUFE2NlV2dVNwV3JvS0pJK3psY20zVk42ZjVBTzF6VTFwUis2N240?=
 =?utf-8?B?Vmp6djBRaUFXR1MzMzAxemROVWpiMTRQVCsxOStKeUloTHQ2bzc2L1VUTzM5?=
 =?utf-8?B?cjBDVHg1Nko1RE1URGhyZUozQ0J1NVpKYnBlMTdUYTdhdk9OSkNzM0Rzdy9N?=
 =?utf-8?B?TUU0akt5YTloTzhUM0tIWXFPeUxmZVdxbmZxbEh1TC9URThVVHhuSzFHMXFk?=
 =?utf-8?B?TjZ0SzUrNERFVzhUeVhzZitWMlV6bE1oZTZyMXM0N0R0eW5lNThqUlJ2ZDlN?=
 =?utf-8?B?Nk1OUUt1dDRlQTdFQ1VEdElkMXlkSXNzOGZ6NmhVWkIyMVBiOTBRaDlaYlVa?=
 =?utf-8?B?REV5RnZtbHB5bFdEd0poKzVIUkdUd2Fod1Fhd1IvNTdaeXo0eS9MUDRvK0F0?=
 =?utf-8?Q?IIeCUzA+1F9W1Orqqx8iWGBIp?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdf4104-b2d9-4258-21ac-08db86e4f611
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:43:34.3256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEWDw3sQvDpCSeyi6vlW7g+IZhSf1We5O96xMOazb0s5Ecw+qHvEptR1HYSanl3uKdqLR5z4otRIPaFNV8w60w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10295
Received-SPF: pass client-ip=2a01:111:f400:7e1a::723;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 7/1/23 12:07, Alexander Ivanov wrote:
> Cluster offsets must be unique among all the BAT entries. Find duplicate
> offsets in the BAT and fix it by copying the content of the relevant
> cluster to a newly allocated cluster and set the new cluster offset to the
> duplicated entry.
>
> Add host_cluster_index() helper to deduplicate the code.
>
> When new clusters are allocated, the file size increases by 128 Mb. Call
> parallels_check_leak() to fix this leak.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 144 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 374c9d17eb..0f207c4b32 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -136,6 +136,12 @@ static int cluster_remainder(BDRVParallelsState *s, int64_t sector_num,
>       return MIN(nb_sectors, ret);
>   }
>   
> +static uint32_t host_cluster_index(BDRVParallelsState *s, int64_t off)
> +{
> +    off -= s->data_start << BDRV_SECTOR_BITS;
> +    return off / s->cluster_size;
> +}
> +
>   static int64_t block_status(BDRVParallelsState *s, int64_t sector_num,
>                               int nb_sectors, int *pnum)
>   {
> @@ -529,6 +535,139 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>       return 0;
>   }
>   
> +static int coroutine_fn GRAPH_RDLOCK
> +parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
> +                          BdrvCheckMode fix)
> +{
> +    BDRVParallelsState *s = bs->opaque;
> +    int64_t host_off, host_sector, guest_sector;
> +    unsigned long *bitmap;
> +    uint32_t i, bitmap_size, cluster_index, bat_entry;
> +    int n, ret = 0;
> +    uint64_t *buf = NULL;
> +    bool fixed = false;
> +
> +    /*
> +     * Create a bitmap of used clusters.
> +     * If a bit is set, there is a BAT entry pointing to this cluster.
> +     * Loop through the BAT entries, check bits relevant to an entry offset.
> +     * If bit is set, this entry is duplicated. Otherwise set the bit.
> +     *
> +     * We shouldn't worry about newly allocated clusters outside the image
> +     * because they are created higher then any existing cluster pointed by
> +     * a BAT entry.
> +     */
> +    bitmap_size = host_cluster_index(s, res->image_end_offset);
> +    if (bitmap_size == 0) {
> +        return 0;
> +    }
> +    if (res->image_end_offset % s->cluster_size) {
> +        /* A not aligned image end leads to a bitmap shorter by 1 */
> +        bitmap_size++;
> +    }
> +
> +    bitmap = bitmap_new(bitmap_size);
> +
> +    buf = qemu_blockalign(bs, s->cluster_size);
> +
> +    for (i = 0; i < s->bat_size; i++) {
> +        host_off = bat2sect(s, i) << BDRV_SECTOR_BITS;
> +        if (host_off == 0) {
> +            continue;
> +        }
> +
> +        cluster_index = host_cluster_index(s, host_off);
> +        assert(cluster_index < bitmap_size);
> +        if (!test_bit(cluster_index, bitmap)) {
> +            bitmap_set(bitmap, cluster_index, 1);
> +            continue;
> +        }
> +
> +        /* this cluster duplicates another one */
> +        fprintf(stderr, "%s duplicate offset in BAT entry %u\n",
> +                fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
> +
> +        res->corruptions++;
> +
> +        if (!(fix & BDRV_FIX_ERRORS)) {
> +            continue;
> +        }
> +
> +        /*
> +         * Reset the entry and allocate a new cluster
> +         * for the relevant guest offset. In this way we let
> +         * the lower layer to place the new cluster properly.
> +         * Copy the original cluster to the allocated one.
> +         * But before save the old offset value for repairing
> +         * if we have an error.
> +         */
> +        bat_entry = s->bat_bitmap[i];
> +        parallels_set_bat_entry(s, i, 0);
> +
> +        ret = bdrv_co_pread(bs->file, host_off, s->cluster_size, buf, 0);
> +        if (ret < 0) {
> +            res->check_errors++;
> +            goto out_repare_bat;
here and below we should use out_repair_bat.
> +        }
> +
> +        guest_sector = (i * (int64_t)s->cluster_size) >> BDRV_SECTOR_BITS;
> +        host_sector = allocate_clusters(bs, guest_sector, s->tracks, &n);
> +        if (host_sector < 0) {
> +            res->check_errors++;
> +            goto out_repare_bat;
> +        }
> +        host_off = host_sector << BDRV_SECTOR_BITS;
> +
> +        ret = bdrv_co_pwrite(bs->file, host_off, s->cluster_size, buf, 0);
> +        if (ret < 0) {
> +            res->check_errors++;
> +            goto out_repare_bat;
> +        }
> +
> +        if (host_off + s->cluster_size > res->image_end_offset) {
> +            res->image_end_offset = host_off + s->cluster_size;
> +        }
> +
> +        /*
> +         * In the future allocate_cluster() will reuse holed offsets
> +         * inside the image. Keep the used clusters bitmap content
> +         * consistent for the new allocated clusters too.
> +         *
> +         * Note, clusters allocated outside the current image are not
> +         * considered, and the bitmap size doesn't change.
> +         */
> +        cluster_index = host_cluster_index(s, host_off);
> +        if (cluster_index < bitmap_size) {
> +            bitmap_set(bitmap, cluster_index, 1);
> +        }
> +
> +        fixed = true;
> +        res->corruptions_fixed++;
> +
> +    }
> +
> +    if (fixed) {
> +        /*
> +         * When new clusters are allocated, the file size increases by
> +         * 128 Mb. We need to truncate the file to the right size. Let
> +         * the leak fix code make its job without res changing.
> +         */
> +        ret = parallels_check_leak(bs, res, fix, false);
> +    }
> +
> +out_free:
> +    g_free(buf);
> +    g_free(bitmap);
> +    return ret;
> +/*
> + * We can get here only from places where index and old_offset have
> + * meaningful values.
> + */
> +out_repare_bat:
> +    s->bat_bitmap[i] = bat_entry;
> +    goto out_free;
> +}
> +
>   static void parallels_collect_statistics(BlockDriverState *bs,
>                                            BdrvCheckResult *res,
>                                            BdrvCheckMode fix)
> @@ -580,6 +719,11 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
>               return ret;
>           }
>   
> +        ret = parallels_check_duplicate(bs, res, fix);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
>           parallels_collect_statistics(bs, res, fix);
>       }
>   
with old_repare_bat replaced with old_repair_bat:

Reviewed-by: Denis V. Lunev <den@openvz.org>

