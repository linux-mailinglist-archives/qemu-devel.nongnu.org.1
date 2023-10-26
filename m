Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FB97D796E
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:28:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2s-00077E-Q0; Wed, 25 Oct 2023 20:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2o-00072e-1B
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:14 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2h-0004rA-Lb
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:13 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c87a85332bso2311445ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279358; x=1698884158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lVqtOTdE26FeikcQeSUZ6gzaDd5J2ZKDmGo0pFRcFos=;
 b=aQWOWJMpzZsMkg3EhGGeBZgGUQJwZox9rkIK6jjHVTyhdcXBo2zPLTYBSKuQJpTYNm
 nFPrOdEBYmacHsdxjDmz1x5WMSebK89C7YMViBSX5bla28Icex98CbiAdK+acNFQJwip
 o87xD4ZicZLpyfqcugYR6zqbg3uvWDs1WUlVgwXtdRSPZDeQZCHmBIg1X6PUGcOoPAOa
 EVOgtyxlJC8gtBlNGbUDAPmFyKGhFGbxTKeEWSVwLSChuMepULvlJmji+hVmihIIsIpN
 z4YATzl5pQmU3kv+S1s2Q6UKNdVvWs2DHvL0pDMXeA7hdMzWxdjTxSVasceuSdEWTs++
 NtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279358; x=1698884158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVqtOTdE26FeikcQeSUZ6gzaDd5J2ZKDmGo0pFRcFos=;
 b=MQRVPv9uFJ2heaL6xBKoYIOVUvci14tx3r6qB2ivOodKVwddKLyu5rnYzZXJGYfrN/
 9CrDre5yqIoXAqcsZdh+jayOJ2TjN7GuCuwgWGm3Oi7XcUxN1eQKcJTqwwRPE3SusZWa
 HOkrL2hUcu84ReZ09+SXsZlazbmh2IJssoNRmmolBEp7ul9HHh+AdMsUsgELEZFtm0/1
 eIDIDE1pKOIwjRzgFxU0lrx+dFCPLsEEeg/XNYsnQ/iRUW3LbOZRIEG/JGTS7r/tBeKj
 iXbcb/CKkJu//w95jCquoVlJBPhGdlgsEkmvxyFbDI/ig3nIOjvipXj6lSeQ7cvRSvXC
 F/rQ==
X-Gm-Message-State: AOJu0YxiyCKa8gT16jSr9WvKsLvTxdtaqyyzALY83prIpgZ1nB8W5G7D
 ZY+d63rX6nKZrmYnsqR6Gzk0UDgLyEPjRPpCnD8=
X-Google-Smtp-Source: AGHT+IH5oE+4QHtXH8Br62l2u3Uvj9FTE+MKvI5ULEq5Qje7Ytx19BynHScuRUN00xeTzeDcqAqUAg==
X-Received: by 2002:a17:902:c602:b0:1c8:7822:e5c3 with SMTP id
 r2-20020a170902c60200b001c87822e5c3mr14284444plr.47.1698279358399; 
 Wed, 25 Oct 2023 17:15:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/94] target/sparc: Partition cpu features
Date: Wed, 25 Oct 2023 17:13:56 -0700
Message-Id: <20231026001542.1141412-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


