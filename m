Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D234755EB7
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 10:47:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLJs9-0002Ux-1E; Mon, 17 Jul 2023 04:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qLJs7-0002Uf-2K; Mon, 17 Jul 2023 04:46:23 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qLJs5-0002Kz-CJ; Mon, 17 Jul 2023 04:46:22 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-993d1f899d7so616371466b.2; 
 Mon, 17 Jul 2023 01:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689583579; x=1692175579;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ntDOvp0hLY7wfCpnc75OMF0QQc4nvfu9CJfPGufUB/k=;
 b=nt+7G03U+9oSZAV6s5e2UoyM3zN/ZOQVaSZgAYQNYomfOo1g5Juxr3GcmvujpWDZMy
 HQgJZT+CLPpb7/lkh+jA92wp5JptDT4QCs1Ae93bAWpr/6XIRo4tcnTLeKqRfxaAf7us
 hSzKfAksfucnWWnd6fq2A4hzCb64Fe+6dObVRSxg+4qedEtrXpv+BUCVmQJogtU6OHHv
 6DLknEkU2/XbWlZZLU0RlWbAX03i0sKhMhdXn/9339oJ3JIxzJ6iUTNIA/OiDsK3t5Iu
 mAOcJFybwG1sRF0rMuyb9Fq5uLOSKHFGWHC2RGOL0pDuDSs6N1G8B/9xvRR17nM5MXGF
 qwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689583579; x=1692175579;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ntDOvp0hLY7wfCpnc75OMF0QQc4nvfu9CJfPGufUB/k=;
 b=WRtkS52y9mw0J4B1zcqVkd6zdvPSOhj/A4v7viManKKLut+qPOhizxs8dppKo/vlR3
 MQsabQJ9v7I6YnJWS6p3pZUcJ+jElWeMukMVlnJhGuLzunraxVzIIm0xnsoS06s0vPmu
 BDYlU361uJL964p2sH7xk3eQwL0K+hcAMUpuZnqqMJ71Z9YxMEJCaWFHaOVnof+7WlSD
 erJWi2nnpGmHWmwbV0ZKq7btpjxl8l2ftyJXfAbgmlVDGFENL1Spdl0V28HGpPqER3vz
 IpNEfCyucN0beAK9Y+K9WmxS2pI7+cJ23Le3A/8zSn7BmSFmkkVyzGHNuOTLzE+XQTCi
 WxzA==
X-Gm-Message-State: ABy/qLbCLkANo/Qm6vtB5ofLvmXtMpfwMGkFZn5197P3pgLaYVNhL86/
 WsGv+2GmiqKlBaccxU0CRXc=
X-Google-Smtp-Source: APBJJlGmZZiHvmKxJvLShSQ/OjmHTEJ4xoyNbduYbbyHs3vZK+sLdsEPW6llNyMvVBmUjkWF8GIsyw==
X-Received: by 2002:a17:906:5e:b0:994:554b:7f27 with SMTP id
 30-20020a170906005e00b00994554b7f27mr7411039ejg.2.1689583578932; 
 Mon, 17 Jul 2023 01:46:18 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 l9-20020a170906230900b0099342c87775sm8937245eja.20.2023.07.17.01.46.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 01:46:18 -0700 (PDT)
Date: Mon, 17 Jul 2023 08:46:16 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Olaf Hering <olaf@aepfle.de>, Paolo Bonzini <pbonzini@redhat.com>
CC: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Lev Kujawski <lkujaw@member.fsf.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] hw/ide/piix: properly initialize the BMIBA register
In-Reply-To: <20230705120121.4f353ba6.olaf@aepfle.de>
References: <20230701174659.10246-1-olaf@aepfle.de>
 <62EDA748-11A3-473F-913D-F9464335A382@gmail.com>
 <20230703095929.6e793dcf.olaf@aepfle.de>
 <93902CB6-7A6E-49E5-A55F-432C6B4BC00F@gmail.com>
 <dded4d33-d64f-9369-0742-a57a1e173153@redhat.com>
 <20230705120121.4f353ba6.olaf@aepfle.de>
Message-ID: <DA75E02A-FAB3-4262-90B6-37A213ACFA47@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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



Am 5=2E Juli 2023 10:01:21 UTC schrieb Olaf Hering <olaf@aepfle=2Ede>:
>Tue, 4 Jul 2023 08:38:33 +0200 Paolo Bonzini <pbonzini@redhat=2Ecom>:
>
>> I agree that calling pci_device_reset() would be a better match for=20
>> pci_xen_ide_unplug()=2E
>
>This change works as well:
>
>--- a/hw/i386/xen/xen_platform=2Ec
>+++ b/hw/i386/xen/xen_platform=2Ec
>@@ -164,8 +164,9 @@ static void pci_unplug_nics(PCIBus *bus)
>  *
>  * [1] https://xenbits=2Exen=2Eorg/gitweb/?p=3Dxen=2Egit;a=3Dblob;f=3Ddo=
cs/misc/hvm-emulated-unplug=2Epandoc
>  */
>-static void pci_xen_ide_unplug(DeviceState *dev, bool aux)
>+static void pci_xen_ide_unplug(PCIDevice *d, bool aux)
> {
>+    DeviceState *dev =3D DEVICE(d);
>     PCIIDEState *pci_ide;
>     int i;
>     IDEDevice *idedev;
>@@ -195,7 +196,7 @@ static void pci_xen_ide_unplug(DeviceState *dev, bool=
 aux)
>             blk_unref(blk);
>         }
>     }
>-    device_cold_reset(dev);
>+    pci_device_reset(d);
> }
>=20
> static void unplug_disks(PCIBus *b, PCIDevice *d, void *opaque)
>@@ -210,7 +211,7 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, voi=
d *opaque)
>=20
>     switch (pci_get_word(d->config + PCI_CLASS_DEVICE)) {
>     case PCI_CLASS_STORAGE_IDE:
>-        pci_xen_ide_unplug(DEVICE(d), aux);
>+        pci_xen_ide_unplug(d, aux);
>         break;
>=20
>     case PCI_CLASS_STORAGE_SCSI:

Hi Olaf,

Would you mind sending this patch as well? The PIIX fix alone just fixes t=
he syptom, not the underlying problem=2E The underlying problem is that the=
 BAR isn't deactivated, and with the PIIX patch it will stay at address zer=
o rather than in the USB function address range=2E

I think this patch should ideally land in 8=2E1, and IIUC bug fixes are st=
ill accepted for it=2E

Best regards,
Bernhard

>--- a/hw/ide/piix=2Ec
>+++ b/hw/ide/piix=2Ec
>@@ -118,7 +118,6 @@ static void piix_ide_reset(DeviceState *dev)
>     pci_set_word(pci_conf + PCI_COMMAND, 0x0000);
>     pci_set_word(pci_conf + PCI_STATUS,
>                  PCI_STATUS_DEVSEL_MEDIUM | PCI_STATUS_FAST_BACK);
>-    pci_set_byte(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */
> }
>=20
> static bool pci_piix_init_bus(PCIIDEState *d, unsigned i, Error **errp)
>
>
>Olaf

