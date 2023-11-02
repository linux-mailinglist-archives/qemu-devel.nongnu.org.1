Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AC67DF913
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:46:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybfI-0003Vi-PC; Thu, 02 Nov 2023 13:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybek-0003Hi-7h
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:39:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeh-0002zF-5H
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:57 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso9422745e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946733; x=1699551533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q7gNhyKm+XeQ9PyUruTJ7pm1OOgSYvOzpb6f9nuBc4M=;
 b=yAbiL+LBGQmM+teNocOqgKn6/Xu4h7l66wgctuplQV5H0R+1Og+dFwd9a48R49q2m0
 bD0vLc0+o65yWXEkt5ifjxbCyzTHUBN1LV3BvGCNlC04KKgP+OsNYLfOr1odLHnJTwxK
 c9mf11eFnbjDz8tPk2KRL49hop3iSdbHx/uXUMbrSc+8WKObk//XiACdv5nqHw7XhmDg
 7FVAu10GAvyVbxIMYoNzAytHHouEOWqN3Sgwe0f0KR1WTxDoHGEHZ5o/7F1X7q9PEFTS
 99yqDGFuFk1CfVH3zWW+xmrVtk1BJ6iuWmbPIXN7PYCfKUo5UvrNnw1Xvj3Zb4Q26H5d
 qL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946733; x=1699551533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q7gNhyKm+XeQ9PyUruTJ7pm1OOgSYvOzpb6f9nuBc4M=;
 b=cnZ97TIKuB4/9THN84mEFy/74ic6RfEGwCYfE0zohr7+4QC9Di951pnncSBZUOWPJ8
 mBVuZ16rWmQVBSkMRC7kucUJJaOFeaLz/F6uEQL5zxdWqfTXq8xIzc1nArY7YaDAvQHp
 TYoBoToacVf7BU/FEal35M6f/b2ZmmEtfpjBsz0iDKmphWhXHwqZ/oEYtibu+qsnUcy5
 G1Cnucw8MzA0fYgv2ATwd78ckCB7WK9CElppUpeyiDLtc14B+iWLKHq/rPsGbb+kTGt5
 D0EQSyhVGyRJY4k+WpAy6W0qbQxC23nGyD8eIXiAVcgzxu7WcOExLPRVhHB7HvYWPwqT
 1KCA==
X-Gm-Message-State: AOJu0YxM5sNfkwM9UQcapjh8KCXm6eyXSP9M5AW4lfaZWZsrWsAZPj3n
 2YuknA3OpUOtmALL0GBpJURX0LlEaQanYDoMsI4=
X-Google-Smtp-Source: AGHT+IFk4N0bWq93qDCUyOMMaVxyH2BaP6piyj5H+D8zzZfMTbRMUjO2UGVVt0OzAEpcg+Be07eP4Q==
X-Received: by 2002:a5d:6c68:0:b0:32f:7f09:160f with SMTP id
 r8-20020a5d6c68000000b0032f7f09160fmr14221324wrz.12.1698946733563; 
 Thu, 02 Nov 2023 10:38:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/33] target/arm: Correctly propagate stage 1 BTI guarded bit
 in a two-stage walk
Date: Thu,  2 Nov 2023 17:38:32 +0000
Message-Id: <20231102173835.609985-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

In a two-stage translation, the result of the BTI guarded bit should
be the guarded bit from the first stage of translation, as there is
no BTI guard information in stage two.  Our code tried to do this,
but got it wrong, because we currently have two fields where the GP
bit information might live (ARMCacheAttrs::guarded and
CPUTLBEntryFull::extra::arm::guarded), and we were storing the GP bit
in the latter during the stage 1 walk but trying to copy the former
in combine_cacheattrs().

Remove the duplicated storage, and always use the field in
CPUTLBEntryFull; correctly propagate the stage 1 value to the output
in get_phys_addr_twostage().

Note for stable backports: in v8.0 and earlier the field is named
result->f.guarded, not result->f.extra.arm.guarded.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1950
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231031173723.26582-1-peter.maydell@linaro.org
---
 target/arm/internals.h | 1 -
 target/arm/ptw.c       | 7 +++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f7224e6f4d9..c837506e448 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1181,7 +1181,6 @@ typedef struct ARMCacheAttrs {
     unsigned int attrs:8;
     unsigned int shareability:2; /* as in the SH field of the VMSAv8-64 PTEs */
     bool is_s2_format:1;
-    bool guarded:1;              /* guarded bit of the v8-64 PTE */
 } ARMCacheAttrs;
 
 /* Fields that are valid upon success. */
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 53713e03006..1762b058aec 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3032,7 +3032,6 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
 
     assert(!s1.is_s2_format);
     ret.is_s2_format = false;
-    ret.guarded = s1.guarded;
 
     if (s1.attrs == 0xf0) {
         tagged = true;
@@ -3175,7 +3174,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     hwaddr ipa;
     int s1_prot, s1_lgpgsz;
     ARMSecuritySpace in_space = ptw->in_space;
-    bool ret, ipa_secure;
+    bool ret, ipa_secure, s1_guarded;
     ARMCacheAttrs cacheattrs1;
     ARMSecuritySpace ipa_space;
     uint64_t hcr;
@@ -3202,6 +3201,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
      */
     s1_prot = result->f.prot;
     s1_lgpgsz = result->f.lg_page_size;
+    s1_guarded = result->f.extra.arm.guarded;
     cacheattrs1 = result->cacheattrs;
     memset(result, 0, sizeof(*result));
 
@@ -3252,6 +3252,9 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     result->cacheattrs = combine_cacheattrs(hcr, cacheattrs1,
                                             result->cacheattrs);
 
+    /* No BTI GP information in stage 2, we just use the S1 value */
+    result->f.extra.arm.guarded = s1_guarded;
+
     /*
      * Check if IPA translates to secure or non-secure PA space.
      * Note that VSTCR overrides VTCR and {N}SW overrides {N}SA.
-- 
2.34.1


