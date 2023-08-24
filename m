Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C43786BD9
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:29:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6ee-00070I-KM; Thu, 24 Aug 2023 05:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eR-0006JC-BK
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:15 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eA-0004ym-K1
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:06 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c3df710bdso3639466f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869325; x=1693474125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UGCC5w0EUtVabhmBA26zktdGI7YbZzgKTjnOnP1lMsI=;
 b=AuKwooqUWZeXlvPuHzCyWTRLds7GokzH3yXdcn/3oWFsCviBHHAaJYm/GEf3Y5esvG
 vMJEUBcOaJG8BCUzx7gD5gW1ui+XHJI6VTTBAaC8eJ+XJdJ7Opqf+J2Eg9EiUGD+jbq5
 O7aPFPec+2SZLTK/9HCqVU/jqi06kNGjrfkamLLtzYIUdoqRnmVkFflfMPFpSwXKuBqu
 DlBhZaurIQXYaZeXuYbX9WHPhf74o0wC1ve4PpQ7YfKRhjOgZMY+kuPC/i9RH3ToXSoc
 GUlNi+EKZ6wlFFlzn6KfR5HPeJYA9SdRsbGPMsE9NIzwskxbhEeggC7mb7WLTES3sSwP
 Yj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869325; x=1693474125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UGCC5w0EUtVabhmBA26zktdGI7YbZzgKTjnOnP1lMsI=;
 b=Gy5exk4N2YhXs1PLFEgr6NiInRhd6XVuWbPhNh2OjJUn7TO7YMdf27MaL45gHuAsfB
 I1QbNcyBBZttLw06CvFsXFKe+TtNfHt2LReAA92RLp4vUme41SIEK9Lh8PBW98RT5nPz
 zUMvocpNbMK1wIkEDNCYKEvySM0owqW/Ad75AdpFNvZz116T4gKOcdV/11NbP4lQB/yV
 rV6so3KpB+2dXxIHylDKW+AktFWrCpXI96YjL4tx9BIUNpDzCrOp8q9kkQRjvHpf+S/i
 BY9CyH0xl26ejmfMOwM27yKdjW1l/JeBry/3kxjpkvab42RdyqxxYJ7o6auTSbe9h0qD
 d2EA==
X-Gm-Message-State: AOJu0Yy4T0IPLRzrPUmJjMW1Gf9tiW9U56qsnjJtVW7XU2dI2ZezZCIP
 qeA4o8qCs+up7QDZW68U70pOpsJDJ6TLI6Gv0FA=
X-Google-Smtp-Source: AGHT+IGg1VSY+55N+4aXzvNVxgx5zmlfjW1BQLzpO5yRjgId9rrdFyDKsuLOPQQQUCovwLDw6Q2tBg==
X-Received: by 2002:a05:6000:1146:b0:314:152d:f8db with SMTP id
 d6-20020a056000114600b00314152df8dbmr12690263wrx.58.1692869324992; 
 Thu, 24 Aug 2023 02:28:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/35] target/arm/ptw: Don't report GPC faults on stage 1 ptw
 as stage2 faults
Date: Thu, 24 Aug 2023 10:28:15 +0100
Message-Id: <20230824092836.2239644-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

In S1_ptw_translate() we set up the ARMMMUFaultInfo if the attempt to
translate the page descriptor address into a physical address fails.
This used to only be possible if we are doing a stage 2 ptw for that
descriptor address, and so the code always sets fi->stage2 and
fi->s1ptw to true.  However, with FEAT_RME it is also possible for
the lookup of the page descriptor address to fail because of a
Granule Protection Check fault.  These should not be reported as
stage 2, otherwise arm_deliver_fault() will incorrectly set
HPFAR_EL2.  Similarly the s1ptw bit should only be set for stage 2
faults on stage 1 translation table walks, i.e.  not for GPC faults.

Add a comment to the the other place where we might detect a
stage2-fault-on-stage-1-ptw, in arm_casq_ptw(), noting why we know in
that case that it must really be a stage 2 fault and not a GPC fault.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230807141514.19075-3-peter.maydell@linaro.org
---
 target/arm/ptw.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index bafeb876ad7..eb57ebd897b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -600,8 +600,8 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         fi->type = ARMFault_GPCFOnWalk;
     }
     fi->s2addr = addr;
-    fi->stage2 = true;
-    fi->s1ptw = true;
+    fi->stage2 = regime_is_stage2(s2_mmu_idx);
+    fi->s1ptw = fi->stage2;
     fi->s1ns = !is_secure;
     return false;
 }
@@ -719,6 +719,12 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
         env->tlb_fi = NULL;
 
         if (unlikely(flags & TLB_INVALID_MASK)) {
+            /*
+             * We know this must be a stage 2 fault because the granule
+             * protection table does not separately track read and write
+             * permission, so all GPC faults are caught in S1_ptw_translate():
+             * we only get here for "readable but not writeable".
+             */
             assert(fi->type != ARMFault_None);
             fi->s2addr = ptw->out_virt;
             fi->stage2 = true;
-- 
2.34.1


