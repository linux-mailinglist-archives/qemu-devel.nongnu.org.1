Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7D87DA673
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:35:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdM-0006L5-H0; Sat, 28 Oct 2023 06:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgdF-0006El-FX
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:29 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd6-00038s-7f
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4083740f92dso22744745e9.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489193; x=1699093993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maGo4SQ2Nh/uMnXYztWkxCmfjY3u1YXmSOVeK9kBr3c=;
 b=BvCtYU81hoRd6YnGZtDkgSxAwQ6Qjd7EEKG16HQTINlyaALDCW0AeU+0pdPH/s+oG3
 4ePw2bjVBYdLp/TLC3HELS6C0wPNIqn/SvMRClMt8I1IMj0JdpiH7btIGyCYD5gYVOca
 fAL3rHn4mYa35tmPs1B7Iw/JsVfbD5+geomBFtAFq0MNeLo+xmp4LD77QdEIEAUUziSq
 cKLnI1z/SVDoJRubaIdLjeodi1sUeVeSBQVe+xYUyZUDMy5FFdq4/J9btfA63o7r4YOf
 f4rpOBTPh5mBdCVNiXbgIt0Z1eiK31bTrcLd6CbjS4q1go3bWqo4XqED1N5e3PQvItIG
 2jDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489193; x=1699093993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=maGo4SQ2Nh/uMnXYztWkxCmfjY3u1YXmSOVeK9kBr3c=;
 b=I/Fbo31A+nX0o/ZqQ8Bvapzn9K2GL0FkS1tSNmMu3JVHkj07MbUy6R/G6i7x4LUj4n
 5pSTyTcn+RtfhnaM4hBfXAI0lymwtnKHwhArreYVrnERbaFA3NtfAxWrb9L7dZNCfvEZ
 TIYXXHKgiFKXWED3Ol0eEYpzKWIP8HDQwdt3Yl+WxoQAsIlH4jeSZJswgvkN+amkDvuO
 ttF1p+49hT82b7T18Labu8UXQHUXm6Obabd5KHOdLSq09KPbAF+dYKIyGBBJS5uAhU3T
 vQqETD8WrKm/LnudHoeh9yMxcgHWf4MZdwSy3Ayqmy4hNusQe8TPw9wBjN1jkj3hHqUT
 v/HA==
X-Gm-Message-State: AOJu0YwRJcEWuVPmAN6akrf9oS71s0evmyvU1Nw9tuGL5OLKYYaw3hMw
 aMNdDfXqMaRpoq51Z6nBFDaLUQ==
X-Google-Smtp-Source: AGHT+IHVH7/HpmcT43Xx6v23xY/KY74bDdGKTB01AdWue0o0TBQm3NfGPmbiWoKutecEt9iWDYxSGw==
X-Received: by 2002:a05:600c:4f55:b0:408:3707:b199 with SMTP id
 m21-20020a05600c4f5500b004083707b199mr4073665wmq.3.1698489193301; 
 Sat, 28 Oct 2023 03:33:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 y20-20020a1c4b14000000b0040588d85b3asm7021327wma.15.2023.10.28.03.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E37F5F798;
 Sat, 28 Oct 2023 11:33:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 02/17] tests/tcg: Add -fno-stack-protector
Date: Sat, 28 Oct 2023 11:32:56 +0100
Message-Id: <20231028103311.347104-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A build of GCC 13.2 will have stack protector enabled by default if it
was configured with --enable-default-ssp option. For such a compiler,
it is necessary to explicitly disable stack protector when linking
without standard libraries.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230731091042.139159-3-akihiko.odaki@daynix.com>
[AJB: fix comment string typo]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/mips/hello-mips.c       | 4 ++--
 tests/tcg/Makefile.target         | 2 +-
 tests/tcg/aarch64/Makefile.target | 2 +-
 tests/tcg/arm/Makefile.target     | 2 +-
 tests/tcg/cris/Makefile.target    | 2 +-
 tests/tcg/hexagon/Makefile.target | 2 +-
 tests/tcg/i386/Makefile.target    | 2 +-
 tests/tcg/minilib/Makefile.target | 2 +-
 tests/tcg/mips/Makefile.target    | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/tcg/mips/hello-mips.c b/tests/tcg/mips/hello-mips.c
index 4e1cf501af..38e22d00e3 100644
--- a/tests/tcg/mips/hello-mips.c
+++ b/tests/tcg/mips/hello-mips.c
@@ -5,8 +5,8 @@
 * http://www.linux-mips.org/wiki/MIPSABIHistory
 * http://www.linux.com/howtos/Assembly-HOWTO/mips.shtml
 *
-* mipsel-linux-gcc -nostdlib -mno-abicalls -fno-PIC -mabi=32 \
-*                  -O2 -static -o hello-mips hello-mips.c
+* mipsel-linux-gcc -nostdlib -mno-abicalls -fno-PIC -fno-stack-protector \
+*                  -mabi=32 -O2 -static -o hello-mips hello-mips.c
 *
 */
 #define __NR_SYSCALL_BASE	4000
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index f3a189c9d4..8cf65f68dd 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -123,7 +123,7 @@ else
 # For system targets we include a different Makefile fragment as the
 # build options for bare programs are usually pretty different. They
 # are expected to provide their own build recipes.
-EXTRA_CFLAGS += -ffreestanding
+EXTRA_CFLAGS += -ffreestanding -fno-stack-protector
 -include $(SRC_PATH)/tests/tcg/minilib/Makefile.target
 -include $(SRC_PATH)/tests/tcg/multiarch/system/Makefile.softmmu-target
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 62b38c792f..0c84b61ae0 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -53,7 +53,7 @@ endif
 # bti-1 tests the elf notes, so we require special compiler support.
 ifneq ($(CROSS_CC_HAS_ARMV8_BTI),)
 AARCH64_TESTS += bti-1 bti-3
-bti-1 bti-3: CFLAGS += -mbranch-protection=standard
+bti-1 bti-3: CFLAGS += -fno-stack-protector -mbranch-protection=standard
 bti-1 bti-3: LDFLAGS += -nostdlib
 endif
 # bti-2 tests PROT_BTI, so no special compiler support required.
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
-- 
2.39.2


