Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB1172B2C1
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 18:05:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8NVc-0006Sv-Uj; Sun, 11 Jun 2023 12:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUg-0005pe-CJ
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:49 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUc-0000R5-6x
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:41 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f7fcdc7f7fso22690945e9.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686499234; x=1689091234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QYoLjQUBzDtsQLiewQeHZyMx2G0pXSiMumiEHL4MRBM=;
 b=mcCaaGORXLo8u5KAwAVL5dLyFA6eMej5XUaOFzf6IxmKNQOB5DKtc3BgaYWNqz8k1G
 02Yb44mXos0nErkqy7h9llSFN2L9nxPLOIeNGdvedR7748a6Tpn+Ie2RjsNqBkNuUxT3
 Oa0JVh8SlpFjzVFD0OthX2Ek2ZgPuDqlRZgO/1oyfJGJ/jl0YNmMdhHsngA6Yo3sTRcs
 QxQDP7u1Ai/fjrXeIrEFLuwodnvFI4voNWMYax/F3CEnaUsAm1010AHoHLEST6i5st2i
 EqX33OSdOZczgw1hTfkmB0Cm6LsGnB6MDKIGwLVlRDO2ukn9CxLvS0H3oJudPxinbg33
 D1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686499234; x=1689091234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYoLjQUBzDtsQLiewQeHZyMx2G0pXSiMumiEHL4MRBM=;
 b=Cw9i3GubXQR405CZ61Wg3Y/KejbyQMMQnIoPryv/g0TPtDY4C0UUZdq7ZcZNuC5WhM
 /CEdkoudF+FUAFJO5P8wKLM57gXbvKZ4AmavGKtY/YSoha8HHu1kC/aG6Hb3Y//vjFGf
 yUi10aftqjpAz23ItrM5aBnCRxoZ0Hl+wI+F2dKZvPXKddjpfX4hsqQbOiT1wtfJRycC
 0ldC7LARrXEY+NErcc2sA5L+ByTZ4VXC4XSbuiYzXDrDaffKoLllVhjt34Zs7Igi41HS
 NIhHFEKUNePgB2DMzwFBvz//ArIXgnnu0jCNV2O8Xwe+v6eSIj7FJHfH93iORbtWY9BV
 dwQg==
X-Gm-Message-State: AC+VfDyJ2rb/lqogQO/ncboCM8M0lJS+ZuivHeZO6XCsW19D8p2RfXFB
 FR9o0BYRjADpevDE70M+mj9s20Zt86BQQbDzDzI=
X-Google-Smtp-Source: ACHHUZ67Mh+fCshACmW+FQTrSfuFDNU6FN1mHAfy0l2rLZSexBJ19Mc4J+VdRAtbiSyaPmtEnYVetg==
X-Received: by 2002:a5d:5265:0:b0:30f:b0de:f100 with SMTP id
 l5-20020a5d5265000000b0030fb0def100mr3240746wrc.23.1686499234418; 
 Sun, 11 Jun 2023 09:00:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a056000008900b0030ae499da59sm9923022wrx.111.2023.06.11.09.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 09:00:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 01/23] target/arm: Fix return value from LDSMIN/LDSMAX 8/16
 bit atomics
Date: Sun, 11 Jun 2023 17:00:10 +0100
Message-Id: <20230611160032.274823-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611160032.274823-1-peter.maydell@linaro.org>
References: <20230611160032.274823-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The atomic memory operations are supposed to return the old memory
data value in the destination register.  This value is not
sign-extended, even if the operation is the signed minimum or
maximum.  (In the pseudocode for the instructions the returned data
value is passed to ZeroExtend() to create the value in the register.)

We got this wrong because we were doing a 32-to-64 zero extend on the
result for 8 and 16 bit data values, rather than the correct amount
of zero extension.

Fix the bug by using ext8u and ext16u for the MO_8 and MO_16 data
sizes rather than ext32u.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-2-peter.maydell@linaro.org
---
 target/arm/tcg/translate-a64.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index aa93f37e216..246e3c15145 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3545,8 +3545,22 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
      */
     fn(tcg_rt, clean_addr, tcg_rs, get_mem_index(s), mop);
 
-    if ((mop & MO_SIGN) && size != MO_64) {
-        tcg_gen_ext32u_i64(tcg_rt, tcg_rt);
+    if (mop & MO_SIGN) {
+        switch (size) {
+        case MO_8:
+            tcg_gen_ext8u_i64(tcg_rt, tcg_rt);
+            break;
+        case MO_16:
+            tcg_gen_ext16u_i64(tcg_rt, tcg_rt);
+            break;
+        case MO_32:
+            tcg_gen_ext32u_i64(tcg_rt, tcg_rt);
+            break;
+        case MO_64:
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
 }
 
-- 
2.34.1


