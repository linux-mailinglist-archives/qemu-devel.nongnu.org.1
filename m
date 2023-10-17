Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F24817CC575
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:03:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsket-0004sa-Uw; Tue, 17 Oct 2023 10:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qskep-0004P2-0m
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qskem-0008Sa-9t
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40684f53ef3so60050235e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697551366; x=1698156166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSV6TxGYLgcQL/krz5TOyE8HELjjUeVpowrQ5kqb6M0=;
 b=ChgdXX7hg0odR/B9WbhlAGKUQatVxNaRdajE2hHb2knOpCxehS/w8D+KGiVRTpmMEt
 tMKPijUzP7GHwArvUjRVpMo+J6XQbmjOVkNZVe/lzzTJv5oozJB6OuDwowkX8+2wdRjW
 XRTQdYoWm34yAVsPASVtv2GuP4t1Um5Skpy5q6pWYmcy6pHZCgd0ucwZI+CGkrwWtHtP
 ViyR85uVxc9XZQGlGW5XjO6iHO/0SY2VPvgwWdlJli3UYRa734lcd2bJQkF4WwvrVNkD
 1Vit5Qkd2wcul3Z5Jt/KuoBuoAWsoibAmjnaXlSXvGRSkndXwRn+fVOSbh0lhlfudZmb
 NUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551366; x=1698156166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WSV6TxGYLgcQL/krz5TOyE8HELjjUeVpowrQ5kqb6M0=;
 b=Nbxu6603HGGLT/VIVsEdxXWos1z5UgJTTn8NCvDPM1kDc+ogCemecG4zc02WWB07DX
 IB9ve/ZCkNyhZnP4JoAUxZkITBNDXjwqornbe1Q/pArQg7gp7L/VST3cACbkrqkAalia
 OjqhHWDOM914GezI2VwrkNI/5pRho6rPEJy9GEZNoUUdKpIR6f7T28OMa2/UkDj/VeDY
 rQf/2qfGpN5XI6Oe7HDha4INnzkHEroLlJFXCC7+Xm/Xn+vs0wlgZk9/EZina1CSGiFJ
 rElmBn4xNu5j/AME/40dhdbYRhdobUA7RKklcd+TyES4vZXuwFWCblMSz+7RA1pyBO2N
 miFw==
X-Gm-Message-State: AOJu0Yznw6eNGZLNlSHXJ0PUf3IyZ7TmqqsAeut2vDBeTty1ehPiPRL+
 uRx1UL7KCF9TjKJa5COscqdfqcm5otOb7W6INsDNzQ==
X-Google-Smtp-Source: AGHT+IHuQWHBKr2Q61LCO+4KLsyKOlm0Wvur26s/WwVnlDr335X79hVC64BsH5fGr1D7ry1UCn792w==
X-Received: by 2002:a05:6000:a87:b0:32d:8894:6aa2 with SMTP id
 dh7-20020a0560000a8700b0032d88946aa2mr1705571wrb.2.1697551365810; 
 Tue, 17 Oct 2023 07:02:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a5d60c5000000b0032179c4a46dsm1731419wrt.100.2023.10.17.07.02.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Oct 2023 07:02:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/7] hw/usb: Declare link using static DEFINE_PROP_LINK() macro
Date: Tue, 17 Oct 2023 16:01:50 +0200
Message-ID: <20231017140150.44995-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017140150.44995-1-philmd@linaro.org>
References: <20231017140150.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pull the 'dma' property to the core XHCI type, declare
its link statically using DEFINE_PROP_LINK().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-xhci-sysbus.c | 4 ----
 hw/usb/hcd-xhci.c        | 2 ++
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index faf57b4797..15983d0b96 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -60,10 +60,6 @@ static void xhci_sysbus_instance_init(Object *obj)
     object_initialize_child(obj, "xhci-core", &s->xhci, TYPE_XHCI);
     qdev_alias_all_properties(DEVICE(&s->xhci), obj);
 
-    object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
-                             (Object **)&s->xhci.dma_mr,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_STRONG);
     s->xhci.intr_update = NULL;
     s->xhci.intr_raise = xhci_sysbus_intr_raise;
 }
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 4b60114207..012a6f3644 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3638,6 +3638,8 @@ static Property xhci_properties[] = {
     DEFINE_PROP_UINT32("p3",    XHCIState, numports_3, 4),
     DEFINE_PROP_LINK("host",    XHCIState, hostOpaque, TYPE_DEVICE,
                      DeviceState *),
+    DEFINE_PROP_LINK("dma", XHCIState, dma_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


