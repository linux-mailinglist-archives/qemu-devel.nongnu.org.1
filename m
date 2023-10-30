Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7830D7DB5CD
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 10:10:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxOGz-0007oH-Sf; Mon, 30 Oct 2023 05:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qxOGt-0007nt-TN; Mon, 30 Oct 2023 05:09:19 -0400
Received: from mail-vi1eur05on2072e.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::72e]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qxOGq-0002kL-F7; Mon, 30 Oct 2023 05:09:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF3XNpFNixBJFFvc763aWTCsaRLoZzo9nlIdeSmjQJVDbHBPs37ZSdJYji1IFeTx14ydUYnEabROof6Ik/Xhh6Mvz0lzW3kXunWFYJKawfuUTHVBX19oeWCZSO8rVA3Oe3VJtZ81eOq6srFDH4etrAaFg9RJLOeB49M9ZFj9Hyv00840JtI7XNvWMT2NrRgec1Z7S2UJkUeByupaL4DeBDYUFTe37+PPgj4HHJRpuL0mfbfwUzxEL5unNpffEjlplld0LeW/kTgpvAnlgYJ/QL94fsj/H3bwlxiE670FVArQZmx2ciqvwS0bk1TTC78XYR2xiWFb1BAQA7gNkpoHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Y5QpbD+AxZLzjH4z/GfdnnzSBla5XI8rAGVucdxy60=;
 b=Jvzn6dI97+NVGMS0iuXtOk5NFmfMSKdr7gn3FctNYQIHOV2ZUh9M83+xLFGlUJC1M/JpXJ/s6DLr2/YAOSv244O90SgGIMEmtA1dQq4ChI1nM8AcQKY2I/9rzs8duPpCV6lgDV7ZbtnBFEkJk0HFy4rr1t1sExlqsUoavaqp4CAsbEcUpsq13hspNhCScREgBqzcQUfQzb4HN2BsQKQF3BLmytx+HU6h7mnmV43gclSbcEAR+hmi1kdwcK0W44LNxGn+66nbE3LkFqJYXosd0C8zKpT75ItSj99gxiEIB4u8HJUob390jUBA5QhanOYc6R44AgYjY3ghc9/W28T3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y5QpbD+AxZLzjH4z/GfdnnzSBla5XI8rAGVucdxy60=;
 b=Vga5/iPOCbi6sfPwcjJo1gJAd58jJkh1dY0P4VQRg2f8CDlvXxgMjCOjrxiTXPePpmjm0aQLBZKWYUHAtfF7TizWr977dS07iTCoSIJ2cQ6S0J/PQSjrn0WwgDsGp/00t4BDsSTNha3bCXl17EORRFCmqGYXg/2HO5Ra/qOHBSR9MuP0AuCVllzFwrfvc5mG6rG8r8BaaDIosgAl4aRwVmIrImyokugcf19ZPIrq7E6y2Cg1oE8yjfhtqrGpc3z2OIlWoWFoDt54IFmQE9mVe7aL+BWH06TJH8nKl8vk91SDYmsT/yjusR7q8VsofAaxvhppvbiqRG6JvnUN1InO/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by GV1PR08MB8131.eurprd08.prod.outlook.com (2603:10a6:150:91::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25; Mon, 30 Oct
 2023 09:09:11 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c196:49d8:108c:2254%6]) with mapi id 15.20.6907.032; Mon, 30 Oct 2023
 09:09:10 +0000
Message-ID: <4e40d9c9-6ddf-4235-ae90-71d6ef04af13@virtuozzo.com>
Date: Mon, 30 Oct 2023 10:09:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/21] parallels: Add parallels_mark_unused() helper
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
 <20231027074636.430139-5-alexander.ivanov@virtuozzo.com>
 <c3eb3258-d650-43d7-91c4-0f262408e54d@virtuozzo.com>
In-Reply-To: <c3eb3258-d650-43d7-91c4-0f262408e54d@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR10CA0086.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::15) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|GV1PR08MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac2c0db-1222-4cb7-c224-08dbd927e123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USR+23yhqCvvsSzsP/P+bVld9kAYDg7xHOmrJsLpuDb26DmdR8bWPomGko6OU9+U03xkHh1+KinPZF/C3OVAHnJ2GwDx6foRj55xR8Ru8PcTY+9SN+jEi3+IW/KUP6mVq2AvYJxOCbiksWBgj55G03NAaJI0pVl1dHdG6BPS7B/mlyKSRj9NjYteiwLrtYwy1imkQJ02BlD5DuUWEXPFXtYiY75wHyyHviaKep3UzJhU5JoH91uE66nrvoR7wUasZ9LH0Jo2JcAb8dcqQRX/NXwnztSJnc47v9RI/Tye9amU5TR+kExITZ0BOPS+ZSOAraeM1F2qjnLZuFjxr50QlkXKDgS2LwcJCbqgUgR1VYGhSFmMGMM0Wcj8L4VH/Ml326Kol8V0G5Q0As73GI6dR9OeyZlmTZEfT+hmOpQ+Ed/8cmsSBFOuiC2ktgCHzsNMGAjIsVeENn+hizoHPenJyxYJckBa5VxaAugd/cP8RaIn8Lr6fof8H3baVpfrvE2pHvYfmnz4prUyk2Pz1gdBihQ5lFeGfHlZVcOR7ChaLxiJeLc4bRXB+S0BNgORJBEaDKHVr0uaerc2l8ylCg9RY6iozMRDorcNjQ70ARrm6461qtbebNjBgRhQruLBvCIz6ASFIKLxMMGvLP6rub7Z8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39840400004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(86362001)(31696002)(2906002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(478600001)(36756003)(31686004)(6486002)(6512007)(38100700002)(6506007)(53546011)(66476007)(66556008)(26005)(66946007)(83380400001)(2616005)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTFHT3F3RWdHSmRKUDdOY0YrMTl0MTBxQmxGOXFqL1RkWnZzUmR0UzRwZHRh?=
 =?utf-8?B?eDlRZllKYjZQOCtvcUsyWk1vVnFGWkdISFJJd20zeXpXK0ZHQnFmTXRMV25p?=
 =?utf-8?B?ZGQ2Z2FrQ0VRNE1NNG1UZ1hzUlhuelJhU3krcjJIckNrRXBVaURQYSt0MUVZ?=
 =?utf-8?B?SWNMa0dNWEE5ZHp3emh2WC9INDkyT1dPN0hqMDhLSzVrVXBpZGJZL3pZRlVT?=
 =?utf-8?B?YWxJQ2ZWMWFEejdNNTFPTTk1VWRiclpKZkRMamI1OXRmWENkMmtzWVh6ellw?=
 =?utf-8?B?ZFZ5WjZUNHZEampZT0ZhbDdsYUFtVGgvcE1yaFVSZmNYclhXMDJ1K1R3VnJ2?=
 =?utf-8?B?TXo5OHcrdWdoOGhmUEJNaHFXNi9HNDBIUi96WHpQQThRTmI1Z0I2ZXdDZWdq?=
 =?utf-8?B?TGRTZjU3LzMydnFHQmRhUk1GMDdrelBJSEE5ZWpETFlaRHFaeHFhQjIzMVdn?=
 =?utf-8?B?WXhPQ3pxTXRvcytFT1VLRlovSGlLRzBIbUVjTFVoV0kvTGFzaHgwWnZ6K0RC?=
 =?utf-8?B?c0pPS3ZYaFl5Q29uU0pDa3dUSVMrL01YU2xTWXZOUXRRMTdkRXlmNU9GYlY0?=
 =?utf-8?B?ZVlsN3BZK3dEbExPUkg1Njc5VVQwNk1DaDlYckJiVXNrTW1mUXRIQzZQbVRR?=
 =?utf-8?B?VjB0ck52b3dDWXRXRUJlSEJkZDA3blZ1MGJyMXVNaGZHV0UvaGF6dnpvTzI0?=
 =?utf-8?B?QzNoM2Fpb2tsaWswcndGNTd1ZnV1TnljNENRZFdyVFZhL0diUmlZUi8vMU1I?=
 =?utf-8?B?RXF2cTNXbUlLRm1YTVdRS1dmY2o0ZGVoZW9uS3lBQjBnSXFRbWVBSlBubEhD?=
 =?utf-8?B?YXRUeWxNKytOOUhPTTF2SGtlZExsUHloa01FRnRJQ3hVS1NudUhjMjlETVVD?=
 =?utf-8?B?VW5GQ0djWTRFUmdKM3NyOUx1VzNHdzlFc2FYYndZQjFDLzc2U3ZhdCt6THI5?=
 =?utf-8?B?elZNM0VtSXNJbTVLVS80ZkFyd09GZXVaYWIveE1YZ2VBdHBxOGRVQzdmbTkv?=
 =?utf-8?B?dklXRHdCc1NTdXFXNVd2akVPNkNiMFMwdE9uSzhyNzhoL1dlVVlaWWlSY21y?=
 =?utf-8?B?RmpOTi9UeGV0OVpZU0V4N2ZUcS82aGtOMHBPRUV1ZWJpQkRRZ05MQ3A1dUI4?=
 =?utf-8?B?VXpJVllxMkJ1Q2U0ZHVBbmQxaElON2t5a29DV3JtcXByVklXem01WXROZGYw?=
 =?utf-8?B?S0RrK2JVQjFaZGJwd0p2S3hKNDl1dWtDSExRQnRCYlFyK2h1Mkg2WWZkc2tH?=
 =?utf-8?B?dWU3QldsOXc4N1liV2JzNUNzRUwyZk5qTUVnOFJ0ODN2bHgySUorbmRya2cw?=
 =?utf-8?B?VFRvVU45TEFIT0Nnd2ZYVVpCZkFIQ3BWSWtIcXZiM0ZNWFpBVmhlTWNSR3Q2?=
 =?utf-8?B?NEJaTkhzbVIyUmlVUmlOOVh5SDlMN2FOZ0g3Z0xzNW9iTEFxaHNKOE12N1dq?=
 =?utf-8?B?M3JZdXhrVUVhYnMxOVhXdWlYMExXUlJvTWdrSHJBOWlFdkMyc2QxOXpRVUVR?=
 =?utf-8?B?OFVBbG5peTFLcGI1eEtVRXhRVEVUSEtOZW8xQitZZXc0WUVmZW5UMWZocWsz?=
 =?utf-8?B?VGYwSzg4M2FIQlpCU2VxYTVLcE9NblhROEtRcERzaStKWFJrVDJidTJhT0RW?=
 =?utf-8?B?ZFRRZStCaTRSanBzUDEwdFBRN3gwUktBU2NCcmlndXFJQ05odmhxajRZK0Jk?=
 =?utf-8?B?ampKZ0x4TVlQT2IveWhNYzdrMzFQWHdON3V3WkNJc2V5SmVQTkxPSmo1NVRO?=
 =?utf-8?B?dyt1SWRVR3FTQWpEMjVncEZicjRuUUVOdzFzR1ZqVXFDRWFGVnFhdkVYMndu?=
 =?utf-8?B?amZTUlhkeVRZZjBkbnM0UmF5d1EyVS91T3VEcTJKTWIvZ3Jua1ZlN1M0L3pS?=
 =?utf-8?B?cjRFYjdXSUF6Z1NaVW1oVEtUOVpOeEtVQkJmNys3aUFHbmxrMHJDZVZKS3hZ?=
 =?utf-8?B?SHFYdG5VN0tEbHBna0hSa3JhUlVFTnpwcDdQaTU0YXRPeVBFV0ZGM0Q5R2RU?=
 =?utf-8?B?ZjZWVnNxc09iTnR0TlFkd3RiK29iazF2TS8wZW43dWV0MmE0cGQxSmY3Mmwv?=
 =?utf-8?B?VGVXYkJsdDJHRjdsV3lMTk56ZGgxemlyTFFYbFJVM2h3QjZyV29ad2FXOGJa?=
 =?utf-8?Q?nFATzCPLOn6FhWO9YMsG5uHED?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac2c0db-1222-4cb7-c224-08dbd927e123
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 09:09:10.8538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XEEhAf+3o5UZHCLj/21WGUYic5yD0o/MUYHMyx44OKCYdO3g4rhubyi8scr5N5DaH/OhXdNiH1g3Q8aTdlLSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8131
Received-SPF: pass client-ip=2a01:111:f400:7d00::72e;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 10/30/23 10:06, Denis V. Lunev wrote:
> On 10/27/23 09:46, Alexander Ivanov wrote:
>> Add a helper to set unused areas in the used bitmap.
>>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> ---
>>   block/parallels.c | 17 +++++++++++++++++
>>   block/parallels.h |  2 ++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index e9a8cbe430..a30bb5fe0d 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -195,6 +195,23 @@ int parallels_mark_used(BlockDriverState *bs, 
>> unsigned long *bitmap,
>>       return 0;
>>   }
>>   +int parallels_mark_unused(BlockDriverState *bs, unsigned long 
>> *bitmap,
>> +                          uint32_t bitmap_size, int64_t off, 
>> uint32_t count)
>> +{
>> +    BDRVParallelsState *s = bs->opaque;
>> +    uint32_t cluster_index = host_cluster_index(s, off);
>> +    unsigned long next_unused;
>> +    if (cluster_index + count > bitmap_size) {
>> +        return -E2BIG;
>> +    }
>> +    next_unused = find_next_zero_bit(bitmap, bitmap_size, 
>> cluster_index);
>> +    if (next_unused < cluster_index + count) {
>> +        return -EINVAL;
>> +    }
> I would limit the search with 'off + count'.
> There is no necessity to traverse the bitmap further.
>
> Den
I mean 'cluster_index + off' to avoid the confusion.

Den

