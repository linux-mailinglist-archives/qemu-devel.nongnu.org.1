Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 896577D59AF
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:25:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvL98-0001VR-9f; Tue, 24 Oct 2023 13:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvL91-0001Kc-JP
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:24:46 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvL8z-0000qr-Vx
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:24:43 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c509d5ab43so72294591fa.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698168280; x=1698773080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=whe7VhM1QRrMglSRu5qWCi/P7ekDVJP9PS80iqT8NDE=;
 b=NJ+VHedBJ4QLSYxKt2OhOyWrO9WiZP2TojcDbETa6eR9/0/N2io94rp9FNQDg2T3ZH
 qhslUyKDGtDjGcjnWBSloB+iFJfVZFcYrN0+cpOIfXD6Kg5O+GhKcUK6dsksYN7pGu9b
 SaHcXc0TOh/p1YPVm/FN8a2TY/GOilwVLdSRwyApkiBNnWIAwXDMkaTvOFi5nQiF6BwU
 wb/yS3ta0M+ZYOVUO3K2xiDUWf/dVwHIYvTbNfjCuQS+5S1nz1V07K8lw3RqGXg/AIMd
 5IrZpTrcH05QfLbsVaDRD4folEfrI5HbF1CUNgEZUnttA947NCXiLf30AEeQEyjKNYEr
 nN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698168280; x=1698773080;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=whe7VhM1QRrMglSRu5qWCi/P7ekDVJP9PS80iqT8NDE=;
 b=DpwmbIbvOGf1N+nWmSZOuPE+oDMjP6C8mVDyBL5IAnoYvzlKwdXOIrhO25bvZbdbbq
 fOhZU0DhLrbQlrO5QPeOJgHBP+BF/FC2zBnKRLehXXPZfL4lkaCqwS03iYBe3Z/fP/OK
 4CaSIvfguvyUsQ+xCpatTsniYluZY9cYsOd+QO6CgUqU9vREQ5RKVhmYEoVrxXe5ahdD
 0vZd3kJbw8vPRWGeINqXgaCER89glf0SE6qlVA7gWOJkavXGd3KBG51RRDWGDHky8y+A
 KEdpk86gQ5lcJHnBFsJYtkeklHRbZ+kI5EQx6sIltY+9q6xJ9PF6s71vKSwrod48qjKT
 k18w==
X-Gm-Message-State: AOJu0YyI+TlKE3fXv5RL8olxl5hXtJjNB8Rk7w3t9L4vpgaOq9mimHFE
 A2uFNFlVnSy8WZanaSHg9mJAIA==
X-Google-Smtp-Source: AGHT+IFhe5HvLq9YFpPzlBEUC+cEmMYTUVz3KfUR9Fev05gjE02Lcxxm29gISS4PpWn3cO13p0KvZg==
X-Received: by 2002:a05:651c:447:b0:2c5:18a9:620b with SMTP id
 g7-20020a05651c044700b002c518a9620bmr9223152ljg.23.1698168279521; 
 Tue, 24 Oct 2023 10:24:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a05600c314e00b003fbe4cecc3bsm17371755wmo.16.2023.10.24.10.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 10:24:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Fix syndrome for FGT traps on ERET
Date: Tue, 24 Oct 2023 18:24:38 +0100
Message-Id: <20231024172438.2990945-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

In commit 442c9d682c94fc2 when we converted the ERET, ERETAA, ERETAB
instructions to decodetree, the conversion accidentally lost the
correct setting of the syndrome register when taking a trap because
of the FEAT_FGT HFGITR_EL1.ERET bit.  Instead of reporting a correct
full syndrome value with the EC and IL bits, we only reported the low
two bits of the syndrome, because the call to syn_erettrap() got
dropped.

Fix the syndrome values for these traps by reinstating the
syn_erettrap() calls.

Fixes: 442c9d682c94fc2 ("target/arm: Convert ERET, ERETAA, ERETAB to decodetree")
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Spotted by code inspection when I was looking at putting in
the ERET trap for FEAT_NV...
---
 target/arm/tcg/translate-a64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ad78b8b1202..41484d8ae54 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1606,7 +1606,7 @@ static bool trans_ERET(DisasContext *s, arg_ERET *a)
         return false;
     }
     if (s->fgt_eret) {
-        gen_exception_insn_el(s, 0, EXCP_UDEF, 0, 2);
+        gen_exception_insn_el(s, 0, EXCP_UDEF, syn_erettrap(0), 2);
         return true;
     }
     dst = tcg_temp_new_i64();
@@ -1633,7 +1633,7 @@ static bool trans_ERETA(DisasContext *s, arg_reta *a)
     }
     /* The FGT trap takes precedence over an auth trap. */
     if (s->fgt_eret) {
-        gen_exception_insn_el(s, 0, EXCP_UDEF, a->m ? 3 : 2, 2);
+        gen_exception_insn_el(s, 0, EXCP_UDEF, syn_erettrap(a->m ? 3 : 2), 2);
         return true;
     }
     dst = tcg_temp_new_i64();
-- 
2.34.1


