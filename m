Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC2474C48F
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:03:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxi-0000YX-08; Sun, 09 Jul 2023 10:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxP-0000P9-GX
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxN-0000d4-Bj
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:11 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc656873eso47235425e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911208; x=1691503208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ineMFXHMMUsTtHLB4+TRmNQDsbNNDE8LTO9PLI3JgtY=;
 b=LIL376NngMbnjromVYy3xH1Oq1n7Up3N9FTKjY/aABCKs1ybOMrzr1UUzgvJLfFzFH
 tq0dOmEQtR5nLSpDLo7a/ryeQ82KCsc8aegr6YWHvEpbXz3N+b7xaAhhCG+vAQefDNdX
 rHK0GmaDwdFhjugZ4UYpTAK5kDW5cE5B1i6CeEM0fJr7bs1KChRxoMG3kQ3eVQ18w8ny
 maTV5dzAQCt5jN+vvLMSvuEpDW33Do2Pyzo0wJGj62MWCekuyEColAOKIjC3rORzIBIY
 /yLKgfDR6//xfhdBcae6byX54Tu5LekHarlQCvwPUakfjfffecMHbsSt1cdatwdpomb9
 sing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911208; x=1691503208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ineMFXHMMUsTtHLB4+TRmNQDsbNNDE8LTO9PLI3JgtY=;
 b=E2JycU+5heetRLAdqpiJj7UFUpKJ/cPrTBfwKbjuo0/ClycKueQbGFyW6TT9IWmYZ+
 R4AnOhaBC+oIkaXtSQ4g4QYchQPnT2sHsknNOa2Res3XKS4FrCl81fQa55Bp8eJBnzfe
 pijfJRRPy83yWgExU3waw9+DmN3d9rmrU6KCS04i+yIjNThAMaGo2Vv6eprjsxNuL72o
 mhJFic1BLq3rxN0aEUsBWbjNmUpNzrbXsZuLUlpy76fy/cmkC75kiCfnfPcSQ0rWG9T4
 Fiizl2XFBnfC4ie/aI/Ktk8Vk/vpSIKHz8dqKCOpNB/uwLVpPnHNO1HNAgNxJj2iFa+5
 qtag==
X-Gm-Message-State: ABy/qLbhHsENy61ftggw9tTHwbKm+M/Xs2A8+OuoncRwjhuRDfijVduI
 7JohTSi4iKilsokD/tdNfymNpT2QcGF2aeWJnkpJyQ==
X-Google-Smtp-Source: APBJJlEl8sfHanHv2sBURpgQkrqprwY0TVASA/A56Qbtr1uORrKdZmmJq4SG3mFVuQwMM6Vw+cdXeg==
X-Received: by 2002:a05:600c:2105:b0:3fc:3e1:7105 with SMTP id
 u5-20020a05600c210500b003fc03e17105mr5790195wml.24.1688911207602; 
 Sun, 09 Jul 2023 07:00:07 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/37] target/i386: Use aesdec_ISB_ISR_IMC_AK
Date: Sun,  9 Jul 2023 14:59:31 +0100
Message-Id: <20230709135945.250311-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

This implements the AESDEC instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 93a4e0cf16..a0e425733f 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2162,16 +2162,12 @@ void glue(helper_pclmulqdq, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
 
 void glue(helper_aesdec, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
-    int i;
-    Reg st = *v;
-    Reg rk = *s;
+    for (int i = 0; i < SHIFT; i++) {
+        AESState *ad = (AESState *)&d->ZMM_X(i);
+        AESState *st = (AESState *)&v->ZMM_X(i);
+        AESState *rk = (AESState *)&s->ZMM_X(i);
 
-    for (i = 0 ; i < 2 << SHIFT ; i++) {
-        int j = i & 3;
-        d->L(i) = rk.L(i) ^ bswap32(AES_Td0[st.B(AES_ishifts[4 * j + 0])] ^
-                                    AES_Td1[st.B(AES_ishifts[4 * j + 1])] ^
-                                    AES_Td2[st.B(AES_ishifts[4 * j + 2])] ^
-                                    AES_Td3[st.B(AES_ishifts[4 * j + 3])]);
+        aesdec_ISB_ISR_IMC_AK(ad, st, rk, false);
     }
 }
 
-- 
2.34.1


