Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D35D2740973
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 08:33:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEOjx-0002iL-12; Wed, 28 Jun 2023 02:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEOji-0002hI-8n
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:33:07 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEOjg-0002zj-IQ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:33:06 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b44eddb52dso83313161fa.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 23:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687933982; x=1690525982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qC/1GiJPfuuKIOYH9GpoitlcBjboxKTENlQqXK5RUaI=;
 b=qQtobIVJv9S5GZA1akR2od2AX88CrH4D/lYGqelS3VnwsIwBtaBxz3EMSmC1OqcQaN
 toTS/oOTAsMCVHlKgWV2AhMewHv7QirzBfb0andM+4I6k6P6Gj2xvEDvV1dJaS8DQGML
 yVesjJwcMGMRxO5P9cOzyPK5RfdY87A0ISWXnLSf8PEpfEQYj2b1r8FZRlxE2heGYYSa
 oiQkDgDzoLFL6YFGaWDoLtJAu5LMJPUvKaMiJqJXKxGUuVqsoDz9uq+XDPxuVrplpdkg
 H50RONCYa6/rzFf6ScRDlVQtm3vKu6fYV/muf5J3mOmiPclJozBSD4VhXNYqz5nJesL5
 zDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687933982; x=1690525982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qC/1GiJPfuuKIOYH9GpoitlcBjboxKTENlQqXK5RUaI=;
 b=CCVXVXPKV7wUVzClH29BUryum69nQfUMID76lIvfKeSQ+/qkfRkfAgV1/JxcSYeaaP
 mOXsXCSJQyKcjHlzvhdIRGvf58D5G2KB04YTFgSsB61dhEZYrq2g8ZvhPindA1YTGBMI
 vTAbP9LXxao1na14JKz9Knc1t7nkGPwmTI3xCrJGehuPhP7QoWpuUlygBthOzCXqpHhG
 miA8YQKOGWzvVN/Lbz7KLqyxGzB0DroKmk7RoKliWFSZGcA1uWcBE3dQgFw2TKRCzz5J
 n2FVcisV71IKW8T3LPhT8fHVQRZoaradGyeECHzOmdv26YiWUD9OUW+xU5M9zRJBkTT4
 yWtQ==
X-Gm-Message-State: AC+VfDz6AVdq1hTJuN7eUL2zdQLNsYyQ68B6BeuBA785TdUJHfbXzk1I
 BHPEvtNfuk46NMTBevfd+YCqXQz0aVhgMg/PCIc=
X-Google-Smtp-Source: ACHHUZ4SnBarwCAC1JJL2i4KUcSAthpiSqDvb7SlYp3B+HRtGR0CGIaxUnizcaBKM6zY7LQPUHELNw==
X-Received: by 2002:a05:651c:10c:b0:2b6:a55c:fd72 with SMTP id
 a12-20020a05651c010c00b002b6a55cfd72mr4449500ljb.37.1687933982566; 
 Tue, 27 Jun 2023 23:33:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 n23-20020a7bcbd7000000b003f9b19caabesm12837214wmi.37.2023.06.27.23.33.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jun 2023 23:33:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/4] target/riscv: Restrict riscv_cpu_do_interrupt() to
 sysemu
Date: Wed, 28 Jun 2023 08:32:34 +0200
Message-Id: <20230628063234.32544-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628063234.32544-1-philmd@linaro.org>
References: <20230628063234.32544-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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
index cc20ee25a7..ab6aa7e3ea 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -409,7 +409,6 @@ extern const char * const riscv_int_regnamesh[];
 extern const char * const riscv_fpr_regnames[];
 
 const char *riscv_cpu_get_trap_name(target_ulong cause, bool async);
-void riscv_cpu_do_interrupt(CPUState *cpu);
 int riscv_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, DumpState *s);
 int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
@@ -442,6 +441,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
 #define cpu_mmu_index riscv_cpu_mmu_index
 
 #ifndef CONFIG_USER_ONLY
+void riscv_cpu_do_interrupt(CPUState *cpu);
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
                                      MMUAccessType access_type,
@@ -465,7 +465,8 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
                                    void *rmw_fn_arg);
 
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
-#endif
+#endif /* !CONFIG_USER_ONLY */
+
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
 
 void riscv_translate_init(void);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3c28396eaf..3f5ba2b4ef 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1580,7 +1580,6 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
 
     return xinsn;
 }
-#endif /* !CONFIG_USER_ONLY */
 
 /*
  * Handle Traps
@@ -1590,8 +1589,6 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
  */
 void riscv_cpu_do_interrupt(CPUState *cs)
 {
-#if !defined(CONFIG_USER_ONLY)
-
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     bool write_gva = false;
@@ -1784,6 +1781,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
     env->two_stage_lookup = false;
     env->two_stage_indirect_lookup = false;
-#endif
-    cs->exception_index = RISCV_EXCP_NONE; /* mark handled to qemu */
 }
+
+#endif /* !CONFIG_USER_ONLY */
-- 
2.38.1


