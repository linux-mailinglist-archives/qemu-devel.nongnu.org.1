Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ED17D2139
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:02:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRW2-0000VF-UU; Sun, 22 Oct 2023 02:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW0-0000Sd-95
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:44 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVw-0001Vp-Kp
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:43 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso23986855ad.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954439; x=1698559239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZH3dMD/AA/crmsUs16Itr1WvEaqL+uLcI9qPlF9Ii5g=;
 b=STO0GjONFpggK/GNEXvf8X6Pk/T1KNYoRgP8/IsfTHiZDQnT3qSrniSF94bhIRiMR8
 K5+TK3AdSf1X31VoHl2iCsZRvRLxcEpmXxF4UIt+xxPFZVInSBD9l1NZyt10zbQ6hVd0
 V5571Xr3E9dQe3SIUfz848sHmDBHo2QSSKTQlrj1GgzA7WQYvTJWmpjg7kcywbxOWNxI
 f2N3q31a6aJFyyJoiAwY65IQewVAnv+cwJztM0iIqqWZp/iuRw9zrUY0WkTFyTQ7owwE
 jgXmE7QpbKHgUVOMHiecnGrpwZpVjwyD2df7L/ba5Fx4mvzL0dY4z0g51/2oAUbQrnlB
 ACTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954439; x=1698559239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZH3dMD/AA/crmsUs16Itr1WvEaqL+uLcI9qPlF9Ii5g=;
 b=U5sb5/MZW8/Um262a+VFFbwIaAOJCZ4ER9qvwC1fIyjEBj7Ikp7m9JeF53rrNJCTbR
 TIzLTqoAftVNRwMf65sgC5lmoPSgJ6i++HDBPWp9gIk9g2Q0FUzVKe7x5ozr3L0psbWW
 DtVU1TF67zA//OtiadRcoXdR6jr/iMvjOGc3TjvsMlATAbw7FVp4IIOnWy7lLN3css4D
 e0g+H0vm3/BCqvXvO7LVXlXawedE8cVmJ7Gew9CLbvyfU5GKWtnwlg6IHH2SAClkjVFL
 qSrJM6hHSke3rgRv3z1Xp/m8B5Y81WBGzePWrV4AYUG2JhA2tvVvJkxC5ML09mC7KDcQ
 3yWw==
X-Gm-Message-State: AOJu0Yy3gJOsia4gPUyxjOc7dv+SmdT18hczuVDv/8bMsOsGIPtuN/mr
 kX5gAFomt9ynnQO/THSympZnvvXdM1It5QYDn8I=
X-Google-Smtp-Source: AGHT+IF9aqN4srTcSD3TuC96QrQ6rLH6ZGhcPwEDHZC2AWFWaXw34SlO532yI77/Ruk87Eniev4+4g==
X-Received: by 2002:a17:902:ec87:b0:1bd:e258:a256 with SMTP id
 x7-20020a170902ec8700b001bde258a256mr8474213plg.32.1697954439002; 
 Sat, 21 Oct 2023 23:00:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 07/90] target/sparc: Use CPU_FEATURE_BIT_* for cpu
 properties
Date: Sat, 21 Oct 2023 22:59:08 -0700
Message-Id: <20231022060031.490251-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


