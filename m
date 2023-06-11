Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 351BE72B164
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:35:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IOw-0006Pz-MG; Sun, 11 Jun 2023 06:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOu-0006Pa-LH
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:24 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOs-0008HY-SA
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:24 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9768fd99c0cso917563366b.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479661; x=1689071661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XfvsxvGHCekqdpJLuJr3JROZB0TPL4yZNaEjBQcNeKw=;
 b=PjPpbqheCCPWTg9sXH2kva5A9qTEwtwTwMgCsl0crC75jZK7yWZ0UeRuFPo5eYUbVw
 41d+1OE4Qn1n8VxnFtamWlsmgIic5qA43SOxCrWjLDVEXdviYOoYt2I3jl2oOzXv4f9G
 8rbLcsr1r7hA63XK0a60rBgnljRW9HTRnmaVwbHGnQ1cQbckANmqOE76xLSgIlBPmyrd
 /xSUcWsgH2ht0c3/bRNQg+GmHZizeIwhkFPr5wGqGsMET6gX9v2tzdTR28oK7lv+Q2Af
 bf8k13znEf1rpVZIzmkpZvVL0ZXY99KrmJ1K7IEI7gDW+hZQ2m5DPJ7s0ZvFfSUu4wXJ
 eifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479661; x=1689071661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XfvsxvGHCekqdpJLuJr3JROZB0TPL4yZNaEjBQcNeKw=;
 b=kSCmT+BiT67A4fpxBLBLcrUYLTDJAl4IDcUaoxdR8Fp3kN/OvWffDMVwMHK4Ok15dN
 rFbkleRm8A8Y7HQbe0qJUf3IbhcLSXYQ5HBxgLft1Aw/alR/g4bp2ik96Dt+KYjt2lJe
 W+qAGy48pIepOyPcKRcfRI2Z6V+xRJnWSt4WWrUWwaSOF4QJfnrlfetxg/lheUcQTpmx
 qgwOj6a0WAemSOj1QBhishwA3YjEouFXIV9lH3nwh76RDvhDMo+XOllQcKM95vLZetH/
 SwpjYWFtpOrhZkC5EaTHtWxGV1GxDDO91AfCxEJM5e5ARn2v1krlPkJ9ti6YESKor+Bm
 RE5g==
X-Gm-Message-State: AC+VfDyHKzYxGgtDprp9IRC5+NvJVYO6dKy6bb0aXV2dTlKN7L3RYVyr
 BhfhruoCbaMCG2MrR0drui3EzcDXbnQ=
X-Google-Smtp-Source: ACHHUZ46fn9Fw3VsigJzCzTR1VzTCPWsa04HsVbkLsadtUiuqVb86iOM95DAxWp8PqXNXwNftbmj9Q==
X-Received: by 2002:a17:907:c2a:b0:976:6824:ec76 with SMTP id
 ga42-20020a1709070c2a00b009766824ec76mr7740431ejc.11.1686479660419; 
 Sun, 11 Jun 2023 03:34:20 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:20 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 00/15] Q35 and I440FX host bridge QOM cleanup
Date: Sun, 11 Jun 2023 12:33:57 +0200
Message-ID: <20230611103412.12109-1-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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

This series resolves the legacy i440fx_init() function and instantiates the=
=0D
I440FX host bridge the QOM way. As a preparation the Q35 host bridge receiv=
es=0D
some cleanup as well.=0D
=0D
Most of the Q35 patches have been submitted under [1] before. This series=0D
incorporates only the changes making the two device models consistent with=
=0D
each other.=0D
=0D
The original plan of [1] was to clean up Q35 first and then submit a separa=
te=0D
follow-up I440FX QOM'ification series. This series takes a more direct appr=
oach=0D
by cutting down on the changes in both device models while still allowing b=
oth=0D
device models to be instantiated the same way. The remaining patches in [1]=
=0D
would still be doable.=0D
=0D
The series is structured as follows: The first 5 patches clean up Q35, the =
next=0D
patch massages Q35 to share its property names with I440FX. The rest of the=
=0D
series resolves i440fx_init().=0D
=0D
Tesging done:=0D
* `make check`=0D
* `make check-avocado`=0D
* Run `xl create` under Xen with the following config:=0D
    name =3D "Manjaro"=0D
    type =3D 'hvm'=0D
    memory =3D 1536=0D
    apic =3D 1=0D
    usb =3D 1=0D
    disk =3D [ "file:manjaro-kde-21.2.6-220416-linux515.iso,hdc:cdrom,r" ]=
=0D
    device_model_override =3D "/usr/bin/qemu-system-x86_64"=0D
    vga =3D "stdvga"=0D
    sdl =3D 1=0D
=0D
[1] https://patchew.org/QEMU/20230304152648.103749-1-shentey@gmail.com/=0D
=0D
Bernhard Beschow (15):=0D
  hw/i386/pc_q35: Resolve redundant q35_host variable=0D
  hw/pci-host/q35: Fix double, contradicting .endianness assignment=0D
  hw/pci-host/q35: Initialize PCMachineState::bus in board code=0D
  hw/pci/pci_host: Introduce PCI_HOST_BYPASS_IOMMU macro=0D
  hw/pci-host/q35: Initialize PCI_HOST_BYPASS_IOMMU property from board=0D
    code=0D
  hw/pci-host/q35: Make some property name macros reusable by i440fx=0D
  hw/pci-host/i440fx: Replace magic values by existing constants=0D
  hw/pci-host/i440fx: Have common names for some local variables=0D
  hw/pci-host/i440fx: Move i440fx_realize() into PCII440FXState section=0D
  hw/pci-host/i440fx: Make MemoryRegion pointers accessible as=0D
    properties=0D
  hw/pci-host/i440fx: Add PCI_HOST_PROP_IO_MEM property=0D
  hw/pci-host/i440fx: Add PCI_HOST_{ABOVE,BELOW}_4G_MEM_SIZE properties=0D
  hw/pci-host/i440fx: Add I440FX_HOST_PROP_PCI_TYPE property=0D
  hw/pci-host/i440fx: Resolve i440fx_init()=0D
  hw/i386/pc_piix: Move i440fx' realize near its qdev_new()=0D
=0D
 include/hw/i386/pc.h         |   4 ++=0D
 include/hw/pci-host/i440fx.h |  16 +----=0D
 include/hw/pci-host/q35.h    |   5 --=0D
 include/hw/pci/pci_host.h    |   2 +=0D
 hw/i386/pc_piix.c            |  48 ++++++++-----=0D
 hw/i386/pc_q35.c             |  31 +++++----=0D
 hw/pci-host/i440fx.c         | 130 +++++++++++++++++++----------------=0D
 hw/pci-host/q35.c            |  13 ++--=0D
 hw/pci/pci_host.c            |   2 +-=0D
 9 files changed, 134 insertions(+), 117 deletions(-)=0D
=0D
-- =0D
2.41.0=0D
=0D

