Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAEB7F16EF
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:14:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55th-0006O1-Fk; Mon, 20 Nov 2023 10:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tW-0005vo-74
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:09:02 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tI-0001MK-Dt
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:09:01 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso19090855e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492926; x=1701097726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9723xBaPChd48Q2Z6VrVXqqZ/PYaPzTSFScKX3Q69c=;
 b=a3qztZ4yxo48hbmTRTyVOlh4+0o4I6C4rKfebILfOD8RntrYJB0ejRurRqdSwVZjtb
 197U/TcpJ9MbgkloSZUlRZqHo0XruyyIgLpHWUeAR1SRi3ZGM+oWj4gfZ4PgEpdtHHCT
 Bu45c3raxVDslHXZrPD9Z+K0cWHyaYvMrDpx2JdCSWZyoXNwgn2UXhXo13e2bmSru0or
 KF2oDxst4ciK5e6wA3i53whfPb9eJoMalFZOS3nCf/cbz5xRSYayLqWot7n2G3iBDRtg
 sz58uT8kChTods/Av7V5CEZmKNbc8VsZzzLzUxhMtmQdTtvoAUPS1idDOPtmIx/bnG9L
 FF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492926; x=1701097726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9723xBaPChd48Q2Z6VrVXqqZ/PYaPzTSFScKX3Q69c=;
 b=Q4nA6CiSPK4iHUdh0bgC+vykVFUTVZOSuSXhawvgrY3zjzNhdUIHgV94TbCFYqYywt
 DvV2OhUhAHISGL34NJcjn5SAhp9ccxS03Xx87iTSmi36+ywC4usZG6OA5cTSW5C0osxL
 79C/YBYWPTFPTDe2uHXLcZji84t21JXVxNDdxFBH7glsKBg3nNr4qqftV/j0ehyx9IiV
 P5Gxy3dPWgy/PzNJqaCx/QBF2CFKjOcmTYf1n6zOgE5TRuDLBG1V4SdBz7aNQkVfuZ5y
 Y+8p8Bf2OxLDVeL/+7FiECM86koguNrrRAHJRqIdrcNwZg12aD+B2x7DzyucbB4xOn30
 AzaQ==
X-Gm-Message-State: AOJu0YzjmDkMPElNAlSDxaoW3H2z+FbUgsHOxh/irvy9yhu1I5jHcJAO
 91rUohj1vEtYCbur4iunp1RuWg==
X-Google-Smtp-Source: AGHT+IEW7RMJwGLr87ADHMs2b6yOzpNnUGuakZWs8wVeD9lyvE06mI+6Ofa+E8vaaSgh9dgZGPV2dg==
X-Received: by 2002:a05:600c:3ba2:b0:3fe:1b4e:c484 with SMTP id
 n34-20020a05600c3ba200b003fe1b4ec484mr6461662wms.5.1700492926286; 
 Mon, 20 Nov 2023 07:08:46 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b11-20020a05600010cb00b00332c0d256c5sm6570827wrx.80.2023.11.20.07.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:08:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0279F655DF;
 Mon, 20 Nov 2023 15:08:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 11/14] tests/tcg: enable arm softmmu tests
Date: Mon, 20 Nov 2023 15:08:30 +0000
Message-Id: <20231120150833.2552739-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120150833.2552739-1-alex.bennee@linaro.org>
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

To make it easier to test 32 bit Arm softmmu issues implement a basic
boot.S so we can build the multiarch tests. Currently CHECK_UNALIGNED
is disabled as I haven't got the right magic set for it to work.

Message-Id: <20231115205542.3092038-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use endf macro for global function symbols in boot.S
---
 tests/tcg/arm/Makefile.softmmu-target |  64 +++++-
 tests/tcg/arm/system/boot.S           | 301 ++++++++++++++++++++++++++
 tests/tcg/arm/system/kernel.ld        |  24 ++
 3 files changed, 379 insertions(+), 10 deletions(-)
 create mode 100644 tests/tcg/arm/system/boot.S
 create mode 100644 tests/tcg/arm/system/kernel.ld

diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 7857ab9324..aadc12767e 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -8,20 +8,64 @@ ARM_SRC=$(SRC_PATH)/tests/tcg/arm/system
 # Set search path for all sources
 VPATH 		+= $(ARM_SRC)
 
-ARM_TESTS=test-armv6m-undef
+# Specific Test Rules
 
-TESTS += $(ARM_TESTS)
+test-armv6m-undef: test-armv6m-undef.S
+	$(CC) -mcpu=cortex-m0 -mfloat-abi=soft \
+		-Wl,--build-id=none -x assembler-with-cpp \
+		$< -o $@ -nostdlib -N -static \
+		-T $(ARM_SRC)/$@.ld
 
-LDFLAGS+=-nostdlib -N -static
+run-test-armv6m-undef: QEMU_OPTS+=-semihosting -M microbit -kernel
 
-%: %.S %.ld
-	$(CC) $(CFLAGS) $(ASFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) -T $(ARM_SRC)/$@.ld
+ARM_TESTS+=test-armv6m-undef
 
-# Specific Test Rules
+# These objects provide the basic boot code and helper functions for all tests
+CRT_OBJS=boot.o
 
-test-armv6m-undef: EXTRA_CFLAGS+=-mcpu=cortex-m0 -mfloat-abi=soft -Wl,--build-id=none -x assembler-with-cpp
+ARM_TEST_SRCS=$(wildcard $(ARM_SRC)/*.c)
+ARM_TESTS+=$(patsubst $(ARM_SRC)/%.c, %, $(ARM_TEST_SRCS))
 
-run-test-armv6m-undef: QEMU_OPTS+=-semihosting -M microbit -kernel
+CRT_PATH=$(ARM_SRC)
+LINK_SCRIPT=$(ARM_SRC)/kernel.ld
+LDFLAGS=-Wl,-T$(LINK_SCRIPT)
+CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
+LDFLAGS+=-static -nostdlib -N $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
+
+# building head blobs
+.PRECIOUS: $(CRT_OBJS)
+
+%.o: $(ARM_SRC)/%.S
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -c $< -o $@
+
+# Build and link the tests
+%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+
+memory: CFLAGS+=-DCHECK_UNALIGNED=0
+
+# Running
+QEMU_BASE_MACHINE=-M virt -cpu max -display none
+QEMU_OPTS+=$(QEMU_BASE_MACHINE) -semihosting-config enable=on,target=native,chardev=output -kernel
+
+# Simple Record/Replay Test
+.PHONY: memory-record
+run-memory-record: memory-record memory
+	$(call run-test, $<, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
+		  -icount shift=5$(COMMA)rr=record$(COMMA)rrfile=record.bin \
+		  $(QEMU_OPTS) memory)
+
+.PHONY: memory-replay
+run-memory-replay: memory-replay run-memory-record
+	$(call run-test, $<, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
+		  -icount shift=5$(COMMA)rr=replay$(COMMA)rrfile=record.bin \
+		  $(QEMU_OPTS) memory)
+
+EXTRA_RUNS+=run-memory-replay
 
-# We don't currently support the multiarch system tests
-undefine MULTIARCH_TESTS
+TESTS += $(ARM_TESTS) $(MULTIARCH_TESTS)
+EXTRA_RUNS+=$(MULTIARCH_RUNS)
diff --git a/tests/tcg/arm/system/boot.S b/tests/tcg/arm/system/boot.S
new file mode 100644
index 0000000000..7915502ae4
--- /dev/null
+++ b/tests/tcg/arm/system/boot.S
@@ -0,0 +1,301 @@
+/*
+ * Minimal ArmV7 system boot code.
+ *
+ * Using semihosting for serial output and exit functions.
+ */
+
+/*
+ * Semihosting interface on ARM AArch32
+ * R0 - semihosting call number
+ * R1 - semihosting parameter
+ */
+#define semihosting_call svc 0x123456
+#define SYS_WRITEC	0x03	/* character to debug channel */
+#define SYS_WRITE0	0x04	/* string to debug channel */
+#define SYS_EXIT	0x18
+
+#define ADP_Stopped_ApplicationExit	0x20026
+#define ADP_Stopped_InternalError	0x20024
+
+/*
+ * Helper macro for the linker calling subroutines from the C code.
+ */
+.macro 	endf 	name
+	.global	\name
+	.type	\name, %function
+	.size	\name, . - \name
+.endm
+
+	.section	.interrupt_vector, "ax"
+	.align	5
+
+vector_table:
+	b   reset		/* reset vector */
+	b   undef_instr        /* undefined instruction vector */
+	b   software_intr    	/* software interrupt vector */
+	b   prefetch_abort		/* prefetch abort vector */
+	b   data_abort	        /* data abort vector */
+	nop			            /* reserved */
+	b   IRQ_handler        	/* IRQ vector */
+	b   FIQ_handler        	/* FIQ vector */
+
+	.text
+__start:
+	ldr  	r0, =vector_table
+	mcr  	p15, 0, r0, c12, c0, 0  /* Set up VBAR */
+
+	ldr	sp, =stack_end		/* Set up the stack */
+	bl	mmu_setup		/* Set up the MMU */
+	bl	main			/* Jump to main */
+
+endf	__start
+
+_exit:
+	cmp r0, #0
+	ite EQ  // if-then-else. "EQ" is for if equal, else otherwise
+	ldreq r1, =ADP_Stopped_ApplicationExit // if r0 == 0
+	ldrne r1, =ADP_Stopped_InternalError   // else
+	mov r0, #SYS_EXIT
+	semihosting_call
+
+endf	_exit
+
+	/*
+ * Helper Functions
+ */
+
+mmu_setup:
+	/*
+  	 * The MMU setup for this is very simple using two stage one
+	 * translations. The first 1Mb section points to the text
+	 * section and the second points to the data and rss.
+         * Currently the fattest test only needs ~50k for that so we
+ 	 * have plenty of space.
+	 *
+	 * The short descriptor Section format is as follows:
+	 *
+	 *  PA[31:20] - Section Base Address
+	 *  NS[19] - Non-secure bit
+	 *  0[18] - Section (1 for Super Section)
+	 *  nG[17] - Not global bit
+	 *  S[16] - Shareable
+	 *  TEX[14:12] - Memory Region Attributes
+	 *  AP[15, 11:10] - Access Permission Bits
+	 *  IMPDEF[9]
+	 *  Domain[8:5]
+	 *  XN[4] - Execute never bit
+	 *  C[3] - Memory Region Attributes
+	 *  B[2] - Memory Region Attributes
+	 *  1[1]
+	 *  PXN[0] - Privileged Execute Never
+	 *
+	 * r0 - point at the table
+	 * r1 - address
+	 * r2 - entry
+	 * r3 - common section bits
+	 * r4 - scratch
+	 */
+
+	/*
+	 * Memory Region Bits
+	 *
+	 *   TEX[14:12] = 000
+	 *     C[3]     = 1
+	 *     B[2]     = 1
+	 *
+	 * Outer and Inner WB, no write allocate
+	 */
+	mov r3, #0
+	ldr r4, =(3 << 2)
+	orr r3, r4, r4
+
+	/* Section bit */
+	orr r3, r3, #2
+
+	/* Page table setup (identity mapping). */
+	ldr r0, =ttb
+
+	/* First block: .text/RO/execute enabled */
+	ldr r1, =.text
+	ldr r2, =0xFFF00000  			/* 1MB block alignment */
+	and r2, r1, r2
+	orr r2, r2, r3				/* common bits */
+	orr r2, r2, #(1 << 15)			/* AP[2] = 1 */
+	orr r2, r2, #(1 << 10)			/* AP[0] = 1 => RO @ PL1 */
+
+	lsr r4, r2, #(20 - 2)
+	str r2, [r0, r4, lsl #0]		/* write entry */
+
+	/* Second block: .data/RW/no execute */
+	ldr r1, =.data
+	ldr r2, =0xFFF00000  			/* 1MB block alignment */
+	and r2, r1, r2
+	orr r2, r2, r3				/* common bits */
+	orr r2, r2, #(1 << 10)			/* AP[0] = 1 => RW @ PL1 */
+	orr r2, r2, #(1 << 4)			/* XN[4] => no execute */
+
+	lsr r4, r2, #(20 - 2)
+	str r2, [r0, r4, lsl #0]		/* write entry */
+
+	/*
+	 * DACR - Domain Control
+	 *
+	 * Enable client mode for domain 0 (we don't use any others)
+	 */
+	ldr r0, =0x1
+	mcr p15, 0, r0, c3, c0, 0
+
+	/*
+	 * TTCBR - Translation Table Base Control Register
+	 *
+	 * EAE[31] = 0, 32-bit translation, short descriptor format
+	 * N[2:0] = 5 ( TTBRO uses 31:14-5 => 9 bit lookup stage )
+	 */
+	ldr r0, =0x5
+	mcr p15, 0, r0, c1, c0, 2
+
+	/*
+	 * TTBR0 -Translation Table Base Register 0
+	 *
+	 * [31:9] = Base address of table
+	 *
+	 * QEMU doesn't really care about the cache sharing
+	 * attributes so we don't need to either.
+	 */
+	ldr r0, =ttb
+	mcr p15, 0, r0, c2, c0, 0
+
+	/*
+	 * SCTLR- System Control Register
+	 *
+   	 * TE[30] = 0, exceptions to A32 state
+	 * AFE[29] = 0, AP[0] is the access permissions bit
+	 * EE[25] = 0, Little-endian
+	 * WXN[19] = 0 = no effect, Write does not imply XN (execute never)
+	 * I[12] = Instruction cachability control
+	 * C[2] = Data cachability control
+	 * M[0] = 1, enable stage 1 address translation for EL0/1
+         *
+	 * At this point virtual memory is enabled.
+	 */
+	ldr r0, =0x1005
+	mcr p15, 0, r0, c1, c0, 0
+
+	isb
+
+	mov  pc, lr  /* done, return to caller */
+
+/* Output a single character to serial port */
+__sys_outc:
+	STMFD sp!, {r0-r1}  // push r0, r1 onto stack
+	mov r1, sp
+	mov r0, #SYS_WRITEC
+	semihosting_call
+	LDMFD sp!, {r0-r1}  // pop r0, r1 from stack
+	bx lr
+
+endf __sys_outc
+
+reset:
+	ldr	r1, =reset_error
+	b exception_handler
+
+undef_instr:
+	ldr	r1, =undef_intr_error
+	b exception_handler
+
+software_intr:
+	ldr	r1, =software_intr_error
+	b exception_handler
+
+prefetch_abort:
+	ldr	r1, =prefetch_abort_error
+	b exception_handler
+
+data_abort:
+	ldr	r1, =data_abort_error
+	b exception_handler
+
+IRQ_handler:
+	ldr	r1, =irq_error
+	b exception_handler
+
+FIQ_handler:
+	ldr	r1, =fiq_error
+	b exception_handler
+
+/*
+ * Initiate a exit semihosting call whenever there is any exception
+ * r1 already holds the string.
+ */
+exception_handler:
+	mov	r0, #SYS_WRITE0
+	semihosting_call
+	mov	r0, #SYS_EXIT
+	mov	r1, #1
+	semihosting_call
+
+endf	exception_handler
+
+/*
+ * We implement a stub raise() function which errors out as tests
+ * shouldn't trigger maths errors.
+ */
+	.global raise
+raise:
+	mov	r0, #SYS_WRITE0
+	ldr	r1, =maths_error
+	semihosting_call
+	mov	r0, #SYS_EXIT
+	ldr	r1, =ADP_Stopped_InternalError
+	semihosting_call
+
+endf raise
+
+	.data
+
+.data
+
+reset_error:
+	.ascii "Reset exception occurred.\n\0"
+
+undef_intr_error:
+	.ascii "Undefined Instruction Exception Occurred.\n\0"
+
+software_intr_error:
+	.ascii "Software Interrupt Occurred.\n\0"
+
+prefetch_abort_error:
+	.ascii "Prefetch Abort Occurred.\n\0"
+
+data_abort_error:
+	.ascii "Data Abort Occurred.\n\0"
+
+irq_error:
+	.ascii "IRQ exception occurred.\n\0"
+
+fiq_error:
+	.ascii "FIQ exception occurred.\n\0"
+
+maths_error:
+	.ascii "Software maths exception.\n\0"
+
+
+	/*
+	 * 1st Stage Translation table
+	 * 4096 entries, indexed by [31:20]
+	 * each entry covers 1Mb of address space
+	 * aligned on 16kb
+	 */
+	.align	15
+ttb:
+	.space	(4096 * 4), 0
+
+	.align	12
+
+	/* Space for stack */
+	.align	5
+	.section .bss
+stack:
+	.space 65536, 0
+stack_end:
diff --git a/tests/tcg/arm/system/kernel.ld b/tests/tcg/arm/system/kernel.ld
new file mode 100644
index 0000000000..7b3a76dcbf
--- /dev/null
+++ b/tests/tcg/arm/system/kernel.ld
@@ -0,0 +1,24 @@
+ENTRY(__start)
+
+SECTIONS
+{
+    /* virt machine, RAM starts at 1gb */
+    . = (1 << 30);
+    .text : {
+        *(.text)
+    }
+    .rodata : {
+        *(.rodata)
+    }
+    /* align r/w section to next 2mb */
+    . = ALIGN(1 << 21);
+    .data : {
+        *(.data)
+    }
+    .bss : {
+        *(.bss)
+    }
+    /DISCARD/ : {
+        *(.ARM.attributes)
+    }
+}
-- 
2.39.2


