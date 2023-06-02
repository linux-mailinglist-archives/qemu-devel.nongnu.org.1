Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7813D71FFAD
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 12:48:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q52JG-0006NH-5e; Fri, 02 Jun 2023 06:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q52JD-0006Mq-Oj; Fri, 02 Jun 2023 06:47:03 -0400
Received: from mail-vi1eur05on2072f.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::72f]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q52JB-0001S2-IJ; Fri, 02 Jun 2023 06:47:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heFSb70aJRDoTzuRMJ/Az8xDscGr46GOf/sw8+fyQum1hh8fBOf/rcu+LRurzb14JOdDV7pCPeN8G3SQfx8jrGP8B8+jNYqssT/oh8BAe0jSqyCLBkvDKnzQGhWYWLpqklnLqbBTokD6fUgVEY0U0NKaPm2yIhYAgoSdZZSMR7IybAcfLorBX6/Mju9aE5mL9R/lhO6GMBMpStToH5bSNZldgsSOdiMeqdXz0Ro4l0ghR60ZBwUU8kpjfx+RnANX7dZvXOwB6FgPK6mR4T+JyHRCbSIPX9F5QqDbOap6k5QW9PYoUGzrbSuqmstucyJI/Zq67qf2rHBBktLFgtvrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQwneJTuZFWrsCYNDOzaC3+CgYFvSoQ1B0HMGXFlTDo=;
 b=BVQCFpJfxe786CaP/a+3Uc6+OZIRF066PFUC/HEIK8XVGoFhEy4MmIc6i88gGQx7fnnCN0bi/c1aISzzQNHxuI0seCBTyWnhCwZpw1senXHfGQON02Y14GKFZV2y+MldIG/tla6bOb0i/x6jabE7DFHQazinfeV78R6G6ubLZkrR7cUs8NY981yOU5Q7Y4umvYHmrYKOo+YMrs9GvhUTR2JLew1EvhtH5+luOA1g1Ur2JhAXUyt5KUBPtvQQoqCI8wbgNdXBfCXagNA5xqI/N0fbZiY9nvTICSA6bvCrT0HxOjhOXcoV1VheeNfPclwexDd+Am4xcJl9ehydNv45cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQwneJTuZFWrsCYNDOzaC3+CgYFvSoQ1B0HMGXFlTDo=;
 b=p0m5qeeOFE6BXbN4/q6N+mkAm2kmtVLQZ7kOPOAwsEwaZWXcQkBQJQa8qIXm1oDDx0Yq8TN+XcEO453m7BjhH7EefxeuoZbMVJhMeBQ9nT7tFy/49uQetQvxAJ5x8QEhFXG30lud6UmpBpdLFbeOyGYm5h9vgn65koQFUgHz2fAZktC+vuL449BUL5oyVaitGWqyKMBVSL0OrIztzLBuAtShQW3soMjGEs3x3Bw+n3Iw7rNQOpixu94LGyMlRlkRqJZi7E4HpPXiPvM4YWLUM2of+ZpGIJqTdYndSpbkcDutoOonkD0US8cn+wmOVwuJ6ymrjqOUV9EbMwPDpiNdbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by DB5PR08MB10216.eurprd08.prod.outlook.com (2603:10a6:10:4a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 10:46:50 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::21b0:d0a:6ec5:11bb]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::21b0:d0a:6ec5:11bb%6]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 10:46:50 +0000
Message-ID: <84bbbd9c-0e89-0a42-9cec-1d68f91e3d99@virtuozzo.com>
Date: Fri, 2 Jun 2023 13:47:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/6] qemu-img: rebase: stop when reaching EOF of old
 backing file
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 den@virtuozzo.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-2-andrey.drobyshev@virtuozzo.com>
 <ea1d491c-acd3-9873-621c-d263e6f8cb72@tls.msk.ru>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ea1d491c-acd3-9873-621c-d263e6f8cb72@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::15) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|DB5PR08MB10216:EE_
X-MS-Office365-Filtering-Correlation-Id: b5565a02-9320-4375-0732-08db6356ab88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kiw8mVWb45XiNuCluGT9eYnMsdhhBZuxLyumdZmqtip1z13q4CLqyh9lcdGl6mPkB2BZCWe95TqItikx3NU6hiDUw4zDF+SB/NIjuKf+9g/UCX2rdOLanNJER5Vp++EAZ2gp7BH2Uua7utgPTqeBWwP4sHnXYdX+pyh1qm3y8K7SuiuGdFHAzcuv6FIuWzDdtiESkvvq7tqg5pSe1aghdomwm2O+yj/w+B8B1nrp1L9Ge0fNvobtquTk2QeG4ooL69tUa7qbx/VDaov6q6lQMyaByZX/TiWp6AGItr+vv/vXy1dBHYqcNrqekeYIWaT32w5s+pdx+VeAPfLL8GgGbCO2FDugfj5ihUhQcjqvvr19o+G8t/7XMTIdKr7FE/MLwMls0qbY9k0CEF6esfWwi5OKUDdnW5hKXBjKjK0PiEJGZi+W1zJP1t0rEpcq3BHqAFhVv8ZcivjhCNkmofW7OW0roo1FwQ3vGDDyvLTPQQLo1WgT73BVXPOm345s4H8fKiI/KVsAq9SI/rySHi4Is8Hg6KqlDdaXIBQj2WtWmWAPEq4WQCi+ZTxJ0vzjaOZytxoBHc8Vk2LTXiFI1QdQX7MOLbkHcj8qCTnbULqNiZ6u5VHH5HTdGkJVPNcuedBwgjsv3p1ARsXpZp9FclZBJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(39850400004)(136003)(451199021)(31686004)(83380400001)(4326008)(66946007)(36756003)(41300700001)(38100700002)(316002)(6486002)(6666004)(6506007)(6512007)(26005)(107886003)(53546011)(66476007)(66556008)(478600001)(31696002)(8936002)(2906002)(44832011)(8676002)(5660300002)(2616005)(186003)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEZOY2VaUGduNWkwQytOL1FoMnBxRGdFaklYamkxT09iNmZXOTRoOTRyUUJ5?=
 =?utf-8?B?VXNicmhIOXVaVUpQbCthY3VCQ2lmTUhnTGhKa1F2c1dPRHd1dXAweHlRRkdu?=
 =?utf-8?B?NGVvQzVWQUdwZGs1VGZuWnBya2Q0ZWZGcVVRdXpJM2J6ZUJsc25nRWlYck1n?=
 =?utf-8?B?elJybUNoSnZFS1JUY3drZU9EOGRoYTJsTEVmREhIVHgrRkphcVJFOEdDZkdP?=
 =?utf-8?B?UEd2LzBpNm9UaktJeDZQRGdUc3d3S2UyNWtmbityQ2RWcEM1MjJwUUNvQ3Jj?=
 =?utf-8?B?UzZXQzQ4dEU3NG00NzhCOTRoNmFncDJkZDR5dEU1aEZJV2lTNkZhS0t5N2du?=
 =?utf-8?B?ME8yNVRmNEV3NHJZa0ptUEluSjFwQW1xN21rdEtOTHRxb3p0RnBKeEtzZUpO?=
 =?utf-8?B?M2x0ZHNyMmxFREdGTTdEbU9UL0lScjhtd2pGQjVwMGJsNkhTMnpZeEtnb2Rh?=
 =?utf-8?B?MXZJUWMvTHpNTW9iSVhvOENhby9ZUjV1aDQyNExROUxvUVpNa0JWdTkxdUpE?=
 =?utf-8?B?Y2I4WHl6T2JsekUxakF2dG9KZm9iU1VNbzk0Z0pka2VubDNPU3E3TW9uMW5E?=
 =?utf-8?B?OWNwT2hDZENwcEJVellURUNyQUlxa015amtMWkN1Sm1BZTRHRWRxVGVYUExo?=
 =?utf-8?B?dm1lZmFINEdZMEdRZ2s4UDFWaGMzWjRzWDlnd1pDZ2grZVVDaGVFVHQzK2Vp?=
 =?utf-8?B?OHl3bEpqWkhZbktyL2FoOTd5cmE4dDhoZ0NLbmtBcVJLbTA4Vk5SNkI3LzZz?=
 =?utf-8?B?L2ZmMUs2aEEwa20zMWNaTFVYNjJNT2d5M1lpWUNFVzZuMjFqYjlMTmRhSnBy?=
 =?utf-8?B?Z0RGUHRLRTZvZmp2RFNjZytzL1A0ZEdyQ0c4Y25JenBhVmVWRUxTckNlbjBj?=
 =?utf-8?B?cDlQMkxHWS95dWVRQndzWTFraDNHSW8zZ0xLMURRK1p3b0hCOTY1Mis4ZTQv?=
 =?utf-8?B?OUpZdCtoRElyeitjb2d1VTRnNEJZVXdpSnpUek5JcFo2dFkvOXlOWjNtdjgv?=
 =?utf-8?B?Ylk4Y0tQOVlTcFhnMUxra0cvZEF3RVBFd2s3REpWSXR1VWhxa1FUSXlmcWtE?=
 =?utf-8?B?REVaTEhFS09nMHMwOWl6K0tFUE44MlVVNkUvZVNzbGNvQmtYYi85YlhQMGF6?=
 =?utf-8?B?UnhKZlp2L09sQXo2dnFEYTFEU1hYSUcwOHVFdFpQU2ZMa25kbzYvNGYxNW9v?=
 =?utf-8?B?WjBZQ3cxRzRrUzZZeG51OXVnSzVnd2ZYU1A5WUNid1ZYMHY4ZTY1d2E5Qm9v?=
 =?utf-8?B?QmJFUlJRKzgveldoU0JTN1dXWm1rZzdOU1llQkEyejZUWnQ1bWZoNDV0THVU?=
 =?utf-8?B?OUpMQ3VuQmd0aENoMThpZ3BUNmxIOGFBMGJWTkhCMi9hbTFwNmZYWHN2V05M?=
 =?utf-8?B?OFhrbWZXYWhLSW5iZ0pzMXZ6RkE3em9FdTh6OU9ha3QvL3kxZDVGSlNpUVBR?=
 =?utf-8?B?ZCt0MDNKMzk0VENNR1lCc21VZVhtb1E4aC9oRzNxYmE4Qi9ydC9GNkY4WHhK?=
 =?utf-8?B?VmU3c2VLY0hOcjAxaklRRktkYjZpZjE0djUvNXJPZnM2K25DTXBHQy85enpa?=
 =?utf-8?B?MzdaNUtFNGIrNTg3VzVZZnlUbWltc2l0SjV3Nk55dE11TFROZjczMFBYMXFG?=
 =?utf-8?B?MXhDZ1M5cDhjMm9XaEVhQ3VFSFl2MmJXeUcyRW56T3BTY1FlTHB5VGd4SEdn?=
 =?utf-8?B?b1Rkd3JwWWI5UUZiYmVkMHVWU2M3dWRVYzU3a2ZZVzRUSTZrUXVrd1RyZXdH?=
 =?utf-8?B?RGV3YTBqSlNOS21HTUxhaVgya1BwcVdOUUZCVm9PSTBvZ1A1RktSdndJZ1J2?=
 =?utf-8?B?MlZNcFNZMjFrb3pGSGtZTExEbTdIaytGb2NubldSY1FvdlhibHVEb1UvamhU?=
 =?utf-8?B?clZGNGVBNFJLalY0QVhReUUvU1FWRmdIM0RhSVhSVlhaaTJwTmVLU1hLdCtz?=
 =?utf-8?B?NWtVUHdzQjNKZkhoZEsvYW5wZGNSbzlYc2R1anBidEFlRDIzVjVLL01OZXU5?=
 =?utf-8?B?RkI0ZnMrZ2pMRFRyaHpsUVlZN0lUcVJHWDcwRnZpN0RqU3F3TFRidHJiQXlR?=
 =?utf-8?B?RnNCRkVlUHFFUlNJUkR1QUtOUkRXdFdHQndtUEtCWkpSZU1EeHlNN2E0dElO?=
 =?utf-8?B?ZnFXUFVOU251cFhVVFFYQTJuU2xac0hoQU5jREFSZ205RE8rZlN2cjljOWZ1?=
 =?utf-8?Q?3dee/5hld6B3RYTmDH4TwE4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5565a02-9320-4375-0732-08db6356ab88
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 10:46:50.0785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oL/y5wXSvYZCLZCmhQ8IER64FcIU2h0PLQAkvoqSCTXLkJvj1S+4Pv+AtjwBB0+0UOaRLOAwdU7FGkCvMJvNXc2Smp2wejXDx7fgvj6W5tM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10216
Received-SPF: pass client-ip=2a01:111:f400:7d00::72f;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/2/23 00:18, Michael Tokarev wrote:
> 01.06.2023 22:28, Andrey Drobyshev via пишет:
>> In case when we're rebasing within one backing chain, and when target
>> image
>> is larger than old backing file, bdrv_is_allocated_above() ends up
>> setting
>> *pnum = 0.  As a result, target offset isn't getting incremented, and we
>> get stuck in an infinite for loop.  Let's detect this case and proceed
>> further down the loop body, as the offsets beyond the old backing size
>> need
>> to be explicitly zeroed.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> It looks like you forgot the Reviewed-by: Denis V. Lunev here and
> in the subsequent patch.

Yes, you're right, thanks for pointing that out.

> 
> Should this be backported to -stable? Not that I've seen this issue,
> it's a quite specific and somewhat rare case..

I guess in the vast majority of cases the sizes of images within the
same backing chain are equal.  But as long as it's legal to have them
unequal, a bug remains a bug.

> 
> Thanks,
> 
> /mjt


