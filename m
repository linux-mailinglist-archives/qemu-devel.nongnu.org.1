Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8511A80C7FB
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 12:29:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCeRv-0007VE-9c; Mon, 11 Dec 2023 06:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rCeRq-0007TW-IA; Mon, 11 Dec 2023 06:27:42 -0500
Received: from mail-db3eur04on070d.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::70d]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rCeRl-0003Ms-D8; Mon, 11 Dec 2023 06:27:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8g9s4ymanqNAO8V+38x2ud3qZ5O4o0+QREz1x0srHNuTH7iiHBHJ/4S76diXXHupx64PoKgOAj4B0tdaSKLo11bJP5u/wP2m4+wM0Yp66K2rwXP7KVuyaKNk+bTMy6Gg2RqVtVSc03b5NItmtqDS0yuHjRO4kr+ASDtVUx+rHwgQM9pbqWHuNMefmShFtL7mEQdWzmprHVt9bTb+HbVmRSOgsTkf9YORvqe0XB7p4yZ7ZDRTuzOD+tNk3gKQBfpRDryIBVNdmojXhulSb/xUVaiJRNjPBfMQuldqJD5JGWRythYN0yJMDfYsk+JXX46OX1/J+SK0LfqYt2CSNFAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuWzsQDRuwmKhfePj7ZRh43s2bL70BBuc0mrae1GSls=;
 b=kpDDY3sKhHioU/tT1sYOuyl9JBlQcWikh/h4ZE5cptU3X3zyWbBlenT3zldaBiUss19KYCv5uOav0x5uT8iP/qpJk02gPDqx3w3Rr9E1vKEtN+d6TPBWAfutJGLfv8bO39K9+VgT3VIPepPOm2QjDHQQaaCB9OPFTY68SzpDMp6+nwfk6W6gMRVnzmxClECUMOv9zNusJSyVAtVovdmoEB1eMYZx5wGiJUropR4g9Qfl3iEBuXD17PW6H1zzfoNSBLz2HZbnf0yxWRl6FlIJzmB6RTwGZj4EjcIlDWdDRpLMm1KvMiD2oCm1U2d8Y5/N2+n2a+fl08NPdVRIt21vuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuWzsQDRuwmKhfePj7ZRh43s2bL70BBuc0mrae1GSls=;
 b=N1im1vdzxVLUWYWihJkVSUV/SsGtQqvPjLl8LUUOBLLYUeBOgwVCSP6M3f6Wm7427N3ouSDSE5Yxl00Lmjl8ceL3tQXyeeMt5ALq1BgDHFH4rINWbIg73Tb9tkhgT7MV4mquIJRqNYGKozKADbRRekkpBdvyHbMSCW1Z7ooC1JeTO7/yi7L5dmo1YAECbT6Kn7SHI8z2RwUtRKlq7OHQ/HtuuSNyVd8LUSrv0xpU/azDtIVkGTVZHgr6yL2Y+scEjII+9C5IcK7bLtS1e7F8p8m4wGBIYk+/gfWl2B7cbelWTBREajJ6XhV89MQXR/sHF9EUFRDcj+XWCpOA7hYd+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS2PR08MB9452.eurprd08.prod.outlook.com (2603:10a6:20b:5e8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 11:27:29 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 11:27:29 +0000
Message-ID: <c197c97a-e296-45fb-ad8b-5ca5dff81ca8@virtuozzo.com>
Date: Mon, 11 Dec 2023 12:27:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: allocate aligned write buffer for 'truncate -m
 full'
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru
References: <20231211105559.316897-1-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231211105559.316897-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0237.eurprd07.prod.outlook.com
 (2603:10a6:802:58::40) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS2PR08MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 3385b1c3-ef4f-4aae-cd2c-08dbfa3c28f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tt2C71UwiPU8jc8RbVb+1b4ndkyrODvQNggtpsD/pUfyOKQvYoI1bNzGc2PPPoAhXhxdjxHiIWYqbUfIO9oDXarikl0u1l/TC5bNcpLLpqX629Ia7f4qW6+xLndlSPCAZ2UPoSNMciQqXRgIih/i1NUF0fzs2rOuJmVN2e9oaMTJ8H3qRWNZH09uLs1qfATMBWheZXSJN1un9fLvOQtu739O61hK4U5FWQMeLumUCaZhGfJR4p+FTURQVdI0l+ma3X6Wlmu6ccTYpTenSoMKD/YngWbfnkrZ+OEajL+tFNBLGQQ2hilqhFDfDiae25ZbPaxKqPOSrrqVslAkd4x46pBedVRa6Yo0RMsuFCAKty8IRXLrH7fbYJTx6I/aIx9tQvpq9hsGKMAW5JbU5+RUyYU6yq4AaW5sq5/ywQzuzQ0Cp46jLH4JS4UyhDAr3FC5CC3dAJRgDGsrPV7Z5c44rZ87fFelTlv0Y2I0tNqyJ9iIWPoEnRHaxMlVdmLURJMmAW/Ic7bTi8ImZZbUMmV39Jo13897w4/ryGF65Z0V1YkeQaC8LSqPmbCZ4UAwACpH7fcseNkfS1WqKvOs5l4Lk75/dL5uCLexbRdbWmoWzb2HVPtjC+Ft9p2/6r7g4pKx7xThHpQ4oOrSrXbUE5ACw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39840400004)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(2616005)(6506007)(6512007)(53546011)(83380400001)(5660300002)(41300700001)(2906002)(4326008)(478600001)(6486002)(8676002)(8936002)(66946007)(66556008)(66476007)(316002)(86362001)(31696002)(38100700002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODdGM1d6ZzZ2NjNObzVMZVFnVitnUTBKakpUMkNFTWFDeDE0bWEzd1dRZEVj?=
 =?utf-8?B?TFhUOWlhalQrL200WmRnU2o1bVZXVmdLbWN5Qi9XZ2t4ckRDcWpUc2o5d09D?=
 =?utf-8?B?SHQwbmZlK3RvZjhsemJGN3c1SFhHRGdHUVVXRVFNT2JoL1l4S0cwQXNXWWxJ?=
 =?utf-8?B?TG8rNWlVYS93L0RmUHVzVndMSXlpMU5nR1QzejlFeWREWld3WlBxdE9wUXdl?=
 =?utf-8?B?eGJBdDlLdnVmYmZoeHorMEVnbW5ISWFSTmwzeVZJRnBlbFQyTHRwbWhlWURl?=
 =?utf-8?B?ejl2SHRjdEp4a1FlY2R0TkpWV2ROZ3B0Q2k3K29mSEd6Y3hkNGthVENYM0ph?=
 =?utf-8?B?aVVOVzhoNXFFTkJJODdMUTA2bWxXdENpR1RnM0NwUnZrRy9NOE1FcitmSG1U?=
 =?utf-8?B?NGVSazVMcC8zVldxUXNlYW9iVGpxdHVGRkNMeklhWWtzUm1MM3lGNy9IdEtT?=
 =?utf-8?B?KzdHSk0ycTN5cVdDeXNGZWlqdm9PWUd3SUFxSGJYd3VhNSs2M2NJT3cwUnoy?=
 =?utf-8?B?Q3VvdVJrSFJwbE91U2FuNWsyK1RDb1RkY0FFcnRMVXZIckpWQUlxWEhZd3VK?=
 =?utf-8?B?Y3dGZHd0QjFxQnMzTGhieFZaM0c4bXRIbkUzY0dSOHpQZTFpdlRoRmZFT3Bz?=
 =?utf-8?B?di9LbHIvdDRtcFVOYmNZRE5HTk5VanF0Mi8xdEl6VmJsd09UZzZuRnIzZWJa?=
 =?utf-8?B?bTlEYjNGbHZGbGIxRGtwUXd2cmlnRXo5eGlreUxraFdtWnFuNjFRRktMeVM5?=
 =?utf-8?B?RytLdFowM1RjajFHR0hYbUdBczNxcC9pOG5GVnFiWSt5RVJlWkNuZlFWNVVH?=
 =?utf-8?B?NEdZNzVJV1lhT1FVQ3BRYWxXNlViZlMwSitWSHVjbm5jRnE1NUFKUG5mSXox?=
 =?utf-8?B?NEQzN05IQldkY2NLcWpaaTNITXJ4aEkvQis5Z3JZckpXNWdYZkorNi85dW9m?=
 =?utf-8?B?WlY3SXQ1aE84a21QUWtLUlBuaUsyWm42Zmd1Tmw4aEZMOHFWUjFSeDhZSElS?=
 =?utf-8?B?ZDJoM3lUTEg0aFZjNHd4eS9nM1V5aHJpVWdFNHgyMHpZK0paYThhelAwN01t?=
 =?utf-8?B?d1VFTFBBWjg5NGp1RWY5N21yZVpPQ3MvQzhsU0liY1EvYml1VlpTT1dMc2to?=
 =?utf-8?B?K1o0NENZRkJhdU5SSnNYMTkxTHJOS2ZPdlpJM0VtSWtmeEUwZndqdUFmNlFH?=
 =?utf-8?B?OXFGRG96SDJhRFF1MnNHdWZ5Zjg5L3F5aHNQTHNVc05xamtlMDUwZ3Z2RG1u?=
 =?utf-8?B?NndGS04rb3RWWUtTMFZkalFRbU90R3lFbnc3ZjJRbGZZRVY3Q3cvK1l2eHpF?=
 =?utf-8?B?c28yS3kyL2FCUVk3KzVnTW80bEhsOVd0cHl5ZFN2WFBKc3lZRExiUVlhbVho?=
 =?utf-8?B?aWdUcUtMVnpHSU1UZkphckllVTJINEFOckVrc2UxWlJCVE1CMU5wSXFTb0RQ?=
 =?utf-8?B?OTU3OFNmSDNybkNOV2hXRTgwZkwwaGJGd1JiRWRDK1ZNaG94YjNXMk1VSU5S?=
 =?utf-8?B?Qk9pYWdpYzJuQVdibDFMVXZzYjBCYXo1NGEvRXkxZnRmTkVmTDh6dmpTMFBJ?=
 =?utf-8?B?TGhEc1hIMDQzc3UyalBvWGc3RHdGK0ZRNi9LVVVBUVNSR3FLWHcxWjhZcmJO?=
 =?utf-8?B?cTNFemlDSmJ3UWJjMHN0bFhOMG02VzhGWmxxVHJCZVFaMW94Ung4Vmh1Vmk3?=
 =?utf-8?B?N1lLOEd1cnNOOUIrUnd0MHhPNWROYmZJaTR0M3hxNzZUN2J0TnBxQ2MrRk9V?=
 =?utf-8?B?cHVRWTlVSW1GYldad25JeUVPeEJwVmcxMXlUcVJjOGFENUxLY1A0TFEvTFFN?=
 =?utf-8?B?b01GU3Jqem9zYXRMN2tmR2ZFSXVhdnU2dFgzNlZmMW95cnFhZ3hFU0c4WjdH?=
 =?utf-8?B?dFFtRTB5S1Fxdk5qdC84NWl4dnVHZjNoaXo0S0R5bCtXeDhsNG9uZklFcU9X?=
 =?utf-8?B?SmRueXdvcExJd2dQUkVsMngzRitDVzV1bXdzc20wQ2piWlVCR3BMZUt5UkZa?=
 =?utf-8?B?Rk54ejlQQ0lPWWlMZjVpa1pZNWZDMU4zVlE0cXhZR2hpaDdEVFRSTGNiencr?=
 =?utf-8?B?eHJsM3FBckxlc0tPVTZiZy9zWHhlaGZ6ZVJNcmh2LzV0Y3JwaVl4Q2dPVURK?=
 =?utf-8?Q?7xny8jB/OWLXMEzU6zTitREeI?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3385b1c3-ef4f-4aae-cd2c-08dbfa3c28f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 11:27:29.6298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5VI2UgA7pTxhn9xTZKSOizO3rSmLWrrOVuc9Boxm9jvNDQViWlsMugq7VnohmkUJdLMJ4GepxAR2HwiTEiwrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9452
Received-SPF: pass client-ip=2a01:111:f400:fe0c::70d;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
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

On 12/11/23 11:55, Andrey Drobyshev wrote:
> In case we're truncating an image opened with O_DIRECT, we might get
> -EINVAL on write with unaligned buffer.  In particular, when running
> iotests/298 with '-nocache' we get:
>
> qemu-io: Failed to resize underlying file: Could not write zeros for
> preallocation: Invalid argument
>
> Let's just allocate the buffer using qemu_blockalign0() instead.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/file-posix.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index b862406c71..cee8de510b 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2354,7 +2354,7 @@ static int handle_aiocb_truncate(void *opaque)
>               goto out;
>           }
>   
> -        buf = g_malloc0(65536);
> +        buf = qemu_blockalign0(aiocb->bs, 65536);
>   
>           seek_result = lseek(fd, current_length, SEEK_SET);
>           if (seek_result < 0) {
> @@ -2413,7 +2413,7 @@ out:
>           }
>       }
>   
> -    g_free(buf);
> +    qemu_vfree(buf);
>       return result;
>   }
>   
Reviewed-by: Denis V. Lunev <den@openvz.org>

