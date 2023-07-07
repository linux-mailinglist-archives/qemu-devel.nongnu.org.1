Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F32974B962
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 00:09:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHtdX-0002yo-Rl; Fri, 07 Jul 2023 18:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qHtdW-0002yS-8p
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 18:09:10 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qHtdU-0007Bm-D4
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 18:09:10 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4fb7b2e3dacso3924816e87.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 15:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1688767746; x=1691359746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nR7uxMMW4KbH8k1MPL/M11QvIItuTYkR4BgH/eWnK2U=;
 b=mck4xwVZp2ImIOi7jjb35zN8wSa+y7YO+M8cPq7+QQ61VCm84SWp3vichiqhtBczwd
 EmvRN3TltTI6V/SM1PEXrXynXI8RIsulyC0yMhFmHNXd2tUHxwwFTVtQ52eitOFlEDr2
 21djXqOs/dgtD32uSvHr8QVGNrpZBvG7W0NMyvYVlVSW7rUee2zTbr4CPB7VKokMU8nH
 0yWqaMvfSZi0HV9c7qpA5YPdhGtpdqGtOpJLTi413I3z4IB2ZProZW+nD+o8hN6TjVeJ
 Qjj1BhtnhluhfvB1Ev/H4jxNiGgcgiuzUzqIE/pTkVkO6e7tKM9oK0XIMwoZK8l/2FuG
 9aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688767746; x=1691359746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nR7uxMMW4KbH8k1MPL/M11QvIItuTYkR4BgH/eWnK2U=;
 b=JFUD3PlK8H4wGUNC+UkmIUDIdQzHGyvkPgYQIP5CUQvMsUEshyxnYF1g3yabLm6crT
 YR6dgPKOEs6cWXpnqEnpFoN4B5QTZNKBlidE53wTSbLJp09bn2UUQQ09AnxmWmfZaBbs
 le/MtTUkJYYRbFL2slMX9Y5mptfu5HZIgOpUvGDmq9r6nTXWnDkeJOTsulU7OrsXxHu1
 4gwO4r2wJJL74rzB+TNx3uvpHKN93eFf0jmS1hvAN8paO8lePjmL9kM2XjFX19Q47fMx
 BLFygxx/o3bYR7yuuhpDNkxZ/8Lvw02TqYqRvt2SM1JsiLZLadijeMYSc0lnMTRC90WQ
 LvYw==
X-Gm-Message-State: ABy/qLbLphiIJ6bjvJLB0BVcgk/r2IwEt5OyvpPUgifN57tm3dFGs0mQ
 CwgVChmrpqM6biUfaMQSgKBRrR+NDNWsBtRqhSGaNw==
X-Google-Smtp-Source: APBJJlHlNLijTgMvqE6YW1or1LPJAxdV4BhZX2kpo84sQ0SzdUCv90jr1gz9695DbNgDllSf6bK84rEXjkL+OTpJVgU=
X-Received: by 2002:a05:6512:3b20:b0:4fb:8a0a:31f2 with SMTP id
 f32-20020a0565123b2000b004fb8a0a31f2mr5648115lfv.69.1688767746490; Fri, 07
 Jul 2023 15:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230707204054.8792-1-richard.henderson@linaro.org>
 <20230707204054.8792-18-richard.henderson@linaro.org>
In-Reply-To: <20230707204054.8792-18-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 7 Jul 2023 16:09:00 -0600
Message-ID: <CANCZdfpCTrE+vT_b66=2iN5bm6r2z1Lu+Hyh7CEEtSq8nmUT3A@mail.gmail.com>
Subject: Re: [PATCH v2 15/24] bsd-user: Use page_find_range_empty for
 mmap_find_vma_reserved
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, mjt@tls.msk.ru, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000a3620905ffece108"
Received-SPF: none client-ip=2a00:1450:4864:20::12c;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x12c.google.com
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

--000000000000a3620905ffece108
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 7, 2023 at 2:41=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Use the interval tree to find empty space, rather than
> probing each page in turn.
>
> Cc: Warner Losh <imp@bsdimp.com>
> Cc: Kyle Evans <kevans@freebsd.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-bt: Warner Losh <imp@bsdimp.com>

I tested the prior version (with a different, but equivalent change) and it
seemed to work where
things had been broken previously.

Warner


> ---
>  bsd-user/mmap.c | 48 +++++++-----------------------------------------
>  1 file changed, 7 insertions(+), 41 deletions(-)
>
> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index 07b5b8055e..aca8764356 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -222,50 +222,16 @@ unsigned long last_brk;
>  static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
>                                          abi_ulong alignment)
>  {
> -    abi_ulong addr;
> -    abi_ulong end_addr;
> -    int prot;
> -    int looped =3D 0;
> +    abi_ulong ret;
>
> -    if (size > reserved_va) {
> -        return (abi_ulong)-1;
> +    ret =3D page_find_range_empty(start, reserved_va, size, alignment);
> +    if (ret =3D=3D -1 && start > TARGET_PAGE_SIZE) {
> +        /* Restart at the beginning of the address space. */
> +        ret =3D page_find_range_empty(TARGET_PAGE_SIZE, start - 1,
> +                                    size, alignment);
>      }
>
> -    size =3D HOST_PAGE_ALIGN(size) + alignment;
> -    end_addr =3D start + size;
> -    if (end_addr > reserved_va) {
> -        end_addr =3D reserved_va + 1;
> -    }
> -    addr =3D end_addr - qemu_host_page_size;
> -
> -    while (1) {
> -        if (addr > end_addr) {
> -            if (looped) {
> -                return (abi_ulong)-1;
> -            }
> -            end_addr =3D reserved_va + 1;
> -            addr =3D end_addr - qemu_host_page_size;
> -            looped =3D 1;
> -            continue;
> -        }
> -        prot =3D page_get_flags(addr);
> -        if (prot) {
> -            end_addr =3D addr;
> -        }
> -        if (end_addr - addr >=3D size) {
> -            break;
> -        }
> -        addr -=3D qemu_host_page_size;
> -    }
> -
> -    if (start =3D=3D mmap_next_start) {
> -        mmap_next_start =3D addr;
> -    }
> -    /* addr is sufficiently low to align it up */
> -    if (alignment !=3D 0) {
> -        addr =3D (addr + alignment) & ~(alignment - 1);
> -    }
> -    return addr;
> +    return ret;
>  }
>
>  /*
> --
> 2.34.1
>
>

--000000000000a3620905ffece108
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 7, 2023 at 2:41=E2=80=AFP=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Use the interval tree to find empty space, rather =
than<br>
probing each page in turn.<br>
<br>
Cc: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp=
@bsdimp.com</a>&gt;<br>
Cc: Kyle Evans &lt;<a href=3D"mailto:kevans@freebsd.org" target=3D"_blank">=
kevans@freebsd.org</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></block=
quote><div><br></div><div>Reviewed-bt: Warner Losh &lt;<a href=3D"mailto:im=
p@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>I tested the =
prior version (with a different, but equivalent change) and it seemed to wo=
rk where</div><div>things had been broken previously.</div><div><br></div><=
div>Warner<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
---<br>
=C2=A0bsd-user/mmap.c | 48 +++++++-----------------------------------------=
<br>
=C2=A01 file changed, 7 insertions(+), 41 deletions(-)<br>
<br>
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c<br>
index 07b5b8055e..aca8764356 100644<br>
--- a/bsd-user/mmap.c<br>
+++ b/bsd-user/mmap.c<br>
@@ -222,50 +222,16 @@ unsigned long last_brk;<br>
=C2=A0static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong si=
ze,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ab=
i_ulong alignment)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 abi_ulong addr;<br>
-=C2=A0 =C2=A0 abi_ulong end_addr;<br>
-=C2=A0 =C2=A0 int prot;<br>
-=C2=A0 =C2=A0 int looped =3D 0;<br>
+=C2=A0 =C2=A0 abi_ulong ret;<br>
<br>
-=C2=A0 =C2=A0 if (size &gt; reserved_va) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (abi_ulong)-1;<br>
+=C2=A0 =C2=A0 ret =3D page_find_range_empty(start, reserved_va, size, alig=
nment);<br>
+=C2=A0 =C2=A0 if (ret =3D=3D -1 &amp;&amp; start &gt; TARGET_PAGE_SIZE) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Restart at the beginning of the address spa=
ce. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D page_find_range_empty(TARGET_PAGE_SIZE=
, start - 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size, alignment);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 size =3D HOST_PAGE_ALIGN(size) + alignment;<br>
-=C2=A0 =C2=A0 end_addr =3D start + size;<br>
-=C2=A0 =C2=A0 if (end_addr &gt; reserved_va) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 end_addr =3D reserved_va + 1;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 addr =3D end_addr - qemu_host_page_size;<br>
-<br>
-=C2=A0 =C2=A0 while (1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (addr &gt; end_addr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (looped) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (abi_ulong)=
-1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 end_addr =3D reserved_va + 1;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D end_addr - qemu_host_pa=
ge_size;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 looped =3D 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 prot =3D page_get_flags(addr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prot) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 end_addr =3D addr;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (end_addr - addr &gt;=3D size) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr -=3D qemu_host_page_size;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (start =3D=3D mmap_next_start) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_next_start =3D addr;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 /* addr is sufficiently low to align it up */<br>
-=C2=A0 =C2=A0 if (alignment !=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D (addr + alignment) &amp; ~(alignment =
- 1);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return addr;<br>
+=C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000a3620905ffece108--

