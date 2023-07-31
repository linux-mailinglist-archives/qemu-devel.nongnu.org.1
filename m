Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC8D76A25C
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:03:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQa2p-0002V5-Lx; Mon, 31 Jul 2023 17:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1qQa2n-0002HW-EA
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:03:09 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1qQa2l-0006bX-Kk
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:03:09 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so5174902f8f.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 14:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690837385; x=1691442185;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iKD6WWO6p/9oTv8bApcU7nPsFXgbOEwMT1T7aFVY2oY=;
 b=IQg7xvZ4H5QOwiXB0dNujySCOq3O7FsKOGFjUSbxbtD+pyBeXvqJu0qJsHRS2+ZbcR
 0r6yez6HzT7mlVGNn2L/c9Z767t18qXIpBzdzOO4fW04bCbWjTtydYAesGajtcOnGDo0
 xrM4cTjMk4u14WwBJyYAiZaF+S5Zs92T4BuCko1fjFGSeDITnbpZKIpiX/Wx+TS9aVUo
 +wkjAXM66ecGCow2jWQa6AEdDP6ol9+TCDVDWB+hHfhcGWNZK5OlV2STWMXV1S8A2rBT
 GbjLNjdB5wnvgmhAuI93/u84YomlUN9MA3Cmr+eIc/K9txz4FQqhUMnRnDjPH29lqmpn
 +BoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690837385; x=1691442185;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iKD6WWO6p/9oTv8bApcU7nPsFXgbOEwMT1T7aFVY2oY=;
 b=aHaW/K3cyt9s5u/IiLoqEVcUFPcmOxdCr9RXG3odSUvvThx94bPxeJFmGFj87nlDL4
 seB1afIxmkl/+p0G7DEe+9ZpeZtgbxJS8dalSaV5QfS5SeJKRpiu/60Dag4tkrmkz9Cj
 DZVZnEs8G33FYAynp7i8TFVTxGZzzZMP5a/S13SG2yPkxZr8R7lFMxB5AkXkIQ0mZMAC
 M9RfLZaAmUk089cnFxZHnFO3uASIUo2MNizCaUoDFQ1e8CN2TKKreg+QKcQlQUxjsdhE
 eZxhxYu6ccOLra7EdcbAF+MkUSMkghopEwVaTcMDYNKhU9WMV3QrE4/k7kNNs3wg9KMa
 476Q==
X-Gm-Message-State: ABy/qLZ0T1B4hskZshTmqzp6djjiIhzT5yuLSsizeldEi+S4nxAo+hKZ
 tMTzcyhc9PpBYX4WcZDe/peehVYRz2c8+A==
X-Google-Smtp-Source: APBJJlG8Hg7YjTAx+naZoCSXgAYMa905YuW/i1AbKFMeCH1s8byTtoihf56pki3FxK0s9kWHlihX5w==
X-Received: by 2002:adf:fd8b:0:b0:314:3ca0:c8c2 with SMTP id
 d11-20020adffd8b000000b003143ca0c8c2mr735391wrr.11.1690837385268; 
 Mon, 31 Jul 2023 14:03:05 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 b10-20020a5d4b8a000000b003175f00e555sm13965510wrt.97.2023.07.31.14.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 14:03:04 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Stafford Horne <shorne@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2] target/openrisc: Set EPCR to next PC on FPE exceptions
Date: Mon, 31 Jul 2023 22:03:01 +0100
Message-Id: <20230731210301.3360723-1-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The architecture specification calls for the EPCR to be set to "Address
of next not executed instruction" when there is a floating point
exception (FPE).  This was not being done, so fix it by using the same
pattern as syscall.  Also, we move this logic down to be done for
instructions not in the delay slot as called for by the architecture
manual.

Without this patch FPU exceptions will loop, as the exception handling
will always return back to the failed floating point instruction.

This was not noticed in earlier testing because:

 1. The compiler usually generates code which clobbers the input operand
    such as:

      lf.div.s r19,r17,r19

 2. The target will store the operation output before to the register
    before handling the exception.  So an operation such as:

      float a = 100.0f;
      float b = 0.0f;
      float c = a / b;    /* lf.div.s r19,r17,r19 */

    Will first execute:

      100 / 0    -> Store inf to c (r19)
                 -> triggering divide by zero exception
                 -> handle and return

    Then it will execute:

      100 / inf  -> Store 0 to c  (no exception)

To confirm the looping behavior and the fix I used the following:

    float fpu_div(float a, float b) {
	float c;
	asm volatile("lf.div.s %0, %1, %2"
		      : "+r" (c)
		      : "r" (a), "r" (b));
	return c;
    }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/interrupt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 3887812810..d4fdb8ce8e 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -34,9 +34,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     int exception = cs->exception_index;
 
     env->epcr = env->pc;
-    if (exception == EXCP_SYSCALL) {
-        env->epcr += 4;
-    }
+
     /* When we have an illegal instruction the error effective address
        shall be set to the illegal instruction address.  */
     if (exception == EXCP_ILLEGAL) {
@@ -63,6 +61,9 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
         env->epcr -= 4;
     } else {
         env->sr &= ~SR_DSX;
+        if (exception == EXCP_SYSCALL || exception == EXCP_FPE) {
+            env->epcr += 4;
+        }
     }
 
     if (exception > 0 && exception < EXCP_NR) {
-- 
2.39.1


