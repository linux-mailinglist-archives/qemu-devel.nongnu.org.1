Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 758927264E5
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:42:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vHT-0001WX-6e; Wed, 07 Jun 2023 11:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6vHR-0001WC-8O
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:41:01 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6vHP-0001zW-M1
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:41:00 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5440e98616cso550325a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686152458; x=1688744458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjOlV3XXmAHIFsGaSRKptyRzWhnKbHdg3ZoAqbceQ4A=;
 b=igJsmhPMZ7nqLTWyTxvsD9/80rlkAdoAu2TpQC4pXtkKptj74VrAUAyLJugUBpKeE7
 2Pn0+NNkG7Extnge1+rjcYE8Rku/W51610XtenT5cSYYsEpI0l2ETsgNlPdGArU4lo8X
 eqwALC0DyHgRadv5agv2C3yrka2HSKyuscWRZTods5bfXIAlV9ubvuNoxdfGkHH+6jKr
 W5x8hrtHtIvLFRrae+uY/Tg9QoD9659hKGGXXnFfJDMtSMslIXYXiLGMoGg6aJFVAql2
 +jFJ9WVUJW8DsPJ6OEv8Ev4K6gyHQH6rbr1E3+mTrHC7jzFFCScypZ7s0PJwFcB1QRp/
 WN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686152458; x=1688744458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SjOlV3XXmAHIFsGaSRKptyRzWhnKbHdg3ZoAqbceQ4A=;
 b=UowHhnoqoGhOOcCqdau4HAZmhsUiVhx1Z5ThCkgCw65ymtMD125ddqBO1+tZZCYYVP
 QJp7DFmn2wnKv1Uic75N0pR03csKsYJXxVabilRH7GCs7YP4mu3FPJnxHo1iEt0MqyAM
 wJ9bHdzQs/rAmBz4VMOhxoJv0wUbXqwIilV/ryxy4sn7w16saAirXBz/riDFQamJjTvK
 89f1IVG+CyA661Wbzn+ftRulJ4mf/oEMdJv4Vw4VGk5ekA8Fp6Xl5kZjv/G8a073tgS2
 6BAJ8Isny9WAJYL+XsBGm6/onbaxns5J+0u0LSjYzAv5k57C1Mue3zu2ajVK+5W4LvBX
 mc+A==
X-Gm-Message-State: AC+VfDz9EZ7qcAcbjF55y8049x7X53V3P8faSR14GiRfaUgR43PSp9jm
 jpjKVexTigKrEH00DeXKvs9UgZV5M97eEWJb5uk=
X-Google-Smtp-Source: ACHHUZ52cqxkd+1URXa8xmQ9Z8+dT1NdXhmuT8XbGYaj37E0E5tjDjW3pQL3n0rZ4JwYaspvV1qahA==
X-Received: by 2002:a17:90a:348f:b0:259:ba4a:134d with SMTP id
 p15-20020a17090a348f00b00259ba4a134dmr3705416pjb.20.1686152457679; 
 Wed, 07 Jun 2023 08:40:57 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:f25d:ffb3:64e4:8ded])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a17090a420b00b002591b957641sm1518066pjg.41.2023.06.07.08.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 08:40:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/5] tcg/tci: Adjust call-clobbered regs for int128_t
Date: Wed,  7 Jun 2023 08:40:51 -0700
Message-Id: <20230607154054.625513-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607154054.625513-1-richard.henderson@linaro.org>
References: <20230607154054.625513-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

We require either 2 or 4 registers to hold int128_t.
Failure to do so results in a register allocation assert.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target.c.inc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 5b456e1277..0037f904f1 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -179,8 +179,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 }
 
 static const int tcg_target_reg_alloc_order[] = {
-    TCG_REG_R2,
-    TCG_REG_R3,
     TCG_REG_R4,
     TCG_REG_R5,
     TCG_REG_R6,
@@ -193,6 +191,9 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_R13,
     TCG_REG_R14,
     TCG_REG_R15,
+    /* Either 2 or 4 of these are call clobbered, so use them last. */
+    TCG_REG_R3,
+    TCG_REG_R2,
     TCG_REG_R1,
     TCG_REG_R0,
 };
@@ -934,11 +935,11 @@ static void tcg_target_init(TCGContext *s)
     /*
      * The interpreter "registers" are in the local stack frame and
      * cannot be clobbered by the called helper functions.  However,
-     * the interpreter assumes a 64-bit return value and assigns to
+     * the interpreter assumes a 128-bit return value and assigns to
      * the return value registers.
      */
     tcg_target_call_clobber_regs =
-        MAKE_64BIT_MASK(TCG_REG_R0, 64 / TCG_TARGET_REG_BITS);
+        MAKE_64BIT_MASK(TCG_REG_R0, 128 / TCG_TARGET_REG_BITS);
 
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP);
-- 
2.34.1


