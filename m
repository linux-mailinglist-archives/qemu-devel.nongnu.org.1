Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16380723134
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:23:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GcZ-0001r2-OX; Mon, 05 Jun 2023 16:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcW-0001ow-Ev
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:04 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcU-0003qn-MF
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:04 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-65242634690so2955330b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996161; x=1688588161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLSnH2FNmWoBPe6jdA7O8wsGiKQZYAPPgH74uYmHViE=;
 b=E5V9CD4D03iGQukTZwCsLGw1uJlAaQh4hd+eZIJn9TIBaDGcoEtv219H7I29YNU8yv
 ZFAI9xsZ/tkZugGu+3uvfTOOCciZfhupn0zEmiwcjvZJuDjXqFCQ4glPfHi4LFffWmo6
 MQbLb+eiMWisEmDFrnOrTczwQCNkJn2ShAYHEa55Fg+NK9+sl0iMDIRh0SAdLaZo96qB
 uAWR1lZaQn/IHSKL/1eD8aAUKY/mHZtR6dbNlse0flu/C76KNMMGz3rnLDZRkQ7G4zkj
 gOV3cjQ0XuyvzYRjS+VE2FAwbjsFAezrvU2/bPV4gSvVvZUlgn6Q6Jpdi2x/CXz6jIAB
 pQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996161; x=1688588161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLSnH2FNmWoBPe6jdA7O8wsGiKQZYAPPgH74uYmHViE=;
 b=XH7H77MjBHXT4kGkgY2gjSvzdkyTTApPwkiUqCszEnnQzMJsRfoBFm1bexFfsnp2K2
 S1RmskpBegetKQg8ACzurGReciVzN36vkfi8Ef8dCX6fIZeSbvwAYgtonAx7k/FxzROd
 hsyNbe83MjVBqVlmJX4mLwi/L0zEctvwePF4A2UBQdXWN1W3syWhhXSsQFIHSyPkiLeA
 JRiUfCfL46VjTfwWNdDhFfEJWaRKEGo4CBoNUHg9erS3epAcXBk4o1vmZfXuvSEmuq7R
 vQHBNp+iBQVerolSGPIzcfIbN+OtXcQgx8o2Y9kd6hTGMQ33Ecy+Hh08pBJYk7MweK23
 jj2Q==
X-Gm-Message-State: AC+VfDxMN1TIQQjq6VftAQMLA6p67xynDh0C49DoTGf21nQTAkAc1wfV
 e+ZJggM0aSilYZS3ajjMdNZRLWjIZ/VBS+c/64U=
X-Google-Smtp-Source: ACHHUZ47NUdoT1Sbo0CtFAEYA/M1/5xKoZ//Z4xkR5YruJNxmjNeyJHZVIvpNhV9bFTzFprB1ZYLXQ==
X-Received: by 2002:a05:6a20:244b:b0:112:cf5:d5fb with SMTP id
 t11-20020a056a20244b00b001120cf5d5fbmr51194pzc.50.1685996161130; 
 Mon, 05 Jun 2023 13:16:01 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/52] target/arm: Fix test of TCG_OVERSIZED_GUEST
Date: Mon,  5 Jun 2023 13:15:08 -0700
Message-Id: <20230605201548.1596865-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

The symbol is always defined, even if to 0.  We wanted to test for
TCG_OVERSIZED_GUEST == 0.

This fixed, the #error is reached while building arm-softmmu, because
TCG_OVERSIZED_GUEST is not true (nor supposed to be true) for arm32
guest on a 32-bit host.  But that's ok, because this feature doesn't
apply to arm32.  Add an #ifdef for TARGET_AARCH64.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 69c05cd9da..b0d2a05403 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -418,6 +418,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
+#ifdef TARGET_AARCH64
     uint64_t cur_val;
     void *host = ptw->out_host;
 
@@ -473,7 +474,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
      * we know that TCG_OVERSIZED_GUEST is set, which means that we are
      * running in round-robin mode and could only race with dma i/o.
      */
-#ifndef TCG_OVERSIZED_GUEST
+#if !TCG_OVERSIZED_GUEST
 # error "Unexpected configuration"
 #endif
     bool locked = qemu_mutex_iothread_locked();
@@ -497,6 +498,10 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
 #endif
 
     return cur_val;
+#else
+    /* AArch32 does not have FEAT_HADFS. */
+    g_assert_not_reached();
+#endif
 }
 
 static bool get_level1_table_address(CPUARMState *env, ARMMMUIdx mmu_idx,
-- 
2.34.1


