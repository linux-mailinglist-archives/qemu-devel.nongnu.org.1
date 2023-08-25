Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA471788E0F
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 19:52:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZayD-0005M5-By; Fri, 25 Aug 2023 13:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZayB-0005Lv-Ue
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZay9-0000kN-QO
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692985896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HhoHjczvmdxo+GXe0dtUlDRMabBbHFNBo9Dag2DJ49k=;
 b=aEMgEbLIHDMmNtc7EY+ZQX7PAbesKTLQV6kE2jcPTQKLjaWzpZVjgV7fl0oaqY96QkuocG
 YEAl6tU52/2CWete6yklRz9l3OGVt/ga5a/l6O50fMcWE8EkrZIQWop4ovJNKO9EFq0/gz
 wm4xvyemqIMqqvG5qEI+2s2O9JT2Boo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-KX837bYyM0Sfi6ftAxNS7A-1; Fri, 25 Aug 2023 13:51:32 -0400
X-MC-Unique: KX837bYyM0Sfi6ftAxNS7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9CAE8030B1;
 Fri, 25 Aug 2023 17:51:31 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8070C6B2B6;
 Fri, 25 Aug 2023 17:51:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH 2/3] hw/mips/jazz: Move the NIC init code into a separate
 function
Date: Fri, 25 Aug 2023 19:51:22 +0200
Message-Id: <20230825175123.624114-3-thuth@redhat.com>
In-Reply-To: <20230825175123.624114-1-thuth@redhat.com>
References: <20230825175123.624114-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The mips_jazz_init() function is already quite big, so moving
away some code here can help to make it more understandable.
Additionally, by moving this code into a separate function, the
next patch (that will refactor the for-loop around the NIC init
code) will be much shorter and easier to understand.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/mips/jazz.c | 62 ++++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 358bb6f74f..a95a1bd743 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -114,6 +114,40 @@ static const MemoryRegionOps dma_dummy_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static void mips_jazz_init_net(NICInfo *nd, IOMMUMemoryRegion *rc4030_dma_mr,
+                               DeviceState *rc4030, MemoryRegion *dp8393x_prom)
+{
+    DeviceState *dev;
+    SysBusDevice *sysbus;
+    int checksum, i;
+    uint8_t *prom;
+
+    qemu_check_nic_model(nd, "dp83932");
+
+    dev = qdev_new("dp8393x");
+    qdev_set_nic_properties(dev, nd);
+    qdev_prop_set_uint8(dev, "it_shift", 2);
+    qdev_prop_set_bit(dev, "big_endian", target_words_bigendian());
+    object_property_set_link(OBJECT(dev), "dma_mr",
+                             OBJECT(rc4030_dma_mr), &error_abort);
+    sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus_mmio_map(sysbus, 0, 0x80001000);
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 4));
+
+    /* Add MAC address with valid checksum to PROM */
+    prom = memory_region_get_ram_ptr(dp8393x_prom);
+    checksum = 0;
+    for (i = 0; i < 6; i++) {
+        prom[i] = nd->macaddr.a[i];
+        checksum += prom[i];
+        if (checksum > 0xff) {
+            checksum = (checksum + 1) & 0xff;
+        }
+    }
+    prom[7] = 0xff - checksum;
+}
+
 #define MAGNUM_BIOS_SIZE_MAX 0x7e000
 #define MAGNUM_BIOS_SIZE                                                       \
         (BIOS_SIZE < MAGNUM_BIOS_SIZE_MAX ? BIOS_SIZE : MAGNUM_BIOS_SIZE_MAX)
@@ -287,33 +321,7 @@ static void mips_jazz_init(MachineState *machine,
             nd->model = g_strdup("dp83932");
         }
         if (strcmp(nd->model, "dp83932") == 0) {
-            int checksum, i;
-            uint8_t *prom;
-
-            qemu_check_nic_model(nd, "dp83932");
-
-            dev = qdev_new("dp8393x");
-            qdev_set_nic_properties(dev, nd);
-            qdev_prop_set_uint8(dev, "it_shift", 2);
-            qdev_prop_set_bit(dev, "big_endian", target_words_bigendian());
-            object_property_set_link(OBJECT(dev), "dma_mr",
-                                     OBJECT(rc4030_dma_mr), &error_abort);
-            sysbus = SYS_BUS_DEVICE(dev);
-            sysbus_realize_and_unref(sysbus, &error_fatal);
-            sysbus_mmio_map(sysbus, 0, 0x80001000);
-            sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 4));
-
-            /* Add MAC address with valid checksum to PROM */
-            prom = memory_region_get_ram_ptr(dp8393x_prom);
-            checksum = 0;
-            for (i = 0; i < 6; i++) {
-                prom[i] = nd->macaddr.a[i];
-                checksum += prom[i];
-                if (checksum > 0xff) {
-                    checksum = (checksum + 1) & 0xff;
-                }
-            }
-            prom[7] = 0xff - checksum;
+            mips_jazz_init_net(nd, rc4030_dma_mr, rc4030, dp8393x_prom);
             break;
         } else if (is_help_option(nd->model)) {
             error_report("Supported NICs: dp83932");
-- 
2.39.3


