Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 376637D2726
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:35:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtQ-00079l-Nr; Sun, 22 Oct 2023 19:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtF-00076M-HK
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:51 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtA-0006ih-9a
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:48 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1e9c9d181d6so1984606fac.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017382; x=1698622182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVqtOTdE26FeikcQeSUZ6gzaDd5J2ZKDmGo0pFRcFos=;
 b=tA0pdSxj2MERrl9TszD7r1vCPHYfVJIE+UGINGcwOqK9ZVk0dK7biYs146psjfzZwH
 v59mWe1bopPnJzYNY/pgUxGLPIPVv3nsES8cPG40y4RE9nMIOyPDCwt97kW9xpZGOzGB
 Ak2Ub458rQ821vCfvPZnDEaFCn3W5Uh6m4wGuznkY5XPxncN6uY37GM8pM5u3qHkHnkL
 zc/NgXaZArLYuQKQSfXEnX3MKhWgGERjqIpKFSzgKZ1ZYvenCJ9oAUpgPRSXbm+OWdHX
 tABzG+VN/S8dYQM44EUagxtuACdKeKUyC5NkM6owSCkLkSupm5RCaDEvZ515OCuWP99D
 oxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017382; x=1698622182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVqtOTdE26FeikcQeSUZ6gzaDd5J2ZKDmGo0pFRcFos=;
 b=vjNKM2p/UP2RJdhyBwwTZw98zX5GhhymWpbcBV/ndlo/X65Z32G3o9ZiGHjG0poUWb
 WIHMomwvur9DNCE9RlYat3IIXDZ58iiX+BbWI4OaZADOtWY3A6H4fT8RIHYAnfNpdT+q
 qHDt5+QjSATU9lrUOJnSzRn+2ba0/Ic9pM1BpPbbi0IFa8N0zdQOD9E6rbVesHd5yx8s
 lfJulM9CjEjLTGA7hX/BKln+YwlehtPEbC0RT/Lv2CTRy8MC2xr+aG3JqIcwajq1TpBq
 l9VhwRaMti341p4FWSOQ6XFL6G8iMPajidUtj6elVdYA3Mr+lWdWFzuUie1sUfAZMAD2
 T4cA==
X-Gm-Message-State: AOJu0YyyA39GP1XdsnVVMVFHCeZbVphOmI+p/MHD8luy2qgKd1n3X947
 rwDViJb22RxCXWKgx6ul0t5bvJAr2m3H/pvdZN8=
X-Google-Smtp-Source: AGHT+IHeeAJ3Z86erlYXU3LKqudTtR4fU520lcFUlzgAmhI3Or+4jh3291fRLpFZ7mKIUCrDIp0jSA==
X-Received: by 2002:a05:6870:f212:b0:1e9:e975:4418 with SMTP id
 t18-20020a056870f21200b001e9e9754418mr9950515oao.53.1698017382027; 
 Sun, 22 Oct 2023 16:29:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 09/94] target/sparc: Partition cpu features
Date: Sun, 22 Oct 2023 16:28:07 -0700
Message-Id: <20231022232932.80507-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In the sparc32 binaries, do not advertise features only available
to sparc64, so they cannot be enabled.  In the sparc64 binaries,
do not advertise features mandatory in v9, so they cannot be disabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index f527244aa4..bb1a155510 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -546,14 +546,17 @@ static const sparc_def_t sparc_defs[] = {
 /* This must match sparc_cpu_properties[]. */
 static const char * const feature_name[] = {
     [CPU_FEATURE_BIT_FLOAT128] = "float128",
-    [CPU_FEATURE_BIT_MUL] = "mul",
-    [CPU_FEATURE_BIT_DIV] = "div",
-    [CPU_FEATURE_BIT_VIS1] = "vis1",
-    [CPU_FEATURE_BIT_VIS2] = "vis2",
-    [CPU_FEATURE_BIT_FSMULD] = "fsmuld",
-    [CPU_FEATURE_BIT_HYPV] = "hypv",
+#ifdef TARGET_SPARC64
     [CPU_FEATURE_BIT_CMT] = "cmt",
     [CPU_FEATURE_BIT_GL] = "gl",
+    [CPU_FEATURE_BIT_HYPV] = "hypv",
+    [CPU_FEATURE_BIT_VIS1] = "vis1",
+    [CPU_FEATURE_BIT_VIS2] = "vis2",
+#else
+    [CPU_FEATURE_BIT_MUL] = "mul",
+    [CPU_FEATURE_BIT_DIV] = "div",
+    [CPU_FEATURE_BIT_FSMULD] = "fsmuld",
+#endif
 };
 
 static void print_features(uint32_t features, const char *prefix)
@@ -832,22 +835,25 @@ static PropertyInfo qdev_prop_nwindows = {
 static Property sparc_cpu_properties[] = {
     DEFINE_PROP_BIT("float128", SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_FLOAT128, false),
-    DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
-                    CPU_FEATURE_BIT_MUL, false),
-    DEFINE_PROP_BIT("div",      SPARCCPU, env.def.features,
-                    CPU_FEATURE_BIT_DIV, false),
-    DEFINE_PROP_BIT("vis1",     SPARCCPU, env.def.features,
-                    CPU_FEATURE_BIT_VIS1, false),
-    DEFINE_PROP_BIT("vis2",     SPARCCPU, env.def.features,
-                    CPU_FEATURE_BIT_VIS2, false),
-    DEFINE_PROP_BIT("fsmuld",   SPARCCPU, env.def.features,
-                    CPU_FEATURE_BIT_FSMULD, false),
-    DEFINE_PROP_BIT("hypv",     SPARCCPU, env.def.features,
-                    CPU_FEATURE_BIT_HYPV, false),
+#ifdef TARGET_SPARC64
     DEFINE_PROP_BIT("cmt",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_CMT, false),
     DEFINE_PROP_BIT("gl",       SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_GL, false),
+    DEFINE_PROP_BIT("hypv",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_HYPV, false),
+    DEFINE_PROP_BIT("vis1",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_VIS1, false),
+    DEFINE_PROP_BIT("vis2",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_VIS2, false),
+#else
+    DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_MUL, false),
+    DEFINE_PROP_BIT("div",      SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_DIV, false),
+    DEFINE_PROP_BIT("fsmuld",   SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_FSMULD, false),
+#endif
     DEFINE_PROP_UNSIGNED("iu-version", SPARCCPU, env.def.iu_version, 0,
                          qdev_prop_uint64, target_ulong),
     DEFINE_PROP_UINT32("fpu-version", SPARCCPU, env.def.fpu_version, 0),
-- 
2.34.1


