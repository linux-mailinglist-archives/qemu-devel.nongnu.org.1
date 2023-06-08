Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32674727391
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 02:06:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7399-0001lF-IA; Wed, 07 Jun 2023 20:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q7394-0001ky-Bb
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 20:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q738z-00037H-Bl
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 20:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686182687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7Om+Wz2K629CU8ehyWK5VMhb+CNr8vcvdj5Dkz2TSk=;
 b=RgiKNHf3zkpw0tu+TOePBWixWKNJymgog/YsNkPR9/MTx5dsJAsbj8BVdXuYTIIk3a/yYV
 3xZc/Aoyp7TXSCIzUhq2ibgFmoi0V/FBpRhqLKuk7dx24l0oi737RPP1oO0C0HpaqimDJ9
 AJaw+HzchYRBlbySRn6J6fbidZYYFjc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-FBddKP29PpG_aUlYNnW2Hg-1; Wed, 07 Jun 2023 20:04:45 -0400
X-MC-Unique: FBddKP29PpG_aUlYNnW2Hg-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-397f97f7966so61738b6e.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 17:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686182684; x=1688774684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7Om+Wz2K629CU8ehyWK5VMhb+CNr8vcvdj5Dkz2TSk=;
 b=S0w9BjHS3XnY7aBFvLejNdx91IUFeBEttBZ46TPvl0EEIbaP0xy8+WK30gupwIcPoY
 hwEOnaHEBy36QLoiAdXj5ddi+hRlKZlXxnSNKVqZo0db+3eA6cFDT0GWuvjdjo+5U1WT
 T3rsGbQYGZvALZ5HO/+EPnTHvvlQ6OADm9SI5xKHjqQPYIRTmFuifKgIy8Hvsz/sENLm
 J9uncQIgy34LBSyQ7EvolMAZklpkI5B0jnKYfip3J8s4vGvlowgEEL8rnJbDMX1JFhXp
 ww0EQvsDcsQTJCBW/Idov3/AL+fpBXrgJikGhA13IPVi9JX3aaN20EgPRRfKNb5Vw9J0
 Hh1A==
X-Gm-Message-State: AC+VfDwWf+X6uuZKos5yW1W3y4VKl333o9tz/sq/t2FVb+WfZ7CVqT1o
 Z0jNoqgF7LawgR8xCrhBjB3KuirzdTDJRd5NkKdPfXG24hOz/ia8Q18F0jJGmjcBoo40WOA43Nm
 wPtI2/Dvtriugzp70bT4YmTgVkMz0s+0=
X-Received: by 2002:a54:480e:0:b0:398:111d:c438 with SMTP id
 j14-20020a54480e000000b00398111dc438mr4470329oij.32.1686182684684; 
 Wed, 07 Jun 2023 17:04:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72VF1CQtDr0hwIoI6KxzkZMFXS3IqO9S/6I+NFX9Kwu+kH7lJiNVxhr5RQrdhbuQEyRiMNJrCsgezYsPWOBPo=
X-Received: by 2002:a54:480e:0:b0:398:111d:c438 with SMTP id
 j14-20020a54480e000000b00398111dc438mr4470318oij.32.1686182684387; Wed, 07
 Jun 2023 17:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <b869ab5c-7b2f-93fc-678f-53ee39118f97@redhat.com>
 <c21f16ae-f653-4150-1372-b33f99342bf2@redhat.com>
In-Reply-To: <c21f16ae-f653-4150-1372-b33f99342bf2@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 7 Jun 2023 20:04:33 -0400
Message-ID: <CAFn=p-bwcsGJ3zE_2YvZ4mB_K5vu7gCwoL5bhm+4Lr6VESsw1A@mail.gmail.com>
Subject: Re: Building of docs does not work anymore
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Jun 7, 2023 at 5:46=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote=
:
>
> On 07/06/2023 11.42, Thomas Huth wrote:
> >
> >   Hi Paolo, hi John,
> >
> > since the recent reworks with the Python venv, building of the docs doe=
s not
> > work for me on my RHEL 8 installation anymore.
> >
> > If I just run "configure" without any additional arguments, I get:
> >
> > ------------------------- 8< -----------------------------
> > $ ./configure
> > Using './build' as the directory for build output
> > python determined to be '/usr/bin/python3.8'
> > python version: Python 3.8.13
> > mkvenv: Creating non-isolated virtual environment at 'pyvenv'
> > mkvenv: checking for meson>=3D0.63.0
> > mkvenv: installing meson>=3D0.63.0
> > mkvenv: checking for sphinx>=3D1.6.0, sphinx-rtd-theme>=3D0.5.0
> >
> > *** Ouch! ***
> >
> > Could not provide build dependency 'sphinx>=3D1.6.0':
> >   =E2=80=A2 Python package 'sphinx' was not found nor installed.
> >   =E2=80=A2 mkvenv was configured to operate offline and did not check =
PyPI.
> >   =E2=80=A2 'sphinx-build' was detected on your system at '/usr/bin/sph=
inx-build',
> > but the Python package 'sphinx' was not found by this Python interprete=
r
> > ('/usr/bin/python3.8'). Typically this means that 'sphinx-build' has be=
en
> > installed against a different Python interpreter on your system.
> >
> > Sphinx not found/usable, disabling docs.
> > ------------------------- 8< -----------------------------

Looks right as far as I can see. Should this behave differently, do you thi=
nk?

> >
> > If I enable downloads and enforce --enable-docs , I get:
> >
> > ------------------------- 8< -----------------------------
> > ./configure --enable-docs --enable-download
> > Using './build' as the directory for build output
> > python determined to be '/usr/bin/python3.8'
> > python version: Python 3.8.13
> > mkvenv: Creating non-isolated virtual environment at 'pyvenv'
> > mkvenv: checking for meson>=3D0.63.0
> > mkvenv: installing meson>=3D0.63.0
> > mkvenv: checking for sphinx>=3D1.6.0, sphinx-rtd-theme>=3D0.5.0
> > mkvenv: installing sphinx>=3D1.6.0, sphinx-rtd-theme>=3D0.5.0
> > ERROR: sphinx-rtd-theme 1.2.1 has requirement docutils<0.19, but you'll=
 have
> > docutils 0.20.1 which is incompatible.
> > ERROR: sphinx-rtd-theme 1.2.1 has requirement sphinx<7,>=3D1.6, but you=
'll
> > have sphinx 7.0.1 which is incompatible.
> > ------------------------- 8< -----------------------------
>
> Actually, it seems like it builds the docs in the latter case ... but the
> two error messages still look quite menacing (printed with red letters).
>
>   Thomas

Hm, in this case it appears that the latest versions of these packages
for Python 3.8 actually conflict with each other, which is ... funny.
I would think that in this case:

1. You don't have existing Python3.8 packages if it isn't your
system's native Python interpreter
2. Pip should have not chosen packages that conflict with each other ...

Can you do me a favor and try:

> python3.8 -m pip list

and tell me what packages it says you have there?

When I run "pip install sphinx>=3D1.6.0 sphinx-rtd-theme>=3D0.5.0" in a
fresh Python3.8 virtual environment, it chooses these versions:
- Sphinx 6.2.1
- sphinx-rtd-theme 1.2.2

Seems like Sphinx 7.0.1 is quite a bit too new for this, I wonder why
it chose it?

--js


