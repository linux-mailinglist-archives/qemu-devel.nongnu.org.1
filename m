Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A97F781736E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 15:20:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFESv-0006et-Vk; Mon, 18 Dec 2023 09:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rFESu-0006eW-9A
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:19:28 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rFESs-0006c9-1v
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:19:28 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-28ba05b28adso312429a91.3
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 06:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1702909042; x=1703513842;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T0qqYoR9VzeSfoAb/yVoQnik3/MmlNuSt68lqAu3lk4=;
 b=VtULp54xHwR0z+4e3HVSuw+TDhSWyhqAggWHvJ3JTSXPHNwDl6tu+7CFmFjwyfusqE
 EGT2i3sQE7+QlHo5ZqqftJl7/UONs1corFU/FQEWGGiqgw3Q53bPmv5ZChkalVNdm6YJ
 PTPkmYoqynoN+BJ9jWFqGRGMfdpxD5KKMq0jSr7T4Nn38KTBNRAK6PgGjVLHtYkjxmoM
 /itMRxRvw9u4T7naxzCXcUMrAtWhGBM77pfu3MKh95FseQ4TqURtArbRI5aNuYaX6cjt
 VY2fAzqKHB+Xph/f4UgieSpMgUVsZ5i+hoIWtmQWkQneUNURym3GIDag+MHKsAnA6AE8
 rFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702909042; x=1703513842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T0qqYoR9VzeSfoAb/yVoQnik3/MmlNuSt68lqAu3lk4=;
 b=qhLv8l2NW/6YgxO2R3liKx4gf9VjD7Jsd9Gy1NgywuVcelSt1j8OTCQBc8y+B0VlrE
 bnP8IoFIr2jTFnUBULGMT6VodZaE6YqFh+L2VkN19EVz660tlT8D+1gJG2pFhHeBEx68
 m2EEIvQiTSDYdo7d9iLrOda05EXLJ1WOqkDYMlF/OnVgve0bNBgAXyXGdlaHeWABkYSU
 BULX6VAL9afvj3bC6sSiP0T0f9AP2gyKkmAXvr9PaaF6pmqsib5u7cYXy7tSL9LG1fOa
 uvjSbgFKOvIKCZTYG5Qe2Pmp7l6ehHx339I+EdW8btWmkmo+SVrQ7Pb3nBs+eQcirWlP
 VEsw==
X-Gm-Message-State: AOJu0YyqrTrvpCLh0SdzqmlLbwzsEZwvqq9mpriWdMq7vvO6XKxKjzs8
 /NRB7lMWvoS788+z/PkH9zCYqWZTA8+JOwfhGMrYrQ==
X-Google-Smtp-Source: AGHT+IGG+jUpn8MH+KX1Oyj/eAWy7VLtOL8vnKzDVd18KEkMt/K7H9vvZjGLebRsAaJzEobhv2Tb7s47oy1WG8xRn3c=
X-Received: by 2002:a17:90b:4c81:b0:28b:263a:cd40 with SMTP id
 my1-20020a17090b4c8100b0028b263acd40mr2081675pjb.89.1702909041044; Mon, 18
 Dec 2023 06:17:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701879996.git.yong.huang@smartx.com>
 <5ca4a43ea0795d9fb6ea3649eead10017df69b1c.1701879996.git.yong.huang@smartx.com>
 <ZYAq1kre1cEH5YOD@redhat.com>
In-Reply-To: <ZYAq1kre1cEH5YOD@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 18 Dec 2023 22:17:04 +0800
Message-ID: <CAK9dgmb9kWoa=Bgi_N4qnh8h-69XD2op-YAJisu1ENVAZnGjHQ@mail.gmail.com>
Subject: Re: [v2 4/4] block: Support detached LUKS header creation for
 blockdev-create
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007a07b7060cc9680b"
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102b.google.com
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

--0000000000007a07b7060cc9680b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 7:19=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Thu, Dec 07, 2023 at 12:37:45AM +0800, Hyman Huang wrote:
> > Provide the "detached-mode" option for detached LUKS header
> > formatting.
> >
> > To format the LUKS header on the pre-creating disk, example
> > as follows:
> >
> > 1. add a protocol blockdev node of LUKS header
> > $ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> > > "arguments":{"node-name":"libvirt-1-storage", "driver":"file",
> > > "filename":"/path/to/cipher.gluks" }}'
> >
> > 2. add the secret for encrypting the cipher stored in LUKS
> >    header above
> > $ virsh qemu-monitor-command vm '{"execute":"object-add",
> > > "arguments":{"qom-type": "secret", "id":
> > > "libvirt-1-storage-secret0", "data": "abc123"}}'
> >
> > 3. format the disk node
> > $ virsh qemu-monitor-command vm '{"execute":"blockdev-create",
> > > "arguments":{"job-id":"job0", "options":{"driver":"luks",
> > > "size":0, "file":"libvirt-1-storage", "detached-mode":true,
> > > "cipher-alg":"aes-256",
> > > "key-secret":"libvirt-3-storage-encryption-secret0"}}}'
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  block/crypto.c       | 8 +++++++-
> >  qapi/block-core.json | 5 ++++-
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 7d70349463..e77c49bd0c 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -667,10 +667,12 @@ block_crypto_co_create_luks(BlockdevCreateOptions
> *create_options, Error **errp)
> >      BlockDriverState *bs =3D NULL;
> >      QCryptoBlockCreateOptions create_opts;
> >      PreallocMode preallocation =3D PREALLOC_MODE_OFF;
> > +    int64_t size;
> >      int ret;
> >
> >      assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_LUKS);
> >      luks_opts =3D &create_options->u.luks;
> > +    size =3D luks_opts->size;
> >
> >      bs =3D bdrv_co_open_blockdev_ref(luks_opts->file, errp);
> >      if (bs =3D=3D NULL) {
> > @@ -686,7 +688,11 @@ block_crypto_co_create_luks(BlockdevCreateOptions
> *create_options, Error **errp)
> >          preallocation =3D luks_opts->preallocation;
> >      }
> >
> > -    ret =3D block_crypto_co_create_generic(bs, luks_opts->size,
> &create_opts,
> > +    if (luks_opts->detached_mode) {
> > +        size =3D 0;
> > +    }
> > +
> > +    ret =3D block_crypto_co_create_generic(bs, size, &create_opts,
> >                                           preallocation, errp);
> >      if (ret < 0) {
> >          goto fail;
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 10be08d08f..1e7a7e1b05 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4952,13 +4952,16 @@
> >  # @preallocation: Preallocation mode for the new image (since: 4.2)
> >  #     (default: off; allowed values: off, metadata, falloc, full)
> >  #
> > +# @detached-mode: create a detached LUKS header. (since 9.0)
> > +#
> >  # Since: 2.12
> >  ##
> >  { 'struct': 'BlockdevCreateOptionsLUKS',
> >    'base': 'QCryptoBlockCreateOptionsLUKS',
> >    'data': { 'file':             'BlockdevRef',
> >              'size':             'size',
> > -            '*preallocation':   'PreallocMode' } }
> > +            '*preallocation':   'PreallocMode',
> > +            '*detached-mode':   'bool'}}
>
> Using a bool flag here is insufficiently flexible. We need to be able to
> honour preallocation of the payload device, while using a separate
> header.
>
> You need to make the existing 'file' optional, while also adding an
> extra optional 'header' field. ie
>
>   { 'struct': 'BlockdevCreateOptionsLUKS',
>     'base': 'QCryptoBlockCreateOptionsLUKS',
>     'data': { '*file':            'BlockdevRef',
>               '*header':          'BlockdevRef',
>               'size':             'size',
>               '*preallocation':   'PreallocMode' } }
>
>
> If 'preallocation' is requested, then we must enforce that 'file' is
> non-NULL in the code.
>

Ok, thanks for the advice, I'll modify it in the next version.

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

--0000000000007a07b7060cc9680b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 18, 20=
23 at 7:19=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrang=
e@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Thu, Dec 07, 2023 at 12:37:45AM +0800, Hyman Huang wrote:<br>
&gt; Provide the &quot;detached-mode&quot; option for detached LUKS header<=
br>
&gt; formatting.<br>
&gt; <br>
&gt; To format the LUKS header on the pre-creating disk, example<br>
&gt; as follows:<br>
&gt; <br>
&gt; 1. add a protocol blockdev node of LUKS header<br>
&gt; $ virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;blockd=
ev-add&quot;,<br>
&gt; &gt; &quot;arguments&quot;:{&quot;node-name&quot;:&quot;libvirt-1-stor=
age&quot;, &quot;driver&quot;:&quot;file&quot;,<br>
&gt; &gt; &quot;filename&quot;:&quot;/path/to/cipher.gluks&quot; }}&#39;<br=
>
&gt; <br>
&gt; 2. add the secret for encrypting the cipher stored in LUKS<br>
&gt;=C2=A0 =C2=A0 header above<br>
&gt; $ virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;object=
-add&quot;,<br>
&gt; &gt; &quot;arguments&quot;:{&quot;qom-type&quot;: &quot;secret&quot;, =
&quot;id&quot;:<br>
&gt; &gt; &quot;libvirt-1-storage-secret0&quot;, &quot;data&quot;: &quot;ab=
c123&quot;}}&#39;<br>
&gt; <br>
&gt; 3. format the disk node<br>
&gt; $ virsh qemu-monitor-command vm &#39;{&quot;execute&quot;:&quot;blockd=
ev-create&quot;,<br>
&gt; &gt; &quot;arguments&quot;:{&quot;job-id&quot;:&quot;job0&quot;, &quot=
;options&quot;:{&quot;driver&quot;:&quot;luks&quot;,<br>
&gt; &gt; &quot;size&quot;:0, &quot;file&quot;:&quot;libvirt-1-storage&quot=
;, &quot;detached-mode&quot;:true,<br>
&gt; &gt; &quot;cipher-alg&quot;:&quot;aes-256&quot;,<br>
&gt; &gt; &quot;key-secret&quot;:&quot;libvirt-3-storage-encryption-secret0=
&quot;}}}&#39;<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 block/crypto.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 8 +++++++-<br>
&gt;=C2=A0 qapi/block-core.json | 5 ++++-<br>
&gt;=C2=A0 2 files changed, 11 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/block/crypto.c b/block/crypto.c<br>
&gt; index 7d70349463..e77c49bd0c 100644<br>
&gt; --- a/block/crypto.c<br>
&gt; +++ b/block/crypto.c<br>
&gt; @@ -667,10 +667,12 @@ block_crypto_co_create_luks(BlockdevCreateOption=
s *create_options, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 BlockDriverState *bs =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QCryptoBlockCreateOptions create_opts;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 PreallocMode preallocation =3D PREALLOC_MODE_OFF;<=
br>
&gt; +=C2=A0 =C2=A0 int64_t size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 assert(create_options-&gt;driver =3D=3D BLOCKDEV_D=
RIVER_LUKS);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 luks_opts =3D &amp;create_options-&gt;u.luks;<br>
&gt; +=C2=A0 =C2=A0 size =3D luks_opts-&gt;size;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 bs =3D bdrv_co_open_blockdev_ref(luks_opts-&gt;fil=
e, errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (bs =3D=3D NULL) {<br>
&gt; @@ -686,7 +688,11 @@ block_crypto_co_create_luks(BlockdevCreateOptions=
 *create_options, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 preallocation =3D luks_opts-&gt;prea=
llocation;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 ret =3D block_crypto_co_create_generic(bs, luks_opts-&g=
t;size, &amp;create_opts,<br>
&gt; +=C2=A0 =C2=A0 if (luks_opts-&gt;detached_mode) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D block_crypto_co_create_generic(bs, size, &amp;c=
reate_opts,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0preallocation, errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
&gt; index 10be08d08f..1e7a7e1b05 100644<br>
&gt; --- a/qapi/block-core.json<br>
&gt; +++ b/qapi/block-core.json<br>
&gt; @@ -4952,13 +4952,16 @@<br>
&gt;=C2=A0 # @preallocation: Preallocation mode for the new image (since: 4=
.2)<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0(default: off; allowed values: off, metadat=
a, falloc, full)<br>
&gt;=C2=A0 #<br>
&gt; +# @detached-mode: create a detached LUKS header. (since 9.0)<br>
&gt; +#<br>
&gt;=C2=A0 # Since: 2.12<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;struct&#39;: &#39;BlockdevCreateOptionsLUKS&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;base&#39;: &#39;QCryptoBlockCreateOptionsLUKS&#39;,<=
br>
&gt;=C2=A0 =C2=A0 &#39;data&#39;: { &#39;file&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&#39;BlockdevRef&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;size&#39;:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;size&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*preallocation&#39;:=
=C2=A0 =C2=A0&#39;PreallocMode&#39; } }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*preallocation&#39;:=
=C2=A0 =C2=A0&#39;PreallocMode&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*detached-mode&#39;:=
=C2=A0 =C2=A0&#39;bool&#39;}}<br>
<br>
Using a bool flag here is insufficiently flexible. We need to be able to<br=
>
honour preallocation of the payload device, while using a separate<br>
header.<br>
<br>
You need to make the existing &#39;file&#39; optional, while also adding an=
<br>
extra optional &#39;header&#39; field. ie<br>
<br>
=C2=A0 { &#39;struct&#39;: &#39;BlockdevCreateOptionsLUKS&#39;,<br>
=C2=A0 =C2=A0 &#39;base&#39;: &#39;QCryptoBlockCreateOptionsLUKS&#39;,<br>
=C2=A0 =C2=A0 &#39;data&#39;: { &#39;*file&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &#39;BlockdevRef&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*header&#39;:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;BlockdevRef&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;size&#39;:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;size&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*preallocation&#39;:=
=C2=A0 =C2=A0&#39;PreallocMode&#39; } }<br>
<br>
<br>
If &#39;preallocation&#39; is requested, then we must enforce that &#39;fil=
e&#39; is<br>
non-NULL in the code.<br></blockquote><div><br></div><div class=3D"gmail_de=
fault" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Ok, thank=
s for the advice, I&#39;ll modify it in the next version.</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:=
1ex">
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

--0000000000007a07b7060cc9680b--

