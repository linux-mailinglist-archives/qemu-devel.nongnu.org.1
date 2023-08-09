Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C538777510C
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 04:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTZMy-0006dP-Fp; Tue, 08 Aug 2023 22:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZMx-0006dB-6o
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:56:19 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZMv-0000Db-BZ
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:56:18 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b962c226ceso101078101fa.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 19:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1691549774; x=1692154574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UyGMJ9PH7A7bFdU7O03I1IAi2LmtbdEoZX/8JUVsioE=;
 b=MkLOJT1Qp8iNYw78W+8nzbNN2ZuYbeKFfK6zlWzy4LXC4kxTofbirOaxYubtdBqBke
 xwG5SLzIr2nePiEvE4SWMHFpQ1mQsrr+fiMAc4x3kyh1XBrmrvN4A6KSBu5H6gOcEvLC
 x+EA/8pwyzXyrPw75wkHyCW2ImyVPyCmvrBIro37TFVXO++RPDtx+o6z23KwJ/5UODcv
 pyu19PAnGR/mUwqlX6Dp0y7+aRjlmVqEYcuAyM8viKmnsy67C/jrZypep1NXuy1MMpks
 4fpx/sMFDhjZFZpqNOkyYud1XK3JM1kXN2ylG2iCZl3arjdfzh+dLKPslUqr17VuPkeN
 d2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691549774; x=1692154574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UyGMJ9PH7A7bFdU7O03I1IAi2LmtbdEoZX/8JUVsioE=;
 b=Ds2W6xE554RGypt7SpaimHtXbGFMiqDP0M44QAIPo3SPkNkI7bRoB+EU/6qL6IoV31
 A9ZjfeID3qoVWmighorfpAkmwdneNeSxwuhYKcuCWNiI3kvqJb6PEhx/qwmCIiuDofV+
 tUP0vfyys1y8OHjkoXgsuTdbFOtjFl9vgCvH9u4unVcPHf4DNRA9IzNANZi9mw3Fn3GD
 7xumdvCgxV5VI8SW+E2plomnmeYZspBgCcV5a9HfE92iUp+r5co/54BG5YaRX8ezkLz0
 A5cBQ9XeUD1lKXK9F/aH9oaxVZZdH07s0ho3V3eEemEGYvwrkiP1FL1qSvxN3cZUAq+a
 IXSQ==
X-Gm-Message-State: AOJu0YyVgtU/dWtbYs35Ub0BnjZ6WR+KDx+qHfBBXTrQs57EimUCnPgs
 jwAlwhkmnCMWrCVB9n9ugqYmrJqHMlkc8aet6D2rxA==
X-Google-Smtp-Source: AGHT+IHgvI+gXStwqL6vCLRwmWd72njZcXmV+PX5PI5mDLjX4579QQ7ffJkI9WU/gfE9h9f3ulQ98uINkzVBTFtAuO0=
X-Received: by 2002:a2e:8603:0:b0:2b8:4079:fd9d with SMTP id
 a3-20020a2e8603000000b002b84079fd9dmr882985lji.29.1691549774224; Tue, 08 Aug
 2023 19:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-3-kariem.taha2.7@gmail.com>
 <612acdbb-865d-0e32-9212-df9440a0e8bb@linaro.org>
In-Reply-To: <612acdbb-865d-0e32-9212-df9440a0e8bb@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 8 Aug 2023 20:56:05 -0600
Message-ID: <CANCZdfoLG8vpwgnxB2hW1ZoNeoTZvQuMfXYkB45eLisEtgbLYA@mail.gmail.com>
Subject: Re: [PATCH 02/33] Disable clang warnings arising from bsd-user/qemu.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000069be340602749fa7"
Received-SPF: none client-ip=2a00:1450:4864:20::22e;
 envelope-from=wlosh@bsdimp.com; helo=mail-lj1-x22e.google.com
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

--00000000000069be340602749fa7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 8, 2023 at 2:50=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/7/23 23:07, Karim Taha wrote:
> > +/*
> > + * Tricky points:
> > + * - Use __builtin_choose_expr to avoid type promotion from ?:,
> > + * - Invalid sizes result in a compile time error stemming from
> > + *   the fact that abort has no parameters.
> > + * - It's easier to use the endian-specific unaligned load/store
> > + *   functions than host-endian unaligned load/store plus tswapN.
> > + * - The pragmas are necessary only to silence a clang false-positive
> > + *   warning: see https://bugs.llvm.org/show_bug.cgi?id=3D39113 .
> > + * - We have to disable -Wpragmas warnings to avoid a complaint about
> > + *   an unknown warning type from older compilers that don't know abou=
t
> > + *   -Waddress-of-packed-member.
> > + * - gcc has bugs in its _Pragma() support in some versions, eg
> > + *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D83256 -- so we onl=
y
> > + *   include the warning-suppression pragmas for clang
>
> Perhaps s/in some versions/prior to gcc-13/ ?
> At least that's what the bugzilla says, and it
> will help when auditing for compiler versions
> in a few years when gcc-12 is EOL.
>

Looking at this now, This bug is in clang 7, from 2018. For FreeBSD, we
don't support
anything older than clang 12 or 13 However, the bug still exists in clang
16, the latest.
I believe this was also copied verbatim from linux-user, so let's leave it
and then make
this one of the common things as a followup... ok?

Warner

Either way,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> r~
>

--00000000000069be340602749fa7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 8, 2023 at 2:50=E2=80=AFP=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org" tar=
get=3D"_blank">richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On 8/7/23 23:07, Karim Taha wrot=
e:<br>
&gt; +/*<br>
&gt; + * Tricky points:<br>
&gt; + * - Use __builtin_choose_expr to avoid type promotion from ?:,<br>
&gt; + * - Invalid sizes result in a compile time error stemming from<br>
&gt; + *=C2=A0 =C2=A0the fact that abort has no parameters.<br>
&gt; + * - It&#39;s easier to use the endian-specific unaligned load/store<=
br>
&gt; + *=C2=A0 =C2=A0functions than host-endian unaligned load/store plus t=
swapN.<br>
&gt; + * - The pragmas are necessary only to silence a clang false-positive=
<br>
&gt; + *=C2=A0 =C2=A0warning: see <a href=3D"https://bugs.llvm.org/show_bug=
.cgi?id=3D39113" rel=3D"noreferrer" target=3D"_blank">https://bugs.llvm.org=
/show_bug.cgi?id=3D39113</a> .<br>
&gt; + * - We have to disable -Wpragmas warnings to avoid a complaint about=
<br>
&gt; + *=C2=A0 =C2=A0an unknown warning type from older compilers that don&=
#39;t know about<br>
&gt; + *=C2=A0 =C2=A0-Waddress-of-packed-member.<br>
&gt; + * - gcc has bugs in its _Pragma() support in some versions, eg<br>
&gt; + *=C2=A0 =C2=A0<a href=3D"https://gcc.gnu.org/bugzilla/show_bug.cgi?i=
d=3D83256" rel=3D"noreferrer" target=3D"_blank">https://gcc.gnu.org/bugzill=
a/show_bug.cgi?id=3D83256</a> -- so we only<br>
&gt; + *=C2=A0 =C2=A0include the warning-suppression pragmas for clang<br>
<br>
Perhaps s/in some versions/prior to gcc-13/ ?<br>
At least that&#39;s what the bugzilla says, and it<br>
will help when auditing for compiler versions<br>
in a few years when gcc-12 is EOL.<br></blockquote><div><br></div><div>Look=
ing at this now, This bug is in clang 7, from 2018. For FreeBSD, we don&#39=
;t support</div><div>anything older than clang 12 or 13 However, the bug st=
ill exists in clang 16, the latest.</div><div>I believe this was also copie=
d verbatim from linux-user, so let&#39;s leave it and then make</div><div>t=
his one of the common things as a followup... ok?</div><div><br></div><div>=
Warner<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
Either way,<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
r~<br>
</blockquote></div></div>

--00000000000069be340602749fa7--

