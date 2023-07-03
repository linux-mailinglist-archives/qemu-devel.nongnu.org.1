Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0C074627B
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 20:33:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGOMJ-0000dx-73; Mon, 03 Jul 2023 14:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGOMG-0000Ur-RB
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 14:33:08 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGOMF-0000Pz-8i
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 14:33:08 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbc244d3a8so49088145e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 11:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688409186; x=1691001186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxoVzJhi2n2dGTE2zLar6uJBuHBuoJDv5oC7y/6cp9w=;
 b=Y+XaAPfyeufkxXFOIiWfxi52RTughpAnKhc71LcwVPTCA8FTatE5LGefW/KS397BnL
 RJ47XP8hkOQdw2TCXmk+QLXZFQr4r1K7orTEIwOXqJhHrTqHvTeRVeW/v8tMeimxCh6A
 geBbqxpS6pdQ9hAr0XuCXxg3mruE02cogHRHgvpZ/lY19SCxT+sITiGAyVyEkN9d8ie+
 NyuPGWfjvqhJetpue9ah+vxb2REJx/Elb4jaYVpqNLwVsVQPzAB+FSyYxQxHfDk4V3IJ
 ZuwwoKX2ormZu4HpOZrol9Jkk16bsQp2Cr/4L+T7mFJxU8gZFDUK6u1oOXlzyWLwwF9z
 S8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688409186; x=1691001186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YxoVzJhi2n2dGTE2zLar6uJBuHBuoJDv5oC7y/6cp9w=;
 b=O4BYgBSbnJ7dO42mLRtWVs5mCpXAu4+4/dsxF8Jh+cprFmeqz37NPbOBMzmperVzBg
 4qeunoSeTLMAKN+S6i3eDLtUytkQ3Ol0EklaPCmwjeinKlQEGQ0QgPbtGmKDAubBURkX
 798pDVrxW285mEf9BapS2NGSkdICXHPm9dPFwWtUSwIJXjh0Nr2WYGYwoCqLmbrNcBCW
 TYE73+1/S6nWOVqBabgE8V42iPuqPGPiJOMX9i51azrEltHmlgvkwTc/AzIHzVwX0k1O
 QwCN21zZI5Dv2M99O9lpgUmzlMGwY5Q+vOc7S5ww42jKwz9DQKjvrPYRYJ7JU8ElS1L/
 G1FA==
X-Gm-Message-State: AC+VfDxOyBc4sUYTePSAkiyqVtKkEmurc36E702Wbpma2yT8pYTJdtgs
 ykxYsmpUwegzI7k6AIjT8DUUjS+0Z53Rm+49u/i7pg==
X-Google-Smtp-Source: ACHHUZ4QDzgia0zEAhiOCSiouBOaTQZnM9Rs1nER5K4OlI3cDj8QoWd91vYOugKueaOEbjqHHeNugw==
X-Received: by 2002:a05:600c:ac8:b0:3f7:e65b:5252 with SMTP id
 c8-20020a05600c0ac800b003f7e65b5252mr9449372wmr.1.1688409185870; 
 Mon, 03 Jul 2023 11:33:05 -0700 (PDT)
Received: from localhost.localdomain ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 l1-20020adff481000000b003113ed02080sm26043073wro.95.2023.07.03.11.33.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Jul 2023 11:33:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 12/16] target/riscv: Expose riscv_cpu_pending_to_irq() from
 cpu_helper.c
Date: Mon,  3 Jul 2023 20:31:41 +0200
Message-Id: <20230703183145.24779-13-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230703183145.24779-1-philmd@linaro.org>
References: <20230703183145.24779-1-philmd@linaro.org>
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


