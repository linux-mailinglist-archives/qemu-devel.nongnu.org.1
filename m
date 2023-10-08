Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F817BCF78
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 19:58:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpY1X-0003RE-1U; Sun, 08 Oct 2023 13:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aim.com>) id 1qpY1U-0003Qq-O7
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 13:57:00 -0400
Received: from sonic306-20.consmr.mail.gq1.yahoo.com ([98.137.68.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aim.com>) id 1qpY1S-0007xX-Hq
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 13:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1696787814; bh=pvgJkpXlhRXL/YwvOA6ho+xeIG1W9MzOz2MNb8ClUzM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=hP0s0Rwncn1h/gdjW0h3/dZQlWTGlxaddPynwvHkeWs8iUciHwLpnZ9DeUAIYhzprmtZgDc2EEjY+pufhIxk5a31E9cthwkLDOudXaP+X8DupBm3PtUhPTcpchhJ4WQG3kA9V7jIhnvzbnC73aENev1zscaU3sXOI3ypVqB3XtKNDrXmNEfPUj64wGUYsFRJRaEzH6dJt9DitKP8XG3/B8pXLmewXiDEIZ7zOeykLCO1dhFlqPoM/vc9LwOXdKdkCy+uW7RqrAMvvFW5t7g3EdDsxaY7cQYf62xBuWBMmhBIyuxBL1Fm7BdqS7vwqi8nGQmirmb4O7DH+a23wQBBwQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1696787814; bh=cP8Y5/DkcVqN4/n73rmKXc/P+PC/X2XI4IhnHDACQsd=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=HYjCDlqPxbmEPNj22DWSBZwUsSMfkTVbwszQveaP0ianZ92dzu5M5kTD8DaqLAf58MoPTwknb0GViemfBPABUm0RFmfXl4oX8NOpeQ/42WXjXoII74m9R/pvRDCTl/icn+t91Ps6YlmEY/OjdoFrYkeQYVbKqZ9P7CWfgK2RmlxaYkjAyKb8FGdDUlntfLrnCjop9q94HpNWv5B0tDGZyAqlHQM++2XVBLHPWmMavjPuOUCET8X1U34n2F+BuKqEYfRy9pIk3TXL3nIZP8etKzoG9MGsI/4eXM+BeHCkQzOmpHOio5Lip7tCPbm5/iAwksyiu5Lj0pXCZiOeBELqRA==
X-YMail-OSG: lPmPlvkVM1niU5FTj_CYhQbAguu.h791CtNYDFPaUI6o0Q6S326HNeGC4_4xLCz
 Q3IjlgGMkco9ZKnbAos2CY9nDm18pUTi6HjNZH_lAZFCMPVV7VDwKb074x6ri_s2Tg5Gj4ZqaWWO
 gRpoFSFc9BHoh1QSFon4wxn0qHZ8LeAvKnA28JKA_YL8UXLDkW3BcioqMc7q3L3fA3aEgphmlf4t
 8VDK2PK_GtNR_SpoY5H4K8ets_SCn2BaWsOm86pXkFOqjK58CnXYZzOrYaX73uupmTUrkosBs4Zx
 4ZIrbqsgEuD.4g9b5hek3V5CqdcdnD6vLLUL1SC4kCWGSD5ZhDTDg1UkALYT58MKfAUXvyQ559AA
 p.hbyPPjkLoXt8In5DXEFoP1wox4nnM64DkBsgz.Eztw.ov5d8VFe5XZcUVarhx2V_tXFnN9Wo7D
 XRs9ELxPRUohIw0o7IL5Je5hNbIChW5Qe0.AMVnb4UGcWK41JP7_WDICwiyjt7LM2VFxrDPDUv6b
 ybM4aK5cns1CeE3CNapM40rLAilvjSoWpJTq8TKLFAFlZvcKA4cPl5bZ0S5B.T7GIJNXmWAejIcW
 dJH8lVL.ME6o82CBypn5LnSahoeCq3nFL4uBesN47uEI5MH.50dijtcuLtev338BpEp58CiyKguX
 gGz_XzVR2ZhqLqtENejgd5Rzlf59.J.iF6BvDjbiM1xB38aKaXy3mOPSII3907S7R2dVyNcTeu.v
 M0wi2xPQIq26UJhGaqy1C.nvNjXEGNXUQMJegaYwLWmph5SeNMQhZAygzHY2JavopoDa24dZ3upX
 eSwetkHWknsmGgG7jtQx6UJkV.yMfzd6ZDW8oPaHQQDHMhUV7ujlXydKWnEy.7LhzFWFBdSqZPTT
 ._I3Ex28vEIPBzhvlZx1jd1XdMxIZuMS5ftPGQajFj3WgJC_cLuMW35yXNNtbB.nKOAJhf245Mxf
 enF26gWfCphI5bb7fjduvlc7QjBMrT66bA9btAVuS1ODRlQBlZNmdXkGKO57q_7tjEozRuqLlrE0
 rDBNfUZJlJW1XflTSiYe1Ca1QdEmg2lrh6R9Sc0526DavzTUpO.2ZJdoxGsPiX0PruSEp0A66NpK
 da23eC6NuJNcWZHMv3wwdUa8eu_1p6UGvJqYgM6IAPV_G3eNmvWiTtVjeb2..739eQoF7bqjL4_2
 aeri6SjE0cWppRCQKRDoM.W1TN8FDU6NRVz20dtm_Q3oAQNGA0yLsN08RrDZY0_2LzIujrVq6fXU
 RysF6DQWHEaDSlWklz_DKUl_HGQ7xziLAke63E1mE1nG3s4flNRQp4RQYboD6TFGPz9kg0irnKPZ
 x4hojs05yZ9ki5MsS.lygTycPa1DJgbAe4y34p91ymmnE5Pp0w_4.xvfQsSeaV9rcqJN.ioqZKwd
 3.4qlwNewUZZhxUkdtnJbmaiIMpES3_LPrk9d5N4z9Lb4v8t1oPAgXqo6Mk_vu8310tfWUsCfbWc
 NSPRXm9zF2v_LS9ZdB_mxnJPhc72vhaeLUoZLIQp0lYvIH45fum9kfXmzb5tXSeFxP7rjB019DHV
 0HQPBwmnk5Gm9iL3sEjbN_JP9iEbkpgeROLKCkZZE8mr4wpQO3hrZ96XoXaYPSL0R1poQilHVj5W
 tMNsyZKAOoh1efY34ZTnRNaw1swRFTjcQVV9teWzoxK5HRPyQ0EJO4.ToD3_dWYlPgVzBNvgFmTR
 McSxFsYi_gMF2tQJ2_vIXU8fF8DaOfWNzQNpfPYbnGVkQcgogCYLHou6cfMOAbL7EqIHAWiAs3RU
 PAMrw5._4ckZEcQqEjdWAqIGKHq5YzNp36exAy_DuyEaYVRDyxRtYKjMUS5jgCeQ3_pl2odhECHB
 ctDF.hdPj5v7gB7ccaWvYASwMtNzlGLeA1CUVzphuipFwQZqFFYld6OQY7Ja0gIaibwVt1NUOogZ
 Mle2oQpRYn6gpTeEmfiZi7li4.qPVdVa9p8_4bt2ZxZBXuWwVOJ12g2OETyCPCHNMPOEdJHY8Teo
 4R_nOvgOUuvxYL4fvn8JyLtYrCX66Lydl1LxthR7seyRF6Oukuo1bLV1hLDkRvWnQd5axwOpTsKF
 VLfqIBzWLC2Br1Z0Cytn8P_n8PdK8DjsLueDa7B_uAJuf56r4h0uifNMCOjQVjexSQKuakd1A7bT
 rdqfi3jKTgiwppFE3q3mElZj4nGNTtB6Z3hRFHjneHAx3fHT3sxEx0jG.5BXp31Av_DvjaFtuY8W
 v7nsexKhFdszKaOThC3YIDZNQ
X-Sonic-MF: <brchuckz@aim.com>
X-Sonic-ID: 52ddbfa6-bc94-4d79-b8d1-849a3d7d6598
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sun, 8 Oct 2023 17:56:54 +0000
Received: by hermes--production-ne1-57ddc4969d-84fqw (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 3c5b1474e602fbe4c27aaddd5b29d1c1; 
 Sun, 08 Oct 2023 17:56:50 +0000 (UTC)
Message-ID: <cf6a2f47-0130-4ac5-be1d-23aef2f3e87c@aol.com>
Date: Sun, 8 Oct 2023 13:56:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/29] Consolidate PIIX south bridges
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Eduardo Habkost <eduardo@habkost.net>, Aurelien Jarno
 <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Jason Andryuk <jandryuk@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@aol.com>
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.68.83; envelope-from=brchuckz@aim.com;
 helo=sonic306-20.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On 10/7/23 8:38 AM, Bernhard Beschow wrote:
> This series consolidates the implementations of the PIIX3 and PIIX4 south
> bridges and makes PIIX4 usable in the PC machine via an experimental command
> line parameter. The motivation is to resolve duplicate code between the device
> models as well as resolving the "Frankenstein" PIIX4-PM problem in PIIX3
> discussed on this list before.
> 
> The series is structured as follows:
> 
> Patches 1-8 are preparational patches necessary for moving all sub devices into
> PIIX3, like was done for PIIX4. In isolation these patches can also be seen as
> general x86 machine cleanup sub series which has merit in its own right -- and
> could be applied to master if the remainder of the series takes longer to
> review.
> 
> Patches 9-13 move PIIX3 sub devices into one device model like already
> done for PIIX4. Together with the previous sub series these patches form a
> bigger sub series which also has merit in its own right, and could be applied
> independent of the remainder of this series as well.
> 
> The remainder of this series consolidates the PIIX3 and PIIX4 device models.
> The culmination point is the last commit which makes PIIX4 usable in the PC
> machine.
> 
> One challenge was dealing with optional devices where Peter already gave advice
> in [1] which this series implements. Although PIIX4 is now usable in the PC
> machine it still has a different binary layout in its VM state.
> 
> Testing done:
> * `make check`
> * `qemu-system-x86_64 -M pc -m 2G -accel kvm -cdrom
>      manjaro-kde-21.3.2-220704-linux515.iso`
> * `qemu-system-x86_64 -M pc,x-south-bridge=piix4-isa -m 2G -accel kvm -cdrom
>      manjaro-kde-21.3.2-220704-linux515.iso`
> * `qemu-system-x86_64 -M q35 -m 2G -accel kvm -cdrom
>      manjaro-kde-21.3.2-220704-linux515.iso`
> * `qemu-system-mips64el -M malta -cpu 5KEc -m 1G -kernel kernel -initrd initrd
>      -append "root=LABEL=rootfs console=ttyS0" -drive file=image.qcow2`
> * `qemu-system-mips64el -M malta -bios yamon-02.22.bin`
> * Run HVM domU guest under Xen with manjaro-kde-21.3.2-220704-linux515.iso image

I did some preliminary tests of this patch series on some Xen HVM domU guests I have
that use the xenfv / pc machine and depend on the current PIIX3 implementation.
So far there are no regressions in my tests. I use libxl or libvirt to manage the
Xen guests.

I have not (yet) tested the experimental option that makes PIIX4 useable in the xenfv / pc
machines. IIUC, that would require a patch to hvmloader/pci.c in Xen tools so Xen's
hvmloader recognizes the PIIX4 pci device id [1], and a patch to libxl so libxl can
optionally launch qemu with the new experimental option enabled.

Since this patch series affects the xenfv machine, I added the Xen x86 maintainers to
the Cc list and Jason Andryuk who is credited with discovering the necessary patch to
hvmloader/pci.c.

[1] https://lore.kernel.org/qemu-devel/B0FF78F4-1193-495B-919C-84A1FF8ADF12@gmail.com/

> 
> v8:
> - Wire ISA interrupts before device realization
> - Optionally allow a PIC and PIT to be instantiated in PIIX3 for compatiblity
>     with PIIX4
> - Touch ICH9 LPC as far as required for PIIX consolidation
> - Make PIIX4 usable in the PC machine via an experimental option
> - Review and rework history, touching every commit and drop R-b tags when
>     changes became too large
> 
> v7:
> - Rebase onto master
> - Avoid the PIC proxy (Phil)
>   The motivation for the PIC proxy was to allow for wiring up ISA interrupts in
>   the south bridges. ISA interrupt wiring requires the GPIO lines to be
>   populated already but pc_piix assigned the interrupts only after realizing
>   PIIX3. By shifting interrupt assignment before realizing, the ISA interrupts
>   are already populated during PIIX3's realize phase where the ISA interrupts
>   are wired up.
> - New patches:
>   * hw/isa/piix4: Reuse struct PIIXState from PIIX3
>   * hw/isa/piix4: Create the "intr" property during init() already
> - Patches with substantial changes (Reviewed-by dropped):
>   * hw/isa/piix3: Move ISA bus IRQ assignments into host device
> 
> v6:
> - Fix some comments about TYPE_ISA_PIC (Mark) ... and use it consistently
>   within the patch series.
> - Incorporate series "[PATCH v2 0/3] Decouple INTx-to-LNKx routing from south
>   bridges" [2] for maintainer convenience.
> - Merge v5's 'hw/i386/pc_piix: Associate pci_map_irq_fn as soon as PCI bus is
>   created' into
>   https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg03312.html . Do
>   similar for Malta.
> - Rebase onto latest master (d6271b657286 "Merge tag 'for_upstream' of
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging")
> 
> v5:
> - Pick up Reviewed-by tags from https://lists.nongnu.org/archive/html/qemu-devel/2023-01/msg00116.html
> - Add patch to make usage of the isa_pic global more type-safe
> - Re-introduce isa-pic as PIC specific proxy (Mark)
> 
> v4:
> - Rebase onto "[PATCH v2 0/3] Decouple INTx-to-LNKx routing from south bridges"
>   since it is already queued via mips-next. This eliminates patches
>   'hw/isa/piix3: Prefix pci_slot_get_pirq() with "piix3_"' and 'hw/isa/piix4:
>   Prefix pci_slot_get_pirq() with "piix4_"'.
> - Squash 'hw/isa/piix: Drop the "3" from the PIIX base class' into
>   'hw/isa/piix3: Rename typedef PIIX3State to PIIXState'. I originally only
>   split these patches since I wasn't sure whether renaming a type was allowed.
> - Add new patch 'hw/i386/pc_piix: Associate pci_map_irq_fn as soon as PCI bus is
>   created' for forther cleanup of INTx-to-LNKx route decoupling.
> 
> v3:
> - Introduce one TYPE_ICH9_USB_UHCI(fn) rather than several TYPE_ICH9_USB_UHCIx
>   (Philippe)
> - Make proxy PIC generic (Philippe)
> - Track Malta's PIIX dependencies through KConfig
> - Rebase onto Philippe's 'hw/isa/piix4: Remove MIPS Malta specific bits' series [3]
> - Also rebase onto latest master to resolve merge conflicts. This required
>   copying Philippe's series as first three patches - please ignore.
> 
> v2:
> - Introduce TYPE_ defines for IDE and USB device models (Mark)
> - Omit unexporting of PIIXState (Mark)
> - Improve commit message of patch 5 to mention reset triggering through PCI
>   configuration space (Mark)
> - Move reviewed patches w/o dependencies to the bottom of the series for early
>   upstreaming
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2022-07/msg02348.html
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg03310.html
> [3] https://lists.nongnu.org/archive/html/qemu-devel/2022-10/msg05367.html
> 
> Bernhard Beschow (29):
>   hw/i386/pc: Merge two if statements into one
>   hw/i386/pc_piix: Allow for setting properties before realizing PIIX3
>     south bridge
>   hw/i386/pc_piix: Assign PIIX3's ISA interrupts before its realize()
>   hw/isa/piix3: Resolve redundant PIIX_NUM_PIC_IRQS
>   hw/i386/pc_piix: Wire PIIX3's ISA interrupts by new "isa-irqs"
>     property
>   hw/i386/pc_piix: Remove redundant "piix3" variable
>   hw/isa/piix3: Rename "pic" attribute to "isa_irqs_in"
>   hw/i386/pc_q35: Wire ICH9 LPC function's interrupts before its
>     realize()
>   hw/isa/piix3: Wire PIC IRQs to ISA bus in host device
>   hw/i386/pc: Wire RTC ISA IRQs in south bridges
>   hw/isa/piix3: Create IDE controller in host device
>   hw/isa/piix3: Create USB controller in host device
>   hw/isa/piix3: Create power management controller in host device
>   hw/isa/piix3: Drop the "3" from PIIX base class name
>   hw/isa/piix4: Remove unused inbound ISA interrupt lines
>   hw/isa/piix4: Rename "isa" attribute to "isa_irqs_in"
>   hw/isa/piix4: Rename reset control operations to match PIIX3
>   hw/isa/piix4: Reuse struct PIIXState from PIIX3
>   hw/isa/piix3: Merge hw/isa/piix4.c
>   hw/isa/piix: Allow for optional PIC creation in PIIX3
>   hw/isa/piix: Allow for optional PIT creation in PIIX3
>   hw/isa/piix: Harmonize names of reset control memory regions
>   hw/isa/piix: Share PIIX3's base class with PIIX4
>   hw/isa/piix: Reuse PIIX3 base class' realize method in PIIX4
>   hw/isa/piix: Rename functions to be shared for PCI interrupt
>     triggering
>   hw/isa/piix: Reuse PIIX3's PCI interrupt triggering in PIIX4
>   hw/isa/piix: Resolve duplicate code regarding PCI interrupt wiring
>   hw/isa/piix: Implement multi-process QEMU support also for PIIX4
>   hw/i386/pc_piix: Make PIIX4 south bridge usable in PC machine
> 
>  MAINTAINERS                          |   6 +-
>  docs/system/target-i386-desc.rst.inc |   8 +
>  include/hw/i386/pc.h                 |   2 +
>  include/hw/southbridge/piix.h        |  28 ++-
>  hw/i386/pc.c                         |  13 +-
>  hw/i386/pc_piix.c                    | 125 ++++++++---
>  hw/i386/pc_q35.c                     |  14 +-
>  hw/isa/lpc_ich9.c                    |   9 +-
>  hw/isa/{piix3.c => piix.c}           | 281 ++++++++++++++++++-------
>  hw/isa/piix4.c                       | 302 ---------------------------
>  hw/mips/malta.c                      |   5 +-
>  hw/i386/Kconfig                      |   3 +-
>  hw/isa/Kconfig                       |   8 +-
>  hw/isa/meson.build                   |   3 +-
>  hw/mips/Kconfig                      |   2 +-
>  15 files changed, 358 insertions(+), 451 deletions(-)
>  rename hw/isa/{piix3.c => piix.c} (52%)
>  delete mode 100644 hw/isa/piix4.c
> 


