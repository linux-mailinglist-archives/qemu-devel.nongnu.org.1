Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F80C82E28E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:27:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVOz-0000Z4-H4; Mon, 15 Jan 2024 17:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVOx-0000YC-Bt
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:25:51 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rPVOv-00063k-R6
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:25:51 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6d9bbf71bc8so4584635b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705357547; x=1705962347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qF5+PX0nZWOHyWfrTo8zcaVTywr+EXD7qxo9/Mep7fY=;
 b=B+++nKOj+18qjxALVlb0SvJRkz54l8ee+8mvbCOCw/0mCR7pns7R2eA7gMB/oa+vxi
 +RfhxlGaeHn+yofvHoR77qg4qHeaaW5rqJvo9puh69IS1WZqmAzWZvxMfBvRILFIp+yE
 Ge0eB0KIZqrnP6/i+PLhEKSYoJ6rCeqPmSQzKTFdS08EZ+1fQxgvM+1OMYYlccOgKpv7
 TB2v9+TTCvAPdujzIawIh2X3TWI6UEwbD9gML2vwaecKz+j4PYekizMQifHMahRIY5+/
 0tafatip3jz3L4YryzWeajABSUPPesDrQIPd96cFdArUDGq7/XSRgj2Pp0n7aVEOlWfH
 E89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705357547; x=1705962347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qF5+PX0nZWOHyWfrTo8zcaVTywr+EXD7qxo9/Mep7fY=;
 b=LMETQg+TdembK506Li6Q1sgHFBjb4oN8ZQuIHecnC+/eoYBn0ymxx7xddWoZUfzOly
 SzYP4vDwAJegNgtjOmxfuYh83N4xgRs3+WhH5omkMmsrQovkgNgKWFcF3FIBYb5KsAyj
 SsJkiYL7fXgczmZ/zZkU483+DyxRy2mqPhRNCDYvYpfCCey2mMXYUHmjRdi8Z0qHVbXD
 ykC6VxaPjUxnsDMOHPUXeKgz/3NKvnUgmgtASl+YeE0TMSX2DLcn2pfrEpmAnoC2RUd6
 lTyU20M4mLMV+K4I//YKflKEE6d1vJ8ACTmJSTlIMXWAALTz3dI4ZnMLocGQ22yx99VH
 YYFg==
X-Gm-Message-State: AOJu0Yzo5mMbm0X0xXKRqbA9yqmeOSt0uiRlML3bjaSimcklx0qZXeyr
 ZxIVLNyV6wJ316/p2gL5/ab13QTJsRNZzVAbKiUYAV0uu9l1qw==
X-Google-Smtp-Source: AGHT+IGErSJHA9TQ3bzhyNHyWRWP5ngid3reGeNgPC5m9tQtux8OQQQNDlGS2kjKiGwBWvkNoqGIEQ==
X-Received: by 2002:a05:6a00:3d44:b0:6da:63a5:3f32 with SMTP id
 lp4-20020a056a003d4400b006da63a53f32mr3929074pfb.66.1705357547630; 
 Mon, 15 Jan 2024 14:25:47 -0800 (PST)
Received: from grind.. ([152.234.123.64]) by smtp.gmail.com with ESMTPSA id
 ks19-20020a056a004b9300b006d977f70cd5sm8125940pfb.23.2024.01.15.14.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 14:25:47 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 04/12] target/riscv/insn_trans/trans_rvbf16.c.inc: use
 cpu->cfg.vlenb
Date: Mon, 15 Jan 2024 19:25:20 -0300
Message-ID: <20240115222528.257342-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115222528.257342-1-dbarboza@ventanamicro.com>
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42b.google.com
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

Use ctx->cfg_ptr->vlenb instead of ctx->cfg_ptr->vlen / 8.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvbf16.c.inc | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 4e39c00884..8ee99df3f3 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -83,8 +83,8 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
         data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
         tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
                            vreg_ofs(ctx, a->rs2), tcg_env,
-                           ctx->cfg_ptr->vlen / 8,
-                           ctx->cfg_ptr->vlen / 8, data,
+                           ctx->cfg_ptr->vlenb,
+                           ctx->cfg_ptr->vlenb, data,
                            gen_helper_vfncvtbf16_f_f_w);
         mark_vs_dirty(ctx);
         gen_set_label(over);
@@ -112,8 +112,8 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
         data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
         tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
                            vreg_ofs(ctx, a->rs2), tcg_env,
-                           ctx->cfg_ptr->vlen / 8,
-                           ctx->cfg_ptr->vlen / 8, data,
+                           ctx->cfg_ptr->vlenb,
+                           ctx->cfg_ptr->vlenb, data,
                            gen_helper_vfwcvtbf16_f_f_v);
         mark_vs_dirty(ctx);
         gen_set_label(over);
@@ -143,8 +143,8 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
         tcg_gen_gvec_4_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
                            vreg_ofs(ctx, a->rs1),
                            vreg_ofs(ctx, a->rs2), tcg_env,
-                           ctx->cfg_ptr->vlen / 8,
-                           ctx->cfg_ptr->vlen / 8, data,
+                           ctx->cfg_ptr->vlenb,
+                           ctx->cfg_ptr->vlenb, data,
                            gen_helper_vfwmaccbf16_vv);
         mark_vs_dirty(ctx);
         gen_set_label(over);
-- 
2.43.0


