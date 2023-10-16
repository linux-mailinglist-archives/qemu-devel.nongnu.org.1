Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 189037CA4CA
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:09:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKX7-00040f-Dy; Mon, 16 Oct 2023 06:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKWp-0003gF-A7
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:08:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKWm-0007ib-B0
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697450927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sAWk0rYa+2Bbpv1yRsDr5g4o4uoh25xPqzR/+0DDrj4=;
 b=UnXC9MDfokpqdhLAf1FtzMEe4c1lg1aj5Uzw8SeyXPOVLyN/Sei+xsrP94WhfbPU4XRmaU
 m4tcx4KO2on3/qZUUnzgx/5L2KQYn01xztQMEfOB14iyyew57zAA4EyGe0ptwNYzkN2nDZ
 GI3eRUnrMdSPqUzZHYnHfyNI23IySNs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-2HYY5ccbM1WcCDZE62X4nw-1; Mon, 16 Oct 2023 06:08:44 -0400
X-MC-Unique: 2HYY5ccbM1WcCDZE62X4nw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C03333C0CEF1;
 Mon, 16 Oct 2023 10:08:43 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E49B963F21;
 Mon, 16 Oct 2023 10:08:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Nikolay Borisov <nborisov@suse.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/38] migration/ram: Refactor precopy ram loading code
Date: Mon, 16 Oct 2023 12:06:59 +0200
Message-ID: <20231016100706.2551-32-quintela@redhat.com>
In-Reply-To: <20231016100706.2551-1-quintela@redhat.com>
References: <20231016100706.2551-1-quintela@redhat.com>
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

From: Nikolay Borisov <nborisov@suse.com>

Extract the ramblock parsing code into a routine that operates on the
sequence of headers from the stream and another the parses the
individual ramblock. This makes ram_load_precopy() easier to
comprehend.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231011184604.32364-3-farosas@suse.de>
---
 migration/ram.c | 146 +++++++++++++++++++++++++++---------------------
 1 file changed, 82 insertions(+), 64 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index a9bc6ae1f1..2bd51d6bb5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3884,6 +3884,85 @@ void colo_flush_ram_cache(void)
     trace_colo_flush_ram_cache_end();
 }
 
+static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
+{
+    int ret = 0;
+    /* ADVISE is earlier, it shows the source has the postcopy capability on */
+    bool postcopy_advised = migration_incoming_postcopy_advised();
+
+    assert(block);
+
+    if (!qemu_ram_is_migratable(block)) {
+        error_report("block %s should not be migrated !", block->idstr);
+        return -EINVAL;
+    }
+
+    if (length != block->used_length) {
+        Error *local_err = NULL;
+
+        ret = qemu_ram_resize(block, length, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
+    }
+    /* For postcopy we need to check hugepage sizes match */
+    if (postcopy_advised && migrate_postcopy_ram() &&
+        block->page_size != qemu_host_page_size) {
+        uint64_t remote_page_size = qemu_get_be64(f);
+        if (remote_page_size != block->page_size) {
+            error_report("Mismatched RAM page size %s "
+                         "(local) %zd != %" PRId64, block->idstr,
+                         block->page_size, remote_page_size);
+            ret = -EINVAL;
+        }
+    }
+    if (migrate_ignore_shared()) {
+        hwaddr addr = qemu_get_be64(f);
+        if (migrate_ram_is_ignored(block) &&
+            block->mr->addr != addr) {
+            error_report("Mismatched GPAs for block %s "
+                         "%" PRId64 "!= %" PRId64, block->idstr,
+                         (uint64_t)addr, (uint64_t)block->mr->addr);
+            ret = -EINVAL;
+        }
+    }
+    ret = rdma_block_notification_handle(f, block->idstr);
+    if (ret < 0) {
+        qemu_file_set_error(f, ret);
+    }
+
+    return ret;
+}
+
+static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
+{
+    int ret = 0;
+
+    /* Synchronize RAM block list */
+    while (!ret && total_ram_bytes) {
+        RAMBlock *block;
+        char id[256];
+        ram_addr_t length;
+        int len = qemu_get_byte(f);
+
+        qemu_get_buffer(f, (uint8_t *)id, len);
+        id[len] = 0;
+        length = qemu_get_be64(f);
+
+        block = qemu_ram_block_by_name(id);
+        if (block) {
+            ret = parse_ramblock(f, block, length);
+        } else {
+            error_report("Unknown ramblock \"%s\", cannot accept "
+                         "migration", id);
+            ret = -EINVAL;
+        }
+        total_ram_bytes -= length;
+    }
+
+    return ret;
+}
+
 /**
  * ram_load_precopy: load pages in precopy case
  *
@@ -3898,14 +3977,13 @@ static int ram_load_precopy(QEMUFile *f)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     int flags = 0, ret = 0, invalid_flags = 0, len = 0, i = 0;
-    /* ADVISE is earlier, it shows the source has the postcopy capability on */
-    bool postcopy_advised = migration_incoming_postcopy_advised();
+
     if (!migrate_compress()) {
         invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
     }
 
     while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
-        ram_addr_t addr, total_ram_bytes;
+        ram_addr_t addr;
         void *host = NULL, *host_bak = NULL;
         uint8_t ch;
 
@@ -3976,67 +4054,7 @@ static int ram_load_precopy(QEMUFile *f)
 
         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
         case RAM_SAVE_FLAG_MEM_SIZE:
-            /* Synchronize RAM block list */
-            total_ram_bytes = addr;
-            while (!ret && total_ram_bytes) {
-                RAMBlock *block;
-                char id[256];
-                ram_addr_t length;
-
-                len = qemu_get_byte(f);
-                qemu_get_buffer(f, (uint8_t *)id, len);
-                id[len] = 0;
-                length = qemu_get_be64(f);
-
-                block = qemu_ram_block_by_name(id);
-                if (block && !qemu_ram_is_migratable(block)) {
-                    error_report("block %s should not be migrated !", id);
-                    ret = -EINVAL;
-                } else if (block) {
-                    if (length != block->used_length) {
-                        Error *local_err = NULL;
-
-                        ret = qemu_ram_resize(block, length,
-                                              &local_err);
-                        if (local_err) {
-                            error_report_err(local_err);
-                        }
-                    }
-                    /* For postcopy we need to check hugepage sizes match */
-                    if (postcopy_advised && migrate_postcopy_ram() &&
-                        block->page_size != qemu_host_page_size) {
-                        uint64_t remote_page_size = qemu_get_be64(f);
-                        if (remote_page_size != block->page_size) {
-                            error_report("Mismatched RAM page size %s "
-                                         "(local) %zd != %" PRId64,
-                                         id, block->page_size,
-                                         remote_page_size);
-                            ret = -EINVAL;
-                        }
-                    }
-                    if (migrate_ignore_shared()) {
-                        hwaddr addr2 = qemu_get_be64(f);
-                        if (migrate_ram_is_ignored(block) &&
-                            block->mr->addr != addr2) {
-                            error_report("Mismatched GPAs for block %s "
-                                         "%" PRId64 "!= %" PRId64,
-                                         id, (uint64_t)addr2,
-                                         (uint64_t)block->mr->addr);
-                            ret = -EINVAL;
-                        }
-                    }
-                    ret = rdma_block_notification_handle(f, block->idstr);
-                    if (ret < 0) {
-                        qemu_file_set_error(f, ret);
-                    }
-                } else {
-                    error_report("Unknown ramblock \"%s\", cannot "
-                                 "accept migration", id);
-                    ret = -EINVAL;
-                }
-
-                total_ram_bytes -= length;
-            }
+            ret = parse_ramblocks(f, addr);
             break;
 
         case RAM_SAVE_FLAG_ZERO:
-- 
2.41.0


