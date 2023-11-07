Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC89A7E33AC
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:12:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CS0-0005yw-GT; Mon, 06 Nov 2023 22:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRr-0005hK-VG
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:16 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRj-0001Th-Aq
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:15 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2800c221af2so4894738a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326486; x=1699931286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66ApnGauyIOyjoGgrQcp0zpcbmFv1rSgcJfwyoog9aA=;
 b=E9smyNzu+MMIWhX6sW422iiBI/MKSznPxjEurvYC+Cwzut7kyyCbI7sI+qTYplu4tG
 8HntvqAhkYkwmJFZk+MDpEjZSrvsbM7w/zzKrmCv+klEQT576NZR1jfGdLRqsO+GooJ0
 pYYbNZk8r/1LKOilH5ghq/DZCS2jvhOqJbO2F+js4VknJUowgzDA72WWpt4FGZjEsi0G
 3U9incHDHs+2PBABlJnTn89FSiPKPYko3M1c5ZpuveHcnWo7OlBL+3hhFMURo3T/xy4z
 H0kpwOTbu9TbAFyeEYNfj4oi21la8HrIv5NClCi0qu/fxqLZ42ogAir85DP4urH0qIVa
 xsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326486; x=1699931286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66ApnGauyIOyjoGgrQcp0zpcbmFv1rSgcJfwyoog9aA=;
 b=qXFLyS6qlUBRP6IHJrjKZEX2X/TgV79nOktCrTZ/wcA98VQNcycrS2TCpJ4sbTfyW5
 DdSXZmvpzkFIKSiNNb2LJOweld0gvvDWIkElfESS8ntZWe8lg7nDiYcgHHLmPjQa+Cu4
 noxfAjfVKwxiF5HRVxHp1nuvfF5+lg07W36nRMbiySeieXgGpzkySAGvy++1zU7du3Mm
 DUiecl1qNBobsxU18NC4BNFfORkmjbUdz8dDMSQQYRC7QdUIdW+dYZ/xduneftOifbyq
 pWJNU3zIJZvBbCAE3cXhdb+s3M5QtUHtQ5TaPSVn04yas3sIiOG2us5yphdKV9BTvOWg
 78EA==
X-Gm-Message-State: AOJu0YwdCp7RWQSUlYCAGU5h3QKjt9XnRIEUxfBS8lTsNX7AouP47Ols
 /MUykCc1krq1+/pdo81VOKmHqjLZElu9UOCPG58=
X-Google-Smtp-Source: AGHT+IFyvps4/lAnC9OqjDYOBBiXME/gf7FCkDVYvzxoqgiMihNBFoyFZZxKHH59jf/BevuKNMumKQ==
X-Received: by 2002:a17:90a:2a86:b0:27d:4b20:3604 with SMTP id
 j6-20020a17090a2a8600b0027d4b203604mr22815684pjd.27.1699326485811; 
 Mon, 06 Nov 2023 19:08:05 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:08:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 77/85] target/hppa: Clear upper bits in mtctl for pa1.x
Date: Mon,  6 Nov 2023 19:03:59 -0800
Message-Id: <20231107030407.8979-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

From: Helge Deller <deller@gmx.de>

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 9f129a230b..4102f5faf3 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2060,7 +2060,13 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
 
 #ifndef CONFIG_USER_ONLY
     nullify_over(ctx);
-    reg = load_gpr(ctx, a->r);
+
+    if (ctx->is_pa20) {
+        reg = load_gpr(ctx, a->r);
+    } else {
+        reg = tcg_temp_new_i64();
+        tcg_gen_ext32u_i64(reg, load_gpr(ctx, a->r));
+    }
 
     switch (ctl) {
     case CR_IT:
-- 
2.34.1


