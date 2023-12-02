Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86405801B54
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:03:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9Kvm-0004K2-1I; Sat, 02 Dec 2023 03:00:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Kvb-0004IB-An
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:00:49 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KvZ-0004xC-Le
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:00:43 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-58d08497aa1so1954959eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504040; x=1702108840;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2S+QsDyqDyIlvvpRINrQ1P4xjH1/QaHDNGsQRs2XIL0=;
 b=FuT+3TshDdtjiqOmbcjuLrVdRjmS81QRqKfBI/Kdkfvfy9VpLnLXXdMhddWWeHC9a2
 JZ8bVzZUhbVcN89BuNFeU9DD9NUi1u5fjQ7luiFCSNZZfO1u4D9dcre1lI2jDnb2OxEz
 dmdUgrQ1FDPkQVu8lM7b9lAkE/yorvJO/JF6ImdfNkKohT3ql39Aw9pRwY8T8KuKBtEr
 ttnk1itKK09R3RZRJcA1BLW27wnvVvh4n7xQK5nS1w16P8QlCOz1n6X6Vmb6FtMl43wb
 DdKRe4j2v3jBcviZ6mJMkGkOH+oZJaGAJfBfW64WHmqlx6OUGzHAIbvSLodfONJ5GhWt
 bvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504040; x=1702108840;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2S+QsDyqDyIlvvpRINrQ1P4xjH1/QaHDNGsQRs2XIL0=;
 b=dHBPkwV99p3XeTp+yxWLppiqZovqgRSX0a0XvglT0ehkX7HNvJsPyiALD5NCioZVSC
 dJMEPvW19kCt0FZk3tx18Yc+GpBzoOJUxEdKrG/V2LM8Oo8AXVCuicmL0KTTDTs1Offp
 gtjSipV47v7uQbyCqLQkldaIArfsfpFfJIRB/hxZKKu68hTQzBu529AHcnfOlF8DHMfo
 pQdmhrCj2jtvcTnt5wEYAD6cWmFHn9AZwo0zSOHNenvzFm+KpklJ4MbASS6k+hdO9ZtW
 EbVLiP6ePFkmPC29kDmP3Xh7ognfCQnQRSYsbzogcc6f1pSqf5M0gvaT9iGpg28YS7xH
 h5Tw==
X-Gm-Message-State: AOJu0YxkIkyJO0ioQ0bmy4Q141c7iOYvTBrc0CX2YxMdRV4MXtxR/OHD
 e9zS5y2hD41l3KywldMpK7dYFg==
X-Google-Smtp-Source: AGHT+IHVQe5TIvceBmipGBNc1CxkcZYyB9SChYBRLbRmmLgxNpX5zFcYZ7sAQCH2mojhfNlk3ic8IQ==
X-Received: by 2002:a05:6358:896:b0:170:911:8b80 with SMTP id
 m22-20020a056358089600b0017009118b80mr982336rwj.28.1701504040152; 
 Sat, 02 Dec 2023 00:00:40 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 1-20020a17090a000100b0027722832498sm6730481pja.52.2023.12.02.00.00.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:00:39 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 02 Dec 2023 17:00:25 +0900
Subject: [PATCH 02/14] hw/qdev: Remove opts member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-sriov-v1-2-32b3570f7bd6@daynix.com>
References: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
In-Reply-To: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It is no longer used.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h |  2 +-
 include/hw/qdev-core.h      |  4 ----
 hw/core/qdev.c              |  1 -
 system/qdev-monitor.c       | 12 +++++++-----
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 5b6436992f..8e287c5414 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -205,7 +205,7 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
     return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
 }
 
-static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
+static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *d)
 {
     return d->rom_bar && d->rom_bar != -1;
 }
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 151d968238..6befbca311 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -237,10 +237,6 @@ struct DeviceState {
      * @pending_deleted_expires_ms: optional timeout for deletion events
      */
     int64_t pending_deleted_expires_ms;
-    /**
-     * @opts: QDict of options for the device
-     */
-    QDict *opts;
     /**
      * @hotplugged: was device added after PHASE_MACHINE_READY?
      */
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 43d863b0c5..c98691a90d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -706,7 +706,6 @@ static void device_finalize(Object *obj)
         dev->canonical_path = NULL;
     }
 
-    qobject_unref(dev->opts);
     g_free(dev->id);
 }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index a13db763e5..71c00f62ee 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -625,6 +625,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     char *id;
     DeviceState *dev = NULL;
     BusState *bus = NULL;
+    QDict *properties;
 
     driver = qdict_get_try_str(opts, "driver");
     if (!driver) {
@@ -705,13 +706,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     }
 
     /* set properties */
-    dev->opts = qdict_clone_shallow(opts);
-    qdict_del(dev->opts, "driver");
-    qdict_del(dev->opts, "bus");
-    qdict_del(dev->opts, "id");
+    properties = qdict_clone_shallow(opts);
+    qdict_del(properties, "driver");
+    qdict_del(properties, "bus");
+    qdict_del(properties, "id");
 
-    object_set_properties_from_keyval(&dev->parent_obj, dev->opts, from_json,
+    object_set_properties_from_keyval(&dev->parent_obj, properties, from_json,
                                       errp);
+    qobject_unref(properties);
     if (*errp) {
         goto err_del_dev;
     }

-- 
2.43.0


