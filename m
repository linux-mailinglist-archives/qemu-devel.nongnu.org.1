Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3840C722BC7
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:47:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6CQ9-0008Mx-Pk; Mon, 05 Jun 2023 11:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6CPU-0007tM-G5
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6CPD-0001Lw-TY
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685979962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XxmLxQpEJrjP10A1yWPKilviO+OTFPazcS5ehkNvh0s=;
 b=hL4Ziz7pjKAI2jFXbgkAMNelKYrwtuabAHZgU2FMyhDu1DYNXMIiNqjw2bFJ1xRUnpFmCs
 /mnMbEx/C6g5UXx9VyMOLlQ0PQudmYJ4KmnwBHy1WTixAombtdBVSvE1cxF0VrZ2C0QCEO
 W5nTNRYqZ3PV8pBxceXGVn5FcKh/L7k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-Z_qAoFtHOseH7nfdEGaG7A-1; Mon, 05 Jun 2023 11:46:00 -0400
X-MC-Unique: Z_qAoFtHOseH7nfdEGaG7A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 616E5802E58;
 Mon,  5 Jun 2023 15:46:00 +0000 (UTC)
Received: from localhost (unknown [10.39.194.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2362A40CFD47;
 Mon,  5 Jun 2023 15:46:00 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/17] parallels: Move check of unclean image to a separate
 function
Date: Mon,  5 Jun 2023 17:45:34 +0200
Message-Id: <20230605154541.1043261-11-hreitz@redhat.com>
In-Reply-To: <20230605154541.1043261-1-hreitz@redhat.com>
References: <20230605154541.1043261-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

We will add more and more checks so we need a better code structure
in parallels_co_check. Let each check performs in a separate loop
in a separate helper.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20230424093147.197643-7-alexander.ivanov@virtuozzo.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/parallels.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index fa8a56a948..94b7408b6b 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -420,6 +420,25 @@ parallels_co_readv(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
     return ret;
 }
 
+static void parallels_check_unclean(BlockDriverState *bs,
+                                    BdrvCheckResult *res,
+                                    BdrvCheckMode fix)
+{
+    BDRVParallelsState *s = bs->opaque;
+
+    if (!s->header_unclean) {
+        return;
+    }
+
+    fprintf(stderr, "%s image was not closed correctly\n",
+            fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR");
+    res->corruptions++;
+    if (fix & BDRV_FIX_ERRORS) {
+        /* parallels_close will do the job right */
+        res->corruptions_fixed++;
+        s->header_unclean = false;
+    }
+}
 
 static int coroutine_fn GRAPH_RDLOCK
 parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
@@ -437,16 +456,8 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
     }
 
     qemu_co_mutex_lock(&s->lock);
-    if (s->header_unclean) {
-        fprintf(stderr, "%s image was not closed correctly\n",
-                fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR");
-        res->corruptions++;
-        if (fix & BDRV_FIX_ERRORS) {
-            /* parallels_close will do the job right */
-            res->corruptions_fixed++;
-            s->header_unclean = false;
-        }
-    }
+
+    parallels_check_unclean(bs, res, fix);
 
     res->bfi.total_clusters = s->bat_size;
     res->bfi.compressed_clusters = 0; /* compression is not supported */
-- 
2.40.1


