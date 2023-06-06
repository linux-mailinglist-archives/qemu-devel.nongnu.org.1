Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF4D724D26
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6cT5-0006vo-1J; Tue, 06 Jun 2023 15:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q6cT3-0006ve-JF
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q6cT2-0004qb-1d
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686080143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TKnsC3nv98mABAtCtDFlhNLYtbw3M1YOgKkMaP5qncw=;
 b=NTUxyCoKFm6rNURnbTa+aoW2P9PN55JDSOoWtrBWjrgiHwQ/XryRshEDQm8VJXI32jezeh
 sl8wwJvrzUXgzTbSZtYwu56E2YXSfXIoG5bDYmnyt7fQHWeM5+5x0sLhRHGcOxB7ewT5/F
 rlCPepEoUEz7qEeKla8VWGzZu+FtGfw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-jGGKAS-mOm60EOmbVCQ_xQ-1; Tue, 06 Jun 2023 15:35:41 -0400
X-MC-Unique: jGGKAS-mOm60EOmbVCQ_xQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-25667878a53so2383816a91.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686080141; x=1688672141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKnsC3nv98mABAtCtDFlhNLYtbw3M1YOgKkMaP5qncw=;
 b=EHmKzn2j3siaCT42qxkHGg1J2QfG3YWTRIV8cvwR1mBIB4EdVUk2nli8LXaUHV3mdG
 Py0D8SRSR7laPYQA1c9MpRe/BmnjrtAJJQlhAdeR4fuwmC+aobDTuLlcrqVdsikaqkn/
 qVHuTqdcHB9cd3zz08xe4Etx/MhCBzmpw73Ak+R81KcsLU1W8xn+UFU7NnHRA+7+OdJz
 y6HDRvI7qqiC3OP1KbZ5r7qoTbkgbguV2/8vpTdKXPqQHzi29YmTlyGtnd4gccfPNBBm
 SUufd+S4ICbJXo953Hy5Lq4wcvQdqih4V6U3uQFmlJ827pr1uqFV/W0EjaY7AUolcXRQ
 DqMw==
X-Gm-Message-State: AC+VfDwssJMYazur4GI6t2YFHTzmMqkSd33l4K/u6OUaSSRPHwZeLedl
 t2K68CfMKnUlusz81szd4LZtzz9aTfOul7mF1IgaLq9dUTVmn7RFj2+JwoBufsiezearUFGWWpe
 xeEWHIsDQch/MD/my0gSIM346X3WM1eQ=
X-Received: by 2002:a17:90a:d392:b0:24f:13ec:ecac with SMTP id
 q18-20020a17090ad39200b0024f13ececacmr1952748pju.26.1686080140735; 
 Tue, 06 Jun 2023 12:35:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7oOTiODgkS/RdD+D+CaLW6d2JHmhPBpSP6YW0L5SUmOEKd3no4Q+rcPAjWqYbjVnhthdFD8eV3zcAz+vovj2I=
X-Received: by 2002:a17:90a:d392:b0:24f:13ec:ecac with SMTP id
 q18-20020a17090ad39200b0024f13ececacmr1952739pju.26.1686080140424; Tue, 06
 Jun 2023 12:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230605160012.339685-1-pbonzini@redhat.com>
In-Reply-To: <20230605160012.339685-1-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 6 Jun 2023 15:35:29 -0400
Message-ID: <CAFn=p-YfOi1wEZvL_d0L+BNnL1CTy_O2u-CHmVRNifpJibfhBA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Revert recent Avocado changes
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, kconsul@linux.vnet.ibm.com
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

On Mon, Jun 5, 2023 at 12:00=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Bumping avocado to version 101 has two issues.  First, there are problems
> where Avocado is not logging of command lines or terminal output, and not
> collecting Python logs outside the avocado namespace.
>
> Second, the recent changes to Python handling mean that there is a single
> virtual environment for all the build, instead of a separate one for test=
ing.
> Requiring a too-new version of avocado causes conflicts with any avocado
> plugins installed on the host:
>
>    $ make check-venv
>    make[1]: Entering directory '/home/berrange/src/virt/qemu/build'
>      GIT     ui/keycodemapdb tests/fp/berkeley-testfloat-3 tests/fp/berke=
ley-softfloat-3 dtc
>      VENVPIP install -e /home/berrange/src/virt/qemu/python/
>      VENVPIP install -r /home/berrange/src/virt/qemu/tests/requirements.t=
xt
>    ERROR: pip's dependency resolver does not currently take into account =
all the packages that are installed. This behaviour is the source of the fo=
llowing dependency conflicts.
>    avocado-framework-plugin-varianter-yaml-to-mux 98.0 requires avocado-f=
ramework=3D=3D98.0, but you have avocado-framework 101.0 which is incompati=
ble.
>    avocado-framework-plugin-result-html 98.0 requires avocado-framework=
=3D=3D98.0, but you have avocado-framework 101.0 which is incompatible.
>    make[1]: Leaving directory '/home/berrange/src/virt/qemu/build'
>
> To avoid this issue, tests/requirements.txt should use a ">=3D" constrain=
t
> and the version of Avocado should be limited to what distros provide
> in the system packages.  However, this requires more work, so for now
> reintroduce the avocado-specific virtual environment instead of using
> pyvenv/.

That still want you want to do as of right now? (I'm catching up.)

OK if so. We don't lose too much.

>
> Paolo
>
> Supersedes: <20230605075823.48871-1-pbonzini@redhat.com>
>
> Paolo Bonzini (2):
>   Revert "tests/requirements.txt: bump up avocado-framework version to
>     101.0"
>   tests: Use separate virtual environment for avocado
>
>  .gitlab-ci.d/buildtest.yml                    |  6 ++--
>  docs/devel/acpi-bits.rst                      |  6 ++--
>  docs/devel/testing.rst                        | 14 ++++----
>  .../org.centos/stream/8/x86_64/test-avocado   |  4 +--
>  scripts/device-crash-test                     |  2 +-
>  tests/Makefile.include                        | 32 +++++++++----------
>  tests/requirements.txt                        |  9 ++----
>  tests/vm/Makefile.include                     |  2 +-
>  8 files changed, 35 insertions(+), 40 deletions(-)
>
> --
> 2.40.1
>


