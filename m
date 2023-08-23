Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C208778580B
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 14:50:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYnIJ-0004V7-IO; Wed, 23 Aug 2023 08:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qYnID-0004UC-Me; Wed, 23 Aug 2023 08:49:01 -0400
Received: from mail-db3eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::703]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qYnIA-0007GB-Oz; Wed, 23 Aug 2023 08:49:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jY/ngcRAUDQWhF4jkUTGyAAlT3nhLlT0ZT0M+fYkBAZ+Kp9TXKeR90RSY/8ouFK3PT9YuGDA/UFYkfhIj1NJHWl067uasJC22SutdDDbDPlIjGOIbMItBz34mR73n88T6jkd3ppmMMpoXPYPiqyhwGJDpL5tyDZUJTRZ/TuXUoiBk8rur9GD7XQ2j1/4aXYYaoFK4/d0kQNz2ZBrc21IUvmgHDJcuvBRmk3Zk89CtcGpQ9j8A2PQlnPf5R6UH8RyA5yyLXVCXVopNzA/brDXZGMxCehwpPP1UKGtddvHeMI1iJV0ShIKIXxd2GNtBBTQSYWsFg9P2Qi7fXHbfm5Tsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epBz33GulD9x3g8eRCH/VnmxEvwmcdBkmbYGqcuZFag=;
 b=fhz/GqQkvpI4AGSq+6xVpYDsjNlhpPR9OG8CFJmSDKF2JA4UWFFes8QCT7Jf5eWLcEKv+PEwgINSlaAa1tfI6Vefqn/M5wmrKdyVmIxHiJ1e0DZ6CLc2sFictTJPJL3NOXn+nEkchZGCWIXLC1tg5qv2MJPG1JbnmfjeguQzxjFBAkTzHke2GfN19Y3AY9qv6tP1cZLVRgMGmqdiqjFGZYwkG+dl1ilYviaMGOhxw0DlJ0W1MI3rlX6eSvdWRkD9rOjvfrib3DyXfNCrYwH8uO7iq/ONOwcMpijTrG8tBGCsk6ZD0UIkzmexAwWMipNiuxnBm41RhHbOTsZ6gt9eew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epBz33GulD9x3g8eRCH/VnmxEvwmcdBkmbYGqcuZFag=;
 b=oKuCg2QVLOnuds7HfbfqV53FKdtbgxyGHu22+yNQxl3rv5mnPXWRW6kvidmfCfhEYbN47C2FioMWglyHCmmiIJGFK0b97AiANwn2Rj4JAM/R2EkeS7P74OJOxzWu7hbL6fhU39GyS+ralWM4mLxoeQzmCVesX+OXDN9n294WqfQgPO+1Q/5VGgYjLWQDp7JvmYSudMra+o9YO2np5oR1FkmJjUFCqU1iWCQVMMW0T+Q2uK/QRGo1vh8zsImrEFX2wFjJ59NxCnB5W7Q9zjCfqlll1UGJ8pMw9gq7pUAoBFSqJvd4pAhwbQSVPfYjwumVgpVftenLOzCyKMPfJlMm7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by DU2PR08MB7343.eurprd08.prod.outlook.com (2603:10a6:10:2f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 12:48:51 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::6ffb:db00:bd2f:bcac]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::6ffb:db00:bd2f:bcac%7]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 12:48:51 +0000
Message-ID: <3ea51ea2-0138-4a0e-92f0-175d8ad7540e@virtuozzo.com>
Date: Wed, 23 Aug 2023 15:50:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] block: align CoR requests to subclusters
Content-Language: en-US
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 kwolf@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 eblake@redhat.com, den@openvz.org, stefanha@redhat.com, fam@euphon.net
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
 <c49fd209-9a6a-9e0d-752f-30a5178d855b@virtuozzo.com>
 <85e0a9bb-8e8f-e414-70ad-528e45a803e4@virtuozzo.com>
 <60354ae2-d394-49b8-8289-787b4e02e2a6@virtuozzo.com>
 <577e81f0-1479-41b2-9e97-ad6678cf7216@virtuozzo.com>
 <CAFn=p-bz35mcXgG81Dk70u4u8A8cqERot2=fJjYAcweThE0fVQ@mail.gmail.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <CAFn=p-bz35mcXgG81Dk70u4u8A8cqERot2=fJjYAcweThE0fVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|DU2PR08MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: fd886742-9968-4ee1-cdc1-08dba3d74cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTnzGl9NpnJTw0OruVIs3A0iJs1aIcvall432qxbpLN/wntlk9BA9hOv8ej6BPQ+Dao0pJP+JWLLrQOTW/Zrrq1/EqkD6wgiz0QIAJXaRHe9sT3C0PriLxva5J7bu0mw6Wj/umj8fn4GhBQgRGUYr/rFXcCRUQwW8Kag7m88LDAj/jStnX/gh7LtmMGCAWllBP6CXxKN+CcSGYYsbsHIJ0bBuMK8UQtxpGj/5PDdRt3oW8Gqq01l/tSym10TFnm6/+QZMY+gYyUZSMb/AEyPn5FFksTQDXCGJrFlHydlciextm++fj7Vuft29v2rR76Z9IhIKsokh1nW8E9jEaRJOTtvDj2zuvhM4k2/iVx/X3Opw3s1W27cN9yCmSprD6SXk9Bc7M9pjgl42KhNets2TkddCbBYQIr/tY4GEutKQodfzG9C+5+xEXIKRofpQVM8e/ugSNO6BBKoozNHqJjajzHgf0qyM9dtYrmb67bTC4cuELjzh1NqzGRjPF5Reb5Is7joujF3ACbQDDfjup1gRHCLt99f2zm1qrLIBw5EnvAubp4gHDw2yAne+QaXRaeq6LfJ4N4UBbcF2zpQ+GPGVKkdbXSY6jm5ocXNIScc4o9i0HcLlv5V1EB6OlYzWNfagMEYLls85LkQyfHeTQqmFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(376002)(39840400004)(346002)(1800799009)(186009)(451199024)(6916009)(66476007)(66946007)(6512007)(316002)(66556008)(8676002)(8936002)(2616005)(966005)(4326008)(36756003)(41300700001)(478600001)(38100700002)(6506007)(53546011)(6486002)(83380400001)(7416002)(2906002)(31686004)(31696002)(86362001)(44832011)(5660300002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUt6R2pZeWpYNU5VSS8xS29lazUwcE10Tm9QYnkxODBGWm1SRnF3YmpQSUxU?=
 =?utf-8?B?RUo5dXVxQkRiTi84WnNGWlduMVIvWXRLNExYSmg0VHpFQis5Rm85Y2pJVUJy?=
 =?utf-8?B?K0J2WDBPbmYyOEp3b1FhQXBzNGdRY1kvTVk0QStyekpDZGh3ZUgzck1RNjU2?=
 =?utf-8?B?S3orRWFQcGNtVHBHK2pPMHVhODN5TCtBQ3A2d0lTT3BzVzA2RDRSR1ordFAv?=
 =?utf-8?B?ZUs2VXNsQWk0UGlWVEN2OFphOFlDeC9VTnhPZyt3ZnpRTEI3NWE2ajQ2cU9Y?=
 =?utf-8?B?eG8rYnNaeHZFa1VOclZuOGtWT0NITDR3eGZpOERqQWJxMDBzaFRja2p6YVZq?=
 =?utf-8?B?dnVqeWkycVg5ZDNUWGM3U0FwMlc5RlBFSnZMUnU4VnYvVktMWHl4WnNsSjBC?=
 =?utf-8?B?VTN1bk5Lb2doZFdjRkNIQllaSEpTSEhnWVRKZGgzazN3WXFEUkQ2cTl5cXdH?=
 =?utf-8?B?WTRzcHEybGFISHF3TzJpRnRyNXp1RFVORndWdTFLQ0VYOUxLdWMva2hkUHFM?=
 =?utf-8?B?dk9mREFzWGpxUndVSnVsSHB6YmZWTFBOdisxdnh1cnVyVkV0N2g1UnZEb3J6?=
 =?utf-8?B?Rm9qdWZEaE9BNHBOeGh4SEdyRENHb3BxblVEdGNPK2ZjOFlRZHd2R2ZGUUZo?=
 =?utf-8?B?djF6eTJMeEw0Y2V0ZlpQWG80cWw1cnNHMGZJZG9PZW5NcjQ3MW9kVzJveE1W?=
 =?utf-8?B?MU8yRngwbDV2UVU4R1VLSXAzUHVmVEgxT2ZBKzh3TDRzQWJvbk1FV2E0ckUr?=
 =?utf-8?B?ek8yMVRJVzRDYzlBdVpxRm1rQm1QSWlkUXk0S0lHVU9wYWRGbU14b0VGYnYv?=
 =?utf-8?B?WGpWcXdaS2FMUTYxc2dONlg5MHFGRHpuY040elc2RzNDQjFvdi9WOU1Yd0Fv?=
 =?utf-8?B?RWFmZkFsQ3lybDRuaWpOVGlORGljbDkyUk9XSFFqMnB2K2dnVHdPQWUwOWtH?=
 =?utf-8?B?RzMxcks4RXlrM2dwcnAybDBpeFhjZDF0RmhFdWN6R0RMZFBabGYzMWx4cXBl?=
 =?utf-8?B?bUFCYnQ3eG9KcHpjWHdLV2RMdzlNdFJ0SiticnNqUnFDYUZsVGFqMklKdXdU?=
 =?utf-8?B?b1NkR2JTTlMybE81dlhFdzZqSGZZSDNtMStqRFBLTEVKa1FmKytZZzh4ZWZl?=
 =?utf-8?B?MlVLQjRvRjlkQlc1bGZrQ3RKak9QajB0Uk4vRUlVa3huZStCalkvM3VtTlpB?=
 =?utf-8?B?K2kxaEhvQ1NLa0pCVkM1WTY2YmdqRHRHNVkxTTVjb2lhemZpaXJQOWdUMk9N?=
 =?utf-8?B?NFRXeENUQXdxVkRXMGRDdlJCMHNaVHBGZGFTNUdBWWxPeGFxdTY5Nk5xd21l?=
 =?utf-8?B?aU5xTFhITlRKb2xvT2xrWDEzTnViRmtnbk1KZ1BIVUx1d2lRVnNmUlBUTmE1?=
 =?utf-8?B?WjhBOC9RMTRrUTNZa2E0Q1gycHN3TEIrbXFYeHlkb2p6U1d1M2h4SnJmOTMw?=
 =?utf-8?B?RlVJNFFDQldqN3R2aHUyWWhhdThxUklYWGpGdDN0bWRhQmJEeDIxQm5OcmRV?=
 =?utf-8?B?Q1lMOTRjcUtHdldwcW1UUHZVVFpqRjVOWUpVdGgvRXdEQitYZUJYZlF1eE80?=
 =?utf-8?B?a0pDQ2xYTllDYm1PdVNsOXl4WUZsQWt2dk5GdHRqM1o0WmZVK05EMHdobjMw?=
 =?utf-8?B?RG9YUU1nSkREZEpjVUdGd1ZTMDAvNEg5b2JyUloxRVRPSjR0ay83L0NabzlI?=
 =?utf-8?B?RzFXQTZEd01uODNwQlN3RDVqdSsrS2lwdlNIWmlHMTNTWG9DK2dLL3dVR2Jm?=
 =?utf-8?B?a1gyZHIyN3AwK0dpZjdrQW82dWVyZXdjSjlmUzlNbkpFUFk0eUl0d0lGRTgz?=
 =?utf-8?B?aWVVRG0xQWxFdndGMVQzVEdmQXcrRzZqZ2hkQjE4T3N6ZkErOEVxSStJTWVZ?=
 =?utf-8?B?WWIwenRxQkZ4TTFXR2VBV0tLc2pvT3JNUk1WOWUrRkxlRjU2cTVjNkVoUTNQ?=
 =?utf-8?B?aEE2N0FvOEpVWGhBQk45TjFnODM5VGh2TGpwNmNncFM1cWpGOUl0T09SdDlY?=
 =?utf-8?B?NzI4QXJpVG1MRGpmdDh0NW51c1Q1V3JQcngyMHBzN2gvMnRCZXExVS8vTTlj?=
 =?utf-8?B?dGtNc3ZuQzVaaUt1SUZlaWc0bHBveUpBQW82RkVvMDRsVzNFeGNVNXBHMXB5?=
 =?utf-8?B?T1JYNVlmOHViMUxYTlFvcEp2bm9nRS9yNVAyVTBzQUxWcUFqVzc1VzRzVnd5?=
 =?utf-8?Q?yvgxWDBzpG2ZQux3QEC3kWE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd886742-9968-4ee1-cdc1-08dba3d74cfe
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 12:48:50.9889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BciBHqLbMFHreMwY7KrVKCtXCdEcvZLkTBHlGS9Ne5a8Q4KXMa4ZppqjCNdvCDRUtTrlAssMxhghNKdNnGV3pmxGzChdhXrGJPWtsElun8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7343
Received-SPF: pass client-ip=2a01:111:f400:fe0c::703;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
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

On 8/22/23 22:58, John Snow wrote:
> On Tue, Aug 22, 2023 at 1:33 PM Andrey Drobyshev
> <andrey.drobyshev@virtuozzo.com> wrote:
>>
>> On 8/16/23 12:22, Andrey Drobyshev wrote:
>>> On 7/31/23 17:51, Andrey Drobyshev wrote:
>>>> On 7/24/23 16:11, Andrey Drobyshev wrote:
>>>>> On 7/11/23 20:25, Andrey Drobyshev wrote:
>>>>>> v1 --> v2:
>>>>>>  * Fixed line indentation;
>>>>>>  * Fixed wording in a comment;
>>>>>>  * Added R-b.
>>>>>>
>>>>>> v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00606.html
>>>>>>
>>>>>> Andrey Drobyshev (3):
>>>>>>   block: add subcluster_size field to BlockDriverInfo
>>>>>>   block/io: align requests to subcluster_size
>>>>>>   tests/qemu-iotests/197: add testcase for CoR with subclusters
>>>>>>
>>>>>>  block.c                      |  7 +++++
>>>>>>  block/io.c                   | 50 ++++++++++++++++++------------------
>>>>>>  block/mirror.c               |  8 +++---
>>>>>>  block/qcow2.c                |  1 +
>>>>>>  include/block/block-common.h |  5 ++++
>>>>>>  include/block/block-io.h     |  8 +++---
>>>>>>  tests/qemu-iotests/197       | 29 +++++++++++++++++++++
>>>>>>  tests/qemu-iotests/197.out   | 24 +++++++++++++++++
>>>>>>  8 files changed, 99 insertions(+), 33 deletions(-)
>>>>>>
>>>>>
>>>>> Ping
>>>>
>>>> Another ping
>>>
>>> Yet another friendly ping
>>
>> One more friendly ping
> 
> Looks like Stefan gave you an R-B for the series; do we just need an
> ACK by the block maintainers at this point or is there someone
> specific you're hoping will review this?
> 
> --js
> 

Hi John,

I figure a maintainer's R-b doesn't imply the patches being merged into
the tree.  Hence I'm waiting for the notice that they actually are merged.

Please let me know if the process should be different.

Andrey

