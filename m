Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADCD7EA896
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 03:11:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2isF-0001O7-JP; Mon, 13 Nov 2023 21:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2isD-0001NL-Fx
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:09:53 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2is8-0007b5-QZ
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:09:53 -0500
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2800f7c8125so4722111a91.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 18:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699927787; x=1700532587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7QEdUJS68W5mzt9ORxKLrBXJOs881kVxhlYUSB2HGuY=;
 b=udeWgC8a86w6o3ZJFgdESGXrpU5h00G5fNiDoRgGdCZyzD9BSQNcD8Izoq60XuEQFR
 3KqpMsktOEp+aQNis6PF1UCAhVHQ8kCSJALmfOyRw0fLQwJ3np44QVzjLsJ88u19cHd6
 Fqb5LYd+WUdt9VU+hj1QQRDL8tyNVZD033mkgtqFeRUSWJaTNjSfbCszW5lervFzc7dQ
 SeqCAd6fTtTrqhxYL0QtLajsX1GUccTXOcDFS1i08AUnRv9FKhLY/Dd7XlXaIhQ5itMg
 Ub2DiXEzXkA7N3ALNZLMAh2slSfh1rJ+QC1kcn4qGyfucWpY8e4V4XIrqx1P3sQi0D9s
 yRIg==
X-Gm-Message-State: AOJu0YxrhQ8/Ql8x3yfQiCjljJAsH9unvuD8oUMEKP1aGCGNxXcsh6CP
 +nc8L9aDEFVk6WKGZpTVOS+l/vSM0YgufQ==
X-Google-Smtp-Source: AGHT+IHS9p2OTvHSwXPNuconknEWB68F/vMI0Q/NASN2Elph/BwpKCBzajSi+wtw8GPiQ1jCgc/00Q==
X-Received: by 2002:a17:90a:9282:b0:280:74e7:9284 with SMTP id
 n2-20020a17090a928200b0028074e79284mr1894675pjo.21.1699927787091; 
 Mon, 13 Nov 2023 18:09:47 -0800 (PST)
Received: from localhost.localdomain ([2601:642:4c01:2f7:5d09:c219:9099:a639])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a17090ae58d00b0027d12b1e29dsm6175362pjz.25.2023.11.13.18.09.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 18:09:46 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>
Subject: [PATCH v5 08/14] hw/loongarch/virt: connect TPM to platform bus
Date: Mon, 13 Nov 2023 18:09:18 -0800
Message-ID: <20231114020927.62315-9-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114020927.62315-1-j@getutm.app>
References: <20231114020927.62315-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.216.43; envelope-from=osy86dev@gmail.com;
 helo=mail-pj1-f43.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
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


