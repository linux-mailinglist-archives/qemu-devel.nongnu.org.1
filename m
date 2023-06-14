Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2282372FEFD
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 14:47:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Pds-0008LR-NE; Wed, 14 Jun 2023 08:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>)
 id 1q9Pdh-0008EK-Ot; Wed, 14 Jun 2023 08:30:25 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>)
 id 1q9Pde-0001DL-BM; Wed, 14 Jun 2023 08:30:17 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-46e3f05b04bso289249e0c.2; 
 Wed, 14 Jun 2023 05:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686745810; x=1689337810;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=27mXpjU0rZtFzXpLREMWFj2XIwHSGIa7FhRtrTdGotM=;
 b=PCkMadfpXHxv0s74cMiSdXEIAdZuMOSd4ND2WzverA7gHvRFlZEgr2xjfmNa86p4wE
 eV+6wORVHXOYsQl+cSY/NnmW6MN9r/1eQDPLIeK1mIjsfI2sQwDJ2JEdXFN9CpGzDfbB
 TFpHreSN7RZ/OFfw9Oyy7oaHs85Ewk0kG7jgvXJfPcC4YEyyCEU6JumXEm/nKcC+lQlI
 nvVCWAnV1GH9F74RQ3UBiyWNky0XqX5/LI5EZdusVafFS0Cqrf9og55ZMEXrDSF5kSXM
 qxT1JTltQEhPRMQlDl2Mr5wis99keUPaZEg1+wtPwnkyoJUIy6idz9n4PbjIYbAR2278
 v3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686745810; x=1689337810;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=27mXpjU0rZtFzXpLREMWFj2XIwHSGIa7FhRtrTdGotM=;
 b=CnpayeiOAql6wkwBUZXKeKrPZnDWSy/c0uvDqeW4aqF4qWzc4aJ/cPkLzirWPHvpw3
 rh6mROHyC+NhuGCuEPLz2Jd728fjkeYoT6vCc2ixfnA0bPoPbQBsN+Qi9ldqLFqTyw3A
 fPJjlsxMh+yTLL6hnCnlttNAqSXyqN6G6nzuCqwLhACC/8b3SkKM0uY3bO3qz34r454+
 0CdqcWGgK0Li/Nhvq5xHKnYkfcpJDNOOlZPIq3Ym6p8hhS5BjwDx2iVgc/ZFMOdE6/sT
 8bun9pT09b3aK0vUpeYjfGy1XgYzBbBUP+ETHQtVpZ08WhkpF878foyY/FdTyPbr1ES2
 9fxg==
X-Gm-Message-State: AC+VfDxEEkXVOJOMucPSXzhj2G1bhnJH5HDd+34cok+/nSfrrF7WCxRW
 G4iLCa9B0isgGJt1noI5A0bQVSS/L6VND4FaygM=
X-Google-Smtp-Source: ACHHUZ5T+QIYc/hpdb27thMHAuyFL/uD3r4JDtvVs7r9EQpPfhdOq+xre+dTtRtflP+nONDpEpbCNilLUfN8Zx3xh8o=
X-Received: by 2002:a1f:450e:0:b0:46e:7738:1a9e with SMTP id
 s14-20020a1f450e000000b0046e77381a9emr2454280vka.9.1686745810091; Wed, 14 Jun
 2023 05:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230614140748.3584-1-ld.adecy@gmail.com>
 <d7404559-407e-5742-666c-6330da3d3e2c@linaro.org>
In-Reply-To: <d7404559-407e-5742-666c-6330da3d3e2c@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Wed, 14 Jun 2023 15:29:34 +0300
Message-ID: <CAK4993jzRnmfe1BeAQw2aFum3Z=tnQhQh5HyaQEw-2WrPSyeYw@mail.gmail.com>
Subject: Re: [PATCH] Fix handling of AVR interrupts above 33.
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Lucas Dietrich <ld.adecy@gmail.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d6422405fe161cb5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=mrolnik@gmail.com; helo=mail-vk1-xa32.google.com
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

--000000000000d6422405fe161cb5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Michael Rolnik <mrolnik@gmail.com>

On Wed, Jun 14, 2023 at 3:22=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 14/6/23 16:07, Lucas Dietrich wrote:
> > This commit addresses a bug in the AVR interrupt handling code.
> > The modification involves replacing the usage of the ctz32 function
> > with ctz64 to ensure proper handling of interrupts above 33 in the AVR
> > target.
> >
> > Previously, timers 3, 4, and 5 interrupts were not functioning correctl=
y
> > because most of their interrupt vectors are numbered above 33.
> >
> > Signed-off-by: Lucas Dietrich <ld.adecy@gmail.com>
> > ---
> >   target/avr/helper.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
>
> Thanks for insisting with the patch posting process :)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>

--=20
Best Regards,
Michael Rolnik

--000000000000d6422405fe161cb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@=
gmail.com">mrolnik@gmail.com</a>&gt;</div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 14, 2023 at 3:22=E2=80=AFPM=
 Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philm=
d@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On 14/6/23 16:07, Lucas Dietrich wrote:<br>
&gt; This commit addresses a bug in the AVR interrupt handling code.<br>
&gt; The modification involves replacing the usage of the ctz32 function<br=
>
&gt; with ctz64 to ensure proper handling of interrupts above 33 in the AVR=
<br>
&gt; target.<br>
&gt; <br>
&gt; Previously, timers 3, 4, and 5 interrupts were not functioning correct=
ly<br>
&gt; because most of their interrupt vectors are numbered above 33.<br>
&gt; <br>
&gt; Signed-off-by: Lucas Dietrich &lt;<a href=3D"mailto:ld.adecy@gmail.com=
" target=3D"_blank">ld.adecy@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/avr/helper.c | 4 ++--<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
Thanks for insisting with the patch posting process :)<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Be=
st Regards,<br>Michael Rolnik</div>

--000000000000d6422405fe161cb5--

