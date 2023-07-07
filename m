Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EEB74B961
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 00:07:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHtbX-00029s-VZ; Fri, 07 Jul 2023 18:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qHtbV-00029j-Ig
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 18:07:05 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qHtbM-0006th-Uu
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 18:07:05 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51d805cb33aso3215312a12.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 15:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1688767615; x=1691359615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cLSEDL5lizAmbsZ7LrKmAeoPrN7TBOWaNSVITxtnjX4=;
 b=gTyQDKh/GcgsOjUi/Rt5p99e0nssi227Sth+sjnRJmEC/VATQGAcu2QDxZj0UKvUPk
 ykdyNCVde+kg7KuEeMqJgIK3+K6H/VMTeVeoPI34wV82kfHvjY6/f34KnneJ86wLynqj
 ELGibsp3FTvcVfI/+XJ2Hg+L/s0aA9MWabQvVMpf+AwEQM1vkL+M7KU5X1gtNRAQsqxs
 Z3qjcvbVsOrqFS05U7+HpJAVbvB4K0ApnquhVGbSOEh/gweLLwl51ubD+NXhiZU2HnjD
 MOrQS8eSwvxZWymSkRL8wjYJIHgD9wqKaCxJMpl4eWHTkl9P02tPDbHEclgmmXGRa5qn
 ZlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688767615; x=1691359615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cLSEDL5lizAmbsZ7LrKmAeoPrN7TBOWaNSVITxtnjX4=;
 b=WjdwNM6kn5IhxBva2lyUONb1aPEFq00x/0aQgWzbprj/MWAMG8MGVmcSpR3tZXOTly
 05ZJjK79HTJn4490loo6GRllN0HgA9/xy6HjTAUa86gy1VaA0QYCunehLVbuJQ47mlDm
 zCKNtODYIA2qy1H3hWNEBO+NcL7axTF3DLLy1f6av0pgOv1nsytk4YsR0CbzhUj82WtZ
 9oxSN51WGP8dmwK9gpq7+1254SIvZ0nm+rqjjusSAF7cmU9T9ad2OMhkmfvN/vwXM/fU
 wQ+RnSUxBpPBSblCCejg4nTtu7xKVESlfO3xPUtOmR7ng/oGNrbCE9WUDEU/kkqsuP3q
 MWnw==
X-Gm-Message-State: ABy/qLYfiKbvZE/mECSpeXnkLx56cTHyoVFnODLN9+wcIA53Ki3kuQCq
 xpFkmAv+hvEMOZZ/1DQnz8gGZ3dhKS8Yasdu9IT3aw==
X-Google-Smtp-Source: APBJJlHwRGfcgTkmCXO0iTM78xKQ04ufyb1LOGVNiqTP/MQ1nOCQr87M1NSbaKP0TekJpJ9C6OP+ddIOt0yXOGZrI1s=
X-Received: by 2002:aa7:c654:0:b0:51e:1af0:3a90 with SMTP id
 z20-20020aa7c654000000b0051e1af03a90mr4909539edr.37.1688767614795; Fri, 07
 Jul 2023 15:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230707204054.8792-1-richard.henderson@linaro.org>
 <20230707204054.8792-11-richard.henderson@linaro.org>
In-Reply-To: <20230707204054.8792-11-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 7 Jul 2023 16:06:48 -0600
Message-ID: <CANCZdfp+ePBJU_mF781FD_cDR0nqJBikeJ8u-oYJypthux0G2g@mail.gmail.com>
Subject: Re: [PATCH v2 08/24] bsd-user: Use page_check_range_empty for MAP_EXCL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, mjt@tls.msk.ru, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000c9d64205ffecd928"
Received-SPF: none client-ip=2a00:1450:4864:20::52d;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--000000000000c9d64205ffecd928
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 7, 2023 at 2:41=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> The previous check returned -1 when any page within
> [start, start+len) is unmapped, not when all are unmapped.
>
> Cc: Warner Losh <imp@bsdimp.com>
> Cc: Kyle Evans <kevans@freebsd.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

Warner


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
>              errno =3D EINVAL;
>              goto fail;
>          }
> --
> 2.34.1
>
>

--000000000000c9d64205ffecd928
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 7, 2023 at 2:41=E2=80=AFP=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">The previous check returned -1 when any page withi=
n<br>
[start, start+len) is unmapped, not when all are unmapped.<br>
<br>
Cc: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp=
@bsdimp.com</a>&gt;<br>
Cc: Kyle Evans &lt;<a href=3D"mailto:kevans@freebsd.org" target=3D"_blank">=
kevans@freebsd.org</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></block=
quote><div><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:im=
p@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>Warner<br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
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
eck_range_empty(start, end - 1)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000c9d64205ffecd928--

