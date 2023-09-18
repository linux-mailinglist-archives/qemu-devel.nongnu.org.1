Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2C17A444C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:16:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9QE-0006eh-0x; Mon, 18 Sep 2023 04:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi9Q2-0006dK-Rq; Mon, 18 Sep 2023 04:15:46 -0400
Received: from mail-vi1eur05on20715.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::715]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi9Q0-0001RX-PV; Mon, 18 Sep 2023 04:15:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTLnxJc0wxgWSVGXZ5kyRrNSUnxZpdo2k+1qs3NCOoMZeLDfJiHYszDRlfU/hgvE666ynadHuT3ABm0ADAB0ju1VIGaFLgKl5Q4rqESKSMqf4vsOBzwQvoRBUPDG90/gLH+pXbYkVLAF7iLLUEx2DQcQCV4nNh0aZ8heE/4pgoZLctiyoX3wT3/nRdGWO689JeRYNtuVS6MujyQIGzUSy6//W/fIft1LWbDA6f0n49p/4iOGSPDSE3irQUZH8Zlm5fqEx0PEKGHf8F7bt0oIIPVxJV0KU5yR0JcNpeRqcenTVupXnv/c1BC9vP71EKMHeKWtUt7hVUQfv2iz1I05Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hq5KfUg0aRWx2AdmDGqJBVdXyTGbqpXa1MozM22cjp0=;
 b=LXJ30Mko3wrG9FX0E8kc42A0dnh6Z8CZIa23yxNHdU0qkF+oXdS5i6tx4mL8LRh1i3qVPBlT8hJtZdpxTWRbejpF12UWqn7zubvnQXYfPIJnMMcPv8aXaG92e5BbzKd3BghhZlhvWqPPzoVKiomNQOMCuvH8qwii2gTp3OsnDIIUFA2lk1U/u1f9U+b5cQNSCkQU88cEs6Pg+RdOVBKEswuU1ZqZKmnejM1V9p8JYAVCiW2b26AS/mjwZhEwdNknCV5ap1JeYTIDUeCsFOqFO4CXoWwG8UhG1sdRBQ/SXADqp+9AUzOa4215aho349i8HtHGfJkjeCVg8mBGixUU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hq5KfUg0aRWx2AdmDGqJBVdXyTGbqpXa1MozM22cjp0=;
 b=xSWwJg4pR4GFkZ9InffbG2Iop+hgsWWHRFdCTjYjrBTTBmvsQxzpOQkH2XG6p3IqKcXOs4Sdpa9F3J8+5wou7+xJ3Chjfd6Svw4YpuZ385v5yI0hPRpMlCODtPoqK6Eat+EZ/tSWAuVcv/NkJYexG5jgLY68ID6A37uo2tLJa//wgM9/uouxmQf77g7gVuWUFnymVmTJ+B6hBF7xTKSeKUnxQHcNODPEWwNoUODytLd3yC1G/O/DC72TwT5vudR8U/cRTh/IaltVVOUH5+n/v/+un6MxAQRh1KGezacnvJwX86XWB4wx2p3/7TPzPU2Hv1amBkQ+sy5OsseCnFr8TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB10179.eurprd08.prod.outlook.com (2603:10a6:20b:62e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:15:41 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:15:40 +0000
Message-ID: <2fab45c6-6a19-f131-966a-148f6d23ccee@virtuozzo.com>
Date: Mon, 18 Sep 2023 10:15:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 04/21] parallels: return earler in fail_format branch in
 parallels_open()
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-6-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-6-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0039.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::28) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS2PR08MB10179:EE_
X-MS-Office365-Filtering-Correlation-Id: 28aac7f2-1e05-4ad8-5f11-08dbb81f728f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ve6dxaxhYDC6aOjkYq7Tu0P0rsExJ3WZhcujOWUuSYG7q5H6uMTf+F1ec11agnoJg5EpEfMpBMwEmfMGxXZFP796w0ktMACTgENxhYRaqSKdibQtkMYBS46Lr+gIeuNvUFNQ8Hsimnsv/JDRgDqPZeJ8rqNA41YnsRyefvQz2e9IF3kIpRx0SsbMtFUcEPCnJvwJnUP1L8xjV+tZct5pnD2Qz2ObDffYQieE5YnzNcGbqIB6RA/5tWiDjEvC+TLrtx7LEJYtctshXOxy0DEVqTzScJQU329ickAL7mjPDUUa33JgeLQOhRZ4g98WDJvIhcRO5zU4TgpZSDowNJfChptm50KNFtmYRdL6DdTvtyyCmUCSsnDORqHW8UuKVjihEZSxtuLOf1oREZ+HO/MirfLq7t5wjT/vUvuLIel20pe4hEA986Pf4rQ7h7lO76dXDmLPi9UzMAPRdSNsRYt4TmY2JlISbE1yNJneqfX7vAhslKEaqYsCsthAVzCLYV+rM2UJciePhrfuAYUXhaRu2UKDWIT4W3J9yN4hPjTb5MwWUHZXgTbeuDngQpidZH9Rc4LUI5x61A79Fw4RU+fOL70rNbNspxBWI2Fn8mUcbqeNW5unFEN6nevcgjsNZj3EwIuxD/M1grPL64ruKmRg22iiYdmIBxQcBNzUjdiZBXFrqXdnC/m8oWHKuMzelJ3P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(39850400004)(346002)(376002)(1800799009)(186009)(451199024)(53546011)(52116002)(6666004)(6486002)(6506007)(6512007)(83380400001)(478600001)(26005)(2616005)(4744005)(2906002)(44832011)(66476007)(66556008)(66946007)(316002)(8676002)(4326008)(5660300002)(8936002)(41300700001)(38350700002)(31696002)(86362001)(36756003)(38100700002)(31686004)(66899024)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WldheDNXb3VNNUR5OW5kcXhuTFNYQXJ6SmQ5dm5VNzQ0Vm53WFhnRW5CTEU0?=
 =?utf-8?B?UWcva2tzSUhrc2w3R0hUTXR2bklQdVdMdnBZdXJ1cXZaNXBSWGdLWDFxL2FH?=
 =?utf-8?B?TFFXeEdaSWJXWE1mdUxaOS81aFMvRFJmT2lwaEdPUTYxNWdvM1RLa2w1aHo4?=
 =?utf-8?B?RDMxVldUS2Y5d0t6NzlZZSs1eHlvUG8ydURDSEVVVzI5OUNKb2o1czVYUDJq?=
 =?utf-8?B?cURzOE15M2pGV0pQdkJLZ2tlOWNBOXc3NEpDWndhN0RlWkVvN21xYk9weGRR?=
 =?utf-8?B?Q2JhN1Y1bHU0YlRWTVdmbDRBd3BGZlk4ZmI1Y3hUZjhkQndpSWZMbDVrWHlN?=
 =?utf-8?B?dnhUZzBaZmtoclhxUnFDY1dSSjY4d1JQRkdHbXZUWjVNTzFmRHNBVDdIQWFJ?=
 =?utf-8?B?YjRqeUpYZjBBWmFSTjNZQ21EclRHWlp4REo5MUgzbGdCaXFrdkNONjAwcjlr?=
 =?utf-8?B?dXZ4UXJVMzhReEtHaFJxcXlaNHRrQmVpN1dEZEMyU1V1aWtoeFV1RVBYTStt?=
 =?utf-8?B?bGVwek05RExvKzlEVDY4aDgxd05Xd1NHMFp2SzIvV1h6SVlXQ0lFQW1mODhV?=
 =?utf-8?B?MURmWWljdFkzNE1UaE1uQjRaZ0E2RWcycnpPbXZ5REU2b2liODNiTjc5L0FM?=
 =?utf-8?B?VHNnTXpHN1BibWp6aHJYTzlmYTFZU3ozeFA1OFdObDNuajJzd3NVMVU5WUR2?=
 =?utf-8?B?a3E5Y0s3Rit0eFFGZStEWjJSUURZcHVtZlFRdGJYVVNBN2FwODdzZkFNV2Ra?=
 =?utf-8?B?SkYvQjNVa2Y0dDlEME1makxWVjQxM1cvUU1TWUlmT0RoK0cxTjh3cHZYWFFz?=
 =?utf-8?B?N1M0LzFIeUh1Z3JTczN6VEs2UlhRNFEvbXBpclp6ajRiY0w2dDhQR1JjWTJ1?=
 =?utf-8?B?U0I2cmdLekc4cWxEMkRVZzFWY2xlbVVnZ2J3cng5ZDF2U05EcElQZ0RBeGpq?=
 =?utf-8?B?NmxuTEJVL1YveGgxakRSQ1c5aUNPeEVIYllzT2JQSDR6QW9Od1d5QUNsRXZu?=
 =?utf-8?B?ckMyeGxGSXdCUktwNmxHdzZGWHpMY0N2dXQzM3BMMGVnU1l4QXJueU5XU01x?=
 =?utf-8?B?QU1WeXc5WklrN09qSGtZUEs4SDlLdXNMYVJIWWlQM0VGZTlmWTNZeERITzFG?=
 =?utf-8?B?akoxZ0ROamg1Wm9OQzBOY1hOTFR4WjJBQ2t4UVdPTTVxNFdzOGFyT0o3eXJW?=
 =?utf-8?B?ZEc3dFQ1MmZMaktxWW5IZTNtWE5sQVJWVVZWMDk1NHZ5cGV4cFpqLzFIOGlq?=
 =?utf-8?B?QVg3aTlZVXVFbklzaDFmUms4cVRpTjRzZnhuOStQMy9YUVk1TDhhclc4djJk?=
 =?utf-8?B?dTdvUmF5cjc0MUdWZDJmeVNFZTJlL0I1SGlFNWVFOWVkWitCU2s5WFV6dU4w?=
 =?utf-8?B?N2xPUWJxUlp0YVVxYjE0WUpUM1RmbFNxbURCbGgvRE9pd3dGeGFGYitDN3By?=
 =?utf-8?B?RU1JdTJ2SDFJTzR1d0dRZjR5Z201ZVMyaGc2RzF3RHBaUkhNQndKZU4yTnRt?=
 =?utf-8?B?MXZHSG5zNFArSE1aWUdsM1BDaWg2REtNN3h4Wnc2SFIxSXdkMkRGN0U0bFFr?=
 =?utf-8?B?aUZBYXJJM2djcFhtMTBQejR1eDQxM0hDK3VMcjUrZFlQVVdEL2t1VCtyNG1W?=
 =?utf-8?B?Y3hiVk90YiswdjlLcHY1eEdoZXlCZjU2OWIyak1DNUV5VnZleEZUUUtKVkdm?=
 =?utf-8?B?NUQ5UFR6cTZZaGpKTERibk9lSUh6RUlrWk1ZSEFiUlkyNDFYYTNGemtVeUhX?=
 =?utf-8?B?WnlySkdIRGwySjRkWmZXRDc5MmxJdU1CbzZnMCtvWmp1OXp2S3ZOcGF3dDEz?=
 =?utf-8?B?dUtISHhHU2t5MlloYkNxNnNySVcyQU5McmxyVy9aQmxkQXJJWmxUQ2NDcGw4?=
 =?utf-8?B?cGY3aVFlZW9HVkUwbWpIL09YdzZ6T0orSzRzR2lnQnFHbXJ5dkFXNWRMWmhY?=
 =?utf-8?B?c21oaWVUUThwcE5mako3dy9ZQW9WTy9MblZCTHVpUjMzSmg3aTd6eXIzZ0Jl?=
 =?utf-8?B?MEFZRUtramVTKzFTT05oamhoQ2NFaGpaSXBNZG52OU80aXI2b0FYUVFWRU1X?=
 =?utf-8?B?UXZ1bTR5eDA1QVdVUmM3U0ZSNmdTcUdncWpMU3hheHdvQXlyUmdRQVZSNCtK?=
 =?utf-8?B?bDlOaGlNOTk4Zm1RSnFYd05yTVNEV2dWZTNwNzM3TXlGZ1NDZlUyTGlBaXA5?=
 =?utf-8?Q?7Bou6AYUqV2r9dyPI6RRFT4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28aac7f2-1e05-4ad8-5f11-08dbb81f728f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:15:40.9421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeLmIlhwe2Mp6iq0CAS3fLp1mQbDA7eiwbqYNOv/bgujT04I7b2CGCVKi6wPc0KRYhzOJxTOotxBYZuBZf+Syj5LPNWNhBjrNqVA1vzar5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10179
Received-SPF: pass client-ip=2a01:111:f400:7d00::715;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> We do not need to perform any deallocation/cleanup if wrong format is
> detected.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 1d5409f2ba..0f127427bf 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1226,7 +1226,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>   
>   fail_format:
>       error_setg(errp, "Image not in Parallels format");
> -    ret = -EINVAL;
> +    return -EINVAL;
> +
>   fail:
>       /*
>        * "s" object was allocated by g_malloc0 so we can safely
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

