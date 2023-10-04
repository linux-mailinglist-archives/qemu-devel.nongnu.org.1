Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 303B27B8077
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:15:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1hy-0006oy-TR; Wed, 04 Oct 2023 09:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qo1hp-0006mt-Fm
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:14:25 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qo1hm-0001lc-Gt
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:14:25 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so405438366b.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 06:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696425259; x=1697030059;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vrN7Xlm8FTq6oA3b7nLWs38RZVjznB5Vtlx1WPo8Zco=;
 b=czPpXVDW+2YZe3zVMDi3UsKf9ZevL7wAhxZrgN0oBMJ3MTMVyyWvq9sMvNPmt0IxNr
 DorVHmN/mM8eyrcXlCe1rrGcjInmE8kPf2whEAZz6U4zpjj8ahqnI4hW+qaukB/Q0D2G
 WVThjihmAk5+AydFttYIND6KmTlWzxhtzoQ/ubl+4+FWCLj0UPrU0IZVIheZ8iQRho/J
 Z3yweNdCkGIhFJ3F+q+dspD7IvFOaak38sn/l64SR6AN5vjSKFfDvgm1ZDSbOUjYr0ax
 bmHoobjilbflcMTRjgbSeBtkFosYh6TWDbv82al5MeFLti54GqT3v65AEkTKjs6oIHZ3
 mW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696425259; x=1697030059;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vrN7Xlm8FTq6oA3b7nLWs38RZVjznB5Vtlx1WPo8Zco=;
 b=TwdXz/kkVcK+ND0p9kaUSHbrjWecgij1JowfRFkW7pTgE+HnBxWpAjtKEN9Sgc5xgK
 CsOey7WN5snxle/aRPdnFoeSeuLjQuZ4EcxKd5BLscS/fbmNd/Tsj65md98JP17R5xb4
 djbIImoYaRGqwH4nDDdeI3hRacJ9Su9iJ3ci5dWrSdFPsmqHNqQejr2BvvCu3TntcBvd
 fl62UIkTPTsu1niAM/duLB3SvHvM7IgWN7/3wcMZL+3vr2gIk/kbFz6JgFfbH4hHV0UC
 hA0A+mPakSfCRX0H2V0Y04sTpjB5lvt81DNR/NAuGmrckOAvup9yQHfjUZ4lmfR2gu0g
 vJQA==
X-Gm-Message-State: AOJu0YxGmQHGhrCzyoHgP/Iv+TzGBLd9Cziho6pBpmDlHXPxZXpHmkr3
 iyXd3d+JutUxKIo7lpUZ8AmBB2xseQ1QfYMdtraOiA==
X-Google-Smtp-Source: AGHT+IGYnqG4n2BoAL5wElCrYRtNLxiadGbTL8NrrhAvgxqwxeiM0K0hqowBt+iy2jcp8oQs7SpoxoYsUl8eICoaG3E=
X-Received: by 2002:a17:906:74dd:b0:9ae:5a9f:6aa0 with SMTP id
 z29-20020a17090674dd00b009ae5a9f6aa0mr2159154ejl.33.1696425259319; Wed, 04
 Oct 2023 06:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <14cd0201-1507-bfa8-fe9e-f482c35d21ca@linaro.org>
 <ZR07WvspRlftPpMV@redhat.com>
In-Reply-To: <ZR07WvspRlftPpMV@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 4 Oct 2023 07:14:07 -0600
Message-ID: <CANCZdfrKb1XG-QsCxW1ON1B3H3uqV0wnF9QQ3HrBErN+A0jLmA@mail.gmail.com>
Subject: Re: Wshadow: Better name for 'optarg'?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f8580f0606e3c860"
Received-SPF: none client-ip=2a00:1450:4864:20::62d;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000f8580f0606e3c860
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 4, 2023, 4:16 AM Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:

> On Wed, Oct 04, 2023 at 12:05:04PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi,
> >
> > I'm getting a bunch of errors for 'optarg' declared in <unistd.h>:
> >
> > NAME
> >      getopt =E2=80=93 get option character from command line argument l=
ist
> >
> > LIBRARY
> >      Standard C Library (libc, -lc)
> >
> > SYNOPSIS
> >      #include <unistd.h>
> >
> >      extern char *optarg;
> >
> >
> > qom/object_interfaces.c:262:53: error: declaration shadows a variable i=
n
> the
> > global scope [-Werror,-Wshadow]
> > ObjectOptions *user_creatable_parse_str(const char *optarg, Error **err=
p)
>
> snip
>
> > Do we want to clean those? Any good name suggestion?
>
> Yes.  any of "argval", "opts", "optstr", "optval".
>

For the parsing in bsd-user I just removed the variable entirely and
removed the updating of its value since the parsing code was trying to do
what getopt also did...

Warner

With regards,
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
>

--000000000000f8580f0606e3c860
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Oct 4, 2023, 4:16 AM Daniel P. Berrang=C3=A9 &=
lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">On Wed, Oct 04, 2023 at 12:05:04P=
M +0200, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I&#39;m getting a bunch of errors for &#39;optarg&#39; declared in &lt=
;unistd.h&gt;:<br>
&gt; <br>
&gt; NAME<br>
&gt;=C2=A0 =C2=A0 =C2=A0 getopt =E2=80=93 get option character from command=
 line argument list<br>
&gt; <br>
&gt; LIBRARY<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Standard C=C2=A0Library (libc, -lc)<br>
&gt; <br>
&gt; SYNOPSIS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #include &lt;unistd.h&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 extern char *optarg;<br>
&gt; <br>
&gt; <br>
&gt; qom/object_interfaces.c:262:53: error: declaration shadows a variable =
in the<br>
&gt; global scope [-Werror,-Wshadow]<br>
&gt; ObjectOptions *user_creatable_parse_str(const char *optarg, Error **er=
rp)<br>
<br>
snip<br>
<br>
&gt; Do we want to clean those? Any good name suggestion?<br>
<br>
Yes.=C2=A0 any of &quot;argval&quot;, &quot;opts&quot;, &quot;optstr&quot;,=
 &quot;optval&quot;.<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">For the parsing in bsd-user I just removed the variable=
 entirely and removed the updating of its value since the parsing code was =
trying to do what getopt also did...</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Warner=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto=
"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000f8580f0606e3c860--

