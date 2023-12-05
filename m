Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFD8804456
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 02:54:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAKdE-0002xf-Tt; Mon, 04 Dec 2023 20:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rAKdB-0002x3-6B
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:49 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rAKd7-0005iJ-Hw
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:48 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5c67c1ad5beso1442770a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 17:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701741101; x=1702345901;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ldeDeytKmzWM2dRASgdfD4UBDx/LT+3UIIUVC/oKoZg=;
 b=SMtV5LnkUXVh6NHh1ovu+PorLPB73UdZrCjhH8I3+Oc7mLeYdb3tkXw4a4TvMMRfJL
 EwWy0jQ24yiRJq1Hjiih7j6Adsbz4fMcVUvrdNQPsBeBI0qGmN19YDug90PDA6oQk4ba
 zu21t3S/nh/vpJChtwl/tfiP5CM+stglVVWQQshDKHes/ZoTlCpA8FitlZRu4XqtPnI2
 PO33e1AzNyt8agK8jZf27vqFevq1OhyQeQME5WqJSx8TWl+xjdWlQ1wtiSNRnSeJBeY8
 Qx2VYqBq7WiHJDhPorMSkpiQ+vV1ytCNhTIktMuVNll4gR0oAM0HwajDKHmgy2fufQuK
 ab7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701741101; x=1702345901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ldeDeytKmzWM2dRASgdfD4UBDx/LT+3UIIUVC/oKoZg=;
 b=GeU5fEiE9PD2v2S3ZOkOmaUzuPqwt75w5GNleL56ePfHFSEz+6VnKKSDLq4ncCeEj/
 jyizH7DBxCY7tymUGAv1Lzxpep0GHO2TZ3snB26XW5987KCfa7gBjQZZkTpI11Sc3/tF
 zROBp1FNDoXxtlLA6l6kXC1pwYrwWAEe/Ekyidror2qZdlPTRWZdFHgqJAeLFsReYq/T
 EVFy2Uu0gID8+wLi3qx8Vcpr9XHG2rbsSMS7dZAqJ9SieITAbd8AtjHVklGuDKK1RRnJ
 CLy5S1y4tBbjC9q/JAMjbTgg34JXwTecL8Yl+oMYxWBiP98IASr1K6NWiWjhMUBpGXEH
 Jdzw==
X-Gm-Message-State: AOJu0Ywo2XjUEKHUeBvnfE6p65KYuChv1Zd2JjZ7lea11RHHets31YPx
 Lf5hMg5O66+U/XmNcsyZs2fHrrQAKz9kw3SQP5XJWw==
X-Google-Smtp-Source: AGHT+IFQahpCBEy0aUqfVowE8Nm0GykrdMQ5RZPAgFxbkIo3e0LzOTQ4DwuTqfJsDEOIcnJha94HL61gjw5NmqOB31o=
X-Received: by 2002:a17:90b:4b92:b0:286:8c4d:d237 with SMTP id
 lr18-20020a17090b4b9200b002868c4dd237mr501365pjb.10.1701741100149; Mon, 04
 Dec 2023 17:51:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701705003.git.yong.huang@smartx.com>
 <ZW39KzXUbWrJUdQH@redhat.com>
 <CAK9dgmapfxO93ZMSiw+aT6E1XLLrs+sXXprwCxgB8egeznsLBQ@mail.gmail.com>
 <ZW4Dm2TI9d4XBDtT@redhat.com>
 <CAK9dgmZ75OBDCNi-oMm-FKfzmfSo116dqYKi9PJucZa9DbSu8A@mail.gmail.com>
 <ZW4P20Ib7vJZW77V@redhat.com>
In-Reply-To: <ZW4P20Ib7vJZW77V@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 5 Dec 2023 09:51:21 +0800
Message-ID: <CAK9dgmbhJ+UVn3oTkjsshMOPAqdmXnywNk1jZsQ3BD+BN131fQ@mail.gmail.com>
Subject: Re: [RFC 0/8] Support generic Luks encryption
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c64332060bb9796e"
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52f.google.com
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

--000000000000c64332060bb9796e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 1:44=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Tue, Dec 05, 2023 at 01:32:51AM +0800, Yong Huang wrote:
> > On Tue, Dec 5, 2023 at 12:51=E2=80=AFAM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com>
> > wrote:
> >
> > > On Tue, Dec 05, 2023 at 12:41:16AM +0800, Yong Huang wrote:
> > > > On Tue, Dec 5, 2023 at 12:24=E2=80=AFAM Daniel P. Berrang=C3=A9 <
> berrange@redhat.com>
> > > > wrote:
> > > >
> > > > > On Tue, Dec 05, 2023 at 12:06:17AM +0800, Hyman Huang wrote:
> > > > > > This functionality was motivated by the following to-do list se=
en
> > > > > > in crypto documents:
> > > > > > https://wiki.qemu.org/Features/Block/Crypto
> > > > > >
> > > > > > The last chapter says we should "separate header volume":
> > > > > >
> > > > > > The LUKS format has ability to store the header in a separate
> volume
> > > > > > from the payload. We should extend the LUKS driver in QEMU to
> support
> > > > > > this use case.
> > > > > >
> > > > > > As a proof-of-concept, I've created this patchset, which I've
> named
> > > > > > the Gluks: generic luks. As their name suggests, they offer
> > > encryption
> > > > > > for any format that QEMU theoretically supports.
> > > > >
> > > > > I don't see the point in creating a new driver.
> > > > >
> > > > > I would expect detached header support to be implemented via an
> > > > > optional new 'header' field in the existing driver. ie
> > > > >
> > > > > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > > > index ca390c5700..48d1f2a974 100644
> > > > > --- a/qapi/block-core.json
> > > > > +++ b/qapi/block-core.json
> > > > > @@ -3352,11 +3352,15 @@
> > > > >  #     decryption key (since 2.6). Mandatory except when doing a
> > > > >  #     metadata-only probe of the image.
> > > > >  #
> > > > > +# @header: optional reference to the location of a blockdev
> > > > > +#     storing a detached LUKS heaer
> > > > > +#
> > > > >  # Since: 2.9
> > > > >  ##
> > > > >  { 'struct': 'BlockdevOptionsLUKS',
> > > > >    'base': 'BlockdevOptionsGenericFormat',
> > > > > -  'data': { '*key-secret': 'str' } }
> > > > > +  'data': { '*key-secret': 'str',
> > > > > +            "*header-file': 'BlockdevRef'} }
> > > > >
> > > > >  ##
> > > > >  # @BlockdevOptionsGenericCOWFormat:
> > > > > @@ -4941,9 +4945,18 @@
> > > > >  #
> > > > >  # Driver specific image creation options for LUKS.
> > > > >  #
> > > > > -# @file: Node to create the image format on
> > > > > +# @file: Node to create the image format on. Mandatory
> > > > > +#     unless a detached header file is specified using
> > > > > +#     @header.
> > > > >  #
> > > > > -# @size: Size of the virtual disk in bytes
> > > > > +# @size: Size of the virtual disk in bytes.  Mandatory
> > > > > +#     unless a detached header file is specified using
> > > > > +#     @header.
> > > > > +#
> > > > > +# @header: optional reference to the location of a blockdev
> > > > > +#     storing a detached LUKS heaer. The @file option is
> > > > > +#     is optional when this is given, unless it is desired
> > > > > +#     to perform pre-allocation
> > > > >  #
> > > > >  # @preallocation: Preallocation mode for the new image (since:
> 4.2)
> > > > >  #     (default: off; allowed values: off, metadata, falloc, full=
)
> > > > > @@ -4952,8 +4965,9 @@
> > > > >  ##
> > > > >  { 'struct': 'BlockdevCreateOptionsLUKS',
> > > > >    'base': 'QCryptoBlockCreateOptionsLUKS',
> > > > > -  'data': { 'file':             'BlockdevRef',
> > > > > -            'size':             'size',
> > > > > +  'data': { '*file':            'BlockdevRef',
> > > > > +            '*size':            'size',
> > > > > +            '*header':          'BlockdevRef'
> > > > >              '*preallocation':   'PreallocMode' } }
> > > > >
> > > > >  ##
> > > > >
> > > > > It ends up giving basicallly the same workflow as you outline,
> > > > > without needing the new block driver
> > > > >
> > > >
> > > > How about the design and usage, could it be simpler? Any advice? :)
> > > >
> > > >
> > > > As you can see below, the Gluks format block layer driver's design =
is
> > > > quite simple.
> > > >
> > > >          virtio-blk/vhost-user-blk...(front-end device)
> > > >               ^
> > > >               |
> > > >              Gluks   (format-like disk node)
> > > >           /         \
> > > >        file       header (blockdev reference)
> > > >         /             \
> > > >      file            file (protocol node)
> > > >        |               |
> > > >    disk data       Luks data
> > >
> > > What I suggested above ends up with the exact same block driver
> > > graph, unless I'm missing something.
> > >
> >
> > I could overlook something or fail to adequately convey the goal of the
> > patchset. :(
> >
> > Indeed, utilizing the same block driver might be effective if our only
> goal
> > is to divide the header volume, giving us an additional way to use Luks=
.
> >
> > While supporting encryption for any disk format that QEMU is capable of
> > supporting is another feature of this patchset. This implies that we
> might
> > link the Luks header to other blockdev references, which might alter ho=
w
> > the Luks are used and make them incompatible with it. It's not
> > user-friendly in my opinion, and I'm not aware of a more elegant
> solution.
>
> That existing LUKS driver can already be used in combination with
> any QEMU block driver, and in the case of disk formats, can be used
> either above or below the format, depending on whether you want to
> encrypt just the image payload, or the payload and metadata ie.
>
> We can do
>
>   luks -> qcow2 -> file    (qcow2 header and qcow2 payload protected)
>
OK, I prefer this solution so that we can support any format implemented
by the QEMU block driver.

>
> or
>
>   qcow2 -> luks -> file    (only qcow2 payload protected)
>
> And in the qcow2 case, we also have support for LUKS integrated natively
> into the qcow2 format, which is similar to the 2nd case, with the
> benefit that we're explicit that the image requires encryption.
>
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
> Let me make a conclusion about our discussion, if i
misunderstand something,
point that out please:

1. To achieve the generic encryption,  extending the pre-existing LUKS QEMU
   block driver is suggested in practice.

2. Introducing a optional field called "header-file" that store the LUKS
header
   independently, and once "header-file" was specified, we should use it to
   encrypt/decrypt the blockdev node referenced by the "file" field.

The blockdev tree is like:
         virtio-blk/vhost-user-blk...(frontend device)
                       ^
                        |
                    LUKS
             /                     \
         file               header-file
         /                             \
data protocol node    LUKS header protocol node

3. The usage of the generic LUKS is like:

Take the qcow2 as an example:

1. add a protocol blockdev node of data disk
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
  "arguments":{"node-name": "libvirt-1-storage", "driver": "file",
  "filename": "/path/to/test_disk.qcow2"}}'

2. add a protocol blockdev node of Luks header as above.
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
  "arguments":{"node-name": "libvirt-2-storage", "driver": "file",
  "filename": "/path/to/cipher.gluks" }}'

3. add the secret for decrypting the cipher stored in Gluks header as
   above
$ virsh qemu-monitor-command vm '{"execute":"object-add",
  "arguments":{"qom-type": "secret", "id":
  "libvirt-2-storage-secret0", "data": "abc123"}}'

4. add the qcow2-drived blockdev format node:
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
  "arguments":{"node-name": "libvirt-1-format", "driver": "qcow2",
  "file": "libvirt-1-storage"}}'

5. add the luks-drived blockdev to connect the qcow2 disk with Luks
   header by specifying the field "header-file"
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
  "arguments":{"node-name": "libvirt-2-format", "driver": "luks",
  "file": "libvirt-1-format", "header-file": "libvirt-2-storage",
  "key-secret": "libvirt-2-format-secret0"}}'

6. add the device finally
$ virsh qemu-monitor-command vm '{"execute":"device_add",
  "arguments": {"num-queues": "1", "driver": "virtio-blk-pci", "scsi":
  "off", "drive": "libvirt-2-format", "id": "virtio-disk2"}}'

Anyway, thanks for the comments.

Yong.

--=20
Best regards

--000000000000c64332060bb9796e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 5, 202=
3 at 1:44=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange=
@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Tue, Dec 05, 2023 at 01:32:51AM +0800, Yong Huang wrote:<br>
&gt; On Tue, Dec 5, 2023 at 12:51=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a=
 href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com<=
/a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Tue, Dec 05, 2023 at 12:41:16AM +0800, Yong Huang wrote:<br>
&gt; &gt; &gt; On Tue, Dec 5, 2023 at 12:24=E2=80=AFAM Daniel P. Berrang=C3=
=A9 &lt;<a href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@r=
edhat.com</a>&gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Tue, Dec 05, 2023 at 12:06:17AM +0800, Hyman Huang w=
rote:<br>
&gt; &gt; &gt; &gt; &gt; This functionality was motivated by the following =
to-do list seen<br>
&gt; &gt; &gt; &gt; &gt; in crypto documents:<br>
&gt; &gt; &gt; &gt; &gt; <a href=3D"https://wiki.qemu.org/Features/Block/Cr=
ypto" rel=3D"noreferrer" target=3D"_blank">https://wiki.qemu.org/Features/B=
lock/Crypto</a><br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; The last chapter says we should &quot;separate hea=
der volume&quot;:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; The LUKS format has ability to store the header in=
 a separate volume<br>
&gt; &gt; &gt; &gt; &gt; from the payload. We should extend the LUKS driver=
 in QEMU to support<br>
&gt; &gt; &gt; &gt; &gt; this use case.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; As a proof-of-concept, I&#39;ve created this patch=
set, which I&#39;ve named<br>
&gt; &gt; &gt; &gt; &gt; the Gluks: generic luks. As their name suggests, t=
hey offer<br>
&gt; &gt; encryption<br>
&gt; &gt; &gt; &gt; &gt; for any format that QEMU theoretically supports.<b=
r>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; I don&#39;t see the point in creating a new driver.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; I would expect detached header support to be implemente=
d via an<br>
&gt; &gt; &gt; &gt; optional new &#39;header&#39; field in the existing dri=
ver. ie<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/qapi/block-core.json b/qapi/block-core.jso=
n<br>
&gt; &gt; &gt; &gt; index ca390c5700..48d1f2a974 100644<br>
&gt; &gt; &gt; &gt; --- a/qapi/block-core.json<br>
&gt; &gt; &gt; &gt; +++ b/qapi/block-core.json<br>
&gt; &gt; &gt; &gt; @@ -3352,11 +3352,15 @@<br>
&gt; &gt; &gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0decryption key (since 2.6). =
Mandatory except when doing a<br>
&gt; &gt; &gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0metadata-only probe of the i=
mage.<br>
&gt; &gt; &gt; &gt;=C2=A0 #<br>
&gt; &gt; &gt; &gt; +# @header: optional reference to the location of a blo=
ckdev<br>
&gt; &gt; &gt; &gt; +#=C2=A0 =C2=A0 =C2=A0storing a detached LUKS heaer<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt;=C2=A0 # Since: 2.9<br>
&gt; &gt; &gt; &gt;=C2=A0 ##<br>
&gt; &gt; &gt; &gt;=C2=A0 { &#39;struct&#39;: &#39;BlockdevOptionsLUKS&#39;=
,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 &#39;base&#39;: &#39;BlockdevOptionsGeneri=
cFormat&#39;,<br>
&gt; &gt; &gt; &gt; -=C2=A0 &#39;data&#39;: { &#39;*key-secret&#39;: &#39;s=
tr&#39; } }<br>
&gt; &gt; &gt; &gt; +=C2=A0 &#39;data&#39;: { &#39;*key-secret&#39;: &#39;s=
tr&#39;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;*heade=
r-file&#39;: &#39;BlockdevRef&#39;} }<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 ##<br>
&gt; &gt; &gt; &gt;=C2=A0 # @BlockdevOptionsGenericCOWFormat:<br>
&gt; &gt; &gt; &gt; @@ -4941,9 +4945,18 @@<br>
&gt; &gt; &gt; &gt;=C2=A0 #<br>
&gt; &gt; &gt; &gt;=C2=A0 # Driver specific image creation options for LUKS=
.<br>
&gt; &gt; &gt; &gt;=C2=A0 #<br>
&gt; &gt; &gt; &gt; -# @file: Node to create the image format on<br>
&gt; &gt; &gt; &gt; +# @file: Node to create the image format on. Mandatory=
<br>
&gt; &gt; &gt; &gt; +#=C2=A0 =C2=A0 =C2=A0unless a detached header file is =
specified using<br>
&gt; &gt; &gt; &gt; +#=C2=A0 =C2=A0 =C2=A0@header.<br>
&gt; &gt; &gt; &gt;=C2=A0 #<br>
&gt; &gt; &gt; &gt; -# @size: Size of the virtual disk in bytes<br>
&gt; &gt; &gt; &gt; +# @size: Size of the virtual disk in bytes.=C2=A0 Mand=
atory<br>
&gt; &gt; &gt; &gt; +#=C2=A0 =C2=A0 =C2=A0unless a detached header file is =
specified using<br>
&gt; &gt; &gt; &gt; +#=C2=A0 =C2=A0 =C2=A0@header.<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @header: optional reference to the location of a blo=
ckdev<br>
&gt; &gt; &gt; &gt; +#=C2=A0 =C2=A0 =C2=A0storing a detached LUKS heaer. Th=
e @file option is<br>
&gt; &gt; &gt; &gt; +#=C2=A0 =C2=A0 =C2=A0is optional when this is given, u=
nless it is desired<br>
&gt; &gt; &gt; &gt; +#=C2=A0 =C2=A0 =C2=A0to perform pre-allocation<br>
&gt; &gt; &gt; &gt;=C2=A0 #<br>
&gt; &gt; &gt; &gt;=C2=A0 # @preallocation: Preallocation mode for the new =
image (since: 4.2)<br>
&gt; &gt; &gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0(default: off; allowed value=
s: off, metadata, falloc, full)<br>
&gt; &gt; &gt; &gt; @@ -4952,8 +4965,9 @@<br>
&gt; &gt; &gt; &gt;=C2=A0 ##<br>
&gt; &gt; &gt; &gt;=C2=A0 { &#39;struct&#39;: &#39;BlockdevCreateOptionsLUK=
S&#39;,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 &#39;base&#39;: &#39;QCryptoBlockCreateOpt=
ionsLUKS&#39;,<br>
&gt; &gt; &gt; &gt; -=C2=A0 &#39;data&#39;: { &#39;file&#39;:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;BlockdevRef&#39;,<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;size&#3=
9;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;size&#39;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 &#39;data&#39;: { &#39;*file&#39;:=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;BlockdevRef&#39;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*size&#=
39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;size&#39;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*header=
&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;BlockdevRef&#39;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*p=
reallocation&#39;:=C2=A0 =C2=A0&#39;PreallocMode&#39; } }<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 ##<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; It ends up giving basicallly the same workflow as you o=
utline,<br>
&gt; &gt; &gt; &gt; without needing the new block driver<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; How about the design and usage, could it be simpler? Any adv=
ice? :)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; As you can see below, the Gluks format block layer driver&#3=
9;s design is<br>
&gt; &gt; &gt; quite simple.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio-blk/vhost-user-blk.=
..(front-end device)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Gluks=C2=A0 =
=C2=A0(format-like disk node)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 file=C2=A0 =C2=A0 =C2=A0 =C2=A0he=
ader (blockdev reference)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 file=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 file (protocol node)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 disk data=C2=A0 =C2=A0 =C2=A0 =C2=A0Luks data<b=
r>
&gt; &gt;<br>
&gt; &gt; What I suggested above ends up with the exact same block driver<b=
r>
&gt; &gt; graph, unless I&#39;m missing something.<br>
&gt; &gt;<br>
&gt; <br>
&gt; I could overlook something or fail to adequately convey the goal of th=
e<br>
&gt; patchset. :(<br>
&gt; <br>
&gt; Indeed, utilizing the same block driver might be effective if our only=
 goal<br>
&gt; is to divide the header volume, giving us an additional way to use Luk=
s.<br>
&gt; <br>
&gt; While supporting encryption for any disk format that QEMU is capable o=
f<br>
&gt; supporting is another feature of this patchset. This implies that we m=
ight<br>
&gt; link the Luks header to other blockdev references, which might alter h=
ow<br>
&gt; the Luks are used and make them incompatible with it. It&#39;s not<br>
&gt; user-friendly in my opinion, and I&#39;m not aware of a more elegant s=
olution.<br>
<br>
That existing LUKS driver can already be used in combination with<br>
any QEMU block driver, and in the case of disk formats, can be used<br>
either above or below the format, depending on whether you want to<br>
encrypt just the image payload, or the payload and metadata ie.<br>
<br>
We can do<br>
<br>
=C2=A0 luks -&gt; qcow2 -&gt; file=C2=A0 =C2=A0 (qcow2 header and qcow2 pay=
load protected)<br></blockquote><div><div class=3D"gmail_default" style=3D"=
font-family:&quot;comic sans ms&quot;,sans-serif"></div><div class=3D"gmail=
_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">OK, I =
prefer this solution so that we can support any format implemented</div><di=
v class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sa=
ns-serif">by the QEMU block driver.</div></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-s=
tyle:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
or<br>
<br>
=C2=A0 qcow2 -&gt; luks -&gt; file=C2=A0 =C2=A0 (only qcow2 payload protect=
ed)<br>
<br>
And in the qcow2 case, we also have support for LUKS integrated natively<br=
>
into the qcow2 format, which is similar to the 2nd case, with the<br>
benefit that we&#39;re explicit that the image requires encryption.<br>
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
</blockquote></div><div><div class=3D"gmail_default" style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif">Let me make a conclusion about our dis=
cussion, if i misunderstand=C2=A0something,</div><div class=3D"gmail_defaul=
t" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">point that ou=
t please:</div><br></div><div class=3D"gmail_default" style=3D"font-family:=
&quot;comic sans ms&quot;,sans-serif">1. To achieve the generic encryption,=
 =C2=A0extending the pre-existing LUKS QEMU</div><div class=3D"gmail_defaul=
t" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">=C2=A0 =C2=A0=
block driver is suggested in practice.</div><div class=3D"gmail_default" st=
yle=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><div cla=
ss=3D"gmail_default"><span style=3D"font-family:&quot;comic sans ms&quot;,s=
ans-serif">2. Introducing a optional field called &quot;header-file&quot; t=
hat store the LUKS header</span></div><div class=3D"gmail_default"><span st=
yle=3D"font-family:&quot;comic sans ms&quot;,sans-serif">=C2=A0 =C2=A0indep=
endently, and once=C2=A0</span><span style=3D"font-family:&quot;comic sans =
ms&quot;,sans-serif">&quot;header-file&quot; was specified, we should use i=
t to</span></div><div class=3D"gmail_default"><span style=3D"font-family:&q=
uot;comic sans ms&quot;,sans-serif">=C2=A0 =C2=A0encrypt/decrypt the blockd=
ev node referenced by the &quot;file&quot; field.=C2=A0</span></div><div cl=
ass=3D"gmail_default"><br></div><div class=3D"gmail_default"><font face=3D"=
comic sans ms, sans-serif">The blockdev tree is like:</font></div><div clas=
s=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0virtio-blk/vhost-user-blk...(frontend device)</font></d=
iv><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^</font></div><div class=3D"gmail_default">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<font face=3D"comic sans ms, sans-serif">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|</font></div><div class=3D"gmail_default=
"><font face=3D"comic sans ms, sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LUKS</font></div><div class=3D"gmail=
_default"><font face=3D"comic sans ms, sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \</font></div><div class=3D"gmail_default"><font face=
=3D"comic sans ms, sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 header-file</font></div><div =
class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</font></div><div class=3D"gma=
il_default"><font face=3D"comic sans ms, sans-serif">data protocol node =C2=
=A0 =C2=A0LUKS header protocol node=C2=A0</font></div><div class=3D"gmail_d=
efault"><font face=3D"comic sans ms, sans-serif"><br></font></div><div clas=
s=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">3. The usage o=
f the generic LUKS is like:</font></div><div class=3D"gmail_default"><font =
face=3D"comic sans ms, sans-serif"><br></font></div><div class=3D"gmail_def=
ault"><font face=3D"comic sans ms, sans-serif">Take the qcow2 as an example=
:</font></div><div class=3D"gmail_default"><font face=3D"comic sans ms, san=
s-serif"><br></font></div><div class=3D"gmail_default"><font face=3D"comic =
sans ms, sans-serif">1. add a protocol blockdev node of data disk<br>$ virs=
h qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;blockdev-add&quot=
;,<br>=C2=A0 &quot;arguments&quot;:{&quot;node-name&quot;: &quot;libvirt-1-=
storage&quot;, &quot;driver&quot;: &quot;file&quot;,<br>=C2=A0 &quot;filena=
me&quot;: &quot;/path/to/test_disk.qcow2&quot;}}&#39;<br><br>2. add a proto=
col blockdev node of Luks header as above.<br></font><span style=3D"font-fa=
mily:&quot;comic sans ms&quot;,sans-serif">$ virsh qemu-monitor-command vm =
&#39;{&quot;execute&quot;:&quot;blockdev-add&quot;,</span><br style=3D"font=
-family:&quot;comic sans ms&quot;,sans-serif"><span style=3D"font-family:&q=
uot;comic sans ms&quot;,sans-serif">=C2=A0 &quot;arguments&quot;:{&quot;nod=
e-name&quot;: &quot;libvirt-2-storage&quot;, &quot;driver&quot;: &quot;file=
&quot;,</span><br style=3D"font-family:&quot;comic sans ms&quot;,sans-serif=
"><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">=C2=A0 &=
quot;filename&quot;: &quot;/path/to/cipher.gluks&quot; }}&#39;</span><br st=
yle=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><font face=3D"comi=
c sans ms, sans-serif"><br>3. add the secret for decrypting the cipher stor=
ed in Gluks header as<br>=C2=A0 =C2=A0above=C2=A0<br></font><span style=3D"=
font-family:&quot;comic sans ms&quot;,sans-serif">$ virsh qemu-monitor-comm=
and vm &#39;{&quot;execute&quot;:&quot;object-add&quot;,</span><br style=3D=
"font-family:&quot;comic sans ms&quot;,sans-serif"><span style=3D"font-fami=
ly:&quot;comic sans ms&quot;,sans-serif">=C2=A0 &quot;arguments&quot;:{&quo=
t;qom-type&quot;: &quot;secret&quot;, &quot;id&quot;:</span><br style=3D"fo=
nt-family:&quot;comic sans ms&quot;,sans-serif"><span style=3D"font-family:=
&quot;comic sans ms&quot;,sans-serif">=C2=A0 &quot;libvirt-2-storage-secret=
0&quot;, &quot;data&quot;: &quot;abc123&quot;}}&#39;</span><font face=3D"co=
mic sans ms, sans-serif"><br><br>4. add the qcow2-drived blockdev format no=
de:<br>$ virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;bloc=
kdev-add&quot;,<br>=C2=A0 &quot;arguments&quot;:{&quot;node-name&quot;: &qu=
ot;libvirt-1-format&quot;, &quot;driver&quot;: &quot;qcow2&quot;,<br>=C2=A0=
 &quot;file&quot;: &quot;libvirt-1-storage&quot;}}&#39;<br><br>5. add the l=
uks-drived blockdev to connect the qcow2 disk with Luks<br>=C2=A0 =C2=A0hea=
der<span class=3D"gmail-Apple-converted-space">=C2=A0by specifying=C2=A0the=
 field &quot;header-file&quot;</span><br>$ virsh qemu-monitor-command vm &#=
39;{&quot;execute&quot;:&quot;blockdev-add&quot;,<br>=C2=A0 &quot;arguments=
&quot;:{&quot;node-name&quot;: &quot;libvirt-2-format&quot;, &quot;driver&q=
uot;: &quot;luks&quot;,<br>=C2=A0 &quot;file&quot;: &quot;libvirt-1-format&=
quot;, &quot;header-file&quot;: &quot;libvirt-2-storage&quot;,<br>=C2=A0 &q=
uot;key-secret&quot;: &quot;libvirt-2-format-secret0&quot;}}&#39;<br><br>6.=
 add the device finally<br>$ virsh qemu-monitor-command vm &#39;{&quot;exec=
ute&quot;:&quot;device_add&quot;,<br>=C2=A0 &quot;arguments&quot;: {&quot;n=
um-queues&quot;: &quot;1&quot;, &quot;driver&quot;: &quot;virtio-blk-pci&qu=
ot;, &quot;scsi&quot;:<br>=C2=A0 &quot;off&quot;, &quot;drive&quot;: &quot;=
libvirt-2-format&quot;, &quot;id&quot;: &quot;virtio-disk2&quot;}}&#39;<br>=
</font></div><div class=3D"gmail_default"><br></div><div class=3D"gmail_def=
ault"><font face=3D"comic sans ms, sans-serif">Anyway, thanks for the comme=
nts.</font></div><div class=3D"gmail_default"><font face=3D"comic sans ms, =
sans-serif"><br></font></div><div class=3D"gmail_default"><font face=3D"com=
ic sans ms, sans-serif">Yong.</font></div><div class=3D"gmail_default"><br>=
</div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic sans ms, sa=
ns-serif">Best regards</font></div></div></div>

--000000000000c64332060bb9796e--

