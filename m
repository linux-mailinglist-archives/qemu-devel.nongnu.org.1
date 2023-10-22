Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FB77D26FB
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:31:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtI-00076w-Iy; Sun, 22 Oct 2023 19:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quht9-00073h-CV
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:43 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quht7-0006i8-IP
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:43 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-357cd0d4e47so4203005ab.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017380; x=1698622180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clLDX0OMwpp8pXeARARKHNXdrMJ0cLB2t4O0gfCmBGk=;
 b=Zbvsb+Q5s+dlks7Mr8NHsyMyfp53zFVhqnVOlwhxvL5ZfHxNz+ZTW7YFsPHCuQlCcb
 B1+cKmWU4/5smmRaUbYCmcD15MOP9pVLHb9hLhcJkejrZcES3xLbIgvhYg6PoN61QY6O
 A+J5ANV0vy4zaULfeDeqGReHKaB3EZIDodek7TcHesuVtVQ9cQrkjMmVJSG/B05O7mcc
 5QvBLxNECTY/RHgdd4LDx9bGBgUwomYz8+htUk3qol+dET+u4Mdm6ikDqesyxs6JWPKN
 XAJo4hn2Gzoag3kUXeZWHxVPubErIK9h4ptYrpBlu9h7xWYr7Imp5dh0VaEwnmiFgFTi
 2Z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017380; x=1698622180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=clLDX0OMwpp8pXeARARKHNXdrMJ0cLB2t4O0gfCmBGk=;
 b=AzTQA/hh0twUhAJpCE0z7zY5iex6eqhBTi2F45KmV2f64wI6k3AZfrfwZhEfqyH+GW
 4mFTKyE+kq87FC8BYc1HLgJ+quR8/skSt9T3wyiUMzv42NJYrqxfGOs0Hr9SWPEsIcWG
 w/OC04PSD4t2Tu//tOr3amfk5Dng5Sn21G4uMwOnrdHIcVuTVRjI71/HmsTyoA8O2Jr3
 h9k7qfi6JPeH2r/n2un86CEGwJM15GQ2CmInEAX6odoGoXIEYGN7GYnqMi3vJDYL3qLJ
 3b1hKWnYURR2QJMxZOg+ZGL6/wyeqcik9VKTiCIfe/A7bXh9P+vjVpUGMo9zrTDAE5Fe
 +crQ==
X-Gm-Message-State: AOJu0Yysqp2qLH+pI+Z+NYlK5irTuQUZ/TvFNSHShCq1kQZar7PRtUbi
 VoBIcW1fG1vep2MOXAOgkpRlOyhzVoTjYF2x5eM=
X-Google-Smtp-Source: AGHT+IHhoqabKSjOfO3n3LCKidvQ8EUOGHy8Wr3VPC5m5+Yw/j0E+K5MYvLcvyUEjf+D2/C3glYx2w==
X-Received: by 2002:a05:6e02:20ee:b0:357:9817:934c with SMTP id
 q14-20020a056e0220ee00b003579817934cmr10020889ilv.20.1698017380252; 
 Sun, 22 Oct 2023 16:29:40 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 07/94] target/sparc: Use CPU_FEATURE_BIT_* for cpu
 properties
Date: Sun, 22 Oct 2023 16:28:05 -0700
Message-Id: <20231022232932.80507-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x136.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 72 ++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 8ba96ae225..330b7bead3 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -545,21 +545,22 @@ static const sparc_def_t sparc_defs[] = {
 #endif
 };
 
+/* This must match sparc_cpu_properties[]. */
 static const char * const feature_name[] = {
-    "float",
-    "float128",
-    "swap",
-    "mul",
-    "div",
-    "flush",
-    "fsqrt",
-    "fmul",
-    "vis1",
-    "vis2",
-    "fsmuld",
-    "hypv",
-    "cmt",
-    "gl",
+    [CPU_FEATURE_BIT_FLOAT] = "float",
+    [CPU_FEATURE_BIT_FLOAT128] = "float128",
+    [CPU_FEATURE_BIT_SWAP] = "swap",
+    [CPU_FEATURE_BIT_MUL] = "mul",
+    [CPU_FEATURE_BIT_DIV] = "div",
+    [CPU_FEATURE_BIT_FLUSH] = "flush",
+    [CPU_FEATURE_BIT_FSQRT] = "fsqrt",
+    [CPU_FEATURE_BIT_FMUL] = "fmul",
+    [CPU_FEATURE_BIT_VIS1] = "vis1",
+    [CPU_FEATURE_BIT_VIS2] = "vis2",
+    [CPU_FEATURE_BIT_FSMULD] = "fsmuld",
+    [CPU_FEATURE_BIT_HYPV] = "hypv",
+    [CPU_FEATURE_BIT_CMT] = "cmt",
+    [CPU_FEATURE_BIT_GL] = "gl",
 };
 
 static void print_features(uint32_t features, const char *prefix)
@@ -835,21 +836,36 @@ static PropertyInfo qdev_prop_nwindows = {
     .set   = sparc_set_nwindows,
 };
 
+/* This must match feature_name[]. */
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


