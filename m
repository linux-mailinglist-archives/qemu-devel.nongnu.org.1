Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 767227D2678
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 00:08:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qugay-0006Xh-UC; Sun, 22 Oct 2023 18:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qugau-0006Wx-3f; Sun, 22 Oct 2023 18:06:48 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qugao-0008Iq-I2; Sun, 22 Oct 2023 18:06:47 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso378561266b.3; 
 Sun, 22 Oct 2023 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698012399; x=1698617199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=S+IC8QbjH/bGFjYo+lXeMuYN2qJyH6doP9CoNSdD2rE=;
 b=BF4Wgu+/qep3BQPjmoLNH3rzJ8joR81Z94qd+eAZAsOx1F7rmk6SN7plRnKTN+2cig
 4qst04nqwxiAdxzcet9F5piiiGY3VQFZ3XPXduiv+baR7UMWoY5+uUo3P/DfnmUpEi1a
 HAxcUDvgdLUmCuxyhOXAISEnZ0jkOAOcgV0e8m4IrxsFIcCGt0GWT1boN28TlOPmCRzq
 iOUt1QtH9ccnmbFwgt6Gumtr2LbTmk+6w/z4sVpdGvGjkayNIn0flHs6AgjjKVSPlwnR
 JRaj/Cpmbck83I9g9RlCWtJ/l6KQApI6woCFET6AM2YTZh854oLEn3lfWFNWPaGj+AOz
 BCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698012399; x=1698617199;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+IC8QbjH/bGFjYo+lXeMuYN2qJyH6doP9CoNSdD2rE=;
 b=Wiuw8Nkf/P6A6PaU/q97DBlJfg4KwMBnz+koK9lafBRa3OmH7ibxA2m/S1RXPu9BEn
 oCCwCr5Ul9bMXIOkynKWQxd7hMB2wEf1E0JieNSPD/jdwxcfPHji7wMklaKZErsfD22z
 pC9KfiKt4T5l/G77WqMcgoAQvUjkXeUxm5e4Klq4YjR9P7gcTLwhaFAseUAZaOubVIfm
 lRQfDBnLe2q4VroBqfmFS/v88R7XRgoXwx0bkB5vN2D36I55HZ+UhBEkw7QyBl4VNUNz
 QjJmCpFfOHSv+N8SiqRo8h6SCKlL7+PnVtUW6PXMyukLnnpkhyA8Nb513NIR9pwOSAV7
 03zw==
X-Gm-Message-State: AOJu0Yw9gWEE4Zsnl6416YIFUD2FhDV9UBlsc3fh5dUDTiL/f5b/tdp+
 iasZ4F0r182bQNnWJisixB0=
X-Google-Smtp-Source: AGHT+IE/ErqGPKfl0tCRktSW3lx3ZHw4Hw6yw+gwRDZJeRcFacuz5dyv/72bAk3UcFcAwePwo0HX9A==
X-Received: by 2002:a17:906:d542:b0:9be:e153:3f2e with SMTP id
 cr2-20020a170906d54200b009bee1533f2emr4925587ejc.29.1698012399225; 
 Sun, 22 Oct 2023 15:06:39 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-189-152.77.13.pool.telefonica.de.
 [77.13.189.152]) by smtp.gmail.com with ESMTPSA id
 a20-20020a1709066d5400b0099bd5d28dc4sm5628630ejt.195.2023.10.22.15.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 15:06:38 -0700 (PDT)
Date: Sun, 22 Oct 2023 22:06:30 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, balaton@eik.bme.hu,
 philmd@linaro.org
Subject: Re: [PATCH 1/2] ide/pci.c: introduce pci_ide_update_mode() function
In-Reply-To: <20231019130452.508426-2-mark.cave-ayland@ilande.co.uk>
References: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
 <20231019130452.508426-2-mark.cave-ayland@ilande.co.uk>
Message-ID: <B2C0A4CE-0382-48F0-A513-8AD69960F2BF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



Am 19=2E Oktober 2023 13:04:51 UTC schrieb Mark Cave-Ayland <mark=2Ecave-a=
yland@ilande=2Eco=2Euk>:
>This function reads the value of the PCI_CLASS_PROG register for PCI IDE
>controllers and configures the PCI BARs and/or IDE ioports accordingly=2E
>
>In the case where we switch to legacy mode, the PCI BARs are set to retur=
n zero
>(as suggested in the "PCI IDE Controller" specification), the legacy IDE =
ioports
>are enabled, and the PCI interrupt pin cleared to indicate legacy IRQ rou=
ting=2E
>
>Conversely when we switch to native mode, the legacy IDE ioports are disa=
bled
>and the PCI interrupt pin set to indicate native IRQ routing=2E The conte=
nts of
>the PCI BARs are unspecified, but this is not an issue since if a PCI IDE
>controller has been switched to native mode then its BARs will need to be
>programmed=2E
>
>Signed-off-by: Mark Cave-Ayland <mark=2Ecave-ayland@ilande=2Eco=2Euk>
>---
> hw/ide/pci=2Ec         | 90 ++++++++++++++++++++++++++++++++++++++++++++
> include/hw/ide/pci=2Eh |  1 +
> 2 files changed, 91 insertions(+)
>
>diff --git a/hw/ide/pci=2Ec b/hw/ide/pci=2Ec
>index a25b352537=2E=2E9eb30af632 100644
>--- a/hw/ide/pci=2Ec
>+++ b/hw/ide/pci=2Ec
>@@ -104,6 +104,96 @@ const MemoryRegionOps pci_ide_data_le_ops =3D {
>     =2Eendianness =3D DEVICE_LITTLE_ENDIAN,
> };
>=20
>+static const MemoryRegionPortio ide_portio_list[] =3D {
>+    { 0, 8, 1, =2Eread =3D ide_ioport_read, =2Ewrite =3D ide_ioport_writ=
e },
>+    { 0, 1, 2, =2Eread =3D ide_data_readw, =2Ewrite =3D ide_data_writew =
},
>+    { 0, 1, 4, =2Eread =3D ide_data_readl, =2Ewrite =3D ide_data_writel =
},
>+    PORTIO_END_OF_LIST(),
>+};
>+
>+static const MemoryRegionPortio ide_portio2_list[] =3D {
>+    { 0, 1, 1, =2Eread =3D ide_status_read, =2Ewrite =3D ide_ctrl_write =
},
>+    PORTIO_END_OF_LIST(),
>+};
>+
>+void pci_ide_update_mode(PCIIDEState *s)
>+{
>+    PCIDevice *d =3D PCI_DEVICE(s);
>+    uint8_t mode =3D d->config[PCI_CLASS_PROG];
>+
>+    switch (mode) {

Maybe

  switch (mode & 0xf) {

here such that only the bits relevant to the PCI IDE controller specificat=
ion are analyzed? Then we can omit the high '8' nibble in the case labels w=
hich indicate bus master capability which is obviously out of scope of the =
switch statement (since you're not touching the BM DMA BAR)=2E

>+    case 0x8a:

Perhaps we could add a

  case 0x0:

in front of the above label for compatibility with PIIX-IDE? That way, thi=
s function could be reused in the future for resetting PIIX-IDE=2E

>+        /* Both channels legacy mode */
>+
>+        /* Zero BARs */
>+        pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x0);
>+        pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x0);
>+        pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x0);
>+        pci_set_long(d->config + PCI_BASE_ADDRESS_3, 0x0);
>+
>+        /* Clear interrupt pin */
>+        pci_config_set_interrupt_pin(d->config, 0);

Do we really need to toggle the interrupt pin in this function? Or is this=
 VIA-specific? This byte isn't even defined for PIIX-IDE=2E

Best regards,
Bernhard

>+
>+        /* Add legacy IDE ports */
>+        if (!s->bus[0]=2Eportio_list=2Eowner) {
>+            portio_list_init(&s->bus[0]=2Eportio_list, OBJECT(d),
>+                             ide_portio_list, &s->bus[0], "ide");
>+            portio_list_add(&s->bus[0]=2Eportio_list,
>+                            pci_address_space_io(d), 0x1f0);
>+        }
>+
>+        if (!s->bus[0]=2Eportio2_list=2Eowner) {
>+            portio_list_init(&s->bus[0]=2Eportio2_list, OBJECT(d),
>+                             ide_portio2_list, &s->bus[0], "ide");
>+            portio_list_add(&s->bus[0]=2Eportio2_list,
>+                            pci_address_space_io(d), 0x3f6);
>+        }
>+
>+        if (!s->bus[1]=2Eportio_list=2Eowner) {
>+            portio_list_init(&s->bus[1]=2Eportio_list, OBJECT(d),
>+                                ide_portio_list, &s->bus[1], "ide");
>+            portio_list_add(&s->bus[1]=2Eportio_list,
>+                            pci_address_space_io(d), 0x170);
>+        }
>+
>+        if (!s->bus[1]=2Eportio2_list=2Eowner) {
>+            portio_list_init(&s->bus[1]=2Eportio2_list, OBJECT(d),
>+                             ide_portio2_list, &s->bus[1], "ide");
>+            portio_list_add(&s->bus[1]=2Eportio2_list,
>+                            pci_address_space_io(d), 0x376);
>+        }
>+        break;
>+
>+    case 0x8f:
>+        /* Both channels native mode */
>+
>+        /* Set interrupt pin */
>+        pci_config_set_interrupt_pin(d->config, 1);
>+
>+        /* Remove legacy IDE ports */
>+        if (s->bus[0]=2Eportio_list=2Eowner) {
>+            portio_list_del(&s->bus[0]=2Eportio_list);
>+            portio_list_destroy(&s->bus[0]=2Eportio_list);
>+        }
>+
>+        if (s->bus[0]=2Eportio2_list=2Eowner) {
>+            portio_list_del(&s->bus[0]=2Eportio2_list);
>+            portio_list_destroy(&s->bus[0]=2Eportio2_list);
>+        }
>+
>+        if (s->bus[1]=2Eportio_list=2Eowner) {
>+            portio_list_del(&s->bus[1]=2Eportio_list);
>+            portio_list_destroy(&s->bus[1]=2Eportio_list);
>+        }
>+
>+        if (s->bus[1]=2Eportio2_list=2Eowner) {
>+            portio_list_del(&s->bus[1]=2Eportio2_list);
>+            portio_list_destroy(&s->bus[1]=2Eportio2_list);
>+        }
>+        break;
>+    }
>+}
>+
> static IDEState *bmdma_active_if(BMDMAState *bmdma)
> {
>     assert(bmdma->bus->retry_unit !=3D (uint8_t)-1);
>diff --git a/include/hw/ide/pci=2Eh b/include/hw/ide/pci=2Eh
>index 1ff469de87=2E=2Ea814a0a7c3 100644
>--- a/include/hw/ide/pci=2Eh
>+++ b/include/hw/ide/pci=2Eh
>@@ -61,6 +61,7 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val);
> void bmdma_status_writeb(BMDMAState *bm, uint32_t val);
> extern MemoryRegionOps bmdma_addr_ioport_ops;
> void pci_ide_create_devs(PCIDevice *dev);
>+void pci_ide_update_mode(PCIIDEState *s);
>=20
> extern const VMStateDescription vmstate_ide_pci;
> extern const MemoryRegionOps pci_ide_cmd_le_ops;

