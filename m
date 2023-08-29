Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E2678C660
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:45:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaz0y-0005o7-Se; Tue, 29 Aug 2023 09:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qaz0v-0005hJ-8v
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:44:14 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qaz0p-00049U-7Y
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:44:11 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1c50438636fso2892437fac.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693316645; x=1693921445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J2izwuknYEjjo1T8jxXvVGK0fYGRywKjs46mPfXCII0=;
 b=fLyct7zalktrDkiSqzrvDtbg+oRsbybJ+2cy5JV+ArYF2ar8HcJI7Fm8s1zwvxcCZx
 h8pykClZ4/7xLYYwzCZURljhbF6r5JCVuUE09qAeCp+mdNPx30v/GUhxcxJA6fUZjmT/
 SJh3CnGdIG09fOo3D4pGHIhA3yHHU2BaeTUV7IKM3+NJ8HfrCT0TbmCHin6c5S4XIczL
 u9Db6to8JBxgt1MRwo3DRTcqmblXmH/ZhmkDLyUkcIOs3/dJmM4ixm5c8PSPsWRLkoM1
 cGKnpi9d1yf0ZzwieLu2orlQd6jz0asiM4WEeTXWG3qtEEH+ggymxNCXmRzy27ck/B8u
 4XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693316645; x=1693921445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J2izwuknYEjjo1T8jxXvVGK0fYGRywKjs46mPfXCII0=;
 b=d+igwoa2LxaXWUBBRizBGn2sk8O4uMH4IH+KNFVdU9QkxUEPVCjiC3y9IZxMYljEkf
 Scq5H0zb//+gsx2uZYN62vPlUYLA6hheY0URk7eT7/8yZbl7jOZ0rwZVMCEDGMz3xFY6
 7U2uIl67kUmssvesrEqDCLC17qwWRg4jDFbllxv5yb5zQmj+VFQqbwX8ZO4GF9ElFBVe
 voh1RCJYUvdmhJsu/ihy4f6U99bm+7vGvCOJ8SU8ThijWw6iHLGq+Zlleh+Y3cistjJF
 vEvbscWEv8aq2Ccuh89ay5lNHbYwKiYgHUZPNe6aZu5l7Va3b+3/n/3e6L3f//4Mjtb5
 6Xnw==
X-Gm-Message-State: AOJu0YySBwPNR7ZPui+x+kFWfgmqQpmKebNViogh3Zobi/iUee808eAj
 j3G7yrvxXQA1LF2ICn2IzaVrgoEffCk8JXWscsI=
X-Google-Smtp-Source: AGHT+IH6uA0/2j5mlKXNp5bpFdwW3GSB0P9qJsI4R8pd2XXPMNou944GWvNb3RAdEqPXagC+2OEzWU0Uj/r017fqYe0=
X-Received: by 2002:a05:6870:9723:b0:1bf:9fa2:bf94 with SMTP id
 n35-20020a056870972300b001bf9fa2bf94mr15982893oaq.5.1693316645494; Tue, 29
 Aug 2023 06:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230828103856.46031-1-pbonzini@redhat.com>
In-Reply-To: <20230828103856.46031-1-pbonzini@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 29 Aug 2023 09:43:53 -0400
Message-ID: <CAJSP0QUKoDBqQ8yhMdxLS_qN=c0umYHi7YemeE3VLbR5MYF5xw@mail.gmail.com>
Subject: Re: [PULL 00/14] Python, i386 changes for 2023-08-28
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Paolo,
I see a new test error that may have been introduced by this pull request:
https://gitlab.com/qemu-project/qemu/-/jobs/4968468877#L131

AVOCADO Downloading avocado tests VM image for s390x
Failed to load plugin from module "avocado.plugins.journal":
ImportError("Module 'sqlite3' is not installed.\nUse:\n sudo zypper
install python311\nto install it.") :
File "/builds/qemu-project/qemu/build/pyvenv/lib64/python3.11/site-packages/avocado/core/extension_manager.py",
line 63, in __init__
plugin = ep.load()
^^^^^^^^^
File "/usr/lib/python3.11/site-packages/pkg_resources/__init__.py",
line 2517, in load
return self.resolve()
^^^^^^^^^^^^^^
File "/usr/lib/python3.11/site-packages/pkg_resources/__init__.py",
line 2523, in resolve
module = __import__(self.module_name, fromlist=['__name__'], level=0)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
File "/builds/qemu-project/qemu/build/pyvenv/lib64/python3.11/site-packages/avocado/plugins/journal.py",
line 19, in <module>
import sqlite3
File "/usr/lib64/python3.11/_import_failed/sqlite3.py", line 16, in <module>

Stefan

On Mon, 28 Aug 2023 at 06:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 50e7a40af372ee5931c99ef7390f5d3d6fbf6ec4:
>
>   Merge tag 'pull-target-arm-20230824' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-08-24 10:08:33 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 29a8238510df27080b0ffa92c58400412ce19daa:
>
>   configure: remove unnecessary mkdir -p (2023-08-28 10:01:44 +0200)
>
> ----------------------------------------------------------------
> * separate accepted and auto-installed versions of Python dependencies
> * bump tricore container to Debian 11
> * small configure cleanups
>
> ----------------------------------------------------------------
> Ake Koomsin (1):
>       target/i386: add support for VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE
>
> Paolo Bonzini (13):
>       configure: fix and complete detection of tricore tools
>       dockerfiles: bump tricore cross compiler container to Debian 11
>       python: mkvenv: tweak the matching of --diagnose to depspecs
>       python: mkvenv: introduce TOML-like representation of dependencies
>       python: mkvenv: add ensuregroup command
>       lcitool: bump libvirt-ci submodule and regenerate
>       configure: never use PyPI for Meson
>       python: use vendored tomli
>       configure: switch to ensuregroup
>       Revert "tests: Use separate virtual environment for avocado"
>       tests/docker: add python3-tomli dependency to containers
>       configure: fix container_hosts misspellings and duplications
>       configure: remove unnecessary mkdir -p
>
>  .gitlab-ci.d/buildtest.yml                         |   6 +-
>  .gitlab-ci.d/cirrus/freebsd-13.vars                |   2 +-
>  .gitlab-ci.d/cirrus/macos-12.vars                  |   2 +-
>  configure                                          |  31 +---
>  docs/devel/acpi-bits.rst                           |   6 +-
>  docs/devel/testing.rst                             |  14 +-
>  python/scripts/mkvenv.py                           | 201 +++++++++++++++++++--
>  python/scripts/vendor.py                           |   5 +-
>  python/setup.cfg                                   |   6 +
>  python/wheels/tomli-2.0.1-py3-none-any.whl         | Bin 0 -> 12757 bytes
>  pythondeps.toml                                    |  32 ++++
>  scripts/ci/org.centos/stream/8/x86_64/test-avocado |   4 +-
>  scripts/device-crash-test                          |   2 +-
>  target/i386/cpu.c                                  |   6 +-
>  target/i386/cpu.h                                  |   1 +
>  tests/Makefile.include                             |  19 +-
>  tests/docker/dockerfiles/centos8.docker            |   3 +-
>  .../dockerfiles/debian-all-test-cross.docker       |   7 +-
>  tests/docker/dockerfiles/debian-amd64-cross.docker |   6 +-
>  tests/docker/dockerfiles/debian-amd64.docker       |   4 +
>  tests/docker/dockerfiles/debian-arm64-cross.docker |   6 +-
>  tests/docker/dockerfiles/debian-armel-cross.docker |   6 +-
>  tests/docker/dockerfiles/debian-armhf-cross.docker |   6 +-
>  .../docker/dockerfiles/debian-hexagon-cross.docker |   6 +-
>  .../dockerfiles/debian-mips64el-cross.docker       |   6 +-
>  .../docker/dockerfiles/debian-mipsel-cross.docker  |   6 +-
>  .../docker/dockerfiles/debian-ppc64el-cross.docker |   6 +-
>  .../docker/dockerfiles/debian-riscv64-cross.docker |   2 +-
>  tests/docker/dockerfiles/debian-s390x-cross.docker |   6 +-
>  .../docker/dockerfiles/debian-tricore-cross.docker |   4 +-
>  tests/docker/dockerfiles/fedora-i386-cross.docker  |   1 +
>  tests/docker/dockerfiles/fedora-win32-cross.docker |   2 +-
>  tests/docker/dockerfiles/fedora-win64-cross.docker |   2 +-
>  tests/docker/dockerfiles/opensuse-leap.docker      |  22 +--
>  tests/docker/dockerfiles/ubuntu2004.docker         |   4 +-
>  tests/docker/dockerfiles/ubuntu2204.docker         |   1 +
>  tests/lcitool/libvirt-ci                           |   2 +-
>  tests/lcitool/mappings.yml                         |  28 ++-
>  tests/lcitool/projects/qemu.yml                    |   3 +-
>  tests/lcitool/targets/opensuse-leap-15.yml         |   4 +-
>  tests/requirements.txt                             |   6 -
>  tests/vm/Makefile.include                          |   2 +-
>  tests/vm/generated/freebsd.json                    |   1 +
>  43 files changed, 377 insertions(+), 112 deletions(-)
>  create mode 100644 python/wheels/tomli-2.0.1-py3-none-any.whl
>  create mode 100644 pythondeps.toml
>  delete mode 100644 tests/requirements.txt
> --
> 2.41.0
>
>

