Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 453B67D1B19
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:43:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4as-00077z-93; Sat, 21 Oct 2023 01:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4an-00076e-Du
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4al-0008Lv-Ea
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:09 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b6f4c118b7so1358558b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866326; x=1698471126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZH3dMD/AA/crmsUs16Itr1WvEaqL+uLcI9qPlF9Ii5g=;
 b=kehuPPz890doaD6tNxYtoGmtGmNO6MDu32dfGKwcxPRaxuTkJNxd1m8zd4ScWBMmsO
 QPrTmA9WHJdkLzkOThg3dj9cmOhM09VZfaSQ2Vbwzsb3QJ1btqJlcUDTZ8i16UfBnG7l
 j3UIl5O8YMWBTK255nCWphYTRQ+B9K/kh9YBvTmv6ciFoKHVF/hB1PXpzhOPd0gbaX5Y
 xFEdpYJ901sw57Ms3taIU+WzHLdtYl2v2kQxvwwepEJWKKWLq9BTqE963YPqlOnfRSKb
 pn0TTQAgrMvlT3/2yDXTM5fveNLQvxRFAOIqwvVUCHZEpc85A9vHwJ3863sBi+MFNIp1
 z4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866326; x=1698471126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZH3dMD/AA/crmsUs16Itr1WvEaqL+uLcI9qPlF9Ii5g=;
 b=LQGZLW0g7H8Dbd00vGZNorsa6buSrIUxBz5Bwg+As/jtClZjOW53WBO3LLkab2pvgt
 Tuc5OYyRK9Ybl8eRbkO/bXM2WXrbl+//dss0YRhUcnQh8XVCAgqlyLrdyMrIhEZz5jR3
 uyetA1QvLCgaHd1u78PYVlURLESjkMBhU+H/XWYtsRSHupNw6+WHubIMSfmbay55Niss
 8N/91/eR0hAP0VPiLUjwOxjf3L4NgvNCqfOA8Pf3iZ9WchOnuT2CYkdrL3mqhakhek8y
 alMQCJjhJrvl5yQwigMdl8QnS+Pkf7Z4mbbtN8pepOYdn0mA9mZrR5BOnP75kg6PD3H5
 4H0Q==
X-Gm-Message-State: AOJu0YxMyqxhGdtbJmj/7/D1kOCnqFjqMsNvEGFsynfNCgF/nX1uOnJq
 NWGu+3iGp1hzyUGazsrpEmyZGuceezwLSr9JxlI=
X-Google-Smtp-Source: AGHT+IGgsJJwx0nppOKC1t5XEIsRnVODHe0a668k6acs1JwgvSIsI590ZBGo9alUcpy8hs4vLxbnpA==
X-Received: by 2002:a05:6a00:1788:b0:6b5:86c3:ccaf with SMTP id
 s8-20020a056a00178800b006b586c3ccafmr4124196pfg.22.1697866325888; 
 Fri, 20 Oct 2023 22:32:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 07/90] target/sparc: Use CPU_FEATURE_BIT_* for cpu
 properties
Date: Fri, 20 Oct 2023 22:30:35 -0700
Message-Id: <20231021053158.278135-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Use symbols not integer constants for the bit positions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 8ba96ae225..e4d1c552e5 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -836,20 +836,34 @@ static PropertyInfo qdev_prop_nwindows = {
 };
 
 static Property sparc_cpu_properties[] = {
-    DEFINE_PROP_BIT("float",    SPARCCPU, env.def.features, 0, false),
-    DEFINE_PROP_BIT("float128", SPARCCPU, env.def.features, 1, false),
-    DEFINE_PROP_BIT("swap",     SPARCCPU, env.def.features, 2, false),
-    DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features, 3, false),
-    DEFINE_PROP_BIT("div",      SPARCCPU, env.def.features, 4, false),
-    DEFINE_PROP_BIT("flush",    SPARCCPU, env.def.features, 5, false),
-    DEFINE_PROP_BIT("fsqrt",    SPARCCPU, env.def.features, 6, false),
-    DEFINE_PROP_BIT("fmul",     SPARCCPU, env.def.features, 7, false),
-    DEFINE_PROP_BIT("vis1",     SPARCCPU, env.def.features, 8, false),
-    DEFINE_PROP_BIT("vis2",     SPARCCPU, env.def.features, 9, false),
-    DEFINE_PROP_BIT("fsmuld",   SPARCCPU, env.def.features, 10, false),
-    DEFINE_PROP_BIT("hypv",     SPARCCPU, env.def.features, 11, false),
-    DEFINE_PROP_BIT("cmt",      SPARCCPU, env.def.features, 12, false),
-    DEFINE_PROP_BIT("gl",       SPARCCPU, env.def.features, 13, false),
+    DEFINE_PROP_BIT("float",    SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_FLOAT, false),
+    DEFINE_PROP_BIT("float128", SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_FLOAT128, false),
+    DEFINE_PROP_BIT("swap",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_SWAP, false),
+    DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_MUL, false),
+    DEFINE_PROP_BIT("div",      SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_DIV, false),
+    DEFINE_PROP_BIT("flush",    SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_FLUSH, false),
+    DEFINE_PROP_BIT("fsqrt",    SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_FSQRT, false),
+    DEFINE_PROP_BIT("fmul",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_FMUL, false),
+    DEFINE_PROP_BIT("vis1",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_VIS1, false),
+    DEFINE_PROP_BIT("vis2",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_VIS2, false),
+    DEFINE_PROP_BIT("fsmuld",   SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_FSMULD, false),
+    DEFINE_PROP_BIT("hypv",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_HYPV, false),
+    DEFINE_PROP_BIT("cmt",      SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_CMT, false),
+    DEFINE_PROP_BIT("gl",       SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_GL, false),
     DEFINE_PROP_UNSIGNED("iu-version", SPARCCPU, env.def.iu_version, 0,
                          qdev_prop_uint64, target_ulong),
     DEFINE_PROP_UINT32("fpu-version", SPARCCPU, env.def.fpu_version, 0),
-- 
2.34.1


