Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 457C97A359F
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 15:05:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhrRs-0002pQ-Uj; Sun, 17 Sep 2023 09:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qhrRn-0002oW-Ag; Sun, 17 Sep 2023 09:04:23 -0400
Received: from mail-vi1eur04on0712.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::712]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qhrRj-0007r0-9X; Sun, 17 Sep 2023 09:04:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgWjkJg72vN8i+F6i/Pbwrm9qaq8QcUYB8P58gWLKHYP3eLYzhyGLvra0iWAi2rJFju1YME/o11qet5dm4X80Pee2bqZEcBZ2oVNjGbbiOOaVcFkNzvO2wRg0u6vLVxQ9nDcBx2GcjJXm8OK2K+6eLvhmrYKOg8sX203Qc3bncdWtInV2GKES3mAZdBxwmgHun3+geFTtD0sOWxawNZ1RKyC86WFBsMf0rtLCrsbNT09Z8d5UqFNKLmu+FZuDsMBShvKYm8Ia6uAPErdFhw1BLXA4fqeGIiTsUJAq+j3C4ZRGJUsmo8uRdJphNftx7E9dgXLK0Jlfi4XLsoY34f8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26FsPJgz7ub2AI5u9I0auHjufWOtLU6HGKCZaItxk+A=;
 b=idZQG4XTER0Pm+phOCNSrhCDCfRAn/+pEOhbDS0J1KQuX1eeeWtzYMz9I2x6QYmT6bFEaLDoZLCLkdZT5958x4B5aVYe5Uct3C4Xjn3vI7gDGFPknV5ypVN80JuJ8UB1jGN/YHW9IRuh6tAULSLj3LwHOn0/fO7kZvp1D2UPAw0h1CYeSmevZNAkUuWZK5pwL6pBnQlKf3SeGqUu08Tv8C/3qm4vH3rOf0w9uRXczNQgLMmHtvVRykJYxJ9oLg36d5/uGFcLb8HKUrxdXw3+GNPgiPCRe0H1ridcjdfEzn6WvhR6Gr/8J1aRT8YRREsSPEALvep+wUv/s+SSsaLbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26FsPJgz7ub2AI5u9I0auHjufWOtLU6HGKCZaItxk+A=;
 b=oEdnSlSRoz5K7qbtXYAp9cYts+gGxGK7nz+6R+alh9PUxUWP3KABgOFCd74l8kEJch/MCi34Qztagsl7CXPH3ukeIM7P+Dx57zAThyq5rTu4R8cAchiKlOhCrt9fYS7uAVQA1xUMP+kyjhzKY/+4pkgyxJjXBBVj5hRGr1KE1OaFAmOSl5Cpe1p9hUdYhs99U7fGEONPqilg9d3YBZuOejpMrCsdIxrj6Bz7HvkCmUS5hPdE/TSHfSQeao8d3mbI/syaa5GYDJFJVPoQIc0W6+tLnKVdV6VGxwpp+mw5HeR15YpBu3Fo6/ZDCdmgiNz5wzYebwWAixeLJAZrRICxmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AM9PR08MB6644.eurprd08.prod.outlook.com (2603:10a6:20b:30e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sun, 17 Sep
 2023 13:04:09 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f%4]) with mapi id 15.20.6792.024; Sun, 17 Sep 2023
 13:04:09 +0000
Message-ID: <0e76c79a-670c-a7a6-c4a6-db69168858bf@virtuozzo.com>
Date: Sun, 17 Sep 2023 15:04:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 06/21] parallels: refactor path when we need to re-check
 image in parallels_open
Content-Language: en-US
To: Mike Maslenkin <mike.maslenkin@gmail.com>, "Denis V. Lunev"
 <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 alexander.ivanov@virtuozzo.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-8-den@openvz.org>
 <CAL77WPB7nRaWzzkQDqOJCQLpvWYd-=RpBiFn2Roi5wKzZONPFQ@mail.gmail.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <CAL77WPB7nRaWzzkQDqOJCQLpvWYd-=RpBiFn2Roi5wKzZONPFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0160.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::17) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AM9PR08MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b103aac-e3aa-4f34-39f9-08dbb77e9499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3g8oSvDnxTpXPf6jv1b0MZZXIriZqQ8Svbbg1F32TWcIaddoouS+7BIpIFpd20qIe0DaEA0Q7G4kkWY6vVzhAbIqfJdlv40LTLflxMnCcrgvSB6PR2hfZIVNomlfAO7L3w9TXK6dv0AoY6/YKvC/Qj4QHcNYgvQZF0NV+ZbdRnwxnZO47xVuNZhTssNE4a+YoCE9fF93dvx0NU1v/6TkDwEPkA0M2L5XwERyklF9HxAXLPYxtKL/aumyJ8DgnYS7UGmGr1keJEHA1Gtt1ArCkW3rIh9vjnRkH0eFDs4WrvqGW1JBfNm2N+Ojyt10EA5l/y77bDqglE+vrnv3jQW69l/cLRNxU3+gLnCJqd7dWtJjeLKbQNk5XcHzD5ybjQJxOPsBFnA7Zg5cTq6FoBVPMouYzYbpyOSxgVA++MqNUCeQE/n58BG5LdQ18l37l73Kwbe1bH7AidnpgXQCw+c6/tNWsYveo8/7xYsPIRIJ7UnxOhE/5cpMH7fhGjxe6TIoon6wfuEkwr6SeaqgKRnLGihAHycaTmF3u47Dc0OnLJYi8cm/q4c0HMA7DPp/qH/ZnUvNPvRJ+Xx1Pjnz6roDg776xa7bdzvHfYMdtSFJFwtBlxaWwSCJKA5wVZoYZuz4kghFV58TSOLDzA7M99FyZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(136003)(39840400004)(376002)(186009)(1800799009)(451199024)(2906002)(31686004)(5660300002)(8676002)(8936002)(4326008)(26005)(107886003)(41300700001)(316002)(66946007)(110136005)(66476007)(66556008)(478600001)(6512007)(6506007)(6486002)(36756003)(83380400001)(2616005)(53546011)(38100700002)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3NJOThCcU1EaCtib2VQMEloR2lWczYrMmxBN01WV2FFZnlzY2ZkOFN1Nnpp?=
 =?utf-8?B?ZS9ZSnpTVWZabjIwRVRDUmxvMUhuTTBPN3NmTzlCUGdCNmp3Ym1Zalk1NXZw?=
 =?utf-8?B?KzgzYXkwMTl6Rkd3ZURrRFZMVVRrSjNQbjI5anRzaFFlUEVJNGZqTDZ4Mjdn?=
 =?utf-8?B?UnZtS0ZWem5wL1BUcHBsUitrQjdZaE1jeDFwbThzc2x1Z3N5Mm80bmhQU0ln?=
 =?utf-8?B?TW1nZThVd3hQeHdIQXFocGhWWlY2RHpoczJ6L0d6VUprYjJDWEVXM1hiRUZt?=
 =?utf-8?B?M21TaHBINTZRSG5BVmVta3dPQ0V5ZDdEOWVzdDI2OTVlMTNNbVlrQVQxYXZG?=
 =?utf-8?B?Wm4xcFFVVE92TVpCemJ2S0l4ZEpGOUp0YU82Y2xNZjRIc0VYbE5vaUVwUVBV?=
 =?utf-8?B?NTZZak1Iak40SmxiaEhDcHIvWDVXbnBFTG1WOUpqR1MyNGwzN0hsTlhLM1I1?=
 =?utf-8?B?QWMwNEFYUlhrbUs1bFBBQUVjZE0vdGgzalhsTk5JS1I0OUJZbzdxTUtMMEti?=
 =?utf-8?B?K2VTUzhCR2dMd0hRNzZsbDd5eXBGVGdaTGhmblMzMHJTTWswMzBXcDFmc0Fy?=
 =?utf-8?B?bGd4ajNYcU1uV3B0L2dTVEczZTZIZkFTS21wZklvbkxQU1V1aVRBdi8ydklr?=
 =?utf-8?B?OCtnaGlWVmZyVG9LZnRzZ0ZtVUp0cnJCNnRNUURKNm9ReTBPUGg3ZXMyU2hN?=
 =?utf-8?B?b3lMS1Q0NitkTHJBbXcyeHlERHZCSFN6WjVjSkRXeVR0L3phZ29pTEo1dVcx?=
 =?utf-8?B?djFmYmxmS2x4SG5lM3F0U3NDKzFZRUpiVnZoeWxwenI5c3dJaGFUclZSWGZO?=
 =?utf-8?B?dUZQMWMzMjZmL29YSHZvTVp2a0hmeDV2dkpQNnZ4dEs4VWl4WVVUZ2lQUjNP?=
 =?utf-8?B?SktEOWRtbFhweHpzdkpHV3d6MCtjNmwzVk55MVgyWVlZVXJqeEw0U21palJI?=
 =?utf-8?B?enhqakpnSk13ZWhkcXdwZ3NDNVFob2FxL1h1eEhWWWtlUm1CMFE3amdzckpp?=
 =?utf-8?B?bWRFZlRHVE1LRWtMc1RZc281Z2o4SE41M1lQZUc0YWMwbE9PdndML3lCL3My?=
 =?utf-8?B?U041SXN1ZmpHcGRyenBrWEdTNzFyN1VtR3NuM0haNDhoTlE3cDlQdnArdHNG?=
 =?utf-8?B?Tm5Ic2dpRHR4ZmRjMStkRjJ4bnJ1NExkYmdwWXpTaUhILzRxTXBUSC9mZHln?=
 =?utf-8?B?SWRJV2lOb3EyMkVsZWE1aU45TjhDeS9ZeHA0aDRUSG1rTlljZG1sM3Z3Tmtt?=
 =?utf-8?B?dEc1QzhtMXFWQjJEUmdsaEZCQWxMa1EzVmRHOTUwM3BjWUtUcmUwK2lQQTFp?=
 =?utf-8?B?aHZ1L1Y0d0RkaStXcy9XMUFnZUxoYlpxRStKMXhJZnJrYnlLSEM2dGViejVu?=
 =?utf-8?B?dFlWWEQwaW1PWHMwOXAyM25EbWJYK3M5cVFQV1g1aUIyUWJmVGJOdmwweHhv?=
 =?utf-8?B?WUIxQUhaK1NVMCtLRDBTMDFveElIRVVqZkgyM2tEMUZDaXJDM2tWdU9aSTdM?=
 =?utf-8?B?Z05IVC9yK3VHYkIvckNlZkphcG9Ba2JTUkdnM3Ryb2xIV3MyVTUrT2FySnRP?=
 =?utf-8?B?WmlkdW5ndnExVTR1eWpBTytkNjQwOWsxb1JnNHRWYnA4RXFWK3VrNFpIcDlz?=
 =?utf-8?B?SjJJL0I5dmx4WjlGOThxU25sakhzaGdrWXcxVWRCM1k3RllGRHUxZC9Celh0?=
 =?utf-8?B?KzBvQzU5b0lHVUoyOEd2UlgyMXMyL052L1ZMVnhYU2tvd2FlY1FHNlFDcmpE?=
 =?utf-8?B?VkpMNkREUVQxYjBEWW5wN3FrVVdzVGZCMEpKQ2djK2dlSlc3bVlyM0R5TzJx?=
 =?utf-8?B?akg2V0RMaXpBQkoyNHdpWlFuYmlZYzIvc3l6ZWczZHc5WVo4YnVUejlRWlhE?=
 =?utf-8?B?eVZreVBDU3VmVjlCWDVWOTdjb0NLUHZmVUhmRTJZcXdMWGRKcEZWVjlCZFJN?=
 =?utf-8?B?K2JrbUk4NUU4c2ZZcUNSQ3U5RGNxOXYwZWhMTE01Yzh2Kytwc3FPVXB1bEZD?=
 =?utf-8?B?RjAvZFBxV1RmQ056dUZWWDlxdGpZelNZKzA0OHNJT3NjUWZHOTU0bkpTNkwx?=
 =?utf-8?B?NnJtQmZRMTQ4RFMxd3FaZS8weitiZHZIaFlXa0V6YmFhRjBxRUtmRE1nR0hD?=
 =?utf-8?Q?M5NVX7T5m/r9OCcSQEYvNPDrU?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b103aac-e3aa-4f34-39f9-08dbb77e9499
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2023 13:04:09.2819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LD2rov0IeMD6lESqDCvqA3S2r3kZ1xKv60dOaDQ1RK5Az6TMBLF0MhnyOknBmKx2F+pmU1bKdQ61DEHWsPRoDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6644
Received-SPF: pass client-ip=2a01:111:f400:fe0e::712;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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

On 9/17/23 13:40, Mike Maslenkin wrote:
> This patch generates a warning.
>
> On Fri, Sep 15, 2023 at 9:41 PM Denis V. Lunev <den@openvz.org> wrote:
>> More conditions follows thus the check should be more scalable.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>>   block/parallels.c | 19 ++++++++-----------
>>   1 file changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 8f223bfd89..aa29df9f77 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -1065,7 +1065,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>>       int ret, size, i;
>>       int64_t file_nb_sectors, sector;
>>       uint32_t data_start;
>> -    bool data_off_is_correct;
>> +    bool need_check = false;
>>
>>       ret = parallels_opts_prealloc(bs, options, errp);
>>       if (ret < 0) {
>> @@ -1133,11 +1133,12 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>>       s->bat_bitmap = (uint32_t *)(s->header + 1);
>>
>>       if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
>> -        s->header_unclean = true;
>> +        need_check = s->header_unclean = true;
>>       }
>>
>> -    data_off_is_correct = parallels_test_data_off(s, file_nb_sectors,
>> -                                                  &data_start);
>> +    need_check = need_check ||
>> +                 !parallels_test_data_off(s, file_nb_sectors, &data_start);
>> +
> ../block/parallels.c:1139:18: warning: variable 'data_start' is used
> uninitialized whenever '||' condition is true
> [-Wsometimes-uninitialized]
>      need_check = need_check ||
>                   ^~~~~~~~~~
> ../block/parallels.c:1142:21: note: uninitialized use occurs here
>      s->data_start = data_start;
>                      ^~~~~~~~~~
> ../block/parallels.c:1139:18: note: remove the '||' if its condition
> is always false
>      need_check = need_check ||
>                   ^~~~~~~~~~~~~
> ../block/parallels.c:1067:24: note: initialize the variable
> 'data_start' to silence this warning
>      uint32_t data_start;
>                         ^
>                          = 0
> 1 warning generated.
>
>
> Regards,
> Mike.
wow! That is pretty much correct!

What compiler/OS you are using :)

Den

