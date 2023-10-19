Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B987CF085
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 08:57:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtMxk-0007dW-3H; Thu, 19 Oct 2023 02:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qtMxh-0007bL-Od
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 02:56:53 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qtMxg-0002lf-3t
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 02:56:53 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1caad0bcc95so9116855ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 23:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697698610; x=1698303410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bSf8gEwh2FgjAbvUivUkN713PBcoBMD4z6Ks6W+a29Q=;
 b=H0SaOx02mttbe42V0woHZYipMImxBnr27o5Bx4MwlrihjEWdQ0psYAa7AlY/cSiIot
 tYvb2esi7GgAAzZCKcDIa2UAghr7qkYpubSL1ac2OeCtGLLHhVMhsNXcINSaaqKNaUpm
 0HLuzVcS9n6pKgT2sRJDzmzZavoncBPrHcz7J6giyBUFINkWconRCy7s3oc4DQxWYtNT
 8p8QWADErDlD26VN5oYyFSuZEW/qjts6jufFmTOoy8QnofEoljRGBFuPzX6Q1KSyx2s+
 ngoft/l8YsNpW/5MEwMMZt9y8qaq12d6KnW1yi2JC6JwVNVUiDlAi9iiFeCt4LKXeRAp
 5cyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697698610; x=1698303410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bSf8gEwh2FgjAbvUivUkN713PBcoBMD4z6Ks6W+a29Q=;
 b=cbDDlyNpIVbUsjfrWSY6dKA17zP9BwVMrNy2/SUdPRwpyRLWuJhQE2tyrRz+czVwzd
 6xJHyV8Niuz2EX1AWc49i0sDNgqZCGgWRLpmnubTEybaE91T8gUxhbBbZyVE14qOUKL1
 ZsLuwfY30kDF48/2P0ovLk6eW6wj7b6TgXIjCDVbXOJr2Jok/8Vzf/ikB5xw4f1Ril1q
 YXUsJnC7Y9coGId7iiUFmA8C3qbtJpZwRttFyV7Yh31JpmPzGcQuzj0TQrL4h56LkNzv
 37dF8HTj5iWn7g8JWjE9OcxLyrmR6D792epJsseWIA84jRLhkPrJ3/2LpDMkU/jBZ1Fk
 /tLA==
X-Gm-Message-State: AOJu0YwbHFFRk0ElXBqaIu/HIISPXgyQMZ07I7OnyZOaJ31k9JpmUUVX
 j2TCKyTv89371HCcNbXS5bruPA==
X-Google-Smtp-Source: AGHT+IFfT78Md+9Ka8YH610n8fijuNHYtrhSd2wsQwvV9Luf/wDRs3Y9TaKMFUbYtMkcleFXK68N/g==
X-Received: by 2002:a17:903:320c:b0:1c9:e072:3398 with SMTP id
 s12-20020a170903320c00b001c9e0723398mr1508799plh.41.1697698610254; 
 Wed, 18 Oct 2023 23:56:50 -0700 (PDT)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:5302:9b99:4f57:4dc3:993d:4317])
 by smtp.googlemail.com with ESMTPSA id
 u8-20020a17090282c800b001b896d0eb3dsm1089917plz.8.2023.10.18.23.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 23:56:49 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2] target/riscv: pmp: Clear pmp/smepmp bits on reset
Date: Thu, 19 Oct 2023 12:26:44 +0530
Message-Id: <20231019065644.1431798-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=mchitale@ventanamicro.com; helo=mail-pl1-x62a.google.com
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
the pmp/smpemp state across reboots. As required by the spec, also clear
the 'A' field of pmp entries.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---

Changes in v2:
====
- Rebase on latest riscv-to-apply.next
- Clear 'A' field.

 target/riscv/cpu.c | 11 +++++++++++
 target/riscv/pmp.c | 10 ++++++++++
 target/riscv/pmp.h |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index dad167833cc..491e0e46e2e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -883,6 +883,17 @@ static void riscv_cpu_reset_hold(Object *obj)
     }
     /* mmte is supposed to have pm.current hardwired to 1 */
     env->mmte |= (EXT_STATUS_INITIAL | MMTE_M_PM_CURRENT);
+
+    /*
+     * Clear mseccfg and unlock all the PMP entries upon reset.
+     * This is allowed as per the priv and smepmp specifications
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
index 21d2489e27e..4dfaa28fce2 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -135,6 +135,16 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
     return false;
 }
 
+void pmp_unlock_entries(CPURISCVState *env)
+{
+    uint32_t pmp_num = pmp_get_num_rules(env);
+    int i;
+
+    for (i = 0; i < pmp_num; i++) {
+        env->pmp_state.pmp[i].cfg_reg &= ~(PMP_LOCK | PMP_AMATCH);
+    }
+}
+
 static void pmp_decode_napot(target_ulong a, target_ulong *sa,
                              target_ulong *ea)
 {
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index cf5c99f8e68..9af8614cd4f 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -28,6 +28,7 @@ typedef enum {
     PMP_READ  = 1 << 0,
     PMP_WRITE = 1 << 1,
     PMP_EXEC  = 1 << 2,
+    PMP_AMATCH = (3 << 3),
     PMP_LOCK  = 1 << 7
 } pmp_priv_t;
 
@@ -81,6 +82,7 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index);
 void pmp_update_rule_nums(CPURISCVState *env);
 uint32_t pmp_get_num_rules(CPURISCVState *env);
 int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);
+void pmp_unlock_entries(CPURISCVState *env);
 
 #define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
 #define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
-- 
2.34.1


