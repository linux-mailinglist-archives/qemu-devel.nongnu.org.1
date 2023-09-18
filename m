Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 760127A48C3
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 13:52:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiCmm-0000Oc-Kd; Mon, 18 Sep 2023 07:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiCmk-0000O7-Pq; Mon, 18 Sep 2023 07:51:26 -0400
Received: from mail-db5eur02on20728.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::728]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiCmi-0005lj-Qy; Mon, 18 Sep 2023 07:51:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFlPJ25Y5+2/O80HeL5ySJX3VNTdusgQjBSlCYZ+r/xfzslETMfLOII0OiN+4dk9w6ibZqDxrIF1j8XYhRBR9FycQyn5sLDCFYL/oT6MH2pjKA97OXAc7JgrkvUjO8DHYag+zNLoqDL8k6u9EOLTrtSJvdYLpJ8pGzVblvrLMZcgT2ZccX07FuHpYDvyTNQLLXnrL2FFKRl0VPv+ae3HAcI627Zz6Vq4tdp6Y9lsTzFfOFWZstrWT2vunmYQlsSHsBiDhkLCPM0sW77DEU0rYSsmNZ5zjxlJyd29HSN9tO0Rw8t5CytXsqMlXj98I3khJZa2kO45P4iFivzanxgKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPCJKm4AXq+Ozdsp+zY9E6HzJymUe8bxU8xkze7GqSs=;
 b=Oi8asR2iN3d7XiBQP6tYy7cMFwKPywgtyqIm7LiKtF0KRzJed6agVnKQuoN9Mu97G4eoWH8+CTkjIgJipWd3/IN+pcpZNcOc3nathwN0M2AOjJa1NQa6R5zOyiVGwG6lbepdPVohtMg6pctPURAXH5adXkbaNSlswhPke4xJ0hmXv6TjAqd9yE8gYbgonBwunfOIR6tSHaab8eA3fW4pmyc35IxkJ4gGvpslj0x0tQvsVf1eww09bYINRuOMxL3XIQvTIl7ztqSjOCyIEZ2s6wVXdcGMtcTlNy1GUWwR0A4p5yVIN/r0/rvcLh+hOl+IFGuYqnsfHnDx7uqUo14o1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPCJKm4AXq+Ozdsp+zY9E6HzJymUe8bxU8xkze7GqSs=;
 b=vZjX7TBTZ9J9NoLM0tIsdBONpZ2o4FaLIzCf1C21orsSB4UqBaJkAt6OvhAgRuMW8GvUDT+oLN0liDs6OY3/GdaDVZFzHnHp16FrBuwO+Or2crvlCMe1YmmUxqvQdE3NSN9oC9+V5esBCfo+OsvnB6cjnNCkLXODGi7MVVbIS5+XuZWTOuBa7LA7YQztYbqhQPspIPxQPPKTSPT26Ovo+AHtO2pPy81Ae2UvXStUcWTp9X0IR0dJ8Y2JeXBGvAc52rUHUNTZEm1dXjXOz1p4U+LlBO8/KoUOj103XsZNYN0PZqfKZUA3IIOOiYx18nk3xVgk1gXwnF5BCvxVQEdmnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by GV1PR08MB9940.eurprd08.prod.outlook.com (2603:10a6:150:3d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 18 Sep
 2023 11:51:19 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 11:51:19 +0000
Message-ID: <e98978a6-4dc2-cce9-3ea6-9760c9d60f16@virtuozzo.com>
Date: Mon, 18 Sep 2023 13:51:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 13/21] tests: test self-cure of parallels image with
 duplicated clusters
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-16-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-16-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0070.eurprd04.prod.outlook.com
 (2603:10a6:802:2::41) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|GV1PR08MB9940:EE_
X-MS-Office365-Filtering-Correlation-Id: d442fa1b-aba6-41d6-3088-08dbb83d92b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r53FG7Yg5VZIIbs30b2hEEOqfeO8xWKKXkJ3e/fyU799KX+khzhYWNtUzU7en0EOHtuKJ4BT08ieXTx/Ri0wE3kE+VIZkwgKL1fktlfJSyS0ADuixi3x9B5k+IUkNXwe4fjlJV7iXoNQSKBX97PYBc6tyXXI9IrUNyqI71+0I/l+EeLueE6wWDKxg+OhFaxay3pBms5WeVTetf+EWPpMXeqtoKqya5LeaewbS+se2XN7LvO1ky6gK0VIFXjRfjBFOOxz3+21dY2SuGpZQOL37RIRoB4Lb0Tjb3gIAQcjiV0wlNeLHV4DqUplqttGtJJr7/lHYVUzMzAZ+/7xKTWfIsuFIRq6VfziZYZA0kNUpPRLTNzwsxyZw2vzVsOmDj/Hw9n+4+oeAUM35Zecp94fuWZxL2/kgsF5FtekrZSBlBHlqhfxiIu35bDn4kCam2XVyvRpY2IYqfhkZcBnLsSGz2K+fEIYUtQutv24RHY9dwXxYXe+5I0Og2cG0oMUnhqo1jCVt3rd8FRXuqdt9pwypX/6e9A3hPW2XckNI0MwU+BH+JLIPSapK7iE1OcW4XMbv9rqHFzkSZcgsZnaNjRZ397I2+Bdge3Gzw8uqBjTzxkPDT6so5UlfaGg20SHWSCo729ij5czLQGMTaNxrfi+24++1LyX3ajPyBcrrD9D4hvc5mmkDfguXO1Vx2e7QhS382lbSfXrKDUdXRpqf9kFYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(376002)(136003)(346002)(396003)(366004)(451199024)(1800799009)(186009)(66946007)(6486002)(2616005)(478600001)(316002)(66476007)(66556008)(6506007)(53546011)(41300700001)(6512007)(8676002)(8936002)(26005)(5660300002)(44832011)(52116002)(31686004)(6666004)(4326008)(31696002)(2906002)(36756003)(86362001)(38100700002)(38350700002)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M28xZmwyc0d5OVhKYTVpS0ZGV0ZjVFV0Q2JFZnBqa05uMmI2UURPNEtsVTha?=
 =?utf-8?B?VVpQTklSb1dNVXFKR1hJSkJ4NkhYVmo4Rkt2UFZIU0lxMW9VaE12a1dPdFdF?=
 =?utf-8?B?bmZKUDVmY1Q2Y25Ba25hN0NNUDkvT0cyakVISFppQWlVSExxOEVYVlFJVGJ3?=
 =?utf-8?B?Mi9qTGRZdzFrc0dDQUZ3SHlpbkJjYUNPOC92K3hEQThENUdJMnFWZEQrb05L?=
 =?utf-8?B?Yk5ENW15MWpTNitnZjh2M3hBSFVrbjhRbTIzK0hoRTlVMXQyam9JYmR6Z3JK?=
 =?utf-8?B?aXpJVmV6Uks3M2FNalFyNWRUNm9NUzNrZnZIVFcxNW1VMWJySWNwRHVtRHNL?=
 =?utf-8?B?aFFsbnBjeHlrejllcEZBamhCRGNwOXJvS0szakpEQ3RYSVpIWld1dzkzLzlQ?=
 =?utf-8?B?eVFvVXoycEdUY0VWVEZ5QTlLdmorM2VQcXFucXlKaThmd3lIZ1lGb0pEQzI0?=
 =?utf-8?B?dDdSc3kzbUFHeWlsNHJNcmowRG5rdTE0RXhiekROc0s4OXNXQUVpK0Y4eWl5?=
 =?utf-8?B?Wm44WWwyeHVneDZReEN3VFpYQXc5dlV2UFVtVzdZeDJQR1RvVDRpTUhVb2Zw?=
 =?utf-8?B?ZE9zY0kySGFyaEVFMTBQOGVkOXQ2WG1Yb3RaWmtiNTFyTHNhdHpVcDl2QUk5?=
 =?utf-8?B?YlpUcWFkMHFQYzJHazJsdnJhdmxZQjRpZkNxandWbk5GUWhPRTl0OHZXd2xP?=
 =?utf-8?B?V0g2RTFWbGFrMVFkaDlxcVNUVHRRcWdyRW5RdlgxVFVna0tMNUY3N3dWNUdp?=
 =?utf-8?B?QW4vK1ZvSDUwekxMVTFXd01MOVVTNEtTVjNKN0pXUG12dHB4VXRQSWMxOFhU?=
 =?utf-8?B?cU1yUWJHaDRoK0xHM2M1WFlwa0tORHE1T25rUHYzQzRVT1RZUXM5LzJLREFZ?=
 =?utf-8?B?M09NWXBOQ1ZkL0hUMjBTYjR0TDdlSTlVQUJkRHN1QmlqZjRTWnAzYkR1VllW?=
 =?utf-8?B?VkpGSjlTRDZNZXJUd1JHbitMcFIrbzZGOVlxR1gzeG91dnQ3aUlyWjJ0RE9w?=
 =?utf-8?B?UjdWMGJKVmZzRzdETmhlK2lha05ZUXpJUkhPWkNzQzdCY0Z5b3VHcDFLV0pV?=
 =?utf-8?B?Vk9GYkJrVzY4RjhPWDN0SVNDRHViSG41OTJoQ1M2cXhSK2RNclVwSEs1eVdj?=
 =?utf-8?B?SmcvdkFIZ1Z5SlM1d3dMYm03UDVEMmdEcFBIV0ZSdFFnNFBSUEFzd0FwWEo1?=
 =?utf-8?B?OXhmS0E3YmFOcFgvU05SbnBYclJlVEU2YUFzVkFVUEpSdjFGczBNS0V1OExE?=
 =?utf-8?B?YjZSZVBqdm5PcUU5MU0xUy95d1lqcGU0Z3Rud1hSd0h0UEE1czJUU3FSNUw3?=
 =?utf-8?B?dDRvcTZ3Uis0bC9LV3Z4TElqdjN3RC9wbGhKekt6L09EejlzTzlCWFBCRDN3?=
 =?utf-8?B?QXpiWkFZNVRHV1FEdVZnNlg2TWlXb3JkZ2dUSWMvS3M3b0w1eFlIaGFCdHJj?=
 =?utf-8?B?cGlzamE5V3BMSG9YZDhDNWpRVmpvTzZCMlNWQ015REhyWEtpUHFoM3NJalZB?=
 =?utf-8?B?MHNIRXp0UUtrSVV5cmc3K3NTN1p6bzdaSGwvekZZZVZKZWNQbzFxZTBiVXZB?=
 =?utf-8?B?UnB2MUwzeEdHcXdoU2NjRDBXdlRmK01MSXY1bFlPSkk1SWgrQkFTT1FBQmcz?=
 =?utf-8?B?OURxdndxLzBlQm93MDZicWdlRGRCd21qT253SHlEd1JQTjhBdk1VTEtWYklZ?=
 =?utf-8?B?SU9nRjI1bm1rOUc1MUF6ZVVlMm5tWkNPdmlIYUhzQkhwUDU3VHRBWFUyMS9P?=
 =?utf-8?B?WWcxdTRxUTFCYlpoQ1JzOWlKRTJheGpBMkc4bnQwUWdPZUdQY2VHTkZucWFk?=
 =?utf-8?B?TkFtUGxiaXhJaFpJMW9iUmlkeFFHdGYxVXRVemFVNkpYL1RuKzc0UHRvb1Iw?=
 =?utf-8?B?Mzl5WG9MaGgrWlJYUEx3ZE9waUF2Z1lWQkV6azNNTTVocGZUUmVjTXREUGRT?=
 =?utf-8?B?K24wVUc1ejg5dVVwN0NFL2Qvb0NkcnlmbkVGekdsY1I0YVU4a1RHRTdRbGZR?=
 =?utf-8?B?ZklLU2hwTVdRMktoUFMwTDBKUFYzejU5RWtnL3Q5ZTJ5dGNYOEdwM1pCS01z?=
 =?utf-8?B?YkVFMVhuWmowTUhDWjh5ajE2Wm9sMEFFYXJtUXlpRTdYcWFRYzJsYjFhTnFv?=
 =?utf-8?B?K2hVSzZabDlUOVorL0RybmlCL0gxV2F0UHduMUVxZ2VLbnVMeTFrbURZTitn?=
 =?utf-8?Q?zXZ1dtC4i566vStUVoGlRZw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d442fa1b-aba6-41d6-3088-08dbb83d92b1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 11:51:19.7586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vwl+MA8TzgXcXPyx/3gEGctVGaCm2z2sxuumjhFIguqkrTRHeI4gGzcLts0qXuD9CMoPVFsCTeJrJqojt9QnmpGGAX/Z0B2+n9sYegHtSZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB9940
Received-SPF: pass client-ip=2a01:111:f400:fe12::728;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
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

On 9/15/23 20:41, Denis V. Lunev wrote:
> The test is quite similar with the original one for duplicated clusters.
> There is the only difference in the operation which should fix the
> image.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   tests/qemu-iotests/tests/parallels-checks     | 36 +++++++++++++++++++
>   tests/qemu-iotests/tests/parallels-checks.out | 31 ++++++++++++++++
>   2 files changed, 67 insertions(+)
>
> diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
> index df99558486..b281246a42 100755
> --- a/tests/qemu-iotests/tests/parallels-checks
> +++ b/tests/qemu-iotests/tests/parallels-checks
> @@ -135,6 +135,42 @@ echo "== check the second cluster (deduplicated) =="
>   # Clear image
>   _make_test_img $SIZE
>   
> +echo "== TEST DUPLICATION SELF-CURE =="
> +
> +echo "== write pattern to whole image =="
> +{ $QEMU_IO -c "write -P 0x11 0 $SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +echo "== write another pattern to second cluster =="
> +{ $QEMU_IO -c "write -P 0x55 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +echo "== check second cluster =="
> +{ $QEMU_IO -r -c "read -P 0x55 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +
> +echo "== corrupt image =="
> +poke_file "$TEST_IMG" "$(($BAT_OFFSET + 4))" "\x01\x00\x00\x00"
> +
> +echo "== check second cluster =="
> +{ $QEMU_IO -r -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +echo "== check the first cluster with self-repair =="
> +{ $QEMU_IO -c "read -P 0x11 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +echo "== check second cluster =="
> +{ $QEMU_IO -r -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +echo "== write another pattern to the first clusters =="
> +{ $QEMU_IO -c "write -P 0x66 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +echo "== check the first cluster =="
> +{ $QEMU_IO -r -c "read -P 0x66 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +echo "== check the second cluster (deduplicated) =="
> +{ $QEMU_IO -r -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +# Clear image
> +_make_test_img $SIZE
> +
>   echo "== TEST DATA_OFF CHECK =="
>   
>   echo "== write pattern to first cluster =="
> diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
> index 1325d2b611..9793423111 100644
> --- a/tests/qemu-iotests/tests/parallels-checks.out
> +++ b/tests/qemu-iotests/tests/parallels-checks.out
> @@ -71,6 +71,37 @@ read 1048576/1048576 bytes at offset 0
>   read 1048576/1048576 bytes at offset 1048576
>   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
> +== TEST DUPLICATION SELF-CURE ==
> +== write pattern to whole image ==
> +wrote 4194304/4194304 bytes at offset 0
> +4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== write another pattern to second cluster ==
> +wrote 1048576/1048576 bytes at offset 1048576
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== check second cluster ==
> +read 1048576/1048576 bytes at offset 1048576
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== corrupt image ==
> +== check second cluster ==
> +read 1048576/1048576 bytes at offset 1048576
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== check the first cluster with self-repair ==
> +Repairing duplicate offset in BAT entry 1
> +read 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== check second cluster ==
> +read 1048576/1048576 bytes at offset 1048576
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== write another pattern to the first clusters ==
> +wrote 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== check the first cluster ==
> +read 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== check the second cluster (deduplicated) ==
> +read 1048576/1048576 bytes at offset 1048576
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
>   == TEST DATA_OFF CHECK ==
>   == write pattern to first cluster ==
>   wrote 1048576/1048576 bytes at offset 0

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

