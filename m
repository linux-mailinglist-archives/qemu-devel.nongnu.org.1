Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1133482A19D
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:55:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNefO-00027Q-Vq; Wed, 10 Jan 2024 14:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNefE-00021X-KA
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:55:00 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNefD-0002ig-0f
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:55:00 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40b5155e154so58940585e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704916497; x=1705521297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2YEvqYxr1jwORUy1H416YdJDByH1Bti5dkUqmMcrho=;
 b=SNPeznJKdn3spxrTaB/AgPVwyQuPeNcrCnHPi81o/HfLc+xiYhsQz5fp3uGPXTBA3d
 uBmkj3nyh6b/YGz1f034feoQCOvVxWKe7dIOsu7yJMCzAi3rxHN7d5G+AOneAQBMdZFU
 w/75oQumnLZJRzBMfFD/nS6w8luD02RdEuQBBAS0mCZfGe6+AVrpK1JNsHrdPB10khIo
 hj3mfjCTt5Qbd/5F0m+uJ+9yzBvlBHwYWiyz256VPSgSEVHn6ZWeR0rDrthgFxpbGG4d
 9xlxbE156JeIlv+SXcHfKQtBEYgPFljSSiFX/kEw4WsK13UYprGKhO4WPIOkDQ3BnNfU
 kdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704916497; x=1705521297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H2YEvqYxr1jwORUy1H416YdJDByH1Bti5dkUqmMcrho=;
 b=raPBtt5OczUEwVZDyTFYrUkQKo+dLFxBonOM+q8vHSc6SGkgG+9V30Mapy1WD8h+2P
 EnOf2CNx+fRIQHadFUWorA4L+Ox74RdBtYzuoQsBe05KkPtrzEUeW6TSsXcskC8cPU5S
 TFIbWZU1HuSYM1rkzxYEtsS1nSSPmAeDrrKOUGX+qL0BVhnYGavclFBAyrg3Ez4kWfyf
 qqb2FfxXjnj4KlH4NmVcPp0joL0sOnhs9y7ksvgHvjtBjavixgGgdQ5MuaxTCXxYjHqh
 rG9mxvAwMfnSW7Z3yeJFaX0LyUQK645WkrdoGA9s/iwCV9j+pyLvFn1R2uRoKS1vCOKn
 y+NQ==
X-Gm-Message-State: AOJu0YxOVrB2Es19zFMivDD5clKFYDOjoCQhhkXbqrB71NwXY9qYkZXd
 ODWbmFsOJPji2TsWHKZfo2aCCW3RqW1qlKF6+ypwxkS/9A0=
X-Google-Smtp-Source: AGHT+IHQIfFBBMTYrGuA2Z7LZ0BoaPN7z/xVJtfC+knKSfqFG55a4WX2lBDF0b0ZD9Mqg27tWGP88w==
X-Received: by 2002:a05:600c:4387:b0:40e:511c:ce85 with SMTP id
 e7-20020a05600c438700b0040e511cce85mr866737wmn.57.1704916497248; 
 Wed, 10 Jan 2024 11:54:57 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 l17-20020a05600c1d1100b0040e4a2b36bfsm3188298wms.22.2024.01.10.11.54.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 11:54:56 -0800 (PST)
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
Subject: [PATCH v3 12/14] hw/arm: Prefer arm_feature(GENERIC_TMR) over
 'kvm-no-adjvtime' property
Date: Wed, 10 Jan 2024 20:53:26 +0100
Message-ID: <20240110195329.3995-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110195329.3995-1-philmd@linaro.org>
References: <20240110195329.3995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

First, the "kvm-no-adjvtime" and "kvm-steal-time" are only
available when KVM is available, so guard this block within
a 'kvm_enabled()' check. Since the "kvm-steal-time" property
is always available under KVM, directly set it.

Then, the "kvm-no-adjvtime" property is added to ARMCPU when
the ARM_FEATURE_GENERIC_TIMER feature is available. Rather than
checking whether the QOM property is present, directly check
the feature.

Finally, since we are sure the properties are available, we can
use &error_abort instead of NULL error. Replace:

  object_property_set_bool(..., PROPERTY, ..., &error_abort);

by:

  qdev_prop_set_bit(..., PROPERTY, ...);

which is a one-to-one replacement.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6d1cb24a6e..49ed5309ff 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2150,14 +2150,13 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "has_el2", false, NULL);
         }
 
-        if (vmc->kvm_no_adjvtime &&
-            object_property_find(cpuobj, "kvm-no-adjvtime")) {
-            object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
-        }
-
-        if (vmc->no_kvm_steal_time &&
-            object_property_find(cpuobj, "kvm-steal-time")) {
-            object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
+        if (kvm_enabled()) {
+            if (arm_feature(cpu_env(cs), ARM_FEATURE_GENERIC_TIMER)) {
+                qdev_prop_set_bit(DEVICE(cs), "kvm-no-adjvtime",
+                                  vmc->kvm_no_adjvtime);
+            }
+            qdev_prop_set_bit(DEVICE(cs), "kvm-steal-time",
+                              !vmc->no_kvm_steal_time);
         }
 
         if (arm_feature(cpu_env(cs), ARM_FEATURE_PMU) && vmc->no_pmu) {
-- 
2.41.0


