Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5547C80F2CD
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:34:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5f1-0002st-Lb; Tue, 12 Dec 2023 11:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5ey-0002db-KQ
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:31:04 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5ew-0007TO-Ed
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:31:04 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55114c073b8so3625687a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398661; x=1703003461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suvN+YJQ4ci7BcP7cxgDGLkeAASL5qV684+uLcglZPc=;
 b=iZSOobZPgB19Lma4mfVXBo4Iw3Z71FxjL5fN/OLw25cHgqtg7d5pi6Yn6+8As8ef/V
 06uL5NqzTpNsp2IXznB/V9FLgbFqtI0BXs7DryCvOqeT/uju0jEw9yMvTZ1nnVsb5Fju
 yiYCWhy+Di+x6TDKccZw6kEuNoRN92NUmL21KJbypHcQzp63jzMEDqSA3mvx/wAxTmPD
 YWM8M7yw6BwOzGzMA5basKGcBbVebuQzYjO2Oky0y4zXME1zr4j+UmcXxxahpF3uosRD
 VxoRl65Ri+Wdnnzai4XoMFYkmfNFaWo9q5get8SN7JsmGcCWFaV8LVbRmb6Uibjk2YRF
 7nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398661; x=1703003461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suvN+YJQ4ci7BcP7cxgDGLkeAASL5qV684+uLcglZPc=;
 b=prKDlP6yoFixVH/9DnMfJvIImhyiBK++9aVft3VMLn3jj3OOfz5N1gObtWSErg2mzq
 MQGf5qarikuRC5YblByiMUfLdTTr92FLklrXK44bCAOSB4SJl3Z/md8pp8ouQpOxhill
 tFkdMymNpFG/t7LuBnKmPXBpiZWHFsVp2aHqGFSA9Sa8gr1Y1T7bw3Bsfd7KFcMuIgi5
 frUSJwSVDSogEYM42j6hlsey4OdXCVqf/LT10nR6pGumYXPl/kJMOx7HHVY8n1LAmKV4
 DDFzttnk62VEzLNjT4infHYA15OMG5A6trYv0AL2cDucuMquMKenrOzgkCdCtQ/3eW6y
 BqfA==
X-Gm-Message-State: AOJu0Yzj6kWuZWazIbR/P9BOGCBNNL3+r2IROd9y6Ty7+nPxE3h/90MC
 1jjGzR3Ipc2eJVGAPqlq8xKWtHGOpAzeTsGgjXM=
X-Google-Smtp-Source: AGHT+IHmBDaDXhDW4r1hPO1YrXSbvBvxkh74Jkp/r8xWGBdiM2yuCIjHrNpddidSrj2M6FPxqtpzxg==
X-Received: by 2002:a17:906:51c7:b0:a1b:70fb:4517 with SMTP id
 v7-20020a17090651c700b00a1b70fb4517mr2121788ejk.151.1702398660769; 
 Tue, 12 Dec 2023 08:31:00 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 uh17-20020a170906b39100b00a1d5063b01csm6482417ejc.190.2023.12.12.08.30.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:31:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/33] hw/cpu/arm: Have A9MPCORE/A15MPCORE inheritate common
 CORTEX_MPCORE_PRIV
Date: Tue, 12 Dec 2023 17:29:11 +0100
Message-ID: <20231212162935.42910-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

TYPE_CORTEX_MPCORE_PRIV becomes the common parent to
TYPE_A9MPCORE_PRIV and TYPE_A15MPCORE_PRIV.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/cpu/cortex_mpcore.h |  6 ++++--
 hw/cpu/a15mpcore.c             | 14 ++++++++++++--
 hw/cpu/a9mpcore.c              | 13 +++++++++++--
 hw/arm/Kconfig                 |  2 ++
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/hw/cpu/cortex_mpcore.h b/include/hw/cpu/cortex_mpcore.h
index c5dd7200d0..4084c6003a 100644
--- a/include/hw/cpu/cortex_mpcore.h
+++ b/include/hw/cpu/cortex_mpcore.h
@@ -32,6 +32,8 @@ OBJECT_DECLARE_TYPE(CortexMPPrivState, CortexMPPrivClass, CORTEX_MPCORE_PRIV)
 
 struct CortexMPPrivClass {
     SysBusDeviceClass parent_class;
+
+    DeviceRealize parent_realize;
 };
 
 struct CortexMPPrivState {
@@ -42,7 +44,7 @@ struct CortexMPPrivState {
 OBJECT_DECLARE_SIMPLE_TYPE(A9MPPrivState, A9MPCORE_PRIV)
 
 struct A9MPPrivState {
-    SysBusDevice parent_obj;
+    CortexMPPrivState parent_obj;
 
     uint32_t num_cpu;
     MemoryRegion container;
@@ -59,7 +61,7 @@ struct A9MPPrivState {
 OBJECT_DECLARE_SIMPLE_TYPE(A15MPPrivState, A15MPCORE_PRIV)
 
 struct A15MPPrivState {
-    SysBusDevice parent_obj;
+    CortexMPPrivState parent_obj;
 
     uint32_t num_cpu;
     uint32_t num_irq;
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 0f56c40b86..5a57145179 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -48,15 +48,23 @@ static void a15mp_priv_initfn(Object *obj)
 
 static void a15mp_priv_realize(DeviceState *dev, Error **errp)
 {
+    CortexMPPrivClass *cc = CORTEX_MPCORE_PRIV_GET_CLASS(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     A15MPPrivState *s = A15MPCORE_PRIV(dev);
     DeviceState *gicdev;
     SysBusDevice *gicsbd;
+    Error *local_err = NULL;
     int i;
     bool has_el3;
     bool has_el2 = false;
     Object *cpuobj;
 
+    cc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     gicdev = DEVICE(&s->gic);
     qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
@@ -158,8 +166,10 @@ static Property a15mp_priv_properties[] = {
 static void a15mp_priv_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    CortexMPPrivClass *cc = CORTEX_MPCORE_PRIV_CLASS(klass);
 
-    dc->realize = a15mp_priv_realize;
+    device_class_set_parent_realize(dc, a15mp_priv_realize,
+                                    &cc->parent_realize);
     device_class_set_props(dc, a15mp_priv_properties);
     /* We currently have no saveable state */
 }
@@ -167,7 +177,7 @@ static void a15mp_priv_class_init(ObjectClass *klass, void *data)
 static const TypeInfo a15mp_types[] = {
     {
         .name           = TYPE_A15MPCORE_PRIV,
-        .parent         = TYPE_SYS_BUS_DEVICE,
+        .parent         = TYPE_CORTEX_MPCORE_PRIV,
         .instance_size  = sizeof(A15MPPrivState),
         .instance_init  = a15mp_priv_initfn,
         .class_init     = a15mp_priv_class_init,
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index e9cd71e92f..d59e49126b 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -46,11 +46,13 @@ static void a9mp_priv_initfn(Object *obj)
 
 static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 {
+    CortexMPPrivClass *cc = CORTEX_MPCORE_PRIV_GET_CLASS(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     A9MPPrivState *s = A9MPCORE_PRIV(dev);
     DeviceState *scudev, *gicdev, *gtimerdev, *mptimerdev, *wdtdev;
     SysBusDevice *scubusdev, *gicbusdev, *gtimerbusdev, *mptimerbusdev,
                  *wdtbusdev;
+    Error *local_err = NULL;
     int i;
     bool has_el3;
     CPUState *cpu0;
@@ -65,6 +67,12 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    cc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     scudev = DEVICE(&s->scu);
     qdev_prop_set_uint32(scudev, "num-cpu", s->num_cpu);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
@@ -173,15 +181,16 @@ static Property a9mp_priv_properties[] = {
 static void a9mp_priv_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    CortexMPPrivClass *cc = CORTEX_MPCORE_PRIV_CLASS(klass);
 
-    dc->realize = a9mp_priv_realize;
+    device_class_set_parent_realize(dc, a9mp_priv_realize, &cc->parent_realize);
     device_class_set_props(dc, a9mp_priv_properties);
 }
 
 static const TypeInfo a9mp_types[] = {
     {
         .name           = TYPE_A9MPCORE_PRIV,
-        .parent         = TYPE_SYS_BUS_DEVICE,
+        .parent         = TYPE_CORTEX_MPCORE_PRIV,
         .instance_size  =  sizeof(A9MPPrivState),
         .instance_init  = a9mp_priv_initfn,
         .class_init     = a9mp_priv_class_init,
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3040342fcb..ec6e585797 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -648,6 +648,7 @@ config CORTEX_MPCORE
 
 config A9MPCORE
     bool
+    select CORTEX_MPCORE
     select A9_GTIMER
     select A9SCU       # snoop control unit
     select ARM_GIC
@@ -655,6 +656,7 @@ config A9MPCORE
 
 config A15MPCORE
     bool
+    select CORTEX_MPCORE
     select ARM_GIC
 
 config ARM11MPCORE
-- 
2.41.0


