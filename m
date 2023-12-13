Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6C4811B8C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:52:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDTOQ-0003Nu-BT; Wed, 13 Dec 2023 12:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDTOO-0003Ne-Oc
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:51:32 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDTOM-000229-ML
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:51:32 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-54c5d041c23so9629305a12.2
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 09:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702489889; x=1703094689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fkLcSshu6WnRvg/s/jLLnA7eXmKVWcO0Ix5UMR2LY08=;
 b=BjZRxcIGpAxB9A66XMbTKfKmz3U7csr2HP3+bNivW4gKjaXicLy5jEu5NNnIwRq9dn
 H3poVEBbxvkXpEOX0gwrdCr5D5wJbopRoTxM6zymJgQgHlwsbE4a6R2omIhfJ/hCYxx1
 vzKbhUcQb5Qu5f/T17ObS6A0ruZX3oKG95L3Lckdpp12/fN7aT907BLjv30NCdA31Sr3
 c239cJ10yvP9rxgkyRljL0OjYNRu3ctTeMAebwYn6Oy4+rGX96VSrRb6q4bWF517+EQx
 da7Cm0u3m7/f2U3OmB/TZQNJU1nHmRdaEUB+4MTvDj6jMQIa3xqgmy91HP7m0y3lpQIA
 QDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702489889; x=1703094689;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fkLcSshu6WnRvg/s/jLLnA7eXmKVWcO0Ix5UMR2LY08=;
 b=EyUNg6NsglWmjmd3TxNxaXWgU5+y5Jnc3na5j2ZVAJF2PKwIf4l3fFDg2e1gTTV5sH
 HuiURWB+/v/1+NMwa04Z7iiK3uYTca0N2lpBYZBtzySVnfjaVC3zGw9nK+r2wWqVx0/u
 54vTh2ZvYug4GcjCMYqfHzZ42w75T1dQ9l1uM6QaZRIXE6Lza0cxK3mwSUZc8ov9whWX
 3Sa3u9gS7LSNvVhl+1BfrJdzoQebzoO8OZW/NGGy+rU4JjGxY/vYuWc1n3uky2CB5Hz5
 aRObzJ7FyTcTyb91VVen5J2z42W1Q4P/nEQRJLozbMYjcblwTqNxkP4nlSA1yFuEMI6+
 xTjg==
X-Gm-Message-State: AOJu0Yy91Gz8D7pUQDzBhc6Vl/CbCDqQ6boXPyc5IN/5c64fFDxMu6PI
 RKfoDb1IyC5qGZlW5E2n44M1SNEhc6i4mN0eUFzDRQ==
X-Google-Smtp-Source: AGHT+IEjg+Gyfw9GLwCMZQrc6O/QGoze4/znCUmbRh9oD7QHHvjj+Kj1qQL96d5az4d+m1vrzyLy8Q==
X-Received: by 2002:a17:907:3e12:b0:a1d:182:efc4 with SMTP id
 hp18-20020a1709073e1200b00a1d0182efc4mr2508407ejc.200.1702489889026; 
 Wed, 13 Dec 2023 09:51:29 -0800 (PST)
Received: from [192.168.79.175] ([93.23.251.22])
 by smtp.gmail.com with ESMTPSA id
 vs4-20020a170907a58400b00a22fb8901c4sm1333581ejc.12.2023.12.13.09.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 09:51:28 -0800 (PST)
Message-ID: <fb4b7979-d13b-4424-aa99-23a934d94af1@linaro.org>
Date: Wed, 13 Dec 2023 18:51:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] tcg: Move tcg_temp_new_*, tcg_global_mem_new_* out
 of line
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231029210848.78234-1-richard.henderson@linaro.org>
 <20231029210848.78234-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231029210848.78234-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 29/10/23 22:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h     | 11 ++++++
>   include/tcg/tcg-temp-internal.h | 27 +++-----------
>   include/tcg/tcg.h               | 51 --------------------------
>   tcg/tcg.c                       | 64 +++++++++++++++++++++++++++++++--
>   4 files changed, 76 insertions(+), 77 deletions(-)

Preferably split in 2 patches for clarity:

-- >8 --
diff --git a/include/tcg/tcg-temp-internal.h 
b/include/tcg/tcg-temp-internal.h
index dded2917e5..2d45cc45d2 100644
--- a/include/tcg/tcg-temp-internal.h
+++ b/include/tcg/tcg-temp-internal.h
@@ -58,25 +58,6 @@ static inline void tcg_temp_free_vec(TCGv_vec arg)

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

diff --git a/tcg/tcg.c b/tcg/tcg.c
index ab0d227c00..cbbd6d2550 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1698,2 +1698,22 @@ TCGTemp *tcg_temp_new_internal(TCGType type, 
TCGTempKind kind)

+TCGv_i32 tcg_temp_ebb_new_i32(void)
+{
+    return temp_tcgv_i32(tcg_temp_new_internal(TCG_TYPE_I32, TEMP_EBB));
+}
+
+TCGv_i64 tcg_temp_ebb_new_i64(void)
+{
+    return temp_tcgv_i64(tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB));
+}
+
+TCGv_ptr tcg_temp_ebb_new_ptr(void)
+{
+    return temp_tcgv_ptr(tcg_temp_new_internal(TCG_TYPE_PTR, TEMP_EBB));
+}
+
+TCGv_i128 tcg_temp_ebb_new_i128(void)
+{
+    return temp_tcgv_i128(tcg_temp_new_internal(TCG_TYPE_I128, TEMP_EBB));
+}
+
  TCGv_vec tcg_temp_new_vec(TCGType type)
---

and:

-- >8 --
diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index dddf93067e..2d932a515e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -19,2 +19,13 @@ TCGv_vec tcg_constant_vec_matching(TCGv_vec match, 
unsigned vece, int64_t val);

+TCGv_i32 tcg_temp_new_i32(void);
+TCGv_i64 tcg_temp_new_i64(void);
+TCGv_ptr tcg_temp_new_ptr(void);
+TCGv_i128 tcg_temp_new_i128(void);
+TCGv_vec tcg_temp_new_vec(TCGType type);
+TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);
+
+TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t off, const char 
*name);
+TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t off, const char 
*name);
+TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t off, const char 
*name);
+
  /* Generic ops.  */
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 1ae131c242..fc218fd381 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -797,53 +797,2 @@ void tcg_set_frame(TCGContext *s, TCGReg reg, 
intptr_t start, intptr_t size);

-TCGTemp *tcg_global_mem_new_internal(TCGType, TCGv_ptr,
-                                     intptr_t, const char *);
-TCGTemp *tcg_temp_new_internal(TCGType, TCGTempKind);
-TCGv_vec tcg_temp_new_vec(TCGType type);
-TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);
-
-static inline TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t 
offset,
-                                              const char *name)
-{
-    TCGTemp *t = tcg_global_mem_new_internal(TCG_TYPE_I32, reg, offset, 
name);
-    return temp_tcgv_i32(t);
-}
-
-static inline TCGv_i32 tcg_temp_new_i32(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I32, TEMP_TB);
-    return temp_tcgv_i32(t);
-}
-
-static inline TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t 
offset,
-                                              const char *name)
-{
-    TCGTemp *t = tcg_global_mem_new_internal(TCG_TYPE_I64, reg, offset, 
name);
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
-static inline TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t 
offset,
-                                              const char *name)
-{
-    TCGTemp *t = tcg_global_mem_new_internal(TCG_TYPE_PTR, reg, offset, 
name);
-    return temp_tcgv_ptr(t);
-}
-
-static inline TCGv_ptr tcg_temp_new_ptr(void)
-{
-    TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_PTR, TEMP_TB);
-    return temp_tcgv_ptr(t);
-}
-
  #define TCG_CT_CONST  1 /* any constant of register size */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index cbbd6d2550..ec358ce5c0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1574,4 +1574,4 @@ void tcg_set_frame(TCGContext *s, TCGReg reg, 
intptr_t start, intptr_t size)

-TCGTemp *tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
-                                     intptr_t offset, const char *name)
+static TCGTemp *tcg_global_mem_new_internal(TCGv_ptr base, intptr_t offset,
+                                            const char *name, TCGType type)
  {
@@ -1634,3 +1634,21 @@ TCGTemp *tcg_global_mem_new_internal(TCGType 
type, TCGv_ptr base,

-TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind)
+TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t off, const char 
*name)
+{
+    TCGTemp *ts = tcg_global_mem_new_internal(reg, off, name, 
TCG_TYPE_I32);
+    return temp_tcgv_i32(ts);
+}
+
+TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t off, const char 
*name)
+{
+    TCGTemp *ts = tcg_global_mem_new_internal(reg, off, name, 
TCG_TYPE_I64);
+    return temp_tcgv_i64(ts);
+}
+
+TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t off, const char 
*name)
+{
+    TCGTemp *ts = tcg_global_mem_new_internal(reg, off, name, 
TCG_TYPE_PTR);
+    return temp_tcgv_ptr(ts);
+}
+
+static TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind)
  {
@@ -1698,2 +1716,7 @@ TCGTemp *tcg_temp_new_internal(TCGType type, 
TCGTempKind kind)

+TCGv_i32 tcg_temp_new_i32(void)
+{
+    return temp_tcgv_i32(tcg_temp_new_internal(TCG_TYPE_I32, TEMP_TB));
+}
+
  TCGv_i32 tcg_temp_ebb_new_i32(void)
@@ -1703,2 +1726,7 @@ TCGv_i32 tcg_temp_ebb_new_i32(void)

+TCGv_i64 tcg_temp_new_i64(void)
+{
+    return temp_tcgv_i64(tcg_temp_new_internal(TCG_TYPE_I64, TEMP_TB));
+}
+
  TCGv_i64 tcg_temp_ebb_new_i64(void)
@@ -1708,2 +1736,7 @@ TCGv_i64 tcg_temp_ebb_new_i64(void)

+TCGv_ptr tcg_temp_new_ptr(void)
+{
+    return temp_tcgv_ptr(tcg_temp_new_internal(TCG_TYPE_PTR, TEMP_TB));
+}
+
  TCGv_ptr tcg_temp_ebb_new_ptr(void)
@@ -1713,2 +1746,7 @@ TCGv_ptr tcg_temp_ebb_new_ptr(void)

+TCGv_i128 tcg_temp_new_i128(void)
+{
+    return temp_tcgv_i128(tcg_temp_new_internal(TCG_TYPE_I128, TEMP_TB));
+}
+
  TCGv_i128 tcg_temp_ebb_new_i128(void)
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



