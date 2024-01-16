Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC33782EF5E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 14:04:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPj5l-0007K4-Vc; Tue, 16 Jan 2024 08:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5f-0007IV-Q1
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:54 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5d-0006ge-9Y
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:51 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e76109cdeso22366325e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 05:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1705410167; x=1706014967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKW/EH5R/IdiWfxo4lBBEsNkOoH1NjRDpWTKl/kBcoc=;
 b=k6xNufv7zNaDQNQos7UvbPT8/7OjxzUfdIPlC2Qocnqsn1+PjmqDLMltSZTc/5fatu
 BNXA4y5ryxqRYCXTpWSW///ZeuQrC1a1HChoqIu6xdpzipCzRYdWC5zYYSUQOMNTVF5T
 M2PaUYgBYdhkkELwBoDd39n0mGRhzIodti7q3jFXY1O0m8AxowDihYR2kF0OTXC4lJMx
 GRQR+h8gmXtB6qek2cZAHHBg/rF25xeYniThD3wf3+ZQ5RCSjJNxImzDL4+BPuxhCVAA
 KwsWAUhEGavjB7G6Ox2ke6yGyNcRYq8D1AqCfOsSQCxjitKkghr0uc14gfXux2BpWirP
 FPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705410167; x=1706014967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKW/EH5R/IdiWfxo4lBBEsNkOoH1NjRDpWTKl/kBcoc=;
 b=dRZFJc0+oBnrYU5NfVxqc52dLP6qD96E7F+ReLYCIlvGTrta9WwYEE/qpfkMSBGO0T
 yy/+Bo7hc5IhDPKsOxQwiJ6scy0oaJ5uTJ/cCaAHF+8O8E3EVg/5aVFWTTYODcTmmP/p
 mo8rhr8gacuEqPAr1AKvz0xGRXHGrBvFXIrKPiliFtv5ujGYJ2Vw2Kd4P2eVZSM05HXV
 GU8ALYbo8rMafOuB4tk8xqa53ydJT/FmD30NKIuhpSCVR02ljbfnebpWiAyp5C1Nc3jB
 EwB+bvR9qfCAIXJD8MflNSGcRpxzzgUWJquOroIRHXrkog7Anj4F7wW5a1ntSIYovJM0
 l8vA==
X-Gm-Message-State: AOJu0YzAYlicFXk3kr0Xi/V71hgBkzRt4AwxZMj7Z5x0wk9laBGlfVKP
 LGMIRipcq6uqg/flzg1gBm+bCeswYZNNoGH97ICk3puueg==
X-Google-Smtp-Source: AGHT+IF52UqJcA7ULV1Nz0yPkmqu33iUQ/KzXIYB2DIhFHvgb8xIXbTptA4ppz4vwRBoVoyLRlkWNA==
X-Received: by 2002:a05:600c:280b:b0:40e:44c2:92be with SMTP id
 m11-20020a05600c280b00b0040e44c292bemr4065008wmb.143.1705410167579; 
 Tue, 16 Jan 2024 05:02:47 -0800 (PST)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a05600c34d000b0040e83867d62sm2495316wmq.34.2024.01.16.05.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 05:02:46 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: [PATCH v2 7/8] leon3: check cpu_id in the tiny bootloader
Date: Tue, 16 Jan 2024 14:02:12 +0100
Message-Id: <20240116130213.172358-8-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116130213.172358-1-chigot@adacore.com>
References: <20240116130213.172358-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now that SMP is possible, the asr17 must be checked in the little boot code
or the secondary CPU will reinitialize the Timer and the Uart.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/sparc/leon3.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index eacd85ee4f..87a8044a3e 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -100,13 +100,27 @@ static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
 
 /*
  * When loading a kernel in RAM the machine is expected to be in a different
- * state (eg: initialized by the bootloader). This little code reproduces
- * this behavior.
+ * state (eg: initialized by the bootloader).  This little code reproduces
+ * this behavior.  Also this code can be executed by the secondary cpus as
+ * well since it looks at the %asr17 register before doing any
+ * initialization, it allows to use the same reset address for all the
+ * cpus.
  */
 static void write_bootloader(CPUSPARCState *env, uint8_t *base,
                              hwaddr kernel_addr)
 {
     uint32_t *p = (uint32_t *) base;
+    uint32_t *sec_cpu_branch_p = NULL;
+
+    /* If we are running on a secondary CPU, jump directly to the kernel.  */
+
+    stl_p(p++, 0x85444000); /* rd %asr17, %g2      */
+    stl_p(p++, 0x8530a01c); /* srl  %g2, 0x1c, %g2 */
+    stl_p(p++, 0x80908000); /* tst  %g2            */
+    /* Fill that later.  */
+    sec_cpu_branch_p = p;
+    stl_p(p++, 0x0BADC0DE); /* bne xxx             */
+    stl_p(p++, 0x01000000); /* nop */
 
     /* Initialize the UARTs                                        */
     /* *UART_CONTROL = UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
@@ -120,6 +134,10 @@ static void write_bootloader(CPUSPARCState *env, uint8_t *base,
     /* *GPTIMER0_CONFIG = GPTIMER_ENABLE | GPTIMER_RESTART;        */
     p = gen_store_u32(p, 0x80000318, 3);
 
+    /* Now, the relative branch above can be computed.  */
+    stl_p(sec_cpu_branch_p, 0x12800000
+          + (p - sec_cpu_branch_p));
+
     /* JUMP to the entry point                                     */
     stl_p(p++, 0x82100000); /* mov %g0, %g1 */
     stl_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
-- 
2.25.1


