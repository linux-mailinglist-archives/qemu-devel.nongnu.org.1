Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67503756A39
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 19:25:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRyO-0000Zo-90; Mon, 17 Jul 2023 13:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLRyL-0000YN-Lg; Mon, 17 Jul 2023 13:25:21 -0400
Received: from mail-he1eur04on0708.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::708]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qLRyH-0005zE-IA; Mon, 17 Jul 2023 13:25:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRGvvON8V6fbfPL4e5KwyJN7gBj/jL+C1zbTIOGRSxF/4qQuaC8B+N2x7Ea+GIEjlKYZSyQhGUbvis2JEaT7XQOFATut4P8Tdut7EeicNdZKhJC7n+IcFwzMhSC8vugEI4PxFv/+IUWx79tSaWlHKyr6v43ZCgQalHWr+634XdylY2PHfVERjLcXAfWVNRAv29eaqHWtRlkyKnQ3wFJLThQX0/qXFXPZYt9UVUQIf/7W0o98YbxMgFqSp8wgpJr74aKCkpz8dN83Nn80azfYMzNg5YtrzAch03QJFju8cHsy8R6xvt04DnkSD7AHJAO+QdGAGVBH8qzapunCyZygbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGRBneYa75xUlmc7psMdIbwy6T/oU0pkVd8X+z5N1rM=;
 b=IhxEkfd7KUM/neszwPiXdq4Ke3HG5QBToIhj9LMvUiGjLFKxwkgio2lfU0vsaQEy0JRFeQKmwsYmxG4Y1FK1wNC/rqrMBryo8NTRJLurx4488/jpUCSrG8WdIMU77yjwhISWR7G3HjNfBtaP4jUVUZGIwS52197K+5ZKcSBMMpT8vJW4pLSCMp1/pX199Ngzoin6mRNV27SCyiDwssJINmfGOgidRgj/L+6bAuOHmWo8Lsxle+qE3U1heJYoodrJQe8PN4TUccYZS26eCgBWONZolK1/A8rT3bssvvoVhNc4u1GbLh7zfjHw8Xc5uBlLPnrudu2PWv2oALQTOCSiAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGRBneYa75xUlmc7psMdIbwy6T/oU0pkVd8X+z5N1rM=;
 b=W+5AbBT3xGlMk5piXzT6LfmjVVOovQTxpivfUXdwZGM2HzuHCpVvDwkyJvBr4/2Okqx5egvmyUNVqMWHUzpOPluA8Ev3pdN9+PUTfcvoRrPDRQoXmCBnG8Ij0WMQIilMhMgYNNtLo1Izw4awIaCiO4ez0msEXjHTJFwKgkGokQXPzTOdy813ZBId/tO4p9SLqWUEl/AKvdR8+UHpBJQJkCmbR+M57zQQM+VY/5LjssIqgoLkkVwUR+S9zECDo2y4Ky5Ni3D/2UtKv8ipEaBeV6La4VpP1foK5mEMY2+GVHWCYpAwkvEFldarz1FIFHB0Y6zIJWtRjqcV3crW3H2MNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PR3PR08MB5675.eurprd08.prod.outlook.com (2603:10a6:102:8a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 17:25:11 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::531a:f96a:fab2:9530%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 17:25:11 +0000
Message-ID: <6ce1194d-cde7-c574-861e-090216aa9691@virtuozzo.com>
Date: Mon, 17 Jul 2023 19:25:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 8/8] parallels: Add data_off check
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
 <20230701100759.261007-9-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230701100759.261007-9-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0068.eurprd04.prod.outlook.com
 (2603:10a6:208:1::45) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PR3PR08MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a69458-9834-44ea-7605-08db86eac641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Isx6iE6B2PrUkzlubVMeWVS2i0XVh1SZueorvXD8fSnri1sskuRKLsj2cpKJNudTHNVBlsMEyPc2u8uv0Kp13U1h9V4D0CS7SbmsW6UcrD7R9d3zTJfz5nivgsCfQuFAjrSghSZ+G27ZHjxaf6xtXE98zcTG4rALBDxWwicwfX6b8LRLgjZ4f2qhVvQzEKVx3XIqEJFgDzYxf5fCev5SEfdAjecqSaJ4/NXmr9d/9HY5fWNE6oK+qXbErETqs9xWAqCSbZwp0lyocVa7RrwIiew+b0eOG8VKP3pBhOfmfHO78Zpxei5C3sCx9wfQJKdsMhswhq9aJmyfOj5hssAIwThL0wezpZtm0ozmH2Wvr5SZbI2SrhRBrUUhbNNwY9FQlnNYRGJ3wZY3T/fnWQdxX2p68zS1jiHEdUgOvY0oSd421VB5/mu034xR/WBWf7Z8PFKIqmM1xu6YDG4238XB24Y783ME0UA7TcV8Mg3IOYKbvZ8hHqgmYITmG0aWWZRndPtdNUShNk9d0Tb+di3csnnJilh17+cD31SLahANvWcCadSmfKiA9N+KqskSvCZM7uI0kkY+uUjMnvSlgWq5qBXO17yCO2vK91jLqAaktO7uOn2CdOAp7g0MD8xLf0YwLzxDas0VogfbiCPGFF8o6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(376002)(39850400004)(451199021)(478600001)(6666004)(6486002)(6506007)(53546011)(186003)(36756003)(2616005)(6512007)(316002)(2906002)(4326008)(41300700001)(66476007)(66946007)(5660300002)(8676002)(8936002)(26005)(66556008)(38100700002)(86362001)(31696002)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTJmcy9hclEyc3l2RDNBVFNTaGtxT29oN0hwaHgzMjhnRzE2MFpHN0ZmVW90?=
 =?utf-8?B?V0g5YjZ6Y1VsTzJCMGtkc1pnU2Qzckw2emdldS9JZzVjZzBVTDRMRHNCMVNR?=
 =?utf-8?B?bFk0Z0xVRk01Zm9MMllhTm5iSlFxb2t5SklYVlBOazZyWExhV2FHOWl1L2xJ?=
 =?utf-8?B?UThEMUZKaEpNWE9XZjZ4ai82WVdvWSt0VlJnZFhJRndLTURHTHJtcHh2dlVR?=
 =?utf-8?B?NVVoWjhzdVIzY29rR3EreUdIMmh4N2tEMU1nbVE5RmtmTFUzb0U3RlViOFpJ?=
 =?utf-8?B?VExhWjNTaHE5L3N3OWhxT3o5T2wzNTA3bG9BcCtmUWdSaTNGZWhHbXlnSk9S?=
 =?utf-8?B?MU1Td25SWWJoSDNxY1dGcjFRUmZyMU5DR1U1QmlEM0tpZVBUYWdkSk5Jc3FE?=
 =?utf-8?B?U2RBRzEvR2kyV2hqWHpQMlZ1N20wVk1PNGVpN01lZ295dXIzQ002ZkFzNWdM?=
 =?utf-8?B?clFHWGUxOVE4cjR1aCtQQXBRU0RVa2NYaWFsU2lTTDJtQStrZ3NwRHE4cGJY?=
 =?utf-8?B?c1R0UHJueEptWlgrUGEyYjJ6SmpHVDhmZ3BkaVNNRDNQb2FXREpYTVFPemFL?=
 =?utf-8?B?ZUNTZytFaGdnNzZQMm5ZZVFJeGFUK0t5ZzhEeE01ckxITDhRbm1TVkpyc0E3?=
 =?utf-8?B?YzhOeDVnSHpscGZvN08xK0Fqa1VrL1Z4OUVEcUIxLzREcjZSblkzM2l1eHpL?=
 =?utf-8?B?dVFLQ2plV1hsQWdmTnFCTE1ZQ0ZLZlpZd3lOc1FtcHZ1NXVEVGNIZFVyUXZM?=
 =?utf-8?B?ZERHNmVLU0hHOThhNzU2N3p0YmlVTUJ4L0llM2tUaHc4S2d5Q0xPdGptd2ZZ?=
 =?utf-8?B?dTdDMTZYVmt4MmhTK080a0JRK2tQREd0UnVaRlVWS3M2WGVlVFlCK0VmTjZR?=
 =?utf-8?B?aGJwVmVRdEZYdVlOTms1bkFFR2RXUUlZNDhzbWZRaENqSFhhSm1GcnppSmxT?=
 =?utf-8?B?bmNxY0x4OVdhWGt1UFo0akZsd3RMeGRtNmxoNEF0WWpHdXFDU0pyL2RlZ09a?=
 =?utf-8?B?MU5IaGYyeW9ITmUrWUdzd1FjYWswNnNKOGx5MVRaekJiSEtEZmRzSDV2Y1Ry?=
 =?utf-8?B?U0ltT0IxaGV2TzVzWkRiM1JlY05jbTVCTnJpdVBZc1M1YUh4M002UDhUTkE4?=
 =?utf-8?B?UVg1bDVSaDNoL0dscGp6MmJVQjltOWFFSFNRL1paQ2dXUFNXU1BJa3YxQUhM?=
 =?utf-8?B?dFdQRG9wU2JHM2FURmVrUUwyWmcybkdsUkV0dTdxNEFuTjZVbGpVYWt2NGlN?=
 =?utf-8?B?REwvaElKNWQ0VUhPL2lzMGgwNHNrWGoxa1hHLzdYd1pya0plQXpqaTBmL1NR?=
 =?utf-8?B?bDhlYmVuUllYV3dMaGF5cUYyektYYnVRbjdHbzZBSUlsd29xNW4zb1VrL005?=
 =?utf-8?B?dXVMN1BrenVjbFpuSVlBcmhyMWd0dDhWaHlYMC9VSGl2RDNwRDRMWU5JQm90?=
 =?utf-8?B?MmR3TGlpV3E4T1pWOWIzeWFYUEFtY2o1V0w3Ly80cHd4VVl4elZNK2FrV0dy?=
 =?utf-8?B?bmxGc0VHN2pGVnhNd0o0RVZKa0w3NVlTRWxlU2cyUUtjbUdhVEhJVW43cjYw?=
 =?utf-8?B?TzNES0FWdE5PNDJpams2S1ZGeGIxeWRmYXNJUUJSN09qV21UVCtJQWoya1Vh?=
 =?utf-8?B?WmVSQjIyN2RWcVdkckFiTUdjN1RDb3daRmp2ZWUrZE4xYVQybVFla0JnZlBE?=
 =?utf-8?B?UUFLOWNRWXY4VWJ6QTdzZllhMklOU1dyQ1FZY3U3TGlxWENVT2lUV2ZGWFdU?=
 =?utf-8?B?RTVia3BGa0JlUnoxUVY3NGJhSDBwVXNTRHVzWGpxUitjODhjeGxwZitYcW1Y?=
 =?utf-8?B?dkI2ZlBlR21TM2o4dVNjVmNDbURqRlllenRwZnB1Z2VlenlMK0dmR3JvWXBV?=
 =?utf-8?B?eFJydWVsd1ExN1N4RklLQXJrREs0OWpNWVcra3JqbzhKa2V0R3VYakVzdXN2?=
 =?utf-8?B?WDUzM3FqK1Bwb1dvb1RBQ2txZGN0QytkUW5ncy9kVTZNRlFOTnhtYkl3WFRD?=
 =?utf-8?B?a2E2Vm92Y3RKdk1udHBtenMxS3hmblBMUS9qN3cxNitjWTZFaHlzM1p6anFU?=
 =?utf-8?B?OGtaVndjSHZrNEMvbm5BQTlSa2YvTHVZOVFhczRTSW40WDArS3gvZTZiTllw?=
 =?utf-8?Q?WIROAZ49jB6elln2xYnS1uTVz?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a69458-9834-44ea-7605-08db86eac641
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 17:25:11.0596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUmxkOfk2PZpCKg8PdOasUMTlLPebs4KCR262Ppy3dgctvCsv2N+0xrCDewQe3FZNotwuI1j8VlpdCKPezYWtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5675
Received-SPF: pass client-ip=2a01:111:f400:fe0d::708;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 7/1/23 12:07, Alexander Ivanov wrote:
> data_off field of the parallels image header can be corrupted. Check if
> this field greater than the header + BAT size and less than file size.
> Change checking code in parallels_open() accordingly.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
This patch requires a bit more work, unfortunately.

After 'git am' it renders a bit differently as follows:

@@ -1012,18 +1076,6 @@ static int parallels_open(BlockDriverState *bs, 
QDict *options, int flags,
          ret = -ENOMEM;
          goto fail;
      }
-    s->data_start = le32_to_cpu(ph.data_off);
-    if (s->data_start == 0) {
-        s->data_start = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
-    }
-    s->data_end = s->data_start;
-    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
-        /*
-         * There is not enough unused space to fit to block align 
between BAT
-         * and actual data. We can't avoid read-modify-write...
-         */
-        s->header_size = size;
-    }

      ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
      if (ret < 0) {
@@ -1035,6 +1087,21 @@ static int parallels_open(BlockDriverState *bs, 
QDict *options, int flags,
          s->header_unclean = true;
      }

+    new_data_start = parallels_test_data_off(s, file_nb_sectors);
+    if (new_data_start == 0) {
+        s->data_start = le32_to_cpu(ph.data_off);
+    } else {
+        s->data_start = new_data_start;
+    }
+    s->data_end = s->data_start;
+    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
+        /*
+         * There is not enough unused space to fit to block align 
between BAT
+         * and actual data. We can't avoid read-modify-write...
+         */
+        s->header_size = size;
+    }
+
      opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
      if (!opts) {
          goto fail_options;
@@ -1117,7 +1184,8 @@ static

I would say that we need to
1. move s->data_start/s->data_end calculations below as a separate patch
2. create patch which will change formatting of comments inside 
block/parallels.c
     in order to avoid checkpatch errors.


> ---
>   block/parallels.c | 98 +++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 83 insertions(+), 15 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 456a13bd28..51e79056df 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -446,6 +446,65 @@ static void parallels_check_unclean(BlockDriverState *bs,
>       }
>   }
>   
> +/*
> + * Returns 0 if data_off is correct or returns correct offset.
> + */
> +static uint32_t parallels_test_data_off(BDRVParallelsState *s,
> +                                        int64_t file_nb_sectors)
> +{
> +    uint32_t data_off, min_off;
> +    bool old_magic;
> +
> +    old_magic = !memcmp(s->header->magic, HEADER_MAGIC, 16);
> +
> +    data_off = le32_to_cpu(s->header->data_off);
> +    if (data_off == 0 && old_magic) {
this condition is unclear for the unprepared reader
and we need to provide extensive comment with
the reference to the documentation.

> +        return 0;
> +    }
> +
> +    min_off = DIV_ROUND_UP(bat_entry_off(s->bat_size), BDRV_SECTOR_SIZE);
> +    if (!old_magic) {
> +        min_off = ROUND_UP(min_off, s->cluster_size / BDRV_SECTOR_SIZE);
> +    }
> +
> +    if (data_off >= min_off && data_off <= file_nb_sectors) {
> +        return 0;
> +    }
> +
> +    return min_off;
> +}
> +
> +static int coroutine_fn GRAPH_RDLOCK
> +parallels_check_data_off(BlockDriverState *bs, BdrvCheckResult *res,
> +                         BdrvCheckMode fix)
> +{
> +    BDRVParallelsState *s = bs->opaque;
> +    int64_t file_size;
> +    uint32_t data_off;
> +
> +    file_size = bdrv_co_nb_sectors(bs->file->bs);
> +    if (file_size < 0) {
> +        res->check_errors++;
> +        return file_size;
> +    }
> +
> +    data_off = parallels_test_data_off(s, file_size);
> +    if (data_off == 0) {
> +        return 0;
> +    }
> +
> +    res->corruptions++;
> +    if (fix & BDRV_FIX_ERRORS) {
> +        s->header->data_off = cpu_to_le32(data_off);
> +        res->corruptions_fixed++;
> +    }
> +
> +    fprintf(stderr, "%s data_off field has incorrect value\n",
> +            fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR");
> +
> +    return 0;
> +}
> +
>   static int coroutine_fn GRAPH_RDLOCK
>   parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
>                                 BdrvCheckMode fix)
> @@ -709,6 +768,11 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
>       WITH_QEMU_LOCK_GUARD(&s->lock) {
>           parallels_check_unclean(bs, res, fix);
>   
> +        ret = parallels_check_data_off(bs, res, fix);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
>           ret = parallels_check_outside_image(bs, res, fix);
>           if (ret < 0) {
>               return ret;
> @@ -947,7 +1011,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>       BDRVParallelsState *s = bs->opaque;
>       ParallelsHeader ph;
>       int ret, size, i;
> -    int64_t file_nb_sectors, sector;
> +    int64_t file_nb_sectors, sector, new_data_start;
>       QemuOpts *opts = NULL;
>       Error *local_err = NULL;
>       char *buf;
> @@ -1008,9 +1072,22 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>           ret = -ENOMEM;
>           goto fail;
>       }
> -    s->data_start = le32_to_cpu(ph.data_off);
> -    if (s->data_start == 0) {
> -        s->data_start = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
> +
> +    ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +    s->bat_bitmap = (uint32_t *)(s->header + 1);
> +
> +    if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
> +        s->header_unclean = true;
> +    }
> +
> +    new_data_start = parallels_test_data_off(s, file_nb_sectors);
> +    if (new_data_start == 0) {
> +        s->data_start = le32_to_cpu(ph.data_off);
> +    } else {
> +        s->data_start = new_data_start;
>       }
>       s->data_end = s->data_start;
>       if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
> @@ -1019,16 +1096,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>           s->header_size = size;
>       }
>   
> -    ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
> -    if (ret < 0) {
> -        goto fail;
> -    }
> -    s->bat_bitmap = (uint32_t *)(s->header + 1);
> -
> -    if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
> -        s->header_unclean = true;
> -    }
> -
>       opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
>       if (!opts) {
>           goto fail_options;
> @@ -1111,7 +1178,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>        * Repair the image if it's dirty or
>        * out-of-image corruption was detected.
>        */
> -    if (s->data_end > file_nb_sectors || s->header_unclean) {
> +    if (s->data_end > file_nb_sectors || s->header_unclean
> +        || new_data_start != 0) {
>           BdrvCheckResult res;
>           ret = bdrv_check(bs, &res, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
>           if (ret < 0) {


