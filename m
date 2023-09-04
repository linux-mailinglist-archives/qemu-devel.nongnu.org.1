Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 384D8791B33
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:14:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCCf-0002kh-Ih; Mon, 04 Sep 2023 12:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCY-0002bg-Ue
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:24 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCV-0007WT-FJ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:22 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52c74a2e8edso2352982a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693843997; x=1694448797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LlxpFbCHiWjslLmUxZfZSQm0srNjNWhApIJsD1WDg2g=;
 b=p5vKNy9ENT9lXx0QojN/p20L4bgdRNkS023pkLbgSZDcr3aXUF0Q9sovdOJca5/9JD
 p4xEB3DdkUjbhh3a8tGuT4AuvCe6mD+kwy9eC0KiV3+MKDcZlLdw0Srfv9br+Zvd3juu
 krz6e6+Lxi+SNcc275ffqOdyZ6qXqLzoaYO0FHTtdZx2EPRUHnqDRp9p7c7wcHjWMkRQ
 2YO1H+pYBMAdMcARS248i18DHa7sDy4enQwJSLDKPqtLEPSV6AjGWBtK2HXZiWoVUg3J
 HsKHNbE8M46dXkDdJaThZUW2Fv3IK+FfZhNpbSm0LjwpQsL08dS6LkrSigE2U8/5rO6F
 qxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693843997; x=1694448797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LlxpFbCHiWjslLmUxZfZSQm0srNjNWhApIJsD1WDg2g=;
 b=any8bEy9L5CweQD9bx9j6CPqbaL2NvILjynPowkcFZF3kUo26CH3V5AyjwGUDR0ytw
 1+utCejKbzlCLg5C00zVxrl4I41NWIODV7fYhPfnokPrNihpox5uFivAet1IF7tNgU+G
 +UOIH2mtKda6CtveZtMc9CuhNufJmeQ1yW1syO4dbXKIjtEqxxwJUGLZL8YuUf45IDNu
 d4Kx3wi+DRo1SCI6yQIgoJu30yF2r8ONSSCN6UyeiKw+N9iFT02QZnAX+XKh7K6SLVJt
 EwZCZYTEAmT/8kjjCUnbz+HCNZkt6v4ZiZQ90WN18HD3pEFfDAdl32ZjNilVSoiGHbMZ
 Qddg==
X-Gm-Message-State: AOJu0YzhlERNW4Oo2zjqSQJM16CYs5Ri5fVBI4BqB+1n8rFo7gCgaCf+
 MdXNBFoZFuy+zZOaWKiKYz4i6g==
X-Google-Smtp-Source: AGHT+IEhZ9kvBDsoaYLY4Q/fNQLsRrvTJTGZrFKuJhZVz79KGWvOKOe6yJLF6Tvz+ig51XhirQg1ew==
X-Received: by 2002:aa7:d615:0:b0:523:2e63:b9b with SMTP id
 c21-20020aa7d615000000b005232e630b9bmr9196767edr.24.1693843997702; 
 Mon, 04 Sep 2023 09:13:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a50ee85000000b0052595b17fd4sm5941517edr.26.2023.09.04.09.13.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:13:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 07/22] hw/arm/armv7m: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:19 +0200
Message-ID: <20230904161235.84651-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix:

  hw/arm/armv7m.c: In function ‘armv7m_realize’:
  hw/arm/armv7m.c:520:27: warning: declaration of ‘sbd’ shadows a previous local [-Wshadow=compatible-local]
    520 |             SysBusDevice *sbd = SYS_BUS_DEVICE(&s->bitband[i]);
        |                           ^~~
  hw/arm/armv7m.c:278:19: note: shadowed declaration is here
    278 |     SysBusDevice *sbd;
        |                   ^~~
       ---

  hw/arm/armsse.c: In function ‘armsse_realize’:
  hw/arm/armsse.c:1471:27: warning: declaration of ‘mr’ shadows a previous local [-Wshadow=compatible-local]
   1471 |             MemoryRegion *mr;
        |                           ^~
  hw/arm/armsse.c:917:19: note: shadowed declaration is here
    917 |     MemoryRegion *mr;
        |                   ^~
       ---

  hw/arm/armsse.c:1608:22: warning: declaration of ‘dev_splitter’ shadows a previous local [-Wshadow=compatible-local]
   1608 |         DeviceState *dev_splitter = DEVICE(splitter);
        |                      ^~~~~~~~~~~~
  hw/arm/armsse.c:923:18: note: shadowed declaration is here
    923 |     DeviceState *dev_splitter;
        |                  ^~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armsse.c | 16 ++++++----------
 hw/arm/armv7m.c |  2 +-
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 11cd08b6c1..31acbf7347 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -1468,7 +1468,6 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     if (info->has_cachectrl) {
         for (i = 0; i < info->num_cpus; i++) {
             char *name = g_strdup_printf("cachectrl%d", i);
-            MemoryRegion *mr;
 
             qdev_prop_set_string(DEVICE(&s->cachectrl[i]), "name", name);
             g_free(name);
@@ -1484,7 +1483,6 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     if (info->has_cpusecctrl) {
         for (i = 0; i < info->num_cpus; i++) {
             char *name = g_strdup_printf("CPUSECCTRL%d", i);
-            MemoryRegion *mr;
 
             qdev_prop_set_string(DEVICE(&s->cpusecctrl[i]), "name", name);
             g_free(name);
@@ -1499,7 +1497,6 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
     if (info->has_cpuid) {
         for (i = 0; i < info->num_cpus; i++) {
-            MemoryRegion *mr;
 
             qdev_prop_set_uint32(DEVICE(&s->cpuid[i]), "CPUID", i);
             if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpuid[i]), errp)) {
@@ -1512,7 +1509,6 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
     if (info->has_cpu_pwrctrl) {
         for (i = 0; i < info->num_cpus; i++) {
-            MemoryRegion *mr;
 
             if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpu_pwrctrl[i]), errp)) {
                 return;
@@ -1605,7 +1601,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     /* Wire up the splitters for the MPC IRQs */
     for (i = 0; i < IOTS_NUM_EXP_MPC + info->sram_banks; i++) {
         SplitIRQ *splitter = &s->mpc_irq_splitter[i];
-        DeviceState *dev_splitter = DEVICE(splitter);
+        DeviceState *devs = DEVICE(splitter);
 
         if (!object_property_set_int(OBJECT(splitter), "num-lines", 2,
                                      errp)) {
@@ -1617,22 +1613,22 @@ static void armsse_realize(DeviceState *dev, Error **errp)
 
         if (i < IOTS_NUM_EXP_MPC) {
             /* Splitter input is from GPIO input line */
-            s->mpcexp_status_in[i] = qdev_get_gpio_in(dev_splitter, 0);
-            qdev_connect_gpio_out(dev_splitter, 0,
+            s->mpcexp_status_in[i] = qdev_get_gpio_in(devs, 0);
+            qdev_connect_gpio_out(devs, 0,
                                   qdev_get_gpio_in_named(dev_secctl,
                                                          "mpcexp_status", i));
         } else {
             /* Splitter input is from our own MPC */
             qdev_connect_gpio_out_named(DEVICE(&s->mpc[i - IOTS_NUM_EXP_MPC]),
                                         "irq", 0,
-                                        qdev_get_gpio_in(dev_splitter, 0));
-            qdev_connect_gpio_out(dev_splitter, 0,
+                                        qdev_get_gpio_in(devs, 0));
+            qdev_connect_gpio_out(devs, 0,
                                   qdev_get_gpio_in_named(dev_secctl,
                                                          "mpc_status",
                                                          i - IOTS_NUM_EXP_MPC));
         }
 
-        qdev_connect_gpio_out(dev_splitter, 1,
+        qdev_connect_gpio_out(devs, 1,
                               qdev_get_gpio_in(DEVICE(&s->mpc_irq_orgate), i));
     }
     /* Create GPIO inputs which will pass the line state for our
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index bf173b10b8..1f78e18872 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -517,7 +517,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < ARRAY_SIZE(s->bitband); i++) {
         if (s->enable_bitband) {
             Object *obj = OBJECT(&s->bitband[i]);
-            SysBusDevice *sbd = SYS_BUS_DEVICE(&s->bitband[i]);
+            sbd = SYS_BUS_DEVICE(&s->bitband[i]);
 
             if (!object_property_set_int(obj, "base",
                                          bitband_input_addr[i], errp)) {
-- 
2.41.0


