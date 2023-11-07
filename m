Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFCD7E3351
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:54:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9R-0008R4-M5; Mon, 06 Nov 2023 21:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9O-0008Px-M4
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:10 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9N-0005wD-6S
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:10 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5aa481d53e5so3493134a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325348; x=1699930148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s0FKOVu2Ee6DzcvywhcOLuTknlnZxj3uQnWlPfBTRpM=;
 b=F3qk9MDBWiSLhGogYwZbW8/9VAAYs6ZyNRzuqXuOxsqN+IKGfUST2rqiyp+jjNb5Hc
 MHzkXtPzHIhSD+LKsYFVDCRdHhDpTZxqNef3yDBtbpIbyOUVPinPhTOh1jTvfye3a41O
 gMU5QPjwoUC6BTwLvi5fe+b8uEuHdbTv9qNUgB0FkRaEuXgp+X7N1LXMBLYX8byCRfEH
 Jwp5lFhez+cy0FWaMLhIShrmXy7bh98a032zIRGH7TuW/wJFZVRkttjyorc6vRkX2mVJ
 cGdDLvTF3MyEjs3rqaV/X9xV/w7GaZ8+gdju3YPP/fVkPyjitae0I2TMLU7m6Yhxz89I
 RYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325348; x=1699930148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s0FKOVu2Ee6DzcvywhcOLuTknlnZxj3uQnWlPfBTRpM=;
 b=WLymSZPwV5bPx/SguGFwCIddHsP/YAVzXoFYLxxJazpDmHsiHzKeKYz843+7sa0t39
 rvMgcfvWKmU3K+RRq7A5jPWwlydFDeYfhYjQcQB5dvTAEUcWqlR7EOBjglv6nxPSr2PF
 LytdbtSdAFgoMKMosu/Cx1mNZjXmFXE8w14prqdDYs73yTS+0RlGu670yUWAGr5ROs/A
 OaHXIUxkJ1yipyrEkjbsE1wEG6JhVSaG0+C85k+LJNpQdPMXxzpMUFkYvQHQ9b1iQdfv
 7ap5SBSht6hvlmR93JlA2Jh0NkQnjeq32un2goHc2UDVDe2o8ushoIQEjh9C5lzN74mf
 jKKg==
X-Gm-Message-State: AOJu0YyXiU9isym6YFX5cSFJTCpXe/mzqJ4veHKEDfWm/wMSAhxTUK3e
 gLGU89nnQVUyBlYTtCWAThxObQjp7mzjM6dGCtE=
X-Google-Smtp-Source: AGHT+IGYPGlOW0608BMVebjVjUyPRJXbrZBVq+98Ra/ROD7r4ExQ0bgig97y8m6PcsthjExDsUFPYA==
X-Received: by 2002:a05:6a20:431c:b0:181:9b65:b4b5 with SMTP id
 h28-20020a056a20431c00b001819b65b4b5mr12031555pzk.3.1699325347936; 
 Mon, 06 Nov 2023 18:49:07 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:49:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PATCH 30/35] tcg: Eliminate duplicate env store operations
Date: Mon,  6 Nov 2023 18:48:37 -0800
Message-Id: <20231107024842.7650-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Notice when a constant is stored to the same location twice.

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b32ef0be0f..a4fe9ee9bb 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2269,6 +2269,19 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
     src = arg_temp(op->args[0]);
     ofs = op->args[2];
     type = ctx->type;
+
+    /*
+     * Eliminate duplicate stores of a constant.
+     * This happens frequently when the target ISA zero-extends.
+     */
+    if (ts_is_const(src)) {
+        TCGTemp *prev = find_mem_copy_for(ctx, type, ofs);
+        if (src == prev) {
+            tcg_op_remove(ctx->tcg, op);
+            return true;
+        }
+    }
+
     last = ofs + tcg_type_size(type) - 1;
     remove_mem_copy_in(ctx, ofs, last);
     record_mem_copy(ctx, type, src, ofs, last);
-- 
2.34.1


