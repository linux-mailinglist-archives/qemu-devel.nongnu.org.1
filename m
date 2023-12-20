Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E2D819B91
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 10:43:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFt5K-0002cy-Hg; Wed, 20 Dec 2023 04:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt5J-0002cm-5O
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt5H-0005mo-Dx
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703065306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SLbBysMeHI/UcHhD+iEhhS4+g9snre5DxGx4LXfiA8=;
 b=TL98LpLaUFmW0qj7gj4o25ZveecgDaQV9/fVIZ8jOYJ2XC8cplNndBmQ6EFQwXQ4p/hMgM
 r5mVD8X4Q8y+pZkSknFJddvnKBfKwngoiA/ujdX2hNCgHpGtZ2X18aFCIMpIB5QdkbMA3h
 TosgcSJ1oSz5LtxVTDOpga30P+tTvNc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-ZLspY_AFPDKSad20iEl4ww-1; Wed, 20 Dec 2023 04:41:43 -0500
X-MC-Unique: ZLspY_AFPDKSad20iEl4ww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01A6B85A58A;
 Wed, 20 Dec 2023 09:41:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17A7E2166B31;
 Wed, 20 Dec 2023 09:41:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 18/19] tests/unit/test-qmp-event: Simplify event emission check
Date: Wed, 20 Dec 2023 10:41:04 +0100
Message-ID: <20231220094105.6588-19-thuth@redhat.com>
In-Reply-To: <20231220094105.6588-1-thuth@redhat.com>
References: <20231220094105.6588-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

The generated qapi_event_send_FOO() call an event emitter function.
It's test_qapi_event_emit() in this test.  It compares the actual
event to the expected event, and sets a flag to record it was called.
The test functions set expected data and clear the flag before calling
qapi_event_send_FOO(), and check the flag afterwards.

Make test_qapi_event_emit() consume expected data, and the test
functions check it was consumed.  Delete the flag.  This is simpler.
It also catches extraneous calls of test_qapi_event_emit().  Catching
that is not worthwhile, but since the cost is negative...

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231122072456.2518816-3-armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-qmp-event.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/tests/unit/test-qmp-event.c b/tests/unit/test-qmp-event.c
index c2c44687d5..5c9837e849 100644
--- a/tests/unit/test-qmp-event.c
+++ b/tests/unit/test-qmp-event.c
@@ -26,7 +26,6 @@
 
 typedef struct TestEventData {
     QDict *expect;
-    bool emitted;
 } TestEventData;
 
 TestEventData *test_event_data;
@@ -36,6 +35,8 @@ void test_qapi_event_emit(test_QAPIEvent event, QDict *d)
     QDict *t;
     int64_t s, ms;
 
+    g_assert(test_event_data->expect);
+
     /* Verify that we have timestamp, then remove it to compare other fields */
     t = qdict_get_qdict(d, "timestamp");
     g_assert(t);
@@ -52,7 +53,8 @@ void test_qapi_event_emit(test_QAPIEvent event, QDict *d)
     qdict_del(d, "timestamp");
 
     g_assert(qobject_is_equal(QOBJECT(d), QOBJECT(test_event_data->expect)));
-    test_event_data->emitted = true;
+    qobject_unref(test_event_data->expect);
+    test_event_data->expect = NULL;
 }
 
 static void event_prepare(TestEventData *data,
@@ -83,8 +85,7 @@ static void test_event_a(TestEventData *data,
 {
     data->expect = qdict_from_jsonf_nofail("{ 'event': 'EVENT_A' }");
     qapi_event_send_event_a();
-    g_assert(data->emitted);
-    qobject_unref(data->expect);
+    g_assert(!data->expect);
 }
 
 static void test_event_b(TestEventData *data,
@@ -92,8 +93,7 @@ static void test_event_b(TestEventData *data,
 {
     data->expect = qdict_from_jsonf_nofail("{ 'event': 'EVENT_B' }");
     qapi_event_send_event_b();
-    g_assert(data->emitted);
-    qobject_unref(data->expect);
+    g_assert(!data->expect);
 }
 
 static void test_event_c(TestEventData *data,
@@ -105,8 +105,7 @@ static void test_event_c(TestEventData *data,
         "{ 'event': 'EVENT_C', 'data': {"
         " 'a': 1, 'b': { 'integer': 2, 'string': 'test1' }, 'c': 'test2' } }");
     qapi_event_send_event_c(true, 1, &b, "test2");
-    g_assert(data->emitted);
-    qobject_unref(data->expect);
+    g_assert(!data->expect);
 }
 
 /* Complex type */
@@ -131,8 +130,7 @@ static void test_event_d(TestEventData *data,
         "  'string': 'test2', 'enum2': 'value2' },"
         " 'b': 'test3', 'enum3': 'value3' } }");
     qapi_event_send_event_d(&a, "test3", NULL, true, ENUM_ONE_VALUE3);
-    g_assert(data->emitted);
-    qobject_unref(data->expect);
+    g_assert(!data->expect);
 }
 
 static void test_event_deprecated(TestEventData *data, const void *unused)
@@ -142,15 +140,11 @@ static void test_event_deprecated(TestEventData *data, const void *unused)
     memset(&compat_policy, 0, sizeof(compat_policy));
 
     qapi_event_send_test_event_features1();
-    g_assert(data->emitted);
+    g_assert(!data->expect);
 
     compat_policy.has_deprecated_output = true;
     compat_policy.deprecated_output = COMPAT_POLICY_OUTPUT_HIDE;
-    data->emitted = false;
     qapi_event_send_test_event_features1();
-    g_assert(!data->emitted);
-
-    qobject_unref(data->expect);
 }
 
 static void test_event_deprecated_data(TestEventData *data, const void *unused)
@@ -160,17 +154,13 @@ static void test_event_deprecated_data(TestEventData *data, const void *unused)
     data->expect = qdict_from_jsonf_nofail("{ 'event': 'TEST_EVENT_FEATURES0',"
                                            " 'data': { 'foo': 42 } }");
     qapi_event_send_test_event_features0(42);
-    g_assert(data->emitted);
+    g_assert(!data->expect);
 
-    qobject_unref(data->expect);
 
     compat_policy.has_deprecated_output = true;
     compat_policy.deprecated_output = COMPAT_POLICY_OUTPUT_HIDE;
     data->expect = qdict_from_jsonf_nofail("{ 'event': 'TEST_EVENT_FEATURES0' }");
     qapi_event_send_test_event_features0(42);
-    g_assert(data->emitted);
-
-    qobject_unref(data->expect);
 }
 
 int main(int argc, char **argv)
-- 
2.43.0


