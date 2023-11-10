Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 019867E7C8C
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 14:26:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1RV2-0003W9-Te; Fri, 10 Nov 2023 08:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r1RV0-0003Vu-At; Fri, 10 Nov 2023 08:24:38 -0500
Received: from mail-dbaeur03on20714.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::714]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r1RUy-0003KV-4P; Fri, 10 Nov 2023 08:24:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fa15N01YjKmQSqgtQ/TXyUpGtXWdgnnfytpNJFZ90hXTRD+kj0nlFvyxN5F2tpTHQEIkt3SIjeUsJhs9sPRFVDnNs5l4tYQ6K8oXMbObfF9ss4SGyvi+xJCgeKjFzt5shH2fYeVRb9YS8amK6twadxY1t7yBVnN1y35DlA+wadPqn62cX8cAUO9qIA5QGkceQhblvwpaH4nVq8Hh9PLQ3xQ/c5ocAJsgfhilXQLflH9ctP3A272FCyZSR0MuTCDxpT4BPT+paQUBYwspYU3YV06mehhSYCD3/J8gKWKpVdTo/ec9b2J1RlqBbPA0kwN5HeD3R4dUcf/l1IgJ56obbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=785aPm/+F6jpGBmhyWIQExNCszwCmvkrWsMqKNaTBns=;
 b=ZYfaFbt45KoVCXUbkXM/smtYIy06FECCaq13Epy+svJXJk559FEoWjBw9x4Zo/S3DtMx4Ia3j7Z469Ba9naFD5U8Y56c0k83SvEVufJoz0H/TyMkZ+LcVcj3dK7IFKisG4qYQjwCmbdZM20x44Vo4pt6nyTENapnUr+JYT9n5D8G9bVNozTM8DaxT0vIkmi7FNKz1zQkJysbp5ADeGegY0vwbMFcEAa2keHtSBvxYqR51QAg9wMR3dz2LdPrAI0r3t/CcccWahqjm04qOjwf66ZLqbbdTcCVsZIeAhhTH6UDnaPGx1ZAGCuedgqN0x/OkSkqU1L1HMt11M6WnTqSKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=785aPm/+F6jpGBmhyWIQExNCszwCmvkrWsMqKNaTBns=;
 b=NMdDgfcLrOj8ZrIrsi0liMPmDMedwu18yh6Bw7iAG0rR1VC/J6Q1YmkpmsES9+LQTkxXYW9u+Yo6l/X5M0j1hQGAH2iwbL1CNT18T018MbXxqMzrQVxXte8TaHEOaOikQOcdYuJEl+Ohk1lZVMmS6X0a1FJsH6R8QnMxqbZ+THVYZ6Qb8TWEr6Q+GXYBEbv48mRT1x9+lWr3xB91jntsp8lGSx1eNPKTQke/XkX3guSeAjAyf4ZJUWRBjXrN6dYEXfIsZFrTqTZpghR0WZiACq3DDTsLE8lQcEOp0TUvX2JmLtvwdlpGPWS8pmZyoYCgqkvI/K+heMFM8vXWpHPDGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9566.eurprd08.prod.outlook.com
 (2603:10a6:102:2e0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 13:24:31 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352%6]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 13:24:31 +0000
Message-ID: <96e00b80-8dbe-4226-9ad1-b41342e3c842@virtuozzo.com>
Date: Fri, 10 Nov 2023 15:26:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] qcow2: make subclusters discardable
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-5-andrey.drobyshev@virtuozzo.com>
 <6ecd944b-0b8d-46b4-8906-3a9cb5511863@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <6ecd944b-0b8d-46b4-8906-3a9cb5511863@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::11) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 4665eafc-c98b-44f1-e594-08dbe1f05fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pQQuxrTbedEO0KCdB8LLqQq+sLhN5WilYvlOpV2SJFQ2278gPHsjXuCAZi9wcfu3pOd7NIisyXqF6g2ykDnd70QRzQZEMwy7FviCaxs0LPyQdU3Ryeui9tKK3ke8OIHy2Y5tkwVbx1hp+APKyz40t3OgwC4FSqdUY47bxmHb+4NCZG+30PUHb9vneZHZHPj8YAivq2jYe/rAm7oJTnj7T0zHg1q4ds6iBjDoTa3ZMoAeITrbj0etlRL8tN5qAlgq9ZocV2jE9Gbd/RCFVULvs2a3JYWGejv7f2cm6oFg5y7RGBJKVUSA3FA8uh+qH0w1DAieNJ6JMepgwriIQvBjg+PRSL26yuC+K8AID/6QNe3dZw25stjldY9jYm/ssqb3Oq1Q7V7Nj2HYS0sPAy3sTJ1nZPp+YlxbST4d9Cdn6kXzUS/kp6QvpNmN4K1709lqsppJQx90zmSlSUZVjolCeUcEMvgJN/I4CCjiLYnHBU3jufh6sg3Tqg1uc+eyeulDgQeLmN4hCABO5Lb8AVkw1HmjBvWS+9Laux0oSlmTqD4rwUFB3OlnbnwbpJh04u6gi0pcgpiM5mkHrRfIGj0jEN6VoRVq+qWuAetl/ITQkLAUYBBOMXYReeQ8+nwWz49Nt32Q16c4xWANMkDS4Je7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(39850400004)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(55236004)(31686004)(53546011)(6512007)(26005)(2616005)(107886003)(83380400001)(478600001)(66946007)(6506007)(8936002)(4326008)(8676002)(66476007)(316002)(66556008)(44832011)(6666004)(6486002)(41300700001)(66899024)(38100700002)(86362001)(5660300002)(31696002)(2906002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXk4ZFNIWm1IMEVZck1TNlczaURqVmhQT3ZtcnU1dVRxNXBNTE9uWVFDU3pl?=
 =?utf-8?B?c3BMSWUwVHgvWWh6SUhtQXhrbFFMK0FvMThOZHBVMExMZlF1Z1pWbFR2ekxy?=
 =?utf-8?B?dEtFaHpTQVM1MTMvMlQwZWh4dENhMGw4ek05c2lRZm1Rb0ZYQzhPdXNvM1VX?=
 =?utf-8?B?NFU1TzhGbVphMk54UHdOMWg3TE4xL2pQS05JVzdScVkxcnBkdVR5aUNNdkF4?=
 =?utf-8?B?VnFjbkxMTkJ5LzVTTDRlZGprc1VaazdZeHM4SzNJbHBQUWsyZU9ZTXMraXNB?=
 =?utf-8?B?aDNjQlNmYTVKelNWUzZUNitkb0NMR0wwUFRKRHQzNlZxamZvSldXSUFsOG9P?=
 =?utf-8?B?b1NhNE9Td3EvMzdpaks3T3lmSVRveEtINHdKRkhsV3ZlendpZElwczQrcGZU?=
 =?utf-8?B?WWZBcWJOL09xdTNXaTJ5ZGYxTE9IZG9IREtwVVlsUkQrbEpFTnQxQ2x6WEdo?=
 =?utf-8?B?YzVLS2RPQW85bjZHZ3VjVjV1M1Buai81MndPdkpReG56NGp6eUZQSkhKTnBw?=
 =?utf-8?B?S1lTRE40RlY4TFhMRnYxOHhhKzVMdmovaEFuQ013UXU0NE1jNjJwR1dUV3FS?=
 =?utf-8?B?WUZaUzZpYjl4by8reU11YU5JcCtTU21UdXR6Tk5PL1ZqdHpqazdRbXRvRUxu?=
 =?utf-8?B?ZS9mRjE0a3hDSC9yTktOYm50dkF1WjJCTGZaSkRFcXUyTzNObTBEMHh6WTZ3?=
 =?utf-8?B?cjVFOVI1UnVzWkdxcVBxanV3MGxRMHI4d0YzMFFLMVo0bjQyN1dva3VkTWh5?=
 =?utf-8?B?WXl4eFEyL2Vtd0FhUit5TjJsN29IQTNoM0hxbE5Ga0Z3NFJ6Zmd3OGxURzdR?=
 =?utf-8?B?M2QycFFnYnR4dWtwV29ITUVmZm1rbXp1blhtclZyOWVXOTNxK3ViYkUxMWdt?=
 =?utf-8?B?cko5WFdVODN1MDRoYWVQTWhQc2FCcEo2TVd6SzRCZ2tHMnZ5SFljUjUwRkZG?=
 =?utf-8?B?cC9pek95SXZFZUxXSHlsVE41VFg5OFpUSE1qYk51TTRDdE52YXF3Z2NaNjI4?=
 =?utf-8?B?TE9zQVNVek5ZTHdPWmhweVZoSzlKSkhNNHIycmg5eTZBbFJhWDNkT0FZd0gx?=
 =?utf-8?B?OVJGcVdMNWx5ZnloYTN3YWYyT2JyMUN0bnRQYUh4dDZoQVVlZkl1cnU2d1JQ?=
 =?utf-8?B?K0hwZkpQQ0NwaHFMK3c3SkpTYlNvUllWUkdDZXJCVVQ3UWlhQ3BjYWE0MEZm?=
 =?utf-8?B?T2dtWDhSQnNRcEVKTTZpQmVQWGVvZmtWWVlnME5udW5DTlhpaGgyK1crZC9Z?=
 =?utf-8?B?aWdUVkM5dit2aXlETmJDOFJDbnhQZ2E5Ums0TE41TnJtZ00wM3FRZk5ZMlQy?=
 =?utf-8?B?bW5KQ1NhY2lQK1JhMVhZaFcxd1RQOTM3dFkvbkVMRERiZ3cyUHczdUN6d0xz?=
 =?utf-8?B?QURPNGdsWUxtRmFqSGNxSU56NHUxeFJST1l3cVZNTWptWldqVUswUlpqRXBT?=
 =?utf-8?B?WVFMcDViRnQrR1lLRWN5QjJrK1laR1owY2VlcDVyYTlKdjBDMGZrWHdEK21z?=
 =?utf-8?B?VHJ0a0VJUU9rMi9XcEV6NTBNRlpmS3dDMEdEWnNsSExCRGNQU255ZmU4MSsx?=
 =?utf-8?B?UENYcVJvc1ppZ0pzZi9rYmVwaE9TcWZzWEM1SWx2ZU0wZUl0cUZ2OGlNRU0x?=
 =?utf-8?B?aHF6eEtTUjhhT3lmZXo4cE11aHVna2VHOXovS2EveWpOOEg4eHVFRW5UYjJy?=
 =?utf-8?B?WnNDWit1L1dDSjVTaHlpaVcyb0NZRmFYbklhMzhpUWQxaW5hcjJvVFI5c2Jx?=
 =?utf-8?B?QTR2SnRJMVVTWW5Qb2dzWWQvd3hJZ0padWtzeCtLeWRxWkpzK00wbCt4R2o0?=
 =?utf-8?B?eXpTNmVJRE4xeno4UjNOL3VJWm9yR1czVFNRNFFyT0tkWDJGekNrY0t4Skw3?=
 =?utf-8?B?aEd0MEpKaEpMKythaERJei9wSDZBVnlSN1FaYkdpaVZDbXRSNC9TZFpFRDd2?=
 =?utf-8?B?TFBoMVZTS2tRaHovUnpGYndlMktpdnNuVS9ZZW1HMVp3QTVhcWZnTVZWOWV1?=
 =?utf-8?B?YWFsSGdMTThoYlM1MXl5VG9tM08rbjNtNHczL0xBNlVpNjZ0R3E5aU9yU2lq?=
 =?utf-8?B?VC9ZR0xncDZyTm1sVUM4VnJZWEZRcWtOUy9PWWdTT3Z2WWVhSktXVDJMNW1P?=
 =?utf-8?B?MlNCZCtDaHA2Z2RzWXVVeUNJNHpLRGpOZHdhN0xEZ2lDSDNIb3YvN0NBTFQ2?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4665eafc-c98b-44f1-e594-08dbe1f05fb1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 13:24:31.8017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkpFJ4w2VDT6enHkByBJU6syOBpGe4dvtshECM1VkSAsLzWa+dfql/46hYYsrG4sCQFjUWPpyL+oj/WIf3GeJ5Ufys+GkTsLt92FwAJh984=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9566
Received-SPF: pass client-ip=2a01:111:f400:fe1a::714;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 10/31/23 18:33, Hanna Czenczek wrote:
> (Sorry, opened another reply window, forgot I already had one open...)
> 
> On 20.10.23 23:56, Andrey Drobyshev wrote:
>> This commit makes the discard operation work on the subcluster level
>> rather than cluster level.  It introduces discard_l2_subclusters()
>> function and makes use of it in qcow2 discard implementation, much like
>> it's done with zero_in_l2_slice() / zero_l2_subclusters().  It also
>> changes the qcow2 driver pdiscard_alignment to subcluster_size.  That
>> way subcluster-aligned discards lead to actual fallocate(PUNCH_HOLE)
>> operation and free host disk space.
>>
>> This feature will let us gain additional disk space on guest
>> TRIM/discard requests, especially when using large enough clusters
>> (1M, 2M) with subclusters enabled.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   block/qcow2-cluster.c | 100 ++++++++++++++++++++++++++++++++++++++++--
>>   block/qcow2.c         |   8 ++--
>>   2 files changed, 101 insertions(+), 7 deletions(-)
>>
>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>> index 7c6fa5524c..cf40f2dc12 100644
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
>> @@ -2042,6 +2042,74 @@ discard_in_l2_slice(BlockDriverState *bs,
>> uint64_t offset, uint64_t nb_clusters,
>>       return nb_clusters;
>>   }
>>   +static int coroutine_fn GRAPH_RDLOCK
>> +discard_l2_subclusters(BlockDriverState *bs, uint64_t offset,
>> +                       uint64_t nb_subclusters,
>> +                       enum qcow2_discard_type type,
>> +                       bool full_discard,
>> +                       SubClusterRangeInfo *pscri)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    uint64_t new_l2_bitmap, l2_bitmap_mask;
>> +    int ret, sc = offset_to_sc_index(s, offset);
>> +    SubClusterRangeInfo scri = { 0 };
>> +
>> +    if (!pscri) {
>> +        ret = get_sc_range_info(bs, offset, nb_subclusters, &scri);
>> +        if (ret < 0) {
>> +            goto out;
>> +        }
>> +    } else {
>> +        scri = *pscri;
> 
> Allowing to takes this from the caller sounds dangerous, considering we
> need to track who takes care of freeing scri.l2_slice.
> 
>> +    }
>> +
>> +    l2_bitmap_mask = QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc +
>> nb_subclusters);
>> +    new_l2_bitmap = scri.l2_bitmap;
>> +    new_l2_bitmap &= ~l2_bitmap_mask;
>> +
>> +    /*
>> +     * If there're no allocated subclusters left, we might as well
>> discard
>> +     * the entire cluster.  That way we'd also update the refcount
>> table.
>> +     */
>> +    if (!(new_l2_bitmap & QCOW_L2_BITMAP_ALL_ALLOC)) {
> 
> What if there are subclusters in the cluster that are marked as zero,
> outside of the discarded range?  It sounds wrong to apply a discard with
> either full_discard set or cleared to them.
> 

Hmmm, then I think before falling to this path we should either:

1. Make sure full_discard=false.  That is directly implied from what you
said in your other mail: discarding with full_discard=false is
equivalent to zeroizing;
2. Check that no subclusters within this cluster are explicitly marked
as zeroes.
3. Check that either 1) or 2) is true (if ((1) || (2))).

For now I like option 3) better.

>> +        return discard_in_l2_slice(bs,
>> +                                   QEMU_ALIGN_DOWN(offset,
>> s->cluster_size),
>> +                                   1, type, full_discard);
>> +    }
>> +
>> +    /*
>> +     * Full discard means we fall through to the backing file, thus
>> we only
>> +     * need to mark the subclusters as deallocated.
> 
> I think it also means we need to clear the zero bits.
>

Yes, that seems right.

> Hanna
> 
> [...]

