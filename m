Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7050074904A
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 23:53:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHAQA-0006Ee-Ei; Wed, 05 Jul 2023 17:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qHAQ8-0006CT-2x; Wed, 05 Jul 2023 17:52:20 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qHAQ6-0008OI-1d; Wed, 05 Jul 2023 17:52:19 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-313f3a6db22so8143842f8f.3; 
 Wed, 05 Jul 2023 14:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688593936; x=1691185936;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJFMedWlKTyOeWNPiP/B80aG4j9davYW0IAez2buqhA=;
 b=rkwQITE4R6sww5tVR5pG72lECjHlHXawTsexqL23TADbxL4pTW/cVOjeDfIOa57aLb
 E0BDemB8yF0hQdkDcNzUkb1OAqAbb7ePFdSG+P49U36Rkeo9VDfCgCxXmpOuogkQe6Ah
 s/SGQn4qFMMv8sTk8lu//uzvf57K3MSOq1meMretIZbSpZWHHONcC9FnIyhu9XGDNPed
 VddQcUv+S6BNNSxrdA8muVpad3WKCwFP7JpR2m5RIjH90Tj3p7jgJO6iEXJsh/I3rgWU
 x08OR/+Rz038pbEmNlXWHwuJmbEZ9rwJRuMtDe8YCf6l5zAP3YZL4xbYaOD3queZ9ls8
 5bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688593936; x=1691185936;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJFMedWlKTyOeWNPiP/B80aG4j9davYW0IAez2buqhA=;
 b=OZ4kFcJS3LxIN1uQ/jCCEvyjMFdRriKzGk2KPLUuzLIgffST7NQyTUuLWDFcA3Uazk
 6LLU0P3mGLtYvi3XAZ4B2HczhxKfsc4CRqOByZgH6icFuzC8TCo0OMoMfnnElVR9iKgi
 qtbs9SQzITPNs5mxoKtjJoaaCGjH6i4EcGkTwmN7143w78NNc4XSKZZQPQFZTERZXiOh
 dg+ZtS4B63G8qMcDeogGtsu6KZKaFK9tr/C/N88VzmDnI4mRrda0Uj78TQhbDjbbKL5G
 /ESoodm92d+LTJNSsigxGGXwBXktT27rx3GSHdJB4UgEHfUGBAje1KjB0FiBJzyviBE+
 lp2g==
X-Gm-Message-State: ABy/qLaX6t1zLyDa8r7ve5VuHK1oZVcSoPyZxAz4/fZZPE6LkpKAxZKf
 oL/kdDikyi9+SMjazD+TSrw=
X-Google-Smtp-Source: APBJJlHk6NQ7YMrzLxOxfabGiKqAyMoCs/2S/6gDwhx9aFpqwuHXohRPex3OimrF17pWKB0lemh57g==
X-Received: by 2002:adf:e40d:0:b0:314:13e2:2f78 with SMTP id
 g13-20020adfe40d000000b0031413e22f78mr15480469wrm.44.1688593935563; 
 Wed, 05 Jul 2023 14:52:15 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-052-236.77.11.pool.telefonica.de.
 [77.11.52.236]) by smtp.gmail.com with ESMTPSA id
 y18-20020adff152000000b003141a3c4353sm93101wro.30.2023.07.05.14.52.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 14:52:15 -0700 (PDT)
Date: Wed, 05 Jul 2023 21:52:05 +0000
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
Message-ID: <3FF0EBC1-F1F8-4D1D-91DC-904DB287C887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42b.google.com
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

Nice!

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
>--- a/hw/ide/piix=2Ec
>+++ b/hw/ide/piix=2Ec
>@@ -118,7 +118,6 @@ static void piix_ide_reset(DeviceState *dev)
>     pci_set_word(pci_conf + PCI_COMMAND, 0x0000);
>     pci_set_word(pci_conf + PCI_STATUS,
>                  PCI_STATUS_DEVSEL_MEDIUM | PCI_STATUS_FAST_BACK);
>-    pci_set_byte(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */

I wonder if we should fix this line rather than dropping it=2E pci_device_=
reset() calls pci_reset_regions() which unconditionally clears all BARs to =
zero=2E While that works for PIIX IDE the VIA IDE device model intends to s=
et BARs to the IDE compatibility addresses during reset but pci_reset_regio=
ns() overwrites it with zeroes again=2E So I wonder if pci_reset_regions() =
should be dropped such that pci_update_mappings() resets the BARs to whatev=
er they were set in reset=2E

Of course this won't be an easy change but I wonder if it was more correct=
, especially since there seems to be no way to have the device model have t=
he last word=2E Any opinions/suggestions?

Thanks,
Bernhard

> }
>=20
> static bool pci_piix_init_bus(PCIIDEState *d, unsigned i, Error **errp)
>
>
>Olaf

