Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D16719FC2
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:23:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4jCK-0007yP-MU; Thu, 01 Jun 2023 10:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4jCI-0007y5-8f
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4jCG-00075P-Fd
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685629356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6jJyRqAwFfO9G2W9as3yolDnxgdtOEXWm05GV148hy8=;
 b=bt7EwaovxQxWos3dlA+4Dsc5Pc4RgTtMFOmBPI+FJ/IL47CmYrzcIuSKjBPWpjZ3FC78Z+
 Rw+70jvouw4iKtcVV8smuSRity8DNFd2VPEoB6PwSzXWmoBy5PGFkd9/k+GXwFwc6HtAnb
 QBky0XdWzzcBP0qPWOOcCQpzqQW2sn4=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-cfw0_tjDM3SRKPJY8aPWKA-1; Thu, 01 Jun 2023 10:22:34 -0400
X-MC-Unique: cfw0_tjDM3SRKPJY8aPWKA-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-78681dff350so253343241.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 07:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685629353; x=1688221353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6jJyRqAwFfO9G2W9as3yolDnxgdtOEXWm05GV148hy8=;
 b=fYyY6jYew8B5wRzKghTBlAKlyakLIASJAY8HTfayFt7Rokh9NkXo8cIUeeyZWlCAAr
 PO+/KQNzyhrxXkXPpE+LDIkjKfn69qENE/oGy9vNKqhttes6Z83fARD4Sk93i4mJdYgI
 NroSoOgUADfWzKwbsS86pMM3qBZ4GdPQB6JLLss6WLrYQy20b/ckoliAJBuJa3L0joyA
 7EZkba+6qc5kmt14f2NmpgGCJJDsYdp+lenr+RbwhmhnbeumKBJb6XG2ajg0zwuSXScA
 dRiFU/9VnJGU0K9FeRkK62+2GKb3A4raKjw90YtfTv7DPn85R2a7supVJ2zjNFZMp8NQ
 Bgbw==
X-Gm-Message-State: AC+VfDzp/BvkDjdEcq5qxqJUcBh6DKaQHqQMjPBrBA9MtFR2CIy/0LW0
 ekVF3GZNNM6YAEHviezuNhwwJwtwoaqgHdR1M8mSQ/nLGv2yC+O7qq/4mzIBSN338a3WyCfM0kB
 m4pYNWI+i8kuI0NGg9wauqTdqpyt2kfU=
X-Received: by 2002:a67:ed19:0:b0:434:85e0:834c with SMTP id
 l25-20020a67ed19000000b0043485e0834cmr2869827vsp.20.1685629353619; 
 Thu, 01 Jun 2023 07:22:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7fRKDsDp0OQLypNlFOFp5CqHuIF2yh/9FgnA0agNBxGkBSjzl0OIrO4RXkvRdliqVvBomrMlwe+sKs6947G7I=
X-Received: by 2002:a67:ed19:0:b0:434:85e0:834c with SMTP id
 l25-20020a67ed19000000b0043485e0834cmr2869812vsp.20.1685629353283; Thu, 01
 Jun 2023 07:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230601115145.196465-1-pbonzini@redhat.com>
 <20230601115145.196465-2-pbonzini@redhat.com>
 <w7g7ibw4j4yipnhjbnjqyoxg5llnwr6t5pfwf4uvjilw63gwuw@mzxtxvdfhwfe>
In-Reply-To: <w7g7ibw4j4yipnhjbnjqyoxg5llnwr6t5pfwf4uvjilw63gwuw@mzxtxvdfhwfe>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 1 Jun 2023 16:22:21 +0200
Message-ID: <CABgObfYSH8KFY4RRCkmijJMi1BuCmhi6bKRmbRuejzd=bdhS=g@mail.gmail.com>
Subject: Re: [PATCH 01/12] file-posix: remove incorrect coroutine_fn calls
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Wolf, Kevin" <kwolf@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d36d6f05fd122a49"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000d36d6f05fd122a49
Content-Type: text/plain; charset="UTF-8"

Il gio 1 giu 2023, 15:50 Eric Blake <eblake@redhat.com> ha scritto:

> > @@ -2696,7 +2696,7 @@ static int coroutine_fn
> raw_co_truncate(BlockDriverState *bs, int64_t offset,
> >      }
> >
> >      if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
> > -        int64_t cur_length = raw_co_getlength(bs);
> > +        int64_t cur_length = raw_getlength(bs);
>
> Shouldn't this one still call the raw_co_getlength() wrapper?
>

It could, but instead I wanted to clarify that this will never suspend
(because it's calling the function directly rather than bdrv_co_getlength).

Paolo


> > @@ -3245,7 +3250,7 @@ static int coroutine_fn
> raw_co_block_status(BlockDriverState *bs,
> >           * round up if necessary.
> >           */
> >          if (!QEMU_IS_ALIGNED(*pnum, bs->bl.request_alignment)) {
> > -            int64_t file_length = raw_co_getlength(bs);
> > +            int64_t file_length = raw_getlength(bs);
>
> Likewise this one?
>
> >
> >  static bool coroutine_fn cdrom_co_is_inserted(BlockDriverState *bs)
> >  {
> > -    return raw_co_getlength(bs) > 0;
> > +    return raw_getlength(bs) > 0;
> >  }
>
> and this one?
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
>

--000000000000d36d6f05fd122a49
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 1 giu 2023, 15:50 Eric Blake &lt;<a href=3D"mai=
lto:eblake@redhat.com">eblake@redhat.com</a>&gt; ha scritto:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">&gt; @@ -2696,7 +2696,7 @@ static int coroutine_f=
n raw_co_truncate(BlockDriverState *bs, int64_t offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t cur_length =3D raw_co_getlength(b=
s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t cur_length =3D raw_getlength(bs);=
<br>
<br>
Shouldn&#39;t this one still call the raw_co_getlength() wrapper?<br></bloc=
kquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It could, =
but instead I wanted to clarify that this will never suspend (because it&#3=
9;s calling the function directly rather than bdrv_co_getlength).</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
&gt; @@ -3245,7 +3250,7 @@ static int coroutine_fn raw_co_block_status(Bloc=
kDriverState *bs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* round up if necessary.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!QEMU_IS_ALIGNED(*pnum, bs-&gt;b=
l.request_alignment)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t file_length =3D raw=
_co_getlength(bs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t file_length =3D raw=
_getlength(bs);<br>
<br>
Likewise this one?<br>
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static bool coroutine_fn cdrom_co_is_inserted(BlockDriverState *=
bs)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 return raw_co_getlength(bs) &gt; 0;<br>
&gt; +=C2=A0 =C2=A0 return raw_getlength(bs) &gt; 0;<br>
&gt;=C2=A0 }<br>
<br>
and this one?<br>
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+1-919-301-3266<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer norefer=
rer" target=3D"_blank">qemu.org</a> | <a href=3D"http://libvirt.org" rel=3D=
"noreferrer noreferrer" target=3D"_blank">libvirt.org</a><br>
<br>
</blockquote></div></div></div>

--000000000000d36d6f05fd122a49--


