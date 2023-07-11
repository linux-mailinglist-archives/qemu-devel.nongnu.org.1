Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7E474EDE4
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 14:17:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJCHb-0001gg-5Z; Tue, 11 Jul 2023 08:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCHG-0001Rg-RA
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:15:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCHD-0005MU-JU
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:15:33 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fba8e2aa52so61623585e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 05:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689077729; x=1691669729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=076ECBohTlXUJaxvHTLgPSwneaNiKhykT4Ga9JL6Fu8=;
 b=o4owFtktEUEhOf0ebH1FrU7UNnAeoq6FqF8rwB0aD+YvTPDi5Sb/sn1EvIiyiUPglT
 4acjKmnmZOgIh2XvuaSLgUAWcCSBgkbMgHpEsLU+uoyCGm+gn0g3SshACb8M6wVxz2iY
 Hq/fwuAUEGiWSxJyZgyZR8amI0CWeqhwZsNCkYqa969CDkNFd9v4vzvGVxIkNA7yyYwz
 CBoP81P8JSPhJtBsh4IsRYYsa0PJh99IO8+Dy7sjNgsCoQZZPFSFhrnzQaGc5kg55ezD
 Wvz2naa11htfC8sH6kF26gr5+4VrYL5T5LCvfLf8yUuPkqBq22sOtiCk/D/O2H1SFWoq
 9dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689077729; x=1691669729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=076ECBohTlXUJaxvHTLgPSwneaNiKhykT4Ga9JL6Fu8=;
 b=CH2/C32QP4Sm7kydjV+ghqCJUVQqcs657xas4NeJxLBpMVCI+tmJ2dSnHtnAHctfED
 T68Trb/O7uKRNy7wwR6IE2YqbUPSC6GaZWpyUi8N6ILDhpKO8DPkYCVzjN++vskAvxmI
 3Wf420dcwpyLM2LNnZHt4ci4IiJVY5uEa7zpFLAOr8ioe9Qu2yPsQFTYB5L92Q7wmyIA
 vy4aofskcFuCmGiVoB24Z8KfVIMw5Ie6Vhcazbkk+2C4Dm/iwcYowpE8ZjW3VOLZ2Li1
 aTQvy3KmRjKqW2bCRf8gvfqKfgnxiY+IGVY0scCFEmHdK4PG30Qvyzs0rvIuMLivgNzr
 m/8Q==
X-Gm-Message-State: ABy/qLYLJWas57o2/YojOWZlXYXJCKhnM1SJZSED2Szhp5iH5LCf5dVX
 1qlEVfW/Mod4x2x71y9pwp5gBcr0Yod/vvDPzdI=
X-Google-Smtp-Source: APBJJlHpQaebtd3/3ljnzMYoScNm/LDC9xsiUCzWBlyDHmBiU0SP+xhoa0We8QLEyhT9F8JlO3+vXA==
X-Received: by 2002:adf:e341:0:b0:314:5535:8366 with SMTP id
 n1-20020adfe341000000b0031455358366mr13503405wrj.43.1689077729295; 
 Tue, 11 Jul 2023 05:15:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a5d6712000000b003113ed02080sm2076090wru.95.2023.07.11.05.15.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 05:15:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/16] target/riscv: Restrict riscv_cpu_do_interrupt() to
 sysemu
Date: Tue, 11 Jul 2023 14:14:43 +0200
Message-Id: <20230711121453.59138-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230711121453.59138-1-philmd@linaro.org>
References: <20230711121453.59138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

riscv_cpu_do_interrupt() is not reachable on user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.h        | 5 +++--
 target/riscv/cpu_helper.c | 7 ++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index dba78db644..0602b948d4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -416,7 +416,6 @@ extern const char * const riscv_int_regnamesh[];
 extern const char * const riscv_fpr_regnames[];
 
 const char *riscv_cpu_get_trap_name(target_ulong cause, bool async);
-void riscv_cpu_do_interrupt(CPUState *cpu);
 int riscv_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, DumpState *s);
 int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
@@ -449,6 +448,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
 #define cpu_mmu_index riscv_cpu_mmu_index
 
 #ifndef CONFIG_USER_ONLY
+void riscv_cpu_do_interrupt(CPUState *cpu);
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
                                      MMUAccessType access_type,
@@ -472,7 +472,8 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
                                    void *rmw_fn_arg);
 
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
-#endif
+#endif /* !CONFIG_USER_ONLY */
+
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
 
 void riscv_translate_init(void);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0adde26321..597c47bc56 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1579,7 +1579,6 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
 
     return xinsn;
 }
-#endif /* !CONFIG_USER_ONLY */
 
 /*
  * Handle Traps
@@ -1589,8 +1588,6 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
  */
 void riscv_cpu_do_interrupt(CPUState *cs)
 {
-#if !defined(CONFIG_USER_ONLY)
-
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     bool write_gva = false;
@@ -1783,6 +1780,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
     env->two_stage_lookup = false;
     env->two_stage_indirect_lookup = false;
-#endif
-    cs->exception_index = RISCV_EXCP_NONE; /* mark handled to qemu */
 }
+
+#endif /* !CONFIG_USER_ONLY */
-- 
2.38.1


