Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F38747162
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:30:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGf9h-0006GD-K2; Tue, 04 Jul 2023 08:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGf9f-0006Fp-A7
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGf9c-0000fG-Lg
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688473751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xTyqQcTF4Rat9D7W9MR2l9sxbJy3KOaTMD6k6dIF6Mg=;
 b=feLyYikIadwvRAV/HCCKIxkHn+aeByDh86xYK6iYh2vuRu94kSkG2PtQm9F0Bipam3+OAB
 ODO6H6A8xjPyA9/J5QNoeDJ+XVjL1620IzmqlUJH5LkvqYmegNtsuUp2W5Uw0oSMum31Wl
 wAlmvChFvK17jtVg6Gm9KggnqBC5Gn4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-vrvfM8FpPvuGouDbIG1BFw-1; Tue, 04 Jul 2023 08:29:10 -0400
X-MC-Unique: vrvfM8FpPvuGouDbIG1BFw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a348facbbso383555666b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688473749; x=1691065749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xTyqQcTF4Rat9D7W9MR2l9sxbJy3KOaTMD6k6dIF6Mg=;
 b=CuKvQtVEImiF+2HgMnYKN+WHi3hPHwC+gG6r+23FHtGO0Ai6Vv0lae+tSkZW42gN93
 3arkGjZPRmoIeSdPks1j/CVM16xD3NhFrVsRYV42YK/1daWKGwzSa68UmzgWlq92Yi2y
 l7CTpj8XNaCMNCs2hdBa5UYTs3IylUamO0HVOWFo1gwWOvVTLRDd0/udDc75pakOwUtZ
 vNln42KEpjnV6ZkQeIkdGh0H0jUMwAPuLzV4hVvwL9CM8DoefTSMhysvAOPqoqarDwyA
 fvK5sF3lxsbpYxPdqw91YDkjj3PE9uQaUHit2b/tXhLMWeKBHL3hpaf+QbLSPJiqvFY7
 ubIw==
X-Gm-Message-State: ABy/qLZ0nYDjcJ1r2/0M+EbFLcAkUnC4bphUADcywdx0RAm8Z9slCMSY
 Nt0BAmd+PTs8KO6MfoQqBkd7F2C+F18N4pk67BsSRd7v458njbtd8x2Q1q8WhEmWK70HqX5X3A5
 8Wek6JxIaeCU548tPyvw8JGh6ugov23g=
X-Received: by 2002:a17:906:114e:b0:966:5a6c:752d with SMTP id
 i14-20020a170906114e00b009665a6c752dmr9638918eja.20.1688473749088; 
 Tue, 04 Jul 2023 05:29:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFNXssdrZRCsbvFFQNiXeHdBAzkS8NnZsJvDaDSJuhepFbV/RGG3Tzm9BLUAqYmbG5Rvsu7ArqI9RnttgVCcLY=
X-Received: by 2002:a17:906:114e:b0:966:5a6c:752d with SMTP id
 i14-20020a170906114e00b009665a6c752dmr9638906eja.20.1688473748801; Tue, 04
 Jul 2023 05:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230704112555.5629-1-anisinha@redhat.com>
 <20230704112555.5629-6-anisinha@redhat.com>
 <7356dc51-588c-f2f8-22d9-c8193bae9309@daynix.com>
 <2C9BF0F4-6CB0-4805-818D-51CABC1EAFDE@redhat.com>
 <bf793e6b-62a0-0772-0d64-ddb5894ebf53@daynix.com>
 <6AB4A93A-7543-4991-A934-4C6054F0C2BA@redhat.com>
 <912dc66d-dad1-53a1-be4e-3ba795ccb947@daynix.com>
In-Reply-To: <912dc66d-dad1-53a1-be4e-3ba795ccb947@daynix.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 4 Jul 2023 17:58:56 +0530
Message-ID: <CAK3XEhMoOvnrhN-H9DNj4GpaCsWq_syk_H=w6NLD2xSMdSn1DQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000002a5f405ffa86e40"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

--00000000000002a5f405ffa86e40
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jul, 2023, 5:39 pm Akihiko Odaki, <akihiko.odaki@daynix.com>
wrote:

> On 2023/07/04 21:08, Ani Sinha wrote:
> >
> >
> >> On 04-Jul-2023, at 5:32 PM, Akihiko Odaki <akihiko.odaki@daynix.com>
> wrote:
> >>
> >> On 2023/07/04 20:59, Ani Sinha wrote:
> >>>> On 04-Jul-2023, at 5:24 PM, Akihiko Odaki <akihiko.odaki@daynix.com>
> wrote:
> >>>>
> >>>> On 2023/07/04 20:25, Ani Sinha wrote:
> >>>>> PCI Express ports only have one slot, so PCI Express devices can
> only be
> >>>>> plugged into slot 0 on a PCIE port. Add a warning to let users know
> when the
> >>>>> invalid configuration is used. We may enforce this more strongly
> later on once
> >>>>> we get more clarity on whether we are introducing a bad regression
> for users
> >>>>> currenly using the wrong configuration.
> >>>>> The change has been tested to not break or alter behaviors of ARI
> capable
> >>>>> devices by instantiating seven vfs on an emulated igb device (the
> maximum
> >>>>> number of vfs the linux igb driver supports). The vfs instantiated
> correctly
> >>>>> and are seen to have non-zero device/slot numbers in the
> conventional PCI BDF
> >>>>> representation.
> >>>>> CC: jusual@redhat.com
> >>>>> CC: imammedo@redhat.com
> >>>>> CC: mst@redhat.com
> >>>>> CC: akihiko.odaki@daynix.com
> >>>>> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> >>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >>>>> Reviewed-by: Julia Suvorova <jusual@redhat.com>
> >>>>> ---
> >>>>>   hw/pci/pci.c | 15 +++++++++++++++
> >>>>>   1 file changed, 15 insertions(+)
> >>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >>>>> index e2eb4c3b4a..47517ba3db 100644
> >>>>> --- a/hw/pci/pci.c
> >>>>> +++ b/hw/pci/pci.c
> >>>>> @@ -65,6 +65,7 @@ bool pci_available = true;
> >>>>>   static char *pcibus_get_dev_path(DeviceState *dev);
> >>>>>   static char *pcibus_get_fw_dev_path(DeviceState *dev);
> >>>>>   static void pcibus_reset(BusState *qbus);
> >>>>> +static bool pcie_has_upstream_port(PCIDevice *dev);
> >>>>>     static Property pci_props[] = {
> >>>>>       DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> >>>>> @@ -2121,6 +2122,20 @@ static void pci_qdev_realize(DeviceState
> *qdev, Error **errp)
> >>>>>           }
> >>>>>       }
> >>>>>   +    /*
> >>>>> +     * With SRIOV and ARI, vfs can have non-zero slot in the
> conventional
> >>>>> +     * PCI interpretation as all five bits reserved for slot
> addresses are
> >>>>> +     * also used for function bits for the various vfs. Ignore that
> case.
> >>>>
> >>>> You don't have to mention SR/IOV; it affects all ARI-capable devices.
> A PF can also have non-zero slot number in the conventional interpretation
> so you shouldn't call it vf either.
> >>> Can you please help write a comment that explains this properly for
> all cases - ARI/non-ARI, PFs and VFs? Once everyone agrees that its clear
> and correct, I will re-spin.
> >>
> >> Simply, you can say:
> >> With ARI, the slot number field in the conventional PCI interpretation
> can have a non-zero value as the field bits are reused to extend the
> function number bits. Ignore that case.
> >
> > but we are not checking for ARI capability here in the code. So the
> comment is confusing.
>
> Don't we? We check for:
> !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI)
>

Yes I was thinking of patch 6 in the series which also adds a comment for
ARI.

I'll wait to see what others thought of your suggestion before respinning
patch 5


>
> >>
> >>>>
> >>>>> +     */
> >>>>> +    if (pci_is_express(pci_dev) &&
> >>>>> +        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
> >>>>> +        pcie_has_upstream_port(pci_dev) &&
> >>>>> +        PCI_SLOT(pci_dev->devfn)) {
> >>>>> +        warn_report("PCI: slot %d is not valid for %s,"
> >>>>> +                    " parent device only allows plugging into slot
> 0.",
> >>>>> +                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
> >>>>> +    }
> >>>>> +
> >>>>>       if (pci_dev->failover_pair_id) {
> >>>>>           if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
> >>>>>               error_setg(errp, "failover primary device must be on "
> >
>
>

--00000000000002a5f405ffa86e40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, 4 Jul, 2023, 5:39 pm Akihiko Odaki, &lt;<a hre=
f=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">On 2023/07/04 21:08, Ani Sinha w=
rote:<br>
&gt; <br>
&gt; <br>
&gt;&gt; On 04-Jul-2023, at 5:32 PM, Akihiko Odaki &lt;<a href=3D"mailto:ak=
ihiko.odaki@daynix.com" target=3D"_blank" rel=3D"noreferrer">akihiko.odaki@=
daynix.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On 2023/07/04 20:59, Ani Sinha wrote:<br>
&gt;&gt;&gt;&gt; On 04-Jul-2023, at 5:24 PM, Akihiko Odaki &lt;<a href=3D"m=
ailto:akihiko.odaki@daynix.com" target=3D"_blank" rel=3D"noreferrer">akihik=
o.odaki@daynix.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 2023/07/04 20:25, Ani Sinha wrote:<br>
&gt;&gt;&gt;&gt;&gt; PCI Express ports only have one slot, so PCI Express d=
evices can only be<br>
&gt;&gt;&gt;&gt;&gt; plugged into slot 0 on a PCIE port. Add a warning to l=
et users know when the<br>
&gt;&gt;&gt;&gt;&gt; invalid configuration is used. We may enforce this mor=
e strongly later on once<br>
&gt;&gt;&gt;&gt;&gt; we get more clarity on whether we are introducing a ba=
d regression for users<br>
&gt;&gt;&gt;&gt;&gt; currenly using the wrong configuration.<br>
&gt;&gt;&gt;&gt;&gt; The change has been tested to not break or alter behav=
iors of ARI capable<br>
&gt;&gt;&gt;&gt;&gt; devices by instantiating seven vfs on an emulated igb =
device (the maximum<br>
&gt;&gt;&gt;&gt;&gt; number of vfs the linux igb driver supports). The vfs =
instantiated correctly<br>
&gt;&gt;&gt;&gt;&gt; and are seen to have non-zero device/slot numbers in t=
he conventional PCI BDF<br>
&gt;&gt;&gt;&gt;&gt; representation.<br>
&gt;&gt;&gt;&gt;&gt; CC: <a href=3D"mailto:jusual@redhat.com" target=3D"_bl=
ank" rel=3D"noreferrer">jusual@redhat.com</a><br>
&gt;&gt;&gt;&gt;&gt; CC: <a href=3D"mailto:imammedo@redhat.com" target=3D"_=
blank" rel=3D"noreferrer">imammedo@redhat.com</a><br>
&gt;&gt;&gt;&gt;&gt; CC: <a href=3D"mailto:mst@redhat.com" target=3D"_blank=
" rel=3D"noreferrer">mst@redhat.com</a><br>
&gt;&gt;&gt;&gt;&gt; CC: <a href=3D"mailto:akihiko.odaki@daynix.com" target=
=3D"_blank" rel=3D"noreferrer">akihiko.odaki@daynix.com</a><br>
&gt;&gt;&gt;&gt;&gt; Resolves: <a href=3D"https://bugzilla.redhat.com/show_=
bug.cgi?id=3D2128929" rel=3D"noreferrer noreferrer" target=3D"_blank">https=
://bugzilla.redhat.com/show_bug.cgi?id=3D2128929</a><br>
&gt;&gt;&gt;&gt;&gt; Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:anisinh=
a@redhat.com" target=3D"_blank" rel=3D"noreferrer">anisinha@redhat.com</a>&=
gt;<br>
&gt;&gt;&gt;&gt;&gt; Reviewed-by: Julia Suvorova &lt;<a href=3D"mailto:jusu=
al@redhat.com" target=3D"_blank" rel=3D"noreferrer">jusual@redhat.com</a>&g=
t;<br>
&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0hw/pci/pci.c | 15 +++++++++++++++<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A01 file changed, 15 insertions(+)<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/hw/pci/pci.c b/hw/pci/pci.c<br>
&gt;&gt;&gt;&gt;&gt; index e2eb4c3b4a..47517ba3db 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/hw/pci/pci.c<br>
&gt;&gt;&gt;&gt;&gt; +++ b/hw/pci/pci.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -65,6 +65,7 @@ bool pci_available =3D true;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0static char *pcibus_get_dev_path(DeviceSta=
te *dev);<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0static char *pcibus_get_fw_dev_path(Device=
State *dev);<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0static void pcibus_reset(BusState *qbus);<=
br>
&gt;&gt;&gt;&gt;&gt; +static bool pcie_has_upstream_port(PCIDevice *dev);<b=
r>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0static Property pci_props[] =3D {<b=
r>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_PCI_DEVFN(&quot;=
addr&quot;, PCIDevice, devfn, -1),<br>
&gt;&gt;&gt;&gt;&gt; @@ -2121,6 +2122,20 @@ static void pci_qdev_realize(De=
viceState *qdev, Error **errp)<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0+=C2=A0 =C2=A0 /*<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* With SRIOV and ARI, vfs can hav=
e non-zero slot in the conventional<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* PCI interpretation as all five =
bits reserved for slot addresses are<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* also used for function bits for=
 the various vfs. Ignore that case.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; You don&#39;t have to mention SR/IOV; it affects all ARI-c=
apable devices. A PF can also have non-zero slot number in the conventional=
 interpretation so you shouldn&#39;t call it vf either.<br>
&gt;&gt;&gt; Can you please help write a comment that explains this properl=
y for all cases - ARI/non-ARI, PFs and VFs? Once everyone agrees that its c=
lear and correct, I will re-spin.<br>
&gt;&gt;<br>
&gt;&gt; Simply, you can say:<br>
&gt;&gt; With ARI, the slot number field in the conventional PCI interpreta=
tion can have a non-zero value as the field bits are reused to extend the f=
unction number bits. Ignore that case.<br>
&gt; <br>
&gt; but we are not checking for ARI capability here in the code. So the co=
mment is confusing.<br>
<br>
Don&#39;t we? We check for:<br>
!pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI)<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes I was thinking of pat=
ch 6 in the series which also adds a comment for ARI.</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">I&#39;ll wait to see what others thought of y=
our suggestion before respinning patch 5</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
&gt; <br>
&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (pci_is_express(pci_dev) &amp;&amp;<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !pcie_find_capability(pci=
_dev, PCI_EXT_CAP_ID_ARI) &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcie_has_upstream_port(pc=
i_dev) &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PCI_SLOT(pci_dev-&gt;devf=
n)) {<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;PCI: sl=
ot %d is not valid for %s,&quot;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot; parent device only allows plugging into slot 0.&qu=
ot;,<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 PCI_SLOT(pci_dev-&gt;devfn), pci_dev-&gt;name);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pci_dev-&gt;failover_pai=
r_id) {<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pci_bus_i=
s_express(pci_get_bus(pci_dev))) {<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
error_setg(errp, &quot;failover primary device must be on &quot;<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--00000000000002a5f405ffa86e40--


