Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0892F7CE1EE
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:58:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vO-0006Ks-Ua; Wed, 18 Oct 2023 11:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8uu-0004X6-Bo
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8us-00078f-QI
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R8vGmlEfppo+TqGZX0HrmOY6HWL1WGWh7BLfVKf8if4=;
 b=f61k1oqtWNKC2UFG/9/wuMEYvz1j6UvJD2/ZDAA46qd3jD0oJ+t+QHJrJqp5b/zp4gY3x9
 cIZc112egOoGz6VNiopirQOBP4Ep+OXusjztTE68dlNoPsqQP76MeI9P8Lk+SazgOOJQ12
 +P39/B494kpU1dEgc1nggjp+gixit/k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-JDIJTJE4P3msmGhqaZ9kUg-1; Wed, 18 Oct 2023 11:56:50 -0400
X-MC-Unique: JDIJTJE4P3msmGhqaZ9kUg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c520e0a9a7so34428291fa.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644609; x=1698249409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8vGmlEfppo+TqGZX0HrmOY6HWL1WGWh7BLfVKf8if4=;
 b=X5fBNQ7K0a66vk/5EIAhkXpR2GA6GVEXLOaVF2cSkPzfcyoWVkiz7IXjLpV5GlRtN2
 Fo5BKWJfDpihDrxYeRs/9WBdynT17Aj2nJtnj5GLfHVBy9x93MnvxFjrb6OE5siXdv66
 vg388D6xhv0Tb7UbU29nQNENE1XIitx2hh6oKptUjiOrH7p67FcF/voNDFstrzqgn1P7
 hDUD5x2XRUYKzBE151DHkwokAHNe8A+smBHKsLV2K/5AhaR/OWpQ3sZ2QCidK8jX+7LM
 SisKc5Du0frXy8pl99sLkv9bAN/pVTuiDmoG2cW/bqNRa3ypeyej9XL9LTY7oBwXoc2q
 RBHA==
X-Gm-Message-State: AOJu0YyLbDzIfGm37Siaa3OejrXzD7ChwItkTL8OF4NugC8kyL+9kgxQ
 T6pZgQZdJeL7Y/SWSOzVogGqXrbkXyJKaawb8VwEGQaav3MF7IYS2SVOsZ8X5UPNRqD3Rc78Aqk
 FJs7+LtLTk6MB4H1TtXzOChLuRYrQ+rk3yZts3cRmVeQQouQh6HyO0bKqS9B86ILbycyVvIg=
X-Received: by 2002:a2e:878d:0:b0:2b6:e958:5700 with SMTP id
 n13-20020a2e878d000000b002b6e9585700mr4426902lji.4.1697644608866; 
 Wed, 18 Oct 2023 08:56:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGxBSVeKm7PIZnk3OUL9d/jCO70NXoy64yYxolzV5NUed3DUY8rRx0lGE68xWghWsbdMDtLQ==
X-Received: by 2002:a2e:878d:0:b0:2b6:e958:5700 with SMTP id
 n13-20020a2e878d000000b002b6e9585700mr4426887lji.4.1697644608584; 
 Wed, 18 Oct 2023 08:56:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a05600c314e00b003fbe4cecc3bsm2024920wmo.16.2023.10.18.08.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:56:48 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:56:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 45/83] hw/i386/pc_piix: Assign PIIX3's ISA interrupts before
 its realize()
Message-ID: <c89f01c55615ad112a2120c79d2b345cec434ba0.1697644299.git.mst@redhat.com>
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

Unlike its PIIX4 counterpart, TYPE_PIIX3_DEVICE doesn't instantiate a PIC
itself. Instead, it relies on the board to do so. This means that the board
needs to wire the ISA IRQs to the PIIX3 device model. As long as the board
assigns the ISA IRQs after PIIX3's realize(), internal devices can't be wired in
pci_piix3_realize() since the qemu_irqs are still NULL. Fix that by assigning
the ISA interrupts before realize(). This will allow for embedding child devices
into the host device as already done for PIIX4.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Message-Id: <20231007123843.127151-4-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6d2f5509e6..a003923788 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -265,6 +265,8 @@ static void pc_init1(MachineState *machine,
         PCIDevice *pci_dev;
 
         pci_dev = pci_new_multifunction(-1, TYPE_PIIX3_DEVICE);
+        piix3 = PIIX3_PCI_DEVICE(pci_dev);
+        piix3->pic = x86ms->gsi;
         pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
 
         if (xen_enabled()) {
@@ -281,8 +283,6 @@ static void pc_init1(MachineState *machine,
                          XEN_IOAPIC_NUM_PIRQS);
         }
 
-        piix3 = PIIX3_PCI_DEVICE(pci_dev);
-        piix3->pic = x86ms->gsi;
         piix3_devfn = piix3->dev.devfn;
         isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
         rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-- 
MST


