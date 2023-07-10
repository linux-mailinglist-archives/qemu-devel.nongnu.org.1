Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9306374E1D2
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:06:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuo-00053R-I2; Mon, 10 Jul 2023 19:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzum-00052e-42
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuk-0004Fp-NF
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3AeU+luiCA/Y1UCFMNDdCAt3vJKdjvI6VF3GLVTy8g=;
 b=Wd+Chmwg7rG4SIja9EkAHIXWtimji9pB6EPb5esv/8x/5EmHNKm6sm43lzaA/DlCiv2j0e
 eCaaoyxh5kAtlqpQdTYsCljI6dzR6QCQ3dzt3jNO+ArOLFnAhRaMBbp23NJk6Eu01isBjR
 nAyZknH4qCvfI/NFvLDnuq1aoo25914=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-qeOKJFXjP7ey81czSoM3CA-1; Mon, 10 Jul 2023 19:03:28 -0400
X-MC-Unique: qeOKJFXjP7ey81czSoM3CA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbdde92299so29497815e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030207; x=1691622207;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V3AeU+luiCA/Y1UCFMNDdCAt3vJKdjvI6VF3GLVTy8g=;
 b=At0WALhQPHLW5efW7+MsKnSWc9lwpgJ+YRBZpPQxvQlSrVLXocSjaWsfHH8IVuhscL
 h3WbpVZvqDJtCX3ScJtfWOkOO/OO+VlhlKC3s/k2MkZ10vSG6UL8rsw95L92hRwW3tDu
 XFBaWG7C0q6yBAKB13SHynCa1VxMF3J5925pRHsPEmsY4ITQdFE3k50jEzkP1yrGC7qt
 TO6Rxaf1LWE0PMAd6iyYnlQFyz0Ys59q9lmbxlG2PA4OHycijY2WqU0FkX7Lgr5033NT
 519PCiIfRFh/iHdcr8CqQQ2IvispoUFac9YNImvxVK7ubcZ4hRjd5tFVeqe6GmC0IlrM
 SI9A==
X-Gm-Message-State: ABy/qLY6BpjeT2RqFoViDwPf4yoIZaBenfkU2Lgt/58I6ssD2YRD7B6q
 JDLyg01wm85OiiuvS7rts/tdFyLs+dqaJwLSmcxtAMyWC/df2ZlQZP/yJCO88z9C6tcoh3f41gB
 uo6iYJNIQN/GVTO8z7+boA4cj0g0wP62nnHWDGEDLfSL34L2Vn/V9HtcOR9lCjB1Cl0YT
X-Received: by 2002:a05:600c:acc:b0:3f9:b30f:a013 with SMTP id
 c12-20020a05600c0acc00b003f9b30fa013mr14576219wmr.6.1689030207309; 
 Mon, 10 Jul 2023 16:03:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG7Yw1rm9oEEyjyQeGC3r3I3bsau8MgE9cFxgiocQAJ45u87z6+7en26CK8/UTvk0kkLdkOlw==
X-Received: by 2002:a05:600c:acc:b0:3f9:b30f:a013 with SMTP id
 c12-20020a05600c0acc00b003f9b30fa013mr14576197wmr.6.1689030207039; 
 Mon, 10 Jul 2023 16:03:27 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 l16-20020a1c7910000000b003fb40ec9475sm948212wme.11.2023.07.10.16.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:26 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 21/66] hw/pci-host/q35: Initialize PCI_HOST_BYPASS_IOMMU
 property from board code
Message-ID: <e36102cb07dddb3f3758398322535a50e7ed41f2.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Bernhard Beschow <shentey@gmail.com>

The Q35 PCI host already has a PCI_HOST_BYPASS_IOMMU property. However, the
host initializes this property itself by accessing global machine state,
thereby assuming it to be a PC machine. Avoid this by having board code
set this property.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230630073720.21297-6-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_q35.c  | 2 ++
 hw/pci-host/q35.c | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 4edc0b35f4..852250e8cb 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -230,6 +230,8 @@ static void pc_q35_init(MachineState *machine)
                             x86ms->below_4g_mem_size, NULL);
     object_property_set_int(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
                             x86ms->above_4g_mem_size, NULL);
+    object_property_set_bool(phb, PCI_HOST_BYPASS_IOMMU,
+                             pcms->default_bus_bypass_iommu, NULL);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
     /* pci */
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 0604464074..d2830cee34 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -66,8 +66,7 @@ static void q35_host_realize(DeviceState *dev, Error **errp)
                                 s->mch.pci_address_space,
                                 s->mch.address_space_io,
                                 0, TYPE_PCIE_BUS);
-    pci->bypass_iommu =
-        PC_MACHINE(qdev_get_machine())->default_bus_bypass_iommu;
+
     qdev_realize(DEVICE(&s->mch), BUS(pci->bus), &error_fatal);
 }
 
-- 
MST


