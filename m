Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 015FD70F0C1
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:31:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1jt4-0000QG-Hz; Wed, 24 May 2023 04:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1q1jsz-0000Q1-62; Wed, 24 May 2023 04:30:21 -0400
Received: from mail-he1eur04on0708.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::708]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1q1jsx-0007I9-3A; Wed, 24 May 2023 04:30:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dcjn6fEx+ef2fX3kn1zQjo+xHeNG7wEisIIC413Plol7tjW0KZKZ0OgmV7iS9Tb8GYz9CQIxM8rbMewtp3P3l9tRj8PqBYr3/SaJciTwm1knLkzw4g5H9Ckh+HXjH9Xbrh0yfL6k/jE6pR5DNl+bGl6ofDIrkz+EgfB4q2Wdvllfw4hK+2+IWUF2duvM60XHzsPjPkr5VyUOh/CCWqCJBmoVapOl3kBSRHEWkbjm2MpYcXCfsLVwkKmtPWcXHDl74NUawG0OYeZv1HpJNHUli9wXRADVvtp3ewn404R2XCnfIkg+KOhdgNpK9SmvbNjdboOOs2x4hugfIRg+DbrEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSs529Ad1DgnJGO6Czv01vhZXaoyHgfPkRCCsgsXiUM=;
 b=cbQGErbmf+KZ7/ezpavXqJOc65k5kOIf+pcB41VbMAqj25pGyz2/ldaM3+p/Z1Jt6oqoZX+1mpgU3TQZ8oUD9uVOGhq/L66KaaL7vmgz8yb0JX7yHDlPv4Qug3pUEVYUmv/ATsXTHd9wqCegtCzZ115OnNRnqvLl1q76FFd0tquD4YfW1UbxZrZF0QVTalR4Crb5yDCYNSr98zssB5L/JzpWvoi6bJrT161EC+jNKn9bIhZ5l6pA/7m9t9ZjRAHqEjZSVd3gTp2MOGTZyrz++PLBhSbbQCk+nBkleYnfzD47YomSDyVytClfUPMUNefKIaeW6nWZG932dFrtLloq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSs529Ad1DgnJGO6Czv01vhZXaoyHgfPkRCCsgsXiUM=;
 b=Ka+ZKfoz5IgGD6gHyaz36s8+ZHggLbOoNElfdhTqY7zgkf3Hzfgy1VYZaUmf8QXWdQi2Kr5xVx5m/WhLLtfrIyxaSdVjaYcSR7I32PgPALJYtL5eUW36ImuVq8E+kl4n1P0eJKgZO8ztrK1nr9XJJ1LGupfG140EiLexKVJC+vZxyMb1de1ue1d2E/r3mKKFmebCSRqseK7jJ0lNWStZl3zOQGEw2qxa0Kih5bKCCpQPtdSca1tj2xXtcdgkJTJjUqCXI52TdxBnMT0HzkSDCOVpClqOttSN8Vqqv4aN/qK9b1AQ6CZQ3Fmln8evUCeNPd8bJQjzKCsOcM97TJ5h6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PAXPR08MB6382.eurprd08.prod.outlook.com (2603:10a6:102:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 08:30:12 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::b50f:b94:a801:adaa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::b50f:b94:a801:adaa%6]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 08:30:12 +0000
Message-ID: <7f391cd8-0a4b-a276-d7b2-de91ab0e158e@virtuozzo.com>
Date: Wed, 24 May 2023 10:30:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] qemu-img: rebase: stop when reaching EOF of old
 backing file
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, shmuel.eiderman@oracle.com
References: <20230523162458.704266-1-andrey.drobyshev@virtuozzo.com>
 <20230523162458.704266-2-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230523162458.704266-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::7) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PAXPR08MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: cda426e8-bfc1-4bf4-a6b0-08db5c311781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jj37cgHsW7JaNabQ9twWIdN7O3w+us1CbSF2u80+ff+2ZgaPKuCk4W3m2ikyZhmGgXOGVZLzXEBNGzPW20rqNrvKFUxdBIoO/C2sbwouAa/w6y/cNMkQLWS/8d4T/b8I3YDDTfcQdORmrnsemJTIINRGe/FrxIkBHeWL4HfGkayTXJes/ciuMyUAZOR+dz1iBlsU6aeW3fXf/XY0XXHsYSSttIHbQIsomzStqJshs1tFbYinKVa5d4gQaeMiAcHbPkxD+ZfPOu8Ixu2Rj4RqK8FRoxIxLaSMgMO9UCpRDkCWeHTDGzo+KODkCNQhL2xUThjklcHvA3M7midLe4QHm2eFKFdmQYGfJOjxhzVB38XNRp7pxkJXxdry9mS9Q0NOOHv5CgeeDc4Mn4tH5xmNzXs0iLQRTHVD79mvWC7phZPOeUfoWdUbNdr/CWh1Q7cw3h0syac9eTRmeeRnupLtrUe9Dcf4m8pBMFw3OtygUc3hUO06jpODqCY/KfMfpVdNkaVvo/qTBwWn65WJCD8Zq0NGeE1Z2Jvh3IQb0qTW1nxwHJSAkPH1SfG1XzJsIFxUvpgT9rdCXiCeoKMNIRpYuDjBZ0/MCHwJdhVRilp/53tMA3HgkRBv+A3pNZiKZBUKaKwcv9Nh4njNWNwCCOgnaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39850400004)(346002)(366004)(451199021)(6486002)(38100700002)(186003)(53546011)(6512007)(6506007)(26005)(2616005)(83380400001)(36756003)(66556008)(66946007)(66476007)(2906002)(4326008)(316002)(86362001)(31686004)(8936002)(8676002)(5660300002)(31696002)(478600001)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVdPQUlXSWRFRkdvYk9hOTA0c05lL25DQ0tFYTN6TlpUVXVOT29uSFczcndo?=
 =?utf-8?B?ODl5b0ZJZFJsSndQdHhHd0xFdTY4K0dsVHBSb3F0Z2NRM3poYmoxR2dmZFNa?=
 =?utf-8?B?NGU4aHAyY3ZLQThxQ2x5bEp2dGpaMmwwN09BdXZCc3JHZ2RGbmVhSjd0YVlF?=
 =?utf-8?B?eXpOaERvb2g3eGdrWkRmMWUzV2FOQSs3TjJmbW11SkNZbVdxaGNxUkhnVmox?=
 =?utf-8?B?TXZ3WG1lUlVQT2p5ZzYwVkUyM2lpL3ByM0E2dXpFU0hSMXdDRjA5M0kybUQz?=
 =?utf-8?B?MGpXTHdHQTZqdGlBYkZiY1d0YVpiZkt3VUhUbXBibjl2ZnhWZ1JkejNldit3?=
 =?utf-8?B?bVJ4amN1SThJcGJ6ZFhOenY2TlJmUHJPcnhoaVhpOGtXWkF2WkhLSHdkN0xj?=
 =?utf-8?B?MVlmTXB6YTJMY1Bka1ZYN1F6OXM2ZWg3SXpJVTVXeDRZVlZZYkF1TllaRkQw?=
 =?utf-8?B?MzY4TUJZdXhhZklFSkRaQnZUVFNnVmF6c294enlNS1ovSzVzLzhnazZsakdt?=
 =?utf-8?B?MkkxUnQyTkkyb3d4dU5KalE5V3B6ZWpYZWVHZit3a1NVSlhCU2dNTzhmZUgv?=
 =?utf-8?B?QzV0WnE5dGtNMVBLaGx1eWpwZXNlR1AzZ0l5a1BrTVFQNnNpUDlMUWFSa0l3?=
 =?utf-8?B?WVNTU2hPZFI1Y2tvQi9pT3VBQzBqNkhRK0tUSndHMnorZkFNREFHQnh6UU5X?=
 =?utf-8?B?bHVqZ21hVDR1eVpRZXpyQUFOQ0tTbCs0eXhZSXhHeHFybGJLc0RXTXdHTTk4?=
 =?utf-8?B?a1ZFYUJFbW9UcWJMUnVjNVZIMjE1a3hJMjF4ajA0dFkrRnRWSFRnSDY1L01M?=
 =?utf-8?B?R2NCSnErK0RTdGU5Q05vNW1oMkQvUW03TmJBN09KSHdxeXc3NWIxQkJ1OVo1?=
 =?utf-8?B?SzRqUzFyS3hNVCtSWDFNOXUxd3lsSnZSZTNIdjYrUXQxUTVTK05id1YxcHIw?=
 =?utf-8?B?Yi9wU3ZHaUF2d1R4bHdRQVdsSzhuYU5vdmtZTm9VN29nWXlzU0ZYbUNLMnpE?=
 =?utf-8?B?MWlPSWQ2TXJLTTUwS2pYTHNGYzBZQWhkeHYvN0psYTloYnVrNWY5Y25IVnRz?=
 =?utf-8?B?SmFwTXgzQkdtdHlBc25vQlFpdDBVdWhrMGZDUTVzM2FqRlI5ZkRYd0NlQ1R2?=
 =?utf-8?B?cWhSVW1uWm1ZRjYwNUZIY0JJSHZ1YlRwN0MxRUxIUWczUEdwN2tCSGM0VzRy?=
 =?utf-8?B?cEExUkFGMVh6RE5ubXVDdWR4VHNDYlNyS3JQNGRoRlBSSCtNcG1FQ0ZraDY1?=
 =?utf-8?B?SWJIMGg0ZHRlcERQUjVnektDQ3BlWTd6VE9jbFZkSjFMZWJ5UmZxaUxNODgv?=
 =?utf-8?B?Zk1tN2xSN29LUTBVb3M0YnhCTnZnaGJKMzFWTTJTNmY1VUF5NUx6VDluK1R0?=
 =?utf-8?B?Q3NFL011STJ1bzdlb1VzYWd6NEdxQUFMQ2lCU3QxMFAvajBjU29CQ1VPZlVQ?=
 =?utf-8?B?Tk92Q1l4ZDhuUHdZWHNBU20wOE9LUFpqdEtEZUxHUGlCNE5YNHM0eEZGOXBh?=
 =?utf-8?B?eFRqSzRlMUJma3BxWjRFWWNlTGI2b1NOOU1OZm55NDN4eXRleHRwZVU3VjhY?=
 =?utf-8?B?aGJPVkpSR1N0Qy9Wd2ZONE5zYWVTVmdidGZKSjNic3p0bXZLNDFNV3h3dk1X?=
 =?utf-8?B?UUZFZzJ0bUdGekNRa25WSWFrUFBPZEw0bFRYbjllWk9nQWx3aTZydmJsSmZ2?=
 =?utf-8?B?M2tLYlhFRDdmN2lUUVdPd0dEOUx5dTREZWYzMjJZdEhMaXh4Sk1McUQrNGJD?=
 =?utf-8?B?V0l0YlpjcC91Yy9Ob1lQYTdwUVFmdFFJUE8ybnN3aVl6eEw2Zkxwd05Gb21N?=
 =?utf-8?B?VXFtYi93L1ErNVFoQjlTcjFBZEdMTnVGV1FPWGVKRkl3QUhLdFZndE01d1Zp?=
 =?utf-8?B?V2dHNXdhQkFvZ2VEZVFLb1daeHFNZkFiSEl2QVpvZXc5cDFSdGZvNncrVURH?=
 =?utf-8?B?WUh3SmRDME02cjd6MktDNkw0TW1FYVZOZTV3aDZ2YTJtZU5NL1I2VVZST1R0?=
 =?utf-8?B?YnhmT1lTaGlGSHVBd2VIWXBKa3QvVy9wTWZaZ1pvWnBMYUpPZWR2a0d3Sy83?=
 =?utf-8?B?SUllVlozL0J6NGkreXZzZm9IRjVKWGoreVplSW04OUx3Zk5ib1QrbE1oVmNy?=
 =?utf-8?Q?WSsAd7nIx7SS+MUvU3I7O4tiM?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda426e8-bfc1-4bf4-a6b0-08db5c311781
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 08:30:12.2445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdhWeTv45N2gSRz2WifVtKq1qdX/0jfq/ZPztwzEFvJZ0KYZa+NoQa/Uz0D0J1azG1Plq1+znZpnrxq1FQRGjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6382
Received-SPF: pass client-ip=2a01:111:f400:fe0d::708;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 18:24, Andrey Drobyshev wrote:
> In case when we're rebasing within one backing chain, and when target image
> is larger than old backing file, bdrv_is_allocated_above() ends up setting
> *pnum = 0.  As a result, target offset isn't getting incremented, and we
> get stuck in an infinite for loop.  Let's detect this case and break the
> loop, as there's no more data to be read and merged from the old backing.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   qemu-img.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index 27f48051b0..55b6ce407c 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3813,6 +3813,13 @@ static int img_rebase(int argc, char **argv)
>                                    strerror(-ret));
>                       goto out;
>                   }
> +                if (!n) {
> +                    /*
> +                     * We've reached EOF of the old backing, therefore there's
> +                     * no more mergeable data.
> +                     */
> +                    break;
> +                }
>                   if (!ret) {
>                       continue;
>                   }
nope. It seems that this is wrong patch.

iris ~/tmp/1 $ qemu-img create -f qcow2 base.qcow2 $(( 65 * 4 ))k
Formatting 'base.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off 
compression_type=zlib size=266240 lazy_refcounts=off refcount_bits=16
iris ~/tmp/1 $ qemu-img create -f qcow2 -o 
backing_file=base.qcow2,backing_fmt=qcow2 inc1.qcow2 $(( 64 * 4 ))
Formatting 'inc1.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off 
compression_type=zlib size=256 backing_file=base.qcow2 backing_fmt=qcow2 
lazy_refcounts=off refcount_bits=16
iris ~/tmp/1 $ qemu-img create -f qcow2 -o 
backing_file=inc1.qcow2,backing_fmt=qcow2 inc2.qcow2 $(( 64 * 5 ))k
Formatting 'inc2.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off 
compression_type=zlib size=327680 backing_file=inc1.qcow2 
backing_fmt=qcow2 lazy_refcounts=off refcount_bits=16
iris ~/tmp/1 $ qemu-io -c "write -P 0xae 256k 4k" base.qcow2
wrote 4096/4096 bytes at offset 262144
4 KiB, 1 ops; 00.01 sec (471.447 KiB/sec and 117.8617 ops/sec)
iris ~/tmp/1 $ qemu-io -c "read -P 0xae 256k 4k" base.qcow2
read 4096/4096 bytes at offset 262144
4 KiB, 1 ops; 00.00 sec (56.076 MiB/sec and 14355.4407 ops/sec)
iris ~/tmp/1 $ qemu-io -c "read -P 0xae 256k 4k" inc2.qcow2
Pattern verification failed at offset 262144, 4096 bytes
read 4096/4096 bytes at offset 262144
4 KiB, 1 ops; 00.00 sec (827.771 MiB/sec and 211909.3028 ops/sec)
iris ~/tmp/1 $ qemu-io -c "read -P 0 256k 4k" inc2.qcow2
read 4096/4096 bytes at offset 262144
4 KiB, 1 ops; 00.00 sec (838.611 MiB/sec and 214684.4139 ops/sec)
iris ~/tmp/1 $


iris ~/tmp/1 $ /home/den/src/qemu/build/qemu-img rebase -f qcow2 -b 
base.qcow2 -F qcow2 inc2.qcow2
iris ~/tmp/1 $ qemu-io -c "read -P 0 256k 4k" inc2.qcow2
Pattern verification failed at offset 262144, 4096 bytes
read 4096/4096 bytes at offset 262144
4 KiB, 1 ops; 00.00 sec (88.052 MiB/sec and 22541.3069 ops/sec)
iris ~/tmp/1 $

the problem is the following:
[----0xAE] <- base
[----] <- inc1
[--------] <- inc2

In this case last 4k of base should be read as 0x00 (this offset is not
written in inc2 and beyond end of the inc1).

This means that all non-present clusters in inc2 MUST be zeroed
during rebasing to base.

Something like this...

Den

