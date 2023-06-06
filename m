Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2FE723E5E
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:52:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TJ0-0007ro-TI; Tue, 06 Jun 2023 05:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIt-0007n3-BC
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIp-0004jh-VD
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:39 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-30af159b433so5873062f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044915; x=1688636915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=veMFa2sz3JxyfIJgkdTIpGyiMWGxHlB0Jzb6VvKqky4=;
 b=VvtTjJ2GGoyRLwIJs/4xMq23A+QLX+gd7xUu9dGPgL6CznEjhzV50VEE4TECl3PTgp
 LvLykmWo6Xcx8p2FRqarQLFwrA+bXjiLaqnh1AO/zPjeYExFgrDCGD7S+Ae+ssmfDiKS
 ZXf77Qt0/squoDcY9NASoHwL7sxem2REQgC51C5FsNL9zqEDl6/nFB7Rqz476OvzWCS0
 VsVZTjL9dhrVDyPyWIlSjLk2GWP5Bdb58S5LS6aH2uuyiwj53TBYrOiWk3TB7yH3lGhc
 XQEs6J8WumSU7IFBa45Kl8vPEPnFPoa/87+awD/XMXobw8cmi66R6jtJ504uZVOBMfkE
 Cb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044915; x=1688636915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=veMFa2sz3JxyfIJgkdTIpGyiMWGxHlB0Jzb6VvKqky4=;
 b=IRnZtn5bIJR9yhEDwLJ2CDhNMbpxlSlJSdYrlUFei+AGCW8s85cm+GVkT2Socq9Ha1
 8bl8ti6Wes4W83lXtR/ujax0H3FX+9AsKoFdBzQY5UBRtgWZyLsSrmVd+4ADai8DkuHL
 Mgd+lPtBRUaIBxqDF2jyc7aJOFtOjZIvaEh4sWlLeUum+/EYYV/Yv/CTOTAbB0Wiz5t8
 FL/X2jT3C/vvUyzB/Oxiry7XhEiSViee29D3hv0rnafWvBwZD4d7uf7YPSeefkJgvFQV
 J0dltqVfQCH4Vp7KETiHtfWt6R3Eu4sqGJ10z/4DGiLdX/tfMx7L/kLxe0RQiZ4n8rDG
 rxWw==
X-Gm-Message-State: AC+VfDzixUNOgEfEXxTm01+dRlZpw568G2XIo0e/pB9ZVvPB91YHLB6v
 WhdhobkLw2FUljbswfU77UnFo283tYV8GoWUnLo=
X-Google-Smtp-Source: ACHHUZ6MEb6OhbaBTaH3NsTV70FVhig7ULK9vZe67chZOwinyqmCAPtHo2kFUfHeefjoRpBUu4RVAA==
X-Received: by 2002:a5d:40d2:0:b0:306:3f97:4847 with SMTP id
 b18-20020a5d40d2000000b003063f974847mr1600681wrq.65.1686044915176; 
 Tue, 06 Jun 2023 02:48:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/42] target/arm: allow DC CVA[D]P in user mode emulation
Date: Tue,  6 Jun 2023 10:48:12 +0100
Message-Id: <20230606094814.3581397-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Zhuojia Shen <chaosdefinition@hotmail.com>

DC CVAP and DC CVADP instructions can be executed in EL0 on Linux,
either directly when SCTLR_EL1.UCI == 1 or emulated by the kernel (see
user_cache_maint_handler() in arch/arm64/kernel/traps.c).

This patch enables execution of the two instructions in user mode
emulation.

Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0b7fd2e7e6c..d4bee43bd01 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7405,7 +7405,6 @@ static const ARMCPRegInfo rndr_reginfo[] = {
       .access = PL0_R, .readfn = rndr_readfn },
 };
 
-#ifndef CONFIG_USER_ONLY
 static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
                           uint64_t value)
 {
@@ -7420,6 +7419,7 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
     /* This won't be crossing page boundaries */
     haddr = probe_read(env, vaddr, dline_size, mem_idx, GETPC());
     if (haddr) {
+#ifndef CONFIG_USER_ONLY
 
         ram_addr_t offset;
         MemoryRegion *mr;
@@ -7430,6 +7430,7 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
         if (mr) {
             memory_region_writeback(mr, offset, dline_size);
         }
+#endif /*CONFIG_USER_ONLY*/
     }
 }
 
@@ -7448,7 +7449,6 @@ static const ARMCPRegInfo dcpodp_reg[] = {
       .fgt = FGT_DCCVADP,
       .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
 };
-#endif /*CONFIG_USER_ONLY*/
 
 static CPAccessResult access_aa64_tid5(CPUARMState *env, const ARMCPRegInfo *ri,
                                        bool isread)
@@ -9092,7 +9092,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_tlbios, cpu)) {
         define_arm_cp_regs(cpu, tlbios_reginfo);
     }
-#ifndef CONFIG_USER_ONLY
     /* Data Cache clean instructions up to PoP */
     if (cpu_isar_feature(aa64_dcpop, cpu)) {
         define_one_arm_cp_reg(cpu, dcpop_reg);
@@ -9101,7 +9100,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             define_one_arm_cp_reg(cpu, dcpodp_reg);
         }
     }
-#endif /*CONFIG_USER_ONLY*/
 
     /*
      * If full MTE is enabled, add all of the system registers.
-- 
2.34.1


