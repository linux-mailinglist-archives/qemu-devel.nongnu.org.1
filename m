Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4509793F933
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Jul 2024 17:15:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYS4p-0003yZ-Pf; Mon, 29 Jul 2024 11:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYS4e-0003sU-AS
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:14:09 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYS4b-0005nH-GM
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:14:06 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5af51684d52so3301807a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266043; x=1722870843; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tXRCoLvUC43mCRcozMDDdTd1IZQkjbRsqylKzysvyww=;
 b=uBY6aSwSd8doQLiwe45wp926jHfORA0L8AP2NcuZtuwarp9+ng7rjyGYBO5SxfONNq
 flts/qxUQElkyzO40jQOkrraA4KFoujbp9gWUovWIvomYh4sO63+KxxbpToRqsrSARbz
 sh03eTwxTZxOhApWpf/Lofvpu/UTvNc/VyeHFssnmcBc8kF9JADCqKCRdAUzeqamGHz7
 JpUrioKgalWMmKN0WEYGAoW9mGAs1rN8DIw0N9lv1sNxKpqTIf3IweDwvueXDECYRlun
 wrJC/7OVhUiOsDHGDKF9nQqS4kdUxUFBVd+KdWVrHY+dg8z9dRLJJT1hwuT0PYOikc+Q
 xpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266043; x=1722870843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tXRCoLvUC43mCRcozMDDdTd1IZQkjbRsqylKzysvyww=;
 b=OEcVH7lKdaavUHrZDI90RD8tOUshLjbLiWCdFIEuocN5vi9EbVHcyyrD2fAkAW16zq
 NFUsrePu2UwVXVoNYChn25CSnMGiKlbWDB8vdk+XXY0f4fDQx/HE69bc8O/G8M7eiVUu
 EdSvM/dWCgd54+FIGvCgUdH81ZBGlO323Dy0lYmkMxhJGofDvgUATHUHZ5yFbgl4bogO
 s0xzydX8OKveOAWLBltwlpyep5kAL3f7LzB192Exvvqsm4wkpj1cEhB4HWmdqy+NAnEt
 vmssGgdoXaxFWscHAjCh3BOV8Qz1xRLmyoXTNrn1VHt98aPxZZPO2gLvusLZrtR0CSk6
 oV9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHzmkEWThTJlj8O6j0O0jQMwojKSnC3KYL8yPk4/S48Oix3W2hfu88i8XvbtJWn4FhzmIeEpJFapsf3GTqcUg8gT0a1eY=
X-Gm-Message-State: AOJu0YwIKzMYZ9uf/g48PkiqV5jRirFAyODJ5L7MkHttJOjM6JG6ghtm
 r75Vt/fL1nnW3bUBa1SotLhCKhikNC2HxgVIPcdhnkFuF+G+4GnoSJV2UlRWuanMgcGE0e0KV+s
 WwwWis3aVPUZovRf6dp1SQmXwzz7xP89i98O5HA==
X-Google-Smtp-Source: AGHT+IEs8iHg9e+bOR7W3CkBhHyHTd7gyVHiVEpROtEV8UlqIDIqwS8P6KwVB/1hSoNtpt6mIOAqLDchb0mgMZ5A8/k=
X-Received: by 2002:a50:cd18:0:b0:5a0:f8a2:9cf4 with SMTP id
 4fb4d7f45d1cf-5b022003a8fmr5356669a12.25.1722266043138; Mon, 29 Jul 2024
 08:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
 <20240720-pmu-v4-3-2a2b28f6b08f@daynix.com>
In-Reply-To: <20240720-pmu-v4-3-2a2b28f6b08f@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 16:13:52 +0100
Message-ID: <CAFEAcA_HWfCU09NfZDf6EC=rpvHn148avySCztQ8PqPBMFx4_Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] target/arm: Always add pmu property for Armv7-A/R+
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Sat, 20 Jul 2024 at 10:31, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> kvm-steal-time and sve properties are added for KVM even if the
> corresponding features are not available. Always add pmu property for
> Armv8. Note that the property is added only for Armv7-A/R+ as QEMU
> currently emulates PMU only for such versions, and a different
> version may have a different definition of PMU or may not have one at
> all.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  target/arm/cpu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 19191c239181..c1955a82fb3c 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1741,6 +1741,10 @@ void arm_cpu_post_init(Object *obj)
>
>      if (!arm_feature(&cpu->env, ARM_FEATURE_M)) {
>          qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_hivecs_property);
> +
> +        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
> +            object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
> +        }

Not every V7 CPU has a PMU[*]. Unfortunately for PMUv1 the
architecture did not define an ID register field for it,
so there's no ID field you can look at to distinguish
"has PMUv1" from "has no PMU". (For PMUv2 and later you
can look at ID_DFR0 bits [27:24]; or for AArch64
ID_AA64DFR0_EL1.PMUVer.) This is why we have the
ARM_FEATURE_PMU feature bit. So the correct way to determine
"does this CPU have a PMU and so it's OK to add the 'pmu'
property" is to look at ARM_FEATURE_PMU. Which is what
we already do.

Alternatively, if you want to make the property always
present even on CPUs where it can't be set, you need
to have some mechanism for having the user's attempt to
enable it fail. But mostly for Arm at the moment we
have properties which are only present when they're
meaningful. (I'm not opposed to changing this -- it would
arguably be cleaner to have properties be per-class,
not per-object, to aid in introspection. But it's a big
task and probably not easy.)

[*] It happens that all the v7 CPUs that QEMU currently
models do have at least a PMUv1, but that's not an
architectural requirement.

thanks
-- PMM

