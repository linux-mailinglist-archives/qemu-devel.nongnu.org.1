Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4143774C973
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 03:18:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIfWk-0004kY-NK; Sun, 09 Jul 2023 21:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIfWi-0004kB-Mk
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 21:17:20 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIfWg-0003l2-OC
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 21:17:20 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-766b22593faso279441285a.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 18:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688951837; x=1691543837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xpItvjgZ9Z1B+hqALco8MqMyvN6/0bRo1NEc6L2e2pU=;
 b=CY0duINBY5vF8MOXfDOQNk8e7gdneZ2oHnSH7DIeUrq8q6ik9Rc2fW1osIqyzvXycr
 pRPMZC+mS7UyvyO9tRY3jwZsP+WKhDePyKgdodakS1fTRABj8Hg1RPqJeL2HMR+6EAfY
 CK6MF3Pzh5HQMSBBJWx0OpD2xxBVEX5n991TUJ5B4YdaWH4cwAHeVd60aqka53pBJXN7
 LSBEujlOSrjsSHUKq3ak5R5VXkakMukKJ5Iknyyx4cLbaNOUzM+B3rmlyaxzcQDnW0th
 kR4+W5gDxD3+aHLMp9kFvuxiLPLewTLxdeSkq1hQ6M8Ml7lRm5yNycrKXpF4NjMETXRR
 rX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688951837; x=1691543837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xpItvjgZ9Z1B+hqALco8MqMyvN6/0bRo1NEc6L2e2pU=;
 b=Y7rbqXpHlIIHnAY00UHZ5q+qpYFm0Wxlw2ldlSYeX1wd2bKdr3XefG9Sr5Mmf8CXdA
 CBBYMSNHbQLjoK4GWTkCCSb/RwVVolMucUFqTFtyzYLm+u2eBNFgKJ2SnjUWaFP8XFp6
 RHjop50LUN6GMwjpUseVHrGgl4MUazyUP1+Ypk7uU3EHYjAByD0pASpweNaFFPdcTj6m
 IyCKC84Cr2FJ3YBNeJx5W0SPbwsUyXnQ4J67GF1UcNKVqkKdhGCTthEVIAf57tUfSs/e
 x09d5uOyVz4uLvH5i84OyQfEyGjlrOSudbqVXRcaazyJQm5x/5hYy6ggBiGrOwU8fHV6
 k0Rg==
X-Gm-Message-State: ABy/qLaJIk/maRoad2/SpdCo546Vs4dgha9pyVX3P0tCzXYiRGC//jvw
 XUheCXQfmrV87ExN9wc+hZnMmsjVwX7vfaLXea8=
X-Google-Smtp-Source: APBJJlHRo7pw/K3OCgWq+vvZFE7AwprlLvSPdLPco3nu8skT6h50t2Z/0tCDBbb7LcBSTX8atjaWJxg8XfgJ+JQqGjA=
X-Received: by 2002:a05:620a:2588:b0:765:604f:3e7 with SMTP id
 x8-20020a05620a258800b00765604f03e7mr11002957qko.62.1688951837515; Sun, 09
 Jul 2023 18:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230625025018.26956-1-18622748025@163.com>
In-Reply-To: <20230625025018.26956-1-18622748025@163.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Jul 2023 11:16:51 +1000
Message-ID: <CAKmqyKN+USh-38Gzc3vGJYVAw9xThtqx2B8Nf1LAHbrNQ_=EDA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: fix the issue of guest reboot then no
 response or crash in kvm-mode
To: "liguang.zhang" <18622748025@163.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 "liguang.zhang" <liguang.zhang@hexintek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x72f.google.com
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

On Sun, Jun 25, 2023 at 12:50=E2=80=AFPM liguang.zhang <18622748025@163.com=
> wrote:
>
> From: "liguang.zhang" <liguang.zhang@hexintek.com>
>
> There are two issues when rebooting a guest using KVM
> 1. When the guest initiates a reboot the host is unable to stop the vcpu
> 2. When running a SMP guest the qemu monitor system_reset causes a vcpu c=
rash
>
> This can be fixed by clearing the CSR values at reset and syncing the
> MPSTATE with the host.

Thanks for the patch.

I think we should move everything

--- from here ---

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
> v3:
> - change kvm_riscv_set_mpstate_to_kvm to kvm_riscv_sync_mpstate_to_kvm
> - remove newline after if(cap_has_mp_state)
> - update submit description

--- to here ---

>
> Signed-off-by: liguang.zhang <liguang.zhang@hexintek.com>
> ---

below this line. That way it will be included in the patch submission,
but won't be included in the git tree.

We never include the patch changelog in the git tree and I don't think
we need to include the steps as well (they will be preserved on the
mailing list).

For the patch title (the git commit title) can you explain what the
patch is doing?

Also, do you mind rebasing on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Then the patch should be good to go!

Alistair

>  target/riscv/kvm.c       | 44 +++++++++++++++++++++++++++++++++++++++-
>  target/riscv/kvm_riscv.h |  1 +
>  2 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index 0f932a5b96..c478c71905 100644
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
> @@ -99,7 +101,7 @@ static uint64_t kvm_riscv_reg_id(CPURISCVState *env, u=
int64_t type,
>
>  #define KVM_RISCV_SET_TIMER(cs, env, name, reg) \
>      do { \
> -        int ret =3D kvm_set_one_reg(cs, RISCV_TIMER_REG(env, time), &reg=
); \
> +        int ret =3D kvm_set_one_reg(cs, RISCV_TIMER_REG(env, name), &reg=
); \
>          if (ret) { \
>              abort(); \
>          } \
> @@ -335,6 +337,24 @@ int kvm_arch_get_registers(CPUState *cs)
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
> @@ -354,6 +374,18 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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
> @@ -428,6 +460,7 @@ int kvm_arch_add_msi_route_post(struct kvm_irq_routin=
g_entry *route,
>
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
> +    cap_has_mp_state =3D kvm_check_extension(s, KVM_CAP_MP_STATE);
>      return 0;
>  }
>
> @@ -506,10 +539,19 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
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
> index ed281bdce0..88aee902dd 100644
> --- a/target/riscv/kvm_riscv.h
> +++ b/target/riscv/kvm_riscv.h
> @@ -21,5 +21,6 @@
>
>  void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
> +int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
>
>  #endif
> --
> 2.17.1
>

