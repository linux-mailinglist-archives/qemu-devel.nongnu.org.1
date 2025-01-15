Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 046F1A12B6D
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Jan 2025 20:04:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8dg-0007MV-T9; Wed, 15 Jan 2025 14:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dd-0007L5-1X
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8da-0005f0-Qs
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:12 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHtirT028972;
 Wed, 15 Jan 2025 19:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=NnUPRI7X7LFv4CFp32WsOflp+dn76KgkG2C4V7Q/2LE=; b=
 PoMj9+b5qHEcTGYxVn4wuwrj48a24mmtGqGkfx/mjjV+jtRB/tfZNulJhrccVPHc
 O1eoxfCULcICPngRSUxAl1GbX7YtsLU8RraE83fSkhOhIukiTRBqOrBkWr3aebZv
 IAusrVoDDPcWHoZseRvs/kWW93TXFvarg/MmGy7jzqSy1nuRyPeIpm9Q/dUTiG7H
 gYK4hV1kcr7FrxF6zGPRyUlfLZEn9dwE/u7Xkah5earKO3d14ZqBNVWszI9bGVHn
 IOeo7yVmEQOmaxFtkUBZSdFGFodSabHxoAShjrbBl3rw7go/dmxOIu4HQN8KJzRo
 zifAwQbFC3A9R6k2haK2+Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fe2gu3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:01:08 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50FHcjZi034966; Wed, 15 Jan 2025 19:01:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 443f39urb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:01:07 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50FJ0peZ016497;
 Wed, 15 Jan 2025 19:01:06 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 443f39uqwr-22; Wed, 15 Jan 2025 19:01:06 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V7 21/24] tests/qtest: enhance migration channels
Date: Wed, 15 Jan 2025 11:00:47 -0800
Message-Id: <1736967650-129648-22-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150138
X-Proofpoint-ORIG-GUID: Kr6DXmFoBjtta8o0DrV5p8hu-ciWzvha
X-Proofpoint-GUID: Kr6DXmFoBjtta8o0DrV5p8hu-ciWzvha
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Change the migrate_qmp and migrate_qmp_fail channels argument to a QObject
type so the caller can manipulate the object before passing it to the
helper.  Define migrate_str_to_channel to aid such manipulation.
Add a channels argument to migrate_incoming_qmp.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.c     | 15 +++++++---
 tests/qtest/migration/migration-qmp.c | 53 +++++++++++++++++++++++++++++------
 tests/qtest/migration/migration-qmp.h | 10 ++++---
 tests/qtest/migration/misc-tests.c    |  9 +++++-
 tests/qtest/migration/precopy-tests.c |  6 ++--
 tests/qtest/virtio-net-failover.c     |  8 +++---
 6 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 03640e4..8d34cb2 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -18,6 +18,8 @@
 #include "migration/migration-qmp.h"
 #include "migration/migration-util.h"
 #include "ppc-util.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -686,6 +688,7 @@ void test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
+    QObject *out_channels = NULL;
 
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -718,12 +721,16 @@ void test_precopy_common(MigrateCommon *args)
         }
     }
 
+    if (args->connect_channels) {
+        out_channels = qobject_from_json(args->connect_channels, &error_abort);
+    }
+
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
+        migrate_qmp_fail(from, args->connect_uri, out_channels, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
+    migrate_qmp(from, to, args->connect_uri, out_channels, "{}");
 
     if (args->start.defer_target_connect) {
         qtest_connect(to);
@@ -873,7 +880,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
      * We need to wait for the source to finish before starting the
      * destination.
      */
-    migrate_incoming_qmp(to, args->connect_uri, "{}");
+    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
     wait_for_migration_complete(to);
 
     if (stop_src) {
@@ -909,7 +916,7 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
 
     return NULL;
 }
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 71b14b5..f7a597d 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -15,9 +15,13 @@
 #include "migration-qmp.h"
 #include "migration-util.h"
 #include "qapi/error.h"
+#include "qapi/qapi-types-migration.h"
+#include "qapi/qapi-visit-migration.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qobject-output-visitor.h"
 
 /*
  * Number of seconds we wait when looking for migration
@@ -47,8 +51,33 @@ void migration_event_wait(QTestState *s, const char *target)
     } while (!found);
 }
 
+/*
+ * Convert a string representing a single channel to an object.
+ * @str may be in JSON or dotted keys format.
+ */
+QObject *migrate_str_to_channel(const char *str)
+{
+    Visitor *v;
+    MigrationChannel *channel;
+    QObject *obj;
+
+    /* Create the channel */
+    v = qobject_input_visitor_new_str(str, "channel-type", &error_abort);
+    visit_type_MigrationChannel(v, NULL, &channel, &error_abort);
+    visit_free(v);
+
+    /* Create the object */
+    v = qobject_output_visitor_new(&obj);
+    visit_type_MigrationChannel(v, NULL, &channel, &error_abort);
+    visit_complete(v, &obj);
+    visit_free(v);
+
+    qapi_free_MigrationChannel(channel);
+    return obj;
+}
+
 void migrate_qmp_fail(QTestState *who, const char *uri,
-                      const char *channels, const char *fmt, ...)
+                      QObject *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *err;
@@ -64,8 +93,7 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
 
     g_assert(!qdict_haskey(args, "channels"));
     if (channels) {
-        QObject *channels_obj = qobject_from_json(channels, &error_abort);
-        qdict_put_obj(args, "channels", channels_obj);
+        qdict_put_obj(args, "channels", channels);
     }
 
     err = qtest_qmp_assert_failure_ref(
@@ -82,7 +110,7 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
  * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
  */
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
-                 const char *channels, const char *fmt, ...)
+                 QObject *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args;
@@ -102,10 +130,9 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
 
     g_assert(!qdict_haskey(args, "channels"));
     if (channels) {
-        QObject *channels_obj = qobject_from_json(channels, &error_abort);
-        QList *channel_list = qobject_to(QList, channels_obj);
+        QList *channel_list = qobject_to(QList, channels);
         migrate_set_ports(to, channel_list);
-        qdict_put_obj(args, "channels", channels_obj);
+        qdict_put_obj(args, "channels", channels);
     }
 
     qtest_qmp_assert_success(who,
@@ -123,7 +150,8 @@ void migrate_set_capability(QTestState *who, const char *capability,
                              capability, value);
 }
 
-void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
+void migrate_incoming_qmp(QTestState *to, const char *uri, QObject *channels,
+                          const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *rsp;
@@ -133,7 +161,14 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
     va_end(ap);
 
     g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
+    if (uri) {
+        qdict_put_str(args, "uri", uri);
+    }
+
+    g_assert(!qdict_haskey(args, "channels"));
+    if (channels) {
+        qdict_put_obj(args, "channels", channels);
+    }
 
     /* This function relies on the event to work, make sure it's enabled */
     migrate_set_capability(to, "events", true);
diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index caaa787..faa8181 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -4,17 +4,19 @@
 
 #include "migration-util.h"
 
+QObject *migrate_str_to_channel(const char *str);
+
 G_GNUC_PRINTF(4, 5)
 void migrate_qmp_fail(QTestState *who, const char *uri,
-                      const char *channels, const char *fmt, ...);
+                      QObject *channels, const char *fmt, ...);
 
 G_GNUC_PRINTF(5, 6)
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
-                 const char *channels, const char *fmt, ...);
+                 QObject *channels, const char *fmt, ...);
 
-G_GNUC_PRINTF(3, 4)
+G_GNUC_PRINTF(4, 5)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
-                          const char *fmt, ...);
+                          QObject *channels, const char *fmt, ...);
 
 void migration_event_wait(QTestState *s, const char *target);
 void migrate_set_capability(QTestState *who, const char *capability,
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 6173430..dda3707 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -11,6 +11,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qjson.h"
 #include "libqtest.h"
 #include "migration/framework.h"
 #include "migration/migration-qmp.h"
@@ -205,6 +207,7 @@ static void test_validate_uuid_dst_not_set(void)
 static void do_test_validate_uri_channel(MigrateCommon *args)
 {
     QTestState *from, *to;
+    QObject *channels;
 
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -217,7 +220,11 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
      * 'uri' and 'channels' validation is checked even before the migration
      * starts.
      */
-    migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
+    channels = args->connect_channels ?
+               qobject_from_json(args->connect_channels, &error_abort) :
+               NULL;
+    migrate_qmp_fail(from, args->connect_uri, channels, "{}");
+
     migrate_end(from, to, false);
 }
 
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 23599b2..436dbd9 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -152,7 +152,7 @@ static void *migrate_hook_start_fd(QTestState *from,
     close(pair[0]);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "fd:fd-mig", "{}");
+    migrate_incoming_qmp(to, "fd:fd-mig", NULL, "{}");
 
     /* Send the 2nd socket to the target */
     qtest_qmp_fds_assert_success(from, &pair[1], 1,
@@ -479,7 +479,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
@@ -518,7 +518,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to2, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", "{}");
+    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", NULL, "{}");
 
     migrate_ensure_non_converge(from);
 
diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
index 08365ff..f04573f 100644
--- a/tests/qtest/virtio-net-failover.c
+++ b/tests/qtest/virtio-net-failover.c
@@ -773,7 +773,7 @@ static void test_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     resp = get_failover_negociated_event(qts);
     g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
@@ -895,7 +895,7 @@ static void test_off_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, true, "primary0", MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, true, "primary0", MAC_PRIMARY0);
@@ -1022,7 +1022,7 @@ static void test_guest_off_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
@@ -1747,7 +1747,7 @@ static void test_multi_in(gconstpointer opaque)
     check_one_card(qts, true, "standby1", MAC_STANDBY1);
     check_one_card(qts, false, "primary1", MAC_PRIMARY1);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     resp = get_failover_negociated_event(qts);
     g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
-- 
1.8.3.1


