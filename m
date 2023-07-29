Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50403768210
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 23:58:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPrBb-0000We-7P; Sat, 29 Jul 2023 17:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1qPrBZ-0000WV-QI
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 17:09:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1qPrBY-0008Vu-9y
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 17:09:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso32574055e9.2
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 14:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690664950; x=1691269750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8vqUV0jLDURPCeUa2/WSzC33t4u1BZ3jNStq61EGNh8=;
 b=rZpQriHW1cJj7TE0UV0kq/PnPHVcFKlAjzN1lodDDGEHnGKMADCmUmYFQzdL/DaIAm
 bq0Nna7tUtzGUjzpxRdHCJ8+XdiQ4dUHFtEmZvSu4QFg57ijz0C9fGx2aJy9GJ+DqBGv
 YF5CAqoTX35FkcJZ/wu80M1jD9zpvIxZ5pkFPAcgoIFhW44FnDc4j2QpQCTO27pE4sFP
 XlxwkkohsGKxfYhGIAquzc72xstTrK1l7JEtZG5IOb7Sa81YVXFeW0KIbNnJVVu5F1Po
 ez8OOzMm9JPzQvcs0PpbLdGAD12fIWiS/AddS6C3eV+8jgbtfUdlVzJkzvLApWbdEo7T
 Ho0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690664950; x=1691269750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8vqUV0jLDURPCeUa2/WSzC33t4u1BZ3jNStq61EGNh8=;
 b=fo69qEdJdoUWQZ8POtYwa0oKY/eeV3MwzJi86v9jqafoKMTLpG9gMKWegBmvmIxKco
 /uZuHGkPCB4D2J2OZkVFx+wGPz18vSWtFXu+JTkQBJWK468yd/ERHmC4LqYi8SZqWiLu
 93R0nGWQm4VWMocK4FkZmoWUpWkCo6vTYkP/mziEGhCJjhTJX5LjtftPxfZZfgQe3tqU
 8TM6y6y4nh6m5bxk9lm0dPo/ApmbWA4zCoKjTbXAlqMAxBTey/T4HyWSXq+RSmDqXiE2
 3Fzap2kQOPBhEmBQITONzhz78eqEN0MpTImZ30YVqgHcZJbSNhe+waqWCNTppd5aUis1
 IWRg==
X-Gm-Message-State: ABy/qLZo5M16u+9mipHbFJYgyb2+8C8LHoG+2dWXymg6zBfICkvrbMn5
 Zs/B6vvSgQXdYWrH/PWMVkKpdWE4/m3nvw==
X-Google-Smtp-Source: APBJJlGKLfOoRqamGsw/OhdaKl/OvrzwPwsoyKbXU8cAWK5TsDUCOvLKMBP3EVZ8E53nPB1CsP/HZQ==
X-Received: by 2002:a1c:4c11:0:b0:3fe:19cf:93c9 with SMTP id
 z17-20020a1c4c11000000b003fe19cf93c9mr1420245wmf.1.1690664949686; 
 Sat, 29 Jul 2023 14:09:09 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 n14-20020a05600c4f8e00b003fd2e898aa3sm12701310wmq.0.2023.07.29.14.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 14:09:09 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Stafford Horne <shorne@gmail.com>
Subject: [PATCH] target/openrisc: Set EPCR to next PC on FPE exceptions
Date: Sat, 29 Jul 2023 22:08:51 +0100
Message-Id: <20230729210851.3097340-1-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x32b.google.com
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
method as syscall.  Note, this may need a lot more work if we start
seeing floating point operations in delay slots which exceptions
enabled.

Without this patch FPU exceptions will loop, as the exception hanlding
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

    Then it will exectute:

      100 / inf  -> Store 0 to c  (no exception)

To confirm the looping behavoid and the fix I used the following:

    float fpu_div(float a, float b) {
	float c;
	asm volatile("lf.div.s %0, %1, %2"
		      : "+r" (c)
		      : "r" (a), "r" (b));
	return c;
    }

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 3887812810..9b14b8a2c6 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -34,7 +34,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     int exception = cs->exception_index;
 
     env->epcr = env->pc;
-    if (exception == EXCP_SYSCALL) {
+    if (exception == EXCP_SYSCALL || exception == EXCP_FPE) {
         env->epcr += 4;
     }
     /* When we have an illegal instruction the error effective address
-- 
2.39.1


