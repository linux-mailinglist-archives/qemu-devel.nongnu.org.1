Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D417516F2
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 05:54:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJnOF-0005TL-Em; Wed, 12 Jul 2023 23:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qJnO1-0005PL-V7
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 23:53:01 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qJnNs-0004cb-5X
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 23:53:01 -0400
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-1b8bd586086so2568415ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 20:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689220370; x=1691812370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1bAFpbzzKhqQoeU0XwQ75tlGjwI6Bw6ioIhwFteVyw=;
 b=Fkl+sdFF3f1CInAVvi5qIXtUE/YfMg2BF37YlmcbIz6mjhDmj5QnbpftKyukCJ+MvD
 6v48ES8D3Q4xos3hn/IAzyhrcHAiUxwzaxQ+Nwz5z4z327ilxJZc21y9C4OmqcG++70/
 TGC9U3Z0fpIeu3sbrCj23PmwUvC8+/pPVY8uaMQebadTpIvoPRrQkxwc8Lq6EACElLNK
 r7yvCP4WOUb8wtNGM7Cw0EY1d0OeO4fuKeqx88kv0LSV5QiJ1bgYEet89ocAvnTe04Zq
 jIVZ4Kl/yqJCTiP+u6V0w/sXhA86vkew6Iww2ghJE8WpGJXegvSg37f9n+0R63qLpD+M
 MeTg==
X-Gm-Message-State: ABy/qLbzCDbsFHxG2j96KLNkacMI7JTSILtk/jznYXKkgLG9R3CdLqk9
 VfVTh6MRSJ6iTx1pRJ01/PGV4j1OIAP7YQ==
X-Google-Smtp-Source: APBJJlG8IfbxkauJBCNP9BoP85mTxJkJgzQnNhikSOjmNhVgFD1FB7SxegUv28/ZBhFiMeRX/DRp+w==
X-Received: by 2002:a17:903:32c9:b0:1b8:9598:6508 with SMTP id
 i9-20020a17090332c900b001b895986508mr630088plr.18.1689220370597; 
 Wed, 12 Jul 2023 20:52:50 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:8b82:587c:b800:84d:31b7:313d])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a1709027c0600b001b8a37ffb5asm4756199pll.4.2023.07.12.20.52.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Jul 2023 20:52:50 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH 08/11] hw/loongarch/virt: add plug handler for TPM on SysBus
Date: Wed, 12 Jul 2023 20:51:13 -0700
Message-ID: <20230713035232.48406-9-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713035232.48406-1-j@getutm.app>
References: <20230713035232.48406-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.181; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f181.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

TPM needs to know its own base address in order to generate its DSDT
device entry.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 hw/loongarch/virt.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e19b042ce8..9c536c52bc 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1040,6 +1040,37 @@ static void virt_mem_plug(HotplugHandler *hotplug_dev,
                          dev, &error_abort);
 }
 
+#ifdef CONFIG_TPM
+static void virt_tpm_plug(LoongArchMachineState *lams, TPMIf *tpmif)
+{
+    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(lams->platform_bus_dev);
+    hwaddr pbus_base = VIRT_PLATFORM_BUS_BASEADDRESS;
+    SysBusDevice *sbdev = SYS_BUS_DEVICE(tpmif);
+    MemoryRegion *sbdev_mr;
+    hwaddr tpm_base;
+    uint64_t tpm_size;
+
+    if (!sbdev || !object_dynamic_cast(OBJECT(sbdev), TYPE_SYS_BUS_DEVICE)) {
+        return;
+    }
+
+    tpm_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    assert(tpm_base != -1);
+
+    tpm_base += pbus_base;
+
+    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
+    tpm_size = memory_region_size(sbdev_mr);
+
+    if (object_property_find(OBJECT(sbdev), "baseaddr")) {
+        object_property_set_uint(OBJECT(sbdev), "baseaddr", tpm_base, NULL);
+    }
+    if (object_property_find(OBJECT(sbdev), "size")) {
+        object_property_set_uint(OBJECT(sbdev), "size", tpm_size, NULL);
+    }
+}
+#endif
+
 static void loongarch_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
@@ -1054,6 +1085,12 @@ static void loongarch_machine_device_plug_cb(HotplugHandler *hotplug_dev,
     } else if (memhp_type_supported(dev)) {
         virt_mem_plug(hotplug_dev, dev, errp);
     }
+
+#ifdef CONFIG_TPM
+    if (object_dynamic_cast(OBJECT(dev), TYPE_TPM_IF)) {
+        virt_tpm_plug(lams, TPM_IF(dev));
+    }
+#endif
 }
 
 static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
-- 
2.39.2 (Apple Git-143)


