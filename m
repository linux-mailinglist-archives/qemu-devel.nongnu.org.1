Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC1A8263FE
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 13:00:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMRpL-0004Ea-Cx; Sun, 07 Jan 2024 07:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rMRpI-0004Dw-L7
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 07:00:24 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rMRpG-00067G-49
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 07:00:24 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so1223976a12.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 03:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1704628699; x=1705233499;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HXTdd9k7z66M6LQFvPlDeESCw3SxnVeA8Bj9OBj3Skw=;
 b=OTfqWdEcyCczKq05uIv7lOtwS42zLz4F0COXYwjDzSCFLL4ZmfKRM+ZTmzS9K1jQ62
 2OhV05Qg9GXpR+wrcEbidpbBxv6l7sBW5Qz//tCo9s1J4PqjLgYrcbYw3cTSaChyJeS3
 WXxkumkSazhD+epYPErOc7tZCc2ylqPf2ECGtcohpQMh9fbJCZL2QwefNHq4kIRnt+vn
 9X+3ZIoARz2eVrVg+PW6wqmk+EKuk95Z5e+kvmWQ9ZPRMfUenrw3s2rPOyOfRD2U3rCO
 2/MMTu3Stj8s8o7+fAI6OE3qijg89pKYn6H+d7p5kAPJwJa+Bo3NS5jkgel8J72lNA9M
 d0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704628699; x=1705233499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HXTdd9k7z66M6LQFvPlDeESCw3SxnVeA8Bj9OBj3Skw=;
 b=kTwl5YXfFpjei7UoHE9RVDUm7lfG/sDgswy4WOZEJY473nYF/AOUp0ccJPQkXhn53U
 69Jx9dOoXKs8qunwJveFFiJFtRFb82Vc1v9QfFw8y4oGnX9sqmmKaf4Krd8HPxIi/26b
 e0joqoKGMu9aX41w3TD6BDf9/mty9ZM7ZQeuvsmh9Y7KSKq5Ng02apwncmN+PW1WtAZp
 XebPsoSWsfzCyUom4cPIwxWp4I6Vwh7Y5Q1+gkYojyuLhGBDhsuuBcybbNQ2TNzK4vpe
 k48VE72AbjmqXSJ7RlHI6s6vORs+JgnaX+VcdRP8ZlA280DCmT4bK7+3JUYkIAgBnGhR
 6cLg==
X-Gm-Message-State: AOJu0YwPzpHLwt4g/IstumoxZ2yiMfofy4oa6DbXw4RGsgSz2SKmxGo9
 9G+HQMgZomDneAF8vUVB3nlnbTgUuKaTGJLMEKh+wCJsPdWiLw==
X-Google-Smtp-Source: AGHT+IHBY4KJF2DM3nBsBo/VW8voZSRMSCgg9e0/4rMH0iQIDsWUxAZRH7NoXlM2q9NuWQ4B5saVMKvvYxTgJ6zVWyw=
X-Received: by 2002:a17:90a:7447:b0:28c:7e73:2485 with SMTP id
 o7-20020a17090a744700b0028c7e732485mr5938335pjk.36.1704628697113; Sun, 07 Jan
 2024 03:58:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1703482349.git.yong.huang@smartx.com>
 <57ccc93a05f69973d41b571615f9ef13fd9b2983.1703482349.git.yong.huang@smartx.com>
 <ZZbF6XvNiEng7JcS@redhat.com>
In-Reply-To: <ZZbF6XvNiEng7JcS@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Sun, 7 Jan 2024 19:58:01 +0800
Message-ID: <CAK9dgmYLba6KRk0rvrcsAHRkx1wTFWTV2p_=FJW+HO4=fhKZKA@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 04/10] crypto: Introduce creation option and
 structure for detached LUKS header
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f738c0060e59cb99"
Received-SPF: none client-ip=2607:f8b0:4864:20::531;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x531.google.com
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

--000000000000f738c0060e59cb99
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 10:51=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Mon, Dec 25, 2023 at 01:45:06PM +0800, Hyman Huang wrote:
> > Introduce 'header' field in BlockdevCreateOptionsLUKS to support
> > detached LUKS header creation. Meanwhile, introduce header-related
> > field in QCryptoBlock.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  crypto/blockpriv.h   | 3 +++
> >  qapi/block-core.json | 3 +++
> >  qapi/crypto.json     | 5 ++++-
> >  3 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
> > index 3c7ccea504..6289aea961 100644
> > --- a/crypto/blockpriv.h
> > +++ b/crypto/blockpriv.h
> > @@ -42,6 +42,9 @@ struct QCryptoBlock {
> >      size_t niv;
> >      uint64_t payload_offset; /* In bytes */
> >      uint64_t sector_size; /* In bytes */
> > +
> > +    bool detached_header; /* True if disk has a detached LUKS header *=
/
> > +    uint64_t detached_header_size; /* LUKS header size plus key slot
> size */
>
> This field can be replaced by a local variable I believe.
>
> >  };
> >
> >  struct QCryptoBlockDriver {
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 9ac256c489..8aec179926 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4948,6 +4948,8 @@
> >  # @file: Node to create the image format on, mandatory except when
> >  #        'preallocation' is not requested
> >  #
> > +# @header: Detached LUKS header node to format. (since 9.0)
> > +#
> >  # @size: Size of the virtual disk in bytes
> >  #
> >  # @preallocation: Preallocation mode for the new image (since: 4.2)
> > @@ -4958,6 +4960,7 @@
> >  { 'struct': 'BlockdevCreateOptionsLUKS',
> >    'base': 'QCryptoBlockCreateOptionsLUKS',
> >    'data': { '*file':            'BlockdevRef',
> > +            '*header':          'BlockdevRef',
> >              'size':             'size',
> >              '*preallocation':   'PreallocMode' } }
> >
> > diff --git a/qapi/crypto.json b/qapi/crypto.json
> > index fd3d46ebd1..6b4e86cb81 100644
> > --- a/qapi/crypto.json
> > +++ b/qapi/crypto.json
> > @@ -195,10 +195,13 @@
> >  #     decryption key.  Mandatory except when probing image for
> >  #     metadata only.
> >  #
> > +# @detached-header: if true, disk has detached LUKS header.
> > +#
> >  # Since: 2.6
> >  ##
> >  { 'struct': 'QCryptoBlockOptionsLUKS',
> > -  'data': { '*key-secret': 'str' }}
> > +  'data': { '*key-secret': 'str',
> > +            '*detached-header': 'bool' }}
>
> I don't think we need this change if we pass this info as an enum flag
>

Agree.


> >
> >  ##
> >  # @QCryptoBlockCreateOptionsLUKS:
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

--000000000000f738c0060e59cb99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 4, 202=
4 at 10:51=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrang=
e@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Mon, Dec 25, 2023 at 01:45:06PM +0800, Hyman Huang wrote:<br>
&gt; Introduce &#39;header&#39; field in BlockdevCreateOptionsLUKS to suppo=
rt<br>
&gt; detached LUKS header creation. Meanwhile, introduce header-related<br>
&gt; field in QCryptoBlock.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 crypto/blockpriv.h=C2=A0 =C2=A0| 3 +++<br>
&gt;=C2=A0 qapi/block-core.json | 3 +++<br>
&gt;=C2=A0 qapi/crypto.json=C2=A0 =C2=A0 =C2=A0| 5 ++++-<br>
&gt;=C2=A0 3 files changed, 10 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h<br>
&gt; index 3c7ccea504..6289aea961 100644<br>
&gt; --- a/crypto/blockpriv.h<br>
&gt; +++ b/crypto/blockpriv.h<br>
&gt; @@ -42,6 +42,9 @@ struct QCryptoBlock {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 size_t niv;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t payload_offset; /* In bytes */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t sector_size; /* In bytes */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 bool detached_header; /* True if disk has a detached LU=
KS header */<br>
&gt; +=C2=A0 =C2=A0 uint64_t detached_header_size; /* LUKS header size plus=
 key slot size */<br>
<br>
This field can be replaced by a local variable I believe.<br>
<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct QCryptoBlockDriver {<br>
&gt; diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
&gt; index 9ac256c489..8aec179926 100644<br>
&gt; --- a/qapi/block-core.json<br>
&gt; +++ b/qapi/block-core.json<br>
&gt; @@ -4948,6 +4948,8 @@<br>
&gt;=C2=A0 # @file: Node to create the image format on, mandatory except wh=
en<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;preallocation&#39; is not requ=
ested<br>
&gt;=C2=A0 #<br>
&gt; +# @header: Detached LUKS header node to format. (since 9.0)<br>
&gt; +#<br>
&gt;=C2=A0 # @size: Size of the virtual disk in bytes<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @preallocation: Preallocation mode for the new image (since: 4=
.2)<br>
&gt; @@ -4958,6 +4960,7 @@<br>
&gt;=C2=A0 { &#39;struct&#39;: &#39;BlockdevCreateOptionsLUKS&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;base&#39;: &#39;QCryptoBlockCreateOptionsLUKS&#39;,<=
br>
&gt;=C2=A0 =C2=A0 &#39;data&#39;: { &#39;*file&#39;:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;BlockdevRef&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*header&#39;:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;BlockdevRef&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;size&#39;:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;size&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*preallocation&#3=
9;:=C2=A0 =C2=A0&#39;PreallocMode&#39; } }<br>
&gt;=C2=A0 <br>
&gt; diff --git a/qapi/crypto.json b/qapi/crypto.json<br>
&gt; index fd3d46ebd1..6b4e86cb81 100644<br>
&gt; --- a/qapi/crypto.json<br>
&gt; +++ b/qapi/crypto.json<br>
&gt; @@ -195,10 +195,13 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0decryption key.=C2=A0 Mandatory except when=
 probing image for<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0metadata only.<br>
&gt;=C2=A0 #<br>
&gt; +# @detached-header: if true, disk has detached LUKS header.<br>
&gt; +#<br>
&gt;=C2=A0 # Since: 2.6<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;struct&#39;: &#39;QCryptoBlockOptionsLUKS&#39;,<br>
&gt; -=C2=A0 &#39;data&#39;: { &#39;*key-secret&#39;: &#39;str&#39; }}<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;*key-secret&#39;: &#39;str&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*detached-header&#39;:=
 &#39;bool&#39; }}<br>
<br>
I don&#39;t think we need this change if we pass this info as an enum flag<=
br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-f=
amily:&quot;comic sans ms&quot;,sans-serif">Agree.</div><div class=3D"gmail=
_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,20=
4);padding-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @QCryptoBlockCreateOptionsLUKS:<br>
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

--000000000000f738c0060e59cb99--

