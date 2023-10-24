Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD107D4868
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 09:23:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvBjk-0005S6-S3; Tue, 24 Oct 2023 03:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>)
 id 1qvBjf-0005RK-VC; Tue, 24 Oct 2023 03:21:56 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>)
 id 1qvBje-0004h9-D4; Tue, 24 Oct 2023 03:21:55 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-457bac7c3f5so1741160137.2; 
 Tue, 24 Oct 2023 00:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698132112; x=1698736912; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z3XkMZz1feiAlHSZhXxhBpQp5+YAl+omoU5ZAhqJsw4=;
 b=iMCJFpZKNibWhTKPyKUe4bF6cirdUWutGj7kUUZUrW5cX++hv2FSu3ItIfa6o9HqJ2
 ZSxnbPtTn0vnoG9slEGkqK2V/mqL5DZJu0RAGG6R3WwkJ0NgUQqx78VZI+u+sZ7Qe0u0
 cVNBMfErAhjsbKPGIV7epxDStuI7CFOeTKgzA2+4egtxVfeY73Be8YMng1TxRCaxQwYi
 IL2KF+vyyDQDhwgzLy5Wc1dUF6CLZzqw831kBSk1olKonDKb0wvDexD/zG8gTiNbN8VI
 adPFT9OV1SJUb7RXr6THlDukISnndkNXLSPqN9+CilNyFsi1khU6woyioy6vPnsLy2+F
 ZoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698132112; x=1698736912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z3XkMZz1feiAlHSZhXxhBpQp5+YAl+omoU5ZAhqJsw4=;
 b=rE3BTw5xzAMepMklDsPwCyYIpz3yeLjovu1P3kgl4Dl1X8w8hussxzE3fzE0+vQ66i
 F7D3hz1lWjsuoxcRam2qC7Q1L5VdrjswSpMYFBGf1VzMwdu+GihDhpt+hbU5xOhWG0OU
 eyznSFuZeX2qWV6e2Pl86iEzkc1KLUy6XtI/3NS3xRHporYMfjf3MaoWI4CZ05JZWxFf
 4MQqsIANREN9ydySK737dAUNr7LqpJJnGBFG7keriNKCPlWJHO6VuGqI1qWWGGbjgM59
 L+6oiCrxpP9EI7EVLdlFe9DRzvUzTTm2kWJIx8ZC2nwJY9ntcve7MzqY89sSBrUy2oRd
 rS8A==
X-Gm-Message-State: AOJu0YyQaRgwPVwQcjB3ZwwGQVqAUJHXvvpgEmxWFGCm0WvVlCWeDgqE
 ooFt5dnUeVcPQ9Fk/UMmi8NH7WgtA8+QXQLqmmzm40pti06CRQ==
X-Google-Smtp-Source: AGHT+IFhBmT0tOj3VCEka1Wbe46eq5zUtoUh0mq1W7JliUeYgCTxt3fzRoDdihF0XiASLVAauwmm2PH20vG0dV+yyEI=
X-Received: by 2002:a67:c29c:0:b0:457:fbe2:b8f with SMTP id
 k28-20020a67c29c000000b00457fbe20b8fmr10746431vsj.10.1698132112299; Tue, 24
 Oct 2023 00:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-2-philmd@linaro.org>
 <e978d05e-b744-4663-ab45-5a12e7b97537@linaro.org>
In-Reply-To: <e978d05e-b744-4663-ab45-5a12e7b97537@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Tue, 24 Oct 2023 10:21:15 +0300
Message-ID: <CAK4993h3nF5C6uWQz2W62pBS78UQpr3W0N8-xHbCfTU2M2gy_w@mail.gmail.com>
Subject: Re: [PATCH 1/9] target/avr: Use tcg_gen_extract_tl
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000055de3106087131e5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=mrolnik@gmail.com; helo=mail-vs1-xe2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000055de3106087131e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Michael Rolnik <mrolnik@gmail.com>

On Tue, Oct 24, 2023 at 2:32=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 10/23/23 09:09, Philippe Mathieu-Daud=C3=A9 wrote:
> > Inspired-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   target/avr/translate.c | 18 ++++++------------
> >   1 file changed, 6 insertions(+), 12 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> r~
>


--=20
Best Regards,
Michael Rolnik

--00000000000055de3106087131e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@=
gmail.com">mrolnik@gmail.com</a>&gt;</div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 24, 2023 at 2:32=E2=80=AFAM=
 Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">rich=
ard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On 10/23/23 09:09, Philippe Mathieu-Daud=C3=A9 wrot=
e:<br>
&gt; Inspired-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson=
@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/avr/translate.c | 18 ++++++------------<br>
&gt;=C2=A0 =C2=A01 file changed, 6 insertions(+), 12 deletions(-)<br>
<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
r~<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Be=
st Regards,<br>Michael Rolnik</div>

--00000000000055de3106087131e5--

