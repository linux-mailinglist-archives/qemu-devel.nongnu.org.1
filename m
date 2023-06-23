Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8853073BBEB
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 17:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCiv9-0001do-QF; Fri, 23 Jun 2023 11:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCiuq-0001dL-Q0
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:41:43 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCiuo-0008MV-TZ
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:41:40 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso795568f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687534897; x=1690126897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0ehBAGjrrkyk5SNhyBclcjFfgNXByJfqpK/F+XSrmwI=;
 b=GPto7RGWPkV2F0nHpTBpmoAIFkh+/5bdWAm+/Eegd9zearUXAqhxWdlk1U1o91j0AV
 8tjw3srkfxZIf9xNZn6Fawz65I3l+Vj+RyQF8I3w2U9/u8YH6KppHs4s6lOqEvf0SCol
 jvEjf+1iGdstqs7TUKLw8q9SHKZdJ8zQ7y6vGexgzHq3VoWwfe2BD+cZTPd/ZvXYFhph
 7oxPApnYWI7nMAlEhOeqeGWI24CV/x/HaImeWFBeknrFh5RW5jNWyaqW5S7+0kBrWHZR
 DhuvMCyyV9qGcgXcMYGB/ZLTs4/yV3bYDJpaP1o3pmLcD5JetcJZ8Jm578mIu63AHsdk
 ZvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687534897; x=1690126897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ehBAGjrrkyk5SNhyBclcjFfgNXByJfqpK/F+XSrmwI=;
 b=AZwT4cR7ltkMdNKIz1GnfgcveKlFu1LPVX1er9zwxWy/37W83HhAPog+aX9k5MFMi7
 TyjBdlPUpN6xsQgmG73HXumASIJGcl+CA3jsemywFZlxlfQPs7XNJi8Qv/NDx4ttBwim
 eS5bizykLfyAhhYMMFEtuaSIE+/PI4po1scV4mgWS839v/RjDL5zu8fxYdcLM2LRqhKu
 cTLVjhkZjnEnY88Ihk3Shh2MvwuTo1/iVCXvzA2MLdUlZZUIJfz9cdQ2dtdYQDldABYT
 FQ9o07iRf/xxZGhtu806RsMha2CHDiYyLFXAvbmM7I/4RkUuoSHIejDCPSmHk2GvSbsL
 KLWA==
X-Gm-Message-State: AC+VfDwTmnxZiH+HSaTHvABE2IBE923NH8Rpk1oVhfN2BqGkR7KcVDkU
 yV/3JaYonIciy93uUqpNvIpBiJuFLOn4x20/RHg=
X-Google-Smtp-Source: ACHHUZ5g+/Q17NHsmCrBYCwexvr5092gDZKgfoWVlj+b7Vj3Cnn/Ljl1pYQfI8hMfJWEihgZNLQfQQ==
X-Received: by 2002:adf:e8c1:0:b0:30f:bcf3:9a30 with SMTP id
 k1-20020adfe8c1000000b0030fbcf39a30mr4372110wrn.17.1687534897464; 
 Fri, 23 Jun 2023 08:41:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a5d45ce000000b0031118d80246sm9830070wrs.29.2023.06.23.08.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 08:41:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] target/xtensa: Assert that interrupt level is within bounds
Date: Fri, 23 Jun 2023 16:41:35 +0100
Message-Id: <20230623154135.1930261-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

In handle_interrupt() we use level as an index into the interrupt_vector[]
array. This is safe because we have checked it against env->config->nlevel,
but Coverity can't see that (and it is only true because each CPU config
sets its XCHAL_NUM_INTLEVELS to something less than MAX_NLEVELS), so it
complains about a possible array overrun (CID 1507131)

Add an assert() which will make Coverity happy and catch the unlikely
case of a mis-set XCHAL_NUM_INTLEVELS in future.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
NB: only tested with 'make check-avocado'. You could argue that we
should mark the coverity issue as false-positive instead if you like.
---
 target/xtensa/exc_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index d4823a65cda..43f6a862de2 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -169,6 +169,9 @@ static void handle_interrupt(CPUXtensaState *env)
         CPUState *cs = env_cpu(env);
 
         if (level > 1) {
+            /* env->config->nlevel check should have ensured this */
+            assert(level < sizeof(env->config->interrupt_vector));
+
             env->sregs[EPC1 + level - 1] = env->pc;
             env->sregs[EPS2 + level - 2] = env->sregs[PS];
             env->sregs[PS] =
-- 
2.34.1


