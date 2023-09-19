Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E36D7A5E0C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:35:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiX81-0002nQ-DL; Tue, 19 Sep 2023 05:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiX7z-0002n5-Ib; Tue, 19 Sep 2023 05:34:43 -0400
Received: from mail-he1eur01on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::72d]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiX7x-0004BD-Ks; Tue, 19 Sep 2023 05:34:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcfaIGK+wABR3HpkaV0zDyl53GZI635oqFmCM25YZPTkE2BN7e7PgBZZ9F/Vmry89GcYVmKatmTwyDXAHGT4dqSSOMiHPuG8oDqo6JAPTpP+Z+W8oSirVroUjSx2nbHZRY3XQwUjT+krlzUaW9x7x+wo1rWUS4AI3Glk1EsFVJHZcTNb2vL31+eBpixn407fb9CsF6Ed9XNmr6GoS5dji7z2bIPpZ1BJ7Cc7LlemXNI45vPY5QG1nHxENPngkCwi/jG/O91HRIHfiTrh6Hqf/J9CC6JHMAhpdycPxQO8ulS3fp8LHuHBoADLai3UfjZfQeBJ0JEqWSgZMt6b3dl8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAAzQTscUGYbJsu0RWN0U5dcxJokGjUVt7ePJPVVUgg=;
 b=FhmJqR+W3N9OKIlBXU7+uB7fw2GgDF0HbxcOSd8mgi26xEnxfcgGUFGdPRZR6KWwl8gJQSwu40Y+YYyqc1p+MCFgn9bdBqTTW8lLpux1C4OtQFMsOVhEBRfIgdzY5AM7OzbmPK4x/8qS4kf4I6vVRak8CsHxgkhrfbg1rK4Skp56Em1q1RZH5oKK+7CNSvW9s62Bp7wBFw837yS7sVQKGxiLcJucTaZ4gn0AWq14jOC42HoK65+sWy63ijmLhx7ZPeqLM5fO8NUFZuWqhZeoOeuE0YW9S8gtC+30cpTQTe5cWE0sEPenrsoLns3eeAV64j4qHeRgUdjEd06qOK6MrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAAzQTscUGYbJsu0RWN0U5dcxJokGjUVt7ePJPVVUgg=;
 b=KomxREpPJnRzBhe7boheoda1R/UGaT+XIay56ZOigZ1fD3AuZiUpgSurGetY25Mipo/7gumN3DYpx4tPTX4SFV02LuEKTKiMPW2DdYJ2FBT7/k/XJdC4J+dAV1SpNza5hfBho+NlCqva6aYKq2ZZVSJQvczk7OjGgbXH0BSuNYSUvPSo1XN0RR/vzmWCanZMM04BCIJ3stR2WNcPM8/kDyu7zrS7mCuoVEz/hDf04pFq+N2MJ9zUIGiRx/FLMP+/uSXO/hopYe2wLU0Yo/kwztqTuBIgFW/wJVTZKisFdQRel/oyWBCrHmIfSiOixOb2IkCru55QZcVp5++8e6ATlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS8PR08MB6053.eurprd08.prod.outlook.com (2603:10a6:20b:292::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 09:34:36 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 09:34:36 +0000
Message-ID: <0db8c842-e4ef-0f7a-4e58-af9f1139cd12@virtuozzo.com>
Date: Tue, 19 Sep 2023 11:34:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 04/22] parallels: invent parallels_opts_prealloc() helper
 to parse prealloc opts
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230918180100.524843-1-den@openvz.org>
 <20230918180100.524843-6-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230918180100.524843-6-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0023.eurprd05.prod.outlook.com
 (2603:10a6:803:1::36) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS8PR08MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: e1afc082-a0a3-42c0-59e4-08dbb8f3a3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IliJwTM1vhYMBscogIrS5Jlvt+nEEm2k5jnh3iBevsTm8AAhF4eP+OczrIQ4jHPlA/nKY645ogeSPZWdZAkgAhwUP8Tpf0N24ncpkPL7CRZgfx+xZ0OspXgiN5oKYj/qhd5mNLPKsRiJWgix9COgNQshAW/QllC+V+Kta/EOVESFmKOAMgOZmuaaxiwRg64HnGu9LAjlSKvYS0HjXHFC2NxQ33MoZ2VQLrK2gVdENMKr9XUfP88x3/L4XohrOVNiPQJKKKt2AtNUAvT58hiY0tqkjpINKRgc6TzJDIvTkpcPPDScZNXvm3Tl0nJ4JcMw029MuJ0DFUTb5u2Bm7P2J0rggkmtcnjVRBbPmf4cP4pBPb1cevlrqCPuFx3sBL/Oqr5ltNCYBIeY/NSMxVi7Rs9rPjJlVbvYwl4otwWLtxaTuKeZnPTziVrZaiU15UufQdV7fnYfi5Fkv2cB15J6Cd5vYLFOBgKMV8GU5qWCBze6D7n4mxAHA7csSjHo/I7FHRkAd8xDW7jt0SZXcIDOBesF8F1tDRAnRNhR/MPOfIqanoxh9tpoBri+jwy6cC+v3Q4KvjW9XhWW3Q12THcby7pYtuYtjKoR/oMO1ktuIXTUln+kQ1tEVmy2YdJfuNPfHISa7/s0KZ8ImoPUDEMhwQpHpjTA9uxOVJtHhZSB97CHGfHXzakagJ+Pu9StlaVt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(136003)(366004)(376002)(396003)(451199024)(1800799009)(186009)(2616005)(31686004)(44832011)(41300700001)(5660300002)(8936002)(8676002)(4326008)(6486002)(53546011)(6506007)(52116002)(6512007)(26005)(83380400001)(478600001)(6666004)(316002)(66556008)(66946007)(66476007)(31696002)(86362001)(36756003)(2906002)(38350700002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU5ERHFpbEdaVlZ6cnpBZklHUHBQVEdBanMwQmJ4VFdIT1ViK3NSSFpLcldw?=
 =?utf-8?B?NnNRTHdHa25wc3M4RDl1NjNLRWZJSjREclBURjhCL3M3OHFWbURlMzJ6V0d5?=
 =?utf-8?B?V3Qvd2JpcHJxSFUwR2wveVd0d0JRd2l6a1lmbm11b3N5bVIwTkxHN1VXaStF?=
 =?utf-8?B?S1MwYlpWT1Nta1FrV1NaU1haY1lRdGFJcEJqS2RXWVplYUx2cEpHUGE4Yi82?=
 =?utf-8?B?c1UyTm1Gdm1uVGpMY1BNb0UwUk5BU2lLYmtIR0lUYnlrZnJKcmdoTmZFN0x2?=
 =?utf-8?B?Z3NTczAwaldMZEVFaWdaVS9MVUs2SlFWc0tsMlJlZkhoNlhobXRBanJYK0RP?=
 =?utf-8?B?ZWFaZ1Q4OTdUMjRhSUIwa2Jtamh1Um50YVIyUXRKbFBUZVdjVW5zVHRRWFJI?=
 =?utf-8?B?bEpHOGxUeW5uUEd2OTgrZEdNTllYUjNqNWt5SjZkVGRZZEovZmMydXhjK2h3?=
 =?utf-8?B?NWhTRVJjTnZJTTRhdnFVdDdwMjhMckw3UGU5SHpqb203UzBqTTN3RHF4Zk5y?=
 =?utf-8?B?TWRsSk5FdE1IS0FOYkpweEI3MjJaSk4xcndIYXBMZUZTYmd6bGdndzUzV0x1?=
 =?utf-8?B?TVFBZlFNRWcrRTdGNDJHbWFFQ2d5Qzc1MTlLZjRqNVQ2dlkvMWUwVTlCdTVx?=
 =?utf-8?B?YklwM283RW5UNXVjUGdyWGZ0cnFJRVQ3NXRac2x4TGU5VWN3Wms4cE1XaFVx?=
 =?utf-8?B?MWlXa2w5T0t5ZEJ6ek5LTG91NFJWVnhHY3VXblBSZVZKNG5NNHNlVlhwMDBx?=
 =?utf-8?B?SGticGVuNEhpMjlObmxkKzlKMUVtR0twUWFTRWFmeVdvK1docnZJVEw3QzY0?=
 =?utf-8?B?WVZ3Z3RVNGRVR1l1cXQ4ZUFKSUZzMEZpNWp1dkl6ZHNBcmxLckVHWEh1YUJm?=
 =?utf-8?B?OWxOZG9SOHF3ejBMcFBoVzBYM0hQeWNSem5NcE81bFlOSTJoMXM2ekdsRUVC?=
 =?utf-8?B?ZXZkd1RkajhPY1doUFpjbkNYR0hwN2pUQ1FSVThGU3ZPSDFnNXlrbjZycmJK?=
 =?utf-8?B?S0g0ZHRDWllSRTZQditWU1IzTFBQOElSNGpVajh1VjlsYUdNeExlaUxHRnhz?=
 =?utf-8?B?R0Q4WC9iWGVQR0hrT3owY2tsTWltQTZxbzlKMHVCYUtXWlA4bkpPVWR5amk2?=
 =?utf-8?B?WmRJd0J0YUJmRys3TmhyVWMya3pBQ3hsOGlsRjVYZThzV2xtajE1L3NRODB5?=
 =?utf-8?B?L2dZZkZQaGdWc3N5MHZWY2s5YW1pbzBobWJUMmNLejNzd0YwWFA1M1Y0b1px?=
 =?utf-8?B?QVVvTGttZzlmUjNwV3ZGTVhQSFRnVk5SM2RqNkNONjVDNVA2b29YY2JSakNM?=
 =?utf-8?B?ZHg2RlZjTE9UdklkckpaNFZlRmxWbmxNWC9sRDhUOUZmbGF3M0lVTGpLUWkz?=
 =?utf-8?B?Z1dqVXQvTW45UW00QXk0cTJWbjROUFZKTkJUNUFqTTZnTzJnZHN5cnMzZy9Z?=
 =?utf-8?B?SVk4WkVWd25wamtvUGxibndTUWVQMTlXS3ZhY25MWVZvY0Zxa29EUmZHY25T?=
 =?utf-8?B?djYvT3U3ZGFDMkZiNWh2WlFLU3EvOHNMTWFMeDBhRzJHZXRWM0tRR1FyRXVK?=
 =?utf-8?B?TzhnRTMxUVpRM1E2MzNlSG02OWM0eE5ERTNyclU2eC94blA4Y3J0ZFRmanZs?=
 =?utf-8?B?WHJEaE14TUVJU2NNNW8wUjR0VzlJdXA5UUttUTJiZVgyZ0gwTEE4UnhkSVhY?=
 =?utf-8?B?RU1BYUJSK0JPeUduV01QeGZEbE9nQURFc3g4UHFpamg1WUJFQTFBa3FGdzc5?=
 =?utf-8?B?N2hZeW1mQVRHbWFXZGo2bExZMnF4UllxbjZVSlB4Q0NKTnNnclM5M01rZHZD?=
 =?utf-8?B?VU9aZWxFSmRxM2VMMWs1SVdERmVCbjZhdzZERmpqV2pIVW9vN0IrYWJDd2Vk?=
 =?utf-8?B?aVMxUkRKVmZsMUJlQ21pUkxkaEpKMmJlcWhaTG5ncHZTRzl4RG9tSVRCRk50?=
 =?utf-8?B?czIyalZvMUpyYmRFWjBYNWlraFJXRm9YMExMRGF4d3NVMkx6Z3QwcGVrVkp4?=
 =?utf-8?B?bVpaSnh1ckJGUVdyTlUyMEFMOUljV3JSOHhEekhxZVJHYTZBZkR6NDJLR0U1?=
 =?utf-8?B?WXlGVjRReHBUR3hsQzhiTmNCTng3bkY3SEdicll4VW1tVWpROWl5eURjSHVa?=
 =?utf-8?B?Tjd3UUJ6YjZxOCtSQXlqSnArQWZnQ2tORWZvYnF0L2tDSEtad3g2NkVIL3lu?=
 =?utf-8?Q?78uGqW5aOGk5aCipl4P67+A=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1afc082-a0a3-42c0-59e4-08dbb8f3a3c4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 09:34:36.8081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gusZhFWzt5Bh03YjvVCXhW5o49hOMHT28WwNuk/o+yn3BHkVaroUkNQBU2f+o+Ta6hr3viCQ/vmDlbuhU/YSkTBc9jiwV0y1dISdhVpwW+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6053
Received-SPF: pass client-ip=2a01:111:f400:fe1e::72d;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/18/23 20:00, Denis V. Lunev wrote:
> This patch creates above mentioned helper and moves its usage to the
> beginning of parallels_open(). This simplifies parallels_open() a bit.
>
> The patch also ensures that we store prealloc_size on block driver state
> always in sectors. This makes code cleaner and avoids wrong opinion at
> the assignment that the value is in bytes.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 72 +++++++++++++++++++++++++++++------------------
>   1 file changed, 44 insertions(+), 28 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index af7be427c9..ae006e7fc7 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1025,6 +1025,44 @@ static int parallels_update_header(BlockDriverState *bs)
>       return bdrv_pwrite_sync(bs->file, 0, size, s->header, 0);
>   }
>   
> +
> +static int parallels_opts_prealloc(BlockDriverState *bs, QDict *options,
> +                                   Error **errp)
> +{
> +    int err;
> +    char *buf;
> +    int64_t bytes;
> +    BDRVParallelsState *s = bs->opaque;
> +    Error *local_err = NULL;
> +    QemuOpts *opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
> +    if (!opts) {
> +        return -ENOMEM;
> +    }
> +
> +    err = -EINVAL;
> +    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
> +        goto done;
> +    }
> +
> +    bytes = qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
> +    s->prealloc_size = bytes >> BDRV_SECTOR_BITS;
> +    buf = qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
> +    /* prealloc_mode can be downgraded later during allocate_clusters */
> +    s->prealloc_mode = qapi_enum_parse(&prealloc_mode_lookup, buf,
> +                                       PRL_PREALLOC_MODE_FALLOCATE,
> +                                       &local_err);
> +    g_free(buf);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        goto done;
> +    }
> +    err = 0;
> +
> +done:
> +    qemu_opts_del(opts);
> +    return err;
> +}
> +
>   static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>                             Error **errp)
>   {
> @@ -1033,11 +1071,13 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       int ret, size, i;
>       int64_t file_nb_sectors, sector;
>       uint32_t data_start;
> -    QemuOpts *opts = NULL;
> -    Error *local_err = NULL;
> -    char *buf;
>       bool data_off_is_correct;
>   
> +    ret = parallels_opts_prealloc(bs, options, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
>       ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
>       if (ret < 0) {
>           return ret;
> @@ -1078,6 +1118,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>           ret = -EFBIG;
>           goto fail;
>       }
> +    s->prealloc_size = MAX(s->tracks, s->prealloc_size);
>       s->cluster_size = s->tracks << BDRV_SECTOR_BITS;
>   
>       s->bat_size = le32_to_cpu(ph.bat_entries);
> @@ -1117,29 +1158,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>           s->header_size = size;
>       }
>   
> -    opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
> -    if (!opts) {
> -        goto fail_options;
> -    }
> -
> -    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
> -        goto fail_options;
> -    }
> -
> -    s->prealloc_size =
> -        qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
> -    s->prealloc_size = MAX(s->tracks, s->prealloc_size >> BDRV_SECTOR_BITS);
> -    buf = qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
> -    /* prealloc_mode can be downgraded later during allocate_clusters */
> -    s->prealloc_mode = qapi_enum_parse(&prealloc_mode_lookup, buf,
> -                                       PRL_PREALLOC_MODE_FALLOCATE,
> -                                       &local_err);
> -    g_free(buf);
> -    if (local_err != NULL) {
> -        error_propagate(errp, local_err);
> -        goto fail_options;
> -    }
> -
>       if (ph.ext_off) {
>           if (flags & BDRV_O_RDWR) {
>               /*
> @@ -1214,10 +1232,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>   
>   fail_format:
>       error_setg(errp, "Image not in Parallels format");
> -fail_options:
>       ret = -EINVAL;
>   fail:
> -    qemu_opts_del(opts);
>       /*
>        * "s" object was allocated by g_malloc0 so we can safely
>        * try to free its fields even they were not allocated.

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


