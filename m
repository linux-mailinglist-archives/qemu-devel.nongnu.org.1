Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A70927884D9
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 12:23:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZTxk-00075T-BB; Fri, 25 Aug 2023 06:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZTxi-00075B-GD
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:22:42 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZTxg-0004js-58
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:22:42 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68a42d06d02so654340b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 03:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692958958; x=1693563758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wwFlKewAD3EbUW7aELNycuHcgFIWkZV/jDzQISrvf8=;
 b=FfbfokMldMkxgQQXx0kKqbmxCFZvS4cb+cs9FR7hxKAzVLc7NdGcwunSQxwL7zEIfX
 zffFNeD3Sgykfh+oywkQ47bSaVTVz1CRYe+buxa7dFP1rccdum5moqOGvnWQuh9Z2Lwp
 52gda9/lT/sM+qCK/4ubwmn8rTrmKEBkNtHc5bZvWb3u014KbunxMc4QsDSoJB/KU+Oc
 kaETOUZKuu+tmXtte6hJUaTxsiBVL3AZ9Y287JP1yWtJGU0oAX9idJYnzezlale0itKC
 +vJ7TIpnweU8BXYYRb76y7DLc2DpmjKtZ3ong07L+tTERBu629ZVb/vd+sLLeaa7wW27
 sBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692958958; x=1693563758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6wwFlKewAD3EbUW7aELNycuHcgFIWkZV/jDzQISrvf8=;
 b=SLkFOIEZH0THVjyhpquHn+nQ3elf4VEFtm2s5KRhbIgXDhubg5yYZlrx7rRB5NyrtQ
 wGacOWMxCdhC7gRpnqqpVcbjXqVTYk2KJq9KdY/Kd2346uFqnCBHuYDJRRqCOHip9K2Z
 2b/oVK6ebdBDCeovQ9rMyuLGPCFHn4yxuAZbd5DVlSheeSzOcnI8om3qEDxMpuCJgKyR
 WSlOyCWwpzahglfSCXPyeM9euuNhaWIdeBjvK2XN0BvAi3ZcjBL8EnOAhtvA+JenJk9t
 eLLgwIqXh1127336Do/avzKcRQw4xI0UP6d98DPzf74sC6gqEau1TjErgszKNIFu3x75
 vMEg==
X-Gm-Message-State: AOJu0YyOJN3Iu7xHOkD3p1e+Wo0g4i9LUuC4d0QRni8+xh2orhMty60i
 HhsCuHk9CyXYcDEZcL73mtI=
X-Google-Smtp-Source: AGHT+IHTLBBeFysjH/KCnxtzk5zxyxnDw7bEsW1aQq7X7CPHSC7HM6yuHRVCt9FAhaCrU1bPcjfWiw==
X-Received: by 2002:a05:6a00:2312:b0:689:efa6:5c02 with SMTP id
 h18-20020a056a00231200b00689efa65c02mr16781748pfh.11.1692958958538; 
 Fri, 25 Aug 2023 03:22:38 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.15])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa781c5000000b0068a077847c7sm1220954pfn.135.2023.08.25.03.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 03:22:38 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [RFC v5 01/10] build: Implement logic for sharing cross-building
 config files
Date: Fri, 25 Aug 2023 18:19:59 +0800
Message-Id: <20230825102009.1754699-2-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825102009.1754699-1-fufuyqqqqqq@gmail.com>
References: <20230825102009.1754699-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x42e.google.com
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

Since both TCG tests and libnative libraries require cross-building,
the config files for cross-building, config_target_mak, are now saved
in the cross-build directory for sharing. This allows TCG tests and
libnative libraries to use these config files through symbolic links
when cross-building configuration is needed.

Since config_host_mak essentially contains all the information from
the original tests/tcg/config-host.mak, the original config-host.mak
has been deleted and replaced with a symbolic link to config_host_mak.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 configure | 61 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/configure b/configure
index 2b41c49c0d..7a1e463d9c 100755
--- a/configure
+++ b/configure
@@ -1751,32 +1751,23 @@ if test "$ccache_cpp2" = "yes"; then
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
+      # skip installing config-target.mak when we have no tests to build
+      test -f "${source_path}/tests/tcg/${arch}/Makefile.softmmu-target" || continue
       qemu="qemu-system-$arch"
       ;;
     *-linux-user|*-bsd-user)
@@ -1786,22 +1777,46 @@ for target in $target_list; do
 
   if probe_target_compiler $target || test -n "$container_image"; then
       test -n "$container_image" && build_static=y
-      mkdir -p "tests/tcg/$target"
-      config_target_mak=tests/tcg/$target/config-target.mak
-      ln -sf "$source_path/tests/tcg/Makefile.target" "tests/tcg/$target/Makefile"
+      mkdir -p "cross-build/${target}"
+      config_target_mak=cross-build/${target}/config-target.mak
       echo "# Automatically generated by configure - do not modify" > "$config_target_mak"
       echo "TARGET_NAME=$arch" >> "$config_target_mak"
       echo "TARGET=$target" >> "$config_target_mak"
-      write_target_makefile "build-tcg-tests-$target" >> "$config_target_mak"
+      write_target_makefile "$target" >> "$config_target_mak"
       echo "BUILD_STATIC=$build_static" >> "$config_target_mak"
       echo "QEMU=$PWD/$qemu" >> "$config_target_mak"
 
+      # get the interpreter prefix and the path of libnative required for native call tests
+      if test -n "$target_cc" && [ -d "/usr/$(echo "$target_cc" | sed 's/-gcc//')" ]; then
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
+echo "HOST_CC=$host_cc" >> $config_host_mak
+
+tcg_tests_targets=
+for target in $target_list; do
+  case $target in
+    *-softmmu)
+      test -f "${source_path}/tests/tcg/${arch}/Makefile.softmmu-target" || continue
+      ;;
+  esac
 
-      echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
+  if test -f cross-build/${target}/config-target.mak; then
+      mkdir -p "tests/tcg/${target}"
+      ln -srf cross-build/${target}/config-target.mak tests/tcg/${target}/config-target.mak
+      ln -sf ${source_path}/tests/tcg/Makefile.target tests/tcg/${target}/Makefile
+      echo "run-tcg-tests-${target}: $qemu\$(EXESUF)" >> Makefile.prereqs
       tcg_tests_targets="$tcg_tests_targets $target"
   fi
 done
-- 
2.34.1


