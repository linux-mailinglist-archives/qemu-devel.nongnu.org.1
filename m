Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 123837CEAEA
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:03:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESm-0001y8-9z; Wed, 18 Oct 2023 17:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESE-00015D-IR
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:50 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESA-0004OH-AP
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:49 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1c0fcbf7ae4so5076552fac.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665905; x=1698270705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3Cca9a0dUfxOMmsrbDZSCnt4BuRnsfCclCPiSMy9B8=;
 b=FVjQ2RAtxT2KrWlgEhrtiRn00QAYXOTeYlkbbVIN3yG3ng8WFSj96ZMMGaTah4QxFg
 QMZ1BrMAbIyp5aucF3Roz93ylnmrxIgAXD5GhwbjMbQug3okqnNj9tjDagXUbeOantxE
 nes0asv+XxAWQ1r6q1DgyVgoCUDVduyoqGiYenI3vB8JzF4VTxDGkVp4p+NMMgzliXit
 efZJKExF861l9kXuV1k8M8L7gCV49WW7mD+OI7DLkS+QMEAKxqYvFmuTRpQTC3O2Otfv
 7C9uVOtLDFpRcz64/8lPV2Xk//7MI8olf00yHe4q022wke98WpL/NO0ZYPVDJDWBOr+6
 z/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665905; x=1698270705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3Cca9a0dUfxOMmsrbDZSCnt4BuRnsfCclCPiSMy9B8=;
 b=T3GX8F1zQ0vnFOkU4fRdZ2a8ACmCDSCaw5hTKGYArBbzXJyZBD0zAtgGWXbicy46KG
 fkVsPWVPU+F9LkjChEgkeJOr+Vh42CmSyvDOVg5UHoJC5lzS/d5SiHLeTOogvs4xOT4k
 ur9gnZteQO3VPsPsHglAA3kFcQ2/6UjpWVB/wUocfv02MrgYddIo4ZA3xZTN/+Npyc9B
 +U6/SkUhg/zSJU8vKseKsmsLvprWUlWdPZPOjsAdXhCAAeWr7EqmYtepGmDDeIP59JZq
 ARCZ4corBOQRucwEkuWCC4jzADGYey/HRX861UVU/vNwH2NTJdbO6Ecut/8WbWb228on
 1XLQ==
X-Gm-Message-State: AOJu0YxgMAu4LBiRObfjr6ztDbd4r1mzoxDB4oouXHkd1QOMuJQAiyM9
 ySgGyTjcPkBLNI4PyHzU5Q6KqWSWTXXWpy0jgds=
X-Google-Smtp-Source: AGHT+IHEPmoPeHeiK1hyU8bwnzH2S3Fc8i9VLTYf8jnAoXPIT2l5/4IEoWTO3RFjY7lWAQXR9/Lf7g==
X-Received: by 2002:a05:6870:1094:b0:1e9:f0ef:dd8b with SMTP id
 20-20020a056870109400b001e9f0efdd8bmr609837oaq.54.1697665905146; 
 Wed, 18 Oct 2023 14:51:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 10/61] target/hppa: Fix bb_sar for hppa64
Date: Wed, 18 Oct 2023 14:50:44 -0700
Message-Id: <20231018215135.1561375-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8ebe7523a7..119422870c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3073,14 +3073,21 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
 {
     TCGv_reg tmp, tcg_r;
     DisasCond cond;
+    bool d = false;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new();
     tcg_r = load_gpr(ctx, a->r);
-    tcg_gen_shl_reg(tmp, tcg_r, cpu_sar);
+    if (cond_need_ext(ctx, d)) {
+        /* Force shift into [32,63] */
+        tcg_gen_ori_reg(tmp, cpu_sar, 32);
+        tcg_gen_shl_reg(tmp, tcg_r, tmp);
+    } else {
+        tcg_gen_shl_reg(tmp, tcg_r, cpu_sar);
+    }
 
-    cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
+    cond = cond_make_0_tmp(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -3088,12 +3095,15 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
 {
     TCGv_reg tmp, tcg_r;
     DisasCond cond;
+    bool d = false;
+    int p;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new();
     tcg_r = load_gpr(ctx, a->r);
-    tcg_gen_shli_reg(tmp, tcg_r, a->p);
+    p = a->p | (cond_need_ext(ctx, d) ? 32 : 0);
+    tcg_gen_shli_reg(tmp, tcg_r, p);
 
     cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
     return do_cbranch(ctx, a->disp, a->n, &cond);
-- 
2.34.1


