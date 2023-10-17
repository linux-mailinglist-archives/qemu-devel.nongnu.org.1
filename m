Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 246847CBAB3
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:14:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdK5-0008Q8-9o; Tue, 17 Oct 2023 02:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK2-0008Ow-QL
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:54 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK1-0003pw-2C
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:54 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c9d407bb15so44465445ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523172; x=1698127972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZH3dMD/AA/crmsUs16Itr1WvEaqL+uLcI9qPlF9Ii5g=;
 b=h3F/g/IjaouhrCGzes/366bxwA25se4/Ae7ymFMAtV7TtcRXYsAb9NadZvi0cQgqNL
 8hM+mY47rWX/T9V9BWpIcg2HjrpGriQCHnJYyudswiAHhqc8z/tLIjcDMZFsAzsuga0Z
 OALI/w+XNUNoHgy/qD7tWyrk7DPnubf2ygBGAGEWZn/cwV2MAwsZ20cJZJhvtV+9Rn+3
 Zi+So98j2+4KpHMjkOpUZk4zhV0VhNiLRGkYC4c1OjWIGdI+29dXOS/0zCfOKdkooq3f
 mXVY75cXDfpcS6BOckidy+TtQrVS6jIuRDuFzI9P0Ja6B7KrZ+lV9W8aZ8LTDp8g+rVT
 zq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523172; x=1698127972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZH3dMD/AA/crmsUs16Itr1WvEaqL+uLcI9qPlF9Ii5g=;
 b=oIdwk57fnxBv8o5OeRAL3M73V2kbYIB7YcxTgm12UtqCfkbztlOA2jJpLN+QrknUSc
 Jv+BdBJMJuTHzVwMQbkndu2uI6azxBebPTl1iDVUTx5vNuLMT/3Tqe5uYVYeTFiRaL/r
 flfBlZ0EfEDWO9skqX9UHFRGlaRY4qvzo+0Oxp5QIm2eC/V/T80tXU1s7kGRQ8ZRMHtL
 pl14yGYKKbu+K8/bAALZ5BHjX9iHvxKrKIYuouxFVTvdudfP5pHkGHodanwqumiZ06TR
 3OGaD7gvQpQi2kum3nYNQn9bhPprPYpbEVFjxFDITxda4BZHk445iBHq4gn9BirWzK+o
 RgZQ==
X-Gm-Message-State: AOJu0YyBX6Pc6p3ESnbXZfBRJXegWbiUTEK6Ws75XUZTi52LFoU/DS94
 T2KketspxooPU93syqeEV2gLEzzsKUTNfKwHOmE=
X-Google-Smtp-Source: AGHT+IG62IzE/9xuGXVZStDsVRG3j5yl+CazTyjPJ8oFQOv8hZwwRXW8r0Y/WEg3VM8vlQAKGL2PqA==
X-Received: by 2002:a17:902:f0d2:b0:1c9:e508:ad3b with SMTP id
 v18-20020a170902f0d200b001c9e508ad3bmr1280260pla.14.1697523171738; 
 Mon, 16 Oct 2023 23:12:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 07/90] target/sparc: Use CPU_FEATURE_BIT_* for cpu
 properties
Date: Mon, 16 Oct 2023 23:11:21 -0700
Message-Id: <20231017061244.681584-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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


