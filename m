Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5C3819051
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:06:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfPk-0005bd-6g; Tue, 19 Dec 2023 14:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rFfPO-0005Rr-AM; Tue, 19 Dec 2023 14:05:40 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rFfPL-0000DE-Ms; Tue, 19 Dec 2023 14:05:38 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dbd04e7d183so3168401276.1; 
 Tue, 19 Dec 2023 11:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703012734; x=1703617534; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o1gkDaoRWnuKADigBfLJemgjsZtPwZTBeG2A0bj8Ekw=;
 b=D7LJyZPDYd315bBmxEGlRGrmPYfOyIm7fl6SFSNpvDuERW8xtYqMo46EquWSpvoRvW
 WRPZoBe1fX3TpPcpt2URsKpZ4LRWXWyhZDCwXLIt72bsDa/Mch5eybcZKFpKaEW5OZr9
 U7kAn/tzMVT8BLA/9jyGYwpzAq2DogkikguL/gYCnWls3a5CBEnJa0banZLGdRNei011
 w3n5tXKvTxWYDKaXH8jf9+Z/h64sO751LJTqmf9mwvc/3hXSf4YeI1y+krA7/h7svxoh
 YvURoqneb+AO1jmN4arVSFCmz1kd6ZDV9mP4R/jpUFK1vZnzYda2dJI4PZ+IFkJzK/cw
 +j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703012734; x=1703617534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o1gkDaoRWnuKADigBfLJemgjsZtPwZTBeG2A0bj8Ekw=;
 b=ksjjJ0bdzU2zhl05m/pfFB3ALAMA45n/Seh9xLOZGr5W/vT3wYiQIrAYati4xYebra
 tAC4gNgVAIKeu/Mzjr2n+nYEsMrobqoWXjWVgf1/yPx0lG3ipkkF0/e8FAxDdNH2FtJD
 2uNCCKlGhyiTEYuS37Wb3RkZWkqjRORMCN56oiZjhn2qFJzUX0E2J2aGaZa/tq3I4ILz
 2F5T1vrfYiVcV1xntIwBralib0K6J9kHzoP0VB3j01FVzgrYBpBI4YUcB8FBZQmOsIni
 W4ILAYbH6wSbCmk5QkmjPc9ZZRxiGaA+L8TxwTovgA3++wOFxnl0sK5TzFYd6GP2iGsA
 gk8Q==
X-Gm-Message-State: AOJu0Yxk2K+m0dNDnI2XjVcbKCAosA40oXEbLysaTH+81rR7sfCiGh8j
 hx5bvgJUyKsKoZDQnzjzcfI6o36A/Xd42mw5YQU=
X-Google-Smtp-Source: AGHT+IGtrHqBQBZ0t145CgYT0nzCA1SitvjG9jnWdv7R7cMUUYXGNCG98K+3tICnop82SRb9bytBE8nKlEThpC7H6MI=
X-Received: by 2002:a25:83cf:0:b0:dbd:4a26:957d with SMTP id
 v15-20020a2583cf000000b00dbd4a26957dmr1718559ybm.85.1703012734354; Tue, 19
 Dec 2023 11:05:34 -0800 (PST)
MIME-Version: 1.0
References: <20231219105510.4907-1-n.ostrenkov@gmail.com>
 <CAFEAcA-Gp-8ooEhHazJg5Q-xyQ5xB2ox2+fU_tNBYV0HTkwg6A@mail.gmail.com>
In-Reply-To: <CAFEAcA-Gp-8ooEhHazJg5Q-xyQ5xB2ox2+fU_tNBYV0HTkwg6A@mail.gmail.com>
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Date: Tue, 19 Dec 2023 22:05:23 +0300
Message-ID: <CAC8KSA0F-QtkS5T7fcEM=+iuVCNAk88SYUUcVaTKG2hXNn2Uhw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: add cache controller for Freescale i.MX6
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000144bae060ce18d1f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-yb1-xb34.google.com
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

--000000000000144bae060ce18d1f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

thanks for letting me know! Enjoy your holidays.

=D0=B2=D1=82, 19 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3., 19:08 Peter Mayd=
ell <peter.maydell@linaro.org>:

> On Tue, 19 Dec 2023 at 10:55, Nikita Ostrenkov <n.ostrenkov@gmail.com>
> wrote:
> >
> > Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> > ---
> >  hw/arm/Kconfig    | 1 +
> >  hw/arm/fsl-imx6.c | 3 +++
> >  2 files changed, 4 insertions(+)
>
> Thanks for this patch; it looks fairly obviously right,
> but I wanted to let you know I won't be able to do proper patch
> review and take it into the arm queue until I get back from holidays
> in January.
>
> -- PMM
>

--000000000000144bae060ce18d1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">thanks for letting me know! Enjoy your holidays.</div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=
=82, 19 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3., 19:08 Peter Maydell &lt;<=
a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt;=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">On Tue, 19 Dec 2023 at 10:55, Nik=
ita Ostrenkov &lt;<a href=3D"mailto:n.ostrenkov@gmail.com" target=3D"_blank=
" rel=3D"noreferrer">n.ostrenkov@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Signed-off-by: Nikita Ostrenkov &lt;<a href=3D"mailto:n.ostrenkov@gmai=
l.com" target=3D"_blank" rel=3D"noreferrer">n.ostrenkov@gmail.com</a>&gt;<b=
r>
&gt; ---<br>
&gt;=C2=A0 hw/arm/Kconfig=C2=A0 =C2=A0 | 1 +<br>
&gt;=C2=A0 hw/arm/fsl-imx6.c | 3 +++<br>
&gt;=C2=A0 2 files changed, 4 insertions(+)<br>
<br>
Thanks for this patch; it looks fairly obviously right,<br>
but I wanted to let you know I won&#39;t be able to do proper patch<br>
review and take it into the arm queue until I get back from holidays<br>
in January.<br>
<br>
-- PMM<br>
</blockquote></div>

--000000000000144bae060ce18d1f--

