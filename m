Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B8E7B2E87
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:56:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9DY-00055f-33; Fri, 29 Sep 2023 04:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DM-0004y1-Jg
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DB-0005c4-E0
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EcNL3KNWfgGlXj+8QerAso4JKo/jrGmH/Zj7oToKoSI=;
 b=IHNr+cY/NlZWhTJb3AXZNybh298dhn79B2AITTJj+xjmcUPkCXMa7m2VUlEKUYTXE7lpqX
 yzEg0XW0iYwPi1LD+iBbPifoaoK0wTvKAIBTMIGoyGoZWccU9CJrqv8nV2TVpzolH4nurl
 zzhWnMBP99toSsMMWYwxDLJzpe48R3w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115--IoKKtiEMlyUhlgi78Svhw-1; Fri, 29 Sep 2023 04:50:56 -0400
X-MC-Unique: -IoKKtiEMlyUhlgi78Svhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F258C3C0F458;
 Fri, 29 Sep 2023 08:50:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B469B176E4;
 Fri, 29 Sep 2023 08:50:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 77EFA21E691A; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/56] hw/arm/armv7m: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:11 +0200
Message-ID: <20230929085053.2789105-15-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Message-ID: <20230904161235.84651-8-philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


