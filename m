Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF817C5D42
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 20:58:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeOW-0008Rf-Sa; Wed, 11 Oct 2023 14:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qqeOU-0008RH-Ti
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:57:18 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qqeOS-0006Dr-KE
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:57:18 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so358819a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697050635; x=1697655435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20dnmj24OVYhlfvhpWf47MR6VVAs7rKl3c4de1YYiG4=;
 b=ithFZZGAgEGnkzwuxxBop38e6Yr/U3pnP+hKHqiisc4dbXVEqd1K+B8zJLM0TmE9MY
 6S2RX6SMAPuVb3o9gamHYm1GkX8807RvEQjWQa/Wtj2uZVC7CNeY3F6B0HaWWW1OFcOD
 IcTDxKbcD3xLXODA5bje0CJ+b139u20Gxbg2IvAVItI1L8vTl9xaamHDVsthZYCkOsVe
 ZyzXEI0n9YHAA2fVd2+phMwQwQexD7q/bLsdB6B8SOG24sed6EjV+7dreFUqFVgpf8eL
 td76DsPGaWwhyAr3ckH8SMUsOWtZS0N9Oe4iqrsAyLgQYoXQfpidANprXD2Zdabmf12K
 qpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697050635; x=1697655435;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=20dnmj24OVYhlfvhpWf47MR6VVAs7rKl3c4de1YYiG4=;
 b=lifsx2YkNWF3sLOm0U0ddhpKC5f7WiNGG126Kz2D1HXQuGiveuiDoEbX4+z/ypkKhE
 Aj/gumdf1a6K3zFRKFBN8IHUCr1rBaFxc9fWIdrWEnU0ZF7waPqf3iF+f3nqk1GAhxxj
 wV0Mj81Fte4X3oyLKPKlw/torImggpij9YsaH6mjVwY6sLHESv6rDRCKUF1RD3bDZWof
 cVexbwwyFXRPsMcTOAOR043TBH5vty76cpOGa7uVszhsCB+asGy39EMxJCgsOgUKTCf+
 f3+IyEdXaXdwC743uon8W1T/YDFp7ZcZl7O/OFmMPSrf4E+ILA8y8rwcQ/scTvjquKcQ
 jsDA==
X-Gm-Message-State: AOJu0YwxC00XqKQPXf3zKZv5Ntz8DV2DZZw2nnwJQZ5x1Ku18wjVjJDD
 Ti0AAaDl2lmLEmLxO7I+QTk=
X-Google-Smtp-Source: AGHT+IHtYDVP1tQKVWUnNIXOBz5xKZXSB/kDJDZHuc1NYhum4X5xg/0qIL9m5KE9/PPPTWpYtH/jHA==
X-Received: by 2002:aa7:d1d7:0:b0:52f:a42a:85a3 with SMTP id
 g23-20020aa7d1d7000000b0052fa42a85a3mr19055988edp.0.1697050634460; 
 Wed, 11 Oct 2023 11:57:14 -0700 (PDT)
Received: from ?IPv6:::1? ([2a02:8109:9c80:3e28:74fd:5759:c1f:28d7])
 by smtp.gmail.com with ESMTPSA id
 o14-20020aa7c50e000000b0052595b17fd4sm9111679edq.26.2023.10.11.11.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 11:57:13 -0700 (PDT)
Date: Wed, 11 Oct 2023 18:57:07 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Chuck Zmudzinski <brchuckz@aol.com>, qemu-devel@nongnu.org
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Eduardo Habkost <eduardo@habkost.net>, Aurelien Jarno <aurelien@aurel32.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [PATCH v8 00/29] Consolidate PIIX south bridges
In-Reply-To: <cf6a2f47-0130-4ac5-be1d-23aef2f3e87c@aol.com>
References: <20231007123843.127151-1-shentey@gmail.com>
 <cf6a2f47-0130-4ac5-be1d-23aef2f3e87c@aol.com>
Message-ID: <19E0EB2A-83F8-40A1-8A9E-FED0DACE2901@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
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



Am 8=2E Oktober 2023 17:56:48 UTC schrieb Chuck Zmudzinski <brchuckz@aol=
=2Ecom>:
>On 10/7/23 8:38 AM, Bernhard Beschow wrote:
>> This series consolidates the implementations of the PIIX3 and PIIX4 sou=
th
>> bridges and makes PIIX4 usable in the PC machine via an experimental co=
mmand
>> line parameter=2E The motivation is to resolve duplicate code between t=
he device
>> models as well as resolving the "Frankenstein" PIIX4-PM problem in PIIX=
3
>> discussed on this list before=2E
>>=20
>> The series is structured as follows:
>>=20
>> Patches 1-8 are preparational patches necessary for moving all sub devi=
ces into
>> PIIX3, like was done for PIIX4=2E In isolation these patches can also b=
e seen as
>> general x86 machine cleanup sub series which has merit in its own right=
 -- and
>> could be applied to master if the remainder of the series takes longer =
to
>> review=2E
>>=20
>> Patches 9-13 move PIIX3 sub devices into one device model like already
>> done for PIIX4=2E Together with the previous sub series these patches f=
orm a
>> bigger sub series which also has merit in its own right, and could be a=
pplied
>> independent of the remainder of this series as well=2E
>>=20
>> The remainder of this series consolidates the PIIX3 and PIIX4 device mo=
dels=2E
>> The culmination point is the last commit which makes PIIX4 usable in th=
e PC
>> machine=2E
>>=20
>> One challenge was dealing with optional devices where Peter already gav=
e advice
>> in [1] which this series implements=2E Although PIIX4 is now usable in =
the PC
>> machine it still has a different binary layout in its VM state=2E
>>=20
>> Testing done:
>> * `make check`
>> * `qemu-system-x86_64 -M pc -m 2G -accel kvm -cdrom
>>      manjaro-kde-21=2E3=2E2-220704-linux515=2Eiso`
>> * `qemu-system-x86_64 -M pc,x-south-bridge=3Dpiix4-isa -m 2G -accel kvm=
 -cdrom
>>      manjaro-kde-21=2E3=2E2-220704-linux515=2Eiso`
>> * `qemu-system-x86_64 -M q35 -m 2G -accel kvm -cdrom
>>      manjaro-kde-21=2E3=2E2-220704-linux515=2Eiso`
>> * `qemu-system-mips64el -M malta -cpu 5KEc -m 1G -kernel kernel -initrd=
 initrd
>>      -append "root=3DLABEL=3Drootfs console=3DttyS0" -drive file=3Dimag=
e=2Eqcow2`
>> * `qemu-system-mips64el -M malta -bios yamon-02=2E22=2Ebin`
>> * Run HVM domU guest under Xen with manjaro-kde-21=2E3=2E2-220704-linux=
515=2Eiso image
>
>I did some preliminary tests of this patch series on some Xen HVM domU gu=
ests I have
>that use the xenfv / pc machine and depend on the current PIIX3 implement=
ation=2E
>So far there are no regressions in my tests=2E I use libxl or libvirt to =
manage the
>Xen guests=2E

Thanks, nice to read!

>
>I have not (yet) tested the experimental option that makes PIIX4 useable =
in the xenfv / pc
>machines=2E IIUC, that would require a patch to hvmloader/pci=2Ec in Xen =
tools so Xen's
>hvmloader recognizes the PIIX4 pci device id [1], and a patch to libxl so=
 libxl can
>optionally launch qemu with the new experimental option enabled=2E
>
>Since this patch series affects the xenfv machine, I added the Xen x86 ma=
intainers to
>the Cc list and Jason Andryuk who is credited with discovering the necess=
ary patch to
>hvmloader/pci=2Ec=2E

Good idea=2E In the next iteration, I'll cc the respective email addresses=
 from the MAINTAINERS file which hopefully reaches all relevant people=2E

Best regards,
Bernhard

>
>[1] https://lore=2Ekernel=2Eorg/qemu-devel/B0FF78F4-1193-495B-919C-84A1FF=
8ADF12@gmail=2Ecom/
>
>>=20
>> v8:
>> - Wire ISA interrupts before device realization
>> - Optionally allow a PIC and PIT to be instantiated in PIIX3 for compat=
iblity
>>     with PIIX4
>> - Touch ICH9 LPC as far as required for PIIX consolidation
>> - Make PIIX4 usable in the PC machine via an experimental option
>> - Review and rework history, touching every commit and drop R-b tags wh=
en
>>     changes became too large
>>=20
>> v7:
>> - Rebase onto master
>> - Avoid the PIC proxy (Phil)
>>   The motivation for the PIC proxy was to allow for wiring up ISA inter=
rupts in
>>   the south bridges=2E ISA interrupt wiring requires the GPIO lines to =
be
>>   populated already but pc_piix assigned the interrupts only after real=
izing
>>   PIIX3=2E By shifting interrupt assignment before realizing, the ISA i=
nterrupts
>>   are already populated during PIIX3's realize phase where the ISA inte=
rrupts
>>   are wired up=2E
>> - New patches:
>>   * hw/isa/piix4: Reuse struct PIIXState from PIIX3
>>   * hw/isa/piix4: Create the "intr" property during init() already
>> - Patches with substantial changes (Reviewed-by dropped):
>>   * hw/isa/piix3: Move ISA bus IRQ assignments into host device
>>=20
>> v6:
>> - Fix some comments about TYPE_ISA_PIC (Mark) =2E=2E=2E and use it cons=
istently
>>   within the patch series=2E
>> - Incorporate series "[PATCH v2 0/3] Decouple INTx-to-LNKx routing from=
 south
>>   bridges" [2] for maintainer convenience=2E
>> - Merge v5's 'hw/i386/pc_piix: Associate pci_map_irq_fn as soon as PCI =
bus is
>>   created' into
>>   https://lists=2Enongnu=2Eorg/archive/html/qemu-devel/2022-11/msg03312=
=2Ehtml =2E Do
>>   similar for Malta=2E
>> - Rebase onto latest master (d6271b657286 "Merge tag 'for_upstream' of
>>   https://git=2Ekernel=2Eorg/pub/scm/virt/kvm/mst/qemu into staging")
>>=20
>> v5:
>> - Pick up Reviewed-by tags from https://lists=2Enongnu=2Eorg/archive/ht=
ml/qemu-devel/2023-01/msg00116=2Ehtml
>> - Add patch to make usage of the isa_pic global more type-safe
>> - Re-introduce isa-pic as PIC specific proxy (Mark)
>>=20
>> v4:
>> - Rebase onto "[PATCH v2 0/3] Decouple INTx-to-LNKx routing from south =
bridges"
>>   since it is already queued via mips-next=2E This eliminates patches
>>   'hw/isa/piix3: Prefix pci_slot_get_pirq() with "piix3_"' and 'hw/isa/=
piix4:
>>   Prefix pci_slot_get_pirq() with "piix4_"'=2E
>> - Squash 'hw/isa/piix: Drop the "3" from the PIIX base class' into
>>   'hw/isa/piix3: Rename typedef PIIX3State to PIIXState'=2E I originall=
y only
>>   split these patches since I wasn't sure whether renaming a type was a=
llowed=2E
>> - Add new patch 'hw/i386/pc_piix: Associate pci_map_irq_fn as soon as P=
CI bus is
>>   created' for forther cleanup of INTx-to-LNKx route decoupling=2E
>>=20
>> v3:
>> - Introduce one TYPE_ICH9_USB_UHCI(fn) rather than several TYPE_ICH9_US=
B_UHCIx
>>   (Philippe)
>> - Make proxy PIC generic (Philippe)
>> - Track Malta's PIIX dependencies through KConfig
>> - Rebase onto Philippe's 'hw/isa/piix4: Remove MIPS Malta specific bits=
' series [3]
>> - Also rebase onto latest master to resolve merge conflicts=2E This req=
uired
>>   copying Philippe's series as first three patches - please ignore=2E
>>=20
>> v2:
>> - Introduce TYPE_ defines for IDE and USB device models (Mark)
>> - Omit unexporting of PIIXState (Mark)
>> - Improve commit message of patch 5 to mention reset triggering through=
 PCI
>>   configuration space (Mark)
>> - Move reviewed patches w/o dependencies to the bottom of the series fo=
r early
>>   upstreaming
>>=20
>> [1] https://lists=2Enongnu=2Eorg/archive/html/qemu-devel/2022-07/msg023=
48=2Ehtml
>> [2] https://lists=2Enongnu=2Eorg/archive/html/qemu-devel/2022-11/msg033=
10=2Ehtml
>> [3] https://lists=2Enongnu=2Eorg/archive/html/qemu-devel/2022-10/msg053=
67=2Ehtml
>>=20
>> Bernhard Beschow (29):
>>   hw/i386/pc: Merge two if statements into one
>>   hw/i386/pc_piix: Allow for setting properties before realizing PIIX3
>>     south bridge
>>   hw/i386/pc_piix: Assign PIIX3's ISA interrupts before its realize()
>>   hw/isa/piix3: Resolve redundant PIIX_NUM_PIC_IRQS
>>   hw/i386/pc_piix: Wire PIIX3's ISA interrupts by new "isa-irqs"
>>     property
>>   hw/i386/pc_piix: Remove redundant "piix3" variable
>>   hw/isa/piix3: Rename "pic" attribute to "isa_irqs_in"
>>   hw/i386/pc_q35: Wire ICH9 LPC function's interrupts before its
>>     realize()
>>   hw/isa/piix3: Wire PIC IRQs to ISA bus in host device
>>   hw/i386/pc: Wire RTC ISA IRQs in south bridges
>>   hw/isa/piix3: Create IDE controller in host device
>>   hw/isa/piix3: Create USB controller in host device
>>   hw/isa/piix3: Create power management controller in host device
>>   hw/isa/piix3: Drop the "3" from PIIX base class name
>>   hw/isa/piix4: Remove unused inbound ISA interrupt lines
>>   hw/isa/piix4: Rename "isa" attribute to "isa_irqs_in"
>>   hw/isa/piix4: Rename reset control operations to match PIIX3
>>   hw/isa/piix4: Reuse struct PIIXState from PIIX3
>>   hw/isa/piix3: Merge hw/isa/piix4=2Ec
>>   hw/isa/piix: Allow for optional PIC creation in PIIX3
>>   hw/isa/piix: Allow for optional PIT creation in PIIX3
>>   hw/isa/piix: Harmonize names of reset control memory regions
>>   hw/isa/piix: Share PIIX3's base class with PIIX4
>>   hw/isa/piix: Reuse PIIX3 base class' realize method in PIIX4
>>   hw/isa/piix: Rename functions to be shared for PCI interrupt
>>     triggering
>>   hw/isa/piix: Reuse PIIX3's PCI interrupt triggering in PIIX4
>>   hw/isa/piix: Resolve duplicate code regarding PCI interrupt wiring
>>   hw/isa/piix: Implement multi-process QEMU support also for PIIX4
>>   hw/i386/pc_piix: Make PIIX4 south bridge usable in PC machine
>>=20
>>  MAINTAINERS                          |   6 +-
>>  docs/system/target-i386-desc=2Erst=2Einc |   8 +
>>  include/hw/i386/pc=2Eh                 |   2 +
>>  include/hw/southbridge/piix=2Eh        |  28 ++-
>>  hw/i386/pc=2Ec                         |  13 +-
>>  hw/i386/pc_piix=2Ec                    | 125 ++++++++---
>>  hw/i386/pc_q35=2Ec                     |  14 +-
>>  hw/isa/lpc_ich9=2Ec                    |   9 +-
>>  hw/isa/{piix3=2Ec =3D> piix=2Ec}           | 281 ++++++++++++++++++---=
----
>>  hw/isa/piix4=2Ec                       | 302 -------------------------=
--
>>  hw/mips/malta=2Ec                      |   5 +-
>>  hw/i386/Kconfig                      |   3 +-
>>  hw/isa/Kconfig                       |   8 +-
>>  hw/isa/meson=2Ebuild                   |   3 +-
>>  hw/mips/Kconfig                      |   2 +-
>>  15 files changed, 358 insertions(+), 451 deletions(-)
>>  rename hw/isa/{piix3=2Ec =3D> piix=2Ec} (52%)
>>  delete mode 100644 hw/isa/piix4=2Ec
>>=20
>

