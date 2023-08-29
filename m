Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B7878C53B
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:26:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayjE-0000pa-FY; Tue, 29 Aug 2023 09:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qayjB-0000l9-9t; Tue, 29 Aug 2023 09:25:53 -0400
Received: from mail-db8eur05on20712.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::712]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qayj0-0004iQ-NN; Tue, 29 Aug 2023 09:25:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBWjabGC8vPhkS4nDzIy9VXT/pY0QcjuSQW7wKesQKAlDQEb3YEPJW2pbrv997XQuhdHjCgoATDvNuYYuE+21KSlyd4FjAdBRjU8EwiiQWpRhJBH0RgTtjqTP12DmFQMJYsCEbv08SyCpJEDfOCaGB/5KPB6GcR+LX9FCIViVXPPJJuCyz5d2DCU0Fa7EQ+PTL1WMEGhSm6lm0sxkE0srmw3m+K9G9W5pgWNTLGhr//Rt1Cp4lL6AoABRjDnz/UiRymu/lryu1pdGS5t/niy9RiaOBw0urtiO8pu8D8HEI9xaBfoQVajdeYIx8w7JKWBMp05s8R/4SMg1iRBbXRH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+081xqjiekepCxSG36u43T+pQmRGY4vNaHoC6p6NxA=;
 b=KYPAcWwrlZ9gAfjk6tmZKWw/9rZ9dLhGi+youasY+gwfGLv5vs+WZyPre4vcQredY09FANsa8AeOjGkdJOFhDfgTHoKvmWhQwNwspuAu9p/RcKWcXLo8J4FW0uWGHd1li60l9A7j1qT4KaiGZZKuM+v7k26CgioirDifbHYjJJHgA3vo6zsH/2F3C/egZjWeJ9Rptni/ClSd38Dv9DJJ4r2Pda7h6e8SJeooCcMB3HbTJ8xv4+dncUaUj+GqEmiWal46vhMQGJrg9jJwwxXqiEwLLrXdJLRtbDTWvDJ4MWmfoEBp6U3nJFm5A/zLaNGH7x4M5fM0ogsnJI4EGAuhvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+081xqjiekepCxSG36u43T+pQmRGY4vNaHoC6p6NxA=;
 b=AqVkV+obIMgYP15doXW/Bbv126C7Uvg45M/eVKNxrVfyY0Vo7WBg4cXHvg3tVpaR6iHAveBegZOs3MvoMjdL2NuNxRYTqSlHY1zSbB1wbx+1PICiqQEzyu1lgRdh9nwD7RxMeZaOJHy94kI+XX9qWwI8oFWbHXRO0JokB9NjX7oJvg35HkFtvcO2KRXjWC7hjv1nx+GtczmMK8jROyLN6SJsLu0Vp4T7TXemQmNHJfgtbBOhX62ylbxC2YAJ6U27qmhdfOhZ662fAUXWCo6LUb/B1V5JKsz36s/6qBiuryr8zQBcWRI+bYFqA/BjjicIgQ87bGqQkIfAWwCiG8tnHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by PAVPR08MB9858.eurprd08.prod.outlook.com (2603:10a6:102:300::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 13:25:21 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4b14:4628:9a1c:b28]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4b14:4628:9a1c:b28%5]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 13:25:21 +0000
Message-ID: <c1992b4a-12dc-448e-8bcd-1d180e3e86bb@virtuozzo.com>
Date: Tue, 29 Aug 2023 16:27:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] qemu-img: rebase: avoid unnecessary COW operations
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-5-andrey.drobyshev@virtuozzo.com>
 <9413d571-2334-7cf2-8959-99ccf81afe77@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <9413d571-2334-7cf2-8959-99ccf81afe77@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|PAVPR08MB9858:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3842cf-f196-41de-e4d6-08dba8936508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9B7Z52hHvCSk6vSCRa5bp0CplkIZcPNJp5zyT9JydlCR41PAPrFPCqJWE1Wajqfwpl4QcQBvVRXtwU1zlKUHBBE0Ag+IRl6U3kdwv1E+hAQHNGPHhGSgoQiI2VHv+CCc3HvwdoOqhDOJOGlHWC29zNmZaKmqtUiaamJ5YIpmO0j4IE8CggIMdFppiy2XGlh7T6OWyJENH8jIvQ2JuyIVMU9wCBVFcJClqAzeok3yf5LzZZN/iA7JyX6B/+/ih5qLKIRngYS3YoU8NM1FK+z0aPeBYHHBLhzjyP7VCBiJz4bvkdT3kbPR6tjPZksLzgkbktPMpksu18mhRZfXsars5dN2YuX4VunT80pnsun64J/MjnBD/pohscB5MTiDuOgqoLE5lC4ZysKla2efcbwBebLCwGh+vIbubPprcR+mv2LIHqLV/52qSg9zp3zrlY31dJSjfpNFVILSOh1NT0wyAuLevc2mmPvJfn1Y3Vw81RvXOnrSQqcxKrVeTmtJanmQeCbQloGprBM6rSN3xV3l9+GUAoZ7guAOhVTxVUkKWpn0tWDigo9doGNRtZrgMBj7vJPTwY9dnX/O9fvwj72LULEd6kOiKJtSBMTvbNKbHmnyHZmhl6geDzW3cO9U7qjvKpNKO0gIGvZLqUNnXisjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39840400004)(186009)(451199024)(1800799009)(41300700001)(26005)(107886003)(38100700002)(86362001)(31696002)(478600001)(83380400001)(6512007)(6506007)(6486002)(53546011)(2616005)(66476007)(66556008)(36756003)(2906002)(66946007)(316002)(5660300002)(8676002)(8936002)(4326008)(44832011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmxJT3duc0J5NXRJL1R1UjV2cEdNUUVjNEpua3ZpZ0NLZ2NPbHh4RkJweXF0?=
 =?utf-8?B?aEVZUkRzcFFXeEVLM1pxcVJxY2NMYWIzL2JYSXNOczloYTlhek82QVVRb1Br?=
 =?utf-8?B?ZXVWRHNtWXNlemhRbUU1STM5Q1djQklhb1hKVEx3c0tOb2NmNVd2eEd5TzBq?=
 =?utf-8?B?dW9kU0g2WFpBT3RNTTBJRWtXTmY3VTZPTTBOWDFzM1MrS3RjWXZpeGwyWkZK?=
 =?utf-8?B?RkV0UExNYWtjTFVmR01RTXY4M28xRDJlZjVucUtjN3BQdm4yTStjbUxKL0Fj?=
 =?utf-8?B?OEVLaGNNeHJad3FYWGNCbktheFhlZGJlMW1oSmwwaEUySExoVkQ2MWYvUWhm?=
 =?utf-8?B?ZGRwMVBzYnR2UTlMYWxhSW1FalFkSkpqU0J6bkNwa0Qyd01WUlNwRkpreUhR?=
 =?utf-8?B?V2ExT3lPajNXV3hEeDJFckJ5UlEzUU1EUjlkTXNrV0dWODhGbUtKY2xuTjdp?=
 =?utf-8?B?SlZldDMrY2ozY3ZEK25MK1h1M3A2anh1V09INXo4cU4vb21ZVjNBM2tTQ1Vi?=
 =?utf-8?B?U3hIUy9pR2pxQ1hJaFVOMnFxNXViU054ZGhHUklMVmhWSWdTTlpvcDhuNm92?=
 =?utf-8?B?aFdGOVBCN1FyS1BjZGlBQXNTZlB0UC8wVjRCMVZESFlKYXJRZ3czbGw2Mjdv?=
 =?utf-8?B?MjNUVlRDSG1CUDIxeW9vd3ExTWlIZVV2U1FNU0RLSUs5UjlHc0U2OWY1d2hr?=
 =?utf-8?B?cmF3Y0drQ0F0c21KTjZvSmtDN2hkUHR3MzZjU0gxanpZaDZVSmMwOFNLck5j?=
 =?utf-8?B?TGRRNGVMSDZIbU1JOFlaWkRuT2NKNlhVbEFuK0xXSWUwd1hSNk01MC9aV1NN?=
 =?utf-8?B?YkdsS21QSEN6QWZtTEd5WjZabWhZdU9MUkRZRG82elVTUVVxVUIzc0hSb3I1?=
 =?utf-8?B?UDJGMkw3ZUN2ZUNzZXRNbXd1dHBYZG03cGhJWHNNT1kyekdKRWdUdllackt3?=
 =?utf-8?B?bnJlY0NUOEpNbERnU0MrWDhsek5BVFg2NG9YUEdGc0g0b3ZST3V1R0hJT0Ux?=
 =?utf-8?B?c1UyVFVHL2FLMEpoR2lVYXpaUW1KZ1dCSk55SzFCNjBGRG1Wa08xakV1WnJr?=
 =?utf-8?B?ZlFZY3Qyb0ZwZCtzdDZIcU9EZDEyU1JzelF2eHBSQkI4UVpDdENhNjNvb0tB?=
 =?utf-8?B?RWpmRTlvdGpPeTd3VGxkQUVoTWVzaEZ0Wi9RRGw2VXMwODYwVGVzM2pkQmps?=
 =?utf-8?B?Zm1aMmdNZWlseHJNSko2djNTWENnYVY0aFp1R3VBUXU4bjdUcWtEV0p5cWF2?=
 =?utf-8?B?aDZYZXNWSDFiUHV1MU4zeGtTUzBSL3gyY2ZJVDZXV3J3czRjc3R3MlBoa0lD?=
 =?utf-8?B?bENET3U5SFd4a00zZWxPd1BuM1RHeG5EZWwrTldybmJoUkZNN1lZcmp4OG42?=
 =?utf-8?B?VUFEbGVKdmh3Q1VGbnM2UXd2RkVIT2NwNnEzWXJraHVZanllWFBqU2pVZERM?=
 =?utf-8?B?NHFMMSswcHQ3WEZmekwyRTFGcDVlTEw3MStxWGMyaE9POFRhZXRaSWQvZ2J1?=
 =?utf-8?B?N2Rob2wxM3RqcEJlUEVPc0NyV1hIbFdYa0svejZ4OHM4SFJGZ1R3UE5NeWF6?=
 =?utf-8?B?SzcvdmRRTVc0OWhjRVJYUGpVM1REZnNMNVl2Qk9HZzFuWHNVZStCemdhSXlO?=
 =?utf-8?B?eGREalV1eHQyZTNnWW9MZ2YrVHRza3NXdWR5bFpGaHdFV1hyL3JEcFVZOXEx?=
 =?utf-8?B?WUVwOEVsWlMvQ0ZycGpiQ3p0dkhsVWV3QWxsWnFzQkN5K0NrL2crZ0hUK1Bz?=
 =?utf-8?B?dGVDZkV4YXY5UXcxaGxRY2VnRmw3bzFpdU00NUc1ZDFERVhHTWtxeEFTOTlZ?=
 =?utf-8?B?MTVUYzN4blBRYS9Na1NzcUJkWkVjVUROdytKcjg1cVh6bTlKL2ltQWlsL1pZ?=
 =?utf-8?B?SVU3aHNKcndDaWlydXJlRnZWWDJrUHNFOTZPeFRBQU5yMHp1bmdVdTdMdEgz?=
 =?utf-8?B?anFPd25PTCtVd1JTU0RTS1U0QjVqTHdldDE1RHBWVWRyaE85MzMxSGVBczgy?=
 =?utf-8?B?K3pQbTFNLzQ1VGJ3N3dETS93RlM5KytvRmxBVHNNajNYTTdnSjZWTC9uR0lT?=
 =?utf-8?B?T1NtVlBURlFKaFNDUXZBRlZRT3NYWkJGamp2YmUrQ3REczNsOWxGRkVLTndQ?=
 =?utf-8?B?V1I0azNpUy80eWVncjJFM3F0OGh1d3dqZndyRzNzZ2NEZm9DVFcrZGNPYVdY?=
 =?utf-8?Q?VX6e+140qetn9YLVvXfJSD8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3842cf-f196-41de-e4d6-08dba8936508
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 13:25:21.2950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BWNg48KQa8j2ah6UzVPrDXXDg8GbLueJ98tNo6sofUzu4LkGwMc+YTwRtU02SLL3U4BUDIjXRZfOTt9BqOPIn3V/YZKbV/bj9xn64tJO9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9858
Received-SPF: pass client-ip=2a01:111:f400:7e1a::712;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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

On 8/25/23 18:00, Hanna Czenczek wrote:
> On 01.06.23 21:28, Andrey Drobyshev via wrote:
>> When rebasing an image from one backing file to another, we need to
>> compare data from old and new backings.  If the diff between that data
>> happens to be unaligned to the target cluster size, we might end up
>> doing partial writes, which would lead to copy-on-write and additional
>> IO.
>>
>> Consider the following simple case (virtual_size == cluster_size == 64K):
>>
>> base <-- inc1 <-- inc2
>>
>> qemu-io -c "write -P 0xaa 0 32K" base.qcow2
>> qemu-io -c "write -P 0xcc 32K 32K" base.qcow2
>> qemu-io -c "write -P 0xbb 0 32K" inc1.qcow2
>> qemu-io -c "write -P 0xcc 32K 32K" inc1.qcow2
>> qemu-img rebase -f qcow2 -b base.qcow2 -F qcow2 inc2.qcow2
>>
>> While doing rebase, we'll write a half of the cluster to inc2, and block
>> layer will have to read the 2nd half of the same cluster from the base
>> image
>> inc1 while doing this write operation, although the whole cluster is
>> already
>> read earlier to perform data comparison.
>>
>> In order to avoid these unnecessary IO cycles, let's make sure every
>> write request is aligned to the overlay cluster size.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   qemu-img.c | 72 +++++++++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 52 insertions(+), 20 deletions(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 60f4c06487..9a469cd609 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>>>> [...]
>>>>               }
>>   +            /* At this point n must be aligned to the target
>> cluster size. */
>> +            if (offset + n < size) {
>> +                assert(n % bdi.cluster_size == 0);
> 
> This is not correct.  First, bdrv_is_allocated_above() operates not on
> the top image, but on images in the backing chain, which may have
> different cluster sizes and so may lead to `n`s that are not aligned to
> the top image’s cluster size:
> 
> $ ./qemu-img create -f qcow2 base.qcow2 64M
> $ ./qemu-img create -f qcow2 -b base.qcow2 -F qcow2 mid.qcow2 64M
> $ ./qemu-img create -f qcow2 -o cluster_size=2M -b mid.qcow2 -F qcow2
> top.qcow2 64M
> $ ./qemu-io -c 'write 64k 64k' mid.qcow2
> $ ./qemu-img rebase -b base.qcow2 top.qcow2
> qemu-img: ../qemu-img.c:3845: img_rebase: Assertion `n %
> bdi.cluster_size == 0' failed.
> [1]    636690 IOT instruction (core dumped)  ./qemu-img rebase -b
> base.qcow2 top.qcow2
> 
> Second, and this is a more theoretical thing, it would also be broken
> for images with cluster sizes greater than IO_BUF_SIZE.  Now,
> IO_BUF_SIZE is 2 MB, which happens to be precisely the maximum cluster
> size we support for qcow2, and for vmdk we always create images with 64
> kB clusters (I believe), but the vmdk code seems happy to open
> pre-existing images with cluster sizes up to 512 MB. Still, even for
> qcow2, we could easily increase the limit from 2 MB at any point, and
> there is no explicit correlation why IO_BUF_SIZE happens to be exactly
> what the current maximum cluster size for qcow2 is.  One way to get
> around this would be to use MAX(IO_BUF_SIZE, bdi.cluster_size) for the
> buffer size, which would give such an explicit correlation.
> 

I'm not sure whether blunt allocation of buffers up to 512M is the right
thing to do.  Since we need our buffers to be equal in size, we'd have
to take MAX(old backing cluster size, new backing cluster size, target
cluster size).  As for potential increase of qcow2 cluster size, I'd
simply increase IO_BUF_SIZE accordingly once it happens.

Overall, your first point is enough to drop simply drop that assert.

However, your remark gave me another idea that there's actually the 3rd
case when it gets broken, and that is images with subclusters, since in
this case bdrv_is_allocated_above() will align n to the subcluster size.
 While looking into what exactly qcow2_co_block_status() reports I
realized that my patch breaks the following:

> qemu-img create -f qcow2 -o cluster_size=1M base.qcow2 1M
> qemu-img create -f qcow2 -b base.qcow2 -F qcow2 -o cluster_size=1M,extended_l2=on inc1.qcow2 1M
> qemu-img create -f qcow2 -b inc1.qcow2 -F qcow2 -o cluster_size=1M inc2.qcow2 1M
> qemu-io -c 'write -P 0xaa 0 32K' -c 'write -P 0xbb 64K 32K' inc1.qcow2
> qemu-img rebase -b base.qcow2 -F qcow2 inc2.qcow2
> qemu-io -c "read -P 0xaa 0 32K" -c "read -P 0xbb 64K 32K" inc2.qcow2
>> read 32768/32768 bytes at offset 0
> 32 KiB, 1 ops; 00.00 sec (78.511 MiB/sec and 2512.3671 ops/sec)
> Pattern verification failed at offset 65536, 32768 bytes
> read 32768/32768 bytes at offset 65536
> 32 KiB, 1 ops; 00.00 sec (490.381 MiB/sec and 15692.1822 ops/sec)

That happens because n_old is bounded by n and we read not too small
data chunk (1st subcluster only).  Since we end up writing whole
clusters to the target anyway, the solution would probably be rounding n
up to the cluster size right after the call to bdrv_is_allocated_above():

>             if (prefix_chain_bs) {
>                 uint64_t bytes = n;
>             ...
>             }
> 
>             n = MIN(QEMU_ALIGN_UP(n, bdi.cluster_size), size - offset);
>
Now, if the target also has subclusters, we might end up allocating more
disk space than necessary (i.e. writing whole cluster instead of several
separate subclusters).  I'm not sure whether we should consider this as
well (aligning n to subcluster size?) or leave it as is keeping in mind
the trade-off between disk space and IO ops.

In any case I'll add the above scenario to the tests.

>
> [...]
>>> +                         */
>> +                        start = QEMU_ALIGN_DOWN(offset + written,
>> +                                                bdi.cluster_size);
> 
> Please add an assertion here that `start >= offset`.  I would rather
> have qemu-img crash than to write out-of-bounds memory data to disk.
> 
> I understand the idea is that this is given anyway because `offset`
> starts at 0 and we always check that `n`, by which we increment
> `offset`, is aligned, but it is absolutely critical that we don’t do an
> out-of-bounds access, so I feel an explicit assertion here is warranted.
> 
>> +                        end = QEMU_ALIGN_UP(offset + written + pnum,
>> +                                            bdi.cluster_size);
> 
> Similarly here, please assert that `end - offset` this does not exceed
> the buffer’s bounds.  I know the reasoning is the same, we ensured that
> `n` is aligned, so we can always safely align up `written + pnum`, but
> still.
> 

Agreed. Smth like:

>                          end = QEMU_ALIGN_UP(offset + written + pnum,
>                                              bdi.cluster_size);
>                          end = end > size ? size : end;
> +                        assert(offset <= start && start < end &&
> +                               end <= offset + IO_BUF_SIZE);
>                          ret = blk_pwrite(blk, start, end - start,
>                                           buf_old + (start - offset),
>                                           write_flags);





