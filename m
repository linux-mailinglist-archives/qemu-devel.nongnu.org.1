Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE5582A19B
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:55:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNefA-0001pO-47; Wed, 10 Jan 2024 14:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNef7-0001gj-MF
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:53 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNef6-0002dB-1X
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:53 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e5508ecb9so17794965e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704916490; x=1705521290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/Hk2SmJl7pABngKVtRs+8Jo9OKAAK/e6Yxa8zZeHcw=;
 b=quuyPhheOx7P2sVv5vBD7IAouYsfyt119BXc7g8v2AqoTdORDHzSTZvUU/zn3fKVYw
 03HrO1SyGBdQQKIRdGnuSu0COF3eq17EBr5TKmbBAWfqj+2mWryKcZF5C8mlqm0XD8Vv
 0fmPJqhyp4kMZ4vIsyWa8WpXdCUIpZXZAFdVFcjKLj449O7d6u4Zc1VSvupP6w/P2RxY
 XD3mjiPVwtXbYE+oZWU+0eopzZxHZf6K1phZ8U6murfd8T+TlwytR0vbFVQsW1oNviMr
 KWqfUYUK3/rBTjxkk6Jqf00VC5yH91dJ5OY2GgqxmUDHWgJ3tJDtCtxB/3bOsP88/cyw
 0tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704916490; x=1705521290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6/Hk2SmJl7pABngKVtRs+8Jo9OKAAK/e6Yxa8zZeHcw=;
 b=xFHPfBvMcNAEvWv/HyV/VzauCKkEeWcF8jVcXyBlSN6Mcid4GxhhIAznynX7jJ6TJN
 KO+OQuFuFwTlfZfTxaUGPM78DGHVzmMgUt12LlWQ8kMeeHdnCHdKydLX3yMZH77/wdCL
 /6/V11xVUgLq75El7q7m9pOY+BBbL+QkI77MOPkCTjm0AbcUpbNU7ggGzxDMRtWZCuJ3
 coDMuct3eZLQilKI7s8ugShz9jr0dz5ukt0tf3FKR2GGnCqRW3hFTv28jCfg8t/rUl/A
 0DJY1HxTpxk/Rp9H1X4MUnmcjVeVrkN5nUKT5Xh7n/8HAfXSU10Do6b5vFoJJ4MR6a6k
 ZNCA==
X-Gm-Message-State: AOJu0Yzq5Tt/BQA5eIX82C1hBAHUSdo8RhyT/RCQKVHsxbUW5Vel5zpt
 nig4WZRZyw9k4f4nRclV9EA4SbRO6ZCSzuEp4jhSZQ/esFo=
X-Google-Smtp-Source: AGHT+IE2GGMI/J4dfv9lDf41Ytf3T5IQRShNwrRuISaS+JEFOqfMwQ08EvwJ4Wm4/Cn8jqL/QzWuhw==
X-Received: by 2002:a05:600c:2102:b0:40e:5598:be43 with SMTP id
 u2-20020a05600c210200b0040e5598be43mr984802wml.29.1704916490381; 
 Wed, 10 Jan 2024 11:54:50 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 n10-20020a5d420a000000b0033719111458sm5550921wrq.36.2024.01.10.11.54.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 11:54:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/14] hw/arm: Prefer arm_feature(PMU) over
 object_property_find(pmu)
Date: Wed, 10 Jan 2024 20:53:25 +0100
Message-ID: <20240110195329.3995-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110195329.3995-1-philmd@linaro.org>
References: <20240110195329.3995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The "pmu" property is added to ARMCPU when the
ARM_FEATURE_PMU feature is available. Rather than
checking whether the QOM property is present, directly
check the feature.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7e7350fec2..6d1cb24a6e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2160,7 +2160,7 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
         }
 
-        if (vmc->no_pmu && object_property_find(cpuobj, "pmu")) {
+        if (arm_feature(cpu_env(cs), ARM_FEATURE_PMU) && vmc->no_pmu) {
             object_property_set_bool(cpuobj, "pmu", false, NULL);
         }
 
-- 
2.41.0


