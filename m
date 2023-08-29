Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C5F78D012
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:13:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n4-0000qR-DZ; Tue, 29 Aug 2023 19:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb3oz-0006bN-Fo
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:52:13 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb3ow-0003IF-Jm
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:52:13 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2bcfd3220d3so54847071fa.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 11:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693335128; x=1693939928;
 darn=nongnu.org; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BM5gTZpVfwIhUaXsPYxpOVTbgpTlMmeFy4rsYB2BwoI=;
 b=VNJrn7sZ+5XxkMdUOYzZZCeZ8PGA+sR0AdM6l0CpsFT3JlsN+IbMdP/kjhT2GuDCDB
 qZ2vM2buVCRp9Ksx135uVl7QLIWyvDjeBSuJgMYwrlnrfFmAU+naoBItRBkVIRWDp5r5
 SZT3+rD3DOyW/OwFnq3LrvP1tPQuh/3OLQg+SigjcnR0rOt4+fXZHlsyjOqv0mma0n6O
 ljSvElzv5tGofOvBCBzecoz+TTbSJ9MNIjSd4wfkQJnZakW3K+BNx1T3HzPnz/qhvx5h
 3cVXteitRpP4jQPGozKyN+I2kn+JFhKBPZvgxDL7l3w5yU9PUZc6QN8nDWzVm2r6uUyq
 tNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693335128; x=1693939928;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BM5gTZpVfwIhUaXsPYxpOVTbgpTlMmeFy4rsYB2BwoI=;
 b=HtoHXN85D+FQCZp4GnIk/VhmiV5VYxpNB7/YBaMAVX217ENbK5f8yPJym/c2JJ6zRI
 imhezMpdG8cHL81Naafp4/p33xNXsOTwlD8GyOaQ67PDIIu4L0vEz8fqiJGpfASi8A/U
 FHl9vPO7cygePgl2UrLJS2HGUq9GnMBn+wZJuq4l50fsfjDyDTfiWPH2ZjFqxCJwJrVO
 gZNOE4p9lQktYM3SEVbasYNbEn5kJY2zp93Imqmz/Tvf6IEzqkg27S5GeYJwMT43TeeV
 n+qpI/pqPlnzcpSzk+zVdonsZkS5RZZGW/Jqnp221nlYVSJUiMk/OX1NdNwEfDgZ41Wa
 FhPg==
X-Gm-Message-State: AOJu0YxXfCgWqgKK87BpFBBPd2IhuPEFSYleneE3z6nIq2C5xyE4Bskb
 KFVjGjqeBBUg/GZRl4dSal4JEC6lZMLWS3MrRtHYVcytYswaGrhW
X-Google-Smtp-Source: AGHT+IHuB7iZNihD7tpTfNW8PAUfVMPi7Ag4wRtcBHlfQheG1PukNYSvVHIX+zNPoLGCyqR5yR0DvUYwbQFtnMSJb6U=
X-Received: by 2002:a2e:7d0e:0:b0:2bb:997a:493e with SMTP id
 y14-20020a2e7d0e000000b002bb997a493emr107187ljc.35.1693335127789; Tue, 29 Aug
 2023 11:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230829184509.54434-1-imp@bsdimp.com>
In-Reply-To: <20230829184509.54434-1-imp@bsdimp.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 29 Aug 2023 12:51:56 -0600
Message-ID: <CANCZdfrtCUTFXMw0jHaGXo0H8DYh3iQaTnM3emnwnbu6Dy5uXg@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Move PRAGMA_DISABLE_PACKED_WARNING to
 compiler.h
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c77bbf0604144e3b"
Received-SPF: none client-ip=2a00:1450:4864:20::22a;
 envelope-from=wlosh@bsdimp.com; helo=mail-lj1-x22a.google.com
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

--000000000000c77bbf0604144e3b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

v1 should have had a comment removed, but didn't. v2 addresses that (should
already be in your mailbox).

Warner

On Tue, Aug 29, 2023 at 12:48=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote=
:

> Replace the slightly older version of this in include/qemu/compiler.h
> that was commit as part of bsd-user changes with the newer one from
> linux-user. bsd-user has no regreassions with this.
>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  include/qemu/compiler.h  |  3 +--
>  linux-user/qemu.h        | 26 --------------------------
>  tests/lcitool/libvirt-ci |  2 +-
>  3 files changed, 2 insertions(+), 29 deletions(-)
>
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index b0374425180..9496a65ea57 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -38,10 +38,9 @@
>   *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D83256 -- so we only
>   *   include the warning-suppression pragmas for clang
>   */
> -#ifdef __clang__
> +#if defined(__clang__) && __has_warning("-Waddress-of-packed-member")
>  #define PRAGMA_DISABLE_PACKED_WARNING                                   =
\
>      _Pragma("GCC diagnostic push");                                     =
\
> -    _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                    =
\
>      _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"")
>
>  #define PRAGMA_REENABLE_PACKED_WARNING          \
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 4f8b55e2fb0..12821e54d0a 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -193,32 +193,6 @@ static inline bool access_ok(CPUState *cpu, int type=
,
>     These are usually used to access struct data members once the struct
> has
>     been locked - usually with lock_user_struct.  */
>
> -/*
> - * Tricky points:
> - * - Use __builtin_choose_expr to avoid type promotion from ?:,
> - * - Invalid sizes result in a compile time error stemming from
> - *   the fact that abort has no parameters.
> - * - It's easier to use the endian-specific unaligned load/store
> - *   functions than host-endian unaligned load/store plus tswapN.
> - * - The pragmas are necessary only to silence a clang false-positive
> - *   warning: see https://bugs.llvm.org/show_bug.cgi?id=3D39113 .
> - * - gcc has bugs in its _Pragma() support in some versions, eg
> - *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D83256 -- so we only
> - *   include the warning-suppression pragmas for clang
> - */
> -#if defined(__clang__) && __has_warning("-Waddress-of-packed-member")
> -#define PRAGMA_DISABLE_PACKED_WARNING                                   =
\
> -    _Pragma("GCC diagnostic push");                                     =
\
> -    _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"")
> -
> -#define PRAGMA_REENABLE_PACKED_WARNING          \
> -    _Pragma("GCC diagnostic pop")
> -
> -#else
> -#define PRAGMA_DISABLE_PACKED_WARNING
> -#define PRAGMA_REENABLE_PACKED_WARNING
> -#endif
> -
>  #define __put_user_e(x, hptr, e)
>   \
>      do {
>   \
>          PRAGMA_DISABLE_PACKED_WARNING;
>   \
> diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> index bbd55b4d18c..9bff3b763b5 160000
> --- a/tests/lcitool/libvirt-ci
> +++ b/tests/lcitool/libvirt-ci
> @@ -1 +1 @@
> -Subproject commit bbd55b4d18cce8f89b5167675e434a6941315634
> +Subproject commit 9bff3b763b5531a1490e238bfbf77306dc3a6dbb
> --
> 2.41.0
>
>

--000000000000c77bbf0604144e3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">v1 should have had a comment removed, but didn&#39;t. v2 a=
ddresses that (should already be in your mailbox).<div><br></div><div>Warne=
r</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, Aug 29, 2023 at 12:48=E2=80=AFPM Warner Losh &lt;<a href=3D"=
mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Replace the slightly older version of =
this in include/qemu/compiler.h<br>
that was commit as part of bsd-user changes with the newer one from<br>
linux-user. bsd-user has no regreassions with this.<br>
<br>
Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"=
_blank">imp@bsdimp.com</a>&gt;<br>
---<br>
=C2=A0include/qemu/compiler.h=C2=A0 |=C2=A0 3 +--<br>
=C2=A0linux-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 26 -------------------=
-------<br>
=C2=A0tests/lcitool/libvirt-ci |=C2=A0 2 +-<br>
=C2=A03 files changed, 2 insertions(+), 29 deletions(-)<br>
<br>
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h<br>
index b0374425180..9496a65ea57 100644<br>
--- a/include/qemu/compiler.h<br>
+++ b/include/qemu/compiler.h<br>
@@ -38,10 +38,9 @@<br>
=C2=A0 *=C2=A0 =C2=A0<a href=3D"https://gcc.gnu.org/bugzilla/show_bug.cgi?i=
d=3D83256" rel=3D"noreferrer" target=3D"_blank">https://gcc.gnu.org/bugzill=
a/show_bug.cgi?id=3D83256</a> -- so we only<br>
=C2=A0 *=C2=A0 =C2=A0include the warning-suppression pragmas for clang<br>
=C2=A0 */<br>
-#ifdef __clang__<br>
+#if defined(__clang__) &amp;&amp; __has_warning(&quot;-Waddress-of-packed-=
member&quot;)<br>
=C2=A0#define PRAGMA_DISABLE_PACKED_WARNING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0_Pragma(&quot;GCC diagnostic push&quot;);=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 _Pragma(&quot;GCC diagnostic ignored \&quot;-Wpragmas\&quot;=
&quot;);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \<br>
=C2=A0 =C2=A0 =C2=A0_Pragma(&quot;GCC diagnostic ignored \&quot;-Waddress-o=
f-packed-member\&quot;&quot;)<br>
<br>
=C2=A0#define PRAGMA_REENABLE_PACKED_WARNING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \<br>
diff --git a/linux-user/qemu.h b/linux-user/qemu.h<br>
index 4f8b55e2fb0..12821e54d0a 100644<br>
--- a/linux-user/qemu.h<br>
+++ b/linux-user/qemu.h<br>
@@ -193,32 +193,6 @@ static inline bool access_ok(CPUState *cpu, int type,<=
br>
=C2=A0 =C2=A0 These are usually used to access struct data members once the=
 struct has<br>
=C2=A0 =C2=A0 been locked - usually with lock_user_struct.=C2=A0 */<br>
<br>
-/*<br>
- * Tricky points:<br>
- * - Use __builtin_choose_expr to avoid type promotion from ?:,<br>
- * - Invalid sizes result in a compile time error stemming from<br>
- *=C2=A0 =C2=A0the fact that abort has no parameters.<br>
- * - It&#39;s easier to use the endian-specific unaligned load/store<br>
- *=C2=A0 =C2=A0functions than host-endian unaligned load/store plus tswapN=
.<br>
- * - The pragmas are necessary only to silence a clang false-positive<br>
- *=C2=A0 =C2=A0warning: see <a href=3D"https://bugs.llvm.org/show_bug.cgi?=
id=3D39113" rel=3D"noreferrer" target=3D"_blank">https://bugs.llvm.org/show=
_bug.cgi?id=3D39113</a> .<br>
- * - gcc has bugs in its _Pragma() support in some versions, eg<br>
- *=C2=A0 =C2=A0<a href=3D"https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D8=
3256" rel=3D"noreferrer" target=3D"_blank">https://gcc.gnu.org/bugzilla/sho=
w_bug.cgi?id=3D83256</a> -- so we only<br>
- *=C2=A0 =C2=A0include the warning-suppression pragmas for clang<br>
- */<br>
-#if defined(__clang__) &amp;&amp; __has_warning(&quot;-Waddress-of-packed-=
member&quot;)<br>
-#define PRAGMA_DISABLE_PACKED_WARNING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 _Pragma(&quot;GCC diagnostic push&quot;);=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 _Pragma(&quot;GCC diagnostic ignored \&quot;-Waddress-of-pac=
ked-member\&quot;&quot;)<br>
-<br>
-#define PRAGMA_REENABLE_PACKED_WARNING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
<br>
-=C2=A0 =C2=A0 _Pragma(&quot;GCC diagnostic pop&quot;)<br>
-<br>
-#else<br>
-#define PRAGMA_DISABLE_PACKED_WARNING<br>
-#define PRAGMA_REENABLE_PACKED_WARNING<br>
-#endif<br>
-<br>
=C2=A0#define __put_user_e(x, hptr, e)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PRAGMA_DISABLE_PACKED_WARNING;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci<br>
index bbd55b4d18c..9bff3b763b5 160000<br>
--- a/tests/lcitool/libvirt-ci<br>
+++ b/tests/lcitool/libvirt-ci<br>
@@ -1 +1 @@<br>
-Subproject commit bbd55b4d18cce8f89b5167675e434a6941315634<br>
+Subproject commit 9bff3b763b5531a1490e238bfbf77306dc3a6dbb<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div>

--000000000000c77bbf0604144e3b--

