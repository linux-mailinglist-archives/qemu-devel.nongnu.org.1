Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A557055BD
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 20:13:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyz9h-0006YS-MM; Tue, 16 May 2023 14:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pyz9f-0006XZ-Nd
 for qemu-devel@nongnu.org; Tue, 16 May 2023 14:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pyz9b-0000A0-GB
 for qemu-devel@nongnu.org; Tue, 16 May 2023 14:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684260725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OlJuuSmbhCtiohBTeloUV/9tDmWfssw49jL9DY7atWI=;
 b=e8Fqv93wURRrYETC0fQFZqdA2QYVzkuwBqmkzLTpi9kYnsWOMgST4p+9E6ngnp9xP5/Nph
 FuBHOf33SLsLC6cgjx6KjqDkOLzXYVh/xplnEX1AjbaedK5QclXk1w1f9zx2WOcrqHxbga
 l6CLfYpb6w1xdvdYXe9Ph+Z0DnR7i88=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-mqBBhROnO2KRKIrGl_63-g-1; Tue, 16 May 2023 14:12:03 -0400
X-MC-Unique: mqBBhROnO2KRKIrGl_63-g-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-643fdfb437aso6411312b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 11:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684260719; x=1686852719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OlJuuSmbhCtiohBTeloUV/9tDmWfssw49jL9DY7atWI=;
 b=YmXwPXFGCmRA2RxEAkEKb4v+EGn1XpNCqRnv/3jUWB4dO5cMw6hg3mSWO9ZT8w4yAo
 DaYgYkotJt/2+h9YE4mjEk8swNi6CYji2tJrCcwwiClEai+KbBl/jpe523IssSVnoTtv
 W6no9D43itM7L+q/GDKhuMkyXvq7aJOoNtxpHi2ERA5M16xlAQBnnS3mVRtDr0Js4izb
 ikyDVtAgjOFpf/JwLjM67KP5YqXnnYwHcaroNPq/Mn41Yy8p3JgA1FHM8GwxmWpUbRvx
 eO46sLl3v5Y6T/s2U7gAmI1PNXlNtSUjT2R2s1j5QXN96SqARNWmZKRKIRi5NvHOGeIW
 hPzw==
X-Gm-Message-State: AC+VfDxHQWDsd14Av5j6AJdyowYG7JqCfY9nkRImF10R+KZC9Go1UtU8
 Bqd/6iamDQjV5J8pHC05QRUuWCwFSobIRXe8Db8aHzfBftqMTpPfBO+voEgL8D6LDM924iX4Fwk
 mhtenh03LFy7WxC1PUMXZyjQOMDllK1s=
X-Received: by 2002:a05:6a00:1f10:b0:63f:32ed:92b1 with SMTP id
 be16-20020a056a001f1000b0063f32ed92b1mr44620361pfb.7.1684260719423; 
 Tue, 16 May 2023 11:11:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5K945UVMZRmSqRTeiLiJ89uBiwYIJ5E3qSJJhjsXlEUil+dL6ukdiF75vAQ+V4CKlV32WXIYnxFINSpD9wj78=
X-Received: by 2002:a05:6a00:1f10:b0:63f:32ed:92b1 with SMTP id
 be16-20020a056a001f1000b0063f32ed92b1mr44620336pfb.7.1684260718917; Tue, 16
 May 2023 11:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230516105738.526631-1-pbonzini@redhat.com>
 <20230516105738.526631-2-pbonzini@redhat.com>
In-Reply-To: <20230516105738.526631-2-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 16 May 2023 14:11:47 -0400
Message-ID: <CAFn=p-bUsfB2gXyStFFT2LE9SjtDwL0WT22zr++bPDTtSB8g2g@mail.gmail.com>
Subject: Re: [PATCH v2 00/27] configure: create a python venv and ensure
 meson, sphinx
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Tue, May 16, 2023 at 6:57=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> This patch series creates a mandatory python virtual environment
> ("venv") during configure time and uses it to ensure the availability of
> meson and sphinx.
>
> See https://www.qemu.org/2023/03/24/python/ for motivations. The summary
> is that the goal of this series is to ensure that the `python` used to
> run meson is the same `python` used to run Sphinx, tests, and any
> build-time python scripting we have. As it stands, meson and sphinx (and
> their extensions) *may* run in a different python environment than the
> one configured and chosen by the user at configure/build time.
>
> The effective change of this series is that QEMU will now
> unconditionally create a venv at configure-time and will ensure that
> meson (and sphinx, if docs are enabled) are available through that venv.
>
> Some important points as a pre-emptive "FAQ":
>
> - Works for Python 3.6 and up, on Fedora, OpenSuSE, Red Hat, CentOS,
>   Alpine, Debian, Ubuntu, NetBSD, OpenBSD, and hopefully everywhere
>   No new dependencies (...for most platforms. Debian and NetBSD get an
>   asterisk, see patch 4).
>
> - The venv is unconditionally created and lives at {build_dir}/pyvenv.
>   The python interpreter used by this venv is always the one identified
>   by configure. (Which in turn is always the one specified by --python
>   or $PYTHON).  --meson and --sphinx-build disappear.
>
> - *almost* all python scripts in qemu.git executed as part of the build
>   system, meson, sphinx, avocado tests, vm tests or CI are always
>   executed within this venv.  iotests are not yet integrated.
>
> - Missing dependencies, when possible, are fetched and installed
>   on-demand automatically to make developer environments "just work".
>   However, it remains possible to build and test fully offline.  Right
>   now, online behavior is only triggered by --enable-docs, and even
>   in that case...
>
> - ... distribution packaged 'meson' and 'sphinx' are still utilized
>   whenever possible as the highest preference.
>
> - The bundled 'meson' takes the shape of a .whl file, replacing the
>   git submodule.  qemu-qmp will follow suit, while Sphinx will not be
>   bundled just like it already isn't.
>
> - about 13% of the mkvenv.py script is devoted to supporting Python
>   3.7 and Debian 10. =C2=AF\_(=E3=83=84)_/=C2=AF
>

I like that you measured this. It feels like more than 13%, but I'm
going to trust this oddly specific number.

> Tested with "make check-minreqs" after every patch and with GitLab at
> https://gitlab.com/bonzini/qemu/-/pipelines/868627762.

For v1, I also tested with "make check-minreqs && make check-tox" and
also started checking/formatting with black --line-length=3D79. I
haven't added black into the linters yet because there's surely a ton
of code that needs observed before I do that, but Dan suggested it and
I liked it enough to start using it myself to take the ambiguity out
of how to handle long lines.

(Not worth a respin if black isn't happy, I didn't check. Just mentioning i=
t.)

>
> Enjoy!
>
> John and Paolo
>
> v1->v2:
> - integrate distlib for script generation and also to look up
>   installed packages

Thanks :)

> - print a more precise error for --diagnose when running in an
>   isolated venv
> - reorganized code to avoid ensurepip, so that it is not spread
>   across multiple patches
> - made non-fatal errors a bit less scary

"Oops" =3D> "Oopsies!!"

>
>
> John Snow (23):
>   python: update pylint configuration
>   python: add mkvenv.py
>   mkvenv: add better error message for broken or missing ensurepip
>   mkvenv: add nested venv workaround
>   mkvenv: add ensure subcommand
>   mkvenv: add --diagnose option to explain "ensure" failures
>   mkvenv: add console script entry point generation
>   mkvenv: use pip's vendored distlib as a fallback
>   mkvenv: avoid ensurepip if pip is installed
>   mkvenv: work around broken pip installations on Debian 10
>   tests/docker: add python3-venv dependency
>   tests/vm: Configure netbsd to use Python 3.10
>   tests/vm: add py310-expat to NetBSD
>   python: add vendor.py utility
>   configure: create a python venv unconditionally
>   python/wheels: add vendored meson package
>   configure: use 'mkvenv ensure meson' to bootstrap meson
>   qemu.git: drop meson git submodule
>   tests: Use configure-provided pyvenv for tests
>   configure: move --enable-docs and --disable-docs back to configure
>   configure: bootstrap sphinx with mkvenv
>   configure: add --enable-pypi and --disable-pypi
>   configure: Add courtesy hint to Python version failure message
>
> Paolo Bonzini (4):
>   python: shut up "pip install" during "make check-minreqs"
>   Python: Drop support for Python 3.6
>   mkvenv: mark command as required
>   python: bump some of the dependencies
>
>  .gitlab-ci.d/buildtest-template.yml           |   4 +-
>  .gitlab-ci.d/buildtest.yml                    |   6 +-
>  .gitmodules                                   |   3 -
>  configure                                     | 152 +--
>  docs/about/build-platforms.rst                |   2 +-
>  docs/conf.py                                  |   9 -
>  docs/devel/acpi-bits.rst                      |   6 +-
>  docs/devel/testing.rst                        |  14 +-
>  docs/meson.build                              |   2 +-
>  meson                                         |   1 -
>  meson_options.txt                             |   2 -
>  python/Makefile                               |  19 +-
>  python/scripts/mkvenv.py                      | 897 ++++++++++++++++++
>  python/scripts/vendor.py                      |  74 ++
>  python/setup.cfg                              |  46 +-
>  python/tests/flake8.sh                        |   1 +
>  python/tests/isort.sh                         |   1 +
>  python/tests/minreqs.txt                      |  19 +-
>  python/tests/mypy.sh                          |   1 +
>  python/tests/pylint.sh                        |   1 +
>  python/wheels/meson-0.61.5-py3-none-any.whl   | Bin 0 -> 862509 bytes
>  .../org.centos/stream/8/x86_64/test-avocado   |   4 +-
>  scripts/device-crash-test                     |   2 +-
>  scripts/meson-buildoptions.sh                 |   3 -
>  scripts/qapi/mypy.ini                         |   2 +-
>  tests/Makefile.include                        |  10 +-
>  .../dockerfiles/debian-all-test-cross.docker  |   3 +-
>  .../dockerfiles/debian-hexagon-cross.docker   |   3 +-
>  .../dockerfiles/debian-riscv64-cross.docker   |   3 +-
>  .../dockerfiles/debian-tricore-cross.docker   |   3 +-
>  tests/requirements.txt                        |   7 +-
>  tests/vm/netbsd                               |   2 +
>  32 files changed, 1167 insertions(+), 135 deletions(-)
>  delete mode 160000 meson
>  create mode 100644 python/scripts/mkvenv.py
>  create mode 100755 python/scripts/vendor.py
>  create mode 100644 python/wheels/meson-0.61.5-py3-none-any.whl
>
> --
> 2.40.1
>


