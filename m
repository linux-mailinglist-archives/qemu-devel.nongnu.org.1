Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 980F07B3425
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:04:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmE4U-0001km-1w; Fri, 29 Sep 2023 10:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmE4P-0001k7-V8
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:02:17 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmE4N-0000R3-7B
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:02:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4065f29e933so5561725e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695996132; x=1696600932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sAIdIbFvos0KxuUIHlanJE0TWhN545trurRClOCKDZI=;
 b=phC6j+UoIHaFGkZJ79fjzV4TDo+G/71MaWH2oOkVOkUL/f0QDdf/6imZwmoMcJGp9k
 brTnQtkRJCpzUNUXlyHVPr9gvswVjHp6gqcHgrCgryW3VAKciQMvxoqAO4wvkLPuRppM
 GY89gHpgN5wYVdr6Pvl05EeqeNsLJRcAn0IpmAQ+/CW3M9gKC27364PyybAsXOynwc6/
 LBt2OtrDfhfol0bFMV6WUNgVIHavnMJYTKrBrYxs8ZZH/GELb6VDV1Sq7ZCbWFXz10Z1
 TIv/D0+/8fRNxw43DmBpk93Ird+oBawIdF8B56PMSuLAFRFbNTzcX6UZttseB9VhVSS3
 GINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695996132; x=1696600932;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sAIdIbFvos0KxuUIHlanJE0TWhN545trurRClOCKDZI=;
 b=u6Q71b3brXfybG1PwfyusFC4NdBD7kbiov2rTtH6xEkqYEOQAJIw2t+5nmfknefTJH
 3cwpS1JgGbTbd8Gxz1WISj1dz9kE7rlO6m9acjZxMUmCNt+B9xqevFLvKo5PmIo+hKom
 6yxZlboCVHEAldIAz4EeEHv/CcRA61vppgccXpO4XJGnRU5Dn3WmKkFHj1fhzLVq/BUj
 +qRCn+5IUZiZ6sEIR9S+PfRhEeKOkl/ZPsTqy7jIZgkL8Z+jS4uAbs+I2xEDD3G9/kFa
 Jg/3Jo1F5tgJlGQUfJ2Nk5I4v4k47EsT7IYIKlE1y5H5NjntGsgYL0Zm3tKAmH7ddtvJ
 V++g==
X-Gm-Message-State: AOJu0Yy3UKSLl7kUJ1rWeZIOG8HjMGuU+XhbSHIM8TmvYfp919AkkILG
 2TjEzLXW4CjMoAe4qPQ/lOw3gA==
X-Google-Smtp-Source: AGHT+IFHZR5ttssxLsmcZ9h+CJnnovHK2AzdgkoLF3OLXCjZpSiQTToxwNd0Ww3GsxEyi3aJX3sOVA==
X-Received: by 2002:a05:600c:2284:b0:403:e21:1355 with SMTP id
 4-20020a05600c228400b004030e211355mr3803703wmf.36.1695996131465; 
 Fri, 29 Sep 2023 07:02:11 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d4b09000000b0032008f99216sm21941446wrq.96.2023.09.29.07.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 07:02:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EEB5D1FFBB;
 Fri, 29 Sep 2023 15:02:09 +0100 (BST)
References: <20230929124304.13672-1-salil.mehta@huawei.com>
 <20230929124304.13672-2-salil.mehta@huawei.com>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 linuxarm@huawei.com
Subject: Re: [PATCH 1/9] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Date: Fri, 29 Sep 2023 14:32:11 +0100
In-reply-to: <20230929124304.13672-2-salil.mehta@huawei.com>
Message-ID: <877co9oz6m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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


Salil Mehta <salil.mehta@huawei.com> writes:

> KVM vCPU creation is done once during the initialization of the VM when Q=
emu
> threads are spawned. This is common to all the architectures.
>
> Hot-unplug of vCPU results in destruction of the vCPU objects in QOM but
> the KVM vCPU objects in the Host KVM are not destroyed and their represen=
tative
> KVM vCPU objects/context in Qemu are parked.
>
> Refactor common logic so that some APIs could be reused by vCPU Hotplug c=
ode.
>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  accel/kvm/kvm-all.c  | 61 ++++++++++++++++++++++++++++++++++----------
>  include/sysemu/kvm.h |  2 ++
>  2 files changed, 49 insertions(+), 14 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index ff1578bb32..57889c5f6c 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -137,6 +137,7 @@ static QemuMutex kml_slots_lock;
>  #define kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
>=20=20
>  static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
> +static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id);

weird to have a forward static declaration here if you are declare in
the header later on.

>=20=20
>  static inline void kvm_resample_fd_remove(int gsi)
>  {
> @@ -320,11 +321,51 @@ err:
>      return ret;
>  }
>=20=20
> +void kvm_park_vcpu(CPUState *cpu)
> +{
> +    unsigned long vcpu_id =3D cpu->cpu_index;

cpu_index is a plain int in CPUState:

    int cpu_index;

but is defined as an unsigned long in KVMParkedVcpu:

    unsigned long vcpu_id;

I'm not sure if this is just a historical anomaly but I suspect we
should fixup the discrepancy first so all users of cpu_index use the
same size.

> +    struct KVMParkedVcpu *vcpu;
> +
> +    vcpu =3D g_malloc0(sizeof(*vcpu));
> +    vcpu->vcpu_id =3D vcpu_id;
> +    vcpu->kvm_fd =3D cpu->kvm_fd;
> +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +}
> +
> +int kvm_create_vcpu(CPUState *cpu)
> +{

I don't think you get anything other than -1 on failure so at this point
you might as well return a bool.

> +    unsigned long vcpu_id =3D cpu->cpu_index;

Is this used?

> +    KVMState *s =3D kvm_state;
> +    int ret;
> +
> +    DPRINTF("kvm_create_vcpu\n");

Please don't add new DPRINTFs - use tracepoints instead. Whether its
worth cleaning up up kvm-all first I leave up to you.=20

> +    /* check if the KVM vCPU already exist but is parked */
> +    ret =3D kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
> +    if (ret > 0) {
> +        goto found;
> +    }
> +
> +    /* create a new KVM vCPU */
> +    ret =3D kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +found:
> +    cpu->vcpu_dirty =3D true;
> +    cpu->kvm_fd =3D ret;
> +    cpu->kvm_state =3D s;
> +    cpu->dirty_pages =3D 0;
> +    cpu->throttle_us_per_full =3D 0;
> +
> +    return 0;
> +}
> +

This is trivially nestable to avoid gotos:

  bool kvm_create_vcpu(CPUState *cpu)
  {
      unsigned long vcpu_id =3D cpu->cpu_index;
      KVMState *s =3D kvm_state;
      int ret;

      /* check if the KVM vCPU already exist but is parked */
      ret =3D kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
      if (ret < 0) {
          /* not found, try to create a new KVM vCPU */
          ret =3D kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
          if (ret < 0) {
              return false;
          }
      }

      cpu->vcpu_dirty =3D true;
      cpu->kvm_fd =3D ret;
      cpu->kvm_state =3D s;
      cpu->dirty_pages =3D 0;
      cpu->throttle_us_per_full =3D 0;

      return true;
  }

>  static int do_kvm_destroy_vcpu(CPUState *cpu)
>  {
>      KVMState *s =3D kvm_state;
>      long mmap_size;
> -    struct KVMParkedVcpu *vcpu =3D NULL;
>      int ret =3D 0;
>=20=20
>      DPRINTF("kvm_destroy_vcpu\n");
> @@ -353,10 +394,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>          }
>      }
>=20=20
> -    vcpu =3D g_malloc0(sizeof(*vcpu));
> -    vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
> -    vcpu->kvm_fd =3D cpu->kvm_fd;
> -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
> +    kvm_park_vcpu(cpu);
>  err:
>      return ret;
>  }
> @@ -384,7 +422,7 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vc=
pu_id)
>          }
>      }
>=20=20
> -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
> +    return -1;
>  }
>=20=20
>  int kvm_init_vcpu(CPUState *cpu, Error **errp)
> @@ -395,19 +433,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)

Hmm it looks like no one cares about the return value here and the fact
that callers use &error_fatal should be enough to exit. You can then
just return early and avoid the error ladder.

>=20=20
>      trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>=20=20
> -    ret =3D kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
> +    ret =3D kvm_create_vcpu(cpu);
>      if (ret < 0) {
> -        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed=
 (%lu)",
> +        error_setg_errno(errp, -ret,
> +                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
>                           kvm_arch_vcpu_id(cpu));
>          goto err;
>      }
>=20=20
> -    cpu->kvm_fd =3D ret;
> -    cpu->kvm_state =3D s;
> -    cpu->vcpu_dirty =3D true;
> -    cpu->dirty_pages =3D 0;
> -    cpu->throttle_us_per_full =3D 0;
> -
>      mmap_size =3D kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>      if (mmap_size < 0) {
>          ret =3D mmap_size;
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index ee9025f8e9..17919567a8 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -464,6 +464,8 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int si=
gmask_len);
>=20=20
>  int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>                                         hwaddr *phys_addr);
> +int kvm_create_vcpu(CPUState *cpu);
> +void kvm_park_vcpu(CPUState *cpu);

Please add kdoc comments for the public API functions describing their
usage and parameters.

>=20=20
>  #endif /* NEED_CPU_H */


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

