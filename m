Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA087B86EE
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:48:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5yP-0006HS-DP; Wed, 04 Oct 2023 13:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qo5yM-0006HB-8V
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:47:46 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qo5yK-0006Ub-0w
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:47:45 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so75781a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696441662; x=1697046462;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LXcKFoixUVnEhhrmhmqtIgTIzGvORxjCO9uoBmKKYDs=;
 b=MlGoqMxApCVaQCFFGenDQ6/aZZXcpbC7DWUSWzf23RI4ZWmo/+CbhkPLPQHa+S0G/j
 QB9rFiUEmsAMOk3oNOam65+sEfYVJCCqYl4tMpiCD0YG/0VOxYbMflz8q2HI+nNm8Pac
 H7oLy0/uU4PTcm5eqVEllv6MH0G0L//B1nw3VpdreTo8DzFZFqrL6cSIoeydnU/dXVCq
 JEKjV6uyl3zzCKXSUp/yJ19IVLPJabd1gIJA99FmhVjl/LeALjKmLv6hnbSuduG2PYq+
 FnMQU17ctubJYnnni4ubp+Ey2N4CfwYmYyLxBQewjWY53wTar+ITIH13bwB64vQu2+as
 Y7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696441662; x=1697046462;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LXcKFoixUVnEhhrmhmqtIgTIzGvORxjCO9uoBmKKYDs=;
 b=c8zuKVcsbwUfArWUUeNjvA2X8cLA01lbfVjudAcPH+Vf3ZJDF2FcxY4z8dP0QVVrE/
 2fPm09i15dlWgqeyslVL/HKI/QmDNYMAJYRhvGsnTyZqWx07sssrJwtEo5owU2RBk2Xz
 gt/NtlhDgS6qF0++N3H1WHxUDiYydsqbgDDwOCrsFAxJtskMI8kSkBX6aNjebPe/g1AV
 +GKXvT/dH7fxvkIZMe4q7igZaKFBRrZT/4lVK1Z0kg2OFfl+AGWXsgJPiCNPIStZzPt/
 5oHtdQ5u6kPUoEH4V3wCWUENgBKDVDUmGsAvuxIZSxpppW5gr3o0dynLPNqDsu+Spawy
 onWg==
X-Gm-Message-State: AOJu0Yy8blMKcyNiBcPTWTolryrHdBTpalXrf7Y1Iglej8h/QFM4UNT7
 rqDigKx4LJIqXP+g6O3hglZmipW9mY1RTiamuF4m3A==
X-Google-Smtp-Source: AGHT+IFZt2EmA72xLOJs83/cXid71lLbjD9cOM6wjSqS9qWJx6heN4jDu2kmptQrz/lf9xGI5nCmGHwr014tMKu/AW0=
X-Received: by 2002:a05:6402:b18:b0:531:1875:bbc8 with SMTP id
 bm24-20020a0564020b1800b005311875bbc8mr2644398edb.19.1696441661963; Wed, 04
 Oct 2023 10:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <14cd0201-1507-bfa8-fe9e-f482c35d21ca@linaro.org>
 <d688281c-d019-c1ff-6927-d1791911c57d@linaro.org>
 <e13885b5-06a2-599f-e0fe-c5e8f0671742@redhat.com>
 <b8b28fa6-6224-cf6c-9aa9-016083ed994f@linaro.org>
In-Reply-To: <b8b28fa6-6224-cf6c-9aa9-016083ed994f@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 4 Oct 2023 11:47:29 -0600
Message-ID: <CANCZdfpaCMNtB-87jBKe4kQUGX+c-+4sK9hJxj-iPzEsHbzcrg@mail.gmail.com>
Subject: Re: Wshadow: Better name for 'optarg'?
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a4d1070606e79a10"
Received-SPF: none client-ip=2a00:1450:4864:20::532;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x532.google.com
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

--000000000000a4d1070606e79a10
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 4, 2023, 11:44 AM Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:

> On 4/10/23 19:35, Thomas Huth wrote:
> > On 04/10/2023 19.23, Richard Henderson wrote:
> >> On 10/4/23 03:05, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> Hi,
> >>>
> >>> I'm getting a bunch of errors for 'optarg' declared in <unistd.h>:
> >>
> >> I thought things like this is why we were trying -Wshadow=3Dlocal.
> >>
> >> I think it's unlikely that we'll be able to prevent all such cases.
> >
> > Given the broad range of operating systems and libraries that we suppor=
t
> > in QEMU, I agree with Richard - it will likely be impossible to enable
> > that option without =3Dlocal by default without risking that compilatio=
n
> > breaks on some exotic systems or new versions of various libraries.
>
> -Wshadow=3Dlocal doesn't seem to work here which is why I switched
> to -Wshadow. I probably misunderstood something from Markus cover
> letter. My setup is:
>
> C compiler for the host machine: clang (clang 14.0.3 "Apple clang
> version 14.0.3 (clang-1403.0.22.14.1)")
>


I had trouble with -Wshadow=3Dlocal with clang too.

In general I agree not wanting it by default... but for globals defined by
the standard, we'd definitely want to fix.

Warner

I suppose we'll figure that out when eventually enabling -Wshadow=3Dlocal
> on CI. Meanwhile I already cleaned the 'optarg' warnings that were
> bugging me, see:
>
> https://lore.kernel.org/qemu-devel/20231004120019.93101-1-philmd@linaro.o=
rg/
> I'll try to get -Wshadow=3Dlocal, but the other series still seems a
> good cleanup, as I used more meaningful variable names.
>
> Regards,
>
> Phil.
>
>

--000000000000a4d1070606e79a10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Oct 4, 2023, 11:44 AM Philippe Mathieu-Daud=C3=
=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">On 4/10/23 19:35, Thomas Huth wr=
ote:<br>
&gt; On 04/10/2023 19.23, Richard Henderson wrote:<br>
&gt;&gt; On 10/4/23 03:05, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I&#39;m getting a bunch of errors for &#39;optarg&#39; declare=
d in &lt;unistd.h&gt;:<br>
&gt;&gt;<br>
&gt;&gt; I thought things like this is why we were trying -Wshadow=3Dlocal.=
<br>
&gt;&gt;<br>
&gt;&gt; I think it&#39;s unlikely that we&#39;ll be able to prevent all su=
ch cases.<br>
&gt; <br>
&gt; Given the broad range of operating systems and libraries that we suppo=
rt <br>
&gt; in QEMU, I agree with Richard - it will likely be impossible to enable=
 <br>
&gt; that option without =3Dlocal by default without risking that compilati=
on <br>
&gt; breaks on some exotic systems or new versions of various libraries.<br=
>
<br>
-Wshadow=3Dlocal doesn&#39;t seem to work here which is why I switched<br>
to -Wshadow. I probably misunderstood something from Markus cover<br>
letter. My setup is:<br>
<br>
C compiler for the host machine: clang (clang 14.0.3 &quot;Apple clang <br>
version 14.0.3 (clang-1403.0.22.14.1)&quot;)<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">I h=
ad trouble with -Wshadow=3Dlocal with clang too.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">In general I agree not wanting it by default... bu=
t for globals defined by the standard, we&#39;d definitely want to fix.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Warner</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
I suppose we&#39;ll figure that out when eventually enabling -Wshadow=3Dloc=
al<br>
on CI. Meanwhile I already cleaned the &#39;optarg&#39; warnings that were<=
br>
bugging me, see:<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20231004120019.93101-1-philmd=
@linaro.org/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore.=
kernel.org/qemu-devel/20231004120019.93101-1-philmd@linaro.org/</a><br>
I&#39;ll try to get -Wshadow=3Dlocal, but the other series still seems a<br=
>
good cleanup, as I used more meaningful variable names.<br>
<br>
Regards,<br>
<br>
Phil.<br>
<br>
</blockquote></div></div></div>

--000000000000a4d1070606e79a10--

