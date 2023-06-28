Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EB374190E
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:53:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbD8-0004fa-VO; Wed, 28 Jun 2023 15:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbD6-0004fA-12
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:16 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbD3-0005h7-Hr
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:15 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9922d6f003cso26066466b.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981932; x=1690573932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V2MdUBRGb77ViU2/YfuJh0DN9kOdUyHO53LIJSK7v8o=;
 b=XPAmnCK1G8Z6/IygBFc4cc/NMZAbUKvLVxebbTJOiqT3ZQ3aF5xYi5oKAEIFiYfAyg
 Jp0jIw2ydDU9un41dT6ix6EX5qEK8c9cvPWBH8L813ZdmPmFA4fLq31+MDNABCLhL0U4
 3a6A+QuRle15nmZAkN4bimGHxZ5QOtPuGYa2fZ9w7G/0fr3uy4HXGpo7EYHEN75mcUpI
 tc9oJdWHd73i3FFiN/xtgzsdz2IiTWkZsL9PT69xYfMLkqpzollo/YBrFxDp1OzdzuwH
 UDAiyR5yCWAwB0LnU0W2aun9XElX76JoIOPCbaCMnqP9YFQpwNCDGVCr67sEl66cbJfa
 bJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981932; x=1690573932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V2MdUBRGb77ViU2/YfuJh0DN9kOdUyHO53LIJSK7v8o=;
 b=FqkPKUkogPQearV1N9dDJOdzgQh5SgE5QMFuI2wSbOrQgCHWIpGc8CKvgDkrCo009J
 IMy8LRiQxFilYffBYhhanJm8lKy33heoQLb6DEcBdQiR5m4eq/OcTLizEzHtpoUdtj0S
 Vlg4rRxo9zKZxHl8GByekMdvLYvHVZQXoMMX9kIjH455PZdXeZvCaeGWT97tnOJAQN20
 DpF4sZOQdPs7ASxk04/BQc/y7iXlccjs0WykLNGtsNV/YNBNJ60CDUz+AgmtxGfvU8zm
 JKjP8LgHxKYXZUldg5sQSljEmoK1rrIKVrzKQ2GbwIrpOBymCaZpppZZcGGleBt0Se3N
 CVMA==
X-Gm-Message-State: AC+VfDy9KLyPrpe+ykN20wWDMBSGgPQw32V1fEL1tAnW3UYSPbmQzLaW
 /3se+PF/9XiM8zCyiyotaBSppvM/y4M=
X-Google-Smtp-Source: ACHHUZ74PP54w6Z4NqCVsEzElYu95G7QkwiQulvA5Mzr6MdPBKzE049fEAj4tLR8lIcJMAhrFKEosA==
X-Received: by 2002:a17:907:987:b0:969:faf3:7dba with SMTP id
 bf7-20020a170907098700b00969faf37dbamr33919819ejc.52.1687981931488; 
 Wed, 28 Jun 2023 12:52:11 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:11 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 00/16] Q35 and I440FX host bridge QOM cleanup
Date: Wed, 28 Jun 2023 21:51:48 +0200
Message-ID: <20230628195204.1241-1-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
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
v2:=0D
* Rename `address_space_io` to `io_memory` (Phil)=0D
* Eliminate one else branch in pc_piix (Igor)=0D
* Make Q35's blackhole_ops DEVICE_LITTLE_ENDIAN again (Igor)=0D
* Possibly ongoing discussion regarding bringing together i440fx new and re=
alize=0D
=0D
[1] https://patchew.org/QEMU/20230304152648.103749-1-shentey@gmail.com/=0D
=0D
Bernhard Beschow (16):=0D
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
  hw/pci-host/i440fx: Add PCI_HOST_{ABOVE, BELOW}_4G_MEM_SIZE properties=0D
  hw/pci-host/i440fx: Add I440FX_HOST_PROP_PCI_TYPE property=0D
  hw/pci-host/i440fx: Resolve i440fx_init()=0D
  hw/i386/pc_piix: Turn some local variables into initializers=0D
  hw/i386/pc_piix: Move i440fx' realize near its qdev_new()=0D
=0D
 include/hw/i386/pc.h         |   4 ++=0D
 include/hw/pci-host/i440fx.h |  16 +----=0D
 include/hw/pci-host/q35.h    |   5 --=0D
 include/hw/pci/pci_host.h    |   2 +=0D
 hw/i386/pc_piix.c            |  59 +++++++++-------=0D
 hw/i386/pc_q35.c             |  31 +++++----=0D
 hw/pci-host/i440fx.c         | 128 +++++++++++++++++++----------------=0D
 hw/pci-host/q35.c            |  13 ++--=0D
 hw/pci/pci_host.c            |   2 +-=0D
 9 files changed, 135 insertions(+), 125 deletions(-)=0D
=0D
-- =0D
2.41.0=0D
=0D

