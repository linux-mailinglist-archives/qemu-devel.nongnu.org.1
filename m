Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFF57443F0
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 23:31:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFLgP-0005l2-2P; Fri, 30 Jun 2023 17:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qFLgG-0005jq-BP
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 17:29:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qFLgC-0002h1-UZ
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 17:29:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C6D71F8D7;
 Fri, 30 Jun 2023 21:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688160555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+RsoWuHommMSNCwHNUf3izCqnbd3jCKKkfVvm4dvNJo=;
 b=wP0k9Py+Lhqn6F8CrdzdgvvS5cUHq3IDBHxoKG7PrmSRO6aHNi11JEAGvRZwixwlenAcYn
 xtxo86yq2aLxPibwT93fNB8XlDhGfWnJD6D3WYxmK4LNfTxd9LjtsoO610MziFfGqMHS0k
 t+wRFPR5bzryJQjZRuk9dGZ9zJi41d0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688160555;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+RsoWuHommMSNCwHNUf3izCqnbd3jCKKkfVvm4dvNJo=;
 b=TggysuR4JCJCRwAzEAnjXc3b78WXkWMlxgJnjHzIGPe707VKbHdUg+zVqC9ySsFGKISRLq
 S6VHiX84uE+ZzhCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2594713915;
 Fri, 30 Jun 2023 21:29:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IIsIOChJn2TRKAAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 30 Jun 2023 21:29:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v3 3/6] tests/qtest: migration: Use migrate_incoming_qmp where
 appropriate
Date: Fri, 30 Jun 2023 18:28:59 -0300
Message-Id: <20230630212902.19925-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230630212902.19925-1-farosas@suse.de>
References: <20230630212902.19925-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Use the new migrate_incoming_qmp helper in the places that currently
open-code calling migrate-incoming.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/meson.build           |  1 +
 tests/qtest/migration-test.c      | 12 ++---
 tests/qtest/virtio-net-failover.c | 77 ++++---------------------------
 3 files changed, 14 insertions(+), 76 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 74630f6672..292d7d713f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -313,6 +313,7 @@ qtests = {
   'tpm-tis-i2c-test': [io, tpmemu_files, 'qtest_aspeed.c'],
   'tpm-tis-device-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
+  'virtio-net-failover': files('migration-helpers.c'),
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
 }
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index df17bf431f..c4140ac3f1 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1846,8 +1846,7 @@ static void *test_migrate_fd_start_hook(QTestState *from,
     close(pair[0]);
 
     /* Start incoming migration from the 1st socket */
-    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'fd:fd-mig' }}");
+    migrate_incoming_qmp(to, "fd:fd-mig", "{}");
 
     /* Send the 2nd socket to the target */
     qtest_qmp_fds_assert_success(from, &pair[1], 1,
@@ -2069,8 +2068,7 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
 
     return NULL;
 }
@@ -2322,8 +2320,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
@@ -2353,8 +2350,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to2, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    qtest_qmp_assert_success(to2, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
+    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", "{}");
 
     g_free(uri);
     uri = migrate_get_socket_address(to2, "socket-address");
diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
index 4a809590bf..0d40bc1f2d 100644
--- a/tests/qtest/virtio-net-failover.c
+++ b/tests/qtest/virtio-net-failover.c
@@ -11,6 +11,7 @@
 #include "libqtest.h"
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
+#include "migration-helpers.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qjson.h"
@@ -736,26 +737,10 @@ static void test_migrate_out(gconstpointer opaque)
     machine_stop(qts);
 }
 
-static QDict *get_migration_event(QTestState *qts)
-{
-    QDict *resp;
-    QDict *data;
-
-    resp = qtest_qmp_eventwait_ref(qts, "MIGRATION");
-    g_assert(qdict_haskey(resp, "data"));
-
-    data = qdict_get_qdict(resp, "data");
-    g_assert(qdict_haskey(data, "status"));
-    qobject_ref(data);
-    qobject_unref(resp);
-
-    return data;
-}
-
 static void test_migrate_in(gconstpointer opaque)
 {
     QTestState *qts;
-    QDict *resp, *args, *ret;
+    QDict *resp, *ret;
     g_autofree gchar *uri = g_strdup_printf("exec: cat %s", (gchar *)opaque);
 
     qts = machine_start(BASE_MACHINE
@@ -787,18 +772,7 @@ static void test_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
 
-    args = qdict_from_jsonf_nofail("{}");
-    g_assert_nonnull(args);
-    qdict_put_str(args, "uri", uri);
-
-    resp = qtest_qmp(qts, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
-                     args);
-    g_assert(qdict_haskey(resp, "return"));
-    qobject_unref(resp);
-
-    resp = get_migration_event(qts);
-    g_assert_cmpstr(qdict_get_str(resp, "status"), ==, "setup");
-    qobject_unref(resp);
+    migrate_incoming_qmp(qts, uri, "{}");
 
     resp = get_failover_negociated_event(qts);
     g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
@@ -888,7 +862,7 @@ static void test_off_migrate_out(gconstpointer opaque)
 static void test_off_migrate_in(gconstpointer opaque)
 {
     QTestState *qts;
-    QDict *resp, *args, *ret;
+    QDict *ret;
     g_autofree gchar *uri = g_strdup_printf("exec: cat %s", (gchar *)opaque);
 
     qts = machine_start(BASE_MACHINE
@@ -920,18 +894,7 @@ static void test_off_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, true, "primary0", MAC_PRIMARY0);
 
-    args = qdict_from_jsonf_nofail("{}");
-    g_assert_nonnull(args);
-    qdict_put_str(args, "uri", uri);
-
-    resp = qtest_qmp(qts, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
-                     args);
-    g_assert(qdict_haskey(resp, "return"));
-    qobject_unref(resp);
-
-    resp = get_migration_event(qts);
-    g_assert_cmpstr(qdict_get_str(resp, "status"), ==, "setup");
-    qobject_unref(resp);
+    migrate_incoming_qmp(qts, uri, "{}");
 
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, true, "primary0", MAC_PRIMARY0);
@@ -1026,7 +989,7 @@ static void test_guest_off_migrate_out(gconstpointer opaque)
 static void test_guest_off_migrate_in(gconstpointer opaque)
 {
     QTestState *qts;
-    QDict *resp, *args, *ret;
+    QDict *ret;
     g_autofree gchar *uri = g_strdup_printf("exec: cat %s", (gchar *)opaque);
 
     qts = machine_start(BASE_MACHINE
@@ -1058,18 +1021,7 @@ static void test_guest_off_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
 
-    args = qdict_from_jsonf_nofail("{}");
-    g_assert_nonnull(args);
-    qdict_put_str(args, "uri", uri);
-
-    resp = qtest_qmp(qts, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
-                     args);
-    g_assert(qdict_haskey(resp, "return"));
-    qobject_unref(resp);
-
-    resp = get_migration_event(qts);
-    g_assert_cmpstr(qdict_get_str(resp, "status"), ==, "setup");
-    qobject_unref(resp);
+    migrate_incoming_qmp(qts, uri, "{}");
 
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
@@ -1728,7 +1680,7 @@ static void test_multi_out(gconstpointer opaque)
 static void test_multi_in(gconstpointer opaque)
 {
     QTestState *qts;
-    QDict *resp, *args, *ret;
+    QDict *resp, *ret;
     g_autofree gchar *uri = g_strdup_printf("exec: cat %s", (gchar *)opaque);
 
     qts = machine_start(BASE_MACHINE
@@ -1794,18 +1746,7 @@ static void test_multi_in(gconstpointer opaque)
     check_one_card(qts, true, "standby1", MAC_STANDBY1);
     check_one_card(qts, false, "primary1", MAC_PRIMARY1);
 
-    args = qdict_from_jsonf_nofail("{}");
-    g_assert_nonnull(args);
-    qdict_put_str(args, "uri", uri);
-
-    resp = qtest_qmp(qts, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
-                     args);
-    g_assert(qdict_haskey(resp, "return"));
-    qobject_unref(resp);
-
-    resp = get_migration_event(qts);
-    g_assert_cmpstr(qdict_get_str(resp, "status"), ==, "setup");
-    qobject_unref(resp);
+    migrate_incoming_qmp(qts, uri, "{}");
 
     resp = get_failover_negociated_event(qts);
     g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
-- 
2.35.3


