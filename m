Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 690BF7CE257
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:10:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vN-00069N-2j; Wed, 18 Oct 2023 11:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8v1-0004YQ-JZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8uz-0007DI-1t
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zb7+9uBs0aVVSmIJfkcKx4/iAP+jZ8ER447ZRZ+1lm8=;
 b=fyIMJde8eJKmrjbLE31aUZdYrft3ltCHGWvI6z6VhjP8/3rsbLpNI8IHfFTYu4snsTo60t
 0XlLmA5ma1RoGAMDyS30t+py8/qDXjtDNfSz+jok2E14iyODUJDtYIsbETj/LYb9J3HE9E
 5HIb8ZvmlktcMw/ovw+4F2T2C1iX3Qk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-TeSHBGmtPKe8M52AS_j3xA-1; Wed, 18 Oct 2023 11:57:07 -0400
X-MC-Unique: TeSHBGmtPKe8M52AS_j3xA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4055ce1e8c4so36991075e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644625; x=1698249425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zb7+9uBs0aVVSmIJfkcKx4/iAP+jZ8ER447ZRZ+1lm8=;
 b=R/ueXKeWh3uXTDXU5gNCpjop1tvyaKjfrrB77cdF/+VLk5aba6FuikG44z6uGQp+q1
 iiFyHiz52it9Y47lskbRr0fpEw5/bpN2aPU+vcEq1eaIhH32mJAEo1q3STR2n23fYcW2
 CDF3R8r74Bi6vcZ7nuc9jm6S5ZF3ZE9JH/c0trTGTwg70PQI7wVAwxX+YpUsmzIakn9T
 PMssf2dWRRA0Jz6+71RH2iIo7LnSwMDZTCVNdfb+h8kDmH5eWZktvyVJxJcz+3XuQ+XR
 OzuCdOAcbE3slEJ8w/L32Hc35eKmPt6AhCMRf5gYAouR5yKzY9HMha2myC7sAFdU0SFg
 4NsQ==
X-Gm-Message-State: AOJu0YwNmv38Rr+E2E1ronSHS9WFEkMnX+9ASRfF2bjTXYJwgxizlxXK
 khskB6oMjzSrxpRs6pXxZbkrASn6zyRwPNf4u7yeGgCny3r6jrX7wYYzjXxY6q9ZovnoeZWu7/g
 oXdg3oxOqH7Q0JLUmEL0OByLCcpVc1OqonJsqhDybKRlWJFCQGGY6SqByw+8OD8yIfn49AJ0=
X-Received: by 2002:a05:600c:3d14:b0:405:2d29:1648 with SMTP id
 bh20-20020a05600c3d1400b004052d291648mr5324422wmb.19.1697644625438; 
 Wed, 18 Oct 2023 08:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG8t3Do19EdyXZG8RCuoxvusSgLlINcXxvxXQndb7Cj5OCAh9F7BsUK9YDo408KdxGdCLLxQ==
X-Received: by 2002:a05:600c:3d14:b0:405:2d29:1648 with SMTP id
 bh20-20020a05600c3d1400b004052d291648mr5324397wmb.19.1697644624927; 
 Wed, 18 Oct 2023 08:57:04 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 v7-20020adfebc7000000b003196b1bb528sm2387972wrn.64.2023.10.18.08.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:57:04 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:56:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 48/83] hw/i386/pc_piix: Remove redundant "piix3" variable
Message-ID: <16880173d8a76d4423d377dd966a12d1f312d894.1697644299.git.mst@redhat.com>
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


