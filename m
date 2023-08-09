Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87682775077
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 03:41:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTYBC-0006F3-HF; Tue, 08 Aug 2023 21:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTYB9-0006EV-TV
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 21:40:04 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTYB7-00036P-58
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 21:40:03 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52340d9187aso2068106a12.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 18:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1691545196; x=1692149996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CUII7qu/6z3+NcscjshpiqpPVCk1e+bPcaVDqCkeCgU=;
 b=J//aXs+B3eZTxm04Dts5WYfxIfkl3cU2xcSNIhiMfyAFtmcKRHCZvuwZTdBNUA1KNS
 PAVWoFTxU7fb4d3y9bniFri1GwCiUgZdJ895xPafDPPdeUlN7OFZjsCQyKBDJBDU8GQ/
 +pxzLS9XL5ifpasibFWyFe2y4haULJepghZ1E4wF9eCPQJzJIKEfJ3gDpPk0iSFBR7hn
 os73nuYb/h4RLtlo++/09Doj+XspMmitx1y3rWxz2h6vOs1XDBwvyruoPSzA9rjFy9zw
 n9Oy/caPKexv3jKx6qoC3veP2xRaxhZSDyFEgr1njiw+suG5IjmW1AgX9cPOLCzRKeHK
 DqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691545196; x=1692149996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CUII7qu/6z3+NcscjshpiqpPVCk1e+bPcaVDqCkeCgU=;
 b=Og2R8jio1uzaKqKAdBcPhRa85J9NqcGmSd5NEHfR+IzLzzJiMB/BThq1yhy45pECZz
 vQXC19KTynu+RebZBds9AbJssAiQbYmzA78SRwAL+X3xAViXkEUA197w4nzZk1+5Stlm
 K0cNsgmx+i0gCPpp3CT7euRevmGS3+YnXV4JwdZ0VEVbev7asjIpfqAR+kbXBAqXHjIz
 /tr3TOD4CtkCGipi9QmaDbYjVc4/cb9eAwJ/9TcQa0eyyzEHPBWYwvX0FuAt0vAi4Wre
 +p4TtdOk1VFXp3BBy0Hcb8SyYBnRW14fGnXRp9KJIGEjKvi7kdVaCdviEjvo4cd85vK8
 xQ9w==
X-Gm-Message-State: AOJu0YwpVJoliZpTlNFxjIZmhSn0MRpEbjAPYv67wdz3ptW0A97fgvYQ
 jjqScPvJWI+T9Q0H2h8KEX743B6US3/wIMOYclFE7g==
X-Google-Smtp-Source: AGHT+IG+vCHOHXg5j4TePmCV+IvnkWSCC+DcK7S9lKIOhpeQ3qM6GI3teqQyM3AWvpr4N+B3urppmP8q7gld6Vf6eVs=
X-Received: by 2002:a17:907:75c5:b0:997:decf:11e7 with SMTP id
 jl5-20020a17090775c500b00997decf11e7mr998648ejc.12.1691545196416; Tue, 08 Aug
 2023 18:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-4-kariem.taha2.7@gmail.com>
 <d9caacde-d8ab-2fdc-372a-20988f22267c@linaro.org>
In-Reply-To: <d9caacde-d8ab-2fdc-372a-20988f22267c@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 8 Aug 2023 19:39:47 -0600
Message-ID: <CANCZdfoMCNF-SuBz5Ab=rmeW+1VLbR4mcUvfYqkbuV91rdtyPg@mail.gmail.com>
Subject: Re: [PATCH 03/33] Update the definitions of __put_user and __get_user
 macros
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008de4740602738ef9"
Received-SPF: none client-ip=2a00:1450:4864:20::52b;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52b.google.com
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

--0000000000008de4740602738ef9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 8, 2023 at 3:03=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/7/23 23:07, Karim Taha wrote:
> > From: Warner Losh <imp@bsdimp.com>
> >
> > Use __builtin_choose_expr to avoid type promotion from ?:
> > in __put_user_e and __get_user_e macros.
> > Copied from linux-user/qemu.h, originally by Blue Swirl.
> >
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> > ---
> >   bsd-user/qemu.h   | 81 ++++++++++++++++++++--------------------------=
-
> >   bsd-user/signal.c |  5 +--
> >   2 files changed, 35 insertions(+), 51 deletions(-)
> >
> > diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> > index dfdfa8dd67..c41ebfe937 100644
> > --- a/bsd-user/qemu.h
> > +++ b/bsd-user/qemu.h
> > @@ -307,50 +307,37 @@ static inline bool access_ok(int type, abi_ulong
> addr, abi_ulong size)
> >   #define PRAGMA_REENABLE_PACKED_WARNING
> >   #endif
> >
> > -#define __put_user(x, hptr)\
> > -({\
> > -    int size =3D sizeof(*hptr);\
> > -    switch (size) {\
> > -    case 1:\
> > -        *(uint8_t *)(hptr) =3D (uint8_t)(typeof(*hptr))(x);\
> > -        break;\
> > -    case 2:\
> > -        *(uint16_t *)(hptr) =3D tswap16((typeof(*hptr))(x));\
> > -        break;\
> > -    case 4:\
> > -        *(uint32_t *)(hptr) =3D tswap32((typeof(*hptr))(x));\
> > -        break;\
> > -    case 8:\
> > -        *(uint64_t *)(hptr) =3D tswap64((typeof(*hptr))(x));\
> > -        break;\
> > -    default:\
> > -        abort();\
> > -    } \
> > -    0;\
> > -})
> > +#define __put_user_e(x, hptr, e)
>     \
> > +    do {
>     \
> > +        PRAGMA_DISABLE_PACKED_WARNING;
>     \
> > +        (__builtin_choose_expr(sizeof(*(hptr)) =3D=3D 1, stb_p,
>      \
> > +        __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 2, stw_##e##_p,
>     \
> > +        __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 4, stl_##e##_p,
>     \
> > +        __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 8, stq_##e##_p,
> abort))))  \
> > +            ((hptr), (x)), (void)0);
>     \
> > +        PRAGMA_REENABLE_PACKED_WARNING;
>      \
> > +    } while (0)
> > +
> > +#define __get_user_e(x, hptr, e)
>     \
> > +    do {
>     \
> > +        PRAGMA_DISABLE_PACKED_WARNING;
>     \
> > +        ((x) =3D (typeof(*hptr))(
>      \
> > +        __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 1, ldub_p,
>      \
> > +        __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 2, lduw_##e##_p,
>      \
> > +        __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 4, ldl_##e##_p,
>     \
> > +        __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 8, ldq_##e##_p,
> abort))))  \
> > +            (hptr)), (void)0);
>     \
> > +        PRAGMA_REENABLE_PACKED_WARNING;
>      \
> > +    } while (0)
>
> Hmm.  I guess this works.  The typeof cast in __get_user_e being required
> when sizeof(x) >
> sizeof(*hptr) in order to get the correct extension.
>

This code was copied 100% from the current linux-user :) It was also copied
before I needed
to do _Generic for a different project for something as well, so I didn't
think to switch over
from the old-school, gcc-specific hack to the modern clean form.


> Is it clearer with _Generic?
>
>      (x) =3D _Generic(*(hptr),
>                     int8_t: *(int8_t *)(hptr),
>                     uint8_t: *(uint8_t *)(hptr),
>                     int16_t: (int16_t)lduw_##e##_p(hptr),
>                     uint16_t: lduw_##e##_p(hptr),
>                     int32_t: (int32_t)ldl_##e##_p(hptr),
>                     uint32_t: (uint32_t)ldl_##e##_p(hptr),
>                     int64_t: (int64_t)ldq_##e##_p(hptr),
>                     uint64_t: ldq_##e##_p(hptr));
>
> In particular I believe the error message will be much prettier.
>

Indeed. That looks cleaner. I'll see if I can test that against the latest
bsd-user upstream.

Warner


> Either way,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
>

--0000000000008de4740602738ef9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 8, 2023 at 3:03=E2=80=AFP=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 8/7/23 23:07, Karim Taha wrote:<br>
&gt; From: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_bla=
nk">imp@bsdimp.com</a>&gt;<br>
&gt; <br>
&gt; Use __builtin_choose_expr to avoid type promotion from ?:<br>
&gt; in __put_user_e and __get_user_e macros.<br>
&gt; Copied from linux-user/qemu.h, originally by Blue Swirl.<br>
&gt; <br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.c=
om" target=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/qemu.h=C2=A0 =C2=A0| 81 ++++++++++++++++++++-----=
----------------------<br>
&gt;=C2=A0 =C2=A0bsd-user/signal.c |=C2=A0 5 +--<br>
&gt;=C2=A0 =C2=A02 files changed, 35 insertions(+), 51 deletions(-)<br>
&gt; <br>
&gt; diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h<br>
&gt; index dfdfa8dd67..c41ebfe937 100644<br>
&gt; --- a/bsd-user/qemu.h<br>
&gt; +++ b/bsd-user/qemu.h<br>
&gt; @@ -307,50 +307,37 @@ static inline bool access_ok(int type, abi_ulong=
 addr, abi_ulong size)<br>
&gt;=C2=A0 =C2=A0#define PRAGMA_REENABLE_PACKED_WARNING<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -#define __put_user(x, hptr)\<br>
&gt; -({\<br>
&gt; -=C2=A0 =C2=A0 int size =3D sizeof(*hptr);\<br>
&gt; -=C2=A0 =C2=A0 switch (size) {\<br>
&gt; -=C2=A0 =C2=A0 case 1:\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(uint8_t *)(hptr) =3D (uint8_t)(typeof(*=
hptr))(x);\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;\<br>
&gt; -=C2=A0 =C2=A0 case 2:\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(uint16_t *)(hptr) =3D tswap16((typeof(*=
hptr))(x));\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;\<br>
&gt; -=C2=A0 =C2=A0 case 4:\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(uint32_t *)(hptr) =3D tswap32((typeof(*=
hptr))(x));\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;\<br>
&gt; -=C2=A0 =C2=A0 case 8:\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 *(uint64_t *)(hptr) =3D tswap64((typeof(*=
hptr))(x));\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;\<br>
&gt; -=C2=A0 =C2=A0 default:\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 abort();\<br>
&gt; -=C2=A0 =C2=A0 } \<br>
&gt; -=C2=A0 =C2=A0 0;\<br>
&gt; -})<br>
&gt; +#define __put_user_e(x, hptr, e)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PRAGMA_DISABLE_PACKED_WARNING;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (__builtin_choose_expr(sizeof(*(hptr)) =
=3D=3D 1, stb_p,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __builtin_choose_expr(sizeof(*(hptr)) =3D=
=3D 2, stw_##e##_p,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __builtin_choose_expr(sizeof(*(hptr)) =3D=
=3D 4, stl_##e##_p,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __builtin_choose_expr(sizeof(*(hptr)) =3D=
=3D 8, stq_##e##_p, abort))))=C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((hptr), (x)), (void)0);=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PRAGMA_REENABLE_PACKED_WARNING;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 } while (0)<br>
&gt; +<br>
&gt; +#define __get_user_e(x, hptr, e)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PRAGMA_DISABLE_PACKED_WARNING;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((x) =3D (typeof(*hptr))(=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __builtin_choose_expr(sizeof(*(hptr)) =3D=
=3D 1, ldub_p,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __builtin_choose_expr(sizeof(*(hptr)) =3D=
=3D 2, lduw_##e##_p,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __builtin_choose_expr(sizeof(*(hptr)) =3D=
=3D 4, ldl_##e##_p,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __builtin_choose_expr(sizeof(*(hptr)) =3D=
=3D 8, ldq_##e##_p, abort))))=C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (hptr)), (void)0);=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PRAGMA_REENABLE_PACKED_WARNING;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 } while (0)<br>
<br>
Hmm.=C2=A0 I guess this works.=C2=A0 The typeof cast in __get_user_e being =
required when sizeof(x) &gt; <br>
sizeof(*hptr) in order to get the correct extension.<br></blockquote><div><=
br></div><div>This code was copied 100% from the current linux-user :) It w=
as also copied before I needed</div><div>to do _Generic for a different pro=
ject for something as well, so I didn&#39;t think to switch over</div><div>=
from the old-school, gcc-specific hack to the modern clean form.<br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Is it clearer with _Generic?<br>
<br>
=C2=A0 =C2=A0 =C2=A0(x) =3D _Generic(*(hptr),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int8_=
t: *(int8_t *)(hptr),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8=
_t: *(uint8_t *)(hptr),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int16=
_t: (int16_t)lduw_##e##_p(hptr),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint1=
6_t: lduw_##e##_p(hptr),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int32=
_t: (int32_t)ldl_##e##_p(hptr),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint3=
2_t: (uint32_t)ldl_##e##_p(hptr),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int64=
_t: (int64_t)ldq_##e##_p(hptr),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t: ldq_##e##_p(hptr));<br>
<br>
In particular I believe the error message will be much prettier.<br></block=
quote><div><br></div><div>Indeed. That looks cleaner. I&#39;ll see if I can=
 test that against the latest bsd-user upstream.</div><div><br></div><div>W=
arner<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
Either way,<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
<br>
r~<br>
</blockquote></div></div>

--0000000000008de4740602738ef9--

