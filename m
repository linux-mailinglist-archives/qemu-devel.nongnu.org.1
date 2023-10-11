Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 870757C4EF3
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:30:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVQ8-00078v-Ch; Wed, 11 Oct 2023 05:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQ5-00078P-Mg
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQ3-0004pU-SD
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oa37+X1ZWcwUdlF5vcBJGDkp14L17iIn5zb4STBMd/0=;
 b=S9SjHs3MxJ0Jjfmbb8dxjHwvmm1saSf0ttfZtnKmBvASLx8MiV8oYHK9GqKU4MjFVGku4Z
 QVKeBq7Cy2iftwU1rRZy4yCuP7S8l7EY8Lw4779wMOZVWHlb2OBKRvcH3cWNyHTD+gnNkD
 TRvCkWtS0hUVPFTwYHxVbfTRL4pOQFQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-xQYjDnMUN3CeyLKjEVgArA-1; Wed, 11 Oct 2023 05:22:15 -0400
X-MC-Unique: xQYjDnMUN3CeyLKjEVgArA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B84E4811E7D;
 Wed, 11 Oct 2023 09:22:14 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCF711C060AE;
 Wed, 11 Oct 2023 09:22:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 04/65] tests/qtest: migration: Use migrate_incoming_qmp where
 appropriate
Date: Wed, 11 Oct 2023 11:21:02 +0200
Message-ID: <20231011092203.1266-5-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
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

From: Fabiano Rosas <farosas@suse.de>

Use the new migrate_incoming_qmp helper in the places that currently
open-code calling migrate-incoming.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230712190742.22294-4-farosas@suse.de>
---
 tests/qtest/migration-test.c      | 12 ++---
 tests/qtest/virtio-net-failover.c | 77 ++++---------------------------
 tests/qtest/meson.build           |  1 +
 3 files changed, 14 insertions(+), 76 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 48778565a3..84660b3e3d 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1970,8 +1970,7 @@ static void *test_migrate_fd_start_hook(QTestState *from,
     close(pair[0]);
 
     /* Start incoming migration from the 1st socket */
-    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'fd:fd-mig' }}");
+    migrate_incoming_qmp(to, "fd:fd-mig", "{}");
 
     /* Send the 2nd socket to the target */
     qtest_qmp_fds_assert_success(from, &pair[1], 1,
@@ -2193,8 +2192,7 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
 
     return NULL;
 }
@@ -2447,8 +2445,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
@@ -2478,8 +2475,7 @@ static void test_multifd_tcp_cancel(void)
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
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 1fba07f4ed..66795cfcd2 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -317,6 +317,7 @@ qtests = {
   'tpm-tis-i2c-test': [io, tpmemu_files, 'qtest_aspeed.c'],
   'tpm-tis-device-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
+  'virtio-net-failover': files('migration-helpers.c'),
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
 }
-- 
2.41.0


