Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC4762FF9
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 10:37:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOZzr-0007jv-5Z; Wed, 26 Jul 2023 04:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qOZzo-0007jP-1S; Wed, 26 Jul 2023 04:35:48 -0400
Received: from mail-dbaeur03on20716.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::716]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qOZzk-0003WG-O5; Wed, 26 Jul 2023 04:35:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkIli4isGaHiJ5FaqYyyYU1vZh20QroKtmuEVYWbNGBGFylvt9momBKuT1ME24EMSX/Qg7pUMhncZ1x87vf8YNgv7b43v6P/pU2hvfp7vQUQ87aYVMW7A2apJ03BWrFzKA6LpDCvhs0/30crBlfuVQ2BI6qjsRa+nE/G5EAZOtoYpvm7U2Do2Iopq1XYNGJ3gPW+CoP99k3cMXgbS0WL24LC3cQsz+ZaAcV5rqx7iqhbHnNzUCAYz9zPeL8pHQP4TVkEPzTHZNm5rZDlkAr8VYsqRynMTAkuGYULmiDFJM/lA0xIv6sbk2CzzZvBZOBh4wzXF6/N6Gxs0X58oQLjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RUMcfNrJgfp8dZkOzG0URxBwkucuQC3CG8L/FSrG1g=;
 b=dsX05hLDSuLUjW+4F4X5v2BH8PeOauQZmhQ+pOr9E4rjKrzjb0CYglFWnWMW76cefthGcCOv7w+UlYQ/gkSn01eku7R4Dxl/Gz4LsrVhkdr5IUEcaZV0mvLZXVoibSEVzII2COI8/UlqQiCYjQdvPzKz/RmGDLSc0CUquqzBRqKnaC7kHW8VpAfUUPuvMJoKEs3X/viots7DA3VsZWkp/D9Qv5AIdPJAV7Bv7CQ247KF3rtG0Iv7pQr3b0bRNxVt1h7LWkefhzIc1UWvrtyHnaS5srek9QNR6rvZlMOMYTxy5/rXH3CpMlAFmqhc1wwhO0u2XuHdf7ldEuJBL4TNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RUMcfNrJgfp8dZkOzG0URxBwkucuQC3CG8L/FSrG1g=;
 b=AskyrYwBxEE2h3othB44vTbADDGwl36UDJIPrQbhaxwqJgg786IB8P7/ZlQoKDoBLC5hJMQG8Ig7HZNClV2D92BtTiiMjR950Wb8af0FiAASzE68Yz7/ilDxbOASQL3OsAd7D0ywRA8t1OJrOa03axIcuNA8RBSwXde/WSPymGNT8hDPsYtHgEuH22oYdaw0gHsarLVcxJ2sktYpFhTB8j9aZjZA1a/P1IrvphPUsXkggh7AH5A9PFA2o8LtmqTt3fWXP3Ry68gT+OzxeQSh2MUnHgoUB72kh5HSqjvEA2UJPsDB9T0b2KE2QiJC6A/z8RzSZ3gOvZ2teMO6jZMzcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS2PR08MB9416.eurprd08.prod.outlook.com (2603:10a6:20b:594::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 08:35:40 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd%5]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 08:35:40 +0000
Message-ID: <196f8bb7-57a8-a3be-8e4e-784bbf76f471@virtuozzo.com>
Date: Wed, 26 Jul 2023 10:35:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] block-jobs: flush target at the end of .run()
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, Evanzhang@archeros.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20230725174008.1147467-1-vsementsov@yandex-team.ru>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230725174008.1147467-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::37) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS2PR08MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a40481-b8b6-4ea3-7d01-08db8db34b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OelK2W+bz6fafSa8thc7k1rZ3ky+2BxsJMIBU/hzgoc1UqEGo/qqPpjmZWXZBGZsirLagr84ZvLN/iZ8mSdWKSS6vXSgyV07tPPq1KOW/wu9hl+sHwIEMR5h0qF2DBcbSF888OLpjb3dhnLrl+St6zEOtTvmOI+z75thZNDoX8V3ROewDU/389ddCNz66EK6tGg8YnhH7kYcyHGJzL3wXyGpNGmyDtRywQ/w4/PaNP4dcfUS3LGHLVJk/iS+Zdbj8ovOqTWuQy6tKMiS6n0HOnYHzQuDylMCmXLDRt1H1ZU5u+9W2V8UEFQpZUGnKuUreZu/0bZfrBeC4xy3jY5OYDnEF9M2zyykipMUPbopgY0fjXVFTt6wqPDcJtw+s2afnUivf8z6iaS5ApYFX13ecedL4LaxDgsbnbRPqew/gGb3NZKJzayeoseHFf0vN2U/wQX4haIdToYokhOm5VFHasK3K48yjSoDU6wGvFimq+ggN6eKW4Qs/PexlYxg0PFrSV3/vuy55fBh1taFlEAXSc2LpJ1msI41Nd/QE+C89X3PPnqNyUBTbfLeuMuCYZ93bLyVuJpEjd0cUJU87YVdwqN1ayuOIpFWl7kD1BjKpCDJhSuOQZYaMRmCr1YZGU4GdKUc97dnZY3TJxBcaLSAy7MxVx+R5dp6c8ObD9hUJLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(39850400004)(396003)(451199021)(2906002)(316002)(8676002)(8936002)(5660300002)(41300700001)(36756003)(86362001)(31696002)(6512007)(26005)(6506007)(53546011)(107886003)(478600001)(6486002)(83380400001)(186003)(31686004)(2616005)(4326008)(66476007)(66556008)(38100700002)(66946007)(142923001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rmk2OVNjSWdWWEoyaUYvZ0dtOUpQU2NLeWNQWXc4QnBISEErM0RKWVlrbDB6?=
 =?utf-8?B?RFh4V1ZRMVg2N2Q2TkFCMGh6TDNsVGI0LzdCMEMwU2JrL3BDSThoVDhxa1lR?=
 =?utf-8?B?R2cwQk16c1JZb3JuQUVRc2xoZS9wYU51d3h6MWxrb0oyc3k3ek03SzNIS0R4?=
 =?utf-8?B?YjdoTXpKMUpUb3VXVVNuaHFzVTBPREFBeHBTOEdIb1NCc2xHaWJodExEcndm?=
 =?utf-8?B?SXZOc3NCMFVCZmJsSHIwQVhFbmUwVmV4ZUg5MEIva2NVYXY3YXJpc1hpWDRJ?=
 =?utf-8?B?UGJCTmVCRmsvdzluNTNlb2NVNjhrLzFwY2x2RDhTSWZEdnZPSDI0VGtxMith?=
 =?utf-8?B?K2dUbW5GcGxSa2J3ZW5ydDBzY2lYOUlJdnNLSk1ZNnJHZWpxRkg3V3ZKeUwz?=
 =?utf-8?B?NFhnSEllN01sZ29GMW1VRUg4VmVOdXJ5RnkxUjNralV4VExxcTIzUURWYkJw?=
 =?utf-8?B?NXhmc2RuRkRPTXpmeU5TRzZHZStVQWRqNjFpa2hnNkhQN29kUHpNYy9RTFlX?=
 =?utf-8?B?TkY3azRrZlVmZ21SMDlsK2tMN0txb1ZsWlQ5NEJQWCtTWW01cTEweWhMb0hS?=
 =?utf-8?B?UE5sMkFTZk1qRVV4VE54eHZBUXhJdmd3ZGJERVkvelljanBIY2JGOU9NVXF5?=
 =?utf-8?B?SDFuNVJ2TDA4YVpKZ3B1T0p1THJlR2JJSkN6bWZUYS9NQW5uR2NvWThUU0Mx?=
 =?utf-8?B?K3FLc1l0c3laSDJlQStLb1g5NUdsTm55OFRkdEJEeFl6SDZKa2ZnZkhQaEZ6?=
 =?utf-8?B?RDJ6WXZxMmhUcFVpcFZ2NDAwZiszYTcxcERDRmdleEtMV3lKNTc1cTdJYjlZ?=
 =?utf-8?B?c2k1MmR4THRQMDIzd0QzYk5CTVd2bjdXcElCMVROMDM2d01OUFRSV1BNUFM4?=
 =?utf-8?B?WkNhT2txLzFjRnd4ZjVkT2dLZW5vTzgwTElYcXF2dzVobGNFUlcvVWFaVjVh?=
 =?utf-8?B?V2UvUlZkaXo4L0RqTzV3T21NVDhrUjNteGx6K1JONEpvdVBUWnpQbE5PRktj?=
 =?utf-8?B?V1R2MkV4MHdGTktnTEQ2WGNvczhZZWlNdEZXb0MvaDVNSFoyekZNQndZQ2o1?=
 =?utf-8?B?RkFYcCtKSkJQWWN2MmhNaGMwcFRpYmJJMDQ1VUhzRkczZHVBaE1rR29BUnJi?=
 =?utf-8?B?V3gybGtGUWt5NWdXNXQyVVdOL21TemdBMzV6d1dBODBqZlBDa3M5UFArWE16?=
 =?utf-8?B?cGo4VDBjakVjREMwc0dqZTZqTzZxendTaU94emZNZk5HWmxUc0k4aFZkS080?=
 =?utf-8?B?RFJhQnJvUFQwM2VFR0JQSEJXWUkvdnhVZ1ZJSGxsekY0ZlYrMW5oS25Vb2d1?=
 =?utf-8?B?Z0dvcSs0VVFvbFI2NkpjYWhjQnJrU2VjLzFDWkRQMC9BM2trdUptbnRHMnZX?=
 =?utf-8?B?Z2hxWDJNejZ3bEFpbnJtUkM3Yk1vc3pVS3FIb1B4QUF6dWMxNFhPSlcrVE8x?=
 =?utf-8?B?Vkl6M3ZPS2g4cTVNWmZwRDgvdDRnYmQwN2ZWK1dXUnlTREo4am1qMnRMbUJ2?=
 =?utf-8?B?Yk50NS8xOEVSeUh5MVlwYUs0cys1ZmVPNFc0dU9wbStNeUhnMDlnZ2htczNJ?=
 =?utf-8?B?WmJuTG9yL3lKUm5MQU1ITjJPNHQ4U09aU2JzTEhxbnp5QngzeFZlQVZFRlVr?=
 =?utf-8?B?S2Q0VU5BSDV4Z0dHMUdMdEg4cjFiWDNja1dzSThET0JZZGo5Q2o5Q1F0UldB?=
 =?utf-8?B?OEhEek9zWndKNG1GaGRnNUtHOTA4U25nbmFpVmRidGdwNWhuVDRha0wwdkw5?=
 =?utf-8?B?Z2lycTk5RS9ROE5EczdWa2gwUXZSS2dySDczSkFjZ3FPTHNMbmE1OHRZa0Nu?=
 =?utf-8?B?Zm9RdVJESm5wWGhpdDRVUnpIQ1c1YnpwektRdnJneGRIMFNySndnQWJtdzM1?=
 =?utf-8?B?aU9ibFhsMHF0QXdYL05QOTRRSzczUWNpTDd0UXVxNWdmUFF5TmNUbFBtNmJn?=
 =?utf-8?B?dWo0UDZ0dFQxVVRzaUF6K2VBRjZzWFdUQzMwU1NoU3JnMzJOeGtMT2Y2MGNo?=
 =?utf-8?B?RU1PRnZqdVg3OXo4QUlpUjNUVis1RFAwTnhrQi9ad0JZQUQyK2NCNTFHR1E4?=
 =?utf-8?B?WEdLeFNQNy83RDlMa0U5aWkvTzVDRVVpWGpKdUh2c0cwTzJ2UTQ2Sk42Wll1?=
 =?utf-8?Q?hnLFuQF6PGVEhe0KRIboPWxix?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a40481-b8b6-4ea3-7d01-08db8db34b1d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 08:35:40.2752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6pdCnIzj8VfXzxSAzOV0wjXqRZeUo1OFSbJJIpoml4KsWVJYxEJCo0dddOvWednkbZGkGRWkFri2uEz5NARqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9416
Received-SPF: pass client-ip=2a01:111:f400:fe1a::716;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/25/23 19:40, Vladimir Sementsov-Ogievskiy wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Actually block job is not completed without this final flush. It's
> rather unexpected to have broken target when job was successfully
> completed long ago and now we fail to flush or process just
> crashed/killed.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   block/backup.c               |  7 +++++--
>   block/commit.c               |  2 +-
>   block/mirror.c               |  4 ++++
>   block/stream.c               |  7 ++++++-
>   blockjob.c                   | 18 ++++++++++++++++++
>   include/block/blockjob_int.h | 11 +++++++++++
>   6 files changed, 45 insertions(+), 4 deletions(-)
>
> diff --git a/block/backup.c b/block/backup.c
> index db3791f4d1..b9ff63359a 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -295,10 +295,13 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
>               job_yield(job);
>           }
>       } else {
> -        return backup_loop(s);
> +        ret = backup_loop(s);
> +        if (ret < 0) {
> +            return ret;
> +        }
>       }
>   
> -    return 0;
> +    return block_job_final_target_flush(&s->common, s->target_bs);
>   }
>   
>   static void coroutine_fn backup_pause(Job *job)
> diff --git a/block/commit.c b/block/commit.c
> index aa45beb0f0..15df96b4f3 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -187,7 +187,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>           }
>       }
>   
> -    return 0;
> +    return block_job_final_target_flush(&s->common, blk_bs(s->base));
>   }
>   
>   static const BlockJobDriver commit_job_driver = {
> diff --git a/block/mirror.c b/block/mirror.c
> index d3cacd1708..cd19b49f7f 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1143,6 +1143,10 @@ immediate_exit:
>       g_free(s->in_flight_bitmap);
>       bdrv_dirty_iter_free(s->dbi);
>   
> +    if (ret >= 0) {
> +        ret = block_job_final_target_flush(&s->common, blk_bs(s->target));
> +    }
> +
>       if (need_drain) {
>           s->in_drain = true;
>           bdrv_drained_begin(bs);
> diff --git a/block/stream.c b/block/stream.c
> index e522bbdec5..f7e8b35e94 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -131,6 +131,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(s->target_bs);
>       int64_t len;
>       int64_t offset = 0;
> +    int ret;
>       int error = 0;
>       int64_t n = 0; /* bytes */
>   
> @@ -149,7 +150,6 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>   
>       for ( ; offset < len; offset += n) {
>           bool copy;
> -        int ret;
>   
>           /* Note that even when no rate limit is applied we need to yield
>            * with no pending I/O here so that bdrv_drain_all() returns.
> @@ -207,6 +207,11 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>           }
>       }
>   
> +    ret = block_job_final_target_flush(&s->common, s->target_bs);
> +    if (error == 0) {
> +        error = ret;
> +    }
> +
>       /* Do not remove the backing file if an error was there but ignored. */
>       return error;
>   }
> diff --git a/blockjob.c b/blockjob.c
> index 25fe8e625d..313e586b0d 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -611,3 +611,21 @@ AioContext *block_job_get_aio_context(BlockJob *job)
>       GLOBAL_STATE_CODE();
>       return job->job.aio_context;
>   }
> +
> +int coroutine_fn
> +block_job_final_target_flush(BlockJob *job, BlockDriverState *target_bs)
> +{
> +    int ret;
> +
> +    WITH_GRAPH_RDLOCK_GUARD() {
> +        ret = bdrv_co_flush(target_bs);
> +    }
> +
> +    if (ret < 0 && !block_job_is_internal(job)) {
> +        qapi_event_send_block_job_error(job->job.id,
> +                                        IO_OPERATION_TYPE_WRITE,
> +                                        BLOCK_ERROR_ACTION_REPORT);
> +    }
> +
> +    return ret;
> +}
> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
> index 104824040c..617e40b916 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -152,4 +152,15 @@ void block_job_ratelimit_sleep(BlockJob *job);
>   BlockErrorAction block_job_error_action(BlockJob *job, BlockdevOnError on_err,
>                                           int is_read, int error);
>   
> +/**
> + * block_job_final_target_flush:
> + * @job: The job to signal an error for if flush failed.
> + * @target_bs: The bs to flush.
> + *
> + * The function is intended to be called at the end of .run() for any data
> + * copying job.
> + */
> +int coroutine_fn
> +block_job_final_target_flush(BlockJob *job, BlockDriverState *target_bs);
> +
>   #endif
Reviewed-by: Denis V. Lunev <den@openvz.org>

