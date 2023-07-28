Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9A97660DE
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 02:45:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPB3f-0006Uv-0O; Thu, 27 Jul 2023 20:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qPB3W-0006UX-8y
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 20:10:06 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qPB3T-0002JS-1Q
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 20:10:06 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51e619bcbf9so1925470a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1690503000; x=1691107800;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EbMGLoTtOycWTftcJPkpwdS2efF7zFtSpuKICJ8KTH4=;
 b=rIc5CMgDujC16FcG7ijTxxRjxF5NVXdGTZzKbtKGZNh9VzkPlGiEMjIfr/tG2Uw6k8
 YWduLfKsl4m49ZFzXgi61ExNqWvKVe12+SHS4lgiVqxPj9nMDkW3IvHgOQI3hR9hYkPy
 apK1GTJ5WZGx17hEWakKZ+grPHPmBhK/nYROsrrx6fXXAls018m+54/cgecddckNyTNn
 nzO1CvInJJM8ObjnlTo2HSWJ5T41+4KHd4VHiect72cZW6VTxkNpTZqrEh0txlFaUMpt
 KhD/t0VlUcinZDpinc8D4wrRBozJQWLtthh7IgLlel41CqHIPr1qJVLvfO35Qu/12Ov9
 leEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690503000; x=1691107800;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EbMGLoTtOycWTftcJPkpwdS2efF7zFtSpuKICJ8KTH4=;
 b=MhWHkmvGIcJGGwhXPZ4QbX7a2DLAwgubFo1jns4+xKPWubymqbQHAXDa2xIzS8jQgV
 IagdxgBPxu1YJdCBJEfMlo6crmMremrsGGDrIHj42DfQMCg1zzP3VsuXfR9PYTRXytUD
 KybSkwX1UMv6iKfmUihIt50avIDlpenzcXehXsoDOTgRe3S9z8DzVgiv7btiMjN0PZLb
 Oemb8uuZfxVboGzD2gSviqhGFLGsqkuLuQvLV65xizxSnU/P7mZKobqrPq79J+nYuyid
 RlRTpsICIMWTyDOz74qpA7jbnp/JWjGzxe4D97tG4aq4rQ3J4y04eZ8jJD9kmI/PWa6w
 Y25w==
X-Gm-Message-State: ABy/qLbfkoxe5sZuEBVtE2FdOt6dKTYjHUL/v087d+VqQyM8dqYNIOce
 lz+MSX4T4fSFPgQePp8VUc4DaK9YpW/9R6PRhzutDQ==
X-Google-Smtp-Source: APBJJlEHgy1e3in4QVIw/2e5Gv8uTacyYEihPWl333KLE2Rk/Jy01BfTbqnPkacjpXvtki00SHnJWAVXmXDcwYropUI=
X-Received: by 2002:aa7:d903:0:b0:522:23e8:2c69 with SMTP id
 a3-20020aa7d903000000b0052223e82c69mr434417edr.27.1690502999820; Thu, 27 Jul
 2023 17:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230727161148.444988-1-richard.henderson@linaro.org>
In-Reply-To: <20230727161148.444988-1-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 27 Jul 2023 18:09:48 -0600
Message-ID: <CANCZdfrLKgVJhXqZ8nJdyoKOsLKscFPYSsZ=w6mSbusn0aX5Ww@mail.gmail.com>
Subject: Re: [PATCH] bsd-user: Properly allocate guest virtual address space
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000cbdbf5060180e63e"
Received-SPF: none client-ip=2a00:1450:4864:20::532;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x532.google.com
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

--000000000000cbdbf5060180e63e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 10:11=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Do not hard-code guest_base at 32GB.
> Do not override mmap_next_start for reserved_va.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> Hi Warner,
>
> With the blitz-trial branch you provided, the host libc allocates
> thread-local storage within the [32GB, 36GB) region that you currently
> assume is free.
>
> The armv7-hello program happens to map on top of this thread-local
> storage, and then we crash later accessing some host TLS variable.
>
> While the linux-user probe_guest_base is significantly more complex,
> we are also trying to handle 32-bit hosts.  I think freebsd is always
> assuming 64-bit hosts, which makes this simpler.
>

Double mapping makes sense for problems to arise. I'd not have thought
this would be the problem, but it does eliminate a bunch of code that I'd
thought suspect (made worse by my trying to 'fix' old kludges with new
kludges of my own).

Yes. FreeBSD's bsd-user binary will only run on 64-bit hosts. The project
has started phasing out support for 32-bit hosts, and the role of bsd-user
(package builder tool) is such that 32-bit hosts don't make sense.

I've tested this out, and it works for me. Any chance we can get this into
8.1 as a bug fix for the last minute breakage of bsd-user (without this and
another patch, the static hello world that used to work broke). I can send
that second patch out for review. I can queue this fix in the mean time for
whenever the tree opens up.

Reviewed by: Warner Losh <imp@bsdimp.com>


>
> r~
> ---
>  bsd-user/main.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index f500ec292b..9760aad9f6 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -50,20 +50,8 @@
>
>  int do_strace;
>
> -/*
> - * Going hand in hand with the va space needed (see below), we need
> - * to find a host address to map the guest to. Assume that qemu
> - * itself doesn't need memory above 32GB (or that we don't collide
> - * with anything interesting). This is selected rather arbitrarily,
> - * but seems to produce good results in tests to date.
> - */
> -# if HOST_LONG_BITS >=3D 64
> -uintptr_t guest_base =3D 0x800000000ul;    /* at 32GB */
> -bool have_guest_base =3D true;
> -#else
> -uintptr_t guest_base;    /* TODO: use sysctl to find big enough hole */
> +uintptr_t guest_base;
>  bool have_guest_base;
> -#endif
>  static bool opt_one_insn_per_tb;
>  static const char *cpu_model;
>  static const char *cpu_type;
> @@ -522,10 +510,6 @@ int main(int argc, char **argv)
>      target_environ =3D envlist_to_environ(envlist, NULL);
>      envlist_free(envlist);
>
> -    if (reserved_va) {
> -        mmap_next_start =3D reserved_va + 1;
> -    }
> -
>      {
>          Error *err =3D NULL;
>          if (seed_optarg !=3D NULL) {
> @@ -543,7 +527,24 @@ int main(int argc, char **argv)
>       * Now that page sizes are configured we can do
>       * proper page alignment for guest_base.
>       */
> -    guest_base =3D HOST_PAGE_ALIGN(guest_base);
> +    if (have_guest_base) {
> +       if (guest_base & ~qemu_host_page_mask) {
> +            error_report("Selected guest base not host page aligned");
> +            exit(1);
> +        }
> +    } else if (reserved_va) {
> +        void *p =3D mmap(NULL, reserved_va + 1, PROT_NONE, MAP_GUARD, -1=
,
> 0);
> +        if (p =3D=3D MAP_FAILED) {
> +            const char *err =3D strerror(errno);
> +            char *sz =3D size_to_str(reserved_va + 1);
> +
> +            error_report("Cannot allocate %s bytes for guest address
> space: %s",
> +                         sz, err);
> +            exit(1);
> +        }
> +        guest_base =3D (uintptr_t)p;
> +        have_guest_base =3D true;
> +    }
>
>      if (loader_exec(filename, argv + optind, target_environ, regs, info,
>                      &bprm) !=3D 0) {
> --
> 2.41.0
>
>

--000000000000cbdbf5060180e63e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 27, 2023 at 10:11=E2=80=
=AFAM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org"=
>richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Do not hard-code guest_base at 32GB.<br>
Do not override mmap_next_start for reserved_va.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
<br>
Hi Warner,<br>
<br>
With the blitz-trial branch you provided, the host libc allocates<br>
thread-local storage within the [32GB, 36GB) region that you currently<br>
assume is free.<br>
<br>
The armv7-hello program happens to map on top of this thread-local<br>
storage, and then we crash later accessing some host TLS variable.<br>
<br>
While the linux-user probe_guest_base is significantly more complex,<br>
we are also trying to handle 32-bit hosts.=C2=A0 I think freebsd is always<=
br>
assuming 64-bit hosts, which makes this simpler.<br></blockquote><div><br><=
/div><div>Double mapping makes sense for problems to arise. I&#39;d not hav=
e thought</div><div>this would be the problem, but it does eliminate a bunc=
h of code that I&#39;d</div><div>thought suspect (made worse by my trying t=
o &#39;fix&#39; old kludges with new</div><div>kludges of my own).</div><di=
v><br></div><div>Yes. FreeBSD&#39;s bsd-user binary will only run on 64-bit=
 hosts. The project</div><div>has started phasing out support for 32-bit ho=
sts, and the role of bsd-user</div><div>(package builder tool) is such that=
 32-bit hosts don&#39;t make sense.</div><div><br></div><div>I&#39;ve teste=
d this out, and it works for me. Any chance we can get this into</div><div>=
8.1 as a bug fix for the last minute breakage of bsd-user (without this and=
</div><div>another patch, the static hello world that used to work broke). =
I can send</div><div>that second patch out for review. I can queue this fix=
 in the mean time for</div><div>whenever the tree opens up.</div><div><br><=
/div><div>Reviewed by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">im=
p@bsdimp.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
r~<br>
---<br>
=C2=A0bsd-user/main.c | 37 +++++++++++++++++++------------------<br>
=C2=A01 file changed, 19 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/bsd-user/main.c b/bsd-user/main.c<br>
index f500ec292b..9760aad9f6 100644<br>
--- a/bsd-user/main.c<br>
+++ b/bsd-user/main.c<br>
@@ -50,20 +50,8 @@<br>
<br>
=C2=A0int do_strace;<br>
<br>
-/*<br>
- * Going hand in hand with the va space needed (see below), we need<br>
- * to find a host address to map the guest to. Assume that qemu<br>
- * itself doesn&#39;t need memory above 32GB (or that we don&#39;t collide=
<br>
- * with anything interesting). This is selected rather arbitrarily,<br>
- * but seems to produce good results in tests to date.<br>
- */<br>
-# if HOST_LONG_BITS &gt;=3D 64<br>
-uintptr_t guest_base =3D 0x800000000ul;=C2=A0 =C2=A0 /* at 32GB */<br>
-bool have_guest_base =3D true;<br>
-#else<br>
-uintptr_t guest_base;=C2=A0 =C2=A0 /* TODO: use sysctl to find big enough =
hole */<br>
+uintptr_t guest_base;<br>
=C2=A0bool have_guest_base;<br>
-#endif<br>
=C2=A0static bool opt_one_insn_per_tb;<br>
=C2=A0static const char *cpu_model;<br>
=C2=A0static const char *cpu_type;<br>
@@ -522,10 +510,6 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0target_environ =3D envlist_to_environ(envlist, NULL);<b=
r>
=C2=A0 =C2=A0 =C2=A0envlist_free(envlist);<br>
<br>
-=C2=A0 =C2=A0 if (reserved_va) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_next_start =3D reserved_va + 1;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error *err =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (seed_optarg !=3D NULL) {<br>
@@ -543,7 +527,24 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 * Now that page sizes are configured we can do<br>
=C2=A0 =C2=A0 =C2=A0 * proper page alignment for guest_base.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 guest_base =3D HOST_PAGE_ALIGN(guest_base);<br>
+=C2=A0 =C2=A0 if (have_guest_base) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (guest_base &amp; ~qemu_host_page_mask) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Selected gues=
t base not host page aligned&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else if (reserved_va) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *p =3D mmap(NULL, reserved_va + 1, PROT_N=
ONE, MAP_GUARD, -1, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p =3D=3D MAP_FAILED) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *err =3D strerror(err=
no);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *sz =3D size_to_str(reserve=
d_va + 1);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Cannot alloca=
te %s bytes for guest address space: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0sz, err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 guest_base =3D (uintptr_t)p;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 have_guest_base =3D true;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (loader_exec(filename, argv + optind, target_environ=
, regs, info,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;bprm) !=3D 0) {<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div></div>

--000000000000cbdbf5060180e63e--

