Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3FC7A5859
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 06:17:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiSAI-0000Nz-3s; Tue, 19 Sep 2023 00:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qiSAG-0000Nc-HD
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 00:16:44 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qiSAC-0007gM-S8
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 00:16:44 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7ab2270dfbcso86455241.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 21:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695096999; x=1695701799; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BGq4VgHB/ezj8okN9+iy59JyjDur6hvpfnk9Fey4+bM=;
 b=FWIbFHc7/T+R/iuS3AsHK0YoGp5Sh0DExSS9YZl9Af4yuWUkEFgiZJyK/apyHGiTcB
 tkYC/n+F7BWLg6iQqRHYOlAKe8niPMuvM2YLT3NV/a8AxeW0PaVAx95yX/mxNJ79xqkR
 JKWHD5XZj1eRiVEZccrdo9/7LZq2OB+3/mULhhzpO9q5vUNK3ZKXSqDi4c+KntPXHNX8
 XLXd/kAs0Zzjc+yKk+h6doBsC2hg+/MCvNfFeB6f9h5VD8QZZugoOrbvh7VW1EvjrZna
 pBA3RD7ofAn+iHzU0f2fCIGtewLrkDfuomCZjYPdtHQCJ+JQUFiFs15B7fSNLaX/z9SB
 +wfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695096999; x=1695701799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BGq4VgHB/ezj8okN9+iy59JyjDur6hvpfnk9Fey4+bM=;
 b=mJlQmEEFKfTKZ5gArHaRyNmV/gity2Y97F0J0k6kr8EsyUp1cB7kIf+i2RCL2M02XV
 MuavxfrOsHTjGSZbhMkDQL+4pxWHvm84VQuTnXWpHU1IBdUVZsnENny0EPKAfMgkWP2X
 mhoxtOLrxFdiEbKH4Vtql6jQa5l4+Oa17Fh91TBSmxZTxGIJkiiTQoDgOjjkzuxb5tuV
 1TezWjTpnlq/P0e2qYUR8ycyM7LTkQvv1Ixn8ZnWJL1yUekQJP4USnr20vfqxpMuIyEE
 9fnTg8B6boC3PZlqQWFg0HptNJYapbwesmINHN3p3PlX90m02ARnCDcg7bOZvqUfmHVM
 /gBg==
X-Gm-Message-State: AOJu0YxJhQ0VN7lZVs0PXa++hXcOYJKvsXXu2BllOWqbUwgZWxiJi3My
 VSYsy6PnbjQxx1BTGQ1iGpD1cqZmQ0C2xNUqtdjGo+1sOP29Qg==
X-Google-Smtp-Source: AGHT+IHJyYD/yYykSjeYkZ5QD9eejpl5KK6khR/3HsLbXkSWsSu8Ygg6rPleddphnoh0EzATUGNZnK99dN0nNCDM6dg=
X-Received: by 2002:a67:ec98:0:b0:44d:4fc0:3340 with SMTP id
 h24-20020a67ec98000000b0044d4fc03340mr8526594vsp.7.1695096999087; Mon, 18 Sep
 2023 21:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230913083728.16935-1-18622748025@163.com>
 <20230913091332.17355-1-18622748025@163.com>
In-Reply-To: <20230913091332.17355-1-18622748025@163.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Sep 2023 14:16:12 +1000
Message-ID: <CAKmqyKMzmQQc9zmjs1KzDDomRt1a+=RwmKwtMnW-bSxtwDnY_Q@mail.gmail.com>
Subject: Re: [PATCH v4] target/riscv: Clearing the CSR values at reset and
 syncing the MPSTATE with the host
To: "liguang.zhang" <18622748025@163.com>
Cc: qemu-devel@nongnu.org, "liguang.zhang" <liguang.zhang@hexintek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Sep 13, 2023 at 7:14=E2=80=AFPM liguang.zhang <18622748025@163.com>=
 wrote:
>
> From: "liguang.zhang" <liguang.zhang@hexintek.com>
>
> Fix the guest reboot error when using KVM
> There are two issues when rebooting a guest using KVM
> 1. When the guest initiates a reboot the host is unable to stop the vcpu
> 2. When running a SMP guest the qemu monitor system_reset causes a vcpu c=
rash
>
> This can be fixed by clearing the CSR values at reset and syncing the
> MPSTATE with the host.
>
> v4 update:
> rebase on riscv-to-apply
>
> Signed-off-by: liguang.zhang <liguang.zhang@hexintek.com>

I have fixed up some of the issues and applied this

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/kvm.c       | 42 ++++++++++++++++++++++++++++++++++++++++
>  target/riscv/kvm_riscv.h |  1 +
>  2 files changed, 43 insertions(+)
>
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index c01cfb03f4..8ee410b9b1 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -51,6 +51,8 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int=
 level)
>      kvm_set_irq(kvm_state, irq, !!level);
>  }
>
> +static bool cap_has_mp_state;
> +
>  static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
>                                   uint64_t idx)
>  {
> @@ -797,6 +799,24 @@ int kvm_arch_get_registers(CPUState *cs)
>      return ret;
>  }
>
> +int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
> +{
> +    if (cap_has_mp_state) {
> +        struct kvm_mp_state mp_state =3D {
> +            .mp_state =3D state
> +        };
> +
> +        int ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state=
);
> +        if (ret) {
> +            fprintf(stderr, "%s: failed to sync MP_STATE %d/%s\n",
> +                    __func__, ret, strerror(-ret));
> +            return -1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  int kvm_arch_put_registers(CPUState *cs, int level)
>  {
>      int ret =3D 0;
> @@ -816,6 +836,18 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>          return ret;
>      }
>
> +    if (KVM_PUT_RESET_STATE =3D=3D level) {
> +        RISCVCPU *cpu =3D RISCV_CPU(cs);
> +        if (cs->cpu_index =3D=3D 0) {
> +            ret =3D kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNN=
ABLE);
> +        } else {
> +            ret =3D kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_STOP=
PED);
> +        }
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
>      return ret;
>  }
>
> @@ -928,6 +960,7 @@ int kvm_arch_get_default_type(MachineState *ms)
>
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
> +    cap_has_mp_state =3D kvm_check_extension(s, KVM_CAP_MP_STATE);
>      return 0;
>  }
>
> @@ -1014,10 +1047,19 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
>      if (!kvm_enabled()) {
>          return;
>      }
> +    for (int i=3D0; i<32; i++)
> +        env->gpr[i] =3D 0;
>      env->pc =3D cpu->env.kernel_addr;
>      env->gpr[10] =3D kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
>      env->gpr[11] =3D cpu->env.fdt_addr;          /* a1 */
>      env->satp =3D 0;
> +    env->mie =3D 0;
> +    env->stvec =3D 0;
> +    env->sscratch =3D 0;
> +    env->sepc =3D 0;
> +    env->scause =3D 0;
> +    env->stval =3D 0;
> +    env->mip =3D 0;
>  }
>
>  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
> diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
> index de8c209ebc..8f8c1f969a 100644
> --- a/target/riscv/kvm_riscv.h
> +++ b/target/riscv/kvm_riscv.h
> @@ -27,5 +27,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64=
_t group_shift,
>                            uint64_t aplic_base, uint64_t imsic_base,
>                            uint64_t guest_num);
>  void riscv_kvm_aplic_request(void *opaque, int irq, int level);
> +int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
>
>  #endif
> --
> 2.41.0
>

