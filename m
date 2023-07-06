Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 308A8749D8B
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:26:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOzf-0005UB-BE; Thu, 06 Jul 2023 09:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzO-0004s7-QH
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:45 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzK-0000tA-Fh
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:41 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-307d20548adso637748f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688649920; x=1691241920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1ed/BVXYFJwYxRqofY4hhjASHZDBl9OIQc2oGaDlpXM=;
 b=XRA5eP4xPae0paRyo+1i6wtVNwJES6mHV6mzcrUPcQAOuOAop1eMPINMhddUgGB3LZ
 OxsC/EmPafoltOPTnGL+1WX4GhqhAqL1Y2llA6nowA8HBn7CzmYB29eSQzxQlcP4DEo/
 I1NtcZJUV8Wq625xgF2H+eylfoBinqKuqZF2iLRC9IHKL8v6ZPfOKkvXqu++UMaK8soa
 /9ODKLUwpdv9ljtjxC3W8+9YigV2cYIaK4kH/wngMycft8rSy0jhq1/3UjCAioPzVuR9
 bEGBrivMsSf0Ilhh4xeNIJ5afEBTGkiUowjHAJ0enzoGFaG08+KAHbI/+Xv0aQmZk+dt
 QPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688649920; x=1691241920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ed/BVXYFJwYxRqofY4hhjASHZDBl9OIQc2oGaDlpXM=;
 b=lFB+5FxW8C4455VTYzuBRxp4BurxxgP7D/BNnZrckPJaRSSu4Nb2wn7UcQWeoyWin7
 9qYj28vtEKIHDP+4ElWQ66+fFqb7QWHZmag3Izy47WWG52JmoNeZ5CHmhLygaB3aqdYw
 iHydHCg5VyD0VVgsCtfhK3nQUVl0a7Y89oBPD05/hk3idXulmZf7uux93+/cwQDapwvJ
 tyTKSM/21SngJ8JcSA56wgbqDMnMV7VEVX5VhucHf2KG2oDRQiHZlXGiv+HB4Obac3+H
 MC72+Rbu4WcSLxR5lFZcD2BT16HqoRE7n4HdsJI2YASqUmWRm4HKRhdZamNSIbdDOp2H
 zPsA==
X-Gm-Message-State: ABy/qLYwtCi/K0Y/PDrJ/XTmHgo8/JjWMxoM6GjnnvgNg1S67vRfuawi
 L5LB0dYshyvCeAgl/c2Tx/s/J/bjNfoCYflfgq8=
X-Google-Smtp-Source: APBJJlEvZFj/0ctpT8extXPhet8KptDPyKURlFbAF3HyQQV3EQCSygWnBqF3AghfDz4PieyAZ8Ki/w==
X-Received: by 2002:a5d:48d2:0:b0:30f:c42e:3299 with SMTP id
 p18-20020a5d48d2000000b0030fc42e3299mr1269486wrs.60.1688649920276; 
 Thu, 06 Jul 2023 06:25:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a5d510f000000b00304adbeeabbsm1856170wrt.99.2023.07.06.06.25.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:25:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/14] target/arm: Avoid over-length shift in
 arm_cpu_sve_finalize() error case
Date: Thu,  6 Jul 2023 14:25:12 +0100
Message-Id: <20230706132512.3534397-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706132512.3534397-1-peter.maydell@linaro.org>
References: <20230706132512.3534397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

If you build QEMU with the clang sanitizer enabled, you can see it
fire when running the arm-cpu-features test:

$ QTEST_QEMU_BINARY=./build/arm-clang/qemu-system-aarch64 ./build/arm-clang/tests/qtest/arm-cpu-features
[...]
../../target/arm/cpu64.c:125:19: runtime error: shift exponent 64 is too large for 64-bit type 'unsigned long long'
[...]

This happens because the user can specify some incorrect SVE
properties that result in our calculating a max_vq of 0.  We catch
this and error out, but before we do that we calculate

 vq_mask = MAKE_64BIT_MASK(0, max_vq);$

and the MAKE_64BIT_MASK() call is only valid for lengths that are
greater than zero, so we hit the undefined behaviour.

Change the logic so that if max_vq is 0 we specifically set vq_mask
to 0 without going via MAKE_64BIT_MASK().  This lets us drop the
max_vq check from the error-exit logic, because if max_vq is 0 then
vq_map must now be 0.

The UB only happens in the case where the user passed us an incorrect
set of SVE properties, so it's not a big problem in practice.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230704154332.3014896-1-peter.maydell@linaro.org
---
 target/arm/cpu64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 6eaf8e32cfa..6012e4ef549 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -122,10 +122,10 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
         vq = ctz32(tmp) + 1;
 
         max_vq = vq <= ARM_MAX_VQ ? vq - 1 : ARM_MAX_VQ;
-        vq_mask = MAKE_64BIT_MASK(0, max_vq);
+        vq_mask = max_vq > 0 ? MAKE_64BIT_MASK(0, max_vq) : 0;
         vq_map = vq_supported & ~vq_init & vq_mask;
 
-        if (max_vq == 0 || vq_map == 0) {
+        if (vq_map == 0) {
             error_setg(errp, "cannot disable sve%d", vq * 128);
             error_append_hint(errp, "Disabling sve%d results in all "
                               "vector lengths being disabled.\n",
-- 
2.34.1


