Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 000E0770711
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 19:28:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRyZt-0007vi-Us; Fri, 04 Aug 2023 13:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRyZs-0007vY-Aj
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:27:04 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRyZq-0004QF-PG
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:27:04 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5221c6a2d3dso2992596a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691170021; x=1691774821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t0nTOeFqnFzKnRnAXx88oyJs4DA0yn0GoPkWdFMCgC4=;
 b=NnbURue9QVpbCAE6+MyqLRHPNIAYc3jnsxxUWAn1hNTR523mEqOhomdRB+QV5vKg8y
 hWAD+Kl6pcZGFnJuUzufsnFqHcwCqyaUncLztoFqyY6AiGMsGj/kv3MbJmSmOcqDqt8r
 dMdS6/gGEwb/uFNviF5mrNqoFe242pm/PuCccQsoSiBsmHqUqrkuqSMYmbsiF/JlYo8G
 eCG6hW5uyrWN/NVJz5eo9amz5pU25QNonY9L9aJ/vwjeAbLoFdedeO0LaNMpCoQDH+3K
 LhdIxvwpQMDXFlnDGVx3oEUmv+D0kfmT06YDxPqxup6HARxJghQsVHCEBsHJSjLxife/
 Accg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691170021; x=1691774821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t0nTOeFqnFzKnRnAXx88oyJs4DA0yn0GoPkWdFMCgC4=;
 b=ahCWYsGCdBaB1sojDpP0oKudESzKKpcZpI37auJa7hgQEvflHKndPTjoNLEBeiDgsv
 /yvSaf49aWW35fXupzIe7a9XVP9ORcuz+33SQYZYJnayyPA/44d1dwt7aCE2tMuBEC9T
 s27nJJrUejq1SffcdRcLMn5xFO21Pn6ID/W2yEvd0kXrJ+OIQdj1TRHDZOl+zXcJ/2at
 c+cL9rACDY9FCTlw5hLyE3K1O5bBYRHcRQvOXP1MPStjxN6z4aEQJQjDxlf4HwVPHtLK
 n/UOv7MkVtXAhd0fFRH/qH2UJ3Wl+O+3WvgTI6+2PWafx8ClzhQc5msNbso30VP1Iykv
 TlCg==
X-Gm-Message-State: AOJu0YykKDil2DQbWmp5zD485JYXo+nYNZLu6IKDhf/CBDZ6ChpR9En7
 vMM+gYThf8pWHRCRGpld1Qa1Qg5/8xzsqEZaS3UMUw==
X-Google-Smtp-Source: AGHT+IGGWvPwHXlthmbhmT9sSh+Oh6pYUSZ5Z0MssLXkPyAueXQTUFZUTTOC03AofxhRHW5idyqmiSmCxgL2o0+a2hQ=
X-Received: by 2002:aa7:c383:0:b0:522:219b:ce05 with SMTP id
 k3-20020aa7c383000000b00522219bce05mr2343717edq.7.1691170021093; Fri, 04 Aug
 2023 10:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
 <20230727073134.134102-2-akihiko.odaki@daynix.com>
In-Reply-To: <20230727073134.134102-2-akihiko.odaki@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 18:26:49 +0100
Message-ID: <CAFEAcA_26e2G_qLA8DEcv74MADgquhiVkWEZkh_wL0+JxAf91Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] kvm: Introduce kvm_arch_get_default_type hook
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 27 Jul 2023 at 08:31, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> kvm_arch_get_default_type() returns the default KVM type. This hook is
> particularly useful to derive a KVM type that is valid for "none"
> machine model, which is used by libvirt to probe the availability of
> KVM.
>
> For MIPS, the existing mips_kvm_type() is reused. This function ensures
> the availability of VZ which is mandatory to use KVM on the current
> QEMU.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/sysemu/kvm.h     | 2 ++
>  target/mips/kvm_mips.h   | 9 ---------
>  accel/kvm/kvm-all.c      | 4 +++-
>  hw/mips/loongson3_virt.c | 2 --
>  target/arm/kvm.c         | 5 +++++
>  target/i386/kvm/kvm.c    | 5 +++++
>  target/mips/kvm.c        | 2 +-
>  target/ppc/kvm.c         | 5 +++++
>  target/riscv/kvm.c       | 5 +++++
>  target/s390x/kvm/kvm.c   | 5 +++++
>  10 files changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 115f0cca79..ccaf55caf7 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -369,6 +369,8 @@ int kvm_arch_get_registers(CPUState *cpu);
>
>  int kvm_arch_put_registers(CPUState *cpu, int level);
>
> +int kvm_arch_get_default_type(MachineState *ms);
> +

New global functions should have a doc comment that explains
what they do, what their API is, etc. For instance, is
this allowed to return an error, and if so, how ?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

