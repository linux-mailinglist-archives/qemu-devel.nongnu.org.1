Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E067E610E
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 00:34:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0s3K-0002jl-1b; Wed, 08 Nov 2023 18:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r0s3I-0002jd-Kx
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 18:33:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r0s3F-0001Kq-QL
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 18:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699486416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xXvpNJG4lPmVbNx5yplm8n2NeMOGVKBYtUYUO8C3gMY=;
 b=D3ygvyO+2H6UO8AOaN17kaILlx4eJAf8ruuAXHOZMrPFf1+392sI1xYiqxTibvPefPN08S
 TmZ+K8KoCZJw3R3vKEFuR2L3Sb2DXGAjZfyxhW58P/r6rlg11DVnnm/uydslHA4GWCgJCv
 erTSPUyLkY4g5wbmLE/4FQMdcbR5eBY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-qKxa_vesPnmsnQE2QwhmaA-1; Wed, 08 Nov 2023 18:33:34 -0500
X-MC-Unique: qKxa_vesPnmsnQE2QwhmaA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9dd89e2ce17so19925866b.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 15:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699486413; x=1700091213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xXvpNJG4lPmVbNx5yplm8n2NeMOGVKBYtUYUO8C3gMY=;
 b=BnCgIoRuh2dSivowDpNMbMNYpFrN5UoDVeJUapNiZJnbOS6rKoUeC9UNtCShxEuROM
 iusJSFJXoovc4swQpL+a09Q/WZx7uOkafX8n6TsDFAoSKxnXBj/pFNbZMGzcIzgfATCr
 h7qqo0bjLMCU6i7M1EqiD5hhszNmTZXwHhrDzFlqUDpnKi0HM1Liv/qHiiCARbgGpqV3
 8EKs4IiF6tnAso276WDSoJJKD4rAmMFoAXZNLnWwPwHiFlP1pnRZtP09vVEtWXpqAW4K
 DdGhIVSreAio7Job0tToBPrrEbvQQxz/wcUSHkpXwp/+dnbHmPE7WPGaBmUvzBA8wKF/
 JwWw==
X-Gm-Message-State: AOJu0Yw3zqRXwNWnKw/b88o3bGFXak4ICrGKsi7roXY4EwJ3G8/dXOFh
 WfrD+Yhlt3kWjQNr5IbzLCL73/qJ9f2ECk4N6rpSg6IR8WjfJEYcBtyLAwZ9I7va7hU37AHKnGm
 nAgCoKDrIG/W3x8Tiuy0QxpTipkcqPJs=
X-Received: by 2002:a17:907:3fa6:b0:9b2:babd:cd51 with SMTP id
 hr38-20020a1709073fa600b009b2babdcd51mr3114715ejc.5.1699486413680; 
 Wed, 08 Nov 2023 15:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsWOJoaH2g2Pu+FD1m53gDv6JqgY4QW/Sy8JyHdSE/AyhTysuFcXRVIm4UAuenrX1nlqPHyPWMLxiL9urZBPE=
X-Received: by 2002:a17:907:3fa6:b0:9b2:babd:cd51 with SMTP id
 hr38-20020a1709073fa600b009b2babdcd51mr3114700ejc.5.1699486413324; Wed, 08
 Nov 2023 15:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20231108183251.80572-1-philmd@linaro.org>
 <20231108183251.80572-2-philmd@linaro.org>
 <CAFEAcA9xgS_8VV1S+-7vaqSqzK_2=0hJ+ceDP7BVdFd6TUR-nw@mail.gmail.com>
 <44d8c245-122a-47f0-25e2-eae1dac8ac18@eik.bme.hu>
In-Reply-To: <44d8c245-122a-47f0-25e2-eae1dac8ac18@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 9 Nov 2023 00:33:20 +0100
Message-ID: <CABgObfa00En_Hodn8UaAUNH5Eq1tMbBSAq+6j69pKaZ-iG3Xew@mail.gmail.com>
Subject: Re: [NOTFORMERGE PATCH 1/2] configure: Use distrib meson
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Rene Engel <ReneEngel80@emailn.de>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Howard Spoelstra <hsp.cat7@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000f794240609ac8336"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000f794240609ac8336
Content-Type: text/plain; charset="UTF-8"

Il mer 8 nov 2023, 20:52 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:

> AFAIU the problem is that macOS has system python in
> /Library/Frameworks/python.framework (or something like that) but homebrew
> does not use that but installs its own python somewhere in /opt and meson
> from homebrew uses that python but configure finds the system python which
> does not have meson so it then downloads its own meson but that's too old
> for macOS Sonoma


Correct (except s/downloads/installs/), basically --python/$PYTHON is the
sole interpreter used to run *any* Python code during the QEMU build. The
difference is that QEMU 8.1 would indeed download Meson, while QEMU 8.2
always uses the wheel that is shipped with QEMU. This change was done
because the embedded Meson is intended to be a "known good" version that we
(and pythondeps.toml) can point users to, in case a newer version from the
distro has issues. Of course the other side of the coin is that an older
version might not support new OSes as in this case.

The workaround below is not just a workaround but the intended solution if
one wants to use the Meson and Sphinx packages from homebrew, and cannot
modify the PATH to privilege homebrew's Python interpreter. In order to
support Sonoma out of the box with the system Python, however, we can bump
the shipped version of Meson to 1.2.x (and adjust pythondeps.toml).

Paolo

It should probably check for homebrew or macports
> locations too or check for meson and get the python that's using. A
> workaround apparently is to pass --python with the right path to
> configure.
>

--000000000000f794240609ac8336
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=
=3D"ltr" class=3D"gmail_attr">Il mer 8 nov 2023, 20:52 BALATON Zoltan &lt;<=
a href=3D"mailto:balaton@eik.bme.hu" target=3D"_blank" rel=3D"noreferrer">b=
alaton@eik.bme.hu</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">AFAIU the problem is that macOS has system python in <br>
/Library/Frameworks/python.framework (or something like that) but homebrew =
<br>
does not use that but installs its own python somewhere in /opt and meson <=
br>
from homebrew uses that python but configure finds the system python which =
<br>
does not have meson so it then downloads its own meson but that&#39;s too o=
ld <br>
for macOS Sonoma</blockquote></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Correct (except s/downloads/installs/), basically --python/$PYTHON is=
 the sole interpreter used to run *any* Python code during the QEMU build. =
The difference is that QEMU 8.1 would indeed download Meson, while QEMU 8.2=
 always uses the wheel that is shipped with QEMU. This change was done beca=
use the embedded Meson is intended to be a &quot;known good&quot; version t=
hat we (and pythondeps.toml) can point users to, in case a newer version fr=
om the distro has issues. Of course the other side of the coin is that an o=
lder version might not support new OSes as in this case.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">The workaround below is not just a workaro=
und but the intended solution if one wants to use the Meson and Sphinx pack=
ages from homebrew, and cannot modify the PATH to privilege homebrew&#39;s =
Python interpreter. In order to support Sonoma out of the box with the syst=
em Python, however, we can bump the shipped version of Meson to 1.2.x (and =
adjust pythondeps.toml).</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Paolo</div><div dir=3D"auto"><br></div><div class=3D"gmail_quote" dir=3D"a=
uto"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">It should probably check for homebrew o=
r macports <br>
locations too or check for meson and get the python that&#39;s using. A <br=
>
workaround apparently is to pass --python with the right path to <br>
configure.<br></blockquote></div></div>

--000000000000f794240609ac8336--


