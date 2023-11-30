Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB547FEC4F
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 10:55:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8djl-0001nH-Sc; Thu, 30 Nov 2023 04:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1r8dje-0001mw-P3
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 04:53:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1r8djc-0005rL-QE
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 04:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701338007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4iCLDB7Y6gjf/LcLb2tXV3PXtJbSmB1p05jMADgF5oA=;
 b=gor4ai4shrVHzOHQcF5mZ3wV8VWvEQ8X/D4eBHzifBRjcx53O+MFGVjFRhN205MfzZw4Rn
 rLcpQ4Lz8zPbKThQfs/XH2Npkf4Yr83QBmCufbuiDNvH4t6byMiC9Jwr7llmOOGYSBobQw
 Cw7h+dL0deAc0yWjvulBAXHZXMS/EJc=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-7Tuc0WdcOJeUQng7URFWMA-1; Thu, 30 Nov 2023 04:52:14 -0500
X-MC-Unique: 7Tuc0WdcOJeUQng7URFWMA-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-4acad6aba41so316052e0c.1
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 01:52:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701337934; x=1701942734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4iCLDB7Y6gjf/LcLb2tXV3PXtJbSmB1p05jMADgF5oA=;
 b=VPJ69rQjsdfwdZ9a4XSTpDuhrP4nxoX6Dxb50xZzvzJJHkjmWjIrUFV62fEzI3L9re
 WEnaOQFLwiJJlbvH0Va3I3saK8qUHUJS6DI+IeYPsqFVqU4tMVMXXqjbYmt4BBEPADfe
 J+x9mnxZ1A87p/Z94v/7nz6rxtZbzy3LDS1LaQVjecKCkXhflwnubwiQ4Bp+6J5szDjq
 5pzENBnO63WTqbKBSmT6DEWVJVLvYAKKwxifx9pTAU2yodTHIcjJtLh8ZQu40tjoCIjB
 sX6/nT0OxuuwC8Fmy63vX/xNUI1WhcqwwjvYXkzyIPTJzxeOm+HpBAUPP5NQonY/a8IU
 exEw==
X-Gm-Message-State: AOJu0YwAaTk+SuQdLk0ZSW/TJb6fhyO1dEq7PJb3n5UFP8McCQ6qeU9f
 2pzAQ1HJ7UeE2oHsbdOV2itpKxZhlIN+9tmHYU3dvy9ksaaCDz0nO2g5V16UIsQ8s0qt0d8V8jH
 ZkNL+HiYawBEJjBNCJ4ROVTTIHewPLGM=
X-Received: by 2002:a1f:6244:0:b0:4b2:8446:a9d4 with SMTP id
 w65-20020a1f6244000000b004b28446a9d4mr6276910vkb.12.1701337933771; 
 Thu, 30 Nov 2023 01:52:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1QugqnI71W8Ub+Xt5qve0p9jIyO4lh3OH0DUldQvX7k88996Fh/6f5yZsE8CeaeIJbZi8RuLIzmLLqJzOov0=
X-Received: by 2002:a1f:6244:0:b0:4b2:8446:a9d4 with SMTP id
 w65-20020a1f6244000000b004b28446a9d4mr6276896vkb.12.1701337933352; Thu, 30
 Nov 2023 01:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20231123075630.12057-1-akihiko.odaki@daynix.com>
 <53966853-640a-4581-a08d-8b452afc4c2a@redhat.com>
In-Reply-To: <53966853-640a-4581-a08d-8b452afc4c2a@redhat.com>
From: YangHang Liu <yanghliu@redhat.com>
Date: Thu, 30 Nov 2023 17:52:02 +0800
Message-ID: <CAGYh1E-4fiF+Y0JBKPRwJNbuJzdJuWnR6yA-eNLBjW9++xov3w@mail.gmail.com>
Subject: Re: [PATCH] pcie_sriov: Remove g_new assertion
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000029241e060b5b9b2a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=yanghliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000029241e060b5b9b2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After applying this patch, the VM with a igbvf will not crash during reboot=
.

Tested-by: Yanghang Liu<yanghliu@redhat.com>



On Mon, Nov 27, 2023 at 5:12=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:

> On 11/23/23 08:56, Akihiko Odaki wrote:
> > g_new() aborts if the allocation fails so it returns NULL only if the
> > requested allocation size is zero. register_vfs() makes such an
> > allocation if NumVFs is zero so it should not assert that g_new()
> > returns a non-NULL value.
> >
> > Fixes: 7c0fa8dff8 ("pcie: Add support for Single Root I/O Virtualizatio=
n
> (SR/IOV)")
> > Buglink: https://issues.redhat.com/browse/RHEL-17209
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
>
> Thanks,
>
> C.
>
>
> > ---
> >   hw/pci/pcie_sriov.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> > index 5ef8950940..a1fe65f5d8 100644
> > --- a/hw/pci/pcie_sriov.c
> > +++ b/hw/pci/pcie_sriov.c
> > @@ -178,7 +178,6 @@ static void register_vfs(PCIDevice *dev)
> >       num_vfs =3D pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_=
VF);
> >
> >       dev->exp.sriov_pf.vf =3D g_new(PCIDevice *, num_vfs);
> > -    assert(dev->exp.sriov_pf.vf);
> >
> >       trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
> >                                PCI_FUNC(dev->devfn), num_vfs);
>
>
>

--00000000000029241e060b5b9b2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>After applying this patch, the VM with a igbvf will n=
ot crash during reboot.</div><div><br></div><div>Tested-by: Yanghang Liu&lt=
;<a href=3D"mailto:yanghliu@redhat.com">yanghliu@redhat.com</a>&gt;</div><d=
iv><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signa=
ture"><div dir=3D"ltr"><div><br></div></div></div></div><br></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 27,=
 2023 at 5:12=E2=80=AFPM C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@re=
dhat.com">clg@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On 11/23/23 08:56, Akihiko Odaki wrote:<br>
&gt; g_new() aborts if the allocation fails so it returns NULL only if the<=
br>
&gt; requested allocation size is zero. register_vfs() makes such an<br>
&gt; allocation if NumVFs is zero so it should not assert that g_new()<br>
&gt; returns a non-NULL value.<br>
&gt; <br>
&gt; Fixes: 7c0fa8dff8 (&quot;pcie: Add support for Single Root I/O Virtual=
ization (SR/IOV)&quot;)<br>
&gt; Buglink: <a href=3D"https://issues.redhat.com/browse/RHEL-17209" rel=
=3D"noreferrer" target=3D"_blank">https://issues.redhat.com/browse/RHEL-172=
09</a><br>
&gt; Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@dayni=
x.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
<br>
<br>
Reviewed-by: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@redhat.com" ta=
rget=3D"_blank">clg@redhat.com</a>&gt;<br>
<br>
Thanks,<br>
<br>
C.<br>
<br>
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/pci/pcie_sriov.c | 1 -<br>
&gt;=C2=A0 =C2=A01 file changed, 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c<br>
&gt; index 5ef8950940..a1fe65f5d8 100644<br>
&gt; --- a/hw/pci/pcie_sriov.c<br>
&gt; +++ b/hw/pci/pcie_sriov.c<br>
&gt; @@ -178,7 +178,6 @@ static void register_vfs(PCIDevice *dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0num_vfs =3D pci_get_word(dev-&gt;config + sr=
iov_cap + PCI_SRIOV_NUM_VF);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;exp.sriov_pf.vf =3D g_new(PCIDevice =
*, num_vfs);<br>
&gt; -=C2=A0 =C2=A0 assert(dev-&gt;exp.sriov_pf.vf);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_sriov_register_vfs(dev-&gt;name, PCI_S=
LOT(dev-&gt;devfn),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PCI_FUNC(dev-&gt;devfn), num_vfs)=
;<br>
<br>
<br>
</blockquote></div>

--00000000000029241e060b5b9b2a--


