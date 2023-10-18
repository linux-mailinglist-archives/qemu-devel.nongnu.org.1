Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4CA7CE7B9
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 21:29:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtCDG-0003Kx-Jc; Wed, 18 Oct 2023 15:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCDD-0003Kg-9T
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:28:12 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCDA-00055m-6J
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:28:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B8DD31F88B;
 Wed, 18 Oct 2023 19:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697657286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ml3qsqOE/M42yr8/FMnGjUXaUFUKCzD3TurkW8vBD64=;
 b=z3Lk0J5q9ocyXB6o+OESQM6MSCMalRuW/cXZePU+xD1/5ku7RWSuHHcJuYysy7itkAa44B
 naMrkuaYfmU+DFInRpQ/Q2RH57zJeqdYdopCLJNdOZi+Rn/XkCJg2b17B729fiMgulWojX
 GbTKJ03L7Jska9Vmb2s4GxLBO9h+1zY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697657286;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ml3qsqOE/M42yr8/FMnGjUXaUFUKCzD3TurkW8vBD64=;
 b=RKPQWGjiWlZX6O5q88eaqle++9EnXWpsVOh8z0USNFOh0C6VyXVAlxSxltr6J5tiZYGm22
 0oOwgQDNVKMMXABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35AB3139E0;
 Wed, 18 Oct 2023 19:28:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ePW5AMQxMGVLaAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 19:28:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 07/12] tests/qtest/migration: Define a machine for all
 architectures
Date: Wed, 18 Oct 2023 16:27:36 -0300
Message-Id: <20231018192741.25885-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231018192741.25885-1-farosas@suse.de>
References: <20231018192741.25885-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -1.63
X-Spamd-Result: default: False [-1.63 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.53)[97.89%]
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
 tests/qtest/migration-test.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e1c110537b..43d0b83771 100644
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
2.35.3


