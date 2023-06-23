Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC2073AE80
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 04:17:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCWLG-0001br-Nx; Thu, 22 Jun 2023 22:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qCWL7-0001ba-2E
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 22:15:58 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qCWL5-0006Ps-B9
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 22:15:56 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-440ad406bc8so15131137.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 19:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687486554; x=1690078554;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrCaCM9H+8/tixEYlN1ml96xocI4N1Ipwi+pWWYBzTs=;
 b=Q/5r7xZrqbc0TIKXQyokIpFuTcjhjebe3Ulp+nhYRNk+CMVqJXDScPwy3n9RbZUTRT
 q/PBMJGNJbwb9wPcD1Nk7y5WQL+8Z/x4hf3RFb+5Xue39gnA8ce9MJ7Xw+sECH333IMD
 XGoLu0Nn/kXvfO9QR0LPIesSyro8Rqz0yNCxRvP1mNlnKtv25EE7goq0UIpMjIbo30HC
 08zZmkpzcu6XtEdrTVG2rd8PDbtKpPRd1HJAZNJFVzQuEBREUAtGbYS6KeKrbRmd2AvM
 EHpSOE01O2yURBv8aNvC5dWXXMnpJaRgRS4VMsjYfjbNoks4GRxzCU5iDqOSDO4RKM32
 UNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687486554; x=1690078554;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BrCaCM9H+8/tixEYlN1ml96xocI4N1Ipwi+pWWYBzTs=;
 b=JrEwTPkj+Ah14EDd9ZQhMTTup2wdlZ9xcwHwejRyPPRXcSW3EK609i3DTYQNAxIHKD
 s+PShNaHGfeuDTP1ly30V2nAGgSosR+rZb9Dwjw4nL2hqndBLDkAp4Ik7Hpz7qzi4aAj
 /K6/GW99FKVt2bwineF1XgOhdUaWlCEhcXjXWjWjY962NawBMSwNUCSPx6/h8fVYE8Tu
 tIS3x5jQxy8QKTEISsFyO6YbmH0sb6cvuv4QRKQMAcH7xtWUS+Cf5qsM/45gt/2H9Dof
 Yg/ZUu5HA/mp7kNxgtBpff17yV6AVmfczZ0mZhiKH0nBEp6JQkDG8TWqESfw5sCCYLb7
 246Q==
X-Gm-Message-State: AC+VfDyAsXL3MgHxlp64KSC/SQmUCuqYQ+1W5J5/IQ1s1RcKeOyoAzin
 r3JTCY+ia4TSKeWGNdnXXDEUJ2bBLnj+MLmDsLU=
X-Google-Smtp-Source: ACHHUZ5QmWCm9FAmp7x2qrGdXx3DcrNk8k55XXeFI1XVWx49BpwrxYVIfoRgr2kA842S0VJFXqSEld7EppleS5VGelw=
X-Received: by 2002:a67:fa0a:0:b0:43b:40e2:4031 with SMTP id
 i10-20020a67fa0a000000b0043b40e24031mr6889314vsq.7.1687486554068; Thu, 22 Jun
 2023 19:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230612110215.6955-1-18622748025@163.com>
In-Reply-To: <20230612110215.6955-1-18622748025@163.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Jun 2023 12:15:27 +1000
Message-ID: <CAKmqyKNGEdMQY44E-=uTdGcKatBis3Z0AOG8mUoqGGqr9aH2xQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: fix the issue of guest reboot then no
 response or crash in kvm-mode
To: "liguang.zhang" <18622748025@163.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 "liguang.zhang" <liguang.zhang@hexintek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
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

On Mon, Jun 12, 2023 at 11:07=E2=80=AFPM liguang.zhang <18622748025@163.com=
> wrote:
>
> From: "liguang.zhang" <liguang.zhang@hexintek.com>

Hello, thanks for the patch

>
> There have a issue of guest reboot bug in kvm-mode:
> 1. in guest shell just run the reboot, guest can't reboot success, and ho=
st kvm stop the vcpu schedual.
> 2. for smp guest, ctrl+a+c switch to qemu command, use system_reset comma=
nd to reset the guest, then vcpu crash

There are two issues when rebooting a guest using KVM
 1. When the guest initiates a reboot the host is unable to stop the vcpu
 2. When running a SMP guest the qemu monitor system_reset causes a vcpu cr=
ash

This can be fixed by clearing the CSR values at reset and syncing the
MPSTATE with the host.

>
> kernel log
> ```shell
> $reboot
>
> The system is going down NOW!
> Sent SIGTERM to all processes
> logout
> Sent SIGKILL to all processes
> Requesting system reboot
>
> ```
> then no response
>
> for qemu command:
> $system_reset:
>
> kernel log:
> ```shell
> [   53.739556] kvm [150]: VCPU exit error -95
> [   53.739563] kvm [148]: VCPU exit error -95
> [   53.739557] kvm [149]: VCPU exit error -95
> [   53.740957] kvm [149]: SEPC=3D0x0 SSTATUS=3D0x200004120 HSTATUS=3D0x20=
02001c0
> [   53.740957] kvm [148]: SEPC=3D0x0 SSTATUS=3D0x200004120 HSTATUS=3D0x20=
02001c0
> [   53.741054] kvm [148]: SCAUSE=3D0x14 STVAL=3D0x0 HTVAL=3D0x0 HTINST=3D=
0x0
> [   53.741058] kvm [149]: SCAUSE=3D0x14 STVAL=3D0x0 HTVAL=3D0x0 HTINST=3D=
0x0
> [   53.756187] kvm [150]: SEPC=3D0x0 SSTATUS=3D0x200004120 HSTATUS=3D0x20=
02001c0
> [   53.757797] kvm [150]: SCAUSE=3D0x14 STVAL=3D0x0 HTVAL=3D0x0 HTINST=3D=
0x0
> ```
>
> solution:
>
> add reset csr and context for riscv vcpu
> qemu ioctl reset vcpu->arch.power_off state of kvm
>
> tests:
>
> qemu-system-riscv64 -M virt -bios none -kernel Image \
>    -smp 4 -enable-kvm \
>    -append "rootwait root=3D/dev/vda ro" \
>    -drive file=3Drootfs.ext2,format=3Draw,id=3Dhd0 \
>    -device virtio-blk-device,drive=3Dhd0
>
> in guest shell:
> $reboot
>
> qemu command:
> $system_reset
>
> ---
> v2:
> - update submit description
>
> Signed-off-by: liguang.zhang <liguang.zhang@hexintek.com>
> ---
>  target/riscv/kvm.c       | 43 ++++++++++++++++++++++++++++++++++++++++
>  target/riscv/kvm_riscv.h |  1 +
>  2 files changed, 44 insertions(+)
>
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index 0f932a5b96..c6a7824c9e 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -42,6 +42,8 @@
>  #include "migration/migration.h"
>  #include "sysemu/runstate.h"
>
> +static bool cap_has_mp_state;
> +
>  static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
>                                   uint64_t idx)
>  {
> @@ -335,6 +337,25 @@ int kvm_arch_get_registers(CPUState *cs)
>      return ret;
>  }
>
> +int kvm_riscv_set_mpstate_to_kvm(RISCVCPU *cpu, int state)

This should probably be called:

kvm_riscv_sync_mpstate_to_kvm()

instead

> +{
> +    if (cap_has_mp_state) {
> +

No newline required

Otherwise the patch looks good

Alistair

> +        struct kvm_mp_state mp_state =3D {
> +            .mp_state =3D state
> +        };
> +
> +        int ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state=
);
> +        if (ret) {
> +            fprintf(stderr, "%s: failed to set MP_STATE %d/%s\n",
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
> @@ -354,6 +375,18 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>          return ret;
>      }
>
> +    if (KVM_PUT_RESET_STATE =3D=3D level) {
> +        RISCVCPU *cpu =3D RISCV_CPU(cs);
> +        if (cs->cpu_index =3D=3D 0) {
> +            ret =3D kvm_riscv_set_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNNA=
BLE);
> +        } else {
> +            ret =3D kvm_riscv_set_mpstate_to_kvm(cpu, KVM_MP_STATE_STOPP=
ED);
> +        }
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
>      return ret;
>  }
>
> @@ -428,6 +461,7 @@ int kvm_arch_add_msi_route_post(struct kvm_irq_routin=
g_entry *route,
>
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
> +    cap_has_mp_state =3D kvm_check_extension(s, KVM_CAP_MP_STATE);
>      return 0;
>  }
>
> @@ -506,10 +540,19 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
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
> index ed281bdce0..4a4c262820 100644
> --- a/target/riscv/kvm_riscv.h
> +++ b/target/riscv/kvm_riscv.h
> @@ -21,5 +21,6 @@
>
>  void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
> +int kvm_riscv_set_mpstate_to_kvm(RISCVCPU *cpu, int state);
>
>  #endif
> --
> 2.17.1
>
>

