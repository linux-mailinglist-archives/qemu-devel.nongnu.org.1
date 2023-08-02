Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8F776D4A2
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 19:03:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRFEi-0000Po-Ry; Wed, 02 Aug 2023 13:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qRFEg-0000NR-2q
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 13:02:10 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qRFEd-0003Tz-J6
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 13:02:09 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbc1218262so761725e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690995725; x=1691600525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCTx3e049Pk+oNC5PLbeMgmbnCi39mZL9Wa/yLsQHW8=;
 b=WoykvEdwJkkaEbmRs8lP161neexyMuDQhPMgL/jFgM/+2tB4anrXeBOjO7ZiMod1aJ
 6T5RpszWvkzQWOISyT4npZribk69Frsw0uouxMGfNBFLz38P9/6TiqzKxcDTKSwxs9k3
 4vPgQXyCp+fdKPnivSA1v7ehPfRHQi8PUOQPDoxP0YYc1WctFpj2MWENW9YCAMVPzsBg
 glhbSJV1Gim44WiTpuUVkysRjQTAFE5fjULCtOuix30nJJH2YNRufrwseTP1JDOZ5Oje
 34R42BJXVHF3fMUzTALFXR9xprIxSpooTAfnhUGGLp6zOHzQjycnYU5FuX35Ocu2Rvf4
 qDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690995725; x=1691600525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bCTx3e049Pk+oNC5PLbeMgmbnCi39mZL9Wa/yLsQHW8=;
 b=EVckkMeVjs53+fwkoU7CKGgMSSw1iJzu3CpPg3HWgURLBOWB6DY9xTQ47VwhxSYB+5
 uArsc5Yfg8rIY6lYJ2un5KSsR7ytKj4Io1cSKgXQh5PBGLPrhHTz7Vfv3TS08JM5n3xc
 vG5ome43OTFD9reKqFPlHTvYEBcHgjCFbEHS4KJKIgBdrCFY1gCkyk8h0lDXyPS5In4m
 L7VCWmDGenpw6oCUMPph68iXxVAtChAmgwN24DH7i4dx05kuSOTnMV7L/+e0TcjHXJ2H
 7G4BEZgAY39ZXDPR0xnPlj5CP+RkRuXpIVviaSdMhxc61KPg9IGSiEbJeaLmD2sosM1/
 x+IA==
X-Gm-Message-State: ABy/qLbC2g0yLPxxhRwbw2fja/BrWp1HeWbH2wZufW3qsCKMzgAd/xTj
 U8j3guUtzOpMZGF0fvQ79bilpw==
X-Google-Smtp-Source: APBJJlGYk1yl3OeaVT5mJL1WN+QxJ2bJT/C/S/1uErxScnHg2dY+qqZKKUKviTjnv301EnFYcYkcTw==
X-Received: by 2002:a1c:4b0b:0:b0:3f8:c70e:7ed1 with SMTP id
 y11-20020a1c4b0b000000b003f8c70e7ed1mr5670748wma.20.1690995724755; 
 Wed, 02 Aug 2023 10:02:04 -0700 (PDT)
Received: from localhost.localdomain ([2.219.138.198])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a1cf307000000b003fa98908014sm2149081wmq.8.2023.08.02.10.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 10:02:04 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 1/6] target/arm/ptw: Load stage-2 tables from realm
 physical space
Date: Wed,  2 Aug 2023 18:01:52 +0100
Message-ID: <20230802170157.401491-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802170157.401491-1-jean-philippe@linaro.org>
References: <20230802170157.401491-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32d.google.com
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

In realm state, stage-2 translation tables are fetched from the realm
physical address space (R_PGRQD).

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
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


