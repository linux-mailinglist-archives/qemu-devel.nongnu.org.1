Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D77CF753F49
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:49:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKL0U-0007By-CO; Fri, 14 Jul 2023 11:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0S-0007Ad-Ch
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:46:56 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0P-000759-HF
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:46:56 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3159da54e95so2075032f8f.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689349612; x=1691941612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wjXax+BQ/9wUzLTNVvfXm39pxSfddxOCMcJwUt+OkWM=;
 b=CoNTr4QXfJDkliJsojuyX7mGwBLRb6m7rL9z9VdrE5+ETsWyvIKDPpkd6cChiGl/wq
 Fc9X2CjDE+XVmHkflLOtX99UvqYiVj0AquR/3kSLVsxtcgr7BxXODqLVGmBa/JYAXT3+
 I3a3wgY/5M+3v7ep33y88hfsRn+5LtUeUAB3mJtPLW0RVffAFb4UIimE8Mj3SZpFQsWd
 b+KS1ODviNZx+pvXb9eE4KdcWMReHTl5BLgRcq3J0vD8DBO4TqbdsRINdcv9iNQFVbjU
 8SYjGnc6bK0g/45nvThrINkQbloDiaxiUYG0WUBFvHrTee3JQLyBYOz6BU5qxtj5CTVu
 4emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689349612; x=1691941612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wjXax+BQ/9wUzLTNVvfXm39pxSfddxOCMcJwUt+OkWM=;
 b=iVUV7+6CgFn/S6NKdX8zTvppwrXSk49DZ0+ntGit8nHmkKHwHJ8rYRrx6+ZoRjuFHD
 Bqzmep+1Zk4HAObBndIF82agV4+NvtokyjaImozAD2V0KBuWcsAU6UOx8kAobN/e6dzL
 MduLpKQRN3helCWmWN/qhfYhjEfPiRpAu1b/bjVk0SekJsJim22c5ojOTVkj0Lv7woBu
 JSh0UIInGqmTUFBr0J8IszldZVrosrdP0nIWIuQ/XpFEuskQX6w5snR456bn3pydK5w2
 eImj8TOHnRLoUghTdHfsGJorop0Sq8SV2PUKGDsZkuK1/KzF4DdBA4mDWue8j2GN0Ugu
 +k7Q==
X-Gm-Message-State: ABy/qLaIKY2fIWCUdOQmPpMRPVPMi6xWn1WZrg/416xf8fuCUErUTGfA
 5GRtzeL7PuTQkG9ZVRuRtfN0+A==
X-Google-Smtp-Source: APBJJlGSZx1PeDrI0p0QBaB9KHMmBHHFQItSqmh2/V4T0XaUMimvgYmChrd9sH/m7UYRn12Huk05Nw==
X-Received: by 2002:a5d:4b44:0:b0:313:edaa:2505 with SMTP id
 w4-20020a5d4b44000000b00313edaa2505mr4842435wrs.20.1689349612285; 
 Fri, 14 Jul 2023 08:46:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d49d0000000b003143bb5ecd5sm11214025wrs.69.2023.07.14.08.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 08:46:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 03/14] target/arm/ptw: Set s1ns bit in fault info more
 consistently
Date: Fri, 14 Jul 2023 16:46:37 +0100
Message-Id: <20230714154648.327466-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714154648.327466-1-peter.maydell@linaro.org>
References: <20230714154648.327466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

The s1ns bit in ARMMMUFaultInfo is documented as "true if
we faulted on a non-secure IPA while in secure state". Both the
places which look at this bit only do so after having confirmed
that this is a stage 2 fault and we're dealing with Secure EL2,
which leaves the ptw.c code free to set the bit to any random
value in the other cases.

Instead of taking advantage of that freedom, consistently
make the bit be set to false for the "not a stage 2 fault
for Secure EL2" cases. This removes some cases where we
were using an 'is_secure' boolean and leaving the reader
guessing about whether that was the right thing for Realm
and Root cases.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index eb57ebd897b..67078ae3509 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -514,6 +514,17 @@ static ARMSecuritySpace S2_security_space(ARMSecuritySpace s1_space,
     }
 }
 
+static bool fault_s1ns(ARMSecuritySpace space, ARMMMUIdx s2_mmu_idx)
+{
+    /*
+     * For stage 2 faults in Secure EL22, S1NS indicates
+     * whether the faulting IPA is in the Secure or NonSecure
+     * IPA space. For all other kinds of fault, it is false.
+     */
+    return space == ARMSS_Secure && regime_is_stage2(s2_mmu_idx)
+        && s2_mmu_idx == ARMMMUIdx_Stage2_S;
+}
+
 /* Translate a S1 pagetable walk through S2 if needed.  */
 static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
                              hwaddr addr, ARMMMUFaultInfo *fi)
@@ -586,7 +597,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
             fi->s2addr = addr;
             fi->stage2 = true;
             fi->s1ptw = true;
-            fi->s1ns = !is_secure;
+            fi->s1ns = fault_s1ns(ptw->in_space, s2_mmu_idx);
             return false;
         }
     }
@@ -602,7 +613,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
     fi->s2addr = addr;
     fi->stage2 = regime_is_stage2(s2_mmu_idx);
     fi->s1ptw = fi->stage2;
-    fi->s1ns = !is_secure;
+    fi->s1ns = fault_s1ns(ptw->in_space, s2_mmu_idx);
     return false;
 }
 
@@ -729,7 +740,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
             fi->s2addr = ptw->out_virt;
             fi->stage2 = true;
             fi->s1ptw = true;
-            fi->s1ns = !ptw->in_secure;
+            fi->s1ns = fault_s1ns(ptw->in_space, ptw->in_ptw_idx);
             return 0;
         }
 
@@ -2030,7 +2041,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     fi->level = level;
     /* Tag the error as S2 for failed S1 PTW at S2 or ordinary S2.  */
     fi->stage2 = fi->s1ptw || regime_is_stage2(mmu_idx);
-    fi->s1ns = mmu_idx == ARMMMUIdx_Stage2;
+    fi->s1ns = fault_s1ns(ptw->in_space, mmu_idx);
     return true;
 }
 
-- 
2.34.1


