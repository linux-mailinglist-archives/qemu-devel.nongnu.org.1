Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD4975392A
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:01:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKGX1-0006wH-BX; Fri, 14 Jul 2023 07:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qKGWu-0006vi-Cb
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qKGWq-0005H7-D9
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689332402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjHq5pV5Ng8uzkPYy0p5CUtaFNNkTOHcIqNt3429rqY=;
 b=gM++wNo46LWT4O6ZH5CrffGIlKa8YtxD0bQSTSg69Owsr0MvevEye8qvb6lPkVDCKdinyB
 7/GQiG+gUOUHTmd4KwJwpNN/oPIZGxsJ88CsRMZMe16eMXvZE/4mksvuTW+9Oxft8AtcdI
 oFwRiw/smoVll8OjxWvwRUkSWlyL9do=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-sCKZCJT3PRq41TOxSvpXig-1; Fri, 14 Jul 2023 07:00:01 -0400
X-MC-Unique: sCKZCJT3PRq41TOxSvpXig-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so9875375e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 04:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689332399; x=1691924399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gjHq5pV5Ng8uzkPYy0p5CUtaFNNkTOHcIqNt3429rqY=;
 b=f0bN6qf0juiaH/j8w+/3KYCASAgOvUhGOwi4yP/IMm7fY5SM+IgjtYwi0smyruEuC+
 eCiH39Sq6CKJUVOMM40eNevTptjBYqQGJH/QdGDMR4Ey3Me+vHd500OY9c7L8yWZS/Ht
 358iTMKz1/KNYxOqORiRarKScra9rQtlNP6JA8CApN9fL0c902pEMXGdSJpsflgopis/
 aP/cS/4zw4FtqySe2oA9iGdAzS1EHrFxV7ZaC+px7uJZ0z52B/BqykGRCd82zwKDEJqU
 KVxw2TApK2MIajl6oQgwc8kAMcCpeoVfFKBHncS+44+9MIfowJAkHkQcZrcwvXSiEx1B
 za6w==
X-Gm-Message-State: ABy/qLYKLnodzwiZKsd6puEkeNEC23uaI2TEQAYGKoxem1y4HPCyCOZB
 xFmlRphTSO6BddEFmkPf2mtPe3F7ETS5gPIpXV2LCKpEAO7/UP8o4e00t1HVbJUnPgmYoXMye1D
 6I0W2xC1jqyzzar28nvUpJU+wFQxY0oSYdCKIesPCCD0EIc+EasAn41l/eOOgqCdGo1cYDOyGK8
 c=
X-Received: by 2002:a05:600c:2254:b0:3fa:984d:7e9f with SMTP id
 a20-20020a05600c225400b003fa984d7e9fmr3589895wmm.6.1689332399262; 
 Fri, 14 Jul 2023 03:59:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGlZzZ2mqeqQmUYb0Hki51VmOV0qHbdm/hoT6mO6M85AXbAqjUkBQ6TpJSQ9Suk0xrgWGdIcg==
X-Received: by 2002:a05:600c:2254:b0:3fa:984d:7e9f with SMTP id
 a20-20020a05600c225400b003fa984d7e9fmr3589875wmm.6.1689332398842; 
 Fri, 14 Jul 2023 03:59:58 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a1cf709000000b003fc00892c13sm1151415wmh.35.2023.07.14.03.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 03:59:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 2/5] kconfig: Add PCIe devices to s390x machines
Date: Fri, 14 Jul 2023 12:59:50 +0200
Message-ID: <20230714105953.223485-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714105953.223485-1-pbonzini@redhat.com>
References: <20230714105953.223485-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

It is useful to extend the number of available PCIe devices to KVM guests
for passthrough scenarios and also to expose these models to a different
(big endian) architecture. Introduce a new config PCIE_DEVICES to select
models, Intel Ethernet adapters and one USB controller. These devices all
support MSI-X which is a requirement on s390x as legacy INTx are not
supported.

Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20230712080146.839113-1-clg@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/s390x-softmmu/default.mak | 1 +
 hw/net/Kconfig                            | 4 ++--
 hw/pci/Kconfig                            | 3 +++
 hw/s390x/Kconfig                          | 3 ++-
 hw/usb/Kconfig                            | 2 +-
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/configs/devices/s390x-softmmu/default.mak b/configs/devices/s390x-softmmu/default.mak
index f2287a133f3..6d87bc8b4b0 100644
--- a/configs/devices/s390x-softmmu/default.mak
+++ b/configs/devices/s390x-softmmu/default.mak
@@ -7,6 +7,7 @@
 #CONFIG_VFIO_CCW=n
 #CONFIG_VIRTIO_PCI=n
 #CONFIG_WDT_DIAG288=n
+#CONFIG_PCIE_DEVICES=n
 
 # Boards:
 #
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 98e00be4f93..7fcc0d7faa2 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -41,12 +41,12 @@ config E1000_PCI
 
 config E1000E_PCI_EXPRESS
     bool
-    default y if PCI_DEVICES
+    default y if PCI_DEVICES || PCIE_DEVICES
     depends on PCI_EXPRESS && MSI_NONBROKEN
 
 config IGB_PCI_EXPRESS
     bool
-    default y if PCI_DEVICES
+    default y if PCI_DEVICES || PCIE_DEVICES
     depends on PCI_EXPRESS && MSI_NONBROKEN
 
 config RTL8139_PCI
diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
index 77f8b005ffb..fe70902cd82 100644
--- a/hw/pci/Kconfig
+++ b/hw/pci/Kconfig
@@ -8,6 +8,9 @@ config PCI_EXPRESS
 config PCI_DEVICES
     bool
 
+config PCIE_DEVICES
+    bool
+
 config MSI_NONBROKEN
     # selected by interrupt controllers that do not support MSI,
     # or support it and have a good implementation. See commit
diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
index 5e7d8a2bae8..e8d4d68ece0 100644
--- a/hw/s390x/Kconfig
+++ b/hw/s390x/Kconfig
@@ -5,7 +5,8 @@ config S390_CCW_VIRTIO
     imply VFIO_AP
     imply VFIO_CCW
     imply WDT_DIAG288
-    select PCI
+    imply PCIE_DEVICES
+    select PCI_EXPRESS
     select S390_FLIC
     select SCLPCONSOLE
     select VIRTIO_CCW
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 0ec6def4b8b..0f486764ed6 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -36,7 +36,7 @@ config USB_XHCI
 
 config USB_XHCI_PCI
     bool
-    default y if PCI_DEVICES
+    default y if PCI_DEVICES || PCIE_DEVICES
     depends on PCI
     select USB_XHCI
 
-- 
2.41.0


