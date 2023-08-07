Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 880AD77266D
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 15:47:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT0Yd-0001Cg-Ny; Mon, 07 Aug 2023 09:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT0Yb-0001CX-86
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 09:46:01 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT0YW-0007Sa-CE
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 09:46:01 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52256241c50so6553807a12.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691415953; x=1692020753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xh527B0UrvxM8ewYokdqkM3BEhOS11bOlOTy1vuDC4w=;
 b=e+n/uk4Aa84Uaian1SNB1UNto591JNVjiCNryaPHHuxvFSNTkRr+TCwL4/oJ26yDIG
 lPugqMfr4I3N4uGJm/Z+sWICBeJObRQizdDrQccwQQll/pAfzncu6QrsfJvUAs547g3U
 bLF6MA6pg7wnXQvILJxL0O8D7LVf0DKBlwv8VJWIqtfqFeMR4PWKqzZpNh1VK09KLESo
 B84mUhmdOiTzEdJ/3RqotHf9mWF7mcxQjR0lYxZuF1GK4rB8eU2u/MsoFPA0RBOMseFx
 yjdpVUlrKBupc+Fhc3m6AVoMH96ym4ru/qQtrI9Mo2n3XCrSK+/RxpJwsgnqglDs/Ikr
 RiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691415953; x=1692020753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xh527B0UrvxM8ewYokdqkM3BEhOS11bOlOTy1vuDC4w=;
 b=TfEURsf4yAxV2TJGhy9q3nKNj/iz+IIRRhNkadYVucdjiSSAL6aOtVIewQezL4U6nV
 mCn2JnVjqQwbHbkwWO6vOqfbqhZSkjQKYO9V6rj0bX4GdF9BBFrFVJ77jTLmi0je4aBh
 KsrIqnPMpSORLARO55+WjgqjTIUAf0tfBBUgRcOCD0iLleUFJk0rwF+Yd0CuX1AnZWOm
 FplssgeKbmq9mUP9VGUkLXuIrxJqnesEnrrYA+Hpl7aDMzOB0g+6aUDJjnrO97t2OfaE
 WG7pnftVUyGD6DQAC4zU1aM5TnIF5nAEbVp5LO/pKsIarc2UjoIQsYfNSzbMiPIPcYqj
 BBIQ==
X-Gm-Message-State: AOJu0YzC+LRJTPpJSZ2sYHvHR1u4p02WHWY5acVQIeoMuyFiK5NtwTAn
 lI813tAP/c1jcYs8DDek7qynNMo4lUWkcItrRCOkUg==
X-Google-Smtp-Source: AGHT+IFIt5PsmVnnWCxnJBo0Y9XayF6CJS88wQhD+TGcbFdeoOSqQvu3Ar5JW741hNGnjXb4UpFGn/UFQxSPmLJPNPI=
X-Received: by 2002:a05:6402:78a:b0:522:5980:ae08 with SMTP id
 d10-20020a056402078a00b005225980ae08mr8398744edy.18.1691415952933; Mon, 07
 Aug 2023 06:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230807094807.471646-1-pbonzini@redhat.com>
 <20230807094807.471646-4-pbonzini@redhat.com>
In-Reply-To: <20230807094807.471646-4-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Aug 2023 14:45:41 +0100
Message-ID: <CAFEAcA8mR04aAQcuB4d0L6XkEPNGfF2+QRg2FVPT3feBVst-7w@mail.gmail.com>
Subject: Re: [PATCH 3/3] configure: unify case statements for CPU
 canonicalization
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org, 
 Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 7 Aug 2023 at 10:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The CPU model has to be canonicalized to what Meson wants in the cross
> file, to what Linux uses for its asm-$ARCH directories, and to what
> QEMU uses for its user-mode emulation host/$ARCH directories.  Do
> all three in a single case statement, and check that the Linux and
> QEMU directories actually exist.
>
> At a small cost in repeated lines, this ensures that there are no hidden
> ordering requirements between the case statements.  In particular, commit
> 89e5b7935e9 ("configure: Fix linux-user host detection for riscv64",
> 2023-08-06) broke ppc64le because it assigned host_arch based on a
> non-canonicalized version of $cpu.
>
> Reported-by: Joel Stanley <joel@jms.id.au>
> Fixes: 89e5b7935e9 ("configure: Fix linux-user host detection for riscv64", 2023-08-06)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure | 159 +++++++++++++++++++++++++++++-------------------------
>  1 file changed, 87 insertions(+), 72 deletions(-)
>
> diff --git a/configure b/configure
> index 484d38d81f4..fb213412d7c 100755
> --- a/configure
> +++ b/configure
> @@ -469,59 +469,104 @@ else
>    echo "WARNING: unrecognized host CPU, proceeding with 'uname -m' output '$cpu'"
>  fi
>
> -case "$cpu" in
> -  riscv*)
> -    host_arch=riscv ;;
> -  x32)
> -    host_arch=x86_64 ;;
> -  *)
> -    host_arch="$cpu" ;;
> -esac
> -
> -# Normalise host CPU name and set multilib cflags.  The canonicalization
> -# isn't really necessary, because the architectures that we check for
> -# should not hit the 'uname -m' case, but better safe than sorry.
> +# Normalise host CPU name to the values used by Meson cross files and in source
> +# directories, and set multilib cflags.  The canonicalization isn't really
> +# necessary, because the architectures that we check for should not hit the
> +# 'uname -m' case, but better safe than sorry.
> +#
>  # Note that this case should only have supported host CPUs, not guests.
> +# Please keep it sorted.
> +host_arch=
> +linux_arch=
>  case "$cpu" in
> +  aarch64)
> +    host_arch=aarch64
> +    linux_arch=arm64 ;;
> +
>    armv*b|armv*l|arm)
>      cpu="arm" ;;
> +    host_arch=arm
> +    linux_arch=arm ;;
>
>    i386|i486|i586|i686)
>      cpu="i386"
> +    host_arch=i386
> +    linux_arch=x86
>      CPU_CFLAGS="-m32" ;;
> +
> +  loongarch*)
> +    cpu=loongarch64
> +    host_arch=loongarch64 ;;
> +
> +  mips64*)
> +    cpu=mips64
> +    host_arch=mips
> +    linux_arch=mips ;;
> +  mips*)
> +    cpu=mips
> +    host_arch=mips
> +    linux_arch=mips ;;
> +
> +  ppc)
> +    host_arch=ppc
> +    linux_arch=powerpc
> +    CPU_CFLAGS="-m32" ;;
> +  ppc64)
> +    host_arch=ppc64
> +    linux_arch=powerpc
> +    CPU_CFLAGS="-m64 -mbig-endian" ;;
> +  ppc64le)
> +    cpu=ppc64
> +    host_arch=ppc64
> +    linux_arch=powerpc
> +    CPU_CFLAGS="-m64 -mlittle-endian" ;;
> +
> +  riscv32 | riscv64)
> +    host_arch=riscv
> +    linux_arch=riscv
> +    ;;

Can we be consistent within this case statement about whether
the ';;' is on its own line or at the end of the last line of
the case ? We are not fully consistent within the entire
configure script, but mostly we put it on a line of its
own. (I prefer that personally.)

thanks
-- PMM

