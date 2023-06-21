Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B06738E66
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:17:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2OK-0000b5-Gf; Wed, 21 Jun 2023 14:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC2OI-0000ar-Ff; Wed, 21 Jun 2023 14:17:14 -0400
Received: from mail-am0eur02on2072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe13::72d]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC2OG-0002Ti-Kn; Wed, 21 Jun 2023 14:17:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A14VJ85mRIyBVSKmf1THF42ZtFBOeyugqC+kZZTVYjMZGDTz45ZMdT7RmituZdIWLiluP2O073e21m4Cwk58ZfQBt0QI8Y9VaUqs/9WYJX5/4Dy7YjsuteBUtHJpajYRS4IP7sTbP2AYUKCCZlJnvgGmu0Ui3m+yWTcSrsDTR/Gzhrejc7cNkK78gudBt96nIJuF1S4devUNAFp8qN5vseu4u0icbg1kHBdyJRzHjnf+BFOS7ASQOaTfblLispEGZA+UCMfeDQASJsWsdXqTvBnTlA/zwWwpE/F4vXgiten29SECX9cTQNOdLFidN2IwdL2W53DUfyf906jwlCOzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8MBw4ZtIi1CCzWpSMpZGuL2G3JVsHAQwvOrCGzAe40=;
 b=IcNnjWOgDsWUOGofb5l+CP8vEB9xELOiYUNq3ID4mrQVN4yQjU3E3TQkqIJXwyp16b8X51wz7fGUDaZT2IBQxwD4RD1mTFUEZ5ZfNKo0vHMtO+XewWXqQO8pFA94HRy0pu1r6SVrrf5gZ4dyvOv57utIeVBZXInAcfuPvXcqBIHbyzRdzfYzPqZCZ6CkjQr1VtAxXfyiwehtoTwqkNPV3RZPCmu7acdhH02cBhSDc73T6DqMxPcabo7X0zYRaG9ChphL1nhE5PI/SuS92U5DSLNsFYOb/IREwM7WtBqli3HLOC//1YvDIjXiaWavYUUwQzZ7frZg2lqbeEYETc0CQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8MBw4ZtIi1CCzWpSMpZGuL2G3JVsHAQwvOrCGzAe40=;
 b=Qdw2TkRrQaAQpxjxJg5CafhxbzfhnQoMkmK4S5LVkcnSBYyV8POcmAS8CZ+UiifyoTpc/qgQOY8lwfdDBDvik1NTJyxm8KZdFVnIdk8Fb7Gmrkxv85nWGD00nbLnb0s+/EaHm4IsT+J+d9VhjleH9D1qxm4eBkB+igHFZJtFoq74gJW1ssjuML2KNZwsRTs3u4mQfeDO/jqxRz5ZWoc8ry3VNIfoiVaFcfDLCy2MKRUSCEdShYUYjU4xmI27KS2kwgqo79PIK2I7ngipQoDbRYX5J3mZauyNxHyx/oMVSs+v2/ou8sdxuysvZFtXhb/JfSKp6AQhcOi37hCc9HA2fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB6946.eurprd08.prod.outlook.com (2603:10a6:20b:345::17)
 by PAWPR08MB9806.eurprd08.prod.outlook.com (2603:10a6:102:2e2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 18:17:06 +0000
Received: from AS8PR08MB6946.eurprd08.prod.outlook.com
 ([fe80::1e80:70d8:d23c:9b65]) by AS8PR08MB6946.eurprd08.prod.outlook.com
 ([fe80::1e80:70d8:d23c:9b65%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 18:17:05 +0000
Message-ID: <05d38a48-81ad-f674-b365-b4db56a1cadb@virtuozzo.com>
Date: Wed, 21 Jun 2023 20:16:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/6] qemu-img: rebase: use backing files' BlockBackend for
 buffer alignment
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-4-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230601192836.598602-4-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0096.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::37) To AS8PR08MB6946.eurprd08.prod.outlook.com
 (2603:10a6:20b:345::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB6946:EE_|PAWPR08MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 17537ebb-5f02-475a-a01d-08db7283b321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HsYqcRwW4w6qBbEYMVHCmvEBxWTOevP51lYzG7/y+IcCtehY0sO+q3oqkRuzaeCmtCJ6P99mMe6yVNDZLnhxwQ8mEwu7nLrw1EKwa5TBtVLhu/7m0fDefcBnE4+tmfakyJ3kkuM/TbaouI5T2ZcedQ3zNfYOLqTS1MV65wxEOZF/Be5t6Krdb/AZPqhhRNEpLAaSmIYMFORLt5IKcSK1UsB6+N48lz3XZBWM5p43F4wYE8GSL5nqW64xZBC4l/YeyeznVt6lCchIU7v7djqoa+8uQoy7d7mJqWjzFjHZ8c930wAo6Ddi95rDyMx3ndN4nKCKbJAtSvSDxyQEI+WvWosYctMngYEWkLbDIMuLAZoiByAXzuAm4+bHo5r94yy91A+Wx2Bw0Ix9xdnJXE4pff51HNuFcQ5BRjwnQHBA2mJsUrDC69RhD6+kxXQzFMJDSRrQQP/3S7Y8W+FsGVKnQFTXpq3BRpr1NhhlrUE4BjzSk/Xv9v5A0JAujtiQk4fs6v0UwFNKN2LQIKGZEJ9fH5Da1MZMjPQ3immfbmorQSWw1htmf39q3O6gjBWaT09mDlYPaZ1MQj0QroJNjegRoZnYGQ10faUMTO5n6I8Gpb9ZNQfXQzaP04vAedMcTGzZfDxGLH+2ipDHIVEHGjgrPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB6946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39850400004)(376002)(396003)(366004)(346002)(451199021)(5660300002)(31686004)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(41300700001)(2906002)(6666004)(6486002)(478600001)(26005)(53546011)(186003)(83380400001)(6506007)(36756003)(2616005)(6512007)(38100700002)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmF4cmNQM2Q3KzQweVlaSUF5L2FocmpTR2xrUkRmaTA1dUdZUTJnMXpBY254?=
 =?utf-8?B?Q0ltNnh1QWt1TlhHNnRzdDI5WHlzNERQZUJQblpOSnhPbm9XTmR3NXNaTlkz?=
 =?utf-8?B?VWtVQlY0bTRsTjhJTm03bmlyY2JhTEdPQ3RwTGtYUzhOYURBTmtkcWtMVmVm?=
 =?utf-8?B?U0VhQ0FlZzZsSE9kVUN3NUo3V2dvYXh3VnlYUDRpdzdHb0xDRmw2Q3N1d3Jw?=
 =?utf-8?B?emRadWlJKzMwM3JsWmRFcjI2T2dzWENhRHRRRXl6WmlwZWVLKyt1RExJUFRV?=
 =?utf-8?B?Q01xYlhnWDlmb3puRjMweFVXeG1tNm1USnNmQ2d1enY5RFQzcitETldXbExP?=
 =?utf-8?B?ZFVaVW5SS0Npa3grRFR4SVFMODNhZHR3YktaTzhYNFh6aXpyZlJiNlV2L3Z0?=
 =?utf-8?B?OUdjOHFUcjhpQ1ZaKzhHNG5UbjRBWm5QTmxoT2xTUFpRb0pGazdIM0poR3By?=
 =?utf-8?B?L2ZFc3JQTVV5Y0FSaWdxZEFwYUhVTlM0TjFpdjRzNDFJa2x0NE55SFhGUWFO?=
 =?utf-8?B?ekE4TjN1b0JTeG5pZ3lCRnJsQlNTMEZFMjZzR05ZVjV5WUhuZHdoZ2N5RGZm?=
 =?utf-8?B?ZXgyS25va0NBMk1WNDh1S0VQY0doMi9HcVpoY1dWeG16Y3lSc1h1b0E2eXpB?=
 =?utf-8?B?WmFKdTF3bm9BRWw2TlplZkRHZFd1dzJvTEExblJCRUl2YjFNRndQb1VjcUds?=
 =?utf-8?B?NytzWnFWYWdvSHhvSW0xRWpXTHY4dzVJcDA5QnlEanlqTTBnVmk1TVpncjgr?=
 =?utf-8?B?VVlWWnpiQVQ0L1c5T0tEYXJjdkpSWnEzWTNjMlNiS2IzZlVGV3docVAvWm5R?=
 =?utf-8?B?eEpWdU5ISUUvWmMzeFJQcGQ1MFRuRTdZYmFGVUxESUp0bUdISjZDNlhwa2J2?=
 =?utf-8?B?VWZTMjJnalJBeFFZWlNBZGlLcXdiS2FyOG56L1VheHM0Sk15M2dlaUlqbExH?=
 =?utf-8?B?eXU1VS9CaGlMYUtrY3lVTXYwMUNBbzc0R2dIT3JYTXNxck5Qa0l6WXRlNEN1?=
 =?utf-8?B?ZHlScWNDc2tOdlVOTDhYYjFCb09wZHJrbGNsNTFpbEQ3NzMySXJmUjN0N0lj?=
 =?utf-8?B?Q2pPcHM5dlVqSHBaWWUzcGgwMUFVNWZVbER1QzdUWkg5ZWRNVHJha2JtMUIx?=
 =?utf-8?B?ckh4NUcwdExsRTBQRFpmSURBVlFLM0R1YzBQV0NRWk11eE1sUTMyZlBWVy9w?=
 =?utf-8?B?TWNmdExuVjgwVGM1M1RObjE4YnIrR2dVaGhPYzM0QXZhS09YQnMzU0Q5S3gw?=
 =?utf-8?B?KyttWkZoc04ydmJNMmR2VTJVUldXaENma0NjN0hPRmEvNmZFRExZUTNmUkFo?=
 =?utf-8?B?RVFTVXRxVkJpeXVxZ3FCOC8wSDJPL0xSeURvZFpwQ1dsNVFXeHNGSTZNNmFp?=
 =?utf-8?B?Vlc4bkpLU1Z3UFpKem5rcU16N2k4NVg4SCtIb1V1amFjQ2pvdHh6ZFpraFRO?=
 =?utf-8?B?L09OT1FBVjRoZDF3MlRnakpmbmRtRkxXTFl4TXoxNnZGMC9rMlhkRWhYT3dF?=
 =?utf-8?B?V2ZFSlY5ckpvT1BnamNHVGZJRjBkdloxdW9mK25tUFFraHdyNEZIK2Z3NXhG?=
 =?utf-8?B?cCs4bHkzRlMrcHU1dGRKb1Ixd0hlbjE4ZFpQd3NURjViL1QrdzFSVjMrYnRL?=
 =?utf-8?B?RnI1YlZLSzI4UmFWMnduRm1XbXJSbVhFZkpuZDBneDMvejZCQWN4TTBtMXdu?=
 =?utf-8?B?eDdUcVFSWW1WYUJDRFA1SXdnVjdGajMwM2lQRlB2WjZkckU3ZEM2NGlMdUYz?=
 =?utf-8?B?MDBXb2FNYWRSQm44S0JhdGdWbWlQWmpUWHdod1Y1SkdzL0ZmdmtLb2xza2lV?=
 =?utf-8?B?THUvTG8zQURZYzFuc3pwTFZIN2xWdDhuY09Oa05ueDVMS1ZnSHMySUxveFoy?=
 =?utf-8?B?YllRcDUxaU9Jd2NuZEd5YTF3bGZIL0FLVGJmNkdKS3M4dUx3WE1qWUJMTEY4?=
 =?utf-8?B?Q3VyWjFtUlZ2N29qYkhXVTZrOVVIWWUySnQrSzJXQXdGLzdOcXFQN0hwdm5H?=
 =?utf-8?B?T3A1ajljSllGdmJxSVNmS1hoRTZta2Z6SlBtb0crWkRzYkFTUmd2ZUNnZUYv?=
 =?utf-8?B?MXpYMzlzRm81anNQLzB5WVZxNnNteE1SNFZRTW1qcGtiSk5SdWtpTWRUaTJ0?=
 =?utf-8?Q?vHz20e2TAk/7g5Wk+WvkcTyMe?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17537ebb-5f02-475a-a01d-08db7283b321
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB6946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 18:17:05.6116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eu4oXpI/zEu+4sKb4SWbUObfZ7CBOAnQdx+6FVQ6j6y33r5ik8kVrQCgaqzul4KV+wZ1AtkNk2dBRJsr9HdLow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9806
Received-SPF: pass client-ip=2a01:111:f400:fe13::72d;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
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

On 6/1/23 21:28, Andrey Drobyshev wrote:
> Since commit bb1c05973cf ("qemu-img: Use qemu_blockalign"), buffers for
> the data read from the old and new backing files are aligned using
> BlockDriverState (or BlockBackend later on) referring to the target image.
> However, this isn't quite right, because target image is only being
> written to and has nothing to do with those buffers.  Let's fix that.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   qemu-img.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index 78433f3746..60f4c06487 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3746,8 +3746,8 @@ static int img_rebase(int argc, char **argv)
>           int64_t n;
>           float local_progress = 0;
>   
> -        buf_old = blk_blockalign(blk, IO_BUF_SIZE);
> -        buf_new = blk_blockalign(blk, IO_BUF_SIZE);
> +        buf_old = blk_blockalign(blk_old_backing, IO_BUF_SIZE);
> +        buf_new = blk_blockalign(blk_new_backing, IO_BUF_SIZE);
>   
>           size = blk_getlength(blk);
>           if (size < 0) {
Reviewed-by: Denis V. Lunev <den@openvz.org>

