Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B18667118D5
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 23:11:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2IDJ-0007zD-0u; Thu, 25 May 2023 17:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q2IDH-0007z0-Dx
 for qemu-devel@nongnu.org; Thu, 25 May 2023 17:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q2IDF-0007jq-N9
 for qemu-devel@nongnu.org; Thu, 25 May 2023 17:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685048972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AV2RiK9Gik4P2/22W19ZMAlt2bJPFBzOra98xd3s2Wk=;
 b=GbUinHl8hyJKEd3SO4pJyHRLp20wFQARvfhrNkCCA+gnZVQ0Kszm/1DLa1gAnsXxrk8hdP
 +Lqxz9VLxnFSkduBQDj9LfKz1e9GicZja4OW+u+PUouMn+XMWjXocE23MwgCdZuRkBOiK1
 hS7ueod7QmBeIanGeBleLzltMUwWKko=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-9WP0Do6JMASGt8KKfcxt9A-1; Thu, 25 May 2023 17:09:30 -0400
X-MC-Unique: 9WP0Do6JMASGt8KKfcxt9A-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1ae721230a1so399205ad.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 14:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685048969; x=1687640969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AV2RiK9Gik4P2/22W19ZMAlt2bJPFBzOra98xd3s2Wk=;
 b=V73gXGsQratGXGcJOPmRaUdz9LcX855YF9CBKgZJgbd01zl6L7S1zMI/9cYFcxQfzU
 6elERmuo8ZgbDWANt+BW8wlAxVB2I6+XHQ6lmBQX5C8lHRdfFN6oFJolOmXylrooX/Tl
 k1+3TGMwZP18JbKx50S3k3QJwQ8ds6im229nXtYgAVLXnbI7uw4hGmpgUkfFWTDJT52B
 op4/nSiDWnlqjByzWkcAha70UcCRbeATGq6qWlCEirquJ+9CShLxOkTiTPgnOacMOS/+
 zRlVTg/DCFxsiQ9ZxILTX8bgKAzJHNXs7TAuWuTs8XOXfd6Z/jqhO8unAi41xfntcbC1
 ernw==
X-Gm-Message-State: AC+VfDzY3gJW6TtICQ721IG4DbzidON7isb/TQIlQPfvm/sG7yWk3G8C
 ngyU1DzfWzIhn2bsklhCAOLBr7v+/EyTj2s8nZIFCsf27YFHs0zUaHLZDu2gJ0OAL40RvicGROG
 +QH5t8jZKySNdlmEKkcDXjhwihJZCrevvs+r1C3s=
X-Received: by 2002:a17:902:f549:b0:1ac:4a41:d38d with SMTP id
 h9-20020a170902f54900b001ac4a41d38dmr2993993plf.51.1685048969265; 
 Thu, 25 May 2023 14:09:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Wk/+vF051LztJdH8v8sJN8IJo9QorxeCzErxOtYw5gohrcyC8UrU6D58JdvVnw5CT8iKnXUGb6HpTKZYB6ns=
X-Received: by 2002:a17:902:f549:b0:1ac:4a41:d38d with SMTP id
 h9-20020a170902f54900b001ac4a41d38dmr2993976plf.51.1685048968982; Thu, 25 May
 2023 14:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230525102844.209240-1-pbonzini@redhat.com>
 <20230525102844.209240-4-pbonzini@redhat.com>
In-Reply-To: <20230525102844.209240-4-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 25 May 2023 17:09:17 -0400
Message-ID: <CAFn=p-bXz_-bKtVgVm2L4Aj=n6MoqShfLyg4rzTOD+P1puO8zA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Makefile: remove $(TESTS_PYTHON)
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org
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

On Thu, May 25, 2023 at 6:28=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> It is now the same as $(PYTHON), since the latter always points at pyvenv=
/bin/python3.

Good point!

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  tests/Makefile.include    | 8 +++-----
>  tests/vm/Makefile.include | 2 +-
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 5b838ec438b0..0184ef223737 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -89,11 +89,9 @@ distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
>  # Build up our target list from the filtered list of ninja targets
>  TARGETS=3D$(patsubst libqemu-%.fa, %, $(filter libqemu-%.fa, $(ninja-tar=
gets)))
>
> -TESTS_VENV_DIR=3D$(BUILD_DIR)/pyvenv
>  TESTS_VENV_TOKEN=3D$(BUILD_DIR)/pyvenv/tests.group
>  TESTS_VENV_REQ=3D$(SRC_PATH)/tests/requirements.txt
>  TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
> -TESTS_PYTHON=3D$(TESTS_VENV_DIR)/bin/python3
>  ifndef AVOCADO_TESTS
>         AVOCADO_TESTS=3Dtests/avocado
>  endif
> @@ -109,7 +107,7 @@ else
>  endif
>
>  quiet-venv-pip =3D $(quiet-@)$(call quiet-command-run, \
> -    $(TESTS_PYTHON) -m pip -q --disable-pip-version-check $1, \
> +    $(PYTHON) -m pip -q --disable-pip-version-check $1, \
>      "VENVPIP","$1")
>
>  $(TESTS_VENV_TOKEN): $(TESTS_VENV_REQ)
> @@ -131,7 +129,7 @@ FEDORA_31_DOWNLOAD=3D$(filter $(FEDORA_31_ARCHES),$(F=
EDORA_31_ARCHES_CANDIDATES))
>  # download one specific Fedora 31 image
>  get-vm-image-fedora-31-%: check-venv
>         $(call quiet-command, \
> -             $(TESTS_PYTHON) -m avocado vmimage get \
> +             $(PYTHON) -m avocado vmimage get \
>               --distro=3Dfedora --distro-version=3D31 --arch=3D$*, \
>         "AVOCADO", "Downloading avocado tests VM image for $*")
>
> @@ -142,7 +140,7 @@ JOBS_OPTION=3D$(lastword -j1 $(filter-out -j, $(filte=
r -j%,$(MAKEFLAGS))))
>
>  check-avocado: check-venv $(TESTS_RESULTS_DIR) get-vm-images
>         $(call quiet-command,                                            =
       \
> -            $(TESTS_PYTHON) -m avocado                                  =
               \
> +            $(PYTHON) -m avocado                                        =
       \
>              --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_RES=
ULTS_DIR)  \
>              $(if $(AVOCADO_TAGS),,                                      =
       \
>                         --filter-by-tags-include-empty                   =
       \
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index c2a8ca1c175a..f0f5d32fb0f0 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -5,7 +5,7 @@ ifeq ($(realpath $(SRC_PATH)),$(realpath .))
>  VM_PYTHON =3D PYTHONPATH=3D$(SRC_PATH)/python /usr/bin/env python3
>  VM_VENV =3D
>  else
> -VM_PYTHON =3D $(TESTS_PYTHON)
> +VM_PYTHON =3D $(PYTHON)
>  VM_VENV =3D check-venv
>  endif
>
> --
> 2.40.1
>


