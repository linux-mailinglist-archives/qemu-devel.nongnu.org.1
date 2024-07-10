Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F392CEBF
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jul 2024 12:01:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRU85-0003og-Dn; Wed, 10 Jul 2024 06:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sRU7u-0003hN-C6
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:00:43 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sRU7r-0007PP-Hv
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:00:41 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 46AA0D6U022441
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Wed, 10 Jul 2024 18:00:13 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from atctrx.andestech.com (10.0.15.190) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 18:00:13 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, Alvin Chang <alvinga@andestech.com>
Subject: [PATCH v2 1/2] target/riscv: Preliminary textra trigger CSR writting
 support
Date: Wed, 10 Jul 2024 18:00:09 +0800
Message-ID: <20240710100010.814934-2-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710100010.814934-1-alvinga@andestech.com>
References: <20240710100010.814934-1-alvinga@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.190]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 46AA0D6U022441
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Alvin Chang <alvinga@andestech.com>
From:  Alvin Chang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This commit allows program to write textra trigger CSR for type 2, 3, 6
triggers. In this preliminary patch, the textra.MHVALUE and the
textra.MHSELECT fields are allowed to be configured. Other fields, such
as textra.SBYTEMASK, textra.SVALUE, and textra.SSELECT, are hardwired to
zero for now.

For textra.MHSELECT field, the only legal values are 0 (ignore) and 4
(mcontext). Writing 1~3 into textra.MHSELECT will be changed to 0, and
writing 5~7 into textra.MHSELECT will be changed to 4. This behavior is
aligned to RISC-V SPIKE simulator.

Signed-off-by: Alvin Chang <alvinga@andestech.com>
---
 target/riscv/cpu_bits.h | 10 ++++++
 target/riscv/debug.c    | 75 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index c257c5ed7d..0530b4f9f4 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -906,6 +906,16 @@ typedef enum RISCVException {
 #define JVT_BASE                           (~0x3F)
 
 /* Debug Sdtrig CSR masks */
+#define TEXTRA32_MHVALUE                   0xFC000000
+#define TEXTRA32_MHSELECT                  0x03800000
+#define TEXTRA32_SBYTEMASK                 0x000C0000
+#define TEXTRA32_SVALUE                    0x0003FFFC
+#define TEXTRA32_SSELECT                   0x00000003
+#define TEXTRA64_MHVALUE                   0xFFF8000000000000ULL
+#define TEXTRA64_MHSELECT                  0x0007000000000000ULL
+#define TEXTRA64_SBYTEMASK                 0x000000F000000000ULL
+#define TEXTRA64_SVALUE                    0x00000003FFFFFFFCULL
+#define TEXTRA64_SSELECT                   0x0000000000000003ULL
 #define MCONTEXT32                         0x0000003F
 #define MCONTEXT64                         0x0000000000001FFFULL
 #define MCONTEXT32_HCONTEXT                0x0000007F
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 0b5099ff9a..139b722a7e 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -217,6 +217,72 @@ static inline void warn_always_zero_bit(target_ulong val, target_ulong mask,
     }
 }
 
+static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
+{
+    target_ulong mhvalue, mhselect;
+    target_ulong mhselect_new;
+    target_ulong textra;
+    const uint32_t mhselect_no_rvh[8] = { 0, 0, 0, 0, 4, 4, 4, 4 };
+
+    switch (riscv_cpu_mxl(env)) {
+    case MXL_RV32:
+        mhvalue  = get_field(tdata3, TEXTRA32_MHVALUE);
+        mhselect = get_field(tdata3, TEXTRA32_MHSELECT);
+        /* Validate unimplemented (always zero) bits */
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SBYTEMASK,
+                             "sbytemask");
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SVALUE,
+                             "svalue");
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA32_SSELECT,
+                             "sselect");
+        break;
+    case MXL_RV64:
+    case MXL_RV128:
+        mhvalue  = get_field(tdata3, TEXTRA64_MHVALUE);
+        mhselect = get_field(tdata3, TEXTRA64_MHSELECT);
+        /* Validate unimplemented (always zero) bits */
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SBYTEMASK,
+                             "sbytemask");
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SVALUE,
+                             "svalue");
+        warn_always_zero_bit(tdata3, (target_ulong)TEXTRA64_SSELECT,
+                             "sselect");
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* Validate mhselect. */
+    mhselect_new = mhselect_no_rvh[mhselect];
+    if (mhselect != mhselect_new) {
+        qemu_log_mask(LOG_UNIMP, "mhselect only supports 0 or 4 for now\n");
+    }
+
+    /* Write legal values into textra */
+    textra = 0;
+    switch (riscv_cpu_mxl(env)) {
+    case MXL_RV32:
+        textra = set_field(textra, TEXTRA32_MHVALUE,  mhvalue);
+        textra = set_field(textra, TEXTRA32_MHSELECT, mhselect_new);
+        break;
+    case MXL_RV64:
+    case MXL_RV128:
+        textra = set_field(textra, TEXTRA64_MHVALUE,  mhvalue);
+        textra = set_field(textra, TEXTRA64_MHSELECT, mhselect_new);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (textra != tdata3) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "different value 0x" TARGET_FMT_lx " write to tdata3\n",
+                      textra);
+    }
+
+    return textra;
+}
+
 static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
 {
     trigger_action_t action = get_trigger_action(env, trigger_index);
@@ -441,8 +507,7 @@ static void type2_reg_write(CPURISCVState *env, target_ulong index,
         }
         break;
     case TDATA3:
-        qemu_log_mask(LOG_UNIMP,
-                      "tdata3 is not supported for type 2 trigger\n");
+        env->tdata3[index] = textra_validate(env, val);
         break;
     default:
         g_assert_not_reached();
@@ -558,8 +623,7 @@ static void type6_reg_write(CPURISCVState *env, target_ulong index,
         }
         break;
     case TDATA3:
-        qemu_log_mask(LOG_UNIMP,
-                      "tdata3 is not supported for type 6 trigger\n");
+        env->tdata3[index] = textra_validate(env, val);
         break;
     default:
         g_assert_not_reached();
@@ -741,8 +805,7 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
                       "tdata2 is not supported for icount trigger\n");
         break;
     case TDATA3:
-        qemu_log_mask(LOG_UNIMP,
-                      "tdata3 is not supported for icount trigger\n");
+        env->tdata3[index] = textra_validate(env, val);
         break;
     default:
         g_assert_not_reached();
-- 
2.34.1


