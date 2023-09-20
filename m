Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEFF7A8DE6
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:39:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3xp-00076g-D8; Wed, 20 Sep 2023 16:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qj3xn-00076K-KY; Wed, 20 Sep 2023 16:38:23 -0400
Received: from mail-db8eur05on20704.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::704]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qj3xf-0002M2-T4; Wed, 20 Sep 2023 16:38:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQXsIAgZmTEI23nnkNaq0cCanDPVPj9Az0LSgq7LZmvAOsstlBWwNNFZDUF5edi0M2xdM4HXa4w4kAj2otdntnVj7yRQS6vFrtnI5gmjCeDfbxHiZyRPRddkTTHpLcE29WFg21JqOqUuH3N+j+AtLv+iTpIXj5FHB1/UReM18zBj7jtvaU2b5E+NSBi0vimX14jIcriNxy5sMBuoDpIaeDMY/whZT7Ch9pAt7fBviKxrQi+zv8lynr4WlDtbVxH91EK67s75HKRRnZYWFlQdVdBY8b46OTsHHYvX69H1qMBAVDagsOWYGj31yia4XMGTAuV3myzm/ZfPIXysVe4rqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omjIWKlTl6qtsJfOc3ruYOF8COqQOz+Qfuw22GY6nR8=;
 b=Vc325hAMe0rOB/TKMxAFHN1RNVciFxiyJ4VdImgqdHUmkZiZL1Xxyh0MPgI9AuPrCTqq+PdNssv6PQPjOEd0pptK+IRsBmaTmVArPttyf3kjyhQgA/U0KehmSRer1QY4voxhzCCu+lYGCceGg++SGEziSc7Wm0YE7AjbYD563crG3Y5Dipggc25NZfAqaKLqBfJjV7OfncVKqnf2L/IOLlmwEGZe82heTQ6Tu20KLbr+dM5B425ned1Z3Of8bHBB/ZCi5OWKctpUK51KICt1uYXUQb6A7/9mwsFEzcc3ST3NdJ8GYeMXtkPHoKr7dcsksymteDI0vbHS/11sKe0LJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omjIWKlTl6qtsJfOc3ruYOF8COqQOz+Qfuw22GY6nR8=;
 b=Mryo/hTGQ1bGLAbCg11qUBOEBkrRjOMmWJddNTvn1L0TmaT8cYiq0LxyiKaUYM+KdwkthdSqUNOgBsTL+k/GmtDMfrUu9fE3iuV/rTGwiBIMw2ihIkLXWNFIOf5JVHFadtJfZZxNyG05TbHD9xqWMEE1uDvQfU24ECEwZdOUJxOKOqpGMximZWbK1QLBkLPeuu+jjdJJY2OIkYwxJpjENzyp42xGQ8q1QBN5E8wkDFaW3N8HxHWz6rWEt7FBYg7aUV+ZOYX876hkra3+H8c7liwPnb3RX0a/qQ/1Rhkr5CcLJ3OKKaotjT5MvlJoYil8jTGMO+BsYsVwlWb9ssNQnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AM9PR08MB5876.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 20:38:09 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 20:38:09 +0000
Message-ID: <7972e21f-f850-c11c-8e1c-a25ea2ce6a9b@virtuozzo.com>
Date: Wed, 20 Sep 2023 22:38:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL 00/22] implement discard operation for Parallels images
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20230920092108.258898-1-den@openvz.org>
 <CAJSP0QWXi0pGy7NKq42u3-=3GPP6kFnz6TA7HaBs8ZBXjKLidg@mail.gmail.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <CAJSP0QWXi0pGy7NKq42u3-=3GPP6kFnz6TA7HaBs8ZBXjKLidg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::7) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AM9PR08MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8f7461-9aef-45ed-6cde-08dbba198041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TT6GRlAaLX19MrvkFmmXMWk5NGNaKZ7vgQQDD3yX0Q/i2SlBc0qgxoCJPKb6ppq+JBJcBi9dU8YaD525zii/jmuCowphJgKyp3aK2CWXFrIggGK5GUgKXHIziFESsmZavMx/DOJVyHbzZH7sjLXxkoA3tMtUKe+3Kyr//EOmta9SmvBeydRUfzv2BCx+Yuuup6fxOKwugMCSlsl9k4W4Ml/J4yDQboQ+XEMEb0MmP4L6VtvdY6QLiBssNgkBnccIQV1YMpPapukRCF7T656GIxVGkrwlQFC/JDfMvU8+1Oq+8YpTioajWJnxc+7XhYPrtvbGpduqevZSIP88gQT+ptWbxPX5ZYJGiAczRHfftUepQQaKahgdDRProPAVXsrSgfCZqQmtlagQJ8uHtJVT92+E4JJrqO9Stb4BxpKReBI2rSlkITA6EzSYkUS0ey42PTZY5aJOcHIAhPRSuShJbjJxgdhIlhzLVtN4rqZZP4Ywe0G+CbI+sofqcn/KpZ+gqAMiZbWVKxtJrHdr5pbJlVVvX0COhosXKhA31aJrUveYv85KYu9zBq+xBLhGP2nplgB+ljk8z2PZAnjrfQw2GyFNgjafKycSqZiFzeCVgc/Rc3b1L4JfBkkgLMN5jZu+LtS4pN509KlDGeZJPniWrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(39850400004)(396003)(136003)(451199024)(186009)(1800799009)(66476007)(2616005)(110136005)(6512007)(316002)(66556008)(66946007)(31686004)(6506007)(41300700001)(6486002)(8676002)(5660300002)(8936002)(31696002)(4326008)(966005)(86362001)(53546011)(478600001)(26005)(36756003)(83380400001)(38100700002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFJZUUl4cFVITlNOQXNXalpXdWdUUU5kWWlDRi9MWk1LbjFJYkNSdUJmUTNX?=
 =?utf-8?B?dHBFb2pKaVNuMGlFNDVXcEpYaUdwK3BSTXU3R2s4emdsbXgrZXFpYnhrNWxX?=
 =?utf-8?B?TG5XL293TXVlZi9KOWxrSDVLQWlHRkNLR2N0QVpmNFdGMlRZK0RibUNXZXFp?=
 =?utf-8?B?cGJzZFZ3eC9SVDQzVXo3MmRhem11NkxnQi9mdmMvTll2cVU5cHJhMVNTWDZa?=
 =?utf-8?B?RGlhOVNiSXUzZFh4ZlZUYVFyQ2tmNmtvQVJvT1IwdXN0Mnl1Q1lJWXZrVWlr?=
 =?utf-8?B?N1ZuRU40SlpRWFRicUFpWnl2dkN0dStJZkwvT2ZYVnJtT2EyclZaY0cvakhm?=
 =?utf-8?B?NE1MTXAvdW9HYVBaaG9Bci9HRFpTSVVtMHdQVkpWOHZGeGdiTnRNSFRxTW1M?=
 =?utf-8?B?eHJRQ3k3UTdKS3dzOVhnaStDb25zL29Qa0orREhzcWtabzNacXZxeUsxeVBG?=
 =?utf-8?B?ek0wcktNeTB2b29abzZFL3hFdEZQbVF5NGh1SFczOE5TV3BvZVo0ZzdDUHVs?=
 =?utf-8?B?V3pxR0dNMHBSTm85WjNmZTBrUDhTV0VjdXphZVhxYkNjN3FCUnFpOEUvZURy?=
 =?utf-8?B?ZXRNUkZlcDNoZ1dKVXFLMWw5eUNTK3NBaXdONWlqZXNQMFpESS83a2FXS2Qy?=
 =?utf-8?B?N0NXbUp1RzVpZmtRck5ldEM0c3l4TWJsbWE0bkVja3p5amtNZW5Xb1ZLWk0w?=
 =?utf-8?B?d0UxZ2lDUHBRbHJlWnBrZFkvVk9nQ0lqVmQrc2ZGZDZJdzIvZFF3V3hvc25G?=
 =?utf-8?B?Y2UzN1NvVVhZWU5SaGlMWUZGdFB6QW9ORmMxcWw5d2hSQTZ3RXlWL0ZjU29L?=
 =?utf-8?B?aE4yQVVodDFFeW5kNDdVY05uMWN0SFg3S2lzNjh0YjZZTnVkVlFNMk1TQ2Zy?=
 =?utf-8?B?UStDblpZSHd1cnJ1SXk5cndNZG9TUkZabVdzenYvczQwRkNwMlk3T0ZadTUx?=
 =?utf-8?B?bXhDMEo5ZFd0QXFhei8vUWI5N2tlT2UxQWJ2NzlqbGhoc3RteGRmYTlIU0ls?=
 =?utf-8?B?TGRRdXlMc29XelBTUit0Ump4YWh4YzhFRmdUeldqaFBuQU9XM1hhb25nbTE2?=
 =?utf-8?B?MHVRL3h0M3Y5ZjRGZElvS004NUdENS90NWk2MnVkbGF1aGxSL3RxVUZRQndo?=
 =?utf-8?B?cVg3ek1uTmlhaGhQWTh3WGhpWnh5S1BURHIyR00xU3doL28rcUdhSE85UUxM?=
 =?utf-8?B?aHFvTXJ2RXRrdHpMQW9WZksvTE5pQkRQbG40bHd0clUvSTVlMFg4cEt4bGgy?=
 =?utf-8?B?dHFRZmgzOXUramJRUS9rNVp2WjNLRkxURmtnUU42dnBGRUhJV2xpTHVubVVW?=
 =?utf-8?B?VjBYbDRCVHh3b2ZTakVXL1NVWUdVTDlleVc5Vy83dUs1bzRERmdGb1hHMTl4?=
 =?utf-8?B?dFo1bkgrcWE0OW1qUWhTSHhKbE01TU9XMFJ1ZmN1WmFoVGZNV2pDRUc4VFV2?=
 =?utf-8?B?a0tXblBhUTNBTmdIbExBRWZ5aGxXNDVJUVVaUlgyYXNoQlg3aEs1MFpldEE5?=
 =?utf-8?B?TzcrMjRBS3g4S2V6QmlSdWV0ZU40eUZVTXNSVy80M1dvOVZVN2w0Zm9mVGhn?=
 =?utf-8?B?L3U2eGdFV3J1Mk1MbHhLQjlOc0hYTHFVOFpvMW5BUTVnY0s1QmR5aFdzaExz?=
 =?utf-8?B?cFhmM1d3OWpJQk1MVzJVUm1oekFrR1J6RUJJRTYzY09pQ2tmNmgwQVNFNTRj?=
 =?utf-8?B?aDNZeEtuNGNRNmk2VkoweVp4U0xPMmpoSHpzSnF5MUM3b0hNUk5VNGZXd3RT?=
 =?utf-8?B?bWFZeGFZTlRJNnNtaXRzeVliaGpMcU5rQ2NiSFQzakRMU2ZOek5aS3pMZUZB?=
 =?utf-8?B?cjI1anVDZDlkQzdjdjlrVnl6WGlpWHEwb29NN0J2MlF4VlhIRzE1a3VTZlJI?=
 =?utf-8?B?aExjZjhSNENLTUR0VzJPVUg4TC9qMzdBeHlaeGEzU0w3eUtNRG1XeEYvYkxV?=
 =?utf-8?B?Tnh4SFFLMnRHSVZtVG91RkMxOG5PdkduVUhOQTNWZWJ0WHFjbENWZTVINE82?=
 =?utf-8?B?YlZYMkpweTNyTFNqRjRYMzh0ci8weXVteUZPc1hTak9veWpBTDFYcGlJdUhv?=
 =?utf-8?B?cFc4VlljQkY3UitKcWh3ZHpjd09YR2M5U0Zmb0Rua09YZ2VKOXByN1VFY2xv?=
 =?utf-8?Q?WRZZOYx+vNk5xgSGXIDVhhL8u?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8f7461-9aef-45ed-6cde-08dbba198041
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 20:38:09.3133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lW0qhjJGjeA1w279O0GU5hgrX7gXGSKAh2PbP1eqVQ9QErQ43BIWITg69mYPMLXLxPPm1Oj7gjeskjIwyRPeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5876
Received-SPF: pass client-ip=2a01:111:f400:7e1a::704;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/20/23 19:55, Stefan Hajnoczi wrote:
> On Wed, 20 Sept 2023 at 05:22, Denis V. Lunev <den@openvz.org> wrote:
>> The following changes since commit 4907644841e3200aea6475c0f72d3d987e9f3d93:
>>
>>    Merge tag 'mem-2023-09-19' of https://github.com/davidhildenbrand/qemu into staging (2023-09-19 13:22:19 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://src.openvz.org/scm/~den/qemu.git tags/pull-parallels-2023-09-20
> Hi Denis,
> Please take a look at the following CI failure. I have dropped this
> series for now.
>
> clang -m64 -mcx16 -Ilibblock.fa.p -I. -I.. -Iqapi -Itrace -Iui
> -Iui/shader -Iblock -I/usr/include/p11-kit-1 -I/usr/include/uuid
> -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include
> -I/usr/include/sysprof-4 -flto -fcolor-diagnostics -Wall -Winvalid-pch
> -Werror -std=gnu11 -O2 -g -fstack-protector-strong
> -fsanitize=safe-stack -Wundef -Wwrite-strings -Wmissing-prototypes
> -Wstrict-prototypes -Wredundant-decls -Wold-style-definition
> -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self
> -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels
> -Wexpansion-to-defined -Wmissing-format-attribute
> -Wno-initializer-overrides -Wno-missing-include-dirs
> -Wno-shift-negative-value -Wno-string-plus-int
> -Wno-typedef-redefinition -Wno-tautological-type-limit-compare
> -Wno-psabi -Wno-gnu-variable-sized-type-not-at-end -Wthread-safety
> -isystem /builds/qemu-project/qemu/linux-headers -isystem
> linux-headers -iquote . -iquote /builds/qemu-project/qemu -iquote
> /builds/qemu-project/qemu/include -iquote
> /builds/qemu-project/qemu/host/include/x86_64 -iquote
> /builds/qemu-project/qemu/host/include/generic -iquote
> /builds/qemu-project/qemu/tcg/i386 -pthread -D_GNU_SOURCE
> -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv
> -fsanitize=cfi-icall -fsanitize-cfi-icall-generalize-pointers
> -fno-sanitize-trap=cfi-icall -fPIE -D_FILE_OFFSET_BITS=64
> -D__USE_FILE_OFFSET64 -D__USE_LARGEFILE64 -DUSE_POSIX_ACLS=1 -MD -MQ
> libblock.fa.p/block_parallels.c.o -MF
> libblock.fa.p/block_parallels.c.o.d -o
> libblock.fa.p/block_parallels.c.o -c ../block/parallels.c
> ../block/parallels.c:210:21: error: calling function
> 'bdrv_co_getlength' requires holding mutex 'graph_lock'
> [-Werror,-Wthread-safety-analysis]
> payload_bytes = bdrv_co_getlength(bs->file->bs);
> ^
> ../block/parallels.c:572:15: error: calling function
> 'bdrv_co_pdiscard' requires holding mutex 'graph_lock'
> [-Werror,-Wthread-safety-analysis]
> ret = bdrv_co_pdiscard(bs->file, host_off, s->cluster_size);
> ^
> 2 errors generated.
>
> https://gitlab.com/qemu-project/qemu/-/jobs/5131277794
>
> Stefan
>
>

It seems that GCC and CLANG environments are different
nowadays. I have had a smell of that but have not have
a proof. Will try to understand.

Den

