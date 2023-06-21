Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C2738D92
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 19:48:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC1vC-0005VR-DK; Wed, 21 Jun 2023 13:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC1v8-0005Uk-L0; Wed, 21 Jun 2023 13:47:06 -0400
Received: from mail-ve1eur01on0718.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::718]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC1v6-00072J-A3; Wed, 21 Jun 2023 13:47:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sh1/o130XTIS42EglwlMEcZpbAPaGq/Cf0VI1v1356NKUcvTMT6nn8rqsVgaUf2laKCRBktycs8A25EeCfmeN2D+UXIWNcJtCTTV4s3ym6+czUxPM6Gom4QKMypYWxZ1X72vZtD7kfCfu3XAvuFHZbFV0sFLjdOBYzgT66L/nPHsA+qUU9eC9cJeNzXZOEpiV8CNRUC+iPhwv79rOl5skueLFgAVBWWfWQTEQB21/ZHt6rJFXKZ4qT0zjCUCYAdblEasJhj7v6etynt8KeEHV5szeCReMcL1G4RqSbkd86XrFGXZ5072Kn3g6zrINJdexdD/zhLSBNjF/wFGsFAxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxRAJGo4gtDB9pFnJwLPDwx78KM0YFFn93XObPA/ncE=;
 b=Q8jS+6ASDcK9KxKttCxtjeD/k/6RHGtFERjNzGQw7nDB8RZRguNhAxCwhmWQp3fnvrrJujNLB86LuqWSsJVAyaSp6LTpApfvQQoyRXJyqxm8Xe6HyenQ1hSLXInANfdYjHRFLWHMhjUeYA5ATUO/gSpZwNO8B7Pibf+ZKtaQytB2ff+1TD5yT/fYeHP5yo2ug0bowC5h4D2iUoAXughG6+K8ODDt8KO+HMqcfbcKxhjcqXrBCQiFvOMaOJ+0pXvMqnwxWwPpTmNntWulxiKKjokxPs9T8fm8uQum7TqxdLiNDly4WEdKOQtlr2cHW79BPIQwhrSyIPej3yIkW1uctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxRAJGo4gtDB9pFnJwLPDwx78KM0YFFn93XObPA/ncE=;
 b=QNWXfvxpB7vFs6+1h03lR3wGn/qiGLEUS1ioltTxXvjSlEHDoE4Lw4WWajhYM8GWfsRCilGLUOjvx0n0dV/Oa7HjZMAtgd4nD8E1Bbe/jXU83nUAOsRp8lyEsqF6PJe6+Mk3SY8oIoFFKG8v7MiwlnE4VlzJC1BneHIxHzbMdIGwZHtQXDEf94xhIYJBWOhy+VDpl9SiQR7xgF/5VpxdTMQWHuDeL0unD00pEUKgRiKyx7TcRYxxpmiSd0QsZmQo2vmrNIQWHEINRXM006SpIkAnT1r/Ylx20OANrbumYLdbzgpdWdmCpwnI7t7vzPbxMFbiFiaH2OEAFw2CPLH7eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB9PR08MB8291.eurprd08.prod.outlook.com (2603:10a6:10:3dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Wed, 21 Jun
 2023 17:46:59 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 17:46:59 +0000
Message-ID: <548c3c54-0641-5cb4-c421-b2e8d10c55b9@virtuozzo.com>
Date: Wed, 21 Jun 2023 19:46:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] block: add BDRV_BLOCK_COMPRESSED flag for
 bdrv_block_status()
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
References: <20230607152627.468786-1-andrey.drobyshev@virtuozzo.com>
 <20230607152627.468786-2-andrey.drobyshev@virtuozzo.com>
 <75b5d7aa-fd86-c06a-4633-26567e044b38@virtuozzo.com>
In-Reply-To: <75b5d7aa-fd86-c06a-4633-26567e044b38@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0266.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::39) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB9PR08MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f9f903-9ec5-4b56-f98c-08db727f835d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IB+j+UEUwwS2oLIG1IgNK7OTEXR5ExFV5C7Me4aEfoStoKkzpO32ksJGHQ3B3K2lluiDVPmoU29FJ6o8Js/4Cpk3ziAuMGyMALe+0Quo8mEz2GOxifAs5EJS0skSWajxXrQ8ZpbIxzK9zHVyZO1QoZXAliAJWwem+6H3Zk6qn5yb9AhMnPnCnLifdoFBbhpvZV4HeNW6yqmESc/Re5Rji094QaaPSF0mcogM+g7hd42r/828/nYsfmBiCUhz1i9WCdBfbj+7VX/kWcZJFg+3p4bQPowMpvQF1I2UWRrBVGSrHoD5h2LL337wCj4MF8Ea+UAXbu2mLtWMpOtabLTSO9nIqQMKUy2cszFLOI2geyaDJ2ccxYQEKf1UhDZxNy5t+UyMNknAfUMrlCDX9EMEHtRvVWWQR3Eg3BvMVlD3YO493XwEZSDNfIS1qfEmcuNv3tbQyI+lOaYipXJnFlbuCmnTYdVCAE5bqXp0ERWgpZ4e0kjjfrVZlctajR8LwC1TK9LjsImPfgd2PNXlThRPXVe9MQv+BIyHLehLpnPHoxiwm+f5eAsr4yyO+7HHVX5WWkeZWIpfg+d2sdzt965ZN2bRtMjM12fcqKTrkHQd43hlXKPrV7+mLDKdHZvafBa3EYyKgmb/kWTRzn7bOT0BMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39850400004)(376002)(346002)(396003)(136003)(451199021)(8676002)(36756003)(2906002)(86362001)(186003)(53546011)(6506007)(26005)(2616005)(6512007)(478600001)(41300700001)(8936002)(31696002)(83380400001)(6486002)(31686004)(4326008)(66476007)(66556008)(38100700002)(316002)(66946007)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE1BVTc4TTZORS9xTFJsSm5LaU83aEFPcXlxejhIVWdBdGQ0VFhQTEUzOFQ3?=
 =?utf-8?B?NjNjL3BkNXJzSTlIQ3RvUEJyYS9oTTI4VzkxZVMwMXIzMnZCSnpkL2JFVWRi?=
 =?utf-8?B?NWk5bDZMVnRGNkltK0d0NUY4QjhBUGFhNVROa2dDYUZ2SWZwaytDV3doM3ZR?=
 =?utf-8?B?bm1MOTQ5NUtQUG4zN04wM1RLTjAwZm9xN2lBWmtiQnFNTWFqaW8vM1JuSDRs?=
 =?utf-8?B?a2dIOEdtVGVVL1NXbjlNVUZIcmw0QmhBTFFYUFZCaTdzUHVlamVadXZEb1Ru?=
 =?utf-8?B?KzVaSGRna0RRTjRSMG5uQUFDbzRXTDB0L2xMZFFaaWxKVWF2Sk1ISER0amhj?=
 =?utf-8?B?SEhvUC8rYUhPbmw2cXZURjduenkrS2Y4TXIwbzl1NG1EYitHemlVODdDZEt2?=
 =?utf-8?B?TzFabmEvdU9VVkJTQThPTldGOEsyYmZjTjFDWS9QczljQlE0Y3RvdDZUTDZZ?=
 =?utf-8?B?azd0THh6Mk43UjNxb1hzbUQ3bHhzOVU3Q1lvWTJja2RWVVR6a3UyRVpxTDhl?=
 =?utf-8?B?YUtPKzJnUTZydXB5WXdSUHNXUTNUa1ZzVmxsYjUvR1dWdnNGWGVqdUg3ckx6?=
 =?utf-8?B?VkNlZFkrZzBYS3NWNXhCSHpVajU1T1MzQUxjZXRNZ1BOR0IwVzNzVHF5TjBM?=
 =?utf-8?B?T3JjS3pXbmR4VStvZjdlQW92cjBrRklJaE9lSkNoUjFvcEtqa25XaS9kOTlQ?=
 =?utf-8?B?Ky9Fd3loVUlwQ3BFOUNGZlhKMDMrdW91NXN1aFRWWmp6VG9ERTFzL2lDSDhj?=
 =?utf-8?B?am5yK1dLREdRMy9PNFlVNjB2ME1rS3JhSHF0QXBOcHJJbnZoTzVMVElsRURO?=
 =?utf-8?B?czl5OVZNRTdMMjNJai80UmtyZHFrQU1NbFhVbVdvN2dkUVRNUmNJLzBlWHhZ?=
 =?utf-8?B?NzJlMXVoRjBqWndTUGpoQXZRKzVraURBanI5M2ZRdXhzMSsvSTBqd0QreUdO?=
 =?utf-8?B?SjV6UFV1UTdhK05wUUNVOU5kbTJ3ODkvckQyV2g2ODJDN0VYWWZmTzI4Zkox?=
 =?utf-8?B?RUx2dXRPdGFGN250U3RwVHk4SXFGM2N4WElnczQ1Nnp2QkF4SHlkRDZRUlo3?=
 =?utf-8?B?U0tJZnZWd0lBT3h6YmdMNUhwWFd2cVp3aHcrb3NRbmQ4aEFjK2pUOWNNYVUr?=
 =?utf-8?B?QkVLdE53cWlQK1FQaFVaRmliRkZxVlFWZFlOYUVZdExKS0ZNNEQwOEE4RmNZ?=
 =?utf-8?B?VlhxdDRvdnYwbHR3NWdhRWdmQ21tQkgzZTBJb1kvY2VkcDVMUE9SV2FQeHkv?=
 =?utf-8?B?UTlrV0FPbmJKV3A5Q0JvdkFnVmFITER5VHVkOUpQV3JzQnN2OHRFM0hXWVp3?=
 =?utf-8?B?akdBQWwxTEt4UVd1TUlpenM4Qng3SkJkUWVFVTRVam1xcWJRMWVrTEVwbDVy?=
 =?utf-8?B?WGJITkREbDVJT0xUMTJpa21mbVhEMUE1L1BUc1lxR3B5dnJPbDNWaEdVYy8z?=
 =?utf-8?B?SHUwREt4ZHJ3Y0JoMXRSckVZK2hqd2NXM3dEQ0tqOFJnZmEwVHhRZEZxNTd0?=
 =?utf-8?B?b3hpYjFGT2xSdCt2dXliYjVWeGhpVE12RGh1cDhZcHFrdW91YXhMU2MxVjBM?=
 =?utf-8?B?bXBxNXpzMjBhZE5wNWU4VGowZHVlWmwxc0pKUGtUaDVzQ3dJdW0xQ0xreW50?=
 =?utf-8?B?aWZtTkNRMG1TSGtCYjdZNllXdVpCRC9XaTdPdjdpeFVXaG1zZ3JFUjZIWXJu?=
 =?utf-8?B?aGwrYkVtb2FWQ1RlRU5ja2VZK0hKeTNONXYxUkJPWmdyZk1sK29vYWxOdHZo?=
 =?utf-8?B?UjlSUTJYZlNieFBWNkVMZmNMMGZNVjRyTzA5SUkzY21uS2lvcFk1Z0o0cG5j?=
 =?utf-8?B?U0ozWGJKTU5qMHVKeS9ERnBLZmtFMFpXT1UyY1dlVjRvRVdSYlZ5K29wVmlK?=
 =?utf-8?B?dGEwbGN2YmxxYzBUNm9lY055UGVzaXJIaWxTV280cEpCMWNDcXI1OExRays2?=
 =?utf-8?B?VnRUd21OaHFLcUhoelZGWkV6NmM1Rzl0d1A3RGhLaVJFUi9QN0RqRGVDQm8y?=
 =?utf-8?B?TzEyYmdnNy9OcVNCSEVpV0RiMGttUUMvUVBDa0xnb3p3TjhhdGFBZVF4WGxr?=
 =?utf-8?B?bjhxbXVJSVN5Zlh0U3BaS0ZrdW5BbDNlRVlVZkEvRDFtcGVNaVJjZ0xPb3B3?=
 =?utf-8?Q?FXsvrG2mNqZ/cQg24KMyKU6NS?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f9f903-9ec5-4b56-f98c-08db727f835d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:46:59.4981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sxzCZxwqWomquixLGqvqVPFrG6LrUILLv6LJ4DusEsVfxFdnwsBHP23NppiYombwEjjGPlvd993AsfzyElXHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8291
Received-SPF: pass client-ip=2a01:111:f400:fe1f::718;
 envelope-from=den@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/21/23 19:08, Denis V. Lunev wrote:
> On 6/7/23 17:26, Andrey Drobyshev wrote:
>> Functions qcow2_get_host_offset(), get_cluster_offset() explicitly
>> report compressed cluster types when data is compressed. However, this
>> information is never passed further.  Let's make use of it by adding new
>> BDRV_BLOCK_COMPRESSED flag for bdrv_block_status(), so that caller may
>> know that the data range is compressed.  In particular, we're going to
>> use this flag to tweak "qemu-img map" output.
>>
>> This new flag is only being utilized by qcow and qcow2 formats, as only
>> these two support compression.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   block/qcow.c                 | 5 ++++-
>>   block/qcow2.c                | 3 +++
>>   include/block/block-common.h | 3 +++
>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/qcow.c b/block/qcow.c
>> index 3644bbf5cb..8416bcc2c3 100644
>> --- a/block/qcow.c
>> +++ b/block/qcow.c
>> @@ -549,7 +549,10 @@ qcow_co_block_status(BlockDriverState *bs, bool 
>> want_zero,
>>       if (!cluster_offset) {
>>           return 0;
>>       }
>> -    if ((cluster_offset & QCOW_OFLAG_COMPRESSED) || s->crypto) {
>> +    if (cluster_offset & QCOW_OFLAG_COMPRESSED) {
>> +        return BDRV_BLOCK_DATA | BDRV_BLOCK_COMPRESSED;
>> +    }
>> +    if (s->crypto) {
>>           return BDRV_BLOCK_DATA;
>>       }
>>       *map = cluster_offset | index_in_cluster;
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index e23edd48c2..8e01adc610 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -2162,6 +2162,9 @@ qcow2_co_block_status(BlockDriverState *bs, 
>> bool want_zero, int64_t offset,
>>       {
>>           status |= BDRV_BLOCK_RECURSE;
>>       }
>> +    if (type == QCOW2_SUBCLUSTER_COMPRESSED) {
>> +        status |= BDRV_BLOCK_COMPRESSED;
>> +    }
>>       return status;
>>   }
>>   diff --git a/include/block/block-common.h 
>> b/include/block/block-common.h
>> index e15395f2cb..f7a4e7d4db 100644
>> --- a/include/block/block-common.h
>> +++ b/include/block/block-common.h
>> @@ -282,6 +282,8 @@ typedef enum {
>>    *                       layer rather than any backing, set by 
>> block layer
>>    * BDRV_BLOCK_EOF: the returned pnum covers through end of file for 
>> this
>>    *                 layer, set by block layer
>> + * BDRV_BLOCK_COMPRESSED: the underlying data is compressed; only 
>> valid for
>> + *                        the formats supporting compression: qcow, 
>> qcow2
>>    *
>>    * Internal flags:
>>    * BDRV_BLOCK_RAW: for use by passthrough drivers, such as raw, to 
>> request
>> @@ -317,6 +319,7 @@ typedef enum {
>>   #define BDRV_BLOCK_ALLOCATED    0x10
>>   #define BDRV_BLOCK_EOF          0x20
>>   #define BDRV_BLOCK_RECURSE      0x40
>> +#define BDRV_BLOCK_COMPRESSED   0x80
>>     typedef QTAILQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) 
>> BlockReopenQueue;
> Reviewed-by: Denis V. Lunev <den@openvz.org>
Looking into the second patch I have found that I was a too fast here :)

The comment is misleading and the patch is incomplete.

static inline bool TSA_NO_TSA block_driver_can_compress(BlockDriver *drv)
{
     return drv->bdrv_co_pwritev_compressed ||
            drv->bdrv_co_pwritev_compressed_part;
}

which means that

    1    257  block/copy-on-read.c <<GLOBAL>>
              .bdrv_co_pwritev_compressed = cor_co_pwritev_compressed,
    2   1199  block/qcow.c <<GLOBAL>>
              .bdrv_co_pwritev_compressed = qcow_co_pwritev_compressed,
    3    255  block/throttle.c <<GLOBAL>>
              .bdrv_co_pwritev_compressed = throttle_co_pwritev_compressed,
    4   3108  block/vmdk.c <<GLOBAL>>
              .bdrv_co_pwritev_compressed = vmdk_co_pwritev_compressed,
   1   6121  block/qcow2.c <<GLOBAL>>
.bdrv_co_pwritev_compressed_part...cow2_co_pwritev_compressed_part,

We have missed at least VMDK images.

