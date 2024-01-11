Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 278B882B265
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 17:05:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxYY-0007AV-0R; Thu, 11 Jan 2024 11:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rNxYT-000796-Ta
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:05:18 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rNxYH-0008Ld-Ru
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:05:12 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so4233941a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 08:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1704988980; x=1705593780;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8/lk4OVomEx4I00F5QHPLA58OMzGmQGpiKOVEXjT2kA=;
 b=VNF9Fmop3jqtb4rmxrGVlHwzKV4iq/yW4SaCCCp0GmjhC74Sfdif35K1oqac+EFj7u
 rtwuTNfWPpQwTYdctN9v8CRlwpJr3oOW9Rw+45qTWk3NLOZryywX93IHO+KXEIIQzxiG
 Ex+TzpcwCC7dmTbI6QdTEF3FtcMj1eUfM29/mFKJfhz1oWTWGEhU5ny7X3jU+HrYkTDF
 AZCdpevAOYyrK8lO2YTSJwIo867I9uu9+lWDMJf/nA/4F+rYz4LiO1mI1DRy/D54Cgx9
 H9Jnxb4vbaLW8VbtmPS9n3w4g8mPBh+RI+B/CMcrR3BtXaZyuj4xI0ChK0Cw91d/Y50i
 91Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704988980; x=1705593780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8/lk4OVomEx4I00F5QHPLA58OMzGmQGpiKOVEXjT2kA=;
 b=kPFoXcw6tYwDz9RgapKbgUcsvKED0meEXYIkhZAADq7+hCiUAygGummxEiuO2JwRqV
 xLd5+e3gBipXTpbADBrDv8QZ7nFunFMjXvZ1GdiZV0SNwaeFTfjKblRGdOn5O9ReMWqE
 h/7qi7fcMZxKPnTaqGDkKlcClix02wNeGmUQe24qtAIfQLU635/emnDuikqaMWmJESWO
 Z/XSYCVpM/1GTZvvyTL4CpsoGAAHW6KgYi/1GPJ1p4okT0uWsw32pDwb6Hma8LKVHxH3
 dzv9EkPMAh4Qc/1fIR7bkcxf885bttKbNWb4aq8avouS/sNZpIjDeUxEIdCQmvSJSkZz
 MtOA==
X-Gm-Message-State: AOJu0YzduuV0eAH6QQRTN6u3eM46vDIG/I8n/lsJv+QGrwf2k1GXhYMt
 EqxMCAKwXRdQwCFyK18mXNyFWfcow77s/FboP7wBCfd8UzT5iw==
X-Google-Smtp-Source: AGHT+IF6yJy8G2fC46Tn0SyI9zks5C3IfZqx+oU/xpnyeNQDARY+sJ5cY8ldnc8veAak7XKehjtmL9BG8/vSDlqD0h4=
X-Received: by 2002:a17:90b:3b45:b0:28d:bd27:f81 with SMTP id
 ot5-20020a17090b3b4500b0028dbd270f81mr1116103pjb.15.1704988978173; Thu, 11
 Jan 2024 08:02:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1703482349.git.yong.huang@smartx.com>
 <a34c12048198cea06d5d1a69a3fa8b76ab13cbba.1703482349.git.yong.huang@smartx.com>
 <87h6jkuee9.fsf@pond.sub.org> <ZaACIZlPRnJidSE_@redhat.com>
In-Reply-To: <ZaACIZlPRnJidSE_@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 12 Jan 2024 00:02:42 +0800
Message-ID: <CAK9dgmaFpzvmnTm12Am+UJWYwikA48RWqUWX5PQ3zFphVT8K3w@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 01/10] crypto: Introduce option and structure
 for detached LUKS header
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000063efc4060eadae33"
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x529.google.com
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

--00000000000063efc4060eadae33
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 10:58=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Thu, Jan 11, 2024 at 03:35:10PM +0100, Markus Armbruster wrote:
> > Hyman Huang <yong.huang@smartx.com> writes:
> >
> > > Add the "header" option for the LUKS format. This field would be
> > > used to identify the blockdev's position where a detachable LUKS
> > > header is stored.
> > >
> > > In addition, introduce header field in struct BlockCrypto
> > >
> > > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > Message-Id: <
> 5b99f60c7317092a563d7ca3fb4b414197015eb2.1701879996.git.yong.huang@smartx=
.com
> >
> > > ---
> > >  block/crypto.c       | 1 +
> > >  qapi/block-core.json | 6 +++++-
> > >  2 files changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/block/crypto.c b/block/crypto.c
> > > index 921933a5e5..f82b13d32b 100644
> > > --- a/block/crypto.c
> > > +++ b/block/crypto.c
> > > @@ -39,6 +39,7 @@ typedef struct BlockCrypto BlockCrypto;
> > >  struct BlockCrypto {
> > >      QCryptoBlock *block;
> > >      bool updating_keys;
> > > +    BdrvChild *header;  /* Reference to the detached LUKS header */
> > >  };
> > >
> > >
> > > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > index ca390c5700..10be08d08f 100644
> > > --- a/qapi/block-core.json
> > > +++ b/qapi/block-core.json
> > > @@ -3352,11 +3352,15 @@
> > >  #     decryption key (since 2.6). Mandatory except when doing a
> > >  #     metadata-only probe of the image.
> > >  #
> > > +# @header: optional reference to the location of a blockdev
> > > +#     storing a detached LUKS header. (since 9.0)
> >
> > This will come out like
> >
> >     "header": "BlockdevRef" (optional)
> >        optional reference to the location of a blockdev storing a
> detached
> >        LUKS header. (since 9.0)
> >
> > in the manual.  Scratch "optional".
> >
> > Moreover, a BlockdevRef is a "Reference to a block device" (quote from
> > its doc comment), not a "reference to the location of a blockdev".
> > Better simplify to something like "block device holding a detached LUKS
> > header".
> >
> > But that's just phrasing.  The contents could perhaps use improvement,
> > too.  Let's start with this question: what's a detachable LUKS header,
> > and why would anybody want to use it?
>
> Normally a LUKS volume has a layout:
>
>   disk:  | header | key material | disk payload data |
>
> With a detached LUKS header, you need 2 disks so getting
>
>   disk1:  | header | key material |
>   disk2:  | disk payload data |
>
> There are a variety of reasons to do this
>
>  * Secrecy - the disk2 cannot be identified as containing LUKS volume
>              since there's no header
>
>  * Control - if access to the disk1 is restricted, then even if someone
>              has access to disk2 they can't unlock it. Might be useful
>              if you have disks on NFS but want to restrict which host
>              can launch a VM instance from it, by dynamically providing
>              access to the header to a designated host
>
>  * Flexibility - your application data volume may be a given size and
>                  it is inconvenient to resize it to add encryption.
>                  You can store the LUKS header separately and use
>                  the existing storage volume for payload
>
>  * Recovery - corruption of a bit in the header may make the entire
>               payload inaccessible. It might be convenient to take
>               backups of the header. If your primary disk header
>               becomes corrupt, you can unlock the data still by
>               pointing to the backup detached header.
>
Thank you, Daniel, for the incisive summary. IMHO, the reason listed
above could be added to the document directly :) .

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

--00000000000063efc4060eadae33
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 11, 20=
24 at 10:58=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berran=
ge@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"=
>On Thu, Jan 11, 2024 at 03:35:10PM +0100, Markus Armbruster wrote:<br>
&gt; Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_bl=
ank">yong.huang@smartx.com</a>&gt; writes:<br>
&gt; <br>
&gt; &gt; Add the &quot;header&quot; option for the LUKS format. This field=
 would be<br>
&gt; &gt; used to identify the blockdev&#39;s position where a detachable L=
UKS<br>
&gt; &gt; header is stored.<br>
&gt; &gt;<br>
&gt; &gt; In addition, introduce header field in struct BlockCrypto<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smart=
x.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; &gt; Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berran=
ge@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
&gt; &gt; Message-Id: &lt;<a href=3D"mailto:5b99f60c7317092a563d7ca3fb4b414=
197015eb2.1701879996.git.yong.huang@smartx.com" target=3D"_blank">5b99f60c7=
317092a563d7ca3fb4b414197015eb2.1701879996.git.yong.huang@smartx.com</a>&gt=
;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 block/crypto.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 +<br>
&gt; &gt;=C2=A0 qapi/block-core.json | 6 +++++-<br>
&gt; &gt;=C2=A0 2 files changed, 6 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/block/crypto.c b/block/crypto.c<br>
&gt; &gt; index 921933a5e5..f82b13d32b 100644<br>
&gt; &gt; --- a/block/crypto.c<br>
&gt; &gt; +++ b/block/crypto.c<br>
&gt; &gt; @@ -39,6 +39,7 @@ typedef struct BlockCrypto BlockCrypto;<br>
&gt; &gt;=C2=A0 struct BlockCrypto {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 QCryptoBlock *block;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 bool updating_keys;<br>
&gt; &gt; +=C2=A0 =C2=A0 BdrvChild *header;=C2=A0 /* Reference to the detac=
hed LUKS header */<br>
&gt; &gt;=C2=A0 };<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
&gt; &gt; index ca390c5700..10be08d08f 100644<br>
&gt; &gt; --- a/qapi/block-core.json<br>
&gt; &gt; +++ b/qapi/block-core.json<br>
&gt; &gt; @@ -3352,11 +3352,15 @@<br>
&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0decryption key (since 2.6). Mandatory =
except when doing a<br>
&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0metadata-only probe of the image.<br>
&gt; &gt;=C2=A0 #<br>
&gt; &gt; +# @header: optional reference to the location of a blockdev<br>
&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0storing a detached LUKS header. (since 9.0)=
<br>
&gt; <br>
&gt; This will come out like<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;header&quot;: &quot;BlockdevRef&quot; (option=
al)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 optional reference to the location of a blo=
ckdev storing a detached<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 LUKS header. (since 9.0)<br>
&gt; <br>
&gt; in the manual.=C2=A0 Scratch &quot;optional&quot;.<br>
&gt; <br>
&gt; Moreover, a BlockdevRef is a &quot;Reference to a block device&quot; (=
quote from<br>
&gt; its doc comment), not a &quot;reference to the location of a blockdev&=
quot;.<br>
&gt; Better simplify to something like &quot;block device holding a detache=
d LUKS<br>
&gt; header&quot;.<br>
&gt; <br>
&gt; But that&#39;s just phrasing.=C2=A0 The contents could perhaps use imp=
rovement,<br>
&gt; too.=C2=A0 Let&#39;s start with this question: what&#39;s a detachable=
 LUKS header,<br>
&gt; and why would anybody want to use it?<br>
<br>
Normally a LUKS volume has a layout:<br>
<br>
=C2=A0 disk:=C2=A0 | header | key material | disk payload data |<br>
<br>
With a detached LUKS header, you need 2 disks so getting<br>
<br>
=C2=A0 disk1:=C2=A0 | header | key material |<br>
=C2=A0 disk2:=C2=A0 | disk payload data |<br>
<br>
There are a variety of reasons to do this<br>
<br>
=C2=A0* Secrecy - the disk2 cannot be identified as containing LUKS volume<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0since there&#39;s no header=
<br>
<br>
=C2=A0* Control - if access to the disk1 is restricted, then even if someon=
e<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0has access to disk2 they ca=
n&#39;t unlock it. Might be useful<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if you have disks on NFS bu=
t want to restrict which host<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0can launch a VM instance fr=
om it, by dynamically providing<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0access to the header to a d=
esignated host<br>
<br>
=C2=A0* Flexibility - your application data volume may be a given size and<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0it is inconve=
nient to resize it to add encryption.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0You can store=
 the LUKS header separately and use<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the existing =
storage volume for payload<br>
<br>
=C2=A0* Recovery - corruption of a bit in the header may make the entire<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 payload inaccessible. It m=
ight be convenient to take<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 backups of the header. If =
your primary disk header<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 becomes corrupt, you can u=
nlock the data still by<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pointing to the backup det=
ached header.<br></blockquote><div><div class=3D"gmail_default"><font face=
=3D"comic sans ms, sans-serif"></font></div><div class=3D"gmail_default"><f=
ont face=3D"comic sans ms, sans-serif">Thank you, Daniel, for the incisive =
summary. IMHO, the reason listed</font></div><div class=3D"gmail_default"><=
font face=3D"comic sans ms, sans-serif">above=C2=A0</font><span style=3D"fo=
nt-family:&quot;comic sans ms&quot;,sans-serif">could be added to the docum=
ent directly :)=C2=A0</span><span style=3D"font-family:&quot;comic sans ms&=
quot;,sans-serif">.</span></div></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:soli=
d;border-left-color:rgb(204,204,204);padding-left:1ex">
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

--00000000000063efc4060eadae33--

