Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C987D13F9
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 18:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtsLD-0000P3-DM; Fri, 20 Oct 2023 12:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtsLB-0000Og-Vh
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:27:14 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtsL9-0007rN-Jp
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:27:13 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so1533717a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697819229; x=1698424029; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OTV8XYLdcVNKH5FLoYvzobLiYCjo+VJHtno0MlKMTS8=;
 b=pC/WQkZ1MVFg5Y1Nqx7VVJ5ouyNQ7Bw/sIiKxySjsNzWM1cNim/0KdyvTKp2onYKlb
 MraT7XG3R9cNwOYzni5oYXzNfufduP5ZwwY/mzRDBAi9hZKdqAQp9iBHQbvsQMiWaBEK
 zRKjEFALrPa2zyab/SAV8jZ9eoPvPAmj4EoQKatPzNXFBemaW+IYc+YvUOD4ReEaEZjF
 GrTxQfDWPCL3VM/kcMtEQoxOSVR+3ScbA9ljSYg7CFhdhzC3N7KXtr9U+IFvaibU5SfZ
 3o5COxZfBMpHnYr879SYpUnxS4cHIMdAI1Bihwy8fZwxZWyFVSm6R4yvEiqCQnXydd5L
 V2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697819229; x=1698424029;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OTV8XYLdcVNKH5FLoYvzobLiYCjo+VJHtno0MlKMTS8=;
 b=N0uUB6I5lf8skuiBt6oUJuwPePUotMNqWm1wDG0w4shWnAkL0EAajvl9G+3DGf72Nw
 kU5FFfcNh116TZXxzhntJC4CzpsHOIl+UFUCfGszmaXKgQFGyDgMTXcwG9Etbg4x8g2X
 wda/iiJOip9PmQJGQW4AJmLes1zWfU0EeTQe2OeKLJlAZMWI51qh9VkAj6EMclFbavSW
 l3i3ZYMoleYb3LM5rmTqx04UqQbg16oxLcDxTeA5ba8EigIbc+pBGF1K5zu3myVKGJh8
 fYdO5tOLLdtKh2GPOZDjMNewhhyt7giTyWfR9u4KoSUuHLcGP4rgDq7OX5pVeE0L0eP5
 nUzw==
X-Gm-Message-State: AOJu0Yx2iYqPz0NK3q76m+pC2rk4zErYC/NPGw5izXA7PVI/kzZtMiYT
 MsLIqeRyLhdhHOn/DyaLo6Zw/eOTdS/WBfT8sX3qaA==
X-Google-Smtp-Source: AGHT+IExV2+QZKs5QQSsruPBY4I1AE1eEUoZaVyjIReec7OVd/j38pbgKN7mJQr8sRyJKynFGCLtlvJShUMQuIaqYSU=
X-Received: by 2002:a17:906:4fca:b0:9bf:9f04:e63b with SMTP id
 i10-20020a1709064fca00b009bf9f04e63bmr2048188ejw.23.1697819229280; Fri, 20
 Oct 2023 09:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <87mswd6zi5.fsf@linaro.org>
In-Reply-To: <87mswd6zi5.fsf@linaro.org>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Fri, 20 Oct 2023 17:26:57 +0100
Message-ID: <CAHDbmO3U0B1aam8G6TB0sjVu0iSbGX9yy2JMeGF7bPsFEZNfNA@mail.gmail.com>
Subject: Re: alpha toolchain broken for static builds in bookworm?
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Matthias Klose <doko@debian.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, debian-alpha@lists.debian.org
Content-Type: multipart/alternative; boundary="0000000000000dfacd0608285827"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000000dfacd0608285827
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ahh I was looking in the wrong place - glibc-sources shows the fix
in 2.36-9+deb12u1:

glibc (2.36-9+deb12u1) bookworm; urgency=3Dmedium

  [ Aurelien Jarno ]
  * debian/patches/git-updates.diff: update from upstream stable branch:
    - Affecting bookworm release architectures:
      - Improve mcount overflow handling in gmon.
      - Fix a buffer overflow in gmon (CVE-2023-0687).
      - Fix a memory corruption when incorrectly calling gmon functions
        repeatedly on in wrong order.
      - Fix a deadlock in getaddrinfo (__check_pf) with deferred
cancellation.
      - Fix y2038 support in strftime on 32-bit architectures.
      - Fix corner case parsing of /etc/gshadow which can return bad
pointers
        causing segfaults in applications.
      - Fix a deadlock in system() when called concurrently from multiple
        threads.
      - cdefs: limit definition of fortification macros to __FORTIFY_LEVEL
> 0
        to support old C90 compilers.
    - Not affecting bookworm release architectures:
      - Fix LFS POSIX lock constants for powerpc64.
      - Fix GL(dl_phdr) and GL(dl_phnum) for static builds.  Closes:
#1028200.
    - Not affecting debian architectures:
      - Fix LFS POSIX lock constants on 32 bit arch with 64 bit default
        time_t.
    - No change in the generated code:
      - Fix asm constraints in amd64 version of feraiseexcept (bug not
visible
        with GCC 12).

So I guess we just need a rebuild of the later glibc for the alpha cross
compiler?

On Fri, 20 Oct 2023 at 17:16, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:

> Hi,
>
> While updating QEMU's debian-all-test-cross docker image to bookworm I
> found "check-tcg" broke for alpha. The docker image is essentially a
> slim debian image with minimal qemu build deps and all the cross
> compilers Debian packages that support a QEMU guest.
>
> Digging into the failure it was pretty early on in start-up code:
>
>   (gdb) x/5i $pc
>   =3D> 0x12003e370 <__ctype_init+48>:       ldq     t0,0(t0)
>      0x12003e374 <__ctype_init+52>:       ldq     t4,56(t0)
>      0x12003e378 <__ctype_init+56>:       ldq     t2,64(t0)
>      0x12003e37c <__ctype_init+60>:       ldq     t0,80(t0)
>      0x12003e380 <__ctype_init+64>:       lda     t4,256(t4)
>   (gdb) p/x $t0
>   $1 =3D 0x0
>
> which looks like TLS is very broken on static builds. Chatting with
> Peter and Adhemerval pointed me to:
>
>   https://lists.debian.org/debian-alpha/2023/01/msg00020.html
>
> which has been merged into glibc. However I can't work out if its in the
> bookwork packages. I suspect not because I ran a test where I bumped
> debian-all-test-cross to trixie (which ships 2.37-3cross1) and alpha
> passes check-tcg. However I'm not sure how to navigate the
> cross-toolchain-base-ports-62 to work out if the fix is in. The upstream
> doesn't have any stable release tags beyond glibc-2.36.
>
> In the release/2.36/master branch the fix is:
>
>   d5aaece8a3 elf: Fix GL(dl_phdr) and GL(dl_phnum) for static builds [BZ
> #29864]
>
> So to summarise:
>
>   - what does Debian's 2.36-8cross1 map to on the release branch?
>   - if it doesn't include the above commit can we get a newer release
>     with a fix?
>
> Thanks,
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>


--=20
Alex Benn=C3=A9e
Emulation and Virtualisation Tech Lead @ Linaro

--0000000000000dfacd0608285827
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Ahh I was looking in the wrong place - glibc-sources =
shows the fix in=C2=A02.36-9+deb12u1:</div><div><br></div><div></div><div>g=
libc (2.36-9+deb12u1) bookworm; urgency=3Dmedium<br><br>=C2=A0 [ Aurelien J=
arno ]<br>=C2=A0 * debian/patches/git-updates.diff: update from upstream st=
able branch:<br>=C2=A0 =C2=A0 - Affecting bookworm release architectures:<b=
r>=C2=A0 =C2=A0 =C2=A0 - Improve mcount overflow handling in gmon.<br>=C2=
=A0 =C2=A0 =C2=A0 - Fix a buffer overflow in gmon (CVE-2023-0687).<br>=C2=
=A0 =C2=A0 =C2=A0 - Fix a memory corruption when incorrectly calling gmon f=
unctions<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 repeatedly on in wrong order.<br>=
=C2=A0 =C2=A0 =C2=A0 - Fix a deadlock in getaddrinfo (__check_pf) with defe=
rred cancellation.<br>=C2=A0 =C2=A0 =C2=A0 - Fix y2038 support in strftime =
on 32-bit architectures.<br>=C2=A0 =C2=A0 =C2=A0 - Fix corner case parsing =
of /etc/gshadow which can return bad pointers<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 causing segfaults in applications.<br>=C2=A0 =C2=A0 =C2=A0 - Fix a dead=
lock in system() when called concurrently from multiple<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 threads.<br>=C2=A0 =C2=A0 =C2=A0 - cdefs: limit definition of=
 fortification macros to __FORTIFY_LEVEL &gt; 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 to support old C90 compilers.<br>=C2=A0 =C2=A0 - Not affecting bookworm=
 release architectures:<br>=C2=A0 =C2=A0 =C2=A0 - Fix LFS POSIX lock consta=
nts for powerpc64.<br>=C2=A0 =C2=A0 =C2=A0 - Fix GL(dl_phdr) and GL(dl_phnu=
m) for static builds.=C2=A0 Closes: #1028200.<br>=C2=A0 =C2=A0 - Not affect=
ing debian architectures:<br>=C2=A0 =C2=A0 =C2=A0 - Fix LFS POSIX lock cons=
tants on 32 bit arch with 64 bit default<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 tim=
e_t.<br>=C2=A0 =C2=A0 - No change in the generated code:<br>=C2=A0 =C2=A0 =
=C2=A0 - Fix asm constraints in amd64 version of feraiseexcept (bug not vis=
ible<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 with GCC 12).</div><div><br></div><div>=
So I guess we just need a rebuild of the later glibc for the alpha cross co=
mpiler?<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Fri, 20 Oct 2023 at 17:16, Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
While updating QEMU&#39;s debian-all-test-cross docker image to bookworm I<=
br>
found &quot;check-tcg&quot; broke for alpha. The docker image is essentiall=
y a<br>
slim debian image with minimal qemu build deps and all the cross<br>
compilers Debian packages that support a QEMU guest.<br>
<br>
Digging into the failure it was pretty early on in start-up code:<br>
<br>
=C2=A0 (gdb) x/5i $pc<br>
=C2=A0 =3D&gt; 0x12003e370 &lt;__ctype_init+48&gt;:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0ldq=C2=A0 =C2=A0 =C2=A0t0,0(t0)<br>
=C2=A0 =C2=A0 =C2=A00x12003e374 &lt;__ctype_init+52&gt;:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0ldq=C2=A0 =C2=A0 =C2=A0t4,56(t0)<br>
=C2=A0 =C2=A0 =C2=A00x12003e378 &lt;__ctype_init+56&gt;:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0ldq=C2=A0 =C2=A0 =C2=A0t2,64(t0)<br>
=C2=A0 =C2=A0 =C2=A00x12003e37c &lt;__ctype_init+60&gt;:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0ldq=C2=A0 =C2=A0 =C2=A0t0,80(t0)<br>
=C2=A0 =C2=A0 =C2=A00x12003e380 &lt;__ctype_init+64&gt;:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0lda=C2=A0 =C2=A0 =C2=A0t4,256(t4)<br>
=C2=A0 (gdb) p/x $t0<br>
=C2=A0 $1 =3D 0x0<br>
<br>
which looks like TLS is very broken on static builds. Chatting with<br>
Peter and Adhemerval pointed me to:<br>
<br>
=C2=A0 <a href=3D"https://lists.debian.org/debian-alpha/2023/01/msg00020.ht=
ml" rel=3D"noreferrer" target=3D"_blank">https://lists.debian.org/debian-al=
pha/2023/01/msg00020.html</a><br>
<br>
which has been merged into glibc. However I can&#39;t work out if its in th=
e<br>
bookwork packages. I suspect not because I ran a test where I bumped<br>
debian-all-test-cross to trixie (which ships 2.37-3cross1) and alpha<br>
passes check-tcg. However I&#39;m not sure how to navigate the<br>
cross-toolchain-base-ports-62 to work out if the fix is in. The upstream<br=
>
doesn&#39;t have any stable release tags beyond glibc-2.36.<br>
<br>
In the release/2.36/master branch the fix is:<br>
<br>
=C2=A0 d5aaece8a3 elf: Fix GL(dl_phdr) and GL(dl_phnum) for static builds [=
BZ #29864]<br>
<br>
So to summarise:<br>
<br>
=C2=A0 - what does Debian&#39;s 2.36-8cross1 map to on the release branch?<=
br>
=C2=A0 - if it doesn&#39;t include the above commit can we get a newer rele=
ase<br>
=C2=A0 =C2=A0 with a fix?<br>
<br>
Thanks,<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr">Alex Benn=C3=A9e<br>Emulation and Virtualisation Tech Lead @ Linaro</di=
v></div>

--0000000000000dfacd0608285827--

