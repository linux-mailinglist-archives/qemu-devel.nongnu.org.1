Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0343775F5B
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 14:39:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTiRI-0002Zr-7v; Wed, 09 Aug 2023 08:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qTiRF-0002Xp-Cq
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:37:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qTiRC-0002nu-Aa
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:37:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe1fc8768aso65039055e9.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691584635; x=1692189435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuvReQXvG/EOd6YQVXedXfCkpVkxyqWb9vu/7k0okhs=;
 b=nSZX/z/kVJyX8+oBBQKdrz3jsv1UBNGGj5ghtIFyueJdQmnZ9Vr5wgDPJrgkAVzHmY
 xMJ9/wx5lIrRN5buX1KDo2OzFt9mJf9iBvzkxvnjXTPtNRdb1mtQu+VZ5xGoXELgqBki
 O6wjQ6E6kylCI4id/hMPEYYMLLXAnBoChhymi/iUq7sYekbHTYf7Sbo6gf+LbW0DM1Ju
 6PBdOj5a9gcwlBfdS3AQpcDJd+tDbvCqpxVU1l0JmUKYVEiJKINCHCGAAell4NlgdzFb
 by0UR204ZPb8VE/XNXGwh1tCpBcIf0ljbIc7HDgiat/fiPwlSAgbFBdmHcFOLWUO/P8F
 tpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691584635; x=1692189435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CuvReQXvG/EOd6YQVXedXfCkpVkxyqWb9vu/7k0okhs=;
 b=Zf+tkwKVqYzhADFUDPGYmZ30Me9Z6luxIqBIH96Z3y2mkk97Y27BSxm/qjUJ2FKPes
 pBC4wiQLYfmBMfcW7KfvLToVkVa0dGm9LCgkUTkwEOM3he696DuFrXCoGVM8iR9LUw5K
 2d7sbCmRNSCGxqzjzG/d/Vn/L63nyIM2dqwtWhUS1hqnAUmZCGaNB7xxgCEoGJbFBF1X
 KjH6O0J2IwMRcBXnM234Un0ARGQZPAYMCf/wuozM5hM05rGajq4vu+jln3uPJkISccCe
 BhPpqg7S7Yy13KwPzOi2lHnfZylPJqKQ/4lFuCW/RrFxk6n8cBFD936P2jTeRDzBvvgZ
 e8bg==
X-Gm-Message-State: AOJu0YzkVLYXbfAOV57BzPl/SRHai9D77lnit3Le6FvLA6fj/4k0ZT7Z
 3Ga0AIvCm6PeMZj29U9yy4szAw==
X-Google-Smtp-Source: AGHT+IGuo5ndPmzKMFYUzsJxc5qSg8g1CkUpJ5mlTIAVOHh2muUS978QVM5xKcgCBecY8bq95vr+3A==
X-Received: by 2002:a5d:46ca:0:b0:317:5686:e4b9 with SMTP id
 g10-20020a5d46ca000000b003175686e4b9mr1655249wrs.56.1691584635353; 
 Wed, 09 Aug 2023 05:37:15 -0700 (PDT)
Received: from localhost.localdomain ([2.219.138.198])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a5d5246000000b00317f70240afsm5617888wrc.27.2023.08.09.05.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 05:37:15 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 1/6] target/arm/ptw: Load stage-2 tables from realm
 physical space
Date: Wed,  9 Aug 2023 13:37:01 +0100
Message-ID: <20230809123706.1842548-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809123706.1842548-1-jean-philippe@linaro.org>
References: <20230809123706.1842548-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x332.google.com
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

In realm state, stage-2 translation tables are fetched from the realm
physical address space (R_PGRQD).

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index d1de934702..063adbd84a 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -157,22 +157,32 @@ static ARMMMUIdx ptw_idx_for_stage_2(CPUARMState *env, ARMMMUIdx stage2idx)
 
     /*
      * We're OK to check the current state of the CPU here because
-     * (1) we always invalidate all TLBs when the SCR_EL3.NS bit changes
+     * (1) we always invalidate all TLBs when the SCR_EL3.NS or SCR_EL3.NSE bit
+     * changes.
      * (2) there's no way to do a lookup that cares about Stage 2 for a
      * different security state to the current one for AArch64, and AArch32
      * never has a secure EL2. (AArch32 ATS12NSO[UP][RW] allow EL3 to do
      * an NS stage 1+2 lookup while the NS bit is 0.)
      */
-    if (!arm_is_secure_below_el3(env) || !arm_el_is_aa64(env, 3)) {
+    if (!arm_el_is_aa64(env, 3)) {
         return ARMMMUIdx_Phys_NS;
     }
-    if (stage2idx == ARMMMUIdx_Stage2_S) {
-        s2walk_secure = !(env->cp15.vstcr_el2 & VSTCR_SW);
-    } else {
-        s2walk_secure = !(env->cp15.vtcr_el2 & VTCR_NSW);
-    }
-    return s2walk_secure ? ARMMMUIdx_Phys_S : ARMMMUIdx_Phys_NS;
 
+    switch (arm_security_space_below_el3(env)) {
+    case ARMSS_NonSecure:
+        return ARMMMUIdx_Phys_NS;
+    case ARMSS_Realm:
+        return ARMMMUIdx_Phys_Realm;
+    case ARMSS_Secure:
+        if (stage2idx == ARMMMUIdx_Stage2_S) {
+            s2walk_secure = !(env->cp15.vstcr_el2 & VSTCR_SW);
+        } else {
+            s2walk_secure = !(env->cp15.vtcr_el2 & VTCR_NSW);
+        }
+        return s2walk_secure ? ARMMMUIdx_Phys_S : ARMMMUIdx_Phys_NS;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static bool regime_translation_big_endian(CPUARMState *env, ARMMMUIdx mmu_idx)
-- 
2.41.0


