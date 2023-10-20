Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD047D091C
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:01:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtjU3-00057E-0P; Fri, 20 Oct 2023 02:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtjTs-0004oq-F2
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 02:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtjTo-0003uc-IN
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 02:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697785171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rbNbI20heWd00U5Y9TovTUKtsrNmucO4Gcl0M7WtmH8=;
 b=APMyUcvJe+SM2ydO+F3XULMgakK+uHmAvfJId3Ckz7+/t21APOMs1/IWSlMu/w46DGo1Wg
 /+Qa5ZnSvCbIh15hZ2qhFJ3fNs9sbwsqNG5I4ibcbAglVMMrscnWc7l3DAb25BR3l2z5iB
 cMmXXK5z3hWEpk+Wj+LKKEWvJ0vHnF8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-B_HUPvvDP0CLP862x3tfYw-1; Fri, 20 Oct 2023 02:59:27 -0400
X-MC-Unique: B_HUPvvDP0CLP862x3tfYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C20688B7A2;
 Fri, 20 Oct 2023 06:59:25 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC06F25C0;
 Fri, 20 Oct 2023 06:59:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, "Denis V. Lunev" <den@openvz.org>,
 Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>,
 kvm@vger.kernel.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-arm@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jeff Cody <codyprime@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, qemu-block@nongnu.org
Subject: [PULL 12/17] tests/qtest/migration: Define a machine for all
 architectures
Date: Fri, 20 Oct 2023 08:57:46 +0200
Message-ID: <20231020065751.26047-13-quintela@redhat.com>
In-Reply-To: <20231020065751.26047-1-quintela@redhat.com>
References: <20231020065751.26047-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Stop relying on defaults and select a machine explicitly for every
architecture.

This is a prerequisite for being able to select machine types for
migration using different QEMU binaries for source and destination.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231018192741.25885-8-farosas@suse.de>
---
 tests/qtest/migration-test.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 241b409857..dfea75b76f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -743,6 +743,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     const char *kvm_opts = NULL;
     const char *arch = qtest_get_arch();
     const char *memory_size;
+    const char *machine_alias, *machine_opts = "";
 
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -755,11 +756,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     got_dst_resume = false;
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         memory_size = "150M";
+        machine_alias = "pc";
         arch_opts = g_strdup_printf("-drive file=%s,format=raw", bootpath);
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
         memory_size = "128M";
+        machine_alias = "s390-ccw-virtio";
         arch_opts = g_strdup_printf("-bios %s", bootpath);
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
@@ -771,11 +774,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                       "'nvramrc=hex .\" _\" begin %x %x "
                                       "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
                                       "until'", end_address, start_address);
-        arch_opts = g_strdup("-nodefaults -machine vsmt=8");
+        machine_alias = "pseries";
+        machine_opts = "vsmt=8";
+        arch_opts = g_strdup("-nodefaults");
     } else if (strcmp(arch, "aarch64") == 0) {
         memory_size = "150M";
-        arch_opts = g_strdup_printf("-machine virt,gic-version=max -cpu max "
-                                    "-kernel %s", bootpath);
+        machine_alias = "virt";
+        machine_opts = "gic-version=max";
+        arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
     } else {
@@ -810,11 +816,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     }
 
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
+                                 "-machine %s,%s "
                                  "-name source,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/src_serial "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
+                                 machine_alias, machine_opts,
                                  memory_size, tmpfs,
                                  arch_opts ? arch_opts : "",
                                  arch_source ? arch_source : "",
@@ -829,12 +837,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     }
 
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
+                                 "-machine %s,%s "
                                  "-name target,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
+                                 machine_alias, machine_opts,
                                  memory_size, tmpfs, uri,
                                  arch_opts ? arch_opts : "",
                                  arch_target ? arch_target : "",
-- 
2.41.0


