Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A289A82F07C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 15:21:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPkJZ-0003Ow-Hn; Tue, 16 Jan 2024 09:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPkJW-0003OM-1O; Tue, 16 Jan 2024 09:21:14 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPkJT-0004oH-Uc; Tue, 16 Jan 2024 09:21:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn5r7c++6iMRs0AM4zU2r0ndO7s0qpQKjo0BxCuwgQjsyWLJa3WNjf/Li836Osd8mtWi52YUBCWqKaeGNVqDZHuHtFiMfaNCqtiAjLFTTElQdCcAIGms0F9eN0l7h3tyJkR1cc7BMzbMSH0KeJIwrYTzHSGrECdKDA4HE7GzbPHCwXY2Yl1NE1A1OhyHRQ/RL8LFZpcX2qScwI84jx1DvTyvz4Nqu0pUbTwCwI+zwviCjJEX1zt6RccnVYESz5hvGHLB790FrbCzB9QxIerCYI1uD0tazEahN9p4aGu9WSQmRyY+7dcRC8HsiJUcqxKM/8ZiaC28PaiUi5w0ln79ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tbLdjeKASDf2decTZEJ4XRZ/QI2QM+R41XbA9XJ/9g=;
 b=JKSb6OHXXqJkGsTpoxt+Wp2l/pgbctu75B9dJ1LayMobNG/PKBwzck7U0jutHsNdu6PNERRfe2XNatJBxB3DdNpF+fsEsvLujaVDsTxo/PUIVkARV+TAUr6VFcIVZk9awtNfHI9e1lqrL0ZpS4PPBfx8hOZsjPAn9Pq3nCUDPiQfFs+axkNDYZgu3M+WXeJZLl6JQW+s+Db8cOxmqD9WEy2dsYpjusIYld9XWS+zZTvTylOJYKWyzqb3899/fO7QSskafUyy3/OrT2lBKpcS2yNXRhPYV/B1hEk+aOvLXjNt4yWyZlVAtFwrjlnqi/YeICHHpImm7Es7XsqbIdBgjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tbLdjeKASDf2decTZEJ4XRZ/QI2QM+R41XbA9XJ/9g=;
 b=eh5/frlibDz1UjU+VWLS7jngrAi4Dflqcn2Ok6gAfMH+VyqS0dXvvBlo8UZMtNBt+bR+eR/D/HlpMwcXiqBnsrmOvSA+vgVm59bzsd5wb7pLJzB6IrXpsaGlYy3US3XjjrJ8iTtQXvhAn7KRwCzJXphUQ4cCS+hLdCqISnVSkvBNB2ZChmfsEEwmgNkZrT6LgYCGG9bV7g5aBkVHsGRezlm7gMhYJc/Yr3fsKjQ8a+qQigmmVgl2pxpzfb6yazYQ9I32eO+I/00oQvZ5Xzj9Bw13cY0zuwJc1uSyd0l8dp+fs1qVaAz+ha9VKDBOPxSyGTnkv417+8NNPh0crmGkEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB9PR08MB7469.eurprd08.prod.outlook.com (2603:10a6:10:36f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 14:21:07 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 14:21:07 +0000
Message-ID: <73963a79-9572-4022-ba8c-d9f0644cfe5f@virtuozzo.com>
Date: Tue, 16 Jan 2024 15:21:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/21] parallels: Set data_end value in
 parallels_check_leak()
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-8-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-8-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB9PR08MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: d607d78f-1f8f-430f-0479-08dc169e6162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tu03hDpiCLANFEDBGUZh0KDBTIlHIURKZ6tMe8j+eUggbecCSkbQ9HcIuabGrCKQp/KLq2TYUKMH6/jc7VUL3y8S7qd2orxeXur+Khzpk48fGJDwzNeZin1mhmtO6FyAahPLefj1vokQT+mZFmRhpcf5OzMI03A0FrXXQk6KWT2GaL+R02dFQDw5eke/MnA0JpdPv02F11G178FcrE9eIxpZohclU1foLjSTm5eq11q3UuMKFNsLDybQZ16ldgaNmxX3MfzOPRfiWXS+GQSxqojbgXCnFcbztZ6LgpbuLP1pl2B4zh9mmpETSmu26tWisTIUbEe0CRij8E4dLpE/YixO2Y2of0CKaoX3h9anrKsf+C5g3Ugv/9qsR6ESOEE1pb3bvWD7IFR46iqO26O+8B70HPjgJtUL8MT3fIOAYhNAjymf065KS1trVOzr9hqiQxr6gD61ywI0n+gfjiETZ6KHPuzDqv3S08zwCAz5jD+Z/VqHfOMyYxUaKWNHLgAWwkLSkXM83enD3PLYLcX6yC6hJAQ735GuzAk4Q8YdeGtuvLfNzbJDVwPSLylYk54M4/H47mdBrle45LWXboi81ShLKBkbV6xPVnihKc0UngBdF3GADXJ6vQFobQmrObJByJwsrjGABVypE4v+T3t8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39850400004)(396003)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(83380400001)(41300700001)(36756003)(86362001)(31696002)(38100700002)(26005)(2616005)(6512007)(6486002)(478600001)(2906002)(66556008)(6506007)(8936002)(66946007)(316002)(53546011)(66476007)(4326008)(5660300002)(8676002)(4744005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3A1RS8rZGVJK1NvWEVnM3krVm5YdXNsZTFWSlpiSWNBUSt2QmRxZlVtalpX?=
 =?utf-8?B?UDBoMGpjSmJXYXFFdHZ2N0N0Y0QvRHJMUmllY2YxVUpRN1VpdFpCSVZiNjhD?=
 =?utf-8?B?WnJOajFPMmgxQm4wckcvRWVDb1cwY0FDQmpRalFueWdZS0lOM1RTODY4OExk?=
 =?utf-8?B?YmJ3eUtoRFBPNzQ2VWdxdUtOd29CZzFCdCtsc0gwbG5IVUNiS2ZoQ0VsMEs2?=
 =?utf-8?B?T2dTMEtlN3VLc001K0dNTkd0TkEvRXhDMzUwRWloYXZyWnViRzVwUExNaEdL?=
 =?utf-8?B?ZG1keldlUHZJendEL1JIUEZ1SHRKTGFvY1JoQ0hnQWVwTHJ6VERTSnFZNmto?=
 =?utf-8?B?dkljV1J0R3BKTDlna2daeUtHUkliRkU5T0licTNjVWJxQUk1OUZSVTR5WUlm?=
 =?utf-8?B?a0JWclBYeU1IS3Y2SkRQemNwU01KMGt1Zk4yZ2tMcTN1R1Q1VXJqZ0FpZWYx?=
 =?utf-8?B?K3JzdEJSSFlFNDEwbnl2VnY5a2poU04rRGg0bUt6bnN4czlCOStsd2tBOVNa?=
 =?utf-8?B?aXpYN2VGaER5eUlRdlJUb3NRaXVPd2hFSzZVaDA0MCtiUWEzN2U0cmFjRlZG?=
 =?utf-8?B?dlQwS09UWlJTWGQ4K2IzU1ZvcC9IbnNsLzVJcEpJSzcrUU9obVZmWU4vWGJR?=
 =?utf-8?B?YzZhRkZHeFhNMjlHNXc5cjUzR0hZL09wS0ZaMXFNdUo1Y3dsR0plY1MyLzRO?=
 =?utf-8?B?VGp3dktJenV2YWVKS3ZjdVhLZHZwM3QrQVF0OXhCOExoMU51d1pJemNPQXNX?=
 =?utf-8?B?ZDFyWERWQUdGbDVVVFpCMjBEZHNqeXR5a0M2cG1BRUNhNnRIY0gxUmI0Rnlv?=
 =?utf-8?B?ZGcvekh6UFpjcWZRblhhSGxaNDloSG1CMG5HL1JldG11S0RzU0dxS1o3d05t?=
 =?utf-8?B?UnZhVUhvYmc0ZDZoMnJsWVFjK3ZSV1hyQkNhRHlBVzZ5VUt5U1VmQlEraWhm?=
 =?utf-8?B?VHpoTWdMNVRUelB5WFhFWkMzTWdSZTdTNndyRWx1QlpUcXVMZDZ5UCs0U2VZ?=
 =?utf-8?B?N3orYXVTcXZvQm1RUEZJUm1qRmxCZnlpM3BSRjE3bnlYRVk3UjR1YzloVS90?=
 =?utf-8?B?Ky84c3pmcktUS0pBVnFRNkpFTmtGS0JpY0Q5Q0ZzWXVSU3B2eW5mREFUaTI0?=
 =?utf-8?B?cEtlUHV2SlFhVFZ2cGlNbzFrSTU4VUVnMEhSaUZOWWJ1UnhyOVFScE5abVBo?=
 =?utf-8?B?d0VWeFR6TWlEakFRRXAxSG41OHR6TFB4VkV2aVdzQks0engwcDVoTVBkMHVU?=
 =?utf-8?B?QVlTNnFNZXl5ajRqRk5vWDhCRlZpYUxpV0lMcFFhNmhYZHl5NGljOFc0ZGMv?=
 =?utf-8?B?K0NBd25EdUhRdWQvYXJ0ZEZLcEZOczlKZ3M1aTJBL2U0QlgvZlU0YW1TNFYz?=
 =?utf-8?B?NkV0TmtBaThLODFoYTdJRXV3ODJUQlhZSW8xVkhnYXJnRVZQdEJxM3JvVGM2?=
 =?utf-8?B?c1JhNG9lSVFBVzJHZmQvNjdKRTRnOXRsQTA3cmowT3NwcU82dEVocHhFc01n?=
 =?utf-8?B?VTduekNLalZ0RHlGd2NTS0xNUGJzekVKa09SOS9tOXFZTVZFM1RYR2N0ekdh?=
 =?utf-8?B?aHdSWkdqU3psdno0MS9sT2k1M2xmcXBaWG9ZdW1vYzV0dXRtN043Y1dPdTN3?=
 =?utf-8?B?eFZYS2tOWTlDQlRPZitxazVZam43Q0RUL2pnUmk1eVF6NFBwWXB1UWw3MnFq?=
 =?utf-8?B?STYycDhYOHZTREk4NEFza0FQdUhad0E0S2ZyQ1JPaFNWZGtoTVUyZThwRkgy?=
 =?utf-8?B?TUlnaFYwUkJFUmEyZUd5bzFQdWJoNkpwSzZ5K1B0RjdxbU0vblNUcXZqaXVX?=
 =?utf-8?B?M3ZhYU5HekNJeXVMcXBxbEVGcFM1WGZuOFRjZE1KNWM2dWp6WnZoNys1VWt2?=
 =?utf-8?B?VlgxVTRBRzZrZWtoeG9RdmQzY2lDQ1VJR2l2b0xwTTBscHFubmlNTGVnNkpn?=
 =?utf-8?B?ZkFaTWFjMzBYLzNqZUZUTGMxdkVlcElERW9ib2xxblM0RTBFS2pjMDRUQkNS?=
 =?utf-8?B?clExaVZSU2JLR1N0dldmcFlJbEs5UGpYaVJHZWtQYVNXQU5kRCtKRzE3Y2Uy?=
 =?utf-8?B?WEN1MGRpanIyNUJURkp1bnRJdFV2QlEzcTBQYks2blJIOHNhWVJteDlKbTFz?=
 =?utf-8?Q?kAim6lTWTVm7Vts/+/ZrfL1AD?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d607d78f-1f8f-430f-0479-08dc169e6162
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 14:21:07.5569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGfgm9LKnxzEhPzH9NSlmLyYi+Gk5AfIJ1MQW/Bj5zRCj1iMoZL02wxux4ZtJzi91K4oF0ChKOmTypIsXCYrIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7469
Received-SPF: pass client-ip=2a01:111:f403:2612::701;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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
> In parallels_check_leak() we change file size but don't correct data_end
> field of BDRVParallelsState structure. Fix it.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 658902ae51..8a6e2ba7ee 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -806,6 +806,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>                   res->check_errors++;
>                   return ret;
>               }
> +            s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
>               if (explicit) {
>                   res->leaks_fixed += count;
>               }
Reviewed-by: Denis V. Lunev <den@openvz.org>

