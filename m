Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3FA783AB0
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:16:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLbR-0001GK-6j; Tue, 22 Aug 2023 03:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLbO-0001Dg-6Z
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:14:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLbL-0002wi-QE
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:14:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fef34c33d6so13457755e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688494; x=1693293294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ac7pv2kpb0ajeFGbtJ3onoCTyP2ZNqDH1hhRLbCbPbE=;
 b=t7hWtp1XXtA92hEauBLXvL4NRLQtopFBPefeCNXAmepOE4/nZ4nHlSipRrBuhQ/3cu
 jkySjBR3gOweCCw+oxLQhuWQy8JB6szAmII9I91+DseISbmTquTFPA4GItcQo7z+r/Of
 ib2ndPoDlN87CvpavmvBVIHRqBw0n8HVPFATt/0qBdTFJJkTgKsonyCU+fffTmcemKVy
 yBPeflCb2GNKEtnVKuzsh60L6zORQK9CE54KdVh5vLyWsVssd2wLx7veNaeQL2/C/V7D
 qf5c2meGSllAzJFrV/BtlhS3j0dpzSEv2svztPmaz7dv3d3ZbadLnBphNhtEeNcDEjOs
 vc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688494; x=1693293294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ac7pv2kpb0ajeFGbtJ3onoCTyP2ZNqDH1hhRLbCbPbE=;
 b=PPLUAS6ova86Aww9rHmNA8wLZeDrMKwgs4E8+8PB9Me1nsgdMBBY9hTvYwECiwtoGe
 nrBSwkW3UejMn0MkHf3TG/mUnuAvFUjpAyNhFqUkUkhbXlrmFVmIJDVEY08UVtkoFuCX
 wwOWUaHn7LqDlG1bcuPqAVDsFNxj0zDhvlpAXeVnj+Nz70yU4QtmVcxQZGvRs88bZ3aG
 Z54asr1Y/8jsjGntXFqYzqrV5mWesrGjSFMzV4cns0sEuACdfA0S1SlBoHabYHaUlQtb
 jGzOaywGjicA/tnJUYFqOmLL6mwPFn2WjSEGe7WURaSayOjgYk7oocdx8Hz++1eeHniV
 7xBA==
X-Gm-Message-State: AOJu0YxMa360lKgPG0dBjCmyevwLXmivsGuU+jjjeEgEbZzj4zAUCN/m
 wVOxCUT6VC4acx7QlJLfaTZa0YpS9AONzGHgw/UZrA==
X-Google-Smtp-Source: AGHT+IEtSkEv+Go9/eD/LdLQkuOnttC6r3S510KRzEZynkgTY1PfFZtmikmtyZIhqCgyZhq8czFw+g==
X-Received: by 2002:a05:600c:210b:b0:3fe:ef5b:bb6 with SMTP id
 u11-20020a05600c210b00b003feef5b0bb6mr4233930wml.35.1692688492733; 
 Tue, 22 Aug 2023 00:14:52 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 a19-20020a05600c225300b003fee83ae4a3sm9452540wmm.9.2023.08.22.00.14.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:14:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RESEND v5 07/19] target/loongarch: Extract make_address_pc()
 helper
Date: Tue, 22 Aug 2023 09:13:53 +0200
Message-ID: <20230822071405.35386-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071405.35386-1-philmd@linaro.org>
References: <20230822071405.35386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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


