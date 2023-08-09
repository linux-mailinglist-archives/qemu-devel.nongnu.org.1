Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9E2776A1B
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 22:36:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTptK-0004MC-4H; Wed, 09 Aug 2023 16:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1qTptI-0004Li-D8
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 16:34:48 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1qTptG-00014i-SC
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 16:34:48 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so251626f8f.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 13:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691613284; x=1692218084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKD6WWO6p/9oTv8bApcU7nPsFXgbOEwMT1T7aFVY2oY=;
 b=ljh2YCtNLiPkoOjD+4mJE5fIIrccPG/dTdI0LKrexgqPE2gJTuDelEqfnpe6rj1s0u
 1bQH2tUNya6Sn5kbKPJnQcvaGtJxi5f4MRwfnT3WBW0JZ78qhwPEjq38xgvfor8/sMsm
 ByDvzHi5f8jMHYgCDwri8hH8TB73ufHqi8Rne14k9P8RrAVCO2KeRR0I7kXnYl0FUa9F
 TyNugEdFRZt9Jr/Prwp9Eeb9iUZM/IeaGJ4n4nH/CwZsBeNWjMYRyMdamyFM1KjpCUIS
 xv+SmCt3VYnZ9OPlIHSE1yLj2hngs2wBVcVzaH+j2q3AivUzCuU2uV2GvXVVG6OKQqcv
 Rj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691613284; x=1692218084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iKD6WWO6p/9oTv8bApcU7nPsFXgbOEwMT1T7aFVY2oY=;
 b=Dn1QmtU8GAEjYHJlkO4hrfoEo85xHEYa/MuR0G/n33zKIUAlVJ4nIe47YTlQUlNbb7
 5DkoggOb8Ad4g1DXmQjO7ddeN8MBfEXKRGBL0ntapfho30kW+yM+/N1e44XBGBoCIsyO
 AoWwmYDeTRB22TdUW1coipGUbGbt+mWUlm1RKA3xvwUpvbLafOd1SONVZjEZV9LHn7OR
 ho/99E0IpBO1nW5Lo08m8j4h5sMQnAcYt4HT/379Q4A+np+6NnTMqDx3WDe3zFazMQXZ
 xYNn2y4mWml5ze6I4Pqe5XrnD9LbE8okbKKQ4WZ55jd2999FtcVrI4MqJkbfAwvaEiQg
 fOsw==
X-Gm-Message-State: AOJu0YwIpOa2lFkySGUtuP56tmm+5LCM3mH8Q70E97lb/1hsNaV0mnf/
 lPUW1m1N/ona7wdc8AeFvsHsPSWX3fpuCA==
X-Google-Smtp-Source: AGHT+IG+aMy05E1HnhDg6BBo+7IqXqeOf+9j9zEZ/6nB9tHewDzJe0HkXzJWGRjhf7YOvZPdOOLZ0Q==
X-Received: by 2002:a5d:4105:0:b0:317:df3e:134 with SMTP id
 l5-20020a5d4105000000b00317df3e0134mr342393wrp.65.1691613284219; 
 Wed, 09 Aug 2023 13:34:44 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 m9-20020adfe0c9000000b003145559a691sm18161399wri.41.2023.08.09.13.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 13:34:43 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Stafford Horne <shorne@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/1] target/openrisc: Set EPCR to next PC on FPE exceptions
Date: Wed,  9 Aug 2023 21:34:32 +0100
Message-Id: <20230809203432.424071-2-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230809203432.424071-1-shorne@gmail.com>
References: <20230809203432.424071-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


