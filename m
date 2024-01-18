Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF63831BEF
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:02:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTu5-0002vm-SS; Thu, 18 Jan 2024 10:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQTu3-0002vQ-34; Thu, 18 Jan 2024 10:01:59 -0500
Received: from mail-db3eur04on0725.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::725]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQTtz-0005G3-Qx; Thu, 18 Jan 2024 10:01:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxCtZd7O05uleZzFZFqiE2djxG5BzUldN9mxGoPD3y5xW6hRqakWhRBHveu6R8iR5Mt4D9yow02kKdEczRACrewTn6PLFugkzUq5L3PK4smS5VazfhpzvDMtH+GCxw4numTGsMDS0EpWLa4DhgGfc5j3Bt/gQLUiy9q1rjTEHQo1S0COg+PgsBK9G6LA7HXw4GXMQhQgdPXK0at7JDPBn7YKJr9Lj2Bms53aklqA2wM17IYLFyw3kdnSa1g+S+BCAfma0RGhJfSN8iqFL3xnZwCGLOJLrJejcP07NAnLfJlepiVHbmTT4OVV142gnlhs7ZfwJ0v0Rf3XuodakaKKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/rQxmLxh3iTW3oWhmT5//HKj0iE94AKLjyQPkuMFbg=;
 b=SmGiV4kw6cKBFrdRTEKmb5A067t7BF1GhfASnm3823Zz1BKXN/9RGZpYvf9zpGoVP1BKesxbf8iKwkzyz2dgDTb+jhJo7MNVSCM4qshsU+ZfYDMccJzOZhG60H4ZewSiu0hkjIxz3/jgPSCYe32lL96/XJZzlNABN1r+VaHZP47pkg3c+QQJZa+jy8sh8LgNcEdVT4WN6S1wN1mY8rDMEwQsZZg5sSg4y+ahtbe1tg8MOOAnPuQ8TjVe3jn5ilqDhzq9MCQIaq3Ke00dYtE4K7MqzX21k/U+3iUb7fvdSfqhkLFI90DQnKgFlcuNng5XM3grpOAp/s8iepVYVFA+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/rQxmLxh3iTW3oWhmT5//HKj0iE94AKLjyQPkuMFbg=;
 b=zkhq5mQgo7BcKgokfFVIIC0KAbw0RkiXW4X92x2mWIZIB8GjWOaiawvGNTNKf6k5M43qdbXzgD9G3NnA4+L41I7Rv2b6JyO0+cz1bFdpCjURC0L2eZ3hqutmt9RLw9jH+Gv2EbDN3jomqVosC4cGqRRy5NiIQTGdRYdfDGNf7C2NqeYpB1utqjuiSgucUl/yv11aZhXidD2ZpPl2xqdahaGBwWUL6F06OMWU9ukvKF14mX7QVB6S6HVQn0OZjam3xpnis5TW/QfLmUadE1iaA4eQmzP27+OUoCCfvZ07wXZE1ssOKOwza/e/tVepI3H0LdD1QWF3gQvonP5p/g0OAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by GV2PR08MB8702.eurprd08.prod.outlook.com (2603:10a6:150:b6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 15:01:45 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 15:01:45 +0000
Message-ID: <5cf3d431-5af2-42cd-aa44-6a869245dcf1@virtuozzo.com>
Date: Thu, 18 Jan 2024 16:01:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/21] parallels: Add full dirty bitmap support
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0283.eurprd07.prod.outlook.com
 (2603:10a6:800:130::11) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|GV2PR08MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: 4574e802-643e-4307-1852-08dc1836633e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eD1C84vF1XBGsIZwjHiukMru8Or4XbjWoZGpzce0K4SVBTnpArEJs5diHOSS4rdAbskYLz8bRgm6fnUoD+Ib/T/jSYNuoeUN26kAypMLWnDJr3nP0BvGyzXf47iizfmSJ+utTTpW+VkPYTN4tMz5i+D6zZnkRHvOOXMxSezohcqlZUZwxw2XR1OAkCKE3p9DVIvNT2DF6GTFoNWbbvfnltX3KdZXtLvD/xfHzcqX9MrDyXDcDesqy31aTir8qpW8FYp5cbKtGKYGnjxm8jv4g1k1lNZwAjev0qP9eo25jpGQkBzktG3lnjCVOtE9uzGt+dKPnhWWpM0gIKUQdUh5xnDA5hE4KWLkn/pkfSpssAJRl3MC0BUGaXUQ+eJ+v62h3j6ZfF9BS4PrNE3av/q6kMoBumaiqqSD7W4v6XI5Xz3x1zllRVgPFHj81+cmSjzYl5EaJ7zu4lYykD5ZaJAqSsXzXghn7v41OuxnTEjbKam2zDxFXT03BkzyKDz1fOOPD+SqNpQWOQtGRuqgfRtDyP/WpibCVXw1m9ryGy63jCY1hKrvPfqhn988EC6P8pSiygUzly/6Tu69decx/ycevdq5c1TZIwm6x9orMivID5SDVE99v4vIuLrNpwc8iCpQScKFBEyHx4dXkv916p/9t9qbyefF0aDeFlr4B15pTMafRotXIqGN40V7A46tYGb5LFt4N1815UXufrXcUmRZ0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(396003)(376002)(346002)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(478600001)(6486002)(966005)(38100700002)(31686004)(26005)(53546011)(2616005)(83380400001)(6512007)(6506007)(316002)(86362001)(5660300002)(2906002)(8936002)(4326008)(8676002)(36756003)(31696002)(66946007)(66556008)(66476007)(41300700001)(14143004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm1PRkduRU83bUJFMnZodlQxZ01NRmd6bkNZYzFiQ1AxQzJuRmRYMmFtNUk0?=
 =?utf-8?B?U04vOVdmamI0S2taSERIR0tha0pCWHMvdHZGTUtUTVBidkV0ZlZjWWkzMERM?=
 =?utf-8?B?UVFXYjJnc0hWazhyNW5ZY3I4bThWaS8xaGwzczNVZGRYTTNLdFFDc0k3dFJz?=
 =?utf-8?B?NnU3NWp0VGx4Rk5abE8vckNBaTVRZXQxQUpMU2FaRHg4R3dPVHVtMERYQW1R?=
 =?utf-8?B?eEpoZHk2SVRTQmtsYWFxMjNob1YwMzlPTGRPMnRvUXBoQnFEVjFaSjh4UGdC?=
 =?utf-8?B?emVPS1NvcUxUekpHaTJHWkZuTFNna0lKazFpMW1tTUd2UTBXVWtNVjAzd3dC?=
 =?utf-8?B?V1l4VCtFMXJMakhqWTV2SVBOL0JHRDRIQ3BmM1VtdlJZdGFJVUlVa1RMQ2JM?=
 =?utf-8?B?ZFFNcHZQa2IvOXlrR3BrcFNOSWFlZHAxd014K3A4Tk1IbVFUVHdOU1JCaHc4?=
 =?utf-8?B?OC9JNVh1cElGVHU0TzRVWEVnTS9yRnRPMFVnelJNOG01MkE4Tkl4L09qTVNj?=
 =?utf-8?B?bkpoQkRxU2JmcTRCWG1WQi9tTmE2b1crSGx6aWFCOStPbmErcThrdW5IR3ha?=
 =?utf-8?B?WmhKa25YVDd3YmkyZ05zaFRSTE9mZ25UNGlteWIxc2hOVi9BZVI1Mzlna3Qy?=
 =?utf-8?B?SlVnL3pPMTZUVVVhMGZMYlNJcTJMb1cvb1NkV3lqNk45NUZNaWU4a2Z2OFR1?=
 =?utf-8?B?SGFxeTRJckJpS0ZFV0swVENHRFRXb2psTS8weHQ3am9vTlc0alhUZ2FRM3c5?=
 =?utf-8?B?dGV5blJmNzBlRzJ6M3pDOE5qMUl1YzFZUFVpM0U5UjR2NVdBaXNnVW9VczRv?=
 =?utf-8?B?UE1LSWFaS0tVV3FvL1hXN2JmN0R4MVNHTEw3U2RiTHR3S1BHQTMvenp0ZUxz?=
 =?utf-8?B?eHFUMnArRFViUzVqaFZJYWVORXFiUmc3YlJMeVo2ZTRaVW43bmVNVkdPSDFH?=
 =?utf-8?B?ZFBSd2dHbE5NRVNTclp6bXFXSUdsZnFZL0lFSHVITFJ1RE1SRDBMR3BiVDVk?=
 =?utf-8?B?eHN0QUdNRnoveVB6YUZqbFRmbGVmK3VmcEhKbXdoSXRLSFQ1TVRRNC9JTUVa?=
 =?utf-8?B?Zkt6NjBqdmQ0dzJpYVRIZ0srcE5wdFluY2VUeVlGbCsrdVErNE04bjlRTXFC?=
 =?utf-8?B?VHdGUmErSWJUWnVQazBCVy9WNXVKb3NTajhGNVZUQy9yK1gwYTQ0THJYL1Ni?=
 =?utf-8?B?YkE3a3R0aFl1dmo4eXg5N3EzV2JxeWhVNE1PemF5UnpkS3lpVnhTWXYvUEdl?=
 =?utf-8?B?aEdzVWNGdmtzV3dWdGtvSkc3SXlpMzZQckpCMm9hT284RGxzL2pMNTU0YWlO?=
 =?utf-8?B?OGFtZWYwSWduTHZmMnM5b095a0JueSttSXpxYTg0NW9zd09GWW1Eei9kNy9l?=
 =?utf-8?B?eVRhUnZoZFpYWEFWQTVqR04zVko2c21USHhkTVJHNWZ6N2VVUjc5YzR0NDBs?=
 =?utf-8?B?RC9BMStOUUlhcThQallDVmRtak1uT1A5SzFPdFJLUmpHZUlBbEVXSXhzVE1i?=
 =?utf-8?B?WHRVK3g1RGxYYkwrM0pnbGcvc2dhVVJqRVZteWxKK3d1cTBpYlRZd0RTR20r?=
 =?utf-8?B?bmszOWp6UkZRK1Y5UjZndjZrazQyUURpcXU5Y1Z0Z3NyNHFBQzluWk9PeWky?=
 =?utf-8?B?R0dyY01SMWdVZ2FqQUNoNjBiTTBDTld1QnZTRHdQd3JjR1o2Z2pJa2lCSmlt?=
 =?utf-8?B?YzFKcEdOOGRTWEVobXJiaHNOajd2Q0xlRDVpWDBzdlI3Sm5vdVJtQlA5cmkv?=
 =?utf-8?B?amRvVFZHM2JWUFJtWWszcmZWNFhJb0dCaXF0S0JTRmJBZ1hBTjBpOW5SdzFp?=
 =?utf-8?B?dnVtdE5sTitkL1pZUndyUUZudUJrSHh2T2prZld1aHdXd2hIOWpiRlJHUXAv?=
 =?utf-8?B?aThLKzZQNDZXYXNUNFhYczg5QjFNcEc4WXI4ODROblpZZmFEemdlc0ljVkc2?=
 =?utf-8?B?SGJqMndsMnY1UzFVOFJvVzBPbVJDcHptUXVBNWQ3U1BSWlVpQzgyb3pUcnha?=
 =?utf-8?B?QmhOUlJhbTZ1a0pOSitVcWs1VkJsUFVLbmdLRm9lbDk5dzA0SjdXWGhZSWhv?=
 =?utf-8?B?NkFpTTJ4Skc0b2s4OTNETVlnVzlBYVpGZkhBekJXZDlFRVRlaFJPSGhjTlUw?=
 =?utf-8?Q?5wNHrQnxkzt/6BlhM3zBJPr7W?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4574e802-643e-4307-1852-08dc1836633e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 15:01:45.4480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3LU7/ByxJ2NAiyS3twB26MHNqQvGQBqdkeSOad9jyzwuKi2BQMMvJje6S7FtgRxMf7H0xeuqNlb8BNPZTyFvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8702
Received-SPF: pass client-ip=2a01:111:f400:fe0c::725;
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

On 12/28/23 11:12, Alexander Ivanov wrote:
> Parallels format driver:
> * make some preparation
> * add dirty bitmap saving
> * make dirty bitmap RW
> * fix broken checks
> * refactor leak check
> * add parallels format support to several tests
>
> You could find these patches in my repo:
> https://github.com/AlexanderIvanov-Virtuozzo/qemu/tree/parallels-v4
>
> v4:
> 4: A new patch with limitation of search in parallels_mark_used.
> 5: Previously 4. Search is limited to (cluster_index + count).
> 6: Previously 5. Added GRAPH_RDLOCK annotation, added a note in the commit
>     message.
> 11: Previously 10. Added GRAPH_RDLOCK annotation.
> 16-18: Added GRAPH_RDLOCK annotations.
>
> v3:
> 1: Fixed the order of g_free() and s->used_bmap = NULL.
> 3,4: Made mark_used() a global function before mark_unused() addition. In
>       this way we can avoid compilation warnings.
> 5-9: Patches shifted.
> 11: Added GRAPH_RDLOCK annotation to parallels_inactivate(). Guard
>      parallels_close() with GRAPH_RDLOCK_GUARD_MAINLOOP().
> 12-21: Patches shifted.
>
> v2:
> 1: New patch to fix double free error.
> 4: Fixed clusters leaks.
> 15: Fixed (end_off != s->used_bmap_size) handling in parallels_truncate_unused_clusters().
> 16,17: Changed the sequence of the patches - in this way we have correct leaks check.
>
> Alexander Ivanov (21):
>    parallels: Set s->used_bmap to NULL in parallels_free_used_bitmap()
>    parallels: Move inactivation code to a separate function
>    parallels: Make mark_used() a global function
>    parallels: Limit search in parallels_mark_used to the last marked
>      claster
>    parallels: Add parallels_mark_unused() helper
>    parallels: Move host clusters allocation to a separate function
>    parallels: Set data_end value in parallels_check_leak()
>    parallels: Recreate used bitmap in parallels_check_leak()
>    parallels: Add a note about used bitmap in parallels_check_duplicate()
>    parallels: Create used bitmap even if checks needed
>    parallels: Add dirty bitmaps saving
>    parallels: Let image extensions work in RW mode
>    parallels: Handle L1 entries equal to one
>    parallels: Make a loaded dirty bitmap persistent
>    parallels: Reverse a conditional in parallels_check_leak() to reduce
>      indents
>    parallels: Truncate images on the last used cluster
>    parallels: Check unused clusters in parallels_check_leak()
>    parallels: Remove unnecessary data_end field
>    tests: Add parallels images support to test 165
>    tests: Turned on 256, 299, 304 and block-status-cache for parallels
>      format
>    tests: Add parallels format support to image-fleecing
>
>   block/parallels-ext.c                       | 183 +++++++++-
>   block/parallels.c                           | 371 ++++++++++++--------
>   block/parallels.h                           |  14 +-
>   tests/qemu-iotests/165                      |  40 ++-
>   tests/qemu-iotests/256                      |   2 +-
>   tests/qemu-iotests/299                      |   2 +-
>   tests/qemu-iotests/304                      |   2 +-
>   tests/qemu-iotests/tests/block-status-cache |   2 +-
>   tests/qemu-iotests/tests/image-fleecing     |  13 +-
>   9 files changed, 453 insertions(+), 176 deletions(-)
>
I would also say that if we add parallels extension in
read-write mode, we should also add appropriates clauses
into parallels_check.

Den

