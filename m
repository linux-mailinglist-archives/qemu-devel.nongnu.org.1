Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61830728B44
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:51:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSH-0003Sb-Dk; Thu, 08 Jun 2023 18:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSE-0003RT-82
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSC-0004oz-6c
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCS9s69yO7/0LYnEh+9ZeIPqPwKOA/vMvFcheMbhkYQ=;
 b=WtTvN+f6bvSXb6GAXMGP2zbvDCiizhjwlOSGera7azPsXMGDWwscazmWBFg5cRYdFjJouI
 q+9Lfba2wt9ucbRfVvrosQj8LFvwG+lMAICUpWGYc91BLrvj989GK4i0Z2QsLNijF+/Y7x
 poPYOGeAWVVrYIvEkkd7UBMMNalizG0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-RK9VnpFVMA2G22qzm03B2Q-1; Thu, 08 Jun 2023 18:50:02 -0400
X-MC-Unique: RK9VnpFVMA2G22qzm03B2Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1DB1811E7F;
 Thu,  8 Jun 2023 22:50:01 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D508492B00;
 Thu,  8 Jun 2023 22:50:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 08/42] migration-test: bootpath is the same for all tests and
 for all archs
Date: Fri,  9 Jun 2023 00:49:09 +0200
Message-Id: <20230608224943.3877-9-quintela@redhat.com>
In-Reply-To: <20230608224943.3877-1-quintela@redhat.com>
References: <20230608224943.3877-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

So just make it a global variable.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 1fa815fa66..6453216e4e 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -102,6 +102,7 @@ static bool ufd_version_check(void)
 #endif
 
 static char *tmpfs;
+static char *bootpath;
 
 /* The boot file modifies memory area in [start_address, end_address)
  * repeatedly. It outputs a 'B' at a fixed rate while it's still running.
@@ -110,7 +111,7 @@ static char *tmpfs;
 #include "tests/migration/aarch64/a-b-kernel.h"
 #include "tests/migration/s390x/a-b-bios.h"
 
-static void init_bootfile(const char *bootpath, void *content, size_t len)
+static void init_bootfile(void *content, size_t len)
 {
     FILE *bootfile = fopen(bootpath, "wb");
 
@@ -605,7 +606,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
     const gchar *ignore_stderr = NULL;
-    g_autofree char *bootpath = NULL;
     g_autofree char *shmem_opts = NULL;
     g_autofree char *shmem_path = NULL;
     const char *kvm_opts = NULL;
@@ -621,17 +621,16 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
     got_src_stop = false;
     got_dst_resume = false;
-    bootpath = g_strdup_printf("%s/bootsect", tmpfs);
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         /* the assembled x86 boot sector should be exactly one sector large */
         assert(sizeof(x86_bootsect) == 512);
-        init_bootfile(bootpath, x86_bootsect, sizeof(x86_bootsect));
+        init_bootfile(x86_bootsect, sizeof(x86_bootsect));
         memory_size = "150M";
         arch_opts = g_strdup_printf("-drive file=%s,format=raw", bootpath);
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
-        init_bootfile(bootpath, s390x_elf, sizeof(s390x_elf));
+        init_bootfile(s390x_elf, sizeof(s390x_elf));
         memory_size = "128M";
         arch_opts = g_strdup_printf("-bios %s", bootpath);
         start_address = S390_TEST_MEM_START;
@@ -646,7 +645,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                       "until'", end_address, start_address);
         arch_opts = g_strdup("-nodefaults -machine vsmt=8");
     } else if (strcmp(arch, "aarch64") == 0) {
-        init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
+        init_bootfile(aarch64_kernel, sizeof(aarch64_kernel));
         memory_size = "150M";
         arch_opts = g_strdup_printf("-machine virt,gic-version=max -cpu max "
                                     "-kernel %s", bootpath);
@@ -759,7 +758,6 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
 
     qtest_quit(to);
 
-    cleanup("bootsect");
     cleanup("migsocket");
     cleanup("src_serial");
     cleanup("dest_serial");
@@ -2488,12 +2486,10 @@ static QTestState *dirtylimit_start_vm(void)
     QTestState *vm = NULL;
     g_autofree gchar *cmd = NULL;
     const char *arch = qtest_get_arch();
-    g_autofree char *bootpath = NULL;
 
     assert((strcmp(arch, "x86_64") == 0));
-    bootpath = g_strdup_printf("%s/bootsect", tmpfs);
     assert(sizeof(x86_bootsect) == 512);
-    init_bootfile(bootpath, x86_bootsect, sizeof(x86_bootsect));
+    init_bootfile(x86_bootsect, sizeof(x86_bootsect));
 
     cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
                           "-name dirtylimit-test,debug-threads=on "
@@ -2509,7 +2505,6 @@ static QTestState *dirtylimit_start_vm(void)
 static void dirtylimit_stop_vm(QTestState *vm)
 {
     qtest_quit(vm);
-    cleanup("bootsect");
     cleanup("vm_serial");
 }
 
@@ -2671,6 +2666,7 @@ int main(int argc, char **argv)
                        g_get_tmp_dir(), err->message);
     }
     g_assert(tmpfs);
+    bootpath = g_strdup_printf("%s/bootsect", tmpfs);
 
     module_call_init(MODULE_INIT_QOM);
 
@@ -2814,6 +2810,8 @@ int main(int argc, char **argv)
 
     g_assert_cmpint(ret, ==, 0);
 
+    cleanup("bootsect");
+    g_free(bootpath);
     ret = rmdir(tmpfs);
     if (ret != 0) {
         g_test_message("unable to rmdir: path (%s): %s",
-- 
2.40.1


