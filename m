Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BECB580AADA
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 18:35:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBeje-0006FT-SR; Fri, 08 Dec 2023 12:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1rBejZ-00068M-0w
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 12:33:56 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1rBejX-0003sf-FY
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 12:33:52 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-54744e66d27so63a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 09:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702056827; x=1702661627; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wToyti+9pkrlLVy584lG7SBqjvQA0xI4yh17DSqip9o=;
 b=GSXlkFxYbfD/Fp2cYii2LvLfRGdM9wrwGreNJvsfTnCWVS7whmYXiFRVoJRfx1+N4z
 b+fqlg8V1ENfW80GAEiVYvyeiEaLF1KRp40i3/FWOeFRR4K+GYZv5Mbi7Sd8cNi247Tc
 UMk6S5g9Ag9/R3vNza0Yejk4KT5Xbr9TYJWl6Q3CT/1RiSz5CQxefLz/jcHSOn29jQMi
 TRx29THDTUo61DAS6oZHHnAWfvC4hZ6hB21I/l2OCvZTerr0ESlzKsxh6wXEkBDEWz6w
 BofpjkJHRDatfc5LBx8MUmd9xPqSo2mOC9mNGqXYiPp+mLMLcOEUh9M4eKSDMK7FQbZh
 /wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702056827; x=1702661627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wToyti+9pkrlLVy584lG7SBqjvQA0xI4yh17DSqip9o=;
 b=v1L5t2+wn5jMFd6PdeIZ5/z1mr7zdb/xumyfQNd409g41FQjCtz9+ROwaXlnSNX6jl
 jg5P3twiyhTR3DVheG/b8/WqxIxULvY8Q00bIBPsLmO8VeHJEBoYwdhucCTTTtbm766i
 ue6yuvY9kBgmvjrpABeF5rRSM/Qzb5lh+I0Wan4qqOH0vx+Ih6w7fiibToAWD1OK/jJH
 I6h0AkaQCYROtlbdgAeTRKleSiHnNk2Se0Sl2ob5V6XBmpY/zFHgzUWdBc9wUB5dD5yF
 ue8LX5SoeoEYdaK7HZ1+6r9Nifq2xmPRNyK5yen1iMR3Nlabs3uRoX4z0CdCBRFQsqbS
 qZkg==
X-Gm-Message-State: AOJu0YyxDuwdd8Qlne2aJHmrhCHUoYESqXXMiplmCoDTOo/TbbYDAMJc
 PiYG8pYNbPytRMT2TVKAkY14+b7dfTa7ziW0b2YIGQ==
X-Google-Smtp-Source: AGHT+IE39TQwhOwV9V+F93201xyHFRqwophfGljv9V49Lej9ZqNGJKFcr32NX2XqxOJra46Zv8Be56be+SL8GFRW4Bc=
X-Received: by 2002:a50:c311:0:b0:54c:794b:875b with SMTP id
 a17-20020a50c311000000b0054c794b875bmr79518edb.1.1702056827166; Fri, 08 Dec
 2023 09:33:47 -0800 (PST)
MIME-Version: 1.0
References: <CAHdnXhDZMgAKZyhucJ8QsFJHiO5xqdQq9zVn5X2SSL0-Q12-Jg@mail.gmail.com>
In-Reply-To: <CAHdnXhDZMgAKZyhucJ8QsFJHiO5xqdQq9zVn5X2SSL0-Q12-Jg@mail.gmail.com>
From: Patrick Venture <venture@google.com>
Date: Fri, 8 Dec 2023 09:33:34 -0800
Message-ID: <CAO=notyfoWHWDRBkdMY45_oiifX+t+9hyJfvaMhrAii3yJ7X-g@mail.gmail.com>
Subject: Re: udp guestfwd
To: Louai Al-Khanji <louai.khanji@gmail.com>, Felix Wu <flwu@google.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000929eeb060c02fcf9"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=venture@google.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000929eeb060c02fcf9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 11:44=E2=80=AFPM Louai Al-Khanji <louai.khanji@gmai=
l.com>
wrote:

> Hi,
>
> I'm interested in having the guestfwd option work for udp. My
> understanding is that currently it's restricted to only tcp.
>
> I'm not familiar with libslirp internals. What would need to be changed t=
o
> implement this? I'm potentially interested in doing the work.
>
> I did a tiny amount of digging around libslirp and saw this comment in
> `udp.c':
>
>         /*
>          * XXXXX Here, check if it's in udpexec_list,
>          * and if it is, do the fork_exec() etc.
>          */
>
> I wonder whether that is related. In any case any help is much appreciate=
d.
>

Felix has been working in this space and it may take time to get the CLs
landed in libslirp and qemu.

Patrick

>
> Thanks,
> Louai Al-Khanji
>

--000000000000929eeb060c02fcf9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Fri, Oct 27, 2023 at 11:44=E2=80=AFPM Louai Al-Khanji &lt;<a =
href=3D"mailto:louai.khanji@gmail.com">louai.khanji@gmail.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"lt=
r">Hi,<div><br></div><div>I&#39;m interested in having the guestfwd option =
work for udp. My understanding is that currently it&#39;s restricted to onl=
y tcp.</div><div><br></div><div>I&#39;m not familiar with libslirp=C2=A0int=
ernals. What would need to be changed to implement this? I&#39;m potentiall=
y interested in doing the work.</div><div><br></div><div>I did a tiny amoun=
t of digging around libslirp and saw this comment in `udp.c&#39;:<br clear=
=3D"all"><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0* XXXXX Here, check if it&#39;s in udpexec_list,<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* and if it is, do the fork_exec() etc.<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br></div><div><br></div><div>I wond=
er whether that is related. In any case any help is much appreciated.</div>=
</div></div></blockquote><div><br></div><div dir=3D"ltr">Felix has been wor=
king=C2=A0in this space and it may take time to get the=C2=A0CLs landed in =
libslirp and qemu.<div><br></div></div><div>Patrick=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><div><br></div>=
<span class=3D"gmail_signature_prefix">Thanks,</span><br><div dir=3D"ltr" c=
lass=3D"gmail_signature">Louai Al-Khanji<br></div></div></div>
</blockquote></div></div>

--000000000000929eeb060c02fcf9--

