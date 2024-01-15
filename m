Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DA082E295
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:27:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVPL-0000qu-GL; Mon, 15 Jan 2024 17:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVPK-0000qQ-1a
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:26:14 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVPI-00068O-Hj
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:26:13 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6dddba43d70so4525261a34.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705357570; x=1705962370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3zwnL2bepqEdgfhLqXrSi6UxcmFJJl1qTGSWX8FZUg=;
 b=KIQo/qqvwsoT3h8GBiUZv/IMcygDTapZbsbnhDIzBHP7KXWL0N7c/4kKHLrNabRKhJ
 HLw4u163Ms4bnw68n9/LpbmLYnHZn68oLE7Y0QY+3jQMzJVdKxHh7d4V4QwXpuzviuT7
 GUyEhWCURmO2O6FogS43qlO5LuYifoilmKx+TXu2t3m3KG+XZsB4FAhr72KUSxsR2Nxd
 W32nvs2gmsk8VLJfhrLe8/5mm+RwjI8TLOS0OfDmbwWAtlY68YOziXAZYUh+r6OGCyk6
 yQC13tgZDVAHMuv+yffujySDh5bJl4QQKvYmxg3BVhLiPW17csNrE/+T/l5icwsJgsph
 SSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705357570; x=1705962370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G3zwnL2bepqEdgfhLqXrSi6UxcmFJJl1qTGSWX8FZUg=;
 b=CNJ0C875Upo6uKJgYohsi6OeeBQ0364iw+lJ6OtoUEDzagxV1Y+L9wLmcYmGXwm/ch
 oa8Utkt2vEiEc3wsEn4Qeq2eaujY/VRdTS8MIuEc5sdFIiYwzvV5ehQb3WZn7irF4dxc
 uvk7G0fU1wmM2P7NPAnpDgsNj3AeWN2SNnybBF2UHO2P5lQs1ZDf/hjVvwuXmkzW3lc9
 vSeS5sBH4KqjjyU1IOh9xYVqih4o4SCdXgaONAjSqTLyBDyD//CgounmGoMsETfgYOrv
 y3A70MX+f43PMX6R0R5fhBrm/JDIJQISSqtZ72cwtRBYKX4aZes0ra8iXUaOQuTmryEy
 mqmQ==
X-Gm-Message-State: AOJu0YzYPdQAszTovR+CJl251Cfge3RoUVAnESUJZslkh/qjl+3UN/z8
 FdNfr1t3hpkWrZ3Zqbp5tH1j4IueM9tGNOk7tPManW7tPTkGwQ==
X-Google-Smtp-Source: AGHT+IFuSZSVNc2r+5PefA423niwJsKXk+7c9yBTIF0X6Zk7/9Xzc9vuk10x5kN1Mws+QT8GsPRm1g==
X-Received: by 2002:a05:6808:1306:b0:3bd:3a29:63e9 with SMTP id
 y6-20020a056808130600b003bd3a2963e9mr8293781oiv.27.1705357570733; 
 Mon, 15 Jan 2024 14:26:10 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 ks19-20020a056a004b9300b006d977f70cd5sm8125940pfb.23.2024.01.15.14.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 14:26:10 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 11/12] trans_rvv.c.inc: use 'vlenb' to calc vlmax in
 trans_vrgather_v*()
Date: Mon, 15 Jan 2024 19:25:27 -0300
Message-ID: <20240115222528.257342-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115222528.257342-1-dbarboza@ventanamicro.com>
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x331.google.com
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

Use the same vext_get_vlmax() logic to retrieve 'vlmax' in
trans_vrgather_vi() and trans_vrgather_vx().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b4663b6e1f..05c243186d 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3535,8 +3535,7 @@ static bool trans_vrgather_vx(DisasContext *s, arg_rmrr *a)
     }
 
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
-        int scale = s->lmul - (s->sew + 3);
-        int vlmax = s->cfg_ptr->vlen >> -scale;
+        int vlmax = s->cfg_ptr->vlenb >> (s->sew - s->lmul);
         TCGv_i64 dest = tcg_temp_new_i64();
 
         if (a->rs1 == 0) {
@@ -3566,8 +3565,7 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
     }
 
     if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
-        int scale = s->lmul - (s->sew + 3);
-        int vlmax = s->cfg_ptr->vlen >> -scale;
+        int vlmax = s->cfg_ptr->vlenb >> (s->sew - s->lmul);
         if (a->rs1 >= vlmax) {
             tcg_gen_gvec_dup_imm(MO_64, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), 0);
-- 
2.43.0


