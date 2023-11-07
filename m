Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC397E3343
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:52:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9E-0008Hc-Dc; Mon, 06 Nov 2023 21:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9C-0008Gh-N4
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:58 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9A-0005rp-Sr
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:58 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6bee11456baso4797384b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325335; x=1699930135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d3NCy7c1Qz0hjx/9ReaBNA0nt0Qdhs4UCEPvgjjqajY=;
 b=p8iOw4+R57PNk0K3A3XgtUIPowwJMgbAQ8QcDih+sJ/uflCOqAihZfJpMtmWCLzSBi
 zwSMDz96jJx1EKcvT2HYNbpxVBrh8YupyYXnx9LtmNTdxNXYT1wnTaCNRe+nOY9xt13E
 t1jZ7wNJfnBZ1DJU8XacEqdjyqwC4oOFtDIQJD5/X+qylKebaSiezFNwAs1/R6Fjya9k
 IifOWiKgm7QqMG80gufxmCwqGFBqzgvLd2pECKSeT00CNwt8Ec+DnH50Eqvu5iAMLP0k
 8IFkBs8HT1JgeE/RY79uTh24o6766KTTxfglzcWXW2fom32PD49Rstl2MBjNhJ7zn0m8
 b1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325335; x=1699930135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d3NCy7c1Qz0hjx/9ReaBNA0nt0Qdhs4UCEPvgjjqajY=;
 b=piLpfOsNTEQ9TEQ2lnO2v4tTkAJYfDoltQjp6Z2cXdu3kdLm2kCpnSA8vgIfSsnMGz
 /miiIzpgEOJjKpxO1wq6qIe948l0QzUUUgBsP/CGB5Jyi8qswK8v4WS9cpWn1dEvQnJ3
 DLU8PzB3Nl393+N2KgFW4kBMWVHtOdkGldtses/2PLyVo3pTTElkGAjim1LZeSPQSD+2
 AegWlFzFQ1vRNapyA0XdbmUKUUpQTMg7Rr4+F6Pwpjmw16eM94mJqCbF8P0+7b3D80ep
 Pore3hQT8iJMhIGYkr5zH0xsRg0jSUrxh//MirP+K2V3WTCZDAmVijHmn8803l0Z7XAy
 hBuQ==
X-Gm-Message-State: AOJu0Yw0g5JRwgkeTuK+P2QYLPOQ39cBWhwtajE26ApVtxdY3qvqM+7o
 3z3INbpGO6uFa6CbxYBPTyxQI4LAbJq1D71+9cA=
X-Google-Smtp-Source: AGHT+IGxCwteWhAMpGwZ1Jd4kDzQ3N5d+KBTWrkAySbTQRlC4DpamxkZUhHnmGmdfhY0wghPExpj4A==
X-Received: by 2002:a05:6a00:1389:b0:6be:5a1a:3b93 with SMTP id
 t9-20020a056a00138900b006be5a1a3b93mr31307511pfg.4.1699325335529; 
 Mon, 06 Nov 2023 18:48:55 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/35] tcg: Move tcg_gen_opN declarations to tcg-internal.h
Date: Mon,  6 Nov 2023 18:48:22 -0800
Message-Id: <20231107024842.7650-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

These are used within tcg-op.c and tcg-op-ldst.c.
There are no uses outside tcg/.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231029210848.78234-8-richard.henderson@linaro.org>
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


