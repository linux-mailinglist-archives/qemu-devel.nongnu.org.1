Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58066814B90
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 16:18:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE9vy-0000v6-Lp; Fri, 15 Dec 2023 10:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rE9vq-0000iD-9B
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 10:16:56 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rE9vo-0005wU-Jw
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 10:16:53 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c25973988so8267665e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 07:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702653410; x=1703258210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FD5lcscTgLjr7YreIMa4Mn7D9UemU5jzp3PkrPYtuEY=;
 b=h4jtDbjAvllWqGta7svmrLsBF/ex3u43Rqk5VkZfgBq0xJV7mNDC/6tHUgC+TZKfaa
 1MED4Wz+2xN5hQPd2RYr7AIRjZXj0FkoXH7+xEyb8vpa9uIv9AKi+Yed35iXbdObqt87
 HpRk2+Zx+KLz6thaA5jlCLHYxdtsxqSb82Iwvm8ZiXFQMneS0fQ3gzIK1i19gITWynUI
 Agnm8PDMoBNnmKkHvvV4lGtwjTQ7JJLSyONENjOnuRjFc6Ogc7raANeDmjvn8NQwF2TJ
 vzjBu/WRVetaku725Jq/yMAiYwoWK6aL+v6F6IsiVriC9v+aYm4eo38VXlzy0rAWwSXq
 /bKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702653410; x=1703258210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FD5lcscTgLjr7YreIMa4Mn7D9UemU5jzp3PkrPYtuEY=;
 b=b1SaKenwjfkiAa4LzEtjoKfskOPLKFaKksSZb7Yl39/Bzia2uy4v6Hi0/rwfn2/bPI
 3NDrmGtObVKTa4gdNs8i6qtn+D3poG0dVa977/tNZZYFlZo7XCB3iMqo6AAh+cmwvZaC
 Z+x3faQqed9QdkqheDhIMfVbcNtzCGy/Zttjp1HkChlTebADDJGKAkevh9UJs+obNtA7
 AjdUwYtfF72QQHplo5IE+42lquIW6Q/rlrNtg0bAo/INRxLtHJCcjXYEJt8L0RZPpHdy
 xeVcueljmQbtWuqYzrqy71GiAA2l0oNiA1TI0UEbWbAK9fCMwVhVIPuYdM+Bm4+mLK/c
 mrxQ==
X-Gm-Message-State: AOJu0YzeCoSPk3Z3RynOCKXX3HQUqw+G0ThhTjU4MUKQhlZ4xIKFQ4oy
 5TgOzUvutQ/dLOhNwJnYjyvKQQ==
X-Google-Smtp-Source: AGHT+IF6B/NQHfSx3vv5vis44rxfzvlf6LPWa2iY5/6n+3xFoDcLlghYgurflBbu27cJe6I9sZcpfA==
X-Received: by 2002:a05:600c:1c1a:b0:40b:5e1c:af27 with SMTP id
 j26-20020a05600c1c1a00b0040b5e1caf27mr6205148wms.45.1702653410401; 
 Fri, 15 Dec 2023 07:16:50 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 i1-20020a05600c354100b0040c411da99csm23981111wmq.48.2023.12.15.07.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 07:16:50 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] target/arm/helper: Propagate MDCR_EL2.HPMN into PMCR_EL0.N
Date: Fri, 15 Dec 2023 14:46:53 +0000
Message-ID: <20231215144652.4193815-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32c.google.com
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

MDCR_EL2.HPMN allows an hypervisor to limit the number of PMU counters
available to EL1 and EL0 (to keep the others to itself). QEMU already
implements this split correctly, except for PMCR_EL0.N reads: the number
of counters read by EL1 or EL0 should be the one configured in
MDCR_EL2.HPMN.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 target/arm/helper.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ff1970981e..bec293bc93 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1475,6 +1475,22 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     pmu_op_finish(env);
 }
 
+static uint64_t pmcr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    uint64_t pmcr = env->cp15.c9_pmcr;
+
+    /*
+     * If EL2 is implemented and enabled for the current security state, reads
+     * of PMCR.N from EL1 or EL0 return the value of MDCR_EL2.HPMN or HDCR.HPMN.
+     */
+    if (arm_current_el(env) <= 1 && arm_is_el2_enabled(env)) {
+        pmcr &= ~PMCRN_MASK;
+        pmcr |= (env->cp15.mdcr_el2 & MDCR_HPMN) << PMCRN_SHIFT;
+    }
+
+    return pmcr;
+}
+
 static void pmswinc_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           uint64_t value)
 {
@@ -7137,8 +7153,9 @@ static void define_pmu_regs(ARMCPU *cpu)
         .fgt = FGT_PMCR_EL0,
         .type = ARM_CP_IO | ARM_CP_ALIAS,
         .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmcr),
-        .accessfn = pmreg_access, .writefn = pmcr_write,
-        .raw_writefn = raw_write,
+        .accessfn = pmreg_access,
+        .readfn = pmcr_read, .raw_readfn = raw_read,
+        .writefn = pmcr_write, .raw_writefn = raw_write,
     };
     ARMCPRegInfo pmcr64 = {
         .name = "PMCR_EL0", .state = ARM_CP_STATE_AA64,
@@ -7148,6 +7165,7 @@ static void define_pmu_regs(ARMCPU *cpu)
         .type = ARM_CP_IO,
         .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),
         .resetvalue = cpu->isar.reset_pmcr_el0,
+        .readfn = pmcr_read, .raw_readfn = raw_read,
         .writefn = pmcr_write, .raw_writefn = raw_write,
     };
 
-- 
2.43.0


