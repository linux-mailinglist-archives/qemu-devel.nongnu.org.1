Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EF47EB591
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:35:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2xJX-0003VQ-8A; Tue, 14 Nov 2023 12:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1r2xJQ-0003Km-QS
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:34:57 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1r2xJO-0003fc-3M
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:34:56 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507be298d2aso7876607e87.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 09:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1699983290; x=1700588090;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=blsyRk39V/ANlXxzQcBkYSMkazcipaoOsxaydtw1nng=;
 b=l98XDbMIfZp5vQFs2Oj9dKCwDWt7EpyqGLkkC6YZ3WbpsspmyEVJXHRbHWsyOod7Em
 7mT3x2949kilr8kBBDNDRSzWqlkoCMk9Jgp8qOkdcM6+ZVmfatRoDKgeqRLch5EeujyZ
 gwhA83X8y12J608WddXhLAqvzNqrrcIPQiuMdYM1DtutP1CMGqr77AxpdPTqXXQPsmuF
 aWfM/Xk4GwJODE0SzEDuToyJxNCvhuGDtZMlWkl/q3KckHx3d3bZ5L7y/xJSjeUkWwLF
 0LE12GXdtvu8nmqrQUUkJ0S2SNY9yAkoYI16yy2yCB5eG4cFuSyv/B30xDXVG2qcOGrE
 cnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699983290; x=1700588090;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=blsyRk39V/ANlXxzQcBkYSMkazcipaoOsxaydtw1nng=;
 b=b1JMCxFZYYjUu2zWMtckDOuUyP9/K5XcURfQzAMENnjza0IeyvHGG6ZLLC5vn1EuOo
 MUTBHErprAKteQpigiLPMTxSHcg0KUG/hHPaE98QH0bz6cbDsoaYS/sGuhnVu7teFNJs
 /xhfU8kZ4hn+XNTc9zpSvfwvkovWejxnSbBT5PGHI3IEtpRO6+BFD4Sbm4jNsgcWsg/o
 Nz95zPhwV4VsITeU6Wp1kucYkR1Jj+I5d4R0UvmWq+1EJZzIG7cCDk3S7kFKSqSHffSb
 BiL8mpkIU33EYK6jN29AxlJhPXjdQrbnjtvZxhwnGmnoWqJlRMXtMerI0IzqoK9Zz3Ly
 UIjw==
X-Gm-Message-State: AOJu0Yyk57c+6evdrbNkg0w8Mv9azCB9toTg6m1fyDo7CWtGpenQLRoA
 8HRB9QXYIPi1f7KMX1y9pwFL5Pet+yeTe8QQPUJTaw==
X-Google-Smtp-Source: AGHT+IHK6dnSnbGOaVeKbIONgPltaOnsR6Wiy2HhR6hn5PUttjgwFtTGrdyJVUlaGMHUcdQWWTjmsqb+bvCiexFndjc=
X-Received: by 2002:a05:6512:234c:b0:500:7685:83d with SMTP id
 p12-20020a056512234c00b005007685083dmr10143345lfu.48.1699983289725; Tue, 14
 Nov 2023 09:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
 <20231114165834.2949011-2-mjt@tls.msk.ru>
In-Reply-To: <20231114165834.2949011-2-mjt@tls.msk.ru>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 14 Nov 2023 10:34:38 -0700
Message-ID: <CANCZdfr09Ej9rPVUvrUQwqSY97G7-kmyf8Zi8L3PKKpOo9A+Ww@mail.gmail.com>
Subject: Re: [PATCH trivial 01/21] bsd-user: spelling fixes: necesary,
 agrument, undocummented
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Stacey Son <sson@freebsd.org>, Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000001bcb45060a2034b6"
Received-SPF: none client-ip=2a00:1450:4864:20::132;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x132.google.com
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

--0000000000001bcb45060a2034b6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 9:58=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:

> Fixes: a99d74034754 "bsd-user: Implement do_obreak function"
> Fixes: 8632729060bf "bsd-user: Implement freebsd_exec_common, used in
> implementing execve/fexecve."
> Fixes: bf14f13d8be8 "bsd-user: Implement stat related syscalls"
> Cc: Stacey Son <sson@FreeBSD.org>
> Cc: Warner Losh <imp@bsdimp.com>
> Cc: Kyle Evans <kevans@freebsd.org>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  bsd-user/bsd-mem.h         | 2 +-
>  bsd-user/freebsd/os-proc.c | 2 +-
>  bsd-user/freebsd/os-stat.h | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)


Reviewed-by: Warner Losh <imp@bsdimp.com>

These changes are fine, and won't have any hassles with merging to our
not-yet-merged branch.

--0000000000001bcb45060a2034b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 14, 2023 at 9:58=E2=80=AF=
AM Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fixe=
s: a99d74034754 &quot;bsd-user: Implement do_obreak function&quot;<br>
Fixes: 8632729060bf &quot;bsd-user: Implement freebsd_exec_common, used in =
implementing execve/fexecve.&quot;<br>
Fixes: bf14f13d8be8 &quot;bsd-user: Implement stat related syscalls&quot;<b=
r>
Cc: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Cc: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp=
@bsdimp.com</a>&gt;<br>
Cc: Kyle Evans &lt;<a href=3D"mailto:kevans@freebsd.org" target=3D"_blank">=
kevans@freebsd.org</a>&gt;<br>
Signed-off-by: Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru" target=
=3D"_blank">mjt@tls.msk.ru</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0bsd-user/freebsd/os-proc.c | 2 +-<br>
=C2=A0bsd-user/freebsd/os-stat.h | 6 +++---<br>
=C2=A03 files changed, 5 insertions(+), 5 deletions(-)</blockquote><div><br=
></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">=
imp@bsdimp.com</a>&gt;</div><div><br></div><div>These changes are fine, and=
 won&#39;t have any hassles with merging to our not-yet-merged branch.</div=
></div></div>

--0000000000001bcb45060a2034b6--

