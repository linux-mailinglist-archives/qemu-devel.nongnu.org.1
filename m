Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DE48263FD
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 12:59:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMRoP-0003bQ-NX; Sun, 07 Jan 2024 06:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rMRoM-0003bD-M5
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 06:59:26 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rMRoD-0005wJ-V5
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 06:59:26 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6dc02ab3cc9so837140a34.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 03:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1704628634; x=1705233434;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=45zAUh8EIJaAHbzoBDFIvNz1v0Tox0j9ENGUvEHwTXE=;
 b=BHHV0poNLC0+XGexBpu8mME0vQm9uUyMynm4U0iQIICcLlPEq5ydCqk/gJn/xoXO1c
 uMeHCEJurH3uzfNj0x7JD5R8APEcud+yurJm04fcqjCs/cTjmvD8fiyPWFD4/s3XcNo7
 1DBkgSFLSixULtE84HtD3HoVI9/uQzWQOhtahYRDDTHpv2/Y/pGl/YN17vIDGwaByPqh
 Dt/MJIZNQehJIPZ7Q6H9Ck3V/fp0NEGxpL/MKNSrVoq7VVh0UJm7PrBtwZvmsBD2zZGJ
 wzsmGK02lDlnF/xMwiOjCYCAPQs5OUwE0fiYpw4yVDjSVzMtiWlbCG0mOAPfal88A+B0
 kRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704628634; x=1705233434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=45zAUh8EIJaAHbzoBDFIvNz1v0Tox0j9ENGUvEHwTXE=;
 b=EWcut5Lg4kQpEopQ1MGZfi0L5AT1/4pW/Job8cd4SDDNSgOxPNJB/7VXBhTedBhh1p
 D9O2BIMgJUPz3L9R8ye2FgsrSHoMheFXHFn2+W+4ukvanjxIrOZYpyMUyZs4XegNu54K
 lKHbuccOam2QRndHUPpCn2aMlRdnpKHjSRpXVS25LKlbZHDSM68N0KiMPyeoOZigZ9Ad
 gd2xue2Ze4FpXFL/BS4PSPujKHsCOOw3FJpThj+JT1Tiac+xKUuK1Tx6nRXXmH0ezSsF
 Q99xGF2JSTT4NowkeE7dmdIOpWnvdS+cuZs8VqWOtLLEZgm9O3wSbXQBsK+X0MuIN19d
 tFUQ==
X-Gm-Message-State: AOJu0YxFPhNWPI3fQoNPvC068wn+PWZb1EHKyiy1Gj6Kougju/4UiWdX
 V4kZd/FcxeMoWnkTBIQE9RnPY2JZhZ9n+JzIi6nPJ3fu/+6FVg==
X-Google-Smtp-Source: AGHT+IGDeRF8++W78qNdtZ5Etr2jrDx/0uDExdSOFlBdD3wXvM9xKy7q6oJJywaZP8b4fVg2aobCfXBpyTXjA5fxC1s=
X-Received: by 2002:a05:6870:36d4:b0:203:fca4:43ab with SMTP id
 u20-20020a05687036d400b00203fca443abmr3518177oak.7.1704628632386; Sun, 07 Jan
 2024 03:57:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1703482349.git.yong.huang@smartx.com>
 <c55f6e98595c654d17c16a569422bec5c03ddaa0.1703482349.git.yong.huang@smartx.com>
 <ZZbDJSgyfQJ9NF8f@redhat.com>
In-Reply-To: <ZZbDJSgyfQJ9NF8f@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Sun, 7 Jan 2024 19:56:56 +0800
Message-ID: <CAK9dgmYXiSBQ7Moam+wP63FgdScuT5uKVdXnxOJHU3maoM-=Og@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 02/10] crypto: Support generic LUKS encryption
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001b9137060e59c8d1"
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--0000000000001b9137060e59c8d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 10:40=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Mon, Dec 25, 2023 at 01:45:04PM +0800, Hyman Huang wrote:
> > By enhancing the LUKS driver, it is possible to enable
> > the detachable LUKS header and, as a result, achieve
> > general encryption for any disk format that QEMU has
> > supported.
> >
> > Take the qcow2 as an example, the usage of the generic
> > LUKS encryption as follows:
> >
> > 1. add a protocol blockdev node of data disk
> > $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > > "arguments":{"node-name":"libvirt-1-storage", "driver":"file",
> > > "filename":"/path/to/test_disk.qcow2"}}'
> >
> > 2. add a protocol blockdev node of LUKS header as above.
> > $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > > "arguments":{"node-name":"libvirt-2-storage", "driver":"file",
> > > "filename": "/path/to/cipher.gluks" }}'
> >
> > 3. add the secret for decrypting the cipher stored in LUKS
> >    header above
> > $ virsh qemu-monitor-command vm '{"execute":"object-add",
> > > "arguments":{"qom-type":"secret", "id":
> > > "libvirt-2-storage-secret0", "data":"abc123"}}'
> >
> > 4. add the qcow2-drived blockdev format node
> > $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > > "arguments":{"node-name":"libvirt-1-format", "driver":"qcow2",
> > > "file":"libvirt-1-storage"}}'
> >
> > 5. add the luks-drived blockdev to link the qcow2 disk with
> >    LUKS header by specifying the field "header"
> > $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > > "arguments":{"node-name":"libvirt-2-format", "driver":"luks",
> > > "file":"libvirt-1-format", "header":"libvirt-2-storage",
> > > "key-secret":"libvirt-2-format-secret0"}}'
> >
> > 6. add the virtio-blk device finally
> > $ virsh qemu-monitor-command vm '{"execute":"device_add",
> > > "arguments": {"num-queues":"1", "driver":"virtio-blk-pci",
> > > "drive": "libvirt-2-format", "id":"virtio-disk2"}}'
> >
> > The generic LUKS encryption method of starting a virtual
> > machine (VM) is somewhat similar to hot-plug in that both
> > maintaining the same json command while the starting VM
> > changes the "blockdev-add/device_add" parameters to
> > "blockdev/device".
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > Message-Id: <
> 910801f303da1601051479d3b7e5c2c6b4e01eb7.1701879996.git.yong.huang@smartx=
.com
> >
> > ---
> >  block/crypto.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/crypto.c b/block/crypto.c
> > index f82b13d32b..6063879bac 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -64,12 +64,14 @@ static int block_crypto_read_func(QCryptoBlock
> *block,
> >                                    Error **errp)
> >  {
> >      BlockDriverState *bs =3D opaque;
> > +    BlockCrypto *crypto =3D bs->opaque;
> >      ssize_t ret;
> >
> >      GLOBAL_STATE_CODE();
> >      GRAPH_RDLOCK_GUARD_MAINLOOP();
> >
> > -    ret =3D bdrv_pread(bs->file, offset, buflen, buf, 0);
> > +    ret =3D bdrv_pread(crypto->header ? crypto->header : bs->file,
> > +                     offset, buflen, buf, 0);
> >      if (ret < 0) {
> >          error_setg_errno(errp, -ret, "Could not read encryption
> header");
> >          return ret;
> > @@ -269,6 +271,7 @@ static int
> block_crypto_open_generic(QCryptoBlockFormat format,
> >      QCryptoBlockOpenOptions *open_opts =3D NULL;
> >      unsigned int cflags =3D 0;
> >      QDict *cryptoopts =3D NULL;
> > +    const char *hdr_bdref =3D qdict_get_try_str(options, "header");
>
> This is an invalid check to make, because it is assuming the user is
> referencing a separate blockdev node name and doesn't work for an
> inline definition. eg
>
>   qemu-img info
> 'json:{"driver":"luks","file":{"filename":"test-payload.img"},"header":{"=
filename":"test-header.img"}}'
>
>
> >
> >      GLOBAL_STATE_CODE();
> >
> > @@ -277,6 +280,15 @@ static int
> block_crypto_open_generic(QCryptoBlockFormat format,
> >          return ret;
> >      }
> >
> > +    if (hdr_bdref) {
>
> Get rid of this 'if' clause and unconditionally call the next line:
>
> > +        crypto->header =3D bdrv_open_child(NULL, options, "header", bs=
,
> > +                                         &child_of_bds,
> BDRV_CHILD_METADATA,
> > +                                         false, errp);
>
> but pass 'true' instead of 'false' here to allow the child to be absent,
> and thus let it return NULL.
>
> > +        if (!crypto->header) {
>
> You'll need to then check  '*errp !=3D NULL' instead
>
> You'll also need "ERRP_GUARD" at the start of the method
>
> > +            return -EINVAL;
> > +        }
> > +    }
> > +
> >      GRAPH_RDLOCK_GUARD_MAINLOOP();
> >
> >      bs->supported_write_flags =3D BDRV_REQ_FUA &
>
> This patch should be combined with the previous patch that adds the new
> QAPI schema element as splitting them doesn't add value.
>
>
> Testing this patch with the changes I suggest above, however, still does
> not work:
>
>   $ dd if=3D/dev/zero of=3Dtest-header.img bs=3D1M count=3D32
>   $ dd if=3D/dev/zero of=3Dtest-payload.img bs=3D1M count=3D1000
>   $ cryptsetup luksFormat  --header test-header.img test-payload.img
> --force-password --type luks1
>   $ qemu-img info
> 'json:{"driver":"luks","file":{"filename":"test-payload.img"},"header":{"=
filename":"test-header.img"}}'
>   qemu-img: Could not open
> 'json:{"driver":"luks","file":{"filename":"test-payload.img"},"header":{"=
filename":"test-header.img"}}':
> LUKS payload is overlapping with the header


>
> You need to pass some info into qcrypto_block_open to tell it that the
> header is detached. Add a new enum entry to QCryptoBlockOpenFlags
> perhaps.  Then skip the LUKS payload overlap check.
>
> Ok, I'll try this way and do a test using cryptsetup tools in the next
version.
Thanks for testing this series.


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

--0000000000001b9137060e59c8d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 4, 202=
4 at 10:40=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrang=
e@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Mon, Dec 25, 2023 at 01:45:04PM +0800, Hyman Huang wrote:<br>
&gt; By enhancing the LUKS driver, it is possible to enable<br>
&gt; the detachable LUKS header and, as a result, achieve<br>
&gt; general encryption for any disk format that QEMU has<br>
&gt; supported.<br>
&gt; <br>
&gt; Take the qcow2 as an example, the usage of the generic<br>
&gt; LUKS encryption as follows:<br>
&gt; <br>
&gt; 1. add a protocol blockdev node of data disk<br>
&gt; $ virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;blockd=
ev-add&quot;,<br>
&gt; &gt; &quot;arguments&quot;:{&quot;node-name&quot;:&quot;libvirt-1-stor=
age&quot;, &quot;driver&quot;:&quot;file&quot;,<br>
&gt; &gt; &quot;filename&quot;:&quot;/path/to/test_disk.qcow2&quot;}}&#39;<=
br>
&gt; <br>
&gt; 2. add a protocol blockdev node of LUKS header as above.<br>
&gt; $ virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;blockd=
ev-add&quot;,<br>
&gt; &gt; &quot;arguments&quot;:{&quot;node-name&quot;:&quot;libvirt-2-stor=
age&quot;, &quot;driver&quot;:&quot;file&quot;,<br>
&gt; &gt; &quot;filename&quot;: &quot;/path/to/cipher.gluks&quot; }}&#39;<b=
r>
&gt; <br>
&gt; 3. add the secret for decrypting the cipher stored in LUKS<br>
&gt;=C2=A0 =C2=A0 header above<br>
&gt; $ virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;object=
-add&quot;,<br>
&gt; &gt; &quot;arguments&quot;:{&quot;qom-type&quot;:&quot;secret&quot;, &=
quot;id&quot;:<br>
&gt; &gt; &quot;libvirt-2-storage-secret0&quot;, &quot;data&quot;:&quot;abc=
123&quot;}}&#39;<br>
&gt; <br>
&gt; 4. add the qcow2-drived blockdev format node<br>
&gt; $ virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;blockd=
ev-add&quot;,<br>
&gt; &gt; &quot;arguments&quot;:{&quot;node-name&quot;:&quot;libvirt-1-form=
at&quot;, &quot;driver&quot;:&quot;qcow2&quot;,<br>
&gt; &gt; &quot;file&quot;:&quot;libvirt-1-storage&quot;}}&#39;<br>
&gt; <br>
&gt; 5. add the luks-drived blockdev to link the qcow2 disk with<br>
&gt;=C2=A0 =C2=A0 LUKS header by specifying the field &quot;header&quot;<br=
>
&gt; $ virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;blockd=
ev-add&quot;,<br>
&gt; &gt; &quot;arguments&quot;:{&quot;node-name&quot;:&quot;libvirt-2-form=
at&quot;, &quot;driver&quot;:&quot;luks&quot;,<br>
&gt; &gt; &quot;file&quot;:&quot;libvirt-1-format&quot;, &quot;header&quot;=
:&quot;libvirt-2-storage&quot;,<br>
&gt; &gt; &quot;key-secret&quot;:&quot;libvirt-2-format-secret0&quot;}}&#39=
;<br>
&gt; <br>
&gt; 6. add the virtio-blk device finally<br>
&gt; $ virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;device=
_add&quot;,<br>
&gt; &gt; &quot;arguments&quot;: {&quot;num-queues&quot;:&quot;1&quot;, &qu=
ot;driver&quot;:&quot;virtio-blk-pci&quot;,<br>
&gt; &gt; &quot;drive&quot;: &quot;libvirt-2-format&quot;, &quot;id&quot;:&=
quot;virtio-disk2&quot;}}&#39;<br>
&gt; <br>
&gt; The generic LUKS encryption method of starting a virtual<br>
&gt; machine (VM) is somewhat similar to hot-plug in that both<br>
&gt; maintaining the same json command while the starting VM<br>
&gt; changes the &quot;blockdev-add/device_add&quot; parameters to<br>
&gt; &quot;blockdev/device&quot;.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; Message-Id: &lt;<a href=3D"mailto:910801f303da1601051479d3b7e5c2c6b4e0=
1eb7.1701879996.git.yong.huang@smartx.com" target=3D"_blank">910801f303da16=
01051479d3b7e5c2c6b4e01eb7.1701879996.git.yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 block/crypto.c | 14 +++++++++++++-<br>
&gt;=C2=A0 1 file changed, 13 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/block/crypto.c b/block/crypto.c<br>
&gt; index f82b13d32b..6063879bac 100644<br>
&gt; --- a/block/crypto.c<br>
&gt; +++ b/block/crypto.c<br>
&gt; @@ -64,12 +64,14 @@ static int block_crypto_read_func(QCryptoBlock *bl=
ock,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BlockDriverState *bs =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 BlockCrypto *crypto =3D bs-&gt;opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ssize_t ret;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 GLOBAL_STATE_CODE();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 GRAPH_RDLOCK_GUARD_MAINLOOP();<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 ret =3D bdrv_pread(bs-&gt;file, offset, buflen, buf, 0)=
;<br>
&gt; +=C2=A0 =C2=A0 ret =3D bdrv_pread(crypto-&gt;header ? crypto-&gt;heade=
r : bs-&gt;file,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0offset, buflen, buf, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, -ret, &quot;C=
ould not read encryption header&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; @@ -269,6 +271,7 @@ static int block_crypto_open_generic(QCryptoBlockF=
ormat format,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QCryptoBlockOpenOptions *open_opts =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 unsigned int cflags =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QDict *cryptoopts =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 const char *hdr_bdref =3D qdict_get_try_str(options, &q=
uot;header&quot;);<br>
<br>
This is an invalid check to make, because it is assuming the user is<br>
referencing a separate blockdev node name and doesn&#39;t work for an<br>
inline definition. eg<br>
<br>
=C2=A0 qemu-img info=C2=A0 &#39;json:{&quot;driver&quot;:&quot;luks&quot;,&=
quot;file&quot;:{&quot;filename&quot;:&quot;test-payload.img&quot;},&quot;h=
eader&quot;:{&quot;filename&quot;:&quot;test-header.img&quot;}}&#39;<br>
<br>
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 GLOBAL_STATE_CODE();<br>
&gt;=C2=A0 <br>
&gt; @@ -277,6 +280,15 @@ static int block_crypto_open_generic(QCryptoBlock=
Format format,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (hdr_bdref) {<br>
<br>
Get rid of this &#39;if&#39; clause and unconditionally call the next line:=
<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto-&gt;header =3D bdrv_open_child(NUL=
L, options, &quot;header&quot;, bs,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;child_of_bds, BDRV_CHILD_METADATA,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0false, errp);<br>
<br>
but pass &#39;true&#39; instead of &#39;false&#39; here to allow the child =
to be absent,<br>
and thus let it return NULL.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!crypto-&gt;header) {<br>
<br>
You&#39;ll need to then check=C2=A0 &#39;*errp !=3D NULL&#39; instead<br>
<br>
You&#39;ll also need &quot;ERRP_GUARD&quot; at the start of the method<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 GRAPH_RDLOCK_GUARD_MAINLOOP();<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 bs-&gt;supported_write_flags =3D BDRV_REQ_FUA &amp=
;<br>
<br>
This patch should be combined with the previous patch that adds the new<br>
QAPI schema element as splitting them doesn&#39;t add value.<br>
<br>
<br>
Testing this patch with the changes I suggest above, however, still does<br=
>
not work:<br>
<br>
=C2=A0 $ dd if=3D/dev/zero of=3Dtest-header.img bs=3D1M count=3D32<br>
=C2=A0 $ dd if=3D/dev/zero of=3Dtest-payload.img bs=3D1M count=3D1000<br>
=C2=A0 $ cryptsetup luksFormat=C2=A0 --header test-header.img test-payload.=
img=C2=A0 --force-password --type luks1<br>
=C2=A0 $ qemu-img info=C2=A0 &#39;json:{&quot;driver&quot;:&quot;luks&quot;=
,&quot;file&quot;:{&quot;filename&quot;:&quot;test-payload.img&quot;},&quot=
;header&quot;:{&quot;filename&quot;:&quot;test-header.img&quot;}}&#39;<br>
=C2=A0 qemu-img: Could not open &#39;json:{&quot;driver&quot;:&quot;luks&qu=
ot;,&quot;file&quot;:{&quot;filename&quot;:&quot;test-payload.img&quot;},&q=
uot;header&quot;:{&quot;filename&quot;:&quot;test-header.img&quot;}}&#39;: =
LUKS payload is overlapping with the header</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
<br>
You need to pass some info into qcrypto_block_open to tell it that the<br>
header is detached. Add a new enum entry to QCryptoBlockOpenFlags<br>
perhaps.=C2=A0 Then skip the LUKS payload overlap check.<br>
<br></blockquote><div><div class=3D"gmail_default"><span style=3D"font-fami=
ly:&quot;comic sans ms&quot;,sans-serif"></span></div><div class=3D"gmail_d=
efault"><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Ok=
, I&#39;ll try this way and=C2=A0</span><span style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif">do a test usi</span><font face=3D"comic sans =
ms, sans-serif">ng=C2=A0cryptsetup tools=C2=A0</font><span style=3D"font-fa=
mily:&quot;comic sans ms&quot;,sans-serif">in the next version.</span></div=
><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot=
;,sans-serif">Thanks for testing this series.</div></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);pa=
dding-left:1ex">
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

--0000000000001b9137060e59c8d1--

