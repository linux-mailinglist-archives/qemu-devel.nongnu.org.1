Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E593709E86
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 19:47:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q04BA-0004Au-Pb; Fri, 19 May 2023 13:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q04B8-0004Ag-Ly
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:46:10 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q04B4-0004Cq-SP
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:46:10 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-96f53c06babso276809466b.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 10:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684518365; x=1687110365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SgeNjNsuKfTbNkGJ3rWv2yI3Rj8+AFZqNL/QEiB2hcM=;
 b=V4EA1iCuZFn06qNcJ16Kmcnn+Kvw/e3rMHjr6lmzAJhB3dTl0Qf+4JiL9Jmp2PbXG1
 s+Ej3pxf9pcN0p1ZPEFhZ3S9OSFKp+p4WaPLQHjk/bDEmRNw8OVsLOBbdi+GXfvdbmTf
 vUcCwHnIrIy7UCtc52T26eSAwDAo2R8gy3uewKgqchL+LZV+idzro+Np7+4fvDkuuGM3
 a9lwgNaBeBv7a+M3CR2XstReiusrHNOWjZUjIjOwnm+t1A8cbXHzGzZRXj9xQZzAA6ka
 nqGNeGqrN1pCJymCyhVU5OYVkpp4PVjmMKAbe6d3RRBzEmS0cxq5CoyTayLovdrecFNl
 w95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684518365; x=1687110365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SgeNjNsuKfTbNkGJ3rWv2yI3Rj8+AFZqNL/QEiB2hcM=;
 b=bZy6TaNQ265GB+HqDGTWzmdVJc4iB98yhnhWaLVZsjlGl/xDcH3u5mn2JEBL1bzxWU
 k0hr1V5F+yddlhhsF/sWbWOkweuloDC8cG1qZ88A+qZuH8JhyZG1Ze3Xsw2SIxnUt7Pm
 7qS4eiYiaNnvmmmpMpCcVLaePe0wkahIXmZ73kSTTDVc7mVMDqH48KL8fWUZrWtAJoYV
 UpeKbLkCPEV9t4+XTUhFmr+7SH8Jec5WlYT92O/Kad/4UgPQpmyLjyFEMNrrP7xPudoR
 ZCBDwBxNcFiaYsRMXnhUtuCaBxYgCl5UYRPIjdzVWcDF9Sq8GAxndpyvUrJA6tfUmySh
 mdcg==
X-Gm-Message-State: AC+VfDwWDbxg1ZsBvTuBT6b0U4D08vqD2YNEliui9oVJjnKR1Yf2L59M
 Zp+UVJpTDmMFKW15wngE6DZjZ4/+3qnAumQwwW1oD/O51uWUtOkA
X-Google-Smtp-Source: ACHHUZ5Dz5qj0OTdPERL7+PUMDM1cPfana9ZiLVnGe0rnQT7p29+BGZ951VVYXppm9bBpaD9BRaAPdsDWTd2pohPzIc=
X-Received: by 2002:a17:907:86a8:b0:965:c2ab:7014 with SMTP id
 qa40-20020a17090786a800b00965c2ab7014mr2582110ejc.35.1684518365259; Fri, 19
 May 2023 10:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230518114025.1006732-1-pbonzini@redhat.com>
 <CAFEAcA-ZtAHC2frNzVymYf9pufyi6Y1wHeLnKLrne7NaTeqNfw@mail.gmail.com>
 <CABgObfbk=8Uq3gN1dThxq3jJOAEk_cGu0Y4bvRtvdR9xZ2xtxw@mail.gmail.com>
 <CAFEAcA_4_JD46CxkT2dcXSLHKNsa7kKYPYJkqEzZERDTK_wx-A@mail.gmail.com>
 <379845d1-7a4e-a0eb-345c-451b17e77638@redhat.com>
In-Reply-To: <379845d1-7a4e-a0eb-345c-451b17e77638@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 May 2023 18:45:54 +0100
Message-ID: <CAFEAcA-cWzw-heK7y83=ZnSG7Kd_NUiayOrm6Zz6jRADB1-Nfg@mail.gmail.com>
Subject: Re: [PULL v3 00/68] i386, build system, KVM changes for 2023-05-18
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 19 May 2023 at 18:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 5/19/23 19:01, Peter Maydell wrote:
> >> Can you send your config-host.mak after a failed rebuild? I think
> >> what's happening is that the path to meson has changed but Makefile
> >> still tries the old one (which could be the system meson in
> >> /usr/bin).
> >
> > Attached; it has
> > MESON=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/pyvenv/bin/meson
> >
> >  That meson says: $
> > /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/pyvenv/bin/meson --version>
> > 1.1.0 is neither the system meson (which is 0.61.2) nor the version
> > the build system wants (0.63.0) nor the version that it complains
> > that it's found (0.61.5), so I'm not sure what's going on there...
>
> 1.1.0 must be something you have cached somewhere

Well, I've never done anything with meson except use whatever
the QEMU build system provides...

> but 0.61.5 comes from
> the old submodule.  You should be able to find it with
>
> grep -wA2 'rule REGENERATE_BUILD' ../build.ninja

Yep:

$ grep -wA2 'rule REGENERATE_BUILD' build/x86-tgts/build.ninja
rule REGENERATE_BUILD
 command = /usr/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/meson/meson.py --internal
regenerate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts --backend
ninja
 description = Regenerating build files.

$ /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/meson/meson.py --version
0.61.5

> You should be able to unhose the directory with
>
> pyvenv/bin/meson setup --reconfigure ../..
>
> (where ../.. should be the path to the sources) or even with the patch:
>
> diff --git a/Makefile b/Makefile
> index 3c7d67142f13..08fb6a3b058a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -115,15 +115,15 @@ Makefile.ninja: build.ninja
>           $(NINJA) -t query build.ninja | sed -n '1,/^  input:/d; /^  outputs:/q; s/$$/ \\/p'; \
>         } > $@.tmp && mv $@.tmp $@
>   -include Makefile.ninja
> +endif
>
> +ifneq ($(MESON),)
>   # A separate rule is needed for Makefile dependencies to avoid -n
>   build.ninja: build.ninja.stamp
>   $(build-files):
>   build.ninja.stamp: meson.stamp $(build-files)
> -       $(NINJA) $(if $V,-v,) build.ninja && touch $@
> -endif
> +       $(MESON) setup --reconfigure $(SRC_PATH) && touch $@
>
> -ifneq ($(MESON),)
>   Makefile.mtest: build.ninja scripts/mtest2make.py
>         $(MESON) introspect --targets --tests --benchmarks | $(PYTHON) scripts/mtest2make.py > $@
>   -include Makefile.mtest

This patch doesn't work, I'm afraid:

$ make -C build/x86-tgts/
make: Entering directory
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts'
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/pyvenv/bin/meson
setup --reconfigure /mnt/nvmedisk/linaro/qemu-from-laptop/qemu &&
touch build.ninja.stamp
WARNING: Regenerating configuration from scratch.
Reason: Coredata file
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/meson-private/coredata.dat'
references functions or classes that don't exist. This probably means
that it was generated with an old version of meson. Try running from
the source directory meson setup
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts --wipe
The Meson build system
Version: 1.1.0
Source dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
Build dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts
Build type: native build

../../meson.build:1:0: ERROR: Unknown options: "sphinx_build"

A full log can be found at
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/meson-logs/meson-log.txt
  GIT     ui/keycodemapdb tests/fp/berkeley-testfloat-3
tests/fp/berkeley-softfloat-3 dtc
[0/1] Regenerating build files.
The Meson build system
Version: 0.61.5
Source dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
Build dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts
Build type: native build

../../meson.build:1:0: ERROR: Meson version is 0.61.5 but project
requires >=0.63.0

A full log can be found at
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/meson-logs/meson-log.txt
ninja: error: rebuilding 'build.ninja': subcommand failed
FAILED: build.ninja
/usr/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/meson/meson.py --internal
regenerate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts --backend
ninja
make: *** [Makefile:165: run-ninja] Error 1
make: Leaving directory
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts'

-- PMM

