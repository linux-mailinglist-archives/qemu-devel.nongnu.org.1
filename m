Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D59D71EF61
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:44:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kw7-0008LU-Ci; Thu, 01 Jun 2023 12:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4kw5-0008JA-05
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4kw3-0003tc-Dq
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685636038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jAYe85SCuB16clQqN23Wijl56FUqbh//t/lnF1Z33DI=;
 b=JYPPKkX8N4YdAG29pD3Dj7Mjw+Anog7fq9XI4KS1uRvuy8Jhwojd9KwOQJAraU1s4/w/Gu
 EQIuKjkEXhtQgiW0m3dKeWLy0pibvIRqYshUxS4Y+zYw1ArGwo7yziXwMWKrRkpLyicSUE
 p+gYeveVBEq/uNnyZhoCGp3GNKZA3u0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-6bQbRVs1OX2W0L_2bGBMgg-1; Thu, 01 Jun 2023 12:13:57 -0400
X-MC-Unique: 6bQbRVs1OX2W0L_2bGBMgg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5723C38470A1
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 16:13:57 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 404E714171BC;
 Thu,  1 Jun 2023 16:13:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 04/10] tests/qtest: get rid of some 'qtest_qmp' usage in
 migration test
Date: Thu,  1 Jun 2023 17:13:41 +0100
Message-Id: <20230601161347.1803440-5-berrange@redhat.com>
In-Reply-To: <20230601161347.1803440-1-berrange@redhat.com>
References: <20230601161347.1803440-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Some of the usage is just a verbose way of re-inventing the
qtest_qmp_assert_success(_ref) methods.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/migration-helpers.c |  8 ++---
 tests/qtest/migration-test.c    | 52 ++++++++++++---------------------
 2 files changed, 21 insertions(+), 39 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index bddf3f8d4d..e26fdcb132 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -93,7 +93,7 @@ QDict *wait_command(QTestState *who, const char *command, ...)
 void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
 {
     va_list ap;
-    QDict *args, *rsp;
+    QDict *args;
 
     va_start(ap, fmt);
     args = qdict_from_vjsonf_nofail(fmt, ap);
@@ -102,10 +102,8 @@ void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
     g_assert(!qdict_haskey(args, "uri"));
     qdict_put_str(args, "uri", uri);
 
-    rsp = qtest_qmp(who, "{ 'execute': 'migrate', 'arguments': %p}", args);
-
-    g_assert(qdict_haskey(rsp, "return"));
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate', 'arguments': %p}", args);
 }
 
 /*
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 9ce27f89ec..822516286d 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -359,14 +359,10 @@ static void migrate_check_parameter_int(QTestState *who, const char *parameter,
 static void migrate_set_parameter_int(QTestState *who, const char *parameter,
                                       long long value)
 {
-    QDict *rsp;
-
-    rsp = qtest_qmp(who,
-                    "{ 'execute': 'migrate-set-parameters',"
-                    "'arguments': { %s: %lld } }",
-                    parameter, value);
-    g_assert(qdict_haskey(rsp, "return"));
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate-set-parameters',"
+                             "'arguments': { %s: %lld } }",
+                             parameter, value);
     migrate_check_parameter_int(who, parameter, value);
 }
 
@@ -392,14 +388,10 @@ static void migrate_check_parameter_str(QTestState *who, const char *parameter,
 static void migrate_set_parameter_str(QTestState *who, const char *parameter,
                                       const char *value)
 {
-    QDict *rsp;
-
-    rsp = qtest_qmp(who,
-                    "{ 'execute': 'migrate-set-parameters',"
-                    "'arguments': { %s: %s } }",
-                    parameter, value);
-    g_assert(qdict_haskey(rsp, "return"));
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate-set-parameters',"
+                             "'arguments': { %s: %s } }",
+                             parameter, value);
     migrate_check_parameter_str(who, parameter, value);
 }
 
@@ -427,14 +419,10 @@ static void migrate_check_parameter_bool(QTestState *who, const char *parameter,
 static void migrate_set_parameter_bool(QTestState *who, const char *parameter,
                                       int value)
 {
-    QDict *rsp;
-
-    rsp = qtest_qmp(who,
-                    "{ 'execute': 'migrate-set-parameters',"
-                    "'arguments': { %s: %i } }",
-                    parameter, value);
-    g_assert(qdict_haskey(rsp, "return"));
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate-set-parameters',"
+                             "'arguments': { %s: %i } }",
+                             parameter, value);
     migrate_check_parameter_bool(who, parameter, value);
 }
 
@@ -494,16 +482,12 @@ static void migrate_cancel(QTestState *who)
 static void migrate_set_capability(QTestState *who, const char *capability,
                                    bool value)
 {
-    QDict *rsp;
-
-    rsp = qtest_qmp(who,
-                    "{ 'execute': 'migrate-set-capabilities',"
-                    "'arguments': { "
-                    "'capabilities': [ { "
-                    "'capability': %s, 'state': %i } ] } }",
-                    capability, value);
-    g_assert(qdict_haskey(rsp, "return"));
-    qobject_unref(rsp);
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate-set-capabilities',"
+                             "'arguments': { "
+                             "'capabilities': [ { "
+                             "'capability': %s, 'state': %i } ] } }",
+                             capability, value);
 }
 
 static void migrate_postcopy_start(QTestState *from, QTestState *to)
-- 
2.40.1


