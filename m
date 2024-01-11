Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6592082B10B
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:54:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNwQv-0004kD-0I; Thu, 11 Jan 2024 09:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ari@tuxera.com>)
 id 1rNwQn-0004b1-HA; Thu, 11 Jan 2024 09:53:18 -0500
Received: from mail-db8eur05on20705.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::705]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ari@tuxera.com>)
 id 1rNwQk-0001UT-Rq; Thu, 11 Jan 2024 09:53:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs34G0Y/GEvI2zdbhr/h8ysvr868ve8eIgIzhmdTDKNFG89Z3vfnWIZCktsKONup7AOX7MT+6PWKseJInI3o3bvu/9vK3oDrc6D9iKfo+RXz7TjBcKD72IdcjOfScJRiXlHWf5hUe7VE2UCPOOknQElGoSQ9N7/jxZFT2k2dcT8hTifZyu8Rb7rqA9+iitPMBhnhHQwOCbLYOV9ktSyhSjBHOGD2kt4KJsXK8vvrcTZ8SdUdtfu3cY5bAsijZrkyqNg9DC6Owd8YQo77NA2XC5WQ9D6PzqH0MQWNDQ38jTb1ZqxWEfZ7n2t+idnUojrOEOsN0L0NwS54v1ZZmWc28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2XOcD1lIXc82AwOklzTDTs79uz1NS8cWDXYSdQ/1gA=;
 b=CXtPFAh568m6EUjoc04huY29Ijvdb2k51kEj67H3+qRwOhhgVF7ku+IHPRWRzfQaGw9mY3Cioap95FkTHaWSzmek6Y46O0BKlwGkQxjQPI3X34eiqJn7pbHH7udpLTMwYOtecbinr9O9jdF3mx9k3JN6r1fpYP3/VSUsbbqdF27No/ov831Bas2sJQQfe3pSeIPjT5z9/hYQFPxhEDJKY6e3k5eNYyuFjqIGY+OjFSX8+ihqPICP5zCy74fyae8jY3NJubDzqXIZo+zSj2hpxbLQUnfnvqhkkNKxA6lI9OdOXVESjeuGrfz8wCaAhYjCWtLeetlk887Jn0dfNssYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2XOcD1lIXc82AwOklzTDTs79uz1NS8cWDXYSdQ/1gA=;
 b=QG7ptnBfckKrM/8R/4vwLIdVyvGv63krIAXNR/rrLiKKFB18dXKPYjLjRm//1HHgyx4PBJoErdBaTq9ztx7r+NqUEdAhpfkrtdmw+6P6SCAS0T0w8PGcoBtvhOr6m1gwtSWnfe5qnwme1lFoLyKA261yNfSwu70opxBbIh94NqnOz1zDA5GsTdQtD3neLxECXMzVxbA16Th3+4Qn96zuclKUPx5JyvnUKbNge+UiQeM+yeUN4m521lV1FwXcJqYTmqqIjZwY0RP+g77th4OlLft9G8H7qeiAnGLdgYXsGQ/i1jkufqyTv3O0NjvfC4FFoz/P1SwNK7WhIucG42vsKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
Received: from DB9PR06MB7818.eurprd06.prod.outlook.com (2603:10a6:10:252::7)
 by PA4PR06MB8521.eurprd06.prod.outlook.com (2603:10a6:102:2a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 14:53:08 +0000
Received: from DB9PR06MB7818.eurprd06.prod.outlook.com
 ([fe80::9e26:58bf:b2c5:4bb5]) by DB9PR06MB7818.eurprd06.prod.outlook.com
 ([fe80::9e26:58bf:b2c5:4bb5%6]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 14:53:08 +0000
Message-ID: <38d7b3ee-430a-2d75-c329-918563687709@tuxera.com>
Date: Thu, 11 Jan 2024 16:53:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] block/blklogwrites: Protect mutable driver state with a
 mutex.
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <f1960d8d-352e-4e1b-4d28-7a110e272356@tuxera.com>
 <20240110195005.1263619-1-ari@tuxera.com> <ZZ_17BiyiQcS2kV5@redhat.com>
From: Ari Sundholm <ari@tuxera.com>
In-Reply-To: <ZZ_17BiyiQcS2kV5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::12) To DB9PR06MB7818.eurprd06.prod.outlook.com
 (2603:10a6:10:252::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR06MB7818:EE_|PA4PR06MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 538de3e9-9542-406a-ce12-08dc12b50631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dt3rATsDM855s8dsQKArLvWqSFh9L+YM2WH9UTG7dcvl5Sw05gqCP/Q/CHFvdKnSuCZLTa6vQ8mmmbpHOJ6xjYQ/yAG3VmOi/xraLGLOxt4gU+zL2Elj4rKC3lsceqGP1YuGAb8ANOLXXgOq8Mjj5+LN2cWclBzxy+AdUXBdqJ8MBw70H7died3lQhs7HuX9yjSYOQ7wbvDPmX/Ao+5dPpVfFlR6iFSienDjpEcErqo2gJ4u1RclLHaK0QcQOA67ABxMgwr0itwNuoq6+gAnWt5xL62+AL3EwRfeqTiaM3bMO5hiCeRds8gYMpNXlsF5yAdwGlZakBvUsW1ZRsX9QsQ1gqTp1XWc9JbZWKzls+thTVKGRdsoLtPQXOVS5iKeSrE3YHOtFfHlNApOMt9LJAbBXq7ibrJq2otvxYpW5ef6gZoXZpLhngiR4QrUS9oixXqJ8Q86/kxgZkLNamSZxaKaIGbj5Gfu5xoqMOMk00OPHDLVMxfwwliyL8V+e1mURD+0pEMi58WeF5a6TTqImBoN1RQ4rngSWwsnV6/PPjl/UD9W4VraI7cNtxliE7EvJDV6BtP6UUHwaNH0Cw9xBNkXKKehDJPEslxryO/O7+VjSTwFcYp5PP7JZWDdvqO7v8PThES5YTCqHFgnfGprDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB7818.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39840400004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6666004)(53546011)(6512007)(26005)(6506007)(6486002)(478600001)(83380400001)(2616005)(5660300002)(2906002)(41300700001)(66946007)(66556008)(66476007)(316002)(6916009)(8936002)(4326008)(8676002)(38100700002)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGZDR2RCWVk5ZnNLNyt5OXZQWVpjckNHaHBpeVZvZkNQY1FveUY4aGxKQzZR?=
 =?utf-8?B?amVZMTZGclRzeDhYTTAvZGdvTkVndE5hU1Y5SmtRL3k2Z3dVNC9OME9zbEZv?=
 =?utf-8?B?UXpSS1NzenpzclBYcTF3WFluN2c0M0FRMk1GdmIrTHZIV2Zrdm0xNncyU1R4?=
 =?utf-8?B?dCtZK3o0bkNJNzB5YWo1S1UxMTZBd3dBaGh1L1N5aXFsYTRMTWc3bkVFQlN2?=
 =?utf-8?B?ZnN3bER4cjJ0U29GT0t5cGNGczRuaW1vdlk1M1ZlYUYzWDBRTmNGRXo0TXJZ?=
 =?utf-8?B?MFN4LzJ5bW9GNXZlMVRMQXRURERKL0d6ZTZwY09meE0zUmMrbHU4U1YxY2Qy?=
 =?utf-8?B?Tk9keWtzNVZsNWFERWlOVVZYQ2Q3K3ZwTkxsOWx2OXhXUVNyZmlVQXRnaTBh?=
 =?utf-8?B?Y2RlbE10a1VqVVFRdTF2aVdpVVQ3a0JSMmczMEozTjQrZmt2UzhOb1U3N25H?=
 =?utf-8?B?SDZtQUhJYU1DMkpzOExFRS9WUTQwRnpzM2JZMC8ySUtqNG04a3UrUFMrQzl1?=
 =?utf-8?B?ZDlsOC9MSXpCWVlGYVB6TnZEOFQvT2FZcUtDMFRLYzh2V1V3amJ2MEVQSmZs?=
 =?utf-8?B?ZUh6Vk50VTJUcm1KTHpPcFpNeVdOeGh3NEM4RTNZeER2Rm9EVURHQlNQa0NS?=
 =?utf-8?B?RUhsNC93L3dkQkhZb1NlT2ViV0VlK29Ddjd6bUsvOFJqN1ZyR1FTb3NNWmZI?=
 =?utf-8?B?Y2d6NXByY3MvcmhpUDVobHg4MXdocEZXTG1FY2ZwMEZSaGw0Mm5GMHc5NzR0?=
 =?utf-8?B?ZUhkelNLTG93aENCM2hSM0hzRmpKMWEvd0VFb0Z5M2JwWlFFaHdON1IxVytv?=
 =?utf-8?B?TUR1VGVuZU9OdHhNS1JiY0NpY3BpeHc1cmZBUU5vWTdSNXEwZS9UaXF4eGp5?=
 =?utf-8?B?Q2UvR0tGUDVhOHVSUUh1Znk2bFZlQXJKOTVDL2w2T01oM3dDajY4UjdacHh2?=
 =?utf-8?B?QmJUY2habThQRGhUS2RXZ2pBYUJJSDZpWGNKUldSMUl4emxqSnI2NkJkZFF5?=
 =?utf-8?B?Nk44a0tsRlJmaEFpKzAvZkJCNm1qRDZ5UTQ0ZFRxWHIxbmZ4NE9kbG8vdFdC?=
 =?utf-8?B?QlZXRHlzQWlUbWRZUm1uOXVxTStheUVKM0JIcnd3OUZ3ZjFTR3dtV25EbDBj?=
 =?utf-8?B?YVhQc0FFSGJ0cWtQa01FQW1Ec1poSW9OTGZ5OU4xUnhld2hNUHZ6am5OYmls?=
 =?utf-8?B?a2J6WnlxOSszZlhsMjNGWEpuQzI5RGlpV2oyejJoS0tzR3k2SXp4Z0hEdUxK?=
 =?utf-8?B?bTF2TUJaNXFHNlQ2TWZtNFVqdk13a091eHg3WU1Ic3piWVpsK0wvcVJnZDhr?=
 =?utf-8?B?VDNhUXdFbnBLSG04Z0UzWkFnUGZqK1dzUTdzN3hRbzVveGIwWkNNS1B5ZW53?=
 =?utf-8?B?U01VWmxnZURwVHlvSmx0dmU1NkFWcXlQbVgwbytKaVhna1RnRzBmLzZvVW54?=
 =?utf-8?B?Ni96N09NRGpYODhCZlhjdE9VSHYvTDl1UEFpS0FlbnFob3kvTVpPUkVDL2k3?=
 =?utf-8?B?OHBja0w0TW1pcm5CK2sxZmhOQWx3MWRhbFltem54YkJBSXlsbGtKeVYzTHlS?=
 =?utf-8?B?YytWSXRoUW5qR0Rqek1rRXBEZWlCWm5ST1hnU1FiSXF1ZFcxYVJsQ1NVL0RH?=
 =?utf-8?B?SHJTT1RNNDExektKMXlVb1dDVkpEWWNKMkJoWGkzWlQrK1hHeTVGNGIvaTRi?=
 =?utf-8?B?dTlDRThpQVRZeHo1VW1VS2dDRU1GcXN5NWtTdEtHOGJxZk5PYlBLZlFpekdQ?=
 =?utf-8?B?bnZTeEZNdUhTd0Z0K3U5c29lc00wU3JsZ2drQzJEM2ZJaDZnM3FpTjRnajZz?=
 =?utf-8?B?ak5PZnEzUEVPMXNIUXR6Q0owbkZOQnI3MU1iNEZicTJkd0lxL0VmbGVXUEdk?=
 =?utf-8?B?YjF1TTUxTUJUei9ob3VrZjFhdkpMUTcrMno5QjdlQzdRUTk1bFZTTmRVRHVP?=
 =?utf-8?B?Tmc0M0ZjaDJiRmZodjZ1MGRVa0dlWXpOOVpDZldXRnlwRkoxYi9ub1RhTTdT?=
 =?utf-8?B?anVreS84YTI2bEhjOG9ycWI4SUhDV0tCNXZ5S1ZhS1lmTS8zRzB2Mnc4Yy9O?=
 =?utf-8?B?dlU5RUgxa1JvT1ZKd24zbkFmbTdMN0dDdmJFV1JhUTI5OGJWUC84KzJoUkVM?=
 =?utf-8?Q?H1pk=3D?=
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538de3e9-9542-406a-ce12-08dc12b50631
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB7818.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 14:53:08.4052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dIk41tl3MHCi9YC91RzdGCIUeVk7BBqQGfwWHyGfm6fyqbDsHIY4bGnIIDEKRSL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB8521
Received-SPF: pass client-ip=2a01:111:f400:7e1a::705;
 envelope-from=ari@tuxera.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.982,
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

On 1/11/24 16:06, Kevin Wolf wrote:
> Am 10.01.2024 um 20:50 hat Ari Sundholm geschrieben:
>> During the review of a fix for a concurrency issue in blklogwrites,
>> it was found that the driver needs an additional fix when enabling
>> multiqueue, which is a new feature introduced in QEMU 9.0, as the
>> driver state may be read and written by multiple threads at the same
>> time, which was not the case when the driver was originally written.
>>
>> Fix the multi-threaded scenario by introducing a mutex to protect the
>> mutable fields in the driver state, and always having the mutex locked
>> by the current thread when accessing them.
>>
>> Additionally, add the const qualifier to a few BDRVBlkLogWritesState
>> pointer targets in contexts where the driver state is not written to.
>>
>> Signed-off-by: Ari Sundholm <ari@tuxera.com>
>> ---
>>   block/blklogwrites.c | 29 +++++++++++++++++++++++------
>>   1 file changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/blklogwrites.c b/block/blklogwrites.c
>> index ba717dab4d..50f68df2a6 100644
>> --- a/block/blklogwrites.c
>> +++ b/block/blklogwrites.c
>> @@ -3,7 +3,7 @@
>>    *
>>    * Copyright (c) 2017 Tuomas Tynkkynen <tuomas@tuxera.com>
>>    * Copyright (c) 2018 Aapo Vienamo <aapo@tuxera.com>
>> - * Copyright (c) 2018 Ari Sundholm <ari@tuxera.com>
>> + * Copyright (c) 2018-2024 Ari Sundholm <ari@tuxera.com>
>>    *
>>    * This work is licensed under the terms of the GNU GPL, version 2 or later.
>>    * See the COPYING file in the top-level directory.
>> @@ -55,9 +55,18 @@ typedef struct {
>>       BdrvChild *log_file;
>>       uint32_t sectorsize;
>>       uint32_t sectorbits;
>> +    uint64_t update_interval;
>> +
>> +    /*
>> +     * The mutable state of the driver, consisting of the current log sector
>> +     * and the number of log entries.
>> +     *
>> +     * May be read and/or written from multiple threads, and the mutex must be
>> +     * held when accessing these fields.
>> +     */
>>       uint64_t cur_log_sector;
>>       uint64_t nr_entries;
>> -    uint64_t update_interval;
>> +    QemuMutex mutex;
>>   } BDRVBlkLogWritesState;
>>   
>>   static QemuOptsList runtime_opts = {
>> @@ -149,6 +158,7 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
>>       uint64_t log_sector_size;
>>       bool log_append;
>>   
>> +    qemu_mutex_init(&s->mutex);
>>       opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
>>       if (!qemu_opts_absorb_qdict(opts, options, errp)) {
>>           ret = -EINVAL;
>> @@ -255,6 +265,7 @@ fail_log:
>>           bdrv_unref_child(bs, s->log_file);
>>           bdrv_graph_wrunlock();
>>           s->log_file = NULL;
>> +        qemu_mutex_destroy(&s->mutex);
>>       }
>>   fail:
>>       qemu_opts_del(opts);
>> @@ -269,6 +280,7 @@ static void blk_log_writes_close(BlockDriverState *bs)
>>       bdrv_unref_child(bs, s->log_file);
>>       s->log_file = NULL;
>>       bdrv_graph_wrunlock();
>> +    qemu_mutex_destroy(&s->mutex);
>>   }
>>   
>>   static int64_t coroutine_fn GRAPH_RDLOCK
>> @@ -295,7 +307,7 @@ static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
>>   
>>   static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error **errp)
>>   {
>> -    BDRVBlkLogWritesState *s = bs->opaque;
>> +    const BDRVBlkLogWritesState *s = bs->opaque;
>>       bs->bl.request_alignment = s->sectorsize;
>>   }
>>   
>> @@ -338,15 +350,18 @@ blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
>>        * driver may be modified by other driver operations while waiting for the
>>        * I/O to complete.
>>        */
>> +    qemu_mutex_lock(&s->mutex);
>>       const uint64_t entry_start_sector = s->cur_log_sector;
>>       const uint64_t entry_offset = entry_start_sector << s->sectorbits;
>>       const uint64_t qiov_aligned_size = ROUND_UP(lr->qiov->size, s->sectorsize);
>>       const uint64_t entry_aligned_size = qiov_aligned_size +
>>           ROUND_UP(lr->zero_size, s->sectorsize);
>>       const uint64_t entry_nr_sectors = entry_aligned_size >> s->sectorbits;
>> +    const uint64_t entry_seq = s->nr_entries + 1;
>>   
>> -    s->nr_entries++;
>> +    s->nr_entries = entry_seq;
>>       s->cur_log_sector += entry_nr_sectors;
>> +    qemu_mutex_unlock(&s->mutex);
>>   
>>       /*
>>        * Write the log entry. Note that if this is a "write zeroes" operation,
>> @@ -366,14 +381,16 @@ blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
>>   
>>       /* Update super block on flush or every update interval */
>>       if (lr->log_ret == 0 && ((lr->entry.flags & LOG_FLUSH_FLAG)
>> -        || (s->nr_entries % s->update_interval == 0)))
>> +        || (entry_seq % s->update_interval == 0)))
>>       {
>> +        qemu_mutex_lock(&s->mutex);
>>           struct log_write_super super = {
>>               .magic      = cpu_to_le64(WRITE_LOG_MAGIC),
>>               .version    = cpu_to_le64(WRITE_LOG_VERSION),
>>               .nr_entries = cpu_to_le64(s->nr_entries),
>>               .sectorsize = cpu_to_le32(s->sectorsize),
>>           };
>> +        qemu_mutex_unlock(&s->mutex);
> 
> This hunk looks odd. Is the only thing the lock does here that
> s->nr_entries is accessed atomically?
> 

Yes. We want to make sure that the latest value is being used.

> Looking a bit closer, if s->nr_entries has been changed (increased)
> meanwhile by another request, I assume that we indeed want the newer
> value to be stored in the superblock rather than using the value that
> was current when we did the calculations. So superficially, this part
> looks good.
> 

Yes, that is the intention.

> But the other thing I notice is that a few lines down you can get
> concurrent write requests to the superblock, and there is no guaranteed
> order, so an older update could overwrite a newer one. Don't we need to
> serialise writes to the superblock? (I would actually expect this to be
> a problem already without multithreading.)
> 

That's a good point. Maybe I should add a flag indicating that the 
superblock is being updated. But that may be too simplistic, as an older 
superblock update should neither clobber a newer one nor prevent a newer 
one from being performed, and we do not want to  hold the mutex while 
doing I/O. I'll think this through and post a v2.

Thanks,
Ari

> Kevin
> 


