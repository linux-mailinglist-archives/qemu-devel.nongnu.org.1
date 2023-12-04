Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D14803A61
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:35:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rABuJ-00039b-VL; Mon, 04 Dec 2023 11:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABuG-00039O-Dv
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:34:52 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABuB-0006ps-MH
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:34:52 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-28654179ec0so3380259a91.2
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 08:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701707564; x=1702312364;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v3GRmaVG2w5ro71VhHlbLzoHnBUaGx1Nj/DLDWO8eiA=;
 b=G0Zy2lPe6bnfKpR0z8UmsEqJIQfbu3Qq+jO6YghC4XIgXldLTfuRr4a6hHIROTrP38
 XrdGLdcmH41LvVh++yA4i2rzeLQZKT+7S8M38xsjXkaeRCpDyPCcjnopvH/G34n+xe/O
 QE8giZivw5ITL0nd3JifLkXqzKMYqYrLiaFqtocPRToE4sUDldOOlWSSsixjVHXYBlRg
 giLmtJJCvgrhkSSOsKlZeXodg+1lqjenBSy6BTMa5KKI/wymoSjoSPvFWcFOGOpdoO1i
 pNyc3OnGhHmYU+NOmDcKj08wbazBUfom0MJe3DwElhkB6ONL7zAOXMxZo6hCSN5zkYUw
 q5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701707564; x=1702312364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v3GRmaVG2w5ro71VhHlbLzoHnBUaGx1Nj/DLDWO8eiA=;
 b=GBCRiF8IsjOvWHkEarwgA2EpKy7+J16hAvdXj0rCiIkZYpbYIQcLj5ys3uTMOs62r8
 v5HRzGnWdpGl2AP/cyTskkhjNsAMJqn1d04FqrgAHoMIYf45HCg5RGroW5aN3rHRWn03
 rNQZKxpx2jKgD/IeLsXlLU+V2IljbWHcKYnWAvjS96peqKGSAvq+H7lptcDbkrKqujDj
 DAkHvIxYQTJdpfnFlAYHVqx5myV+UmsStGb3mKnLF+qDTNiVPS5GeS9yIkYvO82qJyLv
 7YLchxdIKSM3nEmIxakBSGT2wPqvH0iQykS5vGv+gcS0CZK4/8X8iMjnhOXR2yTA823D
 +rYg==
X-Gm-Message-State: AOJu0YwFIss54l1mFUhwclUhk28tkQu+LwvXh8iEai/mSnMyEfSJUOsN
 Sv8XwpI73B25HKzyxt04w892CJ4HEydSl8IkeVfRYQ==
X-Google-Smtp-Source: AGHT+IE/4nTXcTb7kDMKQLs4KXeAlm8/S/B0jSE0N8pBWOImFq8tlhw/4soi72Hc7dchJVPXQsS+LsZV3zPSJLPaCPc=
X-Received: by 2002:a17:90a:8008:b0:286:6cc1:3f17 with SMTP id
 b8-20020a17090a800800b002866cc13f17mr3426402pjn.78.1701707562354; Mon, 04 Dec
 2023 08:32:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701705003.git.yong.huang@smartx.com>
 <ZW39KzXUbWrJUdQH@redhat.com>
In-Reply-To: <ZW39KzXUbWrJUdQH@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 5 Dec 2023 00:32:26 +0800
Message-ID: <CAK9dgmY_imQzGu7u6xe-fTFLXG_WMrXiUy0cM9WKTd6v25cOUA@mail.gmail.com>
Subject: Re: [RFC 0/8] Support generic Luks encryption
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c42309060bb1aa8f"
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1036.google.com
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

--000000000000c42309060bb1aa8f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 12:24=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Tue, Dec 05, 2023 at 12:06:17AM +0800, Hyman Huang wrote:
> > This functionality was motivated by the following to-do list seen
> > in crypto documents:
> > https://wiki.qemu.org/Features/Block/Crypto
> >
> > The last chapter says we should "separate header volume":
> >
> > The LUKS format has ability to store the header in a separate volume
> > from the payload. We should extend the LUKS driver in QEMU to support
> > this use case.
> >
> > As a proof-of-concept, I've created this patchset, which I've named
> > the Gluks: generic luks. As their name suggests, they offer encryption
> > for any format that QEMU theoretically supports.
>
> I don't see the point in creating a new driver.
>

Indeed, this definitely makes things simple. The next version would do that
!

>
> I would expect detached header support to be implemented via an
> optional new 'header' field in the existing driver. ie
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ca390c5700..48d1f2a974 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3352,11 +3352,15 @@
>  #     decryption key (since 2.6). Mandatory except when doing a
>  #     metadata-only probe of the image.
>  #
> +# @header: optional reference to the location of a blockdev
> +#     storing a detached LUKS heaer
> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsLUKS',
>    'base': 'BlockdevOptionsGenericFormat',
> -  'data': { '*key-secret': 'str' } }
> +  'data': { '*key-secret': 'str',
> +            "*header-file': 'BlockdevRef'} }
>
>  ##
>  # @BlockdevOptionsGenericCOWFormat:
> @@ -4941,9 +4945,18 @@
>  #
>  # Driver specific image creation options for LUKS.
>  #
> -# @file: Node to create the image format on
> +# @file: Node to create the image format on. Mandatory
> +#     unless a detached header file is specified using
> +#     @header.
>  #
> -# @size: Size of the virtual disk in bytes
> +# @size: Size of the virtual disk in bytes.  Mandatory
> +#     unless a detached header file is specified using
> +#     @header.
> +#
> +# @header: optional reference to the location of a blockdev
> +#     storing a detached LUKS heaer. The @file option is
> +#     is optional when this is given, unless it is desired
> +#     to perform pre-allocation
>  #
>  # @preallocation: Preallocation mode for the new image (since: 4.2)
>  #     (default: off; allowed values: off, metadata, falloc, full)
> @@ -4952,8 +4965,9 @@
>  ##
>  { 'struct': 'BlockdevCreateOptionsLUKS',
>    'base': 'QCryptoBlockCreateOptionsLUKS',
> -  'data': { 'file':             'BlockdevRef',
> -            'size':             'size',
> +  'data': { '*file':            'BlockdevRef',
> +            '*size':            'size',
> +            '*header':          'BlockdevRef'
>              '*preallocation':   'PreallocMode' } }
>
>  ##
>
> It ends up giving basicallly the same workflow as you outline,
> without needing the new block driver
>
Yes, most of the logic reuse the pre-existing Luks driver.


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

--000000000000c42309060bb1aa8f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 5, 202=
3 at 12:24=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrang=
e@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Tue, Dec 05, 2023 at 12:06:17AM +0800, Hyman Huang wrote:<br>
&gt; This functionality was motivated by the following to-do list seen<br>
&gt; in crypto documents:<br>
&gt; <a href=3D"https://wiki.qemu.org/Features/Block/Crypto" rel=3D"norefer=
rer" target=3D"_blank">https://wiki.qemu.org/Features/Block/Crypto</a> <br>
&gt; <br>
&gt; The last chapter says we should &quot;separate header volume&quot;: <b=
r>
&gt; <br>
&gt; The LUKS format has ability to store the header in a separate volume<b=
r>
&gt; from the payload. We should extend the LUKS driver in QEMU to support<=
br>
&gt; this use case.<br>
&gt; <br>
&gt; As a proof-of-concept, I&#39;ve created this patchset, which I&#39;ve =
named<br>
&gt; the Gluks: generic luks. As their name suggests, they offer encryption=
<br>
&gt; for any format that QEMU theoretically supports.<br>
<br>
I don&#39;t see the point in creating a new driver.<br></blockquote><div cl=
ass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif"><br></div><div class=3D"gmail_default" style=3D"font-family:&quot;com=
ic sans ms&quot;,sans-serif">Indeed, this definitely makes things simple. T=
he next version would do that !</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid=
;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
I would expect detached header support to be implemented via an<br>
optional new &#39;header&#39; field in the existing driver. ie<br>
<br>
diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
index ca390c5700..48d1f2a974 100644<br>
--- a/qapi/block-core.json<br>
+++ b/qapi/block-core.json<br>
@@ -3352,11 +3352,15 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0decryption key (since 2.6). Mandatory except whe=
n doing a<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0metadata-only probe of the image.<br>
=C2=A0#<br>
+# @header: optional reference to the location of a blockdev<br>
+#=C2=A0 =C2=A0 =C2=A0storing a detached LUKS heaer<br>
+#<br>
=C2=A0# Since: 2.9<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;BlockdevOptionsLUKS&#39;,<br>
=C2=A0 =C2=A0&#39;base&#39;: &#39;BlockdevOptionsGenericFormat&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;*key-secret&#39;: &#39;str&#39; } }<br>
+=C2=A0 &#39;data&#39;: { &#39;*key-secret&#39;: &#39;str&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;*header-file&#39;: &#39;Bl=
ockdevRef&#39;} }<br>
<br>
=C2=A0##<br>
=C2=A0# @BlockdevOptionsGenericCOWFormat:<br>
@@ -4941,9 +4945,18 @@<br>
=C2=A0#<br>
=C2=A0# Driver specific image creation options for LUKS.<br>
=C2=A0#<br>
-# @file: Node to create the image format on<br>
+# @file: Node to create the image format on. Mandatory<br>
+#=C2=A0 =C2=A0 =C2=A0unless a detached header file is specified using<br>
+#=C2=A0 =C2=A0 =C2=A0@header.<br>
=C2=A0#<br>
-# @size: Size of the virtual disk in bytes<br>
+# @size: Size of the virtual disk in bytes.=C2=A0 Mandatory<br>
+#=C2=A0 =C2=A0 =C2=A0unless a detached header file is specified using<br>
+#=C2=A0 =C2=A0 =C2=A0@header.<br>
+#<br>
+# @header: optional reference to the location of a blockdev<br>
+#=C2=A0 =C2=A0 =C2=A0storing a detached LUKS heaer. The @file option is<br=
>
+#=C2=A0 =C2=A0 =C2=A0is optional when this is given, unless it is desired<=
br>
+#=C2=A0 =C2=A0 =C2=A0to perform pre-allocation<br>
=C2=A0#<br>
=C2=A0# @preallocation: Preallocation mode for the new image (since: 4.2)<b=
r>
=C2=A0#=C2=A0 =C2=A0 =C2=A0(default: off; allowed values: off, metadata, fa=
lloc, full)<br>
@@ -4952,8 +4965,9 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;BlockdevCreateOptionsLUKS&#39;,<br>
=C2=A0 =C2=A0&#39;base&#39;: &#39;QCryptoBlockCreateOptionsLUKS&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;file&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&#39;BlockdevRef&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;size&#39;:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;size&#39;,<br>
+=C2=A0 &#39;data&#39;: { &#39;*file&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;BlockdevRef&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*size&#39;:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;size&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*header&#39;:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &#39;BlockdevRef&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*preallocation&#39;:=
=C2=A0 =C2=A0&#39;PreallocMode&#39; } }<br>
<br>
=C2=A0##<br>
<br>
It ends up giving basicallly the same workflow as you outline,<br>
without needing the new block driver<br></blockquote><div><span style=3D"fo=
nt-family:&quot;comic sans ms&quot;,sans-serif"></span></div><div><span sty=
le=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yes, most of the lo=
gic reuse the pre-existing Luks driver<span class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">.</span></span></div>=
<div><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><span=
 class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,san=
s-serif"><br></span></span></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;bor=
der-left-color:rgb(204,204,204);padding-left:1ex">
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

--000000000000c42309060bb1aa8f--

