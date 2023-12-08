Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03132809794
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 01:48:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBP0u-0007II-9E; Thu, 07 Dec 2023 19:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1rBP0n-0007Hz-Lk
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 19:46:37 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1rBP0l-0004z5-DX
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 19:46:37 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c9f84533beso16993601fa.1
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 16:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701996393; x=1702601193; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vh4XzQRny2CbhcMyVuIEStNBEuqQltsuRSGb5Fureow=;
 b=d7xLFDGktBbveZksdnofx1z2yk7wJrRNFS3ER4s5NjnDDU8TjbqA0MOJyrT/8hvl9u
 TMK4ae8BFiNpVSpw3XM4wdEzRRGX1Z4A7bnTglCfqWJ1wR63/kVZvWM/wQQX3okQPnXu
 I6p6Jd3BGbXHuSrVsiQCQWLa1WSUmVETsZna1LhVM7ALWqVsQX5cefQVdqaKfod8PHIE
 UG50E2T3Gz9pzyM6zveu/QvCIAOEC5nAlgGMtzAXiEN3Zsm3MZcLH0j/TtQBuLjOb9GL
 6P9uo8dV01ns+zbXFQguBgM2ksuMXFeEmBAkpEqm7Nus66MhJomoRuQyG9KTCb0LVJD+
 CMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701996393; x=1702601193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vh4XzQRny2CbhcMyVuIEStNBEuqQltsuRSGb5Fureow=;
 b=scX1cW+wjLYsZW3ghxvpt/WUF54kiM2PWBqiVlq3+nLqUs7fd5gUO0dQGE0HBSAg7b
 97hx/mC4kBB9kK0Xvf6gdSuFkMDUPgNT4dINYHSq8JK5AW6mpMUsz5qDkKjjYk6w3ov8
 NNG7cGmAZldibXM9V2+vHq33qz5MIhVgura1+10IZZtg5LEKTu2ZrqE0wOaPySnyPi1d
 GIA8nnOT28utigYQZF2bmbv5mmbMsT0VZvAfyo/M9yjH3WFCGxmDwJzGtuBaMn4izbUq
 Xb6gqz7Y6KVv+otToNrQtQbjKTfDf+tZuK1zISFiB9Ge9m+qIqML55a/adBbPWC3ihlt
 G9pQ==
X-Gm-Message-State: AOJu0YwT+PhfcgTaswSZdXKj7t4ta/wY2cQs0Y98ywnkx94VOyzsRByJ
 zzN4hjD6CoUrx1PdKq7vDxQlKZ+VferXVtiPrg==
X-Google-Smtp-Source: AGHT+IHyt7HxXsADDTnkOMGT8HIFN/x3diEqDzzJ+7i/rhZ45gLEIeOf9sY5Tv9TORvJgCmOo0U95y5NTGssRWJE0Rk=
X-Received: by 2002:a2e:a453:0:b0:2ca:8f7c:7e0c with SMTP id
 v19-20020a2ea453000000b002ca8f7c7e0cmr236570ljn.78.1701996393000; Thu, 07 Dec
 2023 16:46:33 -0800 (PST)
MIME-Version: 1.0
References: <CAOYM0N27HbO8wOumn_xxNSS8Zg-Rsc6tSj9U1oU3sSAARBoCwQ@mail.gmail.com>
 <CAFEAcA8Mo3XJ_PXet6UoKSyUXpuQ61ejXBrg6XrgAbZGXO=EhA@mail.gmail.com>
In-Reply-To: <CAFEAcA8Mo3XJ_PXet6UoKSyUXpuQ61ejXBrg6XrgAbZGXO=EhA@mail.gmail.com>
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Fri, 8 Dec 2023 08:47:37 +0800
Message-ID: <CAOYM0N0kmdDVU31uKqJ-HWj9eiqgBBMUtha0wZKifwg2pnOuPA@mail.gmail.com>
Subject: Re: make: *** No rule to make target 'i386/fp87.c', needed by
 'i386/fp87.o'. Stop.
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000069f5de060bf4eaeb"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=liu.jaloo@gmail.com; helo=mail-lj1-x233.google.com
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

--00000000000069f5de060bf4eaeb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, I'll check it out.
it does be a very old version, almost the first version of QEMU

$ git checkout initial -b initial

I will try it on my own, thanks a lot.

On Thu, Dec 7, 2023 at 7:32=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Thu, 7 Dec 2023 at 11:20, Liu Jaloo <liu.jaloo@gmail.com> wrote:
> >
> > qemu checkout tag "initial" version, then
> > $ make
> >
> > report error, like this:
> > make: *** No rule to make target 'i386/fp87.c', needed by
> 'i386/fp87.o'.  Stop.
> >
> > How or where can I get the resource about folder "i386", just like OBJS
> in Makefile
> >
> > OBJS=3D i386/fp87.o i386/interp_main.o i386/interp_modrm.o
> i386/interp_16_32.o \
> >       i386/interp_32_16.o i386/interp_32_32.o i386/emu-utils.o \
> >       i386/dis8086.o i386/emu-ldt.o
>
> What version of QEMU are you trying to build? These lines
> have not been in Makefile since 2003 !
>
> If you're deliberately trying to build a very old version of
> QEMU, then you are on your own for that. You'll probably
> find it does not compile at all on a modern Linux with a
> modern C compiler.
>
> thanks
> -- PMM
>

--00000000000069f5de060bf4eaeb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks, I&#39;ll check it out. <br></div><div>it does=
 be a very old version, almost the first version of QEMU<br></div><div><br>=
</div><div>$ git checkout initial -b initial</div><div><br></div><div>I wil=
l try it on my own, thanks a lot.<br></div></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 7, 2023 at 7:32=E2=
=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">pete=
r.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On Thu, 7 Dec 2023 at 11:20, Liu Jaloo &lt;<a href=3D"m=
ailto:liu.jaloo@gmail.com" target=3D"_blank">liu.jaloo@gmail.com</a>&gt; wr=
ote:<br>
&gt;<br>
&gt; qemu checkout tag &quot;initial&quot; version, then<br>
&gt; $ make<br>
&gt;<br>
&gt; report error, like this:<br>
&gt; make: *** No rule to make target &#39;i386/fp87.c&#39;, needed by &#39=
;i386/fp87.o&#39;.=C2=A0 Stop.<br>
&gt;<br>
&gt; How or where can I get the resource about folder &quot;i386&quot;, jus=
t like OBJS in Makefile<br>
&gt;<br>
&gt; OBJS=3D i386/fp87.o i386/interp_main.o i386/interp_modrm.o i386/interp=
_16_32.o \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i386/interp_32_16.o i386/interp_32_32.o i386=
/emu-utils.o \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i386/dis8086.o i386/emu-ldt.o<br>
<br>
What version of QEMU are you trying to build? These lines<br>
have not been in Makefile since 2003 !<br>
<br>
If you&#39;re deliberately trying to build a very old version of<br>
QEMU, then you are on your own for that. You&#39;ll probably<br>
find it does not compile at all on a modern Linux with a<br>
modern C compiler.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--00000000000069f5de060bf4eaeb--

