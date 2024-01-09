Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4CA828C3B
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:13:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGZP-00050H-Ue; Tue, 09 Jan 2024 13:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGZA-0003qJ-8h
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:11:08 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGZ7-0004Zg-3A
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:11:08 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3374c693f92so2657475f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704823863; x=1705428663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHN1WAhVwI6VDlIQMYmKaw16w5C6ru8lwNtKGuzaAIs=;
 b=QyDFv6mbJQoNvRXQrF0Y2qosLHdkQxbY8hgtWNDeOvGpsb98Fw3ixC/qIf+4tBdQEq
 EL9s2y/XfdLlWbsDf62PRTV4EA/H2R/uMd597fCf0Ye3ILweg9ZpKfqOQTGnd6GHtRKx
 mdbQvxQgIpJqWtgWT5BqiYMaHgW07noZozAzpZVLd9SOPtr71O5PeODnYyh2xncY5+Ne
 wbmBxi048zRxcAbtY6einkXKxuptBZ3LYT4Y8BBza7+6j29grYFQ9n4roRDp+2tY041O
 kQAZchlWg27TAKPFnAoAUEoQ9gu8XjfGRFoycJgg+mMG4AQmMKNgEbAJwh9o3HKCTzqA
 EpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823863; x=1705428663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZHN1WAhVwI6VDlIQMYmKaw16w5C6ru8lwNtKGuzaAIs=;
 b=kSG9D+hGNYpM7BhzT0V1vndr1vj7ER9/wL6oZv8DIQoEjUGqyKUv9tPl2MSafKGR4R
 VEn1IwzLUmcv69ttSEp/Xl4k8rWc/DUT57qD95QMhDbu1AQMRfFyECgRwDelDTwcooAy
 klN8LZNal477v6nQS5Ak0n2UNSgFykSxzRf9zBPlqnVj8WOidajd6d2kkEaVhTKNilvk
 CU5Sdvsz6bu4VdvMYWUCDB3fpj/rIcGuxOAwl+j8WP9IQHacdT/4SoFNQ4VoqAhUXnCs
 CWeFhvscMK2ZKO6p/EmcNqnS9SaBWCkVPFmM9TESBNiwc3E3sB67SEDBwurPnkKtxVgX
 z3Tw==
X-Gm-Message-State: AOJu0YyYbTGYzA5CLxNDdj33YWgE/Ihz2aOc9YMFLLvZqZXzVNbvNBMK
 cgsn9Q5n8gc3nmMmZszvIb+C7kcxlCura+ilnb5VAJz//uawrA==
X-Google-Smtp-Source: AGHT+IGIz637i+TAvNSq57H+nTqLxDg7EkXy3wFfa4jY9jgSh7ImiwDSTSWIh/OyzSTvsMIDN4DJ2Q==
X-Received: by 2002:a5d:5917:0:b0:337:5d2:f6cb with SMTP id
 v23-20020a5d5917000000b0033705d2f6cbmr845759wrd.54.1704823863496; 
 Tue, 09 Jan 2024 10:11:03 -0800 (PST)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 i6-20020adfe486000000b003368d2e729bsm2988794wrm.43.2024.01.09.10.11.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jan 2024 10:11:02 -0800 (PST)
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
Subject: [PATCH v2 14/14] hw/arm: Prefer arm_feature(GENERIC_TMR) over
 'kvm-no-adjvtime' property
Date: Tue,  9 Jan 2024 19:09:29 +0100
Message-ID: <20240109180930.90793-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240109180930.90793-1-philmd@linaro.org>
References: <20240109180930.90793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
index 2ce4a18d73..6ac8fb19d2 100644
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


