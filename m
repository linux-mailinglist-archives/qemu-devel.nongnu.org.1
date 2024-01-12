Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6C682C6CD
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 22:39:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPF1-0004TO-Sq; Fri, 12 Jan 2024 16:39:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOPEz-0004P8-DU
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:39:01 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOPEx-0001z0-O1
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:39:01 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d4ca2fd2fbso40909565ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 13:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705095537; x=1705700337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYEDx5DjFeo8N7odKjdkQR8QLaY46yyZIFXqnXBj1FQ=;
 b=W/yCtjAp+myYYwM0SzVpDoJXllUYv1YuWFJQ32dyzUfthaIX+xyxYC8S1FjeBwNL5L
 wklrezwAF77FCTEKqLbtmw72H9qir+9If+QzdUx9Y5NMX7fCNKtFPdshJ3K6ddBr4rkL
 uQOhsZUWx0WhcFZz5hNTuKMA+3Em54wFTykVknojNRMQheRMvZUkpTSUer49JlR8gO1P
 kMhRwLlfb+wSAMEPgMm4iLTLMo08lsd6TOkESAi7MiW0rN7MmbCOI/1Iu2xya902I4mb
 Ac4vQpaQ9gDY1vktQABB7DxpQ2Q0b0Qqb8OU8pR7QdNYecjf4Vlf5uPAWN2wmGBRLIpG
 YrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095537; x=1705700337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYEDx5DjFeo8N7odKjdkQR8QLaY46yyZIFXqnXBj1FQ=;
 b=kWzYYLuCGBbvtshCT9DC6BiUwwX3HJv1fuYszqrLlbQ4ZXTeviZlomVUX1dhRGRnJG
 3IUxyi6o55smI1BwqLhjUdojBC44FkE3l4pq/fKJh5J/6a9UWacjNikvRRDMSzHtP372
 9ASt6YIkTGfvPwELTe3SF13OrKKa+vb2QrXXywgz2KyiEaAotjL+rW92w2DWdnl7hhpy
 TPTw0GismqprFuksvfnokIHp3jfxmmhW6iQl/djrVFNjbUjlO3z2odi5/DdvyOBaDZLB
 t3q+xdnKlMUSEN5hhEUKkaG4+Qp/IkMwOSpL+20VAK7iyjzXXWdqqdsZ58DzRlcjGdQ9
 dG1g==
X-Gm-Message-State: AOJu0YxthKn5EsijUylXCpYvsUbpr1BvOYBcRAcrvLR07o2BwyFtxo4z
 lrG8vJiYQSGNAnDx7BrtLilEXO7oPON2jLD5Ch2e0b2FLBxo0A==
X-Google-Smtp-Source: AGHT+IEn5J3a2gi50iml0y76dFtIAWhM+8V7ZIvp0J+usC0RFNWZAq/MD2dKGsdEWjy8zfbpg5g9GA==
X-Received: by 2002:a17:902:f551:b0:1d4:bba1:bc61 with SMTP id
 h17-20020a170902f55100b001d4bba1bc61mr1679692plf.119.1705095537672; 
 Fri, 12 Jan 2024 13:38:57 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 lf8-20020a170902fb4800b001d5b2967d00sm364727plb.290.2024.01.12.13.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:38:57 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 12/13] trans_rvv.c.inc: use cpu_vl in trans_vrgather_vi()
Date: Fri, 12 Jan 2024 18:38:11 -0300
Message-ID: <20240112213812.173521-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112213812.173521-1-dbarboza@ventanamicro.com>
References: <20240112213812.173521-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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

There's no need to calculate 'vlmax'. We're garanteeing that 'vl_eq_vlmax'
is true, and we can retrieve 'vl' via 'cpu_vl'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 29 ++++++++++++++++---------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 3782d0fa2f..43d20ae354 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3575,16 +3575,25 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
     }
 
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
-        int scale = s->lmul - (s->sew + 3);
-        int vlmax = s->cfg_ptr->vlen >> -scale;
-        if (a->rs1 >= vlmax) {
-            tcg_gen_gvec_dup_imm(MO_64, vreg_ofs(s, a->rd),
-                                 MAXSZ(s), MAXSZ(s), 0);
-        } else {
-            tcg_gen_gvec_dup_mem(s->sew, vreg_ofs(s, a->rd),
-                                 endian_ofs(s, a->rs2, a->rs1),
-                                 MAXSZ(s), MAXSZ(s));
-        }
+        TCGLabel *dup_imm = gen_new_label();
+        TCGLabel *done = gen_new_label();
+        TCGv_i32 vlmax = tcg_temp_new_i32();
+
+        /* a->rs1 >= vlmax, cpu_vl = vlmax */
+        tcg_gen_trunc_tl_i32(vlmax, cpu_vl);
+        tcg_gen_brcond_i32(TCG_COND_GEU, tcg_constant_i32(a->rs1), vlmax,
+                           dup_imm);
+        tcg_gen_gvec_dup_mem(s->sew, vreg_ofs(s, a->rd),
+                             endian_ofs(s, a->rs2, a->rs1),
+                             MAXSZ(s), MAXSZ(s));
+        tcg_gen_br(done);
+
+        gen_set_label(dup_imm);
+        tcg_gen_gvec_dup_imm(MO_64, vreg_ofs(s, a->rd),
+                             MAXSZ(s), MAXSZ(s), 0);
+
+        gen_set_label(done);
+
         mark_vs_dirty(s);
     } else {
         static gen_helper_opivx * const fns[4] = {
-- 
2.43.0


