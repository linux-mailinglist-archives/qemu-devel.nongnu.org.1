Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FAA71F43F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 22:56:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4pJd-0003T6-Vl; Thu, 01 Jun 2023 16:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q4pJU-0003SF-5l; Thu, 01 Jun 2023 16:54:28 -0400
Received: from mail-he1eur01on072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::72e]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q4pJP-0000sx-Ot; Thu, 01 Jun 2023 16:54:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB2HMQYWdE+uqfCliws+KPY4rJDc4cYFaIi6dYb+V+qkiiOlHJjwNuqqWxbIs4Voqdwx4LNmKTCm4/CmDfE9df+vMg96mrIPH7Dve56oN5j//2xfAVnGSpAoYFu8REgdv+ndC1GBOxQTwKyc8/SktXI0TF6fdY0BcmQqOyR+N3eA9caUuRnHm4otsFMqFFrk1VhsvFBt8wVNtmweqejaesAJLn1wMpUbD2HY18K/FAnQMt23Jr+MT2pit/BP/PMMFwRKC5ivSHpgrTA4xoQKNir+gIDhfMu1W2u/9ctgcQvblJi5UYKiiPhyYHUkt57bvxB3vdDVIo7DKbxViR+BBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8jBdea61RJHUF8xcKN0sx2Ark7vZNnN3qvWFIrou6E=;
 b=ln1K3dRqcq+Js7N7VVbVBAHmrxr94FQhcDnEMx7P5ME97A52pnD7MNP5Hz/iIzT9akhO+c7mF7BV91HrjH0MMThOcH3UHAdJ2/BApyE+6UGCiXzunwkLB1eKq/ZiCvPjkJT3v1QjRd2atLCvaSMYPgxajp4sKYakspFh89yqCVv0vKRON9VNjWeb8G8Kt9DAtKfeBkLTlNbP30jkIzeMBcJl5AfmZQ3T+clHAEbE0X2gEMzVYtr733UW/svrpgIygWsQqO9s2DtbT4D/lIwigTpvprGzq9Iu5C+djHo9OtqJ8K0vED5rnOrlt8trIvy3qwCIjQ7xZY+X6cS/bAZF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8jBdea61RJHUF8xcKN0sx2Ark7vZNnN3qvWFIrou6E=;
 b=H+pXlExi/kFHTSD1xWuQgU11BqWe1m0WjlC1+nzht9bDKqfMRGk5SLgtR0AK/gYkCuQmYsVARHHQn1xaDMWqFm2sf2aeiH8uId955JvjKRkR6AMe+L48x6TNAJ/AxmzWFavO617eUNocdQrNfLQ12nnulGpbU/bgdLu4zz1zPR767qKFb6ys8RxZOG15pXgXAVqKUkH1LBdip0z1XZjb/+ICJW/NPga+zwCmlkWfEczuWnjiSm6S2K1Hbc21yrwgJwZPkapYlyk0XvB3bGRaGS/F3B2l9yJazyFhjKbUkA+bRmhlVdq7WbxNO/FNY7tu1Qy3uhYONmZxDbZt1V0K/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by DU0PR08MB8164.eurprd08.prod.outlook.com (2603:10a6:10:3ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 20:54:19 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::21b0:d0a:6ec5:11bb]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::21b0:d0a:6ec5:11bb%6]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 20:54:18 +0000
Message-ID: <f7322d55-4054-7814-4831-44ca55a1ac03@virtuozzo.com>
Date: Thu, 1 Jun 2023 23:54:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 0/2] qemu-img: fix getting stuck in infinite loop on
 in-chain rebase
Content-Language: en-US
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, shmuel.eiderman@oracle.com,
 den@virtuozzo.com
References: <20230525180213.902012-1-andrey.drobyshev@virtuozzo.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20230525180213.902012-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|DU0PR08MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 2842fcde-b879-4e9f-9fb7-08db62e25e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLwLT9PZbUj8gAgSPpqYC+KjyODV5gI0HR0VRbHJlDKmCAk1/8jhYBx6FYHEj0RwR+hmtIB+E3YJKDPFWNuVSVor80gOZGrqy1oXxwm+kUV5gSsW6Cu6/nKNr3DoV21BF+6gqDDYGLsP2xexd+hv0BqP8Jqrxm67gVmFZ49Glj+6mm39/tliATcWDgxVmCO7uIUIhsf2D9e384wKIvRHf1AsokcmY7W5QZNaodNYhPWkUvcE8rfn1zijwfyPL9y/VfwEYZmXKu5oqLT1moL1l2zdj84kyupBY5EIXi/unVPpMp1yujAPHWZyAjpb09DpmsCf0L0K9yiu8sLh3gdJeH+hryOoz+pxaAgIwHmQzmpztx5mN2ywefOu+s0J4FdIOVSSByF3VjxciTepcr8GtQgRjmQOkHBl748z62BZ32fJF5jAZrT9R3jF3Lp52LqvDcSfKmWVha6juedGkIuO1QKm47E3CJHcJvUZGH9AiEUpJYyC9JfE8LqCj94/6oZNm7U1FGBshMpBB1nKw4Y9AjqWVQa+YcxImeW+inHr/qhwDaaSbxyk2RWw6Hcfzyt8fevYSSkZeH+sJI3WP/BtOpfw7jvnBPNcqLlJSBRNNiePENzb1qupumoTrUzJ/+USn6j2RX7y4YKGy+v03fafAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(346002)(376002)(366004)(396003)(136003)(451199021)(8936002)(8676002)(5660300002)(107886003)(36756003)(41300700001)(316002)(26005)(478600001)(38100700002)(6512007)(53546011)(6506007)(186003)(66476007)(4326008)(2616005)(6916009)(66946007)(966005)(66556008)(4744005)(2906002)(44832011)(31686004)(6666004)(6486002)(86362001)(31696002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmc1dEVrTk1GQllvMG0yM3FTZXJnbU9DdlhrYUxKblFuTnA2bDVjZFQzQUt3?=
 =?utf-8?B?N004OVhKY3l2M2JDK0tuVzBxUElRTkc3S1dxN255ZWFiS1p4WHkxVm8yR21i?=
 =?utf-8?B?M1c4U3VpT2diVVBYcnB0ZlNSYWR4dk9uM0ZWQm8zSjNnZlhrZk1USU9Wd3Nz?=
 =?utf-8?B?cWpoVnhKaWpCWkZMelFoYWQvMCtZci9vWmF2THB2Qys5ZHJpSTVXSW04MnBy?=
 =?utf-8?B?YW1JdEgxV2ZFSDRRZWtuaGVOTEt3dFhuTEpEdFc1dWl3N1hwZ0NnQlFTQ21D?=
 =?utf-8?B?QlY1akJnV3BQVUJvM29nYy9KOWpYQVdiMjFXYk1uTmxNbkZjNVRTQ2xQSFEy?=
 =?utf-8?B?bm4xRm9ibm5kVk1mcFdpaExpdjRtV0FkR2dUOFZIR2Zydy9WRzNXY09qbmRo?=
 =?utf-8?B?Zy9ZQTJEZWdWZUorRlM4Sk84R29mUTNXV3Z4SllZRzBzMXZsdHh5ZmdVMUNF?=
 =?utf-8?B?ZDZtUXFxbHhFanh5cDlVRm5TcUNZVmp6VnNXZGNMRVJiRlVnNmxqR0FjS0N4?=
 =?utf-8?B?L29VYlpqNVN1K2RkYXQ5OFp3NmIxZ2lLR3VQSFdZQ1NXYzV1ZGlwaDdEc0N4?=
 =?utf-8?B?eGk4Mm1xdGRZNGM3RHpsbzdzeGdoNDloWUhVc09YL25JWDJGQ2xXaEpPN2Nx?=
 =?utf-8?B?TG9HZ1dCZXRQUUljemRiTml5ZkZ6dGNDaVVXTDhaWUtvVTM0alhkOTJtaXY3?=
 =?utf-8?B?SzQ1OU84SDNwUWJlNjZ5QUc3bWVMdHlsSVRXMG9HeFpmbWJiRWxGYXRkbFRm?=
 =?utf-8?B?a1ZhM0NzNXNSWER2M3pVS3dERStzS1VGRDNWVS9uM0ZXa1FsZVVXS0VNM013?=
 =?utf-8?B?eDFSeDF2RENmMGJXNkhzOVVDY09UQ0FCS2lwS3h1cWxiT3RjbTZYSDIvbU5G?=
 =?utf-8?B?NXIzeUQ3WmxFaklBanVPclFGUkpKWVVYZmJSMjBJYlIyeVdHZVlVOUpMN0VY?=
 =?utf-8?B?QnlCWDJyTkhzdEFGc1Q3a00vZXA3NWJYd0VpMVVEaEcwNUd1V1plaVZsYlJG?=
 =?utf-8?B?aXFBTjVlYUJvVEdXa1pGY21JUis3Z2hBYXhzMHdhelIwVlAxUWZ2SithbjZL?=
 =?utf-8?B?UGJUZlZwa3pZWEZIdGRITHA1aVhNNWk4RjlCQklUNlNwU2Q1dGw0Z1hQSXlL?=
 =?utf-8?B?WlM4cmFYWXlxczUveWVqWHBzRG1raStwU0hBT1BZejJZdzlPcnBVaVE4dExo?=
 =?utf-8?B?b1pFQUdsbHBQTTJuNmFzdVlYclJxYldQYk1OL3FqdnRJemlKbXdwU1hIcEdI?=
 =?utf-8?B?cGUwako0MXV0QzlacE9BeWVTcjVKM2NXN2JlemNSYUdQdkU5UE9wU255TEFL?=
 =?utf-8?B?V2tRKzVsdzJHY2l2THlSbGNYRkVSNG15c3Z5REZnemVTa0tXeFBkb1RCc1FG?=
 =?utf-8?B?ZG1IV1V0MTI3MXEwbEsxeng4bU13cWZEWC9IcEtBaXJCQU9aNTJxeGo4TXZs?=
 =?utf-8?B?L1A1aDRjZUswVWV2NmRldStuNFRJdDFFMTVZSGxuQnhWR2NyQ1BsSGhYdHJa?=
 =?utf-8?B?WUFVQ3pVd2VkUXh0TTRkcWVyaFF1QWdHaXRqTlZWeW4vNDlIUjQ4Rnh4UE9i?=
 =?utf-8?B?SE1xL0k5Tmx2dmNoZmRXb0tVSWRkQ0ROZTZtNEJtWjVmVUJCY1FpRzZ4ZDNK?=
 =?utf-8?B?TTdnNEZFTzk1VjB3S3NtcFFTNkNFV1NETE9SMXQ3UjAxR3o2ZVJWUnhveEpL?=
 =?utf-8?B?YVRZZTdvMHVJT0l1aXpJbFlFZWU3WXRWQ0NFT2NaUldKcFFXUFpUcW01NHdB?=
 =?utf-8?B?Ui92U2pNdWJxNGRoV2t1K05Md0MwRzlUaloyako1Wm8rNXlqK2J2cmgwNk9H?=
 =?utf-8?B?WS9ibVdyNW94R2JtTEpNS2NybjNaZkMzQlI3N0pDd3krYWE1Wk13Y0dDbEgw?=
 =?utf-8?B?dGpBSDdzNXRGdXJkNWZUOGFqUm50MTZqUkEwZk9iS3ZUbnc5M0tFTGk1R3VB?=
 =?utf-8?B?YXgwbW9yMFN0bEZnZkVqYm5qbFNzSGFzczNSUVE1RWdpRDhtMjhsb2dxbFh6?=
 =?utf-8?B?MkdEUThuNHZYSVFRVjNsYUpvYUo0MVgxZTZIOW1vQ3YzZjg4dkpuaHRqZE9W?=
 =?utf-8?B?UE80OXgwTFFpY29LUXU5djB0enYxUEhvdG15WGp4aUtBaUY3M3lEWXp3Qndm?=
 =?utf-8?B?UnRmV1ovd0RkRGtGTzFDUlhzeFRWVDZVNjI3UXhvL2hSVzRaYkozT055QkFE?=
 =?utf-8?Q?hQcA50taDstcl3Uno3F4rAg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2842fcde-b879-4e9f-9fb7-08db62e25e1c
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 20:54:18.6002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6NKTmI/FZAku3NmwCn3azN3Y004acwKXUIwMgpcD/hf8FJhlmsODxHd/FVXx/wlMHKuGVZQktZ1c7EKofO3u0fRKzKEzop29LDRlRa0mYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8164
Received-SPF: pass client-ip=2a01:111:f400:fe1e::72e;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 5/25/23 21:02, Andrey Drobyshev wrote:
> v1 -> v2:
> 
>   * Avoid breaking the loop just yet, as the offsets beyond the old
>     backing size need to be explicitly zeroed;
>   * Amend the commit message accordingly;
>   * Alter the added test case to take the last zeroed cluster into
>     consideration.
> 
> v1: https://lists.nongnu.org/archive/html/qemu-block/2023-05/msg00674.html
> 
> Andrey Drobyshev (2):
>   qemu-img: rebase: stop when reaching EOF of old backing file
>   qemu-iotests: 024: add rebasing test case for overlay_size >
>     backing_size
> 
>  qemu-img.c                 | 13 ++++++++-
>  tests/qemu-iotests/024     | 57 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/024.out | 30 ++++++++++++++++++++
>  3 files changed, 99 insertions(+), 1 deletion(-)
> 

Since there're no comments so far, I've included this same bugfix into
the bigger series regarding "qemu-img rebase".  Please refer to
https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00068.html.

