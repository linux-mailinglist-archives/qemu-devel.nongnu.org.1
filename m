Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83048797046
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 08:26:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe8Rn-0003zF-QB; Thu, 07 Sep 2023 02:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qe8Rg-0003yr-2z
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 02:24:52 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qe8Rd-0005RT-QD
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 02:24:51 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-56a3e6bce68so467591a12.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 23:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694067888; x=1694672688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=45JMhq6t+j8AdylZLsjCmKllHxj4NWcg/3JdETtHIwE=;
 b=Npjp03DPgUmkvLmWlVjUNv0dBygwCmrBvA5KYdtBwXeuUa6/VKHh7lJJNHrdJooTA1
 mehW+o8lVFRt9VZzY0Kg7/Q24fG1qQAm3x5PfHSPGclmYpMLO6jeBPQGsO1p9lxYJ+0J
 l4gppQ6kzsxCdzYBdTBv4STQkd6JlbUZrc00kdVrCnqMoWqGbfxE8Xh6BiJk2E+B61mE
 oA8p0w8cI/YxOPVth/ZjQFSuIIjjDcNmeAHA0m6us3yWyFEqH0aphgOYuFILFzS9PlBT
 GxHY6Z3fbd1ErezjgdKQPs3EEeUV3ACgx3JPMVj8jCzFK61zpxkeKn4Nn81OV9dfLdC6
 ap3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694067888; x=1694672688;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=45JMhq6t+j8AdylZLsjCmKllHxj4NWcg/3JdETtHIwE=;
 b=M05DdN6fe+4jCC79OP0pBNVKdWc9ClWpTczp2hgtwdT7B4b94xCZ+7pHFwTR7A9UdD
 ls/uxOs69uc73WtEeZb4mRbbRk9Y9XmyYgXYpJT/bxhJvbWRR4U4xabGnGVPTUePxXCa
 l9V5xEwww00TqVdvJ/qnGs7zJ70wrFlaKgeKbzaZdB9ufFWVPkIVqTOsLloneliwp0vp
 nftIutyqfE+/hZIMs5NFPX3mnhATcagPD46WBzVvyGfGfFViYWPZw05ElrUb0aht9gxJ
 /xfyxe5Hd+d598ZDQ+XmEMz9Zrq/MKUq3TKgSU3oWZvJmgr4mNLzAsVMGJAJ9UZsVW4I
 g6tA==
X-Gm-Message-State: AOJu0Yxrae4ddx13KCD9/3GqkxIfZ4CsyHTtR30vL5YQWFyc0kp3PGqq
 TuVDoHhSvIitcq+qDgVV28crOpZrASBpZK8jie3YFJHBvYE=
X-Google-Smtp-Source: AGHT+IFsuoJsS/Uy07cXk2ffQF4nkV5Sqd5/cikR519R3VO/JaDlVomwUanKgtZWbl5BVR+Mi7mldw==
X-Received: by 2002:a17:903:22c7:b0:1b9:c207:1802 with SMTP id
 y7-20020a17090322c700b001b9c2071802mr19409525plg.0.1694067887774; 
 Wed, 06 Sep 2023 23:24:47 -0700 (PDT)
Received: from mchitale-vm.. ([106.195.11.23])
 by smtp.googlemail.com with ESMTPSA id
 ik21-20020a170902ab1500b001b9f032bb3dsm12299642plb.3.2023.09.06.23.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 23:24:47 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
	alistair.francis@wdc.com
Subject: [PATCH] target/riscv: pmp: Clear pmp/smepmp bits on reset
Date: Thu,  7 Sep 2023 11:54:40 +0530
Message-Id: <20230907062440.1174224-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=mchitale@ventanamicro.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As per the Priv and Smepmp specifications, certain bits such as the 'L'
bit of pmp entries and mseccfg.MML can only be cleared upon reset and it
is necessary to do so to allow 'M' mode firmware to correctly reinitialize
the pmp/smpemp state across reboots.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 target/riscv/cpu.c | 11 +++++++++++
 target/riscv/pmp.c | 10 ++++++++++
 target/riscv/pmp.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0843461660..77ed653b8d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -896,6 +896,17 @@ static void riscv_cpu_reset_hold(Object *obj)
     }
     /* mmte is supposed to have pm.current hardwired to 1 */
     env->mmte |= (EXT_STATUS_INITIAL | MMTE_M_PM_CURRENT);
+
+    /*
+     * Clear mseccfg and unlock all the PMP entries upon reset.
+     * This is allowed as per the priv and smepmp specifications.
+     * and is needed to clear stale entries across reboots.
+     */
+    if (riscv_cpu_cfg(env)->ext_smepmp) {
+        env->mseccfg = 0;
+    }
+
+    pmp_unlock_entries(env);
 #endif
     env->xl = riscv_cpu_mxl(env);
     riscv_cpu_update_mask(env);
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 3f6c8cf08d..f3eb6e6585 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -131,6 +131,16 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
     return false;
 }
 
+void pmp_unlock_entries(CPURISCVState *env)
+{
+    uint32_t pmp_num = pmp_get_num_rules(env);
+    int i;
+
+    for (i = 0; i < pmp_num; i++) {
+        env->pmp_state.pmp[i].cfg_reg &= ~PMP_LOCK;
+    }
+}
+
 static void pmp_decode_napot(target_ulong a, target_ulong *sa,
                              target_ulong *ea)
 {
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index cf5c99f8e6..2c5ec3cdf1 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -81,6 +81,7 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index);
 void pmp_update_rule_nums(CPURISCVState *env);
 uint32_t pmp_get_num_rules(CPURISCVState *env);
 int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);
+void pmp_unlock_entries(CPURISCVState *env);
 
 #define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
 #define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
-- 
2.34.1


