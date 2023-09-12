Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3703779DAC8
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:29:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAwY-0000FV-BS; Tue, 12 Sep 2023 17:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwT-0000FC-96
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:05 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwQ-0007TF-FO
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:04 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68fdd5c1bbbso212436b3a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 14:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694554141; x=1695158941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wwFlKewAD3EbUW7aELNycuHcgFIWkZV/jDzQISrvf8=;
 b=JHkeIfCRIqH6kwCXysJmwbiW/54KHXpfwyc59bRrC/pUz4T1c6VIlMb5vIVPBSKOK9
 U3NpqdnUsU7udrJdnx7h6XlvXxs4L26DXXLH7FcKbWLY7Bmy0f63BXIcODSdO+VJtzzO
 np81ZHnyFtI0wBHzYEFE31ufcwYwq7tPKqO7kVUTlE+UF/goX1mRMxsn/KNSbtMaUwbW
 qM2jDWGjbvTCV25h8znVTb8zG8jXtIu1RIWcRp6lhsTfkIpGzWh6OjRFYfyInBfTVDtY
 Mw7gx5Cqb8kWO5rCsEVGjRQPytrGwzN20gSErASmRSOq6ytPo5azISyLxg6f7bUrfvOo
 DoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694554141; x=1695158941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6wwFlKewAD3EbUW7aELNycuHcgFIWkZV/jDzQISrvf8=;
 b=raVJeFk7JuFACI0zBuBmwmXJ0u078PNk6+9kgQjq9EScmPNSos08epCC0zIkcBIHgc
 ZFfzqV+lG/tgCPPWEg5t0qvdiiycZeeIFJa0g2ixmuS4vmPQn3254RQHmfztQwpLpnab
 8WCl2nJnz17c+wkfZEShpxRsoLe56Efmj49oDG4MOC/vnJv/vIihrDY1cW4BmUQjJ2Ka
 r7iD2JmwR3wDkGNob7+oowX6NDXa+3J3pmMcqvJNsSfU2bNvEXqmmLXpLE+0zaPvhm8J
 Ycvbp+ZScwNnfgaW86h0X7DjZAq+mCkHYpJSFw9UHXNEizVgK+x0Z9IAZDUMovM24BMD
 /H9w==
X-Gm-Message-State: AOJu0YxF7q63Lg+rLaLLWHgfvMbZS6igbWbeUewv3pHO3w72E+meHyun
 1cm8hunim0YNpad0tVO4Sns=
X-Google-Smtp-Source: AGHT+IHh00tfUbp3/Y/JotIxJ/UkGZ6qtccft87mC03YaSQCeqoRLxB33iis16MWhg2ZlUDYnY8C3g==
X-Received: by 2002:a05:6a20:4326:b0:149:97e4:8ae4 with SMTP id
 h38-20020a056a20432600b0014997e48ae4mr1048368pzk.0.1694554141051; 
 Tue, 12 Sep 2023 14:29:01 -0700 (PDT)
Received: from q1iq-virtual-machine.. ([114.249.236.97])
 by smtp.gmail.com with ESMTPSA id
 u20-20020aa78394000000b0068be4ce33easm7930436pfm.96.2023.09.12.14.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 14:29:00 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [RFC v6 1/9] build: Implement logic for sharing cross-building config
 files
Date: Wed, 13 Sep 2023 05:28:34 +0800
Message-Id: <20230912212842.658374-2-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
References: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x433.google.com
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


