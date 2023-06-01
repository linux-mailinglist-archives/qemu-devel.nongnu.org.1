Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B92F71EF59
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:41:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kwD-0008PJ-T3; Thu, 01 Jun 2023 12:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4kwA-0008OU-3D
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4kw8-0003ug-Fo
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685636044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RUHNmYB7Kk49k9Sia66WEb4GlMnn30IMe9vTRbnrBXI=;
 b=N/BxaNCQky34cq/PXhDQl5HnN1mOub/PI5AE1eSxzQMXazO+1gijCfHn4YT5EGoc/cMlyu
 t5x9r169Vjcx0mbRKOgLpjbaMWfnukcDlIXv+H9rvFo44SWXbItndNLy5G7l8y2NUasv6Z
 yl1FidMlvmTXUO4E3ZFnUsg4OcZqhCM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-6wSDsmDlP_es6KYfxtnMIA-1; Thu, 01 Jun 2023 12:14:02 -0400
X-MC-Unique: 6wSDsmDlP_es6KYfxtnMIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BCC585A5AA
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 16:14:02 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4C1614171BB;
 Thu,  1 Jun 2023 16:14:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 07/10] tests/qtest: capture RESUME events during migration
Date: Thu,  1 Jun 2023 17:13:44 +0100
Message-Id: <20230601161347.1803440-8-berrange@redhat.com>
In-Reply-To: <20230601161347.1803440-1-berrange@redhat.com>
References: <20230601161347.1803440-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

When running migration tests we monitor for a STOP event so we can skip
redundant waits. This will be needed for the RESUME event too shortly.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/migration-helpers.c | 13 +++++++++++++
 tests/qtest/migration-helpers.h |  2 ++
 tests/qtest/migration-test.c    |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 73e506a5f8..be00c52d00 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -36,6 +36,19 @@ bool migrate_watch_for_stop(QTestState *who, const char *name,
     return false;
 }
 
+bool migrate_watch_for_resume(QTestState *who, const char *name,
+                              QDict *event, void *opaque)
+{
+    bool *seen = opaque;
+
+    if (g_str_equal(name, "RESUME")) {
+        *seen = true;
+        return true;
+    }
+
+    return false;
+}
+
 /*
  * Send QMP command "migrate".
  * Arguments are built from @fmt... (formatted like
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index aab0745cfe..009e250e90 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -17,6 +17,8 @@
 
 bool migrate_watch_for_stop(QTestState *who, const char *name,
                             QDict *event, void *opaque);
+bool migrate_watch_for_resume(QTestState *who, const char *name,
+                              QDict *event, void *opaque);
 
 G_GNUC_PRINTF(3, 4)
 void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 822cf13536..0948d13e14 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -44,6 +44,7 @@ unsigned start_address;
 unsigned end_address;
 static bool uffd_feature_thread_id;
 static bool got_stop;
+static bool got_resume;
 
 /*
  * Dirtylimit stop working if dirty page rate error
@@ -607,6 +608,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     }
 
     got_stop = false;
+    got_resume = false;
     bootpath = g_strdup_printf("%s/bootsect", tmpfs);
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         /* the assembled x86 boot sector should be exactly one sector large */
@@ -712,6 +714,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
     *to = qtest_init(cmd_target);
+    qtest_qmp_set_event_callback(*to,
+                                 migrate_watch_for_resume,
+                                 &got_resume);
 
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
-- 
2.40.1


