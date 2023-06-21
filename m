Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAD8738E84
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:23:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2Tz-0003MQ-QH; Wed, 21 Jun 2023 14:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC2Tn-0003Ll-2L; Wed, 21 Jun 2023 14:22:55 -0400
Received: from mail-dbaeur03on20717.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::717]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC2Th-0005tE-Mg; Wed, 21 Jun 2023 14:22:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUQAEAjgv5Hgxab6HSaoWTRBQwWHUnwtiHFrKXsp1cmjc88ihyGNI+lNv5pKC8yiMYbbPTg9oifbtKu4apcKtXdXshetneaIZyOHlNQ1G4Mv5lbRQh/N+hDxh8ZuI/ZV6M5UGev5wijt8pBGc1pHzf1afN1boKveTocd24GG+LPHPwfAr5khjBbj7+s9DgI+6G74DBtLNQ1fgp/JbtFUP/pgvi10kOO/tOjU7KomrSnM+RYTE8KQgfh7kIVWDliE9djw/ZdtaWAXxJQrg9OKSEQiBivLNlCB/FRFNcKhKK+vcN8dGwVtEMctqq1W6IM+4KMs9RKqkuTmidqJ2/NBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltA4VK3G8fHEvWcPjb5O8cUBfV2aDJOWFfYyAzxDOmM=;
 b=V4BLQqaZzFop2F3QE/aE4veEHZaVewOq2EBTWeFSZQeViLRn53j6JFH8GM3IlBvewT1kS9fX4z31SF3vlEjmBOqf4QEEp8xQs1V/QWx0VL+ZFZiwTSzFyJcnKk3Njw+RUpmqFAcD4RSyRb4R+S41nJuAgHoeoxWVCLfGn9vXCzRNOFYvcTT0fwXBVhB0hLVGXGEAH+57PNMA5aS3uj/jGLtOPcu7ZNtVLowgEFl1wiOoC4+0NcVWHJ5dqvvb+RK4dAo65R3Sk2i/qN6d/AAesgE1JDdvRBJpRKvfyU29uNuY39AipFpiaOD9ADQus4KmGXXZkLdH59jAfn8lvtkQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltA4VK3G8fHEvWcPjb5O8cUBfV2aDJOWFfYyAzxDOmM=;
 b=dvtyDromkuiG5ejgY3nTclDh27uW1PvaCwfegSgTcWmyzelO1bd+vW5zUgY5n1rBcrB1nbWsK4yolv34M8OPM9dmezkbUL7GShu0vAIN9u39dj2ykzvoxi99vxJ6AjJx52pcT+HxUdyq6mftUhAE+fQRhsGYl0dvlbDaLu9QuIdg+pDCo6Y57OEgXyAcmYuZhDmdSThmYIT9xKUC6dpkU2p3EzvQLjHZOrtxjvVBecehfSRJKMCUpWrZZRGjN5V6C+OITvZVhCqX5L2V2TdEImTie8QgWBWMPFBCviqDRtCgjw10NeudxGwhy808dNh1GAZoJyJpsZsGDneCNhmShA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB6946.eurprd08.prod.outlook.com (2603:10a6:20b:345::17)
 by PAWPR08MB9806.eurprd08.prod.outlook.com (2603:10a6:102:2e2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 18:22:46 +0000
Received: from AS8PR08MB6946.eurprd08.prod.outlook.com
 ([fe80::1e80:70d8:d23c:9b65]) by AS8PR08MB6946.eurprd08.prod.outlook.com
 ([fe80::1e80:70d8:d23c:9b65%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 18:22:45 +0000
Message-ID: <e0927e6c-a265-8551-4cde-20f9dd50b8a9@virtuozzo.com>
Date: Wed, 21 Jun 2023 20:22:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/6] qemu-img: add compression option to rebase subcommand
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-6-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230601192836.598602-6-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0084.eurprd04.prod.outlook.com
 (2603:10a6:803:64::19) To AS8PR08MB6946.eurprd08.prod.outlook.com
 (2603:10a6:20b:345::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB6946:EE_|PAWPR08MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e31174c-12bb-479a-ab9d-08db728482bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8+KSeXASyKcoiwHsBs67vlFMmIK3a/lf9fjzwIGHadJAvffiyFroOX6AbD2tNvF6VaCutG7vrfQOags0WqdiQ4FP6Z4JLVqxyOsv4OuvCE8Wdg0B7aAmitgWVBXRlBgWoYeNiZZejHbi1Ta3NeSjgcQH4xTA4QfQabg1xJigahcGYzkm/8uykicbm5GTvitjd82Ll53wm4Ko7NSj7xg6l4hpHxMKQuDxLGEHf5D11BHd7vlQ1hXGpWONQoN6ArFmpcgWtfkpTU6ve083o8EqmIYPBtIKMMXu/xFVL31NZ5fbIYKk1Wu4MEjzzHToJpRxMr6q/qjqYhvbSE2sfl2H3/X4rwSLcIZB1PaxxU2WW5cWSdPgBuV4Zb1MDac96qdUA+pfhc68HgqgdxlKh+jkChGS5GyUilWr2bqUUF0xPAArX4w5fv5UqKzGp6SvyEf9vPXirJ+mmh8l0sgH/INXBWcTRW+MlbObxkDcHQZlKCXgXwPX1UuEtcjisd9i0VIZoF1z79Eom3Rsw4r5rZzEMTgLNoyOl9pffigfIBZSWYvMi3FtLIHfz4Kj0ETwolnNRFuwUVYPXsCx6Naq64ICtdi8WU1VYHmjH7NNQ37QcuohZ6bhMV7uZGYoxQEDlrz4SCtP3qeBBTQmIHP0qIFZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB6946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39850400004)(376002)(396003)(366004)(346002)(451199021)(5660300002)(31686004)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(41300700001)(2906002)(6486002)(478600001)(26005)(53546011)(186003)(83380400001)(6506007)(36756003)(2616005)(6512007)(38100700002)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzN2TmFkcTVWc0M2eHZ0MW9yUFM4T2FWVHZjTklYd0QrbTB1UTR3STVOSGhM?=
 =?utf-8?B?MENZRE5OZDJQUStqZk9YMGxCSUlNSzN5VE5INDN0VEhjVXpDdUliUWF5QU5l?=
 =?utf-8?B?RzdQWmd1Tnp2TVlhK2o4VEJtdVlQc01VeWxMWGljZGVXc1FqWlVyaFAxNlRm?=
 =?utf-8?B?YlphODEwTE5hR05iYlRqaSsybWd6SVpmNTB0amhJZHRZYVVncEkyWCs3TGtr?=
 =?utf-8?B?bzRvenhpSlJ0OWJzSDJEbldDNlhTOC9KaTFaTnR1VDlhRWREdzBlZ2QybW0w?=
 =?utf-8?B?UU5oOVdyR2t6dURuNGZrUWJIVUNrV1NFQ2J4dWFKaU1FbW8yKzRkc3VBbmdF?=
 =?utf-8?B?K1ZuOWVTVDlMcXI1T09JRnF2ZnlnTTVZY212MkVnbHlIMFd0Z2t6bFIxeFc1?=
 =?utf-8?B?MjQrVUhWTlpZRVVIRnRMYTV6bUZ4ZXFQSklUQ2pCRnU0ZUVuV0ErQ1BZdUJM?=
 =?utf-8?B?K08wN1ZhNHczVngrTkZPdzdTdGJ4MXBSSzVTOFVBWDZDVmpvYVJXenpMVi8w?=
 =?utf-8?B?aFNvdW04ZFBxNC9mWnIvam9uRnE3U01iZWhHSEJtdDlQajhDeUZ0eWlweGky?=
 =?utf-8?B?SnVBeWJyZWoxa09VSWo5KzNWUmkvbXlWclZodmRWN2VKdUxOcWVLMXNoa1lK?=
 =?utf-8?B?azladlJoeWhETlF0VG10THo1NzYvR1l2N2pMWFRIWjQvZitHRURmR3phdk5S?=
 =?utf-8?B?RFhnSk16MmFKcitjNlIxUFFodDRSZzNUUExiUkJmYjJ3cXZ2TzN6NGRXMjVq?=
 =?utf-8?B?SDE4a3E5R3hpZEhxNUVaTTUwSVFBNlU4QTYxdUROUGFCamYxcHcrY20yRGpu?=
 =?utf-8?B?QVd0dlFmN1lOSWhpS1lNYVNERm8zOXZSYUdKS3FvU1A0ZkdkbGpGZ04zMUcy?=
 =?utf-8?B?cWdZeDRaMUJQREE3YWFRdG5PV0c1ZXNyVG5EZlRGSTBSSHZxcDRuVE1BL2VU?=
 =?utf-8?B?RkVDTmZwSFV4c1YyZzhSbWdzR2Q3SnQxQkIwdm0zZzdLV0tUelRMQ0R4cnM5?=
 =?utf-8?B?aG5QY0k3TlBDemNMWHRocVJKeTF1RXRheE4zSjh1a2JlWkV0bDhsV2dqb3Nx?=
 =?utf-8?B?dmRYZHFDL0NOMnVyMjA0MEFNb1J0MDBmdit3aGkvRm1lWlJvMkpPQTk0c0dl?=
 =?utf-8?B?c2VzMFlQQzlOZkxBdGtlUkJsR0M3SS8wNk40SFU2bmZQQ2gvcWtUejNqK3g1?=
 =?utf-8?B?Z1RQaVFHOEpiT051VUE1dWtNa2dlenZDK05xc240WmRmOTk5dXIrdjBYTit1?=
 =?utf-8?B?bGRoYzNTVitXQkZLREZsckllamZjOW4xQXRWSUlZTkcrZVVzSzJOdk1tUTNR?=
 =?utf-8?B?R2d1NzVVRjFJb1lYMys1blF0bEdyUDZwNzFxYmZlVjBOS2NJaTZBckZraWd2?=
 =?utf-8?B?d2drelprUjQ3bEFZS1g3eERoL0E3WGJHU0RwUnkwMGJBano0RjI4d1ZUVGRw?=
 =?utf-8?B?VWtpTUpQNmpQNjc5aXdWS2t4dkNYeXZyc25McUhFb3U4OTZnSEsvOG8rbE9r?=
 =?utf-8?B?UzBYWVFlRVU5WkhaSXAyYUlPVy9ldVc3aURWTWpyQ2VkVlROOWFubmsxVERU?=
 =?utf-8?B?ZktiUFRsNSsrMmdDRm1KVXYxTGR3citFTDl4Qm1NMGVnOXlyRzFpNzNmRUtl?=
 =?utf-8?B?TlJTOE00djNjdEppei90WHphdk52cDVOaWUzUEcvZktaL3dxTDgzSWNTNk4r?=
 =?utf-8?B?UGpQbGg0TUtZTDFBYVRpUGNtMTFxZTNYMVJMb2NpMm5xYXBYdEd1blVGL0ZZ?=
 =?utf-8?B?ZFgrQUFkbmpGajcwV3VST2k2eE1GY3ZvUlF4bWhFKzhMU1dKdWNLS3pQMVFk?=
 =?utf-8?B?M1lDUXV3RS9jSFE1MFdYVHo0RWFZU0xZZEozbUVKY1N2UHZrOGhNeE9MS2hB?=
 =?utf-8?B?RzI5WTdBTjZ0KzVNSjAzMFpNUlY2M0ExbG11TmZkWVZYYjJoWVJnS3o5WGgw?=
 =?utf-8?B?TllrdDF5RVNKRmFLbys3eTRtbnRoOWJSckRJZi80Um11aWxCKzJJM0tGYzF2?=
 =?utf-8?B?NE1CZzB6ZkNRUlFzZUZvcEMrY3pvWVdWY0FDQURWUGxCM1pybzVEQ3NlWkhE?=
 =?utf-8?B?Y3Vtc3NZcFpORTdpbmM4MlpUYnRPWE9JZ05od3M0emIrT3hBYWE3RnJMWHd1?=
 =?utf-8?Q?Pm0lMi2KszE8A2+KzO54s84cE?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e31174c-12bb-479a-ab9d-08db728482bd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB6946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 18:22:45.9302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Okc6kMv+ubCxNlXiLm5l6YcIw06vTlTFc3nJS2UW5UeEjqSMcbGbPimRxlW1aCfR3VZKvybhHEUZ96njoMyb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9806
Received-SPF: pass client-ip=2a01:111:f400:fe1a::717;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/1/23 21:28, Andrey Drobyshev wrote:
> If we rebase an image whose backing file has compressed clusters, we
> might end up wasting disk space since the copied clusters are now
> uncompressed.  In order to have better control over this, let's add
> "--compress" option to the "qemu-img rebase" command.
>
> Note that this option affects only the clusters which are actually being
> copied from the original backing file.  The clusters which were
> uncompressed in the target image will remain so.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   docs/tools/qemu-img.rst |  6 ++++--
>   qemu-img-cmds.hx        |  4 ++--
>   qemu-img.c              | 19 +++++++++++++++++--
>   3 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 15aeddc6d8..973a912dec 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -663,7 +663,7 @@ Command description:
>   
>     List, apply, create or delete snapshots in image *FILENAME*.
>   
> -.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] -b BACKING_FILE [-F BACKING_FMT] FILENAME
> +.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] [-c] -b BACKING_FILE [-F BACKING_FMT] FILENAME
>   
>     Changes the backing file of an image. Only the formats ``qcow2`` and
>     ``qed`` support changing the backing file.
> @@ -690,7 +690,9 @@ Command description:
>   
>       In order to achieve this, any clusters that differ between
>       *BACKING_FILE* and the old backing file of *FILENAME* are merged
> -    into *FILENAME* before actually changing the backing file.
> +    into *FILENAME* before actually changing the backing file. With ``-c``
> +    option specified, the clusters which are being merged (but not the
> +    entire *FILENAME* image) are written in the compressed mode.
>   
>       Note that the safe mode is an expensive operation, comparable to
>       converting an image. It only works if the old backing file still
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index 1b1dab5b17..068692d13e 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -88,9 +88,9 @@ SRST
>   ERST
>   
>   DEF("rebase", img_rebase,
> -    "rebase [--object objectdef] [--image-opts] [-U] [-q] [-f fmt] [-t cache] [-T src_cache] [-p] [-u] -b backing_file [-F backing_fmt] filename")
> +    "rebase [--object objectdef] [--image-opts] [-U] [-q] [-f fmt] [-t cache] [-T src_cache] [-p] [-u] [-c] -b backing_file [-F backing_fmt] filename")
>   SRST
> -.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] -b BACKING_FILE [-F BACKING_FMT] FILENAME
> +.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] [-c] -b BACKING_FILE [-F BACKING_FMT] FILENAME
>   ERST
>   
>   DEF("resize", img_resize,
> diff --git a/qemu-img.c b/qemu-img.c
> index 9a469cd609..108da27b23 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3517,11 +3517,13 @@ static int img_rebase(int argc, char **argv)
>       char *filename;
>       const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
>       int c, flags, src_flags, ret;
> +    BdrvRequestFlags write_flags = 0;
>       bool writethrough, src_writethrough;
>       int unsafe = 0;
>       bool force_share = false;
>       int progress = 0;
>       bool quiet = false;
> +    bool compress = false;
>       Error *local_err = NULL;
>       bool image_opts = false;
>   
> @@ -3537,9 +3539,10 @@ static int img_rebase(int argc, char **argv)
>               {"object", required_argument, 0, OPTION_OBJECT},
>               {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
>               {"force-share", no_argument, 0, 'U'},
> +            {"compress", no_argument, 0, 'c'},
>               {0, 0, 0, 0}
>           };
> -        c = getopt_long(argc, argv, ":hf:F:b:upt:T:qU",
> +        c = getopt_long(argc, argv, ":hf:F:b:upt:T:qUc",
>                           long_options, NULL);
>           if (c == -1) {
>               break;
> @@ -3587,6 +3590,9 @@ static int img_rebase(int argc, char **argv)
>           case 'U':
>               force_share = true;
>               break;
> +        case 'c':
> +            compress = true;
> +            break;
>           }
>       }
>   
> @@ -3639,6 +3645,14 @@ static int img_rebase(int argc, char **argv)
>   
>       unfiltered_bs = bdrv_skip_filters(bs);
>   
> +    if (compress && !block_driver_can_compress(unfiltered_bs->drv)) {
> +        error_report("Compression not supported for this file format");
> +        ret = -1;
> +        goto out;
> +    } else if (compress) {
> +        write_flags |= BDRV_REQ_WRITE_COMPRESSED;
> +    }
> +

minor neat-picking. Should we get a global
if (compress) {
   if (!block_driver_can_compress(unfiltered_bs->drv)) {
      report_error
      goto out;
   }
   write_flags |= BDRV_REQ_WRITE_COMPRESSED;
}

>       if (out_basefmt != NULL) {
>           if (bdrv_find_format(out_basefmt) == NULL) {
>               error_report("Invalid format name: '%s'", out_basefmt);
> @@ -3903,7 +3917,8 @@ static int img_rebase(int argc, char **argv)
>                                               bdi.cluster_size);
>                           end = end > size ? size : end;
>                           ret = blk_pwrite(blk, start, end - start,
> -                                         buf_old + (start - offset), 0);
> +                                         buf_old + (start - offset),
> +                                         write_flags);
>                           pnum = end - (offset + written);
>                       }
>                       if (ret < 0) {
Anyway, for both variants,
Reviewed-by: Denis V. Lunev <den@openvz.org>

