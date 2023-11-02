Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8C67DF90C
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:44:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybg5-0004QL-JN; Thu, 02 Nov 2023 13:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybej-0003HN-Da
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:39:00 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybef-0002rx-B3
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:56 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32d895584f1so662242f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946730; x=1699551530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KWyGEYTzfH2Abe6/qvv9Qz9Xy/UG4t+1CI7YQLR7W1Q=;
 b=jKRjq5+Xj+GZWXmghtiQDmDvxnYChqujeyC3rZHRI3p9JZ4SqAVP/VyKorWTogl6/U
 EXh0ffpRTWGtkuTpGoUoYfGHt6ibunT3YDTc2VhDHmqjm/S07tBPHJFLJz07QPBNxYNh
 XQaB42lFEX86Ct6qfqTC4o3yA+7HM4wui5Q/lNL9PCCkLwLcOBaGF+AAdTAZ8ZOf5ljO
 l97HJ/ADjXEld59v5pl7aURcBnwEKnft25UqO5s1/eVNDEVRU4exbJ0oUFDjpsSzB21B
 gcP9qZk9OjCq1jaJgPS862yY3TQ7+2kCCUoBL466wgSUuxhvc3mzrKF6c+ZN4llDLq54
 A4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946730; x=1699551530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWyGEYTzfH2Abe6/qvv9Qz9Xy/UG4t+1CI7YQLR7W1Q=;
 b=HJWOwDAOX7VungykAilj1KPDqnB39HVTS0u5gFqHci49Hewd2L+Jnp59bL5KAsfdTE
 kasKfnsbtgQyZOQtg8ps2IhsGZnLXTroUeySSc249H5ds/2BprqsmP568CpEiKEEAlsY
 5L5cojL8XRgoX/1/mV+lmr7vnNTFb7xgsQqoQfayqsHZ4ZJHZzRP87Y1+afpgCxZcwLo
 9NSwZ8fSVGbeaZQquKJqw34hJOz4J3gNzzlXARZpc7EDreDxgLhj4BIM9nHLrDWUPCVL
 vcNJb7NYq40dWnYqaBPP7JWphdp1iqLS3pDGt7O/JxyLG9fT6dd/ZpHipigECUeO00qi
 5LGA==
X-Gm-Message-State: AOJu0YyLuhwkdyqtpvFuwzmJ2yBIgqjq2asy4umPDkYCsOetxEu9NN7R
 R4SMrxyws4Gg4Zvz1vr2/bfHD95KKQdFUZLRcpo=
X-Google-Smtp-Source: AGHT+IHDZsSXPr5WaFs/6lMO69pWvGLjPyPvJ1Y2tFI+NrinacZnPVdK0CAB7H+V889SucZZhuDKUg==
X-Received: by 2002:a5d:5987:0:b0:32f:8181:7d2b with SMTP id
 n7-20020a5d5987000000b0032f81817d2bmr12347763wri.32.1698946730472; 
 Thu, 02 Nov 2023 10:38:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/33] target/arm: Make FEAT_MOPS SET* insns handle Xs == XZR
 correctly
Date: Thu,  2 Nov 2023 17:38:27 +0000
Message-Id: <20231102173835.609985-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Most of the registers used by the FEAT_MOPS instructions cannot use
31 as a register field value; this is CONSTRAINED UNPREDICTABLE to
NOP or UNDEF (we UNDEF).  However, it is permitted for the "source
value" register for the memset insns SET* to be 31, which (as usual
for most data-processing insns) means it should be the zero register
XZR. We forgot to handle this case, with the effect that trying to
set memory to zero with a "SET* Xd, Xn, XZR" sets the memory to
the value that happens to be in the low byte of SP.

Handle XZR when getting the SET* data value from the register file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231030174000.3792225-4-peter.maydell@linaro.org
---
 target/arm/tcg/helper-a64.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 84f54750fc2..ce4800b8d13 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1206,6 +1206,15 @@ static void check_setg_alignment(CPUARMState *env, uint64_t ptr, uint64_t size,
     }
 }
 
+static uint64_t arm_reg_or_xzr(CPUARMState *env, int reg)
+{
+    /*
+     * Runtime equivalent of cpu_reg() -- return the CPU register value,
+     * for contexts when index 31 means XZR (not SP).
+     */
+    return reg == 31 ? 0 : env->xregs[reg];
+}
+
 /*
  * For the Memory Set operation, our implementation chooses
  * always to use "option A", where we update Xd to the final
@@ -1226,7 +1235,7 @@ static void do_setp(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc,
     int rd = mops_destreg(syndrome);
     int rs = mops_srcreg(syndrome);
     int rn = mops_sizereg(syndrome);
-    uint8_t data = env->xregs[rs];
+    uint8_t data = arm_reg_or_xzr(env, rs);
     uint32_t memidx = FIELD_EX32(mtedesc, MTEDESC, MIDX);
     uint64_t toaddr = env->xregs[rd];
     uint64_t setsize = env->xregs[rn];
@@ -1286,7 +1295,7 @@ static void do_setm(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc,
     int rd = mops_destreg(syndrome);
     int rs = mops_srcreg(syndrome);
     int rn = mops_sizereg(syndrome);
-    uint8_t data = env->xregs[rs];
+    uint8_t data = arm_reg_or_xzr(env, rs);
     uint64_t toaddr = env->xregs[rd] + env->xregs[rn];
     uint64_t setsize = -env->xregs[rn];
     uint32_t memidx = FIELD_EX32(mtedesc, MTEDESC, MIDX);
@@ -1349,7 +1358,7 @@ static void do_sete(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc,
     int rd = mops_destreg(syndrome);
     int rs = mops_srcreg(syndrome);
     int rn = mops_sizereg(syndrome);
-    uint8_t data = env->xregs[rs];
+    uint8_t data = arm_reg_or_xzr(env, rs);
     uint64_t toaddr = env->xregs[rd] + env->xregs[rn];
     uint64_t setsize = -env->xregs[rn];
     uint32_t memidx = FIELD_EX32(mtedesc, MTEDESC, MIDX);
-- 
2.34.1


