Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCAE77510B
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 04:55:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTZLU-0005vl-Rd; Tue, 08 Aug 2023 22:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZLT-0005vc-8r
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:54:47 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZLQ-0008Mr-SY
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:54:47 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99bed101b70so897709266b.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 19:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1691549683; x=1692154483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7zZLeYJPOK1QTMs1y76TsKxEAOBX4hdblRL0PJPo5GE=;
 b=J8HnPJJdQvb/RvVsmPPh9ubzSu+/l2Y2Mx90GX+0dGeGfj5ADSy+OpXWhxT96Qm81h
 5K+4jo5pOoryf0sgpTiIgaK14oH6GMi1ZeanVffBult1ZYqZQIn3wQaW0FvJVr7rDTvP
 ZC2GwiXR7DQHE/XJbJcTTnCmtLM4HY+rtXlTlgLLVyHqmBa2bfoaY0te1SeWB7FzVQPC
 6iIj6/iJEMIe02Bi1pYoklVZzB9V2W97PsqvCNOhyQz3HZlDUqbQ5dSXpxwnpWcMouuI
 Ijpuk80QE48ZRghOCYEiXUaOyrvIxuaNzFuZFPCrvNlovzGwdh/9yCnBWgF02dVt3owu
 iZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691549683; x=1692154483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7zZLeYJPOK1QTMs1y76TsKxEAOBX4hdblRL0PJPo5GE=;
 b=kXj2fwIQmTJYvQNKUv3UXBFmUvCLozfAvNbnRzIlHgZ1jmB2bkehZ5dl/Cau1BTkuo
 x/vO1S/IOT32sTJzJGkgCSkuIzo5IJIbeu9eYfDhz1WGptKz0qjMV6NmolKR6xJF14rY
 PPCEWWV9I5cbt2S+CUQqOjQlss0ikmw5E7NJnlTlBaFSwj6P1H2vA2sqfzinx7MufZha
 vSruzUjk68xHmDv9cskzhAkm/QQMum82AjJACe8g+Mc9Yt7PqHToMPrSIoDZ9NQTLp/u
 lmUL+SXAKRIr1DmO0MY/jyXau53wTrtnhzhxXgM74moQDLiEw0aE1f7o7TTnPZtoEg58
 uIIw==
X-Gm-Message-State: AOJu0Yyv6NzbxQSmE+u8HRR3Y7ClvZgFYsbVQgLE03rYeBW0Q/q5b2QL
 x5G+p7AoEea0uBUgXxkYDsvJcJy8Q2N7lpT07W0pzcaE+aCRcMeDXZA=
X-Google-Smtp-Source: AGHT+IF8tN+qVJDbgnO+a0IlfVf9klrPjD77i5W+j8u/e+u/rAIIr0YQAsfIFBC30C9drH5OdfdycXZPzCO9mkFedh8=
X-Received: by 2002:a17:906:74d9:b0:99c:50ee:3da9 with SMTP id
 z25-20020a17090674d900b0099c50ee3da9mr1154694ejl.45.1691549683343; Tue, 08
 Aug 2023 19:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-11-kariem.taha2.7@gmail.com>
 <2c787602-ba70-3607-aaf0-fd3db6857c1b@linaro.org>
In-Reply-To: <2c787602-ba70-3607-aaf0-fd3db6857c1b@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 8 Aug 2023 20:54:30 -0600
Message-ID: <CANCZdfqfEdmyQ9GpZoWnNuTZPKkxPmeY7f7RsXk8zvc3iVxf6Q@mail.gmail.com>
Subject: Re: [PATCH 10/33] Add struct target_freebsd_fhandle and fcntl flags
 to bsd-user/syscall_defs.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000ff2bf006027499af"
Received-SPF: none client-ip=2a00:1450:4864:20::634;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x634.google.com
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

--000000000000ff2bf006027499af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 8, 2023 at 3:26=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/7/23 23:07, Karim Taha wrote:
> > +struct target_freebsd_fid {
> > +    u_short     fid_len;            /* len of data in bytes */
> > +    u_short     fid_data0;          /* force longword align */
> > +    char        fid_data[TARGET_MAXFIDSZ];  /* data (variable len) */
>
> uint16_t?
>

These were copied from FreeBSD's sys/mount.h... Changing to uint16_t likely
is a good idea, though. I'll handle the logistics of making changes like
this in
bsd-user upstream with Kariim.

Warner


> Otherwise,
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>

--000000000000ff2bf006027499af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 8, 2023 at 3:26=E2=80=AFP=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 8/7/23 23:07, Karim Taha wrote:<br>
&gt; +struct target_freebsd_fid {<br>
&gt; +=C2=A0 =C2=A0 u_short=C2=A0 =C2=A0 =C2=A0fid_len;=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 /* len of data in bytes */<br>
&gt; +=C2=A0 =C2=A0 u_short=C2=A0 =C2=A0 =C2=A0fid_data0;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* force longword align */<br>
&gt; +=C2=A0 =C2=A0 char=C2=A0 =C2=A0 =C2=A0 =C2=A0 fid_data[TARGET_MAXFIDS=
Z];=C2=A0 /* data (variable len) */<br>
<br>
uint16_t?<br></blockquote><div><br></div><div>These were copied from FreeBS=
D&#39;s sys/mount.h... Changing to uint16_t likely</div><div>is a good idea=
, though. I&#39;ll handle the logistics of making changes like this in</div=
><div>bsd-user upstream with Kariim.</div><div><br></div><div>Warner<br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Otherwise,<br>
Acked-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.=
org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
</blockquote></div></div>

--000000000000ff2bf006027499af--

