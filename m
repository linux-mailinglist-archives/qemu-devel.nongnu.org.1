Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91079703E0A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 22:00:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeKQ-0007UE-NQ; Mon, 15 May 2023 15:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeK4-0007OH-SE
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeK1-0005HK-Ro
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6mze1g03PTIY1a/hojYwaKt+/bNVU2PR11sxbqIxHE0=;
 b=bKzXPy9NQeooNpzv/RxSvGIpF+HG5JTJX/aB1H8y8z9eOjtAfPap6yvoZQhQOrwklSFMwF
 0RM9Yiik7uasFaDlJhm4ISlw/bNlLxTm7YMhj7VvbsQ0jolqVQG8jvCXxLweh+qRAcL2V9
 MP9pW/kmGof+G8mAKeachkKXsowerVY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-YYay1RDZPYu710-0bbY4yQ-1; Mon, 15 May 2023 15:57:23 -0400
X-MC-Unique: YYay1RDZPYu710-0bbY4yQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13245867955;
 Mon, 15 May 2023 19:57:23 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AEF3492B00;
 Mon, 15 May 2023 19:57:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 02/16] migration: Correct transferred bytes value
Date: Mon, 15 May 2023 21:56:55 +0200
Message-Id: <20230515195709.63843-3-quintela@redhat.com>
In-Reply-To: <20230515195709.63843-1-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We forget several places to add to trasferred amount of data.  With
this fixes I get:

   qemu_file_transferred() + multifd_bytes == transferred

The only place whrer this is not true is during devices sending.  But
going all through the full tree searching for devices that use
QEMUFile directly is a bit too much.

Multifd, precopy and xbzrle work as expected. Postocpy still misses 35
bytes, but searching for them is getting complicated, so I stop here.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c       | 14 ++++++++++++++
 migration/savevm.c    | 19 +++++++++++++++++--
 migration/vmstate.c   |  3 +++
 migration/meson.build |  2 +-
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index f69d8d42b0..fd5a8db0f8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -337,6 +337,7 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
 
     g_free(le_bitmap);
 
+    stat64_add(&mig_stats.transferred, 8 + size + 8);
     if (qemu_file_get_error(file)) {
         return qemu_file_get_error(file);
     }
@@ -1392,6 +1393,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
                     return ret;
                 }
                 qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
+                stat64_add(&mig_stats.transferred, 8);
                 qemu_fflush(f);
             }
             /*
@@ -3020,6 +3022,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     RAMState **rsp = opaque;
     RAMBlock *block;
     int ret;
+    size_t size = 0;
 
     if (compress_threads_save_setup()) {
         return -1;
@@ -3038,16 +3041,20 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
         qemu_put_be64(f, ram_bytes_total_with_ignored()
                          | RAM_SAVE_FLAG_MEM_SIZE);
 
+        size += 8;
         RAMBLOCK_FOREACH_MIGRATABLE(block) {
             qemu_put_byte(f, strlen(block->idstr));
             qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
             qemu_put_be64(f, block->used_length);
+            size += 1 + strlen(block->idstr) + 8;
             if (migrate_postcopy_ram() && block->page_size !=
                                           qemu_host_page_size) {
                 qemu_put_be64(f, block->page_size);
+                size += 8;
             }
             if (migrate_ignore_shared()) {
                 qemu_put_be64(f, block->mr->addr);
+                size += 8;
             }
         }
     }
@@ -3064,11 +3071,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 
     if (!migrate_multifd_flush_after_each_section()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
+        size += 8;
     }
 
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
+    size += 8;
     qemu_fflush(f);
 
+    stat64_add(&mig_stats.transferred, size);
     return 0;
 }
 
@@ -3209,6 +3219,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     RAMState **temp = opaque;
     RAMState *rs = *temp;
     int ret = 0;
+    size_t size = 0;
 
     rs->last_stage = !migration_in_colo_state();
 
@@ -3253,8 +3264,11 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
     if (!migrate_multifd_flush_after_each_section()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
+        size += 8;
     }
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
+    size += 8;
+    stat64_add(&mig_stats.transferred, size);
     qemu_fflush(f);
 
     return 0;
diff --git a/migration/savevm.c b/migration/savevm.c
index e33788343a..c7af9050c2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -952,6 +952,7 @@ static void save_section_header(QEMUFile *f, SaveStateEntry *se,
     qemu_put_byte(f, section_type);
     qemu_put_be32(f, se->section_id);
 
+    size_t size = 1 + 4;
     if (section_type == QEMU_VM_SECTION_FULL ||
         section_type == QEMU_VM_SECTION_START) {
         /* ID string */
@@ -961,7 +962,9 @@ static void save_section_header(QEMUFile *f, SaveStateEntry *se,
 
         qemu_put_be32(f, se->instance_id);
         qemu_put_be32(f, se->version_id);
+        size += 1 + len + 4 + 4;
     }
+    stat64_add(&mig_stats.transferred, size);
 }
 
 /*
@@ -973,6 +976,7 @@ static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
     if (migrate_get_current()->send_section_footer) {
         qemu_put_byte(f, QEMU_VM_SECTION_FOOTER);
         qemu_put_be32(f, se->section_id);
+        stat64_add(&mig_stats.transferred, 1 + 4);
     }
 }
 
@@ -1032,6 +1036,7 @@ static void qemu_savevm_command_send(QEMUFile *f,
     qemu_put_be16(f, (uint16_t)command);
     qemu_put_be16(f, len);
     qemu_put_buffer(f, data, len);
+    stat64_add(&mig_stats.transferred, 1 + 2 + 2 + len);
     qemu_fflush(f);
 }
 
@@ -1212,11 +1217,13 @@ void qemu_savevm_state_header(QEMUFile *f)
     trace_savevm_state_header();
     qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
     qemu_put_be32(f, QEMU_VM_FILE_VERSION);
-
+    size_t size = 4 + 4;
     if (migrate_get_current()->send_configuration) {
         qemu_put_byte(f, QEMU_VM_CONFIGURATION);
+        size += 1;
         vmstate_save_state(f, &vmstate_configuration, &savevm_state, 0);
     }
+    stat64_add(&mig_stats.transferred, size);
 }
 
 bool qemu_savevm_state_guest_unplug_pending(void)
@@ -1384,6 +1391,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
 {
     SaveStateEntry *se;
     int ret;
+    size_t size = 0;
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops || !se->ops->save_live_complete_postcopy) {
@@ -1398,7 +1406,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
         /* Section type */
         qemu_put_byte(f, QEMU_VM_SECTION_END);
         qemu_put_be32(f, se->section_id);
-
+        size += 1 + 4;
         ret = se->ops->save_live_complete_postcopy(f, se->opaque);
         trace_savevm_section_end(se->idstr, se->section_id, ret);
         save_section_footer(f, se);
@@ -1409,6 +1417,8 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     }
 
     qemu_put_byte(f, QEMU_VM_EOF);
+    size += 1;
+    stat64_add(&mig_stats.transferred, size);
     qemu_fflush(f);
 }
 
@@ -1484,6 +1494,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     if (!in_postcopy) {
         /* Postcopy stream will still be going */
         qemu_put_byte(f, QEMU_VM_EOF);
+        stat64_add(&mig_stats.transferred, 1);
     }
 
     json_writer_end_array(vmdesc);
@@ -1664,15 +1675,18 @@ void qemu_savevm_live_state(QEMUFile *f)
     /* save QEMU_VM_SECTION_END section */
     qemu_savevm_state_complete_precopy(f, true, false);
     qemu_put_byte(f, QEMU_VM_EOF);
+    stat64_add(&mig_stats.transferred, 1);
 }
 
 int qemu_save_device_state(QEMUFile *f)
 {
     SaveStateEntry *se;
+    size_t size = 0;
 
     if (!migration_in_colo_state()) {
         qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
         qemu_put_be32(f, QEMU_VM_FILE_VERSION);
+        size = 4 + 4;
     }
     cpu_synchronize_all_states();
 
@@ -1690,6 +1704,7 @@ int qemu_save_device_state(QEMUFile *f)
 
     qemu_put_byte(f, QEMU_VM_EOF);
 
+    stat64_add(&mig_stats.transferred, size + 1);
     return qemu_file_get_error(f);
 }
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index af01d54b6f..ee3b70a6a8 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "migration.h"
+#include "migration-stats.h"
 #include "migration/vmstate.h"
 #include "savevm.h"
 #include "qapi/qmp/json-writer.h"
@@ -394,6 +395,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 written_bytes = qemu_file_transferred_fast(f) - old_offset;
                 vmsd_desc_field_end(vmsd, vmdesc_loop, field, written_bytes, i);
 
+                stat64_add(&mig_stats.transferred, written_bytes);
                 /* Compressed arrays only care about the first element */
                 if (vmdesc_loop && vmsd_can_compress(field)) {
                     vmdesc_loop = NULL;
@@ -517,6 +519,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
             qemu_put_byte(f, len);
             qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
             qemu_put_be32(f, vmsdsub->version_id);
+            stat64_add(&mig_stats.transferred, 1 + 1 + len + 4);
             ret = vmstate_save_state(f, vmsdsub, opaque, vmdesc);
             if (ret) {
                 return ret;
diff --git a/migration/meson.build b/migration/meson.build
index dc8b1daef5..b3d0c537c8 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -1,5 +1,6 @@
 # Files needed by unit tests
 migration_files = files(
+  'migration-stats.c',
   'page_cache.c',
   'xbzrle.c',
   'vmstate-types.c',
@@ -18,7 +19,6 @@ softmmu_ss.add(files(
   'fd.c',
   'global_state.c',
   'migration-hmp-cmds.c',
-  'migration-stats.c',
   'migration.c',
   'multifd.c',
   'multifd-zlib.c',
-- 
2.40.1


