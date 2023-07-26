Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BE97635DE
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 14:08:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOdIS-0004F3-JH; Wed, 26 Jul 2023 08:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qOdIP-0004EY-NF
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:07:14 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qOdIN-0007gg-3U
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:07:13 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-992f15c36fcso1117818966b.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 05:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690373228; x=1690978028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TnV+X/kkkUNkxSt220ubtfvM0KelxWI0dETujDMGfLo=;
 b=DQH/+FjmVXYlxrOMrBW4vRneL9Ez5I5bVCOFO3Zgk+Eyh2flEv9XwnTcG1whBRG2RX
 tbBBSD9WXkqtnHmFgUGVbASg4CX+5V+gyShVrWKBoaQWgCPoqzYn4DpqxaXvv+4XL1Ea
 jt0A5N3SgS9y+kdvxagt4SRwT3hTRGUtZOEj6ZYMcV6PFysQw6DziaGHW3XrPfoPLFAh
 pVPczdH+Xxj2O8AUfhhnlpBVa8lb3iD8YeCRdOTHKfMweC9IuQEvRfZfFFlSUakw4jVi
 mCIhWe4Mmx9qUddXZuPuvLiHRp3Op5VyZOyz1aPiasXpE6o9c3O91SKO0GL1cKOjfQrJ
 FZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690373228; x=1690978028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TnV+X/kkkUNkxSt220ubtfvM0KelxWI0dETujDMGfLo=;
 b=dc1jfthGfvvtCl9jAVDW6XRzbQpDnz5iruitoojtA0HaEz7h/NXrzIlvkExkjLlbHT
 +qRNZ2Ktu3LgxZA4GgKI1+m5rt+c1YCwVTGEl6utZ0NJgTCr5pOKDUGAMACBKTl1tGjL
 5lyXiykL2W6MuECs8P0feYiXij8+oRh1ST2N9UXt+dki1LJkW8tSIctXm06q99C4g2me
 SHaIxWymAXWpnE4dlbx3cVI3e2RGEoPyoIKDA2U6C+DbqXTL2G+MLHcRHNJrtklsQ9KB
 VW1jA3+TaHd6RpiH8cG7sSZI4FlX4jk6fmcwpFcMTmotMfibUAt6sBHUA8Zzh9ZeudZN
 K4GQ==
X-Gm-Message-State: ABy/qLbPjwOgqbrNV6o5WxTKEPg3bA23wvgLi1MgCHz4ekpIcdC06SO4
 gceDWxx+DaWjNa1d6TmMaRHR4X/Jt/XAwGPXQd8=
X-Google-Smtp-Source: APBJJlEVWFQm+I3I1AG4OyJao96yKRPu42x+o8X3/LMBVthyirmgiBHm8XoXMnNmY0lCOnHT+AIgxA==
X-Received: by 2002:a17:906:315b:b0:993:d88e:41ed with SMTP id
 e27-20020a170906315b00b00993d88e41edmr1548186eje.3.1690373228025; 
 Wed, 26 Jul 2023 05:07:08 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a1709062b0600b0099297782aa9sm9491820ejg.49.2023.07.26.05.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 05:07:07 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 peter.maydell@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] docs/devel: Add cross-compiling doc
Date: Wed, 26 Jul 2023 14:07:07 +0200
Message-ID: <20230726120706.335340-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add instructions for how to cross-compile QEMU for RISC-V. The
file is named generically because there's no reason not to collect
other architectures steps into the same file, especially because
several subsections like those for cross-compiling QEMU dependencies
using meson and a cross-file could be shared. Additionally, other
approaches to creating sysroots, such as with debootstrap, may be
documented in this file in the future.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 docs/devel/cross-compiling.rst | 221 +++++++++++++++++++++++++++++++++
 1 file changed, 221 insertions(+)
 create mode 100644 docs/devel/cross-compiling.rst

diff --git a/docs/devel/cross-compiling.rst b/docs/devel/cross-compiling.rst
new file mode 100644
index 000000000000..1b988ba54e4c
--- /dev/null
+++ b/docs/devel/cross-compiling.rst
@@ -0,0 +1,221 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+====================
+Cross-compiling QEMU
+====================
+
+Cross-compiling QEMU first requires the preparation of a cross-toolchain
+and the cross-compiling of QEMU's dependencies. While the steps will be
+similar across architectures, each architecture will have its own specific
+recommendations. This document collects architecture-specific procedures
+and hints that may be used to cross-compile QEMU, where typically the host
+environment is x86.
+
+RISC-V
+======
+
+Toolchain
+---------
+
+Select a root directory for the cross environment
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Export an environment variable pointing to a root directory
+for the cross environment. For example, ::
+
+  $ export PREFIX="$HOME/opt/riscv"
+
+Create a work directory
+^^^^^^^^^^^^^^^^^^^^^^^
+
+Tools and several components will need to be downloaded and built. Create
+a directory for all the work, ::
+
+  $ export WORK_DIR="$HOME/work/xqemu"
+  $ mkdir -p "$WORK_DIR"
+
+Select and prepare the toolchain
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Select a toolchain such as [riscv-toolchain]_ and follow its instructions
+for building and installing it to ``$PREFIX``, e.g. ::
+
+  $ cd "$WORK_DIR"
+  $ git clone https://github.com/riscv/riscv-gnu-toolchain
+  $ cd riscv-gnu-toolchain
+  $ ./configure --prefix="$PREFIX"
+  $ make -j$(nproc) linux
+
+Set the ``$CROSS_COMPILE`` environment variable to the prefix of the cross
+tools and add the tools to ``$PATH``, ::
+
+$ export CROSS_COMPILE=riscv64-unknown-linux-gnu-
+$ export PATH="$PREFIX/bin:$PATH"
+
+Also set ``$SYSROOT``, where all QEMU cross-compiled dependencies will be
+installed. The toolchain installation likely created a 'sysroot' directory
+at ``$PREFIX/sysroot``, which is the default location for most cross
+tools, making it a good location, ::
+
+  $ mkdir -p "$PREFIX/sysroot"
+  $ export SYSROOT="$PREFIX/sysroot"
+
+Create a pkg-config wrapper
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The build processes of QEMU and some of its dependencies depend on
+pkg-config. Create a wrapper script for it which works for the cross
+environment: ::
+
+  $ cat <<EOF >"$PREFIX/bin/${CROSS_COMPILE}pkg-config"
+  #!/bin/sh
+
+  [ "\$SYSROOT" ] || exit 1
+
+  export PKG_CONFIG_PATH=
+  export PKG_CONFIG_LIBDIR="\${SYSROOT}/usr/lib/pkgconfig:\${SYSROOT}/usr/lib64/pkgconfig:\${SYSROOT}/usr/share/pkgconfig"
+
+  exec pkg-config "\$@"
+  EOF
+  $ chmod +x "$PREFIX/bin/${CROSS_COMPILE}pkg-config"
+
+Create a cross-file for meson builds
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+meson setup, used by some of QEMU's dependencies, needs a "cross-file" to
+configure the cross environment. Create one, ::
+
+  $ cd "$WORK_DIR"
+  $ cat <<EOF >cross_file.txt
+  [host_machine]
+  system = 'linux'
+  cpu_family = 'riscv64'
+  cpu = 'riscv64'
+  endian = 'little'
+
+  [binaries]
+  c = '${CROSS_COMPILE}gcc'
+  cpp = '${CROSS_COMPILE}g++'
+  ar = '${CROSS_COMPILE}ar'
+  ld = '${CROSS_COMPILE}ld'
+  objcopy = '${CROSS_COMPILE}objcopy'
+  strip = '${CROSS_COMPILE}strip'
+  pkgconfig = '${CROSS_COMPILE}pkg-config'
+  EOF
+
+Cross-compile dependencies
+--------------------------
+
+glibc
+^^^^^
+
+If [riscv-toolchain]_ was selected for the toolchain then this step is
+already complete and glibc has already been installed into ``$SYSROOT``.
+Otherwise, cross-compile glibc and install it to ``$SYSROOT``.
+
+libffi
+^^^^^^
+
+::
+
+  $ cd "$WORK_DIR"
+  $ git clone https://gitlab.freedesktop.org/gstreamer/meson-ports/libffi.git
+  $ cd libffi
+  $ meson setup --cross-file ../cross_file.txt --prefix="$SYSROOT/usr" _build
+  $ ninja -C _build
+  $ ninja -C _build install
+
+*Building libffi seperately avoids a compilation error generated when
+building it as a subproject of glib.*
+
+glib
+^^^^
+
+::
+
+  $ cd "$WORK_DIR"
+  $ git clone https://github.com/GNOME/glib.git
+  $ cd glib
+  $ meson setup --cross-file ../cross_file.txt --prefix="$SYSROOT/usr" _build
+  $ ninja -C _build
+  $ ninja -C _build install
+
+libslirp [optional]
+^^^^^^^^^^^^^^^^^^^
+
+::
+
+  $ cd "$WORK_DIR"
+  $ git clone https://gitlab.com/qemu-project/libslirp.git
+  $ cd libslirp
+  $ meson setup --cross-file ../cross_file.txt --prefix="$SYSROOT/usr" _build
+  $ ninja -C _build
+  $ ninja -C _build install
+
+pixman
+^^^^^^
+
+First ensure the 'libtool' package is installed, e.g.
+``sudo dnf install libtool`` or ``sudo apt install libtool``
+
+::
+
+  $ cd "$WORK_DIR"
+  $ git clone https://gitlab.freedesktop.org/pixman/pixman
+  $ cd pixman
+  $ ./autogen.sh
+  $ ./configure --prefix="$SYSROOT/usr" --host=riscv64-unknown-linux-gnu
+  $ make -j$(nproc)
+  $ make install
+
+Cross-compile QEMU
+------------------
+
+::
+
+  $ cd "$WORK_DIR"
+  $ git clone https://gitlab.com/qemu-project/qemu.git
+  $ cd qemu
+  $ mkdir -p build/install_dir
+  $ cd build
+  $ ../configure --target-list=riscv64-softmmu --cross-prefix=$CROSS_COMPILE --prefix="$PWD/install_dir"
+  $ make -j$(nproc)
+  $ make install
+
+*Cross-compiling QEMU with different configurations may require more
+dependencies to be built and installed in the sysroot.*
+
+Running QEMU
+------------
+
+``build/install_dir`` may now be copied to the target and its bin
+directory may be added to the target user's PATH. Prior to running
+QEMU, ensure all the libraries it depends on are present, ::
+
+  $ ldd /path/to/bin/qemu-system-riscv64
+
+For example, it may necessary to install zlib libraries, e.g.
+``sudo dnf install zlib-devel`` or ``sudo apt install zlib1g-dev``
+
+Subsequent QEMU Cross-compiling
+-------------------------------
+
+Unless it's necessary to update and recompile the toolchain or
+dependencies, then most steps do not need to be repeated for subsequent
+compiles. Simply ensure the toolchain is in ``$PATH``, ``$SYSROOT`` points
+at the sysroot, and then follow the QEMU cross-compile steps in
+"Cross-compile QEMU". For example, ::
+
+  $ export PATH="$HOME/opt/riscv/bin:$PATH"
+  $ export SYSROOT="$HOME/opt/riscv/sysroot"
+  $ cd /path/to/qemu
+  $ mkdir -p build/install_dir
+  $ cd build
+  $ ../configure --target-list=riscv64-softmmu --cross-prefix=riscv64-unknown-linux-gnu- --prefix="$PWD/install_dir"
+  $ make -j
+  $ make install
+
+References
+----------
+
+.. [riscv-toolchain] https://github.com/riscv/riscv-gnu-toolchain
-- 
2.41.0


