Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFC77BC0F5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 23:08:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qos23-00042J-8u; Fri, 06 Oct 2023 17:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qos21-00041m-1n
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 17:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qos1z-0008Lc-8s
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 17:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696626402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GjmAOTGLFUfIM+eDuAX9LeCJ89s+6tx//L9dnlX1a80=;
 b=KtojSNGabI1f6v0QJhCDAArkrjM/eciwINCZJakdvpkoq++Cvk+XTf6G2pesHw1n/L6l21
 P2Fcnas+tXYXHlEZmc8rrpQARVgfxeUmiZc30ff9mm+O+1Asn+M6cLu40i/xJD6klGoNOd
 OUVfuKYmfrN/zAUCZ6GWfbl7H6dh60w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-vg1ScI2uNzeUnubozHyjpg-1; Fri, 06 Oct 2023 17:06:40 -0400
X-MC-Unique: vg1ScI2uNzeUnubozHyjpg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2775642edfcso2386120a91.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 14:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696626399; x=1697231199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GjmAOTGLFUfIM+eDuAX9LeCJ89s+6tx//L9dnlX1a80=;
 b=a8hMacFOPJc6ENeVIe04kABoJyJT5S1Mwm4M3eVUQ0SdhoEbhCHuSEO6DdCQn/zSiN
 z+81nBgqPQzQ2/DitOCUVSFy+HJ80esu+Z1rMYLm9Ap1U8VhvwSegc84wNWiy++SDkWs
 tstHeechndOSON0J8jGspWuh5qTlhL5gOO2Cc3a4WiAraIYfOTAequAmLTXKTzSKNjkV
 gGGydp/lV6zB4seyZ/dV7lFvjRW8y289qAHe9GKc3IY97eqNHbm9qlMngDVpqVyGckVD
 TlNCu/R10AKRjSaC2AdV3VTP/kUVidqe4R1chNImGxRb2SukpQxRiCPEOzcnIIOBH/u5
 rzMQ==
X-Gm-Message-State: AOJu0Yz6Xs9nQ9Ao6E8vnLMmrshjrMFh6Wnj6HTR6d2JbCeJ7UUMoMw1
 rQDFdgRNKq4IXvJ15zA87VNSjsTnq+0lVcEtPUv4DMLqBnDxGMui0HNJWgZzHGOHxCmT5QAvVn9
 ay7yXVeq9wQyrF7ifSJV4FEyFIoFitUc=
X-Received: by 2002:a17:90b:4a0c:b0:274:b4ce:7049 with SMTP id
 kk12-20020a17090b4a0c00b00274b4ce7049mr9002546pjb.34.1696626399398; 
 Fri, 06 Oct 2023 14:06:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXZQfIUx2ezClBHTK+FCB83+ZtEjIkgVPnOFB3r+HlGEqGf7zZXbE5PK1GZEnDzgSMYALa49KaTsF0EDcGLcI=
X-Received: by 2002:a17:90b:4a0c:b0:274:b4ce:7049 with SMTP id
 kk12-20020a17090b4a0c00b00274b4ce7049mr9002527pjb.34.1696626399097; Fri, 06
 Oct 2023 14:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231006195243.3131140-1-jsnow@redhat.com>
 <20231006195243.3131140-5-jsnow@redhat.com>
 <c423bb7c-867d-4b43-b472-2c548628e645@yandex-team.ru>
In-Reply-To: <c423bb7c-867d-4b43-b472-2c548628e645@yandex-team.ru>
From: John Snow <jsnow@redhat.com>
Date: Fri, 6 Oct 2023 17:06:28 -0400
Message-ID: <CAFn=p-YMXba1PdHhN3pm+9D2zGZ+XkAnT2nLG4O7jmoJrHDCyw@mail.gmail.com>
Subject: Re: [PATCH 4/4] Python: Enable python3.12 support
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-block@nongnu.org, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 6, 2023 at 4:40=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 06.10.23 22:52, John Snow wrote:
> > Python 3.12 has released, so update the test infrastructure to test
> > against this version. Update the configure script to look for it when a=
n
> > explicit Python interpreter isn't chosen.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   configure                              | 3 ++-
> >   python/setup.cfg                       | 3 ++-
> >   tests/docker/dockerfiles/python.docker | 6 +++++-
> >   3 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/configure b/configure
> > index e9a921ffb0..b480a3d6ae 100755
> > --- a/configure
> > +++ b/configure
> > @@ -561,7 +561,8 @@ first_python=3D
> >   if test -z "${PYTHON}"; then
> >       # A bare 'python' is traditionally python 2.x, but some distros
> >       # have it as python 3.x, so check in both places.
> > -    for binary in python3 python python3.11 python3.10 python3.9 pytho=
n3.8; do
> > +    for binary in python3 python python3.12 python3.11 \
> > +                          python3.10 python3.9 python3.8; do
> >           if has "$binary"; then
> >               python=3D$(command -v "$binary")
> >               if check_py_version "$python"; then
> > diff --git a/python/setup.cfg b/python/setup.cfg
> > index 8c67dce457..48668609d3 100644
> > --- a/python/setup.cfg
> > +++ b/python/setup.cfg
> > @@ -18,6 +18,7 @@ classifiers =3D
> >       Programming Language :: Python :: 3.9
> >       Programming Language :: Python :: 3.10
> >       Programming Language :: Python :: 3.11
> > +    Programming Language :: Python :: 3.12
> >       Typing :: Typed
> >
> >   [options]
> > @@ -182,7 +183,7 @@ multi_line_output=3D3
> >   # of python available on your system to run this test.
> >
> >   [tox:tox]
> > -envlist =3D py38, py39, py310, py311
> > +envlist =3D py38, py39, py310, py311, py312
> >   skip_missing_interpreters =3D true
> >
> >   [testenv]
> > diff --git a/tests/docker/dockerfiles/python.docker b/tests/docker/dock=
erfiles/python.docker
> > index 383ccbdc3a..a3c1321190 100644
> > --- a/tests/docker/dockerfiles/python.docker
> > +++ b/tests/docker/dockerfiles/python.docker
> > @@ -11,7 +11,11 @@ ENV PACKAGES \
> >       python3-pip \
> >       python3-tox \
> >       python3-virtualenv \
> > -    python3.10
> > +    python3.10 \
> > +    python3.11 \
> > +    python3.12 \
> > +    python3.8 \
> > +    python3.9
>
> Hmm, interesting, how did it work before? Only 3.10 was tested?

I was relying on dependencies to pull in other versions -- tox usually
pulls in all but the very latest version. I made it explicit instead.
I can explain this in the commit.

>
> >
> >   RUN dnf install -y $PACKAGES
> >   RUN rpm -q $PACKAGES | sort > /packages.txt
>
> weak, I'm unsure about how this all works, I just see that 3.12 is added =
like others in all hunks except python.docker, but I think adding several p=
ython versions to docker should be safe anyway:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks -- and I see your patches for iotests. I'll try to look into
them shortly.

>
> --
> Best regards,
> Vladimir
>


