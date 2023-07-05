Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8B7490F9
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 00:25:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHAvB-0000Do-B9; Wed, 05 Jul 2023 18:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qHAv6-0000BW-QT
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 18:24:20 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qHAv0-0001DT-9j
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 18:24:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742bso301155e9.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 15:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688595851; x=1691187851;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoR4YxCK1TXumF+90/q/7D/WdpmCvdEiuaUsmP2Ol+k=;
 b=G6XsLokh2NHw4gc25F+J8oFL5v89Qcnvh2BkK4mSUKsNJ6q3TlWr23MM+pf7M9OtiP
 dmHC0jfX/S0vipccKIZRmd0syImZ3f04BgngcNg3ZSeCAM+5GqQY6WV38gbgV109MXJo
 zKMgvI9A1dMjxD7hrAjB7R+Yc08u2hEad1z35FHJUETWY7BXfpYa5RFqHQyzQx4sKEQq
 H4RU6ntVHEH5Vq5ixKZYLPHSk+4r7VKqPO0OT2XcQdTDOhnLgGBbg+iEnXbvvAtCrYyL
 CUKUz5I1BQI5mCIp1ucf8zpBqJF/7znVJWVgR6SUvnTSpLFZnQm0ctk4LMKY0l/JInXs
 VAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688595851; x=1691187851;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hoR4YxCK1TXumF+90/q/7D/WdpmCvdEiuaUsmP2Ol+k=;
 b=gVXlIP79PBdTZOS4/dCRK5OQn107vQ21WfZqrlc9E1KsYNmvG8rn2tH/LHlOEaHAuG
 5t+jXSY9ata7D9nUmPB/C/Cgkb3Rg3YA97V2qHH1DvOwE6WmAaEt15eH2/VH9jPx2bSh
 DNBKXPKcUb2hFls6B9P5orHtlXb4fkUwlFHYX2fId6KDqn3gMDnCnABUfR/StVbdHzAr
 ClME95VvO/Tv4K/4r1MywKBa+DZBOwsiWdJhAomzj1mgsPG12+NCePzpK3nlo+fRcalQ
 uVo68LXI21sXUgJwSm+Hfna++aqfE1iJcyg+J6J49nXa45+X+D0ceEZLhZR4FDwvXlP6
 XcIA==
X-Gm-Message-State: AC+VfDxJCNVPWqfwpELB3RZAqobJA/5IHaCtibT6MPwP41yNyVm87vdQ
 FkEDb69uz4nHeBRJv2uaQqs=
X-Google-Smtp-Source: ACHHUZ5Ls4ZwGBAmLjwrsuECctxuo96/SAWHKMJc8SzdUk+XkJ/9sCx6IRo9M2p3yiDlziuLJYOeuQ==
X-Received: by 2002:a1c:7215:0:b0:3fa:71db:56ff with SMTP id
 n21-20020a1c7215000000b003fa71db56ffmr14401589wmc.40.1688595850706; 
 Wed, 05 Jul 2023 15:24:10 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-052-236.77.11.pool.telefonica.de.
 [77.11.52.236]) by smtp.gmail.com with ESMTPSA id
 v22-20020a1cf716000000b003fbe43238c6sm284668wmh.9.2023.07.05.15.24.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 15:24:10 -0700 (PDT)
Date: Wed, 05 Jul 2023 22:24:02 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Joel Upham <jupham125@gmail.com>
CC: qemu-devel@nongnu.org
Subject: Re: [PATCH v1 00/23] Q35 support for Xen
In-Reply-To: <CADPhr0m6XuvZZuCtsXSgex3-FwR+cZ+6113VY+RJ3WfGuaqWDQ@mail.gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
 <38A3023A-6FAC-4155-BD7F-1C1DB16450EE@gmail.com>
 <CADPhr0m6XuvZZuCtsXSgex3-FwR+cZ+6113VY+RJ3WfGuaqWDQ@mail.gmail.com>
Message-ID: <B75057FD-62E4-4B15-8F65-D48DDE45C260@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
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



Am 5=2E Juli 2023 16:50:28 UTC schrieb Joel Upham <jupham125@gmail=2Ecom>:
>I believe it might have been master unstable branch=2E Last commit before=
 my
>patches was:
>
>commit 19a720b74fde7e859d19f12c66a72e545947a657
>Merge: c6a5fc2ac7 367189efae
>Author: Richard Henderson <richard=2Ehenderson@linaro=2Eorg>
>Date:   Thu Jun 1 08:30:29 2023 -0700

Indeed!

I've rebased your series and changed the first commit of your series to on=
ly touch pc_q35=2Ec: https://github=2Ecom/shentok/qemu/commits/q35-xen =2E =
Judging just from compilation my work on decoupling Xen and PIIX seems to h=
ave provided a good blueprint for the ICH9 LPC device model (no changes nee=
ded there)=2E

How can one run Xen/Q35? I've tried running Xen/PC with the PIIX4 rather t=
han the usual PIIX3 south bridge before which essentially only changes the =
PCI IDs=2E But that didn't work=2E With Q35/ICH9 the differences would be w=
ay bigger=2E=2E=2E

Thanks,
Bernhard

P=2ES=2E: I'm waiting for Xen to become compilable again with my Linux dis=
tribution such that I could add PIIX4 support to Xen=2E

>
>-Joel
>
>On Thu, Jun 22, 2023 at 1:11=E2=80=AFPM Bernhard Beschow <shentey@gmail=
=2Ecom> wrote:
>
>>
>>
>> Am 20=2E Juni 2023 17:24:33 UTC schrieb Joel Upham <jupham125@gmail=2Ec=
om>:
>> >These are the Qemu changes needed to support the q35 chipset for xen
>> >I based the patches from 2017 found on the mailing list here:
>> >
>> https://lists=2Exenproject=2Eorg/archives/html/xen-devel/2018-03/msg011=
76=2Ehtml
>> >
>> >I have been using a version of these patches on Xen 4=2E16 with Qemu
>> >version 4=2E1 for over 6 months=2E  The guest VMs are very stable, and=
 PCIe
>> >PT is working as was designed (all of the PCIe devices are on the root
>> >PCIe device)=2E  I have successfully passed through GPUs, NICs, etc=2E=
 I was
>> >asked by those in the community to attempt to once again upstream the
>> >patches=2E  I have them working with Seabios and OVMF (patches are nee=
ded
>> >to OVMF which I will be sending to the mailing list)=2E The Qemu patch=
es
>> >allow for the xenvbd to properly unplug the AHCI SATA device, and all
>> >xen pv windows drivers work as intended=2E
>> >
>> >I used the original author of the patches to get a majority of this to
>> work:
>> >Alexey Gerasimenko=2E  I fixed the patches to be in line with the upst=
ream
>> >Qemu and Xen versions=2E  Any original issues may still exist; however=
, I
>> >am sure in time they can be improved=2E If the code doesn't exist then=
 they
>> >can't be actively looked at by the community=2E
>> >
>> >I am not an expert on the Q35 chipset or PCIe technology=2E  This is m=
y
>> >first patch to this mailing list=2E
>>
>> Patchew was unable to apply this series onto master:
>> https://patchew=2Eorg/QEMU/cover=2E1687278381=2Egit=2Ejupham125@gmail=
=2Ecom/ What
>> revision is the series based on?
>>
>> Can you rebase? Rebasing this series will probably cause quite some wor=
k
>> since it will simplify here and there, as indicated by Igor and by my
>> comments in "version zero" of this series=2E
>>
>> Best regards,
>> Bernhard
>>
>> >
>> >
>> >Joel Upham (23):
>> >  pc/xen: Xen Q35 support: provide IRQ handling for PCI devices
>> >  pc/q35: Apply PCI bus BSEL property for Xen PCI device hotplug
>> >  q35/acpi/xen: Provide ACPI PCI hotplug interface for Xen on Q35
>> >  q35/xen: Add Xen platform device support for Q35
>> >  q35: Fix incorrect values for PCIEXBAR masks
>> >  xen/pt: XenHostPCIDevice: provide functions for PCI Capabilities and
>> >    PCIe Extended Capabilities enumeration
>> >  xen/pt: avoid reading PCIe device type and cap version multiple time=
s
>> >  xen/pt: determine the legacy/PCIe mode for a passed through device
>> >  xen/pt: Xen PCIe passthrough support for Q35: bypass PCIe topology
>> >    check
>> >  xen/pt: add support for PCIe Extended Capabilities and larger config
>> >    space
>> >  xen/pt: handle PCIe Extended Capabilities Next register
>> >  xen/pt: allow to hide PCIe Extended Capabilities
>> >  xen/pt: add Vendor-specific PCIe Extended Capability descriptor and
>> >    sizing
>> >  xen/pt: add fixed-size PCIe Extended Capabilities descriptors
>> >  xen/pt: add AER PCIe Extended Capability descriptor and sizing
>> >  xen/pt: add descriptors and size calculation for
>> >    RCLD/ACS/PMUX/DPA/MCAST/TPH/DPC PCIe Extended Capabilities
>> >  xen/pt: add Resizable BAR PCIe Extended Capability descriptor and
>> >    sizing
>> >  xen/pt: add VC/VC9/MFVC PCIe Extended Capabilities descriptors and
>> >    sizing
>> >  xen/pt: Fake capability id
>> >  xen platform: unplug ahci object
>> >  pc/q35: setup q35 for xen
>> >  qdev-monitor/pt: bypass root device check
>> >  s3 support: enabling s3 with q35
>> >
>> > hw/acpi/ich9=2Ec                |   22 +-
>> > hw/acpi/pcihp=2Ec               |    6 +-
>> > hw/core/machine=2Ec             |   19 +
>> > hw/i386/pc_piix=2Ec             |    3 +-
>> > hw/i386/pc_q35=2Ec              |   39 +-
>> > hw/i386/xen/xen-hvm=2Ec         |    7 +-
>> > hw/i386/xen/xen_platform=2Ec    |   19 +-
>> > hw/isa/lpc_ich9=2Ec             |   53 +-
>> > hw/isa/piix3=2Ec                |    2 +-
>> > hw/pci-host/q35=2Ec             |   28 +-
>> > hw/pci/pci=2Ec                  |   17 +
>> > hw/xen/xen-host-pci-device=2Ec  |  106 +++-
>> > hw/xen/xen-host-pci-device=2Eh  |    6 +-
>> > hw/xen/xen_pt=2Ec               |   49 +-
>> > hw/xen/xen_pt=2Eh               |   18 +-
>> > hw/xen/xen_pt_config_init=2Ec   | 1103 ++++++++++++++++++++++++++++++=
---
>> > include/hw/acpi/pcihp=2Eh       |    2 +
>> > include/hw/boards=2Eh           |    1 +
>> > include/hw/i386/pc=2Eh          |    3 +
>> > include/hw/pci-host/q35=2Eh     |    4 +-
>> > include/hw/pci/pci=2Eh          |    3 +
>> > include/hw/southbridge/ich9=2Eh |    1 +
>> > include/hw/xen/xen=2Eh          |    4 +-
>> > qemu-options=2Ehx               |    1 +
>> > softmmu/qdev-monitor=2Ec        |    4 +-
>> > stubs/xen-hw-stub=2Ec           |    4 +-
>> > 26 files changed, 1394 insertions(+), 130 deletions(-)
>> >
>>

