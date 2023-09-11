Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F04A79A703
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:51:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdVD-0005mL-Bp; Mon, 11 Sep 2023 05:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdV9-0005kR-Qz
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdV7-0004dd-3W
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694425596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iabW5S/MWpfu+nX/swpsRFkS5q06JvmgGl1NF8gMsAU=;
 b=indMWnWhF4NjPSuEHUIktduw55cad0BiG8o0AFYMtfzaufKY/jTNYympvUwU9oISPsZQ3F
 L7XYm4vjVWHrwZINUqvcg+5tKni3l0PohJawHJl1o8Wg5smpedkhEbpbIDvzP9ktF4KZ1j
 0hRvklwg0GcHIf0YcBCqGaWj1S8UKb0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-ACF6DI6tPymAneAXhrL5CA-1; Mon, 11 Sep 2023 05:46:35 -0400
X-MC-Unique: ACF6DI6tPymAneAXhrL5CA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C14E98019DC;
 Mon, 11 Sep 2023 09:46:34 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00DCE40C6EA8;
 Mon, 11 Sep 2023 09:46:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH v2 02/21] preallocate: Factor out
 preallocate_truncate_to_real_size()
Date: Mon, 11 Sep 2023 11:46:01 +0200
Message-ID: <20230911094620.45040-3-kwolf@redhat.com>
In-Reply-To: <20230911094620.45040-1-kwolf@redhat.com>
References: <20230911094620.45040-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It's essentially the same code in preallocate_check_perm() and
preallocate_close(), except that the latter ignores errors.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/preallocate.c | 48 +++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/block/preallocate.c b/block/preallocate.c
index 3d0f621003..3173d80534 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -162,26 +162,39 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
     return 0;
 }
 
-static void preallocate_close(BlockDriverState *bs)
+static int preallocate_truncate_to_real_size(BlockDriverState *bs, Error **errp)
 {
-    int ret;
     BDRVPreallocateState *s = bs->opaque;
-
-    if (s->data_end < 0) {
-        return;
-    }
+    int ret;
 
     if (s->file_end < 0) {
         s->file_end = bdrv_getlength(bs->file->bs);
         if (s->file_end < 0) {
-            return;
+            error_setg_errno(errp, -s->file_end, "Failed to get file length");
+            return s->file_end;
         }
     }
 
     if (s->data_end < s->file_end) {
         ret = bdrv_truncate(bs->file, s->data_end, true, PREALLOC_MODE_OFF, 0,
                             NULL);
-        s->file_end = ret < 0 ? ret : s->data_end;
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to drop preallocation");
+            s->file_end = ret;
+            return ret;
+        }
+        s->file_end = s->data_end;
+    }
+
+    return 0;
+}
+
+static void preallocate_close(BlockDriverState *bs)
+{
+    BDRVPreallocateState *s = bs->opaque;
+
+    if (s->data_end >= 0) {
+        preallocate_truncate_to_real_size(bs, NULL);
     }
 }
 
@@ -473,24 +486,7 @@ static int preallocate_check_perm(BlockDriverState *bs,
          * We should truncate in check_perm, as in set_perm bs->file->perm will
          * be already changed, and we should not violate it.
          */
-        if (s->file_end < 0) {
-            s->file_end = bdrv_getlength(bs->file->bs);
-            if (s->file_end < 0) {
-                error_setg(errp, "Failed to get file length");
-                return s->file_end;
-            }
-        }
-
-        if (s->data_end < s->file_end) {
-            int ret = bdrv_truncate(bs->file, s->data_end, true,
-                                    PREALLOC_MODE_OFF, 0, NULL);
-            if (ret < 0) {
-                error_setg(errp, "Failed to drop preallocation");
-                s->file_end = ret;
-                return ret;
-            }
-            s->file_end = s->data_end;
-        }
+        return preallocate_truncate_to_real_size(bs, errp);
     }
 
     return 0;
-- 
2.41.0


