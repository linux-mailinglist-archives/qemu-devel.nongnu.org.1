Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D9774F68A
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGoM-0005F5-SJ; Tue, 11 Jul 2023 13:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qJGoE-0005A3-Q8; Tue, 11 Jul 2023 13:05:54 -0400
Received: from mail-db3eur04on0731.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::731]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qJGoC-0002PB-2h; Tue, 11 Jul 2023 13:05:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKt77ZXeK8wrTQz5g7CHkjjQPGNZc/sI+la7sscmoef1urgIsl4IcEucCn2WjOcsc72d+BW0UZ1xJcwEi/6C17ZY9KnRhBPtz5w9p48X2b9Y9V2K+6+33nuxqUpDhk3djz8jurap4xXowJbPeSX1VV48O5QB1NlzKuZfuhhc+fHGBsAmN0Ai326nJQw7W2ZminJa5i4pjxB1jSn51Kd+eUg2qPz4DI988RrQURwxaN6Seq9go3o7xn/lKaCEq7Uzc3rBYNdkfJM/W130Hv5D22cZKsVuqInbhgxRRt+BagYU17UfZR2k87c0vhD5g+Oy7pmYNVZoVXadrRrJIF1lbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vusjxwGvgjtLL1l7tqs0+clpRzyQwRZzZrPsqrbrFOM=;
 b=mKBfadKpYYF/12z3NVRIeH8pg79IbCoNnEdga+DQqk5if0YfRHeHg1rlppRpEYCOJwlb7nKQn7bUmn+BOCUaAymgNj0dN99mXJgl4nGZhDz1EYF1HFH/pW6H/xPRUi1eoIThbVFYjLemNwpG19sH90XBClCmuJJLecsIXeXDMTfTsEjhU5F7h9Knf7yGRfwDkpB+byajr6MIw0XPVU0PaJ4zPGZfhPAWefvaxBfz4vA0UzpY1jZL9Z7lPzYOwvq0j/QG77N7kXtj6YsvGZlWTD5DQC7qyRjz6RZHBJ7m5gl24j7mNkQlwroXoqbYI8uNQiqqtGrzhSpd2bIVLfXSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vusjxwGvgjtLL1l7tqs0+clpRzyQwRZzZrPsqrbrFOM=;
 b=Bud6E8uTPe/MZFZu3rGYJgrvs7RFs84Xuk1hcAuclEHWsriT6IEJ9IuoqXOxyYY+QztuT0kLS1CMv2QYRqqOmfVCjmZpDbxY/RipRaxaUmx9i3acetc5JB9HXXVge2f4QGlqWHBSQBUvOmGP383+w/l+yo4m7IiT8+HBV/0D0+OCMqhrgAS6vKZNwjXb/DOztGdUuH3/k9MCZcbEizFhqb+Vk5pGEhGNSQUIgt3/xsZF1jKKwf3eEBfF4ahhnJh49ZHYYnTZpSgDwwLZS3cpe8Mj7VWoy8a2XrKlVsArmsRQJOKFlAnxnw637WNq87S95S+/QOVzv7B5aNfoS8c1ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AM9PR08MB6147.eurprd08.prod.outlook.com (2603:10a6:20b:2da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 17:05:47 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 17:05:47 +0000
Message-ID: <16e91046-7621-192c-bc0a-8e651437508f@virtuozzo.com>
Date: Tue, 11 Jul 2023 19:05:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] tests/qemu-iotests/197: add testcase for CoR with
 subclusters
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org, 
 qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com
References: <20230626160834.696680-1-andrey.drobyshev@virtuozzo.com>
 <20230626160834.696680-4-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230626160834.696680-4-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::21) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AM9PR08MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: ebcb60e2-d554-40aa-eab3-08db82311260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8YLkXC34CUAWSGXv09M9uZIGGH7EO7vleQp9IrVhpBVpiDtD0m7xIWv2O/pYZ0FXvpBYcLBPEH8LlcoR+voweM9z25R0EKQKM2jEdgiugI5C98PUNc4jNi3KeyuhDAEk4OW0OOGxQr3Q3EBHFkAbKlLIakJFYJRFQtyq9uLGf9fKhxJViRSrRwwosYBbLUKzcF7lobkqspdTXcsSWLMnNRVG5MASj17ptcYfOUyUxS89BTQyCPHAd4Y2yQ49cUU9mXhXOAv7hfP3O0cMlfLOZ7wuf2fOyTBAr0yGbeGSgQtzA2JtetXc1jnOLT6g7BgkFCMiqNLGQz3pkpNxExp84V+nMOP5qaxW9EqEVdYjNiv3t7U6PFY47ofxXm/hojzIBEda6DBz9OVTkf1uPToJdDj9w5B/AXOvJLB/GnAG0cdWxk/LUAaYmXNMlIfl071H+nc1UtQqooMYGS6xnngyOdhE+PEa+TYd4XHI1UKPGSUl4pqUGEO6vnoE6yDPr8W6x8hZ+UrD8Us9z1uGGBsAEmatdxtV/0TpfvzHl4KenkQSgujye2t7bZlSQyAyTYaFRzvjU36ST+D8XTyizVl3GNRtkZx6Y+7w22U/83h4s+vYQomp8h7HsciTGJ0P3VlKMLCsv0npPMX8sd0s3aEvHJnOm9S7i8u0cg2JEQ8JGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(376002)(346002)(366004)(136003)(396003)(451199021)(2616005)(2906002)(83380400001)(36756003)(31696002)(86362001)(38100700002)(41300700001)(4326008)(6486002)(6512007)(316002)(5660300002)(8676002)(8936002)(478600001)(66946007)(66476007)(31686004)(66556008)(186003)(6506007)(53546011)(26005)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVpMcmlLUUIvSDBvSTZkTmJHbDFjbExBMWI2cFdCM3Nyd2xhNnQ1SjhsNkVS?=
 =?utf-8?B?REJpODNUWnhtTjZTa1U0OGtLM1BpemluWVJmUjdvazJRM2wvVDFCQkxWQWIv?=
 =?utf-8?B?eFI3RzFwNGJMbFI1S2dQVW1LRDR4Y2svSFlLMlM5V20vVHdSZXZhekpwL00y?=
 =?utf-8?B?VTNmbm5HWTRBWG5uajVySW5xQ0NIdlZQTGUvTjFkZS8raDZJWXpUaTh2c05J?=
 =?utf-8?B?WFJONXgvRTRLWVpNZithN0JLNDNrczJCZTQyYXJQNlNCRWJHSEdRd3NSVzdi?=
 =?utf-8?B?YW05SnhTUWEvRElaTXNDeVB4aEdRbzRISGVWZTBhWVUxV1FhTHJ5ZWhYbVI4?=
 =?utf-8?B?aHV0L1dqM1Qyc1Zpa3BsM2FTeWlHRXhpTTBOaU9pNUM1ZUtPd2RVUkJmRnY5?=
 =?utf-8?B?SlZGZ0RCR3FmOXl1OTBJWHAvNkhpV2hSWXQ2b29iZzFrNmg4QkF0Vys1UXdv?=
 =?utf-8?B?cWVoZUpjeVZkdHVXaExTaE9hZVpwMXd6aVNzdGFYYW5qdzAvZUJ2QTRhZ0w5?=
 =?utf-8?B?UnBSMkxFR1NBYmNDM2VlUXF1MUZoR2ZpSHBxMUhsMXo0Z2dJSlVTK3hTUnc1?=
 =?utf-8?B?SnUrWDF1R2JUM2x1NEFvRkZENzNnRGhMTDVRcDNlazNtMDVRZi9JbkhuR0c4?=
 =?utf-8?B?WnlPT01ITFRLbkNLYTV0enF5eWVwQ2FkaEpmSk9BNC9HdjZCWnc0NGxBL2Z5?=
 =?utf-8?B?V0VEeDhtdGUyVHRrQ3hnUW1ILzJkME9iQ2xoa09RcHptSko2L1gzR3k1cHI4?=
 =?utf-8?B?b3NXZGowL2hEUytPbVNVSDFCcDZNWjB6MzBSVmxnTjlNU1R1NEFZd1ZRUno4?=
 =?utf-8?B?L24wWGNMMHV4SmpYc2lNNXdsY2N4SFU4SVZnSHdDeEovc0pHbTdBV2pIVTlx?=
 =?utf-8?B?UnJsc3BFazM0OEg3MnZuSFVONjVVdnloVXlBTi9zeVExWkN2L0NleFluOUp5?=
 =?utf-8?B?dStWSVM3b1hDdWxxRWRpc1ZJdDBJdDNlYnBxMTduaWZnWTc4VHFPNGpIYmw0?=
 =?utf-8?B?a2dWSDhpVTV4dVVxS1JsT0pTcjFWeVNuQ1o3SzJQRnZMWWpPZFBFeHc2ZzR6?=
 =?utf-8?B?RzhRaXg4cXVLZHFwcjZ2YkE3ZUdYR2M0cThzSHIvM2k1bVNsc21CRERVWWNh?=
 =?utf-8?B?V2JzTitnbVNLTndqb09rY2hLR1NEeHpCcXQyTzZwM0VJNmppMzhXVTZKZTUv?=
 =?utf-8?B?cUc1dVJJcXNvWnNMQUhHY0xkYjNFMGIzaEZYOU5zK3pTRVZVdmdrQVV6WkFo?=
 =?utf-8?B?SWFaTUx3Qi9EOGxZdXg4VWZwUDdXY0YyUGRPR3k0VGx5YzIyd0JOYXBsRCtL?=
 =?utf-8?B?NWNMQUp6U3gwVnNZU3hLZHRtaENTL0Vjeks1bnZZVTRqMHQxdGxoeDRXYktl?=
 =?utf-8?B?citCYSttRldIUjVCNHlYV2tneDk5U2hlVXBkWDdKK1N1NG5mSHdOUnBEemRj?=
 =?utf-8?B?N1NiL0NveVRwZmcreS8yQVRtWWpqdWVlV0lleUNWVXR6U3FhOGpyZWg0dER3?=
 =?utf-8?B?WnN1eENCSFdYdWpsRm1XYkVxUm8zeFdZczVWZXhiNHlwWDRQYlVURHVtT0dS?=
 =?utf-8?B?NkpBYUVhZHZvMklTNlo4aW9CeEszSUZ2TDJEV0R5WlZoVlBSOVpNbnhCNEZ0?=
 =?utf-8?B?ZktIZ2FQdGpsWTBLOElxSXlQNUU5c0J1WEpkdG1ieUhpd0h5VmRwUGtEZ3Jh?=
 =?utf-8?B?a2E0bjlMN3hWVFhsU3dPbzd1bGs3c1dYNUJ4WHhNN292MU84Y0VsR3hxbDVU?=
 =?utf-8?B?NFJFY1B5NG40TnNOYXI3THk4QTVyVFJKTG9zNXFuNkNZc1dSS2hnSTVVMzUr?=
 =?utf-8?B?OEh5SVZ4TkdhVWl1STNJV2R6NlJMZjA2dno2NkFFRFduWHhrYU9Zd05LM3NJ?=
 =?utf-8?B?MjdEN2FwTHNJQkQxM1pwRXBKdFRzcStDczY1dVd4V2hVZ09Yc2psYm1DYkR4?=
 =?utf-8?B?V2ZQSkJwR2JrS2E1ZVpNTUNycVc3aFJPaE9BbFNtdS9VSEJYNFVmMlpBVDFB?=
 =?utf-8?B?TkpTMWJOVmw0a0ZsVTFvU3F0WGVjcW44aVNIYU96V28xNTVSQlViaTJqUzhV?=
 =?utf-8?B?TUlkVFpLaUpuWXdTK1kxWUZPVWpacFVnUVllRkxKeXg4cHNCelRNU2RMd29X?=
 =?utf-8?Q?RWXpG+XQGkMeqlt5Y5IkUAa4l?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcb60e2-d554-40aa-eab3-08db82311260
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:05:47.7735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5YtLwPhMwXYpJIhNCxo+TDG6gGYPJyRaJBid69TBypjtdg9G5c5+z12RGrtD98s/1nrsYpmbIykcTEQl19IRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6147
Received-SPF: pass client-ip=2a01:111:f400:fe0c::731;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
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

On 6/26/23 18:08, Andrey Drobyshev wrote:
> Add testcase which checks that allocations during copy-on-read are
> performed on the subcluster basis when subclusters are enabled in target
> image.
>
> This testcase also triggers the following assert with previous commit
> not being applied, so we check that as well:
>
> qemu-io: ../block/io.c:1236: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.
>
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
Reviewed-by: Denis V. Lunev <den@openvz.org>

