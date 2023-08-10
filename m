Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DA7776D31
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 02:42:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTtjq-0002JI-Ve; Wed, 09 Aug 2023 20:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qTtjp-0002J5-59
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 20:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qTtjn-00075q-EN
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 20:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691628074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vhls4/0s0OY3RBix64XxBrU34kDm3w1YJGwTED0b/aQ=;
 b=DLmVmnvaTwaqvKfcgFDN2O5e6WP08uuAfan82IgSya3qkeHLf+mMz99Eko48jnWkboowPR
 C4E1UxWkjqQtfbrJFv5Rfe9UiCJjiIxbFea5lnaY79deijzg9qwQj+bCtJPQiLVIFn3r68
 n52os8LIGV1+DyMKZd9nQvKHqGY6PYA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-csRLHouMNWqArQmI2Hd1xQ-1; Wed, 09 Aug 2023 20:41:12 -0400
X-MC-Unique: csRLHouMNWqArQmI2Hd1xQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-268441d0e64so459555a91.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 17:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691628071; x=1692232871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vhls4/0s0OY3RBix64XxBrU34kDm3w1YJGwTED0b/aQ=;
 b=K/a6N7u/pkSZBFJY99ySPk0R+iZMhqVN8ruykqd7AlyEXvTQYjrIQAaFkDs0QrPbdA
 tofJ2N5lCVqZFRK2aHlPMUtE4/SqhAUgwCwxMHPhVkfA4FNcztx9FBt8XXYgdAqjTSOh
 wveA6Dsyy5GVWxNYFcVy62erQ6M43B2AWhg0FlFXcbleAb8g1KZuQcTqRTvvkUBScJZ9
 BI2S2RPyc2mZ/A2X36eBErE9ciKPQnvohH7NB+INB2gJrqzM62fX4vH3o8RMrEfgrQZR
 /JS/6S6bDtMLw3gaz1e3E8DLFLdVWIspGxQJ7k6tz+WAO4oFi651QaY6jVT3DJkej5UX
 9rhw==
X-Gm-Message-State: AOJu0YzgIWJHGOZIsiWHGdie0NK4vJXiiWYd7KTXfuDwlAng4c+AtFZ+
 IR7SIWN9lawXyu06gZGtpIoy6n9VApRxgvOsJewVeZlN9Nit/6gwwCxnTWLL1lFBYoLlDMWbLm8
 SD2HJyO55G9ZMs13joMc9PTd4pkvKw3g=
X-Received: by 2002:a17:90a:ba84:b0:25b:d292:d9a3 with SMTP id
 t4-20020a17090aba8400b0025bd292d9a3mr750861pjr.37.1691628071550; 
 Wed, 09 Aug 2023 17:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH60gkKISdeh6fMfDokZPgGPeoeG6b7xv44lztA2+hIG9sw3EB88xqEocv8Z6yuT+B+v58wzHpj+MRyz2UQ2cc=
X-Received: by 2002:a17:90a:ba84:b0:25b:d292:d9a3 with SMTP id
 t4-20020a17090aba8400b0025bd292d9a3mr750851pjr.37.1691628071193; Wed, 09 Aug
 2023 17:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230809092933.761524-1-pbonzini@redhat.com>
In-Reply-To: <20230809092933.761524-1-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 9 Aug 2023 20:40:59 -0400
Message-ID: <CAFn=p-bAik6iKdiUEq8dt=LMOQt4T+jqG+Zkbr98j1CPOMM6tQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Use known good releases when installing in pyvenv
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
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

On Wed, Aug 9, 2023 at 5:29=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> This series introduce a new installation command for mkvenv.py that
> retrieves the packages to be installed from a TOML file. This allows
> being more flexible in using the system version of a package, while at
> the same time using a known-good version when installing the package.
> This is important for packages that sometimes have backwards-incompatible
> changes or that depend on specific versions of their dependencies.
>
> For example, in the case of sphinx we can always use the last version
> that supports older versions of Python and especially docutils (Ubuntu
> 20.04 for example would not support sphinx 6.0), and in the case of
> Avocado we can avoid installing a package that conflicts with any
> plugins already existing in the system package path.  This in turn
> enables using the same virtual environment for both the build and
> qemu-iotests.  John has patches for this.
>
> For the configuration file, TOML was chosen because it was more human
> readable and easier to edit than JSON.  A parser is available in the
> Python 3.11 standard library; for older versions, the API-compatible
> replacement tomli is very small (12k).  I am introducing it as a vendored
> .whl file because it is not installed by default in most distros (unlike
> pip and setuptools which were introduced in 8.0) and because Debian
> 11 only has it in bullseye-backports.  However, if preferred the patch
> "python: use vendored tomli" can be dropped.  In that case, tomli will
> have to be installed from either PyPI or bullseye-backports.
>
> While tomli is bundled with pip, this is only true of recent versions
> of pip.  Of all the supported OSes pretty much only FreeBSD has a recent
> enough version of pip while staying on Python <3.11.  So we cannot use
> the same trick that is in place for distlib.
>
> In order to pick the tomli mapping, lcitool is updated to a recent
> version.  As a side effect this updates from LEAP 15.4 to 15.5.
>
> Paolo

I'm still nose to the grindstone trying to finish up the asyncio
machine demo, but I made good progress today and I'll try to get a
good look at this ASAP.
(But, I suppose we're both about to pop out for PTO soon, so...)

>
>
> Paolo Bonzini (9):
>   python: mkvenv: tweak the matching of --diagnose to depspecs
>   python: mkvenv: introduce TOML-like representation of dependencies
>   python: mkvenv: add ensuregroup command
>   lcitool: bump libvirt-ci submodule and regenerate
>   configure: never use PyPI for Meson
>   python: use vendored tomli
>   configure: switch to ensuregroup
>   Revert "tests: Use separate virtual environment for avocado"
>   tests/docker: add python3-tomli dependency to containers
>
>  .gitlab-ci.d/buildtest.yml                    |   6 +-
>  .gitlab-ci.d/cirrus/freebsd-13.vars           |   2 +-
>  .gitlab-ci.d/cirrus/macos-12.vars             |   2 +-
>  configure                                     |  22 +-
>  docs/devel/acpi-bits.rst                      |   6 +-
>  docs/devel/testing.rst                        |  14 +-
>  python/scripts/mkvenv.py                      | 201 ++++++++++++++++--
>  python/scripts/vendor.py                      |   5 +-
>  python/setup.cfg                              |   9 +
>  python/wheels/tomli-2.0.1-py3-none-any.whl    | Bin 0 -> 12757 bytes
>  pythondeps.toml                               |  32 +++
>  .../org.centos/stream/8/x86_64/test-avocado   |   4 +-
>  scripts/device-crash-test                     |   2 +-
>  tests/Makefile.include                        |  19 +-
>  tests/docker/dockerfiles/centos8.docker       |   3 +-
>  .../dockerfiles/debian-all-test-cross.docker  |   7 +-
>  .../dockerfiles/debian-amd64-cross.docker     |   6 +-
>  tests/docker/dockerfiles/debian-amd64.docker  |   4 +
>  .../dockerfiles/debian-arm64-cross.docker     |   6 +-
>  .../dockerfiles/debian-armel-cross.docker     |   6 +-
>  .../dockerfiles/debian-armhf-cross.docker     |   6 +-
>  .../dockerfiles/debian-hexagon-cross.docker   |   6 +-
>  .../dockerfiles/debian-mips64el-cross.docker  |   6 +-
>  .../dockerfiles/debian-mipsel-cross.docker    |   6 +-
>  .../dockerfiles/debian-ppc64el-cross.docker   |   6 +-
>  .../dockerfiles/debian-riscv64-cross.docker   |   2 +-
>  .../dockerfiles/debian-s390x-cross.docker     |   6 +-
>  .../dockerfiles/debian-tricore-cross.docker   |   2 +
>  .../dockerfiles/fedora-i386-cross.docker      |   1 +
>  .../dockerfiles/fedora-win32-cross.docker     |   2 +-
>  .../dockerfiles/fedora-win64-cross.docker     |   2 +-
>  tests/docker/dockerfiles/opensuse-leap.docker |  23 +-
>  tests/docker/dockerfiles/ubuntu2004.docker    |   4 +-
>  tests/docker/dockerfiles/ubuntu2204.docker    |   1 +
>  tests/lcitool/libvirt-ci                      |   2 +-
>  tests/lcitool/mappings.yml                    |  27 ++-
>  tests/lcitool/projects/qemu.yml               |   3 +-
>  tests/lcitool/targets/opensuse-leap-15.yml    |   4 +-
>  tests/requirements.txt                        |   6 -
>  tests/vm/Makefile.include                     |   2 +-
>  tests/vm/generated/freebsd.json               |   1 +
>  41 files changed, 371 insertions(+), 103 deletions(-)
>  create mode 100644 python/wheels/tomli-2.0.1-py3-none-any.whl
>  create mode 100644 pythondeps.toml
>  delete mode 100644 tests/requirements.txt
>
> --
> 2.41.0
>


