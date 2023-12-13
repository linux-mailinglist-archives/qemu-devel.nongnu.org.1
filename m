Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8F48115C3
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:06:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDQoP-0001V2-6d; Wed, 13 Dec 2023 10:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDQoN-0001Up-Cc
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:06:11 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDQoL-0002nE-JI
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:06:11 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c38de1ee4so48406015e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 07:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702479968; x=1703084768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NuCHOeqwawPiZ7+iu2oh5yIwSOaMy7erL6b+eROcFSI=;
 b=g3ZogR+lzSb4Xz8lrV2SyyLXc629iG5/SnV/UXAC1z2k3sufef9GFrEnpvHOTTHNkE
 82fWIlfl5si1JOv6oWD/ffHWDhGEp0bx9ZPe1Zkq4wMLDVo2ZS1EfMX4N+DIFlWIlM/G
 yK2hKrnzzuF6Z26zP930rmfTOiLwLoOje1vIhRjRpIzRo5HcQGmcubgrCOishUx9eQp6
 XF3QNuAVD7JdFXHa4tJ0mFZzUzm/jzK/TwB/A85Jr/7QoGTxy0Mw02DglEhBbrCyWL7Q
 YSZtVY/3Btb7Vn9TRwsp+20CJAcuAKsMupJf5gMbkUlFF+o1DxucSaO2UKFD/N9bb8d+
 QQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702479968; x=1703084768;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NuCHOeqwawPiZ7+iu2oh5yIwSOaMy7erL6b+eROcFSI=;
 b=f9GfKwu8g59yNHlslKOnHjRpx5WlGsTe1fAJ09IgVplPsf9n49Zh8J48jR/SVFGGGy
 zoCv8LDFj/qa3WGo1czzhluyMjfAVsYkfsMCByjkge9MIBmaV3LB6dQ63xNSqxL9FUTO
 qmPIyuKKZgHdKvpvxIgMI1h97LhGZT1/IN/3I4WCI8z71s7lPLhEyr/i7TRCnA0lqOj7
 paNH9CLEk3CcIbLBWN9D474bpN+WmWpr/G9Bvcxvye5XTI+NVjCnOpRZMTK1iuBc96c7
 7Jg+TJ6QI8qLmZN8/O8ITmgnD2bK7Hnf18RO1E4l1gD2Cxi05/EFI1pRpNYksOXmdILS
 19Og==
X-Gm-Message-State: AOJu0YyA/rswYJrOJ2N/Ay4I9ppVbxaj1TJpcTCe+6CJQK+zIznd+daA
 h45/kRmJY9GJNf804xqdSD654zOjnAgPOtEvqHLgmQ==
X-Google-Smtp-Source: AGHT+IFQcyCDkWWCnVoU6E93HQnD1sxAkjZG/qrJJEHI32HReULGYYQ1MlaCwjpjiSESL2IbuyNXbQ==
X-Received: by 2002:a05:600c:3b29:b0:40c:3290:7b80 with SMTP id
 m41-20020a05600c3b2900b0040c32907b80mr4387722wms.138.1702479968293; 
 Wed, 13 Dec 2023 07:06:08 -0800 (PST)
Received: from [192.168.71.175] (76.red-88-28-19.dynamicip.rima-tde.net.
 [88.28.19.76]) by smtp.gmail.com with ESMTPSA id
 e17-20020a05600c4e5100b0040c34cb896asm19587207wmq.41.2023.12.13.07.06.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 07:06:07 -0800 (PST)
Message-ID: <93330946-8847-4a7f-b04e-7f7da60298b1@linaro.org>
Date: Wed, 13 Dec 2023 15:46:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] tcg: Move 64-bit expanders out of line
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231029210848.78234-1-richard.henderson@linaro.org>
 <20231029210848.78234-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231029210848.78234-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
> This one is more complicated, combining 32-bit and 64-bit
> expansion with C if instead of preprocessor #if.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h | 144 +---------------------
>   tcg/tcg-op.c                | 231 +++++++++++++++++++++++++-----------
>   2 files changed, 169 insertions(+), 206 deletions(-)

Easier for me to review changing first:

-- >8 --
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a8cbad212d..4f3d0b6cec 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1400,10 +1400,14 @@ void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
  {
-    TCGTemp *ts = tcgv_i64_temp(arg);
-
-    /* Canonicalize TCGv_i64 TEMP_CONST into TCGv_i32 TEMP_CONST. */
-    if (ts->kind == TEMP_CONST) {
-        tcg_gen_movi_i64(ret, ts->val);
+    if (ret == arg) {
+        return;
      } else {
-        tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-        tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_HIGH(arg));
+        TCGTemp *ts = tcgv_i64_temp(arg);
+
+        /* Canonicalize TCGv_i64 TEMP_CONST into TCGv_i32 TEMP_CONST. */
+        if (ts->kind == TEMP_CONST) {
+            tcg_gen_movi_i64(ret, ts->val);
+        } else {
+            tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg));
+            tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_HIGH(arg));
+        }
      }
---

and then:

-- >8 --
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4f3d0b6cec..bd9288dac0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1461,9 +1461,9 @@ void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, 
tcg_target_long offset)
         they cannot be the same temporary */
-#if HOST_BIG_ENDIAN
-    tcg_gen_ld_i32(TCGV_HIGH(ret), arg2, offset);
-    tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset + 4);
-#else
-    tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
-    tcg_gen_ld_i32(TCGV_HIGH(ret), arg2, offset + 4);
-#endif
+    if (HOST_BIG_ENDIAN) {
+        tcg_gen_ld_i32(TCGV_HIGH(ret), arg2, offset);
+        tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset + 4);
+    } else {
+        tcg_gen_ld_i32(TCGV_LOW(ret), arg2, offset);
+        tcg_gen_ld_i32(TCGV_HIGH(ret), arg2, offset + 4);
+    }
  }
@@ -1487,9 +1487,9 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, 
tcg_target_long offset)
  {
-#if HOST_BIG_ENDIAN
-    tcg_gen_st_i32(TCGV_HIGH(arg1), arg2, offset);
-    tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset + 4);
-#else
-    tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset);
-    tcg_gen_st_i32(TCGV_HIGH(arg1), arg2, offset + 4);
-#endif
+    if (HOST_BIG_ENDIAN) {
+        tcg_gen_st_i32(TCGV_HIGH(arg1), arg2, offset);
+        tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset + 4);
+    } else {
+        tcg_gen_st_i32(TCGV_LOW(arg1), arg2, offset);
+        tcg_gen_st_i32(TCGV_HIGH(arg1), arg2, offset + 4);
+    }
  }
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


