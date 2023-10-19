Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 671407D0193
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXmG-0001mS-1D; Thu, 19 Oct 2023 14:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtXm6-0001HY-0W
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:29:38 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtXm3-00071b-LF
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:29:37 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-57b5f0d658dso6870eaf.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697740174; x=1698344974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wAV0MQyuUvJwJtAe5PEULJLUpPvnw9Xv2CxQWX7wnBg=;
 b=mT2edJl4xwQl7S+FH+YhboxieIPTU/i/2D/Fi1gLIctRubxCAUiAQt2pbg6zdjaV4o
 Cfr4VMZ2A9KHpjDCjaPy9KImyM7rbsCBCjI/yq+vGnRd2W80i+OIM2QJAD2QSHuySNoJ
 YMLJtjXZMc8eCKAfErLsLYT0g0LzChm2rNRizLUDmRZaBtVjgHfGtYfW/WUogF1cAyz1
 jE+DsuKNGVOLETfq84sTxH6RMMZkNEeximTV7g3ldzHVXbW+zdJ+o4mOV7xTGFs4wyJM
 4vKV5693eCeDuKDcmvonpy4CAIJoaC4CMtVcanyXz6HAuG2CIApJxtMPj0wHxkxorRAx
 vBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697740174; x=1698344974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wAV0MQyuUvJwJtAe5PEULJLUpPvnw9Xv2CxQWX7wnBg=;
 b=rEpfMjquwqhlgOaQ6x4A6IKgQrW3d/tLA4FhaDTRkQqW0uYUe/KNVfwsqAXrxEMlYo
 dbU+cngBY+4jAKhaGmcGzaXfzSGFu910C4YsxLdklYwqJFVA5nzU6b5UBtLKDAQxJTMK
 XARhI7gGT0CiX+25yyVC9AVhQK4v/Cl5pCjB78N3IfsVAJYv0CKmZeZzhTBUj+kzkVwQ
 rlPNpEjzrukFXa1eh5trP7nvMBuxmVrYSnC1m+27yJHfe9Uy0zTxeTuP9cFMdy7aUsyZ
 NqCKo4kDKcJrHMdOhC16TJcOb3CVra3/Tv/n7s19rOzjpFSad2fq9Q1hdX7LlAE5Oxqx
 TdPQ==
X-Gm-Message-State: AOJu0YzmQ3MLQmZQajFZlt9bQVKnqT7Rt7KgIy8qPaRNxyjAbn3NCf5S
 pEu9mNI8yrRGyGUIVX8RPbNEXBjjU6fRVR7mQc4=
X-Google-Smtp-Source: AGHT+IGa7qfPoH5LTYWzrDzVH865rovkziXddTFwYRq9wpENBLAeK7oxs9wlrhzfFrlkDIMM9hjcgA==
X-Received: by 2002:a05:6359:5d26:b0:14d:b8d3:97e5 with SMTP id
 ps38-20020a0563595d2600b0014db8d397e5mr2656647rwb.20.1697740174416; 
 Thu, 19 Oct 2023 11:29:34 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e1-20020a630f01000000b005b856fab5e9sm72216pgl.18.2023.10.19.11.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:29:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, laurent@vivier.eu,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com
Subject: [PATCH 7/7] target/xtensa: Use tcg_gen_sextract_i32
Date: Thu, 19 Oct 2023 11:29:21 -0700
Message-Id: <20231019182921.1772928-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019182921.1772928-1-richard.henderson@linaro.org>
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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
 target/xtensa/translate.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 54bee7ddba..de89940599 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2262,17 +2262,7 @@ static void translate_salt(DisasContext *dc, const OpcodeArg arg[],
 static void translate_sext(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    int shift = 31 - arg[2].imm;
-
-    if (shift == 24) {
-        tcg_gen_ext8s_i32(arg[0].out, arg[1].in);
-    } else if (shift == 16) {
-        tcg_gen_ext16s_i32(arg[0].out, arg[1].in);
-    } else {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_shli_i32(tmp, arg[1].in, shift);
-        tcg_gen_sari_i32(arg[0].out, tmp, shift);
-    }
+    tcg_gen_sextract_i32(arg[0].out, arg[1].in, 0, arg[2].imm + 1);
 }
 
 static uint32_t test_exceptions_simcall(DisasContext *dc,
-- 
2.34.1


