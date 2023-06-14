Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 615C772F1FA
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:33:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FDA-0006b9-S4; Tue, 13 Jun 2023 21:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FD7-0006DH-Os
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:09 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FD6-0004iT-08
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:09 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-652699e72f7so4752207b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705726; x=1689297726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KM81BhAJ9G+QJiochVo+Cdqgb52HinUz5Kywn4RfqFk=;
 b=C7NwM8bMf2KlsFTwtD3wVLU+LLsbx5K4bAf6UpxRj08gCf2Bct92s/K0XTQTpcMGn7
 Dc0bAQWDTRXic3mVrCJ+qBW0TTL4krBEfEqE3Q/nUOn/LVrtoo8E4kM8QSUAywI4/Ihb
 czC6vgocRDqtHPvuOtb8IICVyjHZhfxfDZadVsEitK/cObgfB6a32xsJNq9zxD8XQqMd
 N9PrCuoNAvuf8csA7haLu5OwFZRaXld6HnlMconCmYLi4gQLchEK/wLLj38QgcbnkXSj
 vj5cVF9p8JRzKvTe2HbYHbuUwJu8EsLzFJjiXqHqLyry+YBPqUgg7pp+DOXdIWWGwYd7
 bF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705726; x=1689297726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KM81BhAJ9G+QJiochVo+Cdqgb52HinUz5Kywn4RfqFk=;
 b=U0J+z+tUsn13y2FXVWqstcqaywUuHnl/xFTD+rx341Ibd591dan3UyVH6RhJZyAcuj
 +ASvGOTVGEOQJ8N9yV1FTSHsdf3paQTCxb1K5pyUx8/fruSpLATWs8LTUULfNNUXbQVE
 SHshCb8a5GTPqdHgcPPCL/DFr48RdcIEgabACwQ/fh1ac+88+VCXu9y4zicluMQ3NQOE
 aIMlC1qgaLU0npUfkkbBU732uaMJew1hF9aCeyIw0B2Ivre2HVfbl1Lbg+9+9W91sKIv
 bTEqE26n6FqioyqgHRvG7nxkoYeYTRv3eu7bDXdzfRLgoAdGAcLtPb7l+CtKg4Vj02zZ
 N50A==
X-Gm-Message-State: AC+VfDwSQfvtrvfmYB+6My2fVdTn0XkgERmy/yr0XeK+8gnBIuRRlW/s
 y8s4JmaNR/kBNqKoU62bSmGFwrgISzddUw==
X-Google-Smtp-Source: ACHHUZ5MVrJsH+9KqVHsltkLZSxsafKqwXP4p6+d/BqMHATwdnRNrs+5A0Gzs0NRSXpXekJV6+kmnA==
X-Received: by 2002:a05:6a20:8e1f:b0:10e:43e:e223 with SMTP id
 y31-20020a056a208e1f00b0010e043ee223mr457539pzj.1.1686705726566; 
 Tue, 13 Jun 2023 18:22:06 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:06 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 23/60] target/riscv: Flush TLB only when pmpcfg/pmpaddr really
 changes
Date: Wed, 14 Jun 2023 11:19:40 +1000
Message-Id: <20230614012017.3100663-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

TLB needn't be flushed when pmpcfg/pmpaddr don't changes.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-Id: <20230517091519.34439-11-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index e0acee7a15..3c12690565 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -26,7 +26,7 @@
 #include "trace.h"
 #include "exec/exec-all.h"
 
-static void pmp_write_cfg(CPURISCVState *env, uint32_t addr_index,
+static bool pmp_write_cfg(CPURISCVState *env, uint32_t addr_index,
                           uint8_t val);
 static uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t addr_index);
 static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index);
@@ -83,7 +83,7 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
  * Accessor to set the cfg reg for a specific PMP/HART
  * Bounds checks and relevant lock bit.
  */
-static void pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
+static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
 {
     if (pmp_index < MAX_RISCV_PMPS) {
         bool locked = true;
@@ -119,14 +119,17 @@ static void pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
 
         if (locked) {
             qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write - locked\n");
-        } else {
+        } else if (env->pmp_state.pmp[pmp_index].cfg_reg != val) {
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule(env, pmp_index);
+            return true;
         }
     } else {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "ignoring pmpcfg write - out of bounds\n");
     }
+
+    return false;
 }
 
 static void pmp_decode_napot(target_ulong a, target_ulong *sa,
@@ -467,16 +470,19 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
     int i;
     uint8_t cfg_val;
     int pmpcfg_nums = 2 << riscv_cpu_mxl(env);
+    bool modified = false;
 
     trace_pmpcfg_csr_write(env->mhartid, reg_index, val);
 
     for (i = 0; i < pmpcfg_nums; i++) {
         cfg_val = (val >> 8 * i)  & 0xff;
-        pmp_write_cfg(env, (reg_index * 4) + i, cfg_val);
+        modified |= pmp_write_cfg(env, (reg_index * 4) + i, cfg_val);
     }
 
     /* If PMP permission of any addr has been changed, flush TLB pages. */
-    tlb_flush(env_cpu(env));
+    if (modified) {
+        tlb_flush(env_cpu(env));
+    }
 }
 
 
@@ -526,12 +532,14 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
         }
 
         if (!pmp_is_locked(env, addr_index)) {
-            env->pmp_state.pmp[addr_index].addr_reg = val;
-            pmp_update_rule_addr(env, addr_index);
-            if (is_next_cfg_tor) {
-                pmp_update_rule_addr(env, addr_index + 1);
+            if (env->pmp_state.pmp[addr_index].addr_reg != val) {
+                env->pmp_state.pmp[addr_index].addr_reg = val;
+                pmp_update_rule_addr(env, addr_index);
+                if (is_next_cfg_tor) {
+                    pmp_update_rule_addr(env, addr_index + 1);
+                }
+                tlb_flush(env_cpu(env));
             }
-            tlb_flush(env_cpu(env));
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "ignoring pmpaddr write - locked\n");
-- 
2.40.1


