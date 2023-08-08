Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 613AD773A07
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 14:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTLRc-0008Fb-V6; Tue, 08 Aug 2023 08:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTLRW-00089s-8J
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTLRU-0003Dl-2u
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691496243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2GuHr7Nagyoy0KGmTBBT3OaNXGKHU2dPexBBIMs64K4=;
 b=C+WkKJgAOO3grRm7NlblDAQHOsxPwnMWpBjYaeB7db6iaAu4/37uJjr5HJgMiLn4OMdNAV
 SZ/fSTB1PoQRQLqvtAJPfCyI4i1OOHYGX0CRJeQfzaOrGr9EKSDT6c/NMyzwN3HyqVprVj
 XkMcokRpKzn9oQzgqlQtG/8Zgq88DmI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-5sCWNl74P6CTCrZpHOEJdg-1; Tue, 08 Aug 2023 08:04:01 -0400
X-MC-Unique: 5sCWNl74P6CTCrZpHOEJdg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-317ebb94d72so1108527f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 05:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691496240; x=1692101040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2GuHr7Nagyoy0KGmTBBT3OaNXGKHU2dPexBBIMs64K4=;
 b=P0ja0UDFdhrkfsvjxdjkfe0lN/mGtq0vIOFzF9NjzXG9AFIYFcMmmrcO9vIfJ1Sy4o
 d2S49lQ1dJO7G84p4pmu8Pf79+BYtZw89qjV0IrHXwrCXbbFpFPCRb3mwiBN/DgQXIM+
 si01evNc930IkyltCkOsOvVZ+YlKCv93o4zaL4cDpStmPhca/4Em4acWFh9WDz1Fd+hb
 cUHe68x7xbikX9FpRmdMm2cnKnrTa8yMrATHOgXoweaq+JzL0zJ42Sx9egT0Im+QqrUe
 WX+McRRZ/O7V5k7v8n/S+9nbaEd3GePAkqcEyUAdsXTnMuVqcow25oZuSdHuArWj/Wtl
 qofw==
X-Gm-Message-State: AOJu0YwyrSeJMkIaszJc5yEFmBO5uJNYxHXjnPiKGFKM3T0Y5TU6wxI0
 o9FPnRGbIj0ZOh7/gNerN3fQlziOZrB+J9gO1ddJKU5b1Mou6sj8Ejn/7DIfT+W5sjaqz2giyK+
 3N3ldcqPPwft4CIirG9yr9FlypcITsIOEfHyFFL43J+kDj3jXI/xZ/zbgnZuXddPmGs3skh2awj
 M=
X-Received: by 2002:adf:f5cd:0:b0:315:8a80:329e with SMTP id
 k13-20020adff5cd000000b003158a80329emr9474441wrp.40.1691496239892; 
 Tue, 08 Aug 2023 05:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb/f629k/N7iAPZv16K+GDy9RGTYtv/eup/bszNPSPwDVpHiEWwL4o2wMsUE08XsIDitHOiw==
X-Received: by 2002:adf:f5cd:0:b0:315:8a80:329e with SMTP id
 k13-20020adff5cd000000b003158a80329emr9474421wrp.40.1691496239482; 
 Tue, 08 Aug 2023 05:03:59 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 s9-20020adfecc9000000b0031416362e23sm13622369wro.3.2023.08.08.05.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 05:03:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, iii@linux.ibm.com, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 3/3] configure: unify case statements for CPU
 canonicalization
Date: Tue,  8 Aug 2023 14:03:03 +0200
Message-ID: <20230808120303.585509-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808120303.585509-1-pbonzini@redhat.com>
References: <20230808120303.585509-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

The CPU model has to be canonicalized to what Meson wants in the cross
file, to what Linux uses for its asm-$ARCH directories, and to what
QEMU uses for its user-mode emulation host/$ARCH directories.  Do
all three in a single case statement, and check that the Linux and
QEMU directories actually exist.

At a small cost in repeated lines, this ensures that there are no hidden
ordering requirements between the case statements.  In particular, commit
89e5b7935e9 ("configure: Fix linux-user host detection for riscv64",
2023-08-06) broke ppc64le because it assigned host_arch based on a
non-canonicalized version of $cpu.

Reported-by: Joel Stanley <joel@jms.id.au>
Fixes: 89e5b7935e9 ("configure: Fix linux-user host detection for riscv64", 2023-08-06)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 175 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 102 insertions(+), 73 deletions(-)

diff --git a/configure b/configure
index 484d38d81f4..24bfb9277b9 100755
--- a/configure
+++ b/configure
@@ -469,59 +469,119 @@ else
   echo "WARNING: unrecognized host CPU, proceeding with 'uname -m' output '$cpu'"
 fi
 
-case "$cpu" in
-  riscv*)
-    host_arch=riscv ;;
-  x32)
-    host_arch=x86_64 ;;
-  *)
-    host_arch="$cpu" ;;
-esac
-
-# Normalise host CPU name and set multilib cflags.  The canonicalization
-# isn't really necessary, because the architectures that we check for
-# should not hit the 'uname -m' case, but better safe than sorry.
+# Normalise host CPU name to the values used by Meson cross files and in source
+# directories, and set multilib cflags.  The canonicalization isn't really
+# necessary, because the architectures that we check for should not hit the
+# 'uname -m' case, but better safe than sorry in case --cpu= is used.
+#
 # Note that this case should only have supported host CPUs, not guests.
+# Please keep it sorted and synchronized with meson.build's host_arch.
+host_arch=
+linux_arch=
 case "$cpu" in
+  aarch64)
+    host_arch=aarch64
+    linux_arch=arm64
+    ;;
+
   armv*b|armv*l|arm)
-    cpu="arm" ;;
+    cpu=arm
+    host_arch=arm
+    linux_arch=arm
+    ;;
 
   i386|i486|i586|i686)
     cpu="i386"
-    CPU_CFLAGS="-m32" ;;
+    host_arch=i386
+    linux_arch=x86
+    CPU_CFLAGS="-m32"
+    ;;
+
+  loongarch*)
+    cpu=loongarch64
+    host_arch=loongarch64
+    ;;
+
+  mips64*)
+    cpu=mips64
+    host_arch=mips
+    linux_arch=mips
+    ;;
+  mips*)
+    cpu=mips
+    host_arch=mips
+    linux_arch=mips
+    ;;
+
+  ppc)
+    host_arch=ppc
+    linux_arch=powerpc
+    CPU_CFLAGS="-m32"
+    ;;
+  ppc64)
+    host_arch=ppc64
+    linux_arch=powerpc
+    CPU_CFLAGS="-m64 -mbig-endian"
+    ;;
+  ppc64le)
+    cpu=ppc64
+    host_arch=ppc64
+    linux_arch=powerpc
+    CPU_CFLAGS="-m64 -mlittle-endian"
+    ;;
+
+  riscv32 | riscv64)
+    host_arch=riscv
+    linux_arch=riscv
+    ;;
+
+  s390)
+    linux_arch=s390
+    CPU_CFLAGS="-m31"
+    ;;
+  s390x)
+    host_arch=s390x
+    linux_arch=s390
+    CPU_CFLAGS="-m64"
+    ;;
+
+  sparc|sun4[cdmuv])
+    cpu=sparc
+    CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc"
+    ;;
+  sparc64)
+    host_arch=sparc64
+    CPU_CFLAGS="-m64 -mcpu=ultrasparc"
+    ;;
+
   x32)
     cpu="x86_64"
-    CPU_CFLAGS="-mx32" ;;
+    host_arch=x86_64
+    linux_arch=x86
+    CPU_CFLAGS="-mx32"
+    ;;
   x86_64|amd64)
     cpu="x86_64"
+    host_arch=x86_64
+    linux_arch=x86
     # ??? Only extremely old AMD cpus do not have cmpxchg16b.
     # If we truly care, we should simply detect this case at
     # runtime and generate the fallback to serial emulation.
-    CPU_CFLAGS="-m64 -mcx16" ;;
-
-  mips*)
-    cpu="mips" ;;
-
-  ppc)
-    CPU_CFLAGS="-m32" ;;
-  ppc64)
-    CPU_CFLAGS="-m64 -mbig-endian" ;;
-  ppc64le)
-    cpu="ppc64"
-    CPU_CFLAGS="-m64 -mlittle-endian" ;;
-
-  s390)
-    CPU_CFLAGS="-m31" ;;
-  s390x)
-    CPU_CFLAGS="-m64" ;;
-
-  sparc|sun4[cdmuv])
-    cpu="sparc"
-    CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc" ;;
-  sparc64)
-    CPU_CFLAGS="-m64 -mcpu=ultrasparc" ;;
+    CPU_CFLAGS="-m64 -mcx16"
+    ;;
 esac
 
+if test -n "$host_arch" && {
+    ! test -d "$source_path/linux-user/include/host/$host_arch" ||
+    ! test -d "$source_path/common-user/host/$host_arch"; }; then
+    error_exit "linux-user/include/host/$host_arch does not exist." \
+       "This is a bug in the configure script, please report it."
+fi
+if test -n "$linux_arch" && ! test -d "$source_path/linux-headers/asm-$linux_arch"; then
+    error_exit "linux-headers/asm-$linux_arch does not exist." \
+       "This is a bug in the configure script, please report it."
+fi
+
 check_py_version() {
     # We require python >= 3.7.
     # NB: a True python conditional creates a non-zero return code (Failure)
@@ -812,7 +872,7 @@ default_target_list=""
 mak_wilds=""
 
 if [ "$linux_user" != no ]; then
-    if [ "$targetos" = linux ] && [ -d "$source_path/linux-user/include/host/$host_arch" ]; then
+    if [ "$targetos" = linux ] && [ -n "$host_arch" ]; then
         linux_user=yes
     elif [ "$linux_user" = yes ]; then
         error_exit "linux-user not supported on this architecture"
@@ -1717,40 +1777,9 @@ echo "PKG_CONFIG=${pkg_config}" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
 
-# use included Linux headers
-if test "$linux" = "yes" ; then
-  mkdir -p linux-headers
-  case "$cpu" in
-  i386|x86_64)
-    linux_arch=x86
-    ;;
-  ppc|ppc64)
-    linux_arch=powerpc
-    ;;
-  s390x)
-    linux_arch=s390
-    ;;
-  aarch64)
-    linux_arch=arm64
-    ;;
-  loongarch*)
-    linux_arch=loongarch
-    ;;
-  mips64)
-    linux_arch=mips
-    ;;
-  riscv32|riscv64)
-    linux_arch=riscv
-    ;;
-  *)
-    # For most CPUs the kernel architecture name and QEMU CPU name match.
-    linux_arch="$cpu"
-    ;;
-  esac
-    # For non-KVM architectures we will not have asm headers
-    if [ -e "$source_path/linux-headers/asm-$linux_arch" ]; then
-      symlink "$source_path/linux-headers/asm-$linux_arch" linux-headers/asm
-    fi
+# use included Linux headers for KVM architectures
+if test "$linux" = "yes" && test -n "$linux_arch"; then
+  symlink "$source_path/linux-headers/asm-$linux_arch" linux-headers/asm
 fi
 
 for target in $target_list; do
-- 
2.41.0


