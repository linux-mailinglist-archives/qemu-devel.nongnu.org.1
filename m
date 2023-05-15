Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A89E170321E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:04:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyafL-0000Td-Bb; Mon, 15 May 2023 12:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1pyaez-0000By-EM
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:02:54 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1pyaex-0001Kp-AW
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:02:53 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-965ac4dd11bso2591278466b.2
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 09:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1684166568; x=1686758568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+eDaJOiIH5BkyblGh+tHpIYzMnQA/usPLX2YuXp58ZQ=;
 b=rMtxhKiSgUU8h1dmnDz6TtbRUlOEavcsBgawqrX6XsgVWtGA8XLk/+Pq0b3kiarebI
 lbE6011PI84J0gacs2w1vVVUFryOHMWTzJGvGv85Pnk51Lgxg17kzNEbn4wcq365oE2e
 WrBF0xiLjlmE8cLCc2NCUBO5qgUECL+85kDuUZ2LzEVcsPelySpoK9PQwPqVl1g2GopI
 yRK7Z1gFDU7vhug8/JO5NdRsu+OKpNk/A4E5TK+Ax63UCGPtH5akZJNv4QWtTDaC/CIA
 8Zk+l82Mqd2OHErgZZPt1ZkJXex/lInBDHBJjKoF/bA6PjIwQda3u4DLAJ7zA/ZFGiKZ
 zHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684166568; x=1686758568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+eDaJOiIH5BkyblGh+tHpIYzMnQA/usPLX2YuXp58ZQ=;
 b=Djh0KiabTydzm1GK7H+UhpCJn865uYlv3JC0/L4+1q0xljwcR9Xg+XPcn8qKA1ASCq
 Si8yBMPh1wktyCSl535xPrmiHoctBKpd2iEL9Zyzb6AB0xzMv82f8FxOCZsjBaso3cBQ
 UVBF8+iwQLsamMcm7ORdNFHwVfSZvQlAiXZDlfaMAGKKozwJNWsKptO4J7ahwsc+Qpc0
 tHjF2RE6v2ixdA0MSO0I8wtX42F5MjzKv9K2MjxnUzMEj5y6lAZYNzjnt+hv6j3aiwfc
 Xi7+iroq7eYx/9DCsLYQXm7QsHz/wErZuigNR/W9c0n+9OuVKSYDb7hiXz+62uBET3jp
 g6rA==
X-Gm-Message-State: AC+VfDx5HYdjOIwL7dTI+K/kujyLaIliAUOP5aerbfqmTk8clp+HVfry
 QFObObAgLBoJjXg0dadpSI83pngyPhVdYbtOohUfag==
X-Google-Smtp-Source: ACHHUZ6MEV97GIJTULP/1WwiatceMrxFxeEf2xk6WqItbZ+/FjXP9ujQVk1bGGfXUQBqgC8/A/L05mOx8BZOInNvQ0I=
X-Received: by 2002:a17:906:da8c:b0:94f:7a8:a902 with SMTP id
 xh12-20020a170906da8c00b0094f07a8a902mr24335624ejb.14.1684166567646; Mon, 15
 May 2023 09:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <d6f3e06c-ee84-5101-c583-220aa90c0c12@msgid.tls.msk.ru>
 <20230508062407-mutt-send-email-mst@kernel.org>
 <5492f69f-021d-cf25-5a92-8310255fddca@msgid.tls.msk.ru>
 <20230508074529-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230508074529-mutt-send-email-mst@kernel.org>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 15 May 2023 10:02:43 -0600
Message-ID: <CANCZdfqybuKuDpkb4FsftfoCvZkq8OhixA0yj8K27WVeUjLN0g@mail.gmail.com>
Subject: Re: missing boot rom: is it really a fatal error?
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000001f01c05fbbd965f"
Received-SPF: none client-ip=2a00:1450:4864:20::632;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000001f01c05fbbd965f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 8, 2023 at 5:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:

> On Mon, May 08, 2023 at 01:42:04PM +0300, Michael Tokarev wrote:
> > 08.05.2023 13:28, Michael S. Tsirkin wrote:
> > > On Sun, May 07, 2023 at 08:56:23PM +0300, Michael Tokarev wrote:
> > ..
> >
> > > > I'm about to revert that old change on debian, to make it just a
> warning instead
> > > > of an error (the code is different now, but the same principle
> applies), - because
> > > > I dislike dependencies which are useless 99.9% of the time and are
> trivial to
> > > > install when actually needed.
> > ..
> > > I advise against it.
> > > If you boot guest on a system with boot rom not installed you will no=
t
> > > be able to migrate to a system with boot rom installed.
> > > why not? because we don't know how big to make the rom BAR.
> > > And users will not discover until much much later after they have
> > > painted themselves into a corner.
> >
> > Yes, I know about the migration. Actually there's an old bug report ope=
n
> > against debian qemu package, - the context is similar to the old bios12=
8
> > vs bios256 thing in qemu upstream, - boot roms might change in size too=
.
> >
> > In this context though, the talk is not about migration at all. The
> missing
> > dep is in Xen HVM qemu package, a xen-only build of qemu-system-i386. A=
nd
> > this one fails to start unless the boot roms are provided. It is not ev=
en
> > capable of migration to begin with :)
> >
> > Thank you for the reminder, - very useful.
> >
> > /mjt
>
> I guess we decided we'd rather not handle reports from users about net
> boot not working. It's true most users don't need net boot but then
> that's true for most qemu functionality - 99% of users
> probably need 1% of the functionality. It's just a different 1% for each
> user...
>

Yea, but to every user, their 1% is the most important thing ever...
Or so it seems some days :)

Warner

--00000000000001f01c05fbbd965f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 8, 2023 at 5:48=E2=80=AFA=
M Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Mon, May 08, 2023 at 01:42:04PM +0300, Michael Tokarev wrote:<br>
&gt; 08.05.2023 13:28, Michael S. Tsirkin wrote:<br>
&gt; &gt; On Sun, May 07, 2023 at 08:56:23PM +0300, Michael Tokarev wrote:<=
br>
&gt; ..<br>
&gt; <br>
&gt; &gt; &gt; I&#39;m about to revert that old change on debian, to make i=
t just a warning instead<br>
&gt; &gt; &gt; of an error (the code is different now, but the same princip=
le applies), - because<br>
&gt; &gt; &gt; I dislike dependencies which are useless 99.9% of the time a=
nd are trivial to<br>
&gt; &gt; &gt; install when actually needed.<br>
&gt; ..<br>
&gt; &gt; I advise against it.<br>
&gt; &gt; If you boot guest on a system with boot rom not installed you wil=
l not<br>
&gt; &gt; be able to migrate to a system with boot rom installed.<br>
&gt; &gt; why not? because we don&#39;t know how big to make the rom BAR.<b=
r>
&gt; &gt; And users will not discover until much much later after they have=
<br>
&gt; &gt; painted themselves into a corner.<br>
&gt; <br>
&gt; Yes, I know about the migration. Actually there&#39;s an old bug repor=
t open<br>
&gt; against debian qemu package, - the context is similar to the old bios1=
28<br>
&gt; vs bios256 thing in qemu upstream, - boot roms might change in size to=
o.<br>
&gt; <br>
&gt; In this context though, the talk is not about migration at all. The mi=
ssing<br>
&gt; dep is in Xen HVM qemu package, a xen-only build of qemu-system-i386. =
And<br>
&gt; this one fails to start unless the boot roms are provided. It is not e=
ven<br>
&gt; capable of migration to begin with :)<br>
&gt; <br>
&gt; Thank you for the reminder, - very useful.<br>
&gt; <br>
&gt; /mjt<br>
<br>
I guess we decided we&#39;d rather not handle reports from users about net<=
br>
boot not working. It&#39;s true most users don&#39;t need net boot but then=
<br>
that&#39;s true for most qemu functionality - 99% of users<br>
probably need 1% of the functionality. It&#39;s just a different 1% for eac=
h<br>
user...<br></blockquote><div><br></div><div>Yea, but to every user, their 1=
% is the most important thing ever...</div><div>Or so it seems some days :)=
</div><div><br></div><div>Warner <br></div></div></div>

--00000000000001f01c05fbbd965f--

