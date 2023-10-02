Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3287B4E67
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 10:59:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEkz-0001jO-Ng; Mon, 02 Oct 2023 04:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkv-0001fL-KF; Mon, 02 Oct 2023 04:58:22 -0400
Received: from mail-db8eur05on2071c.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::71c]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkm-0003RK-Jv; Mon, 02 Oct 2023 04:58:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5aiDAPEvY8+LR8khPg/k1GfBdBCWxRMw7xaj8mImUEACOH38TyslYYqt8EMYdXmk+OH6Vs8B31TDmMsm+XBl69G1ynlm9Fsib8NIvckMWKWYY5iPeo8lPvlPJoyzBei730YisUu4YXorncqFTzNeAPcc5bRq+8ISYrvwrQBYidsN5TO2FlmntfAAVSpURXRq+bWYY5alzGTvrBs9XFgliHmkWkPUF5aI5UYL0aCFGAbvr803sdqq91xkjekOsxPiKDVZd0olg+QAl/3ImL1Ou0OtuQznkEMzGDjJxsWe7FNCmELLJer/8aRdTTV9JlT8KVZsZ2XCT4ltqWYcMn6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/k1oANas5MIf55ewby6rPkY5+MPfOFhL+ASOIh1bWOk=;
 b=Fnq5qxgjqjHcsGPXSSEyoNuN+IMXFFCo1NMhEGzPLD7aGke02TM0jX/1wsbBahChxA6kPOuhcWahLX5ChD+NB3lxsrXmXplQrQEpDHps9bkiwzRr0sMDkqbhdfKgOMFyt6nSij50ah72sUZwJrykj3bZyGalejWxbBrsaBlQ9fM5aYHdd9FnA2emR3yVZRANoVOprfW2mrSQ2/aXpxZWn/p1BEDfmbK7NM+PVbr3QM+jHlfbC0vTvkRu7ba3IO4EsZESRIvCgDp4SIbWuCmj2MpVsQqa3LQLLRhPiINpQt1+2nDqpTsmRYMENhn5D2YiKO7V20rtR5Cqrsn8DICNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k1oANas5MIf55ewby6rPkY5+MPfOFhL+ASOIh1bWOk=;
 b=IuVpdCoiQHCO8vANrsjFWewqHtQ8oBRejYub8C5TxHz3Luk29P+VUC8qD/fA9yCkmCN1aEAAEWhKgWAaNmjwdY6vXEDuTbCmzR/ImlTnYWz5tIOMhw59QCRAR5gpXx71CbWeDRJqeGVdStvvU+d28C20X+IVlwdNzwDXmxUjd52ItzvUbPsO1xR68+X/Dhp94P8YXJVUk3c1ZoXMjpHFUkB0lr/QIez4wKWlKG+kxw9t0Q7/F5IT5J9URUev65mWUsN6CyzcipsLPtPywkVkjBF4IdFYRknQgafgwFfptwn/BDi59NI/QOHasPuzzfgxLCuo1VT/kNpangObFafZTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:57 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:57 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 11/19] parallels: Handle L1 entries equal to one
Date: Mon,  2 Oct 2023 10:57:30 +0200
Message-Id: <20231002085738.369684-12-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
References: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::45) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|AS8PR08MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: baa7886c-aa13-440f-5fda-08dbc325ab89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sajspc7dBwO4RUpQjiSTVTdgYsBJY9KNcPA7sZSkPgQOldGIXx/qaakrJNYXEXx+92OTcMsxbbhFsEcaCYjK7VjQPRfqw3WYPNEvqRlSFva7NMCcH/u3aEIbEus+pkEaeuy784i0b67ZYQetsHcw7gujvvm4WxxjCaM68u3m2p2qvDDLMM4f8CZVDyAClHHPyUwl8GdNUOUtGmhUJmUxlo0+326+0DdmHYhamyo4e8Y1u73yokqGzxEuXVXX4eyV5MeRuORzSt5ifAuk/w14ojHhQTlYTAlTB5cYqS58lZjIUmrRGSQZTyFLGggXh4tHLsxZFutC8+HGpeSM5NZGKBwxAz2b8TrcPSR2tE9h2ouOzcjPKDBTfjlF5P+RHDzHzajus8AunqzrTXXKEKDjYhVmV2KsgKXDYvAadjFPA4iOIudfnJvFwuzXFprW0ib6nOF5WjDup6R9IyboMWZs+3y7EH7aq9ZbEg2bHg4zCDzrBfql+GvMq9BGHDxpoHmi8faAkWBHWhg8rAWKUT+pWZwugdUK8HFe55KY47AJi5rAy1lB+tm9X0+GF9l2HIY6npjFlYMdijFPJNMZ4Y8vll9OZ2LAB4BoSeBbLe2r2ymUDjbaWz4rt/6u1/0dxMbv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IxNy5ZDrNH36i63BSlsLmsGRDZrCv+wryUJEqZG1veFYEhzhM6RsP+oTslRX?=
 =?us-ascii?Q?+kecfa2Tp19OO3EnPaJmz9cyqo/bc4TE+DTKaDKX0+rN9uFjaEJ3umBiCkkK?=
 =?us-ascii?Q?otHy/DZ5Xer5a5zwbAqRrECtQhcqzHLWxmdByXx1y9Q+hJoYc5ybHUdeZz2t?=
 =?us-ascii?Q?rZeD0hPCDw0SsVangcz+0bF22McVUvEnxGWaiL935hbY4Q3Hyl9esvN4VqlW?=
 =?us-ascii?Q?oA+mjpB/w+KvDJ0lXd0A92JxlsYkUwZREiL0uCGyHi9nspCTSXMmHydwhKKl?=
 =?us-ascii?Q?aXm/HL6qax9+OsCEisjbG9uneVxOVMQSe/5VK+83NBp6NCqGqBJP0DkWxOhO?=
 =?us-ascii?Q?7XtnsSwPoH8sGwABNet9w2tz1GzTBoA/pVubHND8UFv7IYeA6Vd0OOo3rieh?=
 =?us-ascii?Q?SrZjKz7FzijnHvUKVkrvyvtbdjJfUE/2Vkj/z/oLI0GfPeLFWpXA7CwTb2oz?=
 =?us-ascii?Q?hmGUfIgy77dgs8M354fw+vIXx9PgQco2FBoxQNFbqKV9iZlpILMzUtviMKAf?=
 =?us-ascii?Q?xVjigmlN96OT/7SWsLILxcEvu+Oz89r3GnZCUuWY6dUZHNsE0GEsKx6t+fyb?=
 =?us-ascii?Q?zGBRgtK3M3FdLslAC1mS8xouOFz66QJ1QWqXZPVPsNkI/KwXpYsXMOX/h6U9?=
 =?us-ascii?Q?I68ED0j2RsojFvC1SN+/pF5qOP/x6aUDu7MQI1Lv1qCjpM3C1MYvDbwnocbg?=
 =?us-ascii?Q?OLdGCv9P8XUJwqvrkOm6g5yKd3lPOPOaE7t/a/X2j4NVNrLpvfb3WR0AueQq?=
 =?us-ascii?Q?Fl9aqT+kw+DfV6On3xXD8nfdjR6elzzfb+pLRQmWoUX18t7veD673zMBdOVI?=
 =?us-ascii?Q?4QuhUHA97EYYzdxpISBSeaLbapW3x6OAuVmU8Ka5reC9Jt4GlrNb8Z8uHILI?=
 =?us-ascii?Q?XZ6A8W4Jj+1Gu8FVPBbwAvl2unOPUeFdq0TvXY0qXB2b8ogoXgDcRHqGoz6e?=
 =?us-ascii?Q?SEYu1rmHE+/U2UV1h4IVQA6b49Y5gwLpDFiBWGHNKm0sBYIvRpGPprcjsUA1?=
 =?us-ascii?Q?HOpaeC2wvNK+5T4ekACU9gE4lRjbKFoUEOSk6/Zf1oi/0pACVZq6ECpSayvs?=
 =?us-ascii?Q?RuVAADF4JIh5mLLR2iCIY1ngVEwDw1gJvJ+atAQkXU/QqMRuQoXcs8aXkw91?=
 =?us-ascii?Q?uevXdXFZFPFATbSv5bbdTBKYhlRUmN6rRCgNfcMnEKpsSSxRavlp0EcNCct+?=
 =?us-ascii?Q?Ir2ElHJLQBeHzBXflXPqmcnzHzi36r7CFbHjk0ecnnEv6nMdMX1C90If6HiQ?=
 =?us-ascii?Q?jBWZsK0S33Ra/Xp/FMQSSG01enu33fBibxrbSaFXlep+pv/Q+A+XSCEe8pGO?=
 =?us-ascii?Q?dV4/UA4iG1pMRZvXh6uFhbVel+s4ErgiW6MFhcNzKZVH2WJy5fw7U2bq+CCw?=
 =?us-ascii?Q?VIJz07Fov8jt6ZFtcM8Z6gi56MBqBJDl4N0KWD7Kms/qMbez3tz4c2cVRySq?=
 =?us-ascii?Q?VOUkljCtVk062+dlMxcq9iXRZfuPwmbFc3Vf1gElYtttZ14fZyTbuAqN6rcl?=
 =?us-ascii?Q?6urfhhTK5aSO2sv5+GWJ5EUSCtGXROHIx8W4PQVX10Mxntqh1K2T0BwofTKz?=
 =?us-ascii?Q?RM94nNyVKhBCFGLKESoFF3oNreyDF4csOndAkOCVc7w7hiXrrtycBXqy1d/I?=
 =?us-ascii?Q?F1U+vrX3/cgHsBOvmMgS28o=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa7886c-aa13-440f-5fda-08dbc325ab89
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:56.4016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Y0DETwe3TV8m/5A00k/Q0rbHQ8kXkSeb4oJbejS80letPMnEaVsup93OSmpChm96PtlKzNUkrEsCHmi4owRbXIkjqS3R75lWZBsLHe18E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8273
Received-SPF: pass client-ip=2a01:111:f400:7e1a::71c;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If all the bits in a dirty bitmap cluster are ones, the cluster shouldn't
be written. Instead the corresponding L1 entry should be set to 1.

Check if all bits in a memory region are ones and set 1 to L1 entries
corresponding clusters filled with ones.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index a0de4f1b07..ebda6b0a01 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -354,7 +354,7 @@ static void parallels_save_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
     offset = 0;
     while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset, bm_size)) >= 0) {
         uint64_t idx = offset / limit;
-        int64_t cluster_off, end, write_size;
+        int64_t cluster_off, end, write_size, first_zero;
 
         offset = QEMU_ALIGN_DOWN(offset, limit);
         end = MIN(bm_size, offset + limit);
@@ -367,6 +367,16 @@ static void parallels_save_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
             memset(bm_buf + write_size, 0, s->cluster_size - write_size);
         }
 
+        first_zero = bdrv_dirty_bitmap_next_zero(bitmap, offset, bm_size);
+        if (first_zero < 0) {
+            goto end;
+        }
+        if (first_zero - offset >= s->cluster_size) {
+            l1_table[idx] = 1;
+            offset = end;
+            continue;
+        }
+
         cluster_off = parallels_allocate_host_clusters(bs, &alloc_size);
         if (cluster_off <= 0) {
             goto end;
-- 
2.34.1


