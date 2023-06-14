Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 305D372F20D
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:36:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FDE-0007FE-Gf; Tue, 13 Jun 2023 21:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDC-0006rp-2P
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:14 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDA-0004jF-2W
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:13 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-65292f79456so4685873b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705730; x=1689297730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bo0TeGfMOxBLViqxtiPArCs/hfgLjKw7B33Ys+V34Po=;
 b=gDHpWx6xtASXk4xBknYqaoVP9nf6wHO2udheZzWtmqTW/dVdcfvOPVtQ7Kb2BBqRQs
 DwvQy71sKWYpSEdLPhmQti5obrF6P0Wp+C01UgeK76bNs8ppcNLwer5o7rq/1uFyFAR/
 d5QVaxkpLLYn2deOmpLBHkGJ6NjJ1N7bmTFDMVg9c/PQKojb/yfYsi//1Wl8mwIWaK8j
 NHyWIYejpE3U4f0pDNiKi3mExjo9wROO3LpqpoezjwuVWIdID8ot744CKOY2E42sP4G+
 xqcd/xM7aAztn6oOiHUywXbhM3xnVxB4ioBEfPMfmaolk3ymeZ163+YTf4t1wh4bnWND
 omXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705730; x=1689297730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bo0TeGfMOxBLViqxtiPArCs/hfgLjKw7B33Ys+V34Po=;
 b=LOgEtjGijR5YTTUJMmQkqkUbvwECgQJA34iGckbxu3TQLvWy8SERb2iqzNDrzj6kKB
 tXbbb6o3nUgaurgB2LA4glFKtsCVdrDFbPe4NpO2/6IozM6V91O0NcIm6rVc3rKvlxok
 cTGswlJ0aPwlzhMNBFEonGDAA73Wwopk0jJNcpn2IWNIRF8QKWqbSAWYjhVeZvgNuNlM
 a3q9S5Cn7z2rhd5obV0+HyKEmGcwsdhObfP1ED+KX5kiVb1dfIgX8qjuzf02wz2EqIPD
 78YBpsWsyG2OBXYSdGAOXoLo2BCXl0PWtGKgEJ0h2SPeetx3kur63xe4pBHxqWCkj0VC
 2EAA==
X-Gm-Message-State: AC+VfDxiPqVzuAxzyVBBWIJHmK+WbI86Dq6Yq3mSmyHrsIOECDLI40Ak
 bqPfbyYrO4cVz1FRUdIX2eJ89Qqa34yx5A==
X-Google-Smtp-Source: ACHHUZ5vVNZbDnzMdiLqiTSLLH1IaYLSdl2SK5U7VrSk8APCiLQj8EyfJAZ4IwDc5RflWbooX5tt5g==
X-Received: by 2002:aa7:88c2:0:b0:64d:7002:8316 with SMTP id
 k2-20020aa788c2000000b0064d70028316mr531106pff.9.1686705730564; 
 Tue, 13 Jun 2023 18:22:10 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:10 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/60] target/riscv: Separate pmp_update_rule() in
 pmpcfg_csr_write
Date: Wed, 14 Jun 2023 11:19:41 +1000
Message-Id: <20230614012017.3100663-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
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

Use pmp_update_rule_addr() and pmp_update_rule_nums() separately to
update rule nums only once for each pmpcfg_csr_write. Then remove
pmp_update_rule() since it become unused.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517091519.34439-12-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 3c12690565..37e9985d6a 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -29,7 +29,6 @@
 static bool pmp_write_cfg(CPURISCVState *env, uint32_t addr_index,
                           uint8_t val);
 static uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t addr_index);
-static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index);
 
 /*
  * Accessor method to extract address matching type 'a field' from cfg reg
@@ -121,7 +120,7 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
             qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write - locked\n");
         } else if (env->pmp_state.pmp[pmp_index].cfg_reg != val) {
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
-            pmp_update_rule(env, pmp_index);
+            pmp_update_rule_addr(env, pmp_index);
             return true;
         }
     } else {
@@ -209,18 +208,6 @@ void pmp_update_rule_nums(CPURISCVState *env)
     }
 }
 
-/*
- * Convert cfg/addr reg values here into simple 'sa' --> start address and 'ea'
- *   end address values.
- *   This function is called relatively infrequently whereas the check that
- *   an address is within a pmp rule is called often, so optimise that one
- */
-static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index)
-{
-    pmp_update_rule_addr(env, pmp_index);
-    pmp_update_rule_nums(env);
-}
-
 static int pmp_is_in_range(CPURISCVState *env, int pmp_index,
                            target_ulong addr)
 {
@@ -481,6 +468,7 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
 
     /* If PMP permission of any addr has been changed, flush TLB pages. */
     if (modified) {
+        pmp_update_rule_nums(env);
         tlb_flush(env_cpu(env));
     }
 }
-- 
2.40.1


