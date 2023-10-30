Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2559A7DBF36
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 18:40:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxWFL-0000X3-Sq; Mon, 30 Oct 2023 13:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxWFG-0000Vv-Qp
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:40:10 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxWFC-0000Hk-HZ
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:40:10 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32dd70c5401so3044553f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 10:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698687605; x=1699292405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WqVvp3csTiPZFAuQuKekKYsYC9+/xgQvvKPTLe74R7I=;
 b=XlKyM7t6WfRjbYuviamnM9u/Yydkdmc+jIB+bJeW4pVxWQK99TdQeEcLMjKLADSJq6
 bK4ojJPxnzIi1oSi+LTGAtm47ukDOiNXzSCYJ/znulSAqYJn+MDKBshA7NhkRzd2kQKs
 fXPruDPBQLkQaLjnMR8yBaShavWTAZFhpCkhKWDh7JkH6TxjDAserIBLNm2a56eF5ax6
 U+BOvkrV4xwTtID03mk2DE2zcIskW9RBtLgtpgnVgVcQw+OkxeuuOHGprjeJnFn27TQ2
 Kq+/6WCSjc47siaZUdfhslFbIDHQkVAq6srxg40ZArLsna+uIs3XQ4MhqcPw8D7Zfs+q
 ol9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698687605; x=1699292405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqVvp3csTiPZFAuQuKekKYsYC9+/xgQvvKPTLe74R7I=;
 b=j/1wsWzYALNMOWKbJwjSbmLCYMoArpeHXK+u+vwkWiMHWu0nLamYkUYDbREeL5vbqi
 oMTjFbOOThFSc/anSyKH9dbCpq46AxgIjndBoQ2yXHzbIJD3siEIVi9lpj9hQSCHQ1A3
 ytc+JTVLt1nt3VWiQKN+kUyLMOMG4cMzT6nX3qWM5sjH3ksMXVcIEqoe6x8Ude7OQ/F0
 08K2gxDXVCAgDuqOScoRBEwysJixriQL7P8cWfu5lT5CnuQTQS88kN/tIC9mc4b5vmLK
 bBtLpIIDXkUvS4qU/dZggi6DEJn7jCAENDEl3r0/YxH3C3KEzU5g29/jYbnO2vv+jWpt
 s0RQ==
X-Gm-Message-State: AOJu0YxCuTdltcwSMvjTAk2K2NQwq6fjNOv9nnM210dVOVY16OFCOnpL
 q+QchZiezhkCG1mhNcFZKUdYrA==
X-Google-Smtp-Source: AGHT+IHjSGG/lSAnmnoWVDhjWma3hJol5/4oEm/8AYXLMi+dxBXvkyMYWwcEc/eLuZXsBZ4OYnTztQ==
X-Received: by 2002:a05:6000:1447:b0:32f:7f6c:72a6 with SMTP id
 v7-20020a056000144700b0032f7f6c72a6mr4689766wrx.16.1698687605019; 
 Mon, 30 Oct 2023 10:40:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a5d5950000000b0032f7d1e2c7csm5912914wri.95.2023.10.30.10.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 10:40:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/arm: Make FEAT_MOPS SET* insns handle Xs == XZR
 correctly
Date: Mon, 30 Oct 2023 17:40:00 +0000
Message-Id: <20231030174000.3792225-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030174000.3792225-1-peter.maydell@linaro.org>
References: <20231030174000.3792225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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


