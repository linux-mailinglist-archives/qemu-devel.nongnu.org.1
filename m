Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5943E70F49D
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 12:54:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1m8U-000740-36; Wed, 24 May 2023 06:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q1m8R-00073L-4K
 for qemu-devel@nongnu.org; Wed, 24 May 2023 06:54:27 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q1m8P-0006jp-9Y
 for qemu-devel@nongnu.org; Wed, 24 May 2023 06:54:26 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2af2b74d258so10321801fa.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 03:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684925663; x=1687517663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o3z/ww8ylbz4hPfmw9RwYPhZLyBNkzTB2pGCbvuU18w=;
 b=qGHNXUo4L3JYlIXdOptFA/MS9g/ReZKsm0zFlOEL+VaRgCfaDXkMavacmcNfp4Gjab
 XLvPhxyMhp/sb2rVwBBudSmReN+II+iuNAe/7xZgusQ38QECiy9LZxpntaO+Y1uLn6HD
 jUhpgNmhRnhTlLDnbmHmqndub1OsRok7dDale8uGASq4Qz3AmRzmPy+eyrZTp0vYQLTn
 hNnnSo7QyK6p64Ww3+Acj/MoVvsHtG6JjRd6NfM6czK5W2Rb5dJFER8oc1pjp2VQCoyg
 cmB16pV5AEygyGzRvit+t3z0ZhMYZWAxZkYH/EGxiL7+8Y/SXchfzCjur6Rhd2J+yJSJ
 vtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684925663; x=1687517663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o3z/ww8ylbz4hPfmw9RwYPhZLyBNkzTB2pGCbvuU18w=;
 b=jFhmZBtdRBVMoJ9N1IFN3KUznqCpeXnDtOl18fmKZ29ftefxXM1rB55dPMnEZLwg3R
 ljeWnA4n0Uk8wZ0cjLIaufcyzQd7tvgdjTxP//RFi1J4K1qkDKkLj9Lk7XBU8qLnFYae
 6uzbbgDvJypmqPASoY4A88OZAlBtvlOvRBzeRBJiJvI+RlD71zdbTXUDqh5PjSUk5PPR
 RzfFeO+m82ppKeE/g/zMdQ2V3YrnXwZA4Whz8lkVEfe3OmVxCKonNrpCOCdZIRIYfPuX
 vaOyLmRYAy7q3XLOQfdfsRJI3QenareTeh++k2NUKKbUDXAHmwPr8v2GwdZuXXo3alFJ
 U3Zw==
X-Gm-Message-State: AC+VfDxfJav8PJ9qGHRdj7G0dXYk5nWQQhaVLXJGVfDVwYGM6IFIG0hq
 eHIoip0xf+sI9GcGdeTpCr6LJuL/+WDxOBB77qd1eBdyq/c=
X-Google-Smtp-Source: ACHHUZ65XvWRErZgk+JzLZ3h5N9Yjsb3UmUA5O7U7G8c7TSaQIah4gUUFKh6UyZjeQQ8UmU7MVi56M73n7bleALhxYM=
X-Received: by 2002:a2e:3503:0:b0:2af:1dd5:b068 with SMTP id
 z3-20020a2e3503000000b002af1dd5b068mr6974757ljz.48.1684925662878; Wed, 24 May
 2023 03:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230515132440.1025315-1-marcandre.lureau@redhat.com>
In-Reply-To: <20230515132440.1025315-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 24 May 2023 14:54:11 +0400
Message-ID: <CAJ+F1CLvoLSF=91XpFUorfdUN8e=cz9P2v+EmTdY90DPLUOtTw@mail.gmail.com>
Subject: Re: [PATCH] win32: wrap socket close() with an exception handler
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com, Stefan Weil <sw@weilnetz.de>
Content-Type: multipart/alternative; boundary="0000000000009be1d605fc6e5307"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

--0000000000009be1d605fc6e5307
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 5:25=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Since commit abe34282 ("win32: avoid mixing SOCKET and file descriptor
> space"), we set HANDLE_FLAG_PROTECT_FROM_CLOSE on the socket FD, to
> prevent closing the HANDLE with CloseHandle. This raises an exception
> which under gdb is fatal, and qemu exits.
>
> Let's catch the expected error instead.
>
> Note: this appears to work, but the mingw64 macro is not well documented
> or tested, and it's not obvious how it is meant to be used.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>

ping


> ---
>  include/sysemu/os-win32.h |  4 ++++
>  util/oslib-win32.c        | 23 +++++++++++++++++------
>  2 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
> index 15c296e0eb..65f6c9ea57 100644
> --- a/include/sysemu/os-win32.h
> +++ b/include/sysemu/os-win32.h
> @@ -259,6 +259,10 @@ ssize_t qemu_recv_wrap(int sockfd, void *buf, size_t
> len, int flags);
>  ssize_t qemu_recvfrom_wrap(int sockfd, void *buf, size_t len, int flags,
>                             struct sockaddr *addr, socklen_t *addrlen);
>
> +EXCEPTION_DISPOSITION
> +win32_close_exception_handler(struct _EXCEPTION_RECORD*, void*,
> +                              struct _CONTEXT*, void*);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index a98638729a..fafbab80b4 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -479,6 +479,13 @@ int qemu_bind_wrap(int sockfd, const struct sockaddr
> *addr,
>      return ret;
>  }
>
> +EXCEPTION_DISPOSITION
> +win32_close_exception_handler(struct _EXCEPTION_RECORD*,
> +                              void*, struct _CONTEXT*, void*)
> +{
> +    return EXCEPTION_EXECUTE_HANDLER;
> +}
> +
>  #undef close
>  int qemu_close_socket_osfhandle(int fd)
>  {
> @@ -504,12 +511,16 @@ int qemu_close_socket_osfhandle(int fd)
>          return -1;
>      }
>
> -    /*
> -     * close() returns EBADF since we PROTECT_FROM_CLOSE the underlying
> handle,
> -     * but the FD is actually freed
> -     */
> -    if (close(fd) < 0 && errno !=3D EBADF) {
> -        return -1;
> +    __try1(win32_close_exception_handler) {
> +        /*
> +         * close() returns EBADF since we PROTECT_FROM_CLOSE the
> underlying
> +         * handle, but the FD is actually freed
> +         */
> +        if (close(fd) < 0 && errno !=3D EBADF) {
> +            return -1;
> +        }
> +    }
> +    __except1 {
>      }
>
>      if (!SetHandleInformation((HANDLE)s, flags, flags)) {
> --
> 2.40.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000009be1d605fc6e5307
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 15, 2023 at 5:25=E2=80=AF=
PM &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@r=
edhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
Since commit abe34282 (&quot;win32: avoid mixing SOCKET and file descriptor=
<br>
space&quot;), we set HANDLE_FLAG_PROTECT_FROM_CLOSE on the socket FD, to<br=
>
prevent closing the HANDLE with CloseHandle. This raises an exception<br>
which under gdb is fatal, and qemu exits.<br>
<br>
Let&#39;s catch the expected error instead.<br>
<br>
Note: this appears to work, but the mingw64 macro is not well documented<br=
>
or tested, and it&#39;s not obvious how it is meant to be used.<br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br></bl=
ockquote><div><br></div><div>ping</div><div>=C2=A0<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0include/sysemu/os-win32.h |=C2=A0 4 ++++<br>
=C2=A0util/oslib-win32.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 23 +++++++++++++++++-=
-----<br>
=C2=A02 files changed, 21 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h<br>
index 15c296e0eb..65f6c9ea57 100644<br>
--- a/include/sysemu/os-win32.h<br>
+++ b/include/sysemu/os-win32.h<br>
@@ -259,6 +259,10 @@ ssize_t qemu_recv_wrap(int sockfd, void *buf, size_t l=
en, int flags);<br>
=C2=A0ssize_t qemu_recvfrom_wrap(int sockfd, void *buf, size_t len, int fla=
gs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct sockaddr *addr, socklen_t *addrlen);<br>
<br>
+EXCEPTION_DISPOSITION<br>
+win32_close_exception_handler(struct _EXCEPTION_RECORD*, void*,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct _CONTEXT*, void*);<br>
+<br>
=C2=A0#ifdef __cplusplus<br>
=C2=A0}<br>
=C2=A0#endif<br>
diff --git a/util/oslib-win32.c b/util/oslib-win32.c<br>
index a98638729a..fafbab80b4 100644<br>
--- a/util/oslib-win32.c<br>
+++ b/util/oslib-win32.c<br>
@@ -479,6 +479,13 @@ int qemu_bind_wrap(int sockfd, const struct sockaddr *=
addr,<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+EXCEPTION_DISPOSITION<br>
+win32_close_exception_handler(struct _EXCEPTION_RECORD*,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void*, struct _CONTEXT*, void*)<br>
+{<br>
+=C2=A0 =C2=A0 return EXCEPTION_EXECUTE_HANDLER;<br>
+}<br>
+<br>
=C2=A0#undef close<br>
=C2=A0int qemu_close_socket_osfhandle(int fd)<br>
=C2=A0{<br>
@@ -504,12 +511,16 @@ int qemu_close_socket_osfhandle(int fd)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* close() returns EBADF since we PROTECT_FROM_CLOSE th=
e underlying handle,<br>
-=C2=A0 =C2=A0 =C2=A0* but the FD is actually freed<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 if (close(fd) &lt; 0 &amp;&amp; errno !=3D EBADF) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 __try1(win32_close_exception_handler) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* close() returns EBADF since we PROTECT=
_FROM_CLOSE the underlying<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* handle, but the FD is actually freed<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (close(fd) &lt; 0 &amp;&amp; errno !=3D EBA=
DF) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 __except1 {<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!SetHandleInformation((HANDLE)s, flags, flags)) {<b=
r>
-- <br>
2.40.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000009be1d605fc6e5307--

