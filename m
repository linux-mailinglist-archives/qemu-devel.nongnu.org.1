Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B6D70705D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 20:02:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLH9-0005Tn-DZ; Wed, 17 May 2023 13:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLF4-0002LE-FC
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLF2-0004bj-NU
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QBLkLIPImIhiMXXreUR0S6NO4vQOLpLc4SPHm9Q7bTE=;
 b=E28uFyfVN4b6MnBqTXPDvhao5H/18qnRwJhpVXIa8mvIrXaP61UCZpio+z+Rc8g+CrMklg
 uWH8VqHJ7EjxCKl+Hdm8EFyNMm47pw/8ZQ5+P1ow/8URptG7FoUQiS++6amcsb0eRDRIEY
 kGQlAhiVbo2ciCOshIRUZT535rC5PFs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-ho86Qy0iOgaKgM-f19Y7mA-1; Wed, 17 May 2023 13:47:10 -0400
X-MC-Unique: ho86Qy0iOgaKgM-f19Y7mA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f453ff4cdfso4731635e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345629; x=1686937629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBLkLIPImIhiMXXreUR0S6NO4vQOLpLc4SPHm9Q7bTE=;
 b=dz1AC8V7XxadZ8roNP+uzf5UxA8Pe3aWkZJ9LOfD2d0DIH2fWQ2v6X+CAhd5eR6qpS
 1PORf+Ke4srZ7rv88GfL/mfkxQX0Mt490xWrxFGwEV4LU3EA5ukOAQBK4xYJS1wYCoyw
 9K+gDnwL1+rRWorAWROBBwTffiu3+gceEPbB2fzde9fUMLKTaVNi0imsiSUvj9zJkUG+
 i64AuH1rRkc+U2FDA0Ycpa87KZci6GslY7I7eZ3BWHsGZKdrZE8F85SHr3Tsfn/sU0qi
 5WEUTxCfC5OLHirKqMK10Z4xChd910GEGoSKQ/OknUmJBPSs+2yWO7pWGCZDd857NP5h
 PtRw==
X-Gm-Message-State: AC+VfDzpggqhj1uR9klIWoYIemO2mW4GCjhArkOj4JJkONhEeVS2jk5E
 OFzcpp5nfZVW/pLy1dXSMfXW2Bsf2G57/Ta3Jyyi6K7EVWSbJxb7xYgB/mnmV+LQPg8Pz/Xytby
 TFg1f8vzUcJ89NziyfpUp/ytX3SXs8cxzFYhFpcMi4Fw+CozIM57HncHNeIngcc2WXmSZHCE94/
 s=
X-Received: by 2002:a7b:c014:0:b0:3f5:f52:beb1 with SMTP id
 c20-20020a7bc014000000b003f50f52beb1mr6495845wmb.12.1684345629295; 
 Wed, 17 May 2023 10:47:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7TFsNgingm7QcvhO+D204bxDN0/OPb2UjK3hfUERNf5YiwAA5nNAO8z7874ZLMkPGhByxDcw==
X-Received: by 2002:a7b:c014:0:b0:3f5:f52:beb1 with SMTP id
 c20-20020a7bc014000000b003f50f52beb1mr6495836wmb.12.1684345628943; 
 Wed, 17 May 2023 10:47:08 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 i9-20020adffc09000000b0030497b3224bsm3393796wrr.64.2023.05.17.10.47.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:47:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 66/68] configure: reorder option parsing code
Date: Wed, 17 May 2023 19:45:18 +0200
Message-Id: <20230517174520.887405-67-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Move some variable assignments around for clarity and to remove
one of three loops on the command line arguments.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 121 ++++++++++++++++++++++++++----------------------------
 1 file changed, 58 insertions(+), 63 deletions(-)

diff --git a/configure b/configure
index 2d6ff2d6cef6..9dc17aaa7c86 100755
--- a/configure
+++ b/configure
@@ -177,29 +177,18 @@ then
   error_exit "main directory cannot contain spaces nor colons"
 fi
 
+# parse CC options first; some compiler tests are used to establish
+# some defaults, based on the host environment
+
 # default parameters
 cpu=""
-static="no"
 cross_compile="no"
 cross_prefix=""
 host_cc="cc"
-use_containers="yes"
-gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
-gdb_arches=""
-
-if test -e "$source_path/.git"
-then
-    git_submodules_action="update"
-else
-    git_submodules_action="ignore"
-fi
-
-git_submodules="ui/keycodemapdb"
-git="git"
-
-# Don't accept a target_list environment variable.
-unset target_list
-unset target_list_exclude
+EXTRA_CFLAGS=""
+EXTRA_CXXFLAGS=""
+EXTRA_OBJCFLAGS=""
+EXTRA_LDFLAGS=""
 
 # Default value for a variable defining feature "foo".
 #  * foo="no"  feature will only be used if --enable-foo arg is given
@@ -212,49 +201,8 @@ unset target_list_exclude
 # Always add --enable-foo and --disable-foo command line args.
 # Distributions want to ensure that several features are compiled in, and it
 # is impossible without a --enable-foo that exits if a feature is not found.
-
 default_feature=""
-# parse CC options second
-for opt do
-  optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
-  case "$opt" in
-      --without-default-features)
-          default_feature="no"
-  ;;
-  esac
-done
 
-EXTRA_CFLAGS=""
-EXTRA_CXXFLAGS=""
-EXTRA_OBJCFLAGS=""
-EXTRA_LDFLAGS=""
-
-debug_tcg="no"
-docs="auto"
-EXESUF=""
-prefix="/usr/local"
-qemu_suffix="qemu"
-softmmu="yes"
-linux_user=""
-bsd_user=""
-pie=""
-plugins="$default_feature"
-ninja=""
-bindir="bin"
-skip_meson=no
-vfio_user_server="disabled"
-
-# The following Meson options are handled manually (still they
-# are included in the automatically generated help message)
-
-# 1. Track which submodules are needed
-fdt="auto"
-
-# 2. Automatically enable/disable other options
-tcg="auto"
-cfi="false"
-
-# parse CC options second
 for opt do
   optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
   case "$opt" in
@@ -293,9 +241,60 @@ for opt do
   --cross-prefix-*) cc_arch=${opt#--cross-prefix-}; cc_arch=${cc_arch%%=*}
                     eval "cross_prefix_${cc_arch}=\$optarg"
   ;;
+  --without-default-features) default_feature="no"
+  ;;
   esac
 done
 
+
+if test -e "$source_path/.git"
+then
+    git_submodules_action="update"
+else
+    git_submodules_action="ignore"
+fi
+
+git_submodules="ui/keycodemapdb"
+git="git"
+debug_tcg="no"
+docs="auto"
+EXESUF=""
+prefix="/usr/local"
+qemu_suffix="qemu"
+softmmu="yes"
+linux_user=""
+bsd_user=""
+plugins="$default_feature"
+ninja=""
+python=
+pypi="enabled"
+bindir="bin"
+skip_meson=no
+vfio_user_server="disabled"
+use_containers="yes"
+gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
+gdb_arches=""
+werror=""
+
+# Don't accept a target_list environment variable.
+unset target_list
+unset target_list_exclude
+
+# The following Meson options are handled manually (still they
+# are included in the automatically generated help message)
+
+# 1. Track which submodules are needed
+fdt="auto"
+
+# 2. Automatically enable/disable other options
+tcg="auto"
+cfi="false"
+
+# 3. Need to check for -static-pie before Meson runs.  Also,
+# Meson has PIE as a boolean rather than enabled/disabled/auto.
+pie=""
+static="no"
+
 # Preferred compiler:
 #  ${CC} (if set)
 #  ${cross_prefix}gcc (if cross-prefix specified)
@@ -536,8 +535,6 @@ check_py_version() {
     "$1" -c 'import sys; sys.exit(sys.version_info < (3,7))'
 }
 
-python=
-pypi="enabled"
 first_python=
 if test -z "${PYTHON}"; then
     # A bare 'python' is traditionally python 2.x, but some distros
@@ -584,8 +581,6 @@ if test "$mingw32" = "yes" ; then
   qemu_suffix=""
 fi
 
-werror=""
-
 meson_option_build_array() {
   printf '['
   (if test "$targetos" = windows; then
-- 
2.40.1


