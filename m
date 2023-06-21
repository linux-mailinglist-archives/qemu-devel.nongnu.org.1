Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 966E2738760
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:43:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBz2Y-0006G3-DR; Wed, 21 Jun 2023 10:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qBz2W-0006Ee-7S; Wed, 21 Jun 2023 10:42:32 -0400
Received: from mail-vi1eur04on0709.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::709]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qBz2U-00006d-5J; Wed, 21 Jun 2023 10:42:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaV+tvbWHpZXr7juQyqlOfSj719VwmdybSfzOcnhRL3TcOT0Pe3uySaIdLIq+ivAEQsam3Yk7lrpOlnpKo1mNGn+gnkMTU8Wzb4jns7SbQBfjJl3gB07WFUr159R8GpwW0Oknce9JOe9qQhzW9oLYtlHcYD9zheUS7fiWODkxEismtIAeX1djWCm49fr7tnvHxgC8v9qQzA/G3SXGwMrNCIeUDbc1zbb9555Qc/sAO42NuB0UEX+dNUkT1VgP6fljUQ31tiq7ufKL+jFcR59v0F3vCgo76oaDBfIqu1dQ+krEhzcDwUTjncR4UZ34dioTlGQjGaELu/OpsceIphVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnP55uKGmAqywboaMdUWYZ2z3zEOY9Lj8Bunv+L6o/I=;
 b=NOBMD9diQmRZuMUiMD6JEA5wgtISDmNmkW9sBtTFCpvwYKPXdrqX/uXF7MiK99qbh9fXk5J3+WSfaO22OdWfj22ntBO2p2SP1FMOoL3QeMraQYjA5Yi1J91oG5tRWWv7xxobzw6poM6MzceifI2II79gkiCjSqBc7JMQLlJqti0rubyuK6l5RkNZfDurUc+TLH7N4BOhlDTe6a4EPbwuyoMj1Y0mScyzUHWQm6iRcJu9wqnHl6iJqXpunH7kd0OATQqnHJzKsiJiBP5qu9HC7zBoqnn/Jj5uIeorRcx5qOVNqSksqphm7g/jZpfChW40hrWzJD2t+ZUdKiww1v2VGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnP55uKGmAqywboaMdUWYZ2z3zEOY9Lj8Bunv+L6o/I=;
 b=daqEg0GJ9wQwIgEgJteUuQS6ZhrMKRqfpijGx01acC1dR/yB/OQ8flRzdoMRESEOADpfNvhTBG075FUb87BCQS4crrnqWVhIU4f4yw8UmOiMvinQ5L9dKQAaQxX8OpmdQJc58QUB4aSLrCNslSJF7YWMMEfz5KqCg7LiQikpaSJo1+ggqoVTbckbOfILCfqDJ/ByjEly28Kq7hhOeLpB6zsmVojNqSQ28OChYWNaiWPVOOCFaZhHRoTjWAzzMKCpyWDdcGwXWM80Xa+4xvTAa/6u6zWW287aC22+NpflyVOcmxiTbLDzEpi9VVVw7nLcmLhPcYHLpY+g8AMlzPaX6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by GV2PR08MB7931.eurprd08.prod.outlook.com (2603:10a6:150:a8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 14:42:23 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 14:42:23 +0000
Message-ID: <0bb087b4-bb17-7100-8073-818076818850@virtuozzo.com>
Date: Wed, 21 Jun 2023 16:42:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 4/5] parallels: Add checking and repairing duplicate
 offsets in BAT
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
 <20230621082010.139195-5-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230621082010.139195-5-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0161.eurprd09.prod.outlook.com
 (2603:10a6:800:120::15) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|GV2PR08MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 41655b4c-e7f5-4f0a-5068-08db7265b999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H35Gs9gmaO1GPPaSciqjncygH6LeL0BiY8UxpHxpFbq8fFtqxyFmKPgahDKSPQre7yvlq86miMdZXT+p6OH34Ms0+igOD7v73FRWKlKziB9FT/zjoGX57CU1AoVZvZdKu6jyJzXebTxFU0PeFTSJzmkU9GFA9SPgQVzqZUmYHVliQ8H4cxIblVz6BjweVL11YkIHdW4ymLkGOr5m+8dUXHXaQcSft5CVAqa3J2b6+J1x2+7/eAoDWWLPgDqaH/ZMKiQmb4dzSe1KrAflUus7gLXCxKzdYizcdzrpxGXgjFSikOsKC/Ey8MfZG9OnOvwj8eEyLkKKogztKT1sxU82fGUrwDQFV7bAQyFqxG9Ph0MfG33lKD71Deqaqkn2jEgVRPYmuNiv0/Rp5lpJj6iPW1sD3azQR2TPmRB/B90/BoKCSuudH1ZWv5YM1VzrZ7VJw9TSwXi1xYmPhxJwy2vKhnWn1maLikCqE5BWSS6wnFlQVmaUpb1lxn8rbWVflBgTabWPcw+hrAitD9djhvNpnIbiNq+iyPjZAzo9RsBv7rbkyOIG3xpzV1RvviAxCF64SEYMDcRgOrNhOl9w8zvAfoQlnS9VKW9Z5pCebiWqUwTodw0PNmGSdf85OHreh2WxlNW/TjT0s0uM+rANDgJ0tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39850400004)(451199021)(31686004)(26005)(6512007)(6506007)(2906002)(36756003)(31696002)(86362001)(8936002)(66556008)(66946007)(41300700001)(6486002)(316002)(4326008)(2616005)(53546011)(186003)(38100700002)(8676002)(66476007)(478600001)(83380400001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHJab1Ztend0NVJUQ1pnem5FdVJWbFRwRi9SbS9ReEs1U0JYblV4Mmk5MzVO?=
 =?utf-8?B?Um52MnhUUUNPa2JvamRsZzRvVXhIdmZiTDNHcDM2OHRPOWE5dEFHM0pBNUR3?=
 =?utf-8?B?NEx4aEk5K3pIQi9nYUVUdWJBRGFjdmNPaXhCblNHYlVXZFZYZFI3OVIwTkFi?=
 =?utf-8?B?ZkVHZjI2VExxczdWZlh5OHdXR3o1WGdYZm9maWJFQVNITURPd0FqY3dvVi9Y?=
 =?utf-8?B?TzJyRUxlYmhrZm9iRXU5S2VVUVZOK29ZUW5IYVBvNVRpb3BJTGZlVlFmdU1D?=
 =?utf-8?B?ZnR6b055a1lGS2tsdm93aVh0R3NZc280VHMrTEpia1RVazR2SEtKQ29oZFRW?=
 =?utf-8?B?dko1RVRxN0JIN3B1Y1V6WUh1Z0kvTk4wQzJDR2M1anl4KzIwZ0h4dVBvZjFZ?=
 =?utf-8?B?YWxOZG9EMG5NUmhEZGhuTTF5dTE0Q2grUWQrUTlWWUkyMUxwQVA3V0xOemdk?=
 =?utf-8?B?RWVxMGtYWlNGZmk5b3daMjdRa2hpRHkzR2JWVTNjNmx6REhxejh6dTZnYjVD?=
 =?utf-8?B?UXBKRU8vcFg5WFdqaG9ha3Q5WkZNbWFhZzFPU1hpbTc1ZHBtc25RNmpGd09Q?=
 =?utf-8?B?Z2g1VTJLR3pNOXEySkhPVTU1bThHa2oxM1V3RHlJRVlpM2Q4eVVYRCtxOUIx?=
 =?utf-8?B?OGRlNkdlSGQrRHBJbHdxT095RWxJOXoxUU1BMnNMd0diOFJ1bi9TWmF0b3N2?=
 =?utf-8?B?bmpVdjhxOEljUmZYdXEreFZWTVJMLzg2a0UxYlgzT3VVY0JkVEZqMytnaTI4?=
 =?utf-8?B?Zjk4eFN5T01DV08wRjNLYWJXZFZsek83b0lSMXl3K2VDcTFuWjVtaHNjY3Br?=
 =?utf-8?B?Nm51RERwRGxRemN3aTFmN0VSOVJySGgwdmRObU53di83RHA3b0lhalJXdUts?=
 =?utf-8?B?bnFLWi93U2pOUUVON0RWTytzTDF6cklVejBWUE93dm02L1VMaEN2cC9hNXgz?=
 =?utf-8?B?dHE5YU5qeXhZSzFOTlo3MmE0VnNRMHNmVTFMRHJPZ1JvazVreE01WndTdWhk?=
 =?utf-8?B?VWFkQ1hGUTBPSm9GVFIwSnp2RHZnR1ovWHkzSXR0T1ZiaWo3Y1JRTXZ0MUxo?=
 =?utf-8?B?eldlMW1CN2VWOGp1WVptQVUxUC8zTWJoMGd4SGJhYnhqQVNlYmd4UGtQalQ3?=
 =?utf-8?B?TVY5SFV3a1ZvWTI5YXRteURLVUYwUEdtdWFhd1NCa0tuOHJmaktweWdNazg4?=
 =?utf-8?B?UXlVQllFOXpZbTBXaXFsbko5cW1wYWlhUDc2TnhjQXZ0RFp0UWpIaVN5WEZ1?=
 =?utf-8?B?cDJ4d0RhSzRkK3VndUV2SDVEUlJvVWZhRVphbElxdkV6emt0bWRndTY1SnR4?=
 =?utf-8?B?WWpjSnNMRTJvOHN4KzV0RGJHbHpoOWc3dy9WRDVEUUMwRDBhT28rK2N3R0xD?=
 =?utf-8?B?THg5aTVCODdjWDVZQjE4Q3c0cDJlbHNvWnNVRit0R1BzbEY5TE5pbkNLekpu?=
 =?utf-8?B?Q3JKUlcwdDZ5U2t4b09vcWk0V3FSb0VNYnd5NXBMTnIrSHcrUFh0ZC9jM2NN?=
 =?utf-8?B?THlrV3lQWVZwNm5oNEpXVHl0c3l0V25samZPTU1BY2JwTHVCZ1NwRGQ0eFdv?=
 =?utf-8?B?RkpBOFljbEpaYnFIbG9YdVpIWTBIQTR6RjdFdnJWdXZ0bFJ5Y2NTcnF6QWpZ?=
 =?utf-8?B?c0JaMkljNjYvRkNyanpaaTd5VVRuTjlQVTZyOGxXSXMzOUhRTjBjUEIzSWND?=
 =?utf-8?B?ZDF4T3IvUlpRM3RUUWp1UnZTWVgrL0EzcjhpY0hRV2FudmZVV2tPT2tMS2Zx?=
 =?utf-8?B?MWNzdUo0Tkd4UnBxcGczbmVuSlZVRTVSdEdua3o4ZHFlNWhGdTUzV2ZRQXhk?=
 =?utf-8?B?SldLUC9lZ092VWF4RlRBVnNIcTdrSFFQbmpXd3NheXh3WUJYSEZhU2ZxNE95?=
 =?utf-8?B?WWllam5LREs4NHJtN1V5S0l3emkzQjlIT2NSY3VIcFBaUU1VV0I5cWp3V28x?=
 =?utf-8?B?N052bEZGNVZqRmtHNTl3NEFUUVU2emZkekdCQk9YVG50aGZTYVdvMVIvS0dl?=
 =?utf-8?B?Q0svWFM2TEptOGtLMDFvcGZYb2pOQ3VPQUlNQ2xXUmJ6OXhYWW16YkZsUFAx?=
 =?utf-8?B?MEdpdFJNeS9tcTZGSVd4ejlodUUrOTBxSGtaZk9RRERKMWg0NFB1Q0p5V0Fv?=
 =?utf-8?Q?kqRtOS5vnGUpeWjA6M+KC9Ukv?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41655b4c-e7f5-4f0a-5068-08db7265b999
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 14:42:23.5456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtU8W7fxbATzk3EVsuxkflr+2GtChIuTYQrX75IbvSsvpnfHmp6XjEL2ynE4d/TwO74QVt9GikhZQVqted5J+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7931
Received-SPF: pass client-ip=2a01:111:f400:fe0e::709;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/21/23 10:20, Alexander Ivanov wrote:
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
>   block/parallels.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 142 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 78a34bd667..d507fe7d90 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -136,6 +136,12 @@ static int cluster_remainder(BDRVParallelsState *s, int64_t sector_num,
>       return MIN(nb_sectors, ret);
>   }
>   
> +static uint32_t host_cluster_index(BDRVParallelsState *s, int64_t off)
> +{
> +    off -= le32_to_cpu(s->header->data_off) << BDRV_SECTOR_BITS;
According to


> +    return off / s->cluster_size;
> +}
> +
>   static int64_t block_status(BDRVParallelsState *s, int64_t sector_num,
>                               int nb_sectors, int *pnum)
>   {
> @@ -528,6 +534,137 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>       return 0;
>   }
>   
> +static int parallels_check_duplicate(BlockDriverState *bs,
> +                                     BdrvCheckResult *res,
> +                                     BdrvCheckMode fix)
> +{
> +    BDRVParallelsState *s = bs->opaque;
> +    int64_t off, sector;
> +    unsigned long *bitmap;
> +    uint32_t i, bitmap_size, cluster_index, old_offset;
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
> +
> +    bitmap = bitmap_new(bitmap_size);
> +
> +    buf = qemu_blockalign(bs, s->cluster_size);
> +
> +    for (i = 0; i < s->bat_size; i++) {
> +        off = bat2sect(s, i) << BDRV_SECTOR_BITS;
> +        if (off == 0) {
> +            continue;
> +        }
> +
> +        cluster_index = host_cluster_index(s, off);
> +        assert(cluster_index < bitmap_size);
> +        if (test_bit(cluster_index, bitmap)) {
> +            /* this cluster duplicates another one */
> +            fprintf(stderr,
> +                    "%s duplicate offset in BAT entry %u\n",
> +                    fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
> +
> +            res->corruptions++;
> +
> +            if (fix & BDRV_FIX_ERRORS) {
> +                /*
> +                 * Reset the entry and allocate a new cluster
> +                 * for the relevant guest offset. In this way we let
> +                 * the lower layer to place the new cluster properly.
> +                 * Copy the original cluster to the allocated one.
> +                 * But before save the old offset value for repairing
> +                 * if we have an error.
> +                 */
> +                old_offset = le32_to_cpu(s->bat_bitmap[i]);
> +                parallels_set_bat_entry(s, i, 0);
> +
> +                ret = bdrv_co_pread(bs->file, off, s->cluster_size, buf, 0);
> +                if (ret < 0) {
> +                    res->check_errors++;
> +                    goto out_repare_bat;
> +                }
> +
> +                sector = i * (int64_t)s->tracks;
> +                sector = allocate_clusters(bs, sector, s->tracks, &n);
> +                if (sector < 0) {
> +                    res->check_errors++;
> +                    ret = sector;
> +                    goto out_repare_bat;
> +                }
> +                off = sector << BDRV_SECTOR_BITS;
> +
> +                ret = bdrv_co_pwrite(bs->file, off, s->cluster_size, buf, 0);
> +                if (ret < 0) {
> +                    res->check_errors++;
> +                    goto out_repare_bat;
> +                }
> +
> +                if (off + s->cluster_size > res->image_end_offset) {
> +                    res->image_end_offset = off + s->cluster_size;
> +                }
> +
> +                /*
> +                 * In the future allocate_cluster() will reuse holed offsets
> +                 * inside the image. Keep the used clusters bitmap content
> +                 * consistent for the new allocated clusters too.
> +                 *
> +                 * Note, clusters allocated outside the current image are not
> +                 * considered, and the bitmap size doesn't change.
> +                 */
> +                cluster_index = host_cluster_index(s, off);
> +                if (cluster_index < bitmap_size) {
> +                    bitmap_set(bitmap, cluster_index, 1);
> +                }
> +
> +                fixed = true;
> +                res->corruptions_fixed++;
> +            }
> +        } else {
> +            bitmap_set(bitmap, cluster_index, 1);
> +        }
> +    }
> +
> +    if (fixed) {
> +        /*
> +         * When new clusters are allocated, the file size increases by
> +         * 128 Mb. We need to truncate the file to the right size. Let
> +         * the leak fix code make its job without res changing.
> +         */
> +        ret = parallels_check_leak(bs, res, fix, false);
> +        if (ret < 0) {
> +            goto out;
> +        }
> +    }
> +    goto out;
> +
> +/*
> + * We can get here only from places where index and old_offset have
> + * meaningful values.
> + */
> +out_repare_bat:
> +    s->bat_bitmap[i] = cpu_to_le32(old_offset);
> +
> +out:
> +    g_free(buf);
> +    g_free(bitmap);
> +    return ret;
> +}
> +
>   static void parallels_collect_statistics(BlockDriverState *bs,
>                                            BdrvCheckResult *res,
>                                            BdrvCheckMode fix)
> @@ -579,6 +716,11 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
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


