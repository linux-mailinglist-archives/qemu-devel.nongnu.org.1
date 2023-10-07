Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC44A7BC7A3
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:41:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6aC-0002oK-1k; Sat, 07 Oct 2023 08:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6a9-0002o5-M2
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:38:57 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6a7-0002jI-KL
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:38:57 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9ada2e6e75fso557907766b.2
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682332; x=1697287132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vgPqA69aUrv5f9GLE+kVG34XsFP4ndqQaPhYRQwQei8=;
 b=Ax4YpvZt9Px7H96RkNX4I7f1e3FENeGZ+qrZrxSvZVAs81byctuYSkC7tLuDytZkuS
 J6Acfb9hg76IgjWYCxZu7GNydp2wmy00RL919bBHox4t3cpcSWqBK5RSxR6SCylzgOeX
 CfnzZzhYMUfh5UrNqXbQ9PJeSnMkivv2wb3ALCrsQrvfZAH0zG28U921Ri83EulakVoi
 63xiRICrhe1GIqhpKwvMkIziyn91zD0KZryjAA8EFKy+PQcRJEKtV5tcVcvFiUc0XbQS
 cHoZSFeqWppCGxeIYMMNpUCWvVUNeLt8ESLq1+W8XZ16YpOgE98bbWHisC9WiXpujert
 kHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682332; x=1697287132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vgPqA69aUrv5f9GLE+kVG34XsFP4ndqQaPhYRQwQei8=;
 b=VIrsIKloivkwbX15KKqRTH1Wl25EW3jtGtABxIosZgLcbLpFwB3hQRlzBEJvGthGB8
 egK26LNC1PcH9npQYPb+nsxOnd2/nbD2pgUyRvghSCreK8ceNVTmW7oBN7YU/0fUMfSo
 mPJyMrbZwxyHEUBQa0iJ0TdEdMGv28IHwU2yN9UtO640R6aEPqBYJioLVi/kuMpDbsuX
 cozedV+AUwXTWJVhLoVMUnffpjuWZtMJRLWUJMF24a/AKo8JjdTOOd8ecieJTobP0Vu2
 P5/JKpDcPEZW8mGzLb6pHq9aCQHh/8smjjKVxYrh0tynErwPpIKhHwXThr9Alsal2nSZ
 hQ/A==
X-Gm-Message-State: AOJu0YycW/9OFzUHzl4vsn9i7sfSZ6vARx02jiDPtCjQRaeAjUsglBuO
 Wt1ZQ2UHudpthq/Bodh0ShhzV0kt770=
X-Google-Smtp-Source: AGHT+IHxN/f2nHZAjIQSBBFRwhthVw+xLPuZ9DaSj/V92MywMAfvUc1qqjz4FAGxDrgJhI6VR0QB2w==
X-Received: by 2002:a17:907:7786:b0:9b7:37de:6011 with SMTP id
 ky6-20020a170907778600b009b737de6011mr10324179ejc.71.1696682331529; 
 Sat, 07 Oct 2023 05:38:51 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:38:51 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chuck Zmudzinski <brchuckz@aol.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v8 00/29] Consolidate PIIX south bridges
Date: Sat,  7 Oct 2023 14:38:08 +0200
Message-ID: <20231007123843.127151-1-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series consolidates the implementations of the PIIX3 and PIIX4 south=0D
bridges and makes PIIX4 usable in the PC machine via an experimental comman=
d=0D
line parameter. The motivation is to resolve duplicate code between the dev=
ice=0D
models as well as resolving the "Frankenstein" PIIX4-PM problem in PIIX3=0D
discussed on this list before.=0D
=0D
The series is structured as follows:=0D
=0D
Patches 1-8 are preparational patches necessary for moving all sub devices =
into=0D
PIIX3, like was done for PIIX4. In isolation these patches can also be seen=
 as=0D
general x86 machine cleanup sub series which has merit in its own right -- =
and=0D
could be applied to master if the remainder of the series takes longer to=0D
review.=0D
=0D
Patches 9-13 move PIIX3 sub devices into one device model like already=0D
done for PIIX4. Together with the previous sub series these patches form a=
=0D
bigger sub series which also has merit in its own right, and could be appli=
ed=0D
independent of the remainder of this series as well.=0D
=0D
The remainder of this series consolidates the PIIX3 and PIIX4 device models=
.=0D
The culmination point is the last commit which makes PIIX4 usable in the PC=
=0D
machine.=0D
=0D
One challenge was dealing with optional devices where Peter already gave ad=
vice=0D
in [1] which this series implements. Although PIIX4 is now usable in the PC=
=0D
machine it still has a different binary layout in its VM state.=0D
=0D
Testing done:=0D
* `make check`=0D
* `qemu-system-x86_64 -M pc -m 2G -accel kvm -cdrom=0D
     manjaro-kde-21.3.2-220704-linux515.iso`=0D
* `qemu-system-x86_64 -M pc,x-south-bridge=3Dpiix4-isa -m 2G -accel kvm -cd=
rom=0D
     manjaro-kde-21.3.2-220704-linux515.iso`=0D
* `qemu-system-x86_64 -M q35 -m 2G -accel kvm -cdrom=0D
     manjaro-kde-21.3.2-220704-linux515.iso`=0D
* `qemu-system-mips64el -M malta -cpu 5KEc -m 1G -kernel kernel -initrd ini=
trd=0D
     -append "root=3DLABEL=3Drootfs console=3DttyS0" -drive file=3Dimage.qc=
ow2`=0D
* `qemu-system-mips64el -M malta -bios yamon-02.22.bin`=0D
* Run HVM domU guest under Xen with manjaro-kde-21.3.2-220704-linux515.iso =
image=0D
=0D
v8:=0D
- Wire ISA interrupts before device realization=0D
- Optionally allow a PIC and PIT to be instantiated in PIIX3 for compatibli=
ty=0D
    with PIIX4=0D
- Touch ICH9 LPC as far as required for PIIX consolidation=0D
- Make PIIX4 usable in the PC machine via an experimental option=0D
- Review and rework history, touching every commit and drop R-b tags when=0D
    changes became too large=0D
=0D
v7:=0D
- Rebase onto master=0D
- Avoid the PIC proxy (Phil)=0D
  The motivation for the PIC proxy was to allow for wiring up ISA interrupt=
s in=0D
  the south bridges. ISA interrupt wiring requires the GPIO lines to be=0D
  populated already but pc_piix assigned the interrupts only after realizin=
g=0D
  PIIX3. By shifting interrupt assignment before realizing, the ISA interru=
pts=0D
  are already populated during PIIX3's realize phase where the ISA interrup=
ts=0D
  are wired up.=0D
- New patches:=0D
  * hw/isa/piix4: Reuse struct PIIXState from PIIX3=0D
  * hw/isa/piix4: Create the "intr" property during init() already=0D
- Patches with substantial changes (Reviewed-by dropped):=0D
  * hw/isa/piix3: Move ISA bus IRQ assignments into host device=0D
=0D
v6:=0D
- Fix some comments about TYPE_ISA_PIC (Mark) ... and use it consistently=0D
  within the patch series.=0D
- Incorporate series "[PATCH v2 0/3] Decouple INTx-to-LNKx routing from sou=
th=0D
  bridges" [2] for maintainer convenience.=0D
- Merge v5's 'hw/i386/pc_piix: Associate pci_map_irq_fn as soon as PCI bus =
is=0D
  created' into=0D
  https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg03312.html . =
Do=0D
  similar for Malta.=0D
- Rebase onto latest master (d6271b657286 "Merge tag 'for_upstream' of=0D
  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging")=0D
=0D
v5:=0D
- Pick up Reviewed-by tags from https://lists.nongnu.org/archive/html/qemu-=
devel/2023-01/msg00116.html=0D
- Add patch to make usage of the isa_pic global more type-safe=0D
- Re-introduce isa-pic as PIC specific proxy (Mark)=0D
=0D
v4:=0D
- Rebase onto "[PATCH v2 0/3] Decouple INTx-to-LNKx routing from south brid=
ges"=0D
  since it is already queued via mips-next. This eliminates patches=0D
  'hw/isa/piix3: Prefix pci_slot_get_pirq() with "piix3_"' and 'hw/isa/piix=
4:=0D
  Prefix pci_slot_get_pirq() with "piix4_"'.=0D
- Squash 'hw/isa/piix: Drop the "3" from the PIIX base class' into=0D
  'hw/isa/piix3: Rename typedef PIIX3State to PIIXState'. I originally only=
=0D
  split these patches since I wasn't sure whether renaming a type was allow=
ed.=0D
- Add new patch 'hw/i386/pc_piix: Associate pci_map_irq_fn as soon as PCI b=
us is=0D
  created' for forther cleanup of INTx-to-LNKx route decoupling.=0D
=0D
v3:=0D
- Introduce one TYPE_ICH9_USB_UHCI(fn) rather than several TYPE_ICH9_USB_UH=
CIx=0D
  (Philippe)=0D
- Make proxy PIC generic (Philippe)=0D
- Track Malta's PIIX dependencies through KConfig=0D
- Rebase onto Philippe's 'hw/isa/piix4: Remove MIPS Malta specific bits' se=
ries [3]=0D
- Also rebase onto latest master to resolve merge conflicts. This required=
=0D
  copying Philippe's series as first three patches - please ignore.=0D
=0D
v2:=0D
- Introduce TYPE_ defines for IDE and USB device models (Mark)=0D
- Omit unexporting of PIIXState (Mark)=0D
- Improve commit message of patch 5 to mention reset triggering through PCI=
=0D
  configuration space (Mark)=0D
- Move reviewed patches w/o dependencies to the bottom of the series for ea=
rly=0D
  upstreaming=0D
=0D
[1] https://lists.nongnu.org/archive/html/qemu-devel/2022-07/msg02348.html=
=0D
[2] https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg03310.html=
=0D
[3] https://lists.nongnu.org/archive/html/qemu-devel/2022-10/msg05367.html=
=0D
=0D
Bernhard Beschow (29):=0D
  hw/i386/pc: Merge two if statements into one=0D
  hw/i386/pc_piix: Allow for setting properties before realizing PIIX3=0D
    south bridge=0D
  hw/i386/pc_piix: Assign PIIX3's ISA interrupts before its realize()=0D
  hw/isa/piix3: Resolve redundant PIIX_NUM_PIC_IRQS=0D
  hw/i386/pc_piix: Wire PIIX3's ISA interrupts by new "isa-irqs"=0D
    property=0D
  hw/i386/pc_piix: Remove redundant "piix3" variable=0D
  hw/isa/piix3: Rename "pic" attribute to "isa_irqs_in"=0D
  hw/i386/pc_q35: Wire ICH9 LPC function's interrupts before its=0D
    realize()=0D
  hw/isa/piix3: Wire PIC IRQs to ISA bus in host device=0D
  hw/i386/pc: Wire RTC ISA IRQs in south bridges=0D
  hw/isa/piix3: Create IDE controller in host device=0D
  hw/isa/piix3: Create USB controller in host device=0D
  hw/isa/piix3: Create power management controller in host device=0D
  hw/isa/piix3: Drop the "3" from PIIX base class name=0D
  hw/isa/piix4: Remove unused inbound ISA interrupt lines=0D
  hw/isa/piix4: Rename "isa" attribute to "isa_irqs_in"=0D
  hw/isa/piix4: Rename reset control operations to match PIIX3=0D
  hw/isa/piix4: Reuse struct PIIXState from PIIX3=0D
  hw/isa/piix3: Merge hw/isa/piix4.c=0D
  hw/isa/piix: Allow for optional PIC creation in PIIX3=0D
  hw/isa/piix: Allow for optional PIT creation in PIIX3=0D
  hw/isa/piix: Harmonize names of reset control memory regions=0D
  hw/isa/piix: Share PIIX3's base class with PIIX4=0D
  hw/isa/piix: Reuse PIIX3 base class' realize method in PIIX4=0D
  hw/isa/piix: Rename functions to be shared for PCI interrupt=0D
    triggering=0D
  hw/isa/piix: Reuse PIIX3's PCI interrupt triggering in PIIX4=0D
  hw/isa/piix: Resolve duplicate code regarding PCI interrupt wiring=0D
  hw/isa/piix: Implement multi-process QEMU support also for PIIX4=0D
  hw/i386/pc_piix: Make PIIX4 south bridge usable in PC machine=0D
=0D
 MAINTAINERS                          |   6 +-=0D
 docs/system/target-i386-desc.rst.inc |   8 +=0D
 include/hw/i386/pc.h                 |   2 +=0D
 include/hw/southbridge/piix.h        |  28 ++-=0D
 hw/i386/pc.c                         |  13 +-=0D
 hw/i386/pc_piix.c                    | 125 ++++++++---=0D
 hw/i386/pc_q35.c                     |  14 +-=0D
 hw/isa/lpc_ich9.c                    |   9 +-=0D
 hw/isa/{piix3.c =3D> piix.c}           | 281 ++++++++++++++++++-------=0D
 hw/isa/piix4.c                       | 302 ---------------------------=0D
 hw/mips/malta.c                      |   5 +-=0D
 hw/i386/Kconfig                      |   3 +-=0D
 hw/isa/Kconfig                       |   8 +-=0D
 hw/isa/meson.build                   |   3 +-=0D
 hw/mips/Kconfig                      |   2 +-=0D
 15 files changed, 358 insertions(+), 451 deletions(-)=0D
 rename hw/isa/{piix3.c =3D> piix.c} (52%)=0D
 delete mode 100644 hw/isa/piix4.c=0D
=0D
-- =0D
2.42.0=0D
=0D

