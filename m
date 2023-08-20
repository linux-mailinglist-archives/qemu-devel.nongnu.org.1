Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E99F781C68
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:42:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXaGg-0007Mg-T3; Sun, 20 Aug 2023 00:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaGe-0007MY-EL
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:42:24 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaGc-0002OV-40
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:42:24 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so6875125a12.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692506539; x=1693111339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=10+qqe5OmKz3i5H5cWl5P95gk61KHXYRPmiQRoyT1CI=;
 b=bO9g/uI/gzRXwsKy38IV5llujl0esmtGG/BZo7fL2+T8DOdLi+o2f81RJAoe5ML/kw
 5B/pRqRVksoSYlPZ1/5z2gxUDGXx+osiTGs8+Xl4cKI5FAa3knwk7DzjfUUhzIwltbpd
 iWQaS9jWpD4GGJ+c5xvMUQA3WKJ8ZzrGogwpJvMYzbUgYryEygvoMMf/0pppo8HsKH9m
 c9cHSDNnm0masSV20gnbgoCBNfjKdIh4bLcJO7IxzrdCSCHcmwB5Y7y4sjvhYaF9ewZ4
 lC+4pwGqDHmgg3ykdPYWJ0YjMtob0fYZ8PYeS+jyr2eAHz047khpuInwnciOon1mF0lu
 kWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692506539; x=1693111339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=10+qqe5OmKz3i5H5cWl5P95gk61KHXYRPmiQRoyT1CI=;
 b=IMbopMuyuoHn+tmM3BOJMwGsvbxrvYa+jvmkFcDLbF0vpJ1YBY8YokuKEli3C+JPlz
 sEyMJojdhNqwFzq64bksy783XjsXl3qGX+q6//o3898N0SZAm2fSow8fcIxUosNH0Bvc
 oAgMdX0II7GN8RgyBsCu/YClyjvjiH1u4RpViBicQH9rSPeGJrLCg0VngiT9LxTecP/U
 xT0vYXVhpG2fyv4hRzuoV9UKjCOZZ+1mKnG97m61ttaan7LdQ3zn7/QWI5uSecDigYZC
 /h711KAmGS8UOTxjFE6z3BMkGgUtdj+G5g2/4KCILU8FqZr2dJ70K8LKRwygSZ67JIWx
 fyQg==
X-Gm-Message-State: AOJu0YyIwIfG4bRPNQbal6tEGlKF4/LdtSdQJ4kXPfCzFkZQEHIFURhQ
 yzJMvdOIX0f5otc7ZFThNdIttU/qqaIHA634NZDJpw==
X-Google-Smtp-Source: AGHT+IHormf/qQ7WKaM0gxa/9ectKM8SiX+0H4WEuZxNhTXte7fKzfjLqrVW95gNSrr5JeePY6cCt85H1vrb+V8i6kI=
X-Received: by 2002:a17:906:7693:b0:99b:cb59:79b3 with SMTP id
 o19-20020a170906769300b0099bcb5979b3mr3611880ejm.1.1692506539010; Sat, 19 Aug
 2023 21:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-19-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-19-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:42:11 -0600
Message-ID: <CANCZdfo9hoG2rWdkeTNbHKSx1EK6=M_Cb5m0pOPjh1kpnnQgcA@mail.gmail.com>
Subject: Re: [PATCH 18/22] Implement shm_open(2)
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000009bf510603536309"
Received-SPF: none client-ip=2a00:1450:4864:20::532;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x532.google.com
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

--00000000000009bf510603536309
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:49=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-mem.h            | 27 +++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  4 ++++
>  2 files changed, 31 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--00000000000009bf510603536309
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 3:49=E2=80=AF=
AM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" target=3D"_bl=
ank">kariem.taha2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Co-authored-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 27 ++++=
+++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 4 ++++<br>
=C2=A02 files changed, 31 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_=
blank">imp@bsdimp.com</a>&gt;<br><br>
 </div></div></div>

--00000000000009bf510603536309--

