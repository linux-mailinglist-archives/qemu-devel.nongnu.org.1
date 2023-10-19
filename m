Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E53CD7CFFB0
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 18:36:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtVzu-00061s-1o; Thu, 19 Oct 2023 12:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qtVzd-00060B-4Q; Thu, 19 Oct 2023 12:35:34 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qtVzZ-0000sv-Oo; Thu, 19 Oct 2023 12:35:28 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-57bc2c2f13dso4595117eaf.2; 
 Thu, 19 Oct 2023 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697733324; x=1698338124; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3raebs6EiNu4tLj/ikDhbtHjY7n1xUxZVwRvUY8oKTE=;
 b=KCcZfZodozjax6NamstI0iIxMpdMTjk5rLzgm15eHNdjf96KJwBafhWrdFaBBS/z9N
 Q2/m7AFMJqF+p5kNqgILKrQCoYqJdVot+6YdVIi20Xf2AXAUhubWJFgwAp1QsYLup1Sh
 +DfVkgckPZt3kfnQapTBAnYmPfIBC/xdQUQrE81qIkePGPQDlf+11hyWdE5QBktjsNKV
 Tmyf+3qhR/KEaIc7q06XGzONKLm3mRhkvO/sBzniul1Jztgra6ncbJn9bx60x3NSrVjt
 6gNzzKBoPe2EboncfExDggBgN7sQ9AdggoaykU0DV4XUm73rZkd7QcmhAOIQ5/RJ0Tds
 UIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697733324; x=1698338124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3raebs6EiNu4tLj/ikDhbtHjY7n1xUxZVwRvUY8oKTE=;
 b=r8oEYGQgkeDhgU4l/QDc2IUpE0FWOO2ovbzP6DKaNyfpFptUTCc4MsAPqJJVsrdFqZ
 g86KU89dCNlgC6NFqmEu4MOBmqi/ESaZ2MiQo8mx5qz7hiQQip0iwWzwtIJCp+cSlsxs
 w+Sunp8XDDS/clUZWmOjfOLfv68kUY7NQiTkgXgvcI6Xr9rt2D4tGoZzRmZucHP9ASlg
 AWqxa6kKFzbxLw2V3uLiFpvNR19nU/7W6ZyMyRVjlw/YPU4LYdoV8i3jN0inIEqSA+VF
 8BYYtkNJ9CmTzpIrGqhWotw8lznroRQ+wBJ3Nn6pNoWPGojgPkubx/w7LrTBz3rCwLVd
 eDrw==
X-Gm-Message-State: AOJu0YxwTdnoS2AwE/XTiuzmeWeLxjY783c8fdkI+vK+hhi2wbg2M8fA
 +MVBgTQJy7/U1+alaAG2T0jUu8F8fwBQpvE6u3Y=
X-Google-Smtp-Source: AGHT+IEnaHNoMJgOs0w7UWcdtxVoK+3reW4hnwcht/anxyY/9NC2lW5VuOab80BqZZRf1/l18Kz/SdxSMGfF5TolEUw=
X-Received: by 2002:a4a:a34d:0:b0:582:99ae:ca47 with SMTP id
 u13-20020a4aa34d000000b0058299aeca47mr2900266ool.3.1697733323948; Thu, 19 Oct
 2023 09:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231018130716.286638-1-thuth@redhat.com>
 <20231018130716.286638-7-thuth@redhat.com>
In-Reply-To: <20231018130716.286638-7-thuth@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 19 Oct 2023 09:35:12 -0700
Message-ID: <CAJSP0QXc1yeRYMaEZ_1cRc2d7_E2-vb7Ai4D2P0uRQYTqDqDsA@mail.gmail.com>
Subject: Re: [PULL 06/25] s390x/cpu topology: resetting the
 Topology-Change-Report
To: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-s390x@nongnu.org, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 18 Oct 2023 at 06:09, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Pierre Morel <pmorel@linux.ibm.com>
>
> During a subsystem reset the Topology-Change-Report is cleared
> by the machine.
> Let's ask KVM to clear the Modified Topology Change Report (MTCR)
> bit of the SCA in the case of a subsystem reset.
>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Message-ID: <20231016183925.2384704-7-nsg@linux.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/hw/s390x/cpu-topology.h |  1 +
>  target/s390x/cpu.h              |  1 +
>  target/s390x/kvm/kvm_s390x.h    |  1 +
>  hw/s390x/cpu-topology.c         | 11 +++++++++++
>  hw/s390x/s390-virtio-ccw.c      |  3 +++
>  target/s390x/cpu-sysemu.c       | 13 +++++++++++++
>  target/s390x/kvm/kvm.c          | 17 +++++++++++++++++
>  7 files changed, 47 insertions(+)
>
> diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topology.h
> index f95d26d37c..e33e7c66df 100644
> --- a/include/hw/s390x/cpu-topology.h
> +++ b/include/hw/s390x/cpu-topology.h
> @@ -56,6 +56,7 @@ static inline void s390_topology_setup_cpu(MachineState *ms,
>  #endif
>
>  extern S390Topology s390_topology;
> +void s390_topology_reset(void);

Please take a look at the following CI failure:

/usr/bin/ld: libqemu-s390x-softmmu.fa.p/hw_s390x_s390-virtio-ccw.c.o:
in function `subsystem_reset':
/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/build/../hw/s390x/s390-virtio-ccw.c:128:
undefined reference to `s390_topology_reset'

https://gitlab.com/qemu-project/qemu/-/jobs/5330218593

>
>  static inline int s390_std_socket(int n, CpuTopology *smp)
>  {
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 09bff39fe4..40c5cedd0e 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -654,6 +654,7 @@ typedef struct SysIBCPUListEntry {
>  QEMU_BUILD_BUG_ON(sizeof(SysIBCPUListEntry) != 16);
>
>  void insert_stsi_15_1_x(S390CPU *cpu, int sel2, uint64_t addr, uint8_t ar, uintptr_t ra);
> +void s390_cpu_topology_set_changed(bool changed);
>
>  /* MMU defines */
>  #define ASCE_ORIGIN           (~0xfffULL) /* segment table origin             */
> diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
> index f9785564d0..649dae5948 100644
> --- a/target/s390x/kvm/kvm_s390x.h
> +++ b/target/s390x/kvm/kvm_s390x.h
> @@ -47,5 +47,6 @@ void kvm_s390_crypto_reset(void);
>  void kvm_s390_restart_interrupt(S390CPU *cpu);
>  void kvm_s390_stop_interrupt(S390CPU *cpu);
>  void kvm_s390_set_diag318(CPUState *cs, uint64_t diag318_info);
> +int kvm_s390_topology_set_mtcr(uint64_t attr);
>
>  #endif /* KVM_S390X_H */
> diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
> index 13168341b6..7ec9319272 100644
> --- a/hw/s390x/cpu-topology.c
> +++ b/hw/s390x/cpu-topology.c
> @@ -90,6 +90,17 @@ static void s390_topology_init(MachineState *ms)
>                                              smp->books * smp->drawers);
>  }
>
> +/**
> + * s390_topology_reset:
> + *
> + * Generic reset for CPU topology, calls s390_topology_reset()
> + * to reset the kernel Modified Topology Change Record.
> + */
> +void s390_topology_reset(void)
> +{
> +    s390_cpu_topology_set_changed(false);
> +}
> +
>  /**
>   * s390_topology_cpu_default:
>   * @cpu: pointer to a S390CPU
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 7fe2bce20c..6012165d41 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -124,6 +124,9 @@ static void subsystem_reset(void)
>              device_cold_reset(dev);
>          }
>      }
> +    if (s390_has_topology()) {
> +        s390_topology_reset();
> +    }
>  }
>
>  static int virtio_ccw_hcall_notify(const uint64_t *args)
> diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
> index 8112561e5e..1cd30c1d84 100644
> --- a/target/s390x/cpu-sysemu.c
> +++ b/target/s390x/cpu-sysemu.c
> @@ -307,3 +307,16 @@ void s390_do_cpu_set_diag318(CPUState *cs, run_on_cpu_data arg)
>          kvm_s390_set_diag318(cs, arg.host_ulong);
>      }
>  }
> +
> +void s390_cpu_topology_set_changed(bool changed)
> +{
> +    int ret;
> +
> +    if (kvm_enabled()) {
> +        ret = kvm_s390_topology_set_mtcr(changed);
> +        if (ret) {
> +            error_report("Failed to set Modified Topology Change Report: %s",
> +                         strerror(-ret));
> +        }
> +    }
> +}
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 53d6300809..d6bda3a2a8 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -2664,6 +2664,23 @@ int kvm_s390_get_zpci_op(void)
>      return cap_zpci_op;
>  }
>
> +int kvm_s390_topology_set_mtcr(uint64_t attr)
> +{
> +    struct kvm_device_attr attribute = {
> +        .group = KVM_S390_VM_CPU_TOPOLOGY,
> +        .attr  = attr,
> +    };
> +
> +    if (!s390_has_feat(S390_FEAT_CONFIGURATION_TOPOLOGY)) {
> +        return 0;
> +    }
> +    if (!kvm_vm_check_attr(kvm_state, KVM_S390_VM_CPU_TOPOLOGY, attr)) {
> +        return -ENOTSUP;
> +    }
> +
> +    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attribute);
> +}
> +
>  void kvm_arch_accel_class_init(ObjectClass *oc)
>  {
>  }
> --
> 2.41.0
>
>

