Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D987B35D9
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:37:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEbo-0003il-I1; Fri, 29 Sep 2023 10:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmEbj-0003ib-GN
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:36:43 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmEbg-0001j2-UH
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:36:42 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32336a30d18so6121975f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 07:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695998196; x=1696602996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SmDAjxmm2LwlwG20fJcXE8Lylep/9XkaH1s2bFo745Y=;
 b=Cr9DimB3dEM/oPSEgrOmpO1Eee8JHn0pUbErR9nWpl11Cgm6Tf90m7wYW46U9YyoZ4
 LsQSirMbWxpYprruC3NRgVVTq67HcWbken1/GTetG9SLTrAa72bqDeRzXZuM8wCJaug9
 UBKJcLRJ+oEsp0W2mfaOg1TF+0TK8BIi7OyT77nqJiRtLSLsuHHuzq9uTCJ6B9o7qo0E
 eXDZ8MwXPaNzKgiLocain5jaZ2fORSWwbxbgFUex17tLOCc90SV8bEKcDgZNsrS9JVxT
 KgfTtk57CFGOYUTW+eZXpoRnd1VJYOkfXK5SDTTV2fsOYVnPaP1Kf/PUYii0QQHdJQuW
 dlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695998196; x=1696602996;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SmDAjxmm2LwlwG20fJcXE8Lylep/9XkaH1s2bFo745Y=;
 b=D5iHYbi7tFM1lYUoXWFT9rMl1SH1FmWtKHZnvCS7CEpAf220XAAIkNBujLuyATD9II
 TPIC4617NcHgCZ90ixbIICeDamP4iToaRyu/5XKLn0ehGIolncvfkNdS6+sYyPDJXdLo
 zgdHYA0qpuiYGkffF62xZe/dIcxdLzgXiOK0R0m97OBFDNH5PKpaZTtiw5ReOsLRB1wF
 lmgkmqthm80JK4sk4G1pV9/t98iIhMRvRnpz8zMa43xTS5bTW/j6AL8BCWIual2hB+vD
 o7cOJakiP02gKtgevda+2lxzW4PEj8Ysk6BbQHMitSZSdK/NAxa32gEchUWENhZgQIor
 J2IA==
X-Gm-Message-State: AOJu0YyAz8N4B6RoCM3YgpT7szi/GUq+UHXvT8P+LnaOByj4Zuhhw1WG
 rITdkQnJNbk9kiT3g6yqxLv3xw==
X-Google-Smtp-Source: AGHT+IGZnsrJcqzHoWz90uYXiPFTjcjdVBYEXVsnW8N9GjxGHicqXoUv38ONZx3g4Pfg01ENLp771g==
X-Received: by 2002:a5d:500b:0:b0:321:5d87:5f7c with SMTP id
 e11-20020a5d500b000000b003215d875f7cmr3939135wrt.30.1695998196154; 
 Fri, 29 Sep 2023 07:36:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a5d6404000000b003176aa612b1sm8885804wru.38.2023.09.29.07.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 07:36:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EA2DC1FFBB;
 Fri, 29 Sep 2023 15:36:34 +0100 (BST)
References: <20230929124304.13672-1-salil.mehta@huawei.com>
 <20230929124304.13672-9-salil.mehta@huawei.com>
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
Subject: Re: [PATCH 8/9] physmem,gdbstub: Add helper functions to help
 *unrealize* vCPU object
Date: Fri, 29 Sep 2023 15:34:38 +0100
In-reply-to: <20230929124304.13672-9-salil.mehta@huawei.com>
Message-ID: <87ttrdnj0t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

> vCPU Hot-unplug requires some helper functions to unroll what has happened
> during realization of a CPU object.
>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  gdbstub/gdbstub.c         | 13 +++++++++++++
>  include/exec/cpu-common.h |  8 ++++++++
>  include/exec/gdbstub.h    |  1 +
>  include/hw/core/cpu.h     |  1 +
>  softmmu/physmem.c         | 25 +++++++++++++++++++++++++
>  5 files changed, 48 insertions(+)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 349d348c7b..a06ea3adad 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -491,6 +491,19 @@ void gdb_register_coprocessor(CPUState *cpu,
>      }
>  }
>=20=20
> +void gdb_unregister_coprocessor_all(CPUState *cpu)
> +{
> +    GDBRegisterState *s, *p;
> +
> +    p =3D cpu->gdb_regs;
> +    while (p) {
> +        s =3D p;
> +        p =3D p->next;

Maybe add:

      /* s->xml is static const char so isn't freed */

> +        g_free(s);
> +    }
> +    cpu->gdb_regs =3D NULL;
> +}
> +
>  static void gdb_process_breakpoint_remove_all(GDBProcess *p)
>  {
>      CPUState *cpu =3D gdb_get_first_cpu_in_process(p);
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 41788c0bdd..eb56a228a2 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -120,6 +120,14 @@ size_t qemu_ram_pagesize_largest(void);
>   */
>  void cpu_address_space_init(CPUState *cpu, int asidx,
>                              const char *prefix, MemoryRegion *mr);
> +/**
> + * cpu_address_space_destroy:
> + * @cpu: CPU for which address space needs to be destroyed
> + * @asidx: integer index of this address space
> + *
> + * Note that with KVM only one address space is supported.
> + */
> +void cpu_address_space_destroy(CPUState *cpu, int asidx);
>=20=20
>  void cpu_physical_memory_rw(hwaddr addr, void *buf,
>                              hwaddr len, bool is_write);
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 16a139043f..986d8d2fa5 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -27,6 +27,7 @@ typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_=
t *buf, int reg);
>  void gdb_register_coprocessor(CPUState *cpu,
>                                gdb_get_reg_cb get_reg, gdb_set_reg_cb set=
_reg,
>                                int num_regs, const char *xml, int
>  g_pos);

Can we have a kdoc comment here describing the function.

I suspect this should be split into two patches, one for gdbstub and one
for physmem.

> +void gdb_unregister_coprocessor_all(CPUState *cpu);
>=20=20
>  /**
>   * gdbserver_start: start the gdb server
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 648b5b3586..65d2ae4581 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -355,6 +355,7 @@ struct CPUState {
>      QSIMPLEQ_HEAD(, qemu_work_item) work_list;
>=20=20
>      CPUAddressSpace *cpu_ases;
> +    int cpu_ases_count;
>      int num_ases;
>      AddressSpace *as;
>      MemoryRegion *memory;
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 4f6ca653b3..4dfa0ca66f 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -761,6 +761,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>=20=20
>      if (!cpu->cpu_ases) {
>          cpu->cpu_ases =3D g_new0(CPUAddressSpace, cpu->num_ases);
> +        cpu->cpu_ases_count =3D cpu->num_ases;
>      }
>=20=20
>      newas =3D &cpu->cpu_ases[asidx];
> @@ -774,6 +775,30 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>      }
>  }
>=20=20
> +void cpu_address_space_destroy(CPUState *cpu, int asidx)
> +{
> +    CPUAddressSpace *cpuas;
> +
> +    assert(asidx < cpu->num_ases);
> +    assert(asidx =3D=3D 0 || !kvm_enabled());
> +    assert(cpu->cpu_ases);
> +
> +    cpuas =3D &cpu->cpu_ases[asidx];
> +    if (tcg_enabled()) {
> +        memory_listener_unregister(&cpuas->tcg_as_listener);
> +    }
> +
> +    address_space_destroy(cpuas->as);
> +    g_free_rcu(cpuas->as, rcu);
> +
> +    if (cpu->cpu_ases_count =3D=3D 1) {
> +        g_free(cpu->cpu_ases);
> +        cpu->cpu_ases =3D NULL;
> +    }
> +
> +    cpu->cpu_ases_count--;
> +}
> +
>  AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
>  {
>      /* Return the AddressSpace corresponding to the specified index */


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

