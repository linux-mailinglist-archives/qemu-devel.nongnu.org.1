Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D359737547
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:48:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhIy-0000TV-AR; Tue, 20 Jun 2023 15:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7V-0004FR-MU
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:22 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7S-0006bI-JY
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:21 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5700401acbeso54069177b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281971; x=1689873971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=re4sewoUiAJAV4/kgcnlDrxKrE2Fa0zI8YeYhG23N0Y=;
 b=DfdES6JEvCQWTQ1WFDll4cGS97nAixB6PRsd09O5iFOLxZco6PKhbfyAEFkZAWyakT
 gCJzPrYhpd7a1DMuixAnPGnTmdPOTVwMM5rMfcTE2WmPXGz7o5UvRBvEZ0GteR42PRC2
 lVCvO5GXFsYJItGC1Q2scC7ydoOZ9VTsDqbOD9BN/OuN69tnXeoy0DIkIAtRXjuaqzjN
 013Eyyc3Oa4qordF985hTPAqy6uANH1i3Y6hPcC3nXertqQVA1BtmbjxNxMz81vSwaRD
 mIGdmNWqNoB5viq56p08Y7WwZY97IlnzgnqgCVOHaYsed6TmrP6sl/ttsrXBy3RlJ9hZ
 116w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281971; x=1689873971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=re4sewoUiAJAV4/kgcnlDrxKrE2Fa0zI8YeYhG23N0Y=;
 b=i+QHz8gujZqkDTI7JUgOiTEwQ1s3/cIGh9mppuaMTb6BrnOezpTVCyG1zgrpS30NVb
 7tXwlPTKk4eQKTYWs/FDgAwE3EN2p0lW14gWcNcdvU0Cpg2q9vYjHKJM8rhmfWxyhgqn
 9WMjQGpIZLvG4/hdjF9y26owZOL463aYFg8m3e4Lh5HdaXagSvPYtExyKudIEUE1iWSP
 1hrbpqtiEFcRj6G8Nn0afVAFNhgGDfdaxKwryhmmvxHMtDZUYvrlYZ50VHWCwjo726F5
 lFK48DVgCzMUUGmDB1ISoBOzBWm9q0gfDuijbCVRMPeN94JUMnKhWqDEWz1a1LdLYakq
 Ss5g==
X-Gm-Message-State: AC+VfDxzMRzTjGvWkFTKDPwKodqUGmONSXDmRq2ioqegnDmCVXp5Y0dF
 5g47/jRXEg+B5JNwh6jcaZjz3ZrbJ7aUBw==
X-Google-Smtp-Source: ACHHUZ7xi/MCe/ilteffhPiFjo95RMXHLzj+R6XW+7HT26RsjzlIhW2AGxlvpmO2zHaQ7cawV/D/bg==
X-Received: by 2002:a81:c213:0:b0:56c:ea52:a9fc with SMTP id
 z19-20020a81c213000000b0056cea52a9fcmr13911538ywc.12.1687281971388; 
 Tue, 20 Jun 2023 10:26:11 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:26:10 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v1 08/23] xen/pt: determine the legacy/PCIe mode for a passed
 through device
Date: Tue, 20 Jun 2023 13:24:42 -0400
Message-Id: <c8948ca5513efd77d29c182dfdbaa35aa47f21a8.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=jupham125@gmail.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jun 2023 15:45:55 -0400
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

Even if we have some real PCIe device being passed through to a guest,
there are situations when we cannot use its PCIe features, primarily
allowing to access extended (>256) config space.

Basically, we can allow reading PCIe extended config space only if both
the device and emulated system are PCIe-capable. So it's a combination
of checks:
- PCI Express capability presence
- pci_is_express(device)
- pci_bus_is_express(device bus)

The AND-product of these checks is stored to pcie_enabled_dev flag
in XenPCIPassthroughState for later use in functions like
xen_pt_pci_config_access_check.

This way we get consistent behavior when the same PCIe device being passed
through to either i440 domain or Q35 one.

Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 hw/xen/xen_pt.c | 28 ++++++++++++++++++++++++++--
 hw/xen/xen_pt.h |  1 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index a540149639..65c5516ef4 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -701,6 +701,21 @@ static const MemoryListener xen_pt_io_listener = {
     .priority = 10,
 };
 
+static inline bool xen_pt_dev_is_pcie_mode(PCIDevice *d)
+{
+    XenPCIPassthroughState *s = XEN_PT_DEVICE(d);
+    PCIBus *bus = pci_get_bus(d);
+
+    if (bus != NULL) {
+        if (pci_is_express(d) && pci_bus_is_express(bus) &&
+            xen_host_pci_find_next_cap(&s->real_device, 0, PCI_CAP_ID_EXP)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 /* destroy. */
 static void xen_pt_destroy(PCIDevice *d) {
 
@@ -787,8 +802,17 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
                    s->real_device.dev, s->real_device.func);
     }
 
-    /* Initialize virtualized PCI configuration (Extended 256 Bytes) */
-    memset(d->config, 0, PCI_CONFIG_SPACE_SIZE);
+    s->pcie_enabled_dev = xen_pt_dev_is_pcie_mode(d);
+    if (s->pcie_enabled_dev) {
+        XEN_PT_LOG(d, "Host device %04x:%02x:%02x.%d passed thru "
+                   "in PCIe mode\n", s->real_device.domain,
+                    s->real_device.bus, s->real_device.dev,
+                    s->real_device.func);
+    }
+
+    /* Initialize virtualized PCI configuration space (256/4K bytes) */
+    memset(d->config, 0, pci_is_express(d) ? PCIE_CONFIG_SPACE_SIZE
+                                           : PCI_CONFIG_SPACE_SIZE);
 
     s->memory_listener = xen_pt_memory_listener;
     s->io_listener = xen_pt_io_listener;
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index b20744f7c7..1c9cd6b615 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -234,6 +234,7 @@ struct XenPCIPassthroughState {
 
     PCIHostDeviceAddress hostaddr;
     bool is_virtfn;
+    bool pcie_enabled_dev;
     bool permissive;
     bool permissive_warned;
     XenHostPCIDevice real_device;
-- 
2.34.1


