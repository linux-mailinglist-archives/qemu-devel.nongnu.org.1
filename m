Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 614C27D54F2
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:12:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJ4F-00057U-Km; Tue, 24 Oct 2023 11:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvJ48-00050t-VD
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvJ47-0000vc-4K
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698160290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIqlxPz51TKatnb8SnVpvOTh0EK/sIsjRQSdp/ndJ1A=;
 b=IIcV/htcy8Zu88kHYhPv9t4gLP/vqYGSSTeyw3IIoNWyTZQmzzxKbijDwSXMnm7T7uYfhg
 t8H3/yK7YQxbDesBmbBK+KpHYNBBNaWRts3VjPuhwLTV1d8+63JsOauDxIU2AauvZ1IPiZ
 qEI/noh8knzAEhr0utkXF2uywsAzVbE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-dW6HXZWEPVqF-clQ2J9uYw-1; Tue,
 24 Oct 2023 11:11:12 -0400
X-MC-Unique: dW6HXZWEPVqF-clQ2J9uYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D45161C05B06;
 Tue, 24 Oct 2023 15:11:11 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90CB72026D68;
 Tue, 24 Oct 2023 15:11:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/12] qemu-file: Make qemu_fflush() return errors
Date: Tue, 24 Oct 2023 17:10:42 +0200
Message-ID: <20231024151042.90349-13-quintela@redhat.com>
In-Reply-To: <20231024151042.90349-1-quintela@redhat.com>
References: <20231024151042.90349-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

This let us simplify code of this shape.

   qemu_fflush(f);
   int ret = qemu_file_get_error(f);
   if (ret) {
      return ret;
   }

into:

   int ret = qemu_fflush(f);
   if (ret) {
      return ret;
   }

I updated all callers where there is any error check.
qemu_fclose() don't need to check for f->last_error because
qemu_fflush() returns it at the beggining of the function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Juan Quintela <quintela@redhat.com>

---

In v2: Now that we call always qemu_fflush() for all files, we can
simplify qemu_fclose()
---
 migration/qemu-file.h |  2 +-
 migration/colo.c      | 11 +++--------
 migration/migration.c |  7 +------
 migration/qemu-file.c | 23 +++++++----------------
 migration/ram.c       | 22 +++++++---------------
 migration/rdma.c      |  4 +---
 migration/savevm.c    |  3 +--
 7 files changed, 21 insertions(+), 51 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 1b2f6b8d8f..1774116f79 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -71,7 +71,7 @@ void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err);
 void qemu_file_set_error(QEMUFile *f, int ret);
 int qemu_file_shutdown(QEMUFile *f);
 QEMUFile *qemu_file_get_return_path(QEMUFile *f);
-void qemu_fflush(QEMUFile *f);
+int qemu_fflush(QEMUFile *f);
 void qemu_file_set_blocking(QEMUFile *f, bool block);
 int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
 
diff --git a/migration/colo.c b/migration/colo.c
index 72f4f7b37e..4447e34914 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -314,9 +314,7 @@ static void colo_send_message(QEMUFile *f, COLOMessage msg,
         return;
     }
     qemu_put_be32(f, msg);
-    qemu_fflush(f);
-
-    ret = qemu_file_get_error(f);
+    ret = qemu_fflush(f);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Can't send COLO message");
     }
@@ -335,9 +333,7 @@ static void colo_send_message_value(QEMUFile *f, COLOMessage msg,
         return;
     }
     qemu_put_be64(f, value);
-    qemu_fflush(f);
-
-    ret = qemu_file_get_error(f);
+    ret = qemu_fflush(f);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to send value for message:%s",
                          COLOMessage_str(msg));
@@ -483,8 +479,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     }
 
     qemu_put_buffer(s->to_dst_file, bioc->data, bioc->usage);
-    qemu_fflush(s->to_dst_file);
-    ret = qemu_file_get_error(s->to_dst_file);
+    ret = qemu_fflush(s->to_dst_file);
     if (ret < 0) {
         goto out;
     }
diff --git a/migration/migration.c b/migration/migration.c
index a6cde985a2..ce12fca520 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -305,12 +305,7 @@ static int migrate_send_rp_message(MigrationIncomingState *mis,
     qemu_put_be16(mis->to_src_file, (unsigned int)message_type);
     qemu_put_be16(mis->to_src_file, len);
     qemu_put_buffer(mis->to_src_file, data, len);
-    qemu_fflush(mis->to_src_file);
-
-    /* It's possible that qemu file got error during sending */
-    ret = qemu_file_get_error(mis->to_src_file);
-
-    return ret;
+    return qemu_fflush(mis->to_src_file);
 }
 
 /* Request one page from the source VM at the given start address.
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 7e738743ce..d64500310d 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -262,14 +262,14 @@ static void qemu_iovec_release_ram(QEMUFile *f)
  * This will flush all pending data. If data was only partially flushed, it
  * will set an error state.
  */
-void qemu_fflush(QEMUFile *f)
+int qemu_fflush(QEMUFile *f)
 {
     if (!qemu_file_is_writable(f)) {
-        return;
+        return f->last_error;
     }
 
-    if (qemu_file_get_error(f)) {
-        return;
+    if (f->last_error) {
+        return f->last_error;
     }
     if (f->iovcnt > 0) {
         Error *local_error = NULL;
@@ -287,6 +287,7 @@ void qemu_fflush(QEMUFile *f)
 
     f->buf_index = 0;
     f->iovcnt = 0;
+    return f->last_error;
 }
 
 /*
@@ -353,22 +354,12 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
  */
 int qemu_fclose(QEMUFile *f)
 {
-    int ret, ret2;
-    qemu_fflush(f);
-    ret = qemu_file_get_error(f);
-
-    ret2 = qio_channel_close(f->ioc, NULL);
+    int ret = qemu_fflush(f);
+    int ret2 = qio_channel_close(f->ioc, NULL);
     if (ret >= 0) {
         ret = ret2;
     }
     g_clear_pointer(&f->ioc, object_unref);
-
-    /* If any error was spotted before closing, we should report it
-     * instead of the close() return value.
-     */
-    if (f->last_error) {
-        ret = f->last_error;
-    }
     error_free(f->last_error_obj);
     g_free(f);
     trace_qemu_file_fclose();
diff --git a/migration/ram.c b/migration/ram.c
index 6d2bf50614..3a1d9882ce 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -305,17 +305,15 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
 
     qemu_put_be64(file, size);
     qemu_put_buffer(file, (const uint8_t *)le_bitmap, size);
+    g_free(le_bitmap);
     /*
      * Mark as an end, in case the middle part is screwed up due to
      * some "mysterious" reason.
      */
     qemu_put_be64(file, RAMBLOCK_RECV_BITMAP_ENDING);
-    qemu_fflush(file);
-
-    g_free(le_bitmap);
-
-    if (qemu_file_get_error(file)) {
-        return qemu_file_get_error(file);
+    int ret = qemu_fflush(file);
+    if (ret) {
+        return ret;
     }
 
     return size + sizeof(size);
@@ -3055,9 +3053,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     }
 
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
-    qemu_fflush(f);
-
-    return 0;
+    return qemu_fflush(f);
 }
 
 /**
@@ -3176,10 +3172,8 @@ out:
         }
 
         qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
-        qemu_fflush(f);
         ram_transferred_add(8);
-
-        ret = qemu_file_get_error(f);
+        ret = qemu_fflush(f);
     }
     if (ret < 0) {
         return ret;
@@ -3256,9 +3250,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
     }
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
-    qemu_fflush(f);
-
-    return 0;
+    return qemu_fflush(f);
 }
 
 static void ram_state_pending_estimate(void *opaque, uint64_t *must_precopy,
diff --git a/migration/rdma.c b/migration/rdma.c
index 2a1852ec7f..0884333190 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3849,9 +3849,7 @@ int rdma_registration_start(QEMUFile *f, uint64_t flags)
 
     trace_rdma_registration_start(flags);
     qemu_put_be64(f, RAM_SAVE_FLAG_HOOK);
-    qemu_fflush(f);
-
-    return 0;
+    return qemu_fflush(f);
 }
 
 /*
diff --git a/migration/savevm.c b/migration/savevm.c
index 9c90499609..b19d625259 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1583,8 +1583,7 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
     }
 
 flush:
-    qemu_fflush(f);
-    return 0;
+    return qemu_fflush(f);
 }
 
 /* Give an estimate of the amount left to be transferred,
-- 
2.41.0


