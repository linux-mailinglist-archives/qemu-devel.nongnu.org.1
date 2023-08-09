Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8285E775127
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 05:02:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTZSh-0001Mx-EG; Tue, 08 Aug 2023 23:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZSd-0001MN-4e
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:02:11 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZSb-0001Jz-Gn
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:02:10 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99bf8e5ab39so931274766b.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 20:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1691550126; x=1692154926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pOFNaXoYGQHDbPrx3fzWMfmgnW4+ryakp+S9m2QF6b8=;
 b=u95hP4KqZZXI+DW0r6MCJowqYVQ6i9Qs0DinXMyYLTdyGX6eyULxObKdF5hI5Vtgw+
 t/Od9Gwv3mqG1pe0TJNYc01YLHecaa957ZwMEcAEhD/m9kjOfF1IcIIZT9x0p5n3ttc9
 +vvMUosmEpI+pXCHk5GFGf2EOFotaaHeNDY4Qay0qGvMyDdL040DA07aT4SEB6MmQWKr
 9iiLn/9F1jslVxZB3M+ggXfravByevRD9HfCZMhtrvyICLOD3zPmo+dF/u9QmoHAksiH
 ZWUQMMixaZGVbwk/HxSv1NaS0N2e6f90aNKeHTPf8tcp8bCtS2gP2gXukZHUPE5nVSDh
 xwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691550126; x=1692154926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pOFNaXoYGQHDbPrx3fzWMfmgnW4+ryakp+S9m2QF6b8=;
 b=Wm8vZZfPdaSs8TJ0ANufMsjL/SDW0hL67Oc52KF3f60RKv7LNyEeqjAcd2cbHNuMMH
 JYoAHPkcnOCefPW3sTwIUl6zncFGna0uQqM2IB67UKVCkCBYtHKHGng78gOrMYls+B+K
 GqNiZW0h/WxHe5HqpgdTDyeAwfa5cA826UZ96rnhILgvGgV05Qgv8iEStIl3ZKs8Gxs0
 7f+NIXTpvV3dM6Tbh00aeql34+97JaQ74Bw38yypWOz6cWBnWeEYI0lzygvvQbme3UQZ
 w836i44JPMfxlAz8SVWFnO7rc2gi6z6CStuZw5J5QT0AennkRHTlCUoKX/2HU6TPhMU8
 YI3A==
X-Gm-Message-State: AOJu0Ywv9bnBHQseUOBz46jjkqgB3FVvCmZF01yC0RDufCSDi57O2LNl
 IqtmAiLMOxfFkjCBI3Wz/2lLPKZ4GmTKR3l9va1uJvxWyA5An3+2+8vHzA==
X-Google-Smtp-Source: AGHT+IFZKrEUbbBICawEaggs1uiC43gtcAaRI1YAVAnsA8ZCodmdsSyMf3TQMXixZGYPSUN+38xt1N5Kntmof6JrGeE=
X-Received: by 2002:a17:907:2c54:b0:994:54ff:10f6 with SMTP id
 hf20-20020a1709072c5400b0099454ff10f6mr1002069ejc.30.1691550126160; Tue, 08
 Aug 2023 20:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-17-kariem.taha2.7@gmail.com>
 <9e972ae4-34f4-6924-3b7e-13d5112ed399@linaro.org>
In-Reply-To: <9e972ae4-34f4-6924-3b7e-13d5112ed399@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 8 Aug 2023 21:01:56 -0600
Message-ID: <CANCZdfr2Nk3gaSpif1PxXK-s8qE-MxH5ysp=OKGAgD=_DDhZxA@mail.gmail.com>
Subject: Re: [PATCH 16/33] Implement host-target convertion functions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000063cf4c060274b46a"
Received-SPF: none client-ip=2a00:1450:4864:20::635;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x635.google.com
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

--00000000000063cf4c060274b46a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 8, 2023 at 3:39=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/7/23 23:07, Karim Taha wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Implement the stat converstion functions:
> > target_to_host_fcntl_cmd
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> > ---
> >   bsd-user/freebsd/os-stat.c | 71 +++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 71 insertions(+)
>
> Which host / guest pairs have varying fcntl constants?
> I thought freebsd had these standardized...
>

Ah, indeed. This can be an identity wrapper, since the only #ifdefs for
these
values are for visibility. So this whole function can be replaced by

abi_long target_to_host_fcntl_cmd(int cmd)
{
    return cmd;
}

Warner

--00000000000063cf4c060274b46a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 8, 2023 at 3:39=E2=80=AFP=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 8/7/23 23:07, Karim Taha wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Implement the stat converstion functions:<br>
&gt; target_to_host_fcntl_cmd<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.c=
om" target=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/freebsd/os-stat.c | 71 ++++++++++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 71 insertions(+)<br>
<br>
Which host / guest pairs have varying fcntl constants?<br>
I thought freebsd had these standardized...<br></blockquote><div><br></div>=
<div>Ah, indeed. This can be an identity wrapper, since the only #ifdefs fo=
r these</div><div>values are for visibility. So this whole function can be =
replaced by</div><div><br></div><div>
abi_long target_to_host_fcntl_cmd(int cmd)</div><div>{</div><div>=C2=A0=C2=
=A0=C2=A0 return cmd;</div><div>}<br></div><div><br></div><div>Warner <br><=
/div></div></div>

--00000000000063cf4c060274b46a--

