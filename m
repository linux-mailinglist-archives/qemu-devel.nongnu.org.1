Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D184F7055F8
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 20:28:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyzON-0000eN-6D; Tue, 16 May 2023 14:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pyzOL-0000eD-CF
 for qemu-devel@nongnu.org; Tue, 16 May 2023 14:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pyzOI-0002sQ-Gy
 for qemu-devel@nongnu.org; Tue, 16 May 2023 14:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684261637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nhSBiKxceejTWbkCfg3H4F+MXC/KGq0moE9fyhF5FJU=;
 b=Ezllc2O1azFQztIkFAi/Wemu200EY/VPf+UChjwDM7nw+jGbbzS2zImN023UJC++vtPAH7
 GPLPK2FW8VLRGJ2h6h6MkhCca9kmJm2X1ZMG7fQt9xhPFJfQbJ+fsIxM2QHJSTjYv+w7a6
 i3XbWbDfbIPxd8VY/eg2ObcBNipCOuo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-ln7mIC_VNGqu2-bnpAmbYg-1; Tue, 16 May 2023 14:27:14 -0400
X-MC-Unique: ln7mIC_VNGqu2-bnpAmbYg-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6434e3d1975so8482107b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 11:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684261633; x=1686853633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nhSBiKxceejTWbkCfg3H4F+MXC/KGq0moE9fyhF5FJU=;
 b=J25C0xLXy49lW8mIxJ47IIu0tohTmbEnx5gf6BUPn4UYuGyo+8bIA8hBP++MKefTdW
 wb9KEpYCPVLckfpn0Q7H7t/g/PYovAnDySRSYsw9FFN45vmNYR2D1AbFz3NUAJTtcYmq
 ItgywA8m2rY7Cmn15+5EGNpETR+oix7PHlodNHIitaggQxb58yNDI4Ctb06vfBKZtvDV
 /c06nTvVc/n1ccO80Zoj7c/EiLLO6W/R9BfQgC+DXb5VLht9F4OrUXuBfRYTrOw2PsrV
 Y89xgJL7tP4iUDBkLY1Y4/vwpydGxslleN2shfW3UDUYQFPDCL0btX1mveVYgJo8dalQ
 CfUQ==
X-Gm-Message-State: AC+VfDyX9kq27QVCDCuKmhdoVqaEDFwnA/8HRY58v47GWYwWLnd5Q8IV
 6eIh0SMP5YxuWeik+uuqKJj1bjeAHb8fGyCf4rRKuw6LYgfcJjb3qdLZC86C2hQ4ICI//mGf8B/
 vSw8dVCNcT8xellvs771Vo+bpBXH9QZouSrT2kyc=
X-Received: by 2002:a05:6a00:17a5:b0:63b:1708:10aa with SMTP id
 s37-20020a056a0017a500b0063b170810aamr55874443pfg.34.1684261632705; 
 Tue, 16 May 2023 11:27:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7+LqLciexJNmmyIXBd3rl6hm+ozql68g0GsJwiMGKu3RuEKuthy4GcGgSS3TbZvvxOrIZBT4RuPKps6ztWsro=
X-Received: by 2002:a05:6a00:17a5:b0:63b:1708:10aa with SMTP id
 s37-20020a056a0017a500b0063b170810aamr55874427pfg.34.1684261632289; Tue, 16
 May 2023 11:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230516105908.527838-1-pbonzini@redhat.com>
 <20230516105908.527838-7-pbonzini@redhat.com>
In-Reply-To: <20230516105908.527838-7-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 16 May 2023 14:27:01 -0400
Message-ID: <CAFn=p-be3oyTDFszUH24dOGw2EqbfRyTPxxvq+v3h=nGZVEMKA@mail.gmail.com>
Subject: Re: [PATCH v2 07/27] mkvenv: add --diagnose option to explain
 "ensure" failures
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

On Tue, May 16, 2023 at 6:59=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> From: John Snow <jsnow@redhat.com>
>
> This is a routine that is designed to print some usable info for human
> beings back out to the terminal if/when "mkvenv ensure" fails to locate
> or install a package during configure time, such as meson or sphinx.
>
> Since we are requiring that "meson" and "sphinx" are installed to the
> same Python environment as QEMU is configured to build with, this can
> produce some surprising failures when things are mismatched. This method
> is here to try and ease that sting by offering some actionable
> diagnosis.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Message-Id: <20230511035435.734312-8-jsnow@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  python/scripts/mkvenv.py | 170 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 169 insertions(+), 1 deletion(-)
>
> diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
> index fd4b62c70ffa..5ac22f584fab 100644
> --- a/python/scripts/mkvenv.py
> +++ b/python/scripts/mkvenv.py
> @@ -51,6 +51,8 @@
>  import logging
>  import os
>  from pathlib import Path
> +import re
> +import shutil
>  import site
>  import subprocess
>  import sys
> @@ -60,6 +62,7 @@
>      Any,
>      Optional,
>      Sequence,
> +    Tuple,
>      Union,
>  )
>  import venv
> @@ -331,6 +334,128 @@ def _stringify(data: Union[str, bytes]) -> str:
>      print(builder.get_value("env_exe"))
>
>
> +def pkgname_from_depspec(dep_spec: str) -> str:
> +    """
> +    Parse package name out of a PEP-508 depspec.
> +
> +    See https://peps.python.org/pep-0508/#names
> +    """
> +    match =3D re.match(
> +        r"^([A-Z0-9]([A-Z0-9._-]*[A-Z0-9])?)", dep_spec, re.IGNORECASE
> +    )
> +    if not match:
> +        raise ValueError(
> +            f"dep_spec '{dep_spec}'"
> +            " does not appear to contain a valid package name"
> +        )
> +    return match.group(0)
> +
> +
> +def diagnose(
> +    dep_spec: str,
> +    online: bool,
> +    wheels_dir: Optional[Union[str, Path]],
> +    prog: Optional[str],
> +) -> Tuple[str, bool]:
> +    """
> +    Offer a summary to the user as to why a package failed to be install=
ed.
> +
> +    :param dep_spec: The package we tried to ensure, e.g. 'meson>=3D0.61=
.5'
> +    :param online: Did we allow PyPI access?
> +    :param prog:
> +        Optionally, a shell program name that can be used as a
> +        bellwether to detect if this program is installed elsewhere on
> +        the system. This is used to offer advice when a program is
> +        detected for a different python version.
> +    :param wheels_dir:
> +        Optionally, a directory that was searched for vendored packages.
> +    """
> +    # pylint: disable=3Dtoo-many-branches
> +
> +    # Some errors are not particularly serious
> +    bad =3D False
> +
> +    pkg_name =3D pkgname_from_depspec(dep_spec)
> +    pkg_version =3D None
> +
> +    has_importlib =3D False
> +    try:
> +        # Python 3.8+ stdlib
> +        # pylint: disable=3Dimport-outside-toplevel
> +        # pylint: disable=3Dno-name-in-module
> +        # pylint: disable=3Dimport-error
> +        from importlib.metadata import (  # type: ignore
> +            PackageNotFoundError,
> +            version,
> +        )
> +
> +        has_importlib =3D True
> +        try:
> +            pkg_version =3D version(pkg_name)
> +        except PackageNotFoundError:
> +            pass
> +    except ModuleNotFoundError:
> +        pass
> +
> +    lines =3D []
> +
> +    if pkg_version:
> +        lines.append(
> +            f"Python package '{pkg_name}' version '{pkg_version}' was fo=
und,"
> +            " but isn't suitable."
> +        )
> +    elif has_importlib:
> +        lines.append(
> +            f"Python package '{pkg_name}' was not found nor installed."
> +        )
> +    else:
> +        lines.append(
> +            f"Python package '{pkg_name}' is either not found or"
> +            " not a suitable version."
> +        )
> +
> +    if wheels_dir:
> +        lines.append(
> +            "No suitable version found in, or failed to install from"
> +            f" '{wheels_dir}'."
> +        )
> +        bad =3D True
> +
> +    if online:
> +        lines.append("A suitable version could not be obtained from PyPI=
.")
> +        bad =3D True
> +    else:
> +        lines.append(
> +            "mkvenv was configured to operate offline and did not check =
PyPI."
> +        )
> +
> +    if prog and not pkg_version:
> +        which =3D shutil.which(prog)
> +        if which:
> +            if sys.base_prefix in site.PREFIXES:
> +                pypath =3D Path(sys.executable).resolve()
> +                lines.append(
> +                    f"'{prog}' was detected on your system at '{which}',=
 "
> +                    f"but the Python package '{pkg_name}' was not found =
by "
> +                    f"this Python interpreter ('{pypath}'). "
> +                    f"Typically this means that '{prog}' has been instal=
led "
> +                    "against a different Python interpreter on your syst=
em."
> +                )
> +            else:
> +                lines.append(
> +                    f"'{prog}' was detected on your system at '{which}',=
 "
> +                    "but the build is using an isolated virtual environm=
ent."
> +                )
> +            bad =3D True
> +
> +    lines =3D [f" =E2=80=A2 {line}" for line in lines]
> +    if bad:
> +        lines.insert(0, f"Could not provide build dependency '{dep_spec}=
':")
> +    else:
> +        lines.insert(0, f"'{dep_spec}' not found:")
> +    return os.linesep.join(lines), bad
> +
> +
>  def pip_install(
>      args: Sequence[str],
>      online: bool =3D False,
> @@ -364,7 +489,7 @@ def pip_install(
>      )
>
>
> -def ensure(
> +def _do_ensure(
>      dep_specs: Sequence[str],
>      online: bool =3D False,
>      wheels_dir: Optional[Union[str, Path]] =3D None,
> @@ -402,6 +527,39 @@ def ensure(
>          pip_install(args=3Dabsent, online=3Donline, wheels_dir=3Dwheels_=
dir)
>
>
> +def ensure(
> +    dep_specs: Sequence[str],
> +    online: bool =3D False,
> +    wheels_dir: Optional[Union[str, Path]] =3D None,
> +    prog: Optional[str] =3D None,
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
> +    :param prog:
> +        If specified, use this program name for error diagnostics that w=
ill
> +        be presented to the user. e.g., 'sphinx-build' can be used as a
> +        bellwether for the presence of 'sphinx'.
> +    """
> +    print(f"mkvenv: checking for {', '.join(dep_specs)}", file=3Dsys.std=
err)
> +    try:
> +        _do_ensure(dep_specs, online, wheels_dir)
> +    except subprocess.CalledProcessError as exc:
> +        # Well, that's not good.
> +        msg, bad =3D diagnose(dep_specs[0], online, wheels_dir, prog)
> +        if bad:
> +            raise Ouch(msg) from exc
> +        raise SystemExit(f"\n{msg}\n\n") from exc
> +
> +
>  def _add_create_subcommand(subparsers: Any) -> None:
>      subparser =3D subparsers.add_parser("create", help=3D"create a venv"=
)
>      subparser.add_argument(
> @@ -427,6 +585,15 @@ def _add_ensure_subcommand(subparsers: Any) -> None:
>          action=3D"store",
>          help=3D"Path to vendored packages where we may install from.",
>      )
> +    subparser.add_argument(
> +        "--diagnose",
> +        type=3Dstr,
> +        action=3D"store",
> +        help=3D(
> +            "Name of a shell utility to use for "
> +            "diagnostics if this command fails."
> +        ),
> +    )
>      subparser.add_argument(
>          "dep_specs",
>          type=3Dstr,
> @@ -476,6 +643,7 @@ def main() -> int:
>                  dep_specs=3Dargs.dep_specs,
>                  online=3Dargs.online,
>                  wheels_dir=3Dargs.dir,
> +                prog=3Dargs.diagnose,
>              )
>          logger.debug("mkvenv.py %s: exiting", args.command)
>      except Ouch as exc:
> --
> 2.40.1
>
>

ACK, seems good.

(What a lot of work for an error diagnose function that I hope nobody
ever sees, haha!)

--js


