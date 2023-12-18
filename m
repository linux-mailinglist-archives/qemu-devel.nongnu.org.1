Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18844817064
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 14:26:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFDbn-0004wP-9n; Mon, 18 Dec 2023 08:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rFDbk-0004wG-A2
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:24:32 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rFDbg-0003TG-GJ
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:24:32 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5bcfc508d14so2531320a12.3
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 05:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1702905744; x=1703510544;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=00S6+Do3Ca49ncjVZg3Gp9PBt6Kswb+Tkt8ZzmF4rLw=;
 b=vLo/2BWGOEYeGLAV7EVxeMs5V1MRtD4E5v8K8itaP457fGwAWXGLJjiLER89VvcGC5
 NYtxfUGXW4LjZMV1wAUL5THWczHMtIQAyxl11xvqzI+dD8pYFFLcNNJi4ATOlL9zf5Lv
 qmp3/YzaHSF0iUrnKeSIH4BPaHMTO7/kr3nSX+aoumez+Ht7gp1j8T51L9JDvI4pB2Te
 mMAZBoWL1y53O7UuxUJkfAmWW6/zPwTQwbIZZkd1nk2Wszl/DvNcEUneqT4242/bOJyy
 fK0iPncIhEUQ4tf/Lm4pQEWiOLRIIofJbLlUKm7Fk6LtKpBAncDYvEnyH5pw7Qr6BxVh
 F2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702905744; x=1703510544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=00S6+Do3Ca49ncjVZg3Gp9PBt6Kswb+Tkt8ZzmF4rLw=;
 b=MPFWm/KE1mtXU6gtmJbFIFTjZgy8iDW3vEAicCSH8eg34j9A+PAvMDs4uubFfuu8QS
 1Ir4UrBGHaSoGTXEB9WK+qbkUY1AUONSMhYByCx6QtfQKnP/X7dJE0rRELX/9uvUV4MT
 Q8hY44Ti9+qCDwdpkcGGKKD+OvBL63pxRmMI7Z5GHarfB6znDQjQnTt8/cYXKuPn3CUF
 sOv70ejRHWQRxI/SpTHrUauemVxmwIH/B738EnaetBU/q57h8f/lipATNtnqIqgVfKrl
 59c574gMiHEtWdvaBtVk9VsI4IY7atgbYVsFeI1dldbKRkod7TkFjQ8uT9xOAbdaD2Vn
 +sHA==
X-Gm-Message-State: AOJu0YyWVH3Sx1kGxXepTkVfRcRmuFG5bGhBnmFqlZcLnNcKwM6YaIE3
 LVPBpe6cQ2xW4gU9saWEiZc57CGwEoOvBR1vzD6mpA==
X-Google-Smtp-Source: AGHT+IGEf4YviLmotRu2jtVYtnkp95qyQJaTObjwBSkiBu9w5S6a+USnJtL7CG3MHXLPrLDBfE/7qFa6bpIJjV8IGWM=
X-Received: by 2002:a17:90b:1b41:b0:28b:3b34:9c4 with SMTP id
 nv1-20020a17090b1b4100b0028b3b3409c4mr2161041pjb.43.1702905742777; Mon, 18
 Dec 2023 05:22:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701879996.git.yong.huang@smartx.com>
 <ZYArI__TwpzTb0xp@redhat.com>
In-Reply-To: <ZYArI__TwpzTb0xp@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 18 Dec 2023 21:22:06 +0800
Message-ID: <CAK9dgmajKSbqD0aCDbSmyUBHrAmRW1ryNG+FGEuKrNn-KJDvsg@mail.gmail.com>
Subject: Re: [v2 0/4] Support generic Luks encryption
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e27302060cc8a3b5"
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

--000000000000e27302060cc8a3b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 7:21=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Thu, Dec 07, 2023 at 12:37:41AM +0800, Hyman Huang wrote:
> > v2:
> > - Simplify the design by reusing the LUKS driver to implement
> >   the generic Luks encryption, thank Daniel for the insightful
> >   advice.
> > - rebase on master.
> >
>
> > Hyman Huang (4):
> >   crypto: Introduce option and structure for detached LUKS header
> >   crypto: Introduce payload offset set function
> >   crypto: Support generic LUKS encryption
> >   block: Support detached LUKS header creation for blockdev-create
> >
> >  block/crypto.c         | 47 ++++++++++++++++++++++++++++++++++++++++--
> >  crypto/block.c         |  4 ++++
> >  include/crypto/block.h |  1 +
> >  qapi/block-core.json   | 11 ++++++++--
> >  4 files changed, 59 insertions(+), 4 deletions(-)
>
> Could you add a scenario tests/qemu-iotests/tests/luks-detached-header
> to provide coverage of this method feature.
>

Sure, of course.

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

--000000000000e27302060cc8a3b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 18, 20=
23 at 7:21=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrang=
e@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Thu, Dec 07, 2023 at 12:37:41AM +0800, Hyman Huang wrote:<br>
&gt; v2:<br>
&gt; - Simplify the design by reusing the LUKS driver to implement<br>
&gt;=C2=A0 =C2=A0the generic Luks encryption, thank Daniel for the insightf=
ul <br>
&gt;=C2=A0 =C2=A0advice.<br>
&gt; - rebase on master. <br>
&gt; <br>
<br>
&gt; Hyman Huang (4):<br>
&gt;=C2=A0 =C2=A0crypto: Introduce option and structure for detached LUKS h=
eader<br>
&gt;=C2=A0 =C2=A0crypto: Introduce payload offset set function<br>
&gt;=C2=A0 =C2=A0crypto: Support generic LUKS encryption<br>
&gt;=C2=A0 =C2=A0block: Support detached LUKS header creation for blockdev-=
create<br>
&gt; <br>
&gt;=C2=A0 block/crypto.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 47 +++++++++++=
+++++++++++++++++++++++++++++--<br>
&gt;=C2=A0 crypto/block.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++++<b=
r>
&gt;=C2=A0 include/crypto/block.h |=C2=A0 1 +<br>
&gt;=C2=A0 qapi/block-core.json=C2=A0 =C2=A0| 11 ++++++++--<br>
&gt;=C2=A0 4 files changed, 59 insertions(+), 4 deletions(-)<br>
<br>
Could you add a scenario tests/qemu-iotests/tests/luks-detached-header<br>
to provide coverage of this method feature.<br></blockquote><div><br></div>=
<div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif">Sure, of course.</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex">
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

--000000000000e27302060cc8a3b5--

