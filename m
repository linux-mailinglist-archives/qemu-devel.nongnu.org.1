Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E0B7396ED
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 07:41:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCD3p-00026t-6M; Thu, 22 Jun 2023 01:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qCD3m-00026T-L8
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 01:40:46 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qCD3k-0006mx-Lm
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 01:40:46 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f8792d2e86so4483262e87.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 22:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687412442; x=1690004442;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z5xLOgxc5yMmFB/xqkfPkgAUKFtQLoPEIBnqwRG9wrE=;
 b=jYm+kmGqKaSQjS88IKrNZ+9qWwZb4bzsJzZE5oCs8oJ5udAJqOKgvF4np3iAz35QlO
 opBvnyjViyJaO1Jae0oL5TCzc9oieIbUCytZUMTdC7Mk4FPfPBAyetS08ZFB94dsyK8q
 IIAi9NPtf3BMvq2X/eiOhb3RGW6vkt4vdHDlbzomGPDEEzb40pgNWwvxYlWFl/up77ip
 zssrlwrl1fRVcHpERrVb4f/O7zH3YX4f4vfSiZi7bgNQ+TjQZfZs1Ew+5pEQrMqeV3qk
 nprdgpvFwuFRXdAE2Nx/aJbSuGUJfgKpd4dRCpU2+1jmRQx2AObP5n4nnm2R+fhavt78
 6A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687412442; x=1690004442;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z5xLOgxc5yMmFB/xqkfPkgAUKFtQLoPEIBnqwRG9wrE=;
 b=Jg+wqH7tHoNPWiJ4BlCHhCR4g9lHgIgZNPoIQoHt7qK3N+ahoE8djamoDADrSOFidX
 x0bv+Y3Dxtcbvd3K1SXkuWP8JfYUWJC1wG/hjPHg3IY2UE8BSD4piMvX3WDbqpaz4vUP
 g3R7MVGfHopcCJwTD0Zidik7NHD6LRnHFytK+wBr+8bdX03OuPI7OTDYDspIFESuPYpk
 4WlHX599xGOBbXHeRsqdrguX/Zab0vbliJHKkvHPZUBXZE1JYSCm6SYoI5YiFxtkZPsG
 HFPmasNB6utuPJJEcLbLTROPgAHOyf8pjTbaekI1FhDIn8DlpAPOtkgMUrXx5bE4sLtP
 Rapg==
X-Gm-Message-State: AC+VfDws1Oxb5n0nzPMgb9eifs7gZ19s5RfgrS8FLkZJyP0mOC6+Rgo6
 kXGgEEmMqdT/daD7BYJ/NeQic3n8DDU=
X-Google-Smtp-Source: ACHHUZ5gW7KeklYhgZOV3gDoeY9HwOEt6afLaSv7fml+weuZZE2JHhoRm1bGUB6n/dPmb4JnYQam3g==
X-Received: by 2002:a19:9151:0:b0:4f8:6b82:56c4 with SMTP id
 y17-20020a199151000000b004f86b8256c4mr7278192lfj.33.1687412441768; 
 Wed, 21 Jun 2023 22:40:41 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-235-040.77.191.pool.telefonica.de.
 [77.191.235.40]) by smtp.gmail.com with ESMTPSA id
 d22-20020a1c7316000000b003f80946116dsm17773724wmb.45.2023.06.21.22.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 22:40:41 -0700 (PDT)
Date: Thu, 22 Jun 2023 05:40:36 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Joel Upham <jupham125@gmail.com>
CC: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 20/23] xen platform: unplug ahci object
In-Reply-To: <9b8183903cbf20db4e2f0dafda9e0ed271a86a8e.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
 <9b8183903cbf20db4e2f0dafda9e0ed271a86a8e.1687278381.git.jupham125@gmail.com>
Message-ID: <CB4239A2-8502-406A-A594-3065C0D3B104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x132.google.com
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



Am 20=2E Juni 2023 17:24:54 UTC schrieb Joel Upham <jupham125@gmail=2Ecom>=
:
>This will unplug the ahci device when the Xen driver calls for an unplug=
=2E
>This has been tested to work in linux and Windows guests=2E
>When q35 is detected, we will remove the ahci controller
>with the hard disks=2E  In the libxl config, cdrom devices
>are put on a seperate ahci controller=2E This allows for 6 cdrom
>devices to be added, and 6 qemu hard disks=2E

Does this also work with KVM Xen emulation? If so, the QEMU manual should =
be updated accordingly in this patch since it explicitly rules out Q35 due =
to missing AHCI unplug: https://gitlab=2Ecom/qemu-project/qemu/-/blob/stabl=
e-8=2E0/docs/system/i386/xen=2Erst?plain=3D1&ref_type=3Dheads#L51

Best regards,
Bernhard

>
>
>Signed-off-by: Joel Upham <jupham125@gmail=2Ecom>
>---
> hw/i386/xen/xen_platform=2Ec | 19 ++++++++++++++++++-
> hw/pci/pci=2Ec               | 17 +++++++++++++++++
> include/hw/pci/pci=2Eh       |  3 +++
> 3 files changed, 38 insertions(+), 1 deletion(-)
>
>diff --git a/hw/i386/xen/xen_platform=2Ec b/hw/i386/xen/xen_platform=2Ec
>index 57f1d742c1=2E=2E0375337222 100644
>--- a/hw/i386/xen/xen_platform=2Ec
>+++ b/hw/i386/xen/xen_platform=2Ec
>@@ -34,6 +34,7 @@
> #include "sysemu/block-backend=2Eh"
> #include "qemu/error-report=2Eh"
> #include "qemu/module=2Eh"
>+#include "include/hw/i386/pc=2Eh"
> #include "qom/object=2Eh"
>=20
> #ifdef CONFIG_XEN
>@@ -223,6 +224,12 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, vo=
id *opaque)
>         if (flags & UNPLUG_NVME_DISKS) {
>             object_unparent(OBJECT(d));
>         }
>+        break;
>+
>+    case PCI_CLASS_STORAGE_SATA:
>+	if (!aux) {
>+            object_unparent(OBJECT(d));
>+        }
>=20
>     default:
>         break;
>@@ -231,7 +238,17 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, vo=
id *opaque)
>=20
> static void pci_unplug_disks(PCIBus *bus, uint32_t flags)
> {
>-    pci_for_each_device(bus, 0, unplug_disks, &flags);
>+    PCIBus *q35 =3D find_q35();
>+    if (q35) {
>+        /* When q35 is detected, we will remove the ahci controller
>+	 * with the hard disks=2E  In the libxl config, cdrom devices
>+	 * are put on a seperate ahci controller=2E This allows for 6 cdrom
>+	 * devices to be added, and 6 qemu hard disks=2E
>+	 */
>+        pci_function_for_one_bus(bus, unplug_disks, &flags);
>+    } else {
>+        pci_for_each_device(bus, 0, unplug_disks, &flags);
>+    }
> }
>=20
> static void platform_fixed_ioport_writew(void *opaque, uint32_t addr, ui=
nt32_t val)
>diff --git a/hw/pci/pci=2Ec b/hw/pci/pci=2Ec
>index 1cc7c89036=2E=2E8eac3d751a 100644
>--- a/hw/pci/pci=2Ec
>+++ b/hw/pci/pci=2Ec
>@@ -1815,6 +1815,23 @@ void pci_for_each_device_reverse(PCIBus *bus, int =
bus_num,
>     }
> }
>=20
>+void pci_function_for_one_bus(PCIBus *bus,
>+                          void (*fn)(PCIBus *b, PCIDevice *d, void *opaq=
ue),
>+                          void *opaque)
>+{
>+    bus =3D pci_find_bus_nr(bus, 0);
>+
>+    if (bus) {
>+        PCIDevice *d;
>+
>+        d =3D bus->devices[PCI_DEVFN(4,0)];
>+        if (d) {
>+            fn(bus, d, opaque);
>+            return;
>+        }
>+    }
>+}
>+
> void pci_for_each_device_under_bus(PCIBus *bus,
>                                    pci_bus_dev_fn fn, void *opaque)
> {
>diff --git a/include/hw/pci/pci=2Eh b/include/hw/pci/pci=2Eh
>index e6d0574a29=2E=2Ec53e21082a 100644
>--- a/include/hw/pci/pci=2Eh
>+++ b/include/hw/pci/pci=2Eh
>@@ -343,6 +343,9 @@ void pci_for_each_device_under_bus(PCIBus *bus,
> void pci_for_each_device_under_bus_reverse(PCIBus *bus,
>                                            pci_bus_dev_fn fn,
>                                            void *opaque);
>+void pci_function_for_one_bus(PCIBus *bus,
>+                         void (*fn)(PCIBus *bus, PCIDevice *d, void *opa=
que),
>+                         void *opaque);
> void pci_for_each_bus_depth_first(PCIBus *bus, pci_bus_ret_fn begin,
>                                   pci_bus_fn end, void *parent_state);
> PCIDevice *pci_get_function_0(PCIDevice *pci_dev);

