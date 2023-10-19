Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F717CFA51
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:04:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtScY-0005o6-L5; Thu, 19 Oct 2023 08:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScW-0005nF-Cm; Thu, 19 Oct 2023 08:59:24 -0400
Received: from mail-vi1eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::703]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScU-0002f3-S4; Thu, 19 Oct 2023 08:59:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nevb5vtx8DiKfxC4JJOw1CJVey78KVhrhxuehhyK/moK76QXFpCkPgKQvxqmtpxI8599bNClwyvI3qK4UfRsSBGPwlmE3ofXnuY6V8a/NGztJh6uIY5TiQC3OuxW6z6BCvSIfeaorywsfORDh+3bze7DpB+1u4i4x2mmG1trl2A9RGqGHLgBvulKTzYYfDBgDrMLH4t4FubRndbUhv4FlwBHiCXnVtAPa79OViQGdubz33Tj3SESUj2cV8a35Q6RretBmoD6CE5Lgu6E4d/iSA19QXUckp7q47YaLwD4GP9hqdgDs9Fue3+ZjwrsC4N7C5iaOOBatnTLdKFZ+CWokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/k1oANas5MIf55ewby6rPkY5+MPfOFhL+ASOIh1bWOk=;
 b=OQ6e7LySIuBKsdoRDiIpTg5hn5WcDBH8JFpEUWxxzQKtrD0O8p54D99edFmpQaH++nuX/nTNR4AmBIguX/nk0woRk2+UqSLu7LCSNYU3LjkAXl8v7VmoaMqkSOLBdtflC2V2DwOvblgJYvQFQZuSptconCL+i2ldojMTwFnBcPrKbvjj19/VVfgGrIBtmYGgO4NVQt2i8I5UBgrl4UFXHgMRrLOYiAXuIhPM4eZWwBE/blWa5obm+Y2p7yqlU4mPeFJ0K3r+d02ExCuEfUJUA0eGgwrzz516LGCmDGu2Nw8ArGn3azBwa7du3AwTJHOE3QA3x0VwOY1f2wDyunkeBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k1oANas5MIf55ewby6rPkY5+MPfOFhL+ASOIh1bWOk=;
 b=tGWUyaAqnX7+6qMTzGJVWUkEuR41yMoZnwkXC2wsxQWMsZmHUHurxOwfFhnj+snRs4ycxUvUgpXX8z6ip1plF89GJPcokoTLg0vD21A/R9ZZCk1EieBo/Lp7Gbg+a8fLPLCsgZe0jWULm6X5bVfZ6L5Qw30jGSZfK+/pZyjULEsgqNv9E7GmgScxeeynZreRuUt+wcQ0kraTMQvTLB9NtSmnt6IVLYPXuCCkbP7D82A5Ed7mtokoEB2fwJc+Y9CFgNbF50NiBbqhK7DGYH6aVyvLtP5yL/ckLHMCKGwW+WV0nHktbBPOXRkEtNWOk0LTcBWYDIP3fPYvr3saVejowA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:13 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:13 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 12/20] parallels: Handle L1 entries equal to one
Date: Thu, 19 Oct 2023 14:58:46 +0200
Message-Id: <20231019125854.390385-13-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
References: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::39) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|DBBPR08MB10554:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c90fad4-4547-4535-ee88-08dbd0a331bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUzOByOXB0ezPnKfUmfSWe24LbzJX2LJPS6VcwQ1PlcHrIiy6ks5S2qC+ZASMbtuiaxpGarguTk5jKEXv7jbnPKPBRvx1ZtlnW0+RPVK4jh46bzPeKmkigHxysDcvqkGYYg7hxoo/mfWeBWWSpmEYt1jmjIyIEns5LZI5uLS25VY0KWvtH+K4N8SYvfoMYPFE6V/rmEMpW9Oyp5v8UPle9xA81d/KMxprhH0Qxyyif1RqeVV/1ulhF+fjsb/mOsNOheuuCSmzzXDkI6XbyFR1VqB+sj666sJGqGoR/sCkPYDV2RnXR2i5BgYemlL3MC7IGIidHDIl+6+qoXotiWG3xlNXh02uUisWT2/kH5yiZ3TC4ub3tpnCf/aNgVj5UmyzNSlKPXEbVj4IuhVPMwic+rfIeJuHIn5EaATKHLkk3J6ui7BGCF84qFYnanWzJ8wZ/m3JrbH/B1IoptTUOTu3P0NfL/rAtIYst3Vmfn1SlWM/d8Ow+MhHNTf89HrHyHLxZTKYlD1stexvw8dRPEuYc04Wzq3d9K/rO8IgebvANhJY7o++tr7Oe5brndkKvTm222aN5HjLgxxWeYvHPeUrUzUDX5HO8tWbw2vAJr6/hjnIIrmlH5baTqsRZdWc3/z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DG7AIn9+ZWo9EfvyOFdykxzm9eMyPgamcd7XTw0aqh7kuMvQdf1QgHHoqwi2?=
 =?us-ascii?Q?i7r5w9Or1l4f3R1Jdyv3L1ITRfzCbiwag3I0s2S9XNAoke3Qt4egum0kYUGd?=
 =?us-ascii?Q?UONVZRFYP9J34KlXN99ss5cWG0jVNytkwoXgbwkrO7dLa8NHEcWn+p+Ubi77?=
 =?us-ascii?Q?DQchb23dHBe44CiR1IsE5rhzyKU459v1nNoeHZN4ucCFHVx0/rU/FFqJ4Jrz?=
 =?us-ascii?Q?lGJxc1gdLk3Ep3EioZHRzWTX7+nuhjy1JBWk3IiNiL4lyuNDHwMun9ZZ1CZF?=
 =?us-ascii?Q?e1LATINKXlfsOaxNFw8KAN/0fYNw0wSzkEQ/uHzsPpvcLHGUj/UDMQop3e/B?=
 =?us-ascii?Q?u4I029lQpgyyt2nV0/toI8lL2fua/8JJYf78/nnrjU2iy43l8ow12mGjwN3y?=
 =?us-ascii?Q?IP6xjvJMmrrrH0p4XyexWlp7kYEtcf3QT5YW1vB9SD4C4I8iYeC9tT6b/xC4?=
 =?us-ascii?Q?849XQn4blOhHlsFV75BqQSFnStskLteNT/KRZFk/kPmGgj/pEXzoiiZkjvWD?=
 =?us-ascii?Q?6hmghB+tnFL/0l1fig5kAXQR2X7vX9EwvpIRsCRjHoxZuGFwl37yetgXQ2iA?=
 =?us-ascii?Q?GdrLcVUVAjMQ3nEQTnesRpsmGrvgKcFSXzYJfLai9kt3R6XuEHS534v5jUL9?=
 =?us-ascii?Q?pf65pbv4aq4AvjoF3ASkH+dh5Bl1Z6u7kaJVwHup1GQDMEZU70NT4p9D0E8A?=
 =?us-ascii?Q?CyVcBk2cxIVDU3RU34cPu3IuKspcAnUrqChhtGTALNiJzP9R5kFASVss3edf?=
 =?us-ascii?Q?95xZLIXTWfhaw+tYV6hxGlsJr34lezeleER3XkEEXGvIhoOOTXkGHOf0QF9v?=
 =?us-ascii?Q?wbFU9bDcFgOQJJ7Wa3+lp/MtLGkxNIxXpLH6yJp/QZFWVxqHuJdeqmXiEgJX?=
 =?us-ascii?Q?t6NkOYqNd7gacyU273PeUgHiRFZGZJnZK2a2oBELXDZl38zDvsi0nAw3DJck?=
 =?us-ascii?Q?4vji+FDnUlJ7U9aLAhWRhcRVrNdcnt+vRziR6BRmV0imEOIfNivj9a/EE+en?=
 =?us-ascii?Q?woC0Dm9oFLAxruiP7mNfRUZpwgg/zCi2uZWRdxF1QLjqxRx6uVaQLXY4QsTR?=
 =?us-ascii?Q?syf04x8IlKwCZGM2AP8i7ok7t5tQRRsRACkGy3yBB57Z8StAHCjt2CLlaDj2?=
 =?us-ascii?Q?EPz4ierDin9bp9kVDnZsmWRup/Ce2FO7ra8YK9DvxaOIRZ9OBy8Fwl3JEOj8?=
 =?us-ascii?Q?dq8oXXPVYva+UOnalvafvo031nbjMdw6llZePjZSMqvHccmDqOCIwKRoRGuJ?=
 =?us-ascii?Q?dOia1C4wVYyG6Ta8tD0OKmhyj1qcFd59fe+xT9vshfCihN7d4NvPS2P1EICD?=
 =?us-ascii?Q?YJHXhzSMHLSEnSCo740Y/hLX701hAUwCY0QDmBqJybAsHZYiQYcC3KL49ziZ?=
 =?us-ascii?Q?XTsXAatRnq9LXZSVUp9e9JjOwipHwSAJwVJ7rY4IGwEzm8628lbUSCB2d0tb?=
 =?us-ascii?Q?o5eeUiSOQIgKa1gH0y1oiZqJWkUlAO09XhfWAi4cf2Sp4Z3bK0Rf5RXB9cwk?=
 =?us-ascii?Q?oVjAH4dxEY4pyKHEHQ0bhbm6vX3XFfXsL1fDpEcKvvhb/0ifKuhXYyESKdrd?=
 =?us-ascii?Q?gzq1mvnL5CelQ4/Ilx8Dj7mYLaaxv5NBK/7ryqiIv/BcZNXn8NurxvMDI87E?=
 =?us-ascii?Q?tIPRPihdGhEYsrD58yxWtcg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c90fad4-4547-4535-ee88-08dbd0a331bd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:13.7327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6t12xgHP8x3QFQNlAW4r4oAyN8gq5XO7zmOgSwefYFjxHm0SpOK7ya4YMK8koYIMU2q1fDkja24OtmO4keOnfAJEnOOvbzM806coyBYJsjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:fe0e::703;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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


