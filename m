Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECAF946DBD
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Aug 2024 11:02:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saX7k-0000N3-P8; Sun, 04 Aug 2024 05:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX7i-0000Dm-5K
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:01:54 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX7g-00019V-3a
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:01:53 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso7105454a12.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722762110; x=1723366910;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8641KY8iAUQPaIzKnmIv+VtshKd/QMdL5rBm/qrvkYc=;
 b=2aTvzBhp/kEYlFA6ieDkilyery97tjX0HXPmr4kgK5r+Bke1TtMvqdjvhvq4gryFUL
 82zLSO9hYMBVF6yKPudYVYTd/qmfrTY+ixIgjRSAkhDLlVSCVwpfarRflEfBFQxUhLci
 uC/iFvHJe6VNKlcWmwSBIzbKzxPP0vmAVh/zyxCqQz8ALOHBBEDQxVNHKrvut73i8BOU
 k21vKgBTfYd/a9stqxshK0rHPbgOr1HT/QnrjRy94HJ4oTyPGHFIVGI9Z9YYU3yPIB1+
 NRgJXlWM17KWggZfIXCWD35aQIYZIYdQFSJDo7IYCmvNHk4zlEnSg5dmeO3lzHlPmB6x
 c8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722762110; x=1723366910;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8641KY8iAUQPaIzKnmIv+VtshKd/QMdL5rBm/qrvkYc=;
 b=l7g0Bxg0t16hT9pcxycgjzJ3zGLGP3RgHmuGA/sU4tiLCwafuCC4Dec/lETxu8RFuo
 qRgpDcUNSZoUb5aA4STbKPGoPOr6OnDjffVG61ycDD7i+/1USJKoTeVnri8liaZUDdGd
 iIOh6kySvopvRorQN4ig3ABHcinygSMq7XXFE4pJSTQwE5+cHHt6cehJRX3hHSrBhv9s
 bqb9DDbDq0iqEV0RddM1GgEVS7XqJDvZSqOy8mWFMsGw7Q8eeGnJ9jJh7LzI0m0YGPzH
 FWGwVjvCa8zE1g6TGxxzaOwb2rDa2x8+aeTYFgL7MNeiNQsjgcp8HnnQ5DoCfZ5L4qlW
 dc7g==
X-Gm-Message-State: AOJu0YxXV9raaDfWBuuEx3VOy4v6e+qRpm2KxwuEGI5Py1gHxBfpu1Tg
 RRebzK1c+w9XUpxUp3Y+BoBAuIdbRnQT4NWQw5WESo1nqPKQPolThLIjE9aDKjA=
X-Google-Smtp-Source: AGHT+IEEwt3bDdJgEiYtPuJgOrGZhPEbxGJowbx3IMdFl7ySpsx4lw1pM/BJKHDP8F+Gpv4d1K3XdQ==
X-Received: by 2002:a17:90a:51e6:b0:2cf:eaec:d756 with SMTP id
 98e67ed59e1d1-2cff94477f3mr10418660a91.12.1722762110589; 
 Sun, 04 Aug 2024 02:01:50 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2cffac2d378sm4673526a91.0.2024.08.04.02.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 02:01:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 04 Aug 2024 18:01:37 +0900
Subject: [PATCH for-9.2 v12 01/11] hw/pci: Rename has_power to enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240804-reuse-v12-1-d3930c4111b2@daynix.com>
References: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
In-Reply-To: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

The renamed state will not only represent powering state of PFs, but
also represent SR-IOV VF enablement in the future.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci.h        |  7 ++++++-
 include/hw/pci/pci_device.h |  2 +-
 hw/pci/pci.c                | 14 +++++++-------
 hw/pci/pci_host.c           |  4 ++--
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index eb26cac81098..fe04b4fafd04 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -678,6 +678,11 @@ static inline void pci_irq_pulse(PCIDevice *pci_dev)
 }
 
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
-void pci_set_power(PCIDevice *pci_dev, bool state);
+void pci_set_enabled(PCIDevice *pci_dev, bool state);
+
+static inline void pci_set_power(PCIDevice *pci_dev, bool state)
+{
+    pci_set_enabled(pci_dev, state);
+}
 
 #endif
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 15694f248948..f38fb3111954 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -57,7 +57,7 @@ typedef struct PCIReqIDCache PCIReqIDCache;
 struct PCIDevice {
     DeviceState qdev;
     bool partially_hotplugged;
-    bool has_power;
+    bool enabled;
 
     /* PCI config space */
     uint8_t *config;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fab86d056721..b532888e8f6c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1525,7 +1525,7 @@ static void pci_update_mappings(PCIDevice *d)
             continue;
 
         new_addr = pci_bar_address(d, i, r->type, r->size);
-        if (!d->has_power) {
+        if (!d->enabled) {
             new_addr = PCI_BAR_UNMAPPED;
         }
 
@@ -1613,7 +1613,7 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
         pci_update_irq_disabled(d, was_irq_disabled);
         memory_region_set_enabled(&d->bus_master_enable_region,
                                   (pci_get_word(d->config + PCI_COMMAND)
-                                   & PCI_COMMAND_MASTER) && d->has_power);
+                                   & PCI_COMMAND_MASTER) && d->enabled);
     }
 
     msi_write_config(d, addr, val_in, l);
@@ -2884,18 +2884,18 @@ MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
     return msg;
 }
 
-void pci_set_power(PCIDevice *d, bool state)
+void pci_set_enabled(PCIDevice *d, bool state)
 {
-    if (d->has_power == state) {
+    if (d->enabled == state) {
         return;
     }
 
-    d->has_power = state;
+    d->enabled = state;
     pci_update_mappings(d);
     memory_region_set_enabled(&d->bus_master_enable_region,
                               (pci_get_word(d->config + PCI_COMMAND)
-                               & PCI_COMMAND_MASTER) && d->has_power);
-    if (!d->has_power) {
+                               & PCI_COMMAND_MASTER) && d->enabled);
+    if (!d->enabled) {
         pci_device_reset(d);
     }
 }
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index dfe6fe618401..0d82727cc9dd 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -86,7 +86,7 @@ void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
+        !pci_dev->enabled || is_pci_dev_ejected(pci_dev)) {
         return;
     }
 
@@ -111,7 +111,7 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
+        !pci_dev->enabled || is_pci_dev_ejected(pci_dev)) {
         return ~0x0;
     }
 

-- 
2.45.2


