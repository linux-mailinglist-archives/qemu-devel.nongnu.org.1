Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEF27632A5
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 11:43:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOb1p-0007G7-1N; Wed, 26 Jul 2023 05:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qOb1l-0007FL-9A; Wed, 26 Jul 2023 05:41:54 -0400
Received: from mail-vi1eur02on2071b.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::71b]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qOb1h-0007Sw-Fx; Wed, 26 Jul 2023 05:41:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaQtR3ywWT9YwcU3nKqwxgNvRVITJPx0GSwYZU/cnhPCiBrpF4PYhKz32mEhx38uLBYO4v+u8loLx0b9D5XGP9IfLOX7tLhLYDiN6SA5ou0/NXZKftu5xKSa/bVVaS8yx1n+/hiqxSPxUEIV3VUbv2cpQPCK5KkKFEcrOAzhD+rwTnDcMfe78CabGC4ExAS5CqJThHjXinUsw/Ksb3rqd25KsCQ46QOuZscSkXhlTgvAUYjWr+P6HlZQVpozFFnA4mYQPQbfw0sLxDRaVD9uh0T0z+fcU+XZITSvGlwVL+e3yjgzcO3zxZIk7G6hfZMemfMg+Sk0XrGR24W4FBrvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSp/UzDLBsBBHDK3k9Wtz1VbaNyoCxF0iAiwUwYj3IA=;
 b=X55Q4rWtctrDrXXmJhamR9yEjhLo4ArTMJGOQznEAJmvoRy5yoG4Ko4eeYyMaIw53Xx2qyRkrzg3S+ijR6WOKvsEHmIJRIK+QGn1pyBbmyO04nxA7qn0bKijNUcyeBHSa9ANhJZ1/UCYJQjFSva8udv1AZU2wzy2P8RpoeYXMkiRhvod201tIfKJP3Su8iCsGbXfXJexm2oDkGZU5ciJA9MMpmT0PVJ10jOC2N77H38XEAjej4vsiEo23zoOdLIz/Iq75oholExn7winn/OhiKy1Pb5aN+QuQu+Plu8k68yfSrRIh4FFPVIomotcInVKWMwOoggAHI4+9E0Bo8T4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSp/UzDLBsBBHDK3k9Wtz1VbaNyoCxF0iAiwUwYj3IA=;
 b=lOUxHAOKddEuZ2dOfVJwOL/QN/y7WkniBhK/g3RWIF2x+0+voo4wvAf3c/ZcUJx6ffGaEsDP6F2ivE6qzjOc8jxy1UfeDa/s50qfV6I0FiwhzAJB6dQEozOWlaHVGtMP3ompaYiwxb+cK6T1CrcO+lHWcgk3LMCTNlm3NStnk0NQJkwaoMUa8PFx45H3EMgHG1h+B1egvP5YEfc4YAdaKKDzQJJiwp3LFd81gZ6MAtS1KUZtp3xo7PObnajTm8cdmx2jifjsEqihc+7ea6NRqx6dIb3aE082MZ8pVJm6LGL6oOy/kkRGf365ulAh077f//tgOogD9pGaY4YgA48aBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS2PR08MB10350.eurprd08.prod.outlook.com (2603:10a6:20b:57a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 09:41:44 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd%5]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 09:41:44 +0000
Message-ID: <9d67fa44-42fe-8f04-c24c-de254aef1b83@virtuozzo.com>
Date: Wed, 26 Jul 2023 11:41:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 01/10] parallels: Fix comments formatting inside
 parallels driver
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20230718104432.1130469-1-alexander.ivanov@virtuozzo.com>
 <20230718104432.1130469-2-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230718104432.1130469-2-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::15) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS2PR08MB10350:EE_
X-MS-Office365-Filtering-Correlation-Id: 44046d16-179b-4cb9-b4bb-08db8dbc85a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NQvHVTWIKvUmB6kQEbT8ATK3tdrnOxo5fRMVI3CWtSkv4belYy1/t6uvpHoc8P1pwIl3a55BV86zsHBj9bFX2DY14LvCGeUHoAe4d0Z6fuFy/TAlwmMfoyePGoe5G008GR+EDMKFMpDQC0ismVlTIOiiamJIscClEsYvamOOa6iwjGXP48mX7o2Bgzfv62rEWt4N8AGRC6BFHfa/GfTVrCqIVh9Az167nqkJNfRT3BBN/5JZGejp6FQN1InsverbmhcdVP58g+OwPhrmBzMLrF473ds5tmWy9hFqej298rmRroi/UD9mYrIe+KYUX95oc00ON/Un0xVMQ/BMLmeJNVkkoOrFUDcp7ue/lDLfs/xfJe20GRQ0j8yShJxFaPCqkSd1lBu78EncRGv0wg0h0W7uRJKYEtdnY4jcY1ifXInUnmBVbzBWA9ECQHjNYG0AMpwKIPvkAhO51fPRLnALGo4/LXgWRwMQj/WWgjOcw9MvFV9GMXR/os3+15TeLlbUEgeDbkVlsd/+5+XQuXY2kgKLajybbW8unjCP/4PLRPUCpkKV5iYrQttCsh7zaOefMIPivKfqhPoqddC46CS+Kk5DjdpUO9a7G+lfx8b6BFgeEQ++mAHTL6JQDb92ByO6z+NC/0JWrMptAr7iSeCPlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39850400004)(136003)(366004)(396003)(451199021)(2616005)(186003)(6506007)(53546011)(26005)(83380400001)(478600001)(31696002)(86362001)(66556008)(36756003)(6486002)(316002)(41300700001)(66476007)(4326008)(2906002)(66946007)(8936002)(8676002)(38100700002)(5660300002)(6512007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmtKaWdNL2xyU2hPQ0xndXFXaG5yaUEveUNQK2JHbHpoZkNVVnQvUU5IVDZJ?=
 =?utf-8?B?MEhsL3gxYVprNHNWcHZPZ2Iya3U0OXY5VmZZYVNBOElCQXIxY1RzWWVnb3VG?=
 =?utf-8?B?a0tqVVd0ZEl4RDFocEdSejRLSVRlQm0yZGplTjNNeEl4ZmpvSTFqNE9sZjYy?=
 =?utf-8?B?TVVMdkgyS0duSXZqSkw0Sk85Y21YMGtTNWsva1RwbzVhQ1hXbHhOM1djcEpa?=
 =?utf-8?B?cVFsN2k4UlBkcTVtU3ZmM01XNGJ5OGpYZXJMRUM5akxkVDB6SXp1Y29sZGRa?=
 =?utf-8?B?eHBpeWxvL0s5bDc5UVpSREhKWlpHeEdvS3FMcmh0UXhnVWhWYWRXVnlqejhP?=
 =?utf-8?B?WjVnVWZ2Q1VtY1JJcTFIeFlqUjVPb3RRYVd5U2RzT05NeDhKb1JRSE1iRWw3?=
 =?utf-8?B?M2dOYVNPczRNVk9QcTN6R1hqWTBZVFpMenN4YzlUTUxyMHB5d2FUQjNjc2w3?=
 =?utf-8?B?dExmR09vM0ZPUE1oVlQ0SVBScG1ubWIvb0l2aG84SFpCQmFWQ3phTFFRelpt?=
 =?utf-8?B?OFp4S3kvRUxHWjZHVk9LVVBUWHN6cDNCNVkyWk8xYnRnazR5VzhDNkFpcDMv?=
 =?utf-8?B?VlNObnJkeER1Y0tKTngvNTh4MCt6UUVMOHJubkFWeitWcUtaVGd3OGFCZnFK?=
 =?utf-8?B?MkFOaEdsa2V6WnR0OUxBWFRMWGp1UTNJRTJNQlhnZ2YyMVNhSnkxMWIwNVdT?=
 =?utf-8?B?Q1FrWldZQkxyUjdydWcxRXczOUI3ZjQ5UUsyNmlZbXVmVDAyelhleTE5alN0?=
 =?utf-8?B?RGU4NHB3UVJWbCtUNVZrNHkrVngvQWt3bHRLM3JnNHFzSHp2WWVZU3kzYXdu?=
 =?utf-8?B?RE5uMU1nY2I4QklpbE9SNU0yanE1OE5HdVB5R0dQeTBSUjQxZ3p5NElwbW1a?=
 =?utf-8?B?T2xrckd0cXRDUVJObVJXOUV1ZTEzZmlMQUV0Q2JDTkNsOG9NekEzM2RoME9Y?=
 =?utf-8?B?emxPaHZDQTlybzRjQVRNNTQ1cHV5MzBYdXE3RGNJREpXdW5MYUQ4djdhVVpm?=
 =?utf-8?B?TGQzY29ZT1BwNENZckxWUVFDcE5ybGxRSU1WNE9KNCtlUEgvRjJYN1did0lP?=
 =?utf-8?B?N084WUFubndYNVFSb2plTDBrUzIvOE04L2hZaUM4NGoyTTcvNS9laFdaNlVV?=
 =?utf-8?B?M3hzVEFUbVhyUmVncE1iaHlUMkdtQ3I3cTd3K1YraE5iN3JRUzh0Ymtob1hs?=
 =?utf-8?B?S0paQ0ZmTzJ6Qzc5NStOM3ZBUEs2TWZLK3ZQTit2TkhTUldnTW1UVThYbVFG?=
 =?utf-8?B?MEZNU1RONmx5alF2ZTJOd0pPdittcldJSHJGcUtJem5SR0hLMlNQVlBoaUk5?=
 =?utf-8?B?NHNGM1RIeURYYlAvcjN6SlJoNS9pUGZpWHdCUnNpUVJFc0FyUUpSUHpaNHA4?=
 =?utf-8?B?NGFsZ0dYYm1CbmtUbm5ORWpZQnlsNGYrOVBIazV3aWV3aUtLNXhaRjRLbDZE?=
 =?utf-8?B?ejlHR0ovL0hPeW83emIrYjl4aTk4NkEwS3J3bG00MWcyeWl4ckUza2NzV2xM?=
 =?utf-8?B?SUxib3JpVnJyRzl4L3FXbWRpd28rRzUyNS9maTJuTXFoRVFrVHBud3dacUpN?=
 =?utf-8?B?ZStmZzhrWFFUK3ZEY0dNU3o5NUZMSkNkZ09hci9ZT0k2cTZPaytGVEJ4RENw?=
 =?utf-8?B?TlNCUDhZSmkvaGx3UkZ2N3AxRzZoYXVZTmsrTy9tWnc5YXZtZEh3T2g1ZVhn?=
 =?utf-8?B?RzFEWXF6VGoyYWRJWlZXNnNDUUx4QjlnVlAyekkvTzN6N3l6Q0hId1JDZlhs?=
 =?utf-8?B?enVxT0pCa09JSlBNZlZ0U3JPUnpheWl2WUlMRzZtaE1JRFRUb1NBV2ZtOGs1?=
 =?utf-8?B?NDBhczY2b09mZm81YTZ6UkIzSjdQMVh1RlI1K0hPbzFINUpxTnc5WUNweEdu?=
 =?utf-8?B?RUdTa0k3K3VuaG5pZFF6Ny95amhicEtYbHRsUS9wZjRDRWlyQ3pkMUl3N1hw?=
 =?utf-8?B?U1ZoOXZ0eHhFMmdqMWwxYk5nZU1RaXY5TlU1MzM3TWExVVFtL0tlOUJiN3I0?=
 =?utf-8?B?TVZvbUxaVnNjdFB3WDc2bXljVll1T0VLWVJOSWlmWTRxa25zUitVM2lkRSsy?=
 =?utf-8?B?eE1zSk5OVjI0K3NVUEYrQmlXYUlHYUhrUnYzYmswRUxFdTdSckVFNXlKWlkw?=
 =?utf-8?Q?xpp0x3YTrCUIfXW8O1Jqc9wqf?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44046d16-179b-4cb9-b4bb-08db8dbc85a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 09:41:44.0234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuQQtwTmJBsFJikHfbZb6j3E6C+HkaENMKCZhRz6vS2Jo5SNUYhtySI/EYj77GdE7B6Bu7gdQeqgvwaIcVC7AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10350
Received-SPF: pass client-ip=2a01:111:f400:fe16::71b;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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

On 7/18/23 12:44, Alexander Ivanov wrote:
> This patch is technically necessary as git patch rendering could result
> in moving some code from one place to the another and that hits
> checkpatch.pl warning. This problem specifically happens within next
> series.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 18e34aef28..c7b2ed5a54 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -188,7 +188,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>       idx = sector_num / s->tracks;
>       to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
>   
> -    /* This function is called only by parallels_co_writev(), which will never
> +    /*
> +     * This function is called only by parallels_co_writev(), which will never
>        * pass a sector_num at or beyond the end of the image (because the block
>        * layer never passes such a sector_num to that function). Therefore, idx
>        * is always below s->bat_size.
> @@ -196,7 +197,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>        * exceed the image end. Therefore, idx + to_allocate cannot exceed
>        * s->bat_size.
>        * Note that s->bat_size is an unsigned int, therefore idx + to_allocate
> -     * will always fit into a uint32_t. */
> +     * will always fit into a uint32_t.
> +     */
>       assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
>   
>       space = to_allocate * s->tracks;
> @@ -230,13 +232,15 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>           }
>       }
>   
> -    /* Try to read from backing to fill empty clusters
> +    /*
> +     * Try to read from backing to fill empty clusters
>        * FIXME: 1. previous write_zeroes may be redundant
>        *        2. most of data we read from backing will be rewritten by
>        *           parallels_co_writev. On aligned-to-cluster write we do not need
>        *           this read at all.
>        *        3. it would be good to combine write of data from backing and new
> -     *           data into one write call */
> +     *           data into one write call.
> +     */
>       if (bs->backing) {
>           int64_t nb_cow_sectors = to_allocate * s->tracks;
>           int64_t nb_cow_bytes = nb_cow_sectors << BDRV_SECTOR_BITS;
> @@ -864,8 +868,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>           s->data_end = ROUND_UP(bat_entry_off(s->bat_size), BDRV_SECTOR_SIZE);
>       }
>       if (s->data_end < s->header_size) {
> -        /* there is not enough unused space to fit to block align between BAT
> -           and actual data. We can't avoid read-modify-write... */
> +        /*
> +         * There is not enough unused space to fit to block align between BAT
> +         * and actual data. We can't avoid read-modify-write...
> +         */
>           s->header_size = size;
>       }
>   
Reviewed-by: Denis V. Lunev <den@openvz.org>

