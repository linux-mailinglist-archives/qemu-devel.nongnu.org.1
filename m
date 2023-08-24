Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D2C787C36
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 01:57:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZKCE-0008Jk-Nh; Thu, 24 Aug 2023 19:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZKCD-0008JY-A9
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 19:57:01 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZKC8-00088U-QK
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 19:57:01 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4ff8cf11b90so530240e87.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692921414; x=1693526214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wzlSjy4LCgJ7WDd1fGQUnydZMKCE2HvFwE70RLcaa08=;
 b=FMubyMALIM5LD7lPd4hept8gmvfylrnrhI/89WEKjlyO+7v2jPZ88uTKYVLybs2tlH
 6OPJockVgFM962x7wfWQSwJ0+jGR3674rMjIE98EWiZabeyJ0XGpGO6TmVaYZWmYvAKC
 +QeFz3CgvH1dEjoFUR55VIGMnRveM/czCUzkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692921414; x=1693526214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wzlSjy4LCgJ7WDd1fGQUnydZMKCE2HvFwE70RLcaa08=;
 b=iiQDVNncO0HgpQXks2hO8tDQu3zMYdxMRyCFiiJMwnXfIpkuTtNC0mY6PYY2kTQwKJ
 s0GbzrYuahwTT1RdlmmzPiY6l6fuTfhL60Y9kASNCM6PW5nqG6noR/d9KmYb57ToVJsu
 v1UrkRdEPsutdzk3EGsEO1102QW0heiXzbHgdmoZUzaR/cAncN5AIFaRwcf2dPO/qP18
 5oT4QkIuoKJw/Mq7EbARWLXWv5HehezRAl2l+zBx/yvzT54cEfbg52Zq4htzYe7wfqHS
 DZki1uPA6I3aQOkuNtWoEUdZhEkpZn2jK/lf5K8iHV8CrUx7dYLmMZh2CHViJL/CCGBJ
 ti8A==
X-Gm-Message-State: AOJu0YxXxRXH0zKkwVXq2iM/wPtVEC9iUQkUUhS76irM5h/unCv4VwhZ
 kYlhd7gzCdH0BefYfZ5ADYfPzHTXL9udp6HWgonAHw==
X-Google-Smtp-Source: AGHT+IHe4rUKjrF22391WNq4JEjOkk0tdHVIBYJQWnmvLzh2HMDa8hVTtuabWsEEPMxRMJ3CZBNylw==
X-Received: by 2002:a05:6512:3ca9:b0:4fd:fadc:f1e with SMTP id
 h41-20020a0565123ca900b004fdfadc0f1emr15490168lfv.44.1692921414437; 
 Thu, 24 Aug 2023 16:56:54 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com.
 [209.85.208.46]) by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b00992e94bcfabsm220137eju.167.2023.08.24.16.56.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 16:56:54 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-5232ce75e26so3061a12.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 16:56:54 -0700 (PDT)
X-Received: by 2002:a50:d6d6:0:b0:523:193b:5587 with SMTP id
 l22-20020a50d6d6000000b00523193b5587mr84910edj.6.1692921413936; Thu, 24 Aug
 2023 16:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <87a5uiyq35.fsf@alyssa.is>
In-Reply-To: <87a5uiyq35.fsf@alyssa.is>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 24 Aug 2023 16:56:41 -0700
X-Gmail-Original-Message-ID: <CAAfnVB=qW99pYK04g6ZdM+c8HLLmE5kwc_UWyJgRVSPnGB84=g@mail.gmail.com>
Message-ID: <CAAfnVB=qW99pYK04g6ZdM+c8HLLmE5kwc_UWyJgRVSPnGB84=g@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] rutabaga_gfx + gfxstream
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org, 
 philmd@linaro.org
Content-Type: multipart/alternative; boundary="000000000000831dae0603b3fbb0"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=gurchetansingh@chromium.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

--000000000000831dae0603b3fbb0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 4:07=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:

> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>
> > - Official "release commits" issued for rutabaga_gfx_ffi,
> >   gfxstream, aemu-base.  For example, see crrev.com/c/4778941
> >
> > - The release commits can make packaging easier, though once
> >   again all known users will likely just build from sources
> >   anyways
>
> It's a small thing, but could there be actual tags, rather than just
> blessed commits?  It'd just make them easier to find, and save a bit of
> time in review for packages.
>

I added:

https://crosvm.dev/book/appendix/rutabaga_gfx.html#latest-releases-for-pote=
ntial-packaging

Tags are possible, but I want to clarify the use case before packaging.
Where are you thinking of packaging it for (Debian??)? Are you mostly
interested in Wayland passthrough (my guess) or gfxstream too?  Depending
your use case, we may be able to minimize the work involved.

--000000000000831dae0603b3fbb0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 23, 2023 at 4:07=E2=80=AF=
AM Alyssa Ross &lt;<a href=3D"mailto:hi@alyssa.is">hi@alyssa.is</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Gurchetan Si=
ngh &lt;<a href=3D"mailto:gurchetansingh@chromium.org" target=3D"_blank">gu=
rchetansingh@chromium.org</a>&gt; writes:<br>
<br>
&gt; - Official &quot;release commits&quot; issued for rutabaga_gfx_ffi,<br=
>
&gt;=C2=A0 =C2=A0gfxstream, aemu-base.=C2=A0 For example, see <a href=3D"ht=
tp://crrev.com/c/4778941" rel=3D"noreferrer" target=3D"_blank">crrev.com/c/=
4778941</a><br>
&gt;<br>
&gt; - The release commits can make packaging easier, though once<br>
&gt;=C2=A0 =C2=A0again all known users will likely just build from sources<=
br>
&gt;=C2=A0 =C2=A0anyways<br>
<br>
It&#39;s a small thing, but could there be actual tags, rather than just<br=
>
blessed commits?=C2=A0 It&#39;d just make them easier to find, and save a b=
it of<br>
time in review for packages.<br></blockquote><div><br></div><div>I added:</=
div><div><br></div><div><a href=3D"https://crosvm.dev/book/appendix/rutabag=
a_gfx.html#latest-releases-for-potential-packaging">https://crosvm.dev/book=
/appendix/rutabaga_gfx.html#latest-releases-for-potential-packaging</a><br>=
</div><div><br></div><div>Tags are possible, but I want to clarify the=C2=
=A0use case before=C2=A0packaging.=C2=A0 Where are you thinking of packagin=
g it for (Debian??)? Are you mostly interested in Wayland passthrough (my g=
uess) or gfxstream too?=C2=A0 Depending your use case, we may be able to mi=
nimize the work involved.</div><div><br></div></div></div>

--000000000000831dae0603b3fbb0--

