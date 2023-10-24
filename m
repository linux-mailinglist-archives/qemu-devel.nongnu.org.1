Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC87D4ABB
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:45:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvD25-00031P-LD; Tue, 24 Oct 2023 04:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1qvD23-000315-VY; Tue, 24 Oct 2023 04:44:59 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1qvD22-0003xS-Eh; Tue, 24 Oct 2023 04:44:59 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53de0d1dc46so6757418a12.3; 
 Tue, 24 Oct 2023 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698137095; x=1698741895; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=90kjvmEq2n3m7ZBVpNnPhW5N9zX214BQucMupJIgixY=;
 b=ZHdgI10OEj5tnjpRz+XCz4BqtQSzG76UMae9o9/bdjcFmkP6YZg3K3xAOswQ7dS+QZ
 7KFB5avlqbVgG74P5Xgv19eBq2QAzFHfnBH0FY3y4N2PGZTp287U4VUeq00qWFJB500c
 ZTeUZ/kNuFlvxnmeXkMb/yWKjJT2T5tOujq+aHzhx+lNLsiUrFQDEVzkwUto7n3Ii6C6
 6FTFRZD1HJmslTFmePU2TD9ozkGilz3mPJXeAH8OFPO3bAZvrhKB0RpviX0e+qc5wUxF
 Oxhg+A84c5snZo1XcqfxDC6TZ554oWg/BzlSAAjODyilupFQ1TapYZz3oNjOd5e6SKIy
 V5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698137095; x=1698741895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=90kjvmEq2n3m7ZBVpNnPhW5N9zX214BQucMupJIgixY=;
 b=JKglxDFcJi+rqnHAgu1uWqKN3qY8XyIR7E0Ui+2qcBLXAcWmrdtLNzBp2UEQLfmXVu
 Ui59x9/8mwURlOyXmfmCn0pgUKU2Lv0+AQfcRoBjQh6CUmorqbWT9gxmyUcibNz8MmrI
 GokhFCP62vDV8bIKSxrpAZeb822KlbZADKC5LtIKNwL9Zf1T6Yq9fTudRmtace9OlE7h
 l0zkk1f4CDn88A5OaUtax8VZyxExJL2Adq4uP51m97ofHoHDZd9IXrhVmFjFoYUXuJlU
 8f50/fm8GIJ13ErVsvwd9NBmq4Og034dp9TVVpChiSKf+xQSIMlxLsk6JF7csPBVHGVV
 EshA==
X-Gm-Message-State: AOJu0YwtA18fsfYlyDKMeV/MSDCWJhqNoZEO6GCdaD6jPoudyvYskoF7
 +qrJK+Hsso14zE7TKDb+JoJIxlNQTDMFeZLWssAuFo6rwFIcHg==
X-Google-Smtp-Source: AGHT+IGShYVTEq0vzjjYKpZWy5kNRRWdxZQVhdKPgCO7aAHR8e49LssOTniJbaH7Fz8UppEbH4uouQEn0WO50gIc+3Y=
X-Received: by 2002:a17:907:a03:b0:9c6:4dec:b1eb with SMTP id
 bb3-20020a1709070a0300b009c64decb1ebmr8169426ejc.44.1698137095286; Tue, 24
 Oct 2023 01:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-3-philmd@linaro.org>
 <e7eb7fb3-81e4-4355-94d4-0e542d7e606c@linaro.org>
In-Reply-To: <e7eb7fb3-81e4-4355-94d4-0e542d7e606c@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 24 Oct 2023 10:44:44 +0200
Message-ID: <CAJy5ezp2L3DgOGf31biMvpJv4qJ8xQm0rZ8XGtTVFY4OpKcAjg@mail.gmail.com>
Subject: Re: [PATCH 2/9] target/cris: Use tcg_gen_extract_tl
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: multipart/alternative; boundary="0000000000005834400608725ae7"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x533.google.com
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

--0000000000005834400608725ae7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 1:36=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 10/23/23 09:09, Philippe Mathieu-Daud=C3=A9 wrote:
> > Inspired-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   target/cris/translate.c     | 3 +--
> >   target/i386/tcg/translate.c | 9 +++------
> >   2 files changed, 4 insertions(+), 8 deletions(-)
>
> Accidental merge of two patches, but they both look fine.  :-)
>
> With the split, to both:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
>
CRIS part looks good with Richard's request to split:
Reviewed-by: Edgar E. Iglesias <edgar@zeroasic.com>



> r~
>

--0000000000005834400608725ae7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 24, 2023 at 1:36=E2=80=AF=
AM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 10/23/23 09:09, Philippe Mathieu-Daud=C3=A9 wr=
ote:<br>
&gt; Inspired-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson=
@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/cris/translate.c=C2=A0 =C2=A0 =C2=A0| 3 +--<br>
&gt;=C2=A0 =C2=A0target/i386/tcg/translate.c | 9 +++------<br>
&gt;=C2=A0 =C2=A02 files changed, 4 insertions(+), 8 deletions(-)<br>
<br>
Accidental merge of two patches, but they both look fine.=C2=A0 :-)<br>
<br>
With the split, to both:<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
<br></blockquote><div><br></div><div>CRIS part looks good with Richard&#39;=
s request to split:</div><div>Reviewed-by: Edgar E. Iglesias &lt;<a href=3D=
"mailto:edgar@zeroasic.com">edgar@zeroasic.com</a>&gt;</div><div><br></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
r~<br>
</blockquote></div></div>

--0000000000005834400608725ae7--

