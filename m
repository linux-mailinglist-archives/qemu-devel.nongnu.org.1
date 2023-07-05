Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 289F674897F
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 18:52:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5iU-00021N-JP; Wed, 05 Jul 2023 12:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qH5iG-00020I-Vn
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:50:50 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qH5iE-0006cN-OL
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:50:44 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b69923a715so107818701fa.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 09:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688575840; x=1691167840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bE9yrATJHPUCt1jUjZIqILQnXk4UyK7yZkcv1ebfyTk=;
 b=M16P+w7a/yWdVz0eiYH3wGp3xCISTjHwovI9GFORA6DdCtAdmDt3aULq5Qpp//jcYE
 Qv3zdGymS2FWt8O+dSTIuihiOHZIjEXzsq6yCJiHgtQog4TOLpZlx5PO0EqKNipw4Zec
 FEwU7E+HWQT/kTDfPFjmsqzzCXdDNpKsXgtDDT7XfeTkBvI3wRuuVkMR7IIqGIvxJjW+
 UauV6QL8kEAWdifBMM0Pii8KOSAijbirEXk9UIlAdXz60hUR0JIzv/PmV6BMPyB3NDL3
 3ZPHxAX2LDUozERbBIc01eWnXUdIRqf9MA0lc90RmgqCAI/ewk93FoVjtForAwzQoZAN
 G31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688575840; x=1691167840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bE9yrATJHPUCt1jUjZIqILQnXk4UyK7yZkcv1ebfyTk=;
 b=Aydjr5xsg0p6Htojz2gp7SCyxLMc4RS97acyiWF5YbyUxj4GgU5wiL33UgYNCVp70h
 35/v0u5BETZIh7UDLqKAlISFQ7S1enb4dM6d/ov/zUnSqEvOnnPVgVMXN0hWMuef3RE4
 YPXci/HxVr2NKLcY4N5okgwIks+eSninphtvCLXeyavr1ruqN8r4EeG9G7YrVV5PoUlm
 N1/KcUpfd4/mrxFgf0QgxPnwNRgQDeBk1NRDE5iFFCiBlMkZI6ePWqbkPAaWChFs89pO
 emOx40kTLynMJm1/7HPf34Wz/iAVa72sqUw0NAGB/gMnMoxZcHxJ6Yux5whHCugD2Jfd
 hA6w==
X-Gm-Message-State: ABy/qLbvSQXcSWXSvaginjZEt6HWYKOOZfhGGExSbNZfFgV2v1iCqJiI
 nObK/8V1QViEHLMphiFc47yxjblq30D408fbWfg=
X-Google-Smtp-Source: APBJJlG34RyjPrEg1Qz4TqqelRnq6gV0nra3CNF/SVQJTZMTN3DYutB51yQByBKAwEkjVlHTBzWO0q1gpC3iPM6YSHM=
X-Received: by 2002:a2e:8502:0:b0:2b6:a65f:7294 with SMTP id
 j2-20020a2e8502000000b002b6a65f7294mr13031666lji.50.1688575839850; Wed, 05
 Jul 2023 09:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687278381.git.jupham125@gmail.com>
 <38A3023A-6FAC-4155-BD7F-1C1DB16450EE@gmail.com>
In-Reply-To: <38A3023A-6FAC-4155-BD7F-1C1DB16450EE@gmail.com>
From: Joel Upham <jupham125@gmail.com>
Date: Wed, 5 Jul 2023 12:50:28 -0400
Message-ID: <CADPhr0m6XuvZZuCtsXSgex3-FwR+cZ+6113VY+RJ3WfGuaqWDQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/23] Q35 support for Xen
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001c559505ffc0338a"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=jupham125@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--0000000000001c559505ffc0338a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I believe it might have been master unstable branch. Last commit before my
patches was:

commit 19a720b74fde7e859d19f12c66a72e545947a657
Merge: c6a5fc2ac7 367189efae
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Thu Jun 1 08:30:29 2023 -0700

-Joel

On Thu, Jun 22, 2023 at 1:11=E2=80=AFPM Bernhard Beschow <shentey@gmail.com=
> wrote:

>
>
> Am 20. Juni 2023 17:24:33 UTC schrieb Joel Upham <jupham125@gmail.com>:
> >These are the Qemu changes needed to support the q35 chipset for xen
> >I based the patches from 2017 found on the mailing list here:
> >
> https://lists.xenproject.org/archives/html/xen-devel/2018-03/msg01176.htm=
l
> >
> >I have been using a version of these patches on Xen 4.16 with Qemu
> >version 4.1 for over 6 months.  The guest VMs are very stable, and PCIe
> >PT is working as was designed (all of the PCIe devices are on the root
> >PCIe device).  I have successfully passed through GPUs, NICs, etc. I was
> >asked by those in the community to attempt to once again upstream the
> >patches.  I have them working with Seabios and OVMF (patches are needed
> >to OVMF which I will be sending to the mailing list). The Qemu patches
> >allow for the xenvbd to properly unplug the AHCI SATA device, and all
> >xen pv windows drivers work as intended.
> >
> >I used the original author of the patches to get a majority of this to
> work:
> >Alexey Gerasimenko.  I fixed the patches to be in line with the upstream
> >Qemu and Xen versions.  Any original issues may still exist; however, I
> >am sure in time they can be improved. If the code doesn't exist then the=
y
> >can't be actively looked at by the community.
> >
> >I am not an expert on the Q35 chipset or PCIe technology.  This is my
> >first patch to this mailing list.
>
> Patchew was unable to apply this series onto master:
> https://patchew.org/QEMU/cover.1687278381.git.jupham125@gmail.com/ What
> revision is the series based on?
>
> Can you rebase? Rebasing this series will probably cause quite some work
> since it will simplify here and there, as indicated by Igor and by my
> comments in "version zero" of this series.
>
> Best regards,
> Bernhard
>
> >
> >
> >Joel Upham (23):
> >  pc/xen: Xen Q35 support: provide IRQ handling for PCI devices
> >  pc/q35: Apply PCI bus BSEL property for Xen PCI device hotplug
> >  q35/acpi/xen: Provide ACPI PCI hotplug interface for Xen on Q35
> >  q35/xen: Add Xen platform device support for Q35
> >  q35: Fix incorrect values for PCIEXBAR masks
> >  xen/pt: XenHostPCIDevice: provide functions for PCI Capabilities and
> >    PCIe Extended Capabilities enumeration
> >  xen/pt: avoid reading PCIe device type and cap version multiple times
> >  xen/pt: determine the legacy/PCIe mode for a passed through device
> >  xen/pt: Xen PCIe passthrough support for Q35: bypass PCIe topology
> >    check
> >  xen/pt: add support for PCIe Extended Capabilities and larger config
> >    space
> >  xen/pt: handle PCIe Extended Capabilities Next register
> >  xen/pt: allow to hide PCIe Extended Capabilities
> >  xen/pt: add Vendor-specific PCIe Extended Capability descriptor and
> >    sizing
> >  xen/pt: add fixed-size PCIe Extended Capabilities descriptors
> >  xen/pt: add AER PCIe Extended Capability descriptor and sizing
> >  xen/pt: add descriptors and size calculation for
> >    RCLD/ACS/PMUX/DPA/MCAST/TPH/DPC PCIe Extended Capabilities
> >  xen/pt: add Resizable BAR PCIe Extended Capability descriptor and
> >    sizing
> >  xen/pt: add VC/VC9/MFVC PCIe Extended Capabilities descriptors and
> >    sizing
> >  xen/pt: Fake capability id
> >  xen platform: unplug ahci object
> >  pc/q35: setup q35 for xen
> >  qdev-monitor/pt: bypass root device check
> >  s3 support: enabling s3 with q35
> >
> > hw/acpi/ich9.c                |   22 +-
> > hw/acpi/pcihp.c               |    6 +-
> > hw/core/machine.c             |   19 +
> > hw/i386/pc_piix.c             |    3 +-
> > hw/i386/pc_q35.c              |   39 +-
> > hw/i386/xen/xen-hvm.c         |    7 +-
> > hw/i386/xen/xen_platform.c    |   19 +-
> > hw/isa/lpc_ich9.c             |   53 +-
> > hw/isa/piix3.c                |    2 +-
> > hw/pci-host/q35.c             |   28 +-
> > hw/pci/pci.c                  |   17 +
> > hw/xen/xen-host-pci-device.c  |  106 +++-
> > hw/xen/xen-host-pci-device.h  |    6 +-
> > hw/xen/xen_pt.c               |   49 +-
> > hw/xen/xen_pt.h               |   18 +-
> > hw/xen/xen_pt_config_init.c   | 1103 ++++++++++++++++++++++++++++++---
> > include/hw/acpi/pcihp.h       |    2 +
> > include/hw/boards.h           |    1 +
> > include/hw/i386/pc.h          |    3 +
> > include/hw/pci-host/q35.h     |    4 +-
> > include/hw/pci/pci.h          |    3 +
> > include/hw/southbridge/ich9.h |    1 +
> > include/hw/xen/xen.h          |    4 +-
> > qemu-options.hx               |    1 +
> > softmmu/qdev-monitor.c        |    4 +-
> > stubs/xen-hw-stub.c           |    4 +-
> > 26 files changed, 1394 insertions(+), 130 deletions(-)
> >
>

--0000000000001c559505ffc0338a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I believe it might have been master unstable branch. Last =
commit before my patches was:<br><br>commit 19a720b74fde7e859d19f12c66a72e5=
45947a657<br>Merge: c6a5fc2ac7 367189efae<br>Author: Richard Henderson &lt;=
<a href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.or=
g</a>&gt;<br><div>Date: =C2=A0 Thu Jun 1 08:30:29 2023 -0700</div><div><br>=
</div><div>-Joel<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Thu, Jun 22, 2023 at 1:11=E2=80=AFPM Bernhard =
Beschow &lt;<a href=3D"mailto:shentey@gmail.com">shentey@gmail.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
Am 20. Juni 2023 17:24:33 UTC schrieb Joel Upham &lt;<a href=3D"mailto:juph=
am125@gmail.com" target=3D"_blank">jupham125@gmail.com</a>&gt;:<br>
&gt;These are the Qemu changes needed to support the q35 chipset for xen<br=
>
&gt;I based the patches from 2017 found on the mailing list here:<br>
&gt;<a href=3D"https://lists.xenproject.org/archives/html/xen-devel/2018-03=
/msg01176.html" rel=3D"noreferrer" target=3D"_blank">https://lists.xenproje=
ct.org/archives/html/xen-devel/2018-03/msg01176.html</a><br>
&gt;<br>
&gt;I have been using a version of these patches on Xen 4.16 with Qemu<br>
&gt;version 4.1 for over 6 months.=C2=A0 The guest VMs are very stable, and=
 PCIe<br>
&gt;PT is working as was designed (all of the PCIe devices are on the root<=
br>
&gt;PCIe device).=C2=A0 I have successfully passed through GPUs, NICs, etc.=
 I was<br>
&gt;asked by those in the community to attempt to once again upstream the<b=
r>
&gt;patches.=C2=A0 I have them working with Seabios and OVMF (patches are n=
eeded<br>
&gt;to OVMF which I will be sending to the mailing list). The Qemu patches =
<br>
&gt;allow for the xenvbd to properly unplug the AHCI SATA device, and all <=
br>
&gt;xen pv windows drivers work as intended.<br>
&gt;<br>
&gt;I used the original author of the patches to get a majority of this to =
work:<br>
&gt;Alexey Gerasimenko.=C2=A0 I fixed the patches to be in line with the up=
stream<br>
&gt;Qemu and Xen versions.=C2=A0 Any original issues may still exist; howev=
er, I<br>
&gt;am sure in time they can be improved. If the code doesn&#39;t exist the=
n they<br>
&gt;can&#39;t be actively looked at by the community.<br>
&gt;<br>
&gt;I am not an expert on the Q35 chipset or PCIe technology.=C2=A0 This is=
 my<br>
&gt;first patch to this mailing list.<br>
<br>
Patchew was unable to apply this series onto master: <a href=3D"https://pat=
chew.org/QEMU/cover.1687278381.git.jupham125@gmail.com/" rel=3D"noreferrer"=
 target=3D"_blank">https://patchew.org/QEMU/cover.1687278381.git.jupham125@=
gmail.com/</a> What revision is the series based on?<br>
<br>
Can you rebase? Rebasing this series will probably cause quite some work si=
nce it will simplify here and there, as indicated by Igor and by my comment=
s in &quot;version zero&quot; of this series.<br>
<br>
Best regards,<br>
Bernhard<br>
<br>
&gt;<br>
&gt;<br>
&gt;Joel Upham (23):<br>
&gt;=C2=A0 pc/xen: Xen Q35 support: provide IRQ handling for PCI devices<br=
>
&gt;=C2=A0 pc/q35: Apply PCI bus BSEL property for Xen PCI device hotplug<b=
r>
&gt;=C2=A0 q35/acpi/xen: Provide ACPI PCI hotplug interface for Xen on Q35<=
br>
&gt;=C2=A0 q35/xen: Add Xen platform device support for Q35<br>
&gt;=C2=A0 q35: Fix incorrect values for PCIEXBAR masks<br>
&gt;=C2=A0 xen/pt: XenHostPCIDevice: provide functions for PCI Capabilities=
 and<br>
&gt;=C2=A0 =C2=A0 PCIe Extended Capabilities enumeration<br>
&gt;=C2=A0 xen/pt: avoid reading PCIe device type and cap version multiple =
times<br>
&gt;=C2=A0 xen/pt: determine the legacy/PCIe mode for a passed through devi=
ce<br>
&gt;=C2=A0 xen/pt: Xen PCIe passthrough support for Q35: bypass PCIe topolo=
gy<br>
&gt;=C2=A0 =C2=A0 check<br>
&gt;=C2=A0 xen/pt: add support for PCIe Extended Capabilities and larger co=
nfig<br>
&gt;=C2=A0 =C2=A0 space<br>
&gt;=C2=A0 xen/pt: handle PCIe Extended Capabilities Next register<br>
&gt;=C2=A0 xen/pt: allow to hide PCIe Extended Capabilities<br>
&gt;=C2=A0 xen/pt: add Vendor-specific PCIe Extended Capability descriptor =
and<br>
&gt;=C2=A0 =C2=A0 sizing<br>
&gt;=C2=A0 xen/pt: add fixed-size PCIe Extended Capabilities descriptors<br=
>
&gt;=C2=A0 xen/pt: add AER PCIe Extended Capability descriptor and sizing<b=
r>
&gt;=C2=A0 xen/pt: add descriptors and size calculation for<br>
&gt;=C2=A0 =C2=A0 RCLD/ACS/PMUX/DPA/MCAST/TPH/DPC PCIe Extended Capabilitie=
s<br>
&gt;=C2=A0 xen/pt: add Resizable BAR PCIe Extended Capability descriptor an=
d<br>
&gt;=C2=A0 =C2=A0 sizing<br>
&gt;=C2=A0 xen/pt: add VC/VC9/MFVC PCIe Extended Capabilities descriptors a=
nd<br>
&gt;=C2=A0 =C2=A0 sizing<br>
&gt;=C2=A0 xen/pt: Fake capability id<br>
&gt;=C2=A0 xen platform: unplug ahci object<br>
&gt;=C2=A0 pc/q35: setup q35 for xen<br>
&gt;=C2=A0 qdev-monitor/pt: bypass root device check<br>
&gt;=C2=A0 s3 support: enabling s3 with q35<br>
&gt;<br>
&gt; hw/acpi/ich9.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 =C2=A022 +-<br>
&gt; hw/acpi/pcihp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A0 6 +-<br>
&gt; hw/core/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A019 +<br>
&gt; hw/i386/pc_piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0 3 +-<br>
&gt; hw/i386/pc_q35.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A039 +-<br>
&gt; hw/i386/xen/xen-hvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =
7 +-<br>
&gt; hw/i386/xen/xen_platform.c=C2=A0 =C2=A0 |=C2=A0 =C2=A019 +-<br>
&gt; hw/isa/lpc_ich9.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A053 +-<br>
&gt; hw/isa/piix3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 =C2=A0 2 +-<br>
&gt; hw/pci-host/q35.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A028 +-<br>
&gt; hw/pci/pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A017 +<br>
&gt; hw/xen/xen-host-pci-device.c=C2=A0 |=C2=A0 106 +++-<br>
&gt; hw/xen/xen-host-pci-device.h=C2=A0 |=C2=A0 =C2=A0 6 +-<br>
&gt; hw/xen/xen_pt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A049 +-<br>
&gt; hw/xen/xen_pt.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A018 +-<br>
&gt; hw/xen/xen_pt_config_init.c=C2=A0 =C2=A0| 1103 +++++++++++++++++++++++=
+++++++---<br>
&gt; include/hw/acpi/pcihp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +<b=
r>
&gt; include/hw/boards.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 1 +<br>
&gt; include/hw/i386/pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =
3 +<br>
&gt; include/hw/pci-host/q35.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 4 +-<br>
&gt; include/hw/pci/pci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =
3 +<br>
&gt; include/hw/southbridge/ich9.h |=C2=A0 =C2=A0 1 +<br>
&gt; include/hw/xen/xen.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =
4 +-<br>
&gt; qemu-options.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A0 1 +<br>
&gt; softmmu/qdev-monitor.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 4 +-<=
br>
&gt; stubs/xen-hw-stub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 4 +-<br>
&gt; 26 files changed, 1394 insertions(+), 130 deletions(-)<br>
&gt;<br>
</blockquote></div>

--0000000000001c559505ffc0338a--

