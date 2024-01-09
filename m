Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE89828C26
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:11:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGZG-0003rr-BV; Tue, 09 Jan 2024 13:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGZ2-0003Dh-10
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:11:00 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGYx-0004Su-Da
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:10:59 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-336788cb261so2943034f8f.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704823851; x=1705428651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/Hk2SmJl7pABngKVtRs+8Jo9OKAAK/e6Yxa8zZeHcw=;
 b=i2fOY1ktgha4L+5k2r1rMm8v9EKXXHT4l9L5d1tP2GhpwxOlbavit4KbWQhw26oytK
 Ip4TCPSRbiitZzRkGM2xvaYDcI4eeEJjUrGcYZh2Su/pm68Q02eDm+MXS5PqyRJHZmrZ
 rp0GOgC/jIdVZA6nHPFOXIyTqgmb0WO0I4TzYHpMiEOKVAg0JCynnzJzgC1+FNSdgihO
 i/ZEh2eJitA5C7tQVd3pyJH0P7bnYEQFXrY9u5F+RlmHFjtGwubE2/1a2iX45rqd3IVA
 yrhcPxgh4otDHzgbKQn1ZLOszTVmkVuP1bhCQs/PPmAXfo+KydUPC+Bh1tqXL/NnuTbc
 sbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823851; x=1705428651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6/Hk2SmJl7pABngKVtRs+8Jo9OKAAK/e6Yxa8zZeHcw=;
 b=PlifAHMs+5OkV4l2Q8hyyqBReyH+HFrXrERTvmXi56S+TM+861pxclZbSAQ0tM3xi9
 s6vXU4uOcTsfkE1hZOQ2is9vTU/d3gCb2L841sJdnASZgdJYU97kYXv1pcowbkirEqDG
 VGBBw4ZpQJm10QMxsB/O2A1hGCHsH11MYFsMObiJz+ajoDRW4JQugdy1+qjZgr76Cj55
 +P0zv3IRO3F5Go5BilAVvPHHVGUMWP9fj0Pm1sxyy9rTZZXbd/xbjEVx1SqIwkbbJugE
 /G0AnUomKrEWstvkUsgGOwQt2TD/J2IsDct7as1UTcLvMYYdb374dV1EYouBccu5XR51
 B0mg==
X-Gm-Message-State: AOJu0Yy3QKAziTDIxsLpQSJiPXK/YKs06XZ4cd+JD6e/CljkLPMkULP0
 13JEaTTyl+zWwmnOR/O1N+hR9WNznnGYO30OsdnLks44646Ogw==
X-Google-Smtp-Source: AGHT+IG6SDRF1HikcCuasNNF5WnbAgjNpyY8+e0PFZnSHKwJdhTPUaJzLv6rB04SysNAE0qTuR7vew==
X-Received: by 2002:a5d:4cc9:0:b0:336:c4c1:2d77 with SMTP id
 c9-20020a5d4cc9000000b00336c4c12d77mr740810wrt.73.1704823850830; 
 Tue, 09 Jan 2024 10:10:50 -0800 (PST)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 l8-20020adfe9c8000000b003365951cef9sm2990208wrn.55.2024.01.09.10.10.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jan 2024 10:10:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/14] hw/arm: Prefer arm_feature(PMU) over
 object_property_find(pmu)
Date: Tue,  9 Jan 2024 19:09:27 +0100
Message-ID: <20240109180930.90793-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240109180930.90793-1-philmd@linaro.org>
References: <20240109180930.90793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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


