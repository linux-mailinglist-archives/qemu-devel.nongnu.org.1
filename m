Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FC77D0194
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhn-0001c0-TA; Thu, 19 Oct 2023 14:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgm-0008Dn-1g
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgk-0001pi-D0
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sa7cxSufEU1YWW/+qYkYuIGxk5+3HVskWy82qBGzA2s=;
 b=THO0xTi4Wcm4kYOdFINi7iq4r4oqwfLzSQrdqKa5XiEU3TMY4GTL7iFD7x4HkvLpvbB726
 Z18EWYyx9xVpwtW/hCIZvmZsM5v1b7rPMZGxsexJmnt+6qqgn3l+qRMDCE+xbuxWuxC4Mi
 yD0GfINXEj0mwwMT45AGRMhp9rwcKcQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-mUdU1e2UNBWqWKlfItJZyg-1; Thu, 19 Oct 2023 14:23:43 -0400
X-MC-Unique: mUdU1e2UNBWqWKlfItJZyg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4077e9112b4so31980365e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739822; x=1698344622;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sa7cxSufEU1YWW/+qYkYuIGxk5+3HVskWy82qBGzA2s=;
 b=trDhZSu8gvNztPwQcAIJa7UgUBb9z9qMdoNsX3xsXcOfZ6MidNTK2hoWkkKOEC5G6m
 TTwPGwoiKhh+dpXAH7B54EokoIj6fICAsc5YmbEZpGCxosiMmALib2+zkhilzExs9mSI
 zErc6PXJtBusadwmyPJm7aWsAWy6pLHwG2XZnYo+bv1vuzV1oJVt0U9+v7A3LvP2Kd6C
 VrLCSpRvP2H7UjhLz0AMdXq9ylHOSf0CjJU7+xrOT/STyNgxuDJ9mg1ZaN8N0KWVNg6X
 JjCu7RR/knapVP9Mqrv9P0fkfDeuhFQXWa6qx7wSNje9uUeKXhW9mppKCGA9aGHOIO4T
 B11g==
X-Gm-Message-State: AOJu0YyCj8WWY55TclYeu0CWrYAgb5j/dK2CGZIngScRguNuAX/PQGgy
 siCRu+LVQNHjaNcJe7bOKwx39Rtz0MkC4VJ8sfrhDL2xzvIKlDLEsEE3YNbcD2gHpGvXq9exRnH
 7wyjJ7O4G5SiUw26a4vMCF/wRNWqNKXxf9d549VX+dZ9fjyBrWuIMlnQWiqKCAIDEqJXo
X-Received: by 2002:a05:600c:6004:b0:408:364e:34a2 with SMTP id
 az4-20020a05600c600400b00408364e34a2mr2383937wmb.10.1697739822237; 
 Thu, 19 Oct 2023 11:23:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5XbKf//z7qqf9yS6WbbvpeUAIn90KcNGp+wMEl4WpJkTVF7BT01d1lfjYtTHFGB8lLq3uqg==
X-Received: by 2002:a05:600c:6004:b0:408:364e:34a2 with SMTP id
 az4-20020a05600c600400b00408364e34a2mr2383854wmb.10.1697739819004; 
 Thu, 19 Oct 2023 11:23:39 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a05600c0ad000b003fee567235bsm4996013wmr.1.2023.10.19.11.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:23:38 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:23:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL v2 55/78] hw/isa/piix4: Reuse struct PIIXState from PIIX3
Message-ID: <e219e47e5748be63bfc51c8f672dd812b8bb2a6d.1697739629.git.mst@redhat.com>
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

PIIX4 has its own, private PIIX4State structure. PIIX3 has almost the
same structure, provided in a public header. So reuse it and add a
cpu_intr attribute to it which is only used by PIIX4.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-19-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/southbridge/piix.h |  1 +
 hw/isa/piix4.c                | 26 +++++++++++---------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 0b257e1582..dd5f7b31c0 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -49,6 +49,7 @@ struct PIIXState {
 #endif
     uint64_t pic_levels;
 
+    qemu_irq cpu_intr;
     qemu_irq isa_irqs_in[ISA_NUM_IRQS];
 
     /* This member isn't used. Just for save/load compatibility */
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index eb456622c5..71899aaa69 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -42,21 +42,9 @@
 #include "sysemu/runstate.h"
 #include "qom/object.h"
 
-struct PIIX4State {
-    PCIDevice dev;
-    qemu_irq cpu_intr;
-    qemu_irq *isa_irqs_in;
+typedef struct PIIXState PIIX4State;
 
-    MC146818RtcState rtc;
-    PCIIDEState ide;
-    UHCIState uhci;
-    PIIX4PMState pm;
-    /* Reset Control Register */
-    MemoryRegion rcr_mem;
-    uint8_t rcr;
-};
-
-OBJECT_DECLARE_SIMPLE_TYPE(PIIX4State, PIIX4_PCI_DEVICE)
+DECLARE_INSTANCE_CHECKER(PIIX4State, PIIX4_PCI_DEVICE, TYPE_PIIX4_PCI_DEVICE)
 
 static void piix4_set_irq(void *opaque, int irq_num, int level)
 {
@@ -184,6 +172,8 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
     PCIBus *pci_bus = pci_get_bus(dev);
     ISABus *isa_bus;
     qemu_irq *i8259_out_irq;
+    qemu_irq *i8259;
+    size_t i;
 
     isa_bus = isa_bus_new(DEVICE(dev), pci_address_space(dev),
                           pci_address_space_io(dev), errp);
@@ -201,7 +191,13 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
 
     /* initialize i8259 pic */
     i8259_out_irq = qemu_allocate_irqs(piix4_request_i8259_irq, s, 1);
-    s->isa_irqs_in = i8259_init(isa_bus, *i8259_out_irq);
+    i8259 = i8259_init(isa_bus, *i8259_out_irq);
+
+    for (i = 0; i < ISA_NUM_IRQS; i++) {
+        s->isa_irqs_in[i] = i8259[i];
+    }
+
+    g_free(i8259);
 
     /* initialize ISA irqs */
     isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
-- 
MST


