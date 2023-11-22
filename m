Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC647F3ED9
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 08:26:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5hbm-0002rJ-3Q; Wed, 22 Nov 2023 02:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5hbj-0002r4-3t
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:25:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5hbd-0000pO-1I
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700637901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mrugsTZqCq/1bk2RXJxeMf82BcconNlsB2uCisKzpLk=;
 b=ME2PB2P+hnM0NwhYlF5+F5lGEZRA2m842QjOkcAjARnvW3ygQKInqJI6G2430KiqXskXM8
 EjeRE7cFmdKiyCNt0Kzp0ypVWKF0jYKtn3nN852WhvQoYOM9uFIKF/Xzw5IHh0jjJkKFfy
 ipo85DB85jiNEEh1ycTh2MdV56dmx0Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-lLw2w9tOP8iO97PYhGOQZQ-1; Wed, 22 Nov 2023 02:24:58 -0500
X-MC-Unique: lLw2w9tOP8iO97PYhGOQZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBDD58007B3;
 Wed, 22 Nov 2023 07:24:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F9282026D66;
 Wed, 22 Nov 2023 07:24:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A3D121E6A23; Wed, 22 Nov 2023 08:24:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com
Subject: [PATCH 3/3] tests/unit/test-qmp-event: Replace fixture by global
 variables
Date: Wed, 22 Nov 2023 08:24:56 +0100
Message-ID: <20231122072456.2518816-4-armbru@redhat.com>
In-Reply-To: <20231122072456.2518816-1-armbru@redhat.com>
References: <20231122072456.2518816-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The fixture buys us exactly nothing, as we need a global variable
anyway, for test_qapi_event_emit().  Drop it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/unit/test-qmp-event.c | 91 ++++++++++++-------------------------
 1 file changed, 30 insertions(+), 61 deletions(-)

diff --git a/tests/unit/test-qmp-event.c b/tests/unit/test-qmp-event.c
index 5c9837e849..08e95a382b 100644
--- a/tests/unit/test-qmp-event.c
+++ b/tests/unit/test-qmp-event.c
@@ -24,18 +24,14 @@
 #include "test-qapi-events.h"
 #include "test-qapi-emit-events.h"
 
-typedef struct TestEventData {
-    QDict *expect;
-} TestEventData;
-
-TestEventData *test_event_data;
+static QDict *expected_event;
 
 void test_qapi_event_emit(test_QAPIEvent event, QDict *d)
 {
     QDict *t;
     int64_t s, ms;
 
-    g_assert(test_event_data->expect);
+    g_assert(expected_event);
 
     /* Verify that we have timestamp, then remove it to compare other fields */
     t = qdict_get_qdict(d, "timestamp");
@@ -52,65 +48,38 @@ void test_qapi_event_emit(test_QAPIEvent event, QDict *d)
 
     qdict_del(d, "timestamp");
 
-    g_assert(qobject_is_equal(QOBJECT(d), QOBJECT(test_event_data->expect)));
-    qobject_unref(test_event_data->expect);
-    test_event_data->expect = NULL;
+    g_assert(qobject_is_equal(QOBJECT(d), QOBJECT(expected_event)));
+    qobject_unref(expected_event);
+    expected_event = NULL;
 }
 
-static void event_prepare(TestEventData *data,
-                          const void *unused)
+static void test_event_a(void)
 {
-    test_event_data = data;
-}
-
-static void event_teardown(TestEventData *data,
-                           const void *unused)
-{
-    test_event_data = NULL;
-}
-
-static void event_test_add(const char *testpath,
-                           void (*test_func)(TestEventData *data,
-                                             const void *user_data))
-{
-    g_test_add(testpath, TestEventData, NULL, event_prepare, test_func,
-               event_teardown);
-}
-
-
-/* Test cases */
-
-static void test_event_a(TestEventData *data,
-                         const void *unused)
-{
-    data->expect = qdict_from_jsonf_nofail("{ 'event': 'EVENT_A' }");
+    expected_event = qdict_from_jsonf_nofail("{ 'event': 'EVENT_A' }");
     qapi_event_send_event_a();
-    g_assert(!data->expect);
+    g_assert(!expected_event);
 }
 
-static void test_event_b(TestEventData *data,
-                         const void *unused)
+static void test_event_b(void)
 {
-    data->expect = qdict_from_jsonf_nofail("{ 'event': 'EVENT_B' }");
+    expected_event = qdict_from_jsonf_nofail("{ 'event': 'EVENT_B' }");
     qapi_event_send_event_b();
-    g_assert(!data->expect);
+    g_assert(!expected_event);
 }
 
-static void test_event_c(TestEventData *data,
-                         const void *unused)
+static void test_event_c(void)
 {
     UserDefOne b = { .integer = 2, .string = (char *)"test1" };
 
-    data->expect = qdict_from_jsonf_nofail(
+    expected_event = qdict_from_jsonf_nofail(
         "{ 'event': 'EVENT_C', 'data': {"
         " 'a': 1, 'b': { 'integer': 2, 'string': 'test1' }, 'c': 'test2' } }");
     qapi_event_send_event_c(true, 1, &b, "test2");
-    g_assert(!data->expect);
+    g_assert(!expected_event);
 }
 
 /* Complex type */
-static void test_event_d(TestEventData *data,
-                         const void *unused)
+static void test_event_d(void)
 {
     UserDefOne struct1 = {
         .integer = 2, .string = (char *)"test1",
@@ -123,43 +92,43 @@ static void test_event_d(TestEventData *data,
         .enum2 = ENUM_ONE_VALUE2,
     };
 
-    data->expect = qdict_from_jsonf_nofail(
+    expected_event = qdict_from_jsonf_nofail(
         "{ 'event': 'EVENT_D', 'data': {"
         " 'a': {"
         "  'struct1': { 'integer': 2, 'string': 'test1', 'enum1': 'value1' },"
         "  'string': 'test2', 'enum2': 'value2' },"
         " 'b': 'test3', 'enum3': 'value3' } }");
     qapi_event_send_event_d(&a, "test3", NULL, true, ENUM_ONE_VALUE3);
-    g_assert(!data->expect);
+    g_assert(!expected_event);
 }
 
-static void test_event_deprecated(TestEventData *data, const void *unused)
+static void test_event_deprecated(void)
 {
-    data->expect = qdict_from_jsonf_nofail("{ 'event': 'TEST_EVENT_FEATURES1' }");
+    expected_event = qdict_from_jsonf_nofail("{ 'event': 'TEST_EVENT_FEATURES1' }");
 
     memset(&compat_policy, 0, sizeof(compat_policy));
 
     qapi_event_send_test_event_features1();
-    g_assert(!data->expect);
+    g_assert(!expected_event);
 
     compat_policy.has_deprecated_output = true;
     compat_policy.deprecated_output = COMPAT_POLICY_OUTPUT_HIDE;
     qapi_event_send_test_event_features1();
 }
 
-static void test_event_deprecated_data(TestEventData *data, const void *unused)
+static void test_event_deprecated_data(void)
 {
     memset(&compat_policy, 0, sizeof(compat_policy));
 
-    data->expect = qdict_from_jsonf_nofail("{ 'event': 'TEST_EVENT_FEATURES0',"
+    expected_event = qdict_from_jsonf_nofail("{ 'event': 'TEST_EVENT_FEATURES0',"
                                            " 'data': { 'foo': 42 } }");
     qapi_event_send_test_event_features0(42);
-    g_assert(!data->expect);
+    g_assert(!expected_event);
 
 
     compat_policy.has_deprecated_output = true;
     compat_policy.deprecated_output = COMPAT_POLICY_OUTPUT_HIDE;
-    data->expect = qdict_from_jsonf_nofail("{ 'event': 'TEST_EVENT_FEATURES0' }");
+    expected_event = qdict_from_jsonf_nofail("{ 'event': 'TEST_EVENT_FEATURES0' }");
     qapi_event_send_test_event_features0(42);
 }
 
@@ -167,12 +136,12 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
-    event_test_add("/event/event_a", test_event_a);
-    event_test_add("/event/event_b", test_event_b);
-    event_test_add("/event/event_c", test_event_c);
-    event_test_add("/event/event_d", test_event_d);
-    event_test_add("/event/deprecated", test_event_deprecated);
-    event_test_add("/event/deprecated_data", test_event_deprecated_data);
+    g_test_add_func("/event/event_a", test_event_a);
+    g_test_add_func("/event/event_b", test_event_b);
+    g_test_add_func("/event/event_c", test_event_c);
+    g_test_add_func("/event/event_d", test_event_d);
+    g_test_add_func("/event/deprecated", test_event_deprecated);
+    g_test_add_func("/event/deprecated_data", test_event_deprecated_data);
     g_test_run();
 
     return 0;
-- 
2.41.0


