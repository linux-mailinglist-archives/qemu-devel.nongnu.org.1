Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A965747168
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:33:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfCI-0000HS-UN; Tue, 04 Jul 2023 08:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGfBz-000074-7h
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGfBw-0001Yu-2x
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688473893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NfMn8aEZyXNuqSBQa5baCZrasedFuZKdb6guma9309M=;
 b=CZe2iYMRYPDGmE0cnNaQvvDOnod3LQufW0uqLHuQevQ9MDY3fK2fKqpmJW3P2MfnOS5+eB
 dNg/XNheFY2MB6/GDyVOMWbkKm+tCaVrcQUre2f12qE5AEtIKwuR+Snce7eyuE3UzAv5H1
 RuYKzh0Uir6Z6QlIZZtQbPhm2NkMDPA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-aVhjfZP3OSSVuRKKhqniXA-1; Tue, 04 Jul 2023 08:31:29 -0400
X-MC-Unique: aVhjfZP3OSSVuRKKhqniXA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9874fbf5c95so653793066b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688473888; x=1691065888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NfMn8aEZyXNuqSBQa5baCZrasedFuZKdb6guma9309M=;
 b=Mm3Tdq4gTwH5nMzpgg1tiFc3wPHRAFVK3wtU9eCh8nlIpykcZDBwU7GUgQghXF92Wg
 LfZX1ZQZ6l3HKqE3bBlMQ/J4bS6B4EuEQcN57XWaTZbZx52fsW1lv3tU5/s/ulHVg803
 UqwAojEkiXq6yc9rinRLiSbZuH4h4WmiQWLFb8YEnFfX4tEVoQAfW1BcZCFLElomKYHQ
 tA7un1ER4wnPnCJDLmkvfQmPw8/vfoNyPwbz40U9lQ+D22yW3/8atYsevM9GYtjsK2m7
 oJG3oj0IBlcBcaQWp69+lkaL/jmS2HBWFRSBu3nYykigq9WwLqxaeY5EdY6xaMOJ3sYL
 5BJg==
X-Gm-Message-State: AC+VfDz5GwI/KcSzino0WX9CoF0P3lZeM5GRNED20xqHTYQLksHLW0oL
 caSPMkRfOfHRJy3KrjGAUaYfZjR+o3KPg0R6mDi0AW2qKl/JwPTPqYidkm7JNKaQGdezg7TCXH6
 C+UAW7fO4zN7CPJrp66uQRAq9aa87IGw=
X-Received: by 2002:a17:907:94ce:b0:992:13c7:560 with SMTP id
 dn14-20020a17090794ce00b0099213c70560mr13681575ejc.38.1688473888700; 
 Tue, 04 Jul 2023 05:31:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45TCkVk7vBgrmJ06NsuJ1xqImZAyZJ01AIGq1rNsTNTwvTYd75JBVk5gM2porK0O1LIXkqhW3TsKjDFo4oab4=
X-Received: by 2002:a17:907:94ce:b0:992:13c7:560 with SMTP id
 dn14-20020a17090794ce00b0099213c70560mr13681555ejc.38.1688473888380; Tue, 04
 Jul 2023 05:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230704112555.5629-1-anisinha@redhat.com>
 <20230704112555.5629-7-anisinha@redhat.com>
 <20230704141524.3ddacd34@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230704141524.3ddacd34@imammedo.users.ipa.redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 4 Jul 2023 18:01:16 +0530
Message-ID: <CAK3XEhPRbwx96xYDYK8RWpC5j=bDD=wTUhj-NQEs2FHYxJac1Q@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] hw/pci: add comment explaining the reason for
 checking function 0 in hotplug
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000054710905ffa87688"
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

--00000000000054710905ffa87688
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jul, 2023, 5:45 pm Igor Mammedov, <imammedo@redhat.com> wrote:

> On Tue,  4 Jul 2023 16:55:55 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
>
> > This change is cosmetic. A comment is added explaining why we need to
> check for
> > the availability of function 0 when we hotplug a device.
> >
> > CC: mst@redhat.com
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >  hw/pci/pci.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 47517ba3db..e3ff3808b6 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -1181,9 +1181,15 @@ static PCIDevice
> *do_pci_register_device(PCIDevice *pci_dev,
> >                     PCI_SLOT(devfn), PCI_FUNC(devfn), name,
> >                     bus->devices[devfn]->name, bus->devices[devfn]->
> qdev.id);
> >          return NULL;
> > -    } else if (dev->hotplugged &&
> > -               !pci_is_vf(pci_dev) &&
> > -               pci_get_function_0(pci_dev)) {
> > +    } /*
> > +       * Populating function 0 triggers a scan from the guest that
> > +       * exposes other non-zero functions. Hence we need to ensure that
> > +       * function 0 wasn't added yet.
>
> > With SRIOV and with or without ARI
> > +       * the PF must be hotplugged into function 0 for it to be
> detected.
> Wouldn't the same apply to non-SR-IOV devices as well?
>

I was trying to emphasize PFs and SRIOV. But may be it adds more confusion
and better left out.

>
> > +       */
> > +    else if (dev->hotplugged &&
> > +             !pci_is_vf(pci_dev) &&
> > +             pci_get_function_0(pci_dev)) {
> >          error_setg(errp, "PCI: slot %d function 0 already occupied by
> %s,"
> >                     " new func %s cannot be exposed to guest.",
> >                     PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
>
>

--00000000000054710905ffa87688
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, 4 Jul, 2023, 5:45 pm Igor Mammedov, &lt;<a hre=
f=3D"mailto:imammedo@redhat.com">imammedo@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">On Tue,=C2=A0 4 Jul 2023 16:55:55 +0530<br=
>
Ani Sinha &lt;<a href=3D"mailto:anisinha@redhat.com" target=3D"_blank" rel=
=3D"noreferrer">anisinha@redhat.com</a>&gt; wrote:<br>
<br>
&gt; This change is cosmetic. A comment is added explaining why we need to =
check for<br>
&gt; the availability of function 0 when we hotplug a device.<br>
&gt; <br>
&gt; CC: <a href=3D"mailto:mst@redhat.com" target=3D"_blank" rel=3D"norefer=
rer">mst@redhat.com</a><br>
&gt; Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:anisinha@redhat.com" ta=
rget=3D"_blank" rel=3D"noreferrer">anisinha@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/pci/pci.c | 12 +++++++++---<br>
&gt;=C2=A0 1 file changed, 9 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/pci/pci.c b/hw/pci/pci.c<br>
&gt; index 47517ba3db..e3ff3808b6 100644<br>
&gt; --- a/hw/pci/pci.c<br>
&gt; +++ b/hw/pci/pci.c<br>
&gt; @@ -1181,9 +1181,15 @@ static PCIDevice *do_pci_register_device(PCIDev=
ice *pci_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0PCI_SLOT(devfn), PCI_FUNC(devfn), name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0bus-&gt;devices[devfn]-&gt;name, bus-&gt;devices[devfn]-&gt;<a href=
=3D"http://qdev.id" rel=3D"noreferrer noreferrer" target=3D"_blank">qdev.id=
</a>);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; -=C2=A0 =C2=A0 } else if (dev-&gt;hotplugged &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!pci_is_vf(pci=
_dev) &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_get_functi=
on_0(pci_dev)) {<br>
&gt; +=C2=A0 =C2=A0 } /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0* Populating function 0 triggers a scan fr=
om the guest that<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0* exposes other non-zero functions. Hence =
we need to ensure that<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0* function 0 wasn&#39;t added yet.<br>
<br>
&gt; With SRIOV and with or without ARI<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0* the PF must be hotplugged into function =
0 for it to be detected.<br>
Wouldn&#39;t the same apply to non-SR-IOV devices as well?<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I was trying to e=
mphasize PFs and SRIOV. But may be it adds more confusion and better left o=
ut.=C2=A0</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 else if (dev-&gt;hotplugged &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!pci_is_vf(pci_dev) &=
amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_get_function_0(pc=
i_dev)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;PCI: slot %d =
function 0 already occupied by %s,&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot; new func %s cannot be exposed to guest.&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0PCI_SLOT(pci_get_function_0(pci_dev)-&gt;devfn),<br>
<br>
</blockquote></div></div></div>

--00000000000054710905ffa87688--


