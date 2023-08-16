Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2C877DD28
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 11:21:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWCiC-0004eJ-HX; Wed, 16 Aug 2023 05:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qWChu-0004To-J0; Wed, 16 Aug 2023 05:20:51 -0400
Received: from mail-vi1eur05on20721.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::721]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qWChs-0006gr-Bj; Wed, 16 Aug 2023 05:20:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwwaNoWh7ySbMwwrKdrrg/sTBT24QPRoCoznnrFixuE45qIC/i/KgguBufZu82aPnDJN/GiSyNjU79eOlbf3NZqYOnBxGDf7fT0cc3iUROxMEdSVYCepUlbBIAMEcAzm5I7UScIwSE75NRQWFHrtl364rK2Zy97R7rXrS7LFgcsVdIKfqEwP4oOhOUI9S+RYN7z7wyYFRKbZqrNf3zuqWz29PfC9mJyHH6ngQzZ8lC+hb1t2vaF00tuzaq7l/NpbA7/CoaUjJd/zbNJ0PVgKhV+b1X8YlvluCIjTRo0m1TiG6Yd09CpJfzBrNZ+N1Rl//MlP2Ngdkyx6WUqtysWgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RO/mDZE6j8bCazPdqsN6usujU6Hbx4tbWpgcC4Vxdcs=;
 b=mp7Q6Vrb+8sui5zMwNMjQ1Pwr3jYMIAczFyviiYM4RL/gHYotH7t6ytKYGN2KqvTjr1L/Ls2dvnp5zw4Sw62Oc6SgBEPDfmNb3CDuoDkF7UvxbzYeDpebLFZfImON+qb++qJ2/EgXPdI+KC4tnUvF9ktML6stseZZ+J2GZuII9MuZlzHYTFlm8lxIXfiBo1FZ0KtggL5HmIM6vWPR+doAQlCLtsi4WWodKcA4q7scaexWtYi8sdZwjm4jw//2eyx84QlgEngur+CqXitNsU4NAF18ykS7p0HTTVAOqeLnO84I5JYtfX005JWbn1myrLRzOU6+rFawLSVix8cwwRVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RO/mDZE6j8bCazPdqsN6usujU6Hbx4tbWpgcC4Vxdcs=;
 b=YN3MVo93uGCtd3C9bjiwUxrfzNcUQfuxRlZEcS2s+itaooh1A5KJPpvmN3NF+EQpDaQfL8ltrZL9Ep+3/iIDgpYnh1UoiLEbLGWTNEMPiVchGFFp5uwRqcwBdwePfHbhqLJaqOpg6rhCbAdnzFmhpR1BFRhjgMAezxK+Le9pvAgs4VyojCq798Ln49gMK7D1BsCtIAK1mMz+IZtrnxjfGIuqMWG7JCRgWvgB01sRjeK4+/mdltVTVbGoKweQ9R5Cc7gcN4NiqWGQXsorF2xkxbOO8t6d4yms2Nuw+Kv/g29iU6v5qbtIzGkWYFJr07TE+hSPofslxyjV1y3xlT+94A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by AM8PR08MB6465.eurprd08.prod.outlook.com (2603:10a6:20b:365::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 09:20:44 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::6ffb:db00:bd2f:bcac]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::6ffb:db00:bd2f:bcac%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 09:20:44 +0000
Message-ID: <b865d41d-97df-4d5c-9e52-4fb2415d0af9@virtuozzo.com>
Date: Wed, 16 Aug 2023 12:22:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] qemu-img: rebase: add compression support
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 mjt@tls.msk.ru, vsementsov@yandex-team.ru, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <d4bd1e00-1c63-fbcb-894c-36dd46b03933@virtuozzo.com>
 <8c93905f-2c51-354f-e08a-e9670d3f5cfc@virtuozzo.com>
 <962e464a-cb94-d1a0-5a74-52de34d25557@virtuozzo.com>
In-Reply-To: <962e464a-cb94-d1a0-5a74-52de34d25557@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::7) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|AM8PR08MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: c76cb953-0147-41b3-19a1-08db9e3a114b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKvQx1hLPV4QXZoEjcNiPZwV/MafO/gbRXfFDttkfvAzFG3kXiHncXNvnbNxbvf0SE1kSo2S6dtQ4f9DkH7y9P4xNSPA7PmrpYn0d4kCHk+80cfM9iyELgqqbLEgArYxGrqbugixBJrOj5aB+f5CYKmOhsJW9xMiBxGHq4x/W27dl1BcYqR0GLYix5kGV6wG9GYPuzgZ2309X5BQ81w726k1qiH8hxk51L30Xww7wFsJrwGOCctq2rOZbLJUrp04Kbnyo/KwnTYO3SVtHAsj45IHl4E5FSfHCwevtEUCe8y2wdq9dzUJXoGqNQ7y6bsnsfGWlryP88vXCww3a7Hyk3xX+i9fxWMSJnlNpRnWq5qaEjq6INsDsTMjBQdN6eWd4V1aT6CRbqIlx2Iv7/HmHM3z+n0ecvmUa0Pa9i9JvmS6LkWxQrk+8wrwxseFLsJnGDLxcEEGrL/fmTft5Q2gTyrghl88JnpcaR523gDtl1rBf8fFxS6uOsmGBJ+wTu6RbAKyQsN/4CsgA20LZIhw0QhjLeH84neBdwRGajzvdIQ6bJdI5ez7lTVKWY9cGGM17HhxK2ctEXz0s4AwOt/Ao3YTBFvfVLF7GVPJteTuSvN3k/P0bJjoPUVrMoeXJZbu4XXYXdrpK26A2RBCu3pBgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39850400004)(1800799009)(451199024)(186009)(2906002)(83380400001)(86362001)(478600001)(31696002)(36756003)(2616005)(6486002)(6506007)(107886003)(6512007)(53546011)(26005)(5660300002)(44832011)(41300700001)(6916009)(316002)(54906003)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(31686004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGF4TXMzSDhTc2k5MHdVRWpqNUxvUnRVdzdyOUE2RDk4YUV3aXlUcytWT1pZ?=
 =?utf-8?B?SU1kdFcxR2dTNFZJWVl1Q1FQaCtnZlBzRlBPdFFHRytieDBqNHdOVWhYSGd5?=
 =?utf-8?B?OGUvUGN1YUJFQU50M2ZySDV6a3NWVWxtNEVVR1QwQkpTUCs2SzlsNzM1N2Zz?=
 =?utf-8?B?TWtrdGlRYVBpWVNkeDYvMzhxTitNdW5HVGh2UElmM09Za2tjVU1MYVdERS9s?=
 =?utf-8?B?NGJ4bVA3MGlUeGdOdTgyZmMzb1gwdGtlOXFia2IwN2NZU0wwcmhsb3RsREtv?=
 =?utf-8?B?amV3Y2VSQ1pQVHhibFpvMUR1ZWt2YnV6S1JsZmpmUkZ3R3NHalROM2ZIYWZM?=
 =?utf-8?B?VHpoTm9SM25SZ3ZLWElhVkJ2cHJuVk81VU5sVmpBOENocHBFWE1RM1JPUFFk?=
 =?utf-8?B?bmkzRnhGbUFORDdLTENFNUJJZDA3bmtDbUNEelRvcHphNnplKy9EVVo0RkM1?=
 =?utf-8?B?dzBrbGNEaFY2TWlrYnRtYVpobWxtSW43cFV0RXFrTm9HOTdWWHBaTFdvTE1y?=
 =?utf-8?B?STR6UG00MC9RSnltTkN4ajhHUDA4M01Ma0Zwd1B5ejVha1Nzckt1R2tCdWhQ?=
 =?utf-8?B?aE54WnhqcWttMU12Wlp1TGswbWdBS3pQK2hTc1l4WVFEUDJLRGhieUwxL2Fv?=
 =?utf-8?B?bXFvQnN2aVdoU2Nsb3FOS0tId0N3eUo5ZU52U2FheGw0OFlCYjlzTks3QjVP?=
 =?utf-8?B?dWhZQzk3c05XV29JbVA0Z0Y3NXhDNlJ1QmNuNE5iTGJWNXQ3ZkhQNTQ1ZUkr?=
 =?utf-8?B?bysyZHVCSi9YbjlpTTFkVWsvQU85UGZYMktSVEV6ZU5aQkRxWVVncWJSNTlC?=
 =?utf-8?B?M3FLTzBnTTN2NWZPU3N4cnNZUlBMT0Fvb0VGTlNsUGtXZldaL0lybm1JUzJn?=
 =?utf-8?B?TEFWUytIQ3pYS3FwdlJuWHpBVzRpa1Fud0dSdTczOWQ2ODI1RHJCQ1RHb3hw?=
 =?utf-8?B?ZkVMb1Y5eEQ2SjNWTHlHL3oyQTJMaUdwM0ZIc1c3ZkxXelFQUmwwVW1mV3NW?=
 =?utf-8?B?ZmFHbWU2MFZSUDVjRWdkaGo5K3hscW9vUzEwN3VENjNxeEd4Q3A2dVlkRlFu?=
 =?utf-8?B?NVRRNENNdWNSdDhwNk83NzAxMHJPdGI0UGxTK28vVmNxNzFneHJ2YjhoRzh6?=
 =?utf-8?B?aDY5U3FOempmeWJmOVJQYmFURk1WdHlFb292anpCZEFsRWFDNDdhS1VrcGd4?=
 =?utf-8?B?STNwTnJzcWtod0VsVlhEQzF0RGpmNHU2SzhReC9zV2c1QzUvQzVtWHVCbmZE?=
 =?utf-8?B?cHFFVkFoZWtEaldWZmxtV2ZRNlZrRkNzanBVWXRCQ3NaL3pSbDR1UHZQN29k?=
 =?utf-8?B?bS9jWHkrSUtSbGRISHVZUkplWTNVdjBVSWk3WUxjTjh0eXJjMWVIVnVLZFBo?=
 =?utf-8?B?d0lRWE81amRtTm54NUh6VEhlbk1yQ0t2WmtmVEtWb2NhLzZRbVpYbXZVYkRh?=
 =?utf-8?B?Y0c4cklSZ0E1S0RNTVpkRUtJcm55ak9kTXdOcGhSZW9TT0JuSDV1czdrZHk0?=
 =?utf-8?B?cHBaUE1wRGkycUFGdW04NmpGRFY3bjcvU0I1RSs0dmFnVTRSSmV3NSt4YXh0?=
 =?utf-8?B?aitQTWxVeVd3MU5MTno5SmVWTzB4NEpzeTZRaDVrT2dBemRuZnE2TWIxRUJo?=
 =?utf-8?B?VFhNYUVBa2dBbkgrTkVrYU1QZmxRKzl4L0FlNHkvdlBMSzRqL1pTT0ZudE52?=
 =?utf-8?B?Z2hyQktKaXVUVG1sb1BYYVJBdytqUFFCN2twSDJUbHJ0YWJ1Z3Y4ZnpxMVFx?=
 =?utf-8?B?TzJxaUswMGVCL0czOXg1TU9kWTkrZFlTa3hYdGRnbyt1dkNQZ2g2Q29OV0tr?=
 =?utf-8?B?ZXZJWkwxbmxYVzg1SXVrdVpnRHNpMlBUbElWeW1mKzBlOW8yaTdqejZGVXhs?=
 =?utf-8?B?V3dxVlUrbDNVOE1DVU9Od1pFYTB0dk9tNEZoYllwZCs4bERkeUpLOTFSZEo5?=
 =?utf-8?B?TnNUdXQ1cnV3VEJCVm1ycmRPOE4xUVpIZFlFLy9MTmFpNmtpN01uUTBvY05Y?=
 =?utf-8?B?UnBUVmFmOVpSSEl1dTdiNUg1bjlxMmJwcGxpbHY4b3E0VnNTSE1CTXdCemg2?=
 =?utf-8?B?WUIyQnpYaGcyTG82T3dCMHBnK29XVFlHcmNRdWl6ays0SDlyb3dxL1JmcVRv?=
 =?utf-8?B?c1RFbytKUUhnUldQbEg5MnJSSFc5d214dFJ4Nkt4QkVoek5XbkZsaE5JOGw1?=
 =?utf-8?Q?+Uqe4OqVDDsxO2ubEGfyMjI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76cb953-0147-41b3-19a1-08db9e3a114b
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 09:20:43.9288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfSvjqIkJCZLwYVNLWkPPnuJJ8UxbuoMpTobN/kMMo9SL8PIPXYthAMBYDsidpJdFRvwignQI3PSrFjCSSDvJlV2if4TKUSFd2E9iVw/Ovw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6465
Received-SPF: pass client-ip=2a01:111:f400:7d00::721;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 7/31/23 17:43, Andrey Drobyshev wrote:
> On 7/24/23 16:11, Andrey Drobyshev wrote:
>> On 6/30/23 13:54, Denis V. Lunev wrote:
>>> On 6/1/23 21:28, Andrey Drobyshev wrote:
>>>> This series is adding [-c | --compress] option to "qemu-img rebase"
>>>> command, which might prove useful for saving some disk space when, for
>>>> instance, manipulating chains of backup images.  Along the way I had to
>>>> make a couple of minor improvements.
>>>>
>>>> The first 2 patches are a bug fix + corresponding test case.
>>>> Patch 3 merely fixes wrong args used in allocation.
>>>> Patch 4 makes write requests during rebase operation
>>>> cluster_size-aligned,
>>>> which seems to be beneficial for both non-compressed and compressed mode.
>>>> The last 2 patches are the actual feature implementation + tests.
>>>>
>>>> Andrey Drobyshev (6):
>>>>    qemu-img: rebase: stop when reaching EOF of old backing file
>>>>    qemu-iotests: 024: add rebasing test case for overlay_size >
>>>>      backing_size
>>>>    qemu-img: rebase: use backing files' BlockBackend for buffer alignment
>>>>    qemu-img: rebase: avoid unnecessary COW operations
>>>>    qemu-img: add compression option to rebase subcommand
>>>>    iotests: add test 314 for "qemu-img rebase" with compression
>>>>
>>>>   docs/tools/qemu-img.rst    |   6 +-
>>>>   qemu-img-cmds.hx           |   4 +-
>>>>   qemu-img.c                 | 106 ++++++++++++++++++------
>>>>   tests/qemu-iotests/024     |  57 +++++++++++++
>>>>   tests/qemu-iotests/024.out |  30 +++++++
>>>>   tests/qemu-iotests/314     | 165 +++++++++++++++++++++++++++++++++++++
>>>>   tests/qemu-iotests/314.out |  75 +++++++++++++++++
>>>>   7 files changed, 415 insertions(+), 28 deletions(-)
>>>>   create mode 100755 tests/qemu-iotests/314
>>>>   create mode 100644 tests/qemu-iotests/314.out
>>>>
>>> ping
>>
>> Friendly ping after 7 weeks
> 
> Yet another ping

One more ping after 12 weeks of silence

