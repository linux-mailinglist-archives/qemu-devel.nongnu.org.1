Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEC47421C5
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:06:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEmfF-0003Sm-9g; Thu, 29 Jun 2023 04:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEmey-0003Rt-Vl
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEmex-0005TA-70
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688025946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n8h5szLazqyzS9bD7L7GzQHucJ3ZNe7P6WDMK97NpJU=;
 b=QGFct/uYWnWW7GPMnnVN5ApCzrjRWbpDAT2MJeigkRMDEqhdGCedDmu7VMnOfkyj/DJv7v
 R8vgm/0X1aabJxj1G0cJu1CyV9Mmako1b9a25odWzLADDR95hhG4D9PMrvcuCrnFcP0kYb
 DLMSgZbI1vCivnsQCbKpnsZWUMfP/0k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-wgdhKx8YNJa4D-TAoJd-JQ-1; Thu, 29 Jun 2023 04:05:43 -0400
X-MC-Unique: wgdhKx8YNJa4D-TAoJd-JQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-977e6c94186so36589166b.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 01:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688025942; x=1690617942;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n8h5szLazqyzS9bD7L7GzQHucJ3ZNe7P6WDMK97NpJU=;
 b=j3COqXSbCeUPGEQbiNXvYv8JxMx3LMxsHlhnHZeiU5xu8qvg33Msjp65ISQUz1bJDd
 gG6Q/ODffmWlaWcdkcn0Zi72UKFn1jxDDBE769kigjbtFlSzgBcZC9x04M+UyzyI7jiB
 QJ5Uzh6SzzcbzBkoblveiDqOIfhNOCwpsazK2hPy6CD3XJLX0ZrUH1dz05jruTfFa+el
 Ic2Mq2a3O3JUMKaHepehvrT3sKRvMG5CWPwRiyvOlTUv2yi0m10mxj0gbBYrvxa3Oqtl
 jEfJaHQXZR17BOPDJT8E8jcO5e0cuB4aUzElknNUICuqxmCN7J3sDa1fu6BVDJSNu2sN
 Iqbg==
X-Gm-Message-State: ABy/qLYtp/WmzvWnpnT3z8IA4ga93dWHDafeVmVuKwHNFjYimIW+XRMX
 1BJ8n5lvpu7RfXgWQ4Ekb9KjszrbhaXXL5/G7Sm7W16xLmcr8HznRA1y15m2HQJkqkNTM3HAY+K
 jE8WhgRstrkVyoVu12B2RD08blWnDlIw=
X-Received: by 2002:a17:906:3b46:b0:992:b928:adb3 with SMTP id
 h6-20020a1709063b4600b00992b928adb3mr285114ejf.54.1688025942592; 
 Thu, 29 Jun 2023 01:05:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEgz67Eie2EzntYOzfjhDRFLurZbW2I5yhmdL1C53U4PEdwldl+O4bHRLxxZukfReOmMoeLr0pLhJy76Yve5fY=
X-Received: by 2002:a17:906:3b46:b0:992:b928:adb3 with SMTP id
 h6-20020a1709063b4600b00992b928adb3mr285102ejf.54.1688025942253; Thu, 29 Jun
 2023 01:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-6-anisinha@redhat.com>
 <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
In-Reply-To: <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 29 Jun 2023 13:35:30 +0530
Message-ID: <CAK3XEhNOJkm13+vxJO9-Adhwq8NJ3TQ1gaOXj8Dn3NtixF_=jQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a9294605ff402a56"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

--000000000000a9294605ff402a56
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Jun, 2023, 12:17 pm Akihiko Odaki, <akihiko.odaki@daynix.com>
wrote:

> On 2023/06/29 13:07, Ani Sinha wrote:
> > PCI Express ports only have one slot, so PCI Express devices can only be
> > plugged into slot 0 on a PCIE port. Enforce it.
> >
> > The change has been tested to not break ARI by instantiating seven vfs
> on an
> > emulated igb device (the maximum number of vfs the linux igb driver
> supports).
> > The vfs are seen to have non-zero device/slot numbers in the conventional
> > PCI BDF representation.
> >
> > CC: jusual@redhat.com
> > CC: imammedo@redhat.com
> > CC: akihiko.odaki@daynix.com
> >
> > Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > Reviewed-by: Julia Suvorova <jusual@redhat.com>
> > ---
> >   hw/pci/pci.c | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> >
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index e2eb4c3b4a..0320ac2bb3 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -65,6 +65,7 @@ bool pci_available = true;
> >   static char *pcibus_get_dev_path(DeviceState *dev);
> >   static char *pcibus_get_fw_dev_path(DeviceState *dev);
> >   static void pcibus_reset(BusState *qbus);
> > +static bool pcie_has_upstream_port(PCIDevice *dev);
> >
> >   static Property pci_props[] = {
> >       DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> > @@ -1190,6 +1191,20 @@ static PCIDevice
> *do_pci_register_device(PCIDevice *pci_dev,
> >                      name);
> >
> >          return NULL;
> > +    } /*
> > +       * With SRIOV and ARI, vfs can have non-zero slot in the
> conventional
> > +       * PCI interpretation as all five bits reserved for slot
> addresses are
> > +       * also used for function bits for the various vfs. Ignore that
> case.
> > +       * It is too early here to check for ARI capabilities in the PCI
> config
> > +       * space. Hence, we check for a vf device instead.
> > +       */
>
> Why don't just perform this check after the capabilities are set?
>

We don't want to allocate resources for wrong device parameters. We want to
error out early. Other checks also are performed at the same place .
Show quoted text

>
>
>
> Regards,
> Akihiko Odaki
>
> > +    else if (!pci_is_vf(pci_dev) &&
> > +             pcie_has_upstream_port(pci_dev) &&
> > +             PCI_SLOT(devfn)) {
> > +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> > +                   " parent device only allows plugging into slot 0.",
> > +                   PCI_SLOT(devfn), name);
> > +        return NULL;
> >       }
> >
> >       pci_dev->devfn = devfn;
>
>

--000000000000a9294605ff402a56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, 29 Jun, 2023, 12:17 pm Akihiko Odaki, &lt;<a h=
ref=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">On 2023/06/29 13:07, Ani Sinha=
 wrote:<br>
&gt; PCI Express ports only have one slot, so PCI Express devices can only =
be<br>
&gt; plugged into slot 0 on a PCIE port. Enforce it.<br>
&gt; <br>
&gt; The change has been tested to not break ARI by instantiating seven vfs=
 on an<br>
&gt; emulated igb device (the maximum number of vfs the linux igb driver su=
pports).<br>
&gt; The vfs are seen to have non-zero device/slot numbers in the conventio=
nal<br>
&gt; PCI BDF representation.<br>
&gt; <br>
&gt; CC: <a href=3D"mailto:jusual@redhat.com" target=3D"_blank" rel=3D"nore=
ferrer">jusual@redhat.com</a><br>
&gt; CC: <a href=3D"mailto:imammedo@redhat.com" target=3D"_blank" rel=3D"no=
referrer">imammedo@redhat.com</a><br>
&gt; CC: <a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank" rel=
=3D"noreferrer">akihiko.odaki@daynix.com</a><br>
&gt; <br>
&gt; Resolves: <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D212=
8929" rel=3D"noreferrer noreferrer" target=3D"_blank">https://bugzilla.redh=
at.com/show_bug.cgi?id=3D2128929</a><br>
&gt; Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:anisinha@redhat.com" ta=
rget=3D"_blank" rel=3D"noreferrer">anisinha@redhat.com</a>&gt;<br>
&gt; Reviewed-by: Julia Suvorova &lt;<a href=3D"mailto:jusual@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">jusual@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/pci/pci.c | 15 +++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 15 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/pci/pci.c b/hw/pci/pci.c<br>
&gt; index e2eb4c3b4a..0320ac2bb3 100644<br>
&gt; --- a/hw/pci/pci.c<br>
&gt; +++ b/hw/pci/pci.c<br>
&gt; @@ -65,6 +65,7 @@ bool pci_available =3D true;<br>
&gt;=C2=A0 =C2=A0static char *pcibus_get_dev_path(DeviceState *dev);<br>
&gt;=C2=A0 =C2=A0static char *pcibus_get_fw_dev_path(DeviceState *dev);<br>
&gt;=C2=A0 =C2=A0static void pcibus_reset(BusState *qbus);<br>
&gt; +static bool pcie_has_upstream_port(PCIDevice *dev);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static Property pci_props[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_PCI_DEVFN(&quot;addr&quot;, PCID=
evice, devfn, -1),<br>
&gt; @@ -1190,6 +1191,20 @@ static PCIDevice *do_pci_register_device(PCIDev=
ice *pci_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 name);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 } /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0* With SRIOV and ARI, vfs can have non-zer=
o slot in the conventional<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0* PCI interpretation as all five bits rese=
rved for slot addresses are<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0* also used for function bits for the vari=
ous vfs. Ignore that case.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0* It is too early here to check for ARI ca=
pabilities in the PCI config<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0* space. Hence, we check for a vf device i=
nstead.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
<br>
Why don&#39;t just perform this check after the capabilities are set?<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div d=
ir=3D"auto" style=3D"font-size:12.8px">We don&#39;t want to allocate resour=
ces for wrong device parameters. We want to error out early. Other checks a=
lso are performed at the same place .=C2=A0</div><div dir=3D"auto" style=3D=
"color:rgb(66,133,244);font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:12px;line-height:normal;padding:24p=
x 0px">Show quoted text</div></div><div dir=3D"auto"><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
<br><br><br>
Regards,<br>
Akihiko Odaki<br>
<br>
&gt; +=C2=A0 =C2=A0 else if (!pci_is_vf(pci_dev) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie_has_upstream_por=
t(pci_dev) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_SLOT(devfn)) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;PCI: slot %d is no=
t valid for %s,&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&quot; parent device only allows plugging into slot 0.&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
PCI_SLOT(devfn), name);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dev-&gt;devfn =3D devfn;<br>
<br>
</blockquote></div></div></div>

--000000000000a9294605ff402a56--


