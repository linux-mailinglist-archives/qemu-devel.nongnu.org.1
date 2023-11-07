Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC517E33A3
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:11:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRT-0004AA-Ph; Mon, 06 Nov 2023 22:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRO-00044q-Dd
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:46 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRM-0001N1-Nw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:46 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-27ddc1b1652so4717921a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326463; x=1699931263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qv/a5qw7IRMvc9+1bsPwBvAxjMkczYjB4ck+5MvAjzA=;
 b=l50B/V4f30kGqcKindY5tUGI+lLnfOGm51veJhhJtqCUm4e8D4Xn8kaUJZ2AUxxhbi
 lOa/fJ4YyiMW+oB9NB1IzimBBFXMWudvsXJ+PwQFbFGD73KLROH8OyUh8TJ+0vHtFwz2
 JntBqNzy5VcKfaGhdxdFm9q/rzS40cdgykV9Jc6+yt7CV7+Zap6cwfy+InZEpamHfJQ6
 V0Be//o2WH4D2aONAAmGgOTozi13XVBA2vTODFpjBrcFZNepusIoEekapRuMM+xLSZ1u
 8G5ENnMmNUO9W7Frp213aG+RSBuNi6XCg6vXNY7k6b8mHdKCUNdpCs24ho3f2EdE6wC7
 +mkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326463; x=1699931263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qv/a5qw7IRMvc9+1bsPwBvAxjMkczYjB4ck+5MvAjzA=;
 b=Nqx5fZPLtKChBgw6rwns4M78LxpnT+gTok2SgAKJgZtMEAvP6KTIcGpV7wBGXcwutL
 X5IIhK7SzfPHeSw1Qrd+8FD5hjVZCyuwPgyhs0UPQhD/wNRDF3qWKghbv1EP4bKN/vVp
 G4dLmZ3H3JNbIeu/AY/cEaB2gmLOlv4nwqsLXbvvpdpGXU2/S8YEa/veVUKHEbFqwkkK
 kmen3Ynqfm+mvwhIKr1Sne7zDvfRCyLO4rXGoDJt39iFp/K667jGMp/euJJIqauE3kjO
 tgTanzWrfcijaeEbs3+x6PB4RPEnCUSq0rLNUGrfgQgc8ul2ERCvfvEktvFkwo6v0avG
 UzQw==
X-Gm-Message-State: AOJu0YywVCuhU3uf+ljAf84sAlvzqLkxDXyDtzX4Wn9zaLK8L9qKTrv1
 oeJUUz+i+EnGNDVQ5PWPuq3um+Jvf8SSitXBV90=
X-Google-Smtp-Source: AGHT+IEdiNQn4OZG/QbRA6heo9bfI2BxkRBc1TpiCRtia+cBux8O5LLT9BoyCa3QZFf1KhM2+LsmZw==
X-Received: by 2002:a17:90b:3654:b0:274:755b:63b8 with SMTP id
 nh20-20020a17090b365400b00274755b63b8mr29031043pjb.43.1699326462877; 
 Mon, 06 Nov 2023 19:07:42 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/85] target/hppa: Decode ADDB double-word
Date: Mon,  6 Nov 2023 19:03:28 -0800
Message-Id: <20231107030407.8979-47-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7f767fea64..1b4fa401ba 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3143,6 +3143,17 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
     DisasCond cond;
     bool d = false;
 
+    /*
+     * For hppa64, the ADDB conditions change with PSW.W,
+     * dropping ZNV, SV, OD in favor of double-word EQ, LT, LE.
+     */
+    if (ctx->tb_flags & PSW_W) {
+        d = c >= 5;
+        if (d) {
+            c &= 3;
+        }
+    }
+
     in2 = load_gpr(ctx, r);
     dest = tcg_temp_new();
     sv = NULL;
-- 
2.34.1


