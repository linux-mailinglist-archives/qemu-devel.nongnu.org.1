Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6A2736C45
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaiu-0001cA-Rp; Tue, 20 Jun 2023 08:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBair-0001ZL-Lv
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:37 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaip-00022d-OV
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:37 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51a426e4f4bso5548130a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687265074; x=1689857074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2sdgIiqPnMV4fPsIp02tsJUyVwHllql7Gpq+1+0e7tM=;
 b=ZzcbZpiXKFGkP9X2om/Wznaqohq9BBDio79t4d3/chm+C6LZe8uZdIz/cUHOyOPlaw
 8hJ7E9tyihp5hIGWltmhIfKz25wWMs6058md9V1/I1/nMqyV+YckzbmQlJ1VlC7dY+ND
 PLp6+aiQIYyMOcGbKqPpIXPPSctcHWEwbZwdf8QhLbb2T1tjqFjEcqbGPMPwuRsmjJp1
 4xAq9NJHWH/YYPgdiAuFmVuSzt3WHUZ6mMQgI9BVN2yInH2XSAtLzTrQn1YIL5v8rr5X
 BTmfxzFEEt96wzXWwvVqLbM3ene0EmqtTM4X8hdFMKv566qi8pTzbSlRVGIGg0X4zlB1
 WgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687265074; x=1689857074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2sdgIiqPnMV4fPsIp02tsJUyVwHllql7Gpq+1+0e7tM=;
 b=Alwf9RP6Y1c22W8NWqImgdPWnAtS9GnXLPH5DLQj5LrXOswlOVa8BhmfpbIzsr/ed3
 /u/97o/wgtVevEde3rDUb+Xgt3DrPMm+zSB3h69da1XTdX9KD5CRMbzBZC73N8scKr50
 jhMQABU4Y30pyOVj8ayXHeQABZi/X0hNArwCJ1ItnagXarqVvTp1aWFh0Kz7CYwNCOno
 qA5a+vDxiyX4ienI/xsyooID7QehJMGbXC8OfL0EPmV+XOX6oke94l9zN6X4BSvMQnOo
 tv4wUgi6le/vfeVZFwURK79MAkuUjGJsHwBdJKFn/kogXd1knKsR48vE2i3bft4bXj4j
 m91w==
X-Gm-Message-State: AC+VfDyjaC9XA//GkJDyFaYhEhA69rl90rOic9m6f7XJ11gJZ/AymbzL
 V8igbZyvYEetnhsKD4CEQZ+bTGBfXVOEVe6aeuieaGIt
X-Google-Smtp-Source: ACHHUZ617TIH6j0Ir1IHhBZ6/sIvZtB5spfRCsGQE2jfasUON8ATACCx2OkUUkZxe4WDeIjug2JjMg==
X-Received: by 2002:aa7:d88f:0:b0:51a:4039:2d75 with SMTP id
 u15-20020aa7d88f000000b0051a40392d75mr8680669edq.34.1687265074416; 
 Tue, 20 Jun 2023 05:44:34 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 w9-20020aa7dcc9000000b0051a313a66e8sm1142541edu.45.2023.06.20.05.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:44:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 14/20] target/arm: Use get_phys_addr_with_struct in
 S1_ptw_translate
Date: Tue, 20 Jun 2023 14:44:12 +0200
Message-Id: <20230620124418.805717-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620124418.805717-1-richard.henderson@linaro.org>
References: <20230620124418.805717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52f.google.com
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

Do not provide a fast-path for physical addresses,
as those will need to be validated for GPC.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 45271d666b..6d5e4855a3 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -264,37 +264,27 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
          * From gdbstub, do not use softmmu so that we don't modify the
          * state of the cpu at all, including softmmu tlb contents.
          */
-        if (regime_is_stage2(s2_mmu_idx)) {
-            S1Translate s2ptw = {
-                .in_mmu_idx = s2_mmu_idx,
-                .in_ptw_idx = ptw_idx_for_stage_2(env, s2_mmu_idx),
-                .in_secure = s2_mmu_idx == ARMMMUIdx_Stage2_S,
-                .in_space = (s2_mmu_idx == ARMMMUIdx_Stage2_S ? ARMSS_Secure
-                             : space == ARMSS_Realm ? ARMSS_Realm
-                             : ARMSS_NonSecure),
-                .in_debug = true,
-            };
-            GetPhysAddrResult s2 = { };
+        S1Translate s2ptw = {
+            .in_mmu_idx = s2_mmu_idx,
+            .in_ptw_idx = ptw_idx_for_stage_2(env, s2_mmu_idx),
+            .in_secure = s2_mmu_idx == ARMMMUIdx_Stage2_S,
+            .in_space = (s2_mmu_idx == ARMMMUIdx_Stage2_S ? ARMSS_Secure
+                         : space == ARMSS_Realm ? ARMSS_Realm
+                         : ARMSS_NonSecure),
+            .in_debug = true,
+        };
+        GetPhysAddrResult s2 = { };
 
-            if (get_phys_addr_lpae(env, &s2ptw, addr, MMU_DATA_LOAD,
-                                   false, &s2, fi)) {
-                goto fail;
-            }
-            ptw->out_phys = s2.f.phys_addr;
-            pte_attrs = s2.cacheattrs.attrs;
-            ptw->out_secure = s2.f.attrs.secure;
-            ptw->out_space = s2.f.attrs.space;
-        } else {
-            /* Regime is physical. */
-            ptw->out_phys = addr;
-            pte_attrs = 0;
-            ptw->out_secure = s2_mmu_idx == ARMMMUIdx_Phys_S;
-            ptw->out_space = (s2_mmu_idx == ARMMMUIdx_Phys_S ? ARMSS_Secure
-                              : space == ARMSS_Realm ? ARMSS_Realm
-                              : ARMSS_NonSecure);
+        if (get_phys_addr_with_struct(env, &s2ptw, addr,
+                                      MMU_DATA_LOAD, &s2, fi)) {
+            goto fail;
         }
+        ptw->out_phys = s2.f.phys_addr;
+        pte_attrs = s2.cacheattrs.attrs;
         ptw->out_host = NULL;
         ptw->out_rw = false;
+        ptw->out_secure = s2.f.attrs.secure;
+        ptw->out_space = s2.f.attrs.space;
     } else {
 #ifdef CONFIG_TCG
         CPUTLBEntryFull *full;
-- 
2.34.1


