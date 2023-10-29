Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F0E7DAE72
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 22:11:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxD1v-0002iu-SJ; Sun, 29 Oct 2023 17:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1s-0002hN-4b
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:09:04 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1o-0005FE-4n
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:09:03 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b7f0170d7bso3777625b3a.2
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698613739; x=1699218539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nmyGat29OsWBS5khkJtjE1+pfomW6p5e6e6aoM/615g=;
 b=liLMC0riPnk1211gMLoOOFUwuy5qsufcNxFJOUI2PNejkEXwQiX9PJeFp1QCuRIMjT
 7WyY3H02tq+oHqsUBnEJSUkbK3ON8BQbEioyEtjVF7SQ1A0lCyTAnuEld4bh06SaDWG0
 dD28StcjRuZrG6dYkIhW09IajwPmNibxC7tJDU6OYPIun+cuJVhZBlqoA6VJaAXwRxuC
 JWyY5URyU2Dz0EIHQDu1+qpHOlGnW1SsYGU0x9Er+JG7gS86c0+PDWouFhB00+AaAvgX
 ev6Tk7RKnMo8ixwNc4+8DYTc6rwtZvrXUnFUgQ9apDRbEHohh0Vb4oaJVOBChraoKEOE
 A+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698613739; x=1699218539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nmyGat29OsWBS5khkJtjE1+pfomW6p5e6e6aoM/615g=;
 b=UHAXweh5ZUcscI0kHoMsdq0ogzMSyB/aG1doq0V+87f7fkAy2hFwhDLPSKOk52GQdx
 28L89agb2fFp+N8KfMwp10PjhCVRYb4yQ6ZWroyfD6LgGn4oirLslEkwDJvl735H1ptK
 8uBRPGKl1G/slCBUIKQ9Py50VmNGsr2a10+4bf0I+VbuAcXC7yf0LD0o3vyS/O1vTeLP
 jEW9jy2tBQM0mQldFbNm036KrfvVQvYrg+96yAu0xPaIbQIzjfJtrSuqk2nBX1DL7ttO
 jWvu7IwIZWl9JEmVGXcAItL7drPSyLKKz1koyhHMxVcy6ruIaT/R9A26dRhXJhLi4pev
 Pm2w==
X-Gm-Message-State: AOJu0Yy+NJmzJWTH+e4Gl03r/0L/geMXWPrLTKzGGNynjX3GSAmuegZa
 JSGlxqMR0cml96eE1B/cgREtVQNtHMlKsqDpJsQ=
X-Google-Smtp-Source: AGHT+IHjH1IkgFLhR5mB1OjB/3+S0FBeZEuEBq1rYZttzCZMsdDS1nWzomKFhjjJ0TnkNnnCsvDBjQ==
X-Received: by 2002:a05:6a00:856:b0:6be:23dd:d62c with SMTP id
 q22-20020a056a00085600b006be23ddd62cmr11148260pfk.2.1698613738891; 
 Sun, 29 Oct 2023 14:08:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 z11-20020aa785cb000000b006c0685422e0sm4622847pfn.214.2023.10.29.14.08.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 14:08:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/11] tcg: Move tcg_temp_new_*,
 tcg_global_mem_new_* out of line
Date: Sun, 29 Oct 2023 14:08:47 -0700
Message-Id: <20231029210848.78234-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029210848.78234-1-richard.henderson@linaro.org>
References: <20231029210848.78234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 include/tcg/tcg-op-common.h     | 11 ++++++
 include/tcg/tcg-temp-internal.h | 27 +++-----------
 include/tcg/tcg.h               | 51 --------------------------
 tcg/tcg.c                       | 64 +++++++++++++++++++++++++++++++--
 4 files changed, 76 insertions(+), 77 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index dddf93067e..2d932a515e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -17,6 +17,17 @@ TCGv_i64 tcg_constant_i64(int64_t val);
 TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val);
 TCGv_vec tcg_constant_vec_matching(TCGv_vec match, unsigned vece, int64_t val);
 
+TCGv_i32 tcg_temp_new_i32(void);
+TCGv_i64 tcg_temp_new_i64(void);
+TCGv_ptr tcg_temp_new_ptr(void);
+TCGv_i128 tcg_temp_new_i128(void);
+TCGv_vec tcg_temp_new_vec(TCGType type);
+TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);
+
+TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t off, const char *name);
+TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t off, const char *name);
+TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t off, const char *name);
+
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l);
diff --git a/include/tcg/tcg-temp-internal.h b/include/tcg/tcg-temp-internal.h
index dded2917e5..2d45cc45d2 100644
--- a/include/tcg/tcg-temp-internal.h
+++ b/include/tcg/tcg-temp-internal.h
@@ -56,28 +56,9 @@ static inline void tcg_temp_free_vec(TCGv_vec arg)
     tcg_temp_free_internal(tcgv_vec_temp(arg));
 }
 
-static inline TCGv_i32 tcg_temp_ebb_new_i32(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I32, TEMP_EBB);
-    return temp_tcgv_i32(t);
-}
-
-static inline TCGv_i64 tcg_temp_ebb_new_i64(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
-    return temp_tcgv_i64(t);
-}
-
-static inline TCGv_i128 tcg_temp_ebb_new_i128(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I128, TEMP_EBB);
-    return temp_tcgv_i128(t);
-}
-
-static inline TCGv_ptr tcg_temp_ebb_new_ptr(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_PTR, TEMP_EBB);
-    return temp_tcgv_ptr(t);
-}
+TCGv_i32 tcg_temp_ebb_new_i32(void);
+TCGv_i64 tcg_temp_ebb_new_i64(void);
+TCGv_ptr tcg_temp_ebb_new_ptr(void);
+TCGv_i128 tcg_temp_ebb_new_i128(void);
 
 #endif /* TCG_TEMP_FREE_H */
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a5ecab3cb3..45df817e20 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -795,57 +795,6 @@ void tb_target_set_jmp_target(const TranslationBlock *, int,
 
 void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size);
 
-TCGTemp *tcg_global_mem_new_internal(TCGType, TCGv_ptr,
-                                     intptr_t, const char *);
-TCGTemp *tcg_temp_new_internal(TCGType, TCGTempKind);
-TCGv_vec tcg_temp_new_vec(TCGType type);
-TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);
-
-static inline TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t offset,
-                                              const char *name)
-{
-    TCGTemp *t = tcg_global_mem_new_internal(TCG_TYPE_I32, reg, offset, name);
-    return temp_tcgv_i32(t);
-}
-
-static inline TCGv_i32 tcg_temp_new_i32(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I32, TEMP_TB);
-    return temp_tcgv_i32(t);
-}
-
-static inline TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t offset,
-                                              const char *name)
-{
-    TCGTemp *t = tcg_global_mem_new_internal(TCG_TYPE_I64, reg, offset, name);
-    return temp_tcgv_i64(t);
-}
-
-static inline TCGv_i64 tcg_temp_new_i64(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_TB);
-    return temp_tcgv_i64(t);
-}
-
-static inline TCGv_i128 tcg_temp_new_i128(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I128, TEMP_TB);
-    return temp_tcgv_i128(t);
-}
-
-static inline TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t offset,
-                                              const char *name)
-{
-    TCGTemp *t = tcg_global_mem_new_internal(TCG_TYPE_PTR, reg, offset, name);
-    return temp_tcgv_ptr(t);
-}
-
-static inline TCGv_ptr tcg_temp_new_ptr(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_PTR, TEMP_TB);
-    return temp_tcgv_ptr(t);
-}
-
 void tcg_dump_info(GString *buf);
 void tcg_dump_op_count(GString *buf);
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c77b1fd943..29dbb29a0a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1568,8 +1568,8 @@ void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size)
         = tcg_global_reg_new_internal(s, TCG_TYPE_PTR, reg, "_frame");
 }
 
-TCGTemp *tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
-                                     intptr_t offset, const char *name)
+static TCGTemp *tcg_global_mem_new_internal(TCGv_ptr base, intptr_t offset,
+                                            const char *name, TCGType type)
 {
     TCGContext *s = tcg_ctx;
     TCGTemp *base_ts = tcgv_ptr_temp(base);
@@ -1628,7 +1628,25 @@ TCGTemp *tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
     return ts;
 }
 
-TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind)
+TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t off, const char *name)
+{
+    TCGTemp *ts = tcg_global_mem_new_internal(reg, off, name, TCG_TYPE_I32);
+    return temp_tcgv_i32(ts);
+}
+
+TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t off, const char *name)
+{
+    TCGTemp *ts = tcg_global_mem_new_internal(reg, off, name, TCG_TYPE_I64);
+    return temp_tcgv_i64(ts);
+}
+
+TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t off, const char *name)
+{
+    TCGTemp *ts = tcg_global_mem_new_internal(reg, off, name, TCG_TYPE_PTR);
+    return temp_tcgv_ptr(ts);
+}
+
+static TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind)
 {
     TCGContext *s = tcg_ctx;
     TCGTemp *ts;
@@ -1692,6 +1710,46 @@ TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind)
     return ts;
 }
 
+TCGv_i32 tcg_temp_new_i32(void)
+{
+    return temp_tcgv_i32(tcg_temp_new_internal(TCG_TYPE_I32, TEMP_TB));
+}
+
+TCGv_i32 tcg_temp_ebb_new_i32(void)
+{
+    return temp_tcgv_i32(tcg_temp_new_internal(TCG_TYPE_I32, TEMP_EBB));
+}
+
+TCGv_i64 tcg_temp_new_i64(void)
+{
+    return temp_tcgv_i64(tcg_temp_new_internal(TCG_TYPE_I64, TEMP_TB));
+}
+
+TCGv_i64 tcg_temp_ebb_new_i64(void)
+{
+    return temp_tcgv_i64(tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB));
+}
+
+TCGv_ptr tcg_temp_new_ptr(void)
+{
+    return temp_tcgv_ptr(tcg_temp_new_internal(TCG_TYPE_PTR, TEMP_TB));
+}
+
+TCGv_ptr tcg_temp_ebb_new_ptr(void)
+{
+    return temp_tcgv_ptr(tcg_temp_new_internal(TCG_TYPE_PTR, TEMP_EBB));
+}
+
+TCGv_i128 tcg_temp_new_i128(void)
+{
+    return temp_tcgv_i128(tcg_temp_new_internal(TCG_TYPE_I128, TEMP_TB));
+}
+
+TCGv_i128 tcg_temp_ebb_new_i128(void)
+{
+    return temp_tcgv_i128(tcg_temp_new_internal(TCG_TYPE_I128, TEMP_EBB));
+}
+
 TCGv_vec tcg_temp_new_vec(TCGType type)
 {
     TCGTemp *t;
-- 
2.34.1


