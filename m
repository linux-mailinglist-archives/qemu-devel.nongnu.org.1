Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E64D78D0CF
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:58:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb8aL-00076H-KK; Tue, 29 Aug 2023 19:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb8aJ-000769-Ez
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:57:23 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb8aG-00005Q-Mc
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:57:23 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso643658166b.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 16:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693353438; x=1693958238;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zB75Gqp1ychGRGbOI9VkSNkVdszFe1pVJV3kCX/kEvU=;
 b=IwIlN4uuJu8k0iiApos+lZGdy31aSJavV3vggGkw1LhQc8Oj0FsjEF0fRWmZ9RsaHJ
 fSRVn3xDaWzSVB2X+9W+C2dxg2V8Qfwgs/qCAj8OPQfcPIMUJ1WAUGPyRuBkF9JqCvSy
 YSevdfaGm5tmoHldXMomKuuJQiVMYdD+JkLbQXLorjw0AeaJ9o0YJhh0tLnoDJdGTrlP
 OrRBgf6RZ/oc2kYBSGUsu4T0VMPmyBW9A/0WHI3wh3P26Ntt3uquPUeuI60P4XCWAh1Y
 Idau9N/pHW03FVqY+JpDO4oEjc8T+6rQJfvfjwBtOdo61Td2xvu+Wz9UX6U/zCiyc9Qw
 HFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693353438; x=1693958238;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zB75Gqp1ychGRGbOI9VkSNkVdszFe1pVJV3kCX/kEvU=;
 b=FAJJubpVUt09z6kieEmgMHDmtcEB4kuHWsviDE9KGrrGkXuLltCoa40RwSHtrkT6EC
 aPGH+p07hfUmnC2G+f+jlxO+Cjtgmx/69HAaBql7KQXLApd/P9OYKbs03oOeYMtOYYeW
 BiZA1teS0813smtb1KEyVpQJAngHFu/KSEhMNF5AnOqRVcGVSmeAvQCoejdmY4Jk3uHO
 PDMZf03R9XS0InFjc8eAHpPwpKLUdQN1/ZGqj9JFQPNKQkSH/wDKHo82JzOpPj6s6cHo
 METsOg4nSIfYvmZkZPfjxfENpZYk3iNEN/CM5hdVYO3WMBJagpkr3WxiKDy6o9JFtc/4
 7fxw==
X-Gm-Message-State: AOJu0YzTwLJoaQgIl3igOMNs9ekE6oaabT6f7PT8GLldrXkDCHD3B7Kk
 t3aICtMw3Ou3IF981+J+Nd2cUw0vdJk6efw7Y5yOUw==
X-Google-Smtp-Source: AGHT+IEil4w15GCC5OB9HA5HC0HegmRDQ/CeOxGfzqaSB4sSoU/cHEO8jlx+RJ4WMoU7WkrMk8nrV/Wc2j6coZ+4fcA=
X-Received: by 2002:a17:906:105d:b0:9a1:b18f:77ff with SMTP id
 j29-20020a170906105d00b009a1b18f77ffmr343523ejj.18.1693353437790; Tue, 29 Aug
 2023 16:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230829184743.54557-1-imp@bsdimp.com>
 <67903f3f-89b0-06c5-2b50-911682554c75@linaro.org>
In-Reply-To: <67903f3f-89b0-06c5-2b50-911682554c75@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 29 Aug 2023 17:57:06 -0600
Message-ID: <CANCZdfqfkAGh2TqYe8JGZYG52Y-=mABAggQx_7LmGZrYNa39Eg@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user: Move PRAGMA_DISABLE_PACKED_WARNING to
 compiler.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="0000000000002396330604189212"
Received-SPF: none client-ip=2a00:1450:4864:20::635;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, MIME_BOUND_DIGITS_15=0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

--0000000000002396330604189212
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 5:35=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/29/23 11:47, Warner Losh wrote:
> > Replace the slightly older version of this in include/qemu/compiler.h
> > that was commit as part of bsd-user changes with the newer one from
> > linux-user. bsd-user has no regreassions with this.
> >
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> > diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> > index bbd55b4d18c..9bff3b763b5 160000
> > --- a/tests/lcitool/libvirt-ci
> > +++ b/tests/lcitool/libvirt-ci
> > @@ -1 +1 @@
> > -Subproject commit bbd55b4d18cce8f89b5167675e434a6941315634
> > +Subproject commit 9bff3b763b5531a1490e238bfbf77306dc3a6dbb
>
> Be careful about these.
>

Doh! how did I miss that... Oh, I only did the git submodule update on my
blitz branch, but not also on the master branch before I created this. Nice
catch.

My love for submodules... is not increasing. Do I need to fix that and send
a v3?

Warner

--0000000000002396330604189212
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 29, 2023 at 5:35=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 8/29/23 11:47, Warner Losh wrote:<br>
&gt; Replace the slightly older version of this in include/qemu/compiler.h<=
br>
&gt; that was commit as part of bsd-user changes with the newer one from<br=
>
&gt; linux-user. bsd-user has no regreassions with this.<br>
&gt; <br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
&gt; diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci<br>
&gt; index bbd55b4d18c..9bff3b763b5 160000<br>
&gt; --- a/tests/lcitool/libvirt-ci<br>
&gt; +++ b/tests/lcitool/libvirt-ci<br>
&gt; @@ -1 +1 @@<br>
&gt; -Subproject commit bbd55b4d18cce8f89b5167675e434a6941315634<br>
&gt; +Subproject commit 9bff3b763b5531a1490e238bfbf77306dc3a6dbb<br>
<br>
Be careful about these.<br></blockquote><div><br></div><div>Doh! how did I =
miss that... Oh, I only did the git submodule update on my blitz branch, bu=
t not also on the master branch before I created this. Nice catch.</div><di=
v><br></div><div>My love for submodules... is not increasing. Do I need to =
fix that and send a v3?</div><div><br></div><div>Warner=C2=A0</div></div></=
div>

--0000000000002396330604189212--

