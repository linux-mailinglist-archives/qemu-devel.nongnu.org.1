Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D32CA7E7C70
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 14:17:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1RMA-0007hB-RJ; Fri, 10 Nov 2023 08:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r1RM5-0007gV-G1; Fri, 10 Nov 2023 08:15:25 -0500
Received: from mail-db3eur04on0704.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::704]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1r1RM3-0000Jx-2u; Fri, 10 Nov 2023 08:15:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fam+Ehq3obZ+xTUC7qNEpIlXloEEcybMElFIkocAjoFOcl3VvkCi7Nn2vMWpC9T8CIZJPL5KOuxdqUYpM6kRs7cCuxwIiO0onvY2DfOCh8s0kHwTvrPovgVYT/RXJlO1w8uVzvau9GKR5Lz/RnrZIvM016Rf9yGEVCYyRo+BZ9bgZdJY7x7eG7Mm1EzRQED9LCH9uHZleSBAtUKr7tAiG6bDNOSsNkMlc8WnlVsFEphq+zCtJyN0ACqpB8plqEmZPdYxPcYVeYCA9hPouMN59ojigFcaN7TXuP7oQeGiycOdiBB8AZONWjmQak3ojnABxePl81F0vKf+ge++TGoXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqE45SA1vfopYAG72e89I5J/AZerEBrWv2rYK98r4Ok=;
 b=Vc5eLIMxTY2eiUbEOhNfOzO51a1/J/2/FRX2TB37/J5ceAMFWXNm7uobICOF3nGOF2G7e3gl35DP9A4LQS+e6u+hK6TD0jr67SC5qq/pdz1lKaAc3jfAObJ8pw/KvlJ0OBVUW4k117DDF9/VpKVSTYJzKEvj82ezRsTRoW/AQeSCRLki+KnsrSxJhiJ7lsD3lBQVMgnAmTWIhfOATl824qSW1qF0mNvapNLVMN3aBj4ZKDFuCuI3Nl/Ie6IVPN74XXjOjFENienXWyNIYwbM9YPiQaR0QFwkGwP2hmIfRS+BE5zSkk2Af217a/IODoNe9tiFJ1JKZSUBYUZj+Uf0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqE45SA1vfopYAG72e89I5J/AZerEBrWv2rYK98r4Ok=;
 b=sVPvhZHdmMTgk9iopBJfZt5q/1rZ1cj6PXHguDYM3iKNHzQTJqEhK0VWJ6bgWiR87J00lrEBv0txLxCykXmHlbmghWnt4SgXNlm2KWWasUuYbtBCk/iGOmYBCSiQdQPhOGy42SMvke6XMVjAlbU1e/ZkpZBlHzRACSzB3GkLrSmr2xrPaiSs6+LerckauG1wUobQURyy1daMQLbdjPtkqeScSzlCC4bi+iBT+Q9s6lw7fNIZJ6wuE9aQtMRwLnd2o+/Vtlz2wkmTa8l/T5A6lOcy7ZM6RT5gRtnO1dcqCsH0m8EPsvNeUhnz/UH7+aj7YiknQxOtgvhSKQSPw05PIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV2PR08MB8343.eurprd08.prod.outlook.com
 (2603:10a6:150:bb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 13:15:16 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352%6]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 13:15:15 +0000
Message-ID: <4a8611b5-613e-49c3-9672-049d1ea34377@virtuozzo.com>
Date: Fri, 10 Nov 2023 15:17:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] qcow2: zero_l2_subclusters: fall through to discard
 operation when requested
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-6-andrey.drobyshev@virtuozzo.com>
 <2ed4cbd2-cb44-434e-9e02-5a16e086cfed@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <2ed4cbd2-cb44-434e-9e02-5a16e086cfed@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV2PR08MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: fc899c7a-c31a-4f97-eca6-08dbe1ef1437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4iIX8mx2qIFx49YhGyOvlNNiHavX+u01vimEiOr+C8odtui3LFhf5tHRrJ7UeO5OQNdV9cMT+lfLrwl0DcrIfdhcggcZ3AWsE+c23D5KTprbOSvS4jKiCjOxuHrIHPA1y8bgrjJCNTQio7kQ5akzRZ4ue6+8GyZyd7sPnwzBoRZEzuOSvLAwcVsSjngujekox2xGc3Jldz9wsLelVvepFUAT4aZL5I6YfSyjGELwpk5+zbeIso0l49VCam4fIkLGx/quoP4r9zVrnaQxFYB1l6LS+oPOkZXeXFpsO1uW/qsbo00SOqVcqBaYY0B+W5wxqGzh9XIW8ULONCZ09TCQHP2SvkwGhuXSJYy9HFkxBpQwPzvMbfsknrJvCovJKyu0yCEXsazuAIpVGc6fgT0xK7q7UNdXaT5fU6ypc1geJ+Eln6ysSA9WVpHOUMQl3UsA2vjK+Yty6aqc/5CIGnu1xvHWOb7ROpF8OK7+sxCzJGjf5nIaaz4wh59kG8zH3keW/rNRcAc/Uy9y/QR5ZclsIxmX2DCzRHI+LWF5Q5BAdTJMFwF1gFewvor0zRkDG4IBHjmaLQBAUHXHuJfZIry3GssKrSX5CsZ0d9s/LvQQiQnEQDkFRMd+B8g+zl0rnG6/P75TtL8q5jrP2cNqMEoUTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(396003)(376002)(136003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(6506007)(66946007)(6666004)(55236004)(41300700001)(107886003)(6486002)(316002)(2906002)(2616005)(8936002)(53546011)(6512007)(66556008)(4326008)(66476007)(8676002)(44832011)(5660300002)(86362001)(31696002)(83380400001)(26005)(36756003)(38100700002)(66899024)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGFiM3htWW1Ec3pqYmwrWlV4bmdOWkRnNE5EdnNMdWFDVklJUEZnOExZS3VS?=
 =?utf-8?B?eGVWSXlZby9JVG0wUHFvSTNqeHZaWkpvRUJuMnhpYUN5UFpzUXY2RXhFSFhB?=
 =?utf-8?B?OGZpQlBHb28xYlJ1UVcwTUlhQmRHZlhUOEVZWnA2d1cyRnZXS1hQSEN5blEy?=
 =?utf-8?B?R0kxQmluSVh4Yk0vMHVRMWg0TW9zdzAzVXVwSmlXdXVvVmVzQ3crZnF4RjZD?=
 =?utf-8?B?R0czR2VTaUhmdGxLUlJ6MHRDQlJlMFprR3BpbWRDUUtGdm9kVXU1YXdmaVBX?=
 =?utf-8?B?UWFZRThmWHJsc25LV1Q4UlFWWFc4Ylg2SGVqM1d0T1QyVTdWV0hjQzhqTStC?=
 =?utf-8?B?OGpVd0Ezc2lGTlZwYXRZQ2RmanhYUFVtYVI2by9RVjR5cFVTOUh5TnlRNmhW?=
 =?utf-8?B?cTh2dXMyZDg2RTFBQklWOU5DUXFiVXlEZjJvUXRSWkRsMXZSNjVWK2M2bVZZ?=
 =?utf-8?B?NFhZLzZmMG03TitHTllOV3R5amdqbmJwUnp4MytxNVdqamFuVHF0QUlzcnFz?=
 =?utf-8?B?dE5pbXNoRGV5NmJXcjdRRk1PbEtCTmpNQTRVRWsrbnBUdjdJUjdNSEVML3Y2?=
 =?utf-8?B?SUJjZDg5dlh4a3ZvTzN2Q1N4ckI2K1ZSVFFCT1o0dDhJQVlsMmZrSmZKQlJ3?=
 =?utf-8?B?VTR6NkhPU2pVc3dYaFZ0Vzgybk9KMDV3Ni84QTFPd0hzZEdmaitqeEhPdzFj?=
 =?utf-8?B?Z3YwTzNuK1lLZ2lKbzFUbDFtME40OXlGNURONURXTWMzUGNhbjBaeEJHRGxF?=
 =?utf-8?B?UEswQTZuR3pSdFJTV1pCR29vV05RM2xrRnlGZFM1dithMTJpUGdkNDZXTEp4?=
 =?utf-8?B?ZDd2ZXFvZXJoUlFiMCtYcjd3aW55cC95ZlovWjdBcEpXSDhTeFQrWE51b0wy?=
 =?utf-8?B?dVhMQXdlS2FyVS81ZitoMkhaTE1Bc1hVYzlwWVdTNFVEVmsxcHRWT2g3RXl1?=
 =?utf-8?B?dHdxSk81MWJla3dXVUswNWt6anp2RFVob3l3ZDlHTnNBRFV6enoycnN2S3I3?=
 =?utf-8?B?eGlxSUNvSnZ4MVp1TnF3N0xmeE0weDE1ZmJLdHVaTjJZZlB6OVZjd3I0bXhU?=
 =?utf-8?B?bEMxajg4ZGErVm5iRU9DWlNFVHlXSTQydUNpeVZJTzMxMnRiVTVFVG1EODFl?=
 =?utf-8?B?RjlzQU9jTSs0UUZiTnpLY3J1Tnh2RlNQNVFTTGg2YnhYQlBqUDgxSkpnblJR?=
 =?utf-8?B?enBybFZ5Z2x1M29ka0N3VTlPa1ErRG5QRHpNaUJiK1BlUmJrU2hmRzVtNi9M?=
 =?utf-8?B?eTM0UnBwbHQxbzBVdUN2OEVtT2ZzMm9DeXlRbkM1ZWQ2cVVpR01kRURRMDB4?=
 =?utf-8?B?UUp6UzcranhZbjk3MmpvVk01REQzU2MvTG5leWdydm8vSzZQVGxlN0dQazEw?=
 =?utf-8?B?TVhVY05BNjJOUysrSFFORjUzV3hDUmtSL2pJNHNqblhsTG9YdzhoWmJtUmJ5?=
 =?utf-8?B?Zml6bUF3RU1ONTA5dzZ6NTMxQlNGSVltdEV2d3k1ZlFyNlZFUGhmRDliYk9x?=
 =?utf-8?B?cEZaTmREYjhYTWtXZHRwZnM4VzFWRjZ2RHNTU3lRZytNcmkrYXhiaTNoZ1ds?=
 =?utf-8?B?cXBVcStkL3N2T1ovZHNKTENkMU1Ub3Vlc1NSY1BWTDVLWXpoSDBsS0xwTWtI?=
 =?utf-8?B?TWMxbjBmS1B4cnFqUUxtR1hGdVpHZ1FZY2xVejcvVGF4alJ4cGlDTTdFYUlt?=
 =?utf-8?B?Q2NhUVc2RWNqNnNlTTNkM0kyalRNY1ppMFdQdCtZdmFabXRObUMzVkRxSGlQ?=
 =?utf-8?B?dlFjdzd6RlRCdU95bXRDdEd2TERVQ1pDNDBpazF6YTI3T1JmVlVIT0dQd0xl?=
 =?utf-8?B?UGpURWdhVEp0dVVXNStzbDRUMmREVlN6dGZ1SU9JcjZyVmZrSS9OaURrWlpP?=
 =?utf-8?B?QjBsM1NpMnZ6RkhXditHb3gzSFdMRkxoa0ZVM3NuRkR1VXViOEFaRnU2cThp?=
 =?utf-8?B?Vk1ZNzcwYVd5Y2ZiRnF1TzhWUVVIQXpYQTdUU1B3cHRnc0VHcXErRjhTT0NU?=
 =?utf-8?B?OTBnWVo4Q2hHZVJLRHluamQ1YTkzTHRUSXhuWnI1enhGcUxnUzJXMkk4Ynd4?=
 =?utf-8?B?YjFaMXpkTUpSL1l0OVFndGJHVlhLalpuaEpwZWJPOVhCM1hybVVBc0tQVEww?=
 =?utf-8?B?SUZYR1cxVXhiUTRvNjB5akpYQlBUWUNUcmZtaFhrS002YXNkTkkzcDBlMnZj?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc899c7a-c31a-4f97-eca6-08dbe1ef1437
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 13:15:15.7426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRz+kPRsJBTiGJbAPnA8hKhfElTJoOFrUGbllpuRZiBgOqST8RWAOwIdADSBUjeMvpMWZovDt6HH5UF7VPwhO62GTMRYv8OCDHFbbocHtgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8343
Received-SPF: pass client-ip=2a01:111:f400:fe0c::704;
 envelope-from=andrey.drobyshev@virtuozzo.com;
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

On 11/3/23 17:19, Hanna Czenczek wrote:
> On 20.10.23 23:56, Andrey Drobyshev wrote:
>> When zeroizing subclusters within single cluster, detect usage of the
>> BDRV_REQ_MAY_UNMAP flag and fall through to the subcluster-based discard
>> operation, much like it's done with the cluster-based discards.  That
>> way subcluster-aligned operations "qemu-io -c 'write -z -u ...'" will
>> lead to actual unmap.
> 
> Ever since the introduction of discard-no-unref, I wonder whether that
> is actually an advantage or not.  I can’t think of a reason why it’d be
> advantageous to drop the allocation.

You mean omitting the UNallocation on the discard path?

> 
> On the other hand, zero_in_l2_slice() does it indeed, so consistency is
> a reasonable argument.
> 
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   block/qcow2-cluster.c | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>> index cf40f2dc12..040251f2c3 100644
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
>> @@ -2242,7 +2242,7 @@ zero_l2_subclusters(BlockDriverState *bs,
>> uint64_t offset,
>>                       unsigned nb_subclusters, int flags)
>>   {
>>       BDRVQcow2State *s = bs->opaque;
>> -    uint64_t new_l2_bitmap;
>> +    uint64_t new_l2_bitmap, l2_bitmap_mask;
>>       int ret, sc = offset_to_sc_index(s, offset);
>>       SubClusterRangeInfo scri = { 0 };
>>   @@ -2251,9 +2251,10 @@ zero_l2_subclusters(BlockDriverState *bs,
>> uint64_t offset,
>>           goto out;
>>       }
>>   +    l2_bitmap_mask = QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc +
>> nb_subclusters);
> 
> “l2_bitmap_mask” already wasn’t a great name in patch 4 because it
> doesn’t say what mask it is, but in patch 4, there was at least only one
> relevant mask.  Here, we have two (ALLOC_RANGE and ZERO_RANGE), so the
> name should reflect what kind of mask it is.
> 

Noted.

>>       new_l2_bitmap = scri.l2_bitmap;
>> -    new_l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc +
>> nb_subclusters);
>> -    new_l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc +
>> nb_subclusters);
>> +    new_l2_bitmap |= QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
>> +    new_l2_bitmap &= ~l2_bitmap_mask;
>>         /*
>>        * If there're no non-zero subclusters left, we might as well
>> zeroize
>> @@ -2266,6 +2267,16 @@ zero_l2_subclusters(BlockDriverState *bs,
>> uint64_t offset,
>>                                   1, flags);
>>       }
>>   +    /*
>> +     * If the request allows discarding subclusters and they're actually
>> +     * allocated, we go down the discard path since after the discard
>> +     * operation the subclusters are going to be read as zeroes anyway.
>> +     */
>> +    if ((flags & BDRV_REQ_MAY_UNMAP) && (scri.l2_bitmap &
>> l2_bitmap_mask)) {
>> +        return discard_l2_subclusters(bs, offset, nb_subclusters,
>> +                                      QCOW2_DISCARD_REQUEST, false,
>> &scri);
>> +    }
> 
> I wonder why it matters whether any subclusters are allocated, i.e. why
> can’t we just immediately use discard_l2_subclusters() whenever
> BDRV_REQ_MAY_UNMAP is set, without even fetching SCRI (that would also
> save us passing SCRI here, which I’ve already said on patch 4, I don’t
> find great).
> 

Yes, this way we'd indeed be able to get rid of passing an additional
argument.

> Doesn’t discard_l2_subclusters() guarantee the clusters read as zero
> when full_discard=false?  There is this case where it won’t mark the
> subclusters as zero if there is no backing file, and none of the
> subclusters is allocated.  But still, (A) those subclusters will read as
> zero, and (B) if there is a problem there, why don’t we just always mark
> those subclusters as zero?  This optimization only has effect when the
> guest discards/zeroes subclusters (not whole clusters) that were already
> discarded, so sounds miniscule.
> 
> Hanna
> 

Good question.  I also can't think of any issues when
zeroizing/discarding already unallocated clusters.

Essentially you're saying that zeroizing subclusters is equivalent to
discard_l2_subclusters(full_discard=false).  Then in
discard_l2_subclusters() implementation we may mark the subclusters as
zeroes regardless of their allocation status in case of
full_discard=false.  But when dealing with the whole clusters this logic
isn't quite applicable cause if the l2 entry isn't allocated at all
there's no point marking it as zero.  Correct?

> [...]

