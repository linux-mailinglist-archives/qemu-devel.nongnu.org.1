Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D332F7435E7
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:38:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8hD-000228-Up; Fri, 30 Jun 2023 03:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8hA-00021f-Cq
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:32 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qF8h8-0005Ov-FF
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:37:31 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-992f6d7c7fbso7509166b.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688110648; x=1690702648;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gx+NjmcFBvSAtRPV3rw42EgP3SfyA5VZE1XABQlh2QY=;
 b=kSFWqNraloBBDcupbq+eO4ser1ZXEJfsHbNmY0cFSF+TkOypou66knaamtBo8Qnm0o
 uPnUsNSVE79zEcnuTZPkDjB8KPkjh/opi7fg4U17porinhhFMYWQ1Fmo1OvhgbDbHlsP
 1txQPuOUskpr0z5mqX5TfJcPulLWzhqYrgjtw/AKC4Nufa+JK3pAdPr7izhxzzOY1RQl
 F+J7pWvN14eIlhlPy7ME0UtEL0hlXXm6bAmomeXh67MZ5bsyiYPa9olHBf297VpmUgMa
 aHbj2YVEP6h4zQkU/Efh6XX4AP7NhF4nGo++x3kmjnjfyi9XstH9L0MdZjNtpDHzHoHp
 Qk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110648; x=1690702648;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gx+NjmcFBvSAtRPV3rw42EgP3SfyA5VZE1XABQlh2QY=;
 b=jwk+cW3pI/JNwEsGnSc3POJk4b/n/WZ7u8FjzD6IgCgaLiGq3+9SHzpcMfRxIfh+Nh
 E0l8DKfC3XZi88gnZn5rw9MiWfcxUI1gHg6UjtJxsY4XVUNOCaklPom1UNoyGaZlILMz
 +pcJycHEt+Ws9QkY2c0VdjnTJ4otULYY0vuq1t9bIn5nIlRiwJzG174c9TxXic27IASM
 5WrReb+DA6LwhQBY3NWoQfiJSgvCFohfqwoXNAPXBncmY8SujYnzzBoQnplTj4fZNXSK
 GdL28GS+8VH7GsNYobTH0LoN0QSvQKlqNkAfG9DGylQ7hbpNlQstFJb7EEHk4I01T88J
 vo0w==
X-Gm-Message-State: ABy/qLZwMKruSldmohORYw/KppfUYD/UxbASeT2LrwzpMOs7VcZgm/d5
 RlKKJD5w+StQTTw6edmbILgIxD7tjX4=
X-Google-Smtp-Source: APBJJlHSKS/Cd79AE16vYzlYeD9Pex9oTqxTfnQikgZ5szsXPTnxb8BNfZovuZK20J1baeK7b40QOw==
X-Received: by 2002:a17:906:f884:b0:988:9621:d85f with SMTP id
 lg4-20020a170906f88400b009889621d85fmr1190132ejb.58.1688110648228; 
 Fri, 30 Jun 2023 00:37:28 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-131-254.89.12.pool.telefonica.de.
 [89.12.131.254]) by smtp.gmail.com with ESMTPSA id
 k19-20020a1709061c1300b00988b32160dfsm7625578ejg.222.2023.06.30.00.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 00:37:27 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 00/17] Q35 and I440FX host bridge QOM cleanup
Date: Fri, 30 Jun 2023 09:37:03 +0200
Message-ID: <20230630073720.21297-1-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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
v3:=0D
* Establish i440fx' parent-child relation earlier (Phil)=0D
* Rename i440fx_host -> phb earlier to avoid some churn in last patch=0D
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
Bernhard Beschow (17):=0D
  hw/i386/pc_q35: Resolve redundant q35_host variable=0D
  hw/pci-host/q35: Fix double, contradicting .endianness assignment=0D
  hw/pci-host/q35: Initialize PCMachineState::bus in board code=0D
  hw/pci/pci_host: Introduce PCI_HOST_BYPASS_IOMMU macro=0D
  hw/pci-host/q35: Initialize PCI_HOST_BYPASS_IOMMU property from board=0D
    code=0D
  hw/pci-host/q35: Make some property name macros reusable by i440fx=0D
  hw/i386/pc_piix: Turn some local variables into initializers=0D
  hw/pci-host/i440fx: Add "i440fx" child property in board code=0D
  hw/pci-host/i440fx: Replace magic values by existing constants=0D
  hw/pci-host/i440fx: Have common names for some local variables=0D
  hw/pci-host/i440fx: Move i440fx_realize() into PCII440FXState section=0D
  hw/pci-host/i440fx: Make MemoryRegion pointers accessible as=0D
    properties=0D
  hw/pci-host/i440fx: Add PCI_HOST_PROP_IO_MEM property=0D
  hw/pci-host/i440fx: Add PCI_HOST_{ABOVE, BELOW}_4G_MEM_SIZE properties=0D
  hw/pci-host/i440fx: Add I440FX_HOST_PROP_PCI_TYPE property=0D
  hw/pci-host/i440fx: Resolve i440fx_init()=0D
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

