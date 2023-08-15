Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC1377D3BF
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 21:59:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Au-00058K-Jh; Tue, 15 Aug 2023 15:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Ar-00056G-4B
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:53 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Ao-00014D-ON
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:52 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6884310ee75so1651081b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129469; x=1692734269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAfW4M/c3IgeounQPta3hLHkVcqc5lVrdvZ/euSX+U4=;
 b=h5CL47FiV2u4P7YnWBM6bs06tw4WXbhEiXmdOc4CYpGKNpZffJgdEyDnosb21XP6/5
 P60QT6rKkDmr74C6No4eXqGbFiOK28aQp1bgGcgqGVhVJGnB2VUR82JOt4BnSx4N6oF5
 S5RZruVQDiMSTGr4LS/KYPTRGmTnMr6NAgWf3O4AOCrZCL152Yzd/M07io8z3RNFMgzQ
 T4yNSzfVGff3jg2gHyNllZkc4SvZDMcqSiWk5piQXHe2c5J3Q4WlCn97egp9sPEiXmTy
 BjrzGClO5GtgO8Ua7aCFVCFqo7Z4A/CwrxXhYqJf0d/Y0AjOer9VMtKdAFw+76NRdifr
 7UIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129469; x=1692734269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAfW4M/c3IgeounQPta3hLHkVcqc5lVrdvZ/euSX+U4=;
 b=D9eIOhTdqG921tuLGd7BLDFaGm7UjlRUeY/C5bhuamDWDXNbESuW7LvbGTFJdUkIXH
 mTaN++gaOj8FA2hfL/2QTrUyHGB2fEwBKoKqKfR1EMM6xODav+8BrGL6+RXKK2zDDk1v
 8SxmXv5DsTTVkrVsSjEhzD5JWYR4qo82wW2VOcAjDnil0TJ/JPXULI4nQwYRUMx1RyjC
 aoz3qTl7pTZWrL1L64ugM3jxPsHc7f5lggwoLCQm8SL/Ybsp43xqveCnYCKI3cChgwTo
 pVUgRstT8VpMztcynOYazlYvLEMKPiI+dTowwYfU+5j46hrs4COaZCUqioRLhMxYnmP7
 GXmw==
X-Gm-Message-State: AOJu0YwliyC8ea/MRXOUTsTVDpmXQfFGeVkSRLZVtDgbf6fvICGHWRKK
 nmYyP9VdsubzpSlVUvmnBGqeLbCTQe7k3SjZB6s=
X-Google-Smtp-Source: AGHT+IHEr1qGnuFuy98LMxQO6hfC8XAlMa2EW0jNgFXoAq1QXhJv48BawK2YiwGEdkZEs8jlFc8/sQ==
X-Received: by 2002:a05:6a20:324d:b0:137:a3c9:aaa2 with SMTP id
 hm13-20020a056a20324d00b00137a3c9aaa2mr14896424pzc.30.1692129469425; 
 Tue, 15 Aug 2023 12:57:49 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm9667699pff.86.2023.08.15.12.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 12:57:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	jniethe5@gmail.com
Subject: [PATCH v3 06/14] tcg/ppc: Use ADDPCIS in tcg_out_movi_int
Date: Tue, 15 Aug 2023 12:57:33 -0700
Message-Id: <20230815195741.8325-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815195741.8325-1-richard.henderson@linaro.org>
References: <20230815195741.8325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 36b4f61236..a302bfff2e 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1050,6 +1050,19 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         return;
     }
 
+    /* Load addresses within 2GB with 2 insns. */
+    if (have_isa_3_00) {
+        intptr_t hi = tcg_pcrel_diff(s, (void *)arg) - 4;
+        int16_t lo = hi;
+
+        hi -= lo;
+        if (hi == (int32_t)hi) {
+            tcg_out_addpcis(s, TCG_REG_TMP2, hi);
+            tcg_out32(s, ADDI | TAI(ret, TCG_REG_TMP2, lo));
+            return;
+        }
+    }
+
     /* Load addresses within 2GB of TB with 2 (or rarely 3) insns.  */
     if (!in_prologue && USE_REG_TB && tb_diff == (int32_t)tb_diff) {
         tcg_out_mem_long(s, ADDI, ADD, ret, TCG_REG_TB, tb_diff);
-- 
2.34.1


