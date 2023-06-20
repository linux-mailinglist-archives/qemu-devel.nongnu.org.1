Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE4F736A6C
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:10:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZDu-0006M3-RQ; Tue, 20 Jun 2023 07:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDs-0006KZ-Ew
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:32 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDo-0004Oa-QP
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:32 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9741caaf9d4so558700966b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687259307; x=1689851307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lOYUQGr/W2hN41A+MbMW4B7XkhWFliC6iC1qe2q7c8=;
 b=otR5FyBFmDpDB3KOv+EmuXpJDlYSj9cbY9u/cCcPJs95SB0XfUIJbynjfqWAxOrcLg
 fcqQcLXDXW0KJHiyjEa3MPMqcNi3Nfqh/lY0BdkzlMGpCJp1kimEU9qsIUvpbc7ZPYzU
 GkyuyqU2AxvV3FDvmru8vMh4ljqUEsnow08jzCAUpmAjuM9l11pFxEQP9H6H4jXn/ma8
 RoAXNOhAckj12oXu3jjgNbIGqQqhrV60bIGZTfoX8RvT4i7NRSF6YzKEwetCPPWEgSh0
 a+ySe9cgCz/vtwFtqSSzo4Xr4nhBil+ypJV8tmEJEqbObZbdnmiYO6EBSLigvXCQJ6Js
 Nvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687259307; x=1689851307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lOYUQGr/W2hN41A+MbMW4B7XkhWFliC6iC1qe2q7c8=;
 b=BvUe1SruznI1IClOWiM3HNXeZ/CHYr39Mowd6PYJ6E3N36kCvTFlk/8M5fIV8DmGa0
 jeWAhZifKbwM1VfoOhuJl/IKE6SMu2ZrTFviYNY1UNTYap/0NZ03CLuQQURBDeP5of0R
 xsQ57VplxQWs+FsZTh/uq//vyk65GDrTekggOyvlGkLOerQmfJnON7IfbH/YfzQphCEe
 6YgPKjEAVhrBHl4igZYTtwNKpGXesMqnFtyJHejMRgxWJG6lHXpA51180JXnhVnqMY1P
 X4MmYQR3NHkxKyOEbiVgsIVdUmJAO7n1K4bw1HwS+ksDDdBVMVrGymhh6yyl4/ZsjFLQ
 V8QQ==
X-Gm-Message-State: AC+VfDzTR+1HTzOB2GrHpoE+7PDTivAWcYk89ZTQcCujfCNAqBUW5mhg
 RyCTfETFJPH7HXE/HW1ItqAYNtD4LPfjRu0KF4wa5k4Q
X-Google-Smtp-Source: ACHHUZ4ImoT23NrB56AzXgPgfMApy2Hv7kvtGT+5+kmli0WLwr4dqgf+J8Y0VO+mvd896Cq+FVWGJw==
X-Received: by 2002:a17:907:746:b0:962:46d7:c8fc with SMTP id
 xc6-20020a170907074600b0096246d7c8fcmr11699590ejb.21.1687259307466; 
 Tue, 20 Jun 2023 04:08:27 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm1170687ejj.49.2023.06.20.04.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 04:08:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 19/37] target/i386: Use aesdec_IMC
Date: Tue, 20 Jun 2023 13:07:40 +0200
Message-Id: <20230620110758.787479-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620110758.787479-1-richard.henderson@linaro.org>
References: <20230620110758.787479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This implements the AESIMC instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 0a37bde595..893913ebf8 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2215,15 +2215,10 @@ void glue(helper_aesenclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 #if SHIFT == 1
 void glue(helper_aesimc, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
-    int i;
-    Reg tmp = *s;
+    AESState *ad = (AESState *)&d->ZMM_X(0);
+    AESState *st = (AESState *)&s->ZMM_X(0);
 
-    for (i = 0 ; i < 4 ; i++) {
-        d->L(i) = bswap32(AES_imc[tmp.B(4 * i + 0)][0] ^
-                          AES_imc[tmp.B(4 * i + 1)][1] ^
-                          AES_imc[tmp.B(4 * i + 2)][2] ^
-                          AES_imc[tmp.B(4 * i + 3)][3]);
-    }
+    aesdec_IMC(ad, st, false);
 }
 
 void glue(helper_aeskeygenassist, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
-- 
2.34.1


