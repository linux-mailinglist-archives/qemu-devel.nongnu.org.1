Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2834928664
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jul 2024 12:08:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfqu-0005ou-0A; Fri, 05 Jul 2024 06:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfqs-0005oQ-AV
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:07:38 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfqp-0005at-8w
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:07:38 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a77c4309fc8so114993666b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720174053; x=1720778853; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3I58MnZMXrqowhLjtFic4a7xlF9J1HaX1eNCrjEIEIw=;
 b=E16A/RL1YcDVf+tqvCSXxlciQ3L+78vlcMysvJ7uk3lC7U9G0C9Md73MwhdROlLmuI
 bW4u0PXnRasRf/2a1hLfLn/gxrxia/u+BwXxqnsMSoLWqA3wZULbjeptLLG2IhWV10+F
 fliKAHRmi7afcFlUe1PU88EGqyRqtB7n13OJtQZnKsznYggMVPK0q/ioxwJaOT+oqjUX
 2d6OdAJJFhpw8eGlB0UJPStM4Ke4Z+o21xdsuP8T/goWTAiyP08Qsd8jlV23fObex9XJ
 iFpPFwuoY1NgzSxvnwDdPZ9mWk5Po9VfskuLba+MMHnXDE1P+m80ed0rXcOV1fhBVZB3
 jSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720174053; x=1720778853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3I58MnZMXrqowhLjtFic4a7xlF9J1HaX1eNCrjEIEIw=;
 b=UZn4TP/4q7IrqLH4/SEquQ7cejH8+tJ493sEUsE02IXdGPdyXrFcWSJGzDGs3XWAHt
 8CvRye+JvgCSK4EYjhgNiSo/ExmLU8VdZ7ABNv/xaMrAaDKL/CNtO72ezuvu9rNFYmTk
 A/23MU7N/+5f2tKgLpKWhyr1VbbrUlFXdpGDa+0qw2nveEQJWwX1ZgxKrZmjasmN4/8z
 hcWH+2C30oJb4RGnVdIybLQdxRVlQln1cFDawtCA2YZlig9Kx7baUPMssJXMhHle/zmu
 Du+M5XfaFd1j5rj2VBxCUlfUV7hPeu9XKue4wHyYEyUUswvrC+eRWCUGYQHVD8ZR5pAF
 Rgvw==
X-Gm-Message-State: AOJu0YxR/m/iw0SJaTqIYa3qMcMEj+nTO46pKGjDrP4NxLn/ZJI2/Q9h
 G/luKcKlwzow1Hkrw8bv0Rr5zGPw0cffjaK6O4gXzHqd8Pnbj6LwetRd7DwAFvIZsj50TvfhkB4
 PEtI+xRfq8pz+QA4dhS2QzTCwtj3Fqc5dBB7pRg==
X-Google-Smtp-Source: AGHT+IFFMaVK0V6IbB8OeY4xSmia7qYLCJR+m56rxWhxHL/6YjqYV28jjn1gLHFNpxmlE11ZdKCSttA4SfsoS3RnEno=
X-Received: by 2002:a17:907:7843:b0:a77:c976:2987 with SMTP id
 a640c23a62f3a-a77c97634c7mr118785466b.29.1720174052968; Fri, 05 Jul 2024
 03:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240705084047.857176-1-alex.bennee@linaro.org>
 <20240705084047.857176-36-alex.bennee@linaro.org>
In-Reply-To: <20240705084047.857176-36-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 5 Jul 2024 13:07:17 +0300
Message-ID: <CAAjaMXb5Gs_gcyxK3v+KSgFRyau=txggYX9KJorXcbKJjWU9PQ@mail.gmail.com>
Subject: Re: [PATCH v2 35/40] target/arm: Factor out code for setting MTE TCF0
 field
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Gustavo Romero <gustavo.romero@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x630.google.com
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

On Fri, 5 Jul 2024 at 11:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> From: Gustavo Romero <gustavo.romero@linaro.org>
>
> Factor out the code used for setting the MTE TCF0 field from the prctl
> code into a convenient function. Other subsystems, like gdbstub, need to
> set this field as well, so keep it as a separate function to avoid
> duplication and ensure consistency in how this field is set across the
> board.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Message-Id: <20240628050850.536447-7-gustavo.romero@linaro.org>
> [AJB: clean-up includes, move MTE defines]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> vAJB:
>   - clean-up includes, move MTE defines
> ---
>  linux-user/aarch64/mte_user_helper.h | 32 +++++++++++++++++++++++++
>  linux-user/aarch64/target_prctl.h    | 22 ++---------------
>  linux-user/aarch64/mte_user_helper.c | 35 ++++++++++++++++++++++++++++
>  linux-user/syscall.c                 |  9 -------
>  linux-user/aarch64/meson.build       |  2 ++
>  5 files changed, 71 insertions(+), 29 deletions(-)
>  create mode 100644 linux-user/aarch64/mte_user_helper.h
>  create mode 100644 linux-user/aarch64/mte_user_helper.c
>
> diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mt=
e_user_helper.h
> new file mode 100644
> index 0000000000..8685e5175a
> --- /dev/null
> +++ b/linux-user/aarch64/mte_user_helper.h
> @@ -0,0 +1,32 @@
> +/*
> + * ARM MemTag convenience functions.
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef AARCH64_MTE_USER_HELPER_H
> +#define AARCH64_MTE USER_HELPER_H
> +
> +#ifndef PR_MTE_TCF_SHIFT
> +# define PR_MTE_TCF_SHIFT       1
> +# define PR_MTE_TCF_NONE        (0UL << PR_MTE_TCF_SHIFT)
> +# define PR_MTE_TCF_SYNC        (1UL << PR_MTE_TCF_SHIFT)
> +# define PR_MTE_TCF_ASYNC       (2UL << PR_MTE_TCF_SHIFT)
> +# define PR_MTE_TCF_MASK        (3UL << PR_MTE_TCF_SHIFT)
> +# define PR_MTE_TAG_SHIFT       3
> +# define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)
> +#endif
> +
> +/**
> + * arm_set_mte_tcf0 - Set TCF0 field in SCTLR_EL1 register
> + * @env: The CPU environment
> + * @value: The value to be set for the Tag Check Fault in EL0 field.
> + *
> + * Only SYNC and ASYNC modes can be selected. If ASYMM mode is given, th=
e SYNC
> + * mode is selected instead. So, there is no way to set the ASYMM mode.
> + */
> +void arm_set_mte_tcf0(CPUArchState *env, abi_long value);
> +
> +#endif /* AARCH64_MTE_USER_HELPER_H */
> diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/targe=
t_prctl.h
> index aa8e203c15..ed75b9e4b5 100644
> --- a/linux-user/aarch64/target_prctl.h
> +++ b/linux-user/aarch64/target_prctl.h
> @@ -7,6 +7,7 @@
>  #define AARCH64_TARGET_PRCTL_H
>
>  #include "target/arm/cpu-features.h"
> +#include "mte_user_helper.h"
>
>  static abi_long do_prctl_sve_get_vl(CPUArchState *env)
>  {
> @@ -173,26 +174,7 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArc=
hState *env, abi_long arg2)
>      env->tagged_addr_enable =3D arg2 & PR_TAGGED_ADDR_ENABLE;
>
>      if (cpu_isar_feature(aa64_mte, cpu)) {
> -        /*
> -         * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
> -         *
> -         * The kernel has a per-cpu configuration for the sysadmin,
> -         * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
> -         * which qemu does not implement.
> -         *
> -         * Because there is no performance difference between the modes,=
 and
> -         * because SYNC is most useful for debugging MTE errors, choose =
SYNC
> -         * as the preferred mode.  With this preference, and the way the=
 API
> -         * uses only two bits, there is no way for the program to select
> -         * ASYMM mode.
> -         */
> -        unsigned tcf =3D 0;
> -        if (arg2 & PR_MTE_TCF_SYNC) {
> -            tcf =3D 1;
> -        } else if (arg2 & PR_MTE_TCF_ASYNC) {
> -            tcf =3D 2;
> -        }
> -        env->cp15.sctlr_el[1] =3D deposit64(env->cp15.sctlr_el[1], 38, 2=
, tcf);
> +        arm_set_mte_tcf0(env, arg2);
>
>          /*
>           * Write PR_MTE_TAG to GCR_EL1[Exclude].
> diff --git a/linux-user/aarch64/mte_user_helper.c b/linux-user/aarch64/mt=
e_user_helper.c
> new file mode 100644
> index 0000000000..a5b1c8503b
> --- /dev/null
> +++ b/linux-user/aarch64/mte_user_helper.c
> @@ -0,0 +1,35 @@
> +/*
> + * ARM MemTag convenience functions.
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu.h"
> +#include "mte_user_helper.h"
> +
> +void arm_set_mte_tcf0(CPUArchState *env, abi_long value)
> +{
> +    /*
> +     * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
> +     *
> +     * The kernel has a per-cpu configuration for the sysadmin,
> +     * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
> +     * which qemu does not implement.
> +     *
> +     * Because there is no performance difference between the modes, and
> +     * because SYNC is most useful for debugging MTE errors, choose SYNC
> +     * as the preferred mode.  With this preference, and the way the API
> +     * uses only two bits, there is no way for the program to select
> +     * ASYMM mode.
> +     */
> +    unsigned tcf =3D 0;
> +    if (value & PR_MTE_TCF_SYNC) {
> +        tcf =3D 1;
> +    } else if (value & PR_MTE_TCF_ASYNC) {
> +        tcf =3D 2;
> +    }
> +    env->cp15.sctlr_el[1] =3D deposit64(env->cp15.sctlr_el[1], 38, 2, tc=
f);
> +}
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e2804312fc..b8c278b91d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6281,15 +6281,6 @@ abi_long do_arch_prctl(CPUX86State *env, int code,=
 abi_ulong addr)
>  # define PR_GET_TAGGED_ADDR_CTRL 56
>  # define PR_TAGGED_ADDR_ENABLE  (1UL << 0)
>  #endif
> -#ifndef PR_MTE_TCF_SHIFT
> -# define PR_MTE_TCF_SHIFT       1
> -# define PR_MTE_TCF_NONE        (0UL << PR_MTE_TCF_SHIFT)
> -# define PR_MTE_TCF_SYNC        (1UL << PR_MTE_TCF_SHIFT)
> -# define PR_MTE_TCF_ASYNC       (2UL << PR_MTE_TCF_SHIFT)
> -# define PR_MTE_TCF_MASK        (3UL << PR_MTE_TCF_SHIFT)
> -# define PR_MTE_TAG_SHIFT       3
> -# define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)
> -#endif
>  #ifndef PR_SET_IO_FLUSHER
>  # define PR_SET_IO_FLUSHER 57
>  # define PR_GET_IO_FLUSHER 58
> diff --git a/linux-user/aarch64/meson.build b/linux-user/aarch64/meson.bu=
ild
> index 248c578d15..f75bb3cd75 100644
> --- a/linux-user/aarch64/meson.build
> +++ b/linux-user/aarch64/meson.build
> @@ -9,3 +9,5 @@ vdso_le_inc =3D gen_vdso.process('vdso-le.so',
>                                 extra_args: ['-r', '__kernel_rt_sigreturn=
'])
>
>  linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [vdso_be_inc, vdso_le=
_inc])
> +
> +linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [files('mte_user_help=
er.c')])
> --
> 2.39.2
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

