Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3084672CF7A
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 21:29:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8nDc-0002r4-1H; Mon, 12 Jun 2023 15:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8nDZ-0002qZ-49; Mon, 12 Jun 2023 15:28:45 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8nDX-0005Dr-8t; Mon, 12 Jun 2023 15:28:44 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-977cf86aae5so714772366b.0; 
 Mon, 12 Jun 2023 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686598121; x=1689190121;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=DH16SfYFY8IjvNcuqvmo8wUbyGuUuzILOHNooHtafpE=;
 b=PKekMdAft+0VRUE6dLMDzwTgMWKoowDwe7Nv4IGB4YAvEEwbMnaYVEiH3brao1fuJE
 G2O9LtSSMY7/IGvsjAgusidKk7jJ8Gmfr4jsiXoz64W8/hlQaJCyk11olqv/blJEcJV6
 KUvtBoRH0RwN1HWWrECNUy/jXD8OTxGvnECI6eFNNEQ0zBhF62PVPd5heLNztbXOK0dn
 IdgmEU7rehJEBgm36K3cqgMAASrZ8BePbDPsiAWKVGhB102H/JmzUlWmOidBLDbl53se
 9sZEpzG6ZX+dupnfrpXlZbd8xbVgB/j2Z0zRGjhiIU6u9zLDXGTXHdpagiIzqtp5W7jj
 1uSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686598121; x=1689190121;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DH16SfYFY8IjvNcuqvmo8wUbyGuUuzILOHNooHtafpE=;
 b=ewgCX3re9jLBQaS4vjcdTWdYxA9Q8IWRUEBa8Vmruurw2w/AhGs7CHNeUAuNrz1qBK
 Oz5PEgloLefLyGCou2sm7rml/51L2aBD3Ab/pTWdaHXDXEHIucCth8DnwJkS98Vov8iO
 nISDMKZw9F5h9AaIhiCBnJZpABCt+6OA1Ew3ayvojaAHJrbURpFK/rRMXJKzVZjLHPby
 MfZt4CplmICdG4k3o53kR/xIHMfc3F6a35yJ5dBwa0mwtSgxWQgiMLvuW1VPBJuKaYzJ
 UHuno7seGZr8IbWY2EQXyDnT5xkDQann+6RI2PgQ/f7RzxxqvfY298DyDoMxHT/KKd+9
 lDCA==
X-Gm-Message-State: AC+VfDwCBwXMq/3eS0rDqccWMCf1iUq3nud4pWesEzhOdKclUHhVLzB6
 fxCC7fAcbmIVNcEvDnxl/OE=
X-Google-Smtp-Source: ACHHUZ6wKoiZnKVgNgpWvqFFChQ0cx62B6DShJYUklsBiXWLkDN9odNjE9SHJbObmFbzXJTsBBhwiw==
X-Received: by 2002:a17:906:eec1:b0:977:4b68:bf2 with SMTP id
 wu1-20020a170906eec100b009774b680bf2mr8466812ejb.54.1686598120439; 
 Mon, 12 Jun 2023 12:28:40 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-123-197.77.13.pool.telefonica.de.
 [77.13.123.197]) by smtp.gmail.com with ESMTPSA id
 b8-20020a170906194800b009750b9ff97asm5558586eje.55.2023.06.12.12.28.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 12:28:40 -0700 (PDT)
Date: Mon, 12 Jun 2023 19:28:35 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_5/5=5D_cmd646=3A_move_device-specifi?=
 =?US-ASCII?Q?c_BMDMA_registers_to_separate_memory_region?=
In-Reply-To: <20230609185119.691152-6-mark.cave-ayland@ilande.co.uk>
References: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
 <20230609185119.691152-6-mark.cave-ayland@ilande.co.uk>
Message-ID: <76F6648A-47D8-4975-8344-93BE5DD6A071@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 9=2E Juni 2023 18:51:19 UTC schrieb Mark Cave-Ayland <mark=2Ecave-aylan=
d@ilande=2Eco=2Euk>:
>The aim here is to eliminate any device-specific registers from the main =
BMDMA
>bar memory region so it can potentially be moved into the shared PCI IDE =
device=2E
>
>For each BMDMA bus create a new cmd646-bmdma-specific memory region repre=
senting
>the device-specific BMDMA registers and then map them using aliases onto =
the
>existing BMDMAState memory region=2E
>
>Signed-off-by: Mark Cave-Ayland <mark=2Ecave-ayland@ilande=2Eco=2Euk>
>---
> hw/ide/cmd646=2Ec         | 111 +++++++++++++++++++++++++++++++---------
> include/hw/ide/cmd646=2Eh |   4 ++
> 2 files changed, 90 insertions(+), 25 deletions(-)
>
>diff --git a/hw/ide/cmd646=2Ec b/hw/ide/cmd646=2Ec
>index 9103da581f=2E=2Edd495f2e1b 100644
>--- a/hw/ide/cmd646=2Ec
>+++ b/hw/ide/cmd646=2Ec
>@@ -90,7 +90,6 @@ static uint64_t bmdma_read(void *opaque, hwaddr addr,
>                            unsigned size)
> {
>     BMDMAState *bm =3D opaque;
>-    PCIDevice *pci_dev =3D PCI_DEVICE(bm->pci_dev);
>     uint32_t val;
>=20
>     if (size !=3D 1) {
>@@ -101,19 +100,9 @@ static uint64_t bmdma_read(void *opaque, hwaddr addr=
,
>     case 0:
>         val =3D bm->cmd;
>         break;
>-    case 1:
>-        val =3D pci_dev->config[MRDMODE];
>-        break;
>     case 2:
>         val =3D bm->status;
>         break;
>-    case 3:
>-        if (bm =3D=3D &bm->pci_dev->bmdma[0]) {
>-            val =3D pci_dev->config[UDIDETCR0];
>-        } else {
>-            val =3D pci_dev->config[UDIDETCR1];
>-        }
>-        break;
>     default:
>         val =3D 0xff;
>         break;
>@@ -127,7 +116,6 @@ static void bmdma_write(void *opaque, hwaddr addr,
>                         uint64_t val, unsigned size)
> {
>     BMDMAState *bm =3D opaque;
>-    PCIDevice *pci_dev =3D PCI_DEVICE(bm->pci_dev);
>=20
>     if (size !=3D 1) {
>         return;
>@@ -138,23 +126,10 @@ static void bmdma_write(void *opaque, hwaddr addr,
>     case 0:
>         bmdma_cmd_writeb(bm, val);
>         break;
>-    case 1:
>-        pci_dev->config[MRDMODE] =3D
>-            (pci_dev->config[MRDMODE] & ~0x30) | (val & 0x30);
>-        cmd646_update_dma_interrupts(pci_dev);
>-        cmd646_update_irq(pci_dev);
>-        break;
>     case 2:
>         bm->status =3D (val & 0x60) | (bm->status & 1) |
>                      (bm->status & ~val & 0x06);
>         break;
>-    case 3:
>-        if (bm =3D=3D &bm->pci_dev->bmdma[0]) {
>-            pci_dev->config[UDIDETCR0] =3D val;
>-        } else {
>-            pci_dev->config[UDIDETCR1] =3D val;
>-        }
>-        break;
>     }
> }
>=20
>@@ -181,6 +156,91 @@ static void bmdma_setup_bar(PCIIDEState *d)
>     }
> }
>=20
>+static uint64_t cmd646_bmdma_read(void *opaque, hwaddr addr, unsigned si=
ze)
>+{
>+    BMDMAState *bm =3D opaque;
>+    PCIDevice *pci_dev =3D PCI_DEVICE(bm->pci_dev);
>+    uint32_t val;
>+
>+    if (size !=3D 1) {
>+        return ((uint64_t)1 << (size * 8)) - 1;
>+    }
>+
>+    switch (addr & 3) {
>+    case 1:
>+        val =3D pci_dev->config[MRDMODE];
>+        break;
>+    case 3:
>+        if (bm =3D=3D &bm->pci_dev->bmdma[0]) {
>+            val =3D pci_dev->config[UDIDETCR0];
>+        } else {
>+            val =3D pci_dev->config[UDIDETCR1];
>+        }
>+        break;
>+    default:
>+        val =3D 0xff;
>+        break;
>+    }
>+
>+    trace_bmdma_read_cmd646(addr, val);
>+    return val;
>+}
>+
>+static void cmd646_bmdma_write(void *opaque, hwaddr addr, uint64_t val,
>+                               unsigned size)
>+{
>+    BMDMAState *bm =3D opaque;
>+    PCIDevice *pci_dev =3D PCI_DEVICE(bm->pci_dev);
>+
>+    if (size !=3D 1) {
>+        return;
>+    }
>+
>+    trace_bmdma_write_cmd646(addr, val);
>+    switch (addr & 3) {
>+    case 1:
>+        pci_dev->config[MRDMODE] =3D
>+            (pci_dev->config[MRDMODE] & ~0x30) | (val & 0x30);
>+        cmd646_update_dma_interrupts(pci_dev);
>+        cmd646_update_irq(pci_dev);
>+        break;
>+    case 3:
>+        if (bm =3D=3D &bm->pci_dev->bmdma[0]) {
>+            pci_dev->config[UDIDETCR0] =3D val;
>+        } else {
>+            pci_dev->config[UDIDETCR1] =3D val;
>+        }
>+        break;
>+    }
>+}
>+
>+static const MemoryRegionOps cmd646_bmdma_ops =3D {
>+    =2Eread =3D cmd646_bmdma_read,
>+    =2Ewrite =3D cmd646_bmdma_write,
>+};
>+
>+static void cmd646_bmdma_setup(PCIIDEState *d)
>+{
>+    CMD646IDEState *s =3D CMD646_IDE(d);
>+    BMDMAState *bm;
>+    int i;
>+
>+    /* Setup aliases for device-specific BMDMA registers */
>+    for (i =3D 0; i < 2; i++) {

I'd use `ARRAY_SIZE()` instead of the hardcoded constant here=2E

>+        bm =3D &d->bmdma[i];
>+        memory_region_init_io(&s->bmdma_mem[i], OBJECT(d), &cmd646_bmdma=
_ops,
>+                              bm, "cmd646-bmdma", 4);
>+        memory_region_init_alias(&s->bmdma_mem_alias[i][0], OBJECT(d),
>+                                 "cmd646-bmdma[1]", &s->bmdma_mem[i], 0x=
1, 1);
>+        memory_region_add_subregion(&bm->extra_io, 0x1,
>+                                    &s->bmdma_mem_alias[i][0]);
>+        memory_region_init_alias(&s->bmdma_mem_alias[i][1], OBJECT(d),
>+                                 "cmd646-bmdma[3]", &s->bmdma_mem[i], 0x=
3, 1);
>+        memory_region_add_subregion(&bm->extra_io, 0x3,
>+                                    &s->bmdma_mem_alias[i][1]);
>+    }
>+}
>+
> static void cmd646_update_irq(PCIDevice *pd)
> {
>     int pci_level;
>@@ -289,6 +349,7 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Er=
ror **errp)
>=20
>     bmdma_setup_bar(d);
>     pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &d->bmdma_bar);
>+    cmd646_bmdma_setup(d);
>=20
>     /* TODO: RST# value should be 0 */
>     pci_conf[PCI_INTERRUPT_PIN] =3D 0x01; /* interrupt on pin 1 */
>diff --git a/include/hw/ide/cmd646=2Eh b/include/hw/ide/cmd646=2Eh
>index 4780b1132c=2E=2E5329964533 100644
>--- a/include/hw/ide/cmd646=2Eh
>+++ b/include/hw/ide/cmd646=2Eh
>@@ -29,10 +29,14 @@
> #define TYPE_CMD646_IDE "cmd646-ide"
> OBJECT_DECLARE_SIMPLE_TYPE(CMD646IDEState, CMD646_IDE)
>=20
>+#include "exec/memory=2Eh"
> #include "hw/ide/pci=2Eh"
>=20
> struct CMD646IDEState {
>     PCIIDEState parent_obj;
>+
>+    MemoryRegion bmdma_mem[2];
>+    MemoryRegion bmdma_mem_alias[2][2];

The added complexity of a two-dimensional alias array seems like a tough c=
all for me=2E I'm not totally against it but I'm reluctant=2E

Best regards,
Bernhard

> };
>=20
> #endif

