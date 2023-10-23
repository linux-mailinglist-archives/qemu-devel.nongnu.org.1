Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A167D40EA
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:34:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1bS-0000lu-Ge; Mon, 23 Oct 2023 16:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qv1bQ-0000l6-Fu; Mon, 23 Oct 2023 16:32:44 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qv1bM-0000xc-QQ; Mon, 23 Oct 2023 16:32:44 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99de884ad25so562906366b.3; 
 Mon, 23 Oct 2023 13:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698093158; x=1698697958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=mbO97fEp/nfIBF78REiS8BpB/odBmamqwB0+LNxxzQc=;
 b=d4gVot4bi3yLSUEOW2ibh9h5rM62cW8TMSdDZNkMWB8oi6pagIRoGptGIe1zqtwjTm
 tijuV9NdSgq5zntsoLbXLPLvBdlh08RDFEDKvcyVFI6l4Y4eCJ4X5gWRU1BybFUn5Ytk
 ESLGFj4deP57BcKUxYU0dBS1PmIPtVwLvjRYqs8K+igWnAbtgEvZL3SK832OsZ6XrkRW
 xONxXmuBXhuU8rZyInSOuQTYjDPcS3NrDVqAU+7V+X5oE9aJH3tN0tItKp9ZuvTeZ0+O
 lhnWN0CRWhRjbk2sv75eFx/Z8ATt8UihCdwKegTJ3bopdTNizjYVLB+QQA810ejCQ9Iw
 xiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698093158; x=1698697958;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mbO97fEp/nfIBF78REiS8BpB/odBmamqwB0+LNxxzQc=;
 b=ka20iXhbkJA7bUxS2myQwMnEOYEJKeAUmHbxOvb3IyDE/HKz9Gwlzkw8t6bnxxj7Xw
 ywJQcX+QgHvxVMu1bQEnqQIcK6NfbkAgTHoaTcQoa5X9IOZuqDbo5QCM77RWhjeMvz1u
 MFwBCkYzqgOTwj/USqzwOqZeg5evBT+koOxtwJOE7jmvJ8kvWsQH7UBHUe2Km7S7YdJH
 0L3V2AnYgTYV5eu8PJ6YpQW73KYJar8cA5s7qQlT/HF0VGOdzgjJUXYi2bAWIHH8Bqhn
 RPRMlu/ZBdrIjCIWHVXzovsx2DnefiegvpGmFfN50PbIquTjngQBL63igZtF5MPAjXrU
 wh/Q==
X-Gm-Message-State: AOJu0YzcpHcXJkEU1r+m5qFsezo+05l0N17ePajLCGWMbrTOr8ByVN/W
 uB3UcqCaKRKNIN8Ia2b1BOQ=
X-Google-Smtp-Source: AGHT+IGt9ndJuqrTlP9N017kXWQrD9daWK51TC/ws16ASlwp9fosR0AN8sdr4rP/QE0uG+MydkIwgQ==
X-Received: by 2002:a17:907:9618:b0:9af:4561:591d with SMTP id
 gb24-20020a170907961800b009af4561591dmr8001063ejc.18.1698093158282; 
 Mon, 23 Oct 2023 13:32:38 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-204-122.77.13.pool.telefonica.de.
 [77.13.204.122]) by smtp.gmail.com with ESMTPSA id
 b7-20020a1709062b4700b009ade1a4f795sm7001110ejg.168.2023.10.23.13.32.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 13:32:37 -0700 (PDT)
Date: Mon, 23 Oct 2023 17:19:16 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, balaton@eik.bme.hu,
 philmd@linaro.org
Subject: Re: [PATCH 1/2] ide/pci.c: introduce pci_ide_update_mode() function
In-Reply-To: <B2C0A4CE-0382-48F0-A513-8AD69960F2BF@gmail.com>
References: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
 <20231019130452.508426-2-mark.cave-ayland@ilande.co.uk>
 <B2C0A4CE-0382-48F0-A513-8AD69960F2BF@gmail.com>
Message-ID: <4C3F58DB-2AAA-43CA-8576-07CFBB66066D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 22=2E Oktober 2023 22:06:30 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>
>
>Am 19=2E Oktober 2023 13:04:51 UTC schrieb Mark Cave-Ayland <mark=2Ecave-=
ayland@ilande=2Eco=2Euk>:
>>This function reads the value of the PCI_CLASS_PROG register for PCI IDE
>>controllers and configures the PCI BARs and/or IDE ioports accordingly=
=2E
>>
>>In the case where we switch to legacy mode, the PCI BARs are set to retu=
rn zero
>>(as suggested in the "PCI IDE Controller" specification), the legacy IDE=
 ioports
>>are enabled, and the PCI interrupt pin cleared to indicate legacy IRQ ro=
uting=2E
>>
>>Conversely when we switch to native mode, the legacy IDE ioports are dis=
abled
>>and the PCI interrupt pin set to indicate native IRQ routing=2E The cont=
ents of
>>the PCI BARs are unspecified, but this is not an issue since if a PCI ID=
E
>>controller has been switched to native mode then its BARs will need to b=
e
>>programmed=2E
>>
>>Signed-off-by: Mark Cave-Ayland <mark=2Ecave-ayland@ilande=2Eco=2Euk>
>>---
>> hw/ide/pci=2Ec         | 90 +++++++++++++++++++++++++++++++++++++++++++=
+
>> include/hw/ide/pci=2Eh |  1 +
>> 2 files changed, 91 insertions(+)
>>
>>diff --git a/hw/ide/pci=2Ec b/hw/ide/pci=2Ec
>>index a25b352537=2E=2E9eb30af632 100644
>>--- a/hw/ide/pci=2Ec
>>+++ b/hw/ide/pci=2Ec
>>@@ -104,6 +104,96 @@ const MemoryRegionOps pci_ide_data_le_ops =3D {
>>     =2Eendianness =3D DEVICE_LITTLE_ENDIAN,
>> };
>>=20
>>+static const MemoryRegionPortio ide_portio_list[] =3D {
>>+    { 0, 8, 1, =2Eread =3D ide_ioport_read, =2Ewrite =3D ide_ioport_wri=
te },
>>+    { 0, 1, 2, =2Eread =3D ide_data_readw, =2Ewrite =3D ide_data_writew=
 },
>>+    { 0, 1, 4, =2Eread =3D ide_data_readl, =2Ewrite =3D ide_data_writel=
 },
>>+    PORTIO_END_OF_LIST(),
>>+};
>>+
>>+static const MemoryRegionPortio ide_portio2_list[] =3D {

Although the naming seems familiar: What about renaming both lists to some=
thing like ide_portio_primary_list resp=2E ide_portio_secondary_list? Havin=
g one list carrying a number in its name while omitting it for the other I =
find rather confusing=2E

Best regards,
Bernhard

>>+    { 0, 1, 1, =2Eread =3D ide_status_read, =2Ewrite =3D ide_ctrl_write=
 },
>>+    PORTIO_END_OF_LIST(),
>>+};
>>+
>>+void pci_ide_update_mode(PCIIDEState *s)
>>+{
>>+    PCIDevice *d =3D PCI_DEVICE(s);
>>+    uint8_t mode =3D d->config[PCI_CLASS_PROG];
>>+
>>+    switch (mode) {
>
>Maybe
>
>  switch (mode & 0xf) {
>
>here such that only the bits relevant to the PCI IDE controller specifica=
tion are analyzed? Then we can omit the high '8' nibble in the case labels =
which indicate bus master capability which is obviously out of scope of the=
 switch statement (since you're not touching the BM DMA BAR)=2E
>
>>+    case 0x8a:
>
>Perhaps we could add a
>
>  case 0x0:
>
>in front of the above label for compatibility with PIIX-IDE? That way, th=
is function could be reused in the future for resetting PIIX-IDE=2E
>
>>+        /* Both channels legacy mode */
>>+
>>+        /* Zero BARs */
>>+        pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x0);
>>+        pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x0);
>>+        pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x0);
>>+        pci_set_long(d->config + PCI_BASE_ADDRESS_3, 0x0);
>>+
>>+        /* Clear interrupt pin */
>>+        pci_config_set_interrupt_pin(d->config, 0);
>
>Do we really need to toggle the interrupt pin in this function? Or is thi=
s VIA-specific? This byte isn't even defined for PIIX-IDE=2E
>
>Best regards,
>Bernhard
>
>>+
>>+        /* Add legacy IDE ports */
>>+        if (!s->bus[0]=2Eportio_list=2Eowner) {
>>+            portio_list_init(&s->bus[0]=2Eportio_list, OBJECT(d),
>>+                             ide_portio_list, &s->bus[0], "ide");
>>+            portio_list_add(&s->bus[0]=2Eportio_list,
>>+                            pci_address_space_io(d), 0x1f0);
>>+        }
>>+
>>+        if (!s->bus[0]=2Eportio2_list=2Eowner) {
>>+            portio_list_init(&s->bus[0]=2Eportio2_list, OBJECT(d),
>>+                             ide_portio2_list, &s->bus[0], "ide");
>>+            portio_list_add(&s->bus[0]=2Eportio2_list,
>>+                            pci_address_space_io(d), 0x3f6);
>>+        }
>>+
>>+        if (!s->bus[1]=2Eportio_list=2Eowner) {
>>+            portio_list_init(&s->bus[1]=2Eportio_list, OBJECT(d),
>>+                                ide_portio_list, &s->bus[1], "ide");
>>+            portio_list_add(&s->bus[1]=2Eportio_list,
>>+                            pci_address_space_io(d), 0x170);
>>+        }
>>+
>>+        if (!s->bus[1]=2Eportio2_list=2Eowner) {
>>+            portio_list_init(&s->bus[1]=2Eportio2_list, OBJECT(d),
>>+                             ide_portio2_list, &s->bus[1], "ide");
>>+            portio_list_add(&s->bus[1]=2Eportio2_list,
>>+                            pci_address_space_io(d), 0x376);
>>+        }
>>+        break;
>>+
>>+    case 0x8f:
>>+        /* Both channels native mode */
>>+
>>+        /* Set interrupt pin */
>>+        pci_config_set_interrupt_pin(d->config, 1);
>>+
>>+        /* Remove legacy IDE ports */
>>+        if (s->bus[0]=2Eportio_list=2Eowner) {
>>+            portio_list_del(&s->bus[0]=2Eportio_list);
>>+            portio_list_destroy(&s->bus[0]=2Eportio_list);
>>+        }
>>+
>>+        if (s->bus[0]=2Eportio2_list=2Eowner) {
>>+            portio_list_del(&s->bus[0]=2Eportio2_list);
>>+            portio_list_destroy(&s->bus[0]=2Eportio2_list);
>>+        }
>>+
>>+        if (s->bus[1]=2Eportio_list=2Eowner) {
>>+            portio_list_del(&s->bus[1]=2Eportio_list);
>>+            portio_list_destroy(&s->bus[1]=2Eportio_list);
>>+        }
>>+
>>+        if (s->bus[1]=2Eportio2_list=2Eowner) {
>>+            portio_list_del(&s->bus[1]=2Eportio2_list);
>>+            portio_list_destroy(&s->bus[1]=2Eportio2_list);
>>+        }
>>+        break;
>>+    }
>>+}
>>+
>> static IDEState *bmdma_active_if(BMDMAState *bmdma)
>> {
>>     assert(bmdma->bus->retry_unit !=3D (uint8_t)-1);
>>diff --git a/include/hw/ide/pci=2Eh b/include/hw/ide/pci=2Eh
>>index 1ff469de87=2E=2Ea814a0a7c3 100644
>>--- a/include/hw/ide/pci=2Eh
>>+++ b/include/hw/ide/pci=2Eh
>>@@ -61,6 +61,7 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val);
>> void bmdma_status_writeb(BMDMAState *bm, uint32_t val);
>> extern MemoryRegionOps bmdma_addr_ioport_ops;
>> void pci_ide_create_devs(PCIDevice *dev);
>>+void pci_ide_update_mode(PCIIDEState *s);
>>=20
>> extern const VMStateDescription vmstate_ide_pci;
>> extern const MemoryRegionOps pci_ide_cmd_le_ops;

