Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF127D2255
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:31:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUi4-0006Xv-5A; Sun, 22 Oct 2023 05:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUi1-0006RF-R5
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhz-0000rM-Om
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fiCWXY5zmRdQNGyxHv3gzp1e9XV+cYxYi5n0fzse+pU=;
 b=UnHXJi8xFrCk0BUjXkWt9zCAIcA48KEin0yVbdDreQhfI00ye6J9r7VfjLkG7noBESMJrW
 mtbtDqKt5CBXTckP1+y96QxqvGqla8MV72YvoFfTx1Yg423yRZzC/LM6PjvNFHCG4DdR6J
 4/TmLunOkj8ZwiBQlXR7A+/JbJMZ+Oo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-LfGovp6PMLi21WgqDAPXXw-1; Sun, 22 Oct 2023 05:25:17 -0400
X-MC-Unique: LfGovp6PMLi21WgqDAPXXw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso12651545e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966715; x=1698571515;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fiCWXY5zmRdQNGyxHv3gzp1e9XV+cYxYi5n0fzse+pU=;
 b=qxb9W16WNm6QN8jQs2zGMwio541pt1UYpKHokQTxvlGzQs3/AkFVQ8dnU2azhNF79G
 25d0r+82rN1v9GL0T39QDv8m4gOkQ9247oVW2egpGcnFRR8XqfrVEW8H7DhBiHMxQEIX
 muYyI+lpFnJ4Np048zfJ4KTJjhH2YoU54HlLUNoUgNYX9LzWjIwl0kR5DCWkbQJfCR7Q
 dFIAUaGXxZI4UHFuDVL5SlJPHs+7o1YYljz9u08QL1I7hensLPOFbgH33gx8lvHsNkSS
 I/yxMzOVQN3K8xrIGwGUIm1Ke+HajrMYkLCwKzsiJ+flLSW7YsZ0oNY1QEcn94zX4HEK
 1pMQ==
X-Gm-Message-State: AOJu0Yzo7pj/MUopQAQ1lpxCR5EJyyj9bGbHjoJFZTfu1X2MxE+LQpKu
 bMMdUcj4peAGadF61nvnaczi8+C0l/5ymxJvxKF1lqIxncjX8bWGhesPp87g4u0xxYpJ7+qSqVd
 Zs+Le/Z+Ft5SHKTdp1RrmVlAtsIvT9cRo027u8GIHlbO8JjzvqYgQHi8E5ZMH47HyGxg2
X-Received: by 2002:a05:600c:1e0c:b0:406:84b2:67f with SMTP id
 ay12-20020a05600c1e0c00b0040684b2067fmr4720410wmb.20.1697966715508; 
 Sun, 22 Oct 2023 02:25:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+fyCUQcibj87R8NH048QR1bl6BQ4Bp57ePpKMu88kL041JZtopx9FcRUHbrNK8bfBFIos6Q==
X-Received: by 2002:a05:600c:1e0c:b0:406:84b2:67f with SMTP id
 ay12-20020a05600c1e0c00b0040684b2067fmr4720391wmb.20.1697966715073; 
 Sun, 22 Oct 2023 02:25:15 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 c8-20020a05600c0a4800b0040775fd5bf9sm6596507wmq.0.2023.10.22.02.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:25:14 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:25:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL v3 47/62] hw/isa/piix: Reuse PIIX3's PCI interrupt triggering
 in PIIX4
Message-ID: <0c9fd5a309c8449c70c727f271baf554491d4ecd.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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

Speeds up PIIX4 which resolves an old TODO. Also makes PIIX4 compatible with Xen
which relies on pci_bus_fire_intx_routing_notifier() to be fired.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-27-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 449c1baaab..17677c2126 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -81,27 +81,6 @@ static void piix_set_pci_irq(void *opaque, int pirq, int level)
     piix_set_pci_irq_level(s, pirq, level);
 }
 
-static void piix4_set_irq(void *opaque, int irq_num, int level)
-{
-    int i, pic_irq, pic_level;
-    PIIXState *s = opaque;
-    PCIBus *bus = pci_get_bus(&s->dev);
-
-    /* now we change the pic irq level according to the piix irq mappings */
-    /* XXX: optimize */
-    pic_irq = s->dev.config[PIIX_PIRQCA + irq_num];
-    if (pic_irq < ISA_NUM_IRQS) {
-        /* The pic level is the logical OR of all the PCI irqs mapped to it. */
-        pic_level = 0;
-        for (i = 0; i < PIIX_NUM_PIRQS; i++) {
-            if (pic_irq == s->dev.config[PIIX_PIRQCA + i]) {
-                pic_level |= pci_bus_get_irq_level(bus, i);
-            }
-        }
-        qemu_set_irq(s->isa_irqs_in[pic_irq], pic_level);
-    }
-}
-
 static void piix_request_i8259_irq(void *opaque, int irq, int level)
 {
     PIIXState *s = opaque;
@@ -223,7 +202,7 @@ static int piix4_post_load(void *opaque, int version_id)
         s->rcr = 0;
     }
 
-    return 0;
+    return piix_post_load(opaque, version_id);
 }
 
 static int piix3_pre_save(void *opaque)
@@ -442,6 +421,7 @@ static void pci_piix_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
 
+    k->config_write = piix_write_config;
     dc->reset       = piix_reset;
     dc->desc        = "ISA bridge";
     dc->hotpluggable   = false;
@@ -497,7 +477,6 @@ static void piix3_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->config_write = piix_write_config;
     k->realize = piix3_realize;
     /* 82371SB PIIX3 PCI-to-ISA bridge (Step A1) */
     k->device_id = PCI_DEVICE_ID_INTEL_82371SB_0;
@@ -522,7 +501,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    pci_bus_irqs(pci_bus, piix4_set_irq, s, PIIX_NUM_PIRQS);
+    pci_bus_irqs(pci_bus, piix_set_pci_irq, s, PIIX_NUM_PIRQS);
 }
 
 static void piix4_init(Object *obj)
-- 
MST


