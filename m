Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B927ADAA2
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:53:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmwO-00061c-6U; Mon, 25 Sep 2023 10:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkmty-0001rE-IF
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkmtW-0008L9-JE
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:32 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3232be274a0so1026041f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695653344; x=1696258144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vW14u2/R+fXBkgsAVXJeC+s7wkbS5Xjof2Eeqsenrno=;
 b=P07QOw7h7oSiIPedHOIx4ngpU/EA9KM7CHQbbpv6tGCmBqzS5i8MGV2+Rq0OUDAe8W
 varXa11UsGKo3ckBmFqZkrnS5NttRlCWa3pZB05qBNbHcTUaBM8zughgyAtWNb+ZF3qw
 8EX/Ubl1iVQvRuTiUlevCnHccHKOBvn8ejjOh9aelQTxPJCOS/wGbaSd5GMmU/7fPLyA
 AOm57XbvMtu3HnK4TvNqzCxgUkDIPbQQu65k6m/SFEce3ISw/pHYRRJgPHo/V5FR4BfT
 JvqqDJnXzJXQIfY07fpfTdzvQlEuEL2uUlnAVHot/5FAZ0yHSBz0+ipTTi3m/IhZv8qn
 wEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653344; x=1696258144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vW14u2/R+fXBkgsAVXJeC+s7wkbS5Xjof2Eeqsenrno=;
 b=OqLjjmOveuCYfbeXK/nI7oBxJ6V3fynG+k5wQz1u6w/NIQ50FVJcxP8+Xth2jIYbv7
 joZs8SXU4KTOrRt8O2w1Kw0K2Pvq/XhSy1jZ7re+/Jd1mZp4mWGRLKuNpNDnRVMZWors
 FPtGIEJdO/yCZ6Wjf4cpadErrVEJTsZNoIhSNZ+pOXb+1LmAlpC8a5OVGKH4GouHyoQ7
 o/VnO2jqVAh4k200jfrDcrfOJtG1mWJrZv9KyQHAPfIxq07uyuc81b82SW/JQ8CkGSZd
 pG1p66uy2LirILG3aKWzUyX6pnM5t94Wevq/6+56ZgfCz5kHnAiJniPvjvFnnVy4lUa5
 xz2Q==
X-Gm-Message-State: AOJu0Ywe713uLvo5Vy7M3LdEH6JTx38vHH93WTFFTx565kEJLo9/F3KF
 eoVVl3WNoH7jm33siFz8YPb/5w==
X-Google-Smtp-Source: AGHT+IFoDt+/1YdAyaAs2mIqGW3PYJilqzR3pMEU0y3yKYA/nuwBdpG428Qs2pPLYZN2DO43DVDw7A==
X-Received: by 2002:a5d:4003:0:b0:321:f74d:ade3 with SMTP id
 n3-20020a5d4003000000b00321f74dade3mr7250450wrp.32.1695653344259; 
 Mon, 25 Sep 2023 07:49:04 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a7bcb8d000000b003ff3b964a9asm15334036wmi.39.2023.09.25.07.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:49:03 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D21F41FFC1;
 Mon, 25 Sep 2023 15:48:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Nicholas Piggin <npiggin@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bin.meng@windriver.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Matt Borgerson <contact@mborgerson.com>
Subject: [PATCH 23/31] plugins: Set final instruction count in
 plugin_gen_tb_end
Date: Mon, 25 Sep 2023 15:48:46 +0100
Message-Id: <20230925144854.1872513-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925144854.1872513-1-alex.bennee@linaro.org>
References: <20230925144854.1872513-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Matt Borgerson <contact@mborgerson.com>

Translation logic may partially decode an instruction, then abort and
remove the instruction from the TB. This can happen for example when an
instruction spans two pages. In this case, plugins may get an incorrect
result when calling qemu_plugin_tb_n_insns to query for the number of
instructions in the TB. This patch updates plugin_gen_tb_end to set the
final instruction count.

Signed-off-by: Matt Borgerson <contact@mborgerson.com>
[AJB: added g_assert to defed API]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <CADc=-s5RwGViNTR-h5cq3np673W3RRFfhr4vCGJp0EoDUxvhog@mail.gmail.com>
---
 include/exec/plugin-gen.h | 4 ++--
 accel/tcg/plugin-gen.c    | 6 +++++-
 accel/tcg/translator.c    | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
index 52828781bc..c4552b5061 100644
--- a/include/exec/plugin-gen.h
+++ b/include/exec/plugin-gen.h
@@ -20,7 +20,7 @@ struct DisasContextBase;
 
 bool plugin_gen_tb_start(CPUState *cpu, const struct DisasContextBase *db,
                          bool supress);
-void plugin_gen_tb_end(CPUState *cpu);
+void plugin_gen_tb_end(CPUState *cpu, size_t num_insns);
 void plugin_gen_insn_start(CPUState *cpu, const struct DisasContextBase *db);
 void plugin_gen_insn_end(void);
 
@@ -42,7 +42,7 @@ void plugin_gen_insn_start(CPUState *cpu, const struct DisasContextBase *db)
 static inline void plugin_gen_insn_end(void)
 { }
 
-static inline void plugin_gen_tb_end(CPUState *cpu)
+static inline void plugin_gen_tb_end(CPUState *cpu, size_t num_insns)
 { }
 
 static inline void plugin_gen_disable_mem_helpers(void)
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 5c13615112..c0adc9f4b7 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -866,10 +866,14 @@ void plugin_gen_insn_end(void)
  * do any clean-up here and make sure things are reset in
  * plugin_gen_tb_start.
  */
-void plugin_gen_tb_end(CPUState *cpu)
+void plugin_gen_tb_end(CPUState *cpu, size_t num_insns)
 {
     struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
 
+    /* translator may have removed instructions, update final count */
+    g_assert(num_insns <= ptb->n);
+    ptb->n = num_insns;
+
     /* collect instrumentation requests */
     qemu_plugin_tb_trans_cb(cpu, ptb);
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 37f8dadbbd..ff84282fe5 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -212,7 +212,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);
 
     if (plugin_enabled) {
-        plugin_gen_tb_end(cpu);
+        plugin_gen_tb_end(cpu, db->num_insns);
     }
 
     /* The disas_log hook may use these values rather than recompute.  */
-- 
2.39.2


