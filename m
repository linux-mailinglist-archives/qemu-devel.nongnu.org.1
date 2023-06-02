Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A643720696
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q574p-000367-DD; Fri, 02 Jun 2023 11:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574n-00035o-FE
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574l-0003QR-OM
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:29 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3063433fa66so2217895f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721146; x=1688313146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T5r/LpHJMg7TbmN47HlK1bNQm+yT4WVmfzXQIP2d3t4=;
 b=K2dKhw800F0rxq5ZXvDlEKEmum+eXRXGIm4a6d8x40IwSBKIMvd5rvgl8TNYs89Rsl
 Bjh0FX+Dl4R0xTFjuAc3w26xunrWpWYOHbQE7b5lKz2nJ/s+Ji2MH7PXILwV7VY0IgFc
 kgayOFLg6XRFCMs8ezWLJf/njl4JOEh9VWQFpU9uqH+ZVyg/Rn1G0UrVYrPPb3DzWUvZ
 5cgdczK21w2VydIieuSPGPW7mAcFeQD/aCTPRsY1suXWDsHZ7nFmjZSzvxWK6D3m+1s8
 kEx4WlV/+S3lPWnD8WOpO3aEnzZmTk37G0kR6ovOg2AYap0/eRZw8sEHP6ZudmMVpCqi
 dp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721146; x=1688313146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T5r/LpHJMg7TbmN47HlK1bNQm+yT4WVmfzXQIP2d3t4=;
 b=lrJC8kiUZRvvAtfnTvsadIGAm/5oT2GG3/QSlTXg+IvVwaLl1YpCr2UQRQgtrHAagF
 LqMbUPloF06B1xKBzViWTGJt6jrQJKv0GByq6HC7LUFl+/ZPQd4CQOsmHHPW2x5BmsDM
 NJIhVJoE6CT8nWaHi72ckLIFcehgOhn+8KhjXcuWesmdkZwNIKhR24/s1zahQnpcGP3S
 EysI2YngVToXt750PAW2bsUwJ8vvZL2ShaOsachkaqtBYpmgxz5C3kA+am9q808UVXNO
 229j2RXfYMyZ0PsPNMsJmlJZZR35cpf1ibQNjUVokdhTQNTriIwB6RZ5EClyu20mxmAH
 0LYA==
X-Gm-Message-State: AC+VfDzH/8Ip02AhTG8HA6mBYo2N7KoXX5k1pfNoVMNxklo3bhE5RIto
 7JGZcRP4yElHkrPBoKyw1qx7uDnaMNMSEoVFmdk=
X-Google-Smtp-Source: ACHHUZ4+hOXAPpW83FkzmhDy6HKDypvfJ73L00gJUGXIIaVZDBwKz5ti4h4DHRLg/laaExi8m0tsag==
X-Received: by 2002:adf:dd0e:0:b0:30a:f06f:3ee0 with SMTP id
 a14-20020adfdd0e000000b0030af06f3ee0mr268590wrm.28.1685721146369; 
 Fri, 02 Jun 2023 08:52:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/20] target/arm: Fix return value from LDSMIN/LDSMAX 8/16
 bit atomics
Date: Fri,  2 Jun 2023 16:52:04 +0100
Message-Id: <20230602155223.2040685-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
---
 target/arm/tcg/translate-a64.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 741a6087399..075553e15f5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3401,8 +3401,22 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
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


