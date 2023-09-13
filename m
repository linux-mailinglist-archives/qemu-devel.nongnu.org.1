Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8BE79E25B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:39:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgLOF-0005Jz-83; Wed, 13 Sep 2023 04:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <18622748025@163.com>)
 id 1qgLOD-0005Jc-3l
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:38:25 -0400
Received: from m12.mail.163.com ([220.181.12.199])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <18622748025@163.com>) id 1qgLO7-0001SI-Pm
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version:
 Content-Type; bh=whI2Ki7PMNBWiTCEJyk5Jn08eNCcOYGjzvryQHF9hM0=;
 b=LB4ZnQwuMwH7Du6coG+NDgPao68QnCklSfJY6x5GHkAId9UXUcUEmFTafT/D61
 3R+HKL+/RDufPpw0gCK+cb/BNg+QLtWpBqpyVJZ8pdlNJt3cpDkmQejPP/QYmBf7
 1Q34S0d+Fx5TVwgsW8DE1p6DV9IPoQkPJ5M7mg1C76bhw=
Received: from localhost.localdomain (unknown [218.69.55.90])
 by zwqz-smtp-mta-g1-3 (Coremail) with SMTP id _____wC3OznhdAFl6BDUBw--.5734S2; 
 Wed, 13 Sep 2023 16:37:54 +0800 (CST)
From: "liguang.zhang" <18622748025@163.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	"liguang.zhang" <liguang.zhang@hexintek.com>
Subject: Re: Re: [PATCH v3] target/riscv: Clearing the CSR values at reset and
 syncing the MPSTATE with the host
Date: Wed, 13 Sep 2023 16:37:12 +0800
Message-ID: <20230913083728.16935-1-18622748025@163.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CAKmqyKM1aAvdLssjtXfU6h+VptmMY7vhctrW6aSzQn4BCFiDPA@mail.gmail.com>
References: <CAKmqyKM1aAvdLssjtXfU6h+VptmMY7vhctrW6aSzQn4BCFiDPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3OznhdAFl6BDUBw--.5734S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wry5WFWfuF18tw1xXF4rGrg_yoW7Kr4fpF
 s3C3ZxCr4kJryxJw1SqF1DXFyrW3yFgF45Z3y2kryfA3Z0yrW5Jr4kKrWFkF98Cry0kr1Y
 9F45WF17ua1UtFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYKZJUUUUU=
X-Originating-IP: [218.69.55.90]
X-CM-SenderInfo: bpryljasxumiisv6il2tof0z/1tbivgjpWVZcitOkswAAsC
Received-SPF: pass client-ip=220.181.12.199; envelope-from=18622748025@163.com;
 helo=m12.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "liguang.zhang" <liguang.zhang@hexintek.com>

>  On Mon, Jul 24, 2023 at 2:26 AM liguang.zhang <18622748...@163.com> wrote:
>  >
>  > From: "liguang.zhang" <liguang.zh...@hexintek.com>
>  >
>  > Fix the guest reboot error when using KVM
>  > There are two issues when rebooting a guest using KVM
>  > 1. When the guest initiates a reboot the host is unable to stop the vcpu
>  > 2. When running a SMP guest the qemu monitor system_reset causes a vcpu crash
>  >
>  > This can be fixed by clearing the CSR values at reset and syncing the
>  > MPSTATE with the host.
>  >
>  > Signed-off-by: liguang.zhang <liguang.zh...@hexintek.com>
>  > ---
>  >  target/riscv/kvm.c       | 42 ++++++++++++++++++++++++++++++++++++++++
>  >  target/riscv/kvm_riscv.h |  1 +
>  >  2 files changed, 43 insertions(+)
>  >
>  > diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
>  > index 9d8a8982f9..ecc8ab8238 100644
>  > --- a/target/riscv/kvm.c
>  > +++ b/target/riscv/kvm.c
>  > @@ -44,6 +44,8 @@
>  >  #include "migration/migration.h"
>  >  #include "sysemu/runstate.h"
>  >
>  > +static bool cap_has_mp_state;
>  > +
>  >  static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
>  >                                   uint64_t idx)
>  >  {
>  > @@ -790,6 +792,24 @@ int kvm_arch_get_registers(CPUState *cs)
>  >      return ret;
>  >  }
>  >
>  > +int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
>  > +{
>  > +    if (cap_has_mp_state) {
>  > +        struct kvm_mp_state mp_state = {
>  > +            .mp_state = state
>  > +        };
>  > +
>  > +        int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
>  > +        if (ret) {
>  > +            fprintf(stderr, "%s: failed to sync MP_STATE %d/%s\n",
>  > +                    __func__, ret, strerror(-ret));
>  > +            return -1;
>  > +        }
>  > +    }
>  > +
>  > +    return 0;
>  > +}
>  > +
>  >  int kvm_arch_put_registers(CPUState *cs, int level)
>  >  {
>  >      int ret = 0;
>  > @@ -809,6 +829,18 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>  >          return ret;
>  >      }
>  >
>  > +    if (KVM_PUT_RESET_STATE == level) {
>  > +        RISCVCPU *cpu = RISCV_CPU(cs);
>  > +        if (cs->cpu_index == 0) {
>  > +            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNNABLE);
>  > +        } else {
>  > +            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_STOPPED);
>  > +        }
>  > +        if (ret) {
>  > +            return ret;
>  > +        }
>  > +    }
>  
>  You are adding code to kvm_arch_put_registers() don't you also need to
>  add code to kvm_arch_get_registers()? and a *_mpstate_to_qemu()
>  function to match?
>  
>  Alistair

I think don't need to add code to kvm_arch_get_registers, because i just add reset behavior 
to kvm_arch_put_registers, system reset will come to this point; this is just an suitable entry.
There is no code using when vcpu reset, qemu don't need to get register from vcpu.
According the reset logic of riscv, vcpu is just in pause state in kvm but not destroyed.
Just when qemu reset all system point, call in this entry, and sync vcpu power state and register state to kvm is ok.
And it don't need to modify kvm code to adapt with this change.

2 scenarios of reboot:
1. When a reboot executed from the guest's internal shell enters KVM through SBI, it sets all vcpu->arch.power_off to 'on,' effectively powering off all vCPUs
2. When QEMU issues 'system_reset,' it does not handle kvm's vcpu->arch.power_off; instead, it simply causes all vCPU threads to exit the KVM_RUN loop, effectively ending the ioctl(KVM_RUN) call. This behavior is similar to the guest shell reboot. This also explains why in non-SMP scenarios, 'system_reset' can perform a normal restart. Because the vCPU responsible for booting (boot_hart) remains powered on, it can be scheduled properly.so just to actively send a vCPU power-off command to KVM for vCPUs other than boot_hart, causing the vcpu->arch.power_off state of non-boot_hart vCPUs to return to 'on'
and boot_hart vcpu in kernel call up other vcpu by opensbi hsm_hart_start ecall to kvm hypervisor change the power_off state to off.

```log
$ reboot
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system reboot
[   90.660001] reboot: Restarting system
--------- all smp vcpu means paused not destroyed ------------------
vcpu csrs registers all in a intermediate state, and vcpu in power_off state
[just a kvm vcpu flag vcpu->arch.power_off=true]
---------------- qemu need at system reset point end stage call vcpu up and reset its registers csrs-------------

as this flow https://gitee.com/zhangliguang1/tuchuang/raw/master/img/20230913161603.png

qemu_system_reset
qemu_devices_reset
cpu_synchronize_all_post_reset
do_kvm_cpu_synchronize_post_reset
kvm_arch_put_registers(cpu, KVM_PUT_RESET_STATE)

```

Thanks~

from liguang.zhang@hexintek.com

>  
>  > +
>  >      return ret;
>  >  }
>  >
>  > @@ -909,6 +941,7 @@ int kvm_arch_add_msi_route_post(struct 
>  > kvm_irq_routing_entry *route,
>  >
>  >  int kvm_arch_init(MachineState *ms, KVMState *s)
>  >  {
>  > +    cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
>  >      return 0;
>  >  }
>  >
>  > @@ -987,10 +1020,19 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
>  >      if (!kvm_enabled()) {
>  >          return;
>  >      }
>  > +    for (int i=0; i<32; i++)
>  > +        env->gpr[i] = 0;
>  >      env->pc = cpu->env.kernel_addr;
>  >      env->gpr[10] = kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
>  >      env->gpr[11] = cpu->env.fdt_addr;          /* a1 */
>  >      env->satp = 0;
>  > +    env->mie = 0;
>  > +    env->stvec = 0;
>  > +    env->sscratch = 0;
>  > +    env->sepc = 0;
>  > +    env->scause = 0;
>  > +    env->stval = 0;
>  > +    env->mip = 0;
>  >  }
>  >
>  >  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
>  > diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
>  > index e3ba935808..3ea68c38e3 100644
>  > --- a/target/riscv/kvm_riscv.h
>  > +++ b/target/riscv/kvm_riscv.h
>  > @@ -22,5 +22,6 @@
>  >  void kvm_riscv_init_user_properties(Object *cpu_obj);
>  >  void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>  >  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
>  > +int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
>  >
>  >  #endif
>  > --
>  > 2.41.0
>  >


