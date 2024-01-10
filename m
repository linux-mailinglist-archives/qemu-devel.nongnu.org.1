Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC45982A192
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:55:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNeek-0007Oz-28; Wed, 10 Jan 2024 14:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeeh-0007Np-V8
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:28 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNeef-0002Gc-Eb
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:54:26 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e461c1f5bso40919675e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704916462; x=1705521262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4lFs+peHffZXBVVkShWxuZ7VjcO+rV+nUwkZ0/LL7Zg=;
 b=CI8+bOHDzSnLg56bZ7TGIOZlof9YHtm1bft1rKMqJh5WVPeuJyDswxW3L15kK/1iAp
 aRYpp7aj8hsxX8TsNdOX6sONADrxLdIP9B7TIl8EkxL6KAUXm0diYRG1yU/E/LcgxcR1
 TYFVhAW+lqpHgvgdcKoYdkn21aEAEgegVd4H2HR2sW1WywQlzauIOcnS6i3LU7AwRmYq
 ZCazDsBu2Kz6M0UPIZ5vmUZ16ItAnUzlx7HIkODVFTqbksMsp52/fmdy8yjwe7IKgRml
 HFkKx/EMRs7ptklHijRiypP6mB+FuvdbhS7PjJMHb3GeiWh9WmYifdYG9va1RzN4sqdj
 CErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704916462; x=1705521262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4lFs+peHffZXBVVkShWxuZ7VjcO+rV+nUwkZ0/LL7Zg=;
 b=julp2aa8wLiLeit4w1D6vW7xDB3IGT5r+NZimX2vTT4BNwm96E6XXmCFwut051oNSh
 lshGmACWZ5TNBVMxKLrTIDhYL/AySDl3/2JDlv/wspaJdQ56rpa2Krq/N21CVC3KnSl/
 5XT5/Ef8RhI+05ZUZCYhFNup96IaleJtaE6SyMcNefJgr2A2T5jgXghp35OLwIvrsqWi
 u55+myXbzByWpCZ4KqjeVt1DRR95iIUvJIsHbvVZ4GYltbDXnxBa7FASYy+N1bHaPXtr
 Zvzy0qLYAJxNTvNLWP7q9oh6DTB5rNdMQX8tekpcB5CWywCu+9QCXh7LPN4SLwqg86x+
 Na3Q==
X-Gm-Message-State: AOJu0Yww1ZstiqnLBn7zr6J/aw5kvq8Kf1QAfTuuXhR5pjtx+mb50Cxq
 cw/fCS8h+JjzkWo4HLnrmcIOz9fKLifPVGbpdOkzbmzLzDA=
X-Google-Smtp-Source: AGHT+IGo64vLyi4J8/55MaWl7n5oNPXeGks42EesEkm5PlwaHr8gvTmJY9i7UaNSbV2yJM7TOxalIA==
X-Received: by 2002:a05:600c:225a:b0:40e:480a:cfa3 with SMTP id
 a26-20020a05600c225a00b0040e480acfa3mr827220wmm.61.1704916462415; 
 Wed, 10 Jan 2024 11:54:22 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 bg3-20020a05600c3c8300b0040d91fa270fsm3245344wmb.36.2024.01.10.11.54.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 11:54:22 -0800 (PST)
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
Subject: [PATCH v3 07/14] hw/arm: Prefer arm_feature(V7) over
 object_property_find(pmsav7-dregion)
Date: Wed, 10 Jan 2024 20:53:21 +0100
Message-ID: <20240110195329.3995-8-philmd@linaro.org>
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

The "pmsav7-dregion" property is added to ARMCPU when the
ARM_FEATURE_V7 feature is available. Rather than checking
whether the QOM property is present, directly check the
feature.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armv7m.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 0a7ad2b762..7f15318ae3 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -338,8 +338,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
                    "mpu-ns-regions and mpu-s-regions properties must have the same value");
         return;
     }
-    if (s->mpu_ns_regions != UINT_MAX &&
-        object_property_find(OBJECT(s->cpu), "pmsav7-dregion")) {
+    if (s->mpu_ns_regions != UINT_MAX && arm_feature(&s->cpu->env,
+                                                     ARM_FEATURE_V7)) {
         if (!object_property_set_uint(OBJECT(s->cpu), "pmsav7-dregion",
                                       s->mpu_ns_regions, errp)) {
             return;
-- 
2.41.0


