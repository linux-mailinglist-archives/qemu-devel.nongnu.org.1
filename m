Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5050798A39
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 17:49:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qediW-0007OE-2x; Fri, 08 Sep 2023 11:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qediR-0007NQ-N6
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 11:48:15 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qediP-0005oL-DI
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 11:48:15 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1c4b4c40281so1735955fac.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694188091; x=1694792891; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vJwp6vL8LF7hbxGJ/Yu7qjkZAKCN+PrmNIzbGFXOacg=;
 b=sjEm7fFTwxCoCWD9v/nMYUsnBstkK9NTJCoP1UwewrrepXCBZ7KOpZ6/pB88jYEtlX
 KHiNc2ln+Z2sy8MVxcg7Rehpl1D6oKiXnuXuo+SavjhygFpp8w9c/M8Se1nC/dEGOU7n
 eldumkDe2Gc6hU1Hzs/5RUSYHY/O8YKd/IJvQ80yxUN1HI33KKyCq+jq4IRdoC06ixBv
 8Y9dU1j4/4h60EBMCwJghmWDkfyl8jtOJZ4lDgCTOJbRlqzu2xmmJPQLMOfarcx9Jylj
 apAAIqekgUD5+1HY3JM3k3YfAL21SdjR2+uzkwEKm2yGbc9mEfFWu513HlAXDWygD8Bw
 tUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694188091; x=1694792891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vJwp6vL8LF7hbxGJ/Yu7qjkZAKCN+PrmNIzbGFXOacg=;
 b=ELwjImzm6+jlrSpiRnFGPjnZKYPjeXKrikC52M9C7nJuzhAzZq62fYJr3G12ryekUe
 bOhpYnSiV7yZVUcQWuOJluZjWq21USMt2CCS7rKzNTFSshjkCAgLpuhfrNAsdiQeXq0y
 gHO2eJfAtC414FqbjBwnldoewGUs5+VZ68/DBWh+QphibWvZC4Vr+5+4/rRxwCugquzH
 xpOg3p5wqrbqr8DBJ3mn6O+K3kCIlbmMkRhWFhrhxxBTP6G9obKAzcGJ0S1XcZhuyIhV
 8KnqLo8/79nn2L4jouIye+qdMfteAjr2xYhet2UDRehyUtEoErmNq0PoXGnPzdLk8ZFe
 kNmA==
X-Gm-Message-State: AOJu0YxtTPwKHkVM9KoclUnCAfvnDv48SoepTTJMr1XS6UG+pVHCcZCo
 9DMAhDj0np+34pvXjPcpHyWr8g40ij6Xn2PTAYM=
X-Google-Smtp-Source: AGHT+IE67D6vwha6Pw/5EaYQKfM+m83RV323R0DOBc5I+oOZnFdRGOZfeyDXC+nHpUYCp9CxXumiOZdCeJOWzUt2Okg=
X-Received: by 2002:a05:6870:3327:b0:1c3:2a5a:ebea with SMTP id
 x39-20020a056870332700b001c32a5aebeamr3078441oae.8.1694188091542; Fri, 08 Sep
 2023 08:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907154412.GA1550739@fedora> <ZPs3UB8W4lsOFnxW@redhat.com>
In-Reply-To: <ZPs3UB8W4lsOFnxW@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 8 Sep 2023 11:47:58 -0400
Message-ID: <CAJSP0QX4QgxG-3dbv6oa6_81MWJkYKTT7T05D5hCtFiG=mLi7Q@mail.gmail.com>
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x2e.google.com
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

I wonder how it passed CI?
https://gitlab.com/qemu-project/qemu/-/pipelines/996175923/

Stefan

On Fri, 8 Sept 2023 at 11:02, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 07.09.2023 um 17:44 hat Stefan Hajnoczi geschrieben:
> > Applied, thanks.
> >
> > Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.
>
> Something in this has broken the build for me, it seems to be the
> linux-user binary that doesn't link any more:
>
>   /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `cpu_x86_cpuid':
>   /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:6180: undefined reference to `kvm_arch_get_supported_cpuid'
>   /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `x86_cpu_filter_features':
>   /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7158: undefined reference to `kvm_arch_get_supported_cpuid'
>   /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7159: undefined reference to `kvm_arch_get_supported_cpuid'
>   /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7160: undefined reference to `kvm_arch_get_supported_cpuid'
>   /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7161: undefined reference to `kvm_arch_get_supported_cpuid'
>   /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o:/home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7162: more undefined references to `kvm_arch_get_supported_cpuid' follow
>   clang-15: error: linker command failed with exit code 1 (use -v to see invocation)
>
> In case it makes a difference, I'm using clang on F37.
>
> Kevin

