Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0092070A931
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:31:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PQm-0004Jw-Qu; Sat, 20 May 2023 12:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQJ-0003nB-DK
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:15 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQE-000392-GP
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:15 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ae615d5018so26547555ad.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684600028; x=1687192028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WXDf+ZM8xKRR3ok9Sko5lUMigoP5WIzPelyBaHT6/A=;
 b=wUixfCHPzv4t4m33BQzAwn58Cw6b65/96GrMJuwsDRylO2TW2hHfkgTZ8tQRBQzjLm
 R9jz4khe9Z7XEeKDn74C0wmfSdws6D0fQI8ndPID73egkLFouW93b0zyR8JznVC31VUU
 5eraGvW+1QVoNH+qESq0SamQ+hBHtM0Qzj6CMWnAP7/hInANMJM1l9V7AYCGPa9PyR4w
 k8LGYAMc+NJ96JJqo1pgCTVan/4718W7NCoXp87u31H/9xCox2C27GkejHfG4pafDEg4
 WISn/G16TgYlSHV4ls9FkgcEQ/jgN+35XBqMqURyWdvMHgu+spf7dy0v8ZWQ6ODpZ7GW
 JHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684600028; x=1687192028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6WXDf+ZM8xKRR3ok9Sko5lUMigoP5WIzPelyBaHT6/A=;
 b=PaAqZ9J8iRHM0lq+N2/X+xgLqfp7ZFEdAyX72VshZb3qVh0Ne9F7WTlp5AzazpX1BF
 i7mBY5LexqOSDjUbNTT3R/F3tnmms8K6lCrVpc/IJ14Kq6TzFE9H1abu7QbFCXP/rGDS
 NxeWaXlH63iegY49KQ6chf+jUr75ggWAsZl3BJw8SZyRKTWYvJKg/F7PuE+rz0x4GgIM
 wSXLGzuMUa86pDZfmYKclD8tngG8oZgICjdHL2A5FjLzmuQnuV5MHfLCurHarZi8Y/Dj
 p41scgWkwPIzw2t4yTYL8IjtmFbJjzbjaRW/xCNfBPr8jJZc4YnZ4RV/+LNPYxN+Iybs
 Nm0g==
X-Gm-Message-State: AC+VfDxs0qzdW7+2NfpXo57meKk3knw5oakNtbjNfU16AhBGNrHjVbFa
 UI5agY9qpmzYpdrbLq3sqhzMT1VAW1uqCt9yxl8=
X-Google-Smtp-Source: ACHHUZ4v/Iad6idkzl6MAtd7WQlpIXivKi6ay6+R/zc0zqhHiUfRe8D/NI9Yip4DQrOLUqbcaKVJsg==
X-Received: by 2002:a17:902:d511:b0:1ab:7c4:eb24 with SMTP id
 b17-20020a170902d51100b001ab07c4eb24mr8129667plg.22.1684600028280; 
 Sat, 20 May 2023 09:27:08 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:27:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 25/27] qemu/atomic128: Improve cmpxchg fallback for
 atomic16_set
Date: Sat, 20 May 2023 09:26:32 -0700
Message-Id: <20230520162634.3991009-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520162634.3991009-1-richard.henderson@linaro.org>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Use __sync_bool_compare_and_swap_16 to control the loop,
rather than a separate comparison.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/atomic128-ldst.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/host/include/generic/host/atomic128-ldst.h b/host/include/generic/host/atomic128-ldst.h
index 79d208b7a4..80fff0643a 100644
--- a/host/include/generic/host/atomic128-ldst.h
+++ b/host/include/generic/host/atomic128-ldst.h
@@ -58,11 +58,14 @@ atomic16_read_rw(Int128 *ptr)
 static inline void ATTRIBUTE_ATOMIC128_OPT
 atomic16_set(Int128 *ptr, Int128 val)
 {
-    Int128 old = *ptr, cmp;
+    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
+    __int128_t old;
+    Int128Alias new;
+
+    new.s = val;
     do {
-        cmp = old;
-        old = atomic16_cmpxchg(ptr, cmp, val);
-    } while (int128_ne(old, cmp));
+        old = *ptr_align;
+    } while (!__sync_bool_compare_and_swap_16(ptr_align, old, new.i));
 }
 
 #else
-- 
2.34.1


