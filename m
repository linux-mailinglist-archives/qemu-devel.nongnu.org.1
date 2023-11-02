Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A287DEA59
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:46:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcc-0000Hy-HB; Wed, 01 Nov 2023 21:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbN-0006iQ-8r
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:30 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbJ-0002DP-Ou
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:27 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc329ce84cso3327915ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888864; x=1699493664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyMEcH+XK8Eknr0xQsBIB3lMxzOGskoIpAWKROo/aKo=;
 b=yEfILW/1+/WndNI6j3OMo2Tj4lACg0VHUJ135DiukZHCSBhC4b22O0jBxBGYDyavHE
 Unp2dgKLbHCuNIZDVCjg3kUtNJQfwY0QUmTyFnTFzzI0W886E+c5T1z7WfspJQg8GTss
 Adb4Olg0eIBWs5qCED+aM2yN30Th/Zf7UiJb/VmuszVt/9LGItrgPZmlgE7DrFUaIA1k
 W05/sZR8Ym9qTW0lOtWVhXJ5wTKyxhiY9CWy9dHmpZGXqSlvQBHLPfrq0Oh5lv/8UKAU
 IJKBBGHH333wsiiyN+J3pG+EtKfXeIfjTamxIv0Tv13Vn75YP+q5sqqVuC404KXZRmy0
 aULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888864; x=1699493664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IyMEcH+XK8Eknr0xQsBIB3lMxzOGskoIpAWKROo/aKo=;
 b=QbJWxkoOSs+HJccmjJf464Ek/hcThiDdN/lzEgQP3g611CWrQeIkJLvcucJz34FgpU
 6hX85suzs4wVGkUbldbxs4yHm6ASLONPutKpbyhEGOJ92HJZPHhdMfzWF0O6zjd6na6m
 mRzhIFVQSvjfLZnutMnJMhDRn67wYf9peVskcgOfbSkf8zUbDTXRP6qJlDgfBZL4rdfA
 sEji2G/ZrfqIJ94L1BkLjX26E2dAAqha3KI5CaBW6by9rlqASXIFTh0E3/UTVlxKbS1m
 JoN0N0IaMXViRkgRm2gfwZdMnnv/RiTLKwHOExOVkf4lbEYHS4HtX+2wQijmr29wi+xs
 688w==
X-Gm-Message-State: AOJu0Yxz9dNYw46iJslTnMvRMwUraxoYZ0pi8y2ZO2x4q8hjxjNGA64f
 NH07g/H3VimdzzPuMVUtwrXLuNGCXfNqjETHt18=
X-Google-Smtp-Source: AGHT+IHps9FFCQvtVHxGpu/T22ecdScBRw2ZPpKb9gyklKYUOtNlofbOFAbWcApqaLWEPJxMAWiuJQ==
X-Received: by 2002:a17:902:e5c2:b0:1cc:3fc9:7d09 with SMTP id
 u2-20020a170902e5c200b001cc3fc97d09mr13100680plf.15.1698888864317; 
 Wed, 01 Nov 2023 18:34:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 79/88] target/hppa: Clear upper bits in mtctl for pa1.x
Date: Wed,  1 Nov 2023 18:30:07 -0700
Message-Id: <20231102013016.369010-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
index d9595c5c7c..f7621590e4 100644
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


