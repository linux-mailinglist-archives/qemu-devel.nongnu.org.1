Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9768CE0A2
	for <lists+qemu-devel@lfdr.de>; Fri, 24 May 2024 07:37:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sANbb-0008Dh-J8; Fri, 24 May 2024 01:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sANbY-0008DH-2i
 for qemu-devel@nongnu.org; Fri, 24 May 2024 01:36:36 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sANbV-00015t-8z
 for qemu-devel@nongnu.org; Fri, 24 May 2024 01:36:35 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f693306b7cso3493501b3a.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 22:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716528992; x=1717133792;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=10rXCiXiyOJFrRF1ZmnZJe2ca8m+9/pLyEiZ68FqHXk=;
 b=fX8MIogSvhIWtKcXGW2PRN6Vdp57QslwG0+gxJAifJur6ePnJQqKmy9wUZbZrZQqS0
 XnMsaXcGimx2J+VCV1QSndsOzBZcBU4Lu74j7nBuu6x7O3TxWmH9tbAPJggpXztBwRme
 3VpOmBHgSXO9brYtvuHY51vt55yiqF0QxaGyr7bypseSSMYJLdJ1Z47Gr3syfickHnFw
 8r2j2gZ6c9Y7IuwVgBKBY6os7hk5mlS/dqFk0ry6UaD9x3jMQuLmrjR3gjy+D0CWUD3o
 a7YbvDT/BEOkw1o04iBFdv1pwHzJvI5Vtip0Unr7plAAxsFuWzoVzDRr+9cvT1XswS17
 hPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716528992; x=1717133792;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=10rXCiXiyOJFrRF1ZmnZJe2ca8m+9/pLyEiZ68FqHXk=;
 b=EVyK4ljLdZWgQzQjODXGpx5J6tNW88R0EF4ZqwE52c0PaoUvjIX4VxiMB+RxuoSTi/
 yPw+0EAVJ3c5Bap3dSHmIbgCJ21XuQW7WyidVPj3CwHeLWyK03jRxfYmp9g7xX/qd1v/
 HI+dq1+qjDZGJ8uJTaPLttCyQuglETOs9DT4OcaHVLojJ6NDUElsHt33ziXQXLLTjpb/
 SWEhez3QCdiOV3gLjFdtwRRiAWhvfT2reUL6mpUF5oFRXHHVOrUKfP99uhxYqSoldUu7
 uPm3yJ+WPIlddS1LIZNk59obomQjtfTlg/FOlBYs9C+JID1wKdG7042T3jICN27wd4Q8
 VnUA==
X-Gm-Message-State: AOJu0Yy3fjr2feslCCabXiBlMDChdeA90zelAMKipC8zUkoHYYn5WTnp
 h+xCaDuyzBjw5MLxEwvJRDKvwb/VO3uvEXOdZku8vz/yW5LaqP7VYgYJErtUcG0=
X-Google-Smtp-Source: AGHT+IHAFcUbocCo763YSNdClc19cPCcfPF+H3v6wUIl8GaDdbSfIKestKwYt2bgjdQbhsRIWIP+Rg==
X-Received: by 2002:a05:6a20:3208:b0:1b0:2826:9e2 with SMTP id
 adf61e73a8af0-1b212d49917mr1383594637.31.1716528991766; 
 Thu, 23 May 2024 22:36:31 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1f44c9a9e1esm5162565ad.239.2024.05.23.22.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 22:36:31 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 24 May 2024 14:35:50 +0900
Subject: [PATCH v4 4/4] meson: Drop the .fa library suffix
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-xkb-v4-4-2de564e5c859@daynix.com>
References: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
In-Reply-To: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-01a33
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The non-standard .fa library suffix breaks the link source
de-duplication done by Meson so drop it.

The lack of link source de-duplication causes AddressSanitizer to
complain ODR violations, and makes GNU ld abort when combined with
clang's LTO.

Previously, the non-standard suffix was necessary for fork-fuzzing.
Meson wraps all standard-suffixed libraries with --start-group and
--end-group. This made a fork-fuzz.ld linker script wrapped as well and
broke builds. Commit d2e6f9272d33 ("fuzz: remove fork-fuzzing
scaffolding") dropped fork-fuzzing so we can now restore the standard
suffix.

The occurences of the suffix were detected and removed by performing
a tree-wide search with 'fa' and .fa (note the quotes and dot).

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/devel/build-system.rst         |  5 -----
 meson.build                         | 17 ++---------------
 stubs/blk-exp-close-all.c           |  2 +-
 .gitlab-ci.d/buildtest-template.yml |  2 --
 .gitlab-ci.d/buildtest.yml          |  2 --
 gdbstub/meson.build                 |  2 --
 tcg/meson.build                     |  2 --
 tests/Makefile.include              |  2 +-
 tests/qtest/libqos/meson.build      |  1 -
 9 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 09caf2f8e199..5baf027b7614 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -236,15 +236,10 @@ Subsystem sourcesets:
   are then turned into static libraries as follows::
 
     libchardev = static_library('chardev', chardev_ss.sources(),
-                                name_suffix: 'fa',
                                 build_by_default: false)
 
     chardev = declare_dependency(link_whole: libchardev)
 
-  As of Meson 0.55.1, the special ``.fa`` suffix should be used for everything
-  that is used with ``link_whole``, to ensure that the link flags are placed
-  correctly in the command line.
-
 Target-independent emulator sourcesets:
   Various general purpose helper code is compiled only once and
   the .o files are linked into all output binaries that need it.
diff --git a/meson.build b/meson.build
index 91a0aa64c640..d6549722b50d 100644
--- a/meson.build
+++ b/meson.build
@@ -3462,14 +3462,12 @@ endif
 qom_ss = qom_ss.apply({})
 libqom = static_library('qom', qom_ss.sources() + genh,
                         dependencies: [qom_ss.dependencies()],
-                        name_suffix: 'fa',
                         build_by_default: false)
 qom = declare_dependency(link_whole: libqom)
 
 event_loop_base = files('event-loop-base.c')
 event_loop_base = static_library('event-loop-base',
                                  sources: event_loop_base + genh,
-                                 name_suffix: 'fa',
                                  build_by_default: false)
 event_loop_base = declare_dependency(link_whole: event_loop_base,
                                      dependencies: [qom])
@@ -3703,7 +3701,6 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
 authz_ss = authz_ss.apply({})
 libauthz = static_library('authz', authz_ss.sources() + genh,
                           dependencies: [authz_ss.dependencies()],
-                          name_suffix: 'fa',
                           build_by_default: false)
 
 authz = declare_dependency(link_whole: libauthz,
@@ -3712,7 +3709,6 @@ authz = declare_dependency(link_whole: libauthz,
 crypto_ss = crypto_ss.apply({})
 libcrypto = static_library('crypto', crypto_ss.sources() + genh,
                            dependencies: [crypto_ss.dependencies()],
-                           name_suffix: 'fa',
                            build_by_default: false)
 
 crypto = declare_dependency(link_whole: libcrypto,
@@ -3722,13 +3718,11 @@ io_ss = io_ss.apply({})
 libio = static_library('io', io_ss.sources() + genh,
                        dependencies: [io_ss.dependencies()],
                        link_with: libqemuutil,
-                       name_suffix: 'fa',
                        build_by_default: false)
 
 io = declare_dependency(link_whole: libio, dependencies: [crypto, qom])
 
 libmigration = static_library('migration', sources: migration_files + genh,
-                              name_suffix: 'fa',
                               build_by_default: false)
 migration = declare_dependency(link_with: libmigration,
                                dependencies: [zlib, qom, io])
@@ -3738,7 +3732,6 @@ block_ss = block_ss.apply({})
 libblock = static_library('block', block_ss.sources() + genh,
                           dependencies: block_ss.dependencies(),
                           link_depends: block_syms,
-                          name_suffix: 'fa',
                           build_by_default: false)
 
 block = declare_dependency(link_whole: [libblock],
@@ -3748,7 +3741,6 @@ block = declare_dependency(link_whole: [libblock],
 blockdev_ss = blockdev_ss.apply({})
 libblockdev = static_library('blockdev', blockdev_ss.sources() + genh,
                              dependencies: blockdev_ss.dependencies(),
-                             name_suffix: 'fa',
                              build_by_default: false)
 
 blockdev = declare_dependency(link_whole: [libblockdev],
@@ -3757,13 +3749,11 @@ blockdev = declare_dependency(link_whole: [libblockdev],
 qmp_ss = qmp_ss.apply({})
 libqmp = static_library('qmp', qmp_ss.sources() + genh,
                         dependencies: qmp_ss.dependencies(),
-                        name_suffix: 'fa',
                         build_by_default: false)
 
 qmp = declare_dependency(link_whole: [libqmp])
 
 libchardev = static_library('chardev', chardev_ss.sources() + genh,
-                            name_suffix: 'fa',
                             dependencies: chardev_ss.dependencies(),
                             build_by_default: false)
 
@@ -3771,7 +3761,6 @@ chardev = declare_dependency(link_whole: libchardev)
 
 hwcore_ss = hwcore_ss.apply({})
 libhwcore = static_library('hwcore', sources: hwcore_ss.sources() + genh,
-                           name_suffix: 'fa',
                            build_by_default: false)
 hwcore = declare_dependency(link_whole: libhwcore)
 common_ss.add(hwcore)
@@ -3807,8 +3796,7 @@ common_all = static_library('common',
                             sources: common_ss.all_sources() + genh,
                             include_directories: common_user_inc,
                             implicit_include_directories: false,
-                            dependencies: common_ss.all_dependencies(),
-                            name_suffix: 'fa')
+                            dependencies: common_ss.all_dependencies())
 
 feature_to_c = find_program('scripts/feature_to_c.py')
 
@@ -3909,8 +3897,7 @@ foreach target : target_dirs
                  objects: objects,
                  include_directories: target_inc,
                  c_args: c_args,
-                 build_by_default: false,
-                 name_suffix: 'fa')
+                 build_by_default: false)
 
   if target.endswith('-softmmu')
     execs = [{
diff --git a/stubs/blk-exp-close-all.c b/stubs/blk-exp-close-all.c
index 1c7131676392..2f68e06d7d05 100644
--- a/stubs/blk-exp-close-all.c
+++ b/stubs/blk-exp-close-all.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "block/export.h"
 
-/* Only used in programs that support block exports (libblockdev.fa) */
+/* Only used in programs that support block exports (libblockdev.a) */
 void blk_exp_close_all(void)
 {
 }
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 22045add8064..69e468a576ba 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -45,10 +45,8 @@
     exclude:
       - build/**/*.p
       - build/**/*.a.p
-      - build/**/*.fa.p
       - build/**/*.c.o
       - build/**/*.c.o.d
-      - build/**/*.fa
 
 .common_test_job_template:
   extends: .base_job_template
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index cfdff175c389..c156e6f1d90e 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -178,10 +178,8 @@ build-previous-qemu:
     exclude:
       - build-previous/**/*.p
       - build-previous/**/*.a.p
-      - build-previous/**/*.fa.p
       - build-previous/**/*.c.o
       - build-previous/**/*.c.o.d
-      - build-previous/**/*.fa
   needs:
     job: amd64-opensuse-leap-container
   variables:
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index da5721d8452b..c91e398ae726 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -19,13 +19,11 @@ gdb_system_ss = gdb_system_ss.apply({})
 
 libgdb_user = static_library('gdb_user',
                              gdb_user_ss.sources() + genh,
-                             name_suffix: 'fa',
                              c_args: '-DCONFIG_USER_ONLY',
                              build_by_default: false)
 
 libgdb_system = static_library('gdb_system',
                                 gdb_system_ss.sources() + genh,
-                                name_suffix: 'fa',
                                 build_by_default: false)
 
 gdb_user = declare_dependency(link_whole: libgdb_user)
diff --git a/tcg/meson.build b/tcg/meson.build
index 8251589fd4e9..f941413d5801 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -31,7 +31,6 @@ tcg_ss = tcg_ss.apply({})
 
 libtcg_user = static_library('tcg_user',
                              tcg_ss.sources() + genh,
-                             name_suffix: 'fa',
                              c_args: '-DCONFIG_USER_ONLY',
                              build_by_default: false)
 
@@ -41,7 +40,6 @@ user_ss.add(tcg_user)
 
 libtcg_system = static_library('tcg_system',
                                 tcg_ss.sources() + genh,
-                                name_suffix: 'fa',
                                 c_args: '-DCONFIG_SOFTMMU',
                                 build_by_default: false)
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c9d1674bd070..d39d5dd6a43e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -87,7 +87,7 @@ distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
 .PHONY: check-venv check-avocado check-acceptance check-acceptance-deprecated-warning
 
 # Build up our target list from the filtered list of ninja targets
-TARGETS=$(patsubst libqemu-%.fa, %, $(filter libqemu-%.fa, $(ninja-targets)))
+TARGETS=$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-targets)))
 
 TESTS_VENV_TOKEN=$(BUILD_DIR)/pyvenv/tests.group
 TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 3aed6efcb8d1..45b81c83ade3 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -68,7 +68,6 @@ if have_virtfs
 endif
 
 libqos = static_library('qos', libqos_srcs + genh,
-                        name_suffix: 'fa',
                         build_by_default: false)
 
 qos = declare_dependency(link_whole: libqos)

-- 
2.45.1


