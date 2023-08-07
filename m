Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E89771D8C
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:52:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwql-0001jA-GQ; Mon, 07 Aug 2023 05:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qSwqd-0001Qf-OY
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qSwqb-0003QB-94
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691401700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3m7nJP1sARQaVcmpbe4gbFwTpqCf6ysJLtpJr+yDhU=;
 b=VbFaU/ftlD6QmxC1YyHIXC/lhj7MGNsDsL9c/gNUhu7xLyQlY3d8WTRMJ6HXCA9iP10nzF
 LpagSk/+/2BPpFxt1NrMmhDDtXPUoRyL36SEhO1eVJ/JemqM6C4udOcyB7ZlJ5jsuLlTJ+
 TOTb7Jww1o9oEE8qe4qFh3xkD+FI4ug=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-EzVG6EctNIS5L2F9rNzk4Q-1; Mon, 07 Aug 2023 05:48:18 -0400
X-MC-Unique: EzVG6EctNIS5L2F9rNzk4Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe4cca36b7so14777305e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 02:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691401697; x=1692006497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w3m7nJP1sARQaVcmpbe4gbFwTpqCf6ysJLtpJr+yDhU=;
 b=iDjt8whGJmAPz2xrkw1C2wiSSzy1VN8g7a6dla3xHbCihOgkmAt//rqQi4Wu/8lzUq
 w/BPBDq9hJOvIOFCSOsTSFZQD5Y8HV3CsKdeSqsF4I2zXEIBS/Ifgdte0El6LqGxtnkb
 jPzuhpLc0OPeLmSfOJwv1QG5r+ZpflcWuF5me9Zgl381TAHuwzMh96GFb9PCAlrDhQMx
 5gmlq8yKzsfYbsT945uImymxcc2rbIyaRJ2iv2ZMOPDgtBnZCucKMaNYvClNQPI9k1ug
 cogC0wypR1AX6owAM5q9iNhi5FS0G2tod6hS6gY9u3v0oi7FCh3XqqGVV106DAAZJcGW
 eFXg==
X-Gm-Message-State: AOJu0Yxy9JVIfZdJV+HnNQIo4Van1E5NBXSx6S3Hx/+jBopW1D6vA8hv
 iLm3hBwyXU7G8OIGtp6LBTX3yraU56FA1BrKu3T9kIZpmmjUz5Zpsmr/URor67IsLFP1/H9Wjtw
 KwbyXqHyV5gS4ysG+AycgtY2dGYiA3+8VsG9pDe4S3P6mHhqjd/LEJD9NwsDkJHeJTsLclEQiF4
 A=
X-Received: by 2002:a1c:7912:0:b0:3fb:e2af:49f6 with SMTP id
 l18-20020a1c7912000000b003fbe2af49f6mr6278999wme.39.1691401696956; 
 Mon, 07 Aug 2023 02:48:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESKWuQfFKudYOkkQ4QoOLIrXUrzthoAF07zci3lxcOYeopf4AWVkb2J5nX/B+9t91r1oDGwA==
X-Received: by 2002:a1c:7912:0:b0:3fb:e2af:49f6 with SMTP id
 l18-20020a1c7912000000b003fbe2af49f6mr6278986wme.39.1691401696679; 
 Mon, 07 Aug 2023 02:48:16 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a7bcd88000000b003fe2b081661sm14643075wmj.30.2023.08.07.02.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 02:48:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH 3/3] configure: unify case statements for CPU canonicalization
Date: Mon,  7 Aug 2023 11:48:07 +0200
Message-ID: <20230807094807.471646-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807094807.471646-1-pbonzini@redhat.com>
References: <20230807094807.471646-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 159 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 87 insertions(+), 72 deletions(-)

diff --git a/configure b/configure
index 484d38d81f4..fb213412d7c 100755
--- a/configure
+++ b/configure
@@ -469,59 +469,104 @@ else
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
+# 'uname -m' case, but better safe than sorry.
+#
 # Note that this case should only have supported host CPUs, not guests.
+# Please keep it sorted.
+host_arch=
+linux_arch=
 case "$cpu" in
+  aarch64)
+    host_arch=aarch64
+    linux_arch=arm64 ;;
+
   armv*b|armv*l|arm)
     cpu="arm" ;;
+    host_arch=arm
+    linux_arch=arm ;;
 
   i386|i486|i586|i686)
     cpu="i386"
+    host_arch=i386
+    linux_arch=x86
     CPU_CFLAGS="-m32" ;;
+
+  loongarch*)
+    cpu=loongarch64
+    host_arch=loongarch64 ;;
+
+  mips64*)
+    cpu=mips64
+    host_arch=mips
+    linux_arch=mips ;;
+  mips*)
+    cpu=mips
+    host_arch=mips
+    linux_arch=mips ;;
+
+  ppc)
+    host_arch=ppc
+    linux_arch=powerpc
+    CPU_CFLAGS="-m32" ;;
+  ppc64)
+    host_arch=ppc64
+    linux_arch=powerpc
+    CPU_CFLAGS="-m64 -mbig-endian" ;;
+  ppc64le)
+    cpu=ppc64
+    host_arch=ppc64
+    linux_arch=powerpc
+    CPU_CFLAGS="-m64 -mlittle-endian" ;;
+
+  riscv32 | riscv64)
+    host_arch=riscv
+    linux_arch=riscv
+    ;;
+
+  s390)
+    linux_arch=s390
+    CPU_CFLAGS="-m31" ;;
+  s390x)
+    host_arch=s390x
+    linux_arch=s390
+    CPU_CFLAGS="-m64" ;;
+
+  sparc|sun4[cdmuv])
+    cpu=sparc
+    CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc" ;;
+  sparc64)
+    host_arch=sparc64
+    CPU_CFLAGS="-m64 -mcpu=ultrasparc" ;;
+
   x32)
     cpu="x86_64"
+    host_arch=x86_64
+    linux_arch=x86
     CPU_CFLAGS="-mx32" ;;
   x86_64|amd64)
     cpu="x86_64"
+    host_arch=x86_64
+    linux_arch=x86
     # ??? Only extremely old AMD cpus do not have cmpxchg16b.
     # If we truly care, we should simply detect this case at
     # runtime and generate the fallback to serial emulation.
     CPU_CFLAGS="-m64 -mcx16" ;;
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
@@ -812,7 +857,7 @@ default_target_list=""
 mak_wilds=""
 
 if [ "$linux_user" != no ]; then
-    if [ "$targetos" = linux ] && [ -d "$source_path/linux-user/include/host/$host_arch" ]; then
+    if [ "$targetos" = linux ] && [ -n "$host_arch" ]; then
         linux_user=yes
     elif [ "$linux_user" = yes ]; then
         error_exit "linux-user not supported on this architecture"
@@ -1717,40 +1762,10 @@ echo "PKG_CONFIG=${pkg_config}" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
 
-# use included Linux headers
-if test "$linux" = "yes" ; then
+# use included Linux headers for KVM architectures
+if test "$linux" = "yes" && test -n "$linux_arch"; then
   mkdir -p linux-headers
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
+  symlink "$source_path/linux-headers/asm-$linux_arch" linux-headers/asm
 fi
 
 for target in $target_list; do
-- 
2.41.0


