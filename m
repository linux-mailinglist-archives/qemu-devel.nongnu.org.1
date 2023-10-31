Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BEF7DC51A
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 05:02:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxfvz-0001Nt-UE; Tue, 31 Oct 2023 00:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfvn-0001LT-2g
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:00:46 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfvj-0005Fu-GQ
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:00:41 -0400
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-5b92b852390so3981077a12.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 21:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698724837; x=1699329637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7QEdUJS68W5mzt9ORxKLrBXJOs881kVxhlYUSB2HGuY=;
 b=QwYdSpNM14KStfY19neZj4AaDYkBiDItD5eH1oGLRnrpt3OLgKb2KiDLJilWd9Ai8C
 xMh9hVdetjfJyKa94AdT3vIXKGFPd83Syizy9QgusKW67ZMYQbnfwlzbX7lnJioeL86Z
 L8gOpFm8aONWk2eavM8N54OKTazsGHhUx69OMM7AEdrdF6enOHBcNvuDdp896Wr8sD9x
 yWpSy4tgBvPp6fHSZa0uXEdi1lvXCEqblY1PRlfFSwUkW2S82tbN1fltHd8PjT2X3LXT
 /8reO3GTYmiAAOLBmQkQmVkTGpVyZpJzFCxGhGP6JKFYOsWuBycz8Px7NOPUZ+5GgR5+
 gCuw==
X-Gm-Message-State: AOJu0YxoLVYFCDxasZTJD0dpLrpDFTr9qUtxQnfFrwTLgE7BHHIJDe9L
 fqKTwaX1QeuOI+f6i8j5Sfp7GaxF+XCxMw==
X-Google-Smtp-Source: AGHT+IFPlL0lcZ2aDDBj8UPtNmvZys8vqzJ1rOczLWBy5Okqgfmf5CwgVoYrUH8+C2DBXUK4UyVweQ==
X-Received: by 2002:a05:6a20:918d:b0:133:d17d:193a with SMTP id
 v13-20020a056a20918d00b00133d17d193amr14306530pzd.59.1698724837322; 
 Mon, 30 Oct 2023 21:00:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:7b37:49a8:6e6e:cee6:cee7])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a170902f54400b001bbfa86ca3bsm257975plf.78.2023.10.30.21.00.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 21:00:36 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>
Subject: [PATCH v4 08/14] hw/loongarch/virt: connect TPM to platform bus
Date: Mon, 30 Oct 2023 21:00:11 -0700
Message-ID: <20231031040021.65582-9-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031040021.65582-1-j@getutm.app>
References: <20231031040021.65582-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.180; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f180.google.com
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


