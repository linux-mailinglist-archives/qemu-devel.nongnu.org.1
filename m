Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD858CFE5E
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 12:50:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXvZ-0000zo-1T; Mon, 27 May 2024 06:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sBXvW-0000zV-2t
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sBXvU-0001EI-1N
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716806999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SCjRrgAOVZ/RbqPvWVgleeumPHKestDNF1N1tpDgMds=;
 b=QGHeqgz1UYcL+K+90TVeHCFiNJmns9gDFdC2Wq9pvAq9b3quO+db25AXWNdHJS7BFOJSo7
 P1ktX7JMkXrb4PkhdWCTGz6smoWN65e4x75q5wQ7fIHTzd0GJhtA9RtrTRiU0A4GDSn54a
 4mETFWh72WGM9E0PI2BW9H/Pa9+Z7ew=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-61NMSt8QMAmtogcrGIYz7A-1; Mon, 27 May 2024 06:49:57 -0400
X-MC-Unique: 61NMSt8QMAmtogcrGIYz7A-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-579d1754c26so495453a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 03:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716806995; x=1717411795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SCjRrgAOVZ/RbqPvWVgleeumPHKestDNF1N1tpDgMds=;
 b=tskYVTapzUnZyBUjr6imLMUFrrZVwC/nuiE1G1zHb9xWLLA6T+sf++xGyE5BYuC+z+
 TKhajbi3eqKbNUPh6Qvgnn7Sqm9l0hizDQVggvNX81EHXh7alyfNHKOMbcDkStmxVhzS
 7dgzCuVzpu82IdLcJMeakMj9/Sr9+Jxd9kb+40VEirNNpLwzd6QOjMXAP2kTiXEmOQJS
 z+LHoIVYIp6k44PbBmEivAj8QJvKQNITe8MxHWS9udNP3Pn6FeDw0z58S+7OdlT2lxxS
 zVTp426Xgvpkk+aaRECfOPSWCz+ajIH6q6M4a+xhYYvfcpd4fGvifrji+kz4mazbWP7e
 jpBQ==
X-Gm-Message-State: AOJu0YzeeXbLO3NsHIuXN7Uoc/eWWWsiD0ZGdrdzVkdA7HIj0HyW0WTJ
 azqXpw9uaPNirKOj7BFwaYHAXX825MepdXEq9bR44td20OTrva7ydgoCxXhLUpOnugBW8tSqtl5
 8aIjsf+4cqeyDG2MUfhxmD2iyD6ENJsXS4lWsfRgUoh7h2lw1aHOQhCamLyTYdhq5hT3orHTwsg
 WQPYsFZUCG3NPaQqnUZ8fOTYohMvvoYoz5eM+M
X-Received: by 2002:a50:9359:0:b0:578:59a9:c6eb with SMTP id
 4fb4d7f45d1cf-57859a9cd6bmr7933978a12.15.1716806995387; 
 Mon, 27 May 2024 03:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNTn9TpKicY9kPqgV9fMKFIjDHzLv4P6f8i1CY5jd0i1egezAM12OlYgegdYc3ZXfqybkNeQ==
X-Received: by 2002:a50:9359:0:b0:578:59a9:c6eb with SMTP id
 4fb4d7f45d1cf-57859a9cd6bmr7933961a12.15.1716806994945; 
 Mon, 27 May 2024 03:49:54 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578524b5898sm5664757a12.82.2024.05.27.03.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 03:49:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com
Subject: [RFC PATCH v2 5/5] meson: Drop the .fa library suffix
Date: Mon, 27 May 2024 12:49:37 +0200
Message-ID: <20240527104937.30443-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527104937.30443-1-pbonzini@redhat.com>
References: <20240527104937.30443-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The non-standard .fa library suffix breaks the link source
de-duplication done by Meson so drop it.

The lack of link source de-duplication causes AddressSanitizer to
complain ODR violations, and makes GNU ld abort when combined with
clang's LTO.

Fortunately, the non-standard suffix is not necessary anymore for
two reasons.

First, the non-standard suffix was necessary for fork-fuzzing.
Meson wraps all standard-suffixed libraries with --start-group and
--end-group. This made a fork-fuzz.ld linker script wrapped as well and
broke builds. Commit d2e6f9272d33 ("fuzz: remove fork-fuzzing
scaffolding") dropped fork-fuzzing so we can now restore the standard
suffix.

Second, the libraries are not even built anymore, because it is
possible to just use the object files directly via extract_all_objects().

The occurences of the suffix were detected and removed by performing
a tree-wide search with 'fa' and .fa (note the quotes and dot).

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20240524-xkb-v4-4-2de564e5c859@daynix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 8f73204b7d6..f00adad3181 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -236,16 +236,11 @@ Subsystem sourcesets:
   are then turned into static libraries as follows::
 
     libchardev = static_library('chardev', chardev_ss.sources(),
-                                name_suffix: 'fa',
                                 build_by_default: false)
 
     chardev = declare_dependency(objects: libchardev.extract_all_objects(recursive: false),
                                  dependencies: chardev_ss.dependencies())
 
-  As of Meson 0.55.1, the special ``.fa`` suffix should be used for everything
-  that is used with ``link_whole``, to ensure that the link flags are placed
-  correctly in the command line.
-
 Target-independent emulator sourcesets:
   Various general purpose helper code is compiled only once and
   the .o files are linked into all output binaries that need it.
diff --git a/meson.build b/meson.build
index 84dbd7fb371..e3d4347f5bb 100644
--- a/meson.build
+++ b/meson.build
@@ -3427,7 +3427,6 @@ endif
 qom_ss = qom_ss.apply({})
 libqom = static_library('qom', qom_ss.sources() + genh,
                         dependencies: [qom_ss.dependencies()],
-                        name_suffix: 'fa',
                         build_by_default: false)
 qom = declare_dependency(objects: libqom.extract_all_objects(recursive: false),
                          dependencies: qom_ss.dependencies())
@@ -3435,7 +3434,6 @@ qom = declare_dependency(objects: libqom.extract_all_objects(recursive: false),
 event_loop_base = files('event-loop-base.c')
 event_loop_base = static_library('event-loop-base',
                                  sources: event_loop_base + genh,
-                                 name_suffix: 'fa',
                                  build_by_default: false)
 event_loop_base = declare_dependency(objects: event_loop_base.extract_all_objects(recursive: false),
                                      dependencies: [qom])
@@ -3688,7 +3686,6 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
 authz_ss = authz_ss.apply({})
 libauthz = static_library('authz', authz_ss.sources() + genh,
                           dependencies: [authz_ss.dependencies()],
-                          name_suffix: 'fa',
                           build_by_default: false)
 
 authz = declare_dependency(objects: libauthz.extract_all_objects(recursive: false),
@@ -3697,7 +3694,6 @@ authz = declare_dependency(objects: libauthz.extract_all_objects(recursive: fals
 crypto_ss = crypto_ss.apply({})
 libcrypto = static_library('crypto', crypto_ss.sources() + genh,
                            dependencies: [crypto_ss.dependencies()],
-                           name_suffix: 'fa',
                            build_by_default: false)
 
 crypto = declare_dependency(objects: libcrypto.extract_all_objects(recursive: false),
@@ -3707,14 +3703,12 @@ io_ss = io_ss.apply({})
 libio = static_library('io', io_ss.sources() + genh,
                        dependencies: [io_ss.dependencies()],
                        link_with: libqemuutil,
-                       name_suffix: 'fa',
                        build_by_default: false)
 
 io = declare_dependency(objects: libio.extract_all_objects(recursive: false),
                         dependencies: [io_ss.dependencies(), crypto, qom])
 
 libmigration = static_library('migration', sources: migration_files + genh,
-                              name_suffix: 'fa',
                               build_by_default: false)
 migration = declare_dependency(objects: libmigration.extract_all_objects(recursive: false),
                                dependencies: [qom, io])
@@ -3723,7 +3717,6 @@ system_ss.add(migration)
 block_ss = block_ss.apply({})
 libblock = static_library('block', block_ss.sources() + genh,
                           dependencies: block_ss.dependencies(),
-                          name_suffix: 'fa',
                           build_by_default: false)
 
 block = declare_dependency(objects: libblock.extract_all_objects(recursive: false),
@@ -3732,7 +3725,6 @@ block = declare_dependency(objects: libblock.extract_all_objects(recursive: fals
 blockdev_ss = blockdev_ss.apply({})
 libblockdev = static_library('blockdev', blockdev_ss.sources() + genh,
                              dependencies: blockdev_ss.dependencies(),
-                             name_suffix: 'fa',
                              build_by_default: false)
 
 blockdev = declare_dependency(objects: libblockdev.extract_all_objects(recursive: false),
@@ -3741,14 +3733,12 @@ blockdev = declare_dependency(objects: libblockdev.extract_all_objects(recursive
 qmp_ss = qmp_ss.apply({})
 libqmp = static_library('qmp', qmp_ss.sources() + genh,
                         dependencies: qmp_ss.dependencies(),
-                        name_suffix: 'fa',
                         build_by_default: false)
 
 qmp = declare_dependency(objects: libqmp.extract_all_objects(recursive: false),
                          dependencies: qmp_ss.dependencies())
 
 libchardev = static_library('chardev', chardev_ss.sources() + genh,
-                            name_suffix: 'fa',
                             dependencies: chardev_ss.dependencies(),
                             build_by_default: false)
 
@@ -3757,7 +3747,6 @@ chardev = declare_dependency(objects: libchardev.extract_all_objects(recursive:
 
 hwcore_ss = hwcore_ss.apply({})
 libhwcore = static_library('hwcore', sources: hwcore_ss.sources() + genh,
-                           name_suffix: 'fa',
                            build_by_default: false)
 hwcore = declare_dependency(objects: libhwcore.extract_all_objects(recursive: false))
 common_ss.add(hwcore)
@@ -3780,8 +3769,7 @@ common_all = static_library('common',
                             sources: common_ss.all_sources() + genh,
                             include_directories: common_user_inc,
                             implicit_include_directories: false,
-                            dependencies: common_ss.all_dependencies(),
-                            name_suffix: 'fa')
+                            dependencies: common_ss.all_dependencies())
 
 feature_to_c = find_program('scripts/feature_to_c.py')
 
@@ -3890,8 +3878,7 @@ foreach target : target_dirs
                  objects: objects,
                  include_directories: target_inc,
                  c_args: c_args,
-                 build_by_default: false,
-                 name_suffix: 'fa')
+                 build_by_default: false)
 
   if target.endswith('-softmmu')
     execs = [{
diff --git a/stubs/blk-exp-close-all.c b/stubs/blk-exp-close-all.c
index 1c713167639..2f68e06d7d0 100644
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
index 278a5ea966d..8f7ebfaed8b 100644
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
index 91c57efdede..cba1ab71331 100644
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
index c56b54eae7e..dff741ddd4d 100644
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
 
 gdb_user = declare_dependency(objects: libgdb_user.extract_all_objects(recursive: false))
diff --git a/tcg/meson.build b/tcg/meson.build
index 165e773abbe..69ebb4908a6 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -31,7 +31,6 @@ tcg_ss = tcg_ss.apply({})
 
 libtcg_user = static_library('tcg_user',
                              tcg_ss.sources() + genh,
-                             name_suffix: 'fa',
                              dependencies: tcg_ss.dependencies(),
                              c_args: '-DCONFIG_USER_ONLY',
                              build_by_default: false)
@@ -42,7 +41,6 @@ user_ss.add(tcg_user)
 
 libtcg_system = static_library('tcg_system',
                                 tcg_ss.sources() + genh,
-                                name_suffix: 'fa',
                                 dependencies: tcg_ss.dependencies(),
                                 c_args: '-DCONFIG_SOFTMMU',
                                 build_by_default: false)
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c9d1674bd07..d39d5dd6a43 100644
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
index 7825d7f6831..5b18aa4eaeb 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -68,7 +68,6 @@ if have_virtfs
 endif
 
 libqos = static_library('qos', libqos_srcs + genh,
-                        name_suffix: 'fa',
                         build_by_default: false)
 
 qos = declare_dependency(objects: libqos.extract_all_objects(recursive: false))
-- 
2.45.1


