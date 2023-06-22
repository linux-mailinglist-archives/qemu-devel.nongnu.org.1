Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAD673A700
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:12:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNpr-0007gb-Nm; Thu, 22 Jun 2023 13:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qCNpp-0007gG-CX
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:11:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qCNpn-0003eE-CM
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:11:05 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f9ede60140so13788445e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687453861; x=1690045861;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=UwGsgAI7jV9p7OyUvworxEvMAeK5tygQS0LgF8hkZVE=;
 b=dW59H8DBtj0VuHVTRAjn+01kG5V4N+IspA5VQONz2JlMeXzjXumUigH6C3oegl7ggl
 pDcbPzz+HojRPstgt4guIPZe62jEbOjLU8goeOmYT1uF9wahWIkHFT34Ezz9Dn3I/aS8
 kmB4L6Tt0xdSvfPlC6nWR10FrFtMt/O/U7yPouJpYNei7CVqQJYNc4ErjkrnVztW6+9V
 IOZSry3oRnhHddetkS9jw5mA4AA+ZMHW6rWT+RIOLcKaBLDMJyjewTLKS9FzdLgN+Cz7
 2fUkodTZ2rlNDtJWMOVffHmBtjt0DXge4Zh8nS2+XXMk1FEmj7KgD43dlsglfffiEAH9
 px6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687453861; x=1690045861;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UwGsgAI7jV9p7OyUvworxEvMAeK5tygQS0LgF8hkZVE=;
 b=H/h1s61nbqnkyjKg3NBpPBt26nrZW4+wbH1efDJNJucKqHfmi8Zn1ARuHfcKB3272i
 gWpjIJ6GgkRsckeDSAe4jDN0A4u2amTD12geDF28b3cHD6rTJvYHdp5mYa7mmm+iECMQ
 WA0MWmQ0ML/7wvCi0XVf1x38HkRcqjtT4sq2MwVai4lievqX4vfKYRuCmKIWJdK0ac3P
 FYJk2DtonjSOybAZ8yosL814o4F2ArG7uOT1OE957pJwZWhPae+Nh5H/ZbzMpX8jPrPM
 rvUka6T1PFvqLMgD8UEfL3dmQ6qzIEPRvQpwH/uhdsHs1TdU15X+d97XyJABm2EgiIRu
 XJlw==
X-Gm-Message-State: AC+VfDwsiu/LZZb9ehOX5iex7lFzZtoiswf8rKXv7QZywNQd859oPOvL
 CNHJ8O7FUXXw/XArU6rZE3uVU9TMh3I=
X-Google-Smtp-Source: ACHHUZ6qP1SFZMW1hHyvVmE5FJ38SP7w5l8M5+8sxaX5gNgzlIdSxnNqazCqipVy2meaociob4Z9xw==
X-Received: by 2002:a05:600c:21cc:b0:3fa:72ce:25ad with SMTP id
 x12-20020a05600c21cc00b003fa72ce25admr1891474wmj.35.1687453860914; 
 Thu, 22 Jun 2023 10:11:00 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 g7-20020a7bc4c7000000b003f7eeec829asm50809wmk.10.2023.06.22.10.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 10:11:00 -0700 (PDT)
Date: Thu, 22 Jun 2023 17:10:55 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Joel Upham <jupham125@gmail.com>
Subject: Re: [PATCH v1 00/23] Q35 support for Xen
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
Message-ID: <38A3023A-6FAC-4155-BD7F-1C1DB16450EE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
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



Am 20=2E Juni 2023 17:24:33 UTC schrieb Joel Upham <jupham125@gmail=2Ecom>=
:
>These are the Qemu changes needed to support the q35 chipset for xen
>I based the patches from 2017 found on the mailing list here:
>https://lists=2Exenproject=2Eorg/archives/html/xen-devel/2018-03/msg01176=
=2Ehtml
>
>I have been using a version of these patches on Xen 4=2E16 with Qemu
>version 4=2E1 for over 6 months=2E  The guest VMs are very stable, and PC=
Ie
>PT is working as was designed (all of the PCIe devices are on the root
>PCIe device)=2E  I have successfully passed through GPUs, NICs, etc=2E I =
was
>asked by those in the community to attempt to once again upstream the
>patches=2E  I have them working with Seabios and OVMF (patches are needed
>to OVMF which I will be sending to the mailing list)=2E The Qemu patches=
=20
>allow for the xenvbd to properly unplug the AHCI SATA device, and all=20
>xen pv windows drivers work as intended=2E
>
>I used the original author of the patches to get a majority of this to wo=
rk:
>Alexey Gerasimenko=2E  I fixed the patches to be in line with the upstrea=
m
>Qemu and Xen versions=2E  Any original issues may still exist; however, I
>am sure in time they can be improved=2E If the code doesn't exist then th=
ey
>can't be actively looked at by the community=2E
>
>I am not an expert on the Q35 chipset or PCIe technology=2E  This is my
>first patch to this mailing list=2E

Patchew was unable to apply this series onto master: https://patchew=2Eorg=
/QEMU/cover=2E1687278381=2Egit=2Ejupham125@gmail=2Ecom/ What revision is th=
e series based on?

Can you rebase? Rebasing this series will probably cause quite some work s=
ince it will simplify here and there, as indicated by Igor and by my commen=
ts in "version zero" of this series=2E

Best regards,
Bernhard

>
>
>Joel Upham (23):
>  pc/xen: Xen Q35 support: provide IRQ handling for PCI devices
>  pc/q35: Apply PCI bus BSEL property for Xen PCI device hotplug
>  q35/acpi/xen: Provide ACPI PCI hotplug interface for Xen on Q35
>  q35/xen: Add Xen platform device support for Q35
>  q35: Fix incorrect values for PCIEXBAR masks
>  xen/pt: XenHostPCIDevice: provide functions for PCI Capabilities and
>    PCIe Extended Capabilities enumeration
>  xen/pt: avoid reading PCIe device type and cap version multiple times
>  xen/pt: determine the legacy/PCIe mode for a passed through device
>  xen/pt: Xen PCIe passthrough support for Q35: bypass PCIe topology
>    check
>  xen/pt: add support for PCIe Extended Capabilities and larger config
>    space
>  xen/pt: handle PCIe Extended Capabilities Next register
>  xen/pt: allow to hide PCIe Extended Capabilities
>  xen/pt: add Vendor-specific PCIe Extended Capability descriptor and
>    sizing
>  xen/pt: add fixed-size PCIe Extended Capabilities descriptors
>  xen/pt: add AER PCIe Extended Capability descriptor and sizing
>  xen/pt: add descriptors and size calculation for
>    RCLD/ACS/PMUX/DPA/MCAST/TPH/DPC PCIe Extended Capabilities
>  xen/pt: add Resizable BAR PCIe Extended Capability descriptor and
>    sizing
>  xen/pt: add VC/VC9/MFVC PCIe Extended Capabilities descriptors and
>    sizing
>  xen/pt: Fake capability id
>  xen platform: unplug ahci object
>  pc/q35: setup q35 for xen
>  qdev-monitor/pt: bypass root device check
>  s3 support: enabling s3 with q35
>
> hw/acpi/ich9=2Ec                |   22 +-
> hw/acpi/pcihp=2Ec               |    6 +-
> hw/core/machine=2Ec             |   19 +
> hw/i386/pc_piix=2Ec             |    3 +-
> hw/i386/pc_q35=2Ec              |   39 +-
> hw/i386/xen/xen-hvm=2Ec         |    7 +-
> hw/i386/xen/xen_platform=2Ec    |   19 +-
> hw/isa/lpc_ich9=2Ec             |   53 +-
> hw/isa/piix3=2Ec                |    2 +-
> hw/pci-host/q35=2Ec             |   28 +-
> hw/pci/pci=2Ec                  |   17 +
> hw/xen/xen-host-pci-device=2Ec  |  106 +++-
> hw/xen/xen-host-pci-device=2Eh  |    6 +-
> hw/xen/xen_pt=2Ec               |   49 +-
> hw/xen/xen_pt=2Eh               |   18 +-
> hw/xen/xen_pt_config_init=2Ec   | 1103 ++++++++++++++++++++++++++++++---
> include/hw/acpi/pcihp=2Eh       |    2 +
> include/hw/boards=2Eh           |    1 +
> include/hw/i386/pc=2Eh          |    3 +
> include/hw/pci-host/q35=2Eh     |    4 +-
> include/hw/pci/pci=2Eh          |    3 +
> include/hw/southbridge/ich9=2Eh |    1 +
> include/hw/xen/xen=2Eh          |    4 +-
> qemu-options=2Ehx               |    1 +
> softmmu/qdev-monitor=2Ec        |    4 +-
> stubs/xen-hw-stub=2Ec           |    4 +-
> 26 files changed, 1394 insertions(+), 130 deletions(-)
>

