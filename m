Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA9D7E334D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:54:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C96-0008Am-2F; Mon, 06 Nov 2023 21:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C93-00089t-US
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:49 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C91-0005pd-Mk
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:49 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b56b618217so3120931b6e.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325326; x=1699930126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dtF56/6br6ds70EvBJRTzpGkNHFFQW2fY4AZd7lgvlY=;
 b=qRvYeS7gpXNraJJbJp8/8J8ivQMUIH0Yn+wiwnaD4zBXT7fR+fo4EfQO6J4hcSi5MA
 9xuEcViZ3oghHkMtm9hTUA4uSdyfzzWb5luWPBgWEK6R3jhmaAM1bE29sMjxGmthaTOr
 z7PKUnAAtWuCDgH/FsdQLllMnW6QU9D2IuMUTeWW9TPoeETt5ijQadanupXuLw85eq7D
 GlkCEGjtha6eykUfWsMQmgzExt9Ra7tQ+8ZKPShReqa0BuEzKFde97pp3IrrW4IMQ97T
 zFAGlCcsOBCZUXqYw/OJ/BT+oanInMEox2wjrynel6d+Guu5glcWsc+gMo3NXuQzaVox
 UnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325326; x=1699930126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dtF56/6br6ds70EvBJRTzpGkNHFFQW2fY4AZd7lgvlY=;
 b=H8LIFkgDth6Sn1yFVmilm06NtAyHZ3hLVPaI7OV4QSVgDn4TemP9CYL8sNq+9832AM
 5PCFgev2fzxIXhPQopD/nJRUWuM25wqSMYU7Eilb7b9DI0ZfPnoXiBcpo+PB10vnvvX3
 q+HK3ENCtMjNdg/pCB6N8SZeaayiAp7rF2NhW+uDhdj0LaErfLLqtpaD3xKGPM2pc8gF
 Qn1vbWz509rnzz1UODzqdoVHdNmYnAEK5EszeI/f76D3rK3SmcUMh6Kp05R7NdQryoWD
 mjWwE+xnaOIXT8thSZtw/tiDygkTKfxLb6AUirt4eQxcYQXeViGXl51GxVkbRP9U6SUC
 ytQg==
X-Gm-Message-State: AOJu0YzGXsqgv1e01a13hulgFMlddowhmzyERK18miJ15vw5ePq1ljIA
 EUnOM1N1ao754Vw9YlI55wlVyjHwk+90VsEjAY4=
X-Google-Smtp-Source: AGHT+IEledB9uo8//j6HRBja1GeKb7iZ3feDbf7uQ6ilV5FlUCVuWUoEEkr4MBJwuMjH/zdjX80Grg==
X-Received: by 2002:a05:6808:f8e:b0:3af:8050:369f with SMTP id
 o14-20020a0568080f8e00b003af8050369fmr36764637oiw.6.1699325326453; 
 Mon, 06 Nov 2023 18:48:46 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PATCH 03/35] tcg/loongarch64: Use C_N2_I1 for
 INDEX_op_qemu_ld_a*_i128
Date: Mon,  6 Nov 2023 18:48:10 -0800
Message-Id: <20231107024842.7650-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

Use new registers for the output, so that we never overlap
the input address, which could happen for user-only.
This avoids a "tmp = addr + 0" in that case.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiajie Chen <c@jia.je>
Message-Id: <20230916220151.526140-3-richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-con-set.h |  2 +-
 tcg/loongarch64/tcg-target.c.inc     | 17 +++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index 77d62e38e7..cae6c2aad6 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -38,4 +38,4 @@ C_O1_I2(w, w, wM)
 C_O1_I2(w, w, wA)
 C_O1_I3(w, w, w, w)
 C_O1_I4(r, rZ, rJ, rZ, rZ)
-C_O2_I1(r, r, r)
+C_N2_I1(r, r, r)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index ccf133db4b..a1a387df31 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1103,13 +1103,18 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg data_lo, TCGReg data_hi
         }
     } else {
         /* Otherwise use a pair of LD/ST. */
-        tcg_out_opc_add_d(s, TCG_REG_TMP0, h.base, h.index);
+        TCGReg base = h.base;
+        if (h.index != TCG_REG_ZERO) {
+            base = TCG_REG_TMP0;
+            tcg_out_opc_add_d(s, base, h.base, h.index);
+        }
         if (is_ld) {
-            tcg_out_opc_ld_d(s, data_lo, TCG_REG_TMP0, 0);
-            tcg_out_opc_ld_d(s, data_hi, TCG_REG_TMP0, 8);
+            tcg_debug_assert(base != data_lo);
+            tcg_out_opc_ld_d(s, data_lo, base, 0);
+            tcg_out_opc_ld_d(s, data_hi, base, 8);
         } else {
-            tcg_out_opc_st_d(s, data_lo, TCG_REG_TMP0, 0);
-            tcg_out_opc_st_d(s, data_hi, TCG_REG_TMP0, 8);
+            tcg_out_opc_st_d(s, data_lo, base, 0);
+            tcg_out_opc_st_d(s, data_hi, base, 8);
         }
     }
 
@@ -2049,7 +2054,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_qemu_ld_a32_i128:
     case INDEX_op_qemu_ld_a64_i128:
-        return C_O2_I1(r, r, r);
+        return C_N2_I1(r, r, r);
 
     case INDEX_op_qemu_st_a32_i128:
     case INDEX_op_qemu_st_a64_i128:
-- 
2.34.1


