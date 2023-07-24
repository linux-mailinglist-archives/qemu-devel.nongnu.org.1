Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4875F75EA14
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 05:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNmHj-0000SK-Mv; Sun, 23 Jul 2023 23:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qNmHh-0000Ro-6y
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 23:30:57 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qNmHe-0006CS-L5
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 23:30:56 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-79a23db59c3so93493241.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 20:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690169453; x=1690774253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qppPadwq3jYOcymvazK7wwjyzzJ8cyHitdE0JI5a81k=;
 b=o1MRhQJ8x90sDVvr531pJ8zx4VPxiBJ04viyEZhiHdzPvoLbqjJbj8fQpRoBeEeJW3
 NAxs/L7GW1WE5pz/sMtslQa90WQx4g4dfLCy39KR4tFttcGm1wujfxPvdu0Q+lnJbSh5
 HQHvGRWKgRR42aTRpKNUgaO7pg4agQirJX2wS8mtB0k4DHFXVtacUROAabQCYuz3Beem
 7+D1jNgE7PKiIeTOoWeUKGpYOhHsiLub6jzzKiejuFl+fuFHnwr3+TMe4m0UKvYQ7Kq6
 Tt8koG25L8fAE+L+CrJctCJFG3sJ46FX7Y1VM3LWxjYReYS0MIwb0vb7xSN9R2akvkYk
 CEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690169453; x=1690774253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qppPadwq3jYOcymvazK7wwjyzzJ8cyHitdE0JI5a81k=;
 b=BadXtuafEY57TDuGIvNDq7BlxArzVQH4QyvE5Upi7toZuPofBCKBYp/ltXLCRoIw/i
 O+HtfzM6PSt2ar5Zz91O4YtaBBHLeZaOe0OxOtbwrd7e1cOTKzZlAPP2cc91NLT2kC9O
 zz9DqE/KFnqzhRoT0iwy7Fae2ltAPSKKnYiGkXkvkcwHFsd+nUjLdR1ZY95Cqyur6muw
 aig7eCQ1lKTsy8lW8kYk0yj2nUvKkOUuiLmWFzlS3R5EAf+HvXIAY3sc9lVWhQMucxQR
 U2x9pp6i4L2AyImuS2/AqbFwuKTwVLtugH4o8c051qskwxtpItQI460C629zzEvGBBX+
 dC6w==
X-Gm-Message-State: ABy/qLbRZWjoGWUUNI621Ub9THOgGHFIE6IxGJ1/vfl5ZH4CMtQ9s7G9
 KvR9amD879h5LaQWnzBWxHfNPJQ4yCzHHWSLVyQ=
X-Google-Smtp-Source: APBJJlEE+E0cSfRwr9ayVu+Qm/S5UxE5+wV74H0SMJdQoBR+UBPfp8oX1qEPErNbxiPzearpZs/OlJYpb2nRa/4SQ5M=
X-Received: by 2002:a67:f717:0:b0:443:6b6b:36bb with SMTP id
 m23-20020a67f717000000b004436b6b36bbmr1423499vso.17.1690169453319; Sun, 23
 Jul 2023 20:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230625025018.26956-1-18622748025@163.com>
 <20230718122157.7425-1-18622748025@163.com>
In-Reply-To: <20230718122157.7425-1-18622748025@163.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Jul 2023 13:30:26 +1000
Message-ID: <CAKmqyKMLU-D6C2BA5LjDjKg_t-xAh9kg+WgmfRxkxDbtujkBBw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Clearing the CSR values at reset and
 syncing the MPSTATE with the host
To: "liguang.zhang" <18622748025@163.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 "liguang.zhang" <liguang.zhang@hexintek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jul 18, 2023 at 10:22=E2=80=AFPM liguang.zhang <18622748025@163.com=
> wrote:
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

Thanks!

When sending new versions of patches please increment the patch
version: https://www.qemu.org/docs/master/devel/submitting-a-patch.html#whe=
n-resending-patches-add-a-version-tag

The patch looks good, but don't we need an equivalent for the get register =
call?

Alistair

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
> 2.17.1
>

