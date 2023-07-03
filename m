Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8107745F05
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 16:48:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGKpm-0003Ev-9w; Mon, 03 Jul 2023 10:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qGKpd-0003BQ-PK
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:47:14 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qGKpb-0007EC-WB
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:47:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E08F821A52;
 Mon,  3 Jul 2023 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688395630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/X/G+tCDpmHClHVHUpKPNEcEbL1TXez51tAfCPEGK8=;
 b=HryIGPBvMBJt+KsfCCBYZ+CQwRDyVO1uGyVOIEn735cA7CYAoVJ03ahX0OkKvvmNXX3P2S
 Q68rCE8FoxOasCDb8Mo3FRLEnVfDPhWhWJi6vIDxA132MUnY221sqLgqfS90RyUXy9feBN
 Yyp9k50qevEf1slOYva7S0gJRo3pvj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688395630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/X/G+tCDpmHClHVHUpKPNEcEbL1TXez51tAfCPEGK8=;
 b=aRH3MuBEIN0j0tQK+/V+xkce/MjmjDXXJzuWpUA1UnlCf/iSY+p4T//vG7QB5mw6gxNCP7
 rsadldwSQ0Q0E3Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22CC21358E;
 Mon,  3 Jul 2023 14:47:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sIJKN2vfomRoSAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 03 Jul 2023 14:47:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [RFC PATCH 2/2] tests/qtest: Pass migration tests individually to
 meson
Date: Mon,  3 Jul 2023 11:47:00 -0300
Message-Id: <20230703144700.13536-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230703144700.13536-1-farosas@suse.de>
References: <20230703144700.13536-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Having glib tests (qtest) all defined in a single test file makes it
hard to know which test has failed when running CI. Create a new
'migration' test suite and move the migration tests individually to
meson.

For now, use the global migration-test timeout value, but we could set
a per-subtest timeout in the future.

Sample output:

$ ../configure --target-list=x86_64-softmmu,aarch64-softmmu ...
$ make check-migration
...
36/469 qemu:migration / /x86_64/migration/precopy/unix/plain                       OK    34.25s   1 subtests passed
37/469 qemu:migration / /x86_64/migration/multifd/tcp/tls/x509/default-host        OK     7.33s   1 subtests passed
39/469 qemu:migration / /x86_64/migration/multifd/tcp/tls/x509/allow-anon-client   OK     7.32s   1 subtests passed
40/469 qemu:migration / /aarch64/migration/postcopy/compress/plain                 SKIP   0.04s
41/469 qemu:migration / /aarch64/migration/postcopy/recovery/compress/plain        SKIP   0.04s
42/469 qemu:migration / /aarch64/migration/bad_dest                                OK     0.65s   1 subtests passed

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 .gitlab-ci.d/windows.yml |  2 +-
 tests/qtest/meson.build  | 40 +++++++++++++++++++++++++++++++---------
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index f889a468b5..04bc74a20e 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -84,7 +84,7 @@ msys2-64bit:
   - ..\msys64\usr\bin\bash -lc 'make'
   # qTests don't run successfully with "--without-default-devices",
   # so let's exclude the qtests from CI for now.
-  - ..\msys64\usr\bin\bash -lc 'make check MTESTARGS=\"--no-suite qtest\" || { cat meson-logs/testlog.txt; exit 1; } ;'
+  - ..\msys64\usr\bin\bash -lc 'make check MTESTARGS=\"--no-suite qtest migration\" || { cat meson-logs/testlog.txt; exit 1; } ;'
 
 msys2-32bit:
   extends: .shared_msys2_builder
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 5fa6833ad7..43c140921c 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -369,14 +369,36 @@ foreach dir : target_dirs
         test: executable(test, src, dependencies: deps)
       }
     endif
-    test('qtest-@0@/@1@'.format(target_base, test),
-         qtest_executables[test],
-         depends: [test_deps, qtest_emulator, emulator_modules],
-         env: qtest_env,
-         args: ['--tap', '-k'],
-         protocol: 'tap',
-         timeout: slow_qtests.get(test, 30),
-         priority: slow_qtests.get(test, 30),
-         suite: ['qtest', 'qtest-' + target_base])
+
+    migtest = 'migration-test'
+    if test == migtest
+      migtests = run_command(python, files('gen_migration_tests_list.py'),
+                             meson.current_source_dir() / 'migration-test.c',
+                             check: true)
+
+      foreach item : migtests.stdout().strip().split('\n')
+        testname = '/@0@@1@'.format(target_base, item)
+
+        test(testname,
+             qtest_executables['migration-test'],
+             depends: [test_deps, qtest_emulator, emulator_modules],
+             env: qtest_env,
+             args: ['-k', '-p', testname],
+             protocol: 'tap',
+             timeout: slow_qtests.get(migtest),
+             priority: slow_qtests.get(migtest),
+             suite: ['migration'])
+      endforeach
+    else
+      test('qtest-@0@/@1@'.format(target_base, test),
+           qtest_executables[test],
+           depends: [test_deps, qtest_emulator, emulator_modules],
+           env: qtest_env,
+           args: ['--tap', '-k'],
+           protocol: 'tap',
+           timeout: slow_qtests.get(test, 30),
+           priority: slow_qtests.get(test, 30),
+           suite: ['qtest', 'qtest-' + target_base])
+      endif
   endforeach
 endforeach
-- 
2.35.3


