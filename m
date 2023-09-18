Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C9E7A519C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 20:07:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiId8-0004SA-4k; Mon, 18 Sep 2023 14:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qiIcT-0003cg-4q; Mon, 18 Sep 2023 14:05:13 -0400
Received: from mail-ve1eur01on0706.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::706]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qiIcO-0003lK-Qc; Mon, 18 Sep 2023 14:05:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsNr6sjYKlwqoDp5xM2Fj8g3tKy7qbFHO0lDYgLL/Exsn1uibi8pOIy6a3341RVyriYjTWbC6XwXmoFE7Tq9sd0+yagv171SvfJY4cR5iaP4M7gtcY7fX6+fRln3dOosFRC5V2c/cJODVmZZHxTgpf8CCRAAYTzZ7tGzA2bhmtjVXFSw0ULgfxZyd/DuUtPRNIg3j2xf7NYV4iJyPdVt4TgOFg3ggp7/c+qLCjHT9Bb02L5zvVjT+WE+wdzdU+cFpojjq3h9/LJsWoJ9mSlDkpSw+btCO05DSt5ANcxfeEg3rbvdESI8nzukBgehyrRQaBh2pOxjy0XWamGYYy1Urw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM8PuqWFeQfzwhfb0PF4nhjlxXIHp74XkCcXRFd5xvs=;
 b=OcL45feVF1NsuTzWH1qoqDJcDhdlAN0ArXIp3IDuTBxIfeQ83SBtXAENdMAaLo1RlwVUOFNGh6DnnTkLJQ2HLV9l2wBD4KLoSzvBtswEK5/f0OO0OhrLp9pQm/FbWVam7rMn6uWefloySWORYA+LKKk5nnl3q2Dx438h5mpXYkGUBHBrMAeklZdmDTeYsMgcwgu96ds+n35acyZhwDVfToI6JWTfZHAY0qyoAtPBgDum6wq/6vM6Rf9QAXHyfFIZw0M8dgNNPg74lDLBhH0Qc+OtOQpqPZ68RGD6mh6QCE+EBVfotzcoOxKuNihc/mqVhm6SOvskztVRad49bndJfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UM8PuqWFeQfzwhfb0PF4nhjlxXIHp74XkCcXRFd5xvs=;
 b=zf9o251eydPgrtlTaZOPxbOHUSCI5wH0ZAvpnwhs0WJtrmvPobDc/nTRgrsyriWIBelhbL2AK/HIS8Ng+czihAoHYVXR6wmsT9jK6PWPkdUprEthkL5OG6B6QrxjEgI6koY8rfgybexbMZucO05lVZrCYlUIwICX9zwBV1wwvTtk3yP7cFRo3sfKfhUP+bXcWDVJXaflNRovfaq0ExW6BCsckqlx8J5D4x7Z0IcuP2Osm+hBaJlZ3YJB7APPRXmxmZW/naaosyJW9M3IBQVM77Gt2yHDwwon4QyN6fMK0THHE+/xYJ60aJxsQjmLdZSxh6bqZUeMo90qvrgB3XRWVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB6517.eurprd08.prod.outlook.com (2603:10a6:20b:31b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 18:05:04 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 18:05:04 +0000
Message-ID: <f69e12e8-bf32-130a-94c7-5e829a68697d@virtuozzo.com>
Date: Mon, 18 Sep 2023 20:05:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] tests: extend test 131 to cover availability of the
 write-zeroes
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, alexander.ivanov@virtuozzo.com,
 mike.maslenkin@gmail.com
References: <20230918180100.524843-1-den@openvz.org>
 <20230918180100.524843-5-den@openvz.org>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230918180100.524843-5-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::35) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a642c68-1de7-4740-5beb-08dbb871c8e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIjTLiQs/zp7ykIE92SfNfbKGSDOdehAwLw7gzsApRk36YfDPuN01bIt2Zpu7DQGt5qRni+cUJSyIrRNSLrItWVln/uBxeEZrjE/wqwWZeAAyf2Znz+ly0x7yCTOEheXRXAfT9YpUp5NZhhawd5lVuae6TstPPrz6aLOwZ6QhxuhCNDrOHbUIcybZjXkNZCMTuf1Q0Cqv89wdBkp7Y9JeXEmf5pIebGiadBv35GlPoQSPF4ZcRxSrWO/4TTTl3LUBB0fg24zLPHqSSGXRD4dXNK0JLY2Um6sSJWusYkh5NVkogsgJXGgwm8eIZCLuMsesdtLbRwj4ToVWkZz9GZuhpXPIJVVJMlpcD2OFmL4we8tSsCxJUeLYD84w9pcWiFAfvlqIQl9dq7j8Cdu3gW3wlpAcCDrG3J4NHx2yq4aD2XtLdaWw5MoJ6nGASAndbocnFcsBFVnTEpTPx1zyoMBi/yhWXxmy05JNBQze25FVsv6J5a/sG0aDMQ773rW5fgcaWVlziYPzvjv4nfztz4s0V3EYM+ZmziQZpfVApmfzMU/tQSrqm737W0tYiff/AHhhaxPDraL/F2RQOOdXjqa7sPutLKw9z3unNgF3TSJS5wBMhh/GBOnHYkRzAHf9yTrbDS+1KawXD/nTngU++8su2G/ZOgkKEec8WlY2Eb60Gk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(396003)(346002)(376002)(136003)(1800799009)(186009)(451199024)(6512007)(53546011)(6486002)(6506007)(6666004)(83380400001)(86362001)(31696002)(38100700002)(36756003)(2616005)(26005)(66556008)(66946007)(66476007)(41300700001)(316002)(2906002)(5660300002)(4326008)(8676002)(8936002)(31686004)(478600001)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rzg2b3BMVTAreTRpM0c3dXVUNjdxVExMZmlLNTlZbmtQWEE2NUpoZzYrS0Fw?=
 =?utf-8?B?UnZPODRpUkJUMjBma2dkcEJLVlJrK2wxdm8rTHdGSWF4NHQ1NFZTNVhUcFpM?=
 =?utf-8?B?V1Q0VzdzNWgwc0pZeXFDbEhEd0IzbHliVk95ZGFXWVVIbWhneU9NRFBTL1Yz?=
 =?utf-8?B?c2FCN3V4bjFyUVRvQlV6YVdNT1JwM0RFSnVMTG5jdGh2bzRxZVZCVnUxYVRG?=
 =?utf-8?B?UnBYRnpCUXRubkxjUWlMMng0bTZtQy9QREhjL3JMSFpzUzh0ekVSYVkxdTF1?=
 =?utf-8?B?ZFVBVnZWUzczSE9lMEd0NEQyU0NOTDNRRXZGSUMySER3WDM0WnNWS1hieGJC?=
 =?utf-8?B?YkF4Uzg3UmUzV3laYlJ4ZjJuUjVyZUc1NzFseUdYV3FONHBieUxFK0NyVEdJ?=
 =?utf-8?B?ZnNubi9zb0VOdzNnQUdJMm1DRDNqVnMvSzNEeXhhaXgvRGNCdUpiZ1ZJbWpD?=
 =?utf-8?B?UjN3bXpOdlN2ZHJpUzBMM2VLWlZtRW9MaSs0TllQQ0twOUJmQWRxMm5aeUhr?=
 =?utf-8?B?OXlEMUwyRHY2UFVJZUtwa0VWS2pnb1hBZXBrR2lwNnYvZWZ2Mk1MbDZQVGly?=
 =?utf-8?B?dkw4Z2lycU51cnRxdDk5ekwvSEpRdU5MNFpWelM2N2Y3d0FGdk5LcFM3YWJX?=
 =?utf-8?B?WTJ2a2QrOE1sQjQ3REtpTDQvWmovZitETkdlUDZzK3NsQ1k3T1dBMVdxeGxa?=
 =?utf-8?B?UjBvZFNSSE9sck1VVU9EWFhFQ1Jrcy9SL3NuNGIvRXNJdG9hdksvdUZHWjNT?=
 =?utf-8?B?SUE4QzFzWFlRblN5U2ZMUXhDanU4Yld6UWpEdGRIUFNXRTVFU1FRM3pUOGUx?=
 =?utf-8?B?Q3lkaytOZ2ozdXlkLzRtMThJRnQwSVZscG94VTZQc0NaMDlTL1N5bFVrbGNH?=
 =?utf-8?B?RzQ0NGlBSUpIcDVkZEJWeWVaZnE5M3ZlRW5JK2hzMGhJSHpMQ2hNZFpGdk5C?=
 =?utf-8?B?K1piWE9EZlRuWFVxS3YwaktCZCtRWnNxQ2pLMjZ3RE5mOHNjQTR3NUppdVE4?=
 =?utf-8?B?NUpIMjhnOUFBRzdrOGUzWE04bkpOa1Zpd0ovR1E0YkZDOVcwWU82QlMyU0Q2?=
 =?utf-8?B?Zk5QZXYyc21FaUVuOEdwb1pzSXhrbnl6N1pkbUtRK1VFcldVTXBScXNuNFh5?=
 =?utf-8?B?TnorblNKRVpzMnlSVzhKcDZLcndGNmZ5RnNQQkkraHJkT2F6V3kxRjZkV1hl?=
 =?utf-8?B?ZmY2R3d4dWdKT2d6dFNYbHBQbWFPQnc0amptZ1JZdWVOUWJDNDMvcnVjNHJK?=
 =?utf-8?B?U3hBSDdna280WnpSakk4VVhZdmVrUVpqbmZoU3U1QStHY1Z1THhaYWVDSjRB?=
 =?utf-8?B?Ky80U1MzbWVRYVVLMStnUHNTMERtRTVoODV0S2NCaTRIOG9pV2FETWg5b1FY?=
 =?utf-8?B?TTd1VDFiTEFzbHZjaHFqc0FOdDk2N1pxT1JMeXlZY3FmLzVFeXRQMjQ3QVRo?=
 =?utf-8?B?dEtOSnFNRXJXNXl2bmlkT24zMk55M05BZjk1SXRXK3EwNEw1VDBxcFFmVjRu?=
 =?utf-8?B?YjlKeHlITVBPVVJwRjEzeFo4ZmZQY3NVMnZzalVvUFQ5dWk1Q0pjRTNzK1BG?=
 =?utf-8?B?YndwN1lCN1YrSjZwVEtDOFRHNzJOUkdTMjJPWk5xSzJFZDBDS0pBM1MxVzVw?=
 =?utf-8?B?blByQXB4OFU0ZHB6bVhRdEQvV0ppMnBQSTlYMzlJdmJTQjJURG02ek10VDdP?=
 =?utf-8?B?b3laZ1NEN0tzTjdjaXNsS3F5SUJYajdBRWhqVGtwNHVzNmFsUVdwK3dOeWpF?=
 =?utf-8?B?VjUvbzMwdjRJK21mZlJFV1NGRnBSdSs5TGxkdnU3VXNJK09TcW1CeEhsM2Fy?=
 =?utf-8?B?SnNlV2hVbGZlS0NFZVBIQnQveTQyTkY4bjhnb0Z1MEx0dTc0S0N6WVJmanlM?=
 =?utf-8?B?dVcwcStJcnpweFdLL2R5aHdlL0FXUk8za09ZSE1aUDRwcWtiNUFwdGtMVW95?=
 =?utf-8?B?WVBWT296RGxSd0h0YUlYTDEwUnE0dzBQY0tqUTRPcTZSa2FiemlFcEptRjEy?=
 =?utf-8?B?dndWYk9HaGtMcm8wYjEzZ3R1T0pvYlI0SE1RRjUySy9OSVFPZUU5dkxyNmFP?=
 =?utf-8?B?VzZ2L09KaGdSRlR6bGlMNFVRanVNQWUwL2t4OTZodVRTNjlJbjFWOHdyRWw2?=
 =?utf-8?Q?Qj94vQMeCr8oZ5KjhZcXWlpqE?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a642c68-1de7-4740-5beb-08dbb871c8e3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 18:05:04.5352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMZFZcVSUO54z18oSyEexuWgEw2Ar7cSrqOXpIGKmWVQNbpagHb/KXEyeJQeJ57ew32rUSydEX9tHCT6IzyjBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6517
Received-SPF: pass client-ip=2a01:111:f400:fe1f::706;
 envelope-from=den@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
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

On 9/18/23 20:00, Denis V. Lunev wrote:
> This patch contains test which minimally tests write-zeroes on top of
> working discard.
>
> The following checks are added:
> * write 2 clusters, write-zero to the first allocated cluster
> * write 2 cluster, write-zero to the half the first allocated cluster
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
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
This patch is actually patch 22, please disregard it.

Den

