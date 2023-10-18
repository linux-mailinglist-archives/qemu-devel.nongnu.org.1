Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DFF7CDE4F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:08:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7Dc-0003rL-MV; Wed, 18 Oct 2023 10:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7DR-0003km-Fl
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:08:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7DP-0003eD-N4
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:08:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2225D21BB0;
 Wed, 18 Oct 2023 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697638082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8jLH9uvTOQFE36hf3h/+EI9ZesLAyUU5AcfGXlWNJI=;
 b=uhbevShJx2FLVLHPKUFOQLKt7A1v/W12eonH7039VA+Z9JZtuv47JAlrH26H9pFTyd0UlP
 Fn+sQ5cXkZoENq1k3Awu77qsKef28+/u6Y0ObjWKCT+qx3zDtDWJUrqETqopzk/piHPmwt
 7KcTjeyfR01V0Etw+75vyGQbWZOohAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697638082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8jLH9uvTOQFE36hf3h/+EI9ZesLAyUU5AcfGXlWNJI=;
 b=+W3RsZxtawj5XKPeGFygFVvdTeq/Jh8wtzIyS4AhcrjWg8S8jGgjccPW5Ky1ea+zo4ex0n
 spFoJ4GA+NIsNYDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99F2D13915;
 Wed, 18 Oct 2023 14:07:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oKgMGb/mL2WuTQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 14:07:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 07/11] tests/qtest/migration: Define a machine for all
 architectures
Date: Wed, 18 Oct 2023 11:07:32 -0300
Message-Id: <20231018140736.3618-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231018140736.3618-1-farosas@suse.de>
References: <20231018140736.3618-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -1.50
X-Spamd-Result: default: False [-1.50 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.40)[97.26%]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Stop relying on defaults and select a machine explicitly for every
architecture.

This is a prerequisite for being able to select machine types for
migration using different QEMU binaries for source and destination.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e1c110537b..40de320fcc 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -743,6 +743,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     const char *kvm_opts = NULL;
     const char *arch = qtest_get_arch();
     const char *memory_size;
+    const char *machine;
 
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -755,11 +756,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     got_dst_resume = false;
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         memory_size = "150M";
+        machine = "pc";
         arch_opts = g_strdup_printf("-drive file=%s,format=raw", bootpath);
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
         memory_size = "128M";
+        machine = "s390-ccw-virtio";
         arch_opts = g_strdup_printf("-bios %s", bootpath);
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
@@ -771,10 +774,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                       "'nvramrc=hex .\" _\" begin %x %x "
                                       "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
                                       "until'", end_address, start_address);
+        machine = "pseries";
         arch_opts = g_strdup("-nodefaults -machine vsmt=8");
     } else if (strcmp(arch, "aarch64") == 0) {
         memory_size = "150M";
-        arch_opts = g_strdup_printf("-machine virt,gic-version=max -cpu max "
+        machine = "virt";
+        arch_opts = g_strdup_printf("-machine gic-version=max -cpu max "
                                     "-kernel %s", bootpath);
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
@@ -810,11 +815,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     }
 
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
+                                 "-machine %s "
                                  "-name source,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/src_serial "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
+                                 machine,
                                  memory_size, tmpfs,
                                  arch_opts ? arch_opts : "",
                                  arch_source ? arch_source : "",
@@ -829,12 +836,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     }
 
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
+                                 "-machine %s "
                                  "-name target,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
+                                 machine,
                                  memory_size, tmpfs, uri,
                                  arch_opts ? arch_opts : "",
                                  arch_target ? arch_target : "",
-- 
2.35.3


