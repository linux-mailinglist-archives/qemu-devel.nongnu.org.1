Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6519F716D2C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:07:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44aa-0001lD-IS; Tue, 30 May 2023 15:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zh-0000pG-OF
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:05 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zb-0000td-Jf
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:04 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64fbfe0d037so108631b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473197; x=1688065197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yX0nJHc5I1QfdkiCtfe4oFswCwDiEvdZ0dLnh5mJe/s=;
 b=JF8OwDbiBTKNgqGQJPdSVdTbAIrYBBwjkV+seeF42EH1gJQQzVqb4BCtUpTenCyaQA
 TX9LY20V5HXIbJadSJIHBsPaek0SexmqtNSVXFI/b/5vaspfFXP9IjvMW0xsbGUos1sd
 vp9xCC5MtqIp3iT211/ZtBAbaI4Bt2401AgszaPdSKQbqsUrV+5o8Lsa/0MXmIUd/3em
 kWja3Xzrko8ZJj3xoxUvsRSM9ag35j9zHvL9x5Io29ANS2xfztY2mPes714nrRdGYqh2
 li7b1abTNMH+io/CXVD3CXULAV0wiCbG9JfHYJLHhs68Ydn0XJ6ZbrNbOskWZYqF+TqO
 dAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473197; x=1688065197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yX0nJHc5I1QfdkiCtfe4oFswCwDiEvdZ0dLnh5mJe/s=;
 b=i8GUyPXxAfAumrmgOpc2ccDDo+S4WUnQIm5/nDxw+gFaMp81uuMuO1xrI+W6F/gMMu
 lWi4IEm/W1hvs9OWtAODbxoxu6I+uaIwU/mjcm6TbSVccUnBhO1sfzu/cmKPLzYhBmNC
 fr9dKYScE3u6dK512SM8EKYpxdkS9Zjxdoi54rV8HbIMzdbHMx9OAFrVaaqRJiYEGnSo
 pfAYKaahk050Nk3d/jfk1iKmXko3p2KqAAQlgcoaDLU7D0YGd5CwrIGvZk/lD9OawcR6
 Q2Ew3Ss5XPM1FhPXwA8SUGjPWFTsLmeXljRdDxmaSDt8tyEuVrRPUdXUfNQjOqqf3vmF
 ue2g==
X-Gm-Message-State: AC+VfDyPX5lEyFLmF8+TlaY56T9knOhPusARZ7nw7DZrI3OTGtopq+JS
 0FYS0jXvatk7QE8Pe4YtpUSxA47tIoC0y4PJAyE=
X-Google-Smtp-Source: ACHHUZ54Ed4Le+y/zRr0hdpSsH07xLx1mNWNPwbxx1C4iWefDEet3uNjqtoVKwmoy5rC4skqXQLV+Q==
X-Received: by 2002:a05:6a20:729e:b0:104:28d6:5db3 with SMTP id
 o30-20020a056a20729e00b0010428d65db3mr13267862pzk.29.1685473196772; 
 Tue, 30 May 2023 11:59:56 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.11.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 11:59:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/27] tcg/aarch64: Reserve TCG_REG_TMP1, TCG_REG_TMP2
Date: Tue, 30 May 2023 11:59:29 -0700
Message-Id: <20230530185949.410208-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 8996e29ca9..5e7ac6fb76 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -40,11 +40,12 @@ static const int tcg_target_reg_alloc_order[] = {
 
     TCG_REG_X8, TCG_REG_X9, TCG_REG_X10, TCG_REG_X11,
     TCG_REG_X12, TCG_REG_X13, TCG_REG_X14, TCG_REG_X15,
-    TCG_REG_X16, TCG_REG_X17,
 
     TCG_REG_X0, TCG_REG_X1, TCG_REG_X2, TCG_REG_X3,
     TCG_REG_X4, TCG_REG_X5, TCG_REG_X6, TCG_REG_X7,
 
+    /* X16 reserved as temporary */
+    /* X17 reserved as temporary */
     /* X18 reserved by system */
     /* X19 reserved for AREG0 */
     /* X29 reserved as fp */
@@ -71,7 +72,9 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
     return TCG_REG_X0 + slot;
 }
 
-#define TCG_REG_TMP0 TCG_REG_X30
+#define TCG_REG_TMP0 TCG_REG_X16
+#define TCG_REG_TMP1 TCG_REG_X17
+#define TCG_REG_TMP2 TCG_REG_X30
 #define TCG_VEC_TMP0 TCG_REG_V31
 
 #ifndef CONFIG_SOFTMMU
@@ -2902,6 +2905,8 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_FP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_X18); /* platform register */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP0);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP1);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP2);
     tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP0);
 }
 
-- 
2.34.1


