Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E660710A35
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 12:38:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q28LS-000404-4k; Thu, 25 May 2023 06:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q28LP-0003zp-1i; Thu, 25 May 2023 06:37:19 -0400
Received: from mail-ve1eur01on0724.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::724]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q28LM-0002rj-BU; Thu, 25 May 2023 06:37:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3ad7oVq9NzBulZR9uwLbxWMJICBDz7GGGHZCu0kf90WtF4cI31M+Tvkoa4m6CWkv6gbflGfF2aq/SSF5K7Olb3WE2+mk0P99zXudgiKQt6ZlGwDyuUqm30BNugR8WTYBv2EL8xzQevPxEn88GZni4Ir+xOiLtzQSMJ15Uzw4gZptiPcmK5LQ9lFP2mxPYbqRGHSlfM7I2+ofl0X/CHh7LHPhQI9F4/Em2pIfiGvyq9NTgTLRP2dOY/Rd8jJAAWE2JTbpXAEKFPS1OTnSXTA396PmSN6m7wCVuTzEEp6xDXCZEWEBGrdkJpHgtGN9z6iHJJ0JwbucKacuQHhOytAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbDPmhVoIlLNTWQJseFd6F8rLfbbXyJc2KRMTM6bv4U=;
 b=Y4eAvTpUX4if523+n9jlYAa7vSJVLDN9KsZtzioAKD0bIH2gkaFlyJxHjJvXn18Z+HvmL4AvlPA2lyXLeO218cHZpu0FU6WYSyJM3NJJECaT0PKTb17IlvIlWIUSpZBwgh5xBPLNNTIXRFD96XOMzPv+HW+nS6peGq25xlc5YiNjw5xqF4ryBQtZIzI8emeKIMMM/LgADre1KoQggYIXG/9Nfn2zNaQzSum/v4l/IFbiv1wIjEvy4lXa3vLu1U8WVDWUrryTE7WfAdvSoABDqnw85+/jpvUQPgTV1f88AJRlQpBMJqgvM7PQlDqv6H37IQzYCDfqWay+qLayg2Hhnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbDPmhVoIlLNTWQJseFd6F8rLfbbXyJc2KRMTM6bv4U=;
 b=tGs98ZCBq1nAaTsnoqBb7C43jdb625x6EOETUJDs42S6sR8zOHsPLyGr9ZAXm/dL2FwXvPTAH6/tKoc9UIuFz7FvJw3y/MfH8aGeX1nB9+zIDacR+BuHilNRqxPLcOVEuRLHbfwV78tK/mcRPDo4vXFeMdy6kF5DScxk7qSGUgE4dCripZfWjatw+IxkkpJpmS/HQ0Ee5NWHdNcyOOOoz+V0QmqYKTioHI1laszR+x1AmuH2zqN5O8EnwO1rugO0Wj0jCwToGWh8nluRkBc7ruy67XKGIPTZ44otZAAQerVd3pn1Md1eY+S6abvVWxylaj5TrMwn8+a5hreHSrmSxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by DB9PR08MB9465.eurprd08.prod.outlook.com (2603:10a6:10:457::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 10:36:53 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::21b0:d0a:6ec5:11bb]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::21b0:d0a:6ec5:11bb%6]) with mapi id 15.20.6411.029; Thu, 25 May 2023
 10:36:53 +0000
Message-ID: <04202753-b0da-757f-6e8d-ef8525296d02@virtuozzo.com>
Date: Thu, 25 May 2023 13:37:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] qemu-img: rebase: stop when reaching EOF of old
 backing file
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, shmuel.eiderman@oracle.com
References: <20230523162458.704266-1-andrey.drobyshev@virtuozzo.com>
 <20230523162458.704266-2-andrey.drobyshev@virtuozzo.com>
 <7f391cd8-0a4b-a276-d7b2-de91ab0e158e@virtuozzo.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <7f391cd8-0a4b-a276-d7b2-de91ab0e158e@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22)
 To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|DB9PR08MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f4e4b7-1a75-4afa-c8e2-08db5d0bf46a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjEb+9EoR/ELEzhklZllqKBwlX6ojqaWSQLd8M6Kty1lpPhmaggxnDYzOCu6BAMQnJtMlHLrs3gMQolEk8mBZtirkLqOr7vM6Lokzok9ww6Eb6OMAES2/qvmUTl00glNABlDv2Cd1NoRDhdyb3CbQ/C39aHrEr4Yex0eXZm3ucxCWSK4d1CC9DpYsNtUB5PIqDaf0X539w3XlXtN1Phr47B5aieP/rPHqgmcSMqQhtOellSkHWowRy0qporhbKmzMSDFPdgaB3iST2YgqapCXh1NO8vPpGmwW+rfl/SxNyBtBs0x6J0BYQZkff33WA+IdAjeXWzM9GLIbhPe5bLPzcxvMViy68JCUbC2cJ514+Yhqk+AvZEuhFErVpvSmFihDsuOzw0zfEI1cy5feIcylmjp+A4sbVTjUonc5eslh1zTJkNA4jUuGLJP9drc0lDxcl/+0zBBcHAS0VQbfZ95wudg2fEO1rRLLCFGamVWC4AEgjaLrzVi/T2WEhzF8HfL1EtHumPEl1KAg7BQVcQI2HMxEB5ebhSB+n2iKyyOLjLz7YxWzmi9i7I89ZmyBY5FBtV49z5N5iU4Rv5PhkP3juCVvqcxXJRjnmDhkbuiiRErBHtgU+x7pCIV2438jMmskyj36Izqp5yNbFemn/efmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(451199021)(8936002)(8676002)(6506007)(5660300002)(186003)(36756003)(2906002)(86362001)(31696002)(83380400001)(26005)(2616005)(44832011)(6512007)(53546011)(316002)(4326008)(6666004)(478600001)(66476007)(31686004)(66556008)(66946007)(38100700002)(6486002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGwvbmpCSE52VEo0TG9wK2VDNlpJM29tUVQySHZXSzRtOWgweXFuWXR1My9u?=
 =?utf-8?B?aEZQTlRqSVhwTm0wOTE0eXVFcU1uWHlaaHdoRnJmcjZPRFMzZmplMlRIZEhU?=
 =?utf-8?B?V1dPWDJ5K1ltTzFTN3JrWEx1L2VYK1JLMHROaWo1R053M050R1RVNm9CSjBN?=
 =?utf-8?B?T2FtTVZ1YUozUlYvMWd6UEd1L0R4RUtPR2U0NXoxQ0dUUUlOQjZnbEJVYnEr?=
 =?utf-8?B?S0FEUFcvcWQwd3daNUcxV1J3VzUzaTMwd3YycTN3ejVrS2l3WDdHSTdvaU9w?=
 =?utf-8?B?VGZSM0IybDlqV2JzNzI2WnFDYWZia0FSUEIrRUd4ZVJhZ3lVbXBkZVRrRmJ2?=
 =?utf-8?B?V3R5MklxaElINGJEcWJmWFJ4THVQRTJ6eGtoam5rT3YzeExuUkNaaEozOXMr?=
 =?utf-8?B?ckpVeUJSeGFkaTI4Z3NyeHo5OFVHU251LzYvdFJnL2V5bE9RaGQydFl4aGh2?=
 =?utf-8?B?RXJPNnVHb1hjdkRGczJiQVpIeStHdnZhT05ENHZaUUQ0bU1yQnIwOHRndGUx?=
 =?utf-8?B?TEpBUXNFVTljOVJUUHNrakdkYW1IQ3AwandGaWhJWWJ0YmV0cHBsRlBoeXUz?=
 =?utf-8?B?eXF3RkNNSUpFOG1MSGdYeUYxUmhjMkNOUi9ka0Z2R3BmKy9uN3EyakQxU08w?=
 =?utf-8?B?MEJVK0IwaTNTR2tjVkxuTUl1QzJyanBJOWZRcWcrVmh6TUlqVTZEdHFGdGV6?=
 =?utf-8?B?OVNrbXRZTW1xWTBjL2cwb2NTYldEcThLcVZVc1JKZElJZTloNXUvYS8xRzUr?=
 =?utf-8?B?QVErRzNFbWhCNDU4WDFQZ2hTVXhjVTNmTzBQamxtb0hNU2E1VStNenZOTjJj?=
 =?utf-8?B?TjhKVnArUlNZcVJ6cHM5dDd3ZS9OeVhaN2JpdW9MZVM1cHdjaEtvOGlYeGdW?=
 =?utf-8?B?YzNidUxNUlMxTTZuNTYxNVQrZlBXalY2U3FrVm05WGZYQ2Q5L0hlSHFTcXQv?=
 =?utf-8?B?ODFoZkQvQXBVV1Y0Ymx6U2dkd3FvQ0t0K2tqZ2hIKzNVSitoTlA4dWJockhH?=
 =?utf-8?B?dndSN0R5ZnlsLzZzWjhxRGN1Vi83Z2RuZStnRXVFcTBZVk9ib0prSmpzRVcv?=
 =?utf-8?B?UEFScnNnTk1VRXVIbEZ5RWZ1QnNGZk9nWk1xaXhBSmxmWi9HanRSaTFmN21h?=
 =?utf-8?B?VEpEbGYxdUFqa2pKOEtLT0JuT1Nna3ZXdFIyZmJWRHBuZjFKUWR1ei9uVXNt?=
 =?utf-8?B?K0xFV2dBN1QwSmhzZWM2Y011ZGpkNmVUeEV3MVFDNklyaGZ0MEpMNzVDVngw?=
 =?utf-8?B?Szh1cnJOcjl1eENVRVBhNGwyaTFieXp2NHZ4WVh5YVJUZk45cXJjWkhjbGJo?=
 =?utf-8?B?UzAzcy9CV0xNV3NtNUpoNGxHbXkrU3VBZmhwNmNERnhVMHpPVERQQVFiNzI1?=
 =?utf-8?B?OGdmUkwza0tHdG9PQk5RcmlhZUt6OFl2R0h1SkJNdm9wOENVZVJrM0RZWXZX?=
 =?utf-8?B?clpCRHUxUEVNZWZkV0pVWXN1K1VyWUtrOUJQaytwb0NsRVRCTU5TWHd0dzlY?=
 =?utf-8?B?bllXSDljcXgxejdVZktocWR5L1Fpbm12QnUvdU55b3B4QmRseWVsdSs3cHRT?=
 =?utf-8?B?eE1KUHV2cy9ydU1Iby8yTHNWK2wvejRKaXlzdjFJc1M0Q0g2Rm9vclE1Z21R?=
 =?utf-8?B?YzlGZHF5ZHl4S2ZxYW1BWEFqV1YwWWJKRUVjam9uL3MyL0hxMmxoVWFuY0pa?=
 =?utf-8?B?TzV2RnNuamRsVjBYak9KQmc5emh2Zms3ZWxYTzdNa29yVEo2UWoxQldkY2Yv?=
 =?utf-8?B?YThpVWMrbTg3QXBicE9FN1ZtQW9BUW9EK3NHV09tWjMweTNCdEYzV0x5VWR4?=
 =?utf-8?B?YUQ5dW9EZmxCcWtBYUZtbXZvcTQrSEY3bmwrdFpWN0pHQnVoRDUrMzExWlR6?=
 =?utf-8?B?Kys1QnhGNW1CeXI2OWcvRStIOWo5TVJoU2p5SXlZL01Rd3RnVk9FVlF2RnYz?=
 =?utf-8?B?R1RNS2daZkRPM1I2Zm41SEMxVFFDQ3hUMUxpNWY0Qk1ZcDFrNHhUVUF6N1hI?=
 =?utf-8?B?K056c2ROMW1NcU1hbzBRMHg1MXVRZkwwV1NUNi9ESXBJZmM1OGgxTHgzaHlM?=
 =?utf-8?B?RVRBZm1HZktXcFpuUHVPT0dDOENGTkxOSXRrMGpGOEZ6VFZoRnlkY0ExaXBV?=
 =?utf-8?B?azNvL08vbVdGZmE5M1VSNHVtVkQwREdIMEFsOHBnNmlrcDh1dzRMblVYdUlJ?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f4e4b7-1a75-4afa-c8e2-08db5d0bf46a
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 10:36:53.1632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcMNyA2gSXrSMXW+dVYi2K6zl7atCH24Yk7AzYSbAs4B08FXK8FH4g0d1cUg4Vn6xPRprBU13yi87ozt6Lbtkz29R8vXiG0FDgfMWYDX/fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9465
Received-SPF: pass client-ip=2a01:111:f400:fe1f::724;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 5/24/23 11:30, Denis V. Lunev wrote:
> On 5/23/23 18:24, Andrey Drobyshev wrote:
>> In case when we're rebasing within one backing chain, and when target
>> image
>> is larger than old backing file, bdrv_is_allocated_above() ends up
>> setting
>> *pnum = 0.  As a result, target offset isn't getting incremented, and we
>> get stuck in an infinite for loop.  Let's detect this case and break the
>> loop, as there's no more data to be read and merged from the old backing.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   qemu-img.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 27f48051b0..55b6ce407c 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -3813,6 +3813,13 @@ static int img_rebase(int argc, char **argv)
>>                                    strerror(-ret));
>>                       goto out;
>>                   }
>> +                if (!n) {
>> +                    /*
>> +                     * We've reached EOF of the old backing,
>> therefore there's
>> +                     * no more mergeable data.
>> +                     */
>> +                    break;
>> +                }
>>                   if (!ret) {
>>                       continue;
>>                   }
> nope. It seems that this is wrong patch.
> 
> iris ~/tmp/1 $ qemu-img create -f qcow2 base.qcow2 $(( 65 * 4 ))k
> Formatting 'base.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off
> compression_type=zlib size=266240 lazy_refcounts=off refcount_bits=16
> iris ~/tmp/1 $ qemu-img create -f qcow2 -o
> backing_file=base.qcow2,backing_fmt=qcow2 inc1.qcow2 $(( 64 * 4 ))
> Formatting 'inc1.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off
> compression_type=zlib size=256 backing_file=base.qcow2 backing_fmt=qcow2
> lazy_refcounts=off refcount_bits=16
> iris ~/tmp/1 $ qemu-img create -f qcow2 -o
> backing_file=inc1.qcow2,backing_fmt=qcow2 inc2.qcow2 $(( 64 * 5 ))k
> Formatting 'inc2.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off
> compression_type=zlib size=327680 backing_file=inc1.qcow2
> backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
> iris ~/tmp/1 $ qemu-io -c "write -P 0xae 256k 4k" base.qcow2
> wrote 4096/4096 bytes at offset 262144
> 4 KiB, 1 ops; 00.01 sec (471.447 KiB/sec and 117.8617 ops/sec)
> iris ~/tmp/1 $ qemu-io -c "read -P 0xae 256k 4k" base.qcow2
> read 4096/4096 bytes at offset 262144
> 4 KiB, 1 ops; 00.00 sec (56.076 MiB/sec and 14355.4407 ops/sec)
> iris ~/tmp/1 $ qemu-io -c "read -P 0xae 256k 4k" inc2.qcow2
> Pattern verification failed at offset 262144, 4096 bytes
> read 4096/4096 bytes at offset 262144
> 4 KiB, 1 ops; 00.00 sec (827.771 MiB/sec and 211909.3028 ops/sec)
> iris ~/tmp/1 $ qemu-io -c "read -P 0 256k 4k" inc2.qcow2
> read 4096/4096 bytes at offset 262144
> 4 KiB, 1 ops; 00.00 sec (838.611 MiB/sec and 214684.4139 ops/sec)
> iris ~/tmp/1 $
> 
> 
> iris ~/tmp/1 $ /home/den/src/qemu/build/qemu-img rebase -f qcow2 -b
> base.qcow2 -F qcow2 inc2.qcow2
> iris ~/tmp/1 $ qemu-io -c "read -P 0 256k 4k" inc2.qcow2
> Pattern verification failed at offset 262144, 4096 bytes
> read 4096/4096 bytes at offset 262144
> 4 KiB, 1 ops; 00.00 sec (88.052 MiB/sec and 22541.3069 ops/sec)
> iris ~/tmp/1 $
> 
> the problem is the following:
> [----0xAE] <- base
> [----] <- inc1
> [--------] <- inc2
> 
> In this case last 4k of base should be read as 0x00 (this offset is not
> written in inc2 and beyond end of the inc1).
> 
> This means that all non-present clusters in inc2 MUST be zeroed
> during rebasing to base.
> 
> Something like this...
> 
> Den

Thanks for pointing that out, it seems indeed that breaking the loop
just yet isn't a good idea.  Since the offsets beyond the old backing
size were read as zeroes before the rebase, this should remain the case
afterwards as well.  Which means we should explicitly zero the overlay
clusters which go beyond the old backing size.

I'll alter the patches accordingly (including the test) and send v2.

Andrey


