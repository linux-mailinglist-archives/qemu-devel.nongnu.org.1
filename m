Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D377804A
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 20:35:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUAUS-0004oa-6s; Thu, 10 Aug 2023 14:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qUAUQ-0004oR-4R
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:34:30 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qUAUN-000723-NH
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:34:29 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4475fc33c8dso547498137.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 11:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691692466; x=1692297266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=18GqwBlo0k7QwyNQPHQYW74FKAbwwxeNEUkkPxBmBVg=;
 b=IZ6g61FPFxaIu8JYenLT1HltZTp8ZiOFlEFwvA7/qaaArNNTdjwawC5eshGgizhIPI
 FpvHzLx899sLbgSqs0G4PpszKo1Hi1kxIXpJz+aQmbAXH4sBMGhVwft753j/IGJ/kX+d
 PjjKIQwJ0R8spYjjo1deFuleL5LOzYN58qB+usuv7r+ro+eTYwYYZM9s3IUZiMfiiMti
 gG7gJTN2OFPKpXHLhV46VZvQLe9LQoH4qkHIFAOW4OQgi23AAWh/5wdE/hp1v78/DxA8
 7f4sBtWbU0iRSBkHq96TU5i0stVewq4UQXsPmYs2Bm+3A8V5tVv1LDiVlvNTPeVWMXK/
 ziCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691692466; x=1692297266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=18GqwBlo0k7QwyNQPHQYW74FKAbwwxeNEUkkPxBmBVg=;
 b=hv0DYfOn8aa3N/ZHF9VvBzDjNiBVlSGjDleOmHZAa5HegnFU7n9PhI9IYKXBWOzKmj
 d0tvxPpZnKOGieK3rrJJW6I2RPty9nHhoeOUXKGFGtHSCMV4MGJCNI2IPdNorxg9hiqK
 Ep32GF/Z23KSQcjZF9FwBkTEgUkPqBSP5Hx7Va5C/tN4eqW+qAuBj4Fu3PW2z97KZ3ml
 qrtZt+ym4wVZHm84zjzgPMZyqQerGbZBQk5hICridShtCi5flru1cKq6sSXP4pNf/vUI
 50+ELVpkmPqMr+yKWyQQAGna8qyh2INx2KSuRhEzJXcc6nboDZwAt579/ZMph16Eqwar
 4iEw==
X-Gm-Message-State: AOJu0YzyzwIxjZENjFZwQrJTMBr6NiBsUyJEs3j0tXNltQJvGJqz/A65
 rtD/RXijJcoJVZISEpNI0ukyqJOPTLmRE7rU9YU=
X-Google-Smtp-Source: AGHT+IEOuT5kTusjvqeKqrZ114O1hsvAUMwC21wUM9wr4KTamaYaDuBygpEwDAqtIkzqsMTdv2DrJdNu8wSkmoS2yR4=
X-Received: by 2002:a05:6102:249:b0:444:c644:c231 with SMTP id
 a9-20020a056102024900b00444c644c231mr2596899vsq.12.1691692466438; Thu, 10 Aug
 2023 11:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMLU-D6C2BA5LjDjKg_t-xAh9kg+WgmfRxkxDbtujkBBw@mail.gmail.com>
 <20230724062534.5634-1-18622748025@163.com>
In-Reply-To: <20230724062534.5634-1-18622748025@163.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 10 Aug 2023 14:34:00 -0400
Message-ID: <CAKmqyKM1aAvdLssjtXfU6h+VptmMY7vhctrW6aSzQn4BCFiDPA@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: Clearing the CSR values at reset and
 syncing the MPSTATE with the host
To: "liguang.zhang" <18622748025@163.com>
Cc: qemu-devel@nongnu.org, "liguang.zhang" <liguang.zhang@hexintek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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

On Mon, Jul 24, 2023 at 2:26=E2=80=AFAM liguang.zhang <18622748025@163.com>=
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
> Signed-off-by: liguang.zhang <liguang.zhang@hexintek.com>
> ---
>  target/riscv/kvm.c       | 42 ++++++++++++++++++++++++++++++++++++++++
>  target/riscv/kvm_riscv.h |  1 +
>  2 files changed, 43 insertions(+)
>
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index 9d8a8982f9..ecc8ab8238 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -44,6 +44,8 @@
>  #include "migration/migration.h"
>  #include "sysemu/runstate.h"
>
> +static bool cap_has_mp_state;
> +
>  static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
>                                   uint64_t idx)
>  {
> @@ -790,6 +792,24 @@ int kvm_arch_get_registers(CPUState *cs)
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
> @@ -809,6 +829,18 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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

You are adding code to kvm_arch_put_registers() don't you also need to
add code to kvm_arch_get_registers()? and a *_mpstate_to_qemu()
function to match?

Alistair

> +
>      return ret;
>  }
>
> @@ -909,6 +941,7 @@ int kvm_arch_add_msi_route_post(struct kvm_irq_routin=
g_entry *route,
>
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
> +    cap_has_mp_state =3D kvm_check_extension(s, KVM_CAP_MP_STATE);
>      return 0;
>  }
>
> @@ -987,10 +1020,19 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
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
> index e3ba935808..3ea68c38e3 100644
> --- a/target/riscv/kvm_riscv.h
> +++ b/target/riscv/kvm_riscv.h
> @@ -22,5 +22,6 @@
>  void kvm_riscv_init_user_properties(Object *cpu_obj);
>  void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
> +int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
>
>  #endif
> --
> 2.41.0
>

