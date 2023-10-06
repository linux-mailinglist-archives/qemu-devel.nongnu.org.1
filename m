Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0257BB638
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:17:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinP-0008Mv-JF; Fri, 06 Oct 2023 07:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinH-0008H9-Mt
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinE-0000Kj-AX
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vsnRu0/snRmTWvMZqVelQZHrk/C+c4xwiiTtA7NLmt8=;
 b=BBNQml+M01Td4fz38/H/l2PPv03Y9p/pKprfE+DPQGA63LPnBhRpOOdAiAIBABZ9Pav2QL
 zQajII2EXYmH1KVH79MMuf6z6YYwcUk5yuHQuXTZvync+7HxZAK9ydQI4HpJuKuDVELFaW
 iPWsW+V5fOBHswuFNH3+2GnEWmRVZ7I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-0yrRa9PmPuSgGs1L_Z6I6w-1; Fri, 06 Oct 2023 07:14:48 -0400
X-MC-Unique: 0yrRa9PmPuSgGs1L_Z6I6w-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-537a183caa3so1819921a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590886; x=1697195686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vsnRu0/snRmTWvMZqVelQZHrk/C+c4xwiiTtA7NLmt8=;
 b=ENxHcsgJeXANWfrxkvB2B9NxewGkaT37ugr2N2fCpZekvuBa1ZfxsMizhvpfi++eK7
 tr72ippFhL2MHaKl12gsyGKVnUod9bE4g/EkqMsp/fCmAOW/r1A6lUpOnslFXgZQBCf0
 S2yDo3gjuP6FUJLUZRN2I6GoijVOjrzRZvMFVJ3V1iXUJrmhYJuDtRhoFInaDNM/Cl0P
 Hg9zsvhcXqn4AbAlfASNsdH41Xz6xjgGb8soTUin0JqHyChJlxH/Ak4PscJi1pMZUaLS
 9+aQM/gMeg4miD8zbcxpWZ2AYc4wURSS2oqyZnXKC6N5g1DQ0SVktQMNYbcGjl38LBtf
 rq4Q==
X-Gm-Message-State: AOJu0Yzam1teZn9KOpFyHjDcRtgJKkyNu87uFQddRes3h+yTa4LMNVSc
 VAVMVGSkBBCfN7jbkreDG8u+gMuVpDXX+BBcN6VQdIWrxZR9Wm1QQprEJUMyWRiwTWLPfhnVeCY
 ogEo9su80BjjtI5uFkVRe481hNn3Z1SL38HNnCkmybz9DzTSR166GYl/8U2wZLEcs/DpSqTusVO
 s=
X-Received: by 2002:a05:6402:344a:b0:531:5126:cd5e with SMTP id
 l10-20020a056402344a00b005315126cd5emr7146014edc.34.1696590885994; 
 Fri, 06 Oct 2023 04:14:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJIOVMhd8G3u4ehwfZEWCxCk12z/elvOyRZCSDOPLDkbRdpCxi2k9HCet14JFvrx/yKMpuBA==
X-Received: by 2002:a05:6402:344a:b0:531:5126:cd5e with SMTP id
 l10-20020a056402344a00b005315126cd5emr7145993edc.34.1696590885556; 
 Fri, 06 Oct 2023 04:14:45 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a056402029200b0053443c8fd90sm2421124edv.24.2023.10.06.04.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/26] system: Rename softmmu/ directory as system/
Date: Fri,  6 Oct 2023 13:14:03 +0200
Message-ID: <20231006111412.13130-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The softmmu/ directory contains files specific to system
emulation. Rename it as system/. Update meson rules, the
MAINTAINERS file and all the documentation and comments.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004090629.37473-14-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                             | 44 ++++++++++++-------------
 docs/devel/qtest.rst                    |  2 +-
 include/sysemu/runstate-action.h        |  2 +-
 meson.build                             |  8 ++---
 scripts/checkpatch.pl                   |  2 +-
 scripts/coverity-scan/COMPONENTS.md     |  2 +-
 scripts/get_maintainer.pl               |  2 +-
 scripts/oss-fuzz/build.sh               |  6 ++--
 softmmu/trace.h                         |  1 -
 {softmmu => system}/arch_init.c         |  0
 {softmmu => system}/async-teardown.c    |  0
 {softmmu => system}/balloon.c           |  0
 {softmmu => system}/bootdevice.c        |  0
 {softmmu => system}/cpu-throttle.c      |  0
 {softmmu => system}/cpu-timers.c        |  0
 {softmmu => system}/cpus.c              |  0
 {softmmu => system}/datadir.c           |  0
 {softmmu => system}/device_tree.c       |  0
 {softmmu => system}/dirtylimit.c        |  0
 {softmmu => system}/dma-helpers.c       |  0
 {softmmu => system}/globals.c           |  0
 {softmmu => system}/icount.c            |  0
 {softmmu => system}/ioport.c            |  0
 {softmmu => system}/main.c              |  0
 {softmmu => system}/memory.c            |  0
 {softmmu => system}/memory_mapping.c    |  0
 {softmmu => system}/meson.build         |  0
 {softmmu => system}/physmem.c           |  6 ++--
 {softmmu => system}/qdev-monitor.c      |  0
 {softmmu => system}/qemu-seccomp.c      |  0
 {softmmu => system}/qtest.c             |  0
 {softmmu => system}/rtc.c               |  0
 {softmmu => system}/runstate-action.c   |  0
 {softmmu => system}/runstate-hmp-cmds.c |  0
 {softmmu => system}/runstate.c          |  0
 {softmmu => system}/timers-state.h      |  0
 {softmmu => system}/tpm-hmp-cmds.c      |  0
 {softmmu => system}/tpm.c               |  0
 {softmmu => system}/trace-events        |  0
 system/trace.h                          |  1 +
 {softmmu => system}/vl.c                |  0
 {softmmu => system}/watchpoint.c        |  0
 tests/unit/meson.build                  |  2 +-
 43 files changed, 40 insertions(+), 38 deletions(-)
 delete mode 100644 softmmu/trace.h
 rename {softmmu => system}/arch_init.c (100%)
 rename {softmmu => system}/async-teardown.c (100%)
 rename {softmmu => system}/balloon.c (100%)
 rename {softmmu => system}/bootdevice.c (100%)
 rename {softmmu => system}/cpu-throttle.c (100%)
 rename {softmmu => system}/cpu-timers.c (100%)
 rename {softmmu => system}/cpus.c (100%)
 rename {softmmu => system}/datadir.c (100%)
 rename {softmmu => system}/device_tree.c (100%)
 rename {softmmu => system}/dirtylimit.c (100%)
 rename {softmmu => system}/dma-helpers.c (100%)
 rename {softmmu => system}/globals.c (100%)
 rename {softmmu => system}/icount.c (100%)
 rename {softmmu => system}/ioport.c (100%)
 rename {softmmu => system}/main.c (100%)
 rename {softmmu => system}/memory.c (100%)
 rename {softmmu => system}/memory_mapping.c (100%)
 rename {softmmu => system}/meson.build (100%)
 rename {softmmu => system}/physmem.c (99%)
 rename {softmmu => system}/qdev-monitor.c (100%)
 rename {softmmu => system}/qemu-seccomp.c (100%)
 rename {softmmu => system}/qtest.c (100%)
 rename {softmmu => system}/rtc.c (100%)
 rename {softmmu => system}/runstate-action.c (100%)
 rename {softmmu => system}/runstate-hmp-cmds.c (100%)
 rename {softmmu => system}/runstate.c (100%)
 rename {softmmu => system}/timers-state.h (100%)
 rename {softmmu => system}/tpm-hmp-cmds.c (100%)
 rename {softmmu => system}/tpm.c (100%)
 rename {softmmu => system}/trace-events (100%)
 create mode 100644 system/trace.h
 rename {softmmu => system}/vl.c (100%)
 rename {softmmu => system}/watchpoint.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81625f036bd..2ddc3413b0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -137,8 +137,8 @@ Overall TCG CPUs
 M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-F: softmmu/cpus.c
-F: softmmu/watchpoint.c
+F: system/cpus.c
+F: system/watchpoint.c
 F: cpus-common.c
 F: page-vary.c
 F: page-vary-common.c
@@ -2108,7 +2108,7 @@ S: Maintained
 F: docs/interop/virtio-balloon-stats.rst
 F: hw/virtio/virtio-balloon*.c
 F: include/hw/virtio/virtio-balloon.h
-F: softmmu/balloon.c
+F: system/balloon.c
 F: include/sysemu/balloon.h
 
 virtio-9p
@@ -2788,7 +2788,7 @@ Device Tree
 M: Alistair Francis <alistair.francis@wdc.com>
 R: David Gibson <david@gibson.dropbear.id.au>
 S: Maintained
-F: softmmu/device_tree.c
+F: system/device_tree.c
 F: include/sysemu/device_tree.h
 
 Dump
@@ -2844,11 +2844,11 @@ F: include/exec/memory.h
 F: include/exec/ram_addr.h
 F: include/exec/ramblock.h
 F: include/sysemu/memory_mapping.h
-F: softmmu/dma-helpers.c
-F: softmmu/ioport.c
-F: softmmu/memory.c
-F: softmmu/memory_mapping.c
-F: softmmu/physmem.c
+F: system/dma-helpers.c
+F: system/ioport.c
+F: system/memory.c
+F: system/memory_mapping.c
+F: system/physmem.c
 F: include/exec/memory-internal.h
 F: scripts/coccinelle/memory-region-housekeeping.cocci
 
@@ -2901,13 +2901,13 @@ F: include/sysemu/runstate.h
 F: include/sysemu/runstate-action.h
 F: util/main-loop.c
 F: util/qemu-timer.c
-F: softmmu/vl.c
-F: softmmu/main.c
-F: softmmu/cpus.c
-F: softmmu/cpu-throttle.c
-F: softmmu/cpu-timers.c
-F: softmmu/icount.c
-F: softmmu/runstate*
+F: system/vl.c
+F: system/main.c
+F: system/cpus.c
+F: system/cpu-throttle.c
+F: system/cpu-timers.c
+F: system/icount.c
+F: system/runstate*
 F: qapi/run-state.json
 
 Read, Copy, Update (RCU)
@@ -3081,7 +3081,7 @@ F: qapi/qom.json
 F: qapi/qdev.json
 F: scripts/coccinelle/qom-parent-type.cocci
 F: scripts/qom-cast-macro-clean-cocci-gen.py
-F: softmmu/qdev-monitor.c
+F: system/qdev-monitor.c
 F: stubs/qdev.c
 F: qom/
 F: tests/unit/check-qom-interface.c
@@ -3115,7 +3115,7 @@ M: Thomas Huth <thuth@redhat.com>
 M: Laurent Vivier <lvivier@redhat.com>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-F: softmmu/qtest.c
+F: system/qtest.c
 F: accel/qtest/
 F: tests/qtest/
 F: docs/devel/qgraph.rst
@@ -3191,7 +3191,7 @@ F: scripts/simpletrace.py
 TPM
 M: Stefan Berger <stefanb@linux.ibm.com>
 S: Maintained
-F: softmmu/tpm*
+F: system/tpm*
 F: hw/tpm/*
 F: include/hw/acpi/tpm.h
 F: include/sysemu/tpm*
@@ -3226,7 +3226,7 @@ F: util/userfaultfd.c
 Migration dirty limit and dirty page rate
 M: Hyman Huang <yong.huang@smartx.com>
 S: Maintained
-F: softmmu/dirtylimit.c
+F: system/dirtylimit.c
 F: include/sysemu/dirtylimit.h
 F: migration/dirtyrate.c
 F: migration/dirtyrate.h
@@ -3250,7 +3250,7 @@ F: scripts/xml-preprocess*
 Seccomp
 M: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
-F: softmmu/qemu-seccomp.c
+F: system/qemu-seccomp.c
 F: include/sysemu/seccomp.h
 F: tests/unit/test-seccomp.c
 
@@ -3669,7 +3669,7 @@ T: git https://github.com/stefanha/qemu.git block
 Bootdevice
 M: Gonglei <arei.gonglei@huawei.com>
 S: Maintained
-F: softmmu/bootdevice.c
+F: system/bootdevice.c
 
 Quorum
 M: Alberto Garcia <berto@igalia.com>
diff --git a/docs/devel/qtest.rst b/docs/devel/qtest.rst
index 0455aa06ab2..c5b8546b3eb 100644
--- a/docs/devel/qtest.rst
+++ b/docs/devel/qtest.rst
@@ -81,7 +81,7 @@ which you can run manually.
 QTest Protocol
 --------------
 
-.. kernel-doc:: softmmu/qtest.c
+.. kernel-doc:: system/qtest.c
    :doc: QTest Protocol
 
 
diff --git a/include/sysemu/runstate-action.h b/include/sysemu/runstate-action.h
index cff45a047bf..db4e3099ae5 100644
--- a/include/sysemu/runstate-action.h
+++ b/include/sysemu/runstate-action.h
@@ -11,7 +11,7 @@
 
 #include "qapi/qapi-commands-run-state.h"
 
-/* in softmmu/runstate-action.c */
+/* in system/runstate-action.c */
 extern RebootAction reboot_action;
 extern ShutdownAction shutdown_action;
 extern PanicAction panic_action;
diff --git a/meson.build b/meson.build
index 497a85eb9fe..05387853af8 100644
--- a/meson.build
+++ b/meson.build
@@ -3307,7 +3307,7 @@ if have_system
     'hw/gpio',
     'migration',
     'net',
-    'softmmu',
+    'system',
     'ui',
     'hw/remote',
   ]
@@ -3434,7 +3434,7 @@ endif
 common_ss.add(files('cpus-common.c'))
 specific_ss.add(files('cpu.c'))
 
-subdir('softmmu')
+subdir('system')
 
 # Work around a gcc bug/misfeature wherein constant propagation looks
 # through an alias:
@@ -3813,14 +3813,14 @@ foreach target : target_dirs
     execs = [{
       'name': 'qemu-system-' + target_name,
       'win_subsystem': 'console',
-      'sources': files('softmmu/main.c'),
+      'sources': files('system/main.c'),
       'dependencies': []
     }]
     if targetos == 'windows' and (sdl.found() or gtk.found())
       execs += [{
         'name': 'qemu-system-' + target_name + 'w',
         'win_subsystem': 'windows',
-        'sources': files('softmmu/main.c'),
+        'sources': files('system/main.c'),
         'dependencies': []
       }]
     endif
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1ad9ccb74ba..6e4100d2a41 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -466,7 +466,7 @@ sub top_of_kernel_tree {
 	my @tree_check = (
 		"COPYING", "MAINTAINERS", "Makefile",
 		"README.rst", "docs", "VERSION",
-		"linux-user", "softmmu"
+		"linux-user", "system"
 	);
 
 	foreach my $check (@tree_check) {
diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 883da95aff2..0e62f10aad3 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -148,7 +148,7 @@ tcg
   ~ (/qemu)?(/accel/tcg|/replay|/tcg)/.*
 
 sysemu
-  ~ (/qemu)?(/softmmu/.*|/accel/.*)
+  ~ (/qemu)?(/system/.*|/accel/.*)
 
 (headers)
   ~ (/qemu)?(/include/.*)
diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index e5499b94b4f..02fa828100e 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -796,7 +796,7 @@ sub top_of_tree {
         && (-d "${lk_path}docs")
         && (-f "${lk_path}VERSION")
         && (-d "${lk_path}linux-user/")
-        && (-d "${lk_path}softmmu/")) {
+        && (-d "${lk_path}system/")) {
 	return 1;
     }
     return 0;
diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index 3bda0d72c72..5238f833435 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -43,10 +43,10 @@ EXTRA_CFLAGS="$CFLAGS -U __OPTIMIZE__"
 if ! { [ -e "./COPYING" ] &&
    [ -e "./MAINTAINERS" ] &&
    [ -e "./Makefile" ] &&
-   [ -e "./docs" ] &&
+   [ -d "./docs" ] &&
    [ -e "./VERSION" ] &&
-   [ -e "./linux-user" ] &&
-   [ -e "./softmmu" ];} ; then
+   [ -d "./linux-user" ] &&
+   [ -d "./system" ];} ; then
     fatal "Please run the script from the top of the QEMU tree"
 fi
 
diff --git a/softmmu/trace.h b/softmmu/trace.h
deleted file mode 100644
index 2ad10115726..00000000000
--- a/softmmu/trace.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "trace/trace-softmmu.h"
diff --git a/softmmu/arch_init.c b/system/arch_init.c
similarity index 100%
rename from softmmu/arch_init.c
rename to system/arch_init.c
diff --git a/softmmu/async-teardown.c b/system/async-teardown.c
similarity index 100%
rename from softmmu/async-teardown.c
rename to system/async-teardown.c
diff --git a/softmmu/balloon.c b/system/balloon.c
similarity index 100%
rename from softmmu/balloon.c
rename to system/balloon.c
diff --git a/softmmu/bootdevice.c b/system/bootdevice.c
similarity index 100%
rename from softmmu/bootdevice.c
rename to system/bootdevice.c
diff --git a/softmmu/cpu-throttle.c b/system/cpu-throttle.c
similarity index 100%
rename from softmmu/cpu-throttle.c
rename to system/cpu-throttle.c
diff --git a/softmmu/cpu-timers.c b/system/cpu-timers.c
similarity index 100%
rename from softmmu/cpu-timers.c
rename to system/cpu-timers.c
diff --git a/softmmu/cpus.c b/system/cpus.c
similarity index 100%
rename from softmmu/cpus.c
rename to system/cpus.c
diff --git a/softmmu/datadir.c b/system/datadir.c
similarity index 100%
rename from softmmu/datadir.c
rename to system/datadir.c
diff --git a/softmmu/device_tree.c b/system/device_tree.c
similarity index 100%
rename from softmmu/device_tree.c
rename to system/device_tree.c
diff --git a/softmmu/dirtylimit.c b/system/dirtylimit.c
similarity index 100%
rename from softmmu/dirtylimit.c
rename to system/dirtylimit.c
diff --git a/softmmu/dma-helpers.c b/system/dma-helpers.c
similarity index 100%
rename from softmmu/dma-helpers.c
rename to system/dma-helpers.c
diff --git a/softmmu/globals.c b/system/globals.c
similarity index 100%
rename from softmmu/globals.c
rename to system/globals.c
diff --git a/softmmu/icount.c b/system/icount.c
similarity index 100%
rename from softmmu/icount.c
rename to system/icount.c
diff --git a/softmmu/ioport.c b/system/ioport.c
similarity index 100%
rename from softmmu/ioport.c
rename to system/ioport.c
diff --git a/softmmu/main.c b/system/main.c
similarity index 100%
rename from softmmu/main.c
rename to system/main.c
diff --git a/softmmu/memory.c b/system/memory.c
similarity index 100%
rename from softmmu/memory.c
rename to system/memory.c
diff --git a/softmmu/memory_mapping.c b/system/memory_mapping.c
similarity index 100%
rename from softmmu/memory_mapping.c
rename to system/memory_mapping.c
diff --git a/softmmu/meson.build b/system/meson.build
similarity index 100%
rename from softmmu/meson.build
rename to system/meson.build
diff --git a/softmmu/physmem.c b/system/physmem.c
similarity index 99%
rename from softmmu/physmem.c
rename to system/physmem.c
index 309653c7221..edc3ed8ab90 100644
--- a/softmmu/physmem.c
+++ b/system/physmem.c
@@ -2301,8 +2301,10 @@ RAMBlock *qemu_ram_block_by_name(const char *name)
     return NULL;
 }
 
-/* Some of the softmmu routines need to translate from a host pointer
-   (typically a TLB entry) back to a ram offset.  */
+/*
+ * Some of the system routines need to translate from a host pointer
+ * (typically a TLB entry) back to a ram offset.
+ */
 ram_addr_t qemu_ram_addr_from_host(void *ptr)
 {
     RAMBlock *block;
diff --git a/softmmu/qdev-monitor.c b/system/qdev-monitor.c
similarity index 100%
rename from softmmu/qdev-monitor.c
rename to system/qdev-monitor.c
diff --git a/softmmu/qemu-seccomp.c b/system/qemu-seccomp.c
similarity index 100%
rename from softmmu/qemu-seccomp.c
rename to system/qemu-seccomp.c
diff --git a/softmmu/qtest.c b/system/qtest.c
similarity index 100%
rename from softmmu/qtest.c
rename to system/qtest.c
diff --git a/softmmu/rtc.c b/system/rtc.c
similarity index 100%
rename from softmmu/rtc.c
rename to system/rtc.c
diff --git a/softmmu/runstate-action.c b/system/runstate-action.c
similarity index 100%
rename from softmmu/runstate-action.c
rename to system/runstate-action.c
diff --git a/softmmu/runstate-hmp-cmds.c b/system/runstate-hmp-cmds.c
similarity index 100%
rename from softmmu/runstate-hmp-cmds.c
rename to system/runstate-hmp-cmds.c
diff --git a/softmmu/runstate.c b/system/runstate.c
similarity index 100%
rename from softmmu/runstate.c
rename to system/runstate.c
diff --git a/softmmu/timers-state.h b/system/timers-state.h
similarity index 100%
rename from softmmu/timers-state.h
rename to system/timers-state.h
diff --git a/softmmu/tpm-hmp-cmds.c b/system/tpm-hmp-cmds.c
similarity index 100%
rename from softmmu/tpm-hmp-cmds.c
rename to system/tpm-hmp-cmds.c
diff --git a/softmmu/tpm.c b/system/tpm.c
similarity index 100%
rename from softmmu/tpm.c
rename to system/tpm.c
diff --git a/softmmu/trace-events b/system/trace-events
similarity index 100%
rename from softmmu/trace-events
rename to system/trace-events
diff --git a/system/trace.h b/system/trace.h
new file mode 100644
index 00000000000..cd0136dcdc1
--- /dev/null
+++ b/system/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-system.h"
diff --git a/softmmu/vl.c b/system/vl.c
similarity index 100%
rename from softmmu/vl.c
rename to system/vl.c
diff --git a/softmmu/watchpoint.c b/system/watchpoint.c
similarity index 100%
rename from softmmu/watchpoint.c
rename to system/watchpoint.c
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 0299ef6906c..e7d72ee80a9 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -58,7 +58,7 @@ if have_system or have_tools
   }
 
   if seccomp.found()
-    tests += {'test-seccomp': ['../../softmmu/qemu-seccomp.c', seccomp]}
+    tests += {'test-seccomp': ['../../system/qemu-seccomp.c', seccomp]}
   endif
 endif
 
-- 
2.41.0


