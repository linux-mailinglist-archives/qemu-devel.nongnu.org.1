Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C50CA7DAAFE
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 07:05:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwyuU-0002GB-1A; Sun, 29 Oct 2023 02:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyuS-0002FX-8U
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:28 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyuP-0001pP-Qt
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:28 -0400
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-577e62e2adfso2353324a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 23:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698559464; x=1699164264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RsCUo6FYIwj5uKTqrDxQQU+6CCkuwUVskMEosAm0UDs=;
 b=X8HBTKhWg9kPTE1XyMLJkmfdC1hSy7RAYGOxvVoiXktNGxx6lqZMe+AXxhR78z0FRn
 mDMblPs95oJ3AExlyMYmlJve/HqJQE+G7Y76wi5CkBNmtN5KFFCQJkCgRadiRuRKqUUd
 u7C9NEusGgGwk/EVcZr+hrCERq4IaC2s/w3R7K8zI3oF86oEWWHld4essS2+WEGl/OAh
 cvgOmFAcEie0PvjVBptRpPLntHR5oSSA53R5qc5fLnww5r0NfCNGuwUxwi28UGbHFtuN
 07Z2COInBrbKuamU1rnhTFGBuQqQrpBhXS7usah/m4rvhEIHoLxqUaKAQDaGdHuRABE0
 hrWQ==
X-Gm-Message-State: AOJu0YyBGgmNvi/0ZVDDbW2M0xnkqwx0SNwUkZS8UA+KnHhAyiT8YygO
 Ah9kn4pNjya4dvRY34yCWOzz+3NABYnXvw==
X-Google-Smtp-Source: AGHT+IEPXqORc+ppyLIp/O7NVkhtgvDn6nmOHo0kclH5E/sRoCzXq6ArWuDsgubME5UhKVLc/5lntw==
X-Received: by 2002:a05:6a21:3395:b0:17a:cfce:5a30 with SMTP id
 yy21-20020a056a21339500b0017acfce5a30mr6475433pzb.16.1698559464321; 
 Sat, 28 Oct 2023 23:04:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:6ead:344e:2b1:f5a5:58c6])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a17090341cc00b001b8943b37a5sm4019518ple.24.2023.10.28.23.04.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Oct 2023 23:04:23 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Paolo Bonzini <pbonzini@redhat.com>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 08/14] hw/loongarch/virt: connect TPM to platform bus
Date: Sat, 28 Oct 2023 23:03:21 -0700
Message-ID: <20231029060404.71196-9-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231029060404.71196-1-j@getutm.app>
References: <20231029060404.71196-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.179; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f179.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 hw/loongarch/virt.c  | 7 +++++++
 hw/loongarch/Kconfig | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 4b7dc67a2d..feed0f8bbf 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1004,6 +1004,13 @@ static void loongarch_machine_device_plug_cb(HotplugHandler *hotplug_dev,
     } else if (memhp_type_supported(dev)) {
         virt_mem_plug(hotplug_dev, dev, errp);
     }
+
+#ifdef CONFIG_TPM
+    if (object_dynamic_cast(OBJECT(dev), TYPE_TPM_IF)) {
+        tpm_sysbus_plug(TPM_IF(dev), OBJECT(lams->platform_bus_dev),
+                        VIRT_PLATFORM_BUS_BASEADDRESS);
+    }
+#endif
 }
 
 static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 5727efed6d..25da190ffc 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -5,6 +5,7 @@ config LOONGARCH_VIRT
     imply VIRTIO_VGA
     imply PCI_DEVICES
     imply NVDIMM
+    imply TPM_TIS_SYSBUS
     select SERIAL
     select VIRTIO_PCI
     select PLATFORM_BUS
-- 
2.41.0


