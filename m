Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B93127A5EFE
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:03:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXZn-0006is-8L; Tue, 19 Sep 2023 06:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qiXZU-0006ho-VS; Tue, 19 Sep 2023 06:03:09 -0400
Received: from mail-am7eur03on2070f.outbound.protection.outlook.com
 ([2a01:111:f400:7eaf::70f]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qiXZP-0003Pn-Rh; Tue, 19 Sep 2023 06:03:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/f0LI6VFxtxBO2ti7+n96YKAsLITS3J+vaZG3EqW1V5WpkUBd7GIzjQD4QNryQ+GzAnuQ1aH9QgsN4BnxcCNISelDU3ageNqEETBfUcRiQh5p8yBzi6iYUOVIGe5P04lICTOxczAL4MfqKtrlSHRhieb7DTKrJu0oD/pkl028nDq2HA9BochW1GSYJ2neK7p1mGy6Sw2M6t6PdHirkKZ0wdVtRSD+x6uflv7JWc1pe8+rWuwUFSaIATawpKu6wMxy7oZzAEdPL//BirAPKmS1pONCqKnQx9gBk5RtupTcUapKApC11lOQq9Iwe5HbcMNTXPsZ8kRsZt3sTtR1I2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69QG+RVShn4MC5Uh3YHU6uXyNy4xDvNqmHvXqlraOro=;
 b=g+V0CR6pA1JKzLoLNvdeGUSadAYkLtSQ6QSXSLKC+qbBN2mWCrUTtaGOfZjZN8xE6da+taZsvutR6nXsjknoaxAHHMcTThsqgQoM/sRuq+VF0AknN9TKixTv/Ad+/OkG2e+aa6f6r/dmMQ/VtuuNgJUem/pMVC2EcXCCZkP/pBdfaajTwWLyfx2FfUwUN+1sRgSjXVNIdFdjvDpEH09empucz7iplUslF5gia8s0JOmgZwcdAx1bbmaVd2pUw26sB4dDX49J5mD4+WcijhrWPpwmSqZIAh6Ysbj10PjrqNe4+2fYY/81r0ZE+RneDOig3bf9FKEZxqKI/3jgsaA6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69QG+RVShn4MC5Uh3YHU6uXyNy4xDvNqmHvXqlraOro=;
 b=zJWXGEXS0tmSO7igzSvUZzpaF1UugpJCFGnig91rVLGIXbjwhZfPsdeo+S+b7F+S403JbJKvkMQay2ShhQ6JkUoVIQ/sW3PqOucNjK7UWOfs2HPsvVpWeSTHlf96FZaRS2OphypHn/glMvdwjqknR7uwHe9wH/kLfAFOPnPVZ0as8++pXCfGhSaZnrEpNpfqFINmIJKABrNuFmDKVlVsj9467wPjDc9dZV1DztQgPGhWgMQsM9NJPGFz5a8dJGBfXihJVzNxMlaNgp9LMCP62ttQ4BBWD07DocG0MFW38GOKYziVBH0MzIgoFHJH2l4cb75fYlB7X1J1sr54bkZbbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::16)
 by PAVPR08MB9700.eurprd08.prod.outlook.com (2603:10a6:102:31f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 10:02:58 +0000
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::eaa5:5afd:d503:73b7]) by AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::eaa5:5afd:d503:73b7%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 10:02:58 +0000
Message-ID: <867fb4e0-51ad-8572-f6cb-b2ed3791e34f@virtuozzo.com>
Date: Tue, 19 Sep 2023 12:02:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] blockdev: qmp_transaction: harden transaction
 properties for bitmaps
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-devel@nongnu.org,
 den@virtuozzo.com
References: <20230904083116.568912-1-andrey.zhadchenko@virtuozzo.com>
 <a8c81f0f-eb3e-0574-e6bb-4fed9005a7e6@yandex-team.ru>
Content-Language: en-US
From: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
In-Reply-To: <a8c81f0f-eb3e-0574-e6bb-4fed9005a7e6@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::11) To AM8PR08MB5732.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR08MB5732:EE_|PAVPR08MB9700:EE_
X-MS-Office365-Filtering-Correlation-Id: bc813784-83e4-46b1-c1d3-08dbb8f799d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZdRaIZi/R0wrkYBBQBat+h+Z5MGwHRF05RJfIU6QD18xjGO5Aj0nWMUQGWKpkwnDXeZS0+AFKidq8srWCUnUqTE6+ZgOUgdIHm8/Cx9wmoL4dVHp3aw5S64YSUHH150dOnhG/7Fbay+KN4GfYlcHs88ox0ei+1cv8dGl8tcIdUn+pwFBlLcWs1v4b4xYeNuWNpsoMC1/0WI7mUiL/hNznDtu/OivK/Oxkij/rkHRNVjwI0HLytvXz9pfmHobwXfZHWtfsS8vJepG84Z123GilBmbjgrslUbAnCfSD5WnyKmGFdmr61EikJYVAXTZa8uRtz329AlxX74vP/daBsaNAaY1vAUwKSGPlo8eydmVbKyGuZlVTzIjdQTa7Nfp7NjftTEFbyAAW99ZEizSWv4i8CXQgXNBbAyUAChp0WPJFIKAG4j5DDvvHO0spKduo42kh88BgiWQ3Vx34LXZTtxmpl+QB0myNSXioqQvReXndWuCNIJxX/tG4JyP5adgcr1IbCyhwxjtP/23m76o29/8FW6OUGx+cYi1OMZELbK96rhI42zvJdDq5oxfbKZ6igNoZgwbS9A++26sVzsG79eN5WSSLharAcXvlPOmoS98GjdQuEGuRls+cqLm4Eq6wO7tePnzASCaD3gU6mI7ugUbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR08MB5732.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(376002)(396003)(346002)(136003)(451199024)(186009)(1800799009)(31686004)(6486002)(6506007)(53546011)(83380400001)(86362001)(38100700002)(31696002)(36756003)(2616005)(107886003)(2906002)(6512007)(26005)(41300700001)(478600001)(8936002)(4326008)(5660300002)(8676002)(66946007)(66556008)(316002)(44832011)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUxDbDFEL2p1M1drelY3UHBURW1FS09IRnkzYmNHTlNhMmlHb3pWMlVPeTNm?=
 =?utf-8?B?S1Y0SUI1dW83ay9KMTZJWk1aMVhwZlB4RHdib0RkU0xqNEFOZVFUVnVlRVN5?=
 =?utf-8?B?bVY4Wi9aM3lvWVRBVUFPY2NMM1JSM2t6T2U5cDA2MFVUaDV5Wlc2TkQ3Nkdr?=
 =?utf-8?B?dW1ac2JtMU12ZVIvL1lPME50OGZtSitpSFMyNGRqL0U0TTJ3dzhkNFVoL01K?=
 =?utf-8?B?aXJIZTltNktHUGNlU210QU9ORVZXMVBpZE5wMEhacUJtTnh3VjU4V29OeUJI?=
 =?utf-8?B?YXpYT3c4eDlHdXlDUU9rT0NLTkQxTWhwWGkyeDZkdnFBcmJ0K3Z0c0xkVGZE?=
 =?utf-8?B?VHVwcVgzQTNvVnFRTWpSWmRVSE1KREFkSkM4WkZzY1Q4WmpSRFcyakdWejI5?=
 =?utf-8?B?VGkwR0pvQXFoTVpUS0U3d1ZFMy9mVG9Hb2pTcFBlSXlKaGxQNytRQit2ZEdM?=
 =?utf-8?B?bC9UVTdGaHBPUU1QMzc5eDZyR3FRejhnOEw3SlFaZ1kycUNDL0d2K29XVjJ3?=
 =?utf-8?B?aDRtb2dsb21wRXd3VTRTeEhiQW1UcEVuT0QwV3NJT2szNDIrbEZYcDRaWjdq?=
 =?utf-8?B?V1UzVEJtbTBPVkxBS1JvL0JzZ2c0YWJCdDRZYmkvOHR6NDJRSGhWaG9ieHps?=
 =?utf-8?B?SUxFUk9Ud21uM0hSTnNFVW5SNDlma0xBenRSYVlSdUhpZnIwUy9xNXpSWUI5?=
 =?utf-8?B?SGlNWFBmNjZaWFNWZlA4WWhqNVRtUlJYOXUyRlRaMi9hSTQvVjdXZU9VQVpN?=
 =?utf-8?B?bTBBeWplelVRZlR5eFZxZnFrb0t1aWdZTTJ4c2tSK2tsOXM1RnRJV2dsVDk4?=
 =?utf-8?B?anhjUHladmlUS3pXMGYxY2Z5bldQQXhScmRKcVdMa0RIRi8wTkdyTjd6Qkl4?=
 =?utf-8?B?Mk5CcmFVRGhxMXpWcExYMGFYSDVZb2JmSldtM0NYVE9rQUQwblBiZmUzTER3?=
 =?utf-8?B?NHVKdWtTSkZ3cUJMTm5uWWxoMGxqU1pUL09Ya2lPYklkalJ1NkhYVUd5aTFP?=
 =?utf-8?B?cjUydHBXSWJmVW9GcFoxdXpZZXdPcDVBZk5LaHpqME1oZHBPZ3c0UXhhRk9r?=
 =?utf-8?B?SGtoa2NkUnVPMzhGckdvd0RNMThOakd4L3M0N2xVWVdVcXBOS0hRWXFLMStS?=
 =?utf-8?B?bldCaHpaTlJTM2ZnYjhDU0I1aEFveG1Oa0dYVEd3SWVpWnZyN3NrdS9KQmlC?=
 =?utf-8?B?WVpsaE1MZ2xGamhuZ3lzMjFVTXBKNmhVT1hnWUhlUUUrVkkwSlpHMWJzOStJ?=
 =?utf-8?B?MVFRQ25NOCtyMzhURkxad1cxaFRYU3NHbE1YZE55NTUrTG1BYi9lVkEzOFV1?=
 =?utf-8?B?R2RyaGJsWWhHVmowL292b2FXSGdBYkdrV1pKTElHaVRjUFlBUVpDZjhwL2ps?=
 =?utf-8?B?T0dqSGNRL1ZHdFBSODljSUhIMElTQnZKZGJZa1lhenk2RVVuMVFkSTVTU2Nq?=
 =?utf-8?B?MjczdzZjbmY1WDcxRVFRd0tvSnEzTnBOdHNZYkU5S1hrTlAzcmttVlZtMTdZ?=
 =?utf-8?B?L3ZlYy9VanlRb1RWb2J5UHd5U01ta0RMWENFa3p6TDVFcW10d1BFdjRaRVYr?=
 =?utf-8?B?eUNjclRIbVp1N2pBYk5JMUZ3enA3ZkJzMlltNEpLaG1XMms0dWlWRzN1aDBX?=
 =?utf-8?B?c3pZVVJQUlJvZGRnSUhOZEJPUG0wV0hhaG1BWThzamxlN083Nmo1WXFVVHRS?=
 =?utf-8?B?R0hJdmlqalgzeHZ1L3FUTXFJVnRNZWV5WENTSVR2Yzk1L2Jtencya29FK2NX?=
 =?utf-8?B?d21oUjVFSWJzb2lab1JjVVdEUWhOQ2t1dzBxZVJERFQ0WS9Lc09QbjhOTkpD?=
 =?utf-8?B?Q3RjMWVwMkV6b1hPSnI2T3o2YWJFTnVJL2lYMmVsVWllY2ZNcXd3L0xXQ3Vt?=
 =?utf-8?B?Y2JlTHhmTjhJYkpnNjlkRjRCaFozRlVuS0VxUS9GZjFWcjF4bGM5SXVIaHZ0?=
 =?utf-8?B?dElLNkE5ajBBM0lDZGJHNEI4bXc5V1VCRW9oN2NIL29vSnZObUR0bU9QV043?=
 =?utf-8?B?TmRyZ2t6UVU1Rzlpck9lS3JMak4xcHIzYVRjdFFzMmEvZ2FOZDJCZ3JJVU92?=
 =?utf-8?B?STQ3c3pqOWhMOWZGQ3NzWUJrQnQ2TlBjVmpjQkdnN21BZ2xvM0YzTk4vaWFr?=
 =?utf-8?B?STVzWEJPeU81UENvdDR3c1NlUkc1TW5XWjJLYTJuN0I4ZUdZd2NDWG9SREN2?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc813784-83e4-46b1-c1d3-08dbb8f799d4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB5732.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 10:02:58.1385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUTXJZKDD4dGQTna34DRoiLDLk3yqtmfy/Cm+9B0MA2pVsmHf5p52l7UDLIxQ7V89tuKVKpGlTpE5VUl2mqnUg5pfi3hRVCxzntebOrR7ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9700
Received-SPF: pass client-ip=2a01:111:f400:7eaf::70f;
 envelope-from=andrey.zhadchenko@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
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

Hi!

Thanks for the review

On 9/12/23 21:29, Vladimir Sementsov-Ogievskiy wrote:
> On 04.09.23 11:31, Andrey Zhadchenko wrote:
>> Unlike other transaction commands, bitmap operations do not drain target
>> bds. If we have an IOThread, this may result in some inconsistencies, as
>> bitmap content may change during transaction command.
>> Add bdrv_drained_begin()/end() to bitmap operations.
>>
>> Signed-off-by: Andrey Zhadchenko<andrey.zhadchenko@virtuozzo.com>
> 
> Hi!
> 
> First, please always include cover letter when more than 1 patch.
> 
> Next. Hmm. Good idea, but I'm afraid that's still not enough.
> 
> Assume you have two BSs A and B in two different iothreads. So, the 
> sequence may be like this:
> 
> 1. drain_begin A
> 
> 2. do operation with bitmap in A
> 
> 3. guest writes to B, B is modified and bitmap in B is modified as well
> 
> 4. drain_begin B
> 
> 5. do operation with bitmap in B
> 
> 6. drain_end B
> 
> 7. drain_end A
> 
> User may expect, that all the operations are done atomically in relation 
> to any guest IO operations. And if operations are dependent, the 
> intermediate write [3] make break the result.

I see your point, but can the difference really be observed in this 
case? It is probably only relevant if user can copy/merge bitmaps 
between block nodes (as far as I know this is not the case for now)

> 
> So, we should drain all participant drives during the whole 
> transactions. The simplest solution is bdrv_drain_all_begin() / 
> bdrv_drain_all_end() pair in qmp_transaction(), could we start with it?
> 

That would definitely get rig of all problems, but I do not really like 
the idea of draining unrelated nodes.

What do you think if I add a new function prototype to the 
TransactionActionDrv, which will return transaction bds? Then we can get 
a list of all bds and lock them before prepairing and clean afterwards.

