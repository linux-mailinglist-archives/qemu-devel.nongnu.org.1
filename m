Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 646817DB565
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 09:46:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxNuS-0007OJ-VI; Mon, 30 Oct 2023 04:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qxNuM-0007F9-87; Mon, 30 Oct 2023 04:46:03 -0400
Received: from mail-vi1eur02on20711.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::711]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qxNuK-000651-E6; Mon, 30 Oct 2023 04:46:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=No0SdmuFt+euqua0pDj7mPZ6cKfdRAwHl3Q2WWk3rUUGuNAiAMP1KNt6QjjkjOtErNPIEVEW/mngb4htmnAmDqudeJWU8dRTt4UxlrOsO5MwFoq05BKEPH76AukAEewHrFscNpzu0x8QcDapN6n6ozILTozg8Y3OMQ1duFwALQl6fXu+FJELffYlba3dAlXMcJJymGIeCigGizld0cHFUIIFbQNlRJQQjfeJjT6ROTZI/6eJ6fQRq7DKwTS1XUqE9SN9fWKa5/0ooSCpKV5NfBQTeB9TUSku4bwDpXw6+lvxFjc33W88gz7jYJ2CtgTxMyvZA+OFEHdJQ801H9ygrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1fBt8S4/R+gRfrP2CSocILq6W2zS2tbPucl0S7QYDQ=;
 b=Wx7Qkuiil80TnlBIAHVFs7RH5UzJGOMiRTCDW8LPMlWMu+lll+UpxrEsBDIEC6xAmBNwlYI0jT8JgBYfnA3D/e7XI2+UctTZIqen0W05yQ4GENUYorrjcUjYyxWSeGMw63JDWstjA/zHFtRpGEwrguvyRBPb4QmrQ4txmaow5ngi04X5DvE0IARtXeKYEL0+iRJZJv4aizIWTG9t7BtpgOeABRzVOBGbjNgZuFGq6kvE8M2UTT3b62bbch6OIIt0Ya5ARPx5vxmuCu9aj64uJD1vAmL9Fq5uZMqn0OTOJqAzlgbvsXgg3apxIPwUvxaSbtqtnWfcLsGFel/fdu1Few==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1fBt8S4/R+gRfrP2CSocILq6W2zS2tbPucl0S7QYDQ=;
 b=RMP8xQCHXSoIsuSTCMMLiqinvzYEAKHCLOoE+lWpIzytyE3dXTO0BhKoKs+3i3OZO38HDwUGseL4oiScCi7KEJrIz4cdQuSHdlrecXMvpWsvPYoRCoIHHkyV9duzvRl8CBJeJD+B+4ryk2O6VgAHqMXqovfLXmHp3H7XQHOu7zsdS76GgBrsy6tAHs19hgRktNBHTUlmpQ0EUsoxpMgJsOfmVfVSx4VLJcTjYM94tIkKblqiwxx2vqUnlrJnwiq9EeCDqHk9HdB4AkwOeba6WQ+p/bNds2rsMVvSvr7IJcuqDWzo+Uu8Aus0d8Tpj6O6mlTwyiaf5jAWK2WzpaFwig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by VI1PR08MB10200.eurprd08.prod.outlook.com (2603:10a6:800:1bd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 08:45:54 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254%6]) with mapi id 15.20.6907.032; Mon, 30 Oct 2023
 08:45:54 +0000
Message-ID: <dd3d2e0a-c5e8-4b76-83af-3f9ad7417385@virtuozzo.com>
Date: Mon, 30 Oct 2023 09:45:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/21] parallels: Move inactivation code to a separate
 function
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
 <20231027074636.430139-3-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231027074636.430139-3-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0094.eurprd04.prod.outlook.com
 (2603:10a6:803:64::29) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|VI1PR08MB10200:EE_
X-MS-Office365-Filtering-Correlation-Id: a778a865-149b-4aa7-2a78-08dbd924a0d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUYrKALokZOLfsuYU7qnW4rl/TRTtm6I5NgOHp1vhRgdup9pA/i8IVdUfwPELwEqr51UPpCUCZM9peI/cx1BDb251p6wsmE+ObEl6Gu9Qif+OFJl3Z/Bjcg8Ui1kLU7/Fs0iCiwDT7e03ZNiz49N6Fu9b9IjlUdUoiTsgytR+LN5w2XHcNN2LdiEgO0PQsrFjLQr+VItAnS+pE7s6v36/M3w0Nwu/ry2RA8wj6bijVENUCggQNB/brJEJFtKW7wUssverws+6S+4CHvBbipCYS7agNGMQ9iB81XQczzggYLW2tuqyq8zsdn4yWd6RhtttmKUIf1krMu4G07iutksiZVgaGWE3Jc5Iq3jEnHRFQaDWrAP7Q+aKl02XCdcbjJYAUCG1VoIQPcmVKLW+3PNHT1XigzHnHjSqIZeu+slksAleaddU0DPlSqtfm5JGU9y5PsfqHpb/CHzmNxjsAvLakF2tE6t07KS/hO3SwtjHb3JOYrN5MtNtDrS+czQEofdk4i2SWjf3wmDZ4NUHrbDZ4eyt4qaUIPrVV28A/EUlkqeAyBqiV+L+8OLwyHWkjQ1IkqKRIOQQ0rpSZ3bh4YQte6fak4OSgTwxU8rk+WMk7o7Ht2aicY4MplNue6czASVMrFQtdjVoFpXZn7WHphlNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39830400003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(5660300002)(316002)(66476007)(66556008)(66946007)(26005)(2616005)(41300700001)(83380400001)(8676002)(8936002)(38100700002)(4326008)(53546011)(6512007)(478600001)(6486002)(2906002)(6506007)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVUxak5XMDdUcGl6UWkwSXpQVjZPelFLelVCK1FPTi9zbmg4VnZPclR2MnFZ?=
 =?utf-8?B?ZUtPc01haFVwNWk3ZTBjcU1oT2ptaVdLL2wya2o5MU1mUXRPOXc3LzZUeFJE?=
 =?utf-8?B?ME1XWUpDcEI0K1hadnVZVDBITjNxZFRmZnk0QzNybkZWc2pjUGQyZ3FVVmtw?=
 =?utf-8?B?N0VKNzZBbnMvL0dxTHQ3Y3RJanQ5K1NCdFc1NERRSXpidjVSbmlycEt6b1VI?=
 =?utf-8?B?Y3ppUUhmQlhOcnlKQUtGZU0vR1VRQUJRMDdManIrOUNrcDhKVlhPVlYvRnB5?=
 =?utf-8?B?VDgxWWdPbEZMekJZamR3V0tiSmFCZUdRU0U2VTNtU3lkSEI0NWtraktva2ZC?=
 =?utf-8?B?bngwdHZSUW4xeE1VSitoT1ppVW8zaXo1VVJBaVdpTzlLR0JJdkVrZlZ3dXBw?=
 =?utf-8?B?RTY2UHN4NnV4ckdJOExLcEVHTGVJYlF6eUVMbG85VWw1UXpiRHc0U1lhbTNl?=
 =?utf-8?B?T0xUVndBYXoxSmNKb1FpTFZCL1JiV3JkZHBhLzBtK0E0bVhMMU5iOE9XUms2?=
 =?utf-8?B?UFhsK2gxdHNJVkFNTXRmK0VQQ3k5alBxMnZjQVlqYnp2bFh6S0daU0ZIa2FG?=
 =?utf-8?B?WG5ybzF3QkpDWWJSaUNRWkVTeGZIMlNDK1ZwQnhDdWtaQnlJOGxUa1lRWXI5?=
 =?utf-8?B?U1F0ZG4vMXVYUWdLdXhnbkpqOWVKZXdVbVhGeVQ1L2ljWlNjU1ZMTzd0dk5N?=
 =?utf-8?B?YS9ZODYzV1RMODRYU1FhYnlyVjFDRjRkejN0MjJWcFRrZHo5R202Y1VobGVP?=
 =?utf-8?B?UlVMR1M5M1htd2VrNndLRjAzYzhYMXFBQXEzVG1xdDVtN3U2TE5KdFV3ZDlq?=
 =?utf-8?B?YVZLRkFFSURKRU9DTWh3dC83QTJoeVJScVpacmVCNnhVcVZZZ3dBRERaVEcx?=
 =?utf-8?B?SkF2TkdYeWJ1ODY0KzVFdGZIMXFHbmxwRElYdEJZd2I3YUh3aHVkVm9zcWtN?=
 =?utf-8?B?MHBoMnY2Um5udVgrK05kSmdtYTgzOEI5dE02dHMydVZwam5CZENqTEJPSGlq?=
 =?utf-8?B?NUY1NUswL2ZMUkVGQ0dnQ1hwcERSSW9vOHc1dVJVc1lDRmRvWDBwdWtmdUV0?=
 =?utf-8?B?QkV5UTNoMmptaWM5TFJsTWZwQ0FoSUx6MWxQam9uOC9HYTlHOEl4U2UydWtz?=
 =?utf-8?B?aTE4TUNLR3V1alMzdXlBazMybllBRzhCOVVHYUpVS29NUm5QeGdpVmduTHBE?=
 =?utf-8?B?d0VFUHF2cEt0WmV6WDhlWE1leUdKRHVkRzZJUE9iSE8yTERZdmF1T1VWNllz?=
 =?utf-8?B?Q3A0d29sWW5tQm1ybFU5ZXI0MEtmQnhSOWpVcyt2Y0wyVEs4VldyUE12Z2Nq?=
 =?utf-8?B?WDZDUGRteGYrSG5qZkFlRXhRcFNOSGJ4dVFYK05PeFNmM2hQeWphWlArZFJZ?=
 =?utf-8?B?WUFxSytwdU5VUDZWK0FYRkQ3a0NBa2VpemVhcDh3amlwemFQMjl0dWdnVmxj?=
 =?utf-8?B?b0tubDE2MjI3ei8wT0VuZG12QzIyaVFuVUpPQUhsRzNNV1UvUE5DTDM3YUdl?=
 =?utf-8?B?c2JjeVBRY3VNMEJ3WTA3MTJuVUw4MThoUUZYeHJCUDVXUzc1ZDVmVnQ3TmxX?=
 =?utf-8?B?Q2NQVmY0dFExcFd3bkpVa0gxUnZOVUVvdENnaTZ4Zk85SG1KM1BoUW1TTkkx?=
 =?utf-8?B?UVFiMVp2dG9EZUtkQVdDT0RncDlUeEJkd01hT0RYRkpuK0VHM3Q3SXczZ0Fo?=
 =?utf-8?B?RXRNcktZNWVPQ0F6dE5oRVdZbVBWOGxHKzBnVmh2dkJIUUw0RVFFRlpSZFk4?=
 =?utf-8?B?UkVzWG1MSks0ZERucnNGU1poMGdyT2s5akNjbFFMdjZ6cm1zSkRPZG9sVTIx?=
 =?utf-8?B?elE3bjhqYVcyQ3JGZ1huVzFNUmpRdC93OXl4bzBGMzh6UU1yakJtcko2c3hz?=
 =?utf-8?B?TEdVWWZydTBtTGtyMkVPUGtlbm1zaVE1d3JKS0U4dW1tZWQyZEdzam9zTzZQ?=
 =?utf-8?B?eXZSLzlIL1A3Q3BqbjM3TWROR0lFWStPeDRkNnVUSFYzMExLTi82akxzaWZ3?=
 =?utf-8?B?VlZnZysyZnA5VjFYSHI4K2g4V1BSQUhSaHF5NG8vZEVYeS93RVZoQjhnU2lw?=
 =?utf-8?B?R1NOd1pWd2wvdlUvZ2JMeC9BQnFhbzFmL3VQaGpiQnZ5c1lJdGdZQWZsaGRq?=
 =?utf-8?Q?mbGLbyC13kMEzrwwT35Sk4rBM?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a778a865-149b-4aa7-2a78-08dbd924a0d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 08:45:54.4564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deeijx7XveXua5XXJ3gplpSGd9DN6W/9JlnZpofkoW/hVxThowH/0A1JEZ24Ydxpgkq5q/GXd/MizMsvSzPVPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10200
Received-SPF: pass client-ip=2a01:111:f400:fe16::711;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 10/27/23 09:46, Alexander Ivanov wrote:
> We are going to add parallels image extensions storage and need a separate
> function for inactivation code.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 01a61a4ebd..8962bc9fe5 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1428,18 +1428,27 @@ fail:
>       return ret;
>   }
>   
> +static int parallels_inactivate(BlockDriverState *bs)
> +{
> +    BDRVParallelsState *s = bs->opaque;
> +    int ret;
> +
> +    s->header->inuse = 0;
> +    parallels_update_header(bs);
> +
> +    /* errors are ignored, so we might as well pass exact=true */
> +    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
> +                        PREALLOC_MODE_OFF, 0, NULL);
> +
> +    return ret;
> +}
>   
>   static void parallels_close(BlockDriverState *bs)
>   {
>       BDRVParallelsState *s = bs->opaque;
>   
>       if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & BDRV_O_INACTIVE)) {
> -        s->header->inuse = 0;
> -        parallels_update_header(bs);
> -
> -        /* errors are ignored, so we might as well pass exact=true */
> -        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
> -                      PREALLOC_MODE_OFF, 0, NULL);
> +        parallels_inactivate(bs);
>       }
>   
>       parallels_free_used_bitmap(bs);
> @@ -1478,6 +1487,7 @@ static BlockDriver bdrv_parallels = {
>       .bdrv_co_check              = parallels_co_check,
>       .bdrv_co_pdiscard           = parallels_co_pdiscard,
>       .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
> +    .bdrv_inactivate            = parallels_inactivate,
>   };
>   
>   static void bdrv_parallels_init(void)
Reviewed-by: Denis V. Lunev <den@openvz.org>

