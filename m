Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7420474EDE7
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 14:17:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJCHb-0001iP-Uh; Tue, 11 Jul 2023 08:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCHG-0001Re-Pp
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:15:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCH2-0005Le-Ay
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:15:34 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57ddso57835945e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 05:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689077718; x=1691669718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UaLFn1nG0baOids45BFvGGXesNjHPpz9SvJuwJCFeRI=;
 b=Vlg2K71MG1unvjEgk8zP4Ujf9Rc16a/GDW5suKI30ZH2ACWTEnZYdJOT6ksQ6i8Uye
 35P8Kb02uPHBI9zfM4+EeQD7/9KLnTqGdRTs5gpJhuyjRugqpH7yz1oMQYPzwe58Ge03
 KU0DNul4OWebluv8slUxhxG44OsNjn5hNzeWYKPEyI2X5eTVKd/eqQQ5rXJtpZ2OiLBv
 /CCLU/hBiuUMYTWHXeGGZ/Ez0D7GbnwpqGvn3R1UKQ+OL278jmjfAzqz7PnI1rBknbvD
 12bvAGcFxCRVBvxp3WUPHl0U+fQ2GqP6Th/8oybuTYebXzuqU4NSHDY2RVl0bSU4AmNJ
 6Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689077718; x=1691669718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UaLFn1nG0baOids45BFvGGXesNjHPpz9SvJuwJCFeRI=;
 b=l4cAx39czLTFMMSQEUxRErhxEmSBsXk83TtKuubWpwHQGL+w4vRYeoaOqjulO0xhQs
 4YLt7G0IRzoX+6ApDA4rDunRMWaE+rndyDL84BzwRxbXPoVR9Paagcpd26YRmN919OlY
 rQmGp3ql1RxuhYkIfcx+uBRCPggFwWHT9CQo1/q27QHAJhOKYGFk1wpjXZXrAmmaWXdM
 OR/3j3n8kvp1MiiaAEa+DL0XOhC7/BSlWa/kDo3A4GuUJurlJm1azNTBK1jqQv8Qqpr9
 3RZDp1DWalRaUrixUO1HSXKp9Bn6GVs3Z3OczqYjDpIF2IAh2co0cyaAPI0YeJCTYyKp
 7rbA==
X-Gm-Message-State: ABy/qLap1bZ+VcEUC5ONXyHcRMCMMTvZrMfClNmerdM28Su/lxhYrSor
 juoI9tYOszxtiu4z53B1bRrqkTWMsPYVMvlOGWM=
X-Google-Smtp-Source: APBJJlEcK8+2CSJGN94SI+hiS2ZqUQ9BruVrW+1LHgBAAvy6dq66Xa31XSMaxtR2E78+7Oj3wH/luQ==
X-Received: by 2002:a05:600c:244:b0:3fb:b1af:a455 with SMTP id
 4-20020a05600c024400b003fbb1afa455mr13210185wmj.5.1689077718548; 
 Tue, 11 Jul 2023 05:15:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a1ced03000000b003fc0062f0f8sm2429685wmh.9.2023.07.11.05.15.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 05:15:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 04/16] target/riscv: Restrict 'rv128' machine to TCG
 accelerator
Date: Tue, 11 Jul 2023 14:14:41 +0200
Message-Id: <20230711121453.59138-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230711121453.59138-1-philmd@linaro.org>
References: <20230711121453.59138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

We only build for 32/64-bit hosts, so TCG is required for
128-bit targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5712a54404..faf703afcb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -495,6 +495,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
 #endif
 }
 
+#ifdef CONFIG_TCG
 static void rv128_base_cpu_init(Object *obj)
 {
     if (qemu_tcg_mttcg_enabled()) {
@@ -513,7 +514,10 @@ static void rv128_base_cpu_init(Object *obj)
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
 #endif
 }
-#else
+#endif
+
+#else /* !TARGET_RISCV64 */
+
 static void rv32_base_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -595,7 +599,7 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
     cpu->cfg.ext_icsr = true;
     cpu->cfg.pmp = true;
 }
-#endif
+#endif /* !TARGET_RISCV64 */
 
 #if defined(CONFIG_KVM)
 static void riscv_host_cpu_init(Object *obj)
@@ -2274,8 +2278,10 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_SHAKTI_C,         rv64_sifive_u_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_THEAD_C906,       rv64_thead_c906_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_VEYRON_V1,        rv64_veyron_v1_cpu_init),
+#ifdef CONFIG_TCG
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,  rv128_base_cpu_init),
-#endif
+#endif /* CONFIG_TCG */
+#endif /* TARGET_RISCV64 */
 };
 
 DEFINE_TYPES(riscv_cpu_type_infos)
-- 
2.38.1


