Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7966D82F91B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 22:00:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPqWT-0004iA-QF; Tue, 16 Jan 2024 15:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPqWP-0004hE-ST
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:58:58 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPqWO-0007dY-2i
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:58:57 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d4a980fdedso91508185ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 12:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705438733; x=1706043533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFG7+T5THjwRhj30XewxWOhCZwYRWlfB0OO4+a0WhXg=;
 b=IoDEXwoXXXP6KX9cZSq6JKCB2u4aHaL+hsDzNJYaM7pxM/4zU/oietimB+mx2TgHPB
 TzZ9xNX/23mp7LQtfSoRTU8A9/n8e0Cf3elSXIdGR18Hw8jPjazBBRm11/3L5Q8C2qoe
 6k3wnO5EQJjuHeK/JG+F+u0yMsg8oNa2NVgnd1qD3nU17Gr+Fpd9rhB6kugv0AzKUXrZ
 y9yVa+7dYTqta9BNmkul7YwhF15kgwrMPSQ0fWjyoEsZpBtuX5A+FMZjewYkrrDz4FgM
 SrpZuNkxatm1esXroZ9Dmj76bU/02fkqgDGmqhaRJbTUQK3dtlURc6oI8cyRynQlwajU
 qlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705438733; x=1706043533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bFG7+T5THjwRhj30XewxWOhCZwYRWlfB0OO4+a0WhXg=;
 b=UTIxLuMwzrno1w5eYfNWkI2c8Qw7bJhUg6l50Lv31EG2sdqi6VPcOAdIv19TOtqF7e
 V9H3DI0nS/MNiokl1ZccwRveGBEIlbe7rUqVTUlF7f/8UZDQD5r+lFyT/USxLJN4+WJD
 +uqkMt+Tx03LFUzGiAT8mfROecXDOmdD+kuGuon4eK2f+mYvSbJlJ1xY+Z483pFJB2bo
 UsAjc/dNWU1TyWP6rUseKseTewfPQ0MFHT1dgj4zOdp3LGPVDTRspg9MHB4GrHx6s9vP
 x4a5ZXCa5mWmwgTLAYozJwmXM2cKPEd/h2ph3dPTcyGs47477gtshuqVFOtAk5mA3AbQ
 a48w==
X-Gm-Message-State: AOJu0Yw2EAMq2I0UkNidrSSQ0XNzkfIc7ScbU+UBOVMml2KDBO1y5UbA
 WPGlYxP3LLHqcAkekoCS4GcIjaWiY1hWqlS8+UF/iaV95vKsJA==
X-Google-Smtp-Source: AGHT+IFVt7OxBiVVPW+4MDAIR1F7+vRmG6MHoIUTTPiCMwb71Hsy033yePJ0S8k4zoxTyJaJE90Ksw==
X-Received: by 2002:a17:90b:19c6:b0:28c:a76e:7c36 with SMTP id
 nm6-20020a17090b19c600b0028ca76e7c36mr5532565pjb.68.1705438733352; 
 Tue, 16 Jan 2024 12:58:53 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 sh2-20020a17090b524200b0028df5c748e4sm11326949pjb.44.2024.01.16.12.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 12:58:52 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 09/13] target/riscv/insn_trans/trans_rvv.c.inc: use 'vlenb'
 in MAXSZ()
Date: Tue, 16 Jan 2024 17:58:13 -0300
Message-ID: <20240116205817.344178-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116205817.344178-1-dbarboza@ventanamicro.com>
References: <20240116205817.344178-1-dbarboza@ventanamicro.com>
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

Calculate the maximum vector size possible, 'max_sz', which is the size
in bytes 'vlenb' multiplied by the max value of LMUL (LMUL = 8, when
s->lmul = 3).

'max_sz' is then shifted right by 'scale', expressed as '3 - s->lmul',
which is clearer than doing 'scale = lmul - 3' and then using '-scale'
in the shift right.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index d743675262..b4663b6e1f 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1160,12 +1160,12 @@ GEN_LDST_WHOLE_TRANS(vs8r_v, 8, 1, true)
 /*
  * MAXSZ returns the maximum vector size can be operated in bytes,
  * which is used in GVEC IR when vl_eq_vlmax flag is set to true
- * to accerlate vector operation.
+ * to accelerate vector operation.
  */
 static inline uint32_t MAXSZ(DisasContext *s)
 {
-    int scale = s->lmul - 3;
-    return s->cfg_ptr->vlen >> -scale;
+    int max_sz = s->cfg_ptr->vlenb * 8;
+    return max_sz >> (3 - s->lmul);
 }
 
 static bool opivv_check(DisasContext *s, arg_rmrr *a)
-- 
2.43.0


