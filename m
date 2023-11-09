Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F031E7E73AB
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 22:37:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Ch0-0000hv-Ct; Thu, 09 Nov 2023 16:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r1Cgy-0000he-Nb
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 16:36:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r1Cgv-0003wn-UH
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 16:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699565756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TRDMQDVYqhUZnt4ORu8xRvgj+N4wDUR0vU3LFDGgzM4=;
 b=cBOmIPjvvZG8GF7h6yjcgxDkxyhPVEs8n5TZbRGWyRMac98XigP5mxs80ymk8QF1UNKgo2
 qy+HOL85cyVxJ11c2ieFTVQ0m+KA6XpRD3Rq0dbRtqBJYAQ62NgSqIvrATB4SZBD/PRLgG
 IGSmfKYBDJ8rou6QDctCawzgMyvlGRg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-f6fnPnqkPTi2vDQL1kFong-1; Thu, 09 Nov 2023 16:35:55 -0500
X-MC-Unique: f6fnPnqkPTi2vDQL1kFong-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2804a04e233so1266579a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 13:35:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699565753; x=1700170553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRDMQDVYqhUZnt4ORu8xRvgj+N4wDUR0vU3LFDGgzM4=;
 b=pYL5CyvlR8gFcRgTqcNOBwyQvlhAjly15P4mVftMh+F+G6EnRdsRbFrvG4xiisRGEe
 Yunhu3acAhAMJ6qmemJv3aiOuzBat+ahBYix4USQxcsAK9MvtksVvRJRoZrK3Ky6ESKY
 JyWdQQedjPUPg773tntaAq7M/8LeTpjVp5H/+hC7GfE5qe8d206zETMhd/vrN0VzNNWv
 Cci0KapSHY97bTDYC0ymop6RkstoR2/dQTdPMd8Eoo1dpSatEbWmxaTqyGzGMAQLfFLd
 DhXFXlhtpBy/fEaQ+yA/aGY4W0gDhPm7Pkr0f4zG7dVg5iE7bevIvMKw73kPS9m5C5wj
 n79Q==
X-Gm-Message-State: AOJu0Yx43baEMOD26BZtCMyuihKGMf6foXst+XsnLebTTPl1NhiYWZu0
 jfZT+CmR0yRNhudtSHMPgSU4uBZAsUdywDowqyA+3ynxhFfsbkMtcp6ttCe/ZyN9TZEqLUfNR6W
 e7JCx7o+KkHI0OcGeGmC99LWoaViMwtk=
X-Received: by 2002:a17:90b:3a8d:b0:280:6b5b:3f40 with SMTP id
 om13-20020a17090b3a8d00b002806b5b3f40mr2971641pjb.8.1699565753411; 
 Thu, 09 Nov 2023 13:35:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwZW4TF7s/cov9deGc12Gnc4Xwy44tQ5iDauQTJVx+u4/bmm43cNblkRk5noouCNSYfqDx/0sRFSoShyJRpoM=
X-Received: by 2002:a17:90b:3a8d:b0:280:6b5b:3f40 with SMTP id
 om13-20020a17090b3a8d00b002806b5b3f40mr2971620pjb.8.1699565753054; Thu, 09
 Nov 2023 13:35:53 -0800 (PST)
MIME-Version: 1.0
References: <20231109155855.844630-1-pbonzini@redhat.com>
 <CAFn=p-YZ=sMJ0=C71wX1x6NXcK8rSZfVO+f3TQQExADGJhEJdg@mail.gmail.com>
In-Reply-To: <CAFn=p-YZ=sMJ0=C71wX1x6NXcK8rSZfVO+f3TQQExADGJhEJdg@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 9 Nov 2023 16:35:42 -0500
Message-ID: <CAFn=p-YB9QawiXd2newm1itooNpnU_4QY29zC2aFp2mN4beTHg@mail.gmail.com>
Subject: Re: [PATCH] docs: document what configure does with virtual
 environments
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Whoops, didn't mean to reply off-list.

On Thu, Nov 9, 2023 at 4:34=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> On Thu, Nov 9, 2023 at 10:59=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > Given the recent confusion around how QEMU detects the system
> > Meson installation, and/or decides to install its own, it is
> > time to fill in the "Python virtual environments and the QEMU
> > build system" section of the documentation.
> >
> > As a curiosity, a first and partial draft of the text was generated
> > by an LLM[1].  It required quite a bit of editing and probably did not
> > save much time, but some expressions do remain in the finished text.
>
> boo :p
>
> >
> > [1] https://chat.openai.com/share/42c1500d-71c1-480b-bab9-7ccc2c155365
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  docs/devel/build-system.rst | 54 ++++++++++++++++++++++++++++++++++---
> >  pythondeps.toml             |  3 ++-
> >  2 files changed, 53 insertions(+), 4 deletions(-)
> >
> > diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> > index 21f78da7d1d..4def2e55e73 100644
> > --- a/docs/devel/build-system.rst
> > +++ b/docs/devel/build-system.rst
> > @@ -122,10 +122,49 @@ functioning.  These are performed using a few mor=
e helper functions:
> >     indicated by $TMPC.
> >
> >
> > -Python virtual environments and the QEMU build system
> > ------------------------------------------------------
> > +Python virtual environments and the build process
> > +-------------------------------------------------
> > +
> > +An important part of configure is to create a Python virtual environme=
nt
> > +(venv) during the configuration phase, using the Python interpreter th=
at
> > +``configure`` identified, or that was requested via the ``--python``
> > +command line option and the ``$PYTHON`` variable from the environment.
>
> Which takes precedence, in what order? "and" makes it sound as if both
> --python and $PYTHON are considered, but I don't think that's actually
> true.
>
> > +The venv resides in the ``pyvenv`` directory in the build tree,
> > +and provides consistency in how the build process runs Python code.
> > +In particular it avoids a potential mismatch, where Meson and Sphinx
>
> I think you can drop the comma. This is so pedantic that if you left
> it in to spite me, I'd not blame you. :)
>
> > +binaries on the PATH might operate in a different Python environment
> > +than the one chosen by the user during the build process.
> > +
> > +At this stage, ``configure`` also queries the chosen Python interprete=
r
> > +about QEMU's build dependencies.  ``configure`` does  *not*
> > +pick the ``meson``, ``sphinx-build`` or ``avocado`` binaries in the PA=
TH;
> > +likewise, there are no options such as ``--meson`` or ``sphinx-build``=
.
>
> should we say ``--sphinx-build``?
>
> I also might say "does not ^necessarily pick the ..." because they
> could be the same, it just isn't the criteria it uses to choose them.
>
> > +If QEMU does not find a dependency, check that it was installed in the
> > +right ``site-packages`` directory or with the right ``pip`` program.
>
> I don't actually know what this means. >_>
>
> > +
> > +If the package is available as a system package for the chosen
>
> technically, I think if the package is available at all for the chosen
> interpreter. We supported nested venvs, so it's more than just system
> packages.
>
> > +interpreter, ``configure`` prepares a small script that invokes it
> > +from the venv itself.  If not, ``configure`` can also optionally
> > +install dependencies in the virtual environment with ``pip``.
>
> What may not be clear here is that this can refer to installing from
> bundled sources in the source tree. IIRC, it's used in preference to
> internet sources, isn't it? (Unless that changed.)
>
> > +Downloading is triggered only when a ``configure`` option (currently,
> > +only ``--enable-docs``) is explicitly enabled but the dependencies are
> > +not present, and can also be disabled with ``--disable-download``.[#pi=
p]_
> > +
> > +.. [#pip_] Avocado can also be installed with ``pip`` in the virtual
> > +           environment when running ``make check-avocado``.  In this
> > +           case, it is not currently possible to block the downloading=
.
> > +
>
> Similarly to my above comment: if downloads are disabled, we do have
> some vendored packages we'll attempt to use.
>
> > +The required versions of the packages are stored in a configuration fi=
le
> > +``pythondeps.toml``.  The format is custom to QEMU, but it is document=
ed
> > +at the top of the file itself and it should be easy to understand.  Th=
e
> > +requirements should make it possible to use the version that is packag=
ed
> > +that is provided by supported distros.
> > +
> > +When dependencies are downloaded, instead, ``configure`` uses a "known
> > +good" version that is also listed in ``pythondeps.toml``.  In this
> > +scenario, ``pythondeps.toml`` behaves like the "lock file" used by
> > +``cargo``, ``poetry`` or other dependency management systems.
> >
> > -TBD
> >
> >  Stage 2: Meson
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > @@ -376,6 +415,15 @@ This is needed to obey the --python=3D option pass=
ed to the configure
> >  script, which may point to something other than the first python3
> >  binary on the path.
> >
> > +By the time Meson runs, Python dependencies are available in the virtu=
al
> > +environment and should be invoked though the scripts that ``configure`=
`
>
> through
>
> > +places under ``pyvenv``.  One way to do so is as follows, using Meson'=
s
> > +``find_program`` function::
> > +
> > +  sphinx_build =3D find_program(
> > +       fs.parent(python.full_path()) / 'sphinx-build',
> > +       required: get_option('docs'))
> > +
> >
> >  Stage 3: Make
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > diff --git a/pythondeps.toml b/pythondeps.toml
> > index 0a35ebcf9f0..4beadfd96f5 100644
> > --- a/pythondeps.toml
> > +++ b/pythondeps.toml
> > @@ -10,7 +10,8 @@
> >  # - accepted: accepted versions when using a system package
> >  # - installed: fixed version to install in the virtual environment
> >  #              if a system package is not found; if not specified,
> > -#              the minimum and maximum
> > +#              defaults to the same as "accepted" or, if also missing,
> > +#              to the newest version available on PyPI.
> >  # - canary: if specified, use this program name to present more
> >  #           precise error diagnostics to the user.  For example,
> >  #           'sphinx-build' can be used as a bellwether for the
> > --
> > 2.41.0
> >


