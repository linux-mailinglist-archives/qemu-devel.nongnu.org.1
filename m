Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A42DB73EF22
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 01:21:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDvVw-0004l4-8n; Mon, 26 Jun 2023 19:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDvVr-0004iX-VV
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 19:20:51 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDvVq-0000Ap-6f
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 19:20:51 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b698dd515dso33673661fa.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 16:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687821648; x=1690413648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eiJRm9dNflVLbzk1HDloTKSsjOOAeGYdt13uGLUOy3Q=;
 b=TNbMGgUqpHFY7MHZV2HNUHTGA35ajJcS/qVxlzpC7BX/wWtSMFcQUH5VlTgPUsGwvv
 qA3ahx9+ziwpB1TE81UYqKW0lmHtfDB5a9s2MQ83ZYbP+laZoPsJQTrfqNwdnrgcUKPC
 wGmAfuZuZkwDUvhMxiqZlesjMkD20va9L/G1h2HfqaKjr85M0VagE1dYVd5S+WkbtxNt
 9tloLnjN7R10pmW0GEHOLDVRsE8MKONGOx/HB7vRTMGUbnTlt+rmIykpIijcYm1hbekw
 2iCP9T02pyjfXKRrklfobX3/IA4geb4x5V/beVHo29RzHOIsKCUBTH62WAfHUqnwmHDO
 RHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687821648; x=1690413648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eiJRm9dNflVLbzk1HDloTKSsjOOAeGYdt13uGLUOy3Q=;
 b=JjHJOB8rYmQ5cv05M6vIySksc36QnWwbsYd8o+iJv8oEp2NB4C1e5kX1KH/aSfV3gt
 ywtb/TVw19ZMR+Qw2nFHeZvj+XDl9eaDs9YCm9uwIHlJBdYMUseoWPPDsGXccGwHVs7W
 nQsGnfmE3BMGPq1kwGPxnkzW95xqd+990r0/n1ciSMmubYIbT2Cypeo7++bHBdVptf89
 0U9PTPRphPKLaPPk6T5P4ShChY/PGHA0CBjs2V2lSnrCROtBKLGoGO7Rdie00sNKe2+H
 CufKL7R4ETP7pazg/XFEs67uekgaWvGDPdFs/FoA8dPAYK2t7dvEnoSQH0chNvMzGopr
 SvjA==
X-Gm-Message-State: AC+VfDwEvl7MFg4nscnjeaLIwQUoCFNkfWrVBRehiqRjBdv/nJnUQvb7
 TG/x2VCLmVYkkQRQldjhr76AwsLwOz4YS0uHah8=
X-Google-Smtp-Source: ACHHUZ4ODcuhn21yHg4IsYms5EUFs3C/rnI1Je8CTMHNd7gUThqeY5XlEDVtPWKuhvC9JChz5EcDYQ==
X-Received: by 2002:a2e:9542:0:b0:2b1:a89a:5f2b with SMTP id
 t2-20020a2e9542000000b002b1a89a5f2bmr19184807ljh.2.1687821648287; 
 Mon, 26 Jun 2023 16:20:48 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.226])
 by smtp.gmail.com with ESMTPSA id
 k19-20020a05640212d300b0051d988bd64bsm1670037edx.97.2023.06.26.16.20.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jun 2023 16:20:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org
Subject: [PATCH 06/16] target/riscv: Restrict riscv_cpu_do_interrupt() to
 sysemu
Date: Tue, 27 Jun 2023 01:19:57 +0200
Message-Id: <20230626232007.8933-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230626232007.8933-1-philmd@linaro.org>
References: <20230626232007.8933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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
index 83a9a965d1..288df4c2b1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -411,7 +411,6 @@ extern const char * const riscv_int_regnamesh[];
 extern const char * const riscv_fpr_regnames[];
 
 const char *riscv_cpu_get_trap_name(target_ulong cause, bool async);
-void riscv_cpu_do_interrupt(CPUState *cpu);
 int riscv_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, DumpState *s);
 int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
@@ -444,6 +443,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
 #define cpu_mmu_index riscv_cpu_mmu_index
 
 #ifndef CONFIG_USER_ONLY
+void riscv_cpu_do_interrupt(CPUState *cpu);
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
                                      MMUAccessType access_type,
@@ -467,7 +467,8 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
                                    void *rmw_fn_arg);
 
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
-#endif
+#endif /* !CONFIG_USER_ONLY */
+
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
 
 void riscv_translate_init(void);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 5ff48be561..cc0050d110 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1575,7 +1575,6 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
 
     return xinsn;
 }
-#endif /* !CONFIG_USER_ONLY */
 
 /*
  * Handle Traps
@@ -1585,8 +1584,6 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
  */
 void riscv_cpu_do_interrupt(CPUState *cs)
 {
-#if !defined(CONFIG_USER_ONLY)
-
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     bool write_gva = false;
@@ -1779,6 +1776,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
     env->two_stage_lookup = false;
     env->two_stage_indirect_lookup = false;
-#endif
-    cs->exception_index = RISCV_EXCP_NONE; /* mark handled to qemu */
 }
+
+#endif /* !CONFIG_USER_ONLY */
-- 
2.38.1


