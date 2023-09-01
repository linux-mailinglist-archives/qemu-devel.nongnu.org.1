Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4618378F71A
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:27:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbts0-0002pd-2I; Thu, 31 Aug 2023 22:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qbtry-0002eH-5o
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:26:46 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qbtrv-00025d-CI
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:26:45 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99bdcade7fbso166717866b.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1693535201; x=1694140001;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hrzg9JqFL41LiiwxHvUbC6DuvkHczk7hmvOHpgZDroM=;
 b=L9wvzKZDynao/hHe61w83B95/XecK82MwZTENnr1oiYCHkN0J6Oko7YTqK22NYJRaj
 pZN++D87dh5FcL9j3ufFSIIscAHgKKxLj4oL15i1OQBgUMwfFwItN292WgrrSyWArd3Q
 FUMJ8ZW9RNO0b5wWScLxN4tw4h2hmk4rPsrObEgoRCDbXAKpsco6P4A0s7/OG2c6P7vP
 8mRL8IJipWlQc4y0W0dJyCo53QbHTgiY32m6anbxA6EA3hxPxPWhQFRh5gV7MMLSm1Nb
 FVPbYt0nz7tn4JoPQf+bluohEA9LcKh3lpQXim5eT4Ny7UgwX7lccM1pHn1JoNDGXdd0
 tp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535201; x=1694140001;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hrzg9JqFL41LiiwxHvUbC6DuvkHczk7hmvOHpgZDroM=;
 b=eiznVvoNzkGZY0C8tX5OJfCi7BQXgWwDIH3IeB0yP6hNAQZt3km4ltTx4UEpSDDizp
 v9N5GYzSbCTih/h2DfR8Xny9M2cnKXH379uBRTGSy/aUDuf+/s957DzyqAirLnWXueMO
 sShZgIptWzzzJyFvqfz8YTwKyI7FxMyE+KUSAeKXreNJC3nqk2nzdws5HpJTcdjhc1JD
 JDvuurWDandFIlxGKxx9hupP3a2xZSRp/AoAX6lWMOydGytLUaKWvdY4syYAagtLoAiU
 f39AL1KU0jYflAcVa79cyrINjG4CZwZrqZ15+oERQfOWTmwcY3pNRHrNRVx+UdW9ravM
 SC5Q==
X-Gm-Message-State: AOJu0YyqftizvN2S6BwzYGf2V8FZSJF9P5gpHGvId9gAc07+Adr7gkZV
 JlykP9z/i8ni3SjojKDLhFKlOph6VAArW1R2p3HCMDcRNnFdOuHQTcw=
X-Google-Smtp-Source: AGHT+IESDl56oRIEfzHl7XGDuZmUPeCQJIJovqVSK5bEwPwgVNKZdnnchWZcMDULEySerPHLuzpr8M5ZIALJcICkryw=
X-Received: by 2002:a17:906:224a:b0:9a4:88af:b77 with SMTP id
 10-20020a170906224a00b009a488af0b77mr774548ejr.60.1693535200943; Thu, 31 Aug
 2023 19:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230901022331.115247-1-richard.henderson@linaro.org>
 <20230901022331.115247-27-richard.henderson@linaro.org>
In-Reply-To: <20230901022331.115247-27-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 31 Aug 2023 20:26:31 -0600
Message-ID: <CANCZdfrQ+KszX=7EaWd7+vjUK4T+ou+zCavWcMH=NjmfcHxV_g@mail.gmail.com>
Subject: Re: [PATCH v2 26/33] *-user: Deprecate and disable -p pagesize
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, alex.bennee@linaro.org
Content-Type: multipart/alternative; boundary="000000000000113120060442e493"
Received-SPF: none client-ip=2a00:1450:4864:20::62d;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62d.google.com
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

--000000000000113120060442e493
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 8:23=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> This option controls the host page size.  From the mis-usage in
> our own testsuite, this is easily confused with guest page size.
>
> The only thing that occurs when changing the host page size is
> that stuff breaks, because one cannot actually change the host
> page size.  Therefore reject all but the no-op setting as part
> of the deprecation process.
>
> Cc: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  docs/about/deprecated.rst |  7 +++++++
>  docs/user/main.rst        |  3 ---
>  bsd-user/main.c           |  9 +++++----
>  linux-user/main.c         | 11 ++++++-----
>  4 files changed, 18 insertions(+), 12 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000113120060442e493
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 31, 2023 at 8:23=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">This option controls the host page size.=C2=A0 Fr=
om the mis-usage in<br>
our own testsuite, this is easily confused with guest page size.<br>
<br>
The only thing that occurs when changing the host page size is<br>
that stuff breaks, because one cannot actually change the host<br>
page size.=C2=A0 Therefore reject all but the no-op setting as part<br>
of the deprecation process.<br>
<br>
Cc: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp=
@bsdimp.com</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0docs/about/deprecated.rst |=C2=A0 7 +++++++<br>
=C2=A0docs/user/main.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ---<br>
=C2=A0bsd-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 9 +++=
++----<br>
=C2=A0linux-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 ++++++-----<b=
r>
=C2=A04 files changed, 18 insertions(+), 12 deletions(-)<br></blockquote><d=
iv><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp=
.com">imp@bsdimp.com</a>&gt;</div><div>=C2=A0<br></div></div></div>

--000000000000113120060442e493--

