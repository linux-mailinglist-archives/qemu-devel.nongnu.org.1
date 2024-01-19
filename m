Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4CE832D48
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:36:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQrpw-0000lW-GK; Fri, 19 Jan 2024 11:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrpu-0000kd-U3
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:35:18 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrps-0004lq-N3
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:35:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e76626170so10240725e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 08:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705682115; x=1706286915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fK9dmAwnACqE12D5kcXMqNrcgKcFC5XpZxT2a1RWnEY=;
 b=mcawH57T7wasvrC5jMvcLjSqtP6YElv/xntYCGznysOzaovoESBbIHMX6tKkkj9lAR
 0LDEee8EI1k+qmo6cB/CcBgmLbMAof95XyUPkAo1/j/Y9Kxvafb1PtphyTw5irwF4+YS
 mpTTOZ1dEAgv4Do/GJHebnIX56WghWgiqqazeusBQmv10ZNoGL0IvOdTR3px8kX01QWl
 m3meebqpFHV4J6uPLiyCtaR51RY96eXUqXE7dkUbzdudP1shzNFI0akyiE9IEhh19TAT
 IstpcSCD3q+Vaf4zdP4Mqs9sSI1H278hZzhW1MO4qtVGz4r+sK6tgCppVL2kUeoWK0cS
 FZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705682115; x=1706286915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fK9dmAwnACqE12D5kcXMqNrcgKcFC5XpZxT2a1RWnEY=;
 b=N0DA9kXmz6QKQnki/W5Q7JSBs6DR/nGC+7GaPmOQ5TFFetIzvyzntmEI+s4a/NLeyK
 bd3LnUUZK+Kppc3iq1ayr2qgNehLAG3R0DYAW/sl9XfsnuJYanttrdE5rXWKYZT+NwxV
 nrtqU1a0Kdn7ic5OW4DGEYP1PIX2+t9oWlQSFiwjDvtB0K+ZWeWrUkh17LT4Cn8Z+5oO
 4palND68hKMLFPk0va2TOHuhJ4i8X3AhY6doKyNZoe9aKx5vr3DQ62qmZ+MldJa8FhD0
 q5memufbGcCftgxA/xoreC5Z6NNCJ1FweHHdhALAvuu3YFIXC32NwgMD8fdMsHLNyfGP
 7eEw==
X-Gm-Message-State: AOJu0Yw8kGEOsKMDon5WgSl7axVKVtk8ps4cwO94xWK36sPQzZt1YksU
 ZLHldKwZ4ZBPgrPU8CBNp2ySE8RSM/AcEFzItEflFQ581YYq9CYjXz/sgoMAlojZiQxf2eclp9J
 M
X-Google-Smtp-Source: AGHT+IGrRRHdaIIPlHVAKKIdsh71yyrK1uNlbyeMeJf+oi349grv87hV1SvD5XBsTEMpV6SXKPx2Wg==
X-Received: by 2002:a05:600c:6a82:b0:40e:68a6:7bdb with SMTP id
 jl2-20020a05600c6a8200b0040e68a67bdbmr18703wmb.62.1705682114742; 
 Fri, 19 Jan 2024 08:35:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fc11-20020a05600c524b00b0040e86fbd772sm10979260wmb.38.2024.01.19.08.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:35:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] pci: Switch bus reset to 3-phase-reset
Date: Fri, 19 Jan 2024 16:35:08 +0000
Message-Id: <20240119163512.3810301-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119163512.3810301-1-peter.maydell@linaro.org>
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Switch the PCI bus from using BusClass::reset to the Resettable
interface.

This has no behavioural change, because the BusClass code to support
subclasses that use the legacy BusClass::reset will call that method
in the hold phase of 3-phase reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 76080af580d..05c2e46bda5 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -64,7 +64,7 @@ bool pci_available = true;
 
 static char *pcibus_get_dev_path(DeviceState *dev);
 static char *pcibus_get_fw_dev_path(DeviceState *dev);
-static void pcibus_reset(BusState *qbus);
+static void pcibus_reset_hold(Object *obj);
 static bool pcie_has_upstream_port(PCIDevice *dev);
 
 static Property pci_props[] = {
@@ -202,13 +202,15 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
     PCIBusClass *pbc = PCI_BUS_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     k->print_dev = pcibus_dev_print;
     k->get_dev_path = pcibus_get_dev_path;
     k->get_fw_dev_path = pcibus_get_fw_dev_path;
     k->realize = pci_bus_realize;
     k->unrealize = pci_bus_unrealize;
-    k->reset = pcibus_reset;
+
+    rc->phases.hold = pcibus_reset_hold;
 
     pbc->bus_num = pcibus_num;
     pbc->numa_node = pcibus_numa_node;
@@ -424,9 +426,9 @@ void pci_device_reset(PCIDevice *dev)
  * Called via bus_cold_reset on RST# assert, after the devices
  * have been reset device_cold_reset-ed already.
  */
-static void pcibus_reset(BusState *qbus)
+static void pcibus_reset_hold(Object *obj)
 {
-    PCIBus *bus = DO_UPCAST(PCIBus, qbus, qbus);
+    PCIBus *bus = PCI_BUS(obj);
     int i;
 
     for (i = 0; i < ARRAY_SIZE(bus->devices); ++i) {
-- 
2.34.1


