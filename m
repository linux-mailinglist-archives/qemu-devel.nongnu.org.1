Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6656F7CC2A9
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:10:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsit4-0000Wb-4Z; Tue, 17 Oct 2023 08:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsit1-0000Vo-B7
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:09:23 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsisz-0000b8-FH
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:09:23 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53d82bea507so9732641a12.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697544559; x=1698149359; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZH0F3f+uCOPEXSYjYgewFnE5Faf1m9Z5ZRrf3gXOZSQ=;
 b=qmhn+M8QDs2IFeLjmU+OEaG9vz+JENgQNnH4g+/yN/c52f0/iEgNNNLkUuQS8a2c93
 wC6O2LpaUIpVfafqZyjCXUXvOyB8NPtSjiYO6jNGZrI35LLykLUUF9mWYT22Cr/1SQOY
 JWRRBA2a6SpUXancq3WSBHD3P7Cb3RVrsszy8Ck5/k05kAxg3/icuCIHdjfx6Q8RJwgV
 mujb6Q6CHaHKnHl2WKOWYLi2zpLKB4fj9VcPuNqrMyZCusBqoFUWXlo/UUY4kkHcjTiI
 5Ur8RAChdFqEkFM7fY8tR1cCWSSwYry7gt7zXFBfQj8mR/5ZNwziBFhk+2MUXjCVYOoA
 sR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697544559; x=1698149359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZH0F3f+uCOPEXSYjYgewFnE5Faf1m9Z5ZRrf3gXOZSQ=;
 b=xFXFJrUTyPSkkHxHH+AYiBIFN8QUjZuaf2HbTsMEspKRW+2MuFIbfzMVEdt6YMm4Sv
 Chbce/eBTKnGscJxHE4rG0ydscj9Wi69tcovubcXqpWrtnx/685U3nKkJ6gn9wRmJPuN
 pyWG3VjLM52CkqD+WwCSoPL2sxiJMkeYd3o/P4OSAkvxLj3cxT5sdG/G6i96e+59vzG/
 wS7fmP4cC8bMHhUV6lD6p+Dg3bSM2Z25OE9PT8pORf3DD9BAj6z3Ry/7QtD59FSqTW1x
 wpHGjBIo0Qz7Tb4EOrOm42/RBjri4BN9tm41pnMjIVqcBwutH7gpLRnPV8IP+6QxKEvN
 SgjQ==
X-Gm-Message-State: AOJu0Yxwg9wCBkmrE04ck72J2436Bt6keTEEKO1Kl2iZmtSksLGiJulQ
 DDV3oOtwe6OtbEd/sDOGr7ZocPsIehETn35cDTOrL5LIq+wIErXE
X-Google-Smtp-Source: AGHT+IE2K/jx6F/ccMe+2Nr4uzND2KYEgDenap1j6wu8HI14c9LkVAzKww/ddi7gIjkhtF68YjnF7I+dfY9RVUoPZh8=
X-Received: by 2002:a50:9e24:0:b0:53d:a0c9:dbd4 with SMTP id
 z33-20020a509e24000000b0053da0c9dbd4mr1427326ede.21.1697544559610; Tue, 17
 Oct 2023 05:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231010142453.224369-1-cohuck@redhat.com>
 <20231010142453.224369-4-cohuck@redhat.com>
In-Reply-To: <20231010142453.224369-4-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 13:09:08 +0100
Message-ID: <CAFEAcA88O-VDq2rRfVhZ_6OShFq1ANEMmHWHVtNS5hCPQNYtdg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm/kvm: convert to read_sys_reg64
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 10 Oct 2023 at 15:25, Cornelia Huck <cohuck@redhat.com> wrote:
>
> We can use read_sys_reg64 to get the SVE_VLS register instead of
> calling GET_ONE_REG directly.
>
> Suggested-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/arm/kvm64.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 558c0b88dd69..d40c89a84752 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -500,10 +500,6 @@ uint32_t kvm_arm_sve_get_vls(CPUState *cs)
>              .target = -1,
>              .features[0] = (1 << KVM_ARM_VCPU_SVE),
>          };
> -        struct kvm_one_reg reg = {
> -            .id = KVM_REG_ARM64_SVE_VLS,
> -            .addr = (uint64_t)&vls[0],
> -        };
>          int fdarray[3], ret;
>
>          probed = true;
> @@ -512,7 +508,7 @@ uint32_t kvm_arm_sve_get_vls(CPUState *cs)
>              error_report("failed to create scratch VCPU with SVE enabled");
>              abort();
>          }
> -        ret = ioctl(fdarray[2], KVM_GET_ONE_REG, &reg);
> +        ret = read_sys_reg64(fdarray[2], &vls[0], KVM_REG_ARM64_SVE_VLS);
>          kvm_arm_destroy_scratch_host_vcpu(fdarray);
>          if (ret) {
>              error_report("failed to get KVM_REG_ARM64_SVE_VLS: %s",

read_sys_reg64() asserts that the register you're trying to
read is 64 bits, but KVM_REG_ARM64_SVE_VLS is not, it's 512 bits:

#define KVM_REG_ARM64_SVE_VLS           (KVM_REG_ARM64 | KVM_REG_ARM64_SVE | \
                                         KVM_REG_SIZE_U512 | 0xffff)

So this change would trip the assert on a host where SVE
is supported and enabled.

thanks
-- PMM

