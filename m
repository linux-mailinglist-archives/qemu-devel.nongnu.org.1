Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F56768C7D
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:00:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQMsY-0007kh-2K; Mon, 31 Jul 2023 02:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQMsS-0007j0-QC
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:59:36 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQMsQ-0001LG-L9
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:59:36 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bba54f7eefso32894545ad.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jul 2023 23:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690786773; x=1691391573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DYvTqXgC0HuTtAYRh6gTiT5Q7fqN8+LSUnzr3N+U04=;
 b=umsz1RVwPsjEqe/i4ojdN0v+m0aRKucs0oVY8nTTe3tcTQDMe87jNdJtuz5lv3PjLi
 BzNwgIUXeXeuMY2zpvfidnvNZzoXXJ4y8lN6LRMQylcw+plnTsONBsQied12YJTQRCaB
 XCV4XkXWIH+6hLxdOhW+Ob2FFyQHkcHwQ1ZIzdh/0IZc/SFV7vdt95eRHfRDk5F0eMH3
 dOW7orrES+pkp1Hyynqk6fAYfjLl+0teuDFn/aHsU7Yk1uOpi9lpKM2tOu7IJZiIAEzk
 Rf33widYlmse8lSgK4c5F6H/bAa5rd04LuHfJpwPzcQQDmbVTpdlItmKOJqnQcLLv3Cd
 EDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690786773; x=1691391573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DYvTqXgC0HuTtAYRh6gTiT5Q7fqN8+LSUnzr3N+U04=;
 b=DpAMP4XRoc5WNk0qs8PBX9LohVgvj5MLaLWIFlXOFLCgufAT1/3V4RtbhNBkXcrZuj
 Jn12mUihP1IxKS6perVRTCeGg4ClwUz8IQfoXNu75XoP1WmIbsXCjwhI3LEwdtidZBFh
 BW247N4AitEZhPE65iFKLWfp3y54c+jLR+ukY+n5QPR3JeABYkCLIsp9awAW4YqTe2eT
 0OqRgTqnQ/XfkNXdQ8HjDki82MXNEvAw7qzG4DkuxKie4zc8JcJjrX3o16oE1cTK01BB
 pQAhw/PXLXXeiiY/Nl5CKA9/APEF5lu7xA6i2HCyupqJlBax9tkJs0kwOAHfnPOpK4PG
 cD2Q==
X-Gm-Message-State: ABy/qLaD+UdVWEGt52kKlx3SxjClJiv+PczbbGz7Lz5VdtFD+rz2yxau
 jn81LZaCgbIgg8kbPA2isFqlXw==
X-Google-Smtp-Source: APBJJlFKp4TTFlMl/her2N0AEcMZD+PaG20O6grzYfDHXpaibX0vxZywkKL7VX5DxcLInDlHS1Hs/g==
X-Received: by 2002:a17:903:41d1:b0:1b0:3ab6:5140 with SMTP id
 u17-20020a17090341d100b001b03ab65140mr10379402ple.4.1690786773391; 
 Sun, 30 Jul 2023 23:59:33 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 l16-20020a170903121000b001b8af7f632asm7684988plh.176.2023.07.30.23.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jul 2023 23:59:33 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 3/3] tests/tcg: Add -fno-stack-protector
Date: Mon, 31 Jul 2023 15:58:56 +0900
Message-ID: <20230731065904.5869-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731065904.5869-1-akihiko.odaki@daynix.com>
References: <20230731065904.5869-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A build of GCC 13.2 will have stack protector enabled by default if it
was configured with --enable-default-ssp option. For such a compiler,
it is necessary to explicitly disable stack protector when linking
without standard libraries.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/tcg/mips/hello-mips.c                   | 4 ++--
 tests/tcg/aarch64/Makefile.softmmu-target     | 2 +-
 tests/tcg/aarch64/Makefile.target             | 2 +-
 tests/tcg/alpha/Makefile.softmmu-target       | 2 +-
 tests/tcg/arm/Makefile.target                 | 2 +-
 tests/tcg/cris/Makefile.target                | 2 +-
 tests/tcg/hexagon/Makefile.target             | 2 +-
 tests/tcg/i386/Makefile.softmmu-target        | 2 +-
 tests/tcg/i386/Makefile.target                | 2 +-
 tests/tcg/loongarch64/Makefile.softmmu-target | 2 +-
 tests/tcg/minilib/Makefile.target             | 2 +-
 tests/tcg/mips/Makefile.target                | 2 +-
 tests/tcg/nios2/Makefile.softmmu-target       | 2 +-
 tests/tcg/s390x/Makefile.softmmu-target       | 2 +-
 tests/tcg/x86_64/Makefile.softmmu-target      | 2 +-
 15 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tests/tcg/mips/hello-mips.c b/tests/tcg/mips/hello-mips.c
index 4e1cf501af..0ba5f1bf23 100644
--- a/tests/tcg/mips/hello-mips.c
+++ b/tests/tcg/mips/hello-mips.c
@@ -5,8 +5,8 @@
 * http://www.linux-mips.org/wiki/MIPSABIHistory
 * http://www.linux.com/howtos/Assembly-HOWTO/mips.shtml
 *
-* mipsel-linux-gcc -nostdlib -mno-abicalls -fno-PIC -mabi=32 \
-*                  -O2 -static -o hello-mips hello-mips.c
+* mipsel-linux-gcc -nostdlib -mno-abicalls -fno-PIC -fno-stack-protector \
+                   -mabi=32 -O2 -static -o hello-mips hello-mips.c
 *
 */
 #define __NR_SYSCALL_BASE	4000
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index b74a2534e3..11016ffab2 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -16,7 +16,7 @@ LINK_SCRIPT=$(AARCH64_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT)
 TESTS+=$(AARCH64_TESTS) $(MULTIARCH_TESTS)
 EXTRA_RUNS+=$(MULTIARCH_RUNS)
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
+CFLAGS+=-nostdlib -fno-stack-protector -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
 config-cc.mak: Makefile
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 617f821613..55f8609897 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -49,7 +49,7 @@ endif
 # bti-1 tests the elf notes, so we require special compiler support.
 ifneq ($(CROSS_CC_HAS_ARMV8_BTI),)
 AARCH64_TESTS += bti-1 bti-3
-bti-1 bti-3: CFLAGS += -mbranch-protection=standard
+bti-1 bti-3: CFLAGS += -fno-stack-protector -mbranch-protection=standard
 bti-1 bti-3: LDFLAGS += -nostdlib
 endif
 # bti-2 tests PROT_BTI, so no special compiler support required.
diff --git a/tests/tcg/alpha/Makefile.softmmu-target b/tests/tcg/alpha/Makefile.softmmu-target
index 09193a62d6..99c23c2903 100644
--- a/tests/tcg/alpha/Makefile.softmmu-target
+++ b/tests/tcg/alpha/Makefile.softmmu-target
@@ -15,7 +15,7 @@ CRT_PATH=$(ALPHA_SYSTEM_SRC)
 LINK_SCRIPT=$(ALPHA_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT)
 TESTS+=$(ALPHA_TESTS) $(MULTIARCH_TESTS)
-CFLAGS+=-nostdlib -g -O1 -mcpu=ev6 $(MINILIB_INC)
+CFLAGS+=-fno-stack-protector -nostdlib -g -O1 -mcpu=ev6 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
 # building head blobs
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 0038cef02c..3473f4619e 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -12,7 +12,7 @@ float_madds: CFLAGS+=-mfpu=neon-vfpv4
 
 # Basic Hello World
 ARM_TESTS = hello-arm
-hello-arm: CFLAGS+=-marm -ffreestanding
+hello-arm: CFLAGS+=-marm -ffreestanding -fno-stack-protector
 hello-arm: LDFLAGS+=-nostdlib
 
 # IWMXT floating point extensions
diff --git a/tests/tcg/cris/Makefile.target b/tests/tcg/cris/Makefile.target
index 43587d2769..713e2a5b6c 100644
--- a/tests/tcg/cris/Makefile.target
+++ b/tests/tcg/cris/Makefile.target
@@ -30,7 +30,7 @@ AS	= $(CC) -x assembler-with-cpp
 LD      = $(CC)
 
 # we rely on GCC inline:ing the stuff we tell it to in many places here.
-CFLAGS  = -Winline -Wall -g -O2 -static
+CFLAGS  = -Winline -Wall -g -O2 -static -fno-stack-protector
 NOSTDFLAGS = -nostartfiles -nostdlib
 ASFLAGS += -mcpu=v10 -g -Wa,-I,$(SRC_PATH)/tests/tcg/cris/bare
 CRT_FILES = crt.o sys.o
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index 87ed2c90b9..f839b2c0d5 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -19,7 +19,7 @@
 EXTRA_RUNS =
 
 CFLAGS += -Wno-incompatible-pointer-types -Wno-undefined-internal
-CFLAGS += -fno-unroll-loops
+CFLAGS += -fno-unroll-loops -fno-stack-protector
 
 HEX_SRC=$(SRC_PATH)/tests/tcg/hexagon
 VPATH += $(HEX_SRC)
diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index 5266f2335a..8e9d0d7690 100644
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ b/tests/tcg/i386/Makefile.softmmu-target
@@ -15,7 +15,7 @@ CRT_OBJS=boot.o
 CRT_PATH=$(I386_SYSTEM_SRC)
 LINK_SCRIPT=$(I386_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_i386
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
+CFLAGS+=-nostdlib -fno-stack-protector -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
 TESTS+=$(MULTIARCH_TESTS)
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index fdf757c6ce..3dec7c6c42 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -35,7 +35,7 @@ run-test-aes: QEMU_OPTS += -cpu max
 #
 # hello-i386 is a barebones app
 #
-hello-i386: CFLAGS+=-ffreestanding
+hello-i386: CFLAGS+=-ffreestanding -fno-stack-protector
 hello-i386: LDFLAGS+=-nostdlib
 
 # test-386 includes a couple of additional objects that need to be
diff --git a/tests/tcg/loongarch64/Makefile.softmmu-target b/tests/tcg/loongarch64/Makefile.softmmu-target
index 908f3a8c0f..4a348469f7 100644
--- a/tests/tcg/loongarch64/Makefile.softmmu-target
+++ b/tests/tcg/loongarch64/Makefile.softmmu-target
@@ -15,7 +15,7 @@ CRT_PATH=$(LOONGARCH64_SYSTEM_SRC)
 LINK_SCRIPT=$(LOONGARCH64_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT)
 TESTS+=$(LOONGARCH64_TESTS) $(MULTIARCH_TESTS)
-CFLAGS+=-nostdlib -g -O1 -march=loongarch64 -mabi=lp64d $(MINILIB_INC)
+CFLAGS+=-nostdlib -fno-stack-protector -g -O1 -march=loongarch64 -mabi=lp64d $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
 # building head blobs
diff --git a/tests/tcg/minilib/Makefile.target b/tests/tcg/minilib/Makefile.target
index c821d2806a..af0bf54be9 100644
--- a/tests/tcg/minilib/Makefile.target
+++ b/tests/tcg/minilib/Makefile.target
@@ -12,7 +12,7 @@ SYSTEM_MINILIB_SRC=$(SRC_PATH)/tests/tcg/minilib
 MINILIB_SRCS=$(wildcard $(SYSTEM_MINILIB_SRC)/*.c)
 MINILIB_OBJS=$(patsubst $(SYSTEM_MINILIB_SRC)/%.c, %.o, $(MINILIB_SRCS))
 
-MINILIB_CFLAGS+=-nostdlib -ggdb -O0
+MINILIB_CFLAGS+=-nostdlib -fno-stack-protector -ggdb -O0
 MINILIB_INC=-isystem $(SYSTEM_MINILIB_SRC)
 
 .PRECIOUS: $(MINILIB_OBJS)
diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
index 1a994d5525..5d17c1706e 100644
--- a/tests/tcg/mips/Makefile.target
+++ b/tests/tcg/mips/Makefile.target
@@ -14,6 +14,6 @@ MIPS_TESTS=hello-mips
 
 TESTS += $(MIPS_TESTS)
 
-hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -mabi=32
+hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -fno-stack-protector -mabi=32
 hello-mips: LDFLAGS+=-nostdlib
 endif
diff --git a/tests/tcg/nios2/Makefile.softmmu-target b/tests/tcg/nios2/Makefile.softmmu-target
index bc7fd55060..96833b385f 100644
--- a/tests/tcg/nios2/Makefile.softmmu-target
+++ b/tests/tcg/nios2/Makefile.softmmu-target
@@ -12,7 +12,7 @@ VPATH += $(NIOS2_SYSTEM_SRC)
 CRT_OBJS = boot.o intr.o $(MINILIB_OBJS)
 LINK_SCRIPT = $(NIOS2_SYSTEM_SRC)/10m50-ghrd.ld
 
-CFLAGS  += -nostdlib -g -O0 $(MINILIB_INC)
+CFLAGS  += -nostdlib -fno-stack-protector -g -O0 $(MINILIB_INC)
 LDFLAGS += -Wl,-T$(LINK_SCRIPT) -static -nostdlib $(CRT_OBJS) -lgcc
 
 %.o: %.S
diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 76345b6e64..27f2d68235 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -2,7 +2,7 @@ S390X_SRC=$(SRC_PATH)/tests/tcg/s390x
 VPATH+=$(S390X_SRC)
 QEMU_OPTS=-action panic=exit-failure -nographic -kernel
 LINK_SCRIPT=$(S390X_SRC)/softmmu.ld
-CFLAGS+=-ggdb -O0
+CFLAGS+=-fno-stack-protector -ggdb -O0
 LDFLAGS=-nostdlib -static
 
 %.o: %.S
diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
index 1bd763f2e6..23887a1660 100644
--- a/tests/tcg/x86_64/Makefile.softmmu-target
+++ b/tests/tcg/x86_64/Makefile.softmmu-target
@@ -15,7 +15,7 @@ CRT_OBJS=boot.o
 CRT_PATH=$(X64_SYSTEM_SRC)
 LINK_SCRIPT=$(X64_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
+CFLAGS+=-nostdlib -fno-stack-protector -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
 TESTS+=$(MULTIARCH_TESTS)
-- 
2.41.0


