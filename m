Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DE0738FE4
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 21:17:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC3KD-00011J-9w; Wed, 21 Jun 2023 15:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC3Ju-0000sY-OC; Wed, 21 Jun 2023 15:16:51 -0400
Received: from mail-ve1eur01on0713.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::713]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qC3Jn-0000m7-T6; Wed, 21 Jun 2023 15:16:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcOXL07ESM6BMRITWz6zYifkJHKCRlxixdKi/e5wqUg4qaZfwltjKDGpowNFFl6N3IsL9OyImoZWcb8dmfnoVXikoZ/5JtF99jsSRT5jFGk8bsp4uy/Abng4FBq1kIqG6bPCc3P5Rooa1+otQP0wAQ6RptT1GDyeKOcZBhbSDiCR3G/ac3t1aYfg8bd7mN5jBWP1YBiHxLFDPojEBCrTQ/rYBsZ+TMZl3mtHnxX7aEACz8t7sw/ZwnHWIOKyTkaxzGsVgnU4ZD6X/ihVDDnH8VEZpOApGl0/B+CFPIiolP9S12nrqHHwy4huaLwiK6R96BQmQTqSi515XU8eopu1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSooOkbD2uE1raAqY4g7CZo/YqXwMh7eAjINnxbOCC4=;
 b=bMSJ8XSWjXpPvxTxSl5QUENJOCvTgW9nVj/8sm6SUHYlcip2hH2/ysxbX52YWm50TRByVeiCJBweHKUQgcaWaa8StpmLlmSmyP8x7iZymDgibLEl3GJC7TgKHjVpuNRlGLr5S5otFD02VQqNFXfEw1GozUFuVVnlANLPfAjaRgep4K3yS+3m9D+UQQOeRl8xzIX3rUjrT7rrxwwQ48fGWRPgXoydu4WyLf3KQ8xI4jx+avSm15lVyiwnHbI2wbQzD1jTrMWgIQD9l3ccXXjt4eCmeZAHpaHCp06/gqur3KhngvRO6hzMfI+7O26syNu6KWTkXQl2WPSI7whY1CWEzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSooOkbD2uE1raAqY4g7CZo/YqXwMh7eAjINnxbOCC4=;
 b=DT+VqdRiA30A1AkQjZmXAlhrxlHpJMc7zpuIEZbLReUNTOxJ1rFAGp9zBu6REzMSq+45bK2YP0KMZf6zsWEL/f1a5FapWp9WNCcTOlstyefgH9ND1rxaWByEw3FNHkWXOUdgbWnePm0L9soUg+86XcegU7KvjuFkTS7IWug3IuvZPvkAsGjehwHpOujis/y4I5w55o0GEdcaPSnONaEyJptP9Y6r1rKmERCRnq3Vy7+BFNudY4GlnFMTLDczjAYa8H1sS0tF3b+YSRP3LZb0wdpl4WAhvUfFav50duDHAdYJQmrJGmpkfyi+baZf/0XC0UrmNE64M9ZVro43Kq1JWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PAVPR08MB9505.eurprd08.prod.outlook.com (2603:10a6:102:315::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 19:16:34 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%5]) with mapi id 15.20.6521.024; Wed, 21 Jun 2023
 19:16:34 +0000
Message-ID: <b69b3cd1-c38b-bcfa-6f69-2beef363b58c@virtuozzo.com>
Date: Wed, 21 Jun 2023 21:16:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/6] iotests: add test 314 for "qemu-img rebase" with
 compression
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-7-andrey.drobyshev@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230601192836.598602-7-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::7) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PAVPR08MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db2aaeb-cf80-4a45-d8fb-08db728c06c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+YYU6afj/MjPpfQfUjHxM42mktQ1Cful+uy3oR4DRu4oYFJKUk+fd0zysBUb+pslf2tmKokBMMbjXi4GafD/pfkq9KFcPPB2QrhXuT/tSlcIxXVV8gBsjfaRUGSn1s+WHFKWuCIY9rMeF43a9cAMpJC2aEf+OcFHZXsyPtyPHBDJXf5vu1RexG52dN6rtF4Dy65zJXgSifE+Yvr5wdtjzU0ld+0Z4YbxeQAv/0DU5pTR8ZLvY9X8cxDv0b7D4P1x474vE7wmTisze0eWQD8R05yomEQpcpD45jifpfbyTKtayfo31SPLRAUXmLPpnKMudEncHAjV8qHAGFp1VvfDlydyHB2RfKiKTO4RLgX/+JZzZKQmCac15vdVUGKiwvYWlP555uJwE2oFn/c+zmB5uyKtPgyUWJ45aVZRatmOo+VD/9v9VjSYw86t3+n/DD920CqqwRvqkeDQyAGj1HwfIE4tIVq9GHx3e5Pqhf3RRl76x2am8CXK7xaHlSxXJZKqZKWDdqsnlsuh1rFtiNm1bGTNGUhPzMa+ddPMKEmYYckjFUbN1v+IgpczdLDQj0gO7uwsn38Qx3D4PeFkDFvEOvotN5J354Yly6itvtAmdRxVJNo4mXVacBIRZREJ/RqHy8uPG4FMKDpfsCK0ZEr1WDiftxP6h6kmkU3K3Q8pQequ9lxHAMCimSWhKcYK4oW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(366004)(136003)(396003)(376002)(346002)(451199021)(6486002)(6666004)(478600001)(38100700002)(186003)(53546011)(36756003)(83380400001)(86362001)(2616005)(31696002)(6506007)(6512007)(26005)(66556008)(4326008)(66946007)(66476007)(316002)(31686004)(8936002)(5660300002)(8676002)(41300700001)(2906002)(30864003)(21314003)(2004002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjYyWm1CSXlrVGtvL2lYUXdVL0dRelc0YVk0RFRMWVFkVVlRNkF6TThZYnlE?=
 =?utf-8?B?bzl2V29uVWxrWkFFSTVIMWthVnlXK2tmZ25Cc3RWcnRKalBCcnVaelU2TzVv?=
 =?utf-8?B?Rzc2YTNBZ3UrMzZCUWJzbWgrMGtkZDVJN0ZSQjJ5a3pNeHdtVEVoV1MwOUJ0?=
 =?utf-8?B?MnZxYmtsMmhLN0F0L2NaQWpHT1hmakl4UWtxMnNHNVlGWGxGZGFIOUkxM0sz?=
 =?utf-8?B?eUlOOTd2cDBSSGo3b0ZzZ2F5dnhOL0c2YjFyUGdqVm5UakdBaG54Tjg2Y09H?=
 =?utf-8?B?cytMT2dDd284KzZkaTBpY2kydm5BbkRPcUVDUGpEY1g5WmVGUmlVK2dXTVdw?=
 =?utf-8?B?dlRVVHRNeHdXTG9ON0tZckhOU25hSXNKYmlDVXhOUXd4N0dTdWZ5ZjFqaG9u?=
 =?utf-8?B?cTNxc0FZTDRIcjRjcmJUcGwwTlM4eVhUYktWYld3djMrZS8rR0txdjdpNXBj?=
 =?utf-8?B?QkdXdnZFcWc1MHVmaXBkV1dMaHZ4SHJ1MzRkb0FvODA0TEw3S2dBODJQZnJO?=
 =?utf-8?B?ME44Rjg2em1ybkp6R1JNclg3dm9tTS9tcDNxSzhuTFUzakh5MlhRS1pUWlRl?=
 =?utf-8?B?bWlzdWRzQzZzT2Y1cnFjZmNqY0dEYWhVYjhGS2ZnS2NHb3dmNThsc3BiODdU?=
 =?utf-8?B?RnhSM2VqTU9KMUY4SS9FY1BNWERPVmRKMVJtMUdQbE04aXdsbUw4TnVoaSt6?=
 =?utf-8?B?NTBnODhjRU51V1NianJ6QjQ5SThTaW90UGxEVVk5QVp4WmNWSTVac2FJNklK?=
 =?utf-8?B?TnF3VjlHbnlwVWUyNVpkekpWL09vQXFsSWJiSXVDNms3b09DR0NBMXVwMldt?=
 =?utf-8?B?SkVUaHBydHErU29ZenlwYTk1Mm5CU1F4NS92d0JyNzcxWG1NTzZPY2VQMVk2?=
 =?utf-8?B?Q2tjVFB4MFROM1pJVDcreWJrT2Q2YnEzakhmTjlWcWhxekdPS3RFclhZVjhR?=
 =?utf-8?B?VjlRRE8vVExLVGpaQTMyRytYS25uR09RMk80ZkNvcTZjMCtXZ0FIZXgvVFZQ?=
 =?utf-8?B?VjdtS0pBTmx1amJzbTZSWW5sSERsZlZEdzZsN0RORWd3dU1jeG41TlcxN1Iw?=
 =?utf-8?B?cVFoaTI2VzB3ZXdPN3M1bnl3L0hOb2lSZzE2czFxNWI3STFiSyt6ZUttU2RZ?=
 =?utf-8?B?clBVamFVQjY4OFl6cjRLTHJLRnFPVkRHc2xXUWNBUGY0VHYySmtHUUhEVVJz?=
 =?utf-8?B?ck5RWEN4MElYdEYxdGRqVHd2NVdIVm9ZOXlaRFgrQTZCdU9KQ0xWeGVMeld4?=
 =?utf-8?B?SWx4ZE1QTlo0L1R5OER0eGQ0OHVZVURkZHp0c3VnOXQ5eFhteTltWjV3OGpx?=
 =?utf-8?B?TURzb1lyMzBJdll1WFowdWdiQXB0Q25KemtzYU9rNWlKV0NrajBSd0dzbVlN?=
 =?utf-8?B?MXdRRkVOK3N3cjRRY1RLT0VSdnhoeUZMMnY2ekwzSUNuMWxyRC9nejgxWTlM?=
 =?utf-8?B?Rkcza0JEcjRYRUR3UDNEbXBsbmczWCtmTnl1ZnpIazVsOGxGbm1VTEUvY0RK?=
 =?utf-8?B?OENYNVFTNWFlcU1aQ0VxSFA2OHFVeTJ6NWdYU2p1UUtEeEJMMlpWZ2VWZlhv?=
 =?utf-8?B?NTF0T0djRnV1NkFEN1A2WkZ5VVRQV2M1dVg4RHpscmRVdkg0Ymk0dFFIUXp1?=
 =?utf-8?B?OWJMeUtJTVpONnNkbUtxNS9hMDBydjBxeURaczhCNXBLb0U2aGlDN1pNdkRj?=
 =?utf-8?B?MUZSYWtrSjhpai9yYVIvSjJDb1lJdWFpYmdBckJ4eEdxV25SWXl6ck1tMFRW?=
 =?utf-8?B?OEJJZ3YvWlhLcTZjQnNCSmVvblgvajk1Z0Mzc2RGZWIzTStsb3c5OFFwdEhx?=
 =?utf-8?B?S2dueFZGV1hCbGZDdFFYSHlXTlAyc3Z0ZVFqRkt5TGFZR0RHTVAxV2FxZU0x?=
 =?utf-8?B?NmZ0SGF5UmpOZWdjbGtsV3BDRGIyaDlwZ3RVT09MUVNGVHFSbWNlRWJnaUc5?=
 =?utf-8?B?Vmp3eWNmdGJVYmd6MnFZTW5LR2NwVWtNM1hjQ3BlUVJZTElVcEh1STBLZFpp?=
 =?utf-8?B?KzB3VHpoUVFTK1JQdWZrdVE5MmlXb1Rud2lmRkF3aXcvdnAxTW0rNmN3aFRB?=
 =?utf-8?B?cjR1WlFCNXM4Q2F5emYvNjdPdGNVRTVVTDFNN3hTaTJ4WExwcjFNU0R4L0pC?=
 =?utf-8?Q?DLutD8DEwoXX1ZTfP0alZfqaZ?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db2aaeb-cf80-4a45-d8fb-08db728c06c3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:16:34.0705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHONiGetohm0Dh5S5iVThm75dtqbrMt7cqGrFGxPHikN2ilmkQtqDyh6e4x4EQAKCAUuE/BaWseHyrUNOnHG+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9505
Received-SPF: pass client-ip=2a01:111:f400:fe1f::713;
 envelope-from=den@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/1/23 21:28, Andrey Drobyshev wrote:
> The test cases considered so far:
>
> 1. Check that compression mode isn't compatible with "-f raw" (raw
>     format doesn't support compression).
> 2. Check that rebasing an image onto no backing file preserves the data
>     and writes the copied clusters actually compressed.
> 3. Same as 2, but with a raw backing file (i.e. the clusters copied from the
>     backing are originally uncompressed -- we check they end up compressed
>     after being merged).
> 4. Remove a single delta from a backing chain, perform the same checks
>     as in 2.
> 5. Check that even when backing and overlay are initially uncompressed,
>     copied clusters end up compressed when rebase with compression is
>     performed.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qemu-iotests/314     | 165 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/314.out |  75 +++++++++++++++++
>   2 files changed, 240 insertions(+)
>   create mode 100755 tests/qemu-iotests/314
>   create mode 100644 tests/qemu-iotests/314.out
>
> diff --git a/tests/qemu-iotests/314 b/tests/qemu-iotests/314
> new file mode 100755
> index 0000000000..96d7b4d258
> --- /dev/null
> +++ b/tests/qemu-iotests/314
> @@ -0,0 +1,165 @@
> +#!/usr/bin/env bash
> +# group: rw backing auto quick
> +#
> +# Test qemu-img rebase with compression
> +#
> +# Copyright (c) 2023 Virtuozzo International GmbH.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +# creator
> +owner=andrey.drobyshev@virtuozzo.com
> +
> +seq=`basename $0`
> +echo "QA output created by $seq"
> +
> +status=1	# failure is the default!
> +
> +_cleanup()
> +{
> +    _cleanup_test_img
> +    _rm_test_img "$TEST_IMG.base"
> +    _rm_test_img "$TEST_IMG.itmd"
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +
> +_supported_fmt qcow2
> +_supported_proto file
> +_supported_os Linux
> +
> +# Want the size divisible by 2 and 3
> +size=$(( 48 * 1024 * 1024 ))
> +half_size=$(( size / 2 ))
> +third_size=$(( size / 3 ))
> +
> +# 1. "qemu-img rebase -c" should refuse working with any format which doesn't
> +# support compression.  We only check "-f raw" here.
> +echo
> +echo "=== Testing compressed rebase format compatibility ==="
> +echo
> +
> +$QEMU_IMG create -f raw "$TEST_IMG" "$size" | _filter_img_create
> +$QEMU_IMG rebase -c -f raw -b "" "$TEST_IMG"
> +
> +# 2. Write the 1st half of $size to backing file (compressed), 2nd half -- to
> +# the top image (also compressed).  Rebase the top image onto no backing file,
> +# with compression (i.e. "qemu-img -c -b ''").  Check that the resulting image
> +# has the written data preserved, and "qemu-img check" reports 100% clusters
> +# as compressed.
> +echo
> +echo "=== Testing rebase with compression onto no backing file ==="
> +echo
> +
> +TEST_IMG="$TEST_IMG.base" _make_test_img $size
> +_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $size
> +
> +$QEMU_IO -c "write -c -P 0xaa 0 $half_size" "$TEST_IMG.base" | _filter_qemu_io
> +$QEMU_IO -c "write -c -P 0xbb $half_size $half_size" "$TEST_IMG" \
> +    | _filter_qemu_io
> +
> +$QEMU_IMG rebase -c -f $IMGFMT -b "" "$TEST_IMG"
> +
> +$QEMU_IO -c "read -P 0xaa 0 $half_size" "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -P 0xbb $half_size $half_size" "$TEST_IMG" | _filter_qemu_io
> +
> +$QEMU_IMG check "$TEST_IMG" | _filter_testdir
> +
> +# 3. Same as the previous one, but with raw backing file (hence write to
> +# the backing is uncompressed).
> +echo
> +echo "=== Testing rebase with compression with raw backing file ==="
> +echo
> +
> +$QEMU_IMG create -f raw "$TEST_IMG.base" "$half_size" | _filter_img_create
> +_make_test_img -b "$TEST_IMG.base" -F raw $size
> +
> +$QEMU_IO -f raw -c "write -P 0xaa 0 $half_size" "$TEST_IMG.base" \
> +    | _filter_qemu_io
> +$QEMU_IO -c "write -c -P 0xbb $half_size $half_size" \
> +    "$TEST_IMG" | _filter_qemu_io
> +
> +$QEMU_IMG rebase -c -f $IMGFMT -b "" "$TEST_IMG"
> +
> +$QEMU_IO -c "read -P 0xaa 0 $half_size" "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -P 0xbb $half_size $half_size" "$TEST_IMG" | _filter_qemu_io
> +
> +$QEMU_IMG check "$TEST_IMG" | _filter_testdir
> +
> +# 4. Create a backing chain base<--itmd<--img, filling 1st, 2nd and 3rd
> +# thirds of them, respectively (with compression).  Rebase img onto base,
> +# effectively deleting itmd from the chain, and check that written data is
> +# preserved in the resulting image.  Also check that "qemu-img check" reports
> +# 100% clusters as compressed.
> +echo
> +echo "=== Testing compressed rebase removing single delta from the chain ==="
> +echo
> +
> +TEST_IMG="$TEST_IMG.base" _make_test_img $size
> +TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT $size
> +_make_test_img -b "$TEST_IMG.itmd" -F $IMGFMT $size
> +
> +$QEMU_IO -c "write -c -P 0xaa 0 $third_size" \
> +    "$TEST_IMG.base" | _filter_qemu_io
> +$QEMU_IO -c "write -c -P 0xbb $third_size $third_size" \
> +    "$TEST_IMG.itmd" | _filter_qemu_io
> +$QEMU_IO -c "write -c -P 0xcc $((third_size * 2 )) $third_size" \
> +    "$TEST_IMG" | _filter_qemu_io
> +
> +$QEMU_IMG rebase -c -f $IMGFMT -b "$TEST_IMG.base" -F $IMGFMT "$TEST_IMG"
> +
> +$QEMU_IO -c "read -P 0xaa 0 $third_size" "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -P 0xbb $third_size $third_size" \
> +    "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -P 0xcc $(( third_size * 2 )) $third_size" \
> +    "$TEST_IMG" | _filter_qemu_io
> +
> +$QEMU_IMG check "$TEST_IMG" | _filter_testdir
> +
> +# 5. Create one-cluster backing and overlay images, and fill only the first
> +# (half - 1) bytes of the backing with data (uncompressed).  Rebase the
> +# overlay onto no backing file with compression.  Check that data is still
> +# read correctly, and that cluster is now really compressed ("qemu-img check"
> +# reports 100% clusters as compressed.
> +echo
> +echo "=== Testing compressed rebase with unaligned unmerged data ==="
> +echo
> +
> +CLUSTER_SIZE=65536
> +
> +TEST_IMG="$TEST_IMG.base" _make_test_img $CLUSTER_SIZE
> +_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $CLUSTER_SIZE
> +
> +$QEMU_IO -c "write -P 0xaa 0 $(( CLUSTER_SIZE / 2 - 1 ))" $TEST_IMG.base \
> +    | _filter_qemu_io
> +
> +$QEMU_IMG rebase -c -f $IMGFMT -b "" "$TEST_IMG"
> +
> +$QEMU_IO -c "read -P 0xaa 0 $(( CLUSTER_SIZE / 2 - 1 ))" "$TEST_IMG" \
> +    | _filter_qemu_io
> +$QEMU_IO -c \
> +    "read -P 0x00 $(( CLUSTER_SIZE / 2 - 1 )) $(( CLUSTER_SIZE / 2 + 1 ))" \
> +    "$TEST_IMG" | _filter_qemu_io
> +
> +$QEMU_IMG check "$TEST_IMG" | _filter_testdir
> +
> +# success, all done
> +echo
> +echo '*** done'
> +rm -f $seq.full
> +status=0
> diff --git a/tests/qemu-iotests/314.out b/tests/qemu-iotests/314.out
> new file mode 100644
> index 0000000000..ac9337a543
> --- /dev/null
> +++ b/tests/qemu-iotests/314.out
> @@ -0,0 +1,75 @@
> +QA output created by 314
> +
> +=== Testing compressed rebase format compatibility ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=raw size=50331648
> +qemu-img: Compression not supported for this file format
> +
> +=== Testing rebase with compression onto no backing file ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=50331648
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=50331648 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
> +wrote 25165824/25165824 bytes at offset 0
> +24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 25165824/25165824 bytes at offset 25165824
> +24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 25165824/25165824 bytes at offset 0
> +24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 25165824/25165824 bytes at offset 25165824
> +24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +No errors were found on the image.
> +768/768 = 100.00% allocated, 100.00% fragmented, 100.00% compressed clusters
> +Image end offset: 458752
> +
> +=== Testing rebase with compression with raw backing file ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=raw size=25165824
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=50331648 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
> +wrote 25165824/25165824 bytes at offset 0
> +24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 25165824/25165824 bytes at offset 25165824
> +24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 25165824/25165824 bytes at offset 0
> +24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 25165824/25165824 bytes at offset 25165824
> +24 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +No errors were found on the image.
> +768/768 = 100.00% allocated, 100.00% fragmented, 100.00% compressed clusters
> +Image end offset: 458752
> +
> +=== Testing compressed rebase removing single delta from the chain ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=50331648
> +Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=50331648 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=50331648 backing_file=TEST_DIR/t.IMGFMT.itmd backing_fmt=IMGFMT
> +wrote 16777216/16777216 bytes at offset 0
> +16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 16777216/16777216 bytes at offset 16777216
> +16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 16777216/16777216 bytes at offset 33554432
> +16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 16777216/16777216 bytes at offset 0
> +16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 16777216/16777216 bytes at offset 16777216
> +16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 16777216/16777216 bytes at offset 33554432
> +16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +No errors were found on the image.
> +512/768 = 66.67% allocated, 100.00% fragmented, 100.00% compressed clusters
> +Image end offset: 458752
> +
> +=== Testing compressed rebase with unaligned unmerged data ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=65536
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
> +wrote 32767/32767 bytes at offset 0
> +31.999 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 32767/32767 bytes at offset 0
> +31.999 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 32769/32769 bytes at offset 32767
> +32.001 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +No errors were found on the image.
> +1/1 = 100.00% allocated, 100.00% fragmented, 100.00% compressed clusters
> +Image end offset: 393216
> +
> +*** done
Reviewed-by: Denis V. Lunev <den@openvz.org>

