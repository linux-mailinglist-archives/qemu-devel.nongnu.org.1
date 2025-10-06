Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C2BBBD966
	for <lists+qemu-devel@lfdr.de>; Mon, 06 Oct 2025 12:04:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5i1O-0002XE-Ho; Mon, 06 Oct 2025 06:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5i0S-0001Y1-8k
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:59:49 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1v5i0Q-00041U-Gz
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 05:59:48 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 4A9CD60B91
 for <qemu-devel@nongnu.org>; Mon,  6 Oct 2025 11:59:45 +0200 (CEST)
Received: (qmail 21069 invoked by uid 990); 6 Oct 2025 09:59:45 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 06 Oct 2025 11:59:45 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v7 25/25] tests: add test with interrupted memory accesses on
 rv64
Date: Mon,  6 Oct 2025 11:59:20 +0200
Message-ID: <729c8db0f4b61033f5a460747ea50fced9dabc1e.1759744337.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1759744337.git.neither@nut.email>
References: <cover.1759744337.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.214157) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.814157
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=mVLyiyy1HWjSWhu1/Q5w+icoVuven8S3d7VhRcdbntg=;
 b=ns2lwxA4B0p8ltBmZnDMEHNw0Bq5Ga6Y1QM+vbpm/5XynLaOFk2vRdl0z3AgZ0Stw+7b+/F/XH
 M68z3dtDsNwwfxZQ0Z6Mp1UzWu2eygtlTiPkCrIq9YHO2vtMdiv9HaVRd/hGJuoH9shb9xDPRE0g
 0nEUonUD4B3KaRyVeZWIlI60J208FwcZalZHqWxcO0vDKX2mm4TgPS4s2kRTD6XgabwuXNM8BDld
 hGhjp11tFyBks+F9BHHoKGownnqcPohMYxbp85Vx9OnIdEcKyw8VsP5EIeJQvWOPQGbMxXLU48Ma
 /zNwBH5ytJE/8FsWNZCWo+MKrDE7i/1LEpr1W7YgP+fUI2wMN9TurOgK/UyIBDSLJ3tc7BlczeNp
 r6d4zcGt6AVve4FwvqmmbdaoPrt7BkkxvHXnqiz0bhtQxxJ7lPoHbMGZDsjrIIeCoW2GYy9KJO2m
 Vpj0reCAd4zAizhzLlny7qo5eNNnDsri8J8ZZZ8FxstKy3NFHygsesJEfobv9+biXzDzoWbHjfjh
 iqInSOPHfDv8khneqkrRZFEMnc+5cSdtdHuSPDCtVt2QNN47Iso5GQaIhUnmzaQGwJ+WQFJXIJXn
 Nt94ahfTZndbW6MbGi4YKsDEPKqPOuELNFf+Q2rcx/XwgpPYiRyJgwJzdhoTInMwibneeEDBY9mg
 w=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This test aims at catching API misbehaviour w.r.t. the interaction
between interrupts and memory accesses, such as the bug fixed in

    27f347e6a1d269c533633c812321cabb249eada8

Because the condition for triggering misbehaviour may not be
deterministic and the cross-section between memory accesses and
interrupt handlers may be small, we have to place our trust in large
numbers. Instead of guessing/trying an arbitrary, fixed loop-bound, we
decided to loop for a fixed amount of real-time. This avoids the test
running into a time-out on slower machines while enabling a high number
of possible interactions on faster machines.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 tests/tcg/riscv64/Makefile.softmmu-target |  6 ++
 tests/tcg/riscv64/interruptedmemory.S     | 67 +++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 tests/tcg/riscv64/interruptedmemory.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 1a71a78653..d8f92b8e61 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -30,5 +30,11 @@ run-plugin-doubletrap: doubletrap
 	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $*.pout \
 	  $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-plugin-interruptedmemory
+run-plugin-interruptedmemory: interruptedmemory
+	$(call run-test, $<, \
+	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $*.pout \
+	  $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/interruptedmemory.S b/tests/tcg/riscv64/interruptedmemory.S
new file mode 100644
index 0000000000..a32d672849
--- /dev/null
+++ b/tests/tcg/riscv64/interruptedmemory.S
@@ -0,0 +1,67 @@
+	.option norvc
+
+	.text
+	.global _start
+_start:
+	# Set up trap vector
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	# Set up timer
+	lui	t1, 0x02004
+	sd	zero, 0(t1) # MTIMECMP0
+
+	# Enable timer interrupts
+	li	t0, 0x80
+	csrrs	zero, mie, t0
+	csrrsi	zero, mstatus, 0x8
+
+	# Find out when to stop
+	call	rtc_get
+	li	t0, 60
+	slli	t0, t0, 30 # Approx. 10e9 ns
+	add	t0, t0, a0
+
+	# Loop with memory accesses
+	la	t1, semiargs
+0:
+	ld	t2, 0(t1)
+	sd	t2, 0(t1)
+	call	rtc_get
+	bltu	a0, t0, 0b
+
+	li	a0, 0
+	lla	a1, semiargs
+	li	t0, 0x20026	# ADP_Stopped_ApplicationExit
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	# TARGET_SYS_EXIT_EXTENDED
+
+	# Semihosting call sequence
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+rtc_get:
+	# Get current time from the goldfish RTC
+	lui	t3, 0x0101
+	lw	a0, 0(t3)
+	lw	t3, 4(t3)
+	slli	t3, t3, 32
+	add	a0, a0, t3
+	ret
+
+trap:
+	lui	t5, 0x0200c
+	ld	t6, -0x8(t5) # MTIME
+	addi	t6, t6, 100
+	lui	t5, 0x02004
+	sd	t6, 0(t5) # MTIMECMP
+	mret
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.49.1


