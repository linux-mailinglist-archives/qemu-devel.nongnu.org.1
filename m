Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C8C7BD6E8
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:25:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmVL-0000GY-Dt; Mon, 09 Oct 2023 05:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmVF-0000Fs-4x
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:24:41 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmVD-0001bD-8m
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:24:40 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso740796766b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696843477; x=1697448277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2fe4kejQ+gNSKuaihInbio7ohEhriksd0K5ohb5f1Ns=;
 b=C+Hvt14pUkQ6iPv+CkiTPEk88IZnEDk33aQCRsm8uP6fWKLoLU1wxDyeu4kNh9D2WG
 DPDfpKz/hJf7Pg+TBxDk8VIsNZdvbNyXS/eO43JmIUvUl6S33UNFKMQaAv9HDFPvqUs1
 9nK88KtvlFUhVPkIJ1HKmyttE/Aezn1HanXsOMmi8CC1UpfGmZ/WiHWtKgmDCWQUgfSY
 +xw90YxEwAaRqPYYc87/nZD5On9+Z51WcE60+F7I3SdDnYD+gEGxWQBcYz14TTxsIaDr
 bt+9zGA5bDkrNcoOX79+1/WEyNJyDJvzQ3t/knrxdbwytXmBpecKN44+w07sW8JiPGzg
 OMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696843477; x=1697448277;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2fe4kejQ+gNSKuaihInbio7ohEhriksd0K5ohb5f1Ns=;
 b=hBHNxZxipXTO36JJ1c+hRtm/rSVVLX48mLbnL5VyjJXdVIcqOdQzeq0BVSoxxZlv09
 GBXpiRxzWcEfMT+YOYHdl8vbMbYYc5b1q3VDN1fLnm+B1g5pYPNhgig5VSk74nXRiYUq
 jrlimTdrx+f+Gt3FUoLpxPkGxg0+AhUiMvHRngO+OFQ8ShY2LSSaV2g3dcqyV5SXjOIM
 SJeCDhfrqMIbdzQyKSbzA9pGNPS46KpeSUa1JiwFVXrWSRWc8GIKlvFpps/VyZSEQ7Em
 bIvzowTJc10GR/9Es3IPlXb0QwART3udPBF/mOWNKGW4cQrtMEux7a+tCGokDMTbzzae
 kcOA==
X-Gm-Message-State: AOJu0YxkGKw91qY2TKLwdMPF1pRiMYk51icPnQXvhU5FfHEXIPwVZx/F
 mX6d2y01s+607bhvQdgdYkOtG7EJSGYV8IKzHIg=
X-Google-Smtp-Source: AGHT+IEPpfdbPV/SXFcLOH+zbCoFVrOsdA+YF4Q5IjR/uLr4D+RbgQTKuZsZItxGSrszERy3hXRKGw==
X-Received: by 2002:a17:906:cc0d:b0:9b2:b95e:3825 with SMTP id
 ml13-20020a170906cc0d00b009b2b95e3825mr12896317ejb.39.1696843477166; 
 Mon, 09 Oct 2023 02:24:37 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 j17-20020a170906831100b009a16975ee5asm6424315ejx.169.2023.10.09.02.24.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 02:24:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/sparc: Clean up global variable shadowing
Date: Mon,  9 Oct 2023 11:24:34 +0200
Message-ID: <20231009092434.50356-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

Fix:

  target/sparc/translate.c:2823:66: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env tcg_env)
                                                                   ^
  include/tcg/tcg.h:579:17: note: previous declaration is here
  extern TCGv_env tcg_env;
                  ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f92ff80ac8..26ed371109 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2820,19 +2820,19 @@ static void gen_fmovq(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 }
 
 #ifndef CONFIG_USER_ONLY
-static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env tcg_env)
+static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env env)
 {
     TCGv_i32 r_tl = tcg_temp_new_i32();
 
     /* load env->tl into r_tl */
-    tcg_gen_ld_i32(r_tl, tcg_env, offsetof(CPUSPARCState, tl));
+    tcg_gen_ld_i32(r_tl, env, offsetof(CPUSPARCState, tl));
 
     /* tl = [0 ... MAXTL_MASK] where MAXTL_MASK must be power of 2 */
     tcg_gen_andi_i32(r_tl, r_tl, MAXTL_MASK);
 
     /* calculate offset to current trap state from env->ts, reuse r_tl */
     tcg_gen_muli_i32(r_tl, r_tl, sizeof (trap_state));
-    tcg_gen_addi_ptr(r_tsptr, tcg_env, offsetof(CPUSPARCState, ts));
+    tcg_gen_addi_ptr(r_tsptr, env, offsetof(CPUSPARCState, ts));
 
     /* tsptr = env->ts[env->tl & MAXTL_MASK] */
     {
-- 
2.41.0


