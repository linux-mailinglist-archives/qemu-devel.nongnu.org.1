Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 896587AADB5
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:21:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcLC-0000XY-1k; Fri, 22 Sep 2023 05:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcL8-0000VV-4m
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:20:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcL4-0000yc-Me
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695374442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l2Y88LBUNMolB5acaRDTbaBR/Cap9O8PmqKs2/QD3bA=;
 b=CfWwGzJ3ofXeHrA7441o7SaXq2UuJN399NfJjLEYuAOI1PAMO0JBbTUZqdObzIXnmGNTj6
 pvFcvJSwWp1Wm8TcozCaE1aStBmHSbuchJw1sTWoeuoVAQW+K+yenGaRkhi2kflo6eHBbR
 LpqKjQ/T/22uRqnKs4rXNSBmVCv09ks=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-cmF8x0_qN_GHXbB-7-FZ-g-1; Fri, 22 Sep 2023 05:20:40 -0400
X-MC-Unique: cmF8x0_qN_GHXbB-7-FZ-g-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-45289b05c67so829241137.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695374439; x=1695979239;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l2Y88LBUNMolB5acaRDTbaBR/Cap9O8PmqKs2/QD3bA=;
 b=UstwR5D66EaNyf4VWUby8zq3cOF57TPzbiypIm3uMLJJUoCHapTTm6yKJoA0tODY4A
 NmnDSzpKpSyzMANlHqKzgngzCt9Gi3eWwvuyV32UkEj9CpsA0k07Q5vROkA6huvMhAXi
 EElHqkkgZwH9EUDN4M/4ZSSj4VXnnvukj/jIUAw56wuRJ7VQ73SqeupGWkO5a/ZsdQwS
 Oyj71Sp0GDLuTO8IMXT0THpIaOzbhW7Q5Vy5acMQxDoDx66n+7j0mNvHQHsFZwPd3TOn
 6bhO28+c/dvJp4NHjXDwlUcaXqJx2zzsk8wDR5oaPWJELGWeQxThXt84w8ZrdZOJ4bdN
 TgFg==
X-Gm-Message-State: AOJu0YwttGDl5DSiMQTZV1NYb5QMZ3GDgtXoTOd0AHQ56YnRCGXPYQdO
 edDil1HGdTbUsB1H9XvG2N6AxRBAsLvDReh5DJdgMVbgHrj+UJcHm2SqHux4Jt77eDXYK9LRAjK
 MgzvNwJK8JdWgJRkQU5BSPewQbe6pOT6wiHRXTyo=
X-Received: by 2002:a67:f947:0:b0:452:8422:1318 with SMTP id
 u7-20020a67f947000000b0045284221318mr8208150vsq.27.1695374438968; 
 Fri, 22 Sep 2023 02:20:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG/qOKWbmbOpvY5zfuxh6bOXPee836XAXVfOYP3W7ejY68a4bxXaVAF32afF+spmZC1dj7N9ldVw1PbkNdCWc=
X-Received: by 2002:a67:f947:0:b0:452:8422:1318 with SMTP id
 u7-20020a67f947000000b0045284221318mr8208140vsq.27.1695374438666; Fri, 22 Sep
 2023 02:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230921121051.192355-1-pbonzini@redhat.com>
 <20230921121051.192355-3-pbonzini@redhat.com>
 <9ad33139-93e3-12af-a67d-c7a3906198ce@redhat.com>
In-Reply-To: <9ad33139-93e3-12af-a67d-c7a3906198ce@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2023 11:20:28 +0200
Message-ID: <CABgObfZ1RcxkV57+HNjQcUS9a1ciPQnxvaAr33bzE7OJx5w5sQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] seabios: remove PCI drivers from bios.bin
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Hoffmann, Gerd" <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002da9c90605ef1f40"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000002da9c90605ef1f40
Content-Type: text/plain; charset="UTF-8"

Il ven 22 set 2023, 08:49 Thomas Huth <thuth@redhat.com> ha scritto:

> On 21/09/2023 14.10, Paolo Bonzini wrote:
> > bios.bin is now used only by ISA PC, so PCI drivers are not necessary.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   pc-bios/bios.bin         | Bin 131072 -> 131072 bytes
> >   roms/config.seabios-128k |  30 ++++++++++++++++++++++--------
> >   2 files changed, 22 insertions(+), 8 deletions(-)
> ...
> > diff --git a/roms/config.seabios-128k b/roms/config.seabios-128k
> > index d18c802c46e..06f4ba35bbe 100644
> > --- a/roms/config.seabios-128k
> > +++ b/roms/config.seabios-128k
> > @@ -1,21 +1,35 @@
> > -# for qemu machine types 1.7 + older
> > -# need to turn off features (xhci,uas) to make it fit into 128k
> > +# SeaBIOS Configuration for -M isapc
> > +
> > +#
> > +# General Features
> > +#
> >   CONFIG_QEMU=y
> >   CONFIG_ROM_SIZE=128
> >   CONFIG_ATA_DMA=n
> >   CONFIG_BOOTSPLASH=n
> >   CONFIG_XEN=n
> > -CONFIG_USB_OHCI=n
> > -CONFIG_USB_XHCI=n
> > -CONFIG_USB_UAS=n
> > +CONFIG_ATA_PIO32=n
> > +CONFIG_AHCI=n
> >   CONFIG_SDCARD=n
> >   CONFIG_TCGBIOS=n
> > -CONFIG_MPT_SCSI=n
> > -CONFIG_ESP_SCSI=n
> > -CONFIG_MEGASAS=n
> > +CONFIG_VIRTIO_BLK=n
> > +CONFIG_VIRTIO_SCSI=n
> >   CONFIG_PVSCSI=n
> > +CONFIG_ESP_SCSI=n
> > +CONFIG_LSI_SCSI=n
> > +CONFIG_MEGASAS=n
> > +CONFIG_MPT_SCSI=n
>
> Why did you change the order of MPT, ESP and MEGASAS?
>

Because the previous .config was written by hand while this one is
generated by "make menu config" (other than the comments at the top).

Paolo


> Apart from that, wrt to the config file changes:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> >   CONFIG_NVME=n
> >   CONFIG_USE_SMM=n
> >   CONFIG_VGAHOOKS=n
> >   CONFIG_HOST_BIOS_GEOMETRY=n
> > +CONFIG_PS2PORT=n
> > +CONFIG_USB=n
> > +CONFIG_PMTIMER=n
> > +CONFIG_PCIBIOS=n
> > +CONFIG_DISABLE_A20=n
> > +CONFIG_WRITABLE_UPPERMEMORY=n
> > +CONFIG_ACPI=n
> >   CONFIG_ACPI_PARSE=n
> > +CONFIG_DEBUG_SERIAL=n
> > +CONFIG_DEBUG_SERIAL_MMIO=n
>
>

--0000000000002da9c90605ef1f40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 22 set 2023, 08:49 Thomas Huth &lt;<a href=3D"m=
ailto:thuth@redhat.com">thuth@redhat.com</a>&gt; ha scritto:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">On 21/09/2023 14.10, Paolo Bonzini wrote:<br>
&gt; bios.bin is now used only by ISA PC, so PCI drivers are not necessary.=
<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0pc-bios/bios.bin=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Bin 13=
1072 -&gt; 131072 bytes<br>
&gt;=C2=A0 =C2=A0roms/config.seabios-128k |=C2=A0 30 ++++++++++++++++++++++=
--------<br>
&gt;=C2=A0 =C2=A02 files changed, 22 insertions(+), 8 deletions(-)<br>
...<br>
&gt; diff --git a/roms/config.seabios-128k b/roms/config.seabios-128k<br>
&gt; index d18c802c46e..06f4ba35bbe 100644<br>
&gt; --- a/roms/config.seabios-128k<br>
&gt; +++ b/roms/config.seabios-128k<br>
&gt; @@ -1,21 +1,35 @@<br>
&gt; -# for qemu machine types 1.7 + older<br>
&gt; -# need to turn off features (xhci,uas) to make it fit into 128k<br>
&gt; +# SeaBIOS Configuration for -M isapc<br>
&gt; +<br>
&gt; +#<br>
&gt; +# General Features<br>
&gt; +#<br>
&gt;=C2=A0 =C2=A0CONFIG_QEMU=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_ROM_SIZE=3D128<br>
&gt;=C2=A0 =C2=A0CONFIG_ATA_DMA=3Dn<br>
&gt;=C2=A0 =C2=A0CONFIG_BOOTSPLASH=3Dn<br>
&gt;=C2=A0 =C2=A0CONFIG_XEN=3Dn<br>
&gt; -CONFIG_USB_OHCI=3Dn<br>
&gt; -CONFIG_USB_XHCI=3Dn<br>
&gt; -CONFIG_USB_UAS=3Dn<br>
&gt; +CONFIG_ATA_PIO32=3Dn<br>
&gt; +CONFIG_AHCI=3Dn<br>
&gt;=C2=A0 =C2=A0CONFIG_SDCARD=3Dn<br>
&gt;=C2=A0 =C2=A0CONFIG_TCGBIOS=3Dn<br>
&gt; -CONFIG_MPT_SCSI=3Dn<br>
&gt; -CONFIG_ESP_SCSI=3Dn<br>
&gt; -CONFIG_MEGASAS=3Dn<br>
&gt; +CONFIG_VIRTIO_BLK=3Dn<br>
&gt; +CONFIG_VIRTIO_SCSI=3Dn<br>
&gt;=C2=A0 =C2=A0CONFIG_PVSCSI=3Dn<br>
&gt; +CONFIG_ESP_SCSI=3Dn<br>
&gt; +CONFIG_LSI_SCSI=3Dn<br>
&gt; +CONFIG_MEGASAS=3Dn<br>
&gt; +CONFIG_MPT_SCSI=3Dn<br>
<br>
Why did you change the order of MPT, ESP and MEGASAS?<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">Because the previous .=
config was written by hand while this one is generated by &quot;make menu c=
onfig&quot; (other than the comments at the top).</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Apart from that, wrt to the config file changes:<br>
Reviewed-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
<br>
&gt;=C2=A0 =C2=A0CONFIG_NVME=3Dn<br>
&gt;=C2=A0 =C2=A0CONFIG_USE_SMM=3Dn<br>
&gt;=C2=A0 =C2=A0CONFIG_VGAHOOKS=3Dn<br>
&gt;=C2=A0 =C2=A0CONFIG_HOST_BIOS_GEOMETRY=3Dn<br>
&gt; +CONFIG_PS2PORT=3Dn<br>
&gt; +CONFIG_USB=3Dn<br>
&gt; +CONFIG_PMTIMER=3Dn<br>
&gt; +CONFIG_PCIBIOS=3Dn<br>
&gt; +CONFIG_DISABLE_A20=3Dn<br>
&gt; +CONFIG_WRITABLE_UPPERMEMORY=3Dn<br>
&gt; +CONFIG_ACPI=3Dn<br>
&gt;=C2=A0 =C2=A0CONFIG_ACPI_PARSE=3Dn<br>
&gt; +CONFIG_DEBUG_SERIAL=3Dn<br>
&gt; +CONFIG_DEBUG_SERIAL_MMIO=3Dn<br>
<br>
</blockquote></div></div></div>

--0000000000002da9c90605ef1f40--


