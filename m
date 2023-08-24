Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D61787482
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:46:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCWX-0004RK-39; Thu, 24 Aug 2023 11:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qZCWU-0004PN-Py; Thu, 24 Aug 2023 11:45:27 -0400
Received: from mail-am6eur05on2071f.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::71f]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qZCWR-0006GV-Pw; Thu, 24 Aug 2023 11:45:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk71r6GyAjcXzESxeRnUnZhQdys7cj60/ziiFcHEWjTF3kyUA2RliHcbubzRYhnHO3/1Iikyay/MruOUHjY3yZmctD/Sgc8McCMyClvw0IG9aF1gwrotEQnBGtLIM6xP8i0qWweLiAe7gpongBIevGXDFgEcUhfDZ46tflCKAHJRCGLjE6ITCsPUJxiIpdSWDxa6UM0pgh2FDDiaGAyt3928stceRJc1jCAKmuFC0uWUSzZPTzXPhQd8eJ275RbB2hvJC9KvQugBunABBV0wBBaV3vBwjcx8VffZ57lvEbXzmu0wSg+uNHKza90c/zHW0mYn5g5oXAgFhy0yb6stoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjTyPaBZiG+NTt/1qFP+S1LQELz0dYUFcCt/JxKA5h4=;
 b=MdxjnDFyDDpDwGR5luZjG7PQ2i52nP02nX6jGCXAwrgP3mULRwFXRTy9FqGTSDn91n6lAIAm080X2qPilCe+aN+T1+PesNJ1tM5uxJtPN8F/DXF5j96zxY0n6QK+ITlZzF50YIY4FBsOAO/flUmspqlngV4q257Pua99tQFjiJOOy5oDp6EchyzLHo3IY0J5yV6lRuvgTyq65N35VR+IfnI6VOVkLtbfPHup0bUaLoTCU41InTJnzFxAOYmCBdT52e5VzW1CVkBZzcXjYA7OAtEEI7jd9F7ak80PQTCNJC6OPNpKjS8Qx1+jZVxjfwBufU65UWhiiGypK34PJo9TOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjTyPaBZiG+NTt/1qFP+S1LQELz0dYUFcCt/JxKA5h4=;
 b=uVKaEuqMCyrPO/6iOGCtS77xfe01fbZChT0nJEMTaoJEYM3m7ZXvKHbTrcB51O+xRsvCi9cf1hA7S/8Huj+Rj7gkWJSmI7PW5Qdw87yZhME+c8F0luobIHe6NXfZfMGSEJibJ3g46ZJTLhJNhLdJZqUqYBJ9Wd+XDstJd+p0x76IBlAXvAoDLKJHWARbTEP10GEYeYM1cwJ3vygdIMPbfw6LFLuQlrb5xWWsb+sWNL0bnDEdHswhnV6Dk+COyUDBMaS48dBu9FoNGFFwN1AxXGaiVrU/WfQFjmt2LGS973bePl83T25k1y5pJX1f3v6fs0zQTuLsmUMlSfXXwl/S9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by DB4PR08MB8174.eurprd08.prod.outlook.com (2603:10a6:10:382::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 15:45:16 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4b14:4628:9a1c:b28]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4b14:4628:9a1c:b28%5]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 15:45:16 +0000
Message-ID: <d7283a16-885f-4d7e-bfc9-e4d4ff5ccea3@virtuozzo.com>
Date: Thu, 24 Aug 2023 18:47:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] block: align CoR requests to subclusters
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, vsementsov@yandex-team.ru, eblake@redhat.com,
 den@openvz.org, fam@euphon.net
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
 <c49fd209-9a6a-9e0d-752f-30a5178d855b@virtuozzo.com>
 <85e0a9bb-8e8f-e414-70ad-528e45a803e4@virtuozzo.com>
 <60354ae2-d394-49b8-8289-787b4e02e2a6@virtuozzo.com>
 <577e81f0-1479-41b2-9e97-ad6678cf7216@virtuozzo.com>
 <CAFn=p-bz35mcXgG81Dk70u4u8A8cqERot2=fJjYAcweThE0fVQ@mail.gmail.com>
 <3ea51ea2-0138-4a0e-92f0-175d8ad7540e@virtuozzo.com>
 <20230824143247.GB1412804@fedora>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20230824143247.GB1412804@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::17) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|DB4PR08MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7a5638-f44a-48b5-77e9-08dba4b91d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4an5uUltS5AQFh28hxwpZu2muWufdTvcDAHKDdagoq21nAaSk+Acj+Rfx1XPAiTEDO2WaABiUdZihLzVby1LgVtSraGRtBzrO5HeHCvjf7NCAllzk2NspkEqqGc4oZd/uIK3mGU/ac16BRHJbk9gKefZrXlgFEP7ct9wK53MxhLcjUNIFIzeSSaAdKMsb6tCylJDO4cPStF0aWykwD7+yQSI0xNXnA6T0kChE4Z8mDxrLLwwkL4cGGALiAV/1bBnG8HaApqNDrENxN/+OiXbWeMocQrG8tv4LLGb8YZ2xKKNC3y0hKPtlV4b3DpRBaNKhH/52tI1T/fsnvRL9XQhEMgvMedN8xbpygUrX98m7JXTGd4pGzj+PchscKnEPoyIj5gbOn+sd46lxvjQomJsohojyLEuZH2Oiw6RyV7A1FRay8rzaw1+JVB/zA0blnV4ghVABYDN1YnfT5ZDEJwAqNYYR5u6Gc6nWBsC/aypURGyor3YGq3uB49N66lkGp2q4ZURuxNziqIau1wGRiFZLoFkQhL6UwlVweDWl0sn1skVuUp51jVrZJcprR0sID1zAef1PgJEBnLKy3cxltjRQUPU/ixkOCF4b2z0EuFs1n95cVQijhRNrXUwR7PbTDFRHoAwBdFzKIPbx103aiNdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(136003)(346002)(366004)(376002)(396003)(451199024)(186009)(1800799009)(6506007)(66946007)(66476007)(66556008)(316002)(6916009)(478600001)(26005)(44832011)(38100700002)(6666004)(41300700001)(86362001)(31696002)(6486002)(6512007)(2906002)(53546011)(966005)(31686004)(8936002)(8676002)(4326008)(2616005)(5660300002)(7416002)(83380400001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUxOczFoS3NuUllFY3czNUtQL1Y0MDNQN3c0YU04Vklja0V6OFJWYm9OcnRD?=
 =?utf-8?B?UHJuVTBlQm5Ma3hQNjJ6Y0ZxdDBJMUJoSUp0UFFsTUVKTDk2Y3FjeFJMekUw?=
 =?utf-8?B?ckFnSWM1U05xSDlpQkNRSGo5R0FuNTFybThSeHJ6T3l2dmlKRndKcGNxbFFk?=
 =?utf-8?B?TFZMaGVKd2xlRnQ1aGpwWFJJUVJGNXVOTG5EQTJ1aXByMkM0QVBwb3drdHFx?=
 =?utf-8?B?alU3eWRpc3ErcTUrMmxUZGJTeFQvdUFkU29NQTZIL0trQTBXcHVSa1FsR1Nk?=
 =?utf-8?B?eE80dWRFcjFPVkZlUkFMTk15ZXRqbk8xUGdlVllUUm4xY210VksvS0R3QnBQ?=
 =?utf-8?B?bXEvdzVXSHJaNXNCTFpibGdTaHdONU11M0JvRDhja3Noenhaa0w0cWt0Uno5?=
 =?utf-8?B?d0dSbjdvTUkrNlczZDRaUXB0L1BnQm9zQXpzY1EwYWdaaC9rUU43V1hpL3NU?=
 =?utf-8?B?Y3JURmZqbk1BL1QrVVNxNEk2anlKdzI1K1lNbVk2bER4QUovTUVZN3F5eTZy?=
 =?utf-8?B?cDJnaFpjRGFsMW5ZV0N2ZDhFWlMrK3FrUVFRaW54cmFJRzBzeE0rV0NaUGFB?=
 =?utf-8?B?QjBDaXM0blpRYWJxQTk5NnFYR2U2NUJkLzd0dEFKL0JMQTNXMVpuNzV1dFBw?=
 =?utf-8?B?NkQ3ekh6Zk5QaVdLYW5BS2dMNThsVld3bHlEUTZERHJ1ajlhNjgrSGFKc3VM?=
 =?utf-8?B?MVpYUHRmbnBHRnBEdHVuV05wZzdCL0UvWU94STRGclVyb3N6eWRxMjNEcklB?=
 =?utf-8?B?NzZMaWgzdCszVmRwMHNVQTAvQ3llaHdVTHJzdnFQcFF2YnZPSGo3VGpEeFh6?=
 =?utf-8?B?VlpuUW1mM3BYT0UxWXM2RE1kT3JDKzh1ZGdoWkN4eE9yNlUvRm9oUnJVMldh?=
 =?utf-8?B?OUJJbWF3VlhYdlkzdFRzZE1iWUlyMW5HQ2ZyU0xVTStSdkpybVdRN0R5ei9N?=
 =?utf-8?B?WnIvUjNrOFRPM2l3ZUZqcCs5dGtIWXVUTjZkNWhwYnhVNTZMVTRlYitCeGFK?=
 =?utf-8?B?b21pRmZTdFprRzBLV1ozbVBYQ2tpS0tld1Voc3p0NzNzVUZwMFFDQjQvWXVX?=
 =?utf-8?B?TlQ1UUhueEhVN1hsMjhEUFFMbHhMaU5yb1MrS0poVE5yelNGTnhpOC9MeGJt?=
 =?utf-8?B?MjQ2YnNtbFJTQ0pXVVozRExTaVM4V3VOZG44QVM2RnZTWnM0UnQzRVFrNkxH?=
 =?utf-8?B?Q1p0WEJmeUZTeWw3Z29XamkvWDIrUDV3Uk15WXl4dCtrdm1hdVgyczdKVHNu?=
 =?utf-8?B?NEJLUTNFSlRvVXZMdHNVVUUvV2w5d0xrTzk0dnJrbHVxSHQ1aGFLVHFCZmxj?=
 =?utf-8?B?RG9QdkFMbzdhWU93d2hvOGxvenRWbnFzNHlYRHQvZHhxQm9SUUczaFFIcW1n?=
 =?utf-8?B?YW05QW5PRm5DbTFOcHdDRkw4WUs1RURmZWNqaHo3M0hFOVlxMXVMd1JoeWNP?=
 =?utf-8?B?ZU1weXo4dHZOVzBtNjlSTkgremgvcnl3UCtHalRZRXp3Nk1JNVEzclpJVGtJ?=
 =?utf-8?B?cHNLNW9zTjZqQ3ZuZFNDNGtPTmRmR24yVlN1cTV6WXIvZEVlNkZjU2FqaURw?=
 =?utf-8?B?aWprKzg2eWowNzhpTkZscVYzdXZkVWsxME55STFpK1dtQzhiNWZtU1A1OStq?=
 =?utf-8?B?US9RY2pIeTdMMXhwQzN0ZDFwdndDTGIwU2tPSXVBaWlYeHZmdGNZQVlDUDlZ?=
 =?utf-8?B?UnhUSUxRQkw0NkE4K01DanlVSkJIVlozbFN6OEsrZU9rc0NMWWROYVdjZHJv?=
 =?utf-8?B?TmpKVVJWYTRWUEVwSUJneWNFRUJtQzBQYmk3NU4xaHd4WkwyaHkxcnAvNlZ0?=
 =?utf-8?B?aE9lV1NLOXE3MmN2NkxBZ0FLWm45eEdHZzA3OFFrbkl3clJQQ2dHeTV0WHlx?=
 =?utf-8?B?cEZRWDdJdGdENlI0TGpKei9GTEtqaUtzc0M1aTJkMTBSMS8yWnpYTmwyV3lJ?=
 =?utf-8?B?TGlTTG8yNFpidTMzRVh6UUJGZUd6aVdFcnlXRHE0TDRCbnFhUHFObE5KQjBQ?=
 =?utf-8?B?aC9tWHovTC90b1lOTDFIMDlvVnV0OU1BUmFPS2FjVGJNRnZlUmpZUU55cHN0?=
 =?utf-8?B?eWg4anhWQ0QzYWp5Z0FmWkdXYmw1elZXNHVZUm9tYzlBemVMbWFyOUVkVjha?=
 =?utf-8?B?N2RxMC85Rk1qYXRZeHZrck9IbzdXWmxZUTc4RXZZMXBuT245dC9XZVJEUkF4?=
 =?utf-8?Q?AWatwO118l8bZQ96IYAL6rw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7a5638-f44a-48b5-77e9-08dba4b91d06
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 15:45:16.7262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOlMbCmgPlfP5NketYJ/4zZrgwdurbsufKY7Ifmyrgv+NBKbq1E5OgloexH/gnrTQnfDgTR8USGYBgcjC3TNV7aNEDin1mke5Qfl7hKqhhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8174
Received-SPF: pass client-ip=2a01:111:f400:7e1b::71f;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

On 8/24/23 17:32, Stefan Hajnoczi wrote:
> On Wed, Aug 23, 2023 at 03:50:55PM +0300, Andrey Drobyshev wrote:
>> On 8/22/23 22:58, John Snow wrote:
>>> On Tue, Aug 22, 2023 at 1:33 PM Andrey Drobyshev
>>> <andrey.drobyshev@virtuozzo.com> wrote:
>>>>
>>>> On 8/16/23 12:22, Andrey Drobyshev wrote:
>>>>> On 7/31/23 17:51, Andrey Drobyshev wrote:
>>>>>> On 7/24/23 16:11, Andrey Drobyshev wrote:
>>>>>>> On 7/11/23 20:25, Andrey Drobyshev wrote:
>>>>>>>> v1 --> v2:
>>>>>>>>  * Fixed line indentation;
>>>>>>>>  * Fixed wording in a comment;
>>>>>>>>  * Added R-b.
>>>>>>>>
>>>>>>>> v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00606.html
>>>>>>>>
>>>>>>>> Andrey Drobyshev (3):
>>>>>>>>   block: add subcluster_size field to BlockDriverInfo
>>>>>>>>   block/io: align requests to subcluster_size
>>>>>>>>   tests/qemu-iotests/197: add testcase for CoR with subclusters
>>>>>>>>
>>>>>>>>  block.c                      |  7 +++++
>>>>>>>>  block/io.c                   | 50 ++++++++++++++++++------------------
>>>>>>>>  block/mirror.c               |  8 +++---
>>>>>>>>  block/qcow2.c                |  1 +
>>>>>>>>  include/block/block-common.h |  5 ++++
>>>>>>>>  include/block/block-io.h     |  8 +++---
>>>>>>>>  tests/qemu-iotests/197       | 29 +++++++++++++++++++++
>>>>>>>>  tests/qemu-iotests/197.out   | 24 +++++++++++++++++
>>>>>>>>  8 files changed, 99 insertions(+), 33 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>> Ping
>>>>>>
>>>>>> Another ping
>>>>>
>>>>> Yet another friendly ping
>>>>
>>>> One more friendly ping
>>>
>>> Looks like Stefan gave you an R-B for the series; do we just need an
>>> ACK by the block maintainers at this point or is there someone
>>> specific you're hoping will review this?
>>>
>>> --js
>>>
>>
>> Hi John,
>>
>> I figure a maintainer's R-b doesn't imply the patches being merged into
>> the tree.  Hence I'm waiting for the notice that they actually are merged.
>>
>> Please let me know if the process should be different.
> 
> Hi Andrey,
> Kevin is away right now but seemed happy enough when I mentioned this
> series to him, so I have merged this into my own tree:
> 
>   https://gitlab.com/stefanha/qemu block
> 
> Sorry that your patch series have not been merged in a timely manner.
> 
> Stefan

Hi Stefan,
Good news! Thank you for the notice.

When you have some time would you mind taking a look at these series as
well:

https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00068.html
https://lists.nongnu.org/archive/html/qemu-block/2023-07/msg00106.html

They've been hanging in the list for weeks (probably even longer than
this one) with little to no feedback.  Would be nice to know if people
find those changes useful at all.

Thanks in advance!

Andrey

