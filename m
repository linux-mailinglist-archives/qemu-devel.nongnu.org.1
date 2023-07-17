Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 689CA7568FB
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:22:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLQyX-0001QE-Cj; Mon, 17 Jul 2023 12:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLQxk-0001Pu-Px; Mon, 17 Jul 2023 12:20:40 -0400
Received: from mail-am6eur05on2072a.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::72a]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLQxi-0008A1-ML; Mon, 17 Jul 2023 12:20:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GalMv+RozYmjFliqA/ERXFWk5koposffMq3TlGmEpWX2g34nx5VW6fhZUn7C9RZcqIyEH0s2pxRCWCK3PdfIsVFsOmRVhfmDW+Sp0H6k5CHXkuGU2Opy66atmSOaON1OaN5G3j1fBf4xCFbokCBH1dcOBL/NF2wYi9MKeRwk4Qo2PYW0b6kFHRUIbtX4JuhJ9LUe79U3ZfNQgNpDK6ES87YOM51jSYODlm9txsPsVH5U//9aXK1xsZnR+uYp/+v/ZhfyJ7iF7u2lbeZW9q3NfluDr+H8+m3/CKbhnyv0CjYQzcJMM6y4nC9Bu4ZbLoWogeLPE+39b/xlCSbc/lQKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12tr8eb9u6LrIAZncTdPoLu02sOmnEMqM8c73hi/STM=;
 b=Y1WZ4EpoYLKjRRCXWHAupAbCCDAqkD8fvwTuh7irybc8hfkqdWJPpzGktusasL2LR5RkzLBwVVy6HSev6oa9yWuzr3aqQF4pLeaOc8qCAIetsTZk4G4jpzQvl5S3CoOjtZsADF9Q4eRxecAomhNgWzBtLfwUuiM5+bZhvIfz5fbbxWMdmx6BvzJiic2FeQsDCtvXiHugxAYhb0fwgywmqTsOsEaGUMjy75d+XTB3J28N7qAmvAciSDpt/4igHKAOvkxXF3ZfrhICnreaph96lW9B4RiVdgCYGRZf46qyyeMeYfrIcwadeG0q4SyYeRFRJkBG5S722vGPtFksj76/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12tr8eb9u6LrIAZncTdPoLu02sOmnEMqM8c73hi/STM=;
 b=IW5TePiBd020Rnc0ivoy737wwcldaYt0IlCmEIIi7bvErD8ryp2OtyMEHSFuRpmoVgHj4LKgBz2bD2NdYQkYb3/KdU7kOh85CxU+cr7b5u8dZXjkSd4RQoIwzB25K5+h4/cXFIpdCU1iD2zI9egQoPYVAYaYBexjkZkNUUa83psankC//7REXKrlsEXnJ1ZIwKYloHx5W+46ABvwd68UFQftHyTSc8bt4odp5V+sZ1aksk2ZMgLrX92n2+ZeCxW55U7kax9Us92CMuUQP8dCJ0mSDKqlm6/2tTadJUe2U21LQH3FslSVJb+tWZEMUnPV9Go8Y/0DO4z+nR9Gh206pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PAWPR08MB10136.eurprd08.prod.outlook.com (2603:10a6:102:34f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 16:20:36 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:20:36 +0000
Message-ID: <9ea37ac8-0e12-6f78-84ae-5a58a417d867@virtuozzo.com>
Date: Mon, 17 Jul 2023 18:20:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 3/8] parallels: Add "explicit" argument to
 parallels_check_leak()
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
 <20230701100759.261007-4-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230701100759.261007-4-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0022.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::27) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PAWPR08MB10136:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c90e509-5e30-4785-7f7a-08db86e1c08e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWLcGQo1JY0LJi4wS/7jLCdnvjgyOAVx/7h8JJE5wGF4d92+fuHVY9LvwBkVh5RYVND8aUxPZDrT0ukqem3uzf88ZeaFZi2X78osTI06FOCf29LURUIMnR04coqcVBasE5QRxKJ7dDoP6RRo1lHTuOC/gQClbjl5s7X3LJld8hpuZQjTQqHTAOhiOyPW7druJ8ZEc1nb6afiB2aEGoOUsqmrYdaUt/PDXDaPhq/B6UKKl21mEXI7RmSohYvB4/BsY2m4iRehqhaig+U9Gkn9mY9FqJMuiNEigxnrrBYat7poD8Hwsi5H6UiBFQG/C1/Sy8ghwKmOT/BF5MN4Mitt0nCpEbSMfn8TorcY8IzbJQU9z9/L2rS62tnUVV7G8z2ifdvBKTzIwlAmUjMYYOKM1mFM9ZsFqxCc9T18PIEFcU0tPWp0KelRQntZ7GU+Ti2E7zHSX6JG6goFDq1TLZ+dhUtMnbkuvTVTM9s5+/ynsF12/BpFL2Bwgi4TC184zQaf1dkknFQyFB97P/egJfukQYc/BsTSeHP4XRsAsyS5W1ejfyeLN5LJaiSe2K33j/pq0qmKfq6E0aAZwHO816fiObSwes640yMu1HVhuaIOWpIwkDd7PIwqh4ZUDh+Cdtw2ppKYOv1lTx8EAFcr9Y3Jfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39850400004)(366004)(396003)(451199021)(31686004)(6486002)(6666004)(478600001)(83380400001)(2616005)(31696002)(86362001)(2906002)(26005)(186003)(6506007)(53546011)(6512007)(38100700002)(66476007)(66946007)(66556008)(41300700001)(4326008)(316002)(8676002)(5660300002)(36756003)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ZPOXF2NnZ5eThuN1dIV0ZjaXcrOUZWaXZwQUVRZkp0K28rSHZTUFJ0R1ZE?=
 =?utf-8?B?RW02QWI5elBadWpkK3pUNzk4Mmp6UGwyMHUzdFg3RTI2bHFGcFAxcFdwQ21k?=
 =?utf-8?B?QjdmOXNuKzVpc0xIcW1CMGNIT3NTaXUzRm5va2R6Y1Y1Z25NVjNOUnE0TXow?=
 =?utf-8?B?MEVCLzd0YVFYaEtEVjNxdXBVa1hzMitmcWZCemE4UVVMYmlHUWNkMml0Q0pu?=
 =?utf-8?B?VDJudzJORXV6dWNJMHllL28xUktRVGlzVGVCYnd2SE4rcjJWTVNjK0pPNDdl?=
 =?utf-8?B?VkVRREdORExSdTFyUGJGWVo2SDJybUFpNkR2Vi9Rakh5blpwaVFNbnIwTGcz?=
 =?utf-8?B?YW9GMjR2b05Ta2Z1TVBVdVo0Y092UjJWdUU0cktqL0Y4NTEvN0x0UnRyODdt?=
 =?utf-8?B?Ty9aQVd3c1FoOG5CL3Z5MWNnamVDZUl1bFlyckpIVDlQUXhkVUc4SjUxTkx4?=
 =?utf-8?B?N2JQSmdUWUptczI0NnFneTVmVVVUaGFuUW1OaGhIVlpESkVPZFlnMzlTeCts?=
 =?utf-8?B?YThoSWN5VEVpQjlnUGdENmRqSEQxNldFbVZWVEtMVDBGQkxtT29VemoxbHB3?=
 =?utf-8?B?b0Rna1BrMWZqTGtaMjFEUTZDQmI2WDdaZEZBeXppYTg0MlRHV08zdzlNMTlO?=
 =?utf-8?B?UFVrZk1ZMkRwTnVtVTJLaWE1OVdEcDlzNldpSlJyN1hmMHpUVEFOR0R5NTRO?=
 =?utf-8?B?dkRWd0NFMjRWQll6SzlGaUwwTHg2bmwzRllZcjZkRXAwWll3OHZuZWN3aHhm?=
 =?utf-8?B?bUZ2ZVBSZ3AwOFRndTluaWltdGZCUjdZNUdkaU9ucldqdHBjT1VqWFRhRUIw?=
 =?utf-8?B?L0hWV0JkbW00dTBBdVFaRTRmcXE2L1JvSzR0OWRnTjBBYjN1T0FLLzRBdzJp?=
 =?utf-8?B?WFFIaHpXc3JMZVhWN1JjZVZ5TnhxQXZjN2NXLzlWazlSNnhxVytVRE9BVjR1?=
 =?utf-8?B?YS9oY3RFMlFnMVdNTDIvNFE0NURVSWwzWjR5TElpSDJ3UG44R21TNUJIL0lx?=
 =?utf-8?B?MUlvaG5Ya0hxZjdlaGdVSUN4azQ3dmtueFZMcy9VSnU1T3g2cHhUSzcwVjdQ?=
 =?utf-8?B?VytUOHRIMnNrMzdiTjNpUjdrRnNGc0RTcTdYekVxckJPYWxsWFBPcWMwL25s?=
 =?utf-8?B?Q0t2bktaYTVCREhrczgwdGNCWGNLM2hoRE9DSVVWdFRRRU1uVEhtV2EvRExI?=
 =?utf-8?B?azNRelM3ZnA2bGo2aVFvV1VhVnloNFN5NGRhNkppWG01dHVhVmdxYVVMQmV4?=
 =?utf-8?B?VGh6cWtRNzY3Nmx2czR2ZWxBK2laTFFkN1dGTnZ0N1MrUnhTbkNaM1c5ZnZR?=
 =?utf-8?B?eXN1NkVtTzQzZ2dya2lMa1hzMDExOFlpRDZPdVBYSWl1cVBJWG5QZy9sejhn?=
 =?utf-8?B?UHZETkk1MFQ2d0V5S1o1YlQxYmVIeEo5NzJ5ZlNEZUpQZmNTM2lEV0JGbVNP?=
 =?utf-8?B?UGZReDNlZVRTdDMzNG5UMnR4V0hOVkhyVVJyMUNtcERsRG9lS2ZIYUs1cDdP?=
 =?utf-8?B?WS9KVkkyd0J3bXg3ejk4Wm9XTDl6SlBoTnJrVkFtUnowYll2eTd4dUk1Q1Qw?=
 =?utf-8?B?ZU1PaEMzSE5OQkJiZTFCN3VDRndNZHl5YzJ1SUtoM2cvOUxvNkJHWk02ZzE4?=
 =?utf-8?B?NDM3bHFWR2g5TkNReE8xek12cUVNdVNGSER4WDJRNUJRTmpNK1dBNHlFL1Bx?=
 =?utf-8?B?L0R4dHJMVm8yL1V5djB5eThHWVNFSkNxNFpaUkZEVTA5MERXOWwzMG1QeWxN?=
 =?utf-8?B?S1VsZ2lKeFFJUktOSHpCMWtMU0JQOXZ6T0R0OFo3TXhvck81WUk5ZXcvMm9q?=
 =?utf-8?B?VWtIcjNOTzdLcVNaeURINzZiYzhCb1RobWhuaWhLWWRjSTJOdHF0UFlnTWtr?=
 =?utf-8?B?MzBkbmFJQVlyMkpzUFA3VzdpbkJ1c0JLS1YyTUpDdlRqUzhjN0hvbHpaQ2xv?=
 =?utf-8?B?Y1BhYTUvaHVRNCtueVJhcG1XaGlYRURqdDd4Mlk5bEJwYU9wWFd5WkpxOTha?=
 =?utf-8?B?dzFjb0QvbXNLWnFRSnZkUzc5QzcwdXBKdHluMms3cUFQc1NSeDJKYTJzeVdH?=
 =?utf-8?B?bDFTUGFtMnBJUUdrTTNia1VVS1Zjb0VpM1NLZkZKZTVTNnBTcnV1dXczNHRP?=
 =?utf-8?Q?ebmZ8kVnJDxWei3qM/ZROj2X4?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c90e509-5e30-4785-7f7a-08db86e1c08e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:20:36.0715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tr2FidzPlGHAaQctUQN5DWCQqhRnSbNVAjbdeCeYGhS0tifsnWTkCnO9m8pbjUxAxQc6DrqcTIstcO3fAI6lMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10136
Received-SPF: pass client-ip=2a01:111:f400:7e1b::72a;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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
> In the on of the next patches we need to repair leaks without changing
> leaks and leaks_fixed info in res. Also we don't want to print any warning
> about leaks. Add "explicit" argument to skip info changing if the argument
> is false.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 40a26908db..3cff25e3a4 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -484,7 +484,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
>   
>   static int coroutine_fn GRAPH_RDLOCK
>   parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
> -                     BdrvCheckMode fix)
> +                     BdrvCheckMode fix, bool explicit)
>   {
>       BDRVParallelsState *s = bs->opaque;
>       int64_t size;
> @@ -499,10 +499,13 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>       if (size > res->image_end_offset) {
>           int64_t count;
>           count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
> -        fprintf(stderr, "%s space leaked at the end of the image %" PRId64 "\n",
> -                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
> -                size - res->image_end_offset);
> -        res->leaks += count;
> +        if (explicit) {
> +            fprintf(stderr,
> +                    "%s space leaked at the end of the image %" PRId64 "\n",
> +                    fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
> +                    size - res->image_end_offset);
> +            res->leaks += count;
> +        }
>           if (fix & BDRV_FIX_LEAKS) {
>               Error *local_err = NULL;
>   
> @@ -517,7 +520,9 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>                   res->check_errors++;
>                   return ret;
>               }
> -            res->leaks_fixed += count;
> +            if (explicit) {
> +                res->leaks_fixed += count;
> +            }
>           }
>       }
>   
> @@ -570,7 +575,7 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
>               return ret;
>           }
>   
> -        ret = parallels_check_leak(bs, res, fix);
> +        ret = parallels_check_leak(bs, res, fix, true);
>           if (ret < 0) {
>               return ret;
>           }
Reviewed-by: Denis V. Lunev <den@openvz.org>

