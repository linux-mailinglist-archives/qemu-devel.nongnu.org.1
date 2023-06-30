Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B65B744285
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:48:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFJ92-0006H1-24; Fri, 30 Jun 2023 14:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qFJ8u-0006Ch-OD
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:46:54 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qFJ8s-0003BY-Po
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:46:52 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51d95aed33aso2202285a12.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1688150808; x=1690742808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Z0MQSgMeAX+0TawLhdI9SBXLFK/y3tjhDkwtkPQ0h4=;
 b=Z1c2DA3UtE0TLmkiNq2ZHf3WSynNiCrQCCWLPMLBNnh2xX5AZo24wSzkLQPmakRaP6
 VJJhBlB7KktXoaXBWBi8bWFT14bAFr4sxbT9yxPlnnY9Tc3w+a8OsP6w5gaqpxw7oUbW
 otQDYDVRDlr5snElo9PZXfn/tTgGw9F8+tSqjCfmgjAz0pFcXPNkymomC0S+uU7kcBac
 OJOI2jlR6qswyHMwHfd81GsDOamBIuq/OD0aQzWsc7JguU4esL79wAzA9hNysbcqrUNm
 xmavw9ifXgc7/OyuFX0fr9C6buImfrfYfrKgTN5gqqKhR8DmAyOgeSz9y4OtjtOBAagB
 pydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688150808; x=1690742808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Z0MQSgMeAX+0TawLhdI9SBXLFK/y3tjhDkwtkPQ0h4=;
 b=Od+ZrY3r9DxFDK5V5peHbpcG4xCyAY6NtbeyVeS7Ip9vZlD/zDvy/o03GYNJ57ztQN
 zhyVB2Lx4dsgtb/Qs0RJm3moLwyvTj8214Xorwq4yGcgKfHx7wtvtcjNgXp/xtRZFdGs
 yuyT+YqlKiVPgMhVENcCgsP2aKdUM3HMxYwvE5bxuT08wyEv3Xtkqf3ZgFipj/5B3M8H
 i16t4dmVtkjs3whyyknqCmfBPpbvSWa+R65qSYyLYSMe7oe+vJWyv876qj7TmyZ5S9DM
 Ejx5aUO8s94Gl2N3G0gSt1xCmhwjJkFyB0J4A8wku4lCP463s641bPi9m/XqrQoi/qSg
 QetQ==
X-Gm-Message-State: ABy/qLaOSRFRmjWhSv+lHraUzL0jGkgO1Lx3xCh0egOmLDKThhslZei8
 yO9W4TwRD2vJwl7noXDcIOX2gEDINHBl5UIRQfx5ow==
X-Google-Smtp-Source: APBJJlHPcARe6entUzu0vL4yDFmaOooBPiYl0FTADb0zN4opJ9jTsOUoDw8/BB9nP9bb2+OnGTbtylQ+Fbua4vYQ+Qs=
X-Received: by 2002:a50:ee05:0:b0:51d:d4dd:a0e1 with SMTP id
 g5-20020a50ee05000000b0051dd4dda0e1mr1963363eds.15.1688150808636; Fri, 30 Jun
 2023 11:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-9-richard.henderson@linaro.org>
In-Reply-To: <20230630132159.376995-9-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 30 Jun 2023 12:46:37 -0600
Message-ID: <CANCZdfqreYmDeAtZv=y2kke1H7xdU3Pi6jKKNKCE+i6WkAfq2w@mail.gmail.com>
Subject: Re: [PATCH 08/24] bsd-user: Use page_check_range_empty for MAP_EXCL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000046c5d105ff5d3da4"
Received-SPF: none client-ip=2a00:1450:4864:20::52d;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52d.google.com
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

--00000000000046c5d105ff5d3da4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 7:22=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> The previous check returned -1 when any page within
> [start, start+len) is unmapped, not when all are unmapped.
>
> Cc: Warner Losh <imp@bsdimp.com>
> Cc: Kyle Evans <kevans@freebsd.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index 565b9f97ed..07b5b8055e 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -609,7 +609,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,
> int prot,
>          }
>
>          /* Reject the mapping if any page within the range is mapped */
> -        if ((flags & MAP_EXCL) && page_check_range(start, len, 0) < 0) {
> +        if ((flags & MAP_EXCL) && !page_check_range_empty(start, end -
> 1)) {
>

Won't computing end overflow if start is 1<<32 - len? Then subtracting one
here would be too late.

Warner



>              errno =3D EINVAL;
>              goto fail;
>          }
> --
> 2.34.1
>
>

--00000000000046c5d105ff5d3da4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 30, 2023 at 7:22=E2=80=AF=
AM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">The previous check returned -1 when any page with=
in<br>
[start, start+len) is unmapped, not when all are unmapped.<br>
<br>
Cc: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp=
@bsdimp.com</a>&gt;<br>
Cc: Kyle Evans &lt;<a href=3D"mailto:kevans@freebsd.org" target=3D"_blank">=
kevans@freebsd.org</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/mmap.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c<br>
index 565b9f97ed..07b5b8055e 100644<br>
--- a/bsd-user/mmap.c<br>
+++ b/bsd-user/mmap.c<br>
@@ -609,7 +609,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, in=
t prot,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Reject the mapping if any page within =
the range is mapped */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((flags &amp; MAP_EXCL) &amp;&amp; page_che=
ck_range(start, len, 0) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((flags &amp; MAP_EXCL) &amp;&amp; !page_ch=
eck_range_empty(start, end - 1)) {<br></blockquote><div><br></div><div>Won&=
#39;t computing end overflow if start is 1&lt;&lt;32 - len? Then subtractin=
g one here would be too late.=C2=A0</div><div><br></div><div>Warner</div><d=
iv><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--00000000000046c5d105ff5d3da4--

