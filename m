Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B077CE258
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:10:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8x0-0001Uk-Rq; Wed, 18 Oct 2023 11:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8wF-0000mT-52
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8wC-0007Q6-84
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sa7cxSufEU1YWW/+qYkYuIGxk5+3HVskWy82qBGzA2s=;
 b=Uz6RCi6XZL1R+QUkWJDMMoIDTZBiCC9FtcipdllU6ogZgo0A/kPyI94yfpQnPzLS77uwOV
 8Zz7PJEBUCD9YNa/XCXlh00aXqVhNMs8owz8YQR7T/vlrSu+dWQ/n6uvPnnkzv53Nm8Ye4
 54WXMS3zr+RPdTKeL+uuOgMJjZkLnVU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-9FQ9p8sfOvSQ_E-A03IZKA-1; Wed, 18 Oct 2023 11:57:59 -0400
X-MC-Unique: 9FQ9p8sfOvSQ_E-A03IZKA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3231fceb811so4138778f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644678; x=1698249478;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sa7cxSufEU1YWW/+qYkYuIGxk5+3HVskWy82qBGzA2s=;
 b=gSSpqJYgWVxEcDt7qCbmf9F92DyiS0IVFwXayeGndgInm3gahIZfxsy22cpybF62LI
 je9Klhu6FlSXI/nHKPvRuR4znMgMVjn9x4zzCt0MXyFWCQ+uFi1QbVCAp9YkvM21+1fI
 oueYFtVDBlWRMXOjkYxUfUQKlRYiWWqDthZMqnZQehIGLF/ChEGHJyh3fkRLd11S8EQm
 mh8xN2/0CmnHabznuWiTVOJcI9L0s7etM3GqHhpHAzQQxIkUSgBrrIM/aNOEnRyTGATH
 KGvcdX9hs8j2F5bSpWMQcKA8CU5vFrjraKQcb2ePyCI+m0I4EUzeMPhjC2eCUWrHb9uh
 HRTg==
X-Gm-Message-State: AOJu0YwDEp/pkoxLCVXBefItlEnWzul7aEpy+p1Gs1rKsdAGOCkM8+wg
 cMnIUM6IiMwuQcAG9CX+XgJwlIwHuN28oIOx+miESE1AAO0q9/j/M0uhXEh8BJXDwCTPMmJVd+L
 bx3NLu0T928o/++1OTkGXh3nhw/aXEmkjUrGBy9c8Gmwn3eLdUsTWVVXeARMzS5U2fXydsBU=
X-Received: by 2002:a5d:4e90:0:b0:32d:a4c4:f700 with SMTP id
 e16-20020a5d4e90000000b0032da4c4f700mr4654626wru.38.1697644678122; 
 Wed, 18 Oct 2023 08:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVmTRf8M1sYmePksRQUi8x2kkJ3sMHviIBlCpHeVXEM/iSE2GYSGiNENRYV+8LL3BpLVK+Cw==
X-Received: by 2002:a5d:4e90:0:b0:32d:a4c4:f700 with SMTP id
 e16-20020a5d4e90000000b0032da4c4f700mr4654611wru.38.1697644677815; 
 Wed, 18 Oct 2023 08:57:57 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a056000180b00b0032db8f7f378sm2400573wrh.71.2023.10.18.08.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:57:57 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:57:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL 60/83] hw/isa/piix4: Reuse struct PIIXState from PIIX3
Message-ID: <14d6b2f62da4f8e586e80e6aff7c7c1dd0d38faf.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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


