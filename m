Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 383F3A7B1E1
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Apr 2025 00:06:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Shi-0003O1-03; Thu, 03 Apr 2025 18:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0ShJ-00029D-0D
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:06:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0ShF-000443-R3
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:06:04 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso14827745e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717960; x=1744322760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkZfUGTIHPJoFuoXNJAvYpwK7HYaDnYB6xEqZqBEDyc=;
 b=DvHN15Slr9HhVn4mF6I2org1aPd9KQnVRbi2ky+3aUUsRoI9ncAfocyidrUA1df+eE
 a0YTDyvGYlhr/GWL2SOwpbtJEWsU+nwwGxitWfCjELwlSZJGZ4pclZhYo0jwZdng4V+d
 OiWTaMEReziUf2QDfmcKbVaglt/a30SXHo0zJRQn2LjhW91PSJS873abLbTlI3U/ox6I
 bv2pqSyq+5RSK+Nsl1y76K9E6p9NluyaPV9Hrcx467esZ/3Gm2xHylZTHcunpACnBNl/
 AJpzw94VG/4LpRqRSP3Mw0wp23hG+hKArBGAsfjsSqIt+p8o5l1qv8WnmCqKV/H7Wl1Q
 sxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717960; x=1744322760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkZfUGTIHPJoFuoXNJAvYpwK7HYaDnYB6xEqZqBEDyc=;
 b=a/wRZIPkWgO10TpgG0gDj7tKRcU/j+A7+SvZkymGLK9EzO2c8hHd1mJ4C2RnaMzC4O
 rhscqB4miIB1VBzrgvX+jEDpEINC4fPW7vMkJQZWBVNrrfyYrU9RNZjuI4zNJfw6paN4
 O8LpFx6eXcRDEbQ/Z1Z2pVYfJVQYP4CNOyfZLW9/LTuhd8vuUKoK7TdDou1b/Jt4TqEr
 /Tnkz39JjpNPJNc/uVC/EpbiC2zsqHhYaIGBQiBpxKkKRMjKFkmbFX9imZKhYSysKBwr
 hsi3c8x+iBzjrHyJpL9Asr5PZHi2cxEWhic0IQXDlX4zDC2uejzCZty+Z4TepL7R8zo7
 dqNQ==
X-Gm-Message-State: AOJu0YzwpMEg4ZacF7xv820ctG4Gx0wVkUvhMYgIwDd0x5yfAW5+nwq6
 rhAhq+bJM7JDaMQpG+4wbIiWv8DGOsHvBcaWwBj5g7lr0p4Z3sj6cg4UvR5umGpZuRM1LPYU75B
 Q
X-Gm-Gg: ASbGncuTun+yc4LS3fCPL5EvUd7TlHKteAYl2hELB/DsEPOr8inyQHqPA4GNYsmSEyX
 X/5+8Ev2wcbnzEkwV2ZDQ1Uq1KMaUBMXGl82THbnFTG0ArPcY3tIpqmFUgz/QF5NnTrQfjr369E
 vu59PuOrHwJThYzLO8OC2qBg2LPq0qfrTVLUL7CfwdvRCzAbl4lAxjVwhN44oK2xc1ZOw2b7hrF
 goI+kfgvkDB2l9Av+c47Ah8LWCcZkHFkwXlLUx41lranpGnWxjaBpAvnrNpIfxmkC2Kl277MMx3
 5JW5tlhj+MyuT+oZSSrqONMtDuR1a67x/enH0yZc0HqTmMj83W3c7ysD0628iW9i9enT+mwyD1C
 6yaJltuRz8UpR7Hx4WPNeNTZ3mw3as8QY/kM=
X-Google-Smtp-Source: AGHT+IHJeig6XKx1mZLIYAkmxZM50KoC+sSdVL1mdtxT6pvzyEIo206N6nkuZ4wQiNlGlloNUbImfA==
X-Received: by 2002:a05:600c:1d88:b0:43d:7a:471f with SMTP id
 5b1f17b1804b1-43ecf8ece15mr7175675e9.18.1743717959450; 
 Thu, 03 Apr 2025 15:05:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d64dsm2853743f8f.70.2025.04.03.15.05.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:05:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 19/19] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
Date: Fri,  4 Apr 2025 00:04:19 +0200
Message-ID: <20250403220420.78937-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403220420.78937-1-philmd@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Instead of having a compile-time TARGET_SUPPORTS_MTTCG definition,
have each target set the 'mttcg_supported' field in the TCGCPUOps
structure.

Since so far we only emulate one target architecture at a time,
tcg_init_machine() gets whether MTTCG is supported via the
current CPU class (CPU_RESOLVING_TYPE).

Since TARGET_SUPPORTS_MTTCG isn't available anymore,
instead of emiting a warning when the 'thread' property
is set in tcg_set_thread(), emit it in tcg_init_machine()
where it is consumed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/multi-thread-tcg.rst          |  2 +-
 configs/targets/aarch64-softmmu.mak      |  1 -
 configs/targets/alpha-softmmu.mak        |  1 -
 configs/targets/arm-softmmu.mak          |  1 -
 configs/targets/hppa-softmmu.mak         |  1 -
 configs/targets/i386-softmmu.mak         |  1 -
 configs/targets/loongarch64-softmmu.mak  |  1 -
 configs/targets/microblaze-softmmu.mak   |  1 -
 configs/targets/microblazeel-softmmu.mak |  1 -
 configs/targets/mips-softmmu.mak         |  1 -
 configs/targets/mipsel-softmmu.mak       |  1 -
 configs/targets/or1k-softmmu.mak         |  1 -
 configs/targets/ppc64-softmmu.mak        |  1 -
 configs/targets/riscv32-softmmu.mak      |  1 -
 configs/targets/riscv64-softmmu.mak      |  1 -
 configs/targets/s390x-softmmu.mak        |  1 -
 configs/targets/sparc-softmmu.mak        |  1 -
 configs/targets/sparc64-softmmu.mak      |  1 -
 configs/targets/x86_64-softmmu.mak       |  1 -
 configs/targets/xtensa-softmmu.mak       |  1 -
 configs/targets/xtensaeb-softmmu.mak     |  1 -
 include/accel/tcg/cpu-ops.h              |  8 ++++++++
 include/exec/poison.h                    |  1 -
 accel/tcg/tcg-all.c                      | 17 ++++++++---------
 target/alpha/cpu.c                       |  1 +
 target/arm/cpu.c                         |  1 +
 target/arm/tcg/cpu-v7m.c                 |  1 +
 target/avr/cpu.c                         |  1 +
 target/hexagon/cpu.c                     |  1 +
 target/hppa/cpu.c                        |  1 +
 target/i386/tcg/tcg-cpu.c                |  1 +
 target/loongarch/cpu.c                   |  1 +
 target/m68k/cpu.c                        |  1 +
 target/microblaze/cpu.c                  |  1 +
 target/mips/cpu.c                        |  1 +
 target/openrisc/cpu.c                    |  1 +
 target/ppc/cpu_init.c                    |  1 +
 target/riscv/tcg/tcg-cpu.c               |  1 +
 target/rx/cpu.c                          |  1 +
 target/s390x/cpu.c                       |  1 +
 target/sh4/cpu.c                         |  1 +
 target/sparc/cpu.c                       |  1 +
 target/tricore/cpu.c                     |  1 +
 target/xtensa/cpu.c                      |  1 +
 44 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index 14a2a9dc7b5..da9a1530c9f 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -30,7 +30,7 @@ user-space thread. This is enabled by default for all FE/BE
 combinations where the host memory model is able to accommodate the
 guest (TCGCPUOps::guest_default_memory_order & ~TCG_TARGET_DEFAULT_MO is zero)
 and the guest has had the required work done to support this safely
-(TARGET_SUPPORTS_MTTCG).
+(TCGCPUOps::mttcg_supported).
 
 System emulation will fall back to the original round robin approach
 if:
diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index 82cb72cb83d..5dfeb35af90 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml
 # needed by boot.c
diff --git a/configs/targets/alpha-softmmu.mak b/configs/targets/alpha-softmmu.mak
index 89f3517aca0..5275076e50d 100644
--- a/configs/targets/alpha-softmmu.mak
+++ b/configs/targets/alpha-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=alpha
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/arm-softmmu.mak b/configs/targets/arm-softmmu.mak
index afc64f5927b..6a5a8eda949 100644
--- a/configs/targets/arm-softmmu.mak
+++ b/configs/targets/arm-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=arm
-TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
diff --git a/configs/targets/hppa-softmmu.mak b/configs/targets/hppa-softmmu.mak
index 63ca74ed5e6..ea331107a08 100644
--- a/configs/targets/hppa-softmmu.mak
+++ b/configs/targets/hppa-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=hppa
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 5dd89217560..e9d89e8ab41 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=i386
-TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index 351341132f6..fc44c54233d 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -1,7 +1,6 @@
 TARGET_ARCH=loongarch64
 TARGET_BASE_ARCH=loongarch
 TARGET_KVM_HAVE_GUEST_DEBUG=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml gdb-xml/loongarch-lsx.xml gdb-xml/loongarch-lasx.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
diff --git a/configs/targets/microblaze-softmmu.mak b/configs/targets/microblaze-softmmu.mak
index 99a33ed44a8..23457d0ae65 100644
--- a/configs/targets/microblaze-softmmu.mak
+++ b/configs/targets/microblaze-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=microblaze
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/microblazeel-softmmu.mak
index 52cdeae1a28..c82c509623d 100644
--- a/configs/targets/microblazeel-softmmu.mak
+++ b/configs/targets/microblazeel-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=microblaze
-TARGET_SUPPORTS_MTTCG=y
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
diff --git a/configs/targets/mips-softmmu.mak b/configs/targets/mips-softmmu.mak
index b62a0882499..c9588066b8d 100644
--- a/configs/targets/mips-softmmu.mak
+++ b/configs/targets/mips-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=mips
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/mipsel-softmmu.mak b/configs/targets/mipsel-softmmu.mak
index 620ec681785..90e09bdc3e5 100644
--- a/configs/targets/mipsel-softmmu.mak
+++ b/configs/targets/mipsel-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=mips
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index adfddb1a8ac..0e47d9878b0 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=openrisc
-TARGET_SUPPORTS_MTTCG=y
 TARGET_BIG_ENDIAN=y
 # needed by boot.c and all boards
 TARGET_NEED_FDT=y
diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-softmmu.mak
index 7cee0e97f43..74572864b36 100644
--- a/configs/targets/ppc64-softmmu.mak
+++ b/configs/targets/ppc64-softmmu.mak
@@ -1,7 +1,6 @@
 TARGET_ARCH=ppc64
 TARGET_BASE_ARCH=ppc
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
 # all boards require libfdt
diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv32-softmmu.mak
index c828066ce6b..db55275b868 100644
--- a/configs/targets/riscv32-softmmu.mak
+++ b/configs/targets/riscv32-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=riscv32
 TARGET_BASE_ARCH=riscv
-TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-virtual.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index 09f613d24a0..2bdd4a62cd2 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
-TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-virtual.xml
 # needed by boot.c
diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-softmmu.mak
index 5242ebe7c2e..76dd5de6584 100644
--- a/configs/targets/s390x-softmmu.mak
+++ b/configs/targets/s390x-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=s390x
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index 78c2e25bd13..57801faf1fc 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index f7bab97a002..2504e31ae33 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=64
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index 1ceefde1313..5619b2bc686 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
diff --git a/configs/targets/xtensa-softmmu.mak b/configs/targets/xtensa-softmmu.mak
index 65845df4ffa..2a9797338a6 100644
--- a/configs/targets/xtensa-softmmu.mak
+++ b/configs/targets/xtensa-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=xtensa
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=32
diff --git a/configs/targets/xtensaeb-softmmu.mak b/configs/targets/xtensaeb-softmmu.mak
index f1f789d6971..5204729af8b 100644
--- a/configs/targets/xtensaeb-softmmu.mak
+++ b/configs/targets/xtensaeb-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=xtensa
 TARGET_BIG_ENDIAN=y
-TARGET_SUPPORTS_MTTCG=y
 TARGET_LONG_BITS=32
diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index a4932fc5d7c..0e4352513d1 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -19,6 +19,14 @@
 #include "tcg/tcg-mo.h"
 
 struct TCGCPUOps {
+    /**
+     * mttcg_supported: multi-threaded TCG is supported
+     *
+     * Target (TCG frontend) supports:
+     *   - atomic instructions
+     *   - memory ordering primitives (barriers)
+     */
+    bool mttcg_supported;
 
     /**
      * @guest_default_memory_order: default barrier that is required
diff --git a/include/exec/poison.h b/include/exec/poison.h
index a09e0c12631..bc422719d80 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -35,7 +35,6 @@
 
 #pragma GCC poison TARGET_HAS_BFLT
 #pragma GCC poison TARGET_NAME
-#pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_BIG_ENDIAN
 #pragma GCC poison TCG_GUEST_DEFAULT_MO
 #pragma GCC poison TARGET_HAS_PRECISE_SMC
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 267830658ca..bf27c5c0fb3 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -41,8 +41,10 @@
 #include "hw/boards.h"
 #include "system/tcg.h"
 #endif
+#include "accel/tcg/cpu-ops.h"
 #include "internal-common.h"
 #include "cpu-param.h"
+#include "cpu.h"
 
 
 struct TCGState {
@@ -71,11 +73,8 @@ bool qemu_tcg_mttcg_enabled(void)
 
 static void mttcg_init(TCGState *s)
 {
-#ifdef TARGET_SUPPORTS_MTTCG
-    bool mttcg_supported = true;
-#else
-    bool mttcg_supported = false;
-#endif
+    CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
+    bool mttcg_supported = cc->tcg_ops->mttcg_supported;
 
     if (s->mttcg_enabled == ON_OFF_AUTO_AUTO) {
         /*
@@ -96,6 +95,10 @@ static void mttcg_init(TCGState *s)
             s->mttcg_enabled = mttcg_supported;
         }
     }
+    if (s->mttcg_enabled == ON_OFF_AUTO_ON && !mttcg_supported) {
+        warn_report("Guest not yet converted to MTTCG - "
+                    "you may get unexpected results");
+    }
     mttcg_enabled = s->mttcg_enabled;
 }
 
@@ -162,10 +165,6 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
         if (icount_enabled()) {
             error_setg(errp, "No MTTCG when icount is enabled");
         } else {
-#ifndef TARGET_SUPPORTS_MTTCG
-            warn_report("Guest not yet converted to MTTCG - "
-                        "you may get unexpected results");
-#endif
             s->mttcg_enabled = ON_OFF_AUTO_ON;
         }
     } else if (strcmp(value, "single") == 0) {
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index eeaf3a81c1a..851a3d10d59 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -235,6 +235,7 @@ static const struct SysemuCPUOps alpha_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps alpha_tcg_ops = {
+    .mttcg_supported = true,
     /* Alpha processors have a weak memory model */
     .guest_default_memory_order = 0,
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3e9760b5518..377791c84dd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2671,6 +2671,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
 
 #ifdef CONFIG_TCG
 static const TCGCPUOps arm_tcg_ops = {
+    .mttcg_supported = true,
     /* ARM processors have a weak memory model */
     .guest_default_memory_order = 0,
 
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 89d4e4b4a2f..85d8db87f9b 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -232,6 +232,7 @@ static void cortex_m55_initfn(Object *obj)
 }
 
 static const TCGCPUOps arm_v7m_tcg_ops = {
+    .mttcg_supported = true,
     /* ARM processors have a weak memory model */
     .guest_default_memory_order = 0,
 
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 8f79cf4c08b..064ee3ec3f1 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -224,6 +224,7 @@ static const struct SysemuCPUOps avr_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps avr_tcg_ops = {
+    .mttcg_supported = false,
     .guest_default_memory_order = 0,
     .initialize = avr_cpu_tcg_init,
     .translate_code = avr_cpu_translate_code,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 3d14e5cc6a0..a8293749f3f 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -325,6 +325,7 @@ static void hexagon_cpu_init(Object *obj)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps hexagon_tcg_ops = {
+    .mttcg_supported = false,
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
     .initialize = hexagon_translate_init,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index dfbd9330565..1bfd2a402a9 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -253,6 +253,7 @@ static const struct SysemuCPUOps hppa_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps hppa_tcg_ops = {
+    .mttcg_supported = true,
     /* PA-RISC 1.x processors have a strong memory model.  */
     /*
      * ??? While we do not yet implement PA-RISC 2.0, those processors have
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index d941df09560..a0258f4739e 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -125,6 +125,7 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps x86_tcg_ops = {
+    .mttcg_supported = true,
     /*
      * The x86 has a strong memory model with some store-after-load re-ordering
      */
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f5b8ef29ab0..19151651ae0 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -864,6 +864,7 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps loongarch_tcg_ops = {
+    .mttcg_supported = true,
     .guest_default_memory_order = 0,
 
     .initialize = loongarch_translate_init,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index b2d8c8f1dea..2fda167b73e 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -589,6 +589,7 @@ static const struct SysemuCPUOps m68k_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps m68k_tcg_ops = {
+    .mttcg_supported = false,
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 4efba0dddb2..65c461265fb 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -427,6 +427,7 @@ static const struct SysemuCPUOps mb_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps mb_tcg_ops = {
+    .mttcg_supported = true,
     /* MicroBlaze is always in-order. */
     .guest_default_memory_order = TCG_MO_ALL,
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 010773405a8..77bdb6db887 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -550,6 +550,7 @@ static const Property mips_cpu_properties[] = {
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
 static const TCGCPUOps mips_tcg_ops = {
+    .mttcg_supported = TARGET_LONG_BITS == 32,
     .guest_default_memory_order = 0,
 
     .initialize = mips_tcg_init,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 87fe779042c..51df212bd6b 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -243,6 +243,7 @@ static const struct SysemuCPUOps openrisc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps openrisc_tcg_ops = {
+    .mttcg_supported = true,
     .guest_default_memory_order = 0,
 
     .initialize = openrisc_translate_init,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 8300fa5777e..f95c731c97f 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7478,6 +7478,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps ppc_tcg_ops = {
+  .mttcg_supported = TARGET_LONG_BITS == 64,
   .guest_default_memory_order = 0,
   .initialize = ppc_translate_init,
   .translate_code = ppc_translate_code,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 88f7cdb887c..3afbae9733b 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -141,6 +141,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
 }
 
 static const TCGCPUOps riscv_tcg_ops = {
+    .mttcg_supported = true,
     .guest_default_memory_order = 0,
 
     .initialize = riscv_translate_init,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index f073fe8fc98..654bf7ae5b2 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -204,6 +204,7 @@ static const struct SysemuCPUOps rx_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps rx_tcg_ops = {
+    .mttcg_supported = false,
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 1e101b5afeb..41cccc1e692 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -345,6 +345,7 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 }
 
 static const TCGCPUOps s390_tcg_ops = {
+    .mttcg_supported = true,
     /*
      * The z/Architecture has a strong memory model with some
      * store-after-load re-ordering.
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 7a05301c6ff..e20e49fca8a 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -262,6 +262,7 @@ static const struct SysemuCPUOps sh4_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps superh_tcg_ops = {
+    .mttcg_supported = false,
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 56d9417ae3f..f6b3c0f129a 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1001,6 +1001,7 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps sparc_tcg_ops = {
+    .mttcg_supported = true,
     /*
      * From Oracle SPARC Architecture 2015:
      *
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index c68954b4096..258f55a566f 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -172,6 +172,7 @@ static const struct SysemuCPUOps tricore_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps tricore_tcg_ops = {
+    .mttcg_supported = false,
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
     .initialize = tricore_tcg_init,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 2cbf4e30108..3f00e8e4239 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -232,6 +232,7 @@ static const struct SysemuCPUOps xtensa_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps xtensa_tcg_ops = {
+    .mttcg_supported = true,
     /* Xtensa processors have a weak memory model */
     .guest_default_memory_order = 0,
 
-- 
2.47.1


