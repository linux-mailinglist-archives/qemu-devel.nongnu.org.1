Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B1681E002
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 12:06:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHilR-0000Uj-Qm; Mon, 25 Dec 2023 06:04:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rHilP-0000UX-O3; Mon, 25 Dec 2023 06:04:51 -0500
Received: from mail-ve1eur01on070b.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::70b]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rHilN-0001Qz-Fe; Mon, 25 Dec 2023 06:04:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3f8XQ2uoeE4XF7PNNXCsnk0LDOJaEB9kzko5SkOjR6G8ZwvzsmQBqYIx2nUxrraZIyGkRjGB5up0/tcWTbw66cN4cUeuELWF+l/ZiFaZbRWy8au4nCxePspR2rKWcz+pJK+IrGA51Gtm+U9+jb2TuL8laoIWJ0gkRX2RCyOxS43wOz3ID2YaVGH/qusNKVroXQ4xP+IijKiwpfBBEZqCmHAlJCt+lLdGXqxrknGWW5ZGrQh95kLjj0wnReAK9oRQfADgy4fLdMt7OZBb+SAFFxtBnLbwOxmGuEPoNdF+wMdXuzk1EHLDSzFo/TSElA8NBjM5oldbItLRGgwXKgQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkB1ns6mo2qkGoC1KKg85Ae/1spEktEvmXFpORlgoS4=;
 b=HNX+orKmNC2PHdRkv75aUTvh8bkOfMvYHDq3nW78VtYU6+m7IVgzDNSDcvpDRAUJXrOy2YI//33rtRWG/nDR7VAnh1Xe0YCkxb6dn5Y8TFXuyD1ktWPZcU5tGQUXIljJY34fSG4u4uDkTaZhltYn5W3TbVQqnGYTpV+sORQX3WI+gaOqAk0Ll4yRmsL07Ynz2F2iTX3G8rDwrcbCR65YPlrXlkNuxdHvU210wGiQJvpd5NFhlq56UTndq3GJbeaNzd7K5/vu6tNwDqW/e/OCkaVo0h2Vrmvf6dGMbI67bbvkmP8pZG1EVD3vBjcOvZzv4MM896wAfRUT10HP70PFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkB1ns6mo2qkGoC1KKg85Ae/1spEktEvmXFpORlgoS4=;
 b=SIA7/8MrspbBt53Kw+xpoiM+zlL9m16l6dYN3YNA7cyKEeDmiS4mHV0cSm7Rz2klK77+S3tMrx4UO2ntp+P5j5TdLW70pt0A1b9Xu1q7hz4shalikW7FVtNPTWpINfrtKOuC76enUfCVNO/HJQXe+6NB91DXUEdtZrjJYIg38Tmocwx+iB24DM6sY4RiI7roMfimuF8GeBLq7DcFu/St6p0MBXLof4oIDNkklpIEs5t/otn9v1BItNctnNBqqHVsHXzP57rkbZoatz/uTQttKHu1UPHehlsr9DFhoEeAxpnyDJSRA/Ft81pAHQzx/PXmMpHwg4126oRSvX8y3m8tBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB9PR08MB9441.eurprd08.prod.outlook.com
 (2603:10a6:10:457::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 11:04:43 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 11:04:42 +0000
Message-ID: <e4915aa0-692a-4681-b6a0-f07a9f32842f@virtuozzo.com>
Date: Mon, 25 Dec 2023 12:04:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blockcommit: Reopen base image as RO after abort
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
References: <20231130101104.127356-1-alexander.ivanov@virtuozzo.com>
In-Reply-To: <20231130101104.127356-1-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::11) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB9PR08MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: d83a666c-3d02-4c7a-8650-08dc05394b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Umx3IP8+/qdHEbqqYwvdC9jidSEli+HAWqi+8By5h5EGpg4mALPaqBtoVB5UyH8lFlbbXFIr2sAR7eCIVjBnNbJ9fxNzlF8HmgF/VgWgo6S+xyiPlIpRBGwO/Cv94xFb+Ph5yv5KBVZdeVGU4aPRloqJELE0p5pJwpu7F0Fz2G2uaT2kjhX0CDWJM/GkJLqFWfYsAYIW96/QjR4z0d4a8d9VLOttoQWbwjARHZvDEAWohIaBDbJiiCj6sWPeq54ZHQp66yuYe9uwNR6s7ZVUHGY5yYiSmfaR28lj5YVQIsV5OnttKCNttz/IIF/TU8CNTThomCvB6NI9PBHrP+QDkEiLbLjqYLkZTzEPY8bnRr5n02x+zS/Bg2SIxHFr52LT9IRrUYcMZM8vPyygO0dgzl4BUD8xt1JntxIbbzaDCroRQvYOtVW/IOkfkJL/wsZGldIWsMddblyZt22C0PeP0svJdnAmet5Kg+nstANGeGVPtzSlfuJKxcYn/CnptrWm0lmKHt0lpT5MrKCGZ1BXBHwild9fvdneXzRa/xP+YkGKAyeCZ5xmBYb6/XWN6ezJFhfH7Z3sJsUzdS310wBjhy3FRjPk6NUFGYYlrZsozwJqfeHwgXF8/xV4y17UcTo2C85AXTqL6/ZXTy3VHCvoAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39840400004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(26005)(2616005)(53546011)(6512007)(6506007)(83380400001)(66556008)(66476007)(86362001)(8936002)(31696002)(6916009)(316002)(8676002)(44832011)(66946007)(4326008)(478600001)(6666004)(6486002)(38100700002)(31686004)(36756003)(41300700001)(2906002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk0yWlYwbXIvZk5xM0ZjK3ZlRVBHbVJxclpLT2svZUROQm9HVlF2THR6OXZs?=
 =?utf-8?B?clVCZGd6RkFpZWQreHBqWlYyS3c2OVFVdjVOd2JidHJxUWFZQy9odnBadDVh?=
 =?utf-8?B?ZlRRTHJMajR0TEY5aURxWVBoamVTdEhXWUx2QkNFRzZHUDdsUUpwTHE0UlRT?=
 =?utf-8?B?d0crRCtyU3JhbUpuK3BFRDFpc2dWcU5xTkVYS0FPRyt1ZWNNbWtIbUdLanZv?=
 =?utf-8?B?VEd3all2bW9vemZzd2ZjQmxCTXgzSUJvZHpFVEtjSUQyb1UxVXdnUXRkb3RM?=
 =?utf-8?B?Q2Q1cFprSVU0TTRRbjNpdDJjMHBBdG1aaHEyNml0Z1UrbWYxOHBOSk9XZGlS?=
 =?utf-8?B?a0NGQ04vRE9FKzBPTG02MXdlYUVCMkhIazBDY1ZDMXk0UTh5NGRRU1RleTJ1?=
 =?utf-8?B?UWhxUHczYW13emZtSGZYNldhTWEzYzlFak5JVDhnTHBvZE5LOFRhWHV4Zytu?=
 =?utf-8?B?VktPS3NrdmY3cW41T1NBKzI4UFNGUW5kWDNzQ0J0amdVcEc1RGcrYUIybjRS?=
 =?utf-8?B?WTF3WjJVTGk0MC83c2U0d0lheWxHZ3FoLzcrc2FVWkZQWXBETjBiak9qWXJU?=
 =?utf-8?B?YkFrcmtuWEN2ZjA1bThjWlc0SzNMaTVKTE5zZGZVc3dtL2Yrc2lFd1AydjYr?=
 =?utf-8?B?MStUNC9sL3cyYlVxTGE4eXNrMHBZamhxb2Y5TFo1c2VUcUo5QlIwRFZsR2k1?=
 =?utf-8?B?NDNDQmVub2RqaHRWSm5WNnAyZXBZc2JweVlHUW9xZ3I4dUtlRklvWm1BanRR?=
 =?utf-8?B?eXE0a0dtd1V2NVNmTTZsNG1uUTVTbmloQ2Z6N2x2b0tiNWE5R1NVYTZVS2FB?=
 =?utf-8?B?b3o3amxBM2p4bVQyK0MzemhEWEFoeWQvYkhMVS9PdUlLa1krR0xXWHk0THJo?=
 =?utf-8?B?UDR2aksyak5wZUlkZ1NDUmkvM0lnQTVvL0JNVUxYOWVReGROQVBrTVRqSW9Q?=
 =?utf-8?B?YjZJTnJCWGdsY2dMaXZoY3pZcm5vK3dKRGExT1lTb2xXZ1UvS2pSTVN3bldz?=
 =?utf-8?B?ODd5R3huMlFxWGZiZ2c2VEgvMUhsSW5xNVFWbFlEajRuTnlhRjBMNFNjeXV1?=
 =?utf-8?B?ZlFkSXRxU01ZOG9lTFJpeGZvQ1cvbmo2NzhXWlpQaTFHblBxZXhpbHI0N1gx?=
 =?utf-8?B?bTNZaWtMNXJaRlhMeW5sdEl2TGdYSWFvL0tNZnIvbndyd3FzRitGOWhpYnB0?=
 =?utf-8?B?b092WEEzaXZla0RHR04xanhIbmtFNlNoZFY2OC9hZjdMMVNhdy8wTDFZYXlq?=
 =?utf-8?B?SjhJbWJkaWdpd3BsckFEbUUvZ2ZGQ3dodE5ZSEdtakkxZUpWdjhrL1F5YmtR?=
 =?utf-8?B?R1pFV0JpcklnOUUwK0g2cTAydGFZNW9yeXV4RnUvNGk3S01QR2VVc0dRRkh1?=
 =?utf-8?B?S1dWZ0psNEtKL1NIdVF5aDhqZVBGaFQvanNRVDg3SFE4QldqMU9iZHh0Ynht?=
 =?utf-8?B?VWdmSlF1RHpFTHlLZm13Vjg3WUhGN2Z4SFhVMmFNNk9BZ0dVa0VqV2FVbHh5?=
 =?utf-8?B?ZmsvWHlKY2tiNjJSd3FlVlNCRC9paVN1aVlGUENMV0Q0cTV2TXZvYzUyVlh3?=
 =?utf-8?B?aUFNUUtuUzFDUG1qZDNQOWNaOGJraDYyeGFqWitTVWE2dlp2WFRIdjdTWFJ5?=
 =?utf-8?B?TzJVTm5sVkN6VlFDRmhhREs5TWxEU0pPVUZ5UVBONGZsQWthYkd5ZUNhd3F5?=
 =?utf-8?B?eXhwNHJXL0xjQ3JoSFpOY2NmQ2pSWHRqSjFFMDVycU9EWW5OMEZSZW5LNG0z?=
 =?utf-8?B?M1hEVDZBVVhvQlpCcXJySE5PSlhRT1RSNnc0eUlrYXZ1V21LMWVVQWh4YTlP?=
 =?utf-8?B?Q2J4cWkrU1ZpeFRnM3NHRm5oUjA5bmJVODJUdzg2Z2FhZ2V2cEk0ekRDTFMz?=
 =?utf-8?B?RXdnb2JzclRzQ1NvZVliMkhPNjVTeWVLWlc0NGZGRU9xSlN6Yjh5THM2OGFh?=
 =?utf-8?B?c1FnZlBIZGliSTJmd29QYkVxdHlQdk51dGIyYlRoWnRQYlpxWDJPK1JrODlV?=
 =?utf-8?B?RE9relhkdXJENFZUZ3NtcW84NVpVcGk3T3ZnRktnOHNPdFUxUlBxZU1FQlN0?=
 =?utf-8?B?N0Fva1R0dmpmdmd0MytnY080Mk9xSXJMdGFVMmllZi9OOU13T2VzZlIvckRv?=
 =?utf-8?B?UjF5WkJYam5MZ1dzUC9FOCs4ZW84NEZtSUkyQ1J3dDhIdnlDYVNuUWpGSVVD?=
 =?utf-8?Q?bsY/FrKkJdI8JPCRJgMnw0g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83a666c-3d02-4c7a-8650-08dc05394b78
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 11:04:41.8558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9TsXa1NSBsICUmCoEyoUKLfkeTObJFWrhH54Kuj4h0UTJuLpIGJhz/12mGe/Wu+Uz7X5F8bZ6X9MD6aSz3jZeYcm9m1CBrO0AqZrUoibGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9441
Received-SPF: pass client-ip=2a01:111:f400:fe1f::70b;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
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

Ping. Could someone please review the code?

On 11/30/23 11:11, Alexander Ivanov wrote:
> If a blockcommit is aborted the base image remains in RW mode, that leads
> to a fail of subsequent live migration.
>
> How to reproduce:
>    $ virsh snapshot-create-as vm snp1 --disk-only
>
>    *** write something to the disk ***
>
>    $ virsh blockcommit vm vda --active --shallow && virsh blockjob vm vda --abort
>    $ lsof /vzt/vm.qcow2
>    COMMAND      PID USER   FD   TYPE DEVICE   SIZE/OFF NODE NAME
>    qemu-syst 433203 root   45u   REG  253,0 1724776448  133 /vzt/vm.qcow2
>    $ cat /proc/433203/fdinfo/45
>    pos:    0
>    flags:  02140002
>
> Reopen the base image in RO mode in mirror_exit_common() if the blockjob
> is aborted.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/mirror.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/block/mirror.c b/block/mirror.c
> index dcd88de2e3..50a2825b1c 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -789,6 +789,10 @@ static int mirror_exit_common(Job *job)
>       block_job_remove_all_bdrv(bjob);
>       bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_abort);
>   
> +    if (abort && !bdrv_is_read_only(target_bs)) {
> +        bdrv_reopen_set_read_only(target_bs, true, NULL);
> +    }
> +
>       bs_opaque->job = NULL;
>   
>       bdrv_drained_end(src);

-- 
Best regards,
Alexander Ivanov


