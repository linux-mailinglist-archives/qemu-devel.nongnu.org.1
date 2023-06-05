Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDBD722D1D
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 18:57:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6DVD-0007hb-Kp; Mon, 05 Jun 2023 12:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q6DV7-0007gv-GS; Mon, 05 Jun 2023 12:56:13 -0400
Received: from mail-vi1eur05on20721.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::721]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1q6DUy-0000m2-2x; Mon, 05 Jun 2023 12:56:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGGJF0l5A7nIULyJGGUEkqPiXCJDYylz0hv/5AopUn3TUCRDv4ZcrJ2BrMwqj7RcSeIMUDw0u/Haxfp147pt24ukXf/ebfFzMU3QUoSjZJO5IGUFWqEIy3wZV5aJWZznQvQwXSYgiW8rTn12oKxNAESlH8fEsIsSUdUQ0W6X5ASpTsMk80ZCn6WQpyK5azWGz04CqWPYXWmpCYy4QXxv9t89Q54cya0WREx4dapLbr3PcRgb5XtWfkGaYpdYjfRFKivKxeYfV6AyDffa+eXFQP701sp9LnWMR/yKyLxclvRydRqItQ30BOaRNkrf3YVELKq8sAgYus1u4XV2KMpQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f19sbOWPhqttlzCIGn7HdMV8+h4QbtqnzwWNXvXndeo=;
 b=NTQhTrR7ZibHX6ChfQrcwR8efDsvuZtNwmOuUvYL4LeoqxoSZwpktjYx0ZdcmbnM8OFAHZ8DZlMHeFXkruMm9f90rQxIg9rkCAudBP1gjsQUK9IbnTRaMcTJo7042bBn8Ks9hE65TbTSgmrNZGSyY6Q6zxW1CxC9vZWVikZZOKE7xzKycZiWvD8SqOxAslQej+bXN41oJL0NPzteT3tTJXZU3/ABzPMnrc9wJw74eoyCy6TTu4eYW1UPBwQNeBgDRdnd2efpuNwXW6ufSZn/ApdykLyxXIEc2ScHFZlN7LL0rE0h09l96JHBoxWrFb+9PZyjvbGSwynjwwN5E2QmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f19sbOWPhqttlzCIGn7HdMV8+h4QbtqnzwWNXvXndeo=;
 b=AY4/Rh3r66kKKAKlH9zMoVQYolgqUsbj10FgdTsDMRvPgAkEqqIFalbWKvYSdLXhN0EkXBkUKfbeFPxNJMfAWqHo++Phe7DrQOEhFldf2EUyWUWjdY8jCXPmeEaaiKwMg6SlH8Fs8BBTzXpadYSZRtt6CGThxQ5Ms9oU1S8Y37+PfjzAoGKrgr2vgglvjH/95JTl7jIAWocEqu2TLRVR9/om/lwM9x/KdtWJVAXf+knDTIU9fQ44XFHh5q8YSOHSWgLhaXZrrBj/XierRTGwecMXV9I74o3mYp3MnQemFq8pDl7+Ou5suMETytIks+WvfhW7A3NP1/kjMSpbQqdd2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DU2PR08MB10108.eurprd08.prod.outlook.com (2603:10a6:10:496::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Mon, 5 Jun
 2023 16:55:59 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::b630:c4eb:fba3:1158]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::b630:c4eb:fba3:1158%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 16:55:59 +0000
Message-ID: <7939fa1d-d219-4644-e7be-e49c4aef9936@virtuozzo.com>
Date: Mon, 5 Jun 2023 18:55:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/5] parallels: Add checking and repairing duplicate
 offsets in BAT
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com
References: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
 <20230529151503.34006-4-alexander.ivanov@virtuozzo.com>
 <5cbe5958-e47b-8151-9d5e-a9ae0d572d3d@redhat.com>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <5cbe5958-e47b-8151-9d5e-a9ae0d572d3d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0246.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::19) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DU2PR08MB10108:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe74790-d0a9-40c4-a2e7-08db65e5bc7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6rkoT7v/w+zSMTGcv9Mosb89q/1Biz+l6iF+DMLoiyxdQLvAKiS2fx3EwQ53Nf7vjxuwKWld6DY/Dj/ZimRqfui9Z3sLjw+ygCOO2SqSXDpcPRZoW9SfQuaQRVqjfRdyVZfAvvqMLvU2/xysrUDt5c3qjJ8a47ALu54eyzZdbrvqcvZQIcDkWEDW4YyWp8NjeLb+tmTtlmuy/rBwIkFLL8AcMstsozrLv26sCycFB42/T5lTiUFEZiLES6hh0+lMe/61PJm/1tVUQsfX1ZmJzhhVVLhw5rw4A2bp2PMT9yh8/lIDhjbZVyaGkdoECsYdDMqXEV3q2F+V4M1rIvoaJlSgti/9yoIpJvjkRPgid4XABKtSc/QapdO9Zw+d8hkZX1SHiIptxo7E/vHkPjBpXxhpxn6ZP/064kntBbZuLLwAp4KnMMdcmk8ZYEZJ1bb7Q6aTzAf05xImiiVfZneNIbnGSZCc/ApNbrYLpBsOvLzM93cXyL6xR75BFEbUWUMMB9uqcYW6TX8I2XEqb7R/1pxCXjWgl2I/0KvfpCGHyFUVB11kTk1rThtMNeVCgquyIk0ld4jtbJQ56Vlh/MzEKO02m5h/EYDdT05mUV2+Yl9pimOcLcUmOK66oIoJtxxnALaGqVcs9ODNiGZzqXWXRis3Q2V+LA5JiWWSoj7/ePJ6JfHFMhDLcTlU0Q7AM5M8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(451199021)(36756003)(2906002)(478600001)(31696002)(86362001)(41300700001)(38100700002)(38350700002)(8936002)(8676002)(5660300002)(316002)(44832011)(4326008)(66556008)(31686004)(66476007)(66946007)(83380400001)(2616005)(6506007)(6512007)(53546011)(26005)(186003)(52116002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkRJS1k1NFFSdlRnMmRWeUlNZUNRME9KU0MxTmMyNHN6MjJaY0RRQ1k0Q3Rp?=
 =?utf-8?B?UlFaRFRYa0hITFl5SEVWUjBOMERYZmlSRTllaStZY0UwTDlLTTVHUEZYUTJi?=
 =?utf-8?B?bExmMG5WYmx4NWF3dk9LQUlmcE9pZDhqdVpNcUJMSmZocFkraUpuRTdZYzNG?=
 =?utf-8?B?eTgrbFQ1Q2hKVjhMYlk5ejBLSDF5cVF1NExZNndFamVoaVprNVNHR21mMjN3?=
 =?utf-8?B?RXN4QU9wK1YxQUduZHViellyQVN3bWNBVFlSb1VoZHltaXNla1ZKMi9VNUU4?=
 =?utf-8?B?SWE2eXpmTytxYWk4Zk9taEZ5a3pncjZ1MTA3clgzVk93Y3pYSGMwLytqQlR4?=
 =?utf-8?B?ZXN1dDZhVCtFNDRkRDZFU25YVWM5Z3NTYWVQNWpFU0FUNzdQOS9GalJrSjRH?=
 =?utf-8?B?bVczVStFNGN3MGMzTGlSUmxnRmRVeTQ1TjIzK2lFWTRiMG1tbk94MHM4ZlV6?=
 =?utf-8?B?ZUhwak1qcnpyL21JYlcyY0I1SHFFdWh0a3NiYVU1YWZvNGxDVkNBWmJtYWtv?=
 =?utf-8?B?Y0prakU5aS9wUU9vbnRPMFVOajVyeWZiUnJ4M0VLczJWSkh0Zy9uZnlWS3hq?=
 =?utf-8?B?RGt2bzczamN0M0hDMHl4cXFndGZWRklqS1pSekJ4WVdZREpyZFVaK2RWaFFK?=
 =?utf-8?B?U2FHWGtYcDlrQkRsK2R1eFZzbXhSSVRrQkc5V1hRZlZwc1NMSTV0ZXFXRG9y?=
 =?utf-8?B?bE9sb3VXb0sySXhhb3BQSkN0cWVEdHJuZGNmazVMUjQxY1FuY2lWTXNrOGQw?=
 =?utf-8?B?SC8rek5VME5iUWRMcWdkTEZRNWo4OThiVXNiMlBTRG1hOFJJa2NLMnRUbVdW?=
 =?utf-8?B?KzN2Y2FEY3NxU0ZmUUhxZ3o0Y1pDcTRlRmVnTkM4Q0Zab1hvRUtRQjRJY2dO?=
 =?utf-8?B?ZVlldHg1N1JOOGRTTmZocnh3WlVaOEJtODd2a0c0M0ZHNjdIemRFZk1nb0lE?=
 =?utf-8?B?UHFLWFNZS2x6aS9XSFllOW95OTlUOFBnTGJxd0UxTDBSNFB6RUtkTWtxQW1I?=
 =?utf-8?B?UldObU45Q0Y1WVphYjh0bEpZRFcyNVo5NlZMUnlROGVPbVlnSlQzT0RFMDh6?=
 =?utf-8?B?L3lab2Z4TS90ZzBDQnVxMzVwMXRITnNzRkk4N3V5dnowRnZocEREUE1Hc25T?=
 =?utf-8?B?aFRiYm8rTEdabzBqU1ZhRDQ1WDZIKzB2ZGhGMzVrRW1mbUVpb3ppMmhTNS9x?=
 =?utf-8?B?RlZlck50U0RvOTVmd2U4SWI4SzlnVmwyYWxSZWc5TVZXMU5rYVEvZ3dYTlpv?=
 =?utf-8?B?bnJxS2ZaQk5paS9Wa1BxbG8rQ3hJdVAvYmQwNkxpcUs4VXM0cDJoVzdYSUIv?=
 =?utf-8?B?M3ZObkR3SHlieGpiclpHdGU3S0xWeVQrRmVmNWZjaXAvcytUSTNRdHV4Tm9X?=
 =?utf-8?B?UWx0T0Q4T2ZBQk5pNHA5K2ZISEM4VTJMNVZrbEdlc1Q0bGljVTZMdG5waGxH?=
 =?utf-8?B?dGJLcnhKMldpZkV4Z2gxdlhQcnRkMGt1Y055dC9RUlZEUVp1aXBZNHZpZDNt?=
 =?utf-8?B?Y0dnV2Z1TjJnNWg4RCttcVlRZENTQ2s2Nk1KNk95NnRCQXdpejZHWUduTW1Q?=
 =?utf-8?B?VERxdFdZWVR1YTlnNDFBN09aZGMrdG05VklOdWtJalFRLzVESDFKVmdRUklR?=
 =?utf-8?B?dWVKdVVwK0k2QlBQWG9JY3RkbEhZZG9tL3ViNU1MUlU1Y0tFR3VwVW5pdTJj?=
 =?utf-8?B?MnFaU2V1ZzBvMncrVmNyS2JYS1FmcHR5akk5N05UTXh3U2tVQU1HZnZyU0VU?=
 =?utf-8?B?ZGVpa0tINFpUdCtEOUF3R3FobzAzWXU5OVhGUWlhSEpFOGJkNFBhaGhKUU5J?=
 =?utf-8?B?T3pwUzhiT0I4SkVJRVhid2Qyems4NTRrNGhZTkZzT3VHS1FhamJqWXc5NUJj?=
 =?utf-8?B?bUtEa0h6TlhkaVg3d25Zd0ZZUDZNLzhucEFoZlZycFJVQ3B4TjZKZ1hQbDQ5?=
 =?utf-8?B?dnJKc0FFTTZ2MitqUE56N08rSUNwN3pFNmFjODllSnJlaFpES1c1MTI4b0Ft?=
 =?utf-8?B?Z1NYV2dwcFVhU0xucmJMK2xYQm9zMzN5WjV1bVI5REFZVGFiVi9McVdtOTZU?=
 =?utf-8?B?OUNNeXVsZzkxRXI2QzdZWTY1VWRGanZESnVqbUY5aFpRRnV2S0lMTzVUZTNN?=
 =?utf-8?B?L0FPT21YelYxaHRrK2l0cTFHRDFWZ3B2MlhSeGhUSm1PN1J5MGpna2lwQmdC?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe74790-d0a9-40c4-a2e7-08db65e5bc7f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 16:55:58.8770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7fS8xJxMWIhM+7rG3qcm/2kY8w8hoWgmb+g3IwBBFTM5dY/OnHdR6TmmuANQzcY6OIUF5JVT6rD9ldMx71NZlErFOtTIFse52PD+s/TZj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10108
Received-SPF: pass client-ip=2a01:111:f400:7d00::721;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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



On 6/2/23 16:43, Hanna Czenczek wrote:
> On 29.05.23 17:15, Alexander Ivanov wrote:
>> Cluster offsets must be unique among all the BAT entries. Find duplicate
>> offsets in the BAT and fix it by copying the content of the relevant
>> cluster to a newly allocated cluster and set the new cluster offset 
>> to the
>> duplicated entry.
>>
>> Add host_cluster_index() helper to deduplicate the code.
>>
>> Move parallels_fix_leak() call to parallels_co_check() to fix both types
>> of leak: real corruption and a leak produced by allocate_clusters()
>> during deduplication.
>
> I’m not really a fan of splitting parallels_fix_leak() in this way. 
> One problem is that parallels_check_leak() still increments 
> leaks_fixed, even though it cannot know whether that will succeed. 
> Would it be a problem to move parallels_check_leak() after 
> parallels_check_duplicate()?
Will get rid of this splitting and add an argument to 
parallels_check_leak() for opportunity to call this function without 
changing leaks and fixed_leaks fields in res. So we can just call it 
from parallels_check_duplicate().
>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> ---
>>   block/parallels.c | 138 ++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 133 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 64850b9655..9fa1f93973 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -136,6 +136,12 @@ static int cluster_remainder(BDRVParallelsState 
>> *s, int64_t sector_num,
>>       return MIN(nb_sectors, ret);
>>   }
>>   +static uint32_t host_cluster_index(BDRVParallelsState *s, int64_t 
>> off)
>> +{
>> +    off -= le32_to_cpu(s->header->data_off) << BDRV_SECTOR_BITS;
>> +    return off / s->cluster_size;
>> +}
>> +
>>   static int64_t block_status(BDRVParallelsState *s, int64_t sector_num,
>>                               int nb_sectors, int *pnum)
>>   {
>> @@ -533,7 +539,6 @@ parallels_check_leak(BlockDriverState *bs, 
>> BdrvCheckResult *res,
>>   {
>>       BDRVParallelsState *s = bs->opaque;
>>       int64_t count, leak_size;
>> -    int ret;
>>         leak_size = parallels_get_leak_size(bs, res);
>>       if (leak_size < 0) {
>> @@ -550,16 +555,127 @@ parallels_check_leak(BlockDriverState *bs, 
>> BdrvCheckResult *res,
>>               fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR", leak_size);
>>         if (fix & BDRV_FIX_LEAKS) {
>> -        ret = parallels_fix_leak(bs, res);
>> -        if (ret < 0) {
>> -            return ret;
>> -        }
>>           res->leaks_fixed += count;
>>       }
>>         return 0;
>>   }
>>   +static int parallels_check_duplicate(BlockDriverState *bs,
>> +                                     BdrvCheckResult *res,
>> +                                     BdrvCheckMode *fix)
>> +{
>> +    BDRVParallelsState *s = bs->opaque;
>> +    QEMUIOVector qiov;
>> +    int64_t off, sector;
>> +    unsigned long *bitmap;
>> +    uint32_t i, bitmap_size, cluster_index;
>> +    int n, ret = 0;
>> +    uint64_t *buf = NULL;
>> +
>> +    /*
>> +     * Create a bitmap of used clusters.
>> +     * If a bit is set, there is a BAT entry pointing to this cluster.
>> +     * Loop through the BAT entries, check bits relevant to an entry 
>> offset.
>> +     * If bit is set, this entry is duplicated. Otherwise set the bit.
>> +     *
>> +     * We shouldn't worry about newly allocated clusters outside the 
>> image
>> +     * because they are created higher then any existing cluster 
>> pointed by
>> +     * a BAT entry.
>> +     */
>> +    bitmap_size = host_cluster_index(s, res->image_end_offset);
>> +    if (bitmap_size == 0) {
>> +        return 0;
>> +    }
>> +
>> +    bitmap = bitmap_new(bitmap_size);
>> +
>> +    buf = qemu_memalign(4096, s->cluster_size);
>
> There is qemu_blockalign(), which actually uses the BDS’s memory 
> alignment, so should be a better fit.
+
>
>> +    qemu_iovec_init(&qiov, 0);
>> +    qemu_iovec_add(&qiov, buf, s->cluster_size);
>
> I don’t think this is necessary, there is bdrv_co_pwrite() that takes 
> a buffer.  OTOH, if you want to keep this, you could replace the 
> bdrv_co_pread() call by bdrv_co_preadv().
+
>
>> +
>> +    for (i = 0; i < s->bat_size; i++) {
>> +        off = bat2sect(s, i) << BDRV_SECTOR_BITS;
>> +        if (off == 0) {
>> +            continue;
>> +        }
>> +
>> +        cluster_index = host_cluster_index(s, off);
>> +        if (test_bit(cluster_index, bitmap)) {
>
> I understand we’ve already ensured that image_end_offset (which 
> determines the bitmap size) is large enough, and so this can’t 
> overflow, but I could sleep better if there was an 
> `assert(cluster_index < bitmap_size);` before this `test_bit()`.
+
>> +            /* this cluster duplicates another one */
>> +            fprintf(stderr,
>> +                    "%s duplicate offset in BAT entry %u\n",
>> +                    *fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
>> +
>> +            res->corruptions++;
>> +
>> +            if (*fix & BDRV_FIX_ERRORS) {
>> +                /*
>> +                 * Reset the entry and allocate a new cluster
>> +                 * for the relevant guest offset. In this way we let
>> +                 * the lower layer to place the new cluster properly.
>> +                 * Copy the original cluster to the allocated one.
>> +                 */
>> +                parallels_set_bat_entry(s, i, 0);
>
> As far as I understand, this will modify the image content when read.  
> Can we perhaps revert this change if there’s an error in 
> bdrv_co_pread() or allocate_clusters()?  I understand that a double 
> allocation is a bad corruption, but if we can’t fix it because of some 
> unexpected error, I feel like it’s better to still keep the image in 
> the same state as before rather than having effectively destroyed the 
> data in the respective cluster, so users can at least try to fix it by 
> copying it.
+
>
>> +
>> +                ret = bdrv_co_pread(bs->file, off, s->cluster_size, 
>> buf, 0);
>> +                if (ret < 0) {
>> +                    res->check_errors++;
>> +                    goto out;
>> +                }
>> +
>> +                sector = (i * (int64_t)s->cluster_size) >> 
>> BDRV_SECTOR_BITS;
>
> Both for my own understanding and to maybe suggest a simplification: 
> This is the same as `sector = i * (int64_t)s->tracks`, right?
Yes, you are right, will replace.
>
> Hanna
>
>> +                sector = allocate_clusters(bs, sector, s->tracks, &n);
>> +                if (sector < 0) {
>> +                    res->check_errors++;
>> +                    ret = sector;
>> +                    goto out;
>> +                }
>

-- 
Best regards,
Alexander Ivanov


