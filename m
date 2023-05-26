Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD4E71265E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 14:13:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2WKE-0000hy-D0; Fri, 26 May 2023 08:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1q2WK9-0000Pn-FU; Fri, 26 May 2023 08:13:39 -0400
Received: from mail-vi1eur05on20731.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::731]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1q2WJz-0006Hw-3w; Fri, 26 May 2023 08:13:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRMCuEFpWy6s9lJrsgSLf2dBabr+IKdZqPul2pR2tJq17Vf/TzDm8qz8u+uebeataGiwIoGdghd8Cf8+83GZBYzRhxF/dxAYA09wqWGFZkibySi0V+MddYMAi/Moipw6U0V0B3By0D4Y6UIDo5XqBHbn8tc/Qb/A/7WxRXGVWsT22u8BKR5xSODpM3w4uRVTyCKEEFfrdYXaU2LGcCCQoDrDTRehUDJlGePN5nnRpj+QdIf3kKuHCLMVQFmoP8SkeOSkKjpdtQzlK+2F+DL0uQW35j3H69O3itDkHveOALGvd4032W5aumzdtrY23KYpNmXiFAgrZmbqWCFl4ARMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMhHDnw9BwDD13eicME5IUXXwQtLT0VM5P60MdSAeIg=;
 b=jVIF1XNPEXcnivDrwYZptjS7x3xuJeRFEbraF26+gkbDNZ07OkJT5PAmDBTJO0JA49XTcCtOEyGyxidPDY8Lirc7bL8APQuCn/HrjR7BVymSa3X85XvINuqHoee/ufM1fv4Rd8/xyKhh/VBU54eCzEpcwJzOLXrFcf4wngqIuegCL6W0bk0CJAu/mWbmhOHPy5hpW6xQqvY8JR4oOJhM7d44vARNVOqtBBr+wWCFsxF2RToer9ROgv6Qm0oIPszb3h51lfQcoAzObJfrx3dE3/EtLSlUh10IYuXRltTI9EBYVUxgjTCYXzIOX27mFh0IsQZQyBk844y6goEgk7Kwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMhHDnw9BwDD13eicME5IUXXwQtLT0VM5P60MdSAeIg=;
 b=Jxmmp8vaGf2c96IkUSXCN0v3LQ++8SEFt8H3U/BlFOqBiSA6D5tyEWJz81/hWYs031Cv/LfdEVfTYO3pg5FygYaEYiBIB1+nKex4lpKJKsaMJMvHoqxVs9EwvD3sG2F9IBnxoK5O1Yx1FmoTKtjoFzi2/V7Pm/wIefxV8Lzes9gctNYXFUrHRa+1OkP8OoHEQDDDVI7VUGeia7/doPKV9D7L5nusCPBtpCIdnGTVZs/bS/G8NgxwG0oXCuVrrqiuNmaGN2GdfjqMJAu0AAJOgh4Fu9/ho6u+WVPSmqNtIujp+YSO6/fbv1YcFvv7OKheZkuTV8X/UKAnO8WilKKJRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DU2PR08MB10262.eurprd08.prod.outlook.com (2603:10a6:10:46e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Fri, 26 May
 2023 12:13:21 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::b50f:b94:a801:adaa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::b50f:b94:a801:adaa%6]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 12:13:21 +0000
Message-ID: <1de3094e-8ea1-52a3-8717-e5133e86d25e@virtuozzo.com>
Date: Fri, 26 May 2023 14:13:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] qemu-iotests: 024: add rebasing test case for
 overlay_size > backing_size
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, shmuel.eiderman@oracle.com
References: <20230525180213.902012-1-andrey.drobyshev@virtuozzo.com>
 <20230525180213.902012-3-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230525180213.902012-3-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0096.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::37) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DU2PR08MB10262:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4a6556-1910-4590-5fd5-08db5de298b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRFTBbF4DByFkGhWdPIuXy/uaHfChv8Qtth1GJkliEglUsHd+vXnGTI424U0tSNUXp5XNEXsjKsFnhMm5T4EXDK8m0QfR2pUyTuN2YWZSWhQXOzvmnqqRonbIv56HteQq4AHK9tlYX3fNb/nNANlGsp0zEfmugYRCFwQYoBYrzWiBXKRLUEIPY1W/naFdNq8nHF39KMTXY3+U/zAefLJTqqTJUhXNXd4+iy6JP3MykqEJ4PrEeOdoUUtu6E+AE34+/7m3x92oarE2xyQVK6swJbFYhSOXxfHGeC2C5/cvCCKAWeJRp9v4Qrm7MfcVR756HFZu058AfTTdVBTvTbtFLDJ3f0yoLnvCcDY0GT1EQwDuW8amWFOFHw2ZsdQdbTRVY5/nqLxh/dzKQ4T24hYzrhMqcnOso3byWnK6nxCTcz2xEjhfIZsl6tdZqPvfSTQ34vYTn9HN3/G9XcmvXeVV8eIvBj3CZvq+IR4tvr9mT1ySnCR3gzVJMlBK6Rntzq/a/ZnjV4tWonfqO4oae6lam4yaRvVO7HtD/it005Qa9ebEr+PnCgTHUH93o86bi5vSWbwTQVzxLaNvEOpDVFaNt5FLG1tf+8ljPFy1hygS4O42QLGpNMx7PRB17xEysJx8YMZm/oMtmw9tljm7xZ4uWd38yZeSXl3CyQLlrtdl24=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39850400004)(366004)(451199021)(6486002)(41300700001)(26005)(83380400001)(186003)(6512007)(6506007)(2906002)(53546011)(2616005)(31696002)(38100700002)(86362001)(8676002)(5660300002)(36756003)(8936002)(66946007)(66476007)(4326008)(66556008)(31686004)(478600001)(316002)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWgxL0lydkNENkkxZk5Na2hRMjllTExLQ0p1ZGc1MElvNnRGWmZMVmc0U3Q3?=
 =?utf-8?B?c0E3aENEZkU3cW9QY01ISWdoWWplN3ZzQldGd3A0cDFiT1A2WDFpME5oVm90?=
 =?utf-8?B?cmhnNmk3TXZsOGxDMG1hV0FlZWVOc3Q2U09xNlpHam96U0J0ZUhDK2NzUldm?=
 =?utf-8?B?UnUrTlU4OTVtMzludEUzbjRIMVBVTEdkVDNuVk9SL29QZDlGVHVFQnROTFJk?=
 =?utf-8?B?MmtjQmhWbFF5MU1aZnFkUUNHeFc4OS83VVdKZ1NlNFV6V1ZDaXhNM3pEWXNB?=
 =?utf-8?B?Zy84YzVXMFl1LzhNSm9mUzBqVFRkVUNQb3l2R0dqRDAzZlV5MUNsSzNQT3kw?=
 =?utf-8?B?SmV2M0hxMXppOFViVXJEN3Z4Z3FjOWJtV0hmTlpQRFpWTk5SWHZxS3VZWlFV?=
 =?utf-8?B?MTgzOU82V1lUNkN2d0dMMmcyQytkQ3B1bVVDYjFSZ0tWc1piaUcyNmZFMkEy?=
 =?utf-8?B?amxCeHkwbjg3dTBZM25tNGp3N3NQWWZPaDNpZlJTem1HRTZrRlo3N2ZCaTkr?=
 =?utf-8?B?ak9jNWh4bjBrWlZtQjFrb2FiL0NBZXQyTXNxUHF5VWt0WSs1dlp5V3J0L0c0?=
 =?utf-8?B?M0VMeXBnSkREdkQrK0lCTE1wMmxpYllvL3NzbVNmSWpxcG5mUUhqNzNpbUhP?=
 =?utf-8?B?b1NlWmtFWVo4OGhRNk9WeHc4cmlzOG5ZT0xKRXVnZTlYdVZNaDJwNm9wZXh6?=
 =?utf-8?B?bnBOWGdjQmpLT2h0MGRBTnFhNEhiTFJLanozbE80RnBuNWw1RlVSNitWOWsz?=
 =?utf-8?B?cHVwV1BwNGZkcGhtS0F4TXNiSjhkRnhNbG5ZMFN6aVQzY20xSmZrMWo4TWJk?=
 =?utf-8?B?RzlWemFmdmY2NUxIdndYZXhLMXdKOXk1R0FubWVKbDV4Vy9ONkJrR01PTmh5?=
 =?utf-8?B?dDBSTVlXeVZ6SGhscGFJeHJ4ZDltcnptbUNsR1pRVVQwSnNQL0tzUCtqcnlM?=
 =?utf-8?B?OFN6K0ZBS2ZvOEFnclYrRkNZaXJQUzJwN0VHbTBtbFRSMDJSbWhJNWlndU1J?=
 =?utf-8?B?U2RlVDJIQzEvOUt3WWcrYXJtdnUxa1AzbnAydnZNSGZOcmduYnhIYjRqaTl1?=
 =?utf-8?B?WTZKNHF2VkFTNGtQYitFY0JsL2pDMkc1TmpIb1paZ1RoOExRbS9zUTVJVWxZ?=
 =?utf-8?B?dzU2L1AwRDNXWGNzdWxjWjlYak9xNWJjbmZVT3U3NzNZNW84dnNKZDcrOTJk?=
 =?utf-8?B?OHJPdW9YTXFSOWs2R3FFdHhZeFp0cVA1SzVYWk5ONDZqZHkyTlp6YkY3Vjdt?=
 =?utf-8?B?ZkV6Q2tQbmc1ZmdpeDJuVGJ0MVZwKzlJYmVHZ2lSNm1ZQllBT2kzN05OWGor?=
 =?utf-8?B?ZUFjYnVKbm1kRWxVNGgxb3J6Wi9sVWV2c0JsUkFhOXVEdGdVWHhMYmJSVi9l?=
 =?utf-8?B?WG1vOWZjb2tsS25ZQnJNVTBpZXh6S2NnQUZTbW9HNnl1QU80VFV1VndLb092?=
 =?utf-8?B?UGtQQklYTTcwWDhBcmp1YjM4aGo0Ti9HU3UwUlh1SUM5NWVINEdUTmFUOHJL?=
 =?utf-8?B?U3ZuQmREMjZWczI3TVZUL2lEcC8wMGdhNW1sN29mSXhRak42amRaZkwvZytT?=
 =?utf-8?B?TnMzZzB6NCtIbGVEU0srMmd3dFoyK2psbmhGQ05OVlh6Y3hCMjZNeWNIK0Mw?=
 =?utf-8?B?VEM2SG5NU3BHT2ZRSzFiQ1RETU12VzZzSEhkSXR1dXR3SnFvRit1NGROeVZY?=
 =?utf-8?B?RmFnRmpyblNWckhteHJaQVQwdjRYUWpTeXl6aHdJTGhZa0IrU0l3QmNOY3NS?=
 =?utf-8?B?UnVuM1d2RE5TeVo5TnpQRW9QZlQxakZQcGZpYjRqRDVyZ2Nwc2NMSmVxckxY?=
 =?utf-8?B?MUM3WEE2K0VrMDZjTkNLVnhkK1BHbWJLOUdzeVVIUWlFdk9TN1FuVUplQ1A2?=
 =?utf-8?B?ekZ3MENvR0daZVlNcEk0TG8xdTc1TWJCM1ZlVTdVY3RxVFpTRXFIOFhKdG1K?=
 =?utf-8?B?RFRRNk95OHFYWFJKUGhwNkJJSml2Qy9EME5PbEt4TVgza2M4c2w2TkczaUZK?=
 =?utf-8?B?ZEppbDZWc2Y3MTRTT2srNWdDWnRZTW9FMjZPYTNyMy9JUlVhaGo4S2dWdmxr?=
 =?utf-8?B?dTJSNjVVNGJSRGNmUXZrWlBtQk54NEo3RGphSGR1aHRFcmFSU25Yb1cyN3pG?=
 =?utf-8?Q?5FHBdr3q3mDjG1LpiOaVO4BHR?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4a6556-1910-4590-5fd5-08db5de298b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 12:13:21.0499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pc1Tyd13avjy3WeYOqZWRTmM8W1/1qzwgL3p69ZD0mNwVHA/83DZBAPRLhouY07zXgL+nfSNYiBcsp43w1IcdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10262
Received-SPF: pass client-ip=2a01:111:f400:7d00::731;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 5/25/23 20:02, Andrey Drobyshev wrote:
> Before previous commit, rebase was getting infitely stuck in case of
> rebasing within the same backing chain and when overlay_size > backing_size.
> Let's add this case to the rebasing test 024 to make sure it doesn't
> break again.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qemu-iotests/024     | 57 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/024.out | 30 ++++++++++++++++++++
>   2 files changed, 87 insertions(+)
>
> diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
> index 25a564a150..98a7c8fd65 100755
> --- a/tests/qemu-iotests/024
> +++ b/tests/qemu-iotests/024
> @@ -199,6 +199,63 @@ echo
>   # $BASE_OLD and $BASE_NEW)
>   $QEMU_IMG map "$OVERLAY" | _filter_qemu_img_map
>   
> +# Check that rebase within the chain is working when
> +# overlay_size > old_backing_size
> +#
> +# base_new <-- base_old <-- overlay
> +#
> +# Backing (new): 11 11 11 11 11
> +# Backing (old): 22 22 22 22
> +# Overlay:       -- -- -- -- --
> +#
> +# As a result, overlay should contain data identical to base_old, with the
> +# last cluster remaining unallocated.
> +
> +echo
> +echo "=== Test rebase within one backing chain ==="
> +echo
> +
> +echo "Creating backing chain"
> +echo
> +
> +TEST_IMG=$BASE_NEW _make_test_img $(( CLUSTER_SIZE * 5 ))
> +TEST_IMG=$BASE_OLD _make_test_img -b "$BASE_NEW" -F $IMGFMT \
> +    $(( CLUSTER_SIZE * 4 ))
> +TEST_IMG=$OVERLAY _make_test_img -b "$BASE_OLD" -F $IMGFMT \
> +    $(( CLUSTER_SIZE * 5 ))
> +
> +echo
> +echo "Fill backing files with data"
> +echo
> +
> +$QEMU_IO "$BASE_NEW" -c "write -P 0x11 0 $(( CLUSTER_SIZE * 5 ))" \
> +    | _filter_qemu_io
> +$QEMU_IO "$BASE_OLD" -c "write -P 0x22 0 $(( CLUSTER_SIZE * 4 ))" \
> +    | _filter_qemu_io
> +
> +echo
> +echo "Check the last cluster is zeroed in overlay before the rebase"
> +echo
> +$QEMU_IO "$OVERLAY" -c "read -P 0x00 $(( CLUSTER_SIZE * 4 )) $CLUSTER_SIZE" \
> +    | _filter_qemu_io
> +
> +echo
> +echo "Rebase onto another image in the same chain"
> +echo
> +
> +$QEMU_IMG rebase -b "$BASE_NEW" -F $IMGFMT "$OVERLAY"
> +
> +echo "Verify that data is read the same before and after rebase"
> +echo
> +
> +# Verify the first 4 clusters are still read the same as in the old base
> +$QEMU_IO "$OVERLAY" -c "read -P 0x22 0 $(( CLUSTER_SIZE * 4 ))" \
> +    | _filter_qemu_io
> +# Verify the last cluster still reads as zeroes
> +$QEMU_IO "$OVERLAY" -c "read -P 0x00 $(( CLUSTER_SIZE * 4 )) $CLUSTER_SIZE" \
> +    | _filter_qemu_io
> +
> +echo
>   
>   # success, all done
>   echo "*** done"
> diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
> index 973a5a3711..245fe8b1d1 100644
> --- a/tests/qemu-iotests/024.out
> +++ b/tests/qemu-iotests/024.out
> @@ -171,4 +171,34 @@ read 65536/65536 bytes at offset 196608
>   Offset          Length          File
>   0               0x30000         TEST_DIR/subdir/t.IMGFMT
>   0x30000         0x10000         TEST_DIR/subdir/t.IMGFMT.base_new
> +
> +=== Test rebase within one backing chain ===
> +
> +Creating backing chain
> +
> +Formatting 'TEST_DIR/subdir/t.IMGFMT.base_new', fmt=IMGFMT size=327680
> +Formatting 'TEST_DIR/subdir/t.IMGFMT.base_old', fmt=IMGFMT size=262144 backing_file=TEST_DIR/subdir/t.IMGFMT.base_new backing_fmt=IMGFMT
> +Formatting 'TEST_DIR/subdir/t.IMGFMT', fmt=IMGFMT size=327680 backing_file=TEST_DIR/subdir/t.IMGFMT.base_old backing_fmt=IMGFMT
> +
> +Fill backing files with data
> +
> +wrote 327680/327680 bytes at offset 0
> +320 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 262144/262144 bytes at offset 0
> +256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +Check the last cluster is zeroed in overlay before the rebase
> +
> +read 65536/65536 bytes at offset 262144
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +Rebase onto another image in the same chain
> +
> +Verify that data is read the same before and after rebase
> +
> +read 262144/262144 bytes at offset 0
> +256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 65536/65536 bytes at offset 262144
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
>   *** done
Reviewed-by: Denis V. Lunev <den@openvz.org>

