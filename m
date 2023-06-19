Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B379873598A
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:30:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFsg-0000YR-4D; Mon, 19 Jun 2023 10:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFse-0000Xx-7Z
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:20 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsc-0002AH-54
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:19 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f90b8acefdso13061015e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184956; x=1689776956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QYoLjQUBzDtsQLiewQeHZyMx2G0pXSiMumiEHL4MRBM=;
 b=mJyHVSeDzjgtg4uCTejlEQhY7vrzr1rh51K82VWaS5ngwkSJ2eCoYW4/pdG74lVwZV
 bFcljNGsZ2v4quUPBNpTVX/qUHGfLOwaP+eDoSJOfLi6URq8UQHTGlunY81Tm0PZX7fx
 RK5lOLcaBrFOvJT2SXqUJgo68WTxOZgUH0njFIMrTh8XylR9uv9+6GBLao4889vyGNqg
 +Fj6rHhgnACRZA2VMZA015IpmeMAodTuV52+gM35fpFeUHnBxCf5fJVilbCKan2nt4Bh
 7jbyMJlxMHmJLSSSCkH1QOyJ6i9k6MwLs6Ixf4Ebk7KeQia8NVHXjjB0WCTjHZZEtAkI
 t54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184956; x=1689776956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYoLjQUBzDtsQLiewQeHZyMx2G0pXSiMumiEHL4MRBM=;
 b=C3rUlpsKt0abGQPzHhbEDdp8K94+3L7BtO4LyzU/uTmu/UoG2WH3Lh9vGqNUn30rAP
 6Xv85WtaHDQuaNCfXfOJPpdB1b6mFgL+9JHemCJDrPjs59qbSGblUN0nHLavwpCcWN3o
 uzHjz3zxVkcEHzuqetpVuGG9nylyeHNZyWqcMNTnnBKJ7Rsn1XYorIa0B/oUAtQfDJqa
 A9sB5w4EhEIrsQ+AGkng2kKVnjx7F8KssjbZuLgvP0ARCZ+9xsWSCtfNfttiiQrTCla+
 u8XBwpGQmbCSHxHNM0W2donSf5qUuY3OC4hY+6dKr0JmczjBeFZJqM7aSIHBTKYLMKCb
 +NKg==
X-Gm-Message-State: AC+VfDzRauTTrkkgpmGOxOc3nA0pT2Oih5T2f+gF1qDSU6V2JDOkDhG7
 LwcV3RcO1TyeVaeWEBb9AoLkJvkp2RlAg0lN8Bo=
X-Google-Smtp-Source: ACHHUZ7yk0dYqEmmnTnhq+ZC6tcP89CG5yXHxc2vr7ZgrmPWaxfxhxN0ZjAJJOGW56cYOy6yEtjEXA==
X-Received: by 2002:a7b:c407:0:b0:3f7:e605:287c with SMTP id
 k7-20020a7bc407000000b003f7e605287cmr6359827wmi.40.1687184956636; 
 Mon, 19 Jun 2023 07:29:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/33] target/arm: Fix return value from LDSMIN/LDSMAX 8/16 bit
 atomics
Date: Mon, 19 Jun 2023 15:28:42 +0100
Message-Id: <20230619142914.963184-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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


