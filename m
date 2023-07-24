Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DB575F7D7
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:08:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvI8-00056q-G6; Mon, 24 Jul 2023 09:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvHi-0004S4-2l
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvHf-0002fj-Te
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690204049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZvjnHCDcjoJy/VQcFDdQTWd/9NEv2Kc87WInEpIMHM=;
 b=WGOyBAxxRgeCSx9uxskq36Shj8wPu96ueTsbI3bb7WhCA8pElNoIJu0x1SHxAAxDOyeZxl
 FKDfqv4C9np3XzWV6f6VxiJQ0i4AgyroBv+/CXGy7xhZU0shEy55SZjfjRpAEgZaH+aMYN
 DEOCtcuGnJPp9XFfHMY27u4irPML10Y=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-681-KxP_K1YSMESsBoN-woOjgQ-1; Mon, 24 Jul 2023 09:07:27 -0400
X-MC-Unique: KxP_K1YSMESsBoN-woOjgQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A77E38117E1;
 Mon, 24 Jul 2023 13:07:27 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B69EEF782E;
 Mon, 24 Jul 2023 13:07:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 21/26] qemu-file: Rename qemu_file_transferred_ fast -> noflush
Date: Mon, 24 Jul 2023 15:06:34 +0200
Message-Id: <20230724130639.93135-22-quintela@redhat.com>
In-Reply-To: <20230724130639.93135-1-quintela@redhat.com>
References: <20230724130639.93135-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Fast don't say much.  Noflush indicates more clearly that it is like
qemu_file_transferred but without the flush.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230530183941.7223-2-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.h | 11 +++++------
 migration/qemu-file.c |  2 +-
 migration/savevm.c    |  4 ++--
 migration/vmstate.c   |  4 ++--
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index e649718492..aa6eee66da 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -86,16 +86,15 @@ int qemu_fclose(QEMUFile *f);
 uint64_t qemu_file_transferred(QEMUFile *f);
 
 /*
- * qemu_file_transferred_fast:
+ * qemu_file_transferred_noflush:
  *
- * As qemu_file_transferred except for writable
- * files, where no flush is performed and the reported
- * amount will include the size of any queued buffers,
- * on top of the amount actually transferred.
+ * As qemu_file_transferred except for writable files, where no flush
+ * is performed and the reported amount will include the size of any
+ * queued buffers, on top of the amount actually transferred.
  *
  * Returns: the total bytes transferred and queued
  */
-uint64_t qemu_file_transferred_fast(QEMUFile *f);
+uint64_t qemu_file_transferred_noflush(QEMUFile *f);
 
 /*
  * put_buffer without copying the buffer.
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index acc282654a..fdf115b5da 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -694,7 +694,7 @@ int coroutine_mixed_fn qemu_get_byte(QEMUFile *f)
     return result;
 }
 
-uint64_t qemu_file_transferred_fast(QEMUFile *f)
+uint64_t qemu_file_transferred_noflush(QEMUFile *f)
 {
     uint64_t ret = f->total_transferred;
     int i;
diff --git a/migration/savevm.c b/migration/savevm.c
index 95c2abf47c..a07070db62 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -927,9 +927,9 @@ static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
                                    JSONWriter *vmdesc)
 {
-    uint64_t old_offset = qemu_file_transferred_fast(f);
+    uint64_t old_offset = qemu_file_transferred_noflush(f);
     se->ops->save_state(f, se->opaque);
-    uint64_t size = qemu_file_transferred_fast(f) - old_offset;
+    uint64_t size = qemu_file_transferred_noflush(f) - old_offset;
 
     if (vmdesc) {
         json_writer_int64(vmdesc, "size", size);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index af01d54b6f..31842c3afb 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -361,7 +361,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 void *curr_elem = first_elem + size * i;
 
                 vmsd_desc_field_start(vmsd, vmdesc_loop, field, i, n_elems);
-                old_offset = qemu_file_transferred_fast(f);
+                old_offset = qemu_file_transferred_noflush(f);
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     assert(curr_elem);
                     curr_elem = *(void **)curr_elem;
@@ -391,7 +391,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                     return ret;
                 }
 
-                written_bytes = qemu_file_transferred_fast(f) - old_offset;
+                written_bytes = qemu_file_transferred_noflush(f) - old_offset;
                 vmsd_desc_field_end(vmsd, vmdesc_loop, field, written_bytes, i);
 
                 /* Compressed arrays only care about the first element */
-- 
2.40.1


