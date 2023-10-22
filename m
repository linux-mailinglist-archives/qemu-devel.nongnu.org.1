Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9167D2244
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:29:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUhl-0005Ev-MZ; Sun, 22 Oct 2023 05:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhf-0005BT-6H
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhd-0000cm-Jm
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sa7cxSufEU1YWW/+qYkYuIGxk5+3HVskWy82qBGzA2s=;
 b=KAa4C7x9Rb15/uNks27aQsYmwX1tds007sitTc8UKH8S1cetj+e+izbLw87GCf7PnY5cgf
 lqzzFJkarVKj7zRSmJ3wpkcoUhbXlYmQfOwwZTh07nfB3mDdzHv9qbk3ahXi/yuf2Bpz89
 9+NEBDP8NyIhMEMumFB7dJPHJ16IjwQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-zlVchhI9OfeUihqgBv7G2w-1; Sun, 22 Oct 2023 05:24:45 -0400
X-MC-Unique: zlVchhI9OfeUihqgBv7G2w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so14091205e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966683; x=1698571483;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sa7cxSufEU1YWW/+qYkYuIGxk5+3HVskWy82qBGzA2s=;
 b=Rv1YT/cjc3jaOOold6fF0ExZwNjxf6y3NR/MWeckDQdxJT2P3IcEck6pZ7Vtphrb5E
 qzVxte85UDoJbm3ZTkKqdxESMz6AncIl2rG4FtJe6/IDZ3eMrISkHfEPZXoOx+VhMdcN
 VqnWLaILTgVQb+C0H+SL9+0P/C0soMcvzMFLFpG1OS+lPG8fpXjzAD4oIG36SbP5ZiEz
 24mda6Q0eC8FL/ZJMGjGbPrxMkyybvzSiI1Dm6+wpYqTnOD1sv1eFWDFX3R/uKcVFHVl
 892NnTa0Zza/M6lRGhgobuLhPkk3aqTxvXxBMbhvlUIaUs7Q89/4ORKt/Cx2UJk5ydHx
 0+fw==
X-Gm-Message-State: AOJu0YwHrfvXVc3TydHSmARS9Uo+uCqI7vT3lesZnyDn3Ndu4scGYOOC
 AIAn/pX7ZmcSWzRdv4XvUDoNThamErFtVVxzVEIxhvGy+nv9N7EKD0s6cJzEobZUcjRzKAV9sJ4
 AvMRw5qvMkIJsyH6yirdESCCO7FEzY2ib2vQWLAjGfNNETuw+Q+cEo0Z4qdjb8hn4Ibvw
X-Received: by 2002:a05:600c:138e:b0:406:177e:5df7 with SMTP id
 u14-20020a05600c138e00b00406177e5df7mr5197340wmf.29.1697966683297; 
 Sun, 22 Oct 2023 02:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHroT+CzdXzCW3vubPXZ1PqY2OcmE6HzpSsbKyZ1lw3+5vk3qC+5uewD3jQefe3i30+LjirpQ==
X-Received: by 2002:a05:600c:138e:b0:406:177e:5df7 with SMTP id
 u14-20020a05600c138e00b00406177e5df7mr5197326wmf.29.1697966682919; 
 Sun, 22 Oct 2023 02:24:42 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 m29-20020a05600c3b1d00b003fe61c33df5sm11457494wms.3.2023.10.22.02.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:24:42 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:24:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Subject: [PULL v3 39/62] hw/isa/piix4: Reuse struct PIIXState from PIIX3
Message-ID: <74bdcfb4b2ba7958efe8e66e06757579d61ebbb3.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


