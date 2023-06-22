Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B5073955D
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 04:15:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC9qd-0007zi-Dd; Wed, 21 Jun 2023 22:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9qK-00070z-90
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9qG-00054k-Ur
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687400076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YK9i97oj+2hte8T79ySuooH4bjMECzrsr80F+WOLqQw=;
 b=UCUVYklCrjQA7PElP/JFx6/NiiL5v/IAB8TLEUve1YjuHo0Rkz5+u0t1qmf15EyPYA+zVp
 FCAErast2HdlFmAJ66chZfqVWd6lSZA7UcFzCLdFLbeNYkV/EzyAxdaV0r2q0e60FokF1p
 uT4jWbKcZmbchJEJaLOkWM/fwHdRSE4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-RoqpWqWAOBGOp3KXGdFLJQ-1; Wed, 21 Jun 2023 22:14:30 -0400
X-MC-Unique: RoqpWqWAOBGOp3KXGdFLJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 231D0104458D;
 Thu, 22 Jun 2023 02:14:30 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.193.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 079C3112132C;
 Thu, 22 Jun 2023 02:14:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 16/30] migration-test: bootpath is the same for all tests and
 for all archs
Date: Thu, 22 Jun 2023 04:13:06 +0200
Message-Id: <20230622021320.66124-17-quintela@redhat.com>
In-Reply-To: <20230622021320.66124-1-quintela@redhat.com>
References: <20230622021320.66124-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

So just make it a global variable.

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20230608224943.3877-9-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 40967fdffc..0f80dbfe80 100644
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
     const gchar *ignore_stderr;
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
@@ -764,7 +763,6 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
 
     qtest_quit(to);
 
-    cleanup("bootsect");
     cleanup("migsocket");
     cleanup("src_serial");
     cleanup("dest_serial");
@@ -2493,12 +2491,10 @@ static QTestState *dirtylimit_start_vm(void)
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
@@ -2514,7 +2510,6 @@ static QTestState *dirtylimit_start_vm(void)
 static void dirtylimit_stop_vm(QTestState *vm)
 {
     qtest_quit(vm);
-    cleanup("bootsect");
     cleanup("vm_serial");
 }
 
@@ -2676,6 +2671,7 @@ int main(int argc, char **argv)
                        g_get_tmp_dir(), err->message);
     }
     g_assert(tmpfs);
+    bootpath = g_strdup_printf("%s/bootsect", tmpfs);
 
     module_call_init(MODULE_INIT_QOM);
 
@@ -2819,6 +2815,8 @@ int main(int argc, char **argv)
 
     g_assert_cmpint(ret, ==, 0);
 
+    cleanup("bootsect");
+    g_free(bootpath);
     ret = rmdir(tmpfs);
     if (ret != 0) {
         g_test_message("unable to rmdir: path (%s): %s",
-- 
2.40.1


