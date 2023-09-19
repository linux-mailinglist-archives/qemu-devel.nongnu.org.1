Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F31DB7A5EE7
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:57:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXT9-0004L3-O8; Tue, 19 Sep 2023 05:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiXT4-0004Hr-HJ; Tue, 19 Sep 2023 05:56:31 -0400
Received: from mail-vi1eur02on2070c.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::70c]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiXT1-00025y-K9; Tue, 19 Sep 2023 05:56:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYzuAi8M05pDsivZk5kL9BkMt8jMRp+MoO0FLMb/KBb2d8B8tIvKUywglWiWigldmoY/Pw7DE2WMKisIhRBDe/2wVDJRwl6Aak8i6JPiRAZtc4mNsNBBnVoqSF1mvEnV9yFGO++vhcRnVTFQIzvLHRF/R+bL8uY1axCOajYJLhd827lGZb9Xae206qRWvXmmiHhViLcI0z92x30LGGtM17Cckc8MJ1/tOAZpB2sn5OWOwmG3+8Urgo9WJkrf5+aiZfVu6WIfOcDs8eh1j7N/5vTOF+5T4S5thlndqZt334BD41YXxxfAcG2eW/A/B+odhLcoQCcNRlwxzCazGHRlAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsI3Z8+jrve4Jf13Yf+ysCDOD1pAbXDDgd2gNywtvTo=;
 b=crXAQ9hyUPzO0Yq1jGreEmiK4XPmQ0F5byQJvJk+iENghAKaUq2dKfcFGZvKsWZJQxidA6rdW/uDCyBVESUsWJmkCxcxBtcvX34/Wd/Iaih1vuHJfDG0xmnaxLCFwSlzpIAli2usC91X3PDIGSi6lEJjSGosqIg6XcHvk9WkXI0+4Zie7yn+0YCmKXUDqe5UfYoyJvHoUrw7HoYSBRUkmVltG6sgPgLxtHgUsWDdpI/wAVZzqK6YC8Ebt8F2zVulnuKIoL39gKFYhCuaBLBmy2Ag2aiNPmfSdUMMe0LqXHqbNzXfq2POZDcRwZBQ5alJ+ycgxRu5R6wSLLo8d4Wy0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsI3Z8+jrve4Jf13Yf+ysCDOD1pAbXDDgd2gNywtvTo=;
 b=0A/tSPRG9HgJmBHUKWdUcPl817lbDTozqAoLFsva9sYsch0g34h2dhriIY/hPmWpy/LJCBDg7ngFnB/FtOFUxPnu6/XEaZjZ1cY3Nk9T33lYI0bEtwSBQPgXGa19PucZeqa55rk4TA/g/9SaCk/KWg9mu8/QXp6jX7E6crb4BTGXeOb498kcoO/DM7Ws2mXjBQANmx2EEzeHTQEeLH39tpAVcX8AvHKGP7UoaoyN8ZWFogZ9+ft1ksCDc+vv5O4w4y077QZkX10sIlYKj+ZVAN0EeJ9TwK++pwVKZtXJSoofTMo3+jfVZ1fmCinPRU8la1eKDnOGY+aDAYv3FlzC6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAXPR08MB6383.eurprd08.prod.outlook.com (2603:10a6:102:155::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 09:56:20 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 09:56:20 +0000
Message-ID: <0824275a-9081-194a-1241-120481c91e92@virtuozzo.com>
Date: Tue, 19 Sep 2023 11:56:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 20/22] tests: extend test 131 to cover availability of the
 discard operation
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230918180100.524843-1-den@openvz.org>
 <20230918180100.524843-22-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230918180100.524843-22-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0262.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::29) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAXPR08MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca272f8-198f-4389-7138-08dbb8f6ace4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWC3uePvF4ebdhZOUVTbc+g8ZWVvlcdkwH2VABwoz27J6RHXkmWjz87XgtJwdULGNHVndHmBFB1LikgI/Yv8yG7Z9G0RQOElj8T2KB9PxKv5Pq5fxFIIET99Fr2ctCpHpk1DqdoU+T6TofaHMrPK3ifXmNIVF/H4Mp14+DSfwaHSW4dDpF28fSEyEyk+JfzRbXXcVrgZwXbqnBE/46grHFVTJ2QPPoEzQdbqWxLDLC7WvGVn6wBeMLtG8yka8pew6Tb8iCZSG2zPmxkrz6PXwnGRzLPA5WsiNDtVrIaVPTlcYhBlbIzbrQrXKYgPN7/wAra0VujhTMd1ha4Kiwi0aY/awoNkW9UmU9pBbCywsxj7sJpH0Vb4VA+YZpjd9lHfd0hOOFcnYCbUi5O9SJD5oTQvUmwDdIBpFOBQrxSxRJnwbZ3+Bv0+6/hghZ5uT4yr+WbSJdcXshCwPkDQjArb+9Q6qKbrf7fr7oZiwZjB9Z1HWwQlJhXbV4lm5UIxiH74a6OsPPvOLHham5j4Tboe8xRJDFeOJSQfkDah1Xfq+Hf9+V6GiblcFuu6U7IXvbRSUfMos/zMTouaZdMKaWT6t3oAnwotQr25pTICXz4B9hn+ikNfVUULFkvV2blzY4j73vF7JnVrA5Hvou5mr0z8sAGm0/EBGhtuRM+jHvGmMNuwKWThhjyJRorKJQbTRaBqAUYRe27Qs1b1W0p12kayMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(376002)(136003)(346002)(366004)(451199024)(1800799009)(186009)(83380400001)(6666004)(44832011)(478600001)(86362001)(31686004)(31696002)(26005)(2906002)(2616005)(52116002)(53546011)(6486002)(6506007)(6512007)(8676002)(316002)(66946007)(66556008)(41300700001)(66476007)(4326008)(36756003)(5660300002)(38100700002)(38350700002)(8936002)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVdsZTFaUzNKeFlMclF1YWdPaFZNZVluRWl6dnJtRUFpZWFBZzRJbWlFRG5E?=
 =?utf-8?B?WS9QMkQ4d0JTeE5rM3JGQVlZcXdnMy9kc0FzY3pVb2thSTdETUVRR2VwMEpV?=
 =?utf-8?B?aEJxZHJ4OUJ4dGhMUjE3OFlScisyR1lOeFMzSXMrdnpwVVNlWEQvSUlMN3Fl?=
 =?utf-8?B?NC92NUJDbzVFeWhLWkNxVUdoU1JxQm9Fd3hkb1A5c2JMcGMwYTArN0VHUEdB?=
 =?utf-8?B?ZGJyODNWQWJ5RWhtTDRXTkRlZkxlTk9kSmRJblF4dzJKR0JISGU0VWVjMCtY?=
 =?utf-8?B?SW9iRFhPdFdScW1VRGRCb1VaQUIzYlE3QzArZ3FYYTZQK3VSbVlCYVdDY2VH?=
 =?utf-8?B?eWRFNElQUDVuS1BDMzlMbllCY1FBTTQvM3drV2kxSzRxbm5YYWdOTkc3VUhl?=
 =?utf-8?B?emtTZjNwTWJHcHE1OHo3S01LRUxlUFZ3eVRNWE5RV0xMMkxtRnBHZFlNL1ZH?=
 =?utf-8?B?OTEvOFZSdHpnL2YyUjdBTnFlOW52dXhQOXYrNHNuMkwwTS9lc0Vzb1pHQkdk?=
 =?utf-8?B?bzlEZkhrcFl6M1M3K0FZaXBZWWVPSHlmTGsweGVzSENaTTVodVFKUGF2Ykty?=
 =?utf-8?B?ZkF5U0NmSkpmb1luelNXWW9odEtsY01UZEN4YXQzK05BNDJjMlA1ZGpjWHFJ?=
 =?utf-8?B?RDhXemxnV093ZjBrMmRPMm5PNEM5aFhMYUFBSnZ3d2ZOb0pUNlZ0Y1FBSk5D?=
 =?utf-8?B?Q3Iwa2Y5Z0lYbFRtZi94bVI0WEc2bVVuWEZMTy9MQm1maVIrS1NCdmt5L0JM?=
 =?utf-8?B?SnZQenFUZm5oNUFyNm11ckFmclFiZkwzQURDZFN2UTFPRFZvc1grME94SjE2?=
 =?utf-8?B?U1BsdFJaRUgrRmZKQThKMnVDaFFnR0c0Tld3VVZ5UTZsQWxaQUVhaUJDS2VL?=
 =?utf-8?B?Z0NoYjY4SEtCbzFwZWE0dGRLMDl1cHBDNE8rWmFlcjhLckNZTUsvbWt4RXBG?=
 =?utf-8?B?TFpuY0dvblJoS1JCNDN6NUVTUmRGVG5zSUlCcWw5Z3NVUzJlblhwTzhHY2E4?=
 =?utf-8?B?VFVRcld6dnNEVkx6ZnRZRWdZeU16Nk91eUJrU2RqRkplQVdjMDNHSFBneUpn?=
 =?utf-8?B?WDMyZGNUUGhMK1F1STJMS0x0bVlCM3RVOC9NcUJ4cC8weW5tSGFhQ3F6WW1R?=
 =?utf-8?B?M3B3SERGYkY4bXhYZFJzTk5QUnlCSUNXcjQ3dEovVDRZWE50bXJRWHNobkdx?=
 =?utf-8?B?d3VaYTY3YThSZXV6YVptbW12MzNZVTlBS0ZsR1FDenE5cjd2ZlZYMlRCQzlC?=
 =?utf-8?B?VUgrend6UnFaTExmQ0RoelE5SVJ5Y3pSbFpNM3RsVGlRTlZUK2NEYlZlamIy?=
 =?utf-8?B?Szh6dytMOWtLOURzWVhIdTRtekttNTlLaXB2R3d1amRzSDQzYVJ2N25NWHJP?=
 =?utf-8?B?WW1odERRTDFoZC8zRVh4cmNrZTBJVFR5MmF4MXpXTE0xNlJpdVlOS2xtSnZr?=
 =?utf-8?B?anhLNXgvWnV6RXVoM2d1MUdJTDc5L3lxd2MzOFBGT2lMSDdzWFVMSk5XeWF2?=
 =?utf-8?B?Wlc1WEVNMFRPZkYwVFhZVExJOWRScHdWSy9lbHNuc3F5QUlLc3J5N0V3Y3d4?=
 =?utf-8?B?R1lLL1JNdXE5dkMvc2x4TFdRSVFUWklpU3Rxd2wyZnBrWlQ2N0s4TDQwb1V3?=
 =?utf-8?B?ZmVBeU52TjMzMVdKUEYzbHk4ZTRPbTBicm5pYThQMHpUWnhGQyt6OHhvUTlY?=
 =?utf-8?B?RjU5dTloR0NrMWNORW0raEZNa1JHVU1jZHJuaUw5ejJ6SngzTXFUaEU1Sk9R?=
 =?utf-8?B?bUR6T3A5Z2ViK0RRaHNjeUNHa3Z1Tys2NGVGMzdFU1A0RXAwMjBuYjdsTGRO?=
 =?utf-8?B?c2cyUnBCc1NMd2RhMlBBVEtaVWtvREVCTURFUGpIVkw3RjJWVDlJbzhYTHZ2?=
 =?utf-8?B?dWFHTmI3ZCtZQ3RuVDJKTlYzVnlSTFREdFNjaVhmWTJMaENXeHI4MlVodUlP?=
 =?utf-8?B?N25Jb05lQ2E1NkpTbEU2MmFmQzJEYmkzUGNuREsreGFaRXprK3VxR3lhU3hO?=
 =?utf-8?B?ai9FK1lKV0VTbnd0N004a05XLzBYMDBoN0Zhd3JjemswNDJ2VFdRNS8xWVNZ?=
 =?utf-8?B?MEQwdTg0M1ZFVk9FK09FUVFRd0NaR2V6QnFkbUdnS3d2UFk4dkNrbXNPY3Vl?=
 =?utf-8?B?aEFCOGlLQnBxYnFiSFFBSjlRcHNYSmh6Vit6MkJZL1B2NHZ1cEdTV0xOZU9n?=
 =?utf-8?Q?Zp8Au8dlzvB0W4ZUoEKVo1I=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca272f8-198f-4389-7138-08dbb8f6ace4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 09:56:20.6207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wPNlu0UL2l5vs6mcuGbYZMbCHhKKyuKBZN72tWXfxhYVmG07n+1tMvlXqRKZ5FvOiuLao2MlGzPP1e1r3wWu+U2MJ/jZ4W0TmqBwT9Ppx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6383
Received-SPF: pass client-ip=2a01:111:f400:fe16::70c;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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
> This patch contains test which minimally tests discard and new cluster
> allocation logic.
>
> The following checks are added:
> * write 2 clusters, discard the first allocated
> * write another cluster, check that the hole is filled
> * write 2 clusters, discard the first allocated, write 1 cluster at
>    non-aligned to cluster offset (2 new clusters should be allocated)
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   tests/qemu-iotests/131     | 31 +++++++++++++++++++++++++++++++
>   tests/qemu-iotests/131.out | 38 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+)
>
> diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
> index 304bbb3f61..324008b3f6 100755
> --- a/tests/qemu-iotests/131
> +++ b/tests/qemu-iotests/131
> @@ -74,6 +74,37 @@ poke_file "$TEST_IMG" "$inuse_offset" "\x59\x6e\x6f\x74"
>   echo "== read corrupted image with repairing =="
>   { $QEMU_IO -c "read -P 0x11 $CLUSTER_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
>   
> +echo "== check discard =="
> +
> +# Clear image
> +_make_test_img $size
> +
> +{ $QEMU_IO -c "write -P 0x11 0 $CLUSTER_DBL_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IMG map "$TEST_IMG"; } 2>&1 | _filter_qemu_img_map
> +{ $QEMU_IO -c "discard 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IMG map "$TEST_IMG"; } 2>&1 | _filter_qemu_img_map
> +{ $QEMU_IO -c "read -P 0 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +echo "== check simple allocation over the discarded hole =="
> +
> +{ $QEMU_IO -c "write -P 0x11 $CLUSTER_DBL_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IMG map "$TEST_IMG"; } 2>&1 | _filter_qemu_img_map
> +{ $QEMU_IO -c "read -P 0x11 $CLUSTER_DBL_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
> +echo "== check more complex allocation over the discard hole =="
> +
> +# Clear image
> +_make_test_img $size
> +
> +{ $QEMU_IO -c "write -P 0x11 $CLUSTER_DBL_SIZE $CLUSTER_DBL_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IO -c "discard $CLUSTER_DBL_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +# There is 1 cluster hole. Fill it fully and allocate 1 cluster at the end
> +{ $QEMU_IO -c "write -P 0x12 $CLUSTER_HALF_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IMG map "$TEST_IMG"; } 2>&1 | _filter_qemu_img_map
> +{ $QEMU_IO -c "read -P 0x12 $CLUSTER_HALF_SIZE $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IO -c "read -P 0 0 $CLUSTER_HALF_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +{ $QEMU_IO -c "read -P 0 $((CLUSTER_SIZE + CLUSTER_HALF_SIZE)) $CLUSTER_HALF_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
> +
>   echo "== allocate with backing =="
>   # Verify that allocating clusters works fine even when there is a backing image.
>   # Regression test for a bug where we would pass a buffer read from the backing
> diff --git a/tests/qemu-iotests/131.out b/tests/qemu-iotests/131.out
> index d2904578df..27df91ca97 100644
> --- a/tests/qemu-iotests/131.out
> +++ b/tests/qemu-iotests/131.out
> @@ -26,6 +26,44 @@ read 524288/524288 bytes at offset 0
>   Repairing image was not closed correctly
>   read 1048576/1048576 bytes at offset 1048576
>   1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== check discard ==
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +wrote 2097152/2097152 bytes at offset 0
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Offset          Length          File
> +0               0x200000        TEST_DIR/t.IMGFMT
> +discard 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Offset          Length          File
> +0x100000        0x100000        TEST_DIR/t.IMGFMT
> +read 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== check simple allocation over the discarded hole ==
> +wrote 1048576/1048576 bytes at offset 2097152
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Offset          Length          File
> +0x100000        0x100000        TEST_DIR/t.IMGFMT
> +0x200000        0x100000        TEST_DIR/t.IMGFMT
> +read 1048576/1048576 bytes at offset 2097152
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +== check more complex allocation over the discard hole ==
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +wrote 2097152/2097152 bytes at offset 2097152
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +discard 1048576/1048576 bytes at offset 2097152
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1048576/1048576 bytes at offset 524288
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Offset          Length          File
> +0               0x100000        TEST_DIR/t.IMGFMT
> +0x100000        0x100000        TEST_DIR/t.IMGFMT
> +0x300000        0x100000        TEST_DIR/t.IMGFMT
> +read 1048576/1048576 bytes at offset 524288
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 524288/524288 bytes at offset 0
> +512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 524288/524288 bytes at offset 1572864
> +512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   == allocate with backing ==
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>   Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


