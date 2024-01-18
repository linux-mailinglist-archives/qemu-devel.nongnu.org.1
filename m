Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B42F9831AFA
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 14:59:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQSvN-0007pQ-BU; Thu, 18 Jan 2024 08:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQSvK-0007oY-Rd; Thu, 18 Jan 2024 08:59:14 -0500
Received: from mail-db5eur02on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2608::701]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQSvI-0004Qm-S9; Thu, 18 Jan 2024 08:59:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfxhhUBapu7bLe0latlf9w1rPZ0izSWuD5xbd2koVSNpnFrqAucyyYqElqBCWXkWwjU72vzqNn0kICwxppVCqtv7Qnk2lUgXxkZvG7ncTvLWJWCFiNUPEKZpsGZ+nFr5yv5TRiHR7a3mNkkwO9FVimc7VBCihx0s3nI1KGZX6LyFNljxYOUrdym/lzTnKhs0h8mX9n6/CRvmjiYG9AYqPfBslE/vrIBiBR+OhlWzkXPK+ooz0EeeHdfNCim/+72k7ZeNc8cCjuo2YxhglEcqx+R9b/pz5xRRqaTkioVdvpfJVLx2657+ebbgIpT5b73L2KVEnA6D1A3fsCd25gpbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qasRLrt30hs5L5bOlmx3xxwJuvDZZuXNrxpqUt3YKMM=;
 b=LB6IU084f1M6ZzQ1MyaZY0Ph922UpoZalQqteYpyRxijmCiV8OeJ4D9uqN945d/pzwoW49i7XTnEjMgzHlo+o3GA4/RPgHUIvKzW2bs73M5Y7+P+fwRFp3I9TgrKTKpcmEyR4AItZ3iYCE/wXX5r/ZLDKwdMLY/FA7J5KjIM0UNVoFq16GTSQBP7Y/cgMfUWwb5SCm6wVuhf45iHARepV1XiD6Hq76IxmJCIeP27vn1hDcLDvbyh/9zqtwui9djKuVVSM1mEMULjB2wOi7u+aHUTqlrUB8NP78eIaRRSYzIiNEH78aXV0OkrtA6TkEBa/H3F0t3X6hhj+JgVMQb5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qasRLrt30hs5L5bOlmx3xxwJuvDZZuXNrxpqUt3YKMM=;
 b=QwVa7mZ9zYHC+M0Bq7aZBgO8/qwPJY5miubm1sCwpXfoA7C+8jdZVrSZVi5IJlflBhoWSpEBOtcYihbIJ4zBEBgmZw7xjZTgIRFrE6IoIIJQWPN/1KHrnpYgnSSR0ZMXQyx16r0h4vhVoMgUimgMfMl7dwyn8bOCtrV6zY+WvchpZGWwcQQS852aa58FNWpg1qJQIrL6WhAcTAivn+0frAb/PxM0rF8CNMB1ab/u8LaQ8peGnfBR8d7kfAdliBwI57xn0o7doSaSLLFZlSvcEcw3ZuTdTv039L6P8ScDg8NJOKmJ6QuILeI0lAJT4QUSYlYblay9q4hkAb7EpuJoUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by VE1PR08MB5821.eurprd08.prod.outlook.com (2603:10a6:800:1b2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 13:59:07 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 13:59:07 +0000
Message-ID: <18274de8-91ab-4723-b35d-20853f06beb4@virtuozzo.com>
Date: Thu, 18 Jan 2024 14:59:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/21] parallels: Make a loaded dirty bitmap persistent
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-15-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-15-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0038.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::27) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|VE1PR08MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb9f922-56b5-469a-c071-08dc182da35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysukBJINcFxbuvlvAJMm/QqOwJ4ukXY1ZklHFXOByi/esG6jglzrPawpVcptoK0xhBkh/vcY2wQ4y3fwEw82Fdng2mp6fddY7SSObJv5QLEnmwEoVkLL9gQ3KE8SW+y7NMEilttx7EDqrXswILQSynFqpe0aS0VjEyJIMD4To9dQtZkduAqYWMiyBpW+8paE/d3gJniNgtj+3GJfRTsAMXyPI+YgkSNTwJYpNLGwYo+CHIYlpk38DKGn3Xxo9ENb5oq+FobWNTMsRTLg+vpe5eV9BCLagrI2IrjXp476r7V3KzuWIYZKzriAZW1+A48efm7bRnvXlIl8F+slW3f/3J0G54CbbjlMBjqw8ERjEdb92wewZGVlGvnXDkuWtBUde/yrhpmXjC3mE4iwIL68w+K6I1YNJZmMwXb53r4RDg/aEaPYz4G1vHBZO/qAnz3EisAEQLvamZm9U8KTQR4W5Wpix0brIrtCXl4d3J888bY86Fv9cRkjv5E8orAeDCJxpHQexffViklHGQ8gr4m3lnTD+sv7OYHEY1awuBls774+TLFj9t0QBbIoENw5unfjANJPy9+Gv6YmukuCsq93dWBFdaHmO2q61YkTre6oc+93AuhfeYKkmJeC3odVCkILVaqz9Z1/X40dnTnDyED0A3/oUeudcs7K5jZEEhLu/1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(376002)(39840400004)(346002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(8936002)(8676002)(66946007)(316002)(4326008)(31696002)(36756003)(86362001)(38100700002)(31686004)(2616005)(6506007)(53546011)(6512007)(478600001)(6486002)(5660300002)(66476007)(66556008)(2906002)(83380400001)(26005)(4744005)(41300700001)(14143004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3h5dDEzNk5CU1IyZHhZWGRJR1FLcjQzc0oxTkY2c3BpbWNrcUp4cHhWbDBx?=
 =?utf-8?B?bkcyNEdid1BrZ29lQ2FPdE5hWjhJNm1iQzFnTnpHMUFzbVBWY3BCcStrNUhX?=
 =?utf-8?B?N3c0em1GSlh1T2xENVFScVdweDJnZU1iMFNlbzBlcHBLeCt6aFZlYm9rRERG?=
 =?utf-8?B?MWpxSUVnNzNlMGxZcjluTWxJeXZoaUlEZHlyNStTeVlIQzVSd3dtWkVLb3V3?=
 =?utf-8?B?R3dldUFBbE9hU2c3M1JVUmxoRjRNM3cva2JOK09MRXNyNzNZamgxaVJSSStT?=
 =?utf-8?B?OWwxeHNacXdvTko4L1RXcHZ1ZUZpSVJhNmFDNkNsdUdLZnplN1ZQYWVNUi9t?=
 =?utf-8?B?UzhXUHNoR0ttVDZVT2NXVjllR3ZFaHB4ZUlDZHpVa0cwTFJyTXpsQzBrWllu?=
 =?utf-8?B?OXFhMm5mc0wxRW41WXBSQ1JRWUVOOXFjV3lXZ2I0bm85QlFmM3F0RWx4Slo3?=
 =?utf-8?B?YTRXMVhsM3AxeGhydlhVSUJBU0FJQ0E5TFk5L1BaeHQrUk9yekRKeXcveGNv?=
 =?utf-8?B?SDNPaW9laFRyNEdrV1Z5UmJWaUNFNnRyaGVDejVpc0RGcEFkQlVWcWZIZkg4?=
 =?utf-8?B?NjM1aVdsM1pidTBIak9CTHNnaklQL1R1S0pxcWVkN3RsVy9OSnhQa21TMlJR?=
 =?utf-8?B?dXlQZW02Z2RpbjZGSmU4eWRuanUxUGxBdmVoSlZTRHVtL0wrbkdDaDNLWm9O?=
 =?utf-8?B?bmwxeGtPdk9hQ1c5ekUxYjlsbVRnbEhjdWY0WitFelpUbFQrSVdQQ3MwazNC?=
 =?utf-8?B?ZmV2VnZmUWlma0VwZ29WZ2NvNEtuVzZQazlYQVlaSFZzVHNwSnR6TGpRQnln?=
 =?utf-8?B?YzdqVEpVenI0N1h5bmdRbGYybFhyTFZwRGExUjYyUVRQU2RWb2x1ZWVHS1gw?=
 =?utf-8?B?VUpwK2tJR1dwMnBrdHR5blY4NThxR25YZkwvZ1J4WjZwV0pCVi94WXN5ZERK?=
 =?utf-8?B?a0tNZFVvaGhCVjBscEVqdjdwbVhkQnVlTGFXemp0UHl5VVcrQ2cxcGcvdGpG?=
 =?utf-8?B?cVdBdDRCdTZKRXh5VFR6YzJPWXY4cVdUbGpDSWlNcE5GUEwzUldUekJac0Jh?=
 =?utf-8?B?TXNlVEVveUJ3QnZVWkFQZEhDbXltNVl6TXU4VFFIYVRJS3YwZ3NtcjAxUmxQ?=
 =?utf-8?B?MlJDQ0ptMll2bnBPTEI2cVo0R3I2L0IxUklDS3RkWUhTU0ZlcFhDUmpjaWxx?=
 =?utf-8?B?N1Y1N0MzeXhpNFU0eWNmTmJUV21hQXVNN1YwVHk1TWhGOTdkcXB5YVM1VVZI?=
 =?utf-8?B?QzN6Y0l1cEFlZzF6bE5KTkk0TzBpNmtrdU51L1krViswWmthbHlkY1crcHdF?=
 =?utf-8?B?YTV1V1FtMW9hckorUjVXMDlzdmlPRXZZc0htczNqUGVjUWhvaGs2TVYvU0ky?=
 =?utf-8?B?djJZMWNRQmNaZnJiN09mZXBtbkFlVkFtMC8yZ1NSWDE0M0J5cDZkRzJ5bFRl?=
 =?utf-8?B?SzJkRWJQYTY3TmdjY2xGYU0yZ3grRU53bTNNcHJUaUk1N3NWeU9KcGdkSkRR?=
 =?utf-8?B?WEpYVGdRU3dVVTRlZ1FMb2Eyb2xmYTNtM1Z4Yk5yTUk4Y2dEem90cDNjRXlr?=
 =?utf-8?B?NVJDQ3ZKL0loZFBvSUZOdENyZ2RoeGo4SllTTlRMdjJvaG91TDN4cGN4QUpa?=
 =?utf-8?B?WXZNMC9NRzNzWk1TamxibW4rNzVNejJ1M29nSXpaVi82OEdEVWlJazVYMU5a?=
 =?utf-8?B?Z0I2NFZWNjR5ZnN0R3FCbVpQNUgxR2c0OGtBUTVTaXh0L2MzREthcU9VSGtn?=
 =?utf-8?B?NExpcndqY0ZEYVNPMksyMU0xRndxS20zb1VpeDdCbWF3WVhxUjRScHpCQUhU?=
 =?utf-8?B?MmVJT0pmY0lHZ0gxVWJnZ3NOTXI3Z05GMUkxT3lKQnFhNkhFVEFTL3FYbUEy?=
 =?utf-8?B?L25pdzIyaHJHMitCTG9SeVgxZG9wNUNsYTc5SDVXc2pEc0t5dW83ZFVjUDVM?=
 =?utf-8?B?QmRRWWlBWnNnRUZxNzlLSENKcVNIVk45ckl3aTFhYjFTT0ZBeE1YUmUzWVlM?=
 =?utf-8?B?TFd5N3BVc1Vra25ZWVVXQVMvbzVHTFc4YTBRQjdoMTFVRWUzcFgxWHMrM1Vp?=
 =?utf-8?B?a2QyOUF2MWtBdEtXblNYSVZKaUUrRllWRG03cWZOL3NyRVlBaWZFSmdZdUt6?=
 =?utf-8?Q?t5BGL3KUc0S7llYLzveHqkzwA?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb9f922-56b5-469a-c071-08dc182da35a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 13:59:07.4198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qc9iv+4oYpG+q1jOo34Is0htm9IReAUTrJnEoeqqVgUkl6u+ejFkBZYy+NslyQ3eYE7faMi2iN4DTU1IjOWrhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5821
Received-SPF: pass client-ip=2a01:111:f403:2608::701;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/28/23 11:12, Alexander Ivanov wrote:
> After bitmap loading the bitmap is not persistent and is removed on image
> saving. Set bitmap persistence to true.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels-ext.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/block/parallels-ext.c b/block/parallels-ext.c
> index 033ca3ec3a..2a7ff6e35b 100644
> --- a/block/parallels-ext.c
> +++ b/block/parallels-ext.c
> @@ -255,6 +255,7 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
>               if (!bitmap) {
>                   goto fail;
>               }
> +            bdrv_dirty_bitmap_set_persistence(bitmap, true);
>               bitmaps = g_slist_append(bitmaps, bitmap);
>               break;
>   
Reviewed-by: Denis V. Lunev <den@openvz.org>

