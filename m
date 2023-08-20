Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBFB781C67
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:41:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXaFT-0006h3-Dt; Sun, 20 Aug 2023 00:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaFM-0006dr-0Y
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:41:05 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaFI-0002BT-Pg
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:41:03 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99c47ef365cso297069566b.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692506459; x=1693111259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2e6lNMYP2BsQA2MnxhvcZyBeNMLq/co4TC5yusmxTSY=;
 b=OYt+s2Y6IIH09LlmLDGuCPq2clMXRkklzDvBqTPAUorTsQdcFqSMYS8+horWZZ7jTJ
 avOrxoX4i6aprbtSt1WzqujZjfm+iFlJG8YncP6PmM+NUxY0iJGx6ZeyKV3oso+IIj6P
 hc0zVzvY68Yc5sxXqDH1ZAqQkfZ0qmyF1eC3ZtbxtzdFb9MgaFKPEzz0aetri1O90uAs
 NyUCSsL6QFOD0Us2d3EQ6p83oAxF5OTKjdTPoHcxHXSV9EV8E/jIt4tq8mgQI3r/ARFo
 4mglP/MrwumJbuj4+t+uVS5G1ucJWLptjf82a3GI4HPGHvvIzunULIz0CE5PjoCF4rsR
 Lrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692506459; x=1693111259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2e6lNMYP2BsQA2MnxhvcZyBeNMLq/co4TC5yusmxTSY=;
 b=WDzXaEm0YBrl8qLuOPicSZ8FEQFkFd7sgBd82vTzTGbJsakkaXDpMePsv2j5U5xi2P
 7Q/4DuVwxHy2h70JGa5Hmuckl5n2o07mJzDj7pV6/wjomPRZkCF+6rwN9Kcb2Rx5EyXc
 Dx8LJRx0s+b+N+aiX+2FqmCoPvQiPmvZaWhRcdZenpPoU7LRWRWPc2Xher2FRxmqK9RG
 G8epECJuLn3ZocYV90reIMvTnGpxF5CnHkNpQ2DVVXGUczaq+/hJlgjx5PaIjackuz/u
 Wd9pBM8Jw+EZZQmhnPBngKaNgmlttqUleHTrv3VTikZGTX2tZKHV/rcv3gHY7d1gA4qx
 DWgQ==
X-Gm-Message-State: AOJu0Yx/gRv1PnWMUtl9nCrQ/4GQY4qrQztdrkoD34kEGYjliYiL6sQJ
 uJBq6E4ENyGhx9s0CqFXgxc/OVKORAB6Od4EDV1vVA==
X-Google-Smtp-Source: AGHT+IGNjQY44mfRNiIzmECM5mzG6heN5aif610qHkE2kTcUuPDzcbGKJe+FlFDBmeajOEC1ALN3BUVyoQ9GaSYKnic=
X-Received: by 2002:a17:907:2cea:b0:997:bb66:3ce with SMTP id
 hz10-20020a1709072cea00b00997bb6603cemr2543098ejc.7.1692506458889; Sat, 19
 Aug 2023 21:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-18-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-18-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:40:51 -0600
Message-ID: <CANCZdfpgdCbnwgHxokDD4jVKHAEoVS+4aY80KwNZdAp7qYxMfA@mail.gmail.com>
Subject: Re: [PATCH 17/22] Implement do_obreak function
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>, 
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000432f1c0603535ed8"
Received-SPF: none client-ip=2a00:1450:4864:20::62c;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62c.google.com
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

--000000000000432f1c0603535ed8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:49=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Co-authored-by: Mika=C3=ABl Urankar <mikael.urankar@gmail.com>
>
> Signed-off-by: Mika=C3=ABl Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-mem.h            | 85 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  7 +++
>  2 files changed, 92 insertions(+)
>

emacs works with this, iirc, and it's super picky about brk being
pedantically correct.
This also doesn't match current linux-user. Perhaps the caution it uses is
no longer
needed? I think it's another area we should invite the linux-user
maintainers to
comment.

Warner



> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> index edbccd3111..6f33148eb7 100644
> --- a/bsd-user/bsd-mem.h
> +++ b/bsd-user/bsd-mem.h
> @@ -167,4 +167,89 @@ static inline abi_long do_bsd_mincore(abi_ulong
> target_addr, abi_ulong len,
>      return ret;
>  }
>
> +#ifdef DO_DEBUG
> +#define DEBUGF_BRK(message, args...) \
> +    do { fprintf(stderr, (message), ## args); } while (0)
> +#else
> +#define DEBUGF_BRK(message, args...)
> +#endif
> +
> +/* do_brk() must return target values and target errnos. */
> +static inline abi_long do_obreak(abi_ulong new_brk)
> +{
> +    abi_long mapped_addr;
> +    int new_alloc_size;
> +
> +    DEBUGF_BRK("do_brk(" TARGET_ABI_FMT_lx ") -> ", new_brk);
> +
> +    if (!new_brk) {
> +        DEBUGF_BRK(TARGET_ABI_FMT_lx " (!new_brk)\n", bsd_target_brk);
> +        return bsd_target_brk;
> +    }
> +    if (new_brk < bsd_target_original_brk) {
> +        DEBUGF_BRK(TARGET_ABI_FMT_lx " (new_brk <
> bsd_target_original_brk)\n",
> +                   bsd_target_brk);
> +        return bsd_target_brk;
> +    }
> +
> +    /*
> +     * If the new brk is less than the highest page reserved to the
> target heap
> +     * allocation, set it and we're almost done...
> +     */
> +    if (new_brk <=3D brk_page) {
> +        /*
> +         * Heap contents are initialized to zero, as for anonymous mappe=
d
> pages.
> +         */
> +        if (new_brk > bsd_target_brk) {
> +            memset(g2h_untagged(bsd_target_brk), 0, new_brk -
> bsd_target_brk);
> +        }
> +        bsd_target_brk =3D new_brk;
> +        DEBUGF_BRK(TARGET_ABI_FMT_lx " (new_brk <=3D brk_page)\n",
> +                   bsd_target_brk);
> +        return bsd_target_brk;
> +    }
> +
> +    /*
> +     * We need to allocate more memory after the brk... Note that we
> don't use
> +     * MAP_FIXED because that will map over the top of any existing
> mapping
> +     * (like the one with the host libc or qemu itself); instead we trea=
t
> +     * "mapped but at wrong address" as a failure and unmap again.
> +     */
> +    new_alloc_size =3D HOST_PAGE_ALIGN(new_brk - brk_page);
> +    mapped_addr =3D get_errno(target_mmap(brk_page, new_alloc_size,
> +                                        PROT_READ | PROT_WRITE,
> +                                        MAP_ANON | MAP_PRIVATE, -1, 0));
> +
> +    if (mapped_addr =3D=3D brk_page) {
> +        /*
> +         * Heap contents are initialized to zero, as for anonymous mappe=
d
> pages.
> +         * Technically the new pages are already initialized to zero
> since they
> +         * *are* anonymous mapped pages, however we have to take care
> with the
> +         * contents that come from the remaining part of the previous
> page: it
> +         * may contains garbage data due to a previous heap usage (grown
> then
> +         * shrunken).
> +         */
> +        memset(g2h_untagged(bsd_target_brk), 0, brk_page -
> bsd_target_brk);
> +
> +        bsd_target_brk =3D new_brk;
> +        brk_page =3D HOST_PAGE_ALIGN(bsd_target_brk);
> +        DEBUGF_BRK(TARGET_ABI_FMT_lx " (mapped_addr =3D=3D brk_page)\n",
> +            bsd_target_brk);
> +        return bsd_target_brk;
> +    } else if (mapped_addr !=3D -1) {
> +        /*
> +         * Mapped but at wrong address, meaning there wasn't actually
> enough
> +         * space for this brk.
> +         */
> +        target_munmap(mapped_addr, new_alloc_size);
> +        mapped_addr =3D -1;
> +        DEBUGF_BRK(TARGET_ABI_FMT_lx " (mapped_addr !=3D -1)\n",
> bsd_target_brk);
> +    } else {
> +        DEBUGF_BRK(TARGET_ABI_FMT_lx " (otherwise)\n", bsd_target_brk);
> +    }
> +
> +    /* For everything else, return the previous break. */
> +    return bsd_target_brk;
> +}
> +
>  #endif /* BSD_USER_BSD_MEM_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.=
c
> index 1db0907504..1b9dca9164 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -543,6 +543,13 @@ static abi_long freebsd_syscall(void *cpu_env, int
> num, abi_long arg1,
>          break;
>  #endif
>
> +        /*
> +         * Misc
> +         */
> +    case TARGET_FREEBSD_NR_break:
> +        ret =3D do_obreak(arg1);
> +        break;
> +
>          /*
>           * sys{ctl, arch, call}
>           */
> --
> 2.40.0
>
>

--000000000000432f1c0603535ed8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 3:49=E2=80=AF=
AM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Co-authored-by: Mika=C3=ABl Urankar &lt;<a href=3D"mailto:mikael.urankar@gm=
ail.com" target=3D"_blank">mikael.urankar@gmail.com</a>&gt;<br>
<br>
Signed-off-by: Mika=C3=ABl Urankar &lt;<a href=3D"mailto:mikael.urankar@gma=
il.com" target=3D"_blank">mikael.urankar@gmail.com</a>&gt;<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 85 ++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 7 +++<br>
=C2=A02 files changed, 92 insertions(+)<br></blockquote><div><br></div><div=
>emacs works with this, iirc, and it&#39;s super picky about brk being peda=
ntically correct.</div><div>This also doesn&#39;t match current linux-user.=
 Perhaps the caution it uses is no longer</div><div>needed? I think it&#39;=
s another area we should invite the linux-user maintainers to</div><div>com=
ment.</div><div><br></div><div>Warner<br></div><div><br></div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h<br>
index edbccd3111..6f33148eb7 100644<br>
--- a/bsd-user/bsd-mem.h<br>
+++ b/bsd-user/bsd-mem.h<br>
@@ -167,4 +167,89 @@ static inline abi_long do_bsd_mincore(abi_ulong target=
_addr, abi_ulong len,<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+#ifdef DO_DEBUG<br>
+#define DEBUGF_BRK(message, args...) \<br>
+=C2=A0 =C2=A0 do { fprintf(stderr, (message), ## args); } while (0)<br>
+#else<br>
+#define DEBUGF_BRK(message, args...)<br>
+#endif<br>
+<br>
+/* do_brk() must return target values and target errnos. */<br>
+static inline abi_long do_obreak(abi_ulong new_brk)<br>
+{<br>
+=C2=A0 =C2=A0 abi_long mapped_addr;<br>
+=C2=A0 =C2=A0 int new_alloc_size;<br>
+<br>
+=C2=A0 =C2=A0 DEBUGF_BRK(&quot;do_brk(&quot; TARGET_ABI_FMT_lx &quot;) -&g=
t; &quot;, new_brk);<br>
+<br>
+=C2=A0 =C2=A0 if (!new_brk) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEBUGF_BRK(TARGET_ABI_FMT_lx &quot; (!new_brk)=
\n&quot;, bsd_target_brk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return bsd_target_brk;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (new_brk &lt; bsd_target_original_brk) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEBUGF_BRK(TARGET_ABI_FMT_lx &quot; (new_brk &=
lt; bsd_target_original_brk)\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bsd_t=
arget_brk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return bsd_target_brk;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* If the new brk is less than the highest page reserve=
d to the target heap<br>
+=C2=A0 =C2=A0 =C2=A0* allocation, set it and we&#39;re almost done...<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (new_brk &lt;=3D brk_page) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Heap contents are initialized to zero,=
 as for anonymous mapped pages.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (new_brk &gt; bsd_target_brk) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(g2h_untagged(bsd_target_b=
rk), 0, new_brk - bsd_target_brk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bsd_target_brk =3D new_brk;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEBUGF_BRK(TARGET_ABI_FMT_lx &quot; (new_brk &=
lt;=3D brk_page)\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bsd_t=
arget_brk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return bsd_target_brk;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* We need to allocate more memory after the brk... Not=
e that we don&#39;t use<br>
+=C2=A0 =C2=A0 =C2=A0* MAP_FIXED because that will map over the top of any =
existing mapping<br>
+=C2=A0 =C2=A0 =C2=A0* (like the one with the host libc or qemu itself); in=
stead we treat<br>
+=C2=A0 =C2=A0 =C2=A0* &quot;mapped but at wrong address&quot; as a failure=
 and unmap again.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 new_alloc_size =3D HOST_PAGE_ALIGN(new_brk - brk_page);<br>
+=C2=A0 =C2=A0 mapped_addr =3D get_errno(target_mmap(brk_page, new_alloc_si=
ze,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PROT_REA=
D | PROT_WRITE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MAP_ANON=
 | MAP_PRIVATE, -1, 0));<br>
+<br>
+=C2=A0 =C2=A0 if (mapped_addr =3D=3D brk_page) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Heap contents are initialized to zero,=
 as for anonymous mapped pages.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Technically the new pages are already =
initialized to zero since they<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* *are* anonymous mapped pages, however =
we have to take care with the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* contents that come from the remaining =
part of the previous page: it<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* may contains garbage data due to a pre=
vious heap usage (grown then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* shrunken).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(g2h_untagged(bsd_target_brk), 0, brk_pa=
ge - bsd_target_brk);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bsd_target_brk =3D new_brk;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 brk_page =3D HOST_PAGE_ALIGN(bsd_target_brk);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEBUGF_BRK(TARGET_ABI_FMT_lx &quot; (mapped_ad=
dr =3D=3D brk_page)\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bsd_target_brk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return bsd_target_brk;<br>
+=C2=A0 =C2=A0 } else if (mapped_addr !=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Mapped but at wrong address, meaning t=
here wasn&#39;t actually enough<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* space for this brk.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_munmap(mapped_addr, new_alloc_size);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mapped_addr =3D -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEBUGF_BRK(TARGET_ABI_FMT_lx &quot; (mapped_ad=
dr !=3D -1)\n&quot;, bsd_target_brk);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEBUGF_BRK(TARGET_ABI_FMT_lx &quot; (otherwise=
)\n&quot;, bsd_target_brk);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* For everything else, return the previous break. */<br>
+=C2=A0 =C2=A0 return bsd_target_brk;<br>
+}<br>
+<br>
=C2=A0#endif /* BSD_USER_BSD_MEM_H */<br>
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c<=
br>
index 1db0907504..1b9dca9164 100644<br>
--- a/bsd-user/freebsd/os-syscall.c<br>
+++ b/bsd-user/freebsd/os-syscall.c<br>
@@ -543,6 +543,13 @@ static abi_long freebsd_syscall(void *cpu_env, int num=
, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0#endif<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Misc<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 case TARGET_FREEBSD_NR_break:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D do_obreak(arg1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * sys{ctl, arch, call}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div></div>

--000000000000432f1c0603535ed8--

