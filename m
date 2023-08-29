Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 548D678D082
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:26:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n0-0000ne-21; Tue, 29 Aug 2023 19:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb3t5-0007Zy-AS
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:56:27 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb3t0-0004K9-ER
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:56:27 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99de884ad25so641239666b.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 11:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693335378; x=1693940178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tT/CsO5CFtQ8UdZf8ngPElckGBslgPQG6YlNz+v/vNM=;
 b=tUjBRRkcv6Ypb/0dUFh9KsA29VD4W/cnaE6T2IDB2X26P55LvXNYIUpAMfjDT/OJdv
 GW+/G+GNSEm9fdX8ZO2n5VyCD6cb93hbhMLZDmepCGy3YucwlRChwtHbTdKTxOvB0Syi
 7t9jv0khxohlv01msulX4OTDAsrwFS69t3j+yRJNoLgQPzUobxGGpu020UvZufsLJqA6
 z8ZZRSsRBliQ/U12CI+IL49Pw76YFTQNVCm9V5KyVPP9IkXgP74deCxtdGO1ltEoSXX6
 HL54tUx+GIN31vwSWYz3BU3gzYD0VpNANMa0ByckU3v99aUuLIwu3PSPplBfLW/0AYvB
 OjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693335378; x=1693940178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tT/CsO5CFtQ8UdZf8ngPElckGBslgPQG6YlNz+v/vNM=;
 b=Btl2dESyTv9tfIQZchOKfO8wauOFMmfX7twMSINn4fzciFNBTtlN4VvRHYRk74I3SM
 1I5mkUay4S8y8eIAhKzr8oWoB+It7isIclEKP2Yx1rVzQn627ELEUm6bXKVeJCzNh985
 UuOznOUA1I6c7Bk5CBJSNGmaqmZzr9JUDpiIRiPcLQBR8dXuSMRi7tzWVE5WkNOHH5Ik
 qFymCeZnkGK5YJnH/0gqTSCVeDXybQX3kxY6jfcaq1RccIwzHWmA/+50sq9J0VDJXp+I
 MIsLV2I5hF6WgameuWGylWuAnLJQ+lKKTEpeI7F8vanotOmkKmhDwBK+i/0NCvSybJlZ
 Sgvg==
X-Gm-Message-State: AOJu0YxbnUnQzesj4DtEi/0up5omIWre89Sr2p3S0rWgbNRansi7uY1s
 ntHHDbqWRfYOvO6ZwSNFxVuwmWX6LdiAPOzimWDGfa3gLU3R4DWK
X-Google-Smtp-Source: AGHT+IFnOwlQYVZnk8s5yjCr3OwF5PY7cnvun5ujmiM9cSERXjq2TMe7s3QMJPSwPm5mAOIZ+KD0aXT79R+0zY10sMw=
X-Received: by 2002:a17:906:109a:b0:9a5:c54f:da1c with SMTP id
 u26-20020a170906109a00b009a5c54fda1cmr2704492eju.47.1693335378426; Tue, 29
 Aug 2023 11:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230829184743.54557-1-imp@bsdimp.com>
In-Reply-To: <20230829184743.54557-1-imp@bsdimp.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 29 Aug 2023 12:56:07 -0600
Message-ID: <CANCZdfrSspLDgKWrvLY=w95aLMgH2oaKp3-fkxHPyKYa0=GAuw@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user: Move PRAGMA_DISABLE_PACKED_WARNING to
 compiler.h
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b7b1760604145db3"
Received-SPF: none client-ip=2a00:1450:4864:20::631;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x631.google.com
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

--000000000000b7b1760604145db3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC Peter Maywell
CC Stefan Hajnoczi

On Tue, Aug 29, 2023 at 12:51=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote=
:

> Replace the slightly older version of this in include/qemu/compiler.h
> that was commit as part of bsd-user changes with the newer one from
> linux-user. bsd-user has no regreassions with this.
>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  include/qemu/compiler.h  |  6 +-----
>  linux-user/qemu.h        | 26 --------------------------
>  tests/lcitool/libvirt-ci |  2 +-
>  3 files changed, 2 insertions(+), 32 deletions(-)
>
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index b0374425180..0df9febbe2f 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -31,17 +31,13 @@
>   *   functions than host-endian unaligned load/store plus tswapN.
>   * - The pragmas are necessary only to silence a clang false-positive
>   *   warning: see https://bugs.llvm.org/show_bug.cgi?id=3D39113 .
> - * - We have to disable -Wpragmas warnings to avoid a complaint about
> - *   an unknown warning type from older compilers that don't know about
> - *   -Waddress-of-packed-member.
>   * - gcc has bugs in its _Pragma() support in some versions, eg
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

--000000000000b7b1760604145db3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">CC Peter Maywell<div>CC Stefan Hajnoczi</div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 2=
9, 2023 at 12:51=E2=80=AFPM Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.co=
m">imp@bsdimp.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Replace the slightly older version of this in include/qemu=
/compiler.h<br>
that was commit as part of bsd-user changes with the newer one from<br>
linux-user. bsd-user has no regreassions with this.<br>
<br>
Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"=
_blank">imp@bsdimp.com</a>&gt;<br>
---<br>
=C2=A0include/qemu/compiler.h=C2=A0 |=C2=A0 6 +-----<br>
=C2=A0linux-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 26 -------------------=
-------<br>
=C2=A0tests/lcitool/libvirt-ci |=C2=A0 2 +-<br>
=C2=A03 files changed, 2 insertions(+), 32 deletions(-)<br>
<br>
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h<br>
index b0374425180..0df9febbe2f 100644<br>
--- a/include/qemu/compiler.h<br>
+++ b/include/qemu/compiler.h<br>
@@ -31,17 +31,13 @@<br>
=C2=A0 *=C2=A0 =C2=A0functions than host-endian unaligned load/store plus t=
swapN.<br>
=C2=A0 * - The pragmas are necessary only to silence a clang false-positive=
<br>
=C2=A0 *=C2=A0 =C2=A0warning: see <a href=3D"https://bugs.llvm.org/show_bug=
.cgi?id=3D39113" rel=3D"noreferrer" target=3D"_blank">https://bugs.llvm.org=
/show_bug.cgi?id=3D39113</a> .<br>
- * - We have to disable -Wpragmas warnings to avoid a complaint about<br>
- *=C2=A0 =C2=A0an unknown warning type from older compilers that don&#39;t=
 know about<br>
- *=C2=A0 =C2=A0-Waddress-of-packed-member.<br>
=C2=A0 * - gcc has bugs in its _Pragma() support in some versions, eg<br>
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

--000000000000b7b1760604145db3--

