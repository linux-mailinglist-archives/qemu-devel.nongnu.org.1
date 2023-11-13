Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF217E997A
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 10:54:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2TdE-0003Xq-BH; Mon, 13 Nov 2023 04:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1r2TdA-0003XT-C6; Mon, 13 Nov 2023 04:53:21 -0500
Received: from mail-he1eur04on0720.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::720]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1r2Td7-00051O-SY; Mon, 13 Nov 2023 04:53:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i302kJsUXPpZINx2Vj8QPoaknlRwJWCjHC2fVwbHD/wZ5L/MClUEqd2mbp9eQkYJbzYA0hE7XtlpVwm0hC9WeY0Xu28k09inspGC956WSvYbPTZEdCl3cdOgmMFZNa7hdjSYkjDQmQhb83r8y/TYReNAEHfHGF+D07+MWu/DjHpPrGK6M1mYnphoOHXCm93apmd/qQmvMBp/uKdCnNHBCEV8b0DZ7fnA0UCsCNs0kN6taaOtb0mNbwTxzTTFerZEN4zMTGURsC4I9aoNWUVu7/tGZHMcB5lEjJ19kg9IgL2L53CbnkJg+07ud0HWuCAwTmqPzjN3MM6NygxIwJJ/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCwGAqUKWIsz0GJIGUsCVbTlCucGFSa7/R/rOyTVLu0=;
 b=m7s+RXtadc5R31WaGgEh+QDdUih88DPVUcz05PRnopq0RXuhc0dtnKb0VZa5ISjbM8pCepTp0BY9qpD40lyt1xlw4jSw+Yeca2V7bF+LojsSuSWopFSuvz00wVBfb/6OVWD5TApFLsjto3vFxDnJGEbnYRl67oLsKl1VRBr+erB9xcgVedX4tCzSaYXvE3jc4m7/jxKaWn2NLQlKZ00OGJOWcoskcBMbGFz2jGAuF0kN1ly3fyg8K9zEN2W/uxMOqKE6FiLLFLom8PSuvgmQ5k0V0NC8tIDYghbHs3AA4vf0QIgTCdImd516fEjRHvn7BmUhww9Qda1Xtzaj0S5JBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCwGAqUKWIsz0GJIGUsCVbTlCucGFSa7/R/rOyTVLu0=;
 b=EegVezb9PbM2rbJcFcnTCkDJx81WWDGwm2pXbAoAKcQrSzFo6xU4CFskfyGyB/eevGlUXdsnU9eh5C0BryolLj1tFoURwuHzfJEJvspeHz+NVn8QM6jhRg9ShAWfj/VBof7lUgyiY5ekLTdvbsAJvNFGzehuvIC0MZFVsyB/JzPHDvb7k3kMJqNOOzFa3ij47GLk+EnpyN0WLNDVUkZt27eIPCpA63jZn5AEVTJEQG35JIpG1LHi7HsxT7oo6Zq7dF3GrHOxNZpLn1mdybCK6JCRBJgYHX6t6eQPwbsXeIW/+Camfhgtr+/IBPHWzeQSmQf2GKZusaLk6waBRvLhIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB9PR08MB6489.eurprd08.prod.outlook.com
 (2603:10a6:10:256::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 09:53:11 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 09:53:11 +0000
Message-ID: <c0dceeca-f5ac-4faf-99fd-04a5f7a55b40@virtuozzo.com>
Date: Mon, 13 Nov 2023 10:53:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/21] parallels: Add parallels_mark_unused() helper
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
 <20231027074636.430139-5-alexander.ivanov@virtuozzo.com>
 <c3eb3258-d650-43d7-91c4-0f262408e54d@virtuozzo.com>
 <4e40d9c9-6ddf-4235-ae90-71d6ef04af13@virtuozzo.com>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <4e40d9c9-6ddf-4235-ae90-71d6ef04af13@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0075.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::28) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB9PR08MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: af22c467-b816-4b4f-e01d-08dbe42e587f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ON13AlHa5/EHUqQF3BkjsKdHvHdMG8KwXhmjaT2pI0CYysXJTgjn5x+mbRsdR2aI68mGum0OYCBzFnCmR6pDtgghbxxboRNQgsWV78OwOdUAfQRYDcY8uNYSTbsgw4+m9T3L2srh9a/e/RY8dYkAQuSjBd0qvQIRmHqUlVacuOroH3TX+mFuZNtU6X1CqGxYWWAirX/pfSqQz6R++KlfYNLrYgog5Ai2CVTbwPK/e+zwkXtI02ELWwLm6TFww17JeEsAw6BEjIH3zr9VfD5t3hZoeNNAA43tZvyUdRIgXksXzK4c8M/RQC9PAxsq++AsgPIp6W3ihPug+dKb46EHd/RuEArro3Cc867pgGWAOo5hgk9u4IfGL8DfG/O03eKmrWgDsgF4rb7eVU/FlHDfTK4C1jzHsEOp4w58YjSt+jZ1hMADf4poKU0EZ4fOHK/kp4k/D1MozN2D04RwVbr86or6Vpt+QrSLKcMYzHCO2wQU22GpSWx4V54A82kCjPwFq9ytLF0lReGrh/L6xfECA4PncaFGxFog1nbAyKc22z8t8h1EwwINIs8rPQI4zIVFNeMYGjrug6c2/chg4blH+58KmCjUS/zawjFdQfpVDIPmDdiuIxHoaEOo80sLNZw1GBKskDFxVdkJN0td6b3msg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39840400004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(6512007)(66476007)(66946007)(66556008)(38100700002)(83380400001)(8676002)(8936002)(4326008)(6486002)(478600001)(36756003)(31686004)(6506007)(6666004)(53546011)(44832011)(5660300002)(86362001)(2616005)(2906002)(26005)(31696002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmVPc2JoSTJPaklKbGVzbzdVd3RQeXZRMDVPaWNuaXJxZXhoWTdtM3UyQUUw?=
 =?utf-8?B?OXNLcGc4YlB5WlVrcG1sWnVMM1E4c25OY0dMR3k0RzVmcjZ3MG5QV0t5K1hH?=
 =?utf-8?B?MnRZL0Fyc1hoM1NIVlNlMHZhOWtHc3NHT0FRLzNzNS90dU5rcDdHbGlNckow?=
 =?utf-8?B?TUVIYWN1NWNXWW9rL09WczR0WUg2V09GZWhoRHc5YVNtaGd3NWxIMEMyRHo3?=
 =?utf-8?B?c0NZVitXOVQzY2hEcUZtcFhEdUFLaWk0RXVDZUdQeDVCdkRTdjk3Y1JSdDJB?=
 =?utf-8?B?WFl0emhNYmQxWjFHZEI5OEtPQWpaRGJDa2xhR0NjejJNQ1VGczRobTd6K0pO?=
 =?utf-8?B?c2J0RzkxMmNTQVFGVHJ5RS8wMjkyQmJMOFhiMmM5WkRBMCtyb3R4YllIdElU?=
 =?utf-8?B?bTR0b29wMFVLV1gxREZoaDliQXJDU0JtOXlLemlFZ3RGMll2d0tOSUpZUVZk?=
 =?utf-8?B?cW53RFh3dW9BLzhxZ0UvTXVYdzBPb24xckJpYVN6RzZoQzRJZWR5a3AzZHE3?=
 =?utf-8?B?NWhiV0l3bTFRQjJGK3RiOWl6NlVaUzVWRjEycmN4bEM1eHFhdzU2djBUc282?=
 =?utf-8?B?UzEyQWtyNVRCYXgzeGo4RWN1SVBVVy95SFE1NHBLMDRGTjJ6cXBkVFY1UUdC?=
 =?utf-8?B?bE8xRFQvVGFFQVJudnozYnQ1eFd2cnRpbmhsRDRUb3M5b1VOek1YTDVBby9w?=
 =?utf-8?B?OHJrekNYMy9uQmQvS1g5OHNidnJUZ095cWhLQzdXQ1hHeHBUT1gwZTFIWjhr?=
 =?utf-8?B?bXRjM1lrTVFIY0FYSTJER3l1amd2c1p5RjhaSzVPS09WbVBUZ284QUk3eGRC?=
 =?utf-8?B?Sk9RQ3E4dkg4Y3JzM20xTGhOOEZ5SzZJTE5zSmdlL2cycnlEdTZXTnM1bmZi?=
 =?utf-8?B?TEFSZGNlUmx4UmRpelZWWmp6TmVxcnh4RXJJTDdCUDcxVmhvNG9QMVI5RTdq?=
 =?utf-8?B?UVo5VEVvWjZhNmg2bkJYYzMwQjdBM2YrcXRQVStQeWN6ZlVUVVdMbkxjd05Y?=
 =?utf-8?B?UmxVdy9jdUVRZklkUnJiaWVSNlltcWVEMkpQM1pDcWdkUlBYaFRnQ0V0aEQx?=
 =?utf-8?B?L0lPZGU1a2pzYzZJSHZ6WVpEMktHZ3RvaEtOR3hzUC9ody9DYWhtZmxVN3Bx?=
 =?utf-8?B?MVpIUG1aK3VrcTZGNEtRT0kwYUxld0pDL0s4OGpkRXRMcGdMaW5scmJydlNm?=
 =?utf-8?B?djAvdDVITmx4L2dCRVYyM09LSmVLclZpeGxHNlo0NUgwNXF2V3RtVnFFUm9R?=
 =?utf-8?B?c0Z6MDRiQUpEdkJjMHdxUE5IR29Vdytmb1Q4RzlzYzFjT3BVNlZJbkJPOUtM?=
 =?utf-8?B?VkRBOFJxQ2NDSG5nY2JMOVdmNUN4dWFnQjliQkhheVRoTTBnaFlmMzJNUFl4?=
 =?utf-8?B?QUlOSWlUelA5allLeTMvVGJJTjUvYXRiOGZrQU5lc3F2TUFYcW93Q0lpWUpU?=
 =?utf-8?B?MW0vaFlsR3lyRmFHU1BROU1waXhGeWdua2RLLzV4bytuQ2NzOFVBYXVJU25u?=
 =?utf-8?B?MDFnQzV5aUJmdkRKcjR1L1ZHczdIbGNieUNCUjZGU1NDcHdzOTJxbTVlZUFj?=
 =?utf-8?B?L25UMkpsdHh5eUhpbzhvKzZYVHpjc2F6bGRMQktZQUFrNzV0QmFQNVVHSDVa?=
 =?utf-8?B?dnhoM2NOZHBpS2p4WTNLVUg2c2R4dXJJQXpHRHNXL3ZmQmUwVmNrQnlVRnNt?=
 =?utf-8?B?ajVFL2FVM2ZKUEkxWENVbzAyai9yMVpzTy9QRlhkNURmQzM1TWJ6OU04VlFr?=
 =?utf-8?B?SnFJWVFjczZCdy9oSndtVWVUajhmNTlQaTQwWUxlc3hvY2NLeXo0NVR5NDcy?=
 =?utf-8?B?Z0l1UHhHZWR2eXJSOU90RWxhQ2NqSXBjd05IZjYrdkJvUUdwWkloeDRXMjNx?=
 =?utf-8?B?emNtUFQxTkZDL0tkSEVhWVdvcG1yQVM0bWtuejc4ajhZYVVhZUdxZm1aUnpz?=
 =?utf-8?B?dk4ySTFSVmU5citVVFdMYmxsU3ExbzFDSmc0Y0l0Z1NZSmtuQjdkTjBHYUFt?=
 =?utf-8?B?MlhQYU1ualdWQlZQcFpqTXJxSGlzYVM1V3kvSlRIMDdkcjd0Mk9wOVdHekZ3?=
 =?utf-8?B?MnlsbXFzbkZTY2ZQaFF0WHZEWUZSM0RuRk1ZeXBHUmE5eFVwaVhrRWUyM0pq?=
 =?utf-8?B?ZHZLenl4dDArKzRaa3FCQ01LMk9nMXhjcEdOYTB2UENTUEVUb3JDRE9wS3or?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af22c467-b816-4b4f-e01d-08dbe42e587f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 09:53:10.8808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9tI+GfFzuPsLXuzxHRsqFmqAcQVuECOgsT1gkx/dtPYW6VM88OE4rGVMz8ZAM5TzyVpJCMukPrUfM7rXWNjxkuG7KFhnLavDgAzPM0UHCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6489
Received-SPF: pass client-ip=2a01:111:f400:fe0d::720;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
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



On 10/30/23 10:09, Denis V. Lunev wrote:
> On 10/30/23 10:06, Denis V. Lunev wrote:
>> On 10/27/23 09:46, Alexander Ivanov wrote:
>>> Add a helper to set unused areas in the used bitmap.
>>>
>>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>>> ---
>>>   block/parallels.c | 17 +++++++++++++++++
>>>   block/parallels.h |  2 ++
>>>   2 files changed, 19 insertions(+)
>>>
>>> diff --git a/block/parallels.c b/block/parallels.c
>>> index e9a8cbe430..a30bb5fe0d 100644
>>> --- a/block/parallels.c
>>> +++ b/block/parallels.c
>>> @@ -195,6 +195,23 @@ int parallels_mark_used(BlockDriverState *bs, 
>>> unsigned long *bitmap,
>>>       return 0;
>>>   }
>>>   +int parallels_mark_unused(BlockDriverState *bs, unsigned long 
>>> *bitmap,
>>> +                          uint32_t bitmap_size, int64_t off, 
>>> uint32_t count)
>>> +{
>>> +    BDRVParallelsState *s = bs->opaque;
>>> +    uint32_t cluster_index = host_cluster_index(s, off);
>>> +    unsigned long next_unused;
>>> +    if (cluster_index + count > bitmap_size) {
>>> +        return -E2BIG;
>>> +    }
>>> +    next_unused = find_next_zero_bit(bitmap, bitmap_size, 
>>> cluster_index);
>>> +    if (next_unused < cluster_index + count) {
>>> +        return -EINVAL;
>>> +    }
>> I would limit the search with 'off + count'.
>> There is no necessity to traverse the bitmap further.
>>
>> Den
> I mean 'cluster_index + off' to avoid the confusion.
>
> Den
Do you mean 'cluster_index + count'?
Should I set the same limit in parallels_mark_used()?

-- 
Best regards,
Alexander Ivanov


