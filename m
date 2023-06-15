Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B973A732140
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 23:01:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9u4y-0000vD-If; Thu, 15 Jun 2023 17:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohdyusuf@gmail.com>)
 id 1q9u4v-0000tb-IZ
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 17:00:26 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mohdyusuf@gmail.com>)
 id 1q9u4t-0004am-O9
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 17:00:25 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-519608ddbf7so2858110a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jun 2023 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686862819; x=1689454819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WYLbYL1krmcSknFae1Ccf4OFvXtZnYlTokiPxqIQBcI=;
 b=mG3B9RpjKsDDcaelO6hZCWoXkT1Wx4RqMq50Rmo81sl2kBuamG1ocLzTF5cnMkMTkk
 TZ8DrG1Xba7uhfCri4tRGea8KUDyx0QXmxvf5XiDDRHsOWKky/VaNPqDtes/YA3JObJ2
 0tDY8voWnAnsDBdlBVrobf/LT6M/CWR83t1qolddAwjANyTU1UATFNdtg430wBCq22zS
 zS2+Rz6fU4Ikd3PtT4mDg528euNrpe+SyQCNUTVkE+V+nORVN3kUD3r5jkw76mDTpxdY
 QoF752YaQA5vTBxWlj3Jggmj09VpNTsDScgb22I3ptZa40qqYMRjoOSx4LXd7toZWi2P
 nKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686862819; x=1689454819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WYLbYL1krmcSknFae1Ccf4OFvXtZnYlTokiPxqIQBcI=;
 b=VJghTCWKfBo/WOmmV04ZmgtYFZeYqrFPPcM/RHsoOs4FnXF15vuIqQigdE4W/D6bAF
 obEb/7qRJa+uQ1GsOP1+AngPdTNbI5QtNFeuQxxHhP4Bb2TXki5VLS8zQxSgG0z0eS27
 KGLvz+MS4t4WP2RPeX7S/+wROx3i2Ejm5wH+lrYwBI+qovqlghK+Fuz2Ee/4vqmYRTIe
 UoaVXHmMhdXgTA5IW3q4HYXig/fK3axPF6BtIeXy2PgtA0uUXlLq91sBCZyV5XCRANUD
 xav44aGZvUFgR7I8E6I0biW10zkG8Rat6BXqWqcRARnaJAS3xvzjLWvaRvNG2YfzcYdz
 Je/g==
X-Gm-Message-State: AC+VfDwjJkY3k5CODVRfOkEaAIWZ0cOoNMaVuzgkuHQPK6QeWofZd3v0
 RVksyax3EwDq4X1grCL9QlV2OL82M2aTO7BzRAtzZ3MiaIzAoA==
X-Google-Smtp-Source: ACHHUZ6qwOkxRtEUCZp3d9K1JGCNs9XeSBMDckFoOd1ydIFmpgxVOiWY5Yjo4A9Uzzt5aHyfnzQHCLu4+ntNRUGRdKo=
X-Received: by 2002:aa7:d38b:0:b0:51a:2caa:672c with SMTP id
 x11-20020aa7d38b000000b0051a2caa672cmr10823edq.30.1686862818927; Thu, 15 Jun
 2023 14:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <CALKsAjDBgWvuG5Q8r6N44-VdX8+8zozkN=EZhXJ-8n8DXz2DqA@mail.gmail.com>
 <cfc21135-0f27-8af5-c864-d969dd42e4c0@redhat.com>
In-Reply-To: <cfc21135-0f27-8af5-c864-d969dd42e4c0@redhat.com>
From: Mohd Yusuf Abdul Hamid <mohdyusuf@gmail.com>
Date: Thu, 15 Jun 2023 13:59:42 -0700
Message-ID: <CALKsAjAKFCgihYc-c3p7Fka3gE58bFqQ00xnAW5RYd4tbVs6rQ@mail.gmail.com>
Subject: Re: QEMU virt (arm64) does not honor reserved-memory set in device
 tree
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001b687605fe315b99"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=mohdyusuf@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000001b687605fe315b99
Content-Type: text/plain; charset="UTF-8"

Hi Gavin,
Thanks for the reply. I am new to Linux dev in general and not familiar
with the ACPI table, but I will research in the area and give it a try.

Sorry for the late response.

-Yusuf

On Fri, Jun 9, 2023, 8:36 PM Gavin Shan <gshan@redhat.com> wrote:

> Hi Mohd,
>
> On 6/10/23 10:01 AM, Mohd Yusuf Abdul Hamid wrote:
> > I am trying to reserve a portion of the system memory in QEMU (arm64
> virt), v7.2.1 - but the kernel never honors the reserved memory area and
> keeps using the area.
> >
> > Say, I dumped out DTB and added:
> >
> > reserved-memory {
> >    #address-cells = <0x02>;
> >    #size-cells = <0x02>;
> >
> >    rsvdram@50000000 {
> >    no-map;
> >    reg = <0x00 0x50000000 0x00 0x20000000>;
> >    };
> > };
> >
> > When booted, /proc/iomem still shows the kernel is using the entire
> space - eg 2GB.
> >
> > Is this a supported feature or I would need to modify the virt.c and
> define scratch area for some device driver scratch area.
> >
>
> It relies on the guest kernel to handle the device-tree and the
> device-tree node
> for the reserved map. I doubt if you had ACPI over device-tree in the
> guest kernel's
> configuration. In this case, the reserved memory regions need to be
> specified in
> ACPI tables instead of device-tree.
>
> Thanks,
> Gavin
>
>

--0000000000001b687605fe315b99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto">Hi Gavin,<div dir=3D"auto">Thanks for th=
e reply. I am new to Linux dev in general and not familiar with the ACPI ta=
ble, but I will research in the area and give it a try.</div><div dir=3D"au=
to"><br></div><div>Sorry for the late response.</div><div><br></div><div>-Y=
usuf</div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, Jun 9, 2023, 8:36 PM Gavin Shan &lt;<a href=3D"mail=
to:gshan@redhat.com" target=3D"_blank">gshan@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,2=
04);padding-left:1ex">Hi Mohd,<br>
<br>
On 6/10/23 10:01 AM, Mohd Yusuf Abdul Hamid wrote:<br>
&gt; I am trying to reserve a portion of the system memory in QEMU (arm64 v=
irt), v7.2.1 - but the kernel never honors the reserved memory area and kee=
ps using the area.<br>
&gt; <br>
&gt; Say, I dumped out DTB and added:<br>
&gt; <br>
&gt; reserved-memory {<br>
&gt;=C2=A0 =C2=A0 #address-cells =3D &lt;0x02&gt;;<br>
&gt;=C2=A0 =C2=A0 #size-cells =3D &lt;0x02&gt;;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 rsvdram@50000000 {<br>
&gt;=C2=A0 =C2=A0 no-map;<br>
&gt;=C2=A0 =C2=A0 reg =3D &lt;0x00 0x50000000 0x00 0x20000000&gt;;<br>
&gt;=C2=A0 =C2=A0 };<br>
&gt; };<br>
&gt; <br>
&gt; When booted, /proc/iomem still shows the kernel is using the entire sp=
ace - eg 2GB.<br>
&gt; <br>
&gt; Is this a supported feature or I would need to modify the virt.c and d=
efine scratch area for some device driver scratch area.<br>
&gt; <br>
<br>
It relies on the guest kernel to handle the device-tree and the device-tree=
 node<br>
for the reserved map. I doubt if you had ACPI over device-tree in the guest=
 kernel&#39;s<br>
configuration. In this case, the reserved memory regions need to be specifi=
ed in<br>
ACPI tables instead of device-tree.<br>
<br>
Thanks,<br>
Gavin<br>
<br>
</blockquote></div>

--0000000000001b687605fe315b99--

