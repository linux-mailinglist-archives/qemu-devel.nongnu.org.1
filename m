Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AD4803BC9
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 18:36:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rACr2-0001hz-0G; Mon, 04 Dec 2023 12:35:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rACqv-0001hf-Pg
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 12:35:30 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rACqe-0007BR-Vc
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 12:35:26 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d048d38881so17633645ad.2
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 09:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701711189; x=1702315989;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TMljpsCjPAnNRCwEDjSGgFjYXzA+41QGdnkJ0tbPLFs=;
 b=z5s2Aw+nzGBeGUaQgm+oFJbOdhjwTwapZDC0wAfvW+EroKrKeWfBiW4hfp/xaNeGP5
 w30qduU8SCxLatBeV9aU7NJJ0jpcEsg2hhwZbUtJzLfBg51ARv3E3Zl0VCZUplruvw8v
 mU93m2Plhe5QVUA7RIQQyOd6cyFPMkYZXqXKJYcaWU+sqsP0VeKmj9lu4rolOs0ZfcT+
 UTa3QcPN0dgGEEOr+JxTneotPOV4mvw1Lxm+FMZNJamhNuIpOtfAQn72maqNYgF0LFzK
 Ah8+bUP+Yo7XBDvuWSQ8xwmBdSymyEy/T+TsKC8Hnq0breeZOaX6pW0hJP138l0G1UCr
 mO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701711189; x=1702315989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TMljpsCjPAnNRCwEDjSGgFjYXzA+41QGdnkJ0tbPLFs=;
 b=WqbtXnI1/Z3uGomHL4O7WgaSCIeU3QBZ1HNkd/NgPSjosc94Su/KVm6tifvblSD80P
 IdTRBmwHjKQ7z3AO+P6c4+t9sDrzzuHiQ0UT2vJ5NAo676OAURWtEgeEreCM/OyXskDv
 R+Fos/FqAa8Sy0wu6jGk4B5s91RRKDvOSS/XDgVR7mfP2ET2SH5fQEfPgqtOMvccfirz
 ZpShKMCoul847eDSboTSJvjnS1w6rYwmKbOkUkLudjjsM1KlNzZEfwQbwXsGruAzFfoY
 N76Adc+SvGrnuiX0wrW8MMuLEWht99qeXrIj35oNRPUfIAr/3zRpnEJnmIQjZ4YbCxuf
 nkIg==
X-Gm-Message-State: AOJu0YzCSroPCkuaxy+aBeTbY8lW2pkVHUOQf1ElcfdyxklB2kU4C1P0
 W6ecBa7ksm0XOVRUoWQQ1JTZYC6xRPXy4zvCDevyUg==
X-Google-Smtp-Source: AGHT+IEP+QHMWgmJ0EuPGEFvN16V73dePnkoR52iWKZvNE0sBZqieNd4iA02svLldNwcuDBmCzgItrp5+iDGO/2GdZ0=
X-Received: by 2002:a17:90a:e551:b0:281:5550:ce3d with SMTP id
 ei17-20020a17090ae55100b002815550ce3dmr2037267pjb.31.1701711187596; Mon, 04
 Dec 2023 09:33:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701705003.git.yong.huang@smartx.com>
 <ZW39KzXUbWrJUdQH@redhat.com>
 <CAK9dgmapfxO93ZMSiw+aT6E1XLLrs+sXXprwCxgB8egeznsLBQ@mail.gmail.com>
 <ZW4Dm2TI9d4XBDtT@redhat.com>
In-Reply-To: <ZW4Dm2TI9d4XBDtT@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 5 Dec 2023 01:32:51 +0800
Message-ID: <CAK9dgmZ75OBDCNi-oMm-FKfzmfSo116dqYKi9PJucZa9DbSu8A@mail.gmail.com>
Subject: Re: [RFC 0/8] Support generic Luks encryption
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d8eed8060bb2829c"
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--000000000000d8eed8060bb2829c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 12:51=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Tue, Dec 05, 2023 at 12:41:16AM +0800, Yong Huang wrote:
> > On Tue, Dec 5, 2023 at 12:24=E2=80=AFAM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com>
> > wrote:
> >
> > > On Tue, Dec 05, 2023 at 12:06:17AM +0800, Hyman Huang wrote:
> > > > This functionality was motivated by the following to-do list seen
> > > > in crypto documents:
> > > > https://wiki.qemu.org/Features/Block/Crypto
> > > >
> > > > The last chapter says we should "separate header volume":
> > > >
> > > > The LUKS format has ability to store the header in a separate volum=
e
> > > > from the payload. We should extend the LUKS driver in QEMU to suppo=
rt
> > > > this use case.
> > > >
> > > > As a proof-of-concept, I've created this patchset, which I've named
> > > > the Gluks: generic luks. As their name suggests, they offer
> encryption
> > > > for any format that QEMU theoretically supports.
> > >
> > > I don't see the point in creating a new driver.
> > >
> > > I would expect detached header support to be implemented via an
> > > optional new 'header' field in the existing driver. ie
> > >
> > > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > index ca390c5700..48d1f2a974 100644
> > > --- a/qapi/block-core.json
> > > +++ b/qapi/block-core.json
> > > @@ -3352,11 +3352,15 @@
> > >  #     decryption key (since 2.6). Mandatory except when doing a
> > >  #     metadata-only probe of the image.
> > >  #
> > > +# @header: optional reference to the location of a blockdev
> > > +#     storing a detached LUKS heaer
> > > +#
> > >  # Since: 2.9
> > >  ##
> > >  { 'struct': 'BlockdevOptionsLUKS',
> > >    'base': 'BlockdevOptionsGenericFormat',
> > > -  'data': { '*key-secret': 'str' } }
> > > +  'data': { '*key-secret': 'str',
> > > +            "*header-file': 'BlockdevRef'} }
> > >
> > >  ##
> > >  # @BlockdevOptionsGenericCOWFormat:
> > > @@ -4941,9 +4945,18 @@
> > >  #
> > >  # Driver specific image creation options for LUKS.
> > >  #
> > > -# @file: Node to create the image format on
> > > +# @file: Node to create the image format on. Mandatory
> > > +#     unless a detached header file is specified using
> > > +#     @header.
> > >  #
> > > -# @size: Size of the virtual disk in bytes
> > > +# @size: Size of the virtual disk in bytes.  Mandatory
> > > +#     unless a detached header file is specified using
> > > +#     @header.
> > > +#
> > > +# @header: optional reference to the location of a blockdev
> > > +#     storing a detached LUKS heaer. The @file option is
> > > +#     is optional when this is given, unless it is desired
> > > +#     to perform pre-allocation
> > >  #
> > >  # @preallocation: Preallocation mode for the new image (since: 4.2)
> > >  #     (default: off; allowed values: off, metadata, falloc, full)
> > > @@ -4952,8 +4965,9 @@
> > >  ##
> > >  { 'struct': 'BlockdevCreateOptionsLUKS',
> > >    'base': 'QCryptoBlockCreateOptionsLUKS',
> > > -  'data': { 'file':             'BlockdevRef',
> > > -            'size':             'size',
> > > +  'data': { '*file':            'BlockdevRef',
> > > +            '*size':            'size',
> > > +            '*header':          'BlockdevRef'
> > >              '*preallocation':   'PreallocMode' } }
> > >
> > >  ##
> > >
> > > It ends up giving basicallly the same workflow as you outline,
> > > without needing the new block driver
> > >
> >
> > How about the design and usage, could it be simpler? Any advice? :)
> >
> >
> > As you can see below, the Gluks format block layer driver's design is
> > quite simple.
> >
> >          virtio-blk/vhost-user-blk...(front-end device)
> >               ^
> >               |
> >              Gluks   (format-like disk node)
> >           /         \
> >        file       header (blockdev reference)
> >         /             \
> >      file            file (protocol node)
> >        |               |
> >    disk data       Luks data
>
> What I suggested above ends up with the exact same block driver
> graph, unless I'm missing something.
>

I could overlook something or fail to adequately convey the goal of the
patchset. :(

Indeed, utilizing the same block driver might be effective if our only goal
is to divide the header volume, giving us an additional way to use Luks.

While supporting encryption for any disk format that QEMU is capable of
supporting is another feature of this patchset. This implies that we might
link the Luks header to other blockdev references, which might alter how
the Luks are used and make them incompatible with it. It's not
user-friendly in my opinion, and I'm not aware of a more elegant solution.



> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--=20
Best regards

--000000000000d8eed8060bb2829c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 5, 202=
3 at 12:51=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrang=
e@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Tue, Dec 05, 2023 at 12:41:16AM +0800, Yong Huang wrote:<br>
&gt; On Tue, Dec 5, 2023 at 12:24=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a=
 href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com<=
/a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Tue, Dec 05, 2023 at 12:06:17AM +0800, Hyman Huang wrote:<br>
&gt; &gt; &gt; This functionality was motivated by the following to-do list=
 seen<br>
&gt; &gt; &gt; in crypto documents:<br>
&gt; &gt; &gt; <a href=3D"https://wiki.qemu.org/Features/Block/Crypto" rel=
=3D"noreferrer" target=3D"_blank">https://wiki.qemu.org/Features/Block/Cryp=
to</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The last chapter says we should &quot;separate header volume=
&quot;:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The LUKS format has ability to store the header in a separat=
e volume<br>
&gt; &gt; &gt; from the payload. We should extend the LUKS driver in QEMU t=
o support<br>
&gt; &gt; &gt; this use case.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; As a proof-of-concept, I&#39;ve created this patchset, which=
 I&#39;ve named<br>
&gt; &gt; &gt; the Gluks: generic luks. As their name suggests, they offer =
encryption<br>
&gt; &gt; &gt; for any format that QEMU theoretically supports.<br>
&gt; &gt;<br>
&gt; &gt; I don&#39;t see the point in creating a new driver.<br>
&gt; &gt;<br>
&gt; &gt; I would expect detached header support to be implemented via an<b=
r>
&gt; &gt; optional new &#39;header&#39; field in the existing driver. ie<br=
>
&gt; &gt;<br>
&gt; &gt; diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
&gt; &gt; index ca390c5700..48d1f2a974 100644<br>
&gt; &gt; --- a/qapi/block-core.json<br>
&gt; &gt; +++ b/qapi/block-core.json<br>
&gt; &gt; @@ -3352,11 +3352,15 @@<br>
&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0decryption key (since 2.6). Mandatory =
except when doing a<br>
&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0metadata-only probe of the image.<br>
&gt; &gt;=C2=A0 #<br>
&gt; &gt; +# @header: optional reference to the location of a blockdev<br>
&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0storing a detached LUKS heaer<br>
&gt; &gt; +#<br>
&gt; &gt;=C2=A0 # Since: 2.9<br>
&gt; &gt;=C2=A0 ##<br>
&gt; &gt;=C2=A0 { &#39;struct&#39;: &#39;BlockdevOptionsLUKS&#39;,<br>
&gt; &gt;=C2=A0 =C2=A0 &#39;base&#39;: &#39;BlockdevOptionsGenericFormat&#3=
9;,<br>
&gt; &gt; -=C2=A0 &#39;data&#39;: { &#39;*key-secret&#39;: &#39;str&#39; } =
}<br>
&gt; &gt; +=C2=A0 &#39;data&#39;: { &#39;*key-secret&#39;: &#39;str&#39;,<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;*header-file&#39=
;: &#39;BlockdevRef&#39;} }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 ##<br>
&gt; &gt;=C2=A0 # @BlockdevOptionsGenericCOWFormat:<br>
&gt; &gt; @@ -4941,9 +4945,18 @@<br>
&gt; &gt;=C2=A0 #<br>
&gt; &gt;=C2=A0 # Driver specific image creation options for LUKS.<br>
&gt; &gt;=C2=A0 #<br>
&gt; &gt; -# @file: Node to create the image format on<br>
&gt; &gt; +# @file: Node to create the image format on. Mandatory<br>
&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0unless a detached header file is specified =
using<br>
&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0@header.<br>
&gt; &gt;=C2=A0 #<br>
&gt; &gt; -# @size: Size of the virtual disk in bytes<br>
&gt; &gt; +# @size: Size of the virtual disk in bytes.=C2=A0 Mandatory<br>
&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0unless a detached header file is specified =
using<br>
&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0@header.<br>
&gt; &gt; +#<br>
&gt; &gt; +# @header: optional reference to the location of a blockdev<br>
&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0storing a detached LUKS heaer. The @file op=
tion is<br>
&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0is optional when this is given, unless it i=
s desired<br>
&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0to perform pre-allocation<br>
&gt; &gt;=C2=A0 #<br>
&gt; &gt;=C2=A0 # @preallocation: Preallocation mode for the new image (sin=
ce: 4.2)<br>
&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0(default: off; allowed values: off, me=
tadata, falloc, full)<br>
&gt; &gt; @@ -4952,8 +4965,9 @@<br>
&gt; &gt;=C2=A0 ##<br>
&gt; &gt;=C2=A0 { &#39;struct&#39;: &#39;BlockdevCreateOptionsLUKS&#39;,<br=
>
&gt; &gt;=C2=A0 =C2=A0 &#39;base&#39;: &#39;QCryptoBlockCreateOptionsLUKS&#=
39;,<br>
&gt; &gt; -=C2=A0 &#39;data&#39;: { &#39;file&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&#39;BlockdevRef&#39;,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;size&#39;:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;size&#39;,<br>
&gt; &gt; +=C2=A0 &#39;data&#39;: { &#39;*file&#39;:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;BlockdevRef&#39;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*size&#39;:=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;size&#39;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*header&#39;:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;BlockdevRef&#39;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*preallocati=
on&#39;:=C2=A0 =C2=A0&#39;PreallocMode&#39; } }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 ##<br>
&gt; &gt;<br>
&gt; &gt; It ends up giving basicallly the same workflow as you outline,<br=
>
&gt; &gt; without needing the new block driver<br>
&gt; &gt;<br>
&gt; <br>
&gt; How about the design and usage, could it be simpler? Any advice? :)<br=
>
&gt; <br>
&gt; <br>
&gt; As you can see below, the Gluks format block layer driver&#39;s design=
 is<br>
&gt; quite simple.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio-blk/vhost-user-blk...(front-e=
nd device)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Gluks=C2=A0 =C2=A0(for=
mat-like disk node)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 file=C2=A0 =C2=A0 =C2=A0 =C2=A0header (bloc=
kdev reference)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 file=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file=
 (protocol node)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 disk data=C2=A0 =C2=A0 =C2=A0 =C2=A0Luks data<br>
<br>
What I suggested above ends up with the exact same block driver<br>
graph, unless I&#39;m missing something.<br></blockquote><div><br></div><di=
v class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sa=
ns-serif">I could overlook something or fail to adequately convey the goal =
of the patchset. :(</div><div class=3D"gmail_default" style=3D"font-family:=
&quot;comic sans ms&quot;,sans-serif"><br></div><div class=3D"gmail_default=
" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Indeed, utiliz=
ing the same block driver might be effective if our only goal is to divide =
the header volume, giving us an additional way to use Luks.</div><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f"><br></div><div class=3D"gmail_default" style=3D"font-family:&quot;comic =
sans ms&quot;,sans-serif">While supporting encryption for any disk format t=
hat QEMU is capable of supporting is another feature of this patchset. This=
 implies that we might link the Luks header to other blockdev references, w=
hich might alter how the Luks are used and make them incompatible with it. =
It&#39;s not user-friendly in my opinion, and I&#39;m not aware of a more e=
legant solution.</div><div class=3D"gmail_default" style=3D"font-family:&qu=
ot;comic sans ms&quot;,sans-serif"><br></div><div class=3D"gmail_default" s=
tyle=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wi=
dth:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-=
left:1ex">
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000d8eed8060bb2829c--

