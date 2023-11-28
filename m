Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4533A7FB75B
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 11:25:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7vGX-0001pa-TC; Tue, 28 Nov 2023 05:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7vGS-0001pB-Ja
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:24:26 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7vGN-0001n3-Jw
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 05:24:24 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-54bb9024378so277821a12.3
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 02:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701167057; x=1701771857; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PLtMjpEjt957Y6uNi/prBFDVDdUpYxmByZfZDgExx38=;
 b=k2gUSI6wxrAUTaGDyKyQ02sOlNBHLt4Lbqig3YzkCwK3jQ/61lXh8Ot15BwY7/MatY
 Ty53fS+B3LhHclA6zY/gQmzjwJKlE+AiPorjBOEQf2QK+OmJGYQmV8pq5/rO8oajn70n
 VM12lqMJjkbxTNl+9nyp/HanJLIE8J1YhGkm4W8nzk93S0OcmjZqp9g+iox+4vn1Tpls
 vQlHdEMu+SFAROFKlnY7+o72Jl63ju/H598KtU6xcvjvqFTO+MSsz0BmvZ2WXQEWnd54
 zsV28pM5Ljdfws44wlGpRvRYXWjoaqW5GMjVLFHNqf0KOliLkNqha87S86HEjsC+9hSl
 oS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701167057; x=1701771857;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PLtMjpEjt957Y6uNi/prBFDVDdUpYxmByZfZDgExx38=;
 b=It0dOaCMnxlIfXIdeTA6h1k8OPge+qhr5GXD2dBdhwFsJZJ55EurfelU4nZHGgwH3t
 ZKGvt8YuOn+0OB1Z1HaCVlYGKP9uz5poJv3CHkSyfqEpufswcVikwpUQSbabvXB4VC8u
 d9Of8CDU1Qe1qizOdXfolBW4fMjIdqSk61CGPAu9EMbAFhgq+ehZZ/2dyRsF5b7F6MmM
 u1Qb9yKAZ6L3wL1ZN25vk4Tev1ddVNy/Cqns4zCkr3e3l00jbriQBjiz9np6hybTYcBo
 w8b1/PI4OnbdKXGSpyGATO4J2tFXf2NrnyoOG/4+cpZteYyCv1yL2Fo7FVFpLjTo+s/t
 EMug==
X-Gm-Message-State: AOJu0YxWKElgm4m6NP/2595+vyXs+SkTzB+sLuyCqabD+ss1IaB8Mq+r
 +t801/DeKI4q+WpxGOqsHAduR3sH2Y+QOVEQALuZVg==
X-Google-Smtp-Source: AGHT+IGQne7bMsx1OYZyFxt8JZi3hutMlQ0KnydGNXJgCmPJKTZhfV/HWuSeAFDeBCKleKZn02yD5lSFIoTBlJoH9pY=
X-Received: by 2002:a05:6402:ca9:b0:54b:8a3:33d4 with SMTP id
 cn9-20020a0564020ca900b0054b08a333d4mr8313637edb.21.1701167057341; Tue, 28
 Nov 2023 02:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20231127194258.138603-1-arorajai2798@gmail.com>
In-Reply-To: <20231127194258.138603-1-arorajai2798@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2023 10:24:06 +0000
Message-ID: <CAFEAcA90WMfVxn8V5m730ggoOJhj=3-Wz5mt79ktZf==Pz7L1g@mail.gmail.com>
Subject: Re: [PATCH] accel/kvm: Turn DPRINTF macro use into tracepoints
To: Jai Arora <arorajai2798@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 27 Nov 2023 at 19:44, Jai Arora <arorajai2798@gmail.com> wrote:
>
> To remove DPRINTF macros and use tracepoints
> for logging.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1827
>
> Signed-off-by: Jai Arora <arorajai2798@gmail.com>
> ---
>  accel/kvm/kvm-all.c    | 32 ++++++++++----------------------
>  accel/kvm/trace-events |  2 +-
>  2 files changed, 11 insertions(+), 23 deletions(-)

Hi; thanks for sending in this patch.

(I've CC'd the KVM maintainer.)

> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index e39a810a4e..d0dd7e54c3 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -69,16 +69,6 @@
>  #define KVM_GUESTDBG_BLOCKIRQ 0
>  #endif
>
> -//#define DEBUG_KVM
> -
> -#ifdef DEBUG_KVM
> -#define DPRINTF(fmt, ...) \
> -    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) \
> -    do { } while (0)
> -#endif
> -
>  struct KVMParkedVcpu {
>      unsigned long vcpu_id;
>      int kvm_fd;
> @@ -331,7 +321,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>      struct KVMParkedVcpu *vcpu = NULL;
>      int ret = 0;
>
> -    DPRINTF("kvm_destroy_vcpu\n");
> +    trace_kvm_dprintf("kvm_destroy_vcpu\n");

Rather than using a single tracepoint for every line
that was previously a DPRINTF, it's preferable to
use tracepoints whose name indicates what they're doing.
Users can turn tracepoints on and off individually, and they
might, for instance, only want to trace when the vcpu is
destroyed and not also the very large number of events
that will happen for kvm_cpu_exec entry/exits.

If you look at the current set of events in accel/kvm/trace-events
you can see the general style: the tracepoint name itself
tells you the "what has happened", the arguments provide
more info (eg which CPU did we just destroy), and it's
rarely necessary to pass a string into the tracepoint function.

thanks
-- PMM

