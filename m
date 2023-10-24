Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D567D4AB1
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:43:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvD05-000105-LX; Tue, 24 Oct 2023 04:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1qvD03-0000mG-3g; Tue, 24 Oct 2023 04:42:55 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1qvD01-0003hb-0o; Tue, 24 Oct 2023 04:42:54 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso6496867a12.1; 
 Tue, 24 Oct 2023 01:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698136970; x=1698741770; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wkSC/KRcD0vdxRtbYI2K30HOA1oRU/2QkShpD0VdHVw=;
 b=UdW54QM6wB7vZNUqSo9LGDo0RLLpLul16tH/8nGxqN/l4iisy0QhslLr+aDXEyOwJS
 FZarsM+S1Nh+TRUI3C30uluw+00N5RHoc2ngUWyDEmSsgNK6O721lop1yirpGHMhNodA
 OO4NUI9Ww7E70Cfvgngk8pIP0xrxXIt+HHLKxIEZHsqk2sWQOf78+7eTCsYCtXxa55iG
 IOSgJGGsQd//Utz6N7YKfBK8v4W4MeRAU6n0U1y8AQyV+xwv1BAzN7OfYfzMiYvaL6zD
 pjOWjXG1z9+r2irAGQxeICdh/cGJDgR8tTmprxewhLBgBQBwaYLa6VlsasKt+IiKbrNQ
 42wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698136970; x=1698741770;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wkSC/KRcD0vdxRtbYI2K30HOA1oRU/2QkShpD0VdHVw=;
 b=ONEccM4TRG/sARp/cxanhvbCPvji0Nv87odanng1E3DjeDVocW8IsplUbcSQbOBunM
 DDscowMciI7/nZh8E1zJVSULGXSmCuOUiu6KJYH66UB9dNGpfZhII6eBvJHBgxQVuh5z
 P1sIuUf/pu3t4x6KFx90fsRif3ahvHo105nR4z9j90uIBiad1ntz4B5zzHbGRyoaTos8
 vNHtbh/PWiL+JE09weq1OWa079nDnskW7QG8wRNrmXwC3qTTQSxkHowlDXS1et7oRpxS
 tp7Hwy+gnDwCjbjut10+Ob+IhhMCGbzrInEne1V/grrGtjG+5NEUykvybfB8HZ2kxgue
 roOw==
X-Gm-Message-State: AOJu0Yy5/gJJ5UKJ1Yq7GWEucIfM9L+W7c0kH+vFZvNGXL0UCd0TKLbo
 CINKcvtrLln0BQ2E1e0EJDtWw00jcDDl3c+8Aeg=
X-Google-Smtp-Source: AGHT+IHHq3lQj9gl5NM9iyPoX1dmUDszJQDrvDKdvq575HtBoqPeCjuivM/pwIfhPvQe1IG/pBlF/utIUZ8BTdWnMwQ=
X-Received: by 2002:a50:d716:0:b0:53e:ec17:c885 with SMTP id
 t22-20020a50d716000000b0053eec17c885mr7975618edi.10.1698136970216; Tue, 24
 Oct 2023 01:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-9-philmd@linaro.org>
 <db537981-e8ee-419c-9bc1-d9092ec60deb@linaro.org>
In-Reply-To: <db537981-e8ee-419c-9bc1-d9092ec60deb@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 24 Oct 2023 10:42:38 +0200
Message-ID: <CAJy5ezraq5xpW4F+xAhNyyef+n0=op8bh3uqzVqegKhtfts9Xw@mail.gmail.com>
Subject: Re: [RFC PATCH 8/9] target/cris: Use tcg_gen_sextract_tl
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e3d3690608725205"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52b.google.com
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

--000000000000e3d3690608725205
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 2:26=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 10/23/23 09:09, Philippe Mathieu-Daud=C3=A9 wrote:
> > Inspired-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> > RFC: please double-check bits
> > ---
> >   target/cris/translate.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/target/cris/translate.c b/target/cris/translate.c
> > index 65b07e1d80..3a161f8f73 100644
> > --- a/target/cris/translate.c
> > +++ b/target/cris/translate.c
> > @@ -336,8 +336,7 @@ static void t_gen_cris_mstep(TCGv d, TCGv a, TCGv b=
,
> TCGv ccs)
> >        */
> >       t =3D tcg_temp_new();
> >       tcg_gen_shli_tl(d, a, 1);
> > -    tcg_gen_shli_tl(t, ccs, 31 - 3);
> > -    tcg_gen_sari_tl(t, t, 31);
> > +    tcg_gen_sextract_tl(t, ccs, 3, 1);


> tcg_gen_sextract_tl(t, ccs, ctz32(N_FLAG), 1);
>

Looks good!

I think the intent was a branch-free version of:
if (ccs & N_FLAG) {
    d +=3D b;
}

Or:
t =3D ccs & N_FLAG ? UINT32_MAX : 0;
d +=3D b & t;



>
> Also, it appears t_gen_cris_mstep consumes CCS without making sure that i=
t
> is up-to-date.
> Edgar?
>
>
Yes, that looks suspicious!

Best regards,
Edgar


>
> r~
>

--000000000000e3d3690608725205
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Oct 24, 2023 at 2:26=E2=80=AFAM R=
ichard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richar=
d.henderson@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On 10/23/23 09:09, Philipp=
e Mathieu-Daud=C3=A9 wrote:<br>
&gt; Inspired-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson=
@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt; RFC: please double-check bits<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/cris/translate.c | 3 +--<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/cris/translate.c b/target/cris/translate.c<br>
&gt; index 65b07e1d80..3a161f8f73 100644<br>
&gt; --- a/target/cris/translate.c<br>
&gt; +++ b/target/cris/translate.c<br>
&gt; @@ -336,8 +336,7 @@ static void t_gen_cris_mstep(TCGv d, TCGv a, TCGv =
b, TCGv ccs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0t =3D tcg_temp_new();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_shli_tl(d, a, 1);<br>
&gt; -=C2=A0 =C2=A0 tcg_gen_shli_tl(t, ccs, 31 - 3);<br>
&gt; -=C2=A0 =C2=A0 tcg_gen_sari_tl(t, t, 31);<br>
&gt; +=C2=A0 =C2=A0 tcg_gen_sextract_tl(t, ccs, 3, 1);</blockquote><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
tcg_gen_sextract_tl(t, ccs, ctz32(N_FLAG), 1);<br></blockquote><div><br></d=
iv><div>Looks good!</div><div><br></div><div>I think the intent was a branc=
h-free version of:</div><div><div>if (ccs &amp; N_FLAG) {</div><div>=C2=A0 =
=C2=A0 d=C2=A0<a class=3D"gmail_plusreply" id=3D"gmail-plusReplyChip-3">+=
=3D b;</a></div><div>}</div></div><div><br></div><div>Or:</div><div>t =3D c=
cs &amp; N_FLAG ? UINT32_MAX : 0;</div><div>d=C2=A0+=3D b &amp; t;</div><di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
Also, it appears t_gen_cris_mstep consumes CCS without making sure that it =
is up-to-date.<br>
Edgar?<br>
<br></blockquote><div><br></div><div>Yes, that looks suspicious!</div><div>=
<br></div><div>Best regards,</div><div>Edgar</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
r~<br>
</blockquote></div></div>

--000000000000e3d3690608725205--

