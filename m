Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1421F720449
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:23:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q55fo-0007ZZ-Bs; Fri, 02 Jun 2023 10:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q55fc-0007Yb-Bc
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:22:24 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q55fa-0001Xq-LU
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:22:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3078a3f3b5fso2106076f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685715740; x=1688307740;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T5r/LpHJMg7TbmN47HlK1bNQm+yT4WVmfzXQIP2d3t4=;
 b=rH3c9poL6+VxRMz0zrH9MEbijYE5irYGZvtD3v4zY/cAltbltJBSXGBB2D0sxSFMnf
 z9chXOb1GuN6KS+RGGQ+KHUBVv8BoYX9kUN9uZZXF+5yFbTF7y50QQAjopiahMJoExgz
 fE2uTl9hso99Qnv0DuSH6y06bVolrIL91XJ/AgE87cWsiHMZO/UbSrhvyjNdXfpeR+PK
 T8qgbASecb3vk3ipQgUh0VuW9eN61MkM0JJfuAYqBE+X8RBnIqtFvrxi6JUCl30MVlDE
 KD060NWpl74bmVBzDHuJtYmv6Yvb0t6hzLEOLE5HWpARL4sKw299ezM1DNUOlJ34LsLJ
 sr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685715740; x=1688307740;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T5r/LpHJMg7TbmN47HlK1bNQm+yT4WVmfzXQIP2d3t4=;
 b=cFxcHBYqKn7aiTInzfUAPJDisrT4CbBh3LNxLwZJxUz0iIqCu6D0FUFQv3yc0+PW6T
 /ehIY+g7aw+uzexF92iLDpnGaN6/JaczGL/rFo02coAunYGt9BKC7voVK9chUdtx6OO2
 +bh1PNAHOacXWBigv+YjhJ1vG3Rhj0EXgexkPG6pWfLoCt+kFHMei47nuiopC1pv6qLW
 3DVKRlbApKpr6jtT6dwYYd/U9EoLsAOVR9v7sgw8nNQKAfSPlAYJtC34wz5F6YzDUCnP
 UrNHvVXADjG9sL8b2ibdTCbGmY1fttZ75XywDe/Bgr8pE0pLUAUS8FL8uMOuJiM/3kK7
 dH9g==
X-Gm-Message-State: AC+VfDwdQ8jJqgELwd7XCIQazm1DYMZ7Hj/lIEtxahiTHx+LyBpxCTVi
 femgpWNhJOIPPGzBrEcqg8/hVA==
X-Google-Smtp-Source: ACHHUZ6K1/cr3k4E4451uBRkaUHXMDQccEnX4NftmJ92cfzMD9Y0nTowdtcAJY1+ySqw0EpiOKQLnA==
X-Received: by 2002:adf:f08b:0:b0:309:3a60:d791 with SMTP id
 n11-20020adff08b000000b003093a60d791mr88693wro.54.1685715740643; 
 Fri, 02 Jun 2023 07:22:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a05600c219500b003f17af4c4e0sm5753600wme.9.2023.06.02.07.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 07:22:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Fix return value from LDSMIN/LDSMAX 8/16 bit
 atomics
Date: Fri,  2 Jun 2023 15:22:19 +0100
Message-Id: <20230602142219.1999756-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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


