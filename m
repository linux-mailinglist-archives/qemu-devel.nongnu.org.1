Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E647DAE6C
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 22:10:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxD1u-0002i6-Cr; Sun, 29 Oct 2023 17:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1q-0002gW-KU
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:09:02 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1m-0005Ek-Eb
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:09:02 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-357a69dde08so14165405ab.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698613736; x=1699218536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+92qzklDkxM/mQvVxc+9L7ck8zPyj/vu6S7Sqi5MgDs=;
 b=B6UEEvX6R68JXqNbPB03Mev/H9Z9uIVFs6iCsgTTmmOz9vpJ3E6PQBPD9CDPxikI+v
 9Ro46AvDpjUhPiwim2dOeq7pVtZlvGw+JotpaovXArsPiDTPDMNiUVQk1JcnF7+CZgqO
 rqByaN0ZbyWMQeEvCGrO4wtfCVg0EeqplsedtqPkbvSdgHD1P/r30qwLVBzL8666pnlY
 js1ZslMv5C8CElX9vmruaMFMQJIOXZc8kzhkUhXor7xHrOqmZoNrCIufw6eDMUyliIsa
 Mhc6O5FRhfvu5U7h22fp4kT7fHfXRSPeEIjmnnrCnl1YWpmwrQW5oAxr2p2zXuv4ssO8
 2fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698613736; x=1699218536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+92qzklDkxM/mQvVxc+9L7ck8zPyj/vu6S7Sqi5MgDs=;
 b=PRUMbhsqSZ6ohJHzvxV0+ttGKlQ4Bl1+x0iIpe0HL19AhtOkig56P43IIbt4n3CgNE
 yX8T14z5GUOAl9zU7c+0wzFtVZzpD2gTsFrDtz9Hfp/84c4JkaWYk3TmEvPgbcmp+E+Z
 KM7iH2tMkwOUIBYWxqFmjL+Bmvwpig3gkk+m2z16E/+jqx/R1br9zUtHtAhVAOEZWzeO
 vtRE27Iu/2qA1XPOuZORVGE3+v9GqkgyAoKgvw1YzhFBcQ0QiJ1wQ4+RBuMNwhEfCBaa
 +miK2VOLx5b76I+/SqZRw/asAO8hOp2gLjXQ8hIzgRThOdTTc0GuoVmDmbQAu1m5iTL4
 9WTQ==
X-Gm-Message-State: AOJu0YzFnEv7NqcO0s6Ru5dOZWY/IveV3FtDbq5S1PwQMIospSd2KXq/
 MLtre1SxK2VgekjnO6xMutqBrIOnJcGj95GWvAA=
X-Google-Smtp-Source: AGHT+IGmUPEznxtI7feHh+JxqEB+MNOaRoUydUyf5sPxy9hRLaTKPPMRBtnbSCfqOkJ085HKN4A4GQ==
X-Received: by 2002:a05:6e02:1705:b0:358:141:857f with SMTP id
 u5-20020a056e02170500b003580141857fmr13665920ill.11.1698613736689; 
 Sun, 29 Oct 2023 14:08:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 z11-20020aa785cb000000b006c0685422e0sm4622847pfn.214.2023.10.29.14.08.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 14:08:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/11] tcg: Move tcg_gen_opN declarations to tcg-internal.h
Date: Sun, 29 Oct 2023 14:08:44 -0700
Message-Id: <20231029210848.78234-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029210848.78234-1-richard.henderson@linaro.org>
References: <20231029210848.78234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12f.google.com
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

These are used within tcg-op.c and tcg-op-ldst.c.
There are no uses outside tcg/.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 7 -------
 tcg/tcg-internal.h          | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 3f8b214376..b922545118 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -14,13 +14,6 @@
 
 /* Basic output routines.  Not for general consumption.  */
 
-void tcg_gen_op1(TCGOpcode, TCGArg);
-void tcg_gen_op2(TCGOpcode, TCGArg, TCGArg);
-void tcg_gen_op3(TCGOpcode, TCGArg, TCGArg, TCGArg);
-void tcg_gen_op4(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg);
-void tcg_gen_op5(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
-void tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
-
 void tcg_gen_op1_i32(TCGOpcode, TCGv_i32);
 void tcg_gen_op1_i64(TCGOpcode, TCGv_i64);
 void tcg_gen_op1i(TCGOpcode, TCGArg);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index f18d282abb..c9ac34fc3d 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -83,6 +83,13 @@ static inline TCGv_i64 TCGV128_HIGH(TCGv_i128 t)
 
 bool tcg_target_has_memory_bswap(MemOp memop);
 
+void tcg_gen_op1(TCGOpcode, TCGArg);
+void tcg_gen_op2(TCGOpcode, TCGArg, TCGArg);
+void tcg_gen_op3(TCGOpcode, TCGArg, TCGArg, TCGArg);
+void tcg_gen_op4(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg);
+void tcg_gen_op5(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
+void tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
+
 void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
 void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
 void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
-- 
2.34.1


