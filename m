Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A269937DF5
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jul 2024 01:16:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUwpo-0005Rx-3j; Fri, 19 Jul 2024 19:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sUwpl-0005J8-PD; Fri, 19 Jul 2024 19:16:18 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sUwph-0006Cm-Ry; Fri, 19 Jul 2024 19:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1721430967; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=+dEWqINsH2q0Is5htmo/kl79xBJRl23UUhw4dg0B5iA=;
 b=Nph0dQqsHplYZbPNAl7YYiopArOUh7ksXhm4Pd8BQggSMtH08NAr5bpXUWvNgLGAcUj+7avnoylX9vorp9jhHFl6KZuzmdBkRAgNsRASR5B1M4t527rRYy6c7fY+RRGB4jl7sZ6d4AcS45MYU7s7G6CvE8QodYVN6ja4q0N/w/M=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067113;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0WAspyYj_1721430965; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WAspyYj_1721430965) by smtp.aliyun-inc.com;
 Sat, 20 Jul 2024 07:16:06 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, philmd@linaro.org, alex.bennee@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v6 3/8] target/riscv: Correct SXL return value for RV32 in
 RV64 QEMU
Date: Sat, 20 Jul 2024 07:11:44 +0800
Message-Id: <20240719231149.1364-4-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240719231149.1364-1-zhiwei_liu@linux.alibaba.com>
References: <20240719231149.1364-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Ensure that riscv_cpu_sxl returns MXL_RV32 when runningRV32 in an
RV64 QEMU.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Fixes: 05e6ca5e156 ("target/riscv: Ignore reserved bits in PTE for RV64")
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 87742047ce..49de81be7e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -693,8 +693,11 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
 #ifdef CONFIG_USER_ONLY
     return env->misa_mxl;
 #else
-    return get_field(env->mstatus, MSTATUS64_SXL);
+    if (env->misa_mxl != MXL_RV32) {
+        return get_field(env->mstatus, MSTATUS64_SXL);
+    }
 #endif
+    return MXL_RV32;
 }
 #endif
 
-- 
2.25.1


