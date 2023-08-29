Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC6978BEA1
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 08:43:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qasQp-0003iV-1D; Tue, 29 Aug 2023 02:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qasQd-0003he-SC; Tue, 29 Aug 2023 02:42:19 -0400
Received: from mail-am6eur05on2072d.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::72d]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qasQa-0004t5-VF; Tue, 29 Aug 2023 02:42:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvUNmJoH/gX9L7NUllzkWp6LMwz6L78BF5NmuYA/FPFOEuQF3/EIp4R7QEqL7oBbV8zLcvqAfgdUDOwNX3GtBtI9VaUK2nfnayn6ViELuW9V5LewZHnqKJI2Tn7jR666u1pH9THtuA0TCBff/B3aO+QlzERD6X1SASr9vzijLPKFGk17z5GkF5lX8vXVLDX+qpNjVLtK3dUoLxM4kbvm3NcLXgU8odEI+x1KBlvmlZt3YLau93wEBZY7wNqsusIRHSvlVzSDRAVAQF1mhZxOoAlhC05y8bTCFQqMRGM7itvOrsaipYf+z9RJZk/o0zpvXHwnl6RkHXGsJqbS/fhe9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WMsq2zZkJWjleU/9ollr/Ghfq508PO1l0IYjmWI8IY=;
 b=NwPv1KyYdz+Ke9k6AW+W4LaDLARL45KJmweBBIn4bv21XRP9u8hZZoPN7AHeNyn63ht9KufHlkyKwX5kUZWi0WUFcd2O1grnEjFa1BSngTggxoYL1hZj4e14244MYt3hqbR/55YVY+WZjN0NPQMXh97uI/17imi3DR6r2vOKdZ6vzIhT1MWDvYKoRExf9jDD5Z6SpO0yIu6ccKMom46UIbcxcKbYkXGHhK7HugJzgdq+JyNFvCgYastjuaNyhS3iVBlTtxeqAigHG0XTxnzEoE28LiMk9SV10serNrR5lS9z6ET7q6j7ve4LNcu1IGn9XObuOXzyXET3KiYNZCaPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WMsq2zZkJWjleU/9ollr/Ghfq508PO1l0IYjmWI8IY=;
 b=zQVkVi9eQu6gSjdvmTVKbwtluiiBKlaB9RQlpYIlznRE9rLg42V76mQqOZYjniPtYWr2HSanQB1+eFYvGr7sKgTTvjBd3JRNXc+2iwbdQJBLMeUzy6Vcp9OPY32tSzZTuEW1rwBp+XAjJT3R/uckKf0ekOuiOgDgWhwqB6phdIesKe0yEFGD3A/nEsu10wb7VQUSx7ip4/IXpeNNpLQTRM976TIOYaIvBVVMuYASsH+z4SEU842OkVBJxTvTf7enTxf9mUF3yxxy6k3pFIkkV9E9tclL8ynKa+VSZ1uKLRLQ2D6+oSguoiKC5WkGy01DiFXlHA1nJFtl5FNlykn5+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by DB8PR08MB5433.eurprd08.prod.outlook.com (2603:10a6:10:118::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Tue, 29 Aug
 2023 06:42:11 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4b14:4628:9a1c:b28]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4b14:4628:9a1c:b28%5]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 06:42:11 +0000
Message-ID: <dd69ae0d-63e9-490e-ac59-4345841a78e5@virtuozzo.com>
Date: Tue, 29 Aug 2023 09:44:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] qemu-img: map: report compressed data blocks
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 eblake@redhat.com, vsementsov@yandex-team.ru, den@virtuozzo.com
References: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
 <20230706163047.128999-3-andrey.drobyshev@virtuozzo.com>
 <ada340d8-8ac1-9817-6d58-0da60a601637@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ada340d8-8ac1-9817-6d58-0da60a601637@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::7) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|DB8PR08MB5433:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c9bea9-2d40-47cc-965e-08dba85b12d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtJTIGkS2g5kDntp59SZjuF7SYQD70NVnZtYRY8VhbpWwUOxg8QnftOhQvQGPVT0XYUP75lg3BB79UQ4ilaP3vUELWCxpKxgI5MgKOxA/TBbMKNpGWxoZbcwqKNg/Dnj7R9ejcRPKuo5oTpJN+HpnUYb43Of3ci5S44qb7oBIqFvA49i6VEijYmyTkNQvt7/zA5573Bs9tr175h6qVe6BMD3gsaPX01OBEhOZ9sNjaNmX7dMjJLNaLKLHmHoAJRSGqmgfCKVGcxbf4NWaDB1+jtuXxdaXuJ1lGfmKf6o0cTP+8ll/pMcc8ExVk/TP9Joa9UB9qhopxf8ecvj7OiDMfjz1Y+DxaXEfiOkLKJK5mrNzqC1Maw1uFFCyOgx2/DHQL3TzSkmxsQFpF3DLt+nw60T8u4Up8739gyIvR+ssNbdkBDNPH1UsfGU+haVYPeeWNqKoP0BJkybI0u1G6bBM/8WmBAzgJFgq/rj8qg/SbCQ2JepdQrbpa14fc+0MkYSWCK7nxNk+UfyXez/+scr3XCKuF6yK5zQ1Qdvc+rEqv6oF2kZMoblR3t0rpvTL43UrJ/W4s1kvGUQtl3HSXNxRPUb5nKWnGwGOFcLqAgfrV4wWgR7vQgQn9yqG67Jq3F0AoB98AIoHm4m5MRFiDG0fA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39850400004)(451199024)(1800799009)(186009)(38100700002)(2906002)(83380400001)(86362001)(31696002)(36756003)(66476007)(66556008)(44832011)(31686004)(53546011)(6486002)(8676002)(8936002)(6506007)(66946007)(316002)(6512007)(107886003)(5660300002)(4326008)(41300700001)(2616005)(26005)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlppbzlUQnIwTG1KQ0lWME55eXY3V2IwOGtnbFFvWU10dS9nejhXTnBnbG1B?=
 =?utf-8?B?dTJ3VFBBeVVkNWxwYnY3NHQ0RnVSQlpEVEo3QWVlZW5IQWhIeGdqczVJYzIy?=
 =?utf-8?B?L21IWGZ4L2ZCcnUxOWNvQzFnUVQwdzc0dDhRMnNsODIwT2dyL0hDaDVqUVhv?=
 =?utf-8?B?NURuWEplMU9LNHpXUzRxVjl1MU4rRXA0MUpORllyREpCWHpER0gxTmt2dS9O?=
 =?utf-8?B?Zmg2TnF0Q3VwWUY5anhMdUJpS0IxbFNsMG9FbnA1eG4zZlRneVVET3hVcjVJ?=
 =?utf-8?B?UitrY0llWktOWXFIVzg2eHB3bG5BaDBid1J0MnBYYTV1dzdSZlVhcnZSckc5?=
 =?utf-8?B?Sm1CT3JHaVROVlRGcUNZbE5JTkZ5Yy9mYlUwREswd3d6cDc1YkhTaFB2RWZ1?=
 =?utf-8?B?SGo4ZnI5cS94amR5TFMzMWRhbGZ5L2EvZmplMFB4QlhLcU5RcVM1R2RlRitB?=
 =?utf-8?B?aFlyLzVYWWZadmxyMFkvUmVIZkg4SDlVNXZTZ0lQVU1HTW5EY0lvZ3JGc0tZ?=
 =?utf-8?B?Q2VNZ1BQYWhnOFBQWmVndTQ2akxPYUxGYmNSWWJKS0EwU1hHVzU3eXNCNzJF?=
 =?utf-8?B?T0s3MUJGTWszdzFkVXFodnhlNFhqRis0SlhiMkVMZnpJK3RHZkJ5WjJVa25j?=
 =?utf-8?B?VUtNZVVPSHRCRUZlbFNNVGVYbm04NzNQU0VCK0hhc3J0K2ZZclBWbFFDTUNY?=
 =?utf-8?B?NzIxYzhjU1ljVVlvcFJROFo0aGszOFBWeGdxdmJMNVoyWUlCQnhTWU5sVXE3?=
 =?utf-8?B?Z3VEQTNYVEZCazRCL09kS2FvWDgzN3JnSGx5TG10S0RTd1JERmxyYTlqKzhV?=
 =?utf-8?B?US8vT1hwK0ZZOVRHV29UZWxGSlRnWUhmZjBPcVdWUUwza0p3OXY4SEhYNWxC?=
 =?utf-8?B?c3lwUStlUFJWdWk4WXNiNUxWK3V2c2JEMlhHcWw0VkNSeGJBNzFKajBUSFIv?=
 =?utf-8?B?dGt6YWtKUFQ5ZXAxZ3VsaFJTQWI4V2pXeURBNmZKZTZSaVBuRlRHMzlQNytZ?=
 =?utf-8?B?Zmh4YklOTkxQU3VZdHZxczZpYmhOM08rTHZoSGF6Q1ROOEZqU0hFY292OWQx?=
 =?utf-8?B?ck1CZ3h3TWJNTlptSG55clpNTTk0b1F2bXNyMzdnNnltZjdaNlVLTm5YaWlU?=
 =?utf-8?B?STN1cEt3V0h5T0lKTVVjbkFJSDhFcURRQ1d2WnVxK1FydjdmSG9TdUVuWFl3?=
 =?utf-8?B?RHdiUVBSVS9LSm0vK0JGODh1bDFjbjhJdk4xV1gvTmxMRmdadCtvNVRLWVdG?=
 =?utf-8?B?Z2k0Z1ZmT1FVUFR3MDRma2FCREdwc0V1SFdXN0xrbGt1dXYyRDQrYmRpQkZz?=
 =?utf-8?B?Tjl5eWlteVYrNWZZRGdENFF0QW5TV0hLNVB6S3ROQ1N1ZGZQTk9OOWhHenYr?=
 =?utf-8?B?cEFSOGZpZWdLR0lZSm9lNjRSUGJoTjBDNmhqOGZRWlVBV0h1eEZYM2NteWdD?=
 =?utf-8?B?MWFCdWpLRFl4ekcyTWptbEM5Vlp6WHJxVHdEZkNkRk9vVkVoOTdzUWt6a3Rs?=
 =?utf-8?B?QlBuZDZUcWh2SUp4UmswTUNUVTFqQ21tWDI1V212NmRCUVBBQUswbE94KzBE?=
 =?utf-8?B?RXJ0K01nMk8vWXM5OUg4ZDRpVXp2R3ZLOHdqdk50OXFZcU84SHJYTXR2T2k1?=
 =?utf-8?B?T001ME4yTi9IVFJoQjQxUEM0M1JNM25KMUQ5aWpDeUI1L3NYVVplS2FYNjJG?=
 =?utf-8?B?UUlEcFJzc1JnMGVpbzljZFRHZzVBRnRDWVo3ZkRqQlJCOUVtb1NycEp1bUl3?=
 =?utf-8?B?TDhzOFl1V0VYWXB0UzZrcmRrcndSNTZib0ptREJNS2N3b1p6WSswbkNjdXNw?=
 =?utf-8?B?QXkwSE81VGtxOXl2d29MSGFjL1RsVlIzcHRGbzJ3UGpWMllwcVFJZ3E5MFRj?=
 =?utf-8?B?OFI4Z3VWc2ppRy83RUJWeHI3WHZqNEJTWFIvWXN4djdTOUYxUzEvTHdCeGll?=
 =?utf-8?B?SlQzY1hiZ2VQSFhCdWFuZEFuTnBQUGJhcHhBZnNFdUMydzdtMC9oQ1JkRU1j?=
 =?utf-8?B?blVCTVQ4MHRvSlRCYU5KZzJnUTMvNEhaZjEraTArRnJlYkJWaTNhSDFVU3Bi?=
 =?utf-8?B?R1pwUkpGbXV1RmVDSkxJSFFOejJIY3FOM0d1b1BEOHFWK1JKK3VQV1B2RjhS?=
 =?utf-8?B?T1RKQlcraTRMSjlXV3lSa1hWS0RpUktxUWN2UEQveVlsZHFBbjFBZjRmWENv?=
 =?utf-8?Q?X2SF3rAaFu3grx1h+bbDYsQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c9bea9-2d40-47cc-965e-08dba85b12d8
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 06:42:11.6245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIHnQMM0yfrWOwYNk+n9YLA1rT0oihyA3wUjKGar0621fvnTtYQoGUqRMrVugD8B7a92wUU9Xy2WPbTcOpKC0UKQ1VM8sVNrFzxOV3ur6UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5433
Received-SPF: pass client-ip=2a01:111:f400:7e1b::72d;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 8/25/23 17:14, Hanna Czenczek wrote:
> On 06.07.23 18:30, Andrey Drobyshev wrote:
>> Right now "qemu-img map" reports compressed blocks as containing data
>> but having no host offset.  This is not very informative.  Instead,
>> let's add another boolean field named "compressed" in case JSON output
>> mode is specified.  This is achieved by utilizing new allocation status
>> flag BDRV_BLOCK_COMPRESSED for bdrv_block_status().
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   qapi/block-core.json |  7 +++++--
>>   qemu-img.c           | 16 +++++++++++++---
>>   2 files changed, 18 insertions(+), 5 deletions(-)
> 
> Patch 3 must be merged into this patch.  Every test must pass on every
> commit so we don’t break bisecting.

Agreed, should've figured that myself.

> 
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 5dd5f7e4b0..b263d2cd30 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -409,6 +409,9 @@
>>   #
>>   # @zero: whether the virtual blocks read as zeroes
>>   #
>> +# @compressed: true indicates that data is stored compressed.  Optional,
>> +#     only valid for the formats whith support compression
> 
> This is missing information for when this field was introduced (i.e. a
> “(since 8.2)”).

Noted.

> 
> I also wonder why this field is optional.  We have compression
> information even for formats that don’t support compression,
> specifically, nothing is compressed.  I would just make this field
> mandatory and print it always.  (A technical reason to do so is that
> this patch uses block_driver_can_compress() to figure out whether there
> is compression support; but that function only tells whether the driver
> can write compressed data.  Even if it cannot do that, the format may
> still support compression, and the driver may be able to read compressed
> data, just not write it.)
> 

I figured that for the formats which surely can't support compression,
such as "raw", this information would simply be redundant.  AFAICT right
now the only drivers which can read compressed data are exactly the ones
which can write it: vmdk, qcow and qcow2.  But if we assume that this
might change, and that we'd better show the field value no matter what
(as we do with "zero" field) -- I'm OK with it.


