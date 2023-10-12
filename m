Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 544007C7AD0
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 02:24:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr5wh-0001BI-FE; Thu, 12 Oct 2023 20:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qr5wf-0001B9-ES
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 20:22:25 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qr5wX-00045o-NU
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 20:22:25 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53db3811d8fso3124636a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 17:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697156535; x=1697761335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJ+Lq7d4/V20CFIk9TP2pjSOSkl2wPJHhlvC0QFCxXE=;
 b=mHEHm+zKE2UePFl5fKBaetZXeFnwI/Wj3Fd+29h7v5LgpAsV4rEWspk/pYEYk6fTp5
 O5mCMuqqQ5rG3baW5ZbmjhNUrpygAU4ebaTlz+/Y6E2vYsGUNw1KwhjTCg0cJaUwZpFp
 hWwfc46zVHXXOLy4HaosVhoP5G4G6mwOR5l6CKcp2LNiXfxPZuIymFL/RheRXs8bnqBM
 DSaXdyvT840j1uqCtWm4K8JPuCS7hZ5SDHE1UlAPfC8NwRIYrzO4oXkc/JF44VZTovVy
 OtLJ4miYdFb7c0pAFz6toVWPhGgkSsQxNH5A2OgJ+rrk4kB49JHUp4qLkYudrX/VOBQg
 Pabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697156535; x=1697761335;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oJ+Lq7d4/V20CFIk9TP2pjSOSkl2wPJHhlvC0QFCxXE=;
 b=kIap/ijidUIf1ZOa/338CCqLBU7/7Drf7feTlqBhpi7tFO6lLd0+7s4W3BLQ52sXdL
 symXXxmvy0wq5I0g4UfXVPJuHi0jrmpSkzZ2lp/xZ5MpgdDUYaVQ3BWxCfeKewWV9whA
 /Jrrs0B969zgFZDPE5hBPD0UOOUWbxbDJ8n8fLNxdovqxlvlGAA959CY5STsVugNDuYh
 H1ERbVCSdLg+yyde0NfJhLRFc3qTh3ZyqVbQe2kpXPftTHVGZBPmBlzOBBhY9LGuSlqp
 a7Wl5SOougJz0Vyi7r6jeF/ia/WPd7ycLT5vTwOF31J+mXoDfplgj8XlN+19Ndr73vmR
 LDEA==
X-Gm-Message-State: AOJu0Ywq8abwSOG+USJ4klXHr7NhwuWWx5Zol91mFiQDByc3VCykagbV
 XjLV2XJ3bJxl4IPAYn2OmcU=
X-Google-Smtp-Source: AGHT+IGAOdx5ZbqaF324eOvp67BxvqqBrVS6GijYh9+T6/rAKPutNqXBZ8Ggprj66kCAf3/wuas19w==
X-Received: by 2002:a05:6402:1a33:b0:522:582c:f427 with SMTP id
 be19-20020a0564021a3300b00522582cf427mr21567367edb.14.1697156535036; 
 Thu, 12 Oct 2023 17:22:15 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-014-105-013.89.14.pool.telefonica.de.
 [89.14.105.13]) by smtp.gmail.com with ESMTPSA id
 u5-20020aa7d545000000b00534e791296bsm10763725edr.37.2023.10.12.17.22.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 17:22:14 -0700 (PDT)
Date: Thu, 12 Oct 2023 18:13:05 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Chuck Zmudzinski <brchuckz@aol.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Eduardo Habkost <eduardo@habkost.net>, Aurelien Jarno <aurelien@aurel32.net>, 
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [PATCH v8 00/29] Consolidate PIIX south bridges
In-Reply-To: <20231011161742-mutt-send-email-mst@kernel.org>
References: <20231007123843.127151-1-shentey@gmail.com>
 <cf6a2f47-0130-4ac5-be1d-23aef2f3e87c@aol.com>
 <19E0EB2A-83F8-40A1-8A9E-FED0DACE2901@gmail.com>
 <20231011161742-mutt-send-email-mst@kernel.org>
Message-ID: <22C16AB6-4938-44BB-B4E0-FEC8C75028C0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
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



Am 11=2E Oktober 2023 20:18:00 UTC schrieb "Michael S=2E Tsirkin" <mst@red=
hat=2Ecom>:
>On Wed, Oct 11, 2023 at 06:57:07PM +0000, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 8=2E Oktober 2023 17:56:48 UTC schrieb Chuck Zmudzinski <brchuckz@ao=
l=2Ecom>:
>> >On 10/7/23 8:38 AM, Bernhard Beschow wrote:
>> >> This series consolidates the implementations of the PIIX3 and PIIX4 =
south
>> >> bridges and makes PIIX4 usable in the PC machine via an experimental=
 command
>> >> line parameter=2E The motivation is to resolve duplicate code betwee=
n the device
>> >> models as well as resolving the "Frankenstein" PIIX4-PM problem in P=
IIX3
>> >> discussed on this list before=2E
>> >>=20
>> >> The series is structured as follows:
>> >>=20
>> >> Patches 1-8 are preparational patches necessary for moving all sub d=
evices into
>> >> PIIX3, like was done for PIIX4=2E In isolation these patches can als=
o be seen as
>> >> general x86 machine cleanup sub series which has merit in its own ri=
ght -- and
>> >> could be applied to master if the remainder of the series takes long=
er to
>> >> review=2E
>> >>=20
>> >> Patches 9-13 move PIIX3 sub devices into one device model like alrea=
dy
>> >> done for PIIX4=2E Together with the previous sub series these patche=
s form a
>> >> bigger sub series which also has merit in its own right, and could b=
e applied
>> >> independent of the remainder of this series as well=2E
>> >>=20
>> >> The remainder of this series consolidates the PIIX3 and PIIX4 device=
 models=2E
>> >> The culmination point is the last commit which makes PIIX4 usable in=
 the PC
>> >> machine=2E
>> >>=20
>> >> One challenge was dealing with optional devices where Peter already =
gave advice
>> >> in [1] which this series implements=2E Although PIIX4 is now usable =
in the PC
>> >> machine it still has a different binary layout in its VM state=2E
>> >>=20
>> >> Testing done:
>> >> * `make check`
>> >> * `qemu-system-x86_64 -M pc -m 2G -accel kvm -cdrom
>> >>      manjaro-kde-21=2E3=2E2-220704-linux515=2Eiso`
>> >> * `qemu-system-x86_64 -M pc,x-south-bridge=3Dpiix4-isa -m 2G -accel =
kvm -cdrom
>> >>      manjaro-kde-21=2E3=2E2-220704-linux515=2Eiso`
>> >> * `qemu-system-x86_64 -M q35 -m 2G -accel kvm -cdrom
>> >>      manjaro-kde-21=2E3=2E2-220704-linux515=2Eiso`
>> >> * `qemu-system-mips64el -M malta -cpu 5KEc -m 1G -kernel kernel -ini=
trd initrd
>> >>      -append "root=3DLABEL=3Drootfs console=3DttyS0" -drive file=3Di=
mage=2Eqcow2`
>> >> * `qemu-system-mips64el -M malta -bios yamon-02=2E22=2Ebin`
>> >> * Run HVM domU guest under Xen with manjaro-kde-21=2E3=2E2-220704-li=
nux515=2Eiso image
>> >
>> >I did some preliminary tests of this patch series on some Xen HVM domU=
 guests I have
>> >that use the xenfv / pc machine and depend on the current PIIX3 implem=
entation=2E
>> >So far there are no regressions in my tests=2E I use libxl or libvirt =
to manage the
>> >Xen guests=2E
>>=20
>> Thanks, nice to read!
>>=20
>> >
>> >I have not (yet) tested the experimental option that makes PIIX4 useab=
le in the xenfv / pc
>> >machines=2E IIUC, that would require a patch to hvmloader/pci=2Ec in X=
en tools so Xen's
>> >hvmloader recognizes the PIIX4 pci device id [1], and a patch to libxl=
 so libxl can
>> >optionally launch qemu with the new experimental option enabled=2E
>> >
>> >Since this patch series affects the xenfv machine, I added the Xen x86=
 maintainers to
>> >the Cc list and Jason Andryuk who is credited with discovering the nec=
essary patch to
>> >hvmloader/pci=2Ec=2E
>>=20
>> Good idea=2E In the next iteration, I'll cc the respective email addres=
ses from the MAINTAINERS file which hopefully reaches all relevant people=
=2E
>
>there will be a next version then?

No, unless review comments will require it=2E

>
>> Best regards,
>> Bernhard
>>=20
>> >
>> >[1] https://lore=2Ekernel=2Eorg/qemu-devel/B0FF78F4-1193-495B-919C-84A=
1FF8ADF12@gmail=2Ecom/
>> >
>> >>=20
>> >> v8:
>> >> - Wire ISA interrupts before device realization
>> >> - Optionally allow a PIC and PIT to be instantiated in PIIX3 for com=
patiblity
>> >>     with PIIX4
>> >> - Touch ICH9 LPC as far as required for PIIX consolidation
>> >> - Make PIIX4 usable in the PC machine via an experimental option
>> >> - Review and rework history, touching every commit and drop R-b tags=
 when
>> >>     changes became too large
>> >>=20
>> >> v7:
>> >> - Rebase onto master
>> >> - Avoid the PIC proxy (Phil)
>> >>   The motivation for the PIC proxy was to allow for wiring up ISA in=
terrupts in
>> >>   the south bridges=2E ISA interrupt wiring requires the GPIO lines =
to be
>> >>   populated already but pc_piix assigned the interrupts only after r=
ealizing
>> >>   PIIX3=2E By shifting interrupt assignment before realizing, the IS=
A interrupts
>> >>   are already populated during PIIX3's realize phase where the ISA i=
nterrupts
>> >>   are wired up=2E
>> >> - New patches:
>> >>   * hw/isa/piix4: Reuse struct PIIXState from PIIX3
>> >>   * hw/isa/piix4: Create the "intr" property during init() already
>> >> - Patches with substantial changes (Reviewed-by dropped):
>> >>   * hw/isa/piix3: Move ISA bus IRQ assignments into host device
>> >>=20
>> >> v6:
>> >> - Fix some comments about TYPE_ISA_PIC (Mark) =2E=2E=2E and use it c=
onsistently
>> >>   within the patch series=2E
>> >> - Incorporate series "[PATCH v2 0/3] Decouple INTx-to-LNKx routing f=
rom south
>> >>   bridges" [2] for maintainer convenience=2E
>> >> - Merge v5's 'hw/i386/pc_piix: Associate pci_map_irq_fn as soon as P=
CI bus is
>> >>   created' into
>> >>   https://lists=2Enongnu=2Eorg/archive/html/qemu-devel/2022-11/msg03=
312=2Ehtml =2E Do
>> >>   similar for Malta=2E
>> >> - Rebase onto latest master (d6271b657286 "Merge tag 'for_upstream' =
of
>> >>   https://git=2Ekernel=2Eorg/pub/scm/virt/kvm/mst/qemu into staging"=
)
>> >>=20
>> >> v5:
>> >> - Pick up Reviewed-by tags from https://lists=2Enongnu=2Eorg/archive=
/html/qemu-devel/2023-01/msg00116=2Ehtml
>> >> - Add patch to make usage of the isa_pic global more type-safe
>> >> - Re-introduce isa-pic as PIC specific proxy (Mark)
>> >>=20
>> >> v4:
>> >> - Rebase onto "[PATCH v2 0/3] Decouple INTx-to-LNKx routing from sou=
th bridges"
>> >>   since it is already queued via mips-next=2E This eliminates patche=
s
>> >>   'hw/isa/piix3: Prefix pci_slot_get_pirq() with "piix3_"' and 'hw/i=
sa/piix4:
>> >>   Prefix pci_slot_get_pirq() with "piix4_"'=2E
>> >> - Squash 'hw/isa/piix: Drop the "3" from the PIIX base class' into
>> >>   'hw/isa/piix3: Rename typedef PIIX3State to PIIXState'=2E I origin=
ally only
>> >>   split these patches since I wasn't sure whether renaming a type wa=
s allowed=2E
>> >> - Add new patch 'hw/i386/pc_piix: Associate pci_map_irq_fn as soon a=
s PCI bus is
>> >>   created' for forther cleanup of INTx-to-LNKx route decoupling=2E
>> >>=20
>> >> v3:
>> >> - Introduce one TYPE_ICH9_USB_UHCI(fn) rather than several TYPE_ICH9=
_USB_UHCIx
>> >>   (Philippe)
>> >> - Make proxy PIC generic (Philippe)
>> >> - Track Malta's PIIX dependencies through KConfig
>> >> - Rebase onto Philippe's 'hw/isa/piix4: Remove MIPS Malta specific b=
its' series [3]
>> >> - Also rebase onto latest master to resolve merge conflicts=2E This =
required
>> >>   copying Philippe's series as first three patches - please ignore=
=2E
>> >>=20
>> >> v2:
>> >> - Introduce TYPE_ defines for IDE and USB device models (Mark)
>> >> - Omit unexporting of PIIXState (Mark)
>> >> - Improve commit message of patch 5 to mention reset triggering thro=
ugh PCI
>> >>   configuration space (Mark)
>> >> - Move reviewed patches w/o dependencies to the bottom of the series=
 for early
>> >>   upstreaming
>> >>=20
>> >> [1] https://lists=2Enongnu=2Eorg/archive/html/qemu-devel/2022-07/msg=
02348=2Ehtml
>> >> [2] https://lists=2Enongnu=2Eorg/archive/html/qemu-devel/2022-11/msg=
03310=2Ehtml
>> >> [3] https://lists=2Enongnu=2Eorg/archive/html/qemu-devel/2022-10/msg=
05367=2Ehtml
>> >>=20
>> >> Bernhard Beschow (29):
>> >>   hw/i386/pc: Merge two if statements into one
>> >>   hw/i386/pc_piix: Allow for setting properties before realizing PII=
X3
>> >>     south bridge
>> >>   hw/i386/pc_piix: Assign PIIX3's ISA interrupts before its realize(=
)
>> >>   hw/isa/piix3: Resolve redundant PIIX_NUM_PIC_IRQS
>> >>   hw/i386/pc_piix: Wire PIIX3's ISA interrupts by new "isa-irqs"
>> >>     property
>> >>   hw/i386/pc_piix: Remove redundant "piix3" variable
>> >>   hw/isa/piix3: Rename "pic" attribute to "isa_irqs_in"
>> >>   hw/i386/pc_q35: Wire ICH9 LPC function's interrupts before its
>> >>     realize()
>> >>   hw/isa/piix3: Wire PIC IRQs to ISA bus in host device
>> >>   hw/i386/pc: Wire RTC ISA IRQs in south bridges
>> >>   hw/isa/piix3: Create IDE controller in host device
>> >>   hw/isa/piix3: Create USB controller in host device
>> >>   hw/isa/piix3: Create power management controller in host device
>> >>   hw/isa/piix3: Drop the "3" from PIIX base class name
>> >>   hw/isa/piix4: Remove unused inbound ISA interrupt lines
>> >>   hw/isa/piix4: Rename "isa" attribute to "isa_irqs_in"
>> >>   hw/isa/piix4: Rename reset control operations to match PIIX3
>> >>   hw/isa/piix4: Reuse struct PIIXState from PIIX3
>> >>   hw/isa/piix3: Merge hw/isa/piix4=2Ec
>> >>   hw/isa/piix: Allow for optional PIC creation in PIIX3
>> >>   hw/isa/piix: Allow for optional PIT creation in PIIX3
>> >>   hw/isa/piix: Harmonize names of reset control memory regions
>> >>   hw/isa/piix: Share PIIX3's base class with PIIX4
>> >>   hw/isa/piix: Reuse PIIX3 base class' realize method in PIIX4
>> >>   hw/isa/piix: Rename functions to be shared for PCI interrupt
>> >>     triggering
>> >>   hw/isa/piix: Reuse PIIX3's PCI interrupt triggering in PIIX4
>> >>   hw/isa/piix: Resolve duplicate code regarding PCI interrupt wiring
>> >>   hw/isa/piix: Implement multi-process QEMU support also for PIIX4
>> >>   hw/i386/pc_piix: Make PIIX4 south bridge usable in PC machine
>> >>=20
>> >>  MAINTAINERS                          |   6 +-
>> >>  docs/system/target-i386-desc=2Erst=2Einc |   8 +
>> >>  include/hw/i386/pc=2Eh                 |   2 +
>> >>  include/hw/southbridge/piix=2Eh        |  28 ++-
>> >>  hw/i386/pc=2Ec                         |  13 +-
>> >>  hw/i386/pc_piix=2Ec                    | 125 ++++++++---
>> >>  hw/i386/pc_q35=2Ec                     |  14 +-
>> >>  hw/isa/lpc_ich9=2Ec                    |   9 +-
>> >>  hw/isa/{piix3=2Ec =3D> piix=2Ec}           | 281 ++++++++++++++++++=
-------
>> >>  hw/isa/piix4=2Ec                       | 302 ----------------------=
-----
>> >>  hw/mips/malta=2Ec                      |   5 +-
>> >>  hw/i386/Kconfig                      |   3 +-
>> >>  hw/isa/Kconfig                       |   8 +-
>> >>  hw/isa/meson=2Ebuild                   |   3 +-
>> >>  hw/mips/Kconfig                      |   2 +-
>> >>  15 files changed, 358 insertions(+), 451 deletions(-)
>> >>  rename hw/isa/{piix3=2Ec =3D> piix=2Ec} (52%)
>> >>  delete mode 100644 hw/isa/piix4=2Ec
>> >>=20
>> >
>

