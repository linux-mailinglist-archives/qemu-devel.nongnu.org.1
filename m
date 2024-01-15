Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8AC82E330
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 00:16:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPWBz-0007Qj-D6; Mon, 15 Jan 2024 18:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vineetg@rivosinc.com>)
 id 1rPWBW-0006sZ-Mw
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 18:16:03 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vineetg@rivosinc.com>)
 id 1rPWBU-0008U9-Ht
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 18:16:02 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-595b208a050so5728404eaf.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 15:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705360557; x=1705965357;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KR+Zaqyi92JKl7xqLUo7DtCdC0VWnYRkT/eUM4akMrc=;
 b=SoqaXYwMKdyKpwanj9tWgB9Mq0CtCMGFmN8scORLe91I5MoRWrFhqpBfmeioiTR8F3
 7PZXPDktbXYRWIccGnSmp7KJblozk7BB7oldNsgrYK9d8uUJj6Qz86f8n5CdR0HFml9u
 HRjYJjAefWEk7NSS0xFlNvt5JxRV28nOuYUL9Fvl9knaP9qI/7v23QkuKD3m+MCn2C0h
 a6t9M24RQd1hRKFECxK5O2x6sfuAzJDBNTnpMR/EUYuSW5arfaZuLMuDOL6d4b8uMEWV
 yOdfAoT7DzJNUiRLeQ07yFofcLF8iFCfNubN7QYoJNtiq+/D/XBuSsdc2Q2l1vhXzxpt
 7+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705360557; x=1705965357;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KR+Zaqyi92JKl7xqLUo7DtCdC0VWnYRkT/eUM4akMrc=;
 b=vrt1KPtYrnTRlIl5m1oad5RoMtS/Dd1l8+ZIaV6ktBV+WbrhyAE6UyT8olf+uac3pw
 U6a1iVZMaAqqVHqWHM5OsfYsCculDxXwJfhsMtkLRLsrjPG+a/IBG0kgA7MUYixz+s0J
 fPCHR6dqubFlGN9mBworvIqVu5NxJBy9vm07no1Uihj+H5TNNiMx82IN7SjjBUuChIY/
 NYnvLD6+LivvNQZ8gtA4CBLdU1PtsXhxurLISdgDD04ROB9aZ5kWJCxI0xnnFhJmpmMO
 PCMlSX8pJA6nHvPuMxOebNwMw8vEWvA8Faew42XVkG5NPPj4Miij0j6/Ewh4tVX3cJOI
 hGTA==
X-Gm-Message-State: AOJu0YyFn3VTi0iXrxSi+bzTFn8/zEDsKtIX2Mi7JEjFpPmQ3ZsneQ86
 ZlSjvqvkJMKYrVojxpDSq8UWwWR/DMRbu/vVqHgzihaRlbc=
X-Google-Smtp-Source: AGHT+IFD05CCw7o34WTNTYXVBWiQoXTSg7yoO9sMJtzO2I9l/qpwDk88KIsbrxfV83OXJB+vBkSNZA==
X-Received: by 2002:a05:6359:5d1d:b0:175:51c1:70d2 with SMTP id
 ps29-20020a0563595d1d00b0017551c170d2mr3454511rwb.28.1705360557385; 
 Mon, 15 Jan 2024 15:15:57 -0800 (PST)
Received: from vineet-framework.. (c-24-5-188-125.hsd1.ca.comcast.net.
 [24.5.188.125]) by smtp.gmail.com with ESMTPSA id
 oe7-20020a17090b394700b0028e6005f836sm1813182pjb.28.2024.01.15.15.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 15:15:57 -0800 (PST)
From: Vineet Gupta <vineetg@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, Edwin Lu <ewlu@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 gnu-toolchain <gnu-toolchain@rivosinc.com>,
 Vineet Gupta <vineetg@rivosinc.com>
Subject: [PATCH 1/2] linux-user/riscv: vdso: fix call frame info in
 __vdso_rt_sigreturn
Date: Mon, 15 Jan 2024 15:15:51 -0800
Message-Id: <20240115231552.3217789-1-vineetg@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=vineetg@rivosinc.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When testing gcc testsuite against QEMU v8.2 we found some additional
failures vs. v8.1.2.

| FAIL: gcc.dg/cleanup-10.c execution test
| FAIL: gcc.dg/cleanup-11.c execution test
| FAIL: gcc.dg/cleanup-8.c execution test
| FAIL: gcc.dg/cleanup-9.c execution test

All of these tests involve unwinding off signal stack and v8.2 did
introduce a vdso with sigreturn trampoline and associated unwinding
info. It seems that info is not correct and making it similar to
to one in the linux kernel fixes the above failures.

Fixes: 468c1bb5cac9 ("linux-user/riscv: Add vdso")
Reported-by: Edwin Lu <ewlu@rivosinc.com>
Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>
---
 linux-user/riscv/vdso.S | 87 ++---------------------------------------
 1 file changed, 4 insertions(+), 83 deletions(-)

diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
index a86d8fc488e0..20119010c11b 100644
--- a/linux-user/riscv/vdso.S
+++ b/linux-user/riscv/vdso.S
@@ -97,91 +97,12 @@ endf __vdso_flush_icache
  * trampoline, because the unwinder will assume we are returning
  * after a call site.
  */
-
-	.cfi_startproc simple
-	.cfi_signal_frame
-
-#define sizeof_reg	(__riscv_xlen / 4)
-#define sizeof_freg	8
-#define B_GR	(offsetof_uc_mcontext - sizeof_rt_sigframe)
-#define B_FR	(offsetof_uc_mcontext - sizeof_rt_sigframe + offsetof_freg0)
-
-	.cfi_def_cfa	2, sizeof_rt_sigframe
-
-	/* Return address */
-	.cfi_return_column 64
-	.cfi_offset	64, B_GR + 0			/* pc */
-
-	/* Integer registers */
-	.cfi_offset	1, B_GR + 1 * sizeof_reg	/* r1 (ra) */
-	.cfi_offset	2, B_GR + 2 * sizeof_reg	/* r2 (sp) */
-	.cfi_offset	3, B_GR + 3 * sizeof_reg
-	.cfi_offset	4, B_GR + 4 * sizeof_reg
-	.cfi_offset	5, B_GR + 5 * sizeof_reg
-	.cfi_offset	6, B_GR + 6 * sizeof_reg
-	.cfi_offset	7, B_GR + 7 * sizeof_reg
-	.cfi_offset	8, B_GR + 8 * sizeof_reg
-	.cfi_offset	9, B_GR + 9 * sizeof_reg
-	.cfi_offset	10, B_GR + 10 * sizeof_reg
-	.cfi_offset	11, B_GR + 11 * sizeof_reg
-	.cfi_offset	12, B_GR + 12 * sizeof_reg
-	.cfi_offset	13, B_GR + 13 * sizeof_reg
-	.cfi_offset	14, B_GR + 14 * sizeof_reg
-	.cfi_offset	15, B_GR + 15 * sizeof_reg
-	.cfi_offset	16, B_GR + 16 * sizeof_reg
-	.cfi_offset	17, B_GR + 17 * sizeof_reg
-	.cfi_offset	18, B_GR + 18 * sizeof_reg
-	.cfi_offset	19, B_GR + 19 * sizeof_reg
-	.cfi_offset	20, B_GR + 20 * sizeof_reg
-	.cfi_offset	21, B_GR + 21 * sizeof_reg
-	.cfi_offset	22, B_GR + 22 * sizeof_reg
-	.cfi_offset	23, B_GR + 23 * sizeof_reg
-	.cfi_offset	24, B_GR + 24 * sizeof_reg
-	.cfi_offset	25, B_GR + 25 * sizeof_reg
-	.cfi_offset	26, B_GR + 26 * sizeof_reg
-	.cfi_offset	27, B_GR + 27 * sizeof_reg
-	.cfi_offset	28, B_GR + 28 * sizeof_reg
-	.cfi_offset	29, B_GR + 29 * sizeof_reg
-	.cfi_offset	30, B_GR + 30 * sizeof_reg
-	.cfi_offset	31, B_GR + 31 * sizeof_reg	/* r31 */
-
-	.cfi_offset	32, B_FR + 0			/* f0 */
-	.cfi_offset	33, B_FR + 1 * sizeof_freg	/* f1 */
-	.cfi_offset	34, B_FR + 2 * sizeof_freg
-	.cfi_offset	35, B_FR + 3 * sizeof_freg
-	.cfi_offset	36, B_FR + 4 * sizeof_freg
-	.cfi_offset	37, B_FR + 5 * sizeof_freg
-	.cfi_offset	38, B_FR + 6 * sizeof_freg
-	.cfi_offset	39, B_FR + 7 * sizeof_freg
-	.cfi_offset	40, B_FR + 8 * sizeof_freg
-	.cfi_offset	41, B_FR + 9 * sizeof_freg
-	.cfi_offset	42, B_FR + 10 * sizeof_freg
-	.cfi_offset	43, B_FR + 11 * sizeof_freg
-	.cfi_offset	44, B_FR + 12 * sizeof_freg
-	.cfi_offset	45, B_FR + 13 * sizeof_freg
-	.cfi_offset	46, B_FR + 14 * sizeof_freg
-	.cfi_offset	47, B_FR + 15 * sizeof_freg
-	.cfi_offset	48, B_FR + 16 * sizeof_freg
-	.cfi_offset	49, B_FR + 17 * sizeof_freg
-	.cfi_offset	50, B_FR + 18 * sizeof_freg
-	.cfi_offset	51, B_FR + 19 * sizeof_freg
-	.cfi_offset	52, B_FR + 20 * sizeof_freg
-	.cfi_offset	53, B_FR + 21 * sizeof_freg
-	.cfi_offset	54, B_FR + 22 * sizeof_freg
-	.cfi_offset	55, B_FR + 23 * sizeof_freg
-	.cfi_offset	56, B_FR + 24 * sizeof_freg
-	.cfi_offset	57, B_FR + 25 * sizeof_freg
-	.cfi_offset	58, B_FR + 26 * sizeof_freg
-	.cfi_offset	59, B_FR + 27 * sizeof_freg
-	.cfi_offset	60, B_FR + 28 * sizeof_freg
-	.cfi_offset	61, B_FR + 29 * sizeof_freg
-	.cfi_offset	62, B_FR + 30 * sizeof_freg
-	.cfi_offset	63, B_FR + 31 * sizeof_freg	/* f31 */
-
 	nop
 
 __vdso_rt_sigreturn:
-	raw_syscall __NR_rt_sigreturn
+	.cfi_startproc
+	.cfi_signal_frame
+       raw_syscall __NR_rt_sigreturn
+       .cfi_endproc
 endf __vdso_rt_sigreturn
 
-	.cfi_endproc
-- 
2.34.1


