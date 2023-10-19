Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E8E7D01A1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:33:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhT-0000po-D5; Thu, 19 Oct 2023 14:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXh1-0008WP-RM
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgz-00029q-70
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x3My//pc/qVW2ftl9aWSgQDTy/uh8IXpNIimgHcVE8A=;
 b=WvhIz5s2UwMy9fodW9Cp8fV31FTBY/Gt/BG0TzjLK4u062Elt+rOW1ArTd3/JOU9pnj8Ev
 DJ200yhoaL2zpD+xW5ytu3kjVLZlqKdJ9t5QLWnCRFirQBrtIca87a8wgp2vLXpU5Xt9p4
 eNo5LjRi9blClWP0OR+c9RwsD7EFAMA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-BFg5xkSYN-6vOfPE-FEenQ-1; Thu, 19 Oct 2023 14:24:09 -0400
X-MC-Unique: BFg5xkSYN-6vOfPE-FEenQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe182913c5so51922655e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739847; x=1698344647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3My//pc/qVW2ftl9aWSgQDTy/uh8IXpNIimgHcVE8A=;
 b=Z14+xxWfXuSWTYY6ByaRdoRlB5AnCVkSNE/ZJrfCDPtjVpn7ENbDDQkKpkhSXmxYBT
 UzjhPM0r3MAt9vtO//g+v5qzxPWlV7jaosHh3SCSgHqdZq7A3vUt49qg7agG34WmgpwJ
 WKYkyYi0bI8C9ojx95nXM1vI0O0qAULmA6XFIeOfdArcJP3nCWAIPIRJORE287IR8K1Q
 ePkOHhNPDWh1xwY8owLRA+kf2mw2lrwYfpz/XL0DvBlhx0H4srbsmdrd8fOEb6NSRMDR
 zBKWIcgG2Gc8EKY+AKJkGm5pR0x3SqZzOyUUSW9oSdQGkeRFsRHHbluGhOZmEYj/jnHr
 3kVw==
X-Gm-Message-State: AOJu0Yxq0eNI72Stzofk+4p0xX1PQQ0Ab7FSijwcnuFYxGQTfLUq8dxS
 YBfELT0VXdeQsxvJXKI3yU9on5YZZW2txbb1zdgnk7Cp3p8QNRaXWIC1eulMxjMRjoTzcdpmi8z
 rRi8pypXXn+QDNTO762QaCiIC/fFoiQgfyCIcKViQRjBPWyIZwt1m9FiSd0F3eL3/2M4G
X-Received: by 2002:a5d:638a:0:b0:32d:b1d7:419f with SMTP id
 p10-20020a5d638a000000b0032db1d7419fmr2277313wru.32.1697739847475; 
 Thu, 19 Oct 2023 11:24:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5uWozbg6JYHY247TjIxUGIBITqzcut/kbW+p9IqZZNNHZbL16Rh6Ut0PwCBMcJ9BtOse7wQ==
X-Received: by 2002:a5d:638a:0:b0:32d:b1d7:419f with SMTP id
 p10-20020a5d638a000000b0032db1d7419fmr2277297wru.32.1697739847138; 
 Thu, 19 Oct 2023 11:24:07 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adfa35c000000b0031ad5fb5a0fsm5045581wrb.58.2023.10.19.11.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:24:06 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:24:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 65/78] hw/isa/piix: Implement multi-process QEMU support
 also for PIIX4
Message-ID: <f2bc8eba2a6e2f3b24713e84687766f7fc504917.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

So far multi-process QEMU was only implemented for PIIX3. Move the support into
the base class to achieve feature parity between both device models.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-29-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index cba2098ca2..04ebed5b52 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -374,6 +374,7 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
     }
 
     pci_bus_irqs(pci_bus, piix_set_pci_irq, d, PIIX_NUM_PIRQS);
+    pci_bus_set_route_irq_fn(pci_bus, piix_route_intx_pin_to_irq);
 }
 
 static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
@@ -454,15 +455,7 @@ static const TypeInfo piix_pci_type_info = {
 
 static void piix3_realize(PCIDevice *dev, Error **errp)
 {
-    ERRP_GUARD();
-    PCIBus *pci_bus = pci_get_bus(dev);
-
     pci_piix_realize(dev, TYPE_PIIX3_USB_UHCI, errp);
-    if (*errp) {
-        return;
-    }
-
-    pci_bus_set_route_irq_fn(pci_bus, piix_route_intx_pin_to_irq);
 }
 
 static void piix3_init(Object *obj)
-- 
MST


