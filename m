Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9A0786BDD
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:30:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eR-0005kB-BO; Thu, 24 Aug 2023 05:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e9-00047c-Vz
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e4-0004ys-Q1
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c63cd4ec2so2162027f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869325; x=1693474125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cKwApaEBM2Ue+okvX0YIaC5zH+tiObfh8zC3y9f1bVw=;
 b=ZXeOvBzj5o9rxAUIHWTfu6L9RYHLeUmmSLPXlYlFZcoLQpc0u4GrZqc1hrF8T/lkem
 n+G/N6XnijZRnlSnXkPHy2vny1gAYCwCzGSwNJVd7mr6lDfnevTwwawfNCF22cPRBCJ1
 B/rzQ+ZrITTV9aWmoJgRBKqdrjTJqdrwJZQgxuzWLNSQV5esFb2H2AKsCf4a4h1UIGma
 5/wxocMxd4zzRP4oYYOBwOshDs04RAU5IVkm52ww7V3W1EdMe50SA+se4JEvPXZng3I9
 BMTjur0K+9f5A3vRDHX9ebyBGPH3tq3dGS72VoofVpNhvKNAXUhUWC1YyclW9TkY9/cs
 TMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869325; x=1693474125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cKwApaEBM2Ue+okvX0YIaC5zH+tiObfh8zC3y9f1bVw=;
 b=KKbz1GNVfnSwV4IVDLGj+3ynQ2pVJ0Q7d+wzkYbwrYNMBzKsoaUd7TUNu5zyUUYFiu
 YmmA3Xtbh5vorQrrowoUowrSMXG4sXa2tjE+mw1rgoAbVJwUO8hMSKVlaai6j5071+PN
 MiDVD+xpcG6uWH+PyKcqIrErLyAoBu5nLtSoDMsvSII1oovAnAH8zulabV7ZfknG7nmT
 XnFYxME5r0bo8PRLwZmiMntRFJ6WzwJ4yPGwcVgUlDZdqptaGEg3W+Fv1WJR8DKYKhEC
 VeJKSmwGMcyS9DAGrAM12mRbW0AM2msmhg2HED5cEC9c+djhes2cZEAlM5eqd1snCQ0+
 oXsg==
X-Gm-Message-State: AOJu0YytWwkGoRijFfj8pqUD+0xQI68q/n9Wzu+hcDEUgzwJGQre3xzS
 h8k4VbF8pG+RMJIWUlKIQD7DZYRTVhihJetQs5c=
X-Google-Smtp-Source: AGHT+IF9J+qWgaWlOk5Di50WwPNlxu8OFVlSU5LJpFeiCgwmeNBPw0FKlV9ExUO3bquiHZ4RYa8uJg==
X-Received: by 2002:a05:6000:401f:b0:319:7c14:b06b with SMTP id
 cp31-20020a056000401f00b003197c14b06bmr15732597wrb.47.1692869325416; 
 Thu, 24 Aug 2023 02:28:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/35] target/arm/ptw: Set s1ns bit in fault info more
 consistently
Date: Thu, 24 Aug 2023 10:28:16 +0100
Message-Id: <20230824092836.2239644-16-peter.maydell@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230807141514.19075-4-peter.maydell@linaro.org
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


