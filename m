Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B5D81736B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 15:19:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFERX-0005MD-GT; Mon, 18 Dec 2023 09:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rFERU-0005M5-Bj
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:18:00 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rFERR-0006QG-Bu
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:18:00 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5c6839373f8so2054510a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 06:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1702908952; x=1703513752;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aqKZ34yzEkUXjIYb5GE/D2ncuGJg1MjPcA2SXwinXsE=;
 b=01CG2rHsJN1qHkfnw47GLvUwkvcRKPhLg2mvAAkvHVWase3TVmwyKPxSHfIGyJlN9W
 V2l0Z1aHa7SEw4Aa9GaTaIAx/GVun73GOuvMEPHx11lwsDvPg7b8Jl/N4pL4NmLcvqb6
 CettGvgY8exxLzcj+0bP6bxDcX5qRapskTSGuQyLQ0h22jl+yJlL+FEn30jF2oj0E1Uz
 aiSK0nGnM/PRfoejfofSVxWj5rxTPYT07AyGNSj43GVEiFiEBrhUzoAsKlMZhv9PB28p
 hFWiGu76aX+Fdco8GHQhY96CMxzym49Ihjrs0FNSToo+OKCUzyAa71R8zygjB6QszzzW
 FwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702908952; x=1703513752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aqKZ34yzEkUXjIYb5GE/D2ncuGJg1MjPcA2SXwinXsE=;
 b=vOfexDlWuZ6nGBlV5I8YhUOS019Bn/AjnqiBKRVH6p9AF24zez7bA4oDgoEYg1fhXL
 4TEsEjmSFiL0x5ORB8EWykokQl1w2HIjiv+14PD7fsnEiRiTaaWrRgeVmP1xzxNlnRlR
 YOa2mxQNjwx8auWMHiUlhxWKEghU9vPonDACOz7hciSf0q0awm0CmUOUoW603iOySnTg
 TM1F7kufvJK0mFFzbBtlWKVYJczdt8AAtIEGxjaKdFa2rnhrpRQvBUCgzyv/GBOFKiFT
 a0FpRN/lUpe6/Imsx2J0CjzC0d7SXoEtYpTMUo9fZHFkQWTUyxgbTCkVYqkrVJO8Pm6C
 B3sw==
X-Gm-Message-State: AOJu0YylJiD8wPwXJHdC4Fdx6iMdo4iZsG053dCOaILDNLxOz8vPdd/M
 ekNOFOorbdGJCqwDeuVVtd+7GAdYvT92hTAIiosiQA==
X-Google-Smtp-Source: AGHT+IE9bdXriHL4Wa+4fcdGktPhyxH1H5LPMPnTjyDT5L3ol2k1nlN5VgM6BLWcjwmFsqBWjk458ixYJuds1gXxFv0=
X-Received: by 2002:a17:90a:e50e:b0:28b:3e0d:79f9 with SMTP id
 t14-20020a17090ae50e00b0028b3e0d79f9mr5325870pjy.10.1702908950612; Mon, 18
 Dec 2023 06:15:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701879996.git.yong.huang@smartx.com>
 <910801f303da1601051479d3b7e5c2c6b4e01eb7.1701879996.git.yong.huang@smartx.com>
 <ZYAp6kxCXgV749j2@redhat.com>
In-Reply-To: <ZYAp6kxCXgV749j2@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 18 Dec 2023 22:15:34 +0800
Message-ID: <CAK9dgmZ6E4Zv5Y_BBTSQBanXdC7310VKpfkJNLPomfhJZKZwqw@mail.gmail.com>
Subject: Re: [v2 3/4] crypto: Support generic LUKS encryption
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000162350060cc9634b"
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52b.google.com
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

--000000000000162350060cc9634b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 7:16=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Thu, Dec 07, 2023 at 12:37:44AM +0800, Hyman Huang wrote:
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
> > ---
> >  block/crypto.c | 38 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/crypto.c b/block/crypto.c
> > index f82b13d32b..7d70349463 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -40,6 +40,7 @@ struct BlockCrypto {
> >      QCryptoBlock *block;
> >      bool updating_keys;
> >      BdrvChild *header;  /* Reference to the detached LUKS header */
> > +    bool detached_mode; /* If true, LUKS plays a detached header role =
*/
> >  };
> >
> >
> > @@ -64,12 +65,16 @@ static int block_crypto_read_func(QCryptoBlock
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
> > +    if (crypto->detached_mode)
> > +        ret =3D bdrv_pread(crypto->header, offset, buflen, buf, 0);
> > +    else
> > +        ret =3D bdrv_pread(bs->file, offset, buflen, buf, 0);
>
> This can be simplified to:
>
>     ret =3D bdrv_pread(bs->header ? bs->header : file, offset, buflen, bu=
f,
> 0);
>

Ok.

>
> >      if (ret < 0) {
> >          error_setg_errno(errp, -ret, "Could not read encryption
> header");
> >          return ret;
> > @@ -269,6 +274,8 @@ static int
> block_crypto_open_generic(QCryptoBlockFormat format,
> >      QCryptoBlockOpenOptions *open_opts =3D NULL;
> >      unsigned int cflags =3D 0;
> >      QDict *cryptoopts =3D NULL;
> > +    const char *header_bdref =3D
> > +        qdict_get_try_str(options, "header");
> >
> >      GLOBAL_STATE_CODE();
> >
> > @@ -277,6 +284,16 @@ static int
> block_crypto_open_generic(QCryptoBlockFormat format,
> >          return ret;
> >      }
> >
> > +    if (header_bdref) {
> > +        crypto->detached_mode =3D true;
>
> Drop this flag since it has no benefit.
>
> > +        crypto->header =3D bdrv_open_child(NULL, options, "header", bs=
,
> > +                                         &child_of_bds,
> BDRV_CHILD_METADATA,
> > +                                         false, errp);
> > +        if (!crypto->header) {
> > +            return -EINVAL;
> > +        }
> > +    }
> > +
> >      GRAPH_RDLOCK_GUARD_MAINLOOP();
> >
> >      bs->supported_write_flags =3D BDRV_REQ_FUA &
> > @@ -312,6 +329,14 @@ static int
> block_crypto_open_generic(QCryptoBlockFormat format,
> >          goto cleanup;
> >      }
> >
> > +    if (crypto->detached_mode) {
>
>   if (crypto->header !=3D NULL)
>
> > +        /*
> > +         * Set payload offset to zero as the file bdref has no LUKS
> > +         * header under detached mode.
> > +         */
> > +        qcrypto_block_set_payload_offset(crypto->block, 0);
>
> The LUKS header stores the payload offset.  If someone creates the LUKS
> volume with a detached header, they may still choose to put the payload
> at a non-zero offset.
>
> So AFAICT, we should always honour the payload offset from the header,
> even when detached.   When formatting the header, we should default to
> a zero offset though
>

Agree, I'll code in that way in the next version.

>
> > +    }
> > +
> >      bs->encrypted =3D true;
> >
> >      ret =3D 0;
> > @@ -903,6 +928,17 @@ block_crypto_child_perms(BlockDriverState *bs,
> BdrvChild *c,
> >
> >      BlockCrypto *crypto =3D bs->opaque;
> >
> > +    if (role =3D=3D (role & BDRV_CHILD_METADATA)) {
> > +        /* Assign read permission only */
> > +        perm |=3D BLK_PERM_CONSISTENT_READ;
> > +        /* Share all permissions */
> > +        shared |=3D BLK_PERM_ALL;
> > +
> > +        *nperm =3D perm;
> > +        *nshared =3D shared;
> > +        return;
> > +    }
>
> What is code doing ?  You've set  BDRV_CHILD_METADATA role on the
> crypto->header  object, but how does this block_crypto_child_perms
> method get run against crypto->header ?
>
This paragraph originally aims to provide a function that multiple disks
could share
the same LUKS header (with read-only permission).
But I've found that it may not work when updating the detached header after
reviewing the patch recently :(.

Should it be a separate commit, Since it kind of has nothing to do with the
basic
function?

> > patchset.


>
> > +
> >      bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm,
> nshared);
> >
> >      /*
> > --
> > 2.39.1
> >
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
>

--=20
Best regards

--000000000000162350060cc9634b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 18, 20=
23 at 7:16=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrang=
e@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Thu, Dec 07, 2023 at 12:37:44AM +0800, Hyman Huang wrote:<br>
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
&gt; ---<br>
&gt;=C2=A0 block/crypto.c | 38 +++++++++++++++++++++++++++++++++++++-<br>
&gt;=C2=A0 1 file changed, 37 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/block/crypto.c b/block/crypto.c<br>
&gt; index f82b13d32b..7d70349463 100644<br>
&gt; --- a/block/crypto.c<br>
&gt; +++ b/block/crypto.c<br>
&gt; @@ -40,6 +40,7 @@ struct BlockCrypto {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QCryptoBlock *block;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool updating_keys;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BdrvChild *header;=C2=A0 /* Reference to the detac=
hed LUKS header */<br>
&gt; +=C2=A0 =C2=A0 bool detached_mode; /* If true, LUKS plays a detached h=
eader role */<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; @@ -64,12 +65,16 @@ static int block_crypto_read_func(QCryptoBlock *bl=
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
&gt; +=C2=A0 =C2=A0 if (crypto-&gt;detached_mode)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D bdrv_pread(crypto-&gt;header, off=
set, buflen, buf, 0);<br>
&gt; +=C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D bdrv_pread(bs-&gt;file, offset, b=
uflen, buf, 0);<br>
<br>
This can be simplified to:<br>
<br>
=C2=A0 =C2=A0 ret =3D bdrv_pread(bs-&gt;header ? bs-&gt;header : file, offs=
et, buflen, buf, 0);<br></blockquote><div><br></div><div class=3D"gmail_def=
ault" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Ok.</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);pa=
dding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, -ret, &quot;C=
ould not read encryption header&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; @@ -269,6 +274,8 @@ static int block_crypto_open_generic(QCryptoBlockF=
ormat format,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QCryptoBlockOpenOptions *open_opts =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 unsigned int cflags =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QDict *cryptoopts =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 const char *header_bdref =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdict_get_try_str(options, &quot;header&q=
uot;);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 GLOBAL_STATE_CODE();<br>
&gt;=C2=A0 <br>
&gt; @@ -277,6 +284,16 @@ static int block_crypto_open_generic(QCryptoBlock=
Format format,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (header_bdref) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto-&gt;detached_mode =3D true;<br>
<br>
Drop this flag since it has no benefit.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto-&gt;header =3D bdrv_open_child(NUL=
L, options, &quot;header&quot;, bs,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;child_of_bds, BDRV_CHILD_METADATA,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0false, errp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!crypto-&gt;header) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 GRAPH_RDLOCK_GUARD_MAINLOOP();<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 bs-&gt;supported_write_flags =3D BDRV_REQ_FUA &amp=
;<br>
&gt; @@ -312,6 +329,14 @@ static int block_crypto_open_generic(QCryptoBlock=
Format format,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (crypto-&gt;detached_mode) {<br>
<br>
=C2=A0 if (crypto-&gt;header !=3D NULL)<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Set payload offset to zero as the=
 file bdref has no LUKS<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* header under detached mode.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qcrypto_block_set_payload_offset(crypto-&=
gt;block, 0);<br>
<br>
The LUKS header stores the payload offset.=C2=A0 If someone creates the LUK=
S<br>
volume with a detached header, they may still choose to put the payload<br>
at a non-zero offset.<br>
<br>
So AFAICT, we should always honour the payload offset from the header,<br>
even when detached.=C2=A0 =C2=A0When formatting the header, we should defau=
lt to<br>
a zero offset though<br></blockquote><div><br></div><div class=3D"gmail_def=
ault" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Agree, I&#=
39;ll code in that way in the next version.</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bs-&gt;encrypted =3D true;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 ret =3D 0;<br>
&gt; @@ -903,6 +928,17 @@ block_crypto_child_perms(BlockDriverState *bs, Bd=
rvChild *c,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 BlockCrypto *crypto =3D bs-&gt;opaque;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (role =3D=3D (role &amp; BDRV_CHILD_METADATA)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Assign read permission only */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 perm |=3D BLK_PERM_CONSISTENT_READ;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Share all permissions */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 shared |=3D BLK_PERM_ALL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *nperm =3D perm;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *nshared =3D shared;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
What is code doing ?=C2=A0 You&#39;ve set=C2=A0 BDRV_CHILD_METADATA role on=
 the<br>
crypto-&gt;header=C2=A0 object, but how does this block_crypto_child_perms<=
br>
method get run against crypto-&gt;header ? <br></blockquote><div><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f"></div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif">This paragraph originally aims=C2=A0to provide a func=
tion that multiple disks could share</div><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">the same LUKS header=
 (with read-only permission). =C2=A0</div><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">But I&#39;ve found t=
hat it may not work when updating the detached=C2=A0header after</div><div =
class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif">reviewing the patch recently :(.</div><div class=3D"gmail_default" =
style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><div c=
lass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-=
serif">Should it be a separate commit, Since it kind of has nothing to do w=
ith the basic</div><div class=3D"gmail_default" style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif">function?</div><div class=3D"gmail_default"=
 style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><span=
 style=3D"color:rgb(80,0,80)">&gt; &gt; patchset.</span><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,2=
04,204);padding-left:1ex">
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bdrv_default_perms(bs, c, role, reopen_queue, perm=
, shared, nperm, nshared);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; -- <br>
&gt; 2.39.1<br>
&gt; <br>
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

--000000000000162350060cc9634b--

