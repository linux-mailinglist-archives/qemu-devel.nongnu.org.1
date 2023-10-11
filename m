Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4CD7C5E44
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:21:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqfhe-0001Q0-MC; Wed, 11 Oct 2023 16:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qqfhd-0001Pr-Bb
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qqfhZ-0008Km-1O
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697055659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y222lAWO1sYBpwoUCeRouW0KwOWD3y4ScqDrsJOEbx8=;
 b=IlPL73QF5VWjWUylG7/pUrG0ikEq75XFS4E0VBxsUDScT5R6T6eSYXWhqeO5bAeJvDPkA7
 Ge7wnIzmMidkmFIcGEHaaOzFTmFTJbQm+KPLWDQaZdCeIxLSwH3qwLbBEVbuCyMl0j9Cec
 UzKePytFDztOple+Gnrl7UT0jO4PH/o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-LvCU3ZtpOJa7V-9kyuA2kw-1; Wed, 11 Oct 2023 16:18:06 -0400
X-MC-Unique: LvCU3ZtpOJa7V-9kyuA2kw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40554735995so2674245e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 13:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697055485; x=1697660285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y222lAWO1sYBpwoUCeRouW0KwOWD3y4ScqDrsJOEbx8=;
 b=FMwCX68PlUqLF+c1/ZAhyiKNQo3mubgdB5/EYgIxdtQcQJ9hbg7ERNDhFfMjbhSEZt
 9RpvmhqL1N53m/ttnQ5MAXBpiUhcUwxf2E3/Piazi9nxJxEVK2kpXHaRBUYmvSPgne4C
 fYSU9IrWmjvacjuAF/sZHkH0HBSgj9gO+Mn3f0afwlfM/jtGrIx5OkmElYzzIwdAtfjm
 Yx3bOIqK2foxt46u5ka4dLDvn6QfJdrwV1IVYknJxWFoFqnBU2Djpyaac4L8/Up3hbG3
 tTHEaYwj3cOHVkY2XOAHH/l8bGuj/j3tH/Mtv5Z/159xWso92JtY3CMHXznIchcDxLII
 qAsA==
X-Gm-Message-State: AOJu0YzCe0640mL/mN0mv0h249pEgJLhsZQGR+xLB+SEqyAuuWM9u0Fo
 B2fsc6eLuwuSrkRrB+lTxCTuDoDqwbXjgyWJDefTgj77INVbzjJAseYArKEyKEjh5sfgVmM0oTz
 iC59a7Hmin+3gWN0=
X-Received: by 2002:a1c:f202:0:b0:407:5ad0:ab5b with SMTP id
 s2-20020a1cf202000000b004075ad0ab5bmr4144839wmc.8.1697055485004; 
 Wed, 11 Oct 2023 13:18:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE75sJwKArI4B8qsUyRu5nPW2KnztteeakCK+UWvDheu5hGEUAq72TML5evGH7jBwkwmBclyQ==
X-Received: by 2002:a1c:f202:0:b0:407:5ad0:ab5b with SMTP id
 s2-20020a1cf202000000b004075ad0ab5bmr4144815wmc.8.1697055484578; 
 Wed, 11 Oct 2023 13:18:04 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a1c6a13000000b00402d34ea099sm19864432wmc.29.2023.10.11.13.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 13:18:03 -0700 (PDT)
Date: Wed, 11 Oct 2023 16:18:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: Chuck Zmudzinski <brchuckz@aol.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [PATCH v8 00/29] Consolidate PIIX south bridges
Message-ID: <20231011161742-mutt-send-email-mst@kernel.org>
References: <20231007123843.127151-1-shentey@gmail.com>
 <cf6a2f47-0130-4ac5-be1d-23aef2f3e87c@aol.com>
 <19E0EB2A-83F8-40A1-8A9E-FED0DACE2901@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19E0EB2A-83F8-40A1-8A9E-FED0DACE2901@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 11, 2023 at 06:57:07PM +0000, Bernhard Beschow wrote:
> 
> 
> Am 8. Oktober 2023 17:56:48 UTC schrieb Chuck Zmudzinski <brchuckz@aol.com>:
> >On 10/7/23 8:38 AM, Bernhard Beschow wrote:
> >> This series consolidates the implementations of the PIIX3 and PIIX4 south
> >> bridges and makes PIIX4 usable in the PC machine via an experimental command
> >> line parameter. The motivation is to resolve duplicate code between the device
> >> models as well as resolving the "Frankenstein" PIIX4-PM problem in PIIX3
> >> discussed on this list before.
> >> 
> >> The series is structured as follows:
> >> 
> >> Patches 1-8 are preparational patches necessary for moving all sub devices into
> >> PIIX3, like was done for PIIX4. In isolation these patches can also be seen as
> >> general x86 machine cleanup sub series which has merit in its own right -- and
> >> could be applied to master if the remainder of the series takes longer to
> >> review.
> >> 
> >> Patches 9-13 move PIIX3 sub devices into one device model like already
> >> done for PIIX4. Together with the previous sub series these patches form a
> >> bigger sub series which also has merit in its own right, and could be applied
> >> independent of the remainder of this series as well.
> >> 
> >> The remainder of this series consolidates the PIIX3 and PIIX4 device models.
> >> The culmination point is the last commit which makes PIIX4 usable in the PC
> >> machine.
> >> 
> >> One challenge was dealing with optional devices where Peter already gave advice
> >> in [1] which this series implements. Although PIIX4 is now usable in the PC
> >> machine it still has a different binary layout in its VM state.
> >> 
> >> Testing done:
> >> * `make check`
> >> * `qemu-system-x86_64 -M pc -m 2G -accel kvm -cdrom
> >>      manjaro-kde-21.3.2-220704-linux515.iso`
> >> * `qemu-system-x86_64 -M pc,x-south-bridge=piix4-isa -m 2G -accel kvm -cdrom
> >>      manjaro-kde-21.3.2-220704-linux515.iso`
> >> * `qemu-system-x86_64 -M q35 -m 2G -accel kvm -cdrom
> >>      manjaro-kde-21.3.2-220704-linux515.iso`
> >> * `qemu-system-mips64el -M malta -cpu 5KEc -m 1G -kernel kernel -initrd initrd
> >>      -append "root=LABEL=rootfs console=ttyS0" -drive file=image.qcow2`
> >> * `qemu-system-mips64el -M malta -bios yamon-02.22.bin`
> >> * Run HVM domU guest under Xen with manjaro-kde-21.3.2-220704-linux515.iso image
> >
> >I did some preliminary tests of this patch series on some Xen HVM domU guests I have
> >that use the xenfv / pc machine and depend on the current PIIX3 implementation.
> >So far there are no regressions in my tests. I use libxl or libvirt to manage the
> >Xen guests.
> 
> Thanks, nice to read!
> 
> >
> >I have not (yet) tested the experimental option that makes PIIX4 useable in the xenfv / pc
> >machines. IIUC, that would require a patch to hvmloader/pci.c in Xen tools so Xen's
> >hvmloader recognizes the PIIX4 pci device id [1], and a patch to libxl so libxl can
> >optionally launch qemu with the new experimental option enabled.
> >
> >Since this patch series affects the xenfv machine, I added the Xen x86 maintainers to
> >the Cc list and Jason Andryuk who is credited with discovering the necessary patch to
> >hvmloader/pci.c.
> 
> Good idea. In the next iteration, I'll cc the respective email addresses from the MAINTAINERS file which hopefully reaches all relevant people.

there will be a next version then?

> Best regards,
> Bernhard
> 
> >
> >[1] https://lore.kernel.org/qemu-devel/B0FF78F4-1193-495B-919C-84A1FF8ADF12@gmail.com/
> >
> >> 
> >> v8:
> >> - Wire ISA interrupts before device realization
> >> - Optionally allow a PIC and PIT to be instantiated in PIIX3 for compatiblity
> >>     with PIIX4
> >> - Touch ICH9 LPC as far as required for PIIX consolidation
> >> - Make PIIX4 usable in the PC machine via an experimental option
> >> - Review and rework history, touching every commit and drop R-b tags when
> >>     changes became too large
> >> 
> >> v7:
> >> - Rebase onto master
> >> - Avoid the PIC proxy (Phil)
> >>   The motivation for the PIC proxy was to allow for wiring up ISA interrupts in
> >>   the south bridges. ISA interrupt wiring requires the GPIO lines to be
> >>   populated already but pc_piix assigned the interrupts only after realizing
> >>   PIIX3. By shifting interrupt assignment before realizing, the ISA interrupts
> >>   are already populated during PIIX3's realize phase where the ISA interrupts
> >>   are wired up.
> >> - New patches:
> >>   * hw/isa/piix4: Reuse struct PIIXState from PIIX3
> >>   * hw/isa/piix4: Create the "intr" property during init() already
> >> - Patches with substantial changes (Reviewed-by dropped):
> >>   * hw/isa/piix3: Move ISA bus IRQ assignments into host device
> >> 
> >> v6:
> >> - Fix some comments about TYPE_ISA_PIC (Mark) ... and use it consistently
> >>   within the patch series.
> >> - Incorporate series "[PATCH v2 0/3] Decouple INTx-to-LNKx routing from south
> >>   bridges" [2] for maintainer convenience.
> >> - Merge v5's 'hw/i386/pc_piix: Associate pci_map_irq_fn as soon as PCI bus is
> >>   created' into
> >>   https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg03312.html . Do
> >>   similar for Malta.
> >> - Rebase onto latest master (d6271b657286 "Merge tag 'for_upstream' of
> >>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging")
> >> 
> >> v5:
> >> - Pick up Reviewed-by tags from https://lists.nongnu.org/archive/html/qemu-devel/2023-01/msg00116.html
> >> - Add patch to make usage of the isa_pic global more type-safe
> >> - Re-introduce isa-pic as PIC specific proxy (Mark)
> >> 
> >> v4:
> >> - Rebase onto "[PATCH v2 0/3] Decouple INTx-to-LNKx routing from south bridges"
> >>   since it is already queued via mips-next. This eliminates patches
> >>   'hw/isa/piix3: Prefix pci_slot_get_pirq() with "piix3_"' and 'hw/isa/piix4:
> >>   Prefix pci_slot_get_pirq() with "piix4_"'.
> >> - Squash 'hw/isa/piix: Drop the "3" from the PIIX base class' into
> >>   'hw/isa/piix3: Rename typedef PIIX3State to PIIXState'. I originally only
> >>   split these patches since I wasn't sure whether renaming a type was allowed.
> >> - Add new patch 'hw/i386/pc_piix: Associate pci_map_irq_fn as soon as PCI bus is
> >>   created' for forther cleanup of INTx-to-LNKx route decoupling.
> >> 
> >> v3:
> >> - Introduce one TYPE_ICH9_USB_UHCI(fn) rather than several TYPE_ICH9_USB_UHCIx
> >>   (Philippe)
> >> - Make proxy PIC generic (Philippe)
> >> - Track Malta's PIIX dependencies through KConfig
> >> - Rebase onto Philippe's 'hw/isa/piix4: Remove MIPS Malta specific bits' series [3]
> >> - Also rebase onto latest master to resolve merge conflicts. This required
> >>   copying Philippe's series as first three patches - please ignore.
> >> 
> >> v2:
> >> - Introduce TYPE_ defines for IDE and USB device models (Mark)
> >> - Omit unexporting of PIIXState (Mark)
> >> - Improve commit message of patch 5 to mention reset triggering through PCI
> >>   configuration space (Mark)
> >> - Move reviewed patches w/o dependencies to the bottom of the series for early
> >>   upstreaming
> >> 
> >> [1] https://lists.nongnu.org/archive/html/qemu-devel/2022-07/msg02348.html
> >> [2] https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg03310.html
> >> [3] https://lists.nongnu.org/archive/html/qemu-devel/2022-10/msg05367.html
> >> 
> >> Bernhard Beschow (29):
> >>   hw/i386/pc: Merge two if statements into one
> >>   hw/i386/pc_piix: Allow for setting properties before realizing PIIX3
> >>     south bridge
> >>   hw/i386/pc_piix: Assign PIIX3's ISA interrupts before its realize()
> >>   hw/isa/piix3: Resolve redundant PIIX_NUM_PIC_IRQS
> >>   hw/i386/pc_piix: Wire PIIX3's ISA interrupts by new "isa-irqs"
> >>     property
> >>   hw/i386/pc_piix: Remove redundant "piix3" variable
> >>   hw/isa/piix3: Rename "pic" attribute to "isa_irqs_in"
> >>   hw/i386/pc_q35: Wire ICH9 LPC function's interrupts before its
> >>     realize()
> >>   hw/isa/piix3: Wire PIC IRQs to ISA bus in host device
> >>   hw/i386/pc: Wire RTC ISA IRQs in south bridges
> >>   hw/isa/piix3: Create IDE controller in host device
> >>   hw/isa/piix3: Create USB controller in host device
> >>   hw/isa/piix3: Create power management controller in host device
> >>   hw/isa/piix3: Drop the "3" from PIIX base class name
> >>   hw/isa/piix4: Remove unused inbound ISA interrupt lines
> >>   hw/isa/piix4: Rename "isa" attribute to "isa_irqs_in"
> >>   hw/isa/piix4: Rename reset control operations to match PIIX3
> >>   hw/isa/piix4: Reuse struct PIIXState from PIIX3
> >>   hw/isa/piix3: Merge hw/isa/piix4.c
> >>   hw/isa/piix: Allow for optional PIC creation in PIIX3
> >>   hw/isa/piix: Allow for optional PIT creation in PIIX3
> >>   hw/isa/piix: Harmonize names of reset control memory regions
> >>   hw/isa/piix: Share PIIX3's base class with PIIX4
> >>   hw/isa/piix: Reuse PIIX3 base class' realize method in PIIX4
> >>   hw/isa/piix: Rename functions to be shared for PCI interrupt
> >>     triggering
> >>   hw/isa/piix: Reuse PIIX3's PCI interrupt triggering in PIIX4
> >>   hw/isa/piix: Resolve duplicate code regarding PCI interrupt wiring
> >>   hw/isa/piix: Implement multi-process QEMU support also for PIIX4
> >>   hw/i386/pc_piix: Make PIIX4 south bridge usable in PC machine
> >> 
> >>  MAINTAINERS                          |   6 +-
> >>  docs/system/target-i386-desc.rst.inc |   8 +
> >>  include/hw/i386/pc.h                 |   2 +
> >>  include/hw/southbridge/piix.h        |  28 ++-
> >>  hw/i386/pc.c                         |  13 +-
> >>  hw/i386/pc_piix.c                    | 125 ++++++++---
> >>  hw/i386/pc_q35.c                     |  14 +-
> >>  hw/isa/lpc_ich9.c                    |   9 +-
> >>  hw/isa/{piix3.c => piix.c}           | 281 ++++++++++++++++++-------
> >>  hw/isa/piix4.c                       | 302 ---------------------------
> >>  hw/mips/malta.c                      |   5 +-
> >>  hw/i386/Kconfig                      |   3 +-
> >>  hw/isa/Kconfig                       |   8 +-
> >>  hw/isa/meson.build                   |   3 +-
> >>  hw/mips/Kconfig                      |   2 +-
> >>  15 files changed, 358 insertions(+), 451 deletions(-)
> >>  rename hw/isa/{piix3.c => piix.c} (52%)
> >>  delete mode 100644 hw/isa/piix4.c
> >> 
> >


