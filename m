Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAA3798B31
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:07:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeewE-0005oQ-6o; Fri, 08 Sep 2023 13:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeewC-0005mm-J2
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevs-0001Af-Ud
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401d10e3e54so24377615e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192771; x=1694797571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HjaDTL1xep2B76YBvbaF3VxnEtkhTxo/PkI5Mu9DV1o=;
 b=ORGHrnf4DDAd81s65wpXqIcAdb3OUkW3oe0D8/bvP5vvkFq8vB8/k6NFHQybts1INe
 9Fuk8yFovxdP/UNDLPWj5DTwPh76XWsllS6hHf6V6wqcrJ63Vpswex8giNaY0+G6jW4l
 STzfPliU3EeOUuCXuaan3hoCs8IftPR4jOudc3biAmq7jWDlTUk6ln11iQKlKikra7ml
 9wyhCRI0VVBXrxy5D0eQO42gvclFz4p57HLfqc18ExSBcbbiAJlP7wNjJBwLj/mMdMLi
 LMIM6oSt05Y8mUFSIp9RF/EZBpN8G/1lvg1X9Ux07mLtMqEz651uoP3HscVfOjADezwK
 fELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192771; x=1694797571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HjaDTL1xep2B76YBvbaF3VxnEtkhTxo/PkI5Mu9DV1o=;
 b=pfe3aVbxYG8peaCcwQDfaWVRvPEMX83GhDinjRw9JohOVL3r4dkSqkrhEwVjNqoRdN
 R4aQRKu421h4hwnQJUJBh7PmHqSanOQc0XfJDl+9gv4NHuaw8Jp6QnI919O1GI07Z8cx
 DOMMdO+PDJWdFtTVnV4dGjs4RhAoM730aSkTRaNFB21vA7twet2nOBcQflb4/LnPTF2Y
 PqaCCkk6AqKqBwbXsAMu0M0CpZA3/i147qPrchwbDe6njiMmZGkG932X3bee8wpx1DU0
 6S1/Bha1Y+I7btBUJGYyXMdICgW0JTFyZFSFfIiXsFoDxwozRU2FZvaIgAYHNJNF7UZ9
 xXoA==
X-Gm-Message-State: AOJu0Yxlb7AZWvkfVgbM0SBeOmSawoK64uGwv3SIvND3IlYbB1QeuRvo
 mMN4VLxFpSJ6JkDmKi3r1wwMrX6rGJLFjWr+xk8=
X-Google-Smtp-Source: AGHT+IGVvoW8lrLu9h0AcUmr3fdqKjr5Y1lBJCV+s/SgykQk4TCixKYsu/hD6VOSpnYO4FJi+ngMjw==
X-Received: by 2002:a7b:cd8c:0:b0:401:b2c7:34aa with SMTP id
 y12-20020a7bcd8c000000b00401b2c734aamr2632182wmj.33.1694192771689; 
 Fri, 08 Sep 2023 10:06:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/26] target/arm: Enable SCTLR_EL1.TIDCP for user-only
Date: Fri,  8 Sep 2023 18:05:56 +0100
Message-Id: <20230908170557.773048-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

The linux kernel detects and enables this bit.  Once trapped,
EC_SYSTEMREGISTERTRAP is treated like EC_UNCATEGORIZED, so
no changes required within linux-user/aarch64/cpu_loop.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230831232441.66020-6-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0bb05854419..b9e09a702d6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -243,6 +243,10 @@ static void arm_cpu_reset_hold(Object *obj)
                                   SCTLR_EnDA | SCTLR_EnDB);
         /* Trap on btype=3 for PACIxSP. */
         env->cp15.sctlr_el[1] |= SCTLR_BT0;
+        /* Trap on implementation defined registers. */
+        if (cpu_isar_feature(aa64_tidcp1, cpu)) {
+            env->cp15.sctlr_el[1] |= SCTLR_TIDCP;
+        }
         /* and to the FP/Neon instructions */
         env->cp15.cpacr_el1 = FIELD_DP64(env->cp15.cpacr_el1,
                                          CPACR_EL1, FPEN, 3);
-- 
2.34.1


