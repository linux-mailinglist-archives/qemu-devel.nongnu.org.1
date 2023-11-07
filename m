Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBFC7E333F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:51:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9I-0008KX-NE; Mon, 06 Nov 2023 21:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9F-0008JU-P7
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:01 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9D-0005sc-SH
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:01 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5b980391d70so3931710a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325338; x=1699930138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DlhphZRnGb1iIQOEtk7AVLi5uVwg8AB9d1n3Ic46tJk=;
 b=jO3ba2Qnxy0dll63+Bohr2n7klyTSDz6d6skvLf0Uql2hwezj/R0xAS1pZe5zu1IOA
 YjiF3gDZbuuyvfiR3IKU9MmjJTwIYZf5hTvnUPvdvi9h5P6sRo2L+laMt/HEZK3quWKt
 PTQPO3NG00puZCMUICAKtxayTlV+FNQ5zrECFzVr8yuSyvMKZMGJUmwvFoEPV3hfMUsc
 iofHKjJq9ZVcXHii8C8C4U1mDGZDgEtK/YztAoIvSBRmRcrZupfleVsPOZ6Q+tiFKiuU
 iFU/vEUtmYkLzJOFfF6NZO8caSJo0naKiRhmEebHVf3l27uNnph3+7/ebpWWjrI5aRnj
 wGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325338; x=1699930138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DlhphZRnGb1iIQOEtk7AVLi5uVwg8AB9d1n3Ic46tJk=;
 b=V6G5BEzIL0/L7UUIYTJfU8iwei6nRb/OQkwAATbtFHJYnIz4FfmZ/Q18CIX7g71yVW
 PhzGg1fpdStHFmeCEDOqAKMC202bC9i1s7wYtrLIB4k4ycEfGhB7g2tM2tfrqsGTQpUn
 CpPw1I7MYiEV3zPbcbvxcDTLvFzSFJU5oxfNseo7kIiyl1QNTW238/oXAWCczJwjS80q
 q0RqjTAI9xk6Dn77jAz/X5zuLgycIJ6TBvfFf7OsxYxukrdH55LCA53Jucm8u2uqBGpz
 AlQdZOwIqNOnUpyG17g3beUYbG2aknTDMMLn7tlZ3yfNn6vBFQygqYTdHM0/7fcBPQM7
 Zwyw==
X-Gm-Message-State: AOJu0Yz3fv19lzB3Nn2rJ6Wtc93DJChz6iOjp5AfKLJZWRxaoVaJvLJL
 X54KcVFEqSLBdahB27eF5B3TEfG188PQb7Fv6AY=
X-Google-Smtp-Source: AGHT+IHlH6Oh0ljb8zENOygv/+fpv553tT3Rj8f6MsZfINixO9yf8cziiOeEaf9AswYaktk7raMymw==
X-Received: by 2002:a05:6a20:8e2a:b0:132:ff57:7fab with SMTP id
 y42-20020a056a208e2a00b00132ff577fabmr38361195pzj.2.1699325338512; 
 Mon, 06 Nov 2023 18:48:58 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/35] tcg: Move tcg_temp_free_* out of line
Date: Mon,  6 Nov 2023 18:48:26 -0800
Message-Id: <20231107024842.7650-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231029210848.78234-12-richard.henderson@linaro.org>
---
 include/tcg/tcg-temp-internal.h | 29 +++++------------------------
 tcg/tcg.c                       | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-temp-internal.h b/include/tcg/tcg-temp-internal.h
index 2d45cc45d2..44192c55a9 100644
--- a/include/tcg/tcg-temp-internal.h
+++ b/include/tcg/tcg-temp-internal.h
@@ -31,30 +31,11 @@
 
 void tcg_temp_free_internal(TCGTemp *);
 
-static inline void tcg_temp_free_i32(TCGv_i32 arg)
-{
-    tcg_temp_free_internal(tcgv_i32_temp(arg));
-}
-
-static inline void tcg_temp_free_i64(TCGv_i64 arg)
-{
-    tcg_temp_free_internal(tcgv_i64_temp(arg));
-}
-
-static inline void tcg_temp_free_i128(TCGv_i128 arg)
-{
-    tcg_temp_free_internal(tcgv_i128_temp(arg));
-}
-
-static inline void tcg_temp_free_ptr(TCGv_ptr arg)
-{
-    tcg_temp_free_internal(tcgv_ptr_temp(arg));
-}
-
-static inline void tcg_temp_free_vec(TCGv_vec arg)
-{
-    tcg_temp_free_internal(tcgv_vec_temp(arg));
-}
+void tcg_temp_free_i32(TCGv_i32 arg);
+void tcg_temp_free_i64(TCGv_i64 arg);
+void tcg_temp_free_i128(TCGv_i128 arg);
+void tcg_temp_free_ptr(TCGv_ptr arg);
+void tcg_temp_free_vec(TCGv_vec arg);
 
 TCGv_i32 tcg_temp_ebb_new_i32(void);
 TCGv_i64 tcg_temp_ebb_new_i64(void);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ec358ce5c0..258bd1c10b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1809,6 +1809,31 @@ void tcg_temp_free_internal(TCGTemp *ts)
     }
 }
 
+void tcg_temp_free_i32(TCGv_i32 arg)
+{
+    tcg_temp_free_internal(tcgv_i32_temp(arg));
+}
+
+void tcg_temp_free_i64(TCGv_i64 arg)
+{
+    tcg_temp_free_internal(tcgv_i64_temp(arg));
+}
+
+void tcg_temp_free_i128(TCGv_i128 arg)
+{
+    tcg_temp_free_internal(tcgv_i128_temp(arg));
+}
+
+void tcg_temp_free_ptr(TCGv_ptr arg)
+{
+    tcg_temp_free_internal(tcgv_ptr_temp(arg));
+}
+
+void tcg_temp_free_vec(TCGv_vec arg)
+{
+    tcg_temp_free_internal(tcgv_vec_temp(arg));
+}
+
 TCGTemp *tcg_constant_internal(TCGType type, int64_t val)
 {
     TCGContext *s = tcg_ctx;
-- 
2.34.1


