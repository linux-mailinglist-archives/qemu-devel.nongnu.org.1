Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 603D3724D89
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:54:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6cjb-0005Vw-Q6; Tue, 06 Jun 2023 15:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q6cjZ-0005VU-W0
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q6cjW-0001pd-Aq
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686081165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b6brvAc+N1Tu9cyISWk0ZAB7VVWY4trX2sZyBSqFfjU=;
 b=hhlHPM9gUq9cbnF4dz4hbyQQshB6PHaWYKbjSX6hDJUD9Qkd/eR2LDiBmkscAgJbWW1IsJ
 3hvVqNYWq8OI0p8FmwnIV2LTBfDF7Liu3Ek/EG/5Y3qpBG8+DyLKN5teofdkxYiU/HIos+
 zIKI8s2c9eYcVGBR6yroINdlo/ZBcdw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-skaLi4raOQqZYSiDicG5cQ-1; Tue, 06 Jun 2023 15:52:43 -0400
X-MC-Unique: skaLi4raOQqZYSiDicG5cQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6570c5525a7so1482483b3a.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686081163; x=1688673163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6brvAc+N1Tu9cyISWk0ZAB7VVWY4trX2sZyBSqFfjU=;
 b=M16XvpZJ9+vHqQhdJPVhdshqW0IApWnjmzwQNFZbA5yiqZN68RzC3cFS7RW0FuRx5V
 MNeWFiH1yMWBIs7hwBU1tNd+qgSFEj/OaX6z9bBKyvQvkJM+jRI18icMLPqTJOasMh0Q
 b9He1+rzCuag4eNesZAoYh6AncjmHpAnVGy/5g4dk1S6gCIbgALjImVBScc6WYvC/MfZ
 j+7J2/ZTSdY82nbEoUcjWqF5ZcSFViAw9bdbmvho/XFmx4wqBRre16/qB+HoM6ZNCEVW
 eNhfFWzx94fqO0WYhGg0b1dz5+1Qp1th+GgJp/kM7XD7VOrQT45dQypkz2oU2VSsTTXt
 XkIQ==
X-Gm-Message-State: AC+VfDxJ3osDy4706aCCHUwTjBUA81vkzr1CPOKD3MkkQRwgFwXDbw45
 rv90sl1pUvDeGKnGH6+ooShH73d3VkdQa82c+qkx14f8LOEZ+85MpIzPRmqjsb4LlweiW45O2NK
 bPkBjJih3zcfXYhgs7HWFkLyGsTuSB2E=
X-Received: by 2002:a05:6a20:7d96:b0:104:ad71:f080 with SMTP id
 v22-20020a056a207d9600b00104ad71f080mr645758pzj.34.1686081162799; 
 Tue, 06 Jun 2023 12:52:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lLQSQbMN+OYNfz8ZYMJOuw4qhCAhktVykWsDn2Nb9nJlTLjhlOCIeFV9mteb0YB/si/96GqHa+BN2lITv9sQ=
X-Received: by 2002:a05:6a20:7d96:b0:104:ad71:f080 with SMTP id
 v22-20020a056a207d9600b00104ad71f080mr645750pzj.34.1686081162502; Tue, 06 Jun
 2023 12:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230606082330.445790-1-pbonzini@redhat.com>
In-Reply-To: <20230606082330.445790-1-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 6 Jun 2023 15:52:31 -0400
Message-ID: <CAFn=p-a8mMgnDk6jJVYAoiFb=oPrG_X7+z=brzF6GnCb0L2TwA@mail.gmail.com>
Subject: Re: [PATCH] mkvenv: always pass locally-installed packages to pip
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

On Tue, Jun 6, 2023 at 4:23=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Let pip decide whether a new version should be installed or the current
> one is okay.  This ensures that the virtual environment is updated
> (either upgraded or downgraded) whenever a new version of a package is
> requested.
>
> The hardest part here is figuring out if a package is installed in
> the venv (which also has to be done twice to account for the presence
> of either setuptools in Python <3.8, or importlib in Python >=3D3.8).
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: John Snow <jsnow@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  python/scripts/mkvenv.py | 76 ++++++++++++++++++++++++++++++++++++++--

:(

The best laid plans of mice and men,

--js

>  1 file changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
> index 3a9aef46a51..3957e7d6e08 100644
> --- a/python/scripts/mkvenv.py
> +++ b/python/scripts/mkvenv.py
> @@ -553,6 +553,74 @@ def pkgname_from_depspec(dep_spec: str) -> str:
>      return match.group(0)
>
>
> +def _get_path_importlib(package: str) -> Optional[str]:
> +    # pylint: disable=3Dimport-outside-toplevel
> +    # pylint: disable=3Dno-name-in-module
> +    # pylint: disable=3Dimport-error
> +    try:
> +        # First preference: Python 3.8+ stdlib
> +        from importlib.metadata import (  # type: ignore
> +            PackageNotFoundError,
> +            distribution,
> +        )
> +    except ImportError as exc:
> +        logger.debug("%s", str(exc))
> +        # Second preference: Commonly available PyPI backport
> +        from importlib_metadata import (  # type: ignore
> +            PackageNotFoundError,
> +            distribution,
> +        )
> +
> +    try:
> +        return str(distribution(package).locate_file("."))
> +    except PackageNotFoundError:
> +        return None
> +
> +
> +def _get_path_pkg_resources(package: str) -> Optional[str]:
> +    # pylint: disable=3Dimport-outside-toplevel
> +    # Bundled with setuptools; has a good chance of being available.
> +    import pkg_resources
> +
> +    try:
> +        return str(pkg_resources.get_distribution(package).location)
> +    except pkg_resources.DistributionNotFound:
> +        return None
> +
> +
> +def _get_path(package: str) -> Optional[str]:
> +    try:
> +        return _get_path_importlib(package)
> +    except ImportError as exc:
> +        logger.debug("%s", str(exc))
> +
> +    try:
> +        return _get_path_pkg_resources(package)
> +    except ImportError as exc:
> +        logger.debug("%s", str(exc))
> +        raise Ouch(
> +            "Neither importlib.metadata nor pkg_resources found. "
> +            "Use Python 3.8+, or install importlib-metadata or setuptool=
s."
> +        ) from exc
> +
> +
> +def _path_is_prefix(prefix: Union[str, Path], path: Union[str, Path]) ->=
 bool:
> +    prefix =3D str(prefix)
> +    path =3D str(path)
> +    try:
> +        return os.path.commonpath([prefix, path]) =3D=3D prefix
> +    except ValueError:
> +        return False
> +
> +
> +def _is_system_package(package: str) -> bool:
> +    path =3D _get_path(package)
> +    return path is not None and not (
> +        _path_is_prefix(sysconfig.get_path("purelib"), path)
> +        or _path_is_prefix(sysconfig.get_path("platlib"), path)
> +    )
> +
> +
>  def _get_version_importlib(package: str) -> Optional[str]:
>      # pylint: disable=3Dimport-outside-toplevel
>      # pylint: disable=3Dno-name-in-module
> @@ -741,8 +809,12 @@ def _do_ensure(
>      for spec in dep_specs:
>          matcher =3D distlib.version.LegacyMatcher(spec)
>          ver =3D _get_version(matcher.name)
> -        if ver is None or not matcher.match(
> -            distlib.version.LegacyVersion(ver)
> +        if (
> +            ver is None
> +            # Always pass installed package to pip, so that they can be
> +            # updated if the requested version changes
> +            or not _is_system_package(matcher.name)
> +            or not matcher.match(distlib.version.LegacyVersion(ver))

Wait, so what exactly does this change? In what cases will we
downgrade and in what cases will we be fine with what we already have?

I'm a little fuzzy on what precisely this fixes, though I gather it's
to do with Avocado-Framework.

>          ):
>              absent.append(spec)
>          else:
> --
> 2.40.1
>


