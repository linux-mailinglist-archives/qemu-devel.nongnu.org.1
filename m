Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E963773AAC
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 16:20:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTNYT-0001DY-3Y; Tue, 08 Aug 2023 10:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYB-0001Cf-JM
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:08 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNY9-0000Co-TN
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:07 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bc7e65ea44so7149075ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691504343; x=1692109143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qumuadsDsJtyCTa73O2rn/870w3uCbJzS1LzmOVmXtY=;
 b=GsPJ2a9+BK+4U9e3NQ30cQYb+u1w4aZUlI5ipHmIVpAWum6KihaWZ+QrvqbVhEkl+G
 UQY2lg1/rV234Buobv4pkLH9AZpnLBc1Db3O87lu7bQWG8SEjIVemrV+Ct/EBphGFUtn
 U5yU98iEaSPtPHTHZzffYfvPDmLwVTcUn7Ko9mlQTGIJuV/50QhkLYAl3OxycjVWbTi2
 UJo90QF+R6NELy1ZpDHNiRbkCDUrSdl0ko8uvQiILHY3rs95KAsjbobbuRrwf03Ngwy1
 t/pVcNVWo/bR8ndrx1PdTWUfZNQyuOKj93xHzHSlhI1ag49ololJKe3CU9aUyDdrQI/9
 5YUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691504343; x=1692109143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qumuadsDsJtyCTa73O2rn/870w3uCbJzS1LzmOVmXtY=;
 b=lp6wtA/YheZx86KEjCmcb+KYv/9F4yEJoVpGI1SC1O5rUwI7llFBANoE+NhqLdVQPm
 ne7PfhX8UbLQ4ibu/D4PHhoqwgGLshv6skUqQPAuJ3VbVOhe21OkXNC1wxkmKdGsZb1s
 rPfi2bswOqW4nZzuGrObFz5JL3pGr0043/8daMkW+RGuVJLrT1L6QCwuMocroD827rpj
 ggJToQhVZdBJJ1aDhGNoi/l5ZBNHtTdz2j4faAvSeivzlsowkC9qpZo9WanuFF4FQIgE
 YUjz9F/Ymb5c8Dj+y2p5K8YD3GEhp1P5S40cr+aS1CtVzZFvSLLXMCrBbiuYgC/8G7nv
 OePg==
X-Gm-Message-State: AOJu0YwSGNa4oMT3a6ynORys/n4eUjW0akgEOIm4A2upIVa8oEwU7Cf5
 x2QgT/q5PPyv2S0aLvLA3/glfMOkAq+ovIKs
X-Google-Smtp-Source: AGHT+IE6roGROIvRAxP2tWG84pAxzXRYsgSDMHYtDcnw6Cm3b9gEyYavodecXI/9rRvkH1TZAta1Nw==
X-Received: by 2002:a17:902:f547:b0:1bc:4df5:8bfe with SMTP id
 h7-20020a170902f54700b001bc4df58bfemr11007836plf.20.1691504343399; 
 Tue, 08 Aug 2023 07:19:03 -0700 (PDT)
Received: from localhost.localdomain ([223.104.41.22])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a170902b68300b001bb1f0605b2sm9043985pls.214.2023.08.08.07.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 07:19:03 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [RFC v4 01/11] build: Implement logic for sharing cross-building
 config files
Date: Tue,  8 Aug 2023 22:17:29 +0800
Message-Id: <20230808141739.3110740-2-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 configure | 57 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/configure b/configure
index 2b41c49c0d..a076583141 100755
--- a/configure
+++ b/configure
@@ -1751,56 +1751,67 @@ if test "$ccache_cpp2" = "yes"; then
   echo "export CCACHE_CPP2=y" >> $config_host_mak
 fi
 
-# tests/tcg configuration
-(config_host_mak=tests/tcg/config-host.mak
-mkdir -p tests/tcg
-echo "# Automatically generated by configure - do not modify" > $config_host_mak
-echo "SRC_PATH=$source_path" >> $config_host_mak
-echo "HOST_CC=$host_cc" >> $config_host_mak
+# Prepare the config files for cross building.
+# This process generates 'cross-build/<target>/config-target.mak' files.
+# These files are then symlinked to the directories that need them which
+# including the TCG tests (tests/tcg/<target>) and the libnative library
+# for linux-user (common/native/<target>/).
+mkdir -p cross-build
 
-# versioned checked in the main config_host.mak above
-if test -n "$gdb_bin"; then
-    echo "HAVE_GDB_BIN=$gdb_bin" >> $config_host_mak
-fi
-if test "$plugins" = "yes" ; then
-    echo "CONFIG_PLUGIN=y" >> $config_host_mak
-fi
-
-tcg_tests_targets=
 for target in $target_list; do
   arch=${target%%-*}
-
   case $target in
     xtensa*-linux-user)
-      # the toolchain is not complete with headers, only build softmmu tests
+      # the toolchain for tests/tcg is not complete with headers
       continue
       ;;
     *-softmmu)
-      test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || continue
       qemu="qemu-system-$arch"
       ;;
     *-linux-user|*-bsd-user)
       qemu="qemu-$arch"
       ;;
   esac
-
   if probe_target_compiler $target || test -n "$container_image"; then
       test -n "$container_image" && build_static=y
-      mkdir -p "tests/tcg/$target"
-      config_target_mak=tests/tcg/$target/config-target.mak
-      ln -sf "$source_path/tests/tcg/Makefile.target" "tests/tcg/$target/Makefile"
+      mkdir -p "cross-build/$target"
+      config_target_mak=cross-build/$target/config-target.mak
       echo "# Automatically generated by configure - do not modify" > "$config_target_mak"
       echo "TARGET_NAME=$arch" >> "$config_target_mak"
       echo "TARGET=$target" >> "$config_target_mak"
-      write_target_makefile "build-tcg-tests-$target" >> "$config_target_mak"
+      write_target_makefile "$target" >> "$config_target_mak"
       echo "BUILD_STATIC=$build_static" >> "$config_target_mak"
       echo "QEMU=$PWD/$qemu" >> "$config_target_mak"
 
+      # get the interpreter prefix and the path of libnative required for native call tests
+      if [ -d "/usr/$(echo "$target_cc" | sed 's/-gcc//')" ]; then
+          echo "LD_PREFIX=/usr/$(echo "$target_cc" | sed 's/-gcc//')" >> "$config_target_mak"
+      fi
+
       # will GDB work with these binaries?
       if test "${gdb_arches#*$arch}" != "$gdb_arches"; then
           echo "HOST_GDB_SUPPORTS_ARCH=y" >> "$config_target_mak"
       fi
+  fi
+done
+
+# tests/tcg configuration
+(mkdir -p tests/tcg
+# create a symlink to the config-host.mak file in the tests/tcg
+ln -srf $config_host_mak tests/tcg/config-host.mak
+
+tcg_tests_targets=
+for target in $target_list; do
+  case $target in
+    *-softmmu)
+      test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || continue
+      ;;
+  esac
 
+  if test -f cross-build/$target/config-target.mak; then
+      mkdir -p "tests/tcg/$target"
+      ln -srf cross-build/$target/config-target.mak tests/tcg/$target/config-target.mak
+      ln -sf $source_path/tests/tcg/Makefile.target tests/tcg/$target/Makefile
       echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
       tcg_tests_targets="$tcg_tests_targets $target"
   fi
-- 
2.34.1


