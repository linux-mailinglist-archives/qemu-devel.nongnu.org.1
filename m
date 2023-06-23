Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EED9673B7B9
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:42:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxK-0002Qo-0i; Fri, 23 Jun 2023 08:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx8-0001iX-7L
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx3-0000h3-RW
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:48 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f9b627c1b8so7512875e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523504; x=1690115504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZIYoookqR3xwp+NlCMe7R+2jFcv2sGpJ7Bx7Q6onvJ0=;
 b=HAmD6Yoc5bplcEiSHp7BY47COecGEVQMlQWvq9xQBG/Ia0iWMnTYtvbfRDVS5BEIYT
 LnO+uknFnbk0rZ2qPyRy9v0UO+Tq4UhBHU8MG/3IqJFy8UupcB4nhq2hoIlGaUKhvhIv
 7EiQ7uZ0z82KiQ9UDJR/kAtl/evSKaThqM2zEM7P4oOdSE6Kqkyom4/TSZc9mzDOyX6A
 yONMBgp7HpnCyvsLiKuCpIMuOFO8GbGtkX3y/DEruhtGGxIvlAUllv0V2+AERV3SqVrd
 AT0JImW/Q6duV+MuKw7Q0UG5AkIe6oH8qgo7mWIavZT9ZcgwR0YxrvKPu5LQGbcAq83m
 PcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523504; x=1690115504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZIYoookqR3xwp+NlCMe7R+2jFcv2sGpJ7Bx7Q6onvJ0=;
 b=QZdPHjVcpXdAyHSocfvMB7S7nsQuXhrU4E7sY2wGzOZgizdoKrir5e6oQk9TIcVvnc
 7b5Xcg9udzT816zWQaiwsGVewL9e+2cokGefVc4dt0wpOQnEkGlUsYFzspzOCgAdBQUT
 8619BDyQM6LDuVGOOXFB2X03sr/qCbQIAFDdrjl362YfCP2iuznlKrIA1/dbEoUSOm7E
 15Gt0LFdZyfxl5Cr/PJsqaYuLIFnE+zEtwPUZum1yj/7c2XGmxwq6p0PimBU7L9YjZ5P
 OszJQ9soP13N652c4a3H/1JFnBxANzzd0+YGBe7yv359US2oIJ6TmNeRtReHLQqzxAs6
 PQmw==
X-Gm-Message-State: AC+VfDwzha/pfppezUywdJ1EoPLbxvT2gINaCvI846GU6Ijt2N7E3hgv
 Hlawgc4KADFxXa3NcpU7D35Una15/PC6J4Sa3HA=
X-Google-Smtp-Source: ACHHUZ46PzW9KMp89N052wm1gwpuY72SufyNh6GFmAYzeHeOL+KP54Jfll47sf1e2XU5dZc0qXe6Vg==
X-Received: by 2002:a7b:cb99:0:b0:3f9:c9bc:401 with SMTP id
 m25-20020a7bcb99000000b003f9c9bc0401mr5493142wmi.33.1687523504004; 
 Fri, 23 Jun 2023 05:31:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/26] target/arm: Use get_phys_addr_with_struct in
 S1_ptw_translate
Date: Fri, 23 Jun 2023 13:31:23 +0100
Message-Id: <20230623123135.1788191-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Do not provide a fast-path for physical addresses,
as those will need to be validated for GPC.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 45271d666b3..6d5e4855a33 100644
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


