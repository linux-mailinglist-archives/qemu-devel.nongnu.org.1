Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6AC71185C
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 22:44:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2HnT-0002K9-Vt; Thu, 25 May 2023 16:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q2HnO-0002Jc-Ef
 for qemu-devel@nongnu.org; Thu, 25 May 2023 16:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q2Hmy-0002x8-7r
 for qemu-devel@nongnu.org; Thu, 25 May 2023 16:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685047342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xHVU0qWkedVoNajGMwVw+ggsw6U+IVBERYKT5P0/pF4=;
 b=asfJ5Tx2ZRGyWzqogu+EiSFOEAzskSGBrcbT1/3cRN4EjmhFj5MrxFFIN6TNdLWNGjH6Bn
 4RZcvE4PZWBF4LLjWv9+nofOm7An0hK+OGYRH+kRg1FQ51hVh9uz4obE3BGqD0WSdydfaK
 YNBRMTg9ajDX8ZYAwTmdtpkQxyMy+AM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-AX9miwJ4NjmDtg-MZZGGqg-1; Thu, 25 May 2023 16:42:20 -0400
X-MC-Unique: AX9miwJ4NjmDtg-MZZGGqg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-530a1b22514so1166079a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 13:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685047340; x=1687639340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xHVU0qWkedVoNajGMwVw+ggsw6U+IVBERYKT5P0/pF4=;
 b=UbT0FlFY423eWTuKXnsgdeqX3mPlBMhQ/d5e3LKNtUxLoXlhumarOjpPfc/zIzfFTD
 p7FPBu6Hcuc0TcT/1Nud2/IXh1TbqpV94ebslqJ6hnKdjeY29cmVXCv2d/d0g/GlQ8su
 TnC0sGVPZ2Wk3c+G+lkKZGuJF7iqhC8YTwKaCf1WBJYbZAOrCcYwiHEfDhoz7mzlJ5Hy
 xlxxxbc2Ib5JyuG4n4wRN/yq3ZPKVPdsaGu7Pz9iZNK7+CcAXDuhejZV23/Jc6giNBxH
 ajA9OruXE26V4gmLWxOIGs82xVqI/mDpPPZr5pG6gpf9ABCQzI9qJGFeJcaIn8WnpC1K
 IxvQ==
X-Gm-Message-State: AC+VfDyW47Wltzqk1Nx0KTuMprEpt+4+3XlRpcNIHFZ4E+Sb88UOBKVe
 FjJiVUtmx2dx/4T8m0soTFX6Kz2OjgBUB/fYOzEtDtqH+Ez+/5t3RrOkj8xAhDZ5a++fRmwn5k1
 knKhbLxCdyx78Qin+2TeNAm2LX7WLBIE=
X-Received: by 2002:a17:902:ab8a:b0:1ac:aac1:e344 with SMTP id
 f10-20020a170902ab8a00b001acaac1e344mr2618107plr.36.1685047339745; 
 Thu, 25 May 2023 13:42:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4aOb3actQ/vjQIUj8Pp3wled4Yvk1aHp6n+tRSQEkao0EigQgJ/Sf29yLgjS2+2e2G65MIXcmIbSHkYD9r0LI=
X-Received: by 2002:a17:902:ab8a:b0:1ac:aac1:e344 with SMTP id
 f10-20020a170902ab8a00b001acaac1e344mr2618083plr.36.1685047339299; Thu, 25
 May 2023 13:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230516105908.527838-1-pbonzini@redhat.com>
 <20230516105908.527838-6-pbonzini@redhat.com>
In-Reply-To: <20230516105908.527838-6-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 25 May 2023 16:42:08 -0400
Message-ID: <CAFn=p-a=druvECmrOJv7o5ydK4Unm3xda8N6FAiRCA+CEdjyTg@mail.gmail.com>
Subject: Re: [PATCH v2 06/27] mkvenv: add ensure subcommand
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, May 16, 2023 at 6:59=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> From: John Snow <jsnow@redhat.com>
>
> This command is to be used to add various packages (or ensure they're
> already present) into the configure-provided venv in a modular fashion.
>
> Examples:
>
> mkvenv ensure --online --dir "${source_dir}/python/wheels/" "meson>=3D0.6=
1.5"
> mkvenv ensure --online "sphinx>=3D1.6.0"
> mkvenv ensure "qemu.qmp=3D=3D0.0.2"
>
> It's designed to look for packages in three places, in order:
>
> (1) In system packages, if the version installed is already good
> enough. This way your distribution-provided meson, sphinx, etc are
> always used as first preference.
>
> (2) In a vendored packages directory. Here I am suggesting
> qemu.git/python/wheels/ as that directory. This is intended to serve as
> a replacement for vendoring the meson source for QEMU tarballs. It is
> also highly likely to be extremely useful for packaging the "qemu.qmp"
> package in source distributions for platforms that do not yet package
> qemu.qmp separately.
>
> (3) Online, via PyPI, ***only when "--online" is passed***. This is only
> ever used as a fallback if the first two sources do not have an
> appropriate package that meets the requirement. The ability to build
> QEMU and run tests *completely offline* is not impinged.
>

I should point out that the commit message here is no longer true,
this order isn't explicitly maintained, because:

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Message-Id: <20230511035435.734312-7-jsnow@redhat.com>
> [Use distlib to lookup distributions. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  python/scripts/mkvenv.py | 135 ++++++++++++++++++++++++++++++++++++++-
>  python/setup.cfg         |  10 +++
>  python/tests/minreqs.txt |   3 +
>  3 files changed, 145 insertions(+), 3 deletions(-)
>
> diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
> index 2a3d73a51db4..fd4b62c70ffa 100644
> --- a/python/scripts/mkvenv.py
> +++ b/python/scripts/mkvenv.py
> @@ -11,6 +11,7 @@
>  Commands:
>    command     Description
>      create    create a venv
> +    ensure    Ensure that the specified package is installed.
>
>  --------------------------------------------------
>
> @@ -22,6 +23,18 @@
>  options:
>    -h, --help  show this help message and exit
>
> +--------------------------------------------------
> +
> +usage: mkvenv ensure [-h] [--online] [--dir DIR] dep_spec...
> +
> +positional arguments:
> +  dep_spec    PEP 508 Dependency specification, e.g. 'meson>=3D0.61.5'
> +
> +options:
> +  -h, --help  show this help message and exit
> +  --online    Install packages from PyPI, if necessary.
> +  --dir DIR   Path to vendored packages where we may install from.
> +
>  """
>
>  # Copyright (C) 2022-2023 Red Hat, Inc.
> @@ -43,8 +56,17 @@
>  import sys
>  import sysconfig
>  from types import SimpleNamespace
> -from typing import Any, Optional, Union
> +from typing import (
> +    Any,
> +    Optional,
> +    Sequence,
> +    Union,
> +)
>  import venv
> +import warnings
> +
> +import distlib.database
> +import distlib.version
>
>
>  # Do not add any mandatory dependencies from outside the stdlib:
> @@ -309,6 +331,77 @@ def _stringify(data: Union[str, bytes]) -> str:
>      print(builder.get_value("env_exe"))
>
>
> +def pip_install(
> +    args: Sequence[str],
> +    online: bool =3D False,
> +    wheels_dir: Optional[Union[str, Path]] =3D None,
> +) -> None:
> +    """
> +    Use pip to install a package or package(s) as specified in @args.
> +    """
> +    loud =3D bool(
> +        os.environ.get("DEBUG")
> +        or os.environ.get("GITLAB_CI")
> +        or os.environ.get("V")
> +    )
> +
> +    full_args =3D [
> +        sys.executable,
> +        "-m",
> +        "pip",
> +        "install",
> +        "--disable-pip-version-check",
> +        "-v" if loud else "-q",
> +    ]
> +    if not online:
> +        full_args +=3D ["--no-index"]
> +    if wheels_dir:
> +        full_args +=3D ["--find-links", f"file://{str(wheels_dir)}"]
> +    full_args +=3D list(args)
> +    subprocess.run(
> +        full_args,
> +        check=3DTrue,
> +    )
> +
> +
> +def ensure(
> +    dep_specs: Sequence[str],
> +    online: bool =3D False,
> +    wheels_dir: Optional[Union[str, Path]] =3D None,
> +) -> None:
> +    """
> +    Use pip to ensure we have the package specified by @dep_specs.
> +
> +    If the package is already installed, do nothing. If online and
> +    wheels_dir are both provided, prefer packages found in wheels_dir
> +    first before connecting to PyPI.
> +
> +    :param dep_specs:
> +        PEP 508 dependency specifications. e.g. ['meson>=3D0.61.5'].
> +    :param online: If True, fall back to PyPI.
> +    :param wheels_dir: If specified, search this path for packages.
> +    """
> +    with warnings.catch_warnings():
> +        warnings.filterwarnings(
> +            "ignore", category=3DUserWarning, module=3D"distlib"
> +        )
> +        dist_path =3D distlib.database.DistributionPath(include_egg=3DTr=
ue)
> +        absent =3D []
> +        for spec in dep_specs:
> +            matcher =3D distlib.version.LegacyMatcher(spec)
> +            dist =3D dist_path.get_distribution(matcher.name)
> +            if dist is None or not matcher.match(dist.version):
> +                absent.append(spec)
> +            else:
> +                logger.info("found %s", dist)
> +

^ This change to determine if a package is installed or not instead of
using pip to figure it out for us, means that ...

> +    if absent:
> +        # Some packages are missing or aren't a suitable version,
> +        # install a suitable (possibly vendored) package.
> +        print(f"mkvenv: installing {', '.join(absent)}", file=3Dsys.stde=
rr)
> +        pip_install(args=3Dabsent, online=3Donline, wheels_dir=3Dwheels_=
dir)
> +

^ a single invocation to pip will actually consider both online and
offline sources simultaneously, and chooses the "best version" between
all sources, with no weighting or preference given to the offline
source.

The only way to prefer an offline source to the exclusion of an online
one is with two separate pip_install invocations; so a suitable patch
here (sans some error management) might be:

if wheels_dir and online:
    try:
        pip_install(args=3Dabsent, wheels_dir)
        return
    except CalledProcessError:
        pass

pip_install(args=3Dabsent, online=3Donline, wheels_dir=3Dwheels_dir)


It *may* be a good idea to implement this so that a meson release in
the middle of an RC freeze does not accidentally change the build
process for a large number of people all at once - It's a risk that
still exists with e.g. Fedora updates et al, but generally downstream
distros lag behind PyPI and we usually have lead time to work to
integrate bleeding edge python package versions (for example, I can
usually fix pylint errors in cutting edge PyPI packages before they
hit Fedora.)

That said, your changes here *do* improve the speed a lot - question,
why are we using LegacyMatcher instead of ... not a Legacy version? I
don't see good docs for this one on the distlib site. (Is this what
pip itself is using somewhere?)

--js

> +
>  def _add_create_subcommand(subparsers: Any) -> None:
>      subparser =3D subparsers.add_parser("create", help=3D"create a venv"=
)
>      subparser.add_argument(
> @@ -319,13 +412,42 @@ def _add_create_subcommand(subparsers: Any) -> None=
:
>      )
>
>
> +def _add_ensure_subcommand(subparsers: Any) -> None:
> +    subparser =3D subparsers.add_parser(
> +        "ensure", help=3D"Ensure that the specified package is installed=
."
> +    )
> +    subparser.add_argument(
> +        "--online",
> +        action=3D"store_true",
> +        help=3D"Install packages from PyPI, if necessary.",
> +    )
> +    subparser.add_argument(
> +        "--dir",
> +        type=3Dstr,
> +        action=3D"store",
> +        help=3D"Path to vendored packages where we may install from.",
> +    )
> +    subparser.add_argument(
> +        "dep_specs",
> +        type=3Dstr,
> +        action=3D"store",
> +        help=3D"PEP 508 Dependency specification, e.g. 'meson>=3D0.61.5'=
",
> +        nargs=3D"+",
> +    )
> +
> +
>  def main() -> int:
>      """CLI interface to make_qemu_venv. See module docstring."""
>      if os.environ.get("DEBUG") or os.environ.get("GITLAB_CI"):
>          # You're welcome.
>          logging.basicConfig(level=3Dlogging.DEBUG)
> -    elif os.environ.get("V"):
> -        logging.basicConfig(level=3Dlogging.INFO)
> +    else:
> +        if os.environ.get("V"):
> +            logging.basicConfig(level=3Dlogging.INFO)
> +
> +        # These are incredibly noisy even for V=3D1
> +        logging.getLogger("distlib.metadata").addFilter(lambda record: F=
alse)
> +        logging.getLogger("distlib.database").addFilter(lambda record: F=
alse)
>
>      parser =3D argparse.ArgumentParser(
>          prog=3D"mkvenv",
> @@ -339,6 +461,7 @@ def main() -> int:
>      )
>
>      _add_create_subcommand(subparsers)
> +    _add_ensure_subcommand(subparsers)
>
>      args =3D parser.parse_args()
>      try:
> @@ -348,6 +471,12 @@ def main() -> int:
>                  system_site_packages=3DTrue,
>                  clear=3DTrue,
>              )
> +        if args.command =3D=3D "ensure":
> +            ensure(
> +                dep_specs=3Dargs.dep_specs,
> +                online=3Dargs.online,
> +                wheels_dir=3Dargs.dir,
> +            )
>          logger.debug("mkvenv.py %s: exiting", args.command)
>      except Ouch as exc:
>          print("\n*** Ouch! ***\n", file=3Dsys.stderr)
> diff --git a/python/setup.cfg b/python/setup.cfg
> index 5b25f810fa8b..d680374b2950 100644
> --- a/python/setup.cfg
> +++ b/python/setup.cfg
> @@ -36,6 +36,7 @@ packages =3D
>  # Remember to update tests/minreqs.txt if changing anything below:
>  devel =3D
>      avocado-framework >=3D 90.0
> +    distlib >=3D 0.3.6
>      flake8 >=3D 3.6.0
>      fusepy >=3D 2.0.4
>      isort >=3D 5.1.2
> @@ -112,6 +113,15 @@ ignore_missing_imports =3D True
>  [mypy-pkg_resources]
>  ignore_missing_imports =3D True
>
> +[mypy-distlib]
> +ignore_missing_imports =3D True
> +
> +[mypy-distlib.database]
> +ignore_missing_imports =3D True
> +
> +[mypy-distlib.version]
> +ignore_missing_imports =3D True
> +
>  [pylint.messages control]
>  # Disable the message, report, category or checker with the given id(s).=
 You
>  # can either give multiple identifiers separated by comma (,) or put thi=
s
> diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
> index dfb8abb155f4..7ecf5e7fe483 100644
> --- a/python/tests/minreqs.txt
> +++ b/python/tests/minreqs.txt
> @@ -16,6 +16,9 @@ urwid=3D=3D2.1.2
>  urwid-readline=3D=3D0.13
>  Pygments=3D=3D2.9.0
>
> +# Dependencies for mkvenv
> +distlib=3D=3D0.3.6
> +
>  # Dependencies for FUSE support for qom-fuse
>  fusepy=3D=3D2.0.4
>
> --
> 2.40.1
>
>


