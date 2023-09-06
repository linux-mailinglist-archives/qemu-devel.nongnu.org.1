Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5F97938B5
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:45:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdp5S-00045E-Ic; Wed, 06 Sep 2023 05:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qdp53-0003oS-2a; Wed, 06 Sep 2023 05:44:14 -0400
Received: from mail-db8eur05on20720.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::720]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qdp4w-0002zO-6D; Wed, 06 Sep 2023 05:44:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSIayOTKQgYvlwOjW8ISb5IkutuUI4tN4CbRuLqL7pO+MpK062w2XYHTliiT/rVfsYsxQ0234Ta2wKHCVEqm8KQptWAzGc5jbOsg3V+rO11Kh+uMOEi5xu7QRMBxeQ1uhMjNAqmnqvH1ahFdN4YwcdpdETsEYIIKF2o62AN8/UevVmT7W0UJgOG4cntRxcmluXTtHUIIkOzBoaQCSya7YBBM+O5PjRyeJWyrqV5fMKFXkK46rahqO88ypg5gifjTzu2z8HQI4ExPUAClS6ohX6oWgwLTusqlCCLiz8UW2O2qcO/RMKRvkbTrFKYqhSyFdRLMqMj9L+M41lIAzMewKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHSMwbayK8apjnZXq2m2oMq9JfYcKZjh+4qSwTQmFRo=;
 b=FXn5jN7y7M3gXtxhmqkOnu8E4fJhGaXanvOshaazGKdF0aK+owu+3LeOS8PjiC943LCX2phmSqdogucpSRfi8DfVrLFfr/I9q0zbO9NgK0Uk6+u8lWO5Gwrt4BgcNFrGVQ717E2hyeVjR2Al2aEqZ2sG00ftHSW9vsX5LFZPIc5k0CiTK6qrtNrKNtkS8oUoc9WnbziYC1eB0M9YIQtpzj45X3ebwprKwGxzIz7MyVqfrac+AE8IqSaui3ZAALZSNWWlUQdLGO8zpq0xZRmR3baBw1TTq7vE5aM7QHBdqMnR5wd5kAujd0Pc97SKBgcK0UlwkseacuUbvv1o+bb+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHSMwbayK8apjnZXq2m2oMq9JfYcKZjh+4qSwTQmFRo=;
 b=j6l4QRhun25mrMh8SmyyBuPR0G1SKTBGrEjvFv/4GFH48/BftsqaWXJGk4TSjEco150QL2vSsdD8ad7paCmSNQUY8LTkI9RdlmFG9NdPxOqt9I6J82JEa3+QGMSAaP8pAyxy5DZOsO92pvQvXS0qe+lkZ2FPS29Cq2SWdFCFOomtUp+Utt1cM1dvZbFLxyL4jTCZx8UoXI9sPl+wyehetYWw6Zx17pgdy1TItW8wVJBk+hvLccA6aHBTcmR1QMS5cdGspWF8DD3HJNdJ1+l7GQ8UY/Sp19c9C8mUmFyfb/2774we4crX6BVGLx9HhqQ3uNqXbCibNd+l3WH8A3DkLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DU0PR08MB7762.eurprd08.prod.outlook.com (2603:10a6:10:3ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 09:44:00 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd%5]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 09:44:00 +0000
Message-ID: <4db472ce-8932-3dca-3572-5dcef391b227@virtuozzo.com>
Date: Wed, 6 Sep 2023 11:43:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 3/3] tests/qemu-iotests/197: add testcase for CoR with
 subclusters
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org, 
 qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com, den@openvz.org
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
 <20230711172553.234055-4-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230711172553.234055-4-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:118::45) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DU0PR08MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d486161-393c-47a5-5030-08dbaebdcc4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjeU3dzxUo5CiLrqV5Ju/Yq/9hbfZ6sEwAVg1EpTPIuPfK6+6uKHGvem3DX9rgq2bjbeQoo6N7+x+u86EmEjUUeYzJjOo0q60YGHmrt41BNclGyYGn6j9eOfzhh3czRwkQI8dXjmkosPJ0jA4VsRH0wy0p0X9NRnYPNaYTTsXtWNm3FHtbQDJV+KqWXZ5+kyBsF8nF71jamgGC3LBIguuB29hD3yt9bcyiNPPi7NETJjm9bNpwHShWt6nhof2OfNYyqqXpKVw6Gzrlgex2YrfJcV9cbHYMumnXDTl/5nzZSCMBmmez1idSKygc7lS5KZPQwq7brWQ3p1/T/QV2F6472LLMKKt53S++fwoFdJjTkTYEx22iSpG65DmH1OsKWVpzGs668K9Aah28TZGCJtvFyO+Ezw1tCfO1m1/6r36mtB2NRnteKfYcwX+z/6EO1RtyYD164keelpmKdmEuTNdmhdo1UDt2LPjfsn2Nsv3r1/tVfopP1tV3xqouH7B3m6CY330TquzrkymOJA9oucVGSQP2q1HIwicgdNLqMfQ/xB54useOlbaTU8d66nSruNv/LcgLGdcauTwJZb7rZs9eoP3Jarua1qzQNJYJYNnaVP5rdAb/wEbLm+IgVvnx5cK8QLeNuyJ/NRpVzI/NCGkuDoOGDYPspuaX3dNFSd+JmvcCfCWPmBMM2/0FYgM+32DetgvlI9IC/qt7kQJ1zPDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(376002)(136003)(366004)(346002)(396003)(186009)(451199024)(1800799009)(38100700002)(478600001)(83380400001)(36756003)(53546011)(6512007)(6486002)(6506007)(26005)(2616005)(107886003)(31686004)(316002)(66476007)(2906002)(4326008)(8676002)(8936002)(41300700001)(5660300002)(86362001)(66556008)(66946007)(31696002)(21314003)(45980500001)(33290500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZitNenhSVTVQS3YxZnFSbDBkcDdCMGlPQjA1RTNDNWs0Q2VxWFh3NmJEOHRR?=
 =?utf-8?B?T0hQdk5DNzlPWGJRMXByZm9YT0J1Vy9rcVpmOFF1SDVvMUl2UXY4ekpWNGJH?=
 =?utf-8?B?eXcyUjM0YzY2Z3FTOU1tWkU4SXFneFBlZE4rdUc4bFpyRnZTK2RWOTljVHhL?=
 =?utf-8?B?RWFyNE9NWXhWSUcxNExTZktlOEt6Y3dORjUveXNXSkJzYkdVQ1RQTXhQZ0lQ?=
 =?utf-8?B?eW1YeldqcUZZWWtuYnA0OFN4U3grY0VaZkoyQ0hZQksvdjFOT1pSdlBreG1F?=
 =?utf-8?B?a1hnYjRZcm93TSttQ2J3K0RVS0hoUkhUaWZtT01CNEtjRVo0Vmxhc1dyakVu?=
 =?utf-8?B?WnJOMGRMMWFxWE15M3RXK1BKVWx2UFNmblFnblRZcUgrc3VmZk84bDdTOUtL?=
 =?utf-8?B?dUJBYlJOUFNWaWI4dW5US2NuaS9FUGtqaW95YkZud2txbFlKUDVIemhHQ2kx?=
 =?utf-8?B?V1dEcjRQTkd0NENsdlJ3VERPQmwydmVvdHl4M0c4eTBtd2V3Si93YzVvK2ZD?=
 =?utf-8?B?cnd4UUhHYndzQVJyV2tQM04yNkU5YXN2QlB1SjVSMCtNSjJocUpmcWc5MWI4?=
 =?utf-8?B?R29qYVl1WkxINmVqZ2xJeUF4NXVYbmo5SG1mamQ2cUpLRk9yTUg0NnF6Qk9p?=
 =?utf-8?B?K2FTMWt1TTdYd3AyVjhEeVRkcHl2MFppZWVBdHBJdFdDd1U4NXZENktnV1Vw?=
 =?utf-8?B?bWxuNkNkSURJbTVBUW1VV3lKN2YzbU9vYkNEVWJ4WEF5SWdCTGpQQlhhTEht?=
 =?utf-8?B?NlRGQkN0aTNQd2Z5bERjQ3o3NnFpQlZ1dVg3UjU2dXU0VURqN3lVMlFLb283?=
 =?utf-8?B?MVNxcnVQVkVXLzFVK0tmeXdTN0hPSnh0dmVwaGlKMlgxZlJDU2FlQzBkTmU5?=
 =?utf-8?B?anhxSk5oMGdVVksySDFOaFU5cU93UUtKVmpQTHhoWlJCMXNHdU13Qk5FRUxl?=
 =?utf-8?B?ZHFuQjR4bHN5S1RBb05VdHhnMUZBMVZUYmlaajM2WE5QRUc1RlJnTUpXUDRq?=
 =?utf-8?B?VDhjY2N2b1ZRM0tzVjZSSENjQ1JNNDFMeTgweWhuZjRWVnBRK3hRMXg4M1FT?=
 =?utf-8?B?MzBJcFVBNlVWd0RzQXR3VER0Y3Q5UU0wN0xnYWdwZ2V0V1NvdTFXc1FHM0M2?=
 =?utf-8?B?Y0hYWHFiSisxR3I5TlZHRjJZTGtnSmRKVVUzR201Nys2MzYzSHlqOVFwbEh4?=
 =?utf-8?B?Q3N6SmcxaVJwQ2Q1UW43MEUwb2Z0WVc5TUVIOUYrOTY2ZVNVazE4TkhKUXdK?=
 =?utf-8?B?T29rZ2VJUXFiZHhsL1FhTUE5NXUwQmtGc0NmQkZadmNQUWxNY1pFUTcxVDl3?=
 =?utf-8?B?azNRVjdjc1p3OVQ2LytqTDBUVGdwcGFGbUlrRmY0RHQ4cmFDU21VejNrVmRa?=
 =?utf-8?B?dW1SYkRtUmFVZ0NGOVUyMGc5aWI4bnpSdkxpMDZpZlNOK2x5amxJRlJTUTda?=
 =?utf-8?B?b1hFOWFta05kbDNwYit6VHVRZzhRbUcrY1RrYklFVllGZFY5WDAzSU82aitz?=
 =?utf-8?B?T3I5Tk5uclNZQ0orc1J6WWxRQXY1N1luNG5TczRsK2JhT0EyZER0QUdrands?=
 =?utf-8?B?UWcvNzJGUkpiNGRnZ2pORFo3UWdrN0FCMVRUci8yNnJMdFd0OXNPWGN5NnMv?=
 =?utf-8?B?a0o3QUx5TDZ3L1lWRkZqbmVLN29uajluem8rZC9WTExGNjhrUW1ZTURJdkRl?=
 =?utf-8?B?ZVpidHliR1BDaEllc1UwVk5KamFnS1NYeU5KVWhWc3htSFk2T3gzc0w1dzFY?=
 =?utf-8?B?Vi9yU3F3UENmOEVkUkk3ZEk2Z0ZTU2piQnJ4NVRaZVZxYXArSkVHWFkzVnZt?=
 =?utf-8?B?eEtPelRiRkx2cjFFNUxrT2lzYTAyRnVNRXVhUWNlelRqbG1VMDJiTExOenpL?=
 =?utf-8?B?S3MyejVQcEFWWFRObzBqL0liY0lqZ2NCVVBkclRsZjNNS05ZbUIxbmt4c0d6?=
 =?utf-8?B?YUVEaEVUTlpLTThJcWQzYTlmQVNYbkIxYzdDZlFCV0JkSjZOYW5OTy9ENWxt?=
 =?utf-8?B?c1pJbVUzdFg2ajJaVGRTMzQwMkU2MEZIdXY0ckVhSmNra2Rka210SGF0Z1l6?=
 =?utf-8?B?aFNGdXpjdlNRQUV6TlMxbEI1N2NSWEY1Z3lra0tiNVlJVDBkR1owM3hiU09F?=
 =?utf-8?Q?Z/2XemrlNjlH01ak54rknLmzw?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d486161-393c-47a5-5030-08dbaebdcc4f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 09:44:00.4026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHd7vvh7808fHaaGczjognPorz6l+wmLyoKdFQTbh6GDe29amwA9dh4R3W+AONRhLcBKlKQ9ULRDdbl1Vp7xTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7762
Received-SPF: pass client-ip=2a01:111:f400:7e1a::720;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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

On 7/11/23 19:25, Andrey Drobyshev wrote:
> Add testcase which checks that allocations during copy-on-read are
> performed on the subcluster basis when subclusters are enabled in target
> image.
>
> This testcase also triggers the following assert with previous commit
> not being applied, so we check that as well:
>
> qemu-io: ../block/io.c:1236: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qemu-iotests/197     | 29 +++++++++++++++++++++++++++++
>   tests/qemu-iotests/197.out | 24 ++++++++++++++++++++++++
>   2 files changed, 53 insertions(+)
>
> diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
> index a2547bc280..f07a9da136 100755
> --- a/tests/qemu-iotests/197
> +++ b/tests/qemu-iotests/197
> @@ -122,6 +122,35 @@ $QEMU_IO -f qcow2 -C -c 'read 0 1024' "$TEST_WRAP" | _filter_qemu_io
>   $QEMU_IO -f qcow2 -c map "$TEST_WRAP"
>   _check_test_img
>   
> +echo
> +echo '=== Copy-on-read with subclusters ==='
> +echo
> +
> +# Create base and top images 64K (1 cluster) each.  Make subclusters enabled
> +# for the top image
> +_make_test_img 64K
> +IMGPROTO=file IMGFMT=qcow2 TEST_IMG_FILE="$TEST_WRAP" \
> +    _make_test_img --no-opts -o extended_l2=true -F "$IMGFMT" -b "$TEST_IMG" \
> +    64K | _filter_img_create
> +
> +$QEMU_IO -c "write -P 0xaa 0 64k" "$TEST_IMG" | _filter_qemu_io
> +
> +# Allocate individual subclusters in the top image, and not the whole cluster
> +$QEMU_IO -c "write -P 0xbb 28K 2K" -c "write -P 0xcc 34K 2K" "$TEST_WRAP" \
> +    | _filter_qemu_io
> +
> +# Only 2 subclusters should be allocated in the top image at this point
> +$QEMU_IMG map "$TEST_WRAP" | _filter_qemu_img_map
> +
> +# Actual copy-on-read operation
> +$QEMU_IO -C -c "read -P 0xaa 30K 4K" "$TEST_WRAP" | _filter_qemu_io
> +
> +# And here we should have 4 subclusters allocated right in the middle of the
> +# top image. Make sure the whole cluster remains unallocated
> +$QEMU_IMG map "$TEST_WRAP" | _filter_qemu_img_map
> +
> +_check_test_img
> +
>   # success, all done
>   echo '*** done'
>   status=0
> diff --git a/tests/qemu-iotests/197.out b/tests/qemu-iotests/197.out
> index ad414c3b0e..8f34a30afe 100644
> --- a/tests/qemu-iotests/197.out
> +++ b/tests/qemu-iotests/197.out
> @@ -31,4 +31,28 @@ read 1024/1024 bytes at offset 0
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
>   No errors were found on the image.
> +
> +=== Copy-on-read with subclusters ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
> +Formatting 'TEST_DIR/t.wrap.IMGFMT', fmt=IMGFMT size=65536 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
> +wrote 65536/65536 bytes at offset 0
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 2048/2048 bytes at offset 28672
> +2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 2048/2048 bytes at offset 34816
> +2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Offset          Length          File
> +0               0x7000          TEST_DIR/t.IMGFMT
> +0x7000          0x800           TEST_DIR/t.wrap.IMGFMT
> +0x7800          0x1000          TEST_DIR/t.IMGFMT
> +0x8800          0x800           TEST_DIR/t.wrap.IMGFMT
> +0x9000          0x7000          TEST_DIR/t.IMGFMT
> +read 4096/4096 bytes at offset 30720
> +4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Offset          Length          File
> +0               0x7000          TEST_DIR/t.IMGFMT
> +0x7000          0x2000          TEST_DIR/t.wrap.IMGFMT
> +0x9000          0x7000          TEST_DIR/t.IMGFMT
> +No errors were found on the image.
>   *** done
It is revealed that this patch seems to break unit tests if run for NBD 
format

iris ~/src/qemu/build/tests/qemu-iotests $ ./check -nbd 197
QEMU          -- 
"/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-system-x86_64" 
-nodefaults -display none -accel qtest
QEMU_IMG      -- 
"/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       -- 
"/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-io" --cache 
writeback --aio threads -f raw
QEMU_NBD      -- 
"/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- raw
IMGPROTO      -- nbd
PLATFORM      -- Linux/x86_64 iris 6.2.0-31-generic
TEST_DIR      -- /home/den/src/qemu/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmpzw5ky8d3
GDB_OPTIONS   --
VALGRIND_QEMU --
PRINT_QEMU_OUTPUT --

197   fail       [11:41:26] [11:41:31]   5.7s   (last: 3.8s)  output 
mismatch (see 
/home/den/src/qemu/build/tests/qemu-iotests/scratch/raw-nbd-197/197.out.bad)
--- /home/den/src/qemu/tests/qemu-iotests/197.out
+++ 
/home/den/src/qemu/build/tests/qemu-iotests/scratch/raw-nbd-197/197.out.bad
@@ -43,16 +43,11 @@
  wrote 2048/2048 bytes at offset 34816
  2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
  Offset          Length          File
-0               0x7000          TEST_DIR/t.IMGFMT
-0x7000          0x800           TEST_DIR/t.wrap.IMGFMT
-0x7800          0x1000          TEST_DIR/t.IMGFMT
-0x8800          0x800           TEST_DIR/t.wrap.IMGFMT
-0x9000          0x7000          TEST_DIR/t.IMGFMT
+0               0x10000         nbd+unix://?socket=SOCK_DIR/nbd
+Pattern verification failed at offset 30720, 4096 bytes
  read 4096/4096 bytes at offset 30720
  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
  Offset          Length          File
-0               0x7000          TEST_DIR/t.IMGFMT
-0x7000          0x2000          TEST_DIR/t.wrap.IMGFMT
-0x9000          0x7000          TEST_DIR/t.IMGFMT
+0               0x10000         nbd+unix://?socket=SOCK_DIR/nbd
  No errors were found on the image.
  *** done
Failures: 197
Failed 1 of 1 iotests
iris ~/src/qemu/build/tests/qemu-iotests $

it is good for QCOW2 format.

iris ~/src/qemu/build/tests/qemu-iotests $ ./check -qcow2 197
QEMU          -- 
"/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-system-x86_64" 
-nodefaults -display none -accel qtest
QEMU_IMG      -- 
"/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       -- 
"/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-io" --cache 
writeback --aio threads -f qcow2
QEMU_NBD      -- 
"/home/den/src/qemu/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 iris 6.2.0-31-generic
TEST_DIR      -- /home/den/src/qemu/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmpe1qldhs9
GDB_OPTIONS   --
VALGRIND_QEMU --
PRINT_QEMU_OUTPUT --

197   pass       [11:42:14] [11:42:17]   2.8s
Passed all 1 iotests
iris ~/src/qemu/build/tests/qemu-iotests $

Regards,
     Den

