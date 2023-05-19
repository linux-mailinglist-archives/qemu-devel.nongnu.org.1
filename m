Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A89709A13
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:40:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01GO-0002pv-IR; Fri, 19 May 2023 10:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q01GM-0002pX-Tm
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:39:22 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q01GL-0001Rx-3Q
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:39:22 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-510d8b0169fso4362872a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684507159; x=1687099159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5G5kgmLYsr4XlNQgbqAHqq0gaVURQy1bCWUDn7j6kXw=;
 b=EfThjahuduC3OEn8bGQ63qpo9o3dgdHX0ssME0Fd8eSHKu1IXOytmdUq2WXi61IkeC
 fYgN3gMaUyU1+rIs3NGZRy6nHzlDRbRiNCkZf+kplXkMid314hRtOitWmvxvHU4igMEz
 9ZtU5ZMDghm+ljpf7JjOKgDuMvLW47mME1raic6dQCYQEH18/d0kVVkb2M3vaBEhhicR
 BKqmdSAVOJ29BMWu30gOBrXkR7wYdRqT0G01SaNE0mnmAkHzJeErSu4wj+x5psYbVJsM
 IAP2p56R0vmI/iwHqolaTAQytTGze/W3x8+XVH7Iz4tBOI6q9pwPckw8xzuy03GsSob0
 lHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507159; x=1687099159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5G5kgmLYsr4XlNQgbqAHqq0gaVURQy1bCWUDn7j6kXw=;
 b=bKD63PbxH/YCS+4UcIhgNIxLh+JGXbHhiCz8T99o7q0gK40gqnM8PJ9kmoQ2o14jvw
 f9MEPnwV/EUXRFpRd370lqkLaiGysM0Y1lFDaAlTX9dqPs8arHv40hlW24fYNJNSM+c+
 kLPgUW2Dr59lDmUYKIxIG99i8/IdZTDI4LjPD+TGFUsLObfvoaB1a1YGfNqe5bQrcCXU
 pf2/Y5o461PJjXj5ttC5aDLLpuWLD0iqgYTCPIhcABtLjvA4h7o71/u3rGuVr5MGKm3A
 9CG05k6j0Obf47Or/DCXsZkNQRbZ2EbLsIxUN4igH1UE2m+ToGm1FgPnymtS90zsoNR1
 SNsg==
X-Gm-Message-State: AC+VfDwF3KvttUMeQFLLE/WqymFdLf42osg0j3TDCTjNdsUzf1b9PCFC
 OdO0ASWRxsrP6gk83Wd0pJrlfffRqAG0OI3UJDwbE10OA3e7CNMp
X-Google-Smtp-Source: ACHHUZ7JhB+YoiCX6K9jpr2lnHl0Sirp0+hXEHFFWgWHPVeFkZ2l9OKtzurWM4wQhzNYameWogIDCjL38uWsaQ11XEI=
X-Received: by 2002:aa7:d1c7:0:b0:50d:9e7c:264d with SMTP id
 g7-20020aa7d1c7000000b0050d9e7c264dmr1757554edp.8.1684507159068; Fri, 19 May
 2023 07:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230518114025.1006732-1-pbonzini@redhat.com>
In-Reply-To: <20230518114025.1006732-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 May 2023 15:39:08 +0100
Message-ID: <CAFEAcA-ZtAHC2frNzVymYf9pufyi6Y1wHeLnKLrne7NaTeqNfw@mail.gmail.com>
Subject: Re: [PULL v3 00/68] i386, build system, KVM changes for 2023-05-18
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 18 May 2023 at 12:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
> ----------------------------------------------------------------
> * kvm: enable dirty ring for arm64
> * target/i386: new features
> * target/i386: AVX fixes
> * configure: create a python venv unconditionally
> * meson: bump to 0.63.0 and move tests from configure
> * meson: Pass -j option to sphinx
> * drop support for Python 3.6
> * fix check-python-tox
> * fix "make clean" in the source directory

Hi; this seems to have broken builds from not-clean on my system.
Blowing away the build tree and recreating it from scratch
works, as does manually re-running configure,
but the Makefile ought to re-run parts of configure
etc when it needs to.

It does seem to try to, but (unlike a manual configure re-run)
it doesn't prevent the failure.

You can see that it says it needs to run configure, and mkvenv
claims to be installing meson 0.6.3, but then the actual build
says it didn't work. (A second run of 'make' at this point doesn't
do the rerun of configure but meson fails in the same way.)

Other weird things:
(1) the error message is printed three times
(2) "warn: ignoring non-existent submodule meson"

$ make -C build/x86-tgts
make: Entering directory
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts'
config-host.mak is out-of-date, running configure
python determined to be '/usr/bin/python3'
python version: Python 3.10.6
mkvenv: Creating non-isolated virtual environment at 'pyvenv'
mkvenv: checking for meson>=0.63.0
mkvenv: installing meson>=0.63.0
mkvenv: checking for sphinx>=1.6.0, sphinx-rtd-theme>=0.5.0
/usr/bin/ninja  build.ninja && touch build.ninja.stamp
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
FAILED: build.ninja
/usr/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/meson/meson.py --internal
regenerate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts --backend
ninja
ninja: error: rebuilding 'build.ninja': subcommand failed
  GIT     ui/keycodemapdb meson tests/fp/berkeley-testfloat-3
tests/fp/berkeley-softfloat-3 dtc
warn: ignoring non-existent submodule meson
/usr/bin/ninja  build.ninja && touch build.ninja.stamp
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
FAILED: build.ninja
/usr/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/meson/meson.py --internal
regenerate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts --backend
ninja
ninja: error: rebuilding 'build.ninja': subcommand failed
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


thanks
-- PMM

