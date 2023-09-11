Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1C779AA86
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 19:15:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfkTt-0002pC-NP; Mon, 11 Sep 2023 13:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfkTs-0002p3-Fj
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:13:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfkTp-0000CY-Oc
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:13:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AD41D1F8B3;
 Mon, 11 Sep 2023 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694452424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+yRV2zV71YcJVy41VS6eqUMCMiCNBCaZK6ydOiBfpk=;
 b=vW447TdZJdezib8NsP+DDCGMSnL57heOcKo0NgcJl7XlnNhVcfSF2/r0/NdZ+bsTb+VLsa
 C65V4dJYqrGAYullL5xlxerbe721ILbyA83kOuu5fFupqT8Cmw20MSX0lFNMBpf6PeIUjL
 9Peej9JLbRQKsz/kqVSXwr3Rh7JGR6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694452424;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+yRV2zV71YcJVy41VS6eqUMCMiCNBCaZK6ydOiBfpk=;
 b=FrjhfSCoq17DAHWhQ+BXdUD2BK3VYBvetg66RZlQYpOAR0jWuXfbSVMs6T2VB/5RJ02mbN
 RqMdc81HqrDnXXBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2A4E139CC;
 Mon, 11 Sep 2023 17:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aODeI8ZK/2QyIAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 11 Sep 2023 17:13:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v6 09/10] migration/yank: Keep track of registered yank
 instances
Date: Mon, 11 Sep 2023 14:13:19 -0300
Message-Id: <20230911171320.24372-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230911171320.24372-1-farosas@suse.de>
References: <20230911171320.24372-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The core yank code is strict about balanced registering and
unregistering of yank functions.

This creates a difficulty because the migration code registers one
yank function per QIOChannel, but each QIOChannel can be referenced by
more than one QEMUFile. The yank function should not be removed until
all QEMUFiles have been closed.

Keep a reference count of how many QEMUFiles are using a QIOChannel
that has a yank function. Only unregister the yank function when all
QEMUFiles have been closed.

This improves the current code by removing the need for the programmer
to know which QEMUFile is the last one to be cleaned up and fixes the
theoretical issue of removing the yank function while another QEMUFile
could still be using the ioc and require a yank.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/yank_functions.c | 81 ++++++++++++++++++++++++++++++++++----
 migration/yank_functions.h |  8 ++++
 2 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/migration/yank_functions.c b/migration/yank_functions.c
index 979e60c762..afdeef30ff 100644
--- a/migration/yank_functions.c
+++ b/migration/yank_functions.c
@@ -10,9 +10,32 @@
 #include "qemu/osdep.h"
 #include "io/channel.h"
 #include "yank_functions.h"
+#include "qemu/lockable.h"
 #include "qemu/yank.h"
 #include "qemu-file.h"
 
+static QemuMutex ioc_list_lock;
+static QLIST_HEAD(, Yankable) yankable_ioc_list
+    = QLIST_HEAD_INITIALIZER(yankable_ioc_list);
+
+static void __attribute__((constructor)) ioc_list_lock_init(void)
+{
+    qemu_mutex_init(&ioc_list_lock);
+}
+
+static void yankable_ref(Yankable *yankable)
+{
+    assert(yankable->refcnt > 0);
+    yankable->refcnt++;
+    assert(yankable->refcnt < INT_MAX);
+}
+
+static void yankable_unref(Yankable *yankable)
+{
+    assert(yankable->refcnt > 0);
+    yankable->refcnt--;
+}
+
 void migration_yank_iochannel(void *opaque)
 {
     QIOChannel *ioc = QIO_CHANNEL(opaque);
@@ -28,20 +51,62 @@ static bool migration_ioc_yank_supported(QIOChannel *ioc)
 
 void migration_ioc_register_yank(QIOChannel *ioc)
 {
-    if (migration_ioc_yank_supported(ioc)) {
-        yank_register_function(MIGRATION_YANK_INSTANCE,
-                               migration_yank_iochannel,
-                               ioc);
+    Yankable *new, *entry;
+
+    if (!ioc || !migration_ioc_yank_supported(ioc)) {
+        return;
     }
+
+    WITH_QEMU_LOCK_GUARD(&ioc_list_lock) {
+        QLIST_FOREACH(entry, &yankable_ioc_list, next) {
+            if (entry->opaque == ioc) {
+                yankable_ref(entry);
+                return;
+            }
+        }
+
+        new = g_new0(Yankable, 1);
+        new->refcnt = 1;
+        new->opaque = ioc;
+        object_ref(ioc);
+
+        QLIST_INSERT_HEAD(&yankable_ioc_list, new, next);
+    }
+
+    yank_register_function(MIGRATION_YANK_INSTANCE,
+                           migration_yank_iochannel,
+                           ioc);
 }
 
 void migration_ioc_unregister_yank(QIOChannel *ioc)
 {
-    if (migration_ioc_yank_supported(ioc)) {
-        yank_unregister_function(MIGRATION_YANK_INSTANCE,
-                                 migration_yank_iochannel,
-                                 ioc);
+    Yankable *entry, *tmp;
+
+    if (!ioc || !migration_ioc_yank_supported(ioc)) {
+        return;
     }
+
+    WITH_QEMU_LOCK_GUARD(&ioc_list_lock) {
+        QLIST_FOREACH_SAFE(entry, &yankable_ioc_list, next, tmp) {
+            if (entry->opaque == ioc) {
+                yankable_unref(entry);
+
+                if (!entry->refcnt) {
+                    QLIST_REMOVE(entry, next);
+                    g_free(entry);
+                    goto unreg;
+                }
+            }
+        }
+    }
+
+    return;
+
+unreg:
+    yank_unregister_function(MIGRATION_YANK_INSTANCE,
+                             migration_yank_iochannel,
+                             ioc);
+    object_unref(ioc);
 }
 
 void migration_ioc_unregister_yank_from_file(QEMUFile *file)
diff --git a/migration/yank_functions.h b/migration/yank_functions.h
index a7577955ed..c928a46f68 100644
--- a/migration/yank_functions.h
+++ b/migration/yank_functions.h
@@ -7,6 +7,14 @@
  * See the COPYING file in the top-level directory.
  */
 
+struct Yankable {
+    void *opaque;
+    int refcnt;
+    QLIST_ENTRY(Yankable) next;
+};
+
+typedef struct Yankable Yankable;
+
 /**
  * migration_yank_iochannel: yank function for iochannel
  *
-- 
2.35.3


