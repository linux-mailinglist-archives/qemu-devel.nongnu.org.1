Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04461783A7B
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:11:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLY3-0003aN-Ut; Tue, 22 Aug 2023 03:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLXe-00036R-Io
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:11:09 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLXb-0002PS-UQ
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:11:05 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-319559fd67dso3877356f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688262; x=1693293062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ac7pv2kpb0ajeFGbtJ3onoCTyP2ZNqDH1hhRLbCbPbE=;
 b=rB96EO2v6DcNYHPQOVDRulIp0flmeeOzA70d15VRu4eNNrZidgjDBUi/lQulVSCeJQ
 lnebTzU2NW+BiG7+wOZsLhtu2VPbdfolJx9H6LFewqyQH+rEIUHq0aJPZczuLryjLyL7
 h0XT1z7OXeMkZmz7FZYcNU/UGcWt235z4m3Y4ndIiKH1ZjFqzPFUQ0G42Juj+HGOYVgZ
 +ZG4l+2QZxu9bvrOyDPT+iiyZbP5OAdGVw7xBpujU2tjmLz0kgPF70jcxehpFR4G3CRH
 KUZlvYEw5hIgy/VTndMWjC7MV8NbKIC2QYQZrBFMBVTjUfoVwSreXfhg6sEnbcrTVEtv
 lsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688262; x=1693293062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ac7pv2kpb0ajeFGbtJ3onoCTyP2ZNqDH1hhRLbCbPbE=;
 b=GvJmCHIFaop6RggaW9Ei9uFH3E+z7l9D28wJ5JiL+FXHUsozwoTRmYhH/ZAQLHuCyS
 qu/EaithhsDUwvXfuG0lnbQS0IQ/NqAwz4VIdiNGsvdPpRMi60CNJU+2IB8mLYGiuTEc
 ltQ4cCU2nhV5JZpT3nIxkbw2rBnKRjWDnN/khlJ2yrtuHVd6nfBypAQ560PNUWCJZSn5
 8yq5sUUqA/5CYPuedhmyTt8S1LpCqzAzXfUTfqTpwJ75beaF8KyDX348mumARDyxOEA5
 8P99jqIgIUEf+N2YcxztdttTF8HfFnnwhrW3VsnOVSXIsj60XDvMN7zQoVWqdqkqfEjQ
 gLFA==
X-Gm-Message-State: AOJu0Yz7TklTZuXmfqw19a1XqaWIz4Ic+UJTrvcfmLLpUCRcqzqxEEdZ
 jGTVooPUnBMMKfUYSY/qSL78xdCK9YscUhybz2GnFw==
X-Google-Smtp-Source: AGHT+IHect3VXZQ83XxRoHmH4A1m0HJhMHte/xOyzLyeHsnGRfhfW2fZeVXHg5LpJ66ZmirwrlcEaw==
X-Received: by 2002:adf:e412:0:b0:317:3e58:64cb with SMTP id
 g18-20020adfe412000000b003173e5864cbmr7689768wrm.46.1692688262168; 
 Tue, 22 Aug 2023 00:11:02 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a5d4647000000b0031c4d4be245sm5789358wrs.93.2023.08.22.00.11.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:11:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 07/19] target/loongarch: Extract make_address_pc() helper
Date: Tue, 22 Aug 2023 09:10:00 +0200
Message-ID: <20230822071013.34884-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071013.34884-1-philmd@linaro.org>
References: <20230822071013.34884-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Jiajie Chen <c@jia.je>

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230822032724.1353391-7-gaosong@loongson.cn>
[PMD: Extract helper from bigger patch]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/translate.c                   | 5 +++++
 target/loongarch/insn_trans/trans_arith.c.inc  | 2 +-
 target/loongarch/insn_trans/trans_branch.c.inc | 4 ++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index acc54d7587..8b26555a27 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -226,6 +226,11 @@ static TCGv make_address_i(DisasContext *ctx, TCGv base, target_long ofs)
     return make_address_x(ctx, base, addend);
 }
 
+static uint64_t make_address_pc(DisasContext *ctx, uint64_t addr)
+{
+    return addr;
+}
+
 #include "decode-insns.c.inc"
 #include "insn_trans/trans_arith.c.inc"
 #include "insn_trans/trans_shift.c.inc"
diff --git a/target/loongarch/insn_trans/trans_arith.c.inc b/target/loongarch/insn_trans/trans_arith.c.inc
index 43d6cf261d..2aea4e41d5 100644
--- a/target/loongarch/insn_trans/trans_arith.c.inc
+++ b/target/loongarch/insn_trans/trans_arith.c.inc
@@ -72,7 +72,7 @@ static bool gen_pc(DisasContext *ctx, arg_r_i *a,
                    target_ulong (*func)(target_ulong, int))
 {
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
-    target_ulong addr = func(ctx->base.pc_next, a->imm);
+    target_ulong addr = make_address_pc(ctx, func(ctx->base.pc_next, a->imm));
 
     tcg_gen_movi_tl(dest, addr);
     gen_set_gpr(a->rd, dest, EXT_NONE);
diff --git a/target/loongarch/insn_trans/trans_branch.c.inc b/target/loongarch/insn_trans/trans_branch.c.inc
index 3ad34bcc05..2e35572cea 100644
--- a/target/loongarch/insn_trans/trans_branch.c.inc
+++ b/target/loongarch/insn_trans/trans_branch.c.inc
@@ -12,7 +12,7 @@ static bool trans_b(DisasContext *ctx, arg_b *a)
 
 static bool trans_bl(DisasContext *ctx, arg_bl *a)
 {
-    tcg_gen_movi_tl(cpu_gpr[1], ctx->base.pc_next + 4);
+    tcg_gen_movi_tl(cpu_gpr[1], make_address_pc(ctx, ctx->base.pc_next + 4));
     gen_goto_tb(ctx, 0, ctx->base.pc_next + a->offs);
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
@@ -25,7 +25,7 @@ static bool trans_jirl(DisasContext *ctx, arg_jirl *a)
 
     TCGv addr = make_address_i(ctx, src1, a->imm);
     tcg_gen_mov_tl(cpu_pc, addr);
-    tcg_gen_movi_tl(dest, ctx->base.pc_next + 4);
+    tcg_gen_movi_tl(dest, make_address_pc(ctx, ctx->base.pc_next + 4));
     gen_set_gpr(a->rd, dest, EXT_NONE);
     tcg_gen_lookup_and_goto_ptr();
     ctx->base.is_jmp = DISAS_NORETURN;
-- 
2.41.0


