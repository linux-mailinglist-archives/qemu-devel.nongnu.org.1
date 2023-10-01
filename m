Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C26947B476E
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 14:27:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmvWA-00083b-Nn; Sun, 01 Oct 2023 08:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qmvW2-00082R-Jf; Sun, 01 Oct 2023 08:25:46 -0400
Received: from mail-he1eur04on0704.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::704]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qmvVz-0005qg-Hd; Sun, 01 Oct 2023 08:25:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bc1poLwTeolnuHGre6z4NCLz+ROjpESGwWra2xBYJYPM6lt5HWWf7qCAOnDQsV/FNy87R1z1EUVYZW76PuHlaxyu13A2yrxRszlEkKnY9sa+wiKZTuKRki1k94Cr9gpS+zvVku+XFfYLvYYwpFn7DDg+kn+mFb7aBxBZCJ1vFbIU3s76iLHx33ZHoMQFN94/X0dwhnjqJdaleNRmFYAeMO26vpgSEVpOwqteuURapNnZ0sHx/FQmJ1NyjdvezlJZY+EKcZhM6KAdoAXBkp3uRLpy565gTD1u4wYrSECKfQULyUUan+xdJT/9xohaieaTFOyapbxQwBu+G6eww3DTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7fqL6IKgsFI52cuTZ1mALVp3h/VDGWHz3GvncBFRBw=;
 b=igyltbTKnEhCenyX30xcP4CE65gsb+Av5YWNXuPhv38W4m3yMnEkgzE2CpGZX/Z1g7LExlTYmACy7aHE2F8yfpAZs/quAPOXGhpYA81HUdJm9MnAtxyQUYr95OThj+NPKIzzd9TRx12h26f+BRvYw9fGvt2lpi3OYq+IhYHqmL+eQEMiNFnu0UTFYaUfLLNcaGPEcLteM7GcieBzAPVGFaddd6coE8czlVYqleDDv9yMsDieOsNtlzyz/fjxi3H4XrukyL+awkQQ2SxxhAfdYOBKnT53wS2GItXJ04i6AjzO7F3R/iTAt39Oqc6wTXW+5406PN/v34uaXFUsbq7iqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7fqL6IKgsFI52cuTZ1mALVp3h/VDGWHz3GvncBFRBw=;
 b=aREthQYSBl+Py6hMPIWCIYYz7ku4vpLVE4AZ/rbbZrjb4Xpx6Nx10vogUZuy/v9LE8SqzSpLSTaK6qme3nb+4xtuPNURYrGbvT8K+JhPtiTmd3xA9ETttJPiowYGtuNUI81z4SVpmFZXNrf3KJyn96FiyILoWA3+oVZckcEqFOnzxNT0t9G5cnx14hpm20TI3afVYsYt4zOXeNin0nM82HQ659osXrdyOnS8J0rR17SF8K35ckMUoE9+26WqSjcxCFiCGxtC9cl4hOV7wc/B3fg20X1b+rIDUE1sVGD2D794NecRtj9fVg1o9cPq9tVPu7NOCP4AUpKqCnEbgJt5uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by GV1PR08MB8177.eurprd08.prod.outlook.com (2603:10a6:150:93::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Sun, 1 Oct
 2023 12:25:32 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f%5]) with mapi id 15.20.6838.028; Sun, 1 Oct 2023
 12:25:32 +0000
Message-ID: <15609bb5-95d0-3d38-4c44-bcd313dc723b@virtuozzo.com>
Date: Sun, 1 Oct 2023 14:25:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/1] qemu-img: do not erase destination file in
 qemu-img dd command
Content-Language: en-US
To: Mike Maslenkin <mike.maslenkin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, den@openvz.org
References: <20230930203157.85766-1-mike.maslenkin@gmail.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230930203157.85766-1-mike.maslenkin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0093.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::22) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|GV1PR08MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 694c67aa-9e41-469f-81d5-08dbc2798133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57nh/TR5wP6ihbIGQNnpBfFc/YGMQzXYFogDf1BnwSrJXokMA6CvGHiLzKXUPMG+TYzjzeGETZUE8y+pQJXVVpKRwJ11R1NLIOWDZmFg6j1D2QnxiLEKOhGIIfzEK2zNFNF9/9QFXCNN+FB3F/YLCX61Z5QxPUiSu05ferAjC4ELFDYTgCsQhw3iMA6r72fzxN3s6AnyhP2iE31rDp+Igd7Is/nQ2DHr4jbJzARevVUkLJTxg3P286vIi0vww/eGtwiKjTokLpAfyGpkgRfAwKfFHh6CPhhP2httXIxRZGAXurtGEGQnc7FYOKHgCPLC/1CRAa3/v7c7B5Lf8FIX2ThIbctI6Td4ues+b/yHYazcvyxaT/PlkwA2cu4Y2iP6nw9p3Ydqi3bQh7Uo7aW+JHQS+brTxuTIiE79p5aGEQ6p414MADh8YnlIfir9tPTJAynfwFHRXL29Vqoc8L2aGePi38SKCUqMzSaBAAP0o1NknFhsnkssJYFZje3KRcFgcXzpPJUxLmhn7iom3Puu2rEiDT5PGHrvrNXJ+10Yu2GgvCZ1k2GcI9XJ0wzgmDQWDp2lLuBkbSaNyNQsEG+YM6Sgh+ZUH5BeZ7D9eXMR6/9G0HPnLvodHudvKeL5UUeW7Vd9FaEr/fJDGEjCdLKBQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(366004)(346002)(136003)(396003)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(36756003)(26005)(41300700001)(66946007)(66476007)(66556008)(53546011)(6916009)(107886003)(2616005)(316002)(38100700002)(478600001)(6666004)(6486002)(6506007)(2906002)(5660300002)(86362001)(31686004)(31696002)(8936002)(83380400001)(4326008)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2JJQWZ3V3NWTDBYNXcweng5R2dZMFNOVlY3S0FNZE12SkVSR0tMR0hvV2hM?=
 =?utf-8?B?c095YzhHaVJMNXhIejVUdEh0bisxalBzZFBEbGZQWFRrYURrRGF2a0ZBdlVW?=
 =?utf-8?B?b0tBL21uTGtlemJlUDZ4YUJ0L3lHUWFvK1lSZWo3ZFJiQm9ma2tnVGhwcHBL?=
 =?utf-8?B?OHVLcXF4Y3V4OFpTNnNwVlgvUnBpa0FFaTdoNCs4blZNYVRVT1NNdnduQTVj?=
 =?utf-8?B?alBRNzg4TFBNMTdVRzBnN3JGYjhFakpicG1BeU42VElrTGZhOTI5WXd0MVcz?=
 =?utf-8?B?bHhMQzNKK0pxc1dmNS9IMGR3N3Q3OW8wU09MeGVtK1l4eml3OGVRMitFUVNQ?=
 =?utf-8?B?ZXF4R2QxMFh5NFd6eklBZlhoRm5QallLVzFWa3A0UXg0VFlNN3NaNWIwMmVG?=
 =?utf-8?B?Q3MzTldOU1N0c1dwRGRXY2h6bXd2L09PMFNkOGpUSTMwMGdkeGFaS3BKaWZz?=
 =?utf-8?B?eGVRUVhpb2pkYUlyUElUUGdEVmpNNXoyRVA2K1lQbzVyVUpNaURIeENoZVJu?=
 =?utf-8?B?NFFqa2lYSWVVQS85aWJobC93dk5vZFlMREJEZXRXemJDcEhOa2J5V2FBdjBU?=
 =?utf-8?B?WStxSFBpZm02bjlKU1g5Q3d5TEp6UVZnSnAyV3dObzJkYTB6aTlPVUdpK0dr?=
 =?utf-8?B?YjlHM0toZTB0ZWx2MXBaLzJMTHBFazcwRVYxTzV6YVBmUW10QW9WSk1FQUdr?=
 =?utf-8?B?TmNEQWtydzZZNHhBQUkwaldaR0lsbEhwRy9ickg5RFowS3lGbWE5b3cvS01E?=
 =?utf-8?B?Ykt4Q2I3cnZ2RW1hTWhqNTUxb2Q1djBxZWFrVXQxSXNiVWRjQ3V3azJ6OUhu?=
 =?utf-8?B?SUpPNGErTTB6Rjg1SzFTSnFPNVpXdURnMVlMVld3OHdTUi9ScllyWlY0NzhT?=
 =?utf-8?B?QzVsY3M0SXhhR3JFSGdkYnYyMmljOWM1UWE3dUJsY0R1UFp0QWFmODZaMUd2?=
 =?utf-8?B?RXE0d01aODFVbVROeXE5TnpRbFRlWWp5NTRlMER1NTRZWHNEVTAvVUdPbklU?=
 =?utf-8?B?eDRmb05FZVRjaGx2N3p3aHFOK0o2YTNhcXgwdGRMMVpFU3BWdWVJY3laR3I5?=
 =?utf-8?B?bW1rcXRNYmJ6a2xLWmRPbUZoZ1JZNUtneGR2bWRidVFqSUw0L1lNU1R3NmVx?=
 =?utf-8?B?MVlqSEc4Mnd5OEcxclNQR21kZmVmRXZma2piNlN5Wis2MlFmd0NiakYwNXBE?=
 =?utf-8?B?WGtvelgydFZBaXV0NEllYWp3b3RqbG9UbGROL20raDRoNklNSk5JY2U4WkFw?=
 =?utf-8?B?N24vaDJsRXlwMi9vSVYwUW1jajRPWk05NTRrWkxhTktkd2RObmI3YzRBVWNM?=
 =?utf-8?B?T1FHQllxZG5HNXQzQVdGZDZhaElwazFHWXRqOTN0TEVNMHJmSlpLeWsrZFpa?=
 =?utf-8?B?b1laaFpwQWtTb3FMSHZhWURPczlYaWZ6R0N0VFNtR0EyMjhNak1keSs4dEhn?=
 =?utf-8?B?R0YrRzdzSjdKcFBlTmFZTlNuY09ybG5xR2hzTHdhcVZWMEk2dXFJWDFRa09Y?=
 =?utf-8?B?bUJpVUlqZVpjRCtkejEzeDlQcUVFS2pTS1luM1ZHb1A0dytFOGhaL0l0eDJn?=
 =?utf-8?B?UHdkT3pMNERvaGQ5NGN1RFcxVHF2VENYNGVQYTRLRHVWVTI1VWZDQjNaSnhi?=
 =?utf-8?B?bmlOTFNaNUd3VUptS0w1YncxSnJlSnV1cTJNSlVkdGkyS3ljYUIzR1R6d0dX?=
 =?utf-8?B?VE9YQnJZQ25RWnhPS01kUVVFL2JFamtmNjg3cTJZNmEvNS9ZdVl6V2NxcEY4?=
 =?utf-8?B?bkozeXdFTDk1YitPUmlXVHR4dFl3eG9GNU1qZjhWSE9ET2NYdEtJc2kwcGk4?=
 =?utf-8?B?WFZWdHowejZyWnZDS1A4UDlzVzVRMkVRZVlzYlczN3FpRnRCclpQUmVwWE9Z?=
 =?utf-8?B?WEIzM0hYS0ZDdCs2L0dFVm5vd1hvd1djbGE1V3l2Z2RoYmVNKzE0UTkvejlo?=
 =?utf-8?B?bmJCWmxXNzNhc29XYzVkMTV6bVJEZEpOOFM4eEdWdDhEVlNWTEdBNDhiR3ZU?=
 =?utf-8?B?NVdwUStvR2hNWGpKYWlxWTBYWXY2SjFpTUhWcHJMT05KbU1TaVliUTNLQ2I2?=
 =?utf-8?B?S3RubnJUVmRuMFpLWUgwZHRWZWNQNEVSUGVQQUs3WFhlaWFIYk1uRVRwZWN0?=
 =?utf-8?Q?T7hf8VBN23sWr5YxxPCZ9vM0R?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694c67aa-9e41-469f-81d5-08dbc2798133
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 12:25:31.9130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faGMFO6y7g84BiqOGvSV/SVu9E9x9sciaL8OdszqM+WifUy42ZE3gkyqS7A4M0Ks42Ruc1A84wOxfXXYsAGBaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8177
Received-SPF: pass client-ip=2a01:111:f400:fe0d::704;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.058,
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

On 9/30/23 22:31, Mike Maslenkin wrote:
> Add a check that destination file exists and do not call bdrv_create for
> this case.
>
> Currently `qemu-img dd` command destroys content of destination file.
> Effectively this means that parameters (geometry) of destination image
> file are changing. This can be undesirable behavior for user especially
> if format of destination image does not support resizing.
>
> Steps to reproduce:
>    1. Create empty disk image with some non default size.
>         `qemu-img  create -f qcow2 $DEST_IMG 3T`
>       Remember that `qemu-img info $DEST_IMG` returns:
>         virtual size: 3 TiB (3298534883328 bytes)
>         disk size: 240 KiB
>         cluster_size: 65536
>    2. Run `qemu-img dd -O qcow2 of=$DEST_IMG if=$SRC_IMG bs=1M count=100`
>    3. Check `qemu-img info $DEST_IMG` output:
>         virtual size: 100 MiB (104857600 bytes)
>         disk size: 112 MiB
>         cluster_size: 65536
>
> Parameters of $DEST_IMG were changed. Actually `qemu-img dd` has created
> a new disk based on current default geometry for particular format.
> For example for "parallels" format default BAT for 256GB disk is written
> to empty file prior writing disk image data.
>
> With this patch virtual disk metadata and geometry of a destination image
> are preserved. As another visible change of `qemu-img dd` behavior is that
> if destination image is less than source it can finish with error (similar
> to "dd" utility):
>    qemu-img: error while writing to output image file: Input/output error
>
> Signed-off-by: Mike Maslenkin <mike.maslenkin@gmail.com>
> ---
>    diff from v1: removed additional fprintf call leaved in patch by accident
> ---
>   qemu-img.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index a48edb71015c..1a83c14212fb 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -5150,13 +5150,15 @@ static int img_dd(int argc, char **argv)
>                               size - in.bsz * in.offset, &error_abort);
>       }
>   
> -    ret = bdrv_create(drv, out.filename, opts, &local_err);
> -    if (ret < 0) {
> -        error_reportf_err(local_err,
> -                          "%s: error while creating output image: ",
> -                          out.filename);
> -        ret = -1;
> -        goto out;
> +    if (!g_file_test(out.filename, G_FILE_TEST_EXISTS)) {
> +        ret = bdrv_create(drv, out.filename, opts, &local_err);
> +        if (ret < 0) {
> +            error_reportf_err(local_err,
> +                               "%s: error while creating output image: ",
> +                               out.filename);
> +            ret = -1;
> +            goto out;
> +        }
>       }
>   
>       /* TODO, we can't honour --image-opts for the target,
may be it would be worth to follow conventional
'dd' approach, i.e. add conv=nocreat option which
will do the trick?

Den

