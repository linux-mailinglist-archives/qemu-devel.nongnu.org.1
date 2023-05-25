Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A61D71134C
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQC-0008LD-UA; Thu, 25 May 2023 14:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQA-0008KK-C4
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:42 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQ8-0005qn-MZ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:42 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ae54b623c2so16879305ad.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038238; x=1687630238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ZDJh+YnFUCknSRFGXVYE0jRPMbbTzyNWKw2JHeS1ag=;
 b=Nl2HW8jUkETIgYamiCxDmE40ZQgscvzyTP9DVZm2vud0T8/CnnqK8LQnGr2mJuoKDf
 UiRNREb4AYiW7v77jpeN6mSbCpylXW/IX8jUjQqfECchJuof2/CpnMtPAwj1Q+CNGx9Z
 /6R0vqWf7jDq5lChlu4WXtSL5n7v6GwSaKbIZYQ4K7sfemRW4jBBHWE/F6Vx7QXEqz3v
 fuHuGmi/YCmyT5zbrnERuQoPCOc5fqLTcB2sELyICGeKMbicrk7kLe7TXZALHsKYTgPQ
 OpTEsGYZsO6jXgnaUWhLJ42T/On98+PuddYWG0yLyVCunIXiHGm6CiKJX35OIYgMsMZ+
 NvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038238; x=1687630238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ZDJh+YnFUCknSRFGXVYE0jRPMbbTzyNWKw2JHeS1ag=;
 b=WBEExABVALsTZDWIkvtrw7MPMGs9Q3iG8OOP0NgFhkPfEjU4ctSIS9xw/pZmhD/d3K
 nukqm/CqBc2NjxM9ZjszZIiEbl+BCA6gv7vUXQ5uclp/5fGz9gzPZEvkX7f6lZ4gb+yl
 RzqQBJMKHMFEmXH0011ZdsYjJZ9jvaRsS0Ve0++SWfRJjKlN6SiaIk3zLGJxkkSd8kDc
 Sa09g/RnRoASt/khv1/DEBhJmDdGfT7n1Pf2UlgmdKjnnYWXBu4Hw05kI4QehBW0knfT
 AIcl/WWjkQhtXP1l69gVOPIEiD8YBcuIb+23zxAbfGwTP9/GT+iqpTNklR+yWnxO2xa8
 b/IQ==
X-Gm-Message-State: AC+VfDwWgKprxgxe8/cMVmJgBWaKjORrBL647OpZFxpE0gkRNFTyTvrz
 RkOGbtHMg9hJrt/L9VNukNGAVubmxfdZpnvqJr4=
X-Google-Smtp-Source: ACHHUZ5vuhQQR58t8W9l/57LO5zRTbxAyJKCwt+WBUax06QUeisMsp2LDItcP69ybk4bDf5UD0DRuA==
X-Received: by 2002:a17:902:ab8e:b0:1af:e295:ad56 with SMTP id
 f14-20020a170902ab8e00b001afe295ad56mr2309323plr.49.1685038238531; 
 Thu, 25 May 2023 11:10:38 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PULL 01/23] tcg/mips: Move TCG_AREG0 to S8
Date: Thu, 25 May 2023 11:10:14 -0700
Message-Id: <20230525181036.1559435-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

No functional change; just moving the saved reserved regs to the end.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.h     | 2 +-
 tcg/mips/tcg-target.c.inc | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 7277a117ef..46b63e59cc 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -76,7 +76,7 @@ typedef enum {
     TCG_REG_RA,
 
     TCG_REG_CALL_STACK = TCG_REG_SP,
-    TCG_AREG0 = TCG_REG_S0,
+    TCG_AREG0 = TCG_REG_S8,
 } TCGReg;
 
 /* used for function call generation */
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index ef146b193c..ee6c2eb872 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2183,7 +2183,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 }
 
 static const int tcg_target_callee_save_regs[] = {
-    TCG_REG_S0,       /* used for the global env (TCG_AREG0) */
+    TCG_REG_S0,
     TCG_REG_S1,
     TCG_REG_S2,
     TCG_REG_S3,
@@ -2191,7 +2191,7 @@ static const int tcg_target_callee_save_regs[] = {
     TCG_REG_S5,
     TCG_REG_S6,
     TCG_REG_S7,
-    TCG_REG_S8,
+    TCG_REG_S8,       /* used for the global env (TCG_AREG0) */
     TCG_REG_RA,       /* should be last for ABI compliance */
 };
 
-- 
2.34.1


