Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 383A47A4515
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:47:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9tn-0006kA-Nh; Mon, 18 Sep 2023 04:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi9ti-0006jF-Qe; Mon, 18 Sep 2023 04:46:27 -0400
Received: from mail-db3eur04on0705.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::705]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi9tf-0006vK-At; Mon, 18 Sep 2023 04:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm+ruHBAIbaF3UH3KYLwVAwh5lzLNCePNtvBWLV08deOIYtAk7O3wOXaeEi+pljeuL8773WT3D6l1CBf7zRcvQGS5+FtiMJ/5g43Xy69il1mOlbjKUBN/9dldCV4xqALXp6TFV/XN3/zFYlxuAcw9V6c56MVEOduws/+gDREaBO6PmsRttgjzFw1VaqitvJ9h0sACUDa635QQ7Qw9Is4Z1Z0PlKPZfUNDDEF0CnwhnvrbIWmIjf+mF63TMCCslVQjF2El4O10s5AlsrWDfKSvGTpa2EUECByoSO9SVrJFgg7XbzqEPoJSKJAytNY+RmqDv81JuBPYUcajIoifBVw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAAiprbYVWm4voiW6JjKOf0TE0O+YSlCSZShn+v2N60=;
 b=DILMBAu9LZFa/MrqXrLwcwitunpyUOUTt9zqWYo1PdyWMkLdEkDc3JxpA0THGnaSG+8Wu69tgSjz8cZ1eujSbcszi1mBTk2dYeBiS0rKNTO1Vci1b5KA0pMRfcjjMSKimuXgDwHB2+8C0P3r11ZpOw53ot6ttuIn/PQZG8xk3vnoHuP8yP3tJeCSkUsO9uS2D/Q2FB0PiwWChdC+94Xhf6zipjfmwd6X0WUXUfeGWBGm87sWD+krfVFIBN/GYwMc77LWoRG9przIFQtbpnJAEuVRMoyo2QMSusNZ6n1boTk2Ue/m0tce+X0D/rvL56msjLpXE7E+5uUXmX4g+cHofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAAiprbYVWm4voiW6JjKOf0TE0O+YSlCSZShn+v2N60=;
 b=FI16qJw0sfUiUUQ7HqLUvIu+yIYscQVQ5kmwEBg6yiCbbLekqe7HQrPBlGLITeLjeabe8roacEx86shthCeLBhnwQUJdH8MgUFjBedYrNwCgkmDgfsT61SHDO7kmIy4G7FGUjS75pG5T97+lntgfjPPoekCQD+ubJDvMwo+yEHwk5DrfYHWPOIB8cXmYJNgX65ckmwh8DA1LOYE6ek5D9gpEfrBqPGtwFY+8tUcVoDI9wdWlEQL+tHqd2zJSyfZIvXeQmCoHJpaE18e/w6yEYBEYXUBp2BYLrYQyW/D9iUruy5N0XNlZ+WzYJd9re6ww4Qamv0mO5kxDIlf/lg8atA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS8PR08MB8947.eurprd08.prod.outlook.com (2603:10a6:20b:5b3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:46:18 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:46:18 +0000
Message-ID: <dc4b53ee-ee94-f492-6c44-ec6d9d01e750@virtuozzo.com>
Date: Mon, 18 Sep 2023 10:46:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 07/21] parallels: create mark_used() helper which sets bit
 in used bitmap
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-9-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-9-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0046.eurprd03.prod.outlook.com
 (2603:10a6:803:118::35) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS8PR08MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: dd285f26-24a4-45c0-cc8e-08dbb823b9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSx+hcfxOghqMaC8wNUH3NmVuT0ADH2/yjaX4Y5wUK0hav8Zq5Jsl+ZO47jA9TORwTjBsCD2KE1ysvhRi/R8cezsVpmyp8r25TY73iDAczuSoMc+RQL+/M2nCU2DRjNw6pnh3ud7Lva2PyNZ1sjNNyqf20TODa1YExUtnpIeVKd5beQE1mGAEwGzeUe9JdDCPkgddESq2TTkn1vKO2zl5wYsP+nfEkAi6IEb7UxvZnMvJnK54xRO9swwGsr966DWB7TOxzI5m5I5LPQoM2q4nIEVT5y8FXUiKgXtOG/q9FIZWQAy/oRzQ+xpk82hAJYZBnzDFX6ngvVeqVbNV3/7bM2+BRyfOwK1jsqUC5c65UHfqg5ovpmRGlBmWjrlV3xkpQc24yTl9DXr1z5qpcPkNuGOUAbQr2RcE74aCsiXEVjgfwmkMUp3vlKdQhJLh64sKHwMD+H7cWLxxHHuJySX97ESzqoJcEw6mgFr3x365H9nA/lxv94KMvt/neTxvo9OMNtRieM1pLnzf/4hBSzjMnJWiN+SqAQ9DSACXeMyKCTa84KKVb4pi68l/5/dxc3woE8RxoQASG0pGKbyZhCDBB9WqxQ4UDL14wfEGeKZ4lOshFzkXa5vmeV205sI35sO5bRz6pYjBGozrfC71dyvrr/LaJaKeD1nZaAU/8G/AMZ4BJmz3YuzRJFaAgzpjOQv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(39850400004)(136003)(376002)(1800799009)(186009)(451199024)(66476007)(478600001)(316002)(66946007)(26005)(53546011)(6486002)(2616005)(6512007)(66556008)(6506007)(6666004)(52116002)(41300700001)(8936002)(8676002)(44832011)(5660300002)(4326008)(38100700002)(38350700002)(2906002)(86362001)(31696002)(83380400001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmlWT1ZHTDdYWmJmZWFWN3JucUhycCtpZXNuTE1GRUtxOTdmOWlScC9uSVVi?=
 =?utf-8?B?cDNVTmV3bUhhamkxS0xJS2dUNi8vd2FmdUh4WGxGRkxSVnBFMmozdWVFMCtX?=
 =?utf-8?B?MFUrVlNSV3lpMFM5bklRdnd0b3FnWDB2VmxSRVYrbUE3eEgzSzh1Ti9HMXBZ?=
 =?utf-8?B?bkFBMm8yWjFFUkJOaEpaa0hqMktjMmQ4UDVjV3F1bkh3Z2ptOVJSSFYyQk5i?=
 =?utf-8?B?OWNBaW4yODVwVktzSzJKSTJjZzg4VlBpZkpTaGFuWmxXNThXdGVCNDZUbHdF?=
 =?utf-8?B?Y1hKdzNPbm9lL1BSRlAzM1BGdnVyeVJndTBRSVp3OUYyOFVNeWd1QVpsU1hZ?=
 =?utf-8?B?cm4vWElEZ2lEQUJxRU1VdnYwY1RoV2M4cjhpYitYeWMrMkNhQ0R3aTNLNGxj?=
 =?utf-8?B?M05YQlRIenVKZHNKMitDbmpyM0FFa3NhaTVXR256UmR1cVAwZTJKeGM4MENZ?=
 =?utf-8?B?VFNPTGxLZDBaekVJb0VqWFI2aTlBQUFTdzZrT0p6Wjl6cTNOVjM4dkM5UHV4?=
 =?utf-8?B?NldDa2tNK0pLSDdYSG5Md2JRSGxPY3N0bXlYUzNsdU9FZHVFZlovSU51aTEy?=
 =?utf-8?B?QkdWQU9MRW91ZWpwMGdLVzhJUHN1cWs5RHp4UWd5NTFhd20xeXJ5Z2VLSGJZ?=
 =?utf-8?B?SG5aYTBUUjVGeEhkZ0oyV0hYaUNOUzZxTk9VVTJjaE5vdWJlUGRqR1dkeEh5?=
 =?utf-8?B?aEhqeW15bHdmbnRvSXQ2dnFnMnZnNDlacmt4Q1BkRTgvRnRIcnZEWC9BSTVK?=
 =?utf-8?B?djV6eVhQTHFQZ0oxZWM5MEZzOHNRc08vZ2hMVHpsbzhuQUh4NWx6QU1JZlE1?=
 =?utf-8?B?bkZwNnJiYWg2UDF1MjdqUmhnTGZndjJoMyt6L29FZFplTURTTGRXWCtMZ1A2?=
 =?utf-8?B?RmJlaGRCRDdSODlRTVFxdkRpSUxldlpHMHhvNGk3bXBqVVNPT1dNVTRFdllu?=
 =?utf-8?B?QU9wUFoyR1FJK2FyNFl1cU1ubTlkKzhKc1pmWnZSYTUvTlBPREtjeEhzWEhx?=
 =?utf-8?B?NDdRN0dYWk5vcjNrSEFMcWtvSXk3SVhFbkxickM1dEc0K2hLNEVoWHFRc3Bn?=
 =?utf-8?B?WHVlQzVkV3B6RzUxSnNVSEtZQ2FEdFFTU0FqMWNERlgzM0ZLSG53TG91Vjhn?=
 =?utf-8?B?Mm9aNUZIWlhRdjd3YVRXY3NKRXIrZHIzNXZaRm1pV29FRVVjek5LZXh3Vzc3?=
 =?utf-8?B?OGxGUFlhdy8zOXR2dDVtdE90RTI4dkxRWWtDVHVaNGY4blY4NloxRHM2czZ6?=
 =?utf-8?B?QjFsSGVHSGZnTXNLSnNjd1pJZ1NNZzl6L3lhbkNUQWRyZHIxMW5STzhpS25H?=
 =?utf-8?B?WnR1bGNmRTZoL3NBZXZpajhQZTVUVzg3dFdGWnRmTDBwRFgxUUVSOUZsMTRO?=
 =?utf-8?B?L0JUa2IrUXdsTG9YNGE0TFZOamEvb2c4SnhvWkV4WTBtMmRFMWs2UG9WNjZU?=
 =?utf-8?B?QzFSRm5CN0EvTGJJcU1lZzFVSGF2bldVZTBuZGNKQ0pPQTgvOWlwZlduemU1?=
 =?utf-8?B?L3BHZHJFdzF2RE5sMnJ0bU81RnBacS9mbTBNL0g3UFZLSG41bTRYS3JXekdo?=
 =?utf-8?B?RWpoYzY5UjVHMnA2MWpHaDNyOWtBc2NnSVY2ZGZBQWh6N0E3bzAzT3pZYXdp?=
 =?utf-8?B?NFhTVnRHZytUbHY5SW1DZ1N5Zk9SUG1OdmJoV3hxMHFBcUQ1ZVdVZVhHREVI?=
 =?utf-8?B?K29NN1N0VklmM3RreE5uY3l0N0s4L1pZRnVIZ05IMUVEbUQ3UTA1SGdralQv?=
 =?utf-8?B?dDdsc3dQOHF3RU9GaVZQdUhKanQrTkNWVEI1VlJKakxNNlFRMzFWTTVOTzFy?=
 =?utf-8?B?eWl1OXdLMjNwMmFSVm8ybVZSQm51c2hzdmRyNHZYSjN0dFIyRGFyUW1sYW1L?=
 =?utf-8?B?WVZoL2NPei93d0Rpekh5cWNva3lyZTFvS3UvUmtmd0UrK1hBdDJFOWZpd242?=
 =?utf-8?B?R2k5WTlLSkFCQW03aExsM2pDRnNkZzEyU212Wm0xUGhRQXZzWVpvTitoSVUr?=
 =?utf-8?B?Q3RRb2J2Sk5mU01uTUtmRnprZVRMSzRZREhNSXZMRVhYaVpVMXdNTjlZaUhH?=
 =?utf-8?B?cHFIL0crbkd3LzdnMW1IYkdJMTN5aE1NaFB5bHNjOFM4ZVlLRllUMW85dm1a?=
 =?utf-8?B?U0pndTdrUStqcTVuOHgweGhFUXVjV0FnU2czRHIzbkkyUEZneFlCckFFQmdI?=
 =?utf-8?Q?5EXDb+5wx4bQhlG3aPjhFXw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd285f26-24a4-45c0-cc8e-08dbb823b9e6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:46:18.6482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAMBRddYM/ftuvVLvpYJ3PV/b7atBbQQRuwx8+3ZcMOdYnsGhGGq7zFojtkXwC3ECrdqfNRi8Y35lq29HHHb/+CsbpJwdGp6/IIXRea67V8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8947
Received-SPF: pass client-ip=2a01:111:f400:fe0c::705;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
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

On 9/15/23 20:41, Denis V. Lunev wrote:
> This functionality is used twice already and next patch will add more
> code with it.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 34 +++++++++++++++++++++++++---------
>   1 file changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index aa29df9f77..60ad41b49b 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -178,6 +178,21 @@ static void parallels_set_bat_entry(BDRVParallelsState *s,
>       bitmap_set(s->bat_dirty_bmap, bat_entry_off(index) / s->bat_dirty_block, 1);
>   }
>   
> +static int mark_used(BlockDriverState *bs,
> +                     unsigned long *bitmap, uint32_t bitmap_size, int64_t off)
> +{
> +    BDRVParallelsState *s = bs->opaque;
> +    uint32_t cluster_index = host_cluster_index(s, off);
> +    if (cluster_index >= bitmap_size) {
> +        return -E2BIG;
> +    }
> +    if (test_bit(cluster_index, bitmap)) {
> +        return -EBUSY;
> +    }
> +    bitmap_set(bitmap, cluster_index, 1);
> +    return 0;
> +}
> +
>   static int64_t coroutine_fn GRAPH_RDLOCK
>   allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>                     int nb_sectors, int *pnum)
> @@ -621,7 +636,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
>       BDRVParallelsState *s = bs->opaque;
>       int64_t host_off, host_sector, guest_sector;
>       unsigned long *bitmap;
> -    uint32_t i, bitmap_size, cluster_index, bat_entry;
> +    uint32_t i, bitmap_size, bat_entry;
>       int n, ret = 0;
>       uint64_t *buf = NULL;
>       bool fixed = false;
> @@ -655,10 +670,9 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
>               continue;
>           }
>   
> -        cluster_index = host_cluster_index(s, host_off);
> -        assert(cluster_index < bitmap_size);
> -        if (!test_bit(cluster_index, bitmap)) {
> -            bitmap_set(bitmap, cluster_index, 1);
> +        ret = mark_used(bs, bitmap, bitmap_size, host_off);
> +        assert(ret != -E2BIG);
> +        if (ret == 0) {
>               continue;
>           }
>   
> @@ -713,11 +727,13 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
>            * consistent for the new allocated clusters too.
>            *
>            * Note, clusters allocated outside the current image are not
> -         * considered, and the bitmap size doesn't change.
> +         * considered, and the bitmap size doesn't change. This specifically
> +         * means that -E2BIG is OK.
>            */
> -        cluster_index = host_cluster_index(s, host_off);
> -        if (cluster_index < bitmap_size) {
> -            bitmap_set(bitmap, cluster_index, 1);
> +        ret = mark_used(bs, bitmap, bitmap_size, host_off);
> +        if (ret == -EBUSY) {
> +            res->check_errors++;
> +            goto out_repair_bat;
>           }
>   
>           fixed = true;

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

