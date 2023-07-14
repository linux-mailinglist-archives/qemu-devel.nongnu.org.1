Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEE175329B
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 09:11:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCwH-0006Oo-6t; Fri, 14 Jul 2023 03:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKCwF-0006O8-4g
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:10:03 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKCwC-0005A7-Rv
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:10:02 -0400
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-1b8ad356f03so9043765ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 00:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689318599; x=1691910599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1bAFpbzzKhqQoeU0XwQ75tlGjwI6Bw6ioIhwFteVyw=;
 b=jxm/RQQ5rwCevvgMZi5IhxqYu0cNToA6Lek/RKJnVZtd5/mZ2GbmQlnMh75QvaA4Fd
 bJm/7HvhShhqZ9IPsFrEga9IC4VexBeGLs9n6sh6fgKdBk2lN7ZpI+Lu0XZmdA10yITi
 1g+6mPNeppuSUNhy32s5lCA2dSZNqrGGag1OtEHH+3A9SRxvSC7yh8m13jRyClym6Nn8
 lSlUtLaT2jpXl/rw/uPp+kBa4N+F7lFshKtVDjxKScdpYeZzbYcehuKwjec3ZbrlPJtA
 /YMZumNildoTaN32dBhr23qBCvuOkIxV3/vIUhfmnlPTGnb7cF1ECy+KaZoYsgBYFnan
 QiTg==
X-Gm-Message-State: ABy/qLa68ulEsh81S5HUsOlbuZTe17spaYimw47yJL30PHVT4MQ14bVT
 xlq0NIxpRoKOv0qifH+ezBavDWKEe/HCTg==
X-Google-Smtp-Source: APBJJlGlVtKHdxz//Pg6CnwPVp8OPLt2EF3or5uKnC/8CqvD7JWN4JeFLiPWEuQ7DOhHfjhi6RIkKg==
X-Received: by 2002:a17:902:f809:b0:1b7:db37:fada with SMTP id
 ix9-20020a170902f80900b001b7db37fadamr2523476plb.58.1689318599545; 
 Fri, 14 Jul 2023 00:09:59 -0700 (PDT)
Received: from localhost.localdomain
 ([2607:fb90:dd17:8dad:e558:8948:1ff6:c8c1])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a170902b20800b001b89466a5f4sm7041513plr.105.2023.07.14.00.09.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Jul 2023 00:09:59 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v2 08/11] hw/loongarch/virt: add plug handler for TPM on SysBus
Date: Fri, 14 Jul 2023 00:09:24 -0700
Message-ID: <20230714070931.23476-9-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714070931.23476-1-j@getutm.app>
References: <20230714070931.23476-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.180; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f180.google.com
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


