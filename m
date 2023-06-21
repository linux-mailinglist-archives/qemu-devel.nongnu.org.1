Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9F738F45
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:55:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2xg-0004g4-Vu; Wed, 21 Jun 2023 14:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC2xQ-0004f5-Nt; Wed, 21 Jun 2023 14:53:33 -0400
Received: from mail-vi1eur05on2070c.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::70c]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC2xG-0007zI-OD; Wed, 21 Jun 2023 14:53:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtsLLKkW2eEtPoWGgNrh8rhT32cnK5f2c5uRXrGVcTe/9KQ+O6L32x9ScLzRSxEjwoaAFyvr9nhHKW/bMX0GJPf12V9xKVR0aS1kCxGLIRyzpL4zPAVJKkAGfQJthJGg2Z2t2gPPc3d4EJt7nt2g1ElpXnLfRrKbBh2M2RadY5vNS22gjbXfy3qgfMs7qCarLBBaqkID9QiPiOfm1gIiBvWPicnXHe4bRmmbkc95OqM4ltYpADt8zrO0hMR9YFa//UeH6d6x2TK1sCgBoMMTERLOxNkslc3/NJs1siWMo1q+LBl4paopFwyumMzqFbqMo39tzUxYuMVaBSlwRQZ91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ao4s0dxDlXa6xwHPtMQm23WanuqWQCQhA64hO4W3ohM=;
 b=Tzxe7dAQNJReQ8esyz8HFfrRhqF3Zw7XQzj/6FtUWdxts6Y56fYh2FUwSV19L1kLT8UYRqW61oTsgDqUGM+17+jXrN10xvSWLgxVTgTX/3n7Lze2ss3p9mp9Vuvj9KonODbKpwQcNfGseuvVPYohhscLQvenWkv/r/W+DxuNq5JT5Xn2JT7FTM3+Ry8Akc07cV1GYE5MHb+CNfWJj3bvfcwSagkU2IcTRdTq5tqYWZwcQzvJmLo2tdNlXsImWdt1YUWaf/E7A5O4R6RoWzQ4VHTiESdhDXBO7WBa30BMeNH5a+irPt6pt4W2j0L4Aneahs33hSAEFIfP+HbNhWOJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ao4s0dxDlXa6xwHPtMQm23WanuqWQCQhA64hO4W3ohM=;
 b=u9CaYyhNTVubQ6eAO4ixtyrhledIKRxwo9BTGFHJDE4S5ZVW5+onxKKgiQh3VeTOymO+YYG++2L4IklRNWgfj9fK01RyzzbOJu9COG6P6PEK8YFHS/cwJ6OEOQBMtSaSc+eeIVHRDlJ0qhE+RTfMX4p4pPQZD6pPtDTxMBlPSvrxG8hRRdlq4N7stfkPaCCX8R9I/FyckceksrRZfgag/ynQBJBW7eCailKYScR0qjsT+rdQ4sHTwrVNQu9DR0lAVe/VZv9b59rzfoTNx4R/sPCj+0jW0bLRkkDUdoX+J9EKQe0ZPCP8rrZuI4jRCe7SG1aIXff8AkTFbstj5ZS+eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB6946.eurprd08.prod.outlook.com (2603:10a6:20b:345::17)
 by PAXPR08MB7575.eurprd08.prod.outlook.com (2603:10a6:102:23d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 18:53:14 +0000
Received: from AS8PR08MB6946.eurprd08.prod.outlook.com
 ([fe80::1e80:70d8:d23c:9b65]) by AS8PR08MB6946.eurprd08.prod.outlook.com
 ([fe80::1e80:70d8:d23c:9b65%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 18:53:14 +0000
Message-ID: <12f69ba7-efab-607e-6be7-5e4a5f4538f4@virtuozzo.com>
Date: Wed, 21 Jun 2023 20:53:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/6] qemu-img: rebase: avoid unnecessary COW operations
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-5-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230601192836.598602-5-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To AS8PR08MB6946.eurprd08.prod.outlook.com
 (2603:10a6:20b:345::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB6946:EE_|PAXPR08MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: d4cdf0c6-aa8a-447a-d064-08db7288c460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvZiuHN3DWemrt+EIQ4LVNg0D2ocUaIfRl58N4o4gPKVeqx6pIhoVqzLjzrjmUMbpW75xIif1pvqAoK66ikbbUDYMmYfHtvopPik/wKmSI6RvqOWmzG3+PA48A7vbt+KUj+fB7N81ekwYwd1Bw0eX5HjoyulLtow0tGF4eR1hwLYwLCCbsZokedLAA6SdxttKu1SM9wFHSAHD6WzZo2oKANQt28LPN+guRl5qVsqP0H/ix0SK+eZiuJCXViEx9xnODnSULL7NGf0HMCObPH7Xw4lGNrIbJbFaX0X7x4EtaTocvIUviS2WAk6W7gv2IXPw3+dovj/ueDEgWlvJ7xEzNPl8F4uQIhZFy5vMa7zPthd+ggtOruoxOCARsSWPQBTz3vfwC510fBqZld6qQEgr7yJ/Htgdgg+4i1V1K8f/ztHzrM5rvxS9IZJOzgRK+vgrQbUplwMDMoWqWCSh6EWB/1ultWXlC4gU4wV7rduA3+HrpC/kv97tNDpuRveL6J6TOv98KjFWZNO0SU5LrE64csd8ZwEtsLwPBm6EUf+QFMIQxCtr3eq+KSYm/rXbPNxSQA8OqUE0HVaBo0Bty29cnRB6r/CXiLYvFLi1IHErNGP2COsVMZNu25Ia1ReyCawidxtvGvOghEGx+DgL5VpRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB6946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39850400004)(346002)(396003)(136003)(376002)(451199021)(66946007)(66476007)(66556008)(186003)(6512007)(2616005)(38100700002)(53546011)(31696002)(6506007)(26005)(83380400001)(86362001)(478600001)(6666004)(36756003)(6486002)(316002)(2906002)(8936002)(8676002)(5660300002)(31686004)(4326008)(66899021)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am1pKy9HWWVhR1R6OWlkRU9pVGFjbVQ5THlqS3NOZnhudzVZRWk5OHRWalV2?=
 =?utf-8?B?MGwzRVFHenVLY2pabXNtbjFvWHVGakVMQlluRk1lWUpVNWJJczZFQXhnd3Yy?=
 =?utf-8?B?WWlvSldVdWs1V09jOGZqTzBwVVpXSnYxUXZ4OUh2TCtlTUpnY1BnU25vcVJ5?=
 =?utf-8?B?Z3ZwVWRwQmJyQnRsK1ZCNTRoUnpIK1FxZTFDQVgrQnFQWnBHaENLZXFiSmJj?=
 =?utf-8?B?U3huN280bENsYXRvT1ZFRERhcWRFWG1RUHZQanNEbytoVWFBeUZicGlQdlZy?=
 =?utf-8?B?OTZqcVBrWVp6b3BuTHM5QytQSFRSWnZtalJTS3ZyRHhFaS9ENk4rZjNzbGxY?=
 =?utf-8?B?My9VWWlJTlZHUkRHdnBrMnBxM0dUN0Rzd0JGeVFLWGR1eUVNSHVXOTlyZ3Fl?=
 =?utf-8?B?NjBPYmkrZXFQZk1aT3VlOHdWQWdEaTIrNm9uNldFVkxPL3hEbHB6TXRVWTB2?=
 =?utf-8?B?OVRuTDU2WXpTVjl3Z0xmK3lzNXV1SytLTzJUY1lSdDZjdThudlZZSlNoMHpo?=
 =?utf-8?B?WVdDTHErL0s3R0tmRHFoZW01eFpLZGRqbm13dEZ2NVVyS05OcllIS2tRdlBp?=
 =?utf-8?B?VmVaV011WXhEU0lJcmdyZEU0b0F4dXJ6L2pkWkR6Qm5oU1RXN0ZNNXUvSysy?=
 =?utf-8?B?WUJITVBGWVFtb2l1TXBBajBCcVUxNGpzc2lHMCtjbEVDdURZNmljeTdOVUpV?=
 =?utf-8?B?Z2l5dXZyRjBveURieTJOcUlxYVJKNjV6ZjljTFFyVVJxVWxRWnBiaXNzSHUx?=
 =?utf-8?B?UkNmbDIxYjlrVkdxTGo2SSs4OGhaZU5TRWFIbVdtZFdxYWFkUUo4bW5hL2xx?=
 =?utf-8?B?WXRsQWRObElPUlY3VjFOZVhmalNUTlpIN01WSTc0YmZKWit6NDREUGVMNHor?=
 =?utf-8?B?eGFrelJtNFRwanpYelVRRTl4YVpySStaS0gvcnJZVkZTMTBKdjA0Qk5vR0dG?=
 =?utf-8?B?RUsydFhIN0dxYXNNQ3dBREZRYVkyemhJT2RxOFhpdVRDbzgxYWFXaUZCTEFo?=
 =?utf-8?B?dzFnZ3lEQytOWGM4bHhud2c4NlduV2hSVFk0RHRhOWZMSWwwdDdSUXJXZktk?=
 =?utf-8?B?M2ZLc1FPYktHVWtiSjYwTDJsaXFvTVBYTE5WSENTcE9weGpXbXkvQTdCSTND?=
 =?utf-8?B?TDVBNnliZEJORURvK21mK0NKb2VzWnZSOHJ4UGRaS3IxdnFkTGpGWVR0aVVr?=
 =?utf-8?B?QkxuaFRybUFQMHl3QUJkM0FITk1Fa0VwZ1oxRWRYMGJDZ2kzdDhJazA4MjFh?=
 =?utf-8?B?WFNORk9GN1lRNml5bDcwaklrUUo3VXlMQzV0cTNwMm91b01qREM1MFU2ZE96?=
 =?utf-8?B?OWVWekxxK3JZNHlETHF5SFZoU1RrZWt5WE4xaDFabFNWVTJ1dHlIdmV0RHVP?=
 =?utf-8?B?NkNZNU5DbmYrTTAraks5b1BOUFRZSzh3SHBpemg1RHdHV25jZUpDaHpobHIw?=
 =?utf-8?B?cFU2SDVIbGEySnpoc0l2Y1dXZThmRVRmNkJQSjlBcWRkYVVDbHo4MEdNbjNr?=
 =?utf-8?B?Z2NtR2NBMXRoU3hVTlhrenV6V1o2N3FKVGhJZGdTQW1hSGpXdmZtYTN0VFdl?=
 =?utf-8?B?cUQ5cyt4aVZPbEswaDZkbHBCSUJYMWtaVTdqYSs4WGlvSUp2KzdJcEZXVUhL?=
 =?utf-8?B?QkhPMmx2WFI3WWg4RXovQ0ptZkQ2eWgwdEVDL1NUQVF1cU9ueWhVRDNuRjhE?=
 =?utf-8?B?YVhYOEpROHNpZ01GMUg2RkJIMGQ5VHF5Rm9vcG5PZlIwVk9qSkUrSUtEbmxW?=
 =?utf-8?B?KzhGbnlXVzJPMDUxSExEWTIwK2JHclpNWjMyQXJNdDVPUVJrV2NGV05YTmtD?=
 =?utf-8?B?cWs5aEFlS1oyMDIwRkJVWXQ5Q2c5cXlIak9XMnRRVUlmcjNpby9HeU1weFJK?=
 =?utf-8?B?cFBvQkZBaFhObzBjRVF4QVQyWEpKaC9zeTNLVUhOTmw0OXo5QmtTZXBxRk1w?=
 =?utf-8?B?QnBBUmk1SmdTTTlaZldONWVxaURzNmI0SHlwVzdLTndzWVBxWWZ3TVptdllD?=
 =?utf-8?B?cDJlTzJua0N1bnJwQTAwTm94d1Rvam1YWW1zSkVDc0V1Y1BVUmxBVTVISExj?=
 =?utf-8?B?MlU1UUtOZ1doUHhYczkvSTJLT0NBQW1oODNzQlBmQkNZYkEwZGhpR05NOFN2?=
 =?utf-8?Q?c40Sw4V7tHvyHA2MwXDNSORmq?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cdf0c6-aa8a-447a-d064-08db7288c460
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB6946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 18:53:13.9678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7l5vK4/rJ0w1Erae/V0SJ4A0Spk3+JKbBLDGwPlGxZpBgrhU+zdL7b1qf9Gjr6sT8hNvq59mh/TVfh4duHpi+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7575
Received-SPF: pass client-ip=2a01:111:f400:7d00::70c;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/1/23 21:28, Andrey Drobyshev wrote:
> When rebasing an image from one backing file to another, we need to
> compare data from old and new backings.  If the diff between that data
> happens to be unaligned to the target cluster size, we might end up
> doing partial writes, which would lead to copy-on-write and additional IO.
>
> Consider the following simple case (virtual_size == cluster_size == 64K):
>
> base <-- inc1 <-- inc2
>
> qemu-io -c "write -P 0xaa 0 32K" base.qcow2
> qemu-io -c "write -P 0xcc 32K 32K" base.qcow2
> qemu-io -c "write -P 0xbb 0 32K" inc1.qcow2
> qemu-io -c "write -P 0xcc 32K 32K" inc1.qcow2
> qemu-img rebase -f qcow2 -b base.qcow2 -F qcow2 inc2.qcow2
>
> While doing rebase, we'll write a half of the cluster to inc2, and block
> layer will have to read the 2nd half of the same cluster from the base image
> inc1 while doing this write operation, although the whole cluster is already
> read earlier to perform data comparison.
>
> In order to avoid these unnecessary IO cycles, let's make sure every
> write request is aligned to the overlay cluster size.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   qemu-img.c | 72 +++++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 52 insertions(+), 20 deletions(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index 60f4c06487..9a469cd609 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3513,6 +3513,7 @@ static int img_rebase(int argc, char **argv)
>       uint8_t *buf_new = NULL;
>       BlockDriverState *bs = NULL, *prefix_chain_bs = NULL;
>       BlockDriverState *unfiltered_bs;
> +    BlockDriverInfo bdi = {0};
>       char *filename;
>       const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
>       int c, flags, src_flags, ret;
> @@ -3646,6 +3647,15 @@ static int img_rebase(int argc, char **argv)
>           }
>       }
>   
> +    /* We need overlay cluster size to make sure write requests are aligned */
> +    ret = bdrv_get_info(unfiltered_bs, &bdi);
> +    if (ret < 0) {
> +        error_report("could not get block driver info");
> +        goto out;
> +    } else if (bdi.cluster_size == 0) {
> +        bdi.cluster_size = 1;
> +    }
> +
>       /* For safe rebasing we need to compare old and new backing file */
>       if (!unsafe) {
>           QDict *options = NULL;
> @@ -3744,6 +3754,7 @@ static int img_rebase(int argc, char **argv)
>           int64_t new_backing_size = 0;
>           uint64_t offset;
>           int64_t n;
> +        int64_t n_old = 0, n_new = 0;
>           float local_progress = 0;
>   
>           buf_old = blk_blockalign(blk_old_backing, IO_BUF_SIZE);
> @@ -3784,7 +3795,7 @@ static int img_rebase(int argc, char **argv)
>           }
>   
>           for (offset = 0; offset < size; offset += n) {
> -            bool buf_old_is_zero = false;
> +            bool old_backing_eof = false;
>   
>               /* How many bytes can we handle with the next read? */
>               n = MIN(IO_BUF_SIZE, size - offset);
> @@ -3829,33 +3840,38 @@ static int img_rebase(int argc, char **argv)
>                   }
>               }
>   
> +            /* At this point n must be aligned to the target cluster size. */
Minor: except last non-aligned cluster as stated by 'if' :)
> +            if (offset + n < size) {
> +                assert(n % bdi.cluster_size == 0);
> +            }
> +
> +            /*
> +             * Much like the with the target image, we'll try to read as much
> +             * of the old and new backings as we can.
> +             */
> +            n_old = MIN(n, MAX(0, old_backing_size - (int64_t) offset));
> +            if (blk_new_backing) {
> +                n_new = MIN(n, MAX(0, new_backing_size - (int64_t) offset));
> +            }
> +
>               /*
>                * Read old and new backing file and take into consideration that
>                * backing files may be smaller than the COW image.
>                */
> -            if (offset >= old_backing_size) {
> -                memset(buf_old, 0, n);
> -                buf_old_is_zero = true;
> +            memset(buf_old + n_old, 0, n - n_old);
> +            if (!n_old) {
> +                old_backing_eof = true;
>               } else {
> -                if (offset + n > old_backing_size) {
> -                    n = old_backing_size - offset;
> -                }
> -
> -                ret = blk_pread(blk_old_backing, offset, n, buf_old, 0);
> +                ret = blk_pread(blk_old_backing, offset, n_old, buf_old, 0);
>                   if (ret < 0) {
>                       error_report("error while reading from old backing file");
>                       goto out;
>                   }
>               }
>   
> -            if (offset >= new_backing_size || !blk_new_backing) {
> -                memset(buf_new, 0, n);
> -            } else {
> -                if (offset + n > new_backing_size) {
> -                    n = new_backing_size - offset;
> -                }
> -
> -                ret = blk_pread(blk_new_backing, offset, n, buf_new, 0);
> +            memset(buf_new + n_new, 0, n - n_new);
> +            if (blk_new_backing && n_new) {
> +                ret = blk_pread(blk_new_backing, offset, n_new, buf_new, 0);
>                   if (ret < 0) {
>                       error_report("error while reading from new backing file");
>                       goto out;
> @@ -3867,15 +3883,28 @@ static int img_rebase(int argc, char **argv)
>   
>               while (written < n) {
>                   int64_t pnum;
> +                int64_t start, end;
>   
>                   if (compare_buffers(buf_old + written, buf_new + written,
>                                       n - written, &pnum))
>                   {
> -                    if (buf_old_is_zero) {
> +                    if (old_backing_eof) {
>                           ret = blk_pwrite_zeroes(blk, offset + written, pnum, 0);
>                       } else {
> -                        ret = blk_pwrite(blk, offset + written, pnum,
> -                                         buf_old + written, 0);
> +                        /*
> +                         * If we've got to this point, it means the cluster
> +                         * we're dealing with is unallocated, and any partial
> +                         * write will cause COW.  To avoid that, we make sure
> +                         * request is aligned to cluster size.
> +                         */
> +                        start = QEMU_ALIGN_DOWN(offset + written,
> +                                                bdi.cluster_size);
> +                        end = QEMU_ALIGN_UP(offset + written + pnum,
> +                                            bdi.cluster_size);
> +                        end = end > size ? size : end;
Minor (?): end = MIN(size, QEMU_ALIGN_UP(offset + written + pnum, 
bdi.cluster_size))
> +                        ret = blk_pwrite(blk, start, end - start,
> +                                         buf_old + (start - offset), 0);
> +                        pnum = end - (offset + written);
>                       }
>                       if (ret < 0) {
>                           error_report("Error while writing to COW image: %s",
> @@ -3885,6 +3914,9 @@ static int img_rebase(int argc, char **argv)
>                   }
>   
>                   written += pnum;
> +                if (offset + written >= old_backing_size) {
> +                    old_backing_eof = true;
> +                }
>               }
>               qemu_progress_print(local_progress, 100);
>           }
With or without minors:
Reviewed-by: Denis V. Lunev <den@openvz.org>

