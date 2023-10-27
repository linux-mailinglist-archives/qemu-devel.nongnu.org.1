Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D857D904E
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:50:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZx-00014p-J3; Fri, 27 Oct 2023 03:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHZ1-0007Nm-BU; Fri, 27 Oct 2023 03:47:28 -0400
Received: from mail-db5eur02on20704.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::704]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYw-00040L-7x; Fri, 27 Oct 2023 03:47:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUAZUN87KRUI7/RSvNYXK85RIVT9g+uwMNV5IZRvt0E7z2UH3qTYuJc++auoXHJgOdRfE/8fX/BmSiBRohoFwAfkKQW68YbvS3iL6DB6nwKAZ6YQMTA2KfBSjjbyyHKb5l8CtuHKZJZh7bhGdSjgwcc7ugq3Mk4jDHbXUYzBAiDXvBbaivE0Lh7ejcZwXirbsCJMCBS6CXoCCwH7DxQqEHjJo29Hq+fEqbCtiZxJGaUME8sux2xJyyZ5BcF+rj12Gr6T15Gcd85CBmnifnKDd7I5RTCedvaLrO3Bcb25fBAHVebusfBkvPiq3PACqBITrbb8wMePhWWnl0eDwqrl2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVdlrd9E0KA0wnXYG4RCIh43wDwoF7uchSJR3rqTr9U=;
 b=fNRML8szeVl9BeYmZfvAiK98e9p6spOLZ3mT/8yp+Ms+Tcb7QLsK6gx/NjzuAo5HewoIpqvKMNXad421F7mhP5bjfqujLuhNkvruT/lsUvhZPo9/vsiqQDT6VRCk4eNvxpefYQYG3pAU+1NVR/3UAxGrEj0z+0gMZCMQ1K2WYEwq/yFuBuRMisoxxjJd/M310BoKDMdLDK3jsAuxZeUi4yYhLEdfolEkca261dDiafCawVrUq3Mj/LbDMPMb1sUj2BAQAhscy/083Mq1/TYHmRH3v6d6IBrJHZOMraJih4VIJgEYtYhhUmwIMJ2enbn+j54+43bI61mqSfEo8MtGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVdlrd9E0KA0wnXYG4RCIh43wDwoF7uchSJR3rqTr9U=;
 b=E95jyyURwcmr/koKqfJkibYNIuFM7hiYm7YaN6yrnFOt+JwYWyz2LQny5nFFt+G50+Ud1ejH2I859GM/KtEXZ3ikOSowSqnAPPx2P0i6RyJ+7k0RNXKSphAxsSqrfpKXI5+TOSmLqgu6n9KAqPHPLW6jfXDXZuGN7Om3nI29qFpqVXy15tto13iQHcA/JzYFTN+8nYyTuT6PUF6NVjjrevKXbKy5QtxKNDLAP29Bmq/qkXthC0d4VPvPH/cN9nLII1xysAArS9cTHXMvfW1VR+5uHGIpavvaP3Dmybyw4zouT2sPnX3NPSN2YUQeHu1jZPDVewuEWVEDmAT6Eav2Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:51 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:51 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 17/21] parallels: Check unused clusters in
 parallels_check_leak()
Date: Fri, 27 Oct 2023 09:46:32 +0200
Message-Id: <20231027074636.430139-18-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
References: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::30) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f1a7c3-1dd9-446b-2785-08dbd6c0e0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OashZnPmCCGUvJ1TzXeke1fzDQw57LhIjXND+DwK2Ch7mTBc/vfOVsbV5q4F6ko/u3tXumdCyN1jm5HEyZQZdk/iF2EKUTesijYjCAhMGvigczikYHt7/q5LZNlvCfDjiKBJ8KDaOxOPSbFDgTIxIg8BoXbFXuoHDQMaT4em5Lt8uvU6NR2erx2F8PDZd3Jq1a/1d9lJGeYxJe1ORL3C0DMf3+D9lYLBqdxutA0v+Hsj4ANSPoa03cnmZ8nvMHBl1CpyphWhnuKVAt+xwb4SLmvui96JSSIxSVGa92qA9h7GcDh0It+DRHcOmH6RQxVMMAcq1SCw8lqpCbVUawN4pqhRJyfUwRiA//zQmwBSd4hMtSXMTmtgGXh+u6c6SlXhAzw9ml0o92i3DWHwrR14ebGhHXuOuoGas3mgfVQB8o2lr2ERz6zCGRlWigher1BnAjg34TxftKB9jncuy9DnxQKZHLG4Kn7PtE+kC4cBvMx9nh6xb1zB7iCWh9ogUwj2XIsNE19L02o3bvT7N1pSN0EwGfM1VTusatkhAuL5w+mKSqMChbXe4ICEfGrKWuW5rZp0aVip6LT5/qAuumLuxN29Biuahrsmz17Lv1tSbFgqucevwnLs3sGbkLn0g/vR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QzmHo115KJkGtlQkrQdm44EWvHNivWLXp/StiR0+MNPr0TqXSYRkSlHQIp6W?=
 =?us-ascii?Q?e6GqDeUDUB67z2uCcjyOcOv8qkvbkdISo4voS76R7hfGlDAo1ss5zICxbB0q?=
 =?us-ascii?Q?Mj9AmrIoPt0ia7N0KX246+rSGLCs5QvY/ooajzxhniIONAMq3bVmy707ZEHA?=
 =?us-ascii?Q?LA3Z257YqPPgLWUdpNhr/kjWB3HclujxsN6AL9vh7Lzzl8sK9sNxEWkk4mMC?=
 =?us-ascii?Q?/mN45nlopDC9t9iZydIlaC9XzsY9LwJ3yQSpPpj7lRJAzfhFlPUsp2a4msrC?=
 =?us-ascii?Q?jy1lWTFoftJjw4rLyumLKmz7CXlb/JWHAydTePuILCVUh3q4M8cTfkAJ52Qn?=
 =?us-ascii?Q?9pPSf0D/7IXHsJtzEJfs2BmqVqQ3QMLPPOcFWqzWoluTkWkEZ5Qf/5arq7H+?=
 =?us-ascii?Q?cm0KVFYodE49pqB+6iXSiBtukVgSrkAmswH4xqffucPZ1O97RLpADWGw4DCM?=
 =?us-ascii?Q?MPQs9mPoroIC2FQd2iqXXNGlYNPZht+LkzcKk9GJz6PvCmSN/bv/T0F0sBqF?=
 =?us-ascii?Q?oG5hzCnQ4jxIzVQRo+wCrL3Fzu42MYZ8RB29dcPhqqu2nR1nh3DbZaGmBMnD?=
 =?us-ascii?Q?Is+tJJRY0NiFqKt5vttkRFhyAngDDk3Swj9zuMNH3kEyU2eg9pmYqaybNuRr?=
 =?us-ascii?Q?rEpJBfYx70CEo4ov1O0BYBOtgClLqMnciuolwBFnUWCSpDJnOCaBZRxKFwh4?=
 =?us-ascii?Q?tu/PxgsblRdS54VY/LSXE5Kd03icJp2omdIGJgv0hN/3AP1tkNjSFQv0VGGH?=
 =?us-ascii?Q?/QxABJOXjCvhSWS4Mi7ocgqLPQfN9d0UpTa61A6xyGNWcgYhOaTZUYlO9Pn/?=
 =?us-ascii?Q?Q9Q8bAW6HFTUriLl/KI8SxS1B4EAOxO10Esao0OMVMLuPM4JjAvp7pWs0fPB?=
 =?us-ascii?Q?BLKxnrK9fRxKkcRVoQpH8mSPS8ZLDpIHy9YYW4Vc8lhez+TPaUiMDF6e2Jy+?=
 =?us-ascii?Q?wMUf9UTJqMFHO6n7SqLrdHunv44XkNwkJrp00VKnCoMZLnPRD3XWxTjwJ/MW?=
 =?us-ascii?Q?qRvVGRVx17dNWAKHSDjmbQBot4eDAQQNvbd6xVXabUZiUfs32KjZax7FT9on?=
 =?us-ascii?Q?vLdyYdgjfgtfjC4FZ9ouywxDL9x/9DDZtNaLKdltRWElOfCSiIhZSnkzxplJ?=
 =?us-ascii?Q?oZ9CzO9TIlYYJCbcRG3Vx2qNTIrIPZOz2K7vFRsZX2E6M97PYhVie2vsMudb?=
 =?us-ascii?Q?68M+vvZDuML/hRfaxhCvgca0j6b6HOo2qQ4SXD0OvMUxGHImSyYUrSqPZ5ke?=
 =?us-ascii?Q?lsIuQuP9QCJaBwP0aviZsdNVhZF1X+FqCwbuqfnM3GYsgr34tjh+wdlo9m33?=
 =?us-ascii?Q?JyTnVRikoCX171cZhCZsTPI5YXoci5IY///SHpDQcFMcENa4visngv9y+unA?=
 =?us-ascii?Q?vUvAynNlaMgixpz1NkRusJcTFDFeywC9i39LBkWndEm/LAWLbgS1IG1rmWeK?=
 =?us-ascii?Q?D78PIegU6zKKpl4TAjvjIyOQHI2uklq/Nq3YNzvLXRQfanPMdLFpfHugsKTS?=
 =?us-ascii?Q?7b6EcOqexuICuCUzVwBO0DdFcckllK9vUdxlTaW902x4Lj5EQXzWxhuhqzWM?=
 =?us-ascii?Q?Gvgd7zcVITB1oNEaf/JaSlHQqq7pwX0xJeC7bkAYgO0RBWvNYdEP5/4gCa0F?=
 =?us-ascii?Q?+tIJN/HliGfGwJi3nXQ5kNo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f1a7c3-1dd9-446b-2785-08dbd6c0e0a3
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:49.5239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76ydNoORGCdyfiO4WsJOfqesuPdhWZz4mEKAxDsilTPzFnLjy4EBr+9bN4GWP2TlgLhv1QGHYdT38G1iDG3Llvfk5XGcceDtNVbAOKTtvjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::704;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Since we have used bitmap, leak check is useless. Transform
parallels_truncate_unused_clusters() to parallels_check_unused_clusters()
helper and use it in leak check.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 121 +++++++++++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 54 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 472311e2e6..d497cdbe41 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -770,57 +770,87 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
     return 0;
 }
 
+static int64_t parallels_check_unused_clusters(BlockDriverState *bs,
+                                               bool truncate)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int64_t leak, file_size, end_off = 0;
+    int ret;
+
+    file_size = bdrv_getlength(bs->file->bs);
+    if (file_size < 0) {
+        return file_size;
+    }
+
+    if (s->used_bmap_size > 0) {
+        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
+        if (end_off == s->used_bmap_size) {
+            end_off = 0;
+        } else {
+            end_off = (end_off + 1) * s->cluster_size;
+        }
+    }
+
+    end_off += s->data_start * BDRV_SECTOR_SIZE;
+    leak = file_size - end_off;
+    if (leak < 0) {
+        return -EINVAL;
+    }
+    if (!truncate || leak == 0) {
+        return leak;
+    }
+
+    ret = bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
+    if (ret) {
+        return ret;
+    }
+
+    s->data_end = end_off / BDRV_SECTOR_SIZE;
+
+    parallels_free_used_bitmap(bs);
+    ret = parallels_fill_used_bitmap(bs);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return leak;
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                      BdrvCheckMode fix, bool explicit)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t size, count;
-    int ret;
+    int64_t leak, count, size;
+
+    leak = parallels_check_unused_clusters(bs, fix & BDRV_FIX_LEAKS);
+    if (leak < 0) {
+        res->check_errors++;
+        return leak;
+    }
+    if (leak == 0) {
+        return 0;
+    }
 
     size = bdrv_co_getlength(bs->file->bs);
     if (size < 0) {
         res->check_errors++;
         return size;
     }
-    if (size <= res->image_end_offset) {
+    res->image_end_offset = size;
+
+    if (!explicit) {
         return 0;
     }
 
-    count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
-    if (explicit) {
-        fprintf(stderr,
-                "%s space leaked at the end of the image %" PRId64 "\n",
-                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
-                size - res->image_end_offset);
-        res->leaks += count;
-    }
+    count = DIV_ROUND_UP(leak, s->cluster_size);
+    fprintf(stderr,
+            "%s space leaked at the end of the image %" PRId64 "\n",
+            fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR", leak);
+    res->leaks += count;
+
     if (fix & BDRV_FIX_LEAKS) {
-        Error *local_err = NULL;
-
-        /*
-         * In order to really repair the image, we must shrink it.
-         * That means we have to pass exact=true.
-         */
-        ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
-                               PREALLOC_MODE_OFF, 0, &local_err);
-        if (ret < 0) {
-            error_report_err(local_err);
-            res->check_errors++;
-            return ret;
-        }
-        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
-
-        parallels_free_used_bitmap(bs);
-        ret = parallels_fill_used_bitmap(bs);
-        if (ret == -ENOMEM) {
-            res->check_errors++;
-            return ret;
-        }
-
-        if (explicit) {
-            res->leaks_fixed += count;
-        }
+        res->leaks_fixed += count;
     }
 
     return 0;
@@ -1456,23 +1486,6 @@ fail:
     return ret;
 }
 
-static int parallels_truncate_unused_clusters(BlockDriverState *bs)
-{
-    BDRVParallelsState *s = bs->opaque;
-    uint64_t end_off = 0;
-    if (s->used_bmap_size > 0) {
-        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
-        if (end_off == s->used_bmap_size) {
-            end_off = 0;
-        } else {
-            end_off = (end_off + 1) * s->cluster_size;
-        }
-    }
-    end_off += s->data_start * BDRV_SECTOR_SIZE;
-    s->data_end = end_off / BDRV_SECTOR_SIZE;
-    return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
-}
-
 static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
@@ -1490,7 +1503,7 @@ static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
     parallels_update_header(bs);
 
     /* errors are ignored, so we might as well pass exact=true */
-    ret = parallels_truncate_unused_clusters(bs);
+    ret = parallels_check_unused_clusters(bs, true);
     if (ret < 0) {
         error_report("Failed to truncate image: %s", strerror(-ret));
     }
-- 
2.34.1


