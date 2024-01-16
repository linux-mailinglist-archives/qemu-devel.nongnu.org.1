Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE3982F0A0
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 15:39:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPkZc-0001GA-IU; Tue, 16 Jan 2024 09:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPkZZ-0001Fx-Jb; Tue, 16 Jan 2024 09:37:49 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPkZY-00041l-0l; Tue, 16 Jan 2024 09:37:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XToL8gdjl8hYDqBWtVvQ3VnuPgRVQF+CwWQ3qI4cr2LDOVkcDkVmmBUiMgmb2ISHqFqeGwJUohq3Oxoai274x4Y9VCZSiAtGPoIp6+85P07JNuSQCX0Oe/4JgMjb13Lh84axIEpkUpeQhiU/uWc1zaJZ8HABM9pZzEkca0YMkyXiX1rkLik+1zuPMlsbWfgYgw9QI7L8g8IoAy6dQ5fr8d+oM1Lnb3TD8yEpLUP0pRg0/7PlgkTkMfCF5ewGGNYYbDTG2AxA7FovVIouY/R1/+pdVQbKvesDk31PECtE8fxzhws1NKpOHp1Dme4rQ1RB5U4aO1SjtUrBs73ca72mwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QesZNK03q1SgiL+aeJs3EcLykPzSJztXRzjny8iaYNE=;
 b=cNOlctCrtDiAR75mYzes96U3KB8THS/eHpBXrEdmhp+sfYqNpN7BFWU0ZqYhBxebohcDTUlwwvlizZQ2TfpQK29zampzorjMQwLXT12hjQEDB/oup+MsoUvUNn/PtofTbUYu+3kEEBBOYuZDWIuQGertdqSG4PxuMt76tJpEmamSc8OfYRN37748GbXBYvQMoqEF0IODGQDkMtzVGHxQh9wUNExI2NSfJTMxEeUjeaOKql3dZ1M2rSEoPYKgVKkMSIIPaN20v9Rgu5yQkDrFtL23ye/+ZZrvJ7pc1khvAfcgX1fT+eUxIimmZXEy8GdMV3EnI8U6kn91U9WTkolEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QesZNK03q1SgiL+aeJs3EcLykPzSJztXRzjny8iaYNE=;
 b=vik/wqBSZlepgo/3+znTFw7jXryr+2ZfT77jEzQLusdpiyQ6BA+Ln/ATFA2QI9x5K+NU92Bkmvl5BYrom285KuKo9bl3WU4QAZUsou5QAgw+Pt7w8QLkhGWDLlqGnLBxTAfBdk+zX4Vp9hKf2lxSpZp92tGufYAVnHpmQJvszWsAwoq4Uz1rR/oh3oiLCZenJxFPMwy8PiVPx2HFZbsZ4qmOrR3RoD4VEtseEI4tvgvmy5lkvP5GjZJqXSDZUtSmQjiX6se7ACcfuKKapXLlVDKoFEnKLuKf9CGej5Xby0QNys4iy57khOuiXRty5+4NlU0zwH1iiNuHsVff5q6dpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB4PR08MB8102.eurprd08.prod.outlook.com (2603:10a6:10:386::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 14:37:43 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 14:37:43 +0000
Message-ID: <6482539d-1c2a-492d-a8b6-cf1a17aec42a@virtuozzo.com>
Date: Tue, 16 Jan 2024 15:37:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/21] parallels: Create used bitmap even if checks
 needed
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-11-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-11-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::19) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB4PR08MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: f511f97c-6bcb-48ae-c517-08dc16a0b312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l68FzXzUxD4Sh0us8Yha1DVss8jB1d3b0J5KRxAEwzz6UXTcOf7anrQXtrZIJKtuulLBJ8C1pyHwr6y9KLYvR0S7XFlyjSrE909RtLFe35UzR+K6m9a5eQePBnqFMOMyNRNkCG8nT6k6ZoZD1i62VVW6c/uSXParOboIy0UaqBH2aR32+9lmnjMUpRXmqmIG7W5Y3ZiNwTZjHKtphUcd7Kf0R0l+kTmR3SHR3RI8Qn5OqE40KOUH1sT6+aWCb8Gw58i82DS8pQ2yC2quBE77N0JRG0SoWdwou9n6/IUMaLi4NaEqEiLP1kCmFFusT/PZlZilUJq4SqjUtc6dqdugOhhLpDce1a2S69YejoLDEKLQL1ww4XgstmWSrQy/rVceh2dfaujMFQwroSOINm0slxlxNnsdl+6aj8y3DYIopBFdX/GT5yqzFMVOJDzZsiGZXqvwWHAN6G3t4JRl+qy7AwRTUGkrZEYvTkZBNBcWCAPjVEjZkvjf08LSSa+GapDcNXJNypBGzc2mO60LgyaydKTaCRMlvFOQPUucDO7g+kl4Ok79T8X4rTZZ80p8MyOGfU+uhxuCwb9eEkYLfWzS4UceajG+eWF4BZZZDaKS5yj3kf8Vs31vsh9Brj+2InUFrdKPnxdAjqGBikLHqugrBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39840400004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(83380400001)(31696002)(36756003)(86362001)(66946007)(8676002)(8936002)(4326008)(5660300002)(2616005)(53546011)(26005)(38100700002)(66556008)(316002)(66476007)(2906002)(6506007)(41300700001)(6486002)(478600001)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDE3TkZyOHNwK0ZXUk04a3NpUlZic0xhOFN5RXFaYzZmZExsY1ZWbmY2WUkw?=
 =?utf-8?B?OFVibGFVd1ByVzRENkZHT1FrZjhDcXQreW9GTFJraTc0S1k0MXpmem1iR3dm?=
 =?utf-8?B?bFRaNzdLdmFROWNiUk16M0p0dWxRcmdKSnU2NElpSE52dElBUGgrNzZiNElT?=
 =?utf-8?B?YWF4NUxoQ2gxSENac1RYT3BiaG9IajJXaDAvU0EwS0ZjYkhmS2IyOVFRVy9l?=
 =?utf-8?B?b1pWWkxRalJ5VHNJQ0ROelhmZkg4UWd3b0VXaEJpUWNPTWxscUNhZnFuU0xq?=
 =?utf-8?B?d0dhVWlPN3lhSDAwS1BSaUNtTys2dldaa3JsWERhK3MzMmFCRmIyTEpFUUd5?=
 =?utf-8?B?QkJsVjU1bmNRZG1hRXorYUpvZ2QvV2tNVVkyOWk0SnZndTA3eGM0RHdYR3dz?=
 =?utf-8?B?SXpUa0IwY2Z5UFVvRWFHcXZ5bnBYZGorQUNDR045YUpJUUVLanV5R1pENTZI?=
 =?utf-8?B?ODE0Z2xkTFZhQnc1SURqY09KOVlWbkU0Z2NlckJsNjVzWmQxT2IzWjhBdHRG?=
 =?utf-8?B?NWVnMUdnckE0ZjN5bjRqQXVaVHdacjArZ0sza1MwWExvRTZLVjZ2N1Qwc3dt?=
 =?utf-8?B?d2hwQWJiTDcvUktHSFF1RGZNQS9pYThVR2o1Sk5vakdaY0hvQy9kN1RvV0Rk?=
 =?utf-8?B?Y1ZMUDM4ZFdyMEt1OWZXV204OG0zN1NSYkZxRW5FWEM4ZlJveVIzSTBtczM3?=
 =?utf-8?B?YStOd0drVVNPbGVCK1FleENKUitBTjVONmxqR0F2U1p3NmN5M0h3RnZ5SEZK?=
 =?utf-8?B?eFA5dEwwMDRmY1F5dlg0ZWJLTkE2R2M0dVB0MHFqT2U4eG84VGxaN2ZNa1lK?=
 =?utf-8?B?QVRSMG5TdmptZ2hmV1hyZW1kdnpkbkkrbjJPQjIrZ1BlOUQ1a0ZucnVYRmtF?=
 =?utf-8?B?cVNqRzZoSGd1YXRYL3FRcGszSWxrVTNQbFVHK3JpTDYzQXhFRjU3bks3UldB?=
 =?utf-8?B?cDE4cmMrNHhMOG5MaEJZNlVNYjg1b0N3Z0ZNaUYxT2czcUE5WW9mNDhJQnpo?=
 =?utf-8?B?MXovTElmczVtSVdZUlZDbzUyUHYyNG0xOEE0QnpuZGZWdkVKTEpBSC80L285?=
 =?utf-8?B?WVhhUUNLbXNYVE81Z2VHWVFMMlZPV0crVndidHh4Yy8xWXdNUm5ZbzFYdkp6?=
 =?utf-8?B?djM5aC9qYTFHNUMybnl0cDJWVEtJbU9MTGFiNlErUHNZbktBV1RLenBjbmlB?=
 =?utf-8?B?OVNFLzg2V3RZOTRRWHF4dVlXS0c0TVRkcDZUZWx2Q3Btdm1HTUc1YUh0RTNF?=
 =?utf-8?B?TkU4NUdBSTk3YUJ0bG9WeEtYK0NTaUJOU1RIbFZNU3NITFJzUjhibmVwckpK?=
 =?utf-8?B?M0cybFFLMkQrOHdNMU9vdkxPeGZFMUprakdQOXZVU0Q1WEZoNWNMem9lMEIv?=
 =?utf-8?B?d2xnbCtweUhsV0hLWU1nZk5kSEo0RE1NUTMyKytaV3I4Vm1IOGJIR0tDcTc1?=
 =?utf-8?B?a0kyc0lHSlFhQkd5ZmRnQ3hQaUpKeGpvOUZEME9Ba20vZUxjM2l1WmRwRWJB?=
 =?utf-8?B?d2hEWnlIN2VNdk51d0xLZlE5SHkyT0YvMkRBMFNmeHV1d2hpYkloNm9kaXl1?=
 =?utf-8?B?M1Zkdit1TW0vOHIvaUtmYWxjb2FaeFdTc29JREpERndPN3BCTUJkbm1RZndN?=
 =?utf-8?B?VUM3OUZrNW5ETDBxcFpxaTZKeUVNNklFeTYyNEtVU1M2YllzU01YZVRCK0RG?=
 =?utf-8?B?Z3U4SXQ3ZFFTcC9xZFg1WlhqT2x3Tmh2SmdMR3ZVTkpaWHN3OE52VnY0Tmkx?=
 =?utf-8?B?VlNvS2Q4THBmdUZjblZIWFd5bEtsditYVXEzVk5OcFA1WTBKR2UwU3gya2ha?=
 =?utf-8?B?Ri9OdHd0d3hTVnZ0U21oalJsRnM0b1RVL1RiNHltSHl4aThHK2VZYzlwRjJN?=
 =?utf-8?B?Y0Z5Wm44ZWFRd01QSmhabnlHdmU0TlErckkrdkdDcWNBd0xObUhRUk8vM3Vp?=
 =?utf-8?B?YTVmZ3hSWlJpZEQ5bGpEZmZ3c0xyUkNZVDhCbFRTT295UHRVeXlNR2J1S1Z2?=
 =?utf-8?B?dlJvVldkTlNSRVVPV21IOGIzYk5SZ3FwL1lYSUJ5UkM1RFIwaVZQRWJXcGJV?=
 =?utf-8?B?Z2svSHNtNHN2SDdOMmQvZ1crVWRzZUN4TGRYL3FTVDg3TXZaNUxjeHNFanNX?=
 =?utf-8?Q?4PWnOXNQIA8rL+MiKCVcZoakU?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f511f97c-6bcb-48ae-c517-08dc16a0b312
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 14:37:43.5976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzZeGLp6qbMBwXLAVm4rO76pPRcZfNFQf7JD4LB5sUi2mnVrzmK12GSHyeneasUt6CKpw9YX6do0g1DqGQyoNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8102
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
> All the checks were fixed to work with used bitmap. Create used bitmap in
> parallels_open() even if need_check is true.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 0ae06ec0b1..f38dd2309c 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1421,13 +1421,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       }
>       need_check = need_check || s->data_end > file_nb_sectors;
>   
> -    if (!need_check) {
> -        ret = parallels_fill_used_bitmap(bs);
> -        if (ret == -ENOMEM) {
> -            goto fail;
> -        }
> -        need_check = need_check || ret < 0; /* These are correctable errors */
> +    ret = parallels_fill_used_bitmap(bs);
> +    if (ret == -ENOMEM) {
> +        goto fail;
>       }
> +    need_check = need_check || ret < 0; /* These are correctable errors */
>   
>       /*
>        * We don't repair the image here if it's opened for checks. Also we don't
Why do we need it? Most likely we will have to recreate it
on a error. If there is some sense - we need a real motivation
why do we need used bitmap.

Here, at this point, we have already detected that there is
something very bad happened and we can have too long file
or something like that.


