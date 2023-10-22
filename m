Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA9D7D223E
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:28:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUgl-0008Vt-Q7; Sun, 22 Oct 2023 05:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgj-0008K0-Se
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgi-0000Rr-9Q
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zb7+9uBs0aVVSmIJfkcKx4/iAP+jZ8ER447ZRZ+1lm8=;
 b=iaz7Y1nW0Wq1nh9DRP9kWnF8vxXD3JNzkxbeWhAL/UwON903fy48AyKccJyIqvQGj1nY6z
 B1zTDY3BEEYRe4AjHyvS9X7MZzZd05Ig4NlwTXqbqqLHCrlcYHMVIFKebQLIK/deRs8CxI
 rcoKGKGpRZLI2LVBwK+VRRSmhM2Fs14=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-SZQGp2lyPb2Z36rv5XXSeg-1; Sun, 22 Oct 2023 05:23:58 -0400
X-MC-Unique: SZQGp2lyPb2Z36rv5XXSeg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so12547495e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966636; x=1698571436;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zb7+9uBs0aVVSmIJfkcKx4/iAP+jZ8ER447ZRZ+1lm8=;
 b=NPo85+Hb5EKk8ybIWl4EDC1XtBR372MPa2e7pjg7OqKCMoSHtQF+dGG+Qz1f/qKjLc
 fMzahZMqWxAO8oJIjGlPO727dB2wBl68rCwDepaj6JSeRWF355OYKXr+ow1nftLPtuoE
 I80wA1e1fnlp2sex25MStMQNzto2Rm0yNo9uyDxVQ8AlFZkVGUWz57dvq7nYcDwGihmj
 BvQJGag9xOXf2QuuqRHUSOpWQF3FzIw82X3MtS69pVsCCzV/X2wF3dBlNK4w2i2ySTsP
 7VVOUgBHY+2g+tpcuwjzRmzJQxoVIBR+1EHXlldUY8q0sCFIrdTSvDE5JZvnIjSZvHEy
 5DNg==
X-Gm-Message-State: AOJu0YwofhfLW754EjgHB9LNKEY7XCqSEjCNve7FYRFc45GZ+itfCdl1
 1BNxWoUVeUaLFDrL5FYH73TW4Zt8yATD9FbtICMHMwQ4LmXI9iQ8p+tE7LM6Sc1ofKQOwwutJJ3
 +6NuWhLq0Z7jibWrcf2HvrZIjvBQG7wH5q8xm/XuqwMlIsgMZfgYRzUN+0egf9UivLYQF
X-Received: by 2002:a05:600c:31a9:b0:406:7074:301d with SMTP id
 s41-20020a05600c31a900b004067074301dmr4813739wmp.11.1697966636288; 
 Sun, 22 Oct 2023 02:23:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOeMHGQ+qfPabtfp/NfIqQbBHVLq5uDet4dGKorn+yK1efDHn8w9YC04/6VLJjDKXmFxIBGg==
X-Received: by 2002:a05:600c:31a9:b0:406:7074:301d with SMTP id
 s41-20020a05600c31a900b004067074301dmr4813721wmp.11.1697966635957; 
 Sun, 22 Oct 2023 02:23:55 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 v3-20020adff683000000b0032d9523de65sm5213155wrp.48.2023.10.22.02.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:23:55 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:23:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL v3 27/62] hw/i386/pc_piix: Remove redundant "piix3" variable
Message-ID: <b9a8b8d29f438b6a695b12bd2d3e0567cbae5dc7.1697966402.git.mst@redhat.com>
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

The variable is never used by its declared type. Eliminate it.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-7-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 4dc7298c15..cd6c00c0b3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -261,13 +261,11 @@ static void pc_init1(MachineState *machine,
     gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
 
     if (pcmc->pci_enabled) {
-        PIIX3State *piix3;
         PCIDevice *pci_dev;
         DeviceState *dev;
         size_t i;
 
         pci_dev = pci_new_multifunction(-1, TYPE_PIIX3_DEVICE);
-        piix3 = PIIX3_PCI_DEVICE(pci_dev);
         dev = DEVICE(pci_dev);
         for (i = 0; i < ISA_NUM_IRQS; i++) {
             qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
@@ -288,8 +286,8 @@ static void pc_init1(MachineState *machine,
                          XEN_IOAPIC_NUM_PIRQS);
         }
 
-        piix3_devfn = piix3->dev.devfn;
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
+        piix3_devfn = pci_dev->devfn;
+        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
         rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
                                                              "rtc"));
     } else {
-- 
MST


