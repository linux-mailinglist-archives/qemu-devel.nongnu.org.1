Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1008B7DACD0
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:52:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77j-0007Qj-Ok; Sun, 29 Oct 2023 10:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77h-0007P3-8q
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:41 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77d-00055n-Gs
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32ded3eb835so2734509f8f.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591036; x=1699195836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OztiM/F5GCfouycImZ6YpPyaA1zRCAoz10JdWWv1sX8=;
 b=j8KCy+VbSBfgaC3UTXNirn058unIjWxlwXmhskWUTz1d5lHuTvqMUKmSFFLNWS/SP0
 wALRJleDIhb/FPVPoHgU8SJbNkynGXaGWfEydkWthwW0FXrPdzL8o2Nh8HsaSM6tbcDK
 ftvK24VdqM0Y+ROqsl4ThVPDp/rwnGc2ONjlYjc3kWrBL2MT4AaxlAmbQglb5fpefHp0
 FvEbtkUeX5YXv09NGI6r5laYSJyaoJkUiwYM4J55n+1HYtvYjQj23IuZy2OoOB30dxVH
 alPyX0FVSWg3czS8LHt41HalYlGaR2t5GFwjoiCSXSlB64My1MMCJES1zVekK62kyLgL
 MPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591036; x=1699195836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OztiM/F5GCfouycImZ6YpPyaA1zRCAoz10JdWWv1sX8=;
 b=OyMAY/fRp7gbpr2hbXeZ53nJsWwXtr7RoQ2bDJcv9Vtroewt36W3zPQLZkcx9aK+8h
 mBJn/4PdcwU7gXFHW2JUVPdChGRj2Ru09BlyUuY0Q2HEa4sxXqh3DSZdDA3iRiXe5nTu
 fIFXmciqyREbH1nfXnxVLq6HelslJHetWGxp1NsDDtPHrSo8BWTXiHeX8nlfzo56wlxM
 Lv82/uQsK1hCQDbHNYb2G23jEPX7chLpjXsaOMMMDZAljK0y8qgQvfetN0j/gac8uwip
 /kkkpYo9yD5Xi93bdUy5dwZ7XGZA4bim+6s9d7c3tVUFBkM76DM8VK3ovAXFibOVSvr+
 wy/Q==
X-Gm-Message-State: AOJu0YwwmOoIJMrWG6b85+rUFoHUEby5ptg37uMqCLxszW098x2OHoRk
 k/Eodg8aq1FCTVoLgF+9owl4oA==
X-Google-Smtp-Source: AGHT+IF2FKctTRjnnKWGjnI89zYKtw6S6CUMQr+kOUa4pNQOt+f4VgpGLvAlMkx0E25zA511z2v4Dw==
X-Received: by 2002:a5d:644f:0:b0:32d:ccde:73a0 with SMTP id
 d15-20020a5d644f000000b0032dccde73a0mr5218328wrw.33.1698591035459; 
 Sun, 29 Oct 2023 07:50:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o12-20020a056000010c00b003232f167df5sm6084952wrx.108.2023.10.29.07.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4122B5F7A2;
 Sun, 29 Oct 2023 14:50:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kyle Evans <kevans@freebsd.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Brian Cain <bcain@quicinc.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 02/19] tests/tcg: Add -fno-stack-protector
Date: Sun, 29 Oct 2023 14:50:16 +0000
Message-Id: <20231029145033.592566-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A build of GCC 13.2 will have stack protector enabled by default if it
was configured with --enable-default-ssp option. For such a compiler,
it is necessary to explicitly disable stack protector when linking
without standard libraries.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230731091042.139159-3-akihiko.odaki@daynix.com>
[AJB: fix comment string typo]
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231028103311.347104-3-alex.bennee@linaro.org>
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


