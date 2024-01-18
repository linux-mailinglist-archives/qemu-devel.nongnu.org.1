Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED3A831A96
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 14:29:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQSQs-0001jG-RJ; Thu, 18 Jan 2024 08:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQSQr-0001ia-0J; Thu, 18 Jan 2024 08:27:45 -0500
Received: from mail-vi1eur04on072f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::72f]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQSQo-0007wJ-Ck; Thu, 18 Jan 2024 08:27:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Msl8azEAGt/FyUMKCDhik45fTsWr0nq2ZQWTtuNg00/pR3VCTtbsSaZdyx7aqBbzNUxZ6tSwqooopC88Rx0gY+hFLXc7ytRz7C3bq0meyNOADG2etKA23lbSQ21pX4F4mddExelm6FeGTyg3Q2KvxiWE8goA+injxkvqtkES6rbMt7LI00ph9miLjcbh1lq65w39Xb9JS33ers4TuOYW6sw9ZkWfpr+qc44YT7UdCEE8hxftlxsL10zpOMpOOM4FETffGEsHUVWCdpYua7jOclOEQdebTlZ1jtsj2GHKkeKhDMorr4Xv9+FkebAnLhDgOnfw4bJ23/xJtspZu+A4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvHW3y9/SX2cH34Xtfutm1G7VGxZVJnFfKxUN2+SiEw=;
 b=AFfxZrXiPgtgTVokqtTPYDJ7C6fCpXI7oltatJWhA/j+/RiG1kZpOOIEfxIp3+APa3ycWoLmhhkTk25FtUIiiZcQoXo6KJNeavHePpOCeGrmpqWnjCdCRZN9X2mqoXInTGQ2ofvAcY0QEZ0jgJvglFNi4w/k76/oGHfNGXD+XQKA+3yucw4DtVnIhbCW0xXq/anNimBPJAq19vKi9HxIUsNjO6Vkc4bbIST2fuMidUlivKkkMroXx4BS3P7iOeomyY7Lqv9w9MqFqwHW4C5D2Iwuur7SGjq3bcqfggA1XlhYmFeO+wzScBW4pqEBC44W4X10CBSpDNNfN9wRMshuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvHW3y9/SX2cH34Xtfutm1G7VGxZVJnFfKxUN2+SiEw=;
 b=ixulUC6tJdl/aGiAClhF26iNZ7VtOjravNf+eWu0VQmUimzCTV0xIAHTQSY0SNH4OaSExJflZxbTNxi1pBjsVoCpdaaRHZoHBAq4ltaJg3tg7WLnsq1TSwJy/VmPTGcCW3MsOeWtPvIDTQGOqloK8i27x+v1LMUr3f2PsLEDC+2pIPpNglqIdG2TQFvLSN8hHyWw/K0raPNuXVCGHWTNllby9Euxldvlo/ojajVkTAVJDgIZNVxcI59sphuZI2N/xghayjLrN28zs6MuNWlqjEaafi015+f06rV9NS60TzDTiTAmVu1mOsVbTRVSlyoERkx6IdDSWs/J2gm3PvQIMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by VI1PR08MB10273.eurprd08.prod.outlook.com (2603:10a6:800:1be::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 13:27:34 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 13:27:33 +0000
Message-ID: <2d6b35c5-5708-4403-ba48-c46c50ce40d0@virtuozzo.com>
Date: Thu, 18 Jan 2024 14:27:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/21] parallels: Add dirty bitmaps saving
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-12-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-12-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0151.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::35) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|VI1PR08MB10273:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0148b9-551f-489f-bfc6-08dc18293aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89IOY3Voc0i1WCOxMiR8FwKpH25vaXd41PxWws36JTWOU7SIZJ+kyI5DJT3RCMEssbZ7tOItkqx8IoQFSKEYX+CkjGDNDq+ez9/XwiiERUXO5NWEbQHCDEtxW3AsII6IyVD7F4nS6dE4Te//khagu67YJ/180tt/qrFZPM/x91nuFa1wyoIDygdVVoSxdCMHQ/+X4yE+dyCO/YV0ELCArLotc+oJL0Q5QYeCFioBY9miU1wc5XOiNuWuLE2BUb1s03/d+DpGCBjxox8kZo0ZvIpJ2RaAItO1LlpNfAWMhft+jDoUPOYaEhES69d+wTl5DkybNu4K71Eve7pNqLcLo5ywTjkOd2B2AH/5E2f6Rk0/FEaUvimM6cvvA4wSnF5J9HXfqlaI3jzHKFfHskxb4KsymQgF224MTpan6VL/u40icG+ETmaNw6YbvCNH5CCLX5xRlaDSbdN0BkQ7RzW3xFGn1GsGxb3+dEKxdCwf4txmxW8/e3dSt2MLx2ui62lLRffsdGUVQ1u0FydpEi1HyeKgZvBEUR62AtxtTOXygX5n3RcHe6HK/kX3bmQRGRyMO5chy6fxNuibEFmDUqqWyB6dC+tlMTYFzXkAdvG6QhbrmS+6B+lMbt7124KtUW917Cj9+t/XcL3CCA8u2GK5nZ3H/jte4NKiqJiv0oH3/vA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(366004)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(53546011)(83380400001)(26005)(86362001)(31696002)(36756003)(6506007)(4326008)(8676002)(2616005)(6512007)(66556008)(38100700002)(66946007)(316002)(66476007)(5660300002)(8936002)(966005)(478600001)(2906002)(6486002)(41300700001)(14143004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzQxWHJTMFh5UmpqYmJnTytXYlNydHJ2SGV2QkFzM1RYWlZFTFJtT3Q4eHJN?=
 =?utf-8?B?Y2hSMy8wbjFrWjNuRHhUWFdBU3BRUHZQRDZxNnhGeFhOOVVGRGtrWjd6cFdh?=
 =?utf-8?B?SjJYOUgvV3d3bW5PTDBDTlYzWDd1RENmZGNYWkxXVTBaeXlSS3dZR3BYemdt?=
 =?utf-8?B?cUd5MmJrK1VQVVB4aEp1SkdOa0hHWHV2R04wNTRGNTNDR2Y4SnJqYXJFRjkv?=
 =?utf-8?B?NzJaY1FNR29uK2ZyRUZCOEROQ3ZHYXFGR0kxQlpTajRFQ3Q0UHpsSk1XVmEz?=
 =?utf-8?B?QkVnMkxjbExla1ZodHBhYlBMSS81TTA0ZTVTL2tlY3FVV0lmN0p4alE1SEw0?=
 =?utf-8?B?Z0RFOTdWbEI0R0dxbS9QaGVCSkRsTFhsWXJLdys1eTVTOU9QNlBLZXMyWnc2?=
 =?utf-8?B?RmczQ2ZWdmpidjJtUXNoRXB5d1lrYklnRzI0RzZmdTVMUVlETDdERHZmY085?=
 =?utf-8?B?M2pUOU9BdVZhUis0UnU5NUt4RFAyM0I2Q1hGUUNhek5iUmZqMTBhdnM4M0pN?=
 =?utf-8?B?SVJ5eW1LY3A0QWtTREZMRmtEeHNuS3pVU1F3ZFIrd3M5MW5QV0h3ai9SRXhz?=
 =?utf-8?B?SlJGb3B5K1dDRlBLYnVsN2pWU0ZXTGs1d3RmeDhlNVA4bE12ak1wY3NGdjAz?=
 =?utf-8?B?V1ZHazdXbFlJdTJ5N0hWVEhibnhNRzdKUzVzYVJGbEdQN1FlRnFWamxGa2Fr?=
 =?utf-8?B?WXBhd2JiWDhFcEpNbUNJWGVpbTdiMllWVlhvd25JRVd4QVhmb3NKVThIcTBx?=
 =?utf-8?B?bkZTelI0MGdoOWlMNmVCQWoxMGVpWG5udk5IbkcweDFNUE1ZeTRTZmU2MWpr?=
 =?utf-8?B?anNWMGRhQnRiaGZpSTJlNUVVRXZWVjhTR3dOUS9WVzA4WjFsZ3NselZNSEdJ?=
 =?utf-8?B?bStvdmhnaFRVZitLOXlRQXBvbnF1VHRRUC93aXNvN1J6bGhON3lOcEkyeFFT?=
 =?utf-8?B?MTk4M3ZCVUsvRXpaUjk2ejBlL1RiRWt0ZzRVLzJWU3hneFhjeXQrZUpuUy93?=
 =?utf-8?B?YTFMVUVpWUpPWCs0RS8raEZvblZHckhYUmFiMXJMSmFJVVlodDgwZFMrdUx1?=
 =?utf-8?B?aGdzcG5IU0RYekI1dWVBOXRHTDJWR3BiaEc5ZlRyV1ZjcjI3cWZLV1pyeU5F?=
 =?utf-8?B?M09hOEJhT01lYTgvMlR4NXVEc09oSkw3dzkyR1NGMm0wQVlBNzN4dGFyTTN2?=
 =?utf-8?B?MmVCemRFNTVUdGJHaFNVSXo1eHUyMVErWUYwaFhWRkdLY01PZFZCWnhjVXRu?=
 =?utf-8?B?RHVLYXZ2N25BMXVweVFRN1lWeG5xSzNSRzFlS0k0RmtHWUttVHdoN0tsdGg1?=
 =?utf-8?B?cmVPNGdKSk5FbnFYblEzeHZJNXhpZWFhWjFxbFVISzRrL2tYZUkwOXFZU3Ju?=
 =?utf-8?B?OUpZQTFhWUdpblo1WVNSWnNESEtnQlNWbEJZNHd0WlgxNEZMQnl4UGJmL2dE?=
 =?utf-8?B?VXBWQkxaZGhqY2JmYTA3TDJML1ZZcFgyZ1JTeHBhTW4rTEp5QVBhcWhIcC9t?=
 =?utf-8?B?U0JKTFVKTUVQUXEwVnhRZTQxZmE3NytmSmVsR3JMWXRZMksrN2k1TVZTTTdu?=
 =?utf-8?B?Z1lHN0oyQm1TeERqcGxoLzRua3V1b3cyY00rcGY1aG9LSEwrUFlrNGtQb0pK?=
 =?utf-8?B?cjg2QnJOVUZ0MmhoTHJQUnBRWVdXOTQ0dmJHWVdTMVdPamFGVWtXUVdNU01X?=
 =?utf-8?B?NWMrTzJwSGRsTDI5aHJDbDUyU1hKVjVBVmVLNXNDZDBFVmZDRUJnUFNKS1J1?=
 =?utf-8?B?QjgwOU1oRWlwZS9FbGEwbWpHZDJ0a3JuR2EzbnRabU1jczdXS2pEbkZDNHFv?=
 =?utf-8?B?Y1I4VVhEQUwzbTI0ZkowWENJb3hWVXJWSzIwS3hvaXpYVUY2QU42dzV6Uk45?=
 =?utf-8?B?WTd0c29JR0hzbjltRHJUdVpRVkl1cEpBRGptaWVTQzk3U2JySDB1VWtJL2tp?=
 =?utf-8?B?ZHJEd1Byc0c2Z1k5UUdSM2ZoK3l3UHp4TnNFRjIwdTYzWUxlRjhaVWIrWjV4?=
 =?utf-8?B?RGRlUFFrWHordVh4MHNqbjhjWWdGeDJ0bm9COUVhcjQ1WWN1clB2b0hiMUMy?=
 =?utf-8?B?VHZJWkdLWllxZ243azErcUY5VXlsWVpzby82ODdqTGRpWndTNkhMVDFsbG1N?=
 =?utf-8?Q?PMGlOM2WdVTo4vOdMVR+5jhyk?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0148b9-551f-489f-bfc6-08dc18293aae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 13:27:33.8581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vyun5dMOhHKjIme2/AEn26Ytyw/PCOWAluyCvv68JzNGp38qytBQVrp6ZWpdzi6itx+4hAnZ6Ll1qMr4YvcUMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10273
Received-SPF: pass client-ip=2a01:111:f400:fe0e::72f;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> Now dirty bitmaps can be loaded but there is no their saving. Add code for
> dirty bitmap storage.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels-ext.c | 168 ++++++++++++++++++++++++++++++++++++++++++
>   block/parallels.c     |  16 +++-
>   block/parallels.h     |   5 ++
>   3 files changed, 187 insertions(+), 2 deletions(-)
>
> diff --git a/block/parallels-ext.c b/block/parallels-ext.c
> index b4e14c88f2..c83d1ea393 100644
> --- a/block/parallels-ext.c
> +++ b/block/parallels-ext.c
> @@ -24,6 +24,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "block/block-io.h"
>   #include "block/block_int.h"
> @@ -300,3 +301,170 @@ out:
>   
>       return ret;
>   }
> +
> +static void GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
> +                                               BdrvDirtyBitmap *bitmap,
> +                                               uint8_t **buf, int *buf_size)
Do we need a error?

> +{
> +    BDRVParallelsState *s = bs->opaque;
> +    ParallelsFeatureHeader *fh;
> +    ParallelsDirtyBitmapFeature *bh;
> +    uint64_t *l1_table, l1_size, granularity, limit;
I would say that 'limit' here means 'bits_in_cluster'

We are writing the new code and I would prefer if we
would have bits, bytes, clusters, sectors etc are
clearly seen in variable names. It is quite complex
to track various measurables.

> +    int64_t bm_size, ser_size, offset, buf_used;
> +    int64_t alloc_size = 1;
> +    const char *name;
> +    uint8_t *bm_buf;
> +    QemuUUID uuid;
> +    int ret = 0;
> +
> +    if (!bdrv_dirty_bitmap_get_persistence(bitmap) ||
> +        bdrv_dirty_bitmap_inconsistent(bitmap)) {
> +        return;
> +    }
> +
> +    bm_size = bdrv_dirty_bitmap_size(bitmap);
> +    granularity = bdrv_dirty_bitmap_granularity(bitmap);
> +    limit = bdrv_dirty_bitmap_serialization_coverage(s->cluster_size, bitmap);
> +    ser_size = bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size);
> +    l1_size = DIV_ROUND_UP(ser_size, s->cluster_size);
> +
> +    buf_used = l1_size * 8 + sizeof(*fh) + sizeof(*bh);
As far as I can see, bdrv_dirty_bitmap_serialization_size() returns bytes.
That is correct. Thus multiplying it by 8 seems fatal mistake.

I am also quite unsure that we should roundup to the cluster, that
will occupy more clusters than needed. Can you please take a look
here
https://src.openvz.org/users/ibazhitov/repos/ploop/browse/tools/ploop-cbt.c

> +    /* Check if there is enough space for the final section */
> +    if (*buf_size - buf_used < sizeof(*fh)) {
> +        return;
> +    }
> +
> +    name = bdrv_dirty_bitmap_name(bitmap);
> +    ret = qemu_uuid_parse(name, &uuid);
> +    if (ret < 0) {
> +        error_report("Can't save dirty bitmap: ID parsing error: '%s'", name);
> +        return;
> +    }
> +
> +    fh = (ParallelsFeatureHeader *)*buf;
> +    bh = (ParallelsDirtyBitmapFeature *)(*buf + sizeof(*fh));
bh = fh + 1 ?
> +    l1_table = (uint64_t *)((uint8_t *)bh + sizeof(*bh));
l1_table = bh + 1 ?
> +
> +    fh->magic = cpu_to_le64(PARALLELS_DIRTY_BITMAP_FEATURE_MAGIC);
> +    fh->data_size = cpu_to_le32(l1_size * 8 + sizeof(*bh));
I am quite concerned here. Please compare with

int save_dirty_bitmap(int devfd, struct delta *delta, off_t offset,
         void *buf, __u32 *size, void *or_data, writer_fn wr,
         void *data)
{
     int ret = 0;
     struct ploop_pvd_header *vh;
     size_t block_size;
     __u64 bits, bytes, *p;
     __u32 byte_granularity;
     void *block;
     struct ploop_pvd_dirty_bitmap_raw *raw = (struct 
ploop_pvd_dirty_bitmap_raw *)buf;
     char x[50];

     vh = (struct ploop_pvd_header *)delta->hdr0;

     /* granularity and uuid */
     if ((ret = cbt_get_dirty_bitmap_metadata(devfd, raw->m_Id, 
&raw->m_Granularity)))
         return ret;
     raw->m_Granularity /= SECTOR_SIZE;

     block_size = vh->m_Sectors * SECTOR_SIZE;
     if (p_memalign((void **)&block, 4096, block_size))
         return SYSEXIT_MALLOC;

     raw->m_Size = vh->m_SizeInSectors_v2;

     byte_granularity = raw->m_Granularity * SECTOR_SIZE;
     bits = ((raw->m_Size + raw->m_Granularity - 1) / raw->m_Granularity);
     bytes = (bits + 7) >> 3;
     raw->m_L1Size = (bytes + block_size - 1) / block_size;

which means that the header is rotten. In that case can you pls
take a look why this has not been caught by tests?

> +
> +    bh->l1_size = cpu_to_le32(l1_size);
> +    bh->size = cpu_to_le64(bm_size >> BDRV_SECTOR_BITS);
> +    bh->granularity = cpu_to_le32(granularity >> BDRV_SECTOR_BITS);
> +    memcpy(bh->id, &uuid, sizeof(uuid));
> +
> +    bm_buf = qemu_blockalign(bs, s->cluster_size);
> +
> +    offset = 0;
> +    while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset, bm_size)) >= 0) {
> +        uint64_t idx = offset / limit;
> +        int64_t cluster_off, end, write_size;
> +
> +        offset = QEMU_ALIGN_DOWN(offset, limit);
> +        end = MIN(bm_size, offset + limit);
> +        write_size = bdrv_dirty_bitmap_serialization_size(bitmap, offset,
> +                                                          end - offset);
> +        assert(write_size <= s->cluster_size);
> +
> +        bdrv_dirty_bitmap_serialize_part(bitmap, bm_buf, offset, end - offset);
> +        if (write_size < s->cluster_size) {
> +            memset(bm_buf + write_size, 0, s->cluster_size - write_size);
> +        }
> +
> +        cluster_off = parallels_allocate_host_clusters(bs, &alloc_size);
> +        if (cluster_off <= 0) {
> +            goto end;
> +        }



> +
> +        ret = bdrv_pwrite(bs->file, cluster_off, s->cluster_size, bm_buf, 0);
> +        if (ret < 0) {
> +            memset(&fh->magic, 0, sizeof(fh->magic));
> +            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
> +                                  cluster_off, 1);
That is incomplete. You have to clean all clusters inside of the
extension.

> +            goto end;
> +        }
> +
> +        l1_table[idx] = cpu_to_le64(cluster_off >> BDRV_SECTOR_BITS);
> +        offset = end;
> +    }
> +
> +    *buf_size -= buf_used;
> +    *buf += buf_used;
> +
> +end:
> +    qemu_vfree(bm_buf);
> +}
> +
> +void GRAPH_RDLOCK
> +parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
> +{
> +    BDRVParallelsState *s = bs->opaque;
> +    BdrvDirtyBitmap *bitmap;
> +    ParallelsFormatExtensionHeader *eh;
> +    int remaining = s->cluster_size;
> +    uint8_t *buf, *pos;
> +    int64_t header_off, alloc_size = 1;
> +    g_autofree uint8_t *hash = NULL;
> +    size_t hash_len = 0;
> +    int ret;
> +
> +    s->header->ext_off = 0;
> +
> +    if (!bdrv_has_named_bitmaps(bs)) {
> +        return;
> +    }
> +
> +    buf = qemu_blockalign0(bs, s->cluster_size);
> +
> +    eh = (ParallelsFormatExtensionHeader *)buf;
> +    pos = buf + sizeof(*eh);
> +
> +    eh->magic = cpu_to_le64(PARALLELS_FORMAT_EXTENSION_MAGIC);
> +
> +    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
> +        parallels_save_bitmap(bs, bitmap, &pos, &remaining);
> +    }
> +
> +    header_off = parallels_allocate_host_clusters(bs, &alloc_size);
> +    if (header_off < 0) {
> +        error_report("Can't save dirty bitmap: cluster allocation error");
> +        ret = header_off;
> +        goto end;
> +    }
> +
> +    ret = qcrypto_hash_bytes(QCRYPTO_HASH_ALG_MD5,
> +                             (const char *)(buf + sizeof(*eh)),
> +                             s->cluster_size - sizeof(*eh),
> +                             &hash, &hash_len, errp);
> +    if (ret < 0 || hash_len != sizeof(eh->check_sum)) {
> +        error_report("Can't save dirty bitmap: hash error");
> +        ret = -EINVAL;
> +        goto end;
> +    }
> +    memcpy(eh->check_sum, hash, hash_len);
> +
> +    ret = bdrv_pwrite(bs->file, header_off, s->cluster_size, buf, 0);
> +    if (ret < 0) {
> +        error_report("Can't save dirty bitmap: IO error");
> +        parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
> +                              header_off, 1);
> +        goto end;
> +    }
> +
> +    s->header->ext_off = cpu_to_le64(header_off / BDRV_SECTOR_SIZE);
> +end:
> +    qemu_vfree(buf);
> +}
> +
> +bool coroutine_fn parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
> +                                                          const char *name,
> +                                                          uint32_t granularity,
> +                                                          Error **errp)
> +{
> +    if (bdrv_find_dirty_bitmap(bs, name)) {
> +        error_setg(errp, "Bitmap already exists: %s", name);
> +        return false;
> +    }
> +
> +    return true;
> +}
> diff --git a/block/parallels.c b/block/parallels.c
> index f38dd2309c..a49922c6a7 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1466,14 +1466,25 @@ fail:
>   static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
>   {
>       BDRVParallelsState *s = bs->opaque;
> +    Error *err = NULL;
>       int ret;
>   
> +    parallels_store_persistent_dirty_bitmaps(bs, &err);
> +    if (err != NULL) {
For me this looks quite odd, indirect check for error. Not good

> +        error_reportf_err(err, "Lost persistent bitmaps during "
> +                          "inactivation of node '%s': ",
> +                          bdrv_get_device_or_node_name(bs));
> +    }
> +
>       s->header->inuse = 0;
>       parallels_update_header(bs);
>   
>       /* errors are ignored, so we might as well pass exact=true */
> -    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
> -                        PREALLOC_MODE_OFF, 0, NULL);
> +    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
> +                        true, PREALLOC_MODE_OFF, 0, NULL);
> +    if (ret < 0) {
> +        error_report("Failed to truncate image: %s", strerror(-ret));
> +    }
>   
>       return ret;
>   }
> @@ -1525,6 +1536,7 @@ static BlockDriver bdrv_parallels = {
>       .bdrv_co_pdiscard           = parallels_co_pdiscard,
>       .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
>       .bdrv_inactivate            = parallels_inactivate,
> +    .bdrv_co_can_store_new_dirty_bitmap = parallels_co_can_store_new_dirty_bitmap,
>   };
>   
>   static void bdrv_parallels_init(void)
> diff --git a/block/parallels.h b/block/parallels.h
> index 493c89e976..9db4f5c908 100644
> --- a/block/parallels.h
> +++ b/block/parallels.h
> @@ -101,5 +101,10 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
>   int GRAPH_RDLOCK
>   parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
>                                   Error **errp);
> +void GRAPH_RDLOCK
> +parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
> +bool coroutine_fn
> +parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
> +                                        uint32_t granularity, Error **errp);
>   
>   #endif


