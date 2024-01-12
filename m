Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CAA82C6DA
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 22:40:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPEz-0004Of-VF; Fri, 12 Jan 2024 16:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOPEw-0004Dn-Cb
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:38:58 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOPEu-0001ud-M9
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:38:58 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d3e6c86868so58274465ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 13:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705095534; x=1705700334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wA2wpvlTemx9xa4Wy4Iybz0qngA+6AVoY+2orIrGk6Q=;
 b=jtFt+lk59pSWBd+D5u3lltUYaC3Vz1K/ehy2Z4reyoZ46VwjH/wSl2srdppfgd6VPh
 3H0BzfuduJyPLSKE1T1xidwyAto+QvsqKAcwelaJtYsIY9lX1nUre5PDtPmM+8j0YjDx
 GcWFiWlsLfb2388iiIzIdjAezkUSsF+epaIYl8B4JCOD09tM4hNUoce35RHxDMQrAYIL
 7RYt3p5m+dmPUHad/uSroxXOTgavrL8w2n10j3dXlU+lq8ocjPYSmfksf+a88Bve229o
 ZH5MUdYluevBZQEnlKnZunhHYwf1UzId6ReZ28PA0Q4zq8thkniz3CMqg3/LXDG9L53p
 Nadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095534; x=1705700334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wA2wpvlTemx9xa4Wy4Iybz0qngA+6AVoY+2orIrGk6Q=;
 b=vR+tMivylGsl3VRuvF/JSPC5r4mAui1hiH9N4Q4Z9tcuDLd48EB+vrP0PZeC6b7/er
 0yC907qzQE7gWpmqNyjcc0YcXgJnaB9rzKpPpLFzQ3NAZYuZGWIHxts2yslrn2NFTMhP
 yKg1AqUj8nfQrnuGli1SzobWQm5gjFE8CTjq5ao6uLEasXQNTNxMcjVyqMhjU7naPyr+
 3AzmjVcYEch3bm3e/EIx8HlaxZQlaJx0cwSuvi3pvxtgREdbDouU/WXF75vONHBG1z13
 R2O+kgivSatFQO+GRfHuZW0avU+lH5aOT0qQoMhaieez0o02jLTFNkub1MgqFjPCterp
 e1+g==
X-Gm-Message-State: AOJu0YwYMrRiNfe7fvYP26SKk+PSxo8+kPXl87h92Azb9ev9UFZ/DNL+
 Rk2f41i9LM8Y7kBGOllQoLcoo2lm9aJezShZluuI/ikQGf8Nrw==
X-Google-Smtp-Source: AGHT+IHKvvUVn3EqVNUQssaSYpaaTCg3hM7akSpu5hmpCH4Ko0GpKwuuHhfXzzUjd3fazx86j6wnJA==
X-Received: by 2002:a17:902:9f8e:b0:1d4:1199:1cbb with SMTP id
 g14-20020a1709029f8e00b001d411991cbbmr1778206plq.98.1705095534466; 
 Fri, 12 Jan 2024 13:38:54 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 lf8-20020a170902fb4800b001d5b2967d00sm364727plb.290.2024.01.12.13.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:38:54 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 11/13] trans_rvv.c.inc: remove vlmax arg from
 vec_element_loadx()
Date: Fri, 12 Jan 2024 18:38:10 -0300
Message-ID: <20240112213812.173521-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112213812.173521-1-dbarboza@ventanamicro.com>
References: <20240112213812.173521-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 26 +++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 804cfd6c7f..3782d0fa2f 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3265,21 +3265,28 @@ static void endian_adjust(TCGv_i32 ofs, int sew)
 #endif
 }
 
-/* Load idx >= VLMAX ? 0 : vreg[idx] */
+/*
+ * Load idx >= VLMAX ? 0 : vreg[idx]
+ *
+ * This function assumes ctx->vl_eq_vlmax = true.
+ */
 static void vec_element_loadx(DisasContext *s, TCGv_i64 dest,
-                              int vreg, TCGv idx, int vlmax)
+                              int vreg, TCGv idx)
 {
     TCGv_i32 ofs = tcg_temp_new_i32();
+    TCGv_i32 vlmax = tcg_temp_new_i32();
     TCGv_ptr base = tcg_temp_new_ptr();
     TCGv_i64 t_idx = tcg_temp_new_i64();
-    TCGv_i64 t_vlmax, t_zero;
+    TCGv_i64 t_zero, t_vlmax = tcg_temp_new_i64();
 
     /*
      * Mask the index to the length so that we do
      * not produce an out-of-range load.
      */
+    tcg_gen_trunc_tl_i32(vlmax, cpu_vl);
+    tcg_gen_sub_i32(vlmax, vlmax, tcg_constant_i32(1));
     tcg_gen_trunc_tl_i32(ofs, idx);
-    tcg_gen_andi_i32(ofs, ofs, vlmax - 1);
+    tcg_gen_and_i32(ofs, ofs, vlmax);
 
     /* Convert the index to an offset. */
     endian_adjust(ofs, s->sew);
@@ -3294,10 +3301,15 @@ static void vec_element_loadx(DisasContext *s, TCGv_i64 dest,
                  vreg_ofs(s, vreg), s->sew, false);
 
     /* Flush out-of-range indexing to zero.  */
-    t_vlmax = tcg_constant_i64(vlmax);
     t_zero = tcg_constant_i64(0);
     tcg_gen_extu_tl_i64(t_idx, idx);
 
+#ifdef TARGET_RISCV64
+    tcg_gen_mov_i64(t_vlmax, cpu_vl);
+#else
+    tcg_gen_extu_tl_i64(t_vlmax, cpu_vl);
+#endif
+
     tcg_gen_movcond_i64(TCG_COND_LTU, dest, t_idx,
                         t_vlmax, dest, t_zero);
 }
@@ -3534,14 +3546,12 @@ static bool trans_vrgather_vx(DisasContext *s, arg_rmrr *a)
     }
 
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
-        int scale = s->lmul - (s->sew + 3);
-        int vlmax = s->cfg_ptr->vlen >> -scale;
         TCGv_i64 dest = tcg_temp_new_i64();
 
         if (a->rs1 == 0) {
             vec_element_loadi(s, dest, a->rs2, 0, false);
         } else {
-            vec_element_loadx(s, dest, a->rs2, cpu_gpr[a->rs1], vlmax);
+            vec_element_loadx(s, dest, a->rs2, cpu_gpr[a->rs1]);
         }
 
         tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
-- 
2.43.0


