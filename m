Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 426F87C6DE3
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 14:21:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqueu-0002mo-LI; Thu, 12 Oct 2023 08:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qques-0002kd-BN
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:19:18 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqueq-0001nb-Ma
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:19:18 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9b974955474so137746666b.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697113153; x=1697717953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fa15t5TAOGLEwbp/XmPMZ/3+NPt1m11OvXKqtHI65yw=;
 b=XnsZHgGNkyKCh07e/ewz9lrRPHD4E0mYFWZ+55zuQuS70PRDCJVOCpS9XGAOPWQ64w
 hyGH2wv4jsfP4imhfvfEReyipmghs6dJHoIQLByxOxQIaeDmwQDaplkJa51NI67FyvTX
 sSJODgqskAg35U4RoLE0OFbIum2JmOokY5q8Px31UbNFsf/0JyFQ5s7A/vPK1fpPfTHf
 ciQWPx8KArFAxiaS/215NhJpcGN16ilS8oxin6uwKeAH/HXH4Q63u/rGi/hf4AKhHf32
 HkuOUleSs4My/i6fNh7xcYt3+ZJ+JMR8l81QHuh+EA6r5hnmPULI78YTFSXUmuyCW1Il
 PD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697113153; x=1697717953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fa15t5TAOGLEwbp/XmPMZ/3+NPt1m11OvXKqtHI65yw=;
 b=C7gZdptBn/jxb9GhTqrh/tKNwEa+k+9B21cP2FA4XHWB/JWMYoV+zvFzC8VDRhOFe5
 /17FdKS6jQFeCNxv6MRCmOfzQMA51UXC97APMu1x0SZnwJzxh6cV1wZBEJxYUPjaVf2I
 AmWGMzs8TZM7eJj+H4YEMPXbZhN9HNK7MPCtaBfX6Is2fPHmIDrU4aXIZBeR1CECAg3U
 AnIiDooDPHODkBTmL91XSEfbhIvxXOlaFV4/wlV+YwECx31+7VI+ZwkPDNsEhlBCXXTV
 0uy+ge90VIllA3+NWXw0dVc2FpbtIX+4PgopzHK4U3LKxKDT7DOwiHymBi1UYvFjkqgV
 KM3Q==
X-Gm-Message-State: AOJu0YxzNqOr4T5S0pYWJme3xVl40Ka5jj/mpd8mhtt1u7+/gkwHopAw
 +q4S77zNs4LEZZx9F65KH8leJpSpqRtNKSA3cBUeAQ==
X-Google-Smtp-Source: AGHT+IGzO5jeOEKYZl/koR9ug4gcM8qKxGMepkMmqGrfurusJYqoUc1xpst5l4jJA6NUQusa/S92lA==
X-Received: by 2002:a17:907:6c14:b0:9ae:5c99:f2e2 with SMTP id
 rl20-20020a1709076c1400b009ae5c99f2e2mr18605504ejc.43.1697113153692; 
 Thu, 12 Oct 2023 05:19:13 -0700 (PDT)
Received: from m1x-phil.lan (176-131-211-232.abo.bbox.fr. [176.131.211.232])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a170906299400b00997c1d125fasm11157488eje.170.2023.10.12.05.19.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Oct 2023 05:19:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/8] hw/pci-host/designware: Initialize root function in host
 bridge realize
Date: Thu, 12 Oct 2023 14:18:50 +0200
Message-ID: <20231012121857.31873-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012121857.31873-1-philmd@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

There are no root function properties exposed by the host
bridge, so using a 2-step QOM creation isn't really useful.

Simplify by creating the root function when the host bridge
is realized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/designware.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 304eca1b5c..692e0731cd 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -707,6 +707,10 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
                        "pcie-bus-address-space");
     pci_setup_iommu(pci->bus, designware_pcie_host_set_iommu, s);
 
+    object_initialize_child(OBJECT(dev), "root", &s->root,
+                            TYPE_DESIGNWARE_PCIE_ROOT);
+    qdev_prop_set_int32(DEVICE(&s->root), "addr", PCI_DEVFN(0, 0));
+    qdev_prop_set_bit(DEVICE(&s->root), "multifunction", false);
     qdev_realize(DEVICE(&s->root), BUS(pci->bus), &error_fatal);
 }
 
@@ -736,22 +740,11 @@ static void designware_pcie_host_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_designware_pcie_host;
 }
 
-static void designware_pcie_host_init(Object *obj)
-{
-    DesignwarePCIEHost *s = DESIGNWARE_PCIE_HOST(obj);
-    DesignwarePCIERoot *root = &s->root;
-
-    object_initialize_child(obj, "root", root, TYPE_DESIGNWARE_PCIE_ROOT);
-    qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
-    qdev_prop_set_bit(DEVICE(root), "multifunction", false);
-}
-
 static const TypeInfo designware_pcie_types[] = {
     {
         .name           = TYPE_DESIGNWARE_PCIE_HOST,
         .parent         = TYPE_PCI_HOST_BRIDGE,
         .instance_size  = sizeof(DesignwarePCIEHost),
-        .instance_init  = designware_pcie_host_init,
         .class_init     = designware_pcie_host_class_init,
     }, {
         .name           = TYPE_DESIGNWARE_PCIE_ROOT,
-- 
2.41.0


