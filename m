Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B097CD69E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:33:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1v5-0001tN-W7; Wed, 18 Oct 2023 04:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uz-0001rz-9o
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1ux-0003gh-DJ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ayQDGD0KDHpChZfjokOgZU/RN7AItjCsSgvYi1ccBg=;
 b=N4IxAbnv3An1BoGDxo0sNB6dhsRkx76U156QxRW1dIo/YaQpdHW6GgWSUuimH8XT78aZg7
 jSGyKc1sXxsw/sTiXlGPJDQ6UPP6TEWuXT2n/4Ih/M8sX1uFKv0jYXq8toEA4Q7ONavmQB
 /tJCp8hd30Qw3UXLjbaHwNcG4BVxRps=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-FD5--gG6Pzqhj35o3mrrxw-1; Wed, 18 Oct 2023 04:28:37 -0400
X-MC-Unique: FD5--gG6Pzqhj35o3mrrxw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99bcb13d8ddso486665166b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617715; x=1698222515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ayQDGD0KDHpChZfjokOgZU/RN7AItjCsSgvYi1ccBg=;
 b=EN2aiewjU/U2Ov5wobpIXiJTaMzgmBhNrnTsId/8BigF2n1sGd0yszscJ1daBvB7mf
 T6SQ9B5Bl30AdrbwKVyIsQduWG+msJs+fJPs1F5REWqSpx3nyovxy0LJNX24YAAvnlcj
 nxWattk/OnqHKyFRCaZd6/2yw+lfq+mtWlDVFX3jQCslmEUIJ0mtpdp2bnhH2nKG5w8E
 rJ4COUjrmX702Pmg0CrRH7K+8oO1E0l6vpAPX+HJ6o2paG9AVQLFwdj+o7EykjbQ2lGh
 tKWIN0y2ohRE7F8cFauI+lbQUxXj7Adif5v6Ykl6sNzf6juhsnCUsTUNjfVhR8joc8rq
 j7AQ==
X-Gm-Message-State: AOJu0Yw2dXKIv7caW2G5eP6+gxGycdd8cAIrJG/2ji+KDtPgfC3/E5Cg
 N4yLJZe3hhESsl9gn0A3/168C6gj/IxKs22wt6kun0piVw2L1Vb7BYo7oySMb+7eL7NoXN1pMQ/
 k7ik+qF2BubkYmOen02IvnFGnakfjQNoQlrnymxoaWCIzV+bZPoNdc4n4/gPtGd1tNmIKPx5Dz1
 U=
X-Received: by 2002:a17:906:2b89:b0:9b2:b152:b0f2 with SMTP id
 m9-20020a1709062b8900b009b2b152b0f2mr2923750ejg.10.1697617715671; 
 Wed, 18 Oct 2023 01:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGikZ8blbxOLG4dKKjdH+TaBme2S+y/rr9wx7I3x4+sUmf3qInYyLtZIraoyuZ98/1luZ/qMw==
X-Received: by 2002:a17:906:2b89:b0:9b2:b152:b0f2 with SMTP id
 m9-20020a1709062b8900b009b2b152b0f2mr2923739ejg.10.1697617715285; 
 Wed, 18 Oct 2023 01:28:35 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 bt10-20020a170906b14a00b0098884f86e41sm1151972ejb.123.2023.10.18.01.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 22/32] configure, tests/tcg: simplify GDB conditionals
Date: Wed, 18 Oct 2023 10:27:42 +0200
Message-ID: <20231018082752.322306-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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

Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
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
index 9f782054509..ffcfabb8d36 100755
--- a/configure
+++ b/configure
@@ -1140,6 +1140,18 @@ if test "$tcg" = "auto"; then
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
@@ -1660,17 +1672,7 @@ fi
 
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
@@ -1715,10 +1717,6 @@ mkdir -p tests/tcg
 echo "# Automatically generated by configure - do not modify" > $config_host_mak
 echo "SRC_PATH=$source_path" >> $config_host_mak
 
-# versioned checked in the main config_host.mak above
-if test -n "$gdb_bin"; then
-    echo "HAVE_GDB_BIN=$gdb_bin" >> $config_host_mak
-fi
 if test "$plugins" = "yes" ; then
     echo "CONFIG_PLUGIN=y" >> $config_host_mak
 fi
@@ -1755,7 +1753,7 @@ for target in $target_list; do
 
       # will GDB work with these binaries?
       if test "${gdb_arches#*$arch}" != "$gdb_arches"; then
-          echo "HOST_GDB_SUPPORTS_ARCH=y" >> "$config_target_mak"
+          echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
       echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
diff --git a/meson.build b/meson.build
index 1be9f92f7da..2bda62a2b1b 100644
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


