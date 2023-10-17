Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C077CBD87
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:32:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfUH-00062j-Je; Tue, 17 Oct 2023 04:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTz-0005Or-UA
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTy-0005Oo-8g
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fqGJ5eA/FDCS8egTIlvGQPYkcpGd7ZaGCeVhTaDonkg=;
 b=FQCdleGdjonkTbmB++/KvujAzDwjsiz3/l7nCjRFJ09X9r3WBjGalQYIK1kPMpnkZDBxvn
 9AOsnvK0FT7GzlSLcoWX1s2Ws34EbnmKuRcJtYNGV4AEJsVOtmS0VP6TYKQanOtk1xa6R+
 rXEeDgK8Hf+4NCnSqnHWcTSsiZdvE1k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-8mTERHmkMY-tXc40BbgkXQ-1; Tue, 17 Oct 2023 04:30:59 -0400
X-MC-Unique: 8mTERHmkMY-tXc40BbgkXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 043D91C2B667;
 Tue, 17 Oct 2023 08:30:59 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D9E21C060AE;
 Tue, 17 Oct 2023 08:30:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 17/38] migration/rdma: Remove all uses of RAM_CONTROL_HOOK
Date: Tue, 17 Oct 2023 10:29:42 +0200
Message-ID: <20231017083003.15951-18-quintela@redhat.com>
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Instead of going through ram_control_load_hook(), call
qemu_rdma_registration_handle() directly.

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231011203527.9061-5-quintela@redhat.com>
---
 migration/qemu-file.h |  1 -
 migration/rdma.h      |  3 +++
 migration/ram.c       |  5 ++++-
 migration/rdma.c      | 12 +++++++-----
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 35e671a01e..14ff0d9cc4 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -41,7 +41,6 @@ typedef int (QEMURamHookFunc)(QEMUFile *f, uint64_t flags, void *data);
  */
 #define RAM_CONTROL_SETUP     0
 #define RAM_CONTROL_ROUND     1
-#define RAM_CONTROL_HOOK      2
 #define RAM_CONTROL_FINISH    3
 #define RAM_CONTROL_BLOCK_REG 4
 
diff --git a/migration/rdma.h b/migration/rdma.h
index c13b94c782..8bd277efb9 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -24,10 +24,13 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp);
 
 
 #ifdef CONFIG_RDMA
+int qemu_rdma_registration_handle(QEMUFile *f);
 int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags);
 int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags);
 #else
 static inline
+int qemu_rdma_registration_handle(QEMUFile *f) { return 0; }
+static inline
 int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags) { return 0; }
 static inline
 int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags) { return 0; }
diff --git a/migration/ram.c b/migration/ram.c
index f1ddc1f9fa..f6ea1831b5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4075,7 +4075,10 @@ static int ram_load_precopy(QEMUFile *f)
             }
             break;
         case RAM_SAVE_FLAG_HOOK:
-            ram_control_load_hook(f, RAM_CONTROL_HOOK, NULL);
+            ret = qemu_rdma_registration_handle(f);
+            if (ret < 0) {
+                qemu_file_set_error(f, ret);
+            }
             break;
         default:
             error_report("Unknown combination of migration flags: 0x%x", flags);
diff --git a/migration/rdma.c b/migration/rdma.c
index 4b32d375ec..5c20f425a9 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3522,7 +3522,7 @@ static int dest_ram_sort_func(const void *a, const void *b)
  *
  * Keep doing this until the source tells us to stop.
  */
-static int qemu_rdma_registration_handle(QEMUFile *f)
+int qemu_rdma_registration_handle(QEMUFile *f)
 {
     RDMAControlHeader reg_resp = { .len = sizeof(RDMARegisterResult),
                                .type = RDMA_CONTROL_REGISTER_RESULT,
@@ -3534,7 +3534,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                              };
     RDMAControlHeader blocks = { .type = RDMA_CONTROL_RAM_BLOCKS_RESULT,
                                  .repeat = 1 };
-    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
+    QIOChannelRDMA *rioc;
     Error *err = NULL;
     RDMAContext *rdma;
     RDMALocalBlocks *local;
@@ -3550,7 +3550,12 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
     int count = 0;
     int i = 0;
 
+    if (!migrate_rdma()) {
+        return 0;
+    }
+
     RCU_READ_LOCK_GUARD();
+    rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
     rdma = qatomic_rcu_read(&rioc->rdmain);
 
     if (!rdma) {
@@ -3841,9 +3846,6 @@ static int rdma_load_hook(QEMUFile *f, uint64_t flags, void *data)
     case RAM_CONTROL_BLOCK_REG:
         return rdma_block_notification_handle(f, data);
 
-    case RAM_CONTROL_HOOK:
-        return qemu_rdma_registration_handle(f);
-
     default:
         /* Shouldn't be called with any other values */
         abort();
-- 
2.41.0


