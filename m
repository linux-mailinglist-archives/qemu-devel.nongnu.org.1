Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2884880B8C6
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 05:07:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCB5O-0005QM-Q8; Sat, 09 Dec 2023 23:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5M-0005Ou-Cd
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:32 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5B-0005A4-VQ
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:32 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2868605fa4aso2650749a91.0
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 20:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702181180; x=1702785980;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EM9mvrJq/PU8srsKjIP6L4SlttkLYnMfy8koMIgaFUE=;
 b=jOYfvqJ6xKuNj1SKQgsGnSHyWHpIT75Tik5LoHcAB/xJCm+Lg5reb35Nf3S+aKi1Vz
 h7rP9K9oUORwRQPz0E83gRkOYbrSY3f6qRZWAy8czwoRFrnRCAv2iU7qJAeG9LU2My/y
 EIioLdQqpA+ngzMe0L0gB/FPGSgPZG5gg4ZaO8FJwN8hidOLYEum9/SKTrjUsXiHZ7rE
 v/eTkt1Sb8P+rDDBgaDYEpI99GEfizQ0MM8143/CE3lORIzpjG3JKzOafmQdcCoWEKDi
 E3wZukarWpH1vwh/FhpSqXZLrylAc8aiLXELuJSNLbX/yVusf/kjQjXvyy8IHF8hY2TM
 edAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702181180; x=1702785980;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EM9mvrJq/PU8srsKjIP6L4SlttkLYnMfy8koMIgaFUE=;
 b=ISW01C2/sbn0KbyNCXt1Rkd7AKwZD1sMVIj9n/2u0Zc1Rq3PhoTZDck7487OAaMqtF
 qnXiuL2FpePQIGL/G3G9vPXLZK81cmWqVU+XTWyYgvzoWxcK1hzrLMFAwBYtgM94/JQS
 EeuI6rGHPcKnc9Fq/3sPZCRl9imV1XnEA1ul9k0bQEIrIOQ6t1dQluxmgculzkRtd5S4
 kMLEaHDHSvflL0Rg1NaYcTruBEFgwV8um8/6puj4cgdNoPnVTtCEHojE5X096bPpI9Sg
 qI/iv61LY5gbT68qugU4+T8NpC/9y/fM/90xx4cKqH4ar+Wd8P2hDUtaX551f2Jkj7Q6
 eVTQ==
X-Gm-Message-State: AOJu0YwSrfqbK/UgfGsC+/1JSkhRxMNwDC5ep06vWJPd2Ye1JJ2FDZWH
 BOPW/qpeZ7fVFfDwXLNTIV3WpQ==
X-Google-Smtp-Source: AGHT+IFm01sLCi2poG+RKFc3rKzchA4GnDow7bnjR845uEXXmQnj9aM+EP1AXo1BSiWzlOtYu/smfw==
X-Received: by 2002:a05:6a00:4b0c:b0:6ce:2731:79f7 with SMTP id
 kq12-20020a056a004b0c00b006ce273179f7mr945282pfb.45.1702181180522; 
 Sat, 09 Dec 2023 20:06:20 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 z21-20020a656115000000b0059d219cb359sm3446680pgu.9.2023.12.09.20.06.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 20:06:20 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 13:05:45 +0900
Subject: [PATCH RFC v2 02/12] hw/pci: Determine if rombar is explicitly enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-sriov-v2-2-b959e8a6dfaf@daynix.com>
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
In-Reply-To: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
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

vfio determines if rombar is explicitly enabled by inspecting QDict.
Inspecting QDict is not nice because QDict is untyped and depends on the
details on the external interface. Add an infrastructure to determine if
rombar is explicitly enabled to hw/pci. PCIDevice::rom_bar is changed to
have -1 by the default to tell rombar is explicitly enabled. It is
consistent with other properties like addr and romsize.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h | 5 +++++
 hw/pci/pci.c                | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d3dd0f64b2..54fa0676ab 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -205,6 +205,11 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
     return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
 }
 
+static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
+{
+    return dev->rom_bar && dev->rom_bar != -1;
+}
+
 uint16_t pci_requester_id(PCIDevice *dev);
 
 /* DMA access functions */
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4cf31128ba..31e8f413a6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -71,7 +71,7 @@ static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, -1),
-    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
+    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, -1),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,

-- 
2.43.0


