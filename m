Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 488819929EA
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Oct 2024 13:04:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlXD-0001mo-3B; Mon, 07 Oct 2024 07:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlXA-0001mU-Dl
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlX8-0006V0-7E
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728299048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=svV5TpLybYn9X0tiGkt40RrMIOZJ9Xrkkw5ba10Anqg=;
 b=MJ5Nyy9ITsE0EoQ0ZTUIpUufEjXf7vB1LTIRRdArqJHVpwHRV/8AQ03RkcApWGRADq8vtW
 MYqa6sK29MaV1CYOKjCs8nckEGfO1b/oWbEexo15WfY1j0L6aZ5pd23XMvalD9nhkqzY2Y
 IY8RpFScuoCy0dDkV3XevJT5pJLV2IY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-2JeN5yYVNVWsEJ_qISM6fA-1; Mon, 07 Oct 2024 07:04:06 -0400
X-MC-Unique: 2JeN5yYVNVWsEJ_qISM6fA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d0506098cso2660281f8f.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 04:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728299044; x=1728903844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=svV5TpLybYn9X0tiGkt40RrMIOZJ9Xrkkw5ba10Anqg=;
 b=ix65EtOu6GPB9xfTzH76YIj1PQwYfvdSvHxUCRJ9/oa+eUlxjSMOWlHJJGe8WtV47f
 DqJYVKYiNZR8ffO1965lZFRLqzMa726OZNSK4l6h/dKHKOys8FoN2EtXWzSXzfd3+3Tc
 eLu3onDXi3JOQtd8nxYqQLstt0kJ2cm6beMQhNBVzRWwfzKnU8L/dG+VUAK05crS6wdm
 ICUZhcYXWIb4ixNFDCdpZtBBBf+V88g1YD1DNn0SrPs4E6Q/5b85vlt4Dqn08eIMXI2z
 pQ2MXamrDVWKxgky+AWlTi/F8+9U4bQSY0jSBtKx5z684zWOvpG8C7TNZiLr60h/ir6O
 CfKg==
X-Gm-Message-State: AOJu0YwN9RHxRgAbQi9t5dqvnCFWfNLDNMWsQkYcce6f1VS6LMaKwWhk
 f7FDeykFQ9K8rpUE3GkzHIsO2sGpEuxSwpPco3afs0m6y1SKL1YiVc8Tv6xShsgmsOzvvmRqzS1
 kAslfjqrk2oGKwi/2Rbyj5RvsNI2fxM4M9NyDD8JAE0+SGlvLyH10SvHKknImvAanx0MY2MumDQ
 VHCOzsP/5LtCfu0BJeZeQZKGogaolWHC+5ykaXnWQ=
X-Received: by 2002:adf:f411:0:b0:374:b9a7:5ed6 with SMTP id
 ffacd0b85a97d-37d0e6f01bemr7017659f8f.22.1728299044374; 
 Mon, 07 Oct 2024 04:04:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEczpx6WychkKN0Bof3/i7wMH+EdRPjpPc8y1Rx6O1X/slx1PTBEeMhKuuF/Mu4VN6Wa8JQ0A==
X-Received: by 2002:adf:f411:0:b0:374:b9a7:5ed6 with SMTP id
 ffacd0b85a97d-37d0e6f01bemr7017621f8f.22.1728299043798; 
 Mon, 07 Oct 2024 04:04:03 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1698fcacsm5440261f8f.116.2024.10.07.04.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 04:04:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com, junjie.mao@intel.com,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org
Subject: [PULL 03/12] configure, meson: detect Rust toolchain
Date: Mon,  7 Oct 2024 13:03:31 +0200
Message-ID: <20241007110342.1298598-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241007110342.1298598-1-pbonzini@redhat.com>
References: <20241007110342.1298598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Include the correct path and arguments to rustc in the native
and cross files (native compilation is needed for procedural
macros).

Based on the host architecture and OS, the compiler and optionally the argument
to --cpu, the Rust target triple can be detected automatically for either a
native or a cross compiler.

In general, it is only a matter of translating the architecture and OS, and
adding a machine to form the triple, but there are some special cases (e.g.
detecting soft vs. hard floating point on ARM) and some inconsistencies.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/207d2640b32d511e9c27478ce3192f5bb0bf3169.1727961605.git.manos.pitsidianakis@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 163 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 meson.build |   5 +-
 2 files changed, 164 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index aa7aae70fa1..0ccc92074ea 100755
--- a/configure
+++ b/configure
@@ -207,6 +207,8 @@ for opt do
   ;;
   --objcc=*) objcc="$optarg"
   ;;
+  --rustc=*) RUSTC="$optarg"
+  ;;
   --cpu=*) cpu="$optarg"
   ;;
   --extra-cflags=*)
@@ -252,6 +254,8 @@ python=
 download="enabled"
 skip_meson=no
 use_containers="yes"
+rust="auto"
+rust_target_triple=""
 gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
 gdb_arches=""
 
@@ -310,6 +314,7 @@ objcopy="${OBJCOPY-${cross_prefix}objcopy}"
 ld="${LD-${cross_prefix}ld}"
 ranlib="${RANLIB-${cross_prefix}ranlib}"
 nm="${NM-${cross_prefix}nm}"
+readelf="${READELF-${cross_prefix}readelf}"
 strip="${STRIP-${cross_prefix}strip}"
 widl="${WIDL-${cross_prefix}widl}"
 windres="${WINDRES-${cross_prefix}windres}"
@@ -317,6 +322,8 @@ windmc="${WINDMC-${cross_prefix}windmc}"
 pkg_config="${PKG_CONFIG-${cross_prefix}pkg-config}"
 sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
 
+rustc="${RUSTC-rustc}"
+
 check_define() {
 cat > $TMPC <<EOF
 #if !defined($1)
@@ -425,6 +432,7 @@ fi
 # Please keep it sorted and synchronized with meson.build's host_arch.
 host_arch=
 linux_arch=
+raw_cpu=$cpu
 case "$cpu" in
   aarch64)
     host_arch=aarch64
@@ -658,6 +666,8 @@ for opt do
   ;;
   --objcc=*)
   ;;
+  --rustc=*)
+  ;;
   --make=*)
   ;;
   --install=*)
@@ -777,8 +787,14 @@ for opt do
   ;;
   --container-engine=*) container_engine="$optarg"
   ;;
+  --rust-target-triple=*) rust_target_triple="$optarg"
+  ;;
   --gdb=*) gdb_bin="$optarg"
   ;;
+  --enable-rust) rust=enabled
+  ;;
+  --disable-rust) rust=disabled
+  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -881,6 +897,7 @@ Advanced options (experts only):
                            at build time [$host_cc]
   --cxx=CXX                use C++ compiler CXX [$cxx]
   --objcc=OBJCC            use Objective-C compiler OBJCC [$objcc]
+  --rustc=RUSTC            use Rust compiler RUSTC [$rustc]
   --extra-cflags=CFLAGS    append extra C compiler flags CFLAGS
   --extra-cxxflags=CXXFLAGS append extra C++ compiler flags CXXFLAGS
   --extra-objcflags=OBJCFLAGS append extra Objective C compiler flags OBJCFLAGS
@@ -891,8 +908,9 @@ Advanced options (experts only):
   --python=PYTHON          use specified python [$python]
   --ninja=NINJA            use specified ninja [$ninja]
   --static                 enable static build [$static]
-  --without-default-features default all --enable-* options to "disabled"
-  --without-default-devices  do not include any device that is not needed to
+  --rust-target-triple=TRIPLE  compilation target for Rust code [autodetect]
+  --without-default-features   default all --enable-* options to "disabled"
+  --without-default-devices    do not include any device that is not needed to
                            start the emulator (only use if you are including
                            desired devices in configs/devices/)
   --with-devices-ARCH=NAME override default configs/devices
@@ -1166,6 +1184,132 @@ EOF
   fi
 fi
 
+##########################################
+# detect rust triple
+
+if test "$rust" != disabled && has "$rustc" && $rustc -vV > "${TMPDIR1}/${TMPB}.out"; then
+  rust_host_triple=$(sed -n 's/^host: //p' "${TMPDIR1}/${TMPB}.out")
+else
+  if test "$rust" = enabled; then
+    error_exit "could not execute rustc binary \"$rustc\""
+  fi
+  rust=disabled
+fi
+if test "$rust" != disabled && test -z "$rust_target_triple"; then
+  # arch and os generally matches between meson and rust
+  rust_arch=$host_arch
+  rust_os=$host_os
+  rust_machine=unknown
+  rust_osvariant=
+
+  # tweak rust_os if needed; also, machine and variant depend on the OS
+  android=no
+  case "$host_os" in
+  darwin)
+    # e.g. aarch64-apple-darwin
+    rust_machine=apple
+    ;;
+
+  linux)
+    # detect android/glibc/musl
+    if check_define __ANDROID__; then
+      rust_osvariant=android
+      android=yes
+    else
+      cat > $TMPC << EOF
+#define _GNU_SOURCE
+#include <features.h>
+#ifndef __USE_GNU
+error using musl
+#endif
+EOF
+      if compile_object; then
+        rust_osvariant=gnu
+      else
+        rust_osvariant=musl
+      fi
+    fi
+
+    case "$host_arch" in
+    arm)
+      # e.g. arm-unknown-linux-gnueabi, arm-unknown-linux-gnueabihf
+      write_c_skeleton
+      compile_object
+      if $READELF -A $TMPO | grep Tag_API_VFP_args: > /dev/null; then
+        rust_osvariant=${rust_osvariant}eabihf
+      else
+        rust_osvariant=${rust_osvariant}eabi
+      fi
+      ;;
+
+    mips64)
+      # e.g. mips64-unknown-linux-gnuabi64
+      rust_osvariant=${rust_osvariant}abi64
+      ;;
+    esac
+    ;;
+
+  netbsd)
+    # e.g. arm-unknown-netbsd-eabihf
+    test "$host_arch" = arm && rust_osvariant=eabihf
+    ;;
+
+  sunos)
+    rust_machine=pc
+    rust_os=solaris
+    ;;
+
+  windows)
+    # e.g. aarch64-pc-windows-gnullvm, x86_64-pc-windows-gnu (MSVC not supported)
+    rust_machine=pc
+    if test "$host_arch" = aarch64; then
+      rust_osvariant=gnullvm
+    else
+      rust_osvariant=gnu
+    fi
+    ;;
+  esac
+
+  # now tweak the architecture part, possibly based on pre-canonicalization --cpu
+  case "$host_arch" in
+  arm)
+    # preserve ISA version (armv7 etc.) from $raw_cpu if passed via --cpu
+    rust_arch=$raw_cpu
+    test "$rust_arch" = arm && test "$rust_os" != linux && rust_arch=armv7
+    ;;
+
+  mips|mips64)
+    # preserve ISA version (mipsisa64r6 etc.) and include endianness
+    rust_arch=${raw_cpu%el}
+    test "$bigendian" = no && rust_arch=${rust_arch}el
+    ;;
+
+  riscv32|riscv64)
+    # e.g. riscv64gc-unknown-linux-gnu, but riscv64-linux-android
+    test "$android" = no && rust_arch=${rust_arch}gc
+    ;;
+
+  sparc64)
+    if test "$rust_os" = solaris; then
+      rust_arch=sparcv9
+      rust_machine=sun
+    fi
+    ;;
+
+  x86_64)
+    # e.g. x86_64-unknown-linux-gnux32
+    test "$raw_cpu" = x32 && rust_osvariant=${rust_osvariant}x32
+    ;;
+  esac
+
+  if test "$android" = yes; then
+    # e.g. aarch64-linux-android
+    rust_target_triple=$rust_arch-$rust_os-$rust_osvariant
+  else
+    rust_target_triple=$rust_arch-$rust_machine-$rust_os${rust_osvariant+-$rust_osvariant}
+  fi
+fi
+
 ##########################################
 # functions to probe cross compilers
 
@@ -1628,6 +1772,9 @@ if test "$container" != no; then
     echo "RUNC=$runc" >> $config_host_mak
 fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
+if test "$rust" != disabled; then
+  echo "RUST_TARGET_TRIPLE=$rust_target_triple" >> $config_host_mak
+fi
 echo "PYTHON=$python" >> $config_host_mak
 echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
@@ -1764,12 +1911,20 @@ if test "$skip_meson" = no; then
   echo "c = [$(meson_quote $cc $CPU_CFLAGS)]" >> $cross
   test -n "$cxx" && echo "cpp = [$(meson_quote $cxx $CPU_CFLAGS)]" >> $cross
   test -n "$objcc" && echo "objc = [$(meson_quote $objcc $CPU_CFLAGS)]" >> $cross
+  if test "$rust" != disabled; then
+    if test "$rust_host_triple" != "$rust_target_triple"; then
+      echo "rust = [$(meson_quote $rustc --target "$rust_target_triple")]" >> $cross
+    else
+      echo "rust = [$(meson_quote $rustc)]" >> $cross
+    fi
+  fi
   echo "ar = [$(meson_quote $ar)]" >> $cross
   echo "dlltool = [$(meson_quote $dlltool)]" >> $cross
   echo "nm = [$(meson_quote $nm)]" >> $cross
   echo "pkgconfig = [$(meson_quote $pkg_config)]" >> $cross
   echo "pkg-config = [$(meson_quote $pkg_config)]" >> $cross
   echo "ranlib = [$(meson_quote $ranlib)]" >> $cross
+  echo "readelf = [$(meson_quote $readelf)]" >> $cross
   if has $sdl2_config; then
     echo "sdl2-config = [$(meson_quote $sdl2_config)]" >> $cross
   fi
@@ -1799,6 +1954,9 @@ if test "$skip_meson" = no; then
     echo "# Automatically generated by configure - do not modify" > $native
     echo "[binaries]" >> $native
     echo "c = [$(meson_quote $host_cc)]" >> $native
+    if test "$rust" != disabled; then
+      echo "rust = [$(meson_quote $rustc)]" >> $cross
+    fi
     mv $native config-meson.native
     meson_option_add --native-file
     meson_option_add config-meson.native
@@ -1817,6 +1975,7 @@ if test "$skip_meson" = no; then
   test "$pie" = no && meson_option_add -Db_pie=false
 
   # QEMU options
+  test "$rust" != "auto" && meson_option_add "-Drust=$rust"
   test "$cfi" != false && meson_option_add "-Dcfi=$cfi" "-Db_lto=$cfi"
   test "$docs" != auto && meson_option_add "-Ddocs=$docs"
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
diff --git a/meson.build b/meson.build
index 93ddaef500f..f76f01f065f 100644
--- a/meson.build
+++ b/meson.build
@@ -4325,8 +4325,9 @@ else
 endif
 summary_info += {'Rust support':      have_rust}
 if have_rust
-  summary_info += {'rustc version':      rustc.version()}
-  summary_info += {'rustc':      ' '.join(rustc.cmd_array())}
+  summary_info += {'rustc version':   rustc.version()}
+  summary_info += {'rustc':           ' '.join(rustc.cmd_array())}
+  summary_info += {'Rust target':     config_host['RUST_TARGET_TRIPLE']}
 endif
 option_cflags = (get_option('debug') ? ['-g'] : [])
 if get_option('optimization') != 'plain'
-- 
2.46.1


