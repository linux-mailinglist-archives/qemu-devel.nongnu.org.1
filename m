Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC3678DE9A
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 21:13:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbQcE-0006Ur-BH; Wed, 30 Aug 2023 15:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qbQcC-0006Ug-5b
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 15:12:32 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qbQc9-0001FN-NP
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 15:12:31 -0400
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-500b66f8b27so294715e87.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 12:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693422747; x=1694027547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wHwzc6ZwN4m9WkJU6BzqPBu/jAQyW3y5ryXjHg1wwFM=;
 b=CPRJIHqp335xwdZYJFReSZMMwTGnd1p7MKzpCfRCp97yHWhxM0KMwn3W5hpXEa+btZ
 O5+Oj6DZUy+l8T4D+KD3iGwuDDbHl2h8h26LwlTNazvmeOeUcCnfAdsM04z1nYKayf4H
 Z8h2Wq/jTwDHj6O8F1Iuf2NRpXMfmACj4J73iQMepnly/5SXqrfpw/U44x25lk4E/mFP
 mcYKWwolPHNEAk93Q8RO5t269dYJIZYLcmaY4WgN2OXlVrYwrROkdueWLa8QNWPI72qx
 KtVkiGbA+tqQN6hbtF0IkY710v2MJ6vapuqS1vZV7vQn075A3xneRzmDryMdNhaJ2Qbu
 Nvxw==
X-Gm-Message-State: AOJu0YwOtK1svRO3ogI5/Dj6KpFEY/Khc+pxPV6tBBuPQBEALulWk0VA
 6S8eHtPKBOEJ73VAfGelGiIlGLV2F9G4PbW6
X-Google-Smtp-Source: AGHT+IEfsETAYeRfgi7+kgblhWU/jnp6Ux5Baeo5ii6s3vDovSxz+9Kw25B3B+213JBC1ZgJAeC72A==
X-Received: by 2002:ac2:5f9b:0:b0:4fd:b7fb:c9fa with SMTP id
 r27-20020ac25f9b000000b004fdb7fbc9famr2491813lfe.42.1693422747099; 
 Wed, 30 Aug 2023 12:12:27 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com.
 [209.85.208.177]) by smtp.gmail.com with ESMTPSA id
 q22-20020ac246f6000000b004fe0c51fb41sm2512738lfo.45.2023.08.30.12.12.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 12:12:26 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-2b9f0b7af65so2806881fa.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 12:12:26 -0700 (PDT)
X-Received: by 2002:a2e:9857:0:b0:2bc:d43c:8607 with SMTP id
 e23-20020a2e9857000000b002bcd43c8607mr2784969ljj.14.1693422746533; Wed, 30
 Aug 2023 12:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <CADc=-s5RwGViNTR-h5cq3np673W3RRFfhr4vCGJp0EoDUxvhog@mail.gmail.com>
 <87ledspdto.fsf@linaro.org>
In-Reply-To: <87ledspdto.fsf@linaro.org>
From: Matt Borgerson <contact@mborgerson.com>
Date: Wed, 30 Aug 2023 15:12:16 -0400
X-Gmail-Original-Message-ID: <CADc=-s4tXYRMi-6o0QUvagQWtsLZKn=0CU0aAos3ct_eeF_CPA@mail.gmail.com>
Message-ID: <CADc=-s4tXYRMi-6o0QUvagQWtsLZKn=0CU0aAos3ct_eeF_CPA@mail.gmail.com>
Subject: Re: [PATCH v2] plugins: Set final instruction count in
 plugin_gen_tb_end
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Matt Borgerson <contact@mborgerson.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004306b7060428b57a"
Received-SPF: pass client-ip=209.85.167.52; envelope-from=mborgerson@gmail.com;
 helo=mail-lf1-f52.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000004306b7060428b57a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Alex

On Wed, Aug 30, 2023, 14:47 Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:

>
> Matt Borgerson <contact@mborgerson.com> writes:
>
> > Translation logic may partially decode an instruction, then abort and
> > remove the instruction from the TB. This can happen for example when an
> > instruction spans two pages. In this case, plugins may get an incorrect
> > result when calling qemu_plugin_tb_n_insns to query for the number of
> > instructions in the TB. This patch updates plugin_gen_tb_end to set the
> > final instruction count.
>
> re-queued to plugins/next now I have rth's gusa patches.
>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--0000000000004306b7060428b57a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks Alex</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Aug 30, 2023, 14:47 Alex Benn=C3=A9e =
&lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
Matt Borgerson &lt;<a href=3D"mailto:contact@mborgerson.com" target=3D"_bla=
nk" rel=3D"noreferrer">contact@mborgerson.com</a>&gt; writes:<br>
<br>
&gt; Translation logic may partially decode an instruction, then abort and<=
br>
&gt; remove the instruction from the TB. This can happen for example when a=
n<br>
&gt; instruction spans two pages. In this case, plugins may get an incorrec=
t<br>
&gt; result when calling qemu_plugin_tb_n_insns to query for the number of<=
br>
&gt; instructions in the TB. This patch updates plugin_gen_tb_end to set th=
e<br>
&gt; final instruction count.<br>
<br>
re-queued to plugins/next now I have rth&#39;s gusa patches.<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>

--0000000000004306b7060428b57a--

