Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95110707315
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 22:32:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzNoB-00024K-9b; Wed, 17 May 2023 16:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzNo9-000245-0v
 for qemu-devel@nongnu.org; Wed, 17 May 2023 16:31:37 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzNo7-0007Bk-07
 for qemu-devel@nongnu.org; Wed, 17 May 2023 16:31:36 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1a516fb6523so12737675ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684355493; x=1686947493;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mAOg4wm0H6NZEoYxofU+jOHQiDiSplvRynYOZ5EWSCY=;
 b=srgWzqPoyffALTGTxVk2BKOj9QEnzQ8di7M8rOkHKWoSpyWhhmls9AOnQdCJ3RWFpZ
 EWFxmzLH0r6L3+Ujs4OLDgk9zBqNcgh+9kyjmmqXK+Vgaa8RUZwW9U4aLyVlBTayKuye
 dEqHKdzJPSTwmcZr0JmKjSK0swnyJLC+Jn20LwKnV90RXuvQ+V674pYOjk8tkWfNt2H5
 bdqvYq8x/qz0PmxnAzCd+wNz1WpC2OIxr220oTPTurAOh/v6jy1V3L7TKhKoiYOQQqxu
 xIW++pK3XJQjqW8uOtEjxVicdYJkwDgvtYNpV+uRQrHcd5+LZNtKPRQCvbc4bgUEegwn
 GpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684355493; x=1686947493;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mAOg4wm0H6NZEoYxofU+jOHQiDiSplvRynYOZ5EWSCY=;
 b=Wo62UwDo/u24MaKw9Ak2v2+slGb/zKuWu19bEeDbJc7HVojjZPsk8GNi7YhkDcSpWU
 BPDFBc23T7aPa2iDZDVT/PnoSVy/t8xSQc4q3YWB+veIz5GpEuNVgiaDMxQt86lV3hJx
 ufAHXyuGFB/GyPV4cF5Jv1H+z7b9HaCXXwyLtFPUnfBqQn+X2W5XafuUhm2PdBUvCZKu
 /CIFWJFcwQNuq+6vasz+Oe/hHJlWLTxN77xzuDCTrsFwBhWBp5nXs/qfzFm8txtPz2w6
 b3hymSJA0a/9njoFdlradVrk9vxfDg1us3A4cYUA+Eu5pUeVHLVoosiP/bzaVRos/Lbq
 TR5w==
X-Gm-Message-State: AC+VfDyH6bSxqUzosAGA0CZ9zf8IWJ2QG2iuveF4B/WwkMXhzfafsOYf
 GotI+Fk06TY4mVFuaVJZKBqYTw==
X-Google-Smtp-Source: ACHHUZ6bwxPQLqc2r7bmPXkt9DE30+L1ZnLgF+FJDVjCVGjaJxMFKpObrAQwiYJ9CbTAwopKI3oIyQ==
X-Received: by 2002:a17:902:8344:b0:1ae:3991:e4f9 with SMTP id
 z4-20020a170902834400b001ae3991e4f9mr5825892pln.61.1684355493293; 
 Wed, 17 May 2023 13:31:33 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7?
 ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a170902c3c600b001ac84f5559csm16254439plj.126.2023.05.17.13.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 13:31:32 -0700 (PDT)
Message-ID: <a7f23b7c-879f-36db-dabd-1891bda766e5@linaro.org>
Date: Wed, 17 May 2023 13:31:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 00/68] i386, build system, KVM changes for 2023-05-18
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230517174520.887405-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.412,
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

On 5/17/23 10:44, Paolo Bonzini wrote:
> The following changes since commit ab4c44d657aeca7e1da6d6dcb1741c8e7d357b8b:
> 
>    Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-05-15 13:54:33 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to b98d6272e33a2ca8bab4c8087e8809e98400d2c5:
> 
>    docs/devel: update build system docs (2023-05-17 16:55:09 +0200)
> 
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
> 
> ----------------------------------------------------------------
> Emanuele Giuseppe Esposito (2):
>        target/i386: add support for FLUSH_L1D feature
>        target/i386: add support for FB_CLEAR feature
> 
> Fabiano Rosas (1):
>        meson: Pass -j option to sphinx
> 
> Gavin Shan (4):
>        migration: Add last stage indicator to global dirty log
>        kvm: Synchronize the backup bitmap in the last stage
>        kvm: Add helper kvm_dirty_ring_init()
>        kvm: Enable dirty ring for arm64
> 
> John Snow (23):
>        python: update pylint configuration
>        python: add mkvenv.py
>        mkvenv: add better error message for broken or missing ensurepip
>        mkvenv: add nested venv workaround
>        mkvenv: add ensure subcommand
>        mkvenv: add --diagnose option to explain "ensure" failures
>        mkvenv: add console script entry point generation
>        mkvenv: use pip's vendored distlib as a fallback
>        mkvenv: avoid ensurepip if pip is installed
>        mkvenv: work around broken pip installations on Debian 10
>        tests/docker: add python3-venv dependency
>        tests/vm: Configure netbsd to use Python 3.10
>        tests/vm: add py310-expat to NetBSD
>        python: add vendor.py utility
>        configure: create a python venv unconditionally
>        python/wheels: add vendored meson package
>        configure: use 'mkvenv ensure meson' to bootstrap meson
>        qemu.git: drop meson git submodule
>        tests: Use configure-provided pyvenv for tests
>        configure: move --enable-docs and --disable-docs back to configure
>        configure: bootstrap sphinx with mkvenv
>        configure: add --enable-pypi and --disable-pypi
>        configure: Add courtesy hint to Python version failure message
> 
> Paolo Bonzini (33):
>        target/i386: fix operand size for VCOMI/VUCOMI instructions
>        tests/tcg/i386: correct mask for VPERM2F128/VPERM2I128
>        tcg: round-robin: do not use mb_read for rr_current_cpu
>        coverity: the definitive COMPONENTS.md update
>        scsi-generic: fix buffer overflow on block limits inquiry
>        python: shut up "pip install" during "make check-minreqs"
>        Python: Drop support for Python 3.6
>        mkvenv: mark command as required
>        python: bump some of the dependencies
>        meson: regenerate meson-buildoptions.sh
>        meson: require 0.63.0
>        meson: use prefer_static option
>        meson: remove static_kwargs
>        meson: add more version numbers to the summary
>        meson: drop unnecessary declare_dependency()
>        build: move glib detection and workarounds to meson
>        configure: remove pkg-config functions
>        configure, meson: move --enable-modules to Meson
>        meson: prepare move of QEMU_CFLAGS to meson
>        build: move sanitizer tests to meson
>        build: move SafeStack tests to meson
>        build: move coroutine backend selection to meson
>        build: move stack protector flag selection to meson
>        build: move warning flag selection to meson
>        build: move remaining compiler flag tests to meson
>        build: move compiler version check to meson
>        build: move --disable-debug-info to meson
>        configure: remove compiler sanity check
>        configure: do not rerun the tests with -Werror
>        configure: remove unnecessary mkdir
>        configure: reorder option parsing code
>        configure: remove unnecessary check
>        docs/devel: update build system docs
> 
> Ricky Zhou (3):
>        target/i386: Fix and add some comments next to SSE/AVX instructions.
>        target/i386: Fix exception classes for SSE/AVX instructions.
>        target/i386: Fix exception classes for MOVNTPS/MOVNTPD.
> 
> Steve Sistare (1):
>        make: clean after distclean deletes source files
> 
> Xinyu Li (1):
>        target/i386: fix avx2 instructions vzeroall and vpermdq

Failures:

https://gitlab.com/qemu-project/qemu/-/jobs/4304958487#L1887

Warning, treated as error:
the sphinx_rtd_theme extension does not declare if it is safe for parallel reading, 
assuming it isn't - please ask the extension author to check and make it explicit

https://gitlab.com/qemu-project/qemu/-/jobs/4304958508#L2551

/usr/lib/gcc/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/lib/../lib/libc.a(init-first.o): 
in function `__libc_init_first':
(.text+0x10): relocation truncated to fit: R_AARCH64_LD64_GOTPAGE_LO15 against symbol 
`__environ' defined in .bss section in 
/usr/lib/gcc/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/lib/../lib/libc.a(environ.o)
/usr/bin/ld: (.text+0x10): warning: too many GOT entries for -fpic, please recompile with 
-fPIC


r~

