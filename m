Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B25ED738E85
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:23:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2UB-0003X5-VQ; Wed, 21 Jun 2023 14:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC2U5-0003Vi-QV; Wed, 21 Jun 2023 14:23:13 -0400
Received: from mail-dbaeur03on20703.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::703]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC2U2-0005v5-PP; Wed, 21 Jun 2023 14:23:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnfdVCrzSOsiBEB2kvu4fCmsDhAaqCoeG1SfhqxeQdTIEf84kNpe+AapQM9A8UeKH7Ol7uXd/tmCWvlF0BAFyVtNRnSE/fBYE4Z37e+6yyw+vWalw0ScZ+U9w+Ys2Vgu8nf2ELyN+1DTtxNEkv0BpGl57YnNJMyeFip+WBvjmi3k+63SyOIjLDyKivAjeS5q1z75aPeJXfpCGPzgZM5+b39y2qblc+6k8sdBWr7Y+pYO+xS2CqfEfNEJHzb/KcP+oPUCdcW/HwueRD1aUowSoYiPsUM566i3dbKhe+LsTsGs2w4MCM85b5X3NNg1YoSqUPJBItrkY+NDLDgp6omDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJ6xG5z2ZCnIWZ7SjL9QFYALWey3cIQn31NcRMp4zJc=;
 b=mCB+NFsOntee7rF88UlI/NvJbEvX1kzpuqTeimvacfHnyK87ievC3aNFZwp9bQJaHUJ/CDaV/MJWTE49lEqySisZ13ZK2CvpR7oS0QokVWMuKuTk9xU0lPD9SZBQ/8F7E1ga7bszAFV6LjuYNeuUj+/BwO32ix4ESp8Kpt/N3qN6csJncxpb3CJ1JmDlkr83KRO0WQk0sLbiTbABMGWVhTS7iiYa+HZoHiNNtetXgDtRyZDdFqM0u2OV4sxms5oetG3V4wJrT8leVVEH+uxylpeIKz/SU9IqrrOG3Hrr5mVNN/IDmFDO39cpt0EtPij+oxFh1XOSvexfCrtDObOTLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJ6xG5z2ZCnIWZ7SjL9QFYALWey3cIQn31NcRMp4zJc=;
 b=PH64NyVYewUKSIEhOfZ0P8a/ytTxL63LReD2D+VHeJo+A5hkj6679Nfm1hyKdjBVane1SNUyqYEmivGPaKfHwMfFT89DodoIlto57BS20AqQCztHxAkEYQoll0haR1iCLgAfCIT2ry2t1M/3fLhpb0JKxvgI0IBYEmmKWAihXnTpGwoNSihW7U13bcZbMolVyuBz7SQpY+f+buY5Lfkv4UXw1Nf3gjajUg7hhoJyZZNGwj0g+Rz0pe2vl7LxOMBcDbYeyE5EBwVtEsRxpY9SRk0iIsfQZCG0bTs/W9ERsiD/GgsIL3q0Ph6B3GJzzNv60qIkpLOF+WUxigmUDZOCSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB6946.eurprd08.prod.outlook.com (2603:10a6:20b:345::17)
 by PAWPR08MB9806.eurprd08.prod.outlook.com (2603:10a6:102:2e2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 18:23:06 +0000
Received: from AS8PR08MB6946.eurprd08.prod.outlook.com
 ([fe80::1e80:70d8:d23c:9b65]) by AS8PR08MB6946.eurprd08.prod.outlook.com
 ([fe80::1e80:70d8:d23c:9b65%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 18:23:06 +0000
Message-ID: <01acc84d-bb0f-96f1-25c9-d80ad1bc416f@virtuozzo.com>
Date: Wed, 21 Jun 2023 20:23:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/6] qemu-img: rebase: stop when reaching EOF of old
 backing file
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-2-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230601192836.598602-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::39) To AS8PR08MB6946.eurprd08.prod.outlook.com
 (2603:10a6:20b:345::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB6946:EE_|PAWPR08MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: a44bbc91-9077-4b36-7e19-08db72848f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxDm8fxVbcwLsQIbtmxa8XKLiRYCXn7nX5Qs5u/nPbX6fn6RviOOrCptZDqun38+/skEAnb8SFKFfnC4HP8T3oWOJxVl7nMID08ni9MqF+FZTuYrIVeXphyHLk1UzBdVpknJAVmyqM5RKspz+NXCRuDA4r4Auxx5vZqrXnHMHvA2kGBfjKyZ5cR+EmG+RTDshMVLnKfKhQkhvYx8NmMRMb+Gwn4PKB4q64FS6KoBQxJM4CuxWzhM+PQuOAyvHQvXVYgvrkqNUuzDQMUnT4u8mNwiRPji4CJGMcIkZKAzyb5KI3jR/PYn3pUQQwiAzCMG9RRQhrFA/qOF2n487MZ93uOb3Wq9NOB0E1GZOPWhhwaYU/59LCgGjskGC9takff23XtyGEowgTQHUQNhiEFciTpPHjy7K5dAu4kFEIIAYAh9d+ktnrRZW4efFdzL+D4kqnteJBUR4VxVid1CmyO5FSQmMRQQukjStVPHvpr/h0ZccMBMhX1jovIMPwx6wRYnWzkNHzMcl/Ku1fjAHMWoG0sVfGhFnCuAh+LTwfHXdEjgbLn7QOfg52bknu8E0oHX0vGSLElrTjQHe8KpEtNzQg2uZwwGJKzwq423y917co7Aqg/QK+qxIhrf6SpuyO4Wkx1qXfDfYIRoDDsF8veIHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB6946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39850400004)(376002)(396003)(366004)(346002)(451199021)(5660300002)(31686004)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(41300700001)(2906002)(6486002)(478600001)(26005)(53546011)(186003)(83380400001)(6506007)(36756003)(2616005)(6512007)(38100700002)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFNvenlGR0NBT3liZTE0bWU5QnJSVUxPbXVoYVpsVHNoY3ZGcWgwaUEwREor?=
 =?utf-8?B?NjM4cnRwTHR6bEdyb0cyd2d6RDdidHJXMCtFSTMxN1ltd00yeFZXWVdacXd5?=
 =?utf-8?B?YWpUbEtta3NQTHZlajFZa3hBSmhZUUR1ZlVHU2VycEJGNVBFUXJEQ1RVa2ov?=
 =?utf-8?B?MXJIejc2MDhQU1ovY3dUaWtGcm1sVU5DTU9YRUxvUGd1bTN1MTZUUmZvd2Fz?=
 =?utf-8?B?czY3R1ZlekZ1OUxkeXgwWU9qajJZM0ZEVTR4WmszMWZ4QWRUYnpEblRQNTh4?=
 =?utf-8?B?VjR4ajNmRndIcENkd08ycHo2dnBnU3E4aklIS2JMZDYrMlg1VVNQcy93WFpC?=
 =?utf-8?B?Q2hkZkJwWStCRkdlcytZeHBETktOTERxb3RTVUUxNFZsTjNoL2tncVlPUnpM?=
 =?utf-8?B?NXlmYWZsV0hWemVnSEZZRXJ2NzA1TnpTQWhMdkwyNWN2VFBEaHhCR0VtaWl5?=
 =?utf-8?B?NXFrVGRmdUw3Y2FXSWdEeVgyV2JvWlZ0cC94SGZxR0FvV3REUlpHQWdSNExu?=
 =?utf-8?B?UXpJT3BscUdVY3lMWUduQk03blNKV0lrY3ZJU0ZDZUtkRitzcW95WkZNbU5j?=
 =?utf-8?B?a3kvandxcWpWWXhJVnhRdU4vYjJKMVl6VjR2NHBPS1JwWVV6cTBiWHZRb1Jr?=
 =?utf-8?B?ekx6K2pXajh3UWpQbkpwZnI1ZGc5Tko1Y2V0QVRyOUw1RSsrUWx3ZElaeFV5?=
 =?utf-8?B?YVlOMTBPZGRwU20rOFJlbkZMOThWQy9rUXQ4dlFNUTdOMmFxcDI4VkdqYUtx?=
 =?utf-8?B?WW5wTDhsKzJaOEY0YmsveXJDVzRpZWxIdWdpVndoVUQwNEozRzlKLzV5K25R?=
 =?utf-8?B?aUEzSFNyd1hGV041U2dZdGlWRWxXNSs4OE9JMG1xbjYxakpJenpMZmhHSXp3?=
 =?utf-8?B?bWY3VWVSbG1mZUJzbjhzbGxkdnlSd0xPUUJBMHhGS1BrNVA5SVdCVUx4NzE3?=
 =?utf-8?B?SitucjFrZ0RwUmw1Qmt2N0kyZ0o3S2RRd21nczJSOHFFRVYzZHdIak50M0NJ?=
 =?utf-8?B?K1hOd2MxRWFzVUNGSmFZUmF2eWpKdzV3UllEK3RxVXJtemorejltYmt1SGhl?=
 =?utf-8?B?cmhzUmFJYkJ3cFdadFpHNytSN2hPK2NJZHhzSmU3N3Z6Qi9aUXhGTUFUbnRo?=
 =?utf-8?B?SThLZTRzT0R4aFlZbEhBc25mbjY2SFF0clh1SmxoVkhOcjB2SXkyTE5KQkFt?=
 =?utf-8?B?QWhrLzV0T2FxWk5oVmFtNTZSQ1EyOTVCeXFEWndNWHB2NjFNYVFHZnhPb1JT?=
 =?utf-8?B?b2E1RVRFY05jZmtqSEZMdXhmOUtiWWNOWnNlSzQxQ0hFakdyVGlydWdIRVlp?=
 =?utf-8?B?OGs2aHhRTEx0Qlo2Ukp3K1BkaEdERlBCQUx3NHVRbHRtTGlpeDNvRVlMTGI4?=
 =?utf-8?B?ZENnTDhHV0hCYkxIL3hJQ2FpTVNGTjFTK2x5alZ2K2p6bzYxNFUvNG5LT3hS?=
 =?utf-8?B?MGQ1TVBOR2RRVENoVm5jcGNFNFZTUjZCUjlqVWlLWS9rUVhxNllaTDhLVFEv?=
 =?utf-8?B?VWNuL2xQazRUd01GclVzci9rZnN6TWZlRHNiTkQ4RXNZQjY2MDhYeGkyRHIx?=
 =?utf-8?B?ZDlUSE1Kcm05TzVJWkJRdWxpcng2YXAwaWZKaVVUYzduQ3NucE9YSzhEMGxs?=
 =?utf-8?B?MWFkaExZdTR6SzIrMUp1ZGZ0WGRlSHpIR2ZXMnErNi9lbmRXdkFTT0drSnl0?=
 =?utf-8?B?NFpGNTJ4Q293MDM0VmxmSXpoTnNULzg3VTZjY3hqYVRHQTBpYzRqRnpQRElU?=
 =?utf-8?B?djkzSHNuamFWQ3BVQW9HcFNlbUFHcDI2eTVsRWdRbGhaWS85N084S09HbXB6?=
 =?utf-8?B?U3pyVExzVHRoS1A5dVAvYU11Z20vbDU2M0NwRGV6bnFtZlJTOURMdUtrYTJ2?=
 =?utf-8?B?bFhXSlRNZUQxK0NVQSt4dlg2K2dNR3RkQmNPQ1A3UUloak0wY1hoNlRGRVZ0?=
 =?utf-8?B?b0VZUVd2OS9GWDl1bDhuZzRmanNkU2ZTbDF5NHoxQkFBRW9JWDFYMjErVm50?=
 =?utf-8?B?dVpseUttOTYrMlI5dUpGTHZmMk1qc1FZeHpmc0hBNERXa0ZGcUlHRk9QZzF2?=
 =?utf-8?B?ZDRiNmRQbnE2SzB0eWhzbHBMKzR1S1NLYmRkbVJPRlN6dEs2U1dqVEJJclFw?=
 =?utf-8?Q?EO+dq6Pw/YzvCsXU9Hok1zVsQ?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44bbc91-9077-4b36-7e19-08db72848f35
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB6946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 18:23:06.7997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0XbiIIRlWHaQMRci9bV8hdagNeHUuc65cUmi0wdGxFSzG5vWDU4rdjNtZrhO65vVWrflOLNVyk/KydBK/ecAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9806
Received-SPF: pass client-ip=2a01:111:f400:fe1a::703;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/1/23 21:28, Andrey Drobyshev wrote:
> In case when we're rebasing within one backing chain, and when target image
> is larger than old backing file, bdrv_is_allocated_above() ends up setting
> *pnum = 0.  As a result, target offset isn't getting incremented, and we
> get stuck in an infinite for loop.  Let's detect this case and proceed
> further down the loop body, as the offsets beyond the old backing size need
> to be explicitly zeroed.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   qemu-img.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index 27f48051b0..78433f3746 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3801,6 +3801,8 @@ static int img_rebase(int argc, char **argv)
>               }
>   
>               if (prefix_chain_bs) {
> +                uint64_t bytes = n;
> +
>                   /*
>                    * If cluster wasn't changed since prefix_chain, we don't need
>                    * to take action
> @@ -3813,9 +3815,18 @@ static int img_rebase(int argc, char **argv)
>                                    strerror(-ret));
>                       goto out;
>                   }
> -                if (!ret) {
> +                if (!ret && n) {
>                       continue;
>                   }
> +                if (!n) {
> +                    /*
> +                     * If we've reached EOF of the old backing, it means that
> +                     * offsets beyond the old backing size were read as zeroes.
> +                     * Now we will need to explicitly zero the cluster in
> +                     * order to preserve that state after the rebase.
> +                     */
> +                    n = bytes;
> +                }
>               }
>   
>               /*
for the clarity:
Reviewed-by: Denis V. Lunev <den@openvz.org>

