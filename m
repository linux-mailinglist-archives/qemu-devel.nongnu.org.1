Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E89567A48B0
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 13:44:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiCfV-0007JH-D1; Mon, 18 Sep 2023 07:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiCfS-0007Bb-Sd; Mon, 18 Sep 2023 07:43:54 -0400
Received: from mail-am6eur05on20726.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::726]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiCfN-00045A-Og; Mon, 18 Sep 2023 07:43:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRnkQCEgp6lCa/aJ85dDayk7f8hDXGduHluHSAaOMDmzUZ6txvsfVHle5zDBd+KDJfxLNOTYrw7cJ4+pWSe7VaViFTifAsC4xL+658tn97aZS6T45UhBXuKXxxZ+7RtPra7R8YhLmVS3ppDtiBBUxypD//c4NIWthjVXZGju2N9Jv6667hErH4dkOGrNNbDkWTtNjVp0j5RZ2I/Jvu8h4wr9ibURUyLISvjRrbYmXMKnZgxwczTa2N0L8NHefqwuYRspe6H7qNeqB3vq+O6fJJ2gOacQlILibxysrjpX2+jfDM5tSHgVsYFim0HVxpZXzzJJNnpzTo98hWsKexnFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM5jHCCIVLmEQ6lyNFtdfm3PgmeIsqbqudgBr5htO4M=;
 b=RT1ol6GBmT2jkWZozo2XTzz4t7HymcaW2H+DlavcxA+YxvX94mybYagrPtURkoeMn98Cj8271EtsWxG/e3UkbyeCuVRXTwf2yKZEvaSocuSE00qYhV+uY2uR6RKvdnzHgCOo1OAnTive4fTyPu+Ot9z7NsV81CDWg62wxFXOzz9vKbkZjP2XA2+XdnQVuaujRNczwcHKb7fMERTLXtySqSMADwAbroLHPAFKXEXwwUNOhBzIK2HYPRigVLw/7nYXSekNIPSH32pLOFJpItJdF0NInqnezqIvUUymgXtJ5eylONA8BQb3FOX4Xs8OOC5EoCFqapOH5wAxCYzzJsRtsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM5jHCCIVLmEQ6lyNFtdfm3PgmeIsqbqudgBr5htO4M=;
 b=a/4TzervT4ERH9Pfrw3emdGgTDq7FIJcYH8OrlQrnLtgz24EdQ1SglglJNsA/8/XcKHnlRjYPMecFE6DMaXbbSr1l108ys3EDPACDLQ+PPW4bRPeUWBjZ1tMH++jvxt+d/EKCOyVdEnTGJew4TZneNgiS9ez/XcImCjf+TIvh8ynzdGxWb8u7i34SyQZ5R/HL7hlcoG78WkX+ZQKfzDN/yXE4bxXGu3HEcZfwxSktrGTrgMJ6FFjpvZDEp2xul8DJPs702+yP5IpvGfoOV7VcUwaisowj8CA++GcOkKAngnrpWTc4FRs7wh/bBjoH26T0mNxqDJo+tamS+CNw7p2Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DBAPR08MB5765.eurprd08.prod.outlook.com (2603:10a6:10:1ac::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 11:43:45 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 11:43:45 +0000
Message-ID: <10b57c55-0fd9-bf76-7e49-d1f8c334693f@virtuozzo.com>
Date: Mon, 18 Sep 2023 13:43:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 12/21] tests: fix broken deduplication check in parallels
 format test
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-15-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-15-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0114.eurprd04.prod.outlook.com
 (2603:10a6:803:64::49) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DBAPR08MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: e71c72c7-2693-4ab3-09d3-08dbb83c83d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7LeeOQGyP69NxYRPDCFOv6e4zuX/ROhEtRFxRBglThbNa2UtzTiTpaSEY8L462B7FCvwPHZ1NKdrD1KPGYP8gRB2RBddRgP4RRiVeRFHVIuSs+d14Edcut0bXaHzSn1EP6P3dBhCZl+N1r4Hf6j1RlHsYGWx1wLYJzrWB9m+K4pynVfBJG4RQ7uL83B13TgB9XdYqhtHo6jxOYnPLvzZd7syNndrDKjY7CAa5mBQHn5rCtdHapcUeZga8+1PqZQd05WjN1gxjXsHUoxoJQ0P8mVTU90Vst/0T5Kjn5MnZ4xEHrgdFU5+CoUuW4MAWncTenF/Xd3wwHbsoIHB4d7vwxy0cRR7vzdCWut4338mO6iHVfZ0KEGuw/qllE97uv6omhwmKoY9JE8KNpC7OuwPS9zLm9cs2TMoUfBO9iBI/p8KzGbx/nuVoWdt9fZFn8qyyb8eQyWrsWFsP66eLDwJDQeVPxdR1VV0/iZRv+qXX3ghbg09YrtiQYwAkFwxjC8eVyyUFhJ3MktybxKgB2ut6h2qcVRveMAT+TXQfSzkcPgkWaM2UFvI4uneYIvUAOpXuqKdoWB/uDtyHgCHDRisKHIY65JE/ZNOorbMRWguNhOghwMA8F6qS7i57y08W5Z43wqIF5rNQl2o4pLTs53UNU8xEGJj0tzkvaMU1QljPKAEqXNsEqbGncbDGdStZcYsFzq/fJFktTl69hsbxpFogg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(136003)(39840400004)(366004)(186009)(1800799009)(451199024)(83380400001)(6512007)(2616005)(26005)(316002)(41300700001)(66556008)(66946007)(66476007)(5660300002)(8676002)(8936002)(4326008)(44832011)(2906002)(6666004)(52116002)(53546011)(6486002)(6506007)(478600001)(31696002)(86362001)(36756003)(38100700002)(38350700002)(31686004)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVpzVjNZcnBjT25zT3F6clhaMjR3V2dkcjFyU0RuenNFMFYvV0pSRFJSMWhB?=
 =?utf-8?B?UER1K3l3OXVWTFloMHZpU2NmT0orK1pFbU1VaG5lbkkzZmpuRGw2ZkFaa3NU?=
 =?utf-8?B?NXlnOUJ0U3ZpL25xMlNxVWI4bFA4NUppdUQ2QnBVOTFDZjdVN2lYRkFtR2tJ?=
 =?utf-8?B?ci9DYm1TK2E3MFhacUZkSUtJTHFsUWQrU3hETVVQbk1kUE1CN2t6a3IvSTZ0?=
 =?utf-8?B?TkNseFFrM1dzM2RVQWhDaFY5WXYzYXFMOEQxUDZqOG91YzB3YmpKc1c3Yndz?=
 =?utf-8?B?K28xbm5WVWp4dlMxQ0FpVE1sVHJ5aW5KUFZBOHgzUXhLZmRsbWFYSXZZZmc1?=
 =?utf-8?B?VjBsVWFpTG9kbDBDM3VkcnJHcXVFaFdKSTV4UVJBaHRRTlppa2U3dHRNelRl?=
 =?utf-8?B?cXZvUGpNZkY2Nzd2S3FXanJTZE5BVVBkQXdNVXVxc2twWnplTWtEbE5SYTU1?=
 =?utf-8?B?Tm1SeXVKSHBqM0lMTDFnekRFK3NEVjFyaElNMUtXZXFMMUN1ZXdldDJvWWJa?=
 =?utf-8?B?b055SE1Gd0hyVFZMK0MzNU14aU5UTnEyTnVxeUMrVXdYZnNrM2YwVUQrZFNa?=
 =?utf-8?B?ZDN2WkxnVUpJODRZYU4vcFRJMlFLSURjREVQTTFkWkg1V3JkZWpoZDdzaGZ6?=
 =?utf-8?B?QkpWaVFpVHlVaWllNHRNMTZ6WitjRWorNk4vRnk0L1libUcrL1ZLbXdaWkZN?=
 =?utf-8?B?bTYrSldHendwSkErY2QzbzdFMXhydmRHQ2tBdnFseSthdHcyamR4dUJnbFdp?=
 =?utf-8?B?L2xIOXA3VGsyQ1FlTGx5NktTR3BMam9rMTAzRkhnV09HVGpNUG1ocmt5RXg0?=
 =?utf-8?B?c0dTdlRSWWgrS3pudUtWZjRqellYKzQrQzQ2TURSdTBXeGpOa2dIcjh3N0Jx?=
 =?utf-8?B?Y25iTld6ZnIvMzdweGxkRURZSCt3NVpSTnJvYklXTU5MK09VRFpscXVIWnZU?=
 =?utf-8?B?VjV1dW5KU1N1d2F3dnMxWlFkNHFRdndGSU5jdTk5cXE0M3BsVTJRTlR5Y3FB?=
 =?utf-8?B?MnRka092NDBUdThla05sbXhUWEUxMmd0RjVOK1ExMW9HbmJVOFMvYnBzTzVo?=
 =?utf-8?B?OHhQMjI4aVE3M3VYVFR1Q0pBVTNXMVVUdVBhYll1a3hpanJKNU8wZ0RJNFUz?=
 =?utf-8?B?MDFaTm9JUTI0NXUrRmwxQThyY2l5WHFRYWpBdlZhcFdneGFETTBNOUcySDl3?=
 =?utf-8?B?cGMyQVF1eWFvZ0ZReEpZWWRzcUh2c2dnYllIRVR2eHVhZFZoR1BJYWFvYWhS?=
 =?utf-8?B?bjRUb3p0Zk15QkE3U2tJeUw0YXFaQlJwMXhRWTZ4VkhuZ2ZabUtTdlEzRVND?=
 =?utf-8?B?Vjl6ZmN4RG9Fd3JZYXpMWExFRXkxZ2tPb3JLUTZ2bjluZUViZVlpUnNlU1E3?=
 =?utf-8?B?NGhhRHhpblFya2FxdThFajluUnlNM2tYTmlROHNRZ3ZhU1cvc1B1TDhzL3lZ?=
 =?utf-8?B?dEViTVU2U0NFdmVjL2h1UU1Fa0tUb1lVa3RrQXNZWUVCZEdhdGpFc2M0ZTVV?=
 =?utf-8?B?SDVPSkMzVzlSNGUvRk1nUk9TZGx2K3MzK0NMa2tIQm9RVXJkbnJRanRsM0M2?=
 =?utf-8?B?ako2TTNENk83ZXVmYTRhRW1WNGN0VHd3YVFjMlJhRkFDNUpkRzZ1K1FhcTda?=
 =?utf-8?B?REEzbUx6K2tvNWRlTSthRWFjMjIzdk5QUlJ2QzYwSWc0dVZIWWFqYWgrNjNx?=
 =?utf-8?B?Q2pvQ2hwY2Z6aTBmc2NKUENhWWlnSHhFekVkSzh1SllBWkZJUHZOSTMrRGkz?=
 =?utf-8?B?SER2MFVYQXB2Tk5zZkRNT1pXTWFJTm9rVldhRU13WjM1MnAxenlCN3ROT3BR?=
 =?utf-8?B?K2ZJeUFBVmNrM1RqSGFCT0JCWUhiRksvZEhrRnI4UWdFOWkxbTBTSUVLa1Vv?=
 =?utf-8?B?WWRjN1ByQVVJOXRvVCtoeWZ4LzNMQjdCdFF0M0UzODFVQkVYTlkzcmk0cGZ5?=
 =?utf-8?B?VTBmMXBDemhIOG9iSExQUHNTZDFxdmNXZy9XZ3cxWUF5d0E1QThJOENvRi94?=
 =?utf-8?B?dURyd29MNXVPNU9ya2EyV2EvK3B6Zy9JS0hlb3hjbWs3aGorVWtDMFhFeXNV?=
 =?utf-8?B?eGFKK0JwY1JUZlY5SHJQZURJeHBhRzFxck9Kdm9yV1F5QVhSVHlFNmNmNEJ2?=
 =?utf-8?B?Ni9PT0FGb004azZXa2FNM3cxNE9ZMW1QWW4vbDR6VXBPdzlyNGdkWmNiNngw?=
 =?utf-8?Q?2ogvrskoDatU7daXvoMTeQk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71c72c7-2693-4ab3-09d3-08dbb83c83d1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 11:43:45.3041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEv/p0xRb/2d/3b6S+yBEsU6YmI4vb1Wac81B0Qd7WcHoujbwl9E6cLRHwfPbKvoIG7XoQ9WvzStop0ObL6UZq08ySnANS5U5kFCYxAf56U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5765
Received-SPF: pass client-ip=2a01:111:f400:7e1b::726;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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
> Original check is broken as supposed reading from 2 different clusters
> results in read from the same file offset twice. This is definitely
> wrong.
>
> We should be sure that
> * the content of both clusters is correct after repair
> * clusters are at the different offsets after repair
> In order to check the latter we write some content into the first one
> and validate that fact.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   tests/qemu-iotests/tests/parallels-checks     | 14 ++++++++++----
>   tests/qemu-iotests/tests/parallels-checks.out | 16 ++++++++++++----
>   2 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
> index f4ca50295e..df99558486 100755
> --- a/tests/qemu-iotests/tests/parallels-checks
> +++ b/tests/qemu-iotests/tests/parallels-checks
> @@ -117,14 +117,20 @@ echo "== check second cluster =="
>   echo "== repair image =="
>   _check_test_img -r all
>   
> +echo "== check the first cluster =="
> +{ $QEMU_IO -r -c "read -P 0x11 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
>   echo "== check second cluster =="
>   { $QEMU_IO -r -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
>   
> -echo "== check first cluster on host =="
> -printf "content: 0x%02x\n" `peek_file_le $TEST_IMG $(($CLUSTER_SIZE)) 1`
> +echo "== write another pattern to the first clusters =="
> +{ $QEMU_IO -c "write -P 0x66 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +echo "== check the first cluster =="
> +{ $QEMU_IO -r -c "read -P 0x66 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
>   
> -echo "== check second cluster on host =="
> -printf "content: 0x%02x\n" `peek_file_le $TEST_IMG $(($CLUSTER_SIZE)) 1`
> +echo "== check the second cluster (deduplicated) =="
> +{ $QEMU_IO -r -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
>   
>   # Clear image
>   _make_test_img $SIZE
> diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
> index 74a5e29260..1325d2b611 100644
> --- a/tests/qemu-iotests/tests/parallels-checks.out
> +++ b/tests/qemu-iotests/tests/parallels-checks.out
> @@ -55,13 +55,21 @@ The following inconsistencies were found and repaired:
>   
>   Double checking the fixed image now...
>   No errors were found on the image.
> +== check the first cluster ==
> +read 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   == check second cluster ==
>   read 1048576/1048576 bytes at offset 1048576
>   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -== check first cluster on host ==
> -content: 0x11
> -== check second cluster on host ==
> -content: 0x11
> +== write another pattern to the first clusters ==
> +wrote 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== check the first cluster ==
> +read 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== check the second cluster (deduplicated) ==
> +read 1048576/1048576 bytes at offset 1048576
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
>   == TEST DATA_OFF CHECK ==
>   == write pattern to first cluster ==

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

