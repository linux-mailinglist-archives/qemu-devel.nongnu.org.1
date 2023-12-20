Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 627DE819B9F
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 10:44:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFt5Q-0002do-Cv; Wed, 20 Dec 2023 04:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt5O-0002dd-9c
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt5J-0005nZ-Ck
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703065308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DpZlBho/nC9bkYJSXc+Br/82Oo1xDZt5/eDlvKX4I8=;
 b=LpI8lvfL86rT8sTm/i74A7cxK1U7CaK2Hb59IMlusmB91YxCWQvH/2jGqKtrx+i0A3m8s+
 lEw8QUL8lfC/MD7xs/R68HIcajBYgoQCy9DXIptUg4TDd34kPoJHWczNPdrJBgMkTsAZqB
 8EBsNLP9pHqYu3wGeS2qeheROzlm3AM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-SAwW8E9eM96TfRgiw1Xg1Q-1; Wed,
 20 Dec 2023 04:41:45 -0500
X-MC-Unique: SAwW8E9eM96TfRgiw1Xg1Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A5253C00086;
 Wed, 20 Dec 2023 09:41:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70BDE2166B31;
 Wed, 20 Dec 2023 09:41:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 19/19] tests/unit/test-qmp-event: Replace fixture by global
 variables
Date: Wed, 20 Dec 2023 10:41:05 +0100
Message-ID: <20231220094105.6588-20-thuth@redhat.com>
In-Reply-To: <20231220094105.6588-1-thuth@redhat.com>
References: <20231220094105.6588-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

From: Markus Armbruster <armbru@redhat.com>

The fixture buys us exactly nothing, as we need a global variable
anyway, for test_qapi_event_emit().  Drop it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231122072456.2518816-4-armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
-}
-
-static void event_prepare(TestEventData *data,
-                          const void *unused)
-{
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
+    g_assert(qobject_is_equal(QOBJECT(d), QOBJECT(expected_event)));
+    qobject_unref(expected_event);
+    expected_event = NULL;
 }
 
-
-/* Test cases */
-
-static void test_event_a(TestEventData *data,
-                         const void *unused)
+static void test_event_a(void)
 {
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
2.43.0


