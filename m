Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CBD7C9FAC
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:34:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH8s-0003wy-2C; Mon, 16 Oct 2023 02:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8q-0003uM-4j
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8o-0005SM-4O
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UrHZ5GRzW8lQtPg843T6Htzc+QHUFHYsEY4Zs9sIB4w=;
 b=Ck+Mxs58cn2UMG2dgnbXuDAaMxRx4XWlIExnOeK/sV3xUKZMI1c1Rn32G+6JJM8CcHS9bT
 AHMv7+25XbncVjC1D37Fu+mjAezLI+XZNqULva0Y4iiZ1BKwF+S6WoErAbVhxI67IPHGp8
 TgD+zRmTfyAkN/2ydxIyWHhN7XVwmsY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-jQtmKb20MdKSxSQaMjqRaQ-1; Mon, 16 Oct 2023 02:31:47 -0400
X-MC-Unique: jQtmKb20MdKSxSQaMjqRaQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c5073588cbso22571191fa.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437905; x=1698042705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UrHZ5GRzW8lQtPg843T6Htzc+QHUFHYsEY4Zs9sIB4w=;
 b=h2keN6BfUQjgzhe61WxMu/seU2yd4WTNabUplWOVFv983SCXZDQ1b8yUx4JvQutaPK
 q3oUyRew8ans4le0dOKyQYRvfuICwB8+X1oB9RWtKR4h1tnZxtH/T33rvrB33RdC+5Hq
 TvQ/7ZHa2UTct3s3YLFEZ1ON5sfE2Cc53JIKpsdSSPI/Cv585zECX9lJtVE+Nbye80kD
 BoYMI8dWX8AEr2jmRO97n8zrhjnqUlqfw1630YhHBGG8RODpNEgyO5lEYaOY8UNPcNAg
 UX7WEazS0y7j5Sd8a1cjPRQGDxDWPWpZuwyRBTJEYYeIfHDKLVqtqV+k+o0rsCf7cdGx
 vBgw==
X-Gm-Message-State: AOJu0Yx9CCd0CANOtMXiIEMwqcOqqWH01mrlxFSDXYMYMCd2tdnjqXZ6
 kQPCbRA7Aohz0KrtGOl3Qrff20Vf96ZciRjyV21M724Kwb4nJgsvEhcdR0mt740SrkQ52Ht5AWu
 +hueqb+a41817nuhPcoKJJvVdX5F3BeXvrENTAMSac5+PHWH1Y2kq2x5xmnsCfrod8dmJTnAKsY
 c=
X-Received: by 2002:a2e:b2d4:0:b0:2c5:19ea:b6ac with SMTP id
 20-20020a2eb2d4000000b002c519eab6acmr2842191ljz.21.1697437905318; 
 Sun, 15 Oct 2023 23:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz6vF9qFSFNLaIHkjitheYt2SfBmp/5316YZYRGkto31nAklo/j1xnUSkl9UAt70cbvhQO1g==
X-Received: by 2002:a2e:b2d4:0:b0:2c5:19ea:b6ac with SMTP id
 20-20020a2eb2d4000000b002c519eab6acmr2842170ljz.21.1697437904773; 
 Sun, 15 Oct 2023 23:31:44 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 y25-20020a1709063a9900b009ae3e6c342asm3382543ejd.111.2023.10.15.23.31.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/17] configure, tests/tcg: simplify GDB conditionals
Date: Mon, 16 Oct 2023 08:31:18 +0200
Message-ID: <20231016063127.161204-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Unify HAVE_GDB_BIN (currently in config-host.mak) and
HOST_GDB_SUPPORTS_ARCH into a single GDB variable in
config-target.mak.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                     | 30 +++++++++----------
 meson.build                                   |  4 +--
 tests/tcg/aarch64/Makefile.target             |  6 ++--
 tests/tcg/multiarch/Makefile.target           | 18 ++++-------
 .../multiarch/system/Makefile.softmmu-target  | 15 ++++------
 tests/tcg/s390x/Makefile.target               |  6 ++--
 6 files changed, 33 insertions(+), 46 deletions(-)

diff --git a/configure b/configure
index 3da46ed202d..732220fdd45 100755
--- a/configure
+++ b/configure
@@ -1136,6 +1136,18 @@ if test "$tcg" = "auto"; then
   fi
 fi
 
+#########################################
+# gdb test
+
+if test -n "$gdb_bin"; then
+    gdb_version=$($gdb_bin --version | head -n 1)
+    if version_ge ${gdb_version##* } 9.1; then
+        gdb_arches=$($python "$source_path/scripts/probe-gdb-support.py" $gdb_bin)
+    else
+        gdb_bin=""
+    fi
+fi
+
 ##########################################
 # big/little endian test
 cat > $TMPC << EOF
@@ -1656,17 +1668,7 @@ fi
 
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
-
-if test -n "$gdb_bin"; then
-    gdb_version=$($gdb_bin --version | head -n 1)
-    if version_ge ${gdb_version##* } 9.1; then
-        echo "HAVE_GDB_BIN=$gdb_bin" >> $config_host_mak
-        gdb_arches=$($python "$source_path/scripts/probe-gdb-support.py" $gdb_bin)
-    else
-        gdb_bin=""
-    fi
-fi
-
+echo "GDB=$gdb_bin" >> $config_host_mak
 if test "$container" != no; then
     echo "RUNC=$runc" >> $config_host_mak
 fi
@@ -1711,10 +1713,6 @@ mkdir -p tests/tcg
 echo "# Automatically generated by configure - do not modify" > $config_host_mak
 echo "SRC_PATH=$source_path" >> $config_host_mak
 
-# versioned checked in the main config_host.mak above
-if test -n "$gdb_bin"; then
-    echo "HAVE_GDB_BIN=$gdb_bin" >> $config_host_mak
-fi
 if test "$plugins" = "yes" ; then
     echo "CONFIG_PLUGIN=y" >> $config_host_mak
 fi
@@ -1751,7 +1749,7 @@ for target in $target_list; do
 
       # will GDB work with these binaries?
       if test "${gdb_arches#*$arch}" != "$gdb_arches"; then
-          echo "HOST_GDB_SUPPORTS_ARCH=y" >> "$config_target_mak"
+          echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
       echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
diff --git a/meson.build b/meson.build
index 251838f2609..87bb4e9243a 100644
--- a/meson.build
+++ b/meson.build
@@ -4021,8 +4021,8 @@ summary(summary_info, bool_yn: true, section: 'Directories')
 summary_info = {}
 summary_info += {'python':            '@0@ (version: @1@)'.format(python.full_path(), python.language_version())}
 summary_info += {'sphinx-build':      sphinx_build}
-if config_host.has_key('HAVE_GDB_BIN')
-  summary_info += {'gdb':             config_host['HAVE_GDB_BIN']}
+if config_host.has_key('GDB')
+  summary_info += {'gdb':             config_host['GDB']}
 endif
 summary_info += {'iasl':              iasl}
 summary_info += {'genisoimage':       config_host['GENISOIMAGE']}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index d01b8ff47c8..62b38c792fb 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -105,19 +105,19 @@ sha512-sve: sha512.c
 
 TESTS += sha512-sve
 
-ifeq ($(HOST_GDB_SUPPORTS_ARCH),y)
+ifneq ($(GDB),)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
 
 run-gdbstub-sysregs: sysregs
 	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(HAVE_GDB_BIN) \
+		--gdb $(GDB) \
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve.py, \
 	basic gdbstub SVE support)
 
 run-gdbstub-sve-ioctls: sve-ioctls
 	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(HAVE_GDB_BIN) \
+		--gdb $(GDB) \
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
 	basic gdbstub SVE ZLEN support)
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 43bddeaf212..f3bfaf1a228 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -63,45 +63,39 @@ run-test-mmap: test-mmap
 run-test-mmap-%: test-mmap
 	$(call run-test, test-mmap-$*, $(QEMU) -p $* $<, $< ($* byte pages))
 
-ifneq ($(HAVE_GDB_BIN),)
-ifeq ($(HOST_GDB_SUPPORTS_ARCH),y)
+ifneq ($(GDB),)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
 
 run-gdbstub-sha1: sha1
 	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(HAVE_GDB_BIN) \
+		--gdb $(GDB) \
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/sha1.py, \
 	basic gdbstub support)
 
 run-gdbstub-qxfer-auxv-read: sha1
 	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(HAVE_GDB_BIN) \
+		--gdb $(GDB) \
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-auxv-read.py, \
 	basic gdbstub qXfer:auxv:read support)
 
 run-gdbstub-proc-mappings: sha1
 	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(HAVE_GDB_BIN) \
+		--gdb $(GDB) \
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-proc-mappings.py, \
 	proc mappings support)
 
 run-gdbstub-thread-breakpoint: testthread
 	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(HAVE_GDB_BIN) \
+		--gdb $(GDB) \
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-thread-breakpoint.py, \
 	hitting a breakpoint on non-main thread)
-
 else
 run-gdbstub-%:
-	$(call skip-test, "gdbstub test $*", "no guest arch support")
-endif
-else
-run-gdbstub-%:
-	$(call skip-test, "gdbstub test $*", "need working gdb")
+	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
 endif
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
index 90810a32b2f..dee4f58dea1 100644
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
@@ -14,13 +14,12 @@ VPATH+=$(MULTIARCH_SYSTEM_SRC)
 MULTIARCH_TEST_SRCS=$(wildcard $(MULTIARCH_SYSTEM_SRC)/*.c)
 MULTIARCH_TESTS = $(patsubst $(MULTIARCH_SYSTEM_SRC)/%.c, %, $(MULTIARCH_TEST_SRCS))
 
-ifneq ($(HAVE_GDB_BIN),)
-ifeq ($(HOST_GDB_SUPPORTS_ARCH),y)
+ifneq ($(GDB),)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
 
 run-gdbstub-memory: memory
 	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(HAVE_GDB_BIN) \
+		--gdb $(GDB) \
 		--qemu $(QEMU) \
 		--output $<.gdb.out \
 		--qargs \
@@ -29,7 +28,7 @@ run-gdbstub-memory: memory
 	softmmu gdbstub support)
 run-gdbstub-interrupt: interrupt
 	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(HAVE_GDB_BIN) \
+		--gdb $(GDB) \
 		--qemu $(QEMU) \
 		--output $<.gdb.out \
 		--qargs \
@@ -38,7 +37,7 @@ run-gdbstub-interrupt: interrupt
 	softmmu gdbstub support)
 run-gdbstub-untimely-packet: hello
 	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(HAVE_GDB_BIN) \
+		--gdb $(GDB) \
 		--gdb-args "-ex 'set debug remote 1'" \
 		--output untimely-packet.gdb.out \
 		--stderr untimely-packet.gdb.err \
@@ -51,11 +50,7 @@ run-gdbstub-untimely-packet: hello
 		"GREP", file untimely-packet.gdb.err)
 else
 run-gdbstub-%:
-	$(call skip-test, "gdbstub test $*", "no guest arch support")
-endif
-else
-run-gdbstub-%:
-	$(call skip-test, "gdbstub test $*", "need working gdb")
+	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
 endif
 
 MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-interrupt run-gdbstub-untimely-packet
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index c650aefe5c1..826f0a18e43 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -81,12 +81,12 @@ $(Z15_TESTS): CFLAGS+=-march=z15 -O2
 TESTS+=$(Z15_TESTS)
 endif
 
-ifeq ($(HOST_GDB_SUPPORTS_ARCH),y)
+ifneq ($(GDB),)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
 
 run-gdbstub-signals-s390x: signals-s390x
 	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(HAVE_GDB_BIN) \
+		--gdb $(GDB) \
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(S390X_SRC)/gdbstub/test-signals-s390x.py, \
 	mixing signals and debugging)
@@ -95,7 +95,7 @@ hello-s390x-asm: CFLAGS+=-nostdlib
 
 run-gdbstub-svc: hello-s390x-asm
 	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(HAVE_GDB_BIN) \
+		--gdb $(GDB) \
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(S390X_SRC)/gdbstub/test-svc.py, \
 	single-stepping svc)
-- 
2.41.0


