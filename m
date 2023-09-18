Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 319E47A4B88
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:18:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiG0B-0001hX-LL; Mon, 18 Sep 2023 11:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiG08-0001gQ-FB; Mon, 18 Sep 2023 11:17:28 -0400
Received: from mail-db3eur04on071b.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::71b]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiG06-0001xY-7S; Mon, 18 Sep 2023 11:17:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP+WOk6a/V0j2NpsX/j/pzyb2ECtxMZQKLQ4ltCWlWxOq2fxRjVoWM5hM3JwXAehr3sxKNPYzp86PLLz3sgOCy8fUMx8H7divsOIchWeapPHrX5VblhysuNu5WqaOHGc09twRtZtOk+zQ7VGm5UwhTW3Q5jUdN07FrdG4fS+j6Fwg/G9QYSXexg92+1ByZPm9eLtE8oyX4K8Oz3cmiVBqqgwMV0gYxw/Yp2N/P32Cm6SgVXi6YV7f2mwBfiCZrlw9DS3PrlizbeP/pXH4KQHGa2DC/Ftj2+CVU0pSx2hSuNcnOMFvVr/OoLZgZBf5d0YCjZn+RmcCeBWmjo0WDmGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sn0Kp1Swsvrkbw83kPlYvSjyODXbx0V4sQr1F21518=;
 b=Rc4w4/oNKivo+oiDtYNRb86gSn2yQ3xQ2ICzrKK8ytx9hR9h4Yusz6mL50dUuAd4iI9FlTt35cH7qfmNS5d+HsZft5zZpF5xbOasZNzTky0bCUdak3sfVu8rRy2jS15neBIbwlvS5yDP2tmLghbv9yYgoAbYqLa5e5ilcqLHepDDMVaYP+4+no2OfhMYtlaPajMDFav9Q2T+A1Qu6mBsECfi7LHC2X1l3mGH7+FIs0nimRE9dSs14wfJzk4MS2fFgkqaO0wcI57JtlgIy6a9I5+fU+Ox2J2HUhGykFqMV9hM8pHMwTAhPjSRjER7qLa6W+x0nLz96L1ghNmK8U6EEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sn0Kp1Swsvrkbw83kPlYvSjyODXbx0V4sQr1F21518=;
 b=f+lZv9HQ/x6i4zyCCNzA9yDRt/LQUn8nISF5wFPn0dgoTusMJ33cq1BBLQ3Q4ZkysedUEwOUptjnH2ty2nIVdNSsehcVx7KNGfk2kIyLGw1UR+EtgkS7hnoMEXsYoUj1brPtspPc3PenlzDXzaosigR35nt+m5fqvyAyNCIrCycQsUhvODxaNVTe6D6pZlMttZCjUOk+UIv4k3whrq5lbsPvyoMS/dKlozvORphU2F8oZYwEYr7Uwbv9SukatI7ZpcTr/e3mj6hDEAwgcP2d+8ypeMZwPUThCdrSzjng9PWb+leoSCn26duFkjbzl9sYYUPXJO9CYPf1a6ipyueOVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAWPR08MB9056.eurprd08.prod.outlook.com (2603:10a6:102:333::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 15:17:22 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 15:17:22 +0000
Message-ID: <7f996c5a-63e0-3619-87a4-87cccf8b2101@virtuozzo.com>
Date: Mon, 18 Sep 2023 17:17:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 21/21] tests: extend test 131 to cover availability of the
 write-zeroes
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-24-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-24-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::31) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAWPR08MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: b01dd5e6-0e71-489b-d563-08dbb85a5b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Av85fu3dXnF3bRquhKTCnMm7uBiTgmcEmygMkjpb4mJ9X7eQ6SeU11tb/jTOVnxt4foVcww6UHVYL5+A7C84Z2dQ1IWz88PxbwyqUmcZdmxwIGNAE+Ka8N3HfDOSmVz/40qw5Qp9pQYKyRUvB+2GKRLye6unk7DduAr2w/07adkuzgLIJIisbNxpLQhXuVafapbvKb6SP51T7Lwh3Q9SgTp5Oh9BnoDb6ur5iIzI+BL0baZ6D/8BmGtdBF8/dKZXhUgTmPClZEWfJ5gqeejOtCFhzcZB7jiRAkXRkbZ3ywluz0WFlKhowapiXIeW2XKsrfBVf65Sr8ubH+3PeVYz3qtgDOlgVFMxyj0UNg5MO7VjFAlINzt17OBVqPw34x/aRVpdBt7NDd1ezTNuAB3IprJfLDmjYFCLN2o9IQuW/4CTQ5jZ8eoSc5BBrNWnVy1rdsusoEtpX2nF3qcQpmBWg+XFUKOZ7U/XhlrN7fWEWgGNg1VHjYHIyJ2YtO/h5tbHOCLmjjfTCP/MFgsK6nZRCmalu/WlFYPXF+yHhkRVZhuk4ciN29OZrq+UXnrYEvdKPHx8D5PIEdwZbBRDyRzzwFT7NbzslQpsEan6+IzFLho3SmO2hJnKGsQiVMp07Y6uCcdKVtWX7SWQueY0y7Pwe1RFI0DPhxXIIUj5ZeqTQifKfDrd4kZrCH2DzXrZ872NzCJx/RVYQgnYkjE1BHrqHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39850400004)(366004)(136003)(376002)(396003)(186009)(1800799009)(451199024)(26005)(8936002)(2616005)(4326008)(8676002)(83380400001)(2906002)(36756003)(31696002)(5660300002)(44832011)(86362001)(53546011)(52116002)(6506007)(6486002)(478600001)(6666004)(31686004)(316002)(6512007)(66946007)(38350700002)(38100700002)(66476007)(66556008)(41300700001)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1ZyMTFwK01XNHM0Mlp0WGZwNXpZcS9XMGE3eXdyakp0ZnJlZ1Y2RzVNbFVW?=
 =?utf-8?B?dkZjSnRiWmdJMnNlT05vMTZXcXc5Vm9JZUpDSXA0S3RmMWFUZkU5UUVsUFZs?=
 =?utf-8?B?b1hsR1krUXJMbFp3VkZlSm5LTzRrMWdFNXI1NHh4U1d5M1V6YnpMK1AyVEZG?=
 =?utf-8?B?bGNINy9ZS0UvNU1hTWJLZWtrbk5WdWVnMmJiTFRpNk9LNldGY3gvUW9YbDFV?=
 =?utf-8?B?WEhMQmNOdzVEQVFRdzk1dk9oakZRK2RTU2g3dUk5cm9lQU9FNWxqSjhFY2cr?=
 =?utf-8?B?c3dVaDV3U3dWeHUzOG5DckhlK3NHNDVQUHFLUXYrMW9uR2xGTXNSendHNGZU?=
 =?utf-8?B?WXRxeDNGV0d6QTJFQzVIMlFUVDVoRnNveU1PT01nT3ZpbDVCL2hiZldDcHBq?=
 =?utf-8?B?Y2xPeHc2TGJTdC9YU0RndnU3VHk1RXZIREV1WFJKbkFNNHp4MmpMcnNlMERw?=
 =?utf-8?B?WmVjNlRYZmVkR3pjWTZwcDNjWDZYQkpsMHNhM01DRytzL2tWZ0o3cjZ5K0JO?=
 =?utf-8?B?K002MnZSNFlEYjNFTFhZTnVQUGkvSzZPZExsMi9JYlh0a1dDdlh6TURmRTBE?=
 =?utf-8?B?Yi9EMERiNGFmWlZrLzhSUXZ6UGNQSzgrTkRLcW1sckkzNTVwb2dnb2lmR2FT?=
 =?utf-8?B?TkppUEpjN1p3YmdBNWMxTEFPVSt1UGhvbmtiZnlDTlhPbnYwU1AxM1Z0QThE?=
 =?utf-8?B?TVFyTjlwZFdmRGw1bkZ0amc5U0t2YUFXUjlvZndDa1QyZHV4VGczK2tacFZH?=
 =?utf-8?B?L2V1bmdZUWVkeEJqbDJSUm5XV2FhZm0xcWUxcjIwT0NCN1JKKzRuUXFhS2Rq?=
 =?utf-8?B?SmpveHpQVHR1N3o1a3E5RnBDdXBwd2JyQzNPV1FVNFBlbEllVHhwb1JlL2NV?=
 =?utf-8?B?cm5QSUIzN3hpVWtOd0t6UzB6Smp3VTFlcW9xYk5wcy9kSlJDaVZsbmhiNSt2?=
 =?utf-8?B?THNaRkNDS3lFRTQvK0ZybzVEN2Y0VG8vM2c5MGdPVmtxeWVUMGJvbXpZeE9u?=
 =?utf-8?B?UjZYZVY0MFFNbE5LRkQ0akRET0ZZSEJscUpRakszWWRMWnFVSnBLcUJIOGdT?=
 =?utf-8?B?dk0yZDNKTlRFQXR2VlMxMzh6djJyTm9jM3k1Y3JOcXRJaXF4ZzBsS3lzUHdp?=
 =?utf-8?B?cHBzSkRWcC9aSW1RcnhBL1Y3RVhxYTZsTVNnZ1RBK3U2eFBRSXFQTVRBdlVT?=
 =?utf-8?B?NnVxaE9xT2dlM1BJWml3aEtsb01KSWVYMnZVRndaN0N2OHZyYzNOY01walBk?=
 =?utf-8?B?Z21BYml0ZjlQYURmUXpaYTFqSXUvOFdOUHRGaTZPdEVpU09xRGE2OVoyOTVa?=
 =?utf-8?B?VlJDRVNUMDV0SFlHMVErZmhtamMxTmx6U1JmWmZqQ1hYaDNyYXhFUXg0WGRG?=
 =?utf-8?B?MEtsaFVVSjJUZXk0SVM0ZlZuaEVoZ3J3UHpBaytydUtiMVRwS2x0RVRSWTc2?=
 =?utf-8?B?c0Ztc0x5dVhLMlc1bUllb0xEQTd4SHpTQ2UvNVplMmo5anlxcWVPWDB4M1pi?=
 =?utf-8?B?RzdHakdlejZ4L2ZyaTh1anNtSm82emliWDdiRDNjaG5WWnk5VDljTmd0bzl5?=
 =?utf-8?B?dkF4YUkxeU9nUW0yUVdFY09nZFRVYTk2N0VuUE04clVaVW9kVDQ3VmtRREVE?=
 =?utf-8?B?VG5sWTNYNjhLa2tPeG1QU3QxZi9nT1FVaFNIOXUxSzY0QzR0aUJWTlVGTWZD?=
 =?utf-8?B?MmJ2N2V4S2NxbjIyVlN6TjJZTUVxeHY0RDBlc1VRMDRqUWE1anl4cjg2Q3Zm?=
 =?utf-8?B?NERzblVLOGlTVnVlbERsTDduYnpDa014WENDbjlKZG5PL3JPSkpPbkg3dWlI?=
 =?utf-8?B?VGZhVndaTWtLa2duT3l4ZWdWSXo5bGFrVU9Zb0crVDJuY0pqTmJGczJ4c3FW?=
 =?utf-8?B?Y3pBM282MXBHdGVldXREVWpzZ3cxVGZMeklZOWRsckNORjZ6T1BxYmozMnBD?=
 =?utf-8?B?OTZJR0RwclMxRkg4RGdUWmJaR1RlZUx4S3ZFdi9oYXlFNjVvZW9vOFdzR1V2?=
 =?utf-8?B?aE5BaFRvYTd3b1E1eUIxWEtiUC9zczF0Z05mMVY2Zm02S0hvS2gwejhlSXpC?=
 =?utf-8?B?ZEh0ck9LTGt2MDhpSjNNN1k3MjBkd0pHbGZnNHM3NUlvSlUxUHNGOE1iaGdr?=
 =?utf-8?B?bzNneWNxQjJRdmtTeDhnTEZFLzAzWEVERG1BMk1VSENNSDJCSlk1Vy9zR05o?=
 =?utf-8?Q?VnvvzyaovpMPMrY+rros+uA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01dd5e6-0e71-489b-d563-08dbb85a5b40
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:17:22.1511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuMDTRDthz1ClNqUEhOF1ayhwAt00KqpJbD7lulkRWhn/i4BS1M1JxRhHZmrAglRE8Q21fC+fBmM2Kh6gIh1RJfhFZF+8wHdbPTE5gaKfq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9056
Received-SPF: pass client-ip=2a01:111:f400:fe0c::71b;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
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
> This patch contains test which minimally tests write-zeroes on top of
> working discard.
>
> The following checks are added:
> * write 2 clusters, write-zero to the first allocated cluster
> * write 2 cluster, write-zero to the half the first allocated cluster
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   tests/qemu-iotests/131     | 20 ++++++++++++++++++++
>   tests/qemu-iotests/131.out | 20 ++++++++++++++++++++
>   2 files changed, 40 insertions(+)
>
> diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
> index e50a658f22..308732d84b 100755
> --- a/tests/qemu-iotests/131
> +++ b/tests/qemu-iotests/131
> @@ -105,6 +105,26 @@ _make_test_img $size
>   { $QEMU_IO -c "read -P 0 0 $CLUSTER_HALF_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
>   { $QEMU_IO -c "read -P 0 $((CLUSTER_SIZE + CLUSTER_HALF_SIZE)) $CLUSTER_DBL_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
>   
> +echo "== check write-zeroes =="
> +
> +# Clear image
> +_make_test_img $size
> +
> +{ $QEMU_IO -c "write -P 0x11 0 $CLUSTER_DBL_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IO -c "write -z 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IMG map "$TEST_IMG"; } 2>&1 | _filter_qemu_img_map
> +{ $QEMU_IO -c "read -P 0 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +echo "== check cluster-partial write-zeroes =="
> +
> +# Clear image
> +_make_test_img $size
> +
> +{ $QEMU_IO -c "write -P 0x11 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IO -c "write -z 0 $CLUSTER_HALF_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IO -c "read -P 0 0 $CLUSTER_HALF_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IO -c "read -P 0x11 $CLUSTER_HALF_SIZE $CLUSTER_HALF_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
>   echo "== allocate with backing =="
>   # Verify that allocating clusters works fine even when there is a backing image.
>   # Regression test for a bug where we would pass a buffer read from the backing
> diff --git a/tests/qemu-iotests/131.out b/tests/qemu-iotests/131.out
> index 9882f9df6c..8493561bab 100644
> --- a/tests/qemu-iotests/131.out
> +++ b/tests/qemu-iotests/131.out
> @@ -64,6 +64,26 @@ read 524288/524288 bytes at offset 0
>   512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   read 2097152/2097152 bytes at offset 1572864
>   2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== check write-zeroes ==
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +wrote 2097152/2097152 bytes at offset 0
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Offset          Length          File
> +0x100000        0x100000        TEST_DIR/t.IMGFMT
> +read 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== check cluster-partial write-zeroes ==
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +wrote 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 524288/524288 bytes at offset 0
> +512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 524288/524288 bytes at offset 0
> +512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 524288/524288 bytes at offset 524288
> +512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   == allocate with backing ==
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


