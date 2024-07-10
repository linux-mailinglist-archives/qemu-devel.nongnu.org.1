Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F41A92CEC0
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jul 2024 12:01:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRU86-00042P-QK; Wed, 10 Jul 2024 06:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sRU7u-0003iq-IU
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:00:43 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sRU7q-0007PN-Ax
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:00:42 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 46AA0EFK022596
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Wed, 10 Jul 2024 18:00:14 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from atctrx.andestech.com (10.0.15.190) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 18:00:14 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, Alvin Chang <alvinga@andestech.com>
Subject: [PATCH v2 2/2] target/riscv: Add textra matching condition for the
 triggers
Date: Wed, 10 Jul 2024 18:00:10 +0800
Message-ID: <20240710100010.814934-3-alvinga@andestech.com>
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
X-MAIL: Atcsqr.andestech.com 46AA0EFK022596
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

According to RISC-V Debug specification, the optional textra32 and
textra64 trigger CSRs can be used to configure additional matching
conditions for the triggers. For example, if the textra.MHSELECT field
is set to 4 (mcontext), this trigger will only match or fire if the low
bits of mcontext/hcontext equal textra.MHVALUE field.

This commit adds the aforementioned matching condition as common trigger
matching conditions. Currently, the only legal values of textra.MHSELECT
are 0 (ignore) and 4 (mcontext). When textra.MHSELECT is 0, we pass the
checking. When textra.MHSELECT is 4, we compare textra.MHVALUE with
mcontext CSR. The remaining fields, such as textra.SBYTEMASK,
textra.SVALUE, and textra.SSELECT, are hardwired to zero for now. Thus,
we skip checking them here.

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/debug.c | 63 +++++++++++++++++++++++++++++++++++++++++++-
 target/riscv/debug.h |  3 +++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 139b722a7e..7e64216ffe 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -370,11 +370,72 @@ static bool trigger_priv_match(CPURISCVState *env, trigger_type_t type,
     return false;
 }
 
+static bool trigger_textra_match(CPURISCVState *env, trigger_type_t type,
+                                 int trigger_index)
+{
+    target_ulong textra = env->tdata3[trigger_index];
+    target_ulong mhvalue, mhselect;
+
+    if (type < TRIGGER_TYPE_AD_MATCH || type > TRIGGER_TYPE_AD_MATCH6) {
+        /* textra checking is only applicable when type is 2, 3, 4, 5, or 6 */
+        return true;
+    }
+
+    switch (riscv_cpu_mxl(env)) {
+    case MXL_RV32:
+        mhvalue  = get_field(textra, TEXTRA32_MHVALUE);
+        mhselect = get_field(textra, TEXTRA32_MHSELECT);
+        break;
+    case MXL_RV64:
+    case MXL_RV128:
+        mhvalue  = get_field(textra, TEXTRA64_MHVALUE);
+        mhselect = get_field(textra, TEXTRA64_MHSELECT);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* Check mhvalue and mhselect. */
+    switch (mhselect) {
+    case MHSELECT_IGNORE:
+        break;
+    case MHSELECT_MCONTEXT:
+        /* Match or fire if the low bits of mcontext/hcontext equal mhvalue. */
+        if (riscv_has_ext(env, RVH)) {
+            if (mhvalue != env->mcontext) {
+                return false;
+            }
+        } else {
+            switch (riscv_cpu_mxl(env)) {
+            case MXL_RV32:
+                if (mhvalue != (env->mcontext & MCONTEXT32)) {
+                    return false;
+                }
+                break;
+            case MXL_RV64:
+            case MXL_RV128:
+                if (mhvalue != (env->mcontext & MCONTEXT64)) {
+                    return false;
+                }
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        }
+        break;
+    default:
+        break;
+    }
+
+    return true;
+}
+
 /* Common matching conditions for all types of the triggers. */
 static bool trigger_common_match(CPURISCVState *env, trigger_type_t type,
                                  int trigger_index)
 {
-    return trigger_priv_match(env, type, trigger_index);
+    return trigger_priv_match(env, type, trigger_index) &&
+           trigger_textra_match(env, type, trigger_index);
 }
 
 /* type 2 trigger */
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index c347863578..f76b8f944a 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -131,6 +131,9 @@ enum {
 #define ITRIGGER_VU           BIT(25)
 #define ITRIGGER_VS           BIT(26)
 
+#define MHSELECT_IGNORE       0
+#define MHSELECT_MCONTEXT     4
+
 bool tdata_available(CPURISCVState *env, int tdata_index);
 
 target_ulong tselect_csr_read(CPURISCVState *env);
-- 
2.34.1


