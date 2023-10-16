Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 424CD7CA4D2
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:09:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKWS-0002Kt-Ma; Mon, 16 Oct 2023 06:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKW7-0001pf-Qu
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKW1-0007WZ-BF
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697450880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lU5NR2MgIbi03h+tGAVJYSe9CyDljvWz1I6qdBYf8rg=;
 b=QCH0g6lMF/aKfvCGIn5bFr+Swc9G7rjcXkNNvpvSAEGaQSeI2ybGdJkwH/F7uhwcu27hWr
 hf/Dd4gvYe7As38YshmFjWbCDrFOl65rEnNgESxbpz2tTYDLLbH6DZOzF9SprGilT9fKHF
 iXYlZzOsMbXcDvltKrxRIxklOqmwsrk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-C4e_ccjcMZqlLwXZfRYuNw-1; Mon, 16 Oct 2023 06:07:42 -0400
X-MC-Unique: C4e_ccjcMZqlLwXZfRYuNw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E9273826D3F;
 Mon, 16 Oct 2023 10:07:41 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B44763F48;
 Mon, 16 Oct 2023 10:07:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 10/38] tests/qtest/migration: Add a test for the
 analyze-migration script
Date: Mon, 16 Oct 2023 12:06:38 +0200
Message-ID: <20231016100706.2551-11-quintela@redhat.com>
In-Reply-To: <20231016100706.2551-1-quintela@redhat.com>
References: <20231016100706.2551-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

From: Fabiano Rosas <farosas@suse.de>

Add a smoke test that migrates to a file and gives it to the
script. It should catch the most annoying errors such as changes in
the ram flags.

After code has been merged it becomes way harder to figure out what is
causing the script to fail, the person making the change is the most
likely to know right away what the problem is.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231009184326.15777-7-farosas@suse.de>
---
 tests/qtest/migration-test.c | 60 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build      |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 8eb2053dbb..cef5081f8c 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -66,6 +66,8 @@ static bool got_dst_resume;
  */
 #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
 
+#define ANALYZE_SCRIPT "scripts/analyze-migration.py"
+
 #if defined(__linux__)
 #include <sys/syscall.h>
 #include <sys/vfs.h>
@@ -1501,6 +1503,61 @@ static void test_baddest(void)
     test_migrate_end(from, to, false);
 }
 
+#ifndef _WIN32
+static void test_analyze_script(void)
+{
+    MigrateStart args = {
+        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
+    };
+    QTestState *from, *to;
+    g_autofree char *uri = NULL;
+    g_autofree char *file = NULL;
+    int pid, wstatus;
+    const char *python = g_getenv("PYTHON");
+
+    if (!python) {
+        g_test_skip("PYTHON variable not set");
+        return;
+    }
+
+    /* dummy url */
+    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
+        return;
+    }
+
+    /*
+     * Setting these two capabilities causes the "configuration"
+     * vmstate to include subsections for them. The script needs to
+     * parse those subsections properly.
+     */
+    migrate_set_capability(from, "validate-uuid", true);
+    migrate_set_capability(from, "x-ignore-shared", true);
+
+    file = g_strdup_printf("%s/migfile", tmpfs);
+    uri = g_strdup_printf("exec:cat > %s", file);
+
+    migrate_ensure_converge(from);
+    migrate_qmp(from, uri, "{}");
+    wait_for_migration_complete(from);
+
+    pid = fork();
+    if (!pid) {
+        close(1);
+        open("/dev/null", O_WRONLY);
+        execl(python, python, ANALYZE_SCRIPT, "-f", file, NULL);
+        g_assert_not_reached();
+    }
+
+    g_assert(waitpid(pid, &wstatus, 0) == pid);
+    if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) != 0) {
+        g_test_message("Failed to analyze the migration stream");
+        g_test_fail();
+    }
+    test_migrate_end(from, to, false);
+    cleanup("migfile");
+}
+#endif
+
 static void test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
@@ -2837,6 +2894,9 @@ int main(int argc, char **argv)
     }
 
     qtest_add_func("/migration/bad_dest", test_baddest);
+#ifndef _WIN32
+    qtest_add_func("/migration/analyze-script", test_analyze_script);
+#endif
     qtest_add_func("/migration/precopy/unix/plain", test_precopy_unix_plain);
     qtest_add_func("/migration/precopy/unix/xbzrle", test_precopy_unix_xbzrle);
     /*
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 66795cfcd2..d6022ebd64 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -357,6 +357,8 @@ foreach dir : target_dirs
     test_deps += [qsd]
   endif
 
+  qtest_env.set('PYTHON', python.full_path())
+
   foreach test : target_qtests
     # Executables are shared across targets, declare them only the first time we
     # encounter them
-- 
2.41.0


