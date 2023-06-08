Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7622728B54
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 00:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7OSM-0003VL-NX; Thu, 08 Jun 2023 18:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSJ-0003UW-KL
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7OSG-0004w4-L0
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 18:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686264607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fvzy9aXYrm8mI0bcAbv9u3G/soNQ41I+aa6PPSWUMIE=;
 b=Ih7zSj2WeRX2MW639DJ/0HKP+afXS0AHshcbCCCb/1sBv9owFQPKcpD0hpGxJRtuAqQ9K9
 goPRtfNtQVQPDiEK36jQwSgV8E+NLf+ElCOB9HsGzzpXEpuYJ53AnzEu8hPhZT8YTPyyBX
 ve97LEAoleCHDs/sGlEsVQl1UqtTmwk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-cXEnEq4-Nq-w87aHZ3jc4w-1; Thu, 08 Jun 2023 18:50:04 -0400
X-MC-Unique: cXEnEq4-Nq-w87aHZ3jc4w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6D52101A531;
 Thu,  8 Jun 2023 22:50:03 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 453B5492B00;
 Thu,  8 Jun 2023 22:50:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 09/42] migration-test: Add bootfile_create/delete() functions
Date: Fri,  9 Jun 2023 00:49:10 +0200
Message-Id: <20230608224943.3877-10-quintela@redhat.com>
In-Reply-To: <20230608224943.3877-1-quintela@redhat.com>
References: <20230608224943.3877-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

The bootsector code is read only from the guest (otherwise we are
going to have problems with it being read from both source and
destination).

Create a single copy for all the tests.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 50 ++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 6453216e4e..613fda79bb 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -111,14 +111,47 @@ static char *bootpath;
 #include "tests/migration/aarch64/a-b-kernel.h"
 #include "tests/migration/s390x/a-b-bios.h"
 
-static void init_bootfile(void *content, size_t len)
+static void bootfile_create(char *dir)
 {
+    const char *arch = qtest_get_arch();
+    unsigned char *content;
+    size_t len;
+
+    bootpath = g_strdup_printf("%s/bootsect", dir);
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        /* the assembled x86 boot sector should be exactly one sector large */
+        g_assert(sizeof(x86_bootsect) == 512);
+        content = x86_bootsect;
+        len = sizeof(x86_bootsect);
+    } else if (g_str_equal(arch, "s390x")) {
+        content = s390x_elf;
+        len = sizeof(s390x_elf);
+    } else if (strcmp(arch, "ppc64") == 0) {
+        /*
+         * sane architectures can be programmed at the boot prompt
+         */
+        return;
+    } else if (strcmp(arch, "aarch64") == 0) {
+        content = aarch64_kernel;
+        len = sizeof(aarch64_kernel);
+        g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
+    } else {
+        g_assert_not_reached();
+    }
+
     FILE *bootfile = fopen(bootpath, "wb");
 
     g_assert_cmpint(fwrite(content, len, 1, bootfile), ==, 1);
     fclose(bootfile);
 }
 
+static void bootfile_delete(void)
+{
+    unlink(bootpath);
+    g_free(bootpath);
+    bootpath = NULL;
+}
+
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
@@ -622,15 +655,11 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     got_src_stop = false;
     got_dst_resume = false;
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        /* the assembled x86 boot sector should be exactly one sector large */
-        assert(sizeof(x86_bootsect) == 512);
-        init_bootfile(x86_bootsect, sizeof(x86_bootsect));
         memory_size = "150M";
         arch_opts = g_strdup_printf("-drive file=%s,format=raw", bootpath);
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
-        init_bootfile(s390x_elf, sizeof(s390x_elf));
         memory_size = "128M";
         arch_opts = g_strdup_printf("-bios %s", bootpath);
         start_address = S390_TEST_MEM_START;
@@ -645,14 +674,11 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                       "until'", end_address, start_address);
         arch_opts = g_strdup("-nodefaults -machine vsmt=8");
     } else if (strcmp(arch, "aarch64") == 0) {
-        init_bootfile(aarch64_kernel, sizeof(aarch64_kernel));
         memory_size = "150M";
         arch_opts = g_strdup_printf("-machine virt,gic-version=max -cpu max "
                                     "-kernel %s", bootpath);
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
-
-        g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
     } else {
         g_assert_not_reached();
     }
@@ -2488,9 +2514,6 @@ static QTestState *dirtylimit_start_vm(void)
     const char *arch = qtest_get_arch();
 
     assert((strcmp(arch, "x86_64") == 0));
-    assert(sizeof(x86_bootsect) == 512);
-    init_bootfile(x86_bootsect, sizeof(x86_bootsect));
-
     cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
                           "-name dirtylimit-test,debug-threads=on "
                           "-m 150M -smp 1 "
@@ -2666,7 +2689,7 @@ int main(int argc, char **argv)
                        g_get_tmp_dir(), err->message);
     }
     g_assert(tmpfs);
-    bootpath = g_strdup_printf("%s/bootsect", tmpfs);
+    bootfile_create(tmpfs);
 
     module_call_init(MODULE_INIT_QOM);
 
@@ -2810,8 +2833,7 @@ int main(int argc, char **argv)
 
     g_assert_cmpint(ret, ==, 0);
 
-    cleanup("bootsect");
-    g_free(bootpath);
+    bootfile_delete();
     ret = rmdir(tmpfs);
     if (ret != 0) {
         g_test_message("unable to rmdir: path (%s): %s",
-- 
2.40.1


