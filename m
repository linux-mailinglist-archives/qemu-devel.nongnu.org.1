Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 256AE738B73
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:36:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0o4-0000ov-2X; Wed, 21 Jun 2023 12:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qC0o1-0000dM-MD
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:35:41 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qC0nw-0001Kc-ST
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:35:38 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-514ab6cb529so13433443a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687365335; x=1689957335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OlyLGh0xTVH8JxlpESb1IMLg1C/AdwZE4iFR202x120=;
 b=b7KCOl2BOdBXWKllyS8slO2xb4rmElxeKUEAy/BqXLwcQWUSZgu9ledfPdJvqgWSw2
 A/YahHliAocepaa1qlGxUQu57qULXb89dtd2u6RtoBUxUkTn7FDha1QGveYdRktIi6cw
 x4nCrpwM8FYi0ZkdahCo/n3u6WRqFd6aHNZXRgjsd5aCen3TV0Fq2NBFPjKep01Zdo+/
 TkLb6hbeAZBE+3LgJ/StlpSwajC0DzZ4wXoFJJC0hLR0N7craALcI8AMyfjNjlkayGmO
 Kgpg5mDRA6KXLS6kHrA4+GSPNKOZR6Y3BszitMvAQYdWUAqfRYczr7oHjL9U/kjicJdY
 7k1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687365335; x=1689957335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OlyLGh0xTVH8JxlpESb1IMLg1C/AdwZE4iFR202x120=;
 b=C0p1irJsJSinJkrNEcra8L9jLIu3bklwU3EW0DxeRa/KyiNUu5zEAIfLQbdjHspeRR
 hZzLOx7BZgwfMc3KlMCTPSZ/UvKyXIkPg/TbUq+YUsYyLnbUsTnykqvxtPklKzYs+kcJ
 m+kbSKibd9fpMs6gYfTAyUTUBi4XDT9Q+lP4Fyz052erKoFgVqF1G3CpGFH1Mq08/Bu4
 Mn3AgWhriYkQMNI/XQqBaXs7opbhewhE6WIwVNoDKek7IVeKPWFD7HGB9oyoEG8GdTO/
 P3DH1pSwqY7zJjXaSWWJ4RD7HrXRynejkXKuKqb2S77LVIz7j0XRUHGxEg99DHIZ2Ltw
 vR3A==
X-Gm-Message-State: AC+VfDxPZDGDRHQKEC/SYOpTX61bnIl0f3fgcGQRAzKlCOvNcjqLndCR
 w7WgoQK2rjG9/of0tJp/NU6Grk1PhMgQJ2EuHgQ=
X-Google-Smtp-Source: ACHHUZ6YSZIhcRxYSKM7fyS+mZ8b49f7mH4l43bFTLHnG0QGv6NB/cNIZlfGry75u1h9mKHA45f8PFBi3LAMcVzIqT8=
X-Received: by 2002:a05:6402:274b:b0:51a:4039:b9e with SMTP id
 z11-20020a056402274b00b0051a40390b9emr14444586edd.9.1687365334858; Wed, 21
 Jun 2023 09:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687127946.git.jupham125@gmail.com>
 <272947b9494f00bb4ad3e27c050e99f8b61905b3.1687127946.git.jupham125@gmail.com>
 <02b6a8a8-2da7-2864-0c0e-5ed81a560355@redhat.com>
In-Reply-To: <02b6a8a8-2da7-2864-0c0e-5ed81a560355@redhat.com>
From: Joel Upham <jupham125@gmail.com>
Date: Wed, 21 Jun 2023 12:35:23 -0400
Message-ID: <CADPhr0kMXxj1SUQggcNQeXY4wSbLNN1-Amqxo3uGVeBMSJmn-g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Q35 Support
To: David Hildenbrand <david@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Yanan Wang <wangyanan55@huawei.com>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000063ffd605fea65b42"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=jupham125@gmail.com; helo=mail-ed1-x52e.google.com
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

--00000000000063ffd605fea65b42
Content-Type: text/plain; charset="UTF-8"

Sorry, this was sent in error when I did the git send-email for the folder.
This was before I broke each patch down (after looking at the Qemu
submission guidance). This is my first time sending a patch in this way, so
thanks for the understanding. This patch can be ignored, as they are all
covered elsewhere.

-Joel Upham

On Wed, Jun 21, 2023 at 7:10 AM David Hildenbrand <david@redhat.com> wrote:

> On 20.06.23 19:24, Joel Upham wrote:
>
> Inexpressive patch subject and non-existant patch desciption. I have no
> clue what this is supposed to do, except that it involes q35 and xen ()I
> guess ?.
>
> > ---
> >   hw/acpi/ich9.c                |   22 +-
> >   hw/acpi/pcihp.c               |    6 +-
> >   hw/core/machine.c             |   19 +
> >   hw/i386/pc_piix.c             |    3 +-
> >   hw/i386/pc_q35.c              |   39 +-
> >   hw/i386/xen/xen-hvm.c         |    7 +-
> >   hw/i386/xen/xen_platform.c    |   19 +-
> >   hw/isa/lpc_ich9.c             |   53 +-
> >   hw/isa/piix3.c                |    2 +-
> >   hw/pci-host/q35.c             |   28 +-
> >   hw/pci/pci.c                  |   17 +
> >   hw/xen/xen-host-pci-device.c  |  106 +++-
> >   hw/xen/xen-host-pci-device.h  |    6 +-
> >   hw/xen/xen_pt.c               |   49 +-
> >   hw/xen/xen_pt.h               |   19 +-
> >   hw/xen/xen_pt_config_init.c   | 1103 ++++++++++++++++++++++++++++++---
> >   include/hw/acpi/ich9.h        |    1 +
> >   include/hw/acpi/pcihp.h       |    2 +
> >   include/hw/boards.h           |    1 +
> >   include/hw/i386/pc.h          |    3 +
> >   include/hw/pci-host/q35.h     |    4 +-
> >   include/hw/pci/pci.h          |    3 +
> >   include/hw/southbridge/ich9.h |    1 +
> >   include/hw/xen/xen.h          |    4 +-
> >   qemu-options.hx               |    1 +
> >   softmmu/datadir.c             |    1 -
> >   softmmu/qdev-monitor.c        |    3 +-
> >   stubs/xen-hw-stub.c           |    4 +-
> >   28 files changed, 1395 insertions(+), 131 deletions(-)
> >
>
> Usually people refrain from reviewing such massive patches. Most
> probably this can be broken up into reviewable pieces.
>
> Was this supposed to be an RFC?
>
> --
> Cheers,
>
> David / dhildenb
>
>

--00000000000063ffd605fea65b42
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Sorry, this was sent in error when I did the git send-ema=
il for the folder. This was before I broke each patch down (after looking a=
t the Qemu submission guidance). This is my first time sending a patch in t=
his way, so thanks for the understanding. This patch can be ignored, as the=
y are all covered elsewhere.=C2=A0</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">-Joel Upham</div><div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Wed, Jun 21, 2023 at 7:10 AM David Hildenbran=
d &lt;<a href=3D"mailto:david@redhat.com">david@redhat.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">On 20.06.23 19:24, Joel Upham wrote:=
<br>
<br>
Inexpressive patch subject and non-existant patch desciption. I have no <br=
>
clue what this is supposed to do, except that it involes q35 and xen ()I <b=
r>
guess ?.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/acpi/ich9.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A022 +-<br>
&gt;=C2=A0 =C2=A0hw/acpi/pcihp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 6 +-<br>
&gt;=C2=A0 =C2=A0hw/core/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A019 +<br>
&gt;=C2=A0 =C2=A0hw/i386/pc_piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 3 +-<br>
&gt;=C2=A0 =C2=A0hw/i386/pc_q35.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A039 +-<br>
&gt;=C2=A0 =C2=A0hw/i386/xen/xen-hvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 7 +-<br>
&gt;=C2=A0 =C2=A0hw/i386/xen/xen_platform.c=C2=A0 =C2=A0 |=C2=A0 =C2=A019 +=
-<br>
&gt;=C2=A0 =C2=A0hw/isa/lpc_ich9.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A053 +-<br>
&gt;=C2=A0 =C2=A0hw/isa/piix3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0hw/pci-host/q35.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A028 +-<br>
&gt;=C2=A0 =C2=A0hw/pci/pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A017 +<br>
&gt;=C2=A0 =C2=A0hw/xen/xen-host-pci-device.c=C2=A0 |=C2=A0 106 +++-<br>
&gt;=C2=A0 =C2=A0hw/xen/xen-host-pci-device.h=C2=A0 |=C2=A0 =C2=A0 6 +-<br>
&gt;=C2=A0 =C2=A0hw/xen/xen_pt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A049 +-<br>
&gt;=C2=A0 =C2=A0hw/xen/xen_pt.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A019 +-<br>
&gt;=C2=A0 =C2=A0hw/xen/xen_pt_config_init.c=C2=A0 =C2=A0| 1103 +++++++++++=
+++++++++++++++++++---<br>
&gt;=C2=A0 =C2=A0include/hw/acpi/ich9.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0include/hw/acpi/pcihp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 2 +<br>
&gt;=C2=A0 =C2=A0include/hw/boards.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0include/hw/i386/pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 3 +<br>
&gt;=C2=A0 =C2=A0include/hw/pci-host/q35.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 4 +-<br>
&gt;=C2=A0 =C2=A0include/hw/pci/pci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 3 +<br>
&gt;=C2=A0 =C2=A0include/hw/southbridge/ich9.h |=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0include/hw/xen/xen.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 4 +-<br>
&gt;=C2=A0 =C2=A0qemu-options.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0softmmu/datadir.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 1 -<br>
&gt;=C2=A0 =C2=A0softmmu/qdev-monitor.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 3 +-<br>
&gt;=C2=A0 =C2=A0stubs/xen-hw-stub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 4 +-<br>
&gt;=C2=A0 =C2=A028 files changed, 1395 insertions(+), 131 deletions(-)<br>
&gt; <br>
<br>
Usually people refrain from reviewing such massive patches. Most <br>
probably this can be broken up into reviewable pieces.<br>
<br>
Was this supposed to be an RFC?<br>
<br>
-- <br>
Cheers,<br>
<br>
David / dhildenb<br>
<br>
</blockquote></div></div>

--00000000000063ffd605fea65b42--

