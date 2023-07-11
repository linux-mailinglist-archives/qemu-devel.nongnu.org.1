Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 839B674F775
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:47:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJHQm-0006qQ-IS; Tue, 11 Jul 2023 13:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qJHQa-0006fT-6s; Tue, 11 Jul 2023 13:45:32 -0400
Received: from mail-dbaeur03on20717.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::717]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qJHQW-0002JQ-Gj; Tue, 11 Jul 2023 13:45:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfREvrcqX4RCvEDwZIyacBMJ6hEsDBrRmQ+NleQj68ukGTN8u5cOEuJbFTaZr3CG70ab6CaRlUmHU1ieh556vszeBYsiIGZes09fzhfr2WeWH1fWHFB3sxEcw7cjjeTLdQYs5RKP7ltbdXHBbXQoEELtxCY+NK71N/6hFQ44ccjup1hh1s1rRx7PkY2BP0mquYcaSksGbcCfKa5ZCamQ/BpIxaGOo3vMf3f7DcpduIHREZFPA0bmqsWX0K66+6jE/p438YBWoiQJKKcuMgP60Iljav9FBhPaPKcNLduEWguvyjKj6mGpYjgZn9zCWcKnMnc9hagbR32pdc7DOYHCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0tozWtlRy/WxaM+g7xez1N17W5k17v6M7HUwjQ17IE=;
 b=YPCf2LS14G/rr/3DIO4wQBecUKlLCVof0q4jXB9qlN+FNTRUGhU8Ukggt4X/a0TmsJK1iG33MtrXnNRLRK5xYkh1ESwsUot7Qk9Des8ONjRE8gXU08NY/XPzKabXQO1xAf8L3tGKkb/eI9jC/ktNQI94UUL1YEVhyouSRGItjYhbr5GLvBXUjYN8Pqr2Ju3O1EEqvqI3MPQXb3wnuik5J/vI8Bf5iLx+cvjroV5Gt2ggSbfQlbjgWP00AfM+RK73gxMmTfjuTrWLGaQtB3HQOoRIKArHyKvvDXqJKhN8ZRZIqtlWStu2ovCihy37dkeFa3pn8pv9vZM2d+XKPO27Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0tozWtlRy/WxaM+g7xez1N17W5k17v6M7HUwjQ17IE=;
 b=gLUtade7HOGl5RNUK4jvhCDBI/eAgce959jSnrstg3O2hrYnvfFSwqSnYJo+DbmmWnsF3nTyhWr7iaDjI3wDqmrJbp6YPLa/I0RHjdfI2RQU6IVLxvw+Q8RVxIjn9MReTV3d4+gIcRJ0AaUDQ0JXcDsQQxxZUlq7TYUCu1J7cJJhROLTHDxOUkYdjWjOyJGNuLXQwa7O+DoXkrtpbrj8J3MCF4Px5Yey0WaMwXiZX+6SKuYKcDE4F7snMvJmfqHMACfeeZ4rhxJ2REVutE3Uw+EciJPipIeZE/CXyDfxrcS1J5zq+ShF1MtYO3+yZFRoZQfFPLqA20D+QH+2afPdkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by PAVPR08MB8990.eurprd08.prod.outlook.com (2603:10a6:102:326::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 17:45:23 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::c9c4:b136:a31a:bc35]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::c9c4:b136:a31a:bc35%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 17:45:23 +0000
Message-ID: <97713bc3-6018-3c3c-f95e-bdc100a159e0@virtuozzo.com>
Date: Tue, 11 Jul 2023 20:46:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/3] block/io: align requests to subcluster_size
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 kwolf@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 den@virtuozzo.com
References: <20230626160834.696680-1-andrey.drobyshev@virtuozzo.com>
 <20230626160834.696680-3-andrey.drobyshev@virtuozzo.com>
 <5ogsrhiwbo5u5k4a4mleyszoolr7stx56kj6bcwysoyfg7crzw@lhm7o3l3wmbn>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <5ogsrhiwbo5u5k4a4mleyszoolr7stx56kj6bcwysoyfg7crzw@lhm7o3l3wmbn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::19) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|PAVPR08MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 617e26f2-c5e2-42a6-e2b0-08db82369a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ir4d0M46n5ygIjzbYCN+iBIs8nm51aTL+YoHhbX75fU1tFycp/fHB+jDFc1f7cPmX023KTKGbXwtqSmVM+UWp6MotSWtrELKNHXUHUkci6s7qxW6RnYJ67jMQq4wggJePy+HsEfkQl8uPgbwzXqnlVEOe6/Ui8Pk2RBAkdLWM5GyjFBAUURl/C+ZuVMmPiuQk5PNoh1GLUnpuxFAubRZT+nu4IwQDWtx6P9wtYnN8+etWDLiMxCzc7P172I2feijERwx++40/gCCSTnkPRGlfofGbR2zNeJciUGBnvaGdc8iH3hqy9K0mlSABAceQ+qz7H+f/URdSLdsV9t4i93UhHMzpC444OvEFu01B3U3idywxQ6GojjIzKrskPDIk/DIgU/BI1qHMDeYuTRj1wBAi2TI2GxjzEjdvQcReyKgzINkYPrNuIwXvBFMpJbwLFuXXuXUNWWRtLnmuY/i95qCZQU2Ka+C9lAQ+NjtWvYx2+sgV0KfCvbZDnpFWwDcJX7zG423fyqxoAAmRLr4V+6Y0vGmLNnBp9idiIv7pkNw4vrrRX4U9iybo/V6Pt5eTNLNyNp/K8j3693uqb/HUZ4YRhNxzR/oRf4KAm87VOvg6anW+xJob4IqmW+RR/IVOoVJfgAixE1GNachgM6/KGErcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(396003)(39850400004)(451199021)(83380400001)(316002)(8676002)(8936002)(66946007)(66556008)(38100700002)(66476007)(6666004)(186003)(6486002)(2906002)(6916009)(4326008)(44832011)(5660300002)(41300700001)(31686004)(2616005)(31696002)(86362001)(478600001)(966005)(6512007)(107886003)(36756003)(40140700001)(53546011)(6506007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djlGOXY1NFV2SVVlMUJINGw3bTZTZHlXbHNqT1BRczVaQTVTWGRoSkJBOFJp?=
 =?utf-8?B?M3BwS3pnNmVsWlFBazFWQ1EvZUY1cHRPRkZpTGx4aFlIYW5KQmVUZ3RGRGRP?=
 =?utf-8?B?SHFQd3pRdWpZZm9QbEJFS3FMaG56dG1jZUNUV0RMRmJxZ2FmaDVPR3d6OFRp?=
 =?utf-8?B?anRCRTdkM1B2Z1l5L0NnQ0o3NDRZS0crZjVrN0tIOEdaV0hPdWswR2dXcURY?=
 =?utf-8?B?Q1JuRzlRR3dpQkJiMC9nUnoxR3kxbGxIcTBwU1hRU3pMeG1nSzRmWEpZUjFQ?=
 =?utf-8?B?dmU0TlYxRStOWTcyY0ZDT1ovbmE4UE9EczcwNTRWTlBhT0krWE1pMnJXS29i?=
 =?utf-8?B?R1o0NmpwZmZsQk4zenYxNEM3ZllpbXRpTUhzbEdxekhKLzFVSEJsZXRaN1I1?=
 =?utf-8?B?RUswNkdTVjhTdTlMaDNpNXoveURRb1NYL1RVMFVmcGFkR09heitZQ2dhVC9Z?=
 =?utf-8?B?K1ltdDEvSFZTV1AxUEhXQ0FsWkJHYmJmcnJCN0dSUzh6dWlCQzlRN1BSWThJ?=
 =?utf-8?B?WTdLSlRxczMydENMRDkxaVNDeXdmMklhYmpoaVNGWnZlNGl5UGJXN2dza2ww?=
 =?utf-8?B?VXR1WTFLN2lqbDNmSmhLTllOcWJ2bGN6ZEZnQXFzcjUxWUt5WkVMZ2JPTXU0?=
 =?utf-8?B?dWJUbkZSaGwxSGpsSG9VYnNoeGxqK2xUZ0dHaTdwdFc4dCtBSmpEaFRGQklG?=
 =?utf-8?B?MTZxQ3hyVGhvejBIWG4zWUxnVlZ0cWg3QURxUDQxNDhlaVIxV3V6VEtzNGVU?=
 =?utf-8?B?M1d4OUZwZnVlTFM5bFZIcVJ2VXhmbkV3VWtGcFMrUW5TbnA0eUpMWTEyTnhk?=
 =?utf-8?B?Y05ETUVyZXZRcWwxNGlPeFRFOEtmZUFFL0t6NHRsYmlaV0ZEczh1V0RzQldE?=
 =?utf-8?B?NXZWK2tjbWh6Z3VuSkkyRWN4OE1adHkzYjlncEJqZGNGNjZtVGZ2RTlLVC9P?=
 =?utf-8?B?TThzcm1yRys3dmpMN0NOQXpvMk5qOHp5S1phOU82NTJYRDF1SStGY3BvK0Jp?=
 =?utf-8?B?R2dPYXlQUFJqVEEzblRHckJhZHlmMmVSWTZGYVh6OE55b3diS1htdE5hV2dx?=
 =?utf-8?B?QmFMQUtiMFZRQVpXWE5sbnpmdmZUQ3lpYWlzcFFKbzFDWVNVMVFoY2pxYTBC?=
 =?utf-8?B?TGpUdXYzeGRmZXlVQVg0Nzl3NjRFRnplNVdaUEd1aFVOSThZU1FzV0VoRFlu?=
 =?utf-8?B?SU80bXowekZFTmQrQlAraG1Qa1lubENZbnRwbkxTM3cwTmJNbmt2ckpTdVN6?=
 =?utf-8?B?MGUrRW1pWFVMS0thR05tZFFpYS9hcERxYTNndUtyaFdGTVc0UjJkcTc3OWor?=
 =?utf-8?B?TDdQcDQ3eXB6bEZmM05mVHB3SUdiaExCL1hLeWg4enpLNlR4QU0vZkl6T3Zh?=
 =?utf-8?B?eFAvSE12YzlXdmlrc2oyLy91T3lYTGZXUTZ6N0FxdFYyc1l3TXBTeGh0ZWpD?=
 =?utf-8?B?OWh1elk3NjdsSENKbUM0Z0ZsYkhHTTBIRThpVVd0U1AzVEU3LzF5NVZUOGlR?=
 =?utf-8?B?TTF4VXY3U2lFT3JzdEJGWmNXRGxoNzJNV2Z2MGJiMnFWbVVJS0dWdlo0cXdh?=
 =?utf-8?B?UG5xTzNMbmI4WEtOM2xNUy80QmJmU01ZeFFSSm9uNmYxOE1NMFdDTzhmUEI1?=
 =?utf-8?B?L2pOZmFqUmhXL1hKY25QWGlQaHdEQmdmaGp1bzZjNHlBckRseXNwaWlyY1JT?=
 =?utf-8?B?RWNlTGg1N3ZxdmhJVHJ1ZWJNL01UdnZtd1BlbVBJQVV6blZkYXlyZTRQRERj?=
 =?utf-8?B?RmlQellWTjFWTERHQzRZSUYvclVIbS80TnZiNzdtak9QSFowUENwL01EdFVm?=
 =?utf-8?B?SEZuelFQRCtXNVhQZjY0MCtzdTU1L25tcVVYYU9lUTZoSzhSeERERU1udUJP?=
 =?utf-8?B?YUE4dFhmR3JZSGJKN1M4em9QMm02bFFXN2RnK2VhamM1QmVnUHZOT3JYMWJ5?=
 =?utf-8?B?UTFJM2hZS1FxZCt3UUxNdVBqN3pKNkN5VGxtWjlkRVh6dEdURVYwRmxtTWw0?=
 =?utf-8?B?UVgwZWZDZHl6VGJpWDNoakVtWmlXWTRVbWJhNENGVkNWTVhyL2RRTUkyOXVK?=
 =?utf-8?B?N0RkekgzbzVXamZZNHEvMk5BV3FUditUZ2tqcE5OQ0M1YzYrSzFNQmk1M1Qr?=
 =?utf-8?B?RUVjUXNuVE9GaUl0UkMrWGpWNjBOS0E2YWx6YVdHMXdKcC9LUS8vN2d2MVht?=
 =?utf-8?Q?gu6VN8re9+lmnnXfceO5VxQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617e26f2-c5e2-42a6-e2b0-08db82369a5e
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:45:23.4442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4mefh7eEYF3okG2oNK1EUjHtTw0QDGgDen4CHBwTt/U9n5CwXPSgPAdR+5NKq3AhKgdhD9yD0OqBs72BXmchqcYmT9x5bdjE8R386gKPzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8990
Received-SPF: pass client-ip=2a01:111:f400:fe1a::717;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/10/23 22:47, Eric Blake wrote:
> On Mon, Jun 26, 2023 at 07:08:33PM +0300, Andrey Drobyshev via wrote:
>> When target image is using subclusters, and we align the request during
>> copy-on-read, it makes sense to align to subcluster_size rather than
>> cluster_size.  Otherwise we end up with unnecessary allocations.
>>
>> This commit renames bdrv_round_to_clusters() to bdrv_round_to_subclusters()
>> and utilizes subcluster_size field of BlockDriverInfo to make necessary
>> alignments.  It affects copy-on-read as well as mirror job (which is
>> using bdrv_round_to_clusters()).
>>
>> This change also fixes the following bug with failing assert (covered by
>> the test in the subsequent commit):
>>
>> qemu-img create -f qcow2 base.qcow2 64K
>> qemu-img create -f qcow2 -o extended_l2=on,backing_file=base.qcow2,backing_fmt=qcow2 img.qcow2 64K
>> qemu-io -c "write -P 0xaa 0 2K" img.qcow2
>> qemu-io -C -c "read -P 0x00 2K 62K" img.qcow2
>>
>> qemu-io: ../block/io.c:1236: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  block/io.c               | 50 ++++++++++++++++++++--------------------
>>  block/mirror.c           |  8 +++----
>>  include/block/block-io.h |  2 +-
>>  3 files changed, 30 insertions(+), 30 deletions(-)
>>
>> +++ b/include/block/block-io.h
>> @@ -189,7 +189,7 @@ bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
>>  ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs,
>>                                            Error **errp);
>>  BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs);
>> -void bdrv_round_to_clusters(BlockDriverState *bs,
>> +void bdrv_round_to_subclusters(BlockDriverState *bs,
>>                              int64_t offset, int64_t bytes,
>>                              int64_t *cluster_offset,
>>                              int64_t *cluster_bytes);
> 
> Indentation on subsequent lines should be fixed.

Thanks for pointing that out, got it fixed in v2:
https://lists.nongnu.org/archive/html/qemu-block/2023-07/msg00182.html

> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 


