Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00961724AF4
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 20:11:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6b7C-0004La-PB; Tue, 06 Jun 2023 14:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1q6b7A-0004KP-3Q
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 14:09:04 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1q6b76-0008Bj-Nn
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 14:09:03 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-514924ca903so9126015a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1686074938; x=1688666938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GU/nqjDORllfrGp54GrGmgsFS921vMifSD9SzA9qufg=;
 b=Y41pqUhq6kw7Wzdg0y4nGuk7BCM3V7/SoZUTGyVzQ7zpCo4zhu1bFSWWS/NmQ7RUJh
 X+cZBn0IBwNZOfIpJO1zUeQkFqzLHkaeWkmER66LGEaUSPI9FZwwaAwLBd0zA5Ioe2UE
 IGXQDRV55c0LqD/LCQHsxvOpow8kntQNxYfV5RQJBMbb2F0vrJ3X4cpQMpp38GqoieIa
 bo+vSFQoEgRuINJZ0Ng4ZgYmhWCpSo4qgpE8LQSOzAk8aotjgT5BGg9xPqEA9SEs6+6m
 T8yVQTmRxqGR/T++Fqi7l5pGxITtwQ4inPUkt8q3V6pnBelaFCvub1LkMN5Jz6Q9w/4j
 v0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686074938; x=1688666938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GU/nqjDORllfrGp54GrGmgsFS921vMifSD9SzA9qufg=;
 b=d9+j1Pkxj1JXumlbYbcKkbLHnaJLuMqcEuu0zXepOO9GnMa4wQr56ftwF5syFxYPYk
 yvA15XE+lackeQBC0DstgF/RMFfvLZXBZit3hKXBBgKmfNiGMVwsLycygr1OdQg/7W2R
 uRFLSvgepcMQ6S8ThtNLXFyIcSrQBHEOkAet/ZcDPosyYY+Jvu4ox3ePPdzIO8BzQIpa
 2yAorcMFRU51EL5luZYtQyzxLmcPlSA3ToEBOhK++2LXeLTM/spz062OQo8CnSKq3ZhM
 B3lsiTK4M3LHd/7k8zd/hBLGb4JhSLwHTzfvG/7ybXHLWzU4Yy+J4PceCqghcwXe4hZ6
 LMcw==
X-Gm-Message-State: AC+VfDwfGz0IrUdqJldS9lPdZbNplADSSAEygWHuz1mstS1D+B9WG16Y
 FzwrmJ+TpHsQz3Q5XZcVTAc5l7Y4JdS5L3P9Uu5v8nmnoAjiZi+O
X-Google-Smtp-Source: ACHHUZ4DRbKpedXPQQZ7Kp5g73YIB8roNV8YFIOhF5HR5ypmoRLea7LdllUIIghXje+pHRBnmc5IR2BsKc3QZQylh/k=
X-Received: by 2002:a17:906:730c:b0:96f:f98c:ac71 with SMTP id
 di12-20020a170906730c00b0096ff98cac71mr2948296ejc.67.1686074938443; Tue, 06
 Jun 2023 11:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230606141252.95032-1-philmd@linaro.org>
 <20230606141252.95032-2-philmd@linaro.org>
 <c28e9cf1-5fa2-c63d-bb59-fbb4555e0150@linaro.org>
In-Reply-To: <c28e9cf1-5fa2-c63d-bb59-fbb4555e0150@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 6 Jun 2023 12:08:47 -0600
Message-ID: <CANCZdfqjr8om2juzBN_BqTuoyGBq7zEuM1+J5-J3OP55qg5h9Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] bsd-user: Rename elfcore.c -> elfcore.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c559b705fd79e94b"
Received-SPF: none client-ip=2a00:1450:4864:20::534;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000c559b705fd79e94b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 6, 2023 at 8:29=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/6/23 07:12, Philippe Mathieu-Daud=C3=A9 wrote:
> > Since commit 139c1837db ("meson: rename included C source files
> > to .c.inc"), QEMU standard procedure for included C files is to
> > use *.c.inc.
> >
> > Besides, since commit 6a0057aa22 ("docs/devel: make a statement
> > about includes") this is documented as the Coding Style:
> >
> >    If you do use template header files they should be named with
> >    the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
> >    being included for expansion.
> >
> > Therefore rename the included 'elfcore.c' as 'elfcore.c.inc'.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9<philmd@linaro.org>
> > ---
> >   bsd-user/elfload.c                    | 2 +-
> >   bsd-user/{elfcore.c =3D> elfcore.c.inc} | 0
> >   2 files changed, 1 insertion(+), 1 deletion(-)
> >   rename bsd-user/{elfcore.c =3D> elfcore.c.inc} (100%)
>
> Assuming Warner doesn't simply want to merge this small file, or compile
> it separately. It
> isn't actually included more than once.
>

I'd much rather inline it in elfload.c I did the include trick as a
short-term
hack so I didn't have to upstream ALL of the core dump support to get
progress on other things in elfload.c.

So rather than rename it (which will cause some grief to me when I merge
things, but not a huge amount), it would be better to just inline what's
upstream now and I'll reconcile that when I upstream core dump support.

Warner

--000000000000c559b705fd79e94b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 6, 2023 at 8:29=E2=80=AFA=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 6/6/23 07:12, Philippe Mathieu-Daud=C3=A9 wrote=
:<br>
&gt; Since commit 139c1837db (&quot;meson: rename included C source files<b=
r>
&gt; to .c.inc&quot;), QEMU standard procedure for included C files is to<b=
r>
&gt; use *.c.inc.<br>
&gt; <br>
&gt; Besides, since commit 6a0057aa22 (&quot;docs/devel: make a statement<b=
r>
&gt; about includes&quot;) this is documented as the Coding Style:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 If you do use template header files they should be named =
with<br>
&gt;=C2=A0 =C2=A0 the ``.c.inc`` or ``.h.inc`` suffix to make it clear they=
 are<br>
&gt;=C2=A0 =C2=A0 being included for expansion.<br>
&gt; <br>
&gt; Therefore rename the included &#39;elfcore.c&#39; as &#39;elfcore.c.in=
c&#39;.<br>
&gt; <br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9&lt;<a href=3D"mailto:philmd=
@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 =C2=A0bsd-user/{elfcore.c =3D&gt; elfcore.c.inc} | 0<br>
&gt;=C2=A0 =C2=A02 files changed, 1 insertion(+), 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0rename bsd-user/{elfcore.c =3D&gt; elfcore.c.inc} (100%)<b=
r>
<br>
Assuming Warner doesn&#39;t simply want to merge this small file, or compil=
e it separately. It <br>
isn&#39;t actually included more than once.<br></blockquote><div><br></div>=
<div>I&#39;d much rather inline it in elfload.c I did the include trick as =
a short-term</div><div>hack so I didn&#39;t have to upstream ALL of the cor=
e dump support to get</div><div>progress on other things in elfload.c.</div=
><div><br></div><div>So rather than rename it (which will cause some grief =
to me when I merge</div><div>things, but not a huge amount), it would be be=
tter to just inline what&#39;s</div><div>upstream now and I&#39;ll reconcil=
e that when I upstream core dump support.</div><div><br></div><div>Warner</=
div></div></div>

--000000000000c559b705fd79e94b--

