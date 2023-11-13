Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B427EA24F
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:47:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2b1V-0007JO-TM; Mon, 13 Nov 2023 12:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2b1H-0006wy-DP
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:46:44 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2b1E-0003Jr-F2
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:46:43 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40a4d04af5cso16397165e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699897599; x=1700502399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V5Ainl8mAVCq+cDQ3NH1GIuR546ttmnhxNDBTCTMOEM=;
 b=Ej9zHNwsJgisf5FBJzYJeopsT42Y1I9zdNf+aXfAnQqq49WEkB21zuvb8M0nuNnGKG
 TOaR6FhqHW0Z7ntulKAlxraYPvGCu0MyoIiMAndBsKWkKcJUO6dOQ0Arms2iS7m5jb3V
 l7flw1mwDsDjod4df/33HqL+SDmn9cb/Qqvv2WSZoG/Of4ZSO+fUYRtkS3bXiziw3Xo0
 x0YqpeDVJJRkFjmYo0cbw+HgRR4Yy4ZJJYU5qa11tKT4Ln/mvBIl+DzV9VmfjpJzNepH
 m4pickk7gbP82PzVnvTJC+6Rjh/eXSQovi+FmXBgEid/2IJ9KOlZsTXsIPlocFzUru7l
 lUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699897599; x=1700502399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5Ainl8mAVCq+cDQ3NH1GIuR546ttmnhxNDBTCTMOEM=;
 b=MfkbSTUog4j0g8dGMtyHb9uOFTu878O4v/fSZoiiqlk1vQBymndlMqTZ3NqdmqdiJN
 6l4K7vb37GWz50KXP2UOrhWyrDViYaLZyJLwHaaSSl+GYu3CYrnrOb6sv8PMINX2jgwm
 hNWeT1Ph9oGaQ8SmDbovSxMyrxQG0qoOAx9h0NzVTc36N+zSULhhDBXn5gsuXZdwR+9W
 FgIoKsHU+ZeNEtBmuPq8gC1LAbQwCjsKfdrIw8qZum9YrvAxZsHmYkpuGCqsfdgS9FnK
 ZxGbikPlLn4prSkBU1xHG1aqq4R2Ai2H2dO7SR87/LlF0oZzIlaTWgjDsSO17mV6ExlS
 B01A==
X-Gm-Message-State: AOJu0YyexVQmOOf8roy+CSyzyebvnpQqp2R0UDeMFxMsIZ1v3GmUMG3q
 wGMK5m04vTrbiEftPD05ZnT+/GIbwhO8nw0GYYQ=
X-Google-Smtp-Source: AGHT+IFEuQvaWQivjEYr20G5WNYSNKPpcoe3pTvveCx9hVcYVuaIFGakLqvaXuJQ86Ex7SAagGfGWA==
X-Received: by 2002:a05:600c:450a:b0:409:375:5a44 with SMTP id
 t10-20020a05600c450a00b0040903755a44mr6112747wmo.24.1699897598975; 
 Mon, 13 Nov 2023 09:46:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c22c800b0040303a9965asm14391110wmg.40.2023.11.13.09.46.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:46:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] target/arm/tcg: enable PMU feature for Cortex-A8 and A9
Date: Mon, 13 Nov 2023 17:46:35 +0000
Message-Id: <20231113174635.2540484-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113174635.2540484-1-peter.maydell@linaro.org>
References: <20231113174635.2540484-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Nikita Ostrenkov <n.ostrenkov@gmail.com>

According to the technical reference manual, the Cortex-A9
has a Perfomance Unit Monitor (PMU):
https://developer.arm.com/documentation/100511/0401/performance-monitoring-unit/about-the-performance-monitoring-unit
The Cortex-A8 does also.

We already already define the PMU registers when emulating the
Cortex-A8 and Cortex-A9, because we put them in v7_cp_reginfo[]
rather than guarding them behind ARM_FEATURE_PMU.  So the only thing
that setting the feature bit changes is that the registers actually
do something.

Enable ARM_FEATURE_PMU for Cortex-A8 and Cortex-A9, to avoid
this anomaly.

(The A8 and A9 PMU predates the standardisation of ID_DFR0.PerfMon,
so the field there is 0, but the PMU is still present.)

Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Message-id: 20231112165658.2335-1-n.ostrenkov@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: tweaked commit message; also enable PMU for A8]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 0d5d8e307dd..d9e0e2a4ddf 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -351,6 +351,7 @@ static void cortex_a8_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
     cpu->midr = 0x410fc080;
     cpu->reset_fpsid = 0x410330c0;
     cpu->isar.mvfr0 = 0x11110222;
@@ -418,6 +419,7 @@ static void cortex_a9_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
     /*
      * Note that A9 supports the MP extensions even for
      * A9UP and single-core A9MP (which are both different
-- 
2.34.1


