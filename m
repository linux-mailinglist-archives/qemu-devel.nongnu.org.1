Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4A5724D2F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:39:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6cWS-00019B-ND; Tue, 06 Jun 2023 15:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q6cWQ-00018f-2O
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:39:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q6cWN-0005qo-Hl
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686080350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRVv1Ix4efTF1f15tGpBpRuvlQJD8mOa9bHc11wloLo=;
 b=NbSBpKCi+uwnVl1Rv2wzUSvJTXez8ji9qEBTfnTNoSJBL0y7E5El/4ED71mESsJj1jchzi
 CsHdQffCfacYa2WxvlVfQSkjcJOk7XU92ircJeRP8NpcSwyWPv2DWsZKUcFINvr0JRFwQx
 cHf508/UVeYepsKHGLmClLcl/WUaTTI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-48OZPNpoPWSe-wqPF98l8Q-1; Tue, 06 Jun 2023 15:39:09 -0400
X-MC-Unique: 48OZPNpoPWSe-wqPF98l8Q-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-258df3797f2so1793393a91.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686080348; x=1688672348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uRVv1Ix4efTF1f15tGpBpRuvlQJD8mOa9bHc11wloLo=;
 b=QZhMs22mh8XVU6LMWFwDxNtWLjzqdNIOonzDolqD0refxdxL5cadPA0AEKwO0hUYHl
 VoIY+lg8NDRIwMo6frnzqeNjC7RLxk+KCi5eto6I0u+Z6vM5IR2nBpNhE88Eo9uh/HGq
 7i4f28knb5ul1BIgHADM1CgN3YYyddR9FzMFrzI72vzlB3aC5myBi8x4+BBNKx0Y4kJp
 FNH/faEq8JbY9zL/ugFtbVyF5vFq2PZc8LkXm341hbD/otYPfpR7ZwbiboKyIYVVI6Li
 up9UuzweU60IWf3a7Mw5PWMylCRRDb3i26qdk4/sGS8MRlyNOPUAwSoMa+DjSXbb4XOf
 ApYQ==
X-Gm-Message-State: AC+VfDwzeOn8LNhpHtUeXMoLAiSv+jwvEj/PHm/RbN3n/DfVeDrhKAfa
 HcR341s4w98LjXpuxbZq3Eo4Ka37VSjdb9kBW7o4nsxerl5T2795fBqm8kXuYmuIDQKUjs/tGIP
 GYQO4iaGVwrDovrexg3SgUSlCWbJEniU=
X-Received: by 2002:a17:90a:d58f:b0:253:3f25:3d99 with SMTP id
 v15-20020a17090ad58f00b002533f253d99mr1563391pju.45.1686080348071; 
 Tue, 06 Jun 2023 12:39:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Xgz7x6TEZo9TDxsyDwmrGvGCLRPYqlPt5sw3spagrGAoMzpQZCqh+XkO9gNDdmutfhQfyJhryFF8f+pTcYO8=
X-Received: by 2002:a17:90a:d58f:b0:253:3f25:3d99 with SMTP id
 v15-20020a17090ad58f00b002533f253d99mr1563384pju.45.1686080347642; Tue, 06
 Jun 2023 12:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230605160012.339685-1-pbonzini@redhat.com>
 <20230605160012.339685-3-pbonzini@redhat.com>
In-Reply-To: <20230605160012.339685-3-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 6 Jun 2023 15:38:56 -0400
Message-ID: <CAFn=p-ZhGnuufg7hwT7Xyvz9T1AhaQUqDj5JYiR8ksZ6LA6uJA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tests: Use separate virtual environment for avocado
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, kconsul@linux.vnet.ibm.com
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

On Mon, Jun 5, 2023 at 12:00=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> This reverts commits eea2d141179 ("Makefile: remove $(TESTS_PYTHON)",
> 2023-05-26) and 9c6692db550 ("tests: Use configure-provided pyvenv for
> tests", 2023-05-18).
>
> Right now, there is a conflict between wanting a ">=3D" constraint when
> using a distro-provided package and wanting a "=3D=3D" constraint when
> installing Avocado from PyPI; this would provide the best of both worlds
> in terms of resiliency for both distros that have required packages and
> distros that don't.
>
> The conflict is visible also for meson, where we would like to install
> the latest 0.63.x version but also accept a distro 1.1.x version.
> But it is worse for avocado, for two reasons:
>
> 1) we cannot use an "=3D=3D" constraint to install avocado if the venv
> includes a system avocado.  The distro will package plugins that have
> "=3D=3D" constraints on the version that is included in the distro, and, =
using
> "pip install avocado=3D=3D88.1" on a venv that includes system packages w=
ill
> result in this error:
>
>    ERROR: pip's dependency resolver does not currently take into account =
all the packages that are installed. This behaviour is the source of the fo=
llowing dependency conflicts.
>    avocado-framework-plugin-varianter-yaml-to-mux 98.0 requires avocado-f=
ramework=3D=3D98.0, but you have avocado-framework 88.1 which is incompatib=
le.
>    avocado-framework-plugin-result-html 98.0 requires avocado-framework=
=3D=3D98.0, but you have avocado-framework 88.1 which is incompatible.
>    make[1]: Leaving directory '/home/berrange/src/virt/qemu/build'
>
> 2) we cannot use ">=3D" either if the venv does _not_ include a system
> avocado, because that would result in the installation of v101.0 which
> is the one we've just reverted.
>
> So the idea is to encode the dependencies as an (acceptable, locked)
> tuple, like this hypothetical TOML that would be committed inside
> python/ and used by mkvenv.py:
>
>   [meson]
>   meson =3D { minimum =3D "0.63.0", install =3D "0.63.3", canary =3D "mes=
on" }
>
>   [docs]
>   # 6.0 drops support for Python 3.7, we still officially support it
>   sphinx =3D { minimum =3D "1.6", install =3D "<6.0", canary =3D "sphinx-=
build" }
>   sphinx_rtd_theme =3D { minimum =3D "0.5" }
>
>   [avocado]
>   avocado-framework =3D { minimum =3D "88.1", install =3D "88.1", canary =
=3D "avocado" }
>
> Once this is implemented, it would also be possible to install avocado in
> pyvenv/ using "mkvenv.py ensure", thus using the distro package on Fedora
> and CentOS Stream (the only distros where it's available).  But until
> this is implemented, keep avocado in a separate venv.  There is still the
> benefit of using a single python for meson custom_targets and for sphinx.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .gitlab-ci.d/buildtest.yml                       |  6 +++---
>  docs/devel/acpi-bits.rst                         |  6 +++---
>  docs/devel/testing.rst                           | 14 +++++++-------
>  .../ci/org.centos/stream/8/x86_64/test-avocado   |  4 ++--
>  scripts/device-crash-test                        |  2 +-
>  tests/Makefile.include                           | 16 +++++++++-------
>  tests/requirements.txt                           |  7 ++-----
>  tests/vm/Makefile.include                        |  2 +-
>  8 files changed, 28 insertions(+), 29 deletions(-)
>
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 0f1be14cb62..1922caf5363 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -103,7 +103,7 @@ crash-test-debian:
>    script:
>      - cd build
>      - make NINJA=3D":" check-venv
> -    - pyvenv/bin/python3 scripts/device-crash-test -q --tcg-only ./qemu-=
system-i386
> +    - tests/venv/bin/python3 scripts/device-crash-test -q --tcg-only ./q=
emu-system-i386
>
>  build-system-fedora:
>    extends:
> @@ -146,8 +146,8 @@ crash-test-fedora:
>    script:
>      - cd build
>      - make NINJA=3D":" check-venv
> -    - pyvenv/bin/python3 scripts/device-crash-test -q ./qemu-system-ppc
> -    - pyvenv/bin/python3 scripts/device-crash-test -q ./qemu-system-risc=
v32
> +    - tests/venv/bin/python3 scripts/device-crash-test -q ./qemu-system-=
ppc
> +    - tests/venv/bin/python3 scripts/device-crash-test -q ./qemu-system-=
riscv32
>
>  build-system-centos:
>    extends:
> diff --git a/docs/devel/acpi-bits.rst b/docs/devel/acpi-bits.rst
> index 9677b0098f4..22e2580200c 100644
> --- a/docs/devel/acpi-bits.rst
> +++ b/docs/devel/acpi-bits.rst
> @@ -61,19 +61,19 @@ Under ``tests/avocado/`` as the root we have:
>     ::
>
>       $ make check-venv (needed only the first time to create the venv)
> -     $ ./pyvenv/bin/avocado run -t acpi tests/avocado
> +     $ ./tests/venv/bin/avocado run -t acpi tests/avocado
>
>     The above will run all acpi avocado tests including this one.
>     In order to run the individual tests, perform the following:
>     ::
>
> -     $ ./pyvenv/bin/avocado run tests/avocado/acpi-bits.py --tap -
> +     $ ./tests/venv/bin/avocado run tests/avocado/acpi-bits.py --tap -
>
>     The above will produce output in tap format. You can omit "--tap -" i=
n the
>     end and it will produce output like the following:
>     ::
>
> -      $ ./pyvenv/bin/avocado run tests/avocado/acpi-bits.py
> +      $ ./tests/venv/bin/avocado run tests/avocado/acpi-bits.py
>        Fetching asset from tests/avocado/acpi-bits.py:AcpiBitsTest.test_a=
cpi_smbios_bits
>        JOB ID     : eab225724da7b64c012c65705dc2fa14ab1defef
>        JOB LOG    : /home/anisinha/avocado/job-results/job-2022-10-10T17.=
58-eab2257/job.log
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 2cafec41782..203facb417b 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -888,9 +888,9 @@ You can run the avocado tests simply by executing:
>
>    make check-avocado
>
> -This involves the automatic installation, from PyPI, of all the
> -necessary avocado-framework dependencies into the QEMU venv within the
> -build tree (at ``./pyvenv``). Test results are also saved within the
> +This involves the automatic creation of Python virtual environment
> +within the build tree (at ``tests/venv``) which will have all the
> +right dependencies, and will save tests results also within the
>  build tree (at ``tests/results``).
>
>  Note: the build environment must be using a Python 3 stack, and have
> @@ -947,7 +947,7 @@ may be invoked by running:
>
>   .. code::
>
> -  pyvenv/bin/avocado run $OPTION1 $OPTION2 tests/avocado/
> +  tests/venv/bin/avocado run $OPTION1 $OPTION2 tests/avocado/
>
>  Note that if ``make check-avocado`` was not executed before, it is
>  possible to create the Python virtual environment with the dependencies
> @@ -962,20 +962,20 @@ a test file. To run tests from a single file within=
 the build tree, use:
>
>   .. code::
>
> -  pyvenv/bin/avocado run tests/avocado/$TESTFILE
> +  tests/venv/bin/avocado run tests/avocado/$TESTFILE
>
>  To run a single test within a test file, use:
>
>   .. code::
>
> -  pyvenv/bin/avocado run tests/avocado/$TESTFILE:$TESTCLASS.$TESTNAME
> +  tests/venv/bin/avocado run tests/avocado/$TESTFILE:$TESTCLASS.$TESTNAM=
E
>
>  Valid test names are visible in the output from any previous execution
>  of Avocado or ``make check-avocado``, and can also be queried using:
>
>   .. code::
>
> -  pyvenv/bin/avocado list tests/avocado
> +  tests/venv/bin/avocado list tests/avocado
>
>  Manual Installation
>  ~~~~~~~~~~~~~~~~~~~
> diff --git a/scripts/ci/org.centos/stream/8/x86_64/test-avocado b/scripts=
/ci/org.centos/stream/8/x86_64/test-avocado
> index 73e7a1a3126..e0443fc8ae8 100755
> --- a/scripts/ci/org.centos/stream/8/x86_64/test-avocado
> +++ b/scripts/ci/org.centos/stream/8/x86_64/test-avocado
> @@ -4,7 +4,7 @@
>  # KVM and x86_64, or tests that are generic enough to be valid for all
>  # targets. Such a test list can be generated with:
>  #
> -# ./pyvenv/bin/avocado list --filter-by-tags-include-empty \
> +# ./tests/venv/bin/avocado list --filter-by-tags-include-empty \
>  #   --filter-by-tags-include-empty-key -t accel:kvm,arch:x86_64 \
>  #   tests/avocado/
>  #
> @@ -22,7 +22,7 @@
>  #   - tests/avocado/virtio_check_params.py:VirtioMaxSegSettingsCheck.tes=
t_machine_types
>  #
>  make get-vm-images
> -./pyvenv/bin/avocado run \
> +./tests/venv/bin/avocado run \
>      --job-results-dir=3Dtests/results/ \
>      tests/avocado/boot_linux.py:BootLinuxX8664.test_pc_i440fx_kvm \
>      tests/avocado/boot_linux.py:BootLinuxX8664.test_pc_q35_kvm \
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index 353aa575d7b..b74d887331d 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -43,7 +43,7 @@ except ModuleNotFoundError as exc:
>      print(f"Module '{exc.name}' not found.")
>      print("  Try 'make check-venv' from your build directory,")
>      print("  and then one way to run this script is like so:")
> -    print(f'  > $builddir/pyvenv/bin/python3 "{path}"')
> +    print(f'  > $builddir/tests/venv/bin/python3 "{path}"')
>      sys.exit(1)
>
>  logger =3D logging.getLogger('device-crash-test')
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 8294a44816c..9422ddaece5 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -89,9 +89,10 @@ distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
>  # Build up our target list from the filtered list of ninja targets
>  TARGETS=3D$(patsubst libqemu-%.fa, %, $(filter libqemu-%.fa, $(ninja-tar=
gets)))
>
> -TESTS_VENV_TOKEN=3D$(BUILD_DIR)/pyvenv/tests.group
> +TESTS_VENV_DIR=3D$(BUILD_DIR)/tests/venv
>  TESTS_VENV_REQ=3D$(SRC_PATH)/tests/requirements.txt
>  TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
> +TESTS_PYTHON=3D$(TESTS_VENV_DIR)/bin/python3
>  ifndef AVOCADO_TESTS
>         AVOCADO_TESTS=3Dtests/avocado
>  endif
> @@ -107,10 +108,11 @@ else
>  endif
>
>  quiet-venv-pip =3D $(quiet-@)$(call quiet-command-run, \
> -    $(PYTHON) -m pip -q --disable-pip-version-check $1, \
> +    $(TESTS_PYTHON) -m pip -q --disable-pip-version-check $1, \
>      "VENVPIP","$1")
>
> -$(TESTS_VENV_TOKEN): $(TESTS_VENV_REQ)
> +$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
> +       $(call quiet-command, $(PYTHON) -m venv $@, VENV, $@)
>         $(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
>         $(call quiet-venv-pip,install -r $(TESTS_VENV_REQ))
>         $(call quiet-command, touch $@)
> @@ -119,7 +121,7 @@ $(TESTS_RESULTS_DIR):
>         $(call quiet-command, mkdir -p $@, \
>              MKDIR, $@)
>
> -check-venv: $(TESTS_VENV_TOKEN)
> +check-venv: $(TESTS_VENV_DIR)
>
>  FEDORA_31_ARCHES_TARGETS=3D$(patsubst %-softmmu,%, $(filter %-softmmu,$(=
TARGETS)))
>  FEDORA_31_ARCHES_CANDIDATES=3D$(patsubst ppc64,ppc64le,$(FEDORA_31_ARCHE=
S_TARGETS))
> @@ -129,7 +131,7 @@ FEDORA_31_DOWNLOAD=3D$(filter $(FEDORA_31_ARCHES),$(F=
EDORA_31_ARCHES_CANDIDATES))
>  # download one specific Fedora 31 image
>  get-vm-image-fedora-31-%: check-venv
>         $(call quiet-command, \
> -             $(PYTHON) -m avocado vmimage get \
> +             $(TESTS_PYTHON) -m avocado vmimage get \
>               --distro=3Dfedora --distro-version=3D31 --arch=3D$*, \
>         "AVOCADO", "Downloading avocado tests VM image for $*")
>
> @@ -138,7 +140,7 @@ get-vm-images: check-venv $(patsubst %,get-vm-image-f=
edora-31-%, $(FEDORA_31_DOW
>
>  check-avocado: check-venv $(TESTS_RESULTS_DIR) get-vm-images
>         $(call quiet-command, \
> -            $(PYTHON) -m avocado \
> +            $(TESTS_PYTHON) -m avocado \
>              --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_RES=
ULTS_DIR) \
>              $(if $(AVOCADO_TAGS),, --filter-by-tags-include-empty \
>                         --filter-by-tags-include-empty-key) \
> @@ -161,7 +163,7 @@ check:
>  check-build: run-ninja
>
>  check-clean:
> -       rm -rf $(TESTS_RESULTS_DIR)
> +       rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
>
>  clean: check-clean clean-tcg
>  distclean: distclean-tcg
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> index 07e713ef5ac..0ba561b6bdf 100644
> --- a/tests/requirements.txt
> +++ b/tests/requirements.txt
> @@ -1,9 +1,6 @@
>  # Add Python module requirements, one per line, to be installed
> -# in the qemu build_dir/pyvenv Python virtual environment. For more info=
,
> +# in the tests/venv Python virtual environment. For more info,
>  # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> -#
> -# Note that qemu.git/python/ is implicitly installed to this venv when
> -# 'make check-venv' is run, and will persist until configure is run
> -# again.
> +# Note that qemu.git/python/ is always implicitly installed.
>  avocado-framework=3D=3D88.1
>  pycdlib=3D=3D1.11.0
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index f0f5d32fb0f..c2a8ca1c175 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -5,7 +5,7 @@ ifeq ($(realpath $(SRC_PATH)),$(realpath .))
>  VM_PYTHON =3D PYTHONPATH=3D$(SRC_PATH)/python /usr/bin/env python3
>  VM_VENV =3D
>  else
> -VM_PYTHON =3D $(PYTHON)
> +VM_PYTHON =3D $(TESTS_PYTHON)
>  VM_VENV =3D check-venv
>  endif
>
> --
> 2.40.1

Boo.

ACK

--js


