Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F4B74D9CE
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:23:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIshv-0007l4-FJ; Mon, 10 Jul 2023 11:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qIsho-0007jl-2x
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:21:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qIshl-0007w0-EB
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:21:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso51659905e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689002494; x=1691594494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9OpS0FI8bXPcgU4kwQax5JMttcbv9wmKGoxNnD4iVQ=;
 b=VnD6288+t1gQ3MpqRnDe48Mbmr1nJU2clWeTSY4D8Zte9kJMZjAmPWUJ/YxD9OTwOu
 n6Gp60DPU/D0E5AVF/x57WskwT/5uD6YTOuyeFLnFb/qpCNcEyreCQ1uroGkZmX/+jj7
 nFMmbXul+fl9Q8AT9Idxzabvv9MS7cHYiPZPSif+V7PU1824TQxgtHosVZg7HKznzXuY
 Oo61RjESfpc/eDH4c8mPWautzgJaOTMubgitIijo8RPBEmX4/ZUNsmBtKmpH5pvUhITM
 XKPIzLj0zdiQWTgiaD0GST53ikyzhn/6zg/4vDMVqClwrJ3p+4Zj5kZAe0qYF8Ne8D7I
 joyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689002494; x=1691594494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d9OpS0FI8bXPcgU4kwQax5JMttcbv9wmKGoxNnD4iVQ=;
 b=Z1LHQemDrrNidN3md4PK59G/ZwLPySQ/4KFsuw9VSetD250/BTqp2WM/JuFBAITTWu
 xoRIZbffjtUOuuvs4GEAa40SMtjIFlIS2iTST7nyxQ9ZsF+dLuowoqVRuIPUBIe3MfH/
 Bt+u+iw8pUER01Qhm9NPJtMZYG+YsydEMyd3AmAWjVqRvsuWmNWRq4QTCi2jNeXtKaVy
 LozDEuI4rF6J8T+RUWll36XEMy7Blul0XrXfEnbFZv5wbof3XSjY9FFKqH/yORVMETUy
 Lio8Xy+zHzPz5JMYcRJm8lKnu+kuRr9Jc+rYazd7wsNPZnU/qt5DELSRoDY0pnrT/EMf
 VoZw==
X-Gm-Message-State: ABy/qLbRSPiaHS6GnvUKghUtKGX3XL7z6jObwc+F5VLCzn7pPaU5Tw7x
 y/VOknTdsdtEUDFo0ZZ2qdQ5cQ==
X-Google-Smtp-Source: APBJJlEtjQ2TLQI8txoZrcfx4bpl3Lrour7jcaZWOWloQjAza16VXQ3P3qLDbDZuyw/NJlS5sh9kxw==
X-Received: by 2002:a05:600c:c8:b0:3fb:ce46:c0b3 with SMTP id
 u8-20020a05600c00c800b003fbce46c0b3mr14205833wmm.35.1689002494546; 
 Mon, 10 Jul 2023 08:21:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v24-20020a05600c215800b003fa95f328afsm10578798wml.29.2023.07.10.08.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:21:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-8.1 3/3] target/arm/ptw.c: Account for FEAT_RME when
 applying {N}SW, SA bits
Date: Mon, 10 Jul 2023 16:21:30 +0100
Message-Id: <20230710152130.3928330-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710152130.3928330-1-peter.maydell@linaro.org>
References: <20230710152130.3928330-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

In get_phys_addr_twostage() the code that applies the effects of
VSTCR.{SA,SW} and VTCR.{NSA,NSW} only updates result->f.attrs.secure.
Now we also have f.attrs.space for FEAT_RME, we need to keep the two
in sync.

These bits only have an effect for Secure space translations, not
for Root, so use the input in_space field to determine whether to
apply them rather than the input is_secure. This doesn't actually
make a difference because Root translations are never two-stage,
but it's a little clearer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I noticed this while reading through the ptw code...
---
 target/arm/ptw.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index c0b9cee5843..8f94100c61f 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3118,6 +3118,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     hwaddr ipa;
     int s1_prot, s1_lgpgsz;
     bool is_secure = ptw->in_secure;
+    ARMSecuritySpace in_space = ptw->in_space;
     bool ret, ipa_secure;
     ARMCacheAttrs cacheattrs1;
     ARMSecuritySpace ipa_space;
@@ -3200,11 +3201,13 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
      * Check if IPA translates to secure or non-secure PA space.
      * Note that VSTCR overrides VTCR and {N}SW overrides {N}SA.
      */
-    result->f.attrs.secure =
-        (is_secure
-         && !(env->cp15.vstcr_el2 & (VSTCR_SA | VSTCR_SW))
-         && (ipa_secure
-             || !(env->cp15.vtcr_el2 & (VTCR_NSA | VTCR_NSW))));
+    if (in_space == ARMSS_Secure) {
+        result->f.attrs.secure =
+            !(env->cp15.vstcr_el2 & (VSTCR_SA | VSTCR_SW))
+            && (ipa_secure
+                || !(env->cp15.vtcr_el2 & (VTCR_NSA | VTCR_NSW)));
+        result->f.attrs.space = arm_secure_to_space(result->f.attrs.secure);
+    }
 
     return false;
 }
-- 
2.34.1


