Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC85574EDF5
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 14:18:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJCIG-0002YQ-Tb; Tue, 11 Jul 2023 08:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCHq-00023L-FF
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:16:14 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCHj-0005U5-A9
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:16:09 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbc244d307so64027985e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689077761; x=1691669761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxoVzJhi2n2dGTE2zLar6uJBuHBuoJDv5oC7y/6cp9w=;
 b=Bq2YjeDIJADrVDqP0oxj+Lvkqq3O7bjCFSEB9yN7k1lrlhVky5kjGWJfiTZKmlFpqj
 Q+CbwQdNdfdJ11uc25w3WfN0bOh4bmAeNUmZrIZ/jJ3wT4UfEitFle2JFoRh+iSkAvhW
 64gxx1qG/GBtqE2guS7hos3p8GakpqBB1FvzP+ZMrzKzsH7L9Q1LiScQC6UijeWYAAVE
 itnh+4QN4aFqqVeUmDjh3ZJPQ636CA0GIwgXt6TtwtyH9JmtvUWCLAZxn9Qce7LAMgHs
 76CAFI/iPJT0BbU8d67hHN9rAuSLE0cEG4jCCrqb0AJP1E+fzMXJ4w0RrpJU5BkZoS6Q
 lMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689077761; x=1691669761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YxoVzJhi2n2dGTE2zLar6uJBuHBuoJDv5oC7y/6cp9w=;
 b=Szt5Avug8qHoSXpAH3EAiNGCRZW/IPhkdMf0ZasTjsatt10r7bGrTrfzRQJIVPNt4X
 DqGwgRTRK6qK0GBp/FaI3gb3pU3n1UPDpcYDAPZxY2CLUJFtauj3NdnLWZQXR37zjiLK
 cCHE7XV0XedpqjPQJV/mFqhGUki7kJhI9xUmYHQoiHzoaGAZKEYlElW7MYIjiVHHjiTG
 zj1rUITDxg0CILJgEnrRO2UcqeVH6MeDFcls2LvMiTAFIySkIhDwKAU/ZYHaNYAa15He
 uIQgkoQmQOJgGqPry0tpj12uHsBTWjAJstYM/9ahZ9BykpLD550R6J8mzDPEiHA63HAB
 PRNA==
X-Gm-Message-State: ABy/qLYiIqEF0WylozzL6rdCUlBPxULzj3avqnjILgp1h98YIyaCox/o
 tyJW+B0lnHwYvbF3fwgUfLSYjKJ/ydaav4Ic6mM=
X-Google-Smtp-Source: APBJJlENi6aV8Jjoxn5+KD7p08VCJtGdN1iUfk/LLWNqi3jdWQKHov3Uzf5aika0FJxZRYxkWChSIA==
X-Received: by 2002:a5d:43c2:0:b0:30e:3f55:ebc9 with SMTP id
 v2-20020a5d43c2000000b0030e3f55ebc9mr14919113wrr.13.1689077761503; 
 Tue, 11 Jul 2023 05:16:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 z8-20020adff1c8000000b003141e86e751sm2155605wro.5.2023.07.11.05.16.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 05:16:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 12/16] target/riscv: Expose riscv_cpu_pending_to_irq() from
 cpu_helper.c
Date: Tue, 11 Jul 2023 14:14:49 +0200
Message-Id: <20230711121453.59138-13-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230711121453.59138-1-philmd@linaro.org>
References: <20230711121453.59138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We want to extract TCG/sysemu-specific code from cpu_helper.c,
but some functions call riscv_cpu_pending_to_irq(). Expose the
prototype in "internals.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/internals.h  | 4 ++++
 target/riscv/cpu_helper.c | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index b5f823c7ec..b6881b4815 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -72,6 +72,10 @@ target_ulong fclass_d(uint64_t frs1);
 
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_riscv_cpu;
+
+int riscv_cpu_pending_to_irq(CPURISCVState *env,
+                             int extirq, unsigned int extirq_def_prio,
+                             uint64_t pending, uint8_t *iprio);
 #endif
 
 enum {
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6c773000a5..e73cf56e5c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -256,9 +256,9 @@ uint8_t riscv_cpu_default_priority(int irq)
     return default_iprio[irq] ? default_iprio[irq] : IPRIO_MMAXIPRIO;
 };
 
-static int riscv_cpu_pending_to_irq(CPURISCVState *env,
-                                    int extirq, unsigned int extirq_def_prio,
-                                    uint64_t pending, uint8_t *iprio)
+int riscv_cpu_pending_to_irq(CPURISCVState *env,
+                             int extirq, unsigned int extirq_def_prio,
+                             uint64_t pending, uint8_t *iprio)
 {
     int irq, best_irq = RISCV_EXCP_NONE;
     unsigned int prio, best_prio = UINT_MAX;
-- 
2.38.1


