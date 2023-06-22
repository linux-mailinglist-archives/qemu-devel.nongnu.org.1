Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D8273A6AB
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:56:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNbq-00086H-Sp; Thu, 22 Jun 2023 12:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNbd-0007EA-Of
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNba-0000Fg-Ul
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687452981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n9TdMXOS+qjL+W5lDCLJHlY6rS6mQChhMxpnTbMZipM=;
 b=YyvOaBnaM7gtTai64qGhZxr/1MbU2KANi6lEL+HPUVJ677ER7pNFRV/fa/aLdVXv6c0gGH
 N3UzcOJDisItm/Z3KmpirEJkFiZd7JDpksjLCDj7P5KbEqJZH+4/iOd4lKp2LqawNKh3J0
 J+FBxiy8ERrIQvcf3gogVUfu9wP3Z48=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-jH5AR_XRPTCKCCrGuGYPEg-1; Thu, 22 Jun 2023 12:56:17 -0400
X-MC-Unique: jH5AR_XRPTCKCCrGuGYPEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A5C197DE40;
 Thu, 22 Jun 2023 16:56:13 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34F06C00049;
 Thu, 22 Jun 2023 16:56:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 17/30] migration-test: Add bootfile_create/delete() functions
Date: Thu, 22 Jun 2023 18:55:14 +0200
Message-Id: <20230622165527.2417-18-quintela@redhat.com>
In-Reply-To: <20230622165527.2417-1-quintela@redhat.com>
References: <20230622165527.2417-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20230608224943.3877-10-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 50 ++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0f80dbfe80..eb6a11e758 100644
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
@@ -2493,9 +2519,6 @@ static QTestState *dirtylimit_start_vm(void)
     const char *arch = qtest_get_arch();
 
     assert((strcmp(arch, "x86_64") == 0));
-    assert(sizeof(x86_bootsect) == 512);
-    init_bootfile(x86_bootsect, sizeof(x86_bootsect));
-
     cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
                           "-name dirtylimit-test,debug-threads=on "
                           "-m 150M -smp 1 "
@@ -2671,7 +2694,7 @@ int main(int argc, char **argv)
                        g_get_tmp_dir(), err->message);
     }
     g_assert(tmpfs);
-    bootpath = g_strdup_printf("%s/bootsect", tmpfs);
+    bootfile_create(tmpfs);
 
     module_call_init(MODULE_INIT_QOM);
 
@@ -2815,8 +2838,7 @@ int main(int argc, char **argv)
 
     g_assert_cmpint(ret, ==, 0);
 
-    cleanup("bootsect");
-    g_free(bootpath);
+    bootfile_delete();
     ret = rmdir(tmpfs);
     if (ret != 0) {
         g_test_message("unable to rmdir: path (%s): %s",
-- 
2.40.1


