Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 972B67097C5
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 14:56:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzzeG-0005us-Co; Fri, 19 May 2023 08:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzzeE-0005uh-SI
 for qemu-devel@nongnu.org; Fri, 19 May 2023 08:55:54 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzzeC-00086C-Ar
 for qemu-devel@nongnu.org; Fri, 19 May 2023 08:55:54 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-309550263e0so707465f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684500950; x=1687092950;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBIqLim6p5VHXPqB1YrJvJbJLPEU81DizMt3o09VBbA=;
 b=BQS6It+FzlQ/RMdsLprYZzRMjcbGRbNupptdRzvkOCKCQUV0MBgOVYc0uCoFRpsjpD
 DREYtB9SRAU15FqNpPsDjLobKYiKfsoUmU2q3hZlfFWRP+gaAhKJh458MbMZ2pmxOpz6
 Gap+r2LdC/GVS0lCa1ow43/N97DvBRLXsAkJ6nan8OAbFVpXXvDAZD2SPKIEe4o7JrDP
 qHOLDb2BXjeENBAemFnP7CMEuOuDQ5zqTDnw1Sj/TbigTqK+IvbqgKryh6shAsUcQCQ7
 hD/+W2M04WT/IsnkBJDsROQsnZRZegkn4KMAAJXQ4lnyPyX21dlZy2pLXh8l1lZpQzQ0
 ZEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684500950; x=1687092950;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HBIqLim6p5VHXPqB1YrJvJbJLPEU81DizMt3o09VBbA=;
 b=glweGJS6a+HMDCCR3PTlezjYtnMK16KVnPylA9PpnVjD4yX1tThCeOOEXSq0GK04Kw
 3uFr+q1oMlUSEMPkGyWkp4Ic6ROD4W5Vqk0rk8uTt1FsnvioExsIW1DvQDdaU0oxJxT5
 34rbVlBYSt7h7xdCbZFZQfj1237lANBWPnT9+eX2+i3nPNeYfmRiV8aH+vWfDnC/u0/e
 sFvo1/A6bnSdQxOi0hL/M+uXc9wE5SGzFhJYni8o6sfSO/hTTFJyY6qUUpG4MNVm2x4m
 +qe78AJWC8YuWtYy3bI/8PnLrbvPXBJmdBfqKHZCc4118rEqucjy4dgjGgaDtRXkajDB
 WkSw==
X-Gm-Message-State: AC+VfDzJKHcstfeNzdyxf3bPMaLnowQfbN+YMx3+O/K0O8cgcPr7sIcd
 F5USeJBA1OYhrLs5SqKHAC/Taw==
X-Google-Smtp-Source: ACHHUZ543P2ilITTB+JJLcCOf8VceZqXL+eq6Womzd/MKobplm+grQsnY8EFoThu+w77JQjU7kG4Sw==
X-Received: by 2002:a05:6000:1146:b0:306:26fa:1d04 with SMTP id
 d6-20020a056000114600b0030626fa1d04mr1773997wrx.13.1684500950415; 
 Fri, 19 May 2023 05:55:50 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s18-20020a5d6a92000000b0030631f199f9sm5251164wru.34.2023.05.19.05.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 05:55:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8CE9E1FFBB;
 Fri, 19 May 2023 13:55:49 +0100 (BST)
References: <20230518125107.146421-1-peter.maydell@linaro.org>
 <20230518125107.146421-5-peter.maydell@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@redhat.com>
Subject: Re: [PULL 04/29] arm/kvm: add support for MTE
Date: Fri, 19 May 2023 13:51:51 +0100
In-reply-to: <20230518125107.146421-5-peter.maydell@linaro.org>
Message-ID: <878rdklbu2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Cornelia Huck <cohuck@redhat.com>
>
> Extend the 'mte' property for the virt machine to cover KVM as
> well. For KVM, we don't allocate tag memory, but instead enable the
> capability.
>
> If MTE has been enabled, we need to disable migration, as we do not
> yet have a way to migrate the tags as well. Therefore, MTE will stay
> off with KVM unless requested explicitly.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20230428095533.21747-2-cohuck@redhat.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I bisected to this commit which causes a segfault on one of my test
kernels (6.3.2 arm64):

  =E2=9E=9C  ag MTE .config
  486:CONFIG_ARM64_AS_HAS_MTE=3Dy
  487:CONFIG_ARM64_MTE=3Dy
  2949:CONFIG_WLAN_VENDOR_ADMTEK=3Dy
  3573:# CONFIG_I2C_SIMTEC is not set
  5278:# CONFIG_DRM_PANEL_TPO_TD043MTEA1 is not set
  9749:CONFIG_ARCH_USE_MEMTEST=3Dy
  9750:CONFIG_MEMTEST=3Dy

And crashed with a nullptr deref:

  =E2=9E=9C  gdb --args ./qemu-system-aarch64 -cpu max,pauth-impdef=3Don -m=
achine type=3Dvirt,virtualization=3Don,gic-version=3D3 -display none -seria=
l mon:stdio -netdev user,id=3Dunet,hostfwd=3D
  tcp::2222-:22,hostfwd=3Dtcp::1234-:1234 -device virtio-net-pci,netdev=3Du=
net -kernel ~/lsrc/linux.git/builds/arm64.initramfs/arch/arm64/boot/Image -=
append "console=3DttyAMA0 init=3D\"busybox poweroff\"" -m 4096 -object memo=
ry-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3Don -numa nod=
e,memdev=3Dmem -smp 4
  GNU gdb (Debian 13.1-2) 13.1
  Copyright (C) 2023 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.
  Type "show copying" and "show warranty" for details.
  This GDB was configured as "x86_64-linux-gnu".
  Type "show configuration" for configuration details.
  For bug reporting instructions, please see:
  <https://www.gnu.org/software/gdb/bugs/>.
  Find the GDB manual and other documentation resources online at:
      <http://www.gnu.org/software/gdb/documentation/>.

  For help, type "help".
  Type "apropos word" to search for commands related to "word"...
  Executed .gdbinit
  Reading symbols from ./qemu-system-aarch64...
  (gdb) r
  Starting program: /home/alex/lsrc/qemu.git/builds/arm.debug/qemu-system-a=
arch64 -cpu max,pauth-impdef=3Don -machine type=3Dvirt,virtualization=3Don,=
gic-version=3D3 -display none -serial mon:stdio -netdev user,id=3Dunet,host=
fwd=3Dtcp::2222-:22,hostfwd=3Dtcp::1234-:1234 -device virtio-net-pci,netdev=
=3Dunet -kernel /home/alex/lsrc/linux.git/builds/arm64.initramfs/arch/arm64=
/boot/Image -append console=3DttyAMA0\ init=3D\"busybox\ poweroff\" -m 4096=
 -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=
=3Don -numa node,memdev=3Dmem -smp 4
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
  [New Thread 0x7fffe71e26c0 (LWP 1701008)]
  [New Thread 0x7fffe666d6c0 (LWP 1701009)]
  [New Thread 0x7fffe5e6c6c0 (LWP 1701010)]
  [New Thread 0x7fffe566b6c0 (LWP 1701011)]
  [New Thread 0x7fffe4e6a6c0 (LWP 1701012)]

  Thread 3 "qemu-system-aar" received signal SIGSEGV, Segmentation fault.
  [Switching to Thread 0x7fffe666d6c0 (LWP 1701009)]
  0x0000555556005725 in address_space_to_flatview (as=3D0x67726f223d656d61)=
 at /home/alex/lsrc/qemu.git/include/exec/memory.h:1105
  1105        return qatomic_rcu_read(&as->current_map);
  (gdb) bt
  #0  0x0000555556005725 in address_space_to_flatview (as=3D0x67726f223d656=
d61) at /home/alex/lsrc/qemu.git/include/exec/memory.h:1105
  #1  0x000055555600578b in address_space_translate (as=3D0x67726f223d656d6=
1, addr=3D35765504, xlat=3D0x7fffe6667c10, len=3D0x0, is_write=3Dfalse, att=
rs=3D...)
      at /home/alex/lsrc/qemu.git/include/exec/memory.h:2792
  #2  0x000055555600600e in allocation_tag_mem
      (env=3D0x555557512000, ptr_mmu_idx=3D3, ptr=3D18446462598803595264, p=
tr_access=3DMMU_DATA_STORE, ptr_size=3D256, tag_access=3DMMU_DATA_LOAD, tag=
_size=3D8, ra=3D140734806726420)
      at ../../target/arm/tcg/mte_helper.c:176
  #3  0x0000555556006aee in helper_stgm (env=3D0x555557512000, ptr=3D184464=
62598803595264, val=3D0) at ../../target/arm/tcg/mte_helper.c:461
  #4  0x00007fff60299714 in code_gen_buffer ()
  #5  0x000055555617d0e4 in cpu_tb_exec (cpu=3D0x55555750f800, itb=3D0x7fff=
a0299600, tb_exit=3D0x7fffe6668270) at ../../accel/tcg/cpu-exec.c:460
  #6  0x000055555617dd79 in cpu_loop_exec_tb (cpu=3D0x55555750f800, tb=3D0x=
7fffa0299600, pc=3D18446603336361784892, last_tb=3D0x7fffe6668280, tb_exit=
=3D0x7fffe6668270)
      at ../../accel/tcg/cpu-exec.c:893
  #7  0x000055555617e0e3 in cpu_exec_loop (cpu=3D0x55555750f800, sc=3D0x7ff=
fe6668300) at ../../accel/tcg/cpu-exec.c:1013
  #8  0x000055555617e1e3 in cpu_exec_setjmp (cpu=3D0x55555750f800, sc=3D0x7=
fffe6668300) at ../../accel/tcg/cpu-exec.c:1043
  #9  0x000055555617e26a in cpu_exec (cpu=3D0x55555750f800) at ../../accel/=
tcg/cpu-exec.c:1069
  #10 0x00005555561a43ac in tcg_cpus_exec (cpu=3D0x55555750f800) at ../../a=
ccel/tcg/tcg-accel-ops.c:81
  #11 0x00005555561a4a64 in mttcg_cpu_thread_fn (arg=3D0x55555750f800) at .=
./../accel/tcg/tcg-accel-ops-mttcg.c:95
  #12 0x00005555563ba633 in qemu_thread_start (args=3D0x5555575afae0) at ..=
/../util/qemu-thread-posix.c:541
  #13 0x00007ffff4b17fd4 in start_thread (arg=3D<optimized out>) at ./nptl/=
pthread_create.c:442
  #14 0x00007ffff4b985bc in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/=
clone3.S:81
  (gdb) thread 0
  Invalid thread ID: 0
  (gdb) frame 0
  #0  0x0000555556005725 in address_space_to_flatview (as=3D0x67726f223d656=
d61) at /home/alex/lsrc/qemu.git/include/exec/memory.h:1105
  1105        return qatomic_rcu_read(&as->current_map);
  (gdb) p as
  $1 =3D (AddressSpace *) 0x67726f223d656d61
  (gdb) p *$
  Cannot access memory at address 0x67726f223d656d61
  (gdb) f 2
  #2  0x000055555600600e in allocation_tag_mem (env=3D0x555557512000, ptr_m=
mu_idx=3D3, ptr=3D18446462598803595264, ptr_access=3DMMU_DATA_STORE, ptr_si=
ze=3D256,=20
      tag_access=3DMMU_DATA_LOAD, tag_size=3D8, ra=3D140734806726420) at ..=
/../target/arm/tcg/mte_helper.c:176
  176         mr =3D address_space_translate(tag_as, tag_paddr, &xlat, NULL,
  (gdb) l
  171         tag_paddr =3D ptr_paddr >> (LOG2_TAG_GRANULE + 1);
  172
  173         /* Look up the address in tag space. */
  174         tag_asi =3D attrs.secure ? ARMASIdx_TagS : ARMASIdx_TagNS;
  175         tag_as =3D cpu_get_address_space(env_cpu(env), tag_asi);
  176         mr =3D address_space_translate(tag_as, tag_paddr, &xlat, NULL,
  177                                      tag_access =3D=3D MMU_DATA_STORE=
, attrs);
  178
  179         /*
  180          * Note that @mr will never be NULL.  If there is nothing in =
the address
  (gdb) p tag_as
  $2 =3D (AddressSpace *) 0x67726f223d656d61
  (gdb) p *$
  Cannot access memory at address 0x67726f223d656d61

> ---
>  target/arm/cpu.h     |  4 +++
>  target/arm/kvm_arm.h | 19 ++++++++++++
>  hw/arm/virt.c        | 73 +++++++++++++++++++++++++-------------------
>  target/arm/cpu.c     |  9 +++---
>  target/arm/kvm.c     | 35 +++++++++++++++++++++
>  target/arm/kvm64.c   |  5 +++
>  6 files changed, 109 insertions(+), 36 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index d469a2637b3..c3463e39bcd 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -935,6 +935,9 @@ struct ArchCPU {
>       */
>      uint32_t psci_conduit;
>=20=20
> +    /* CPU has Memory Tag Extension */
> +    bool has_mte;
> +
>      /* For v8M, initial value of the Secure VTOR */
>      uint32_t init_svtor;
>      /* For v8M, initial value of the Non-secure VTOR */
> @@ -1053,6 +1056,7 @@ struct ArchCPU {
>      bool prop_pauth;
>      bool prop_pauth_impdef;
>      bool prop_lpa2;
> +    OnOffAuto prop_mte;
>=20=20
>      /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
>      uint32_t dcz_blocksize;
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 330fbe5c722..2083547bf60 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -313,6 +313,13 @@ bool kvm_arm_pmu_supported(void);
>   */
>  bool kvm_arm_sve_supported(void);
>=20=20
> +/**
> + * kvm_arm_mte_supported:
> + *
> + * Returns: true if KVM can enable MTE, and false otherwise.
> + */
> +bool kvm_arm_mte_supported(void);
> +
>  /**
>   * kvm_arm_get_max_vm_ipa_size:
>   * @ms: Machine state handle
> @@ -377,6 +384,8 @@ void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa);
>=20=20
>  int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
>=20=20
> +void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
> +
>  #else
>=20=20
>  /*
> @@ -403,6 +412,11 @@ static inline bool kvm_arm_steal_time_supported(void)
>      return false;
>  }
>=20=20
> +static inline bool kvm_arm_mte_supported(void)
> +{
> +    return false;
> +}
> +
>  /*
>   * These functions should never actually be called without KVM support.
>   */
> @@ -451,6 +465,11 @@ static inline uint32_t kvm_arm_sve_get_vls(CPUState =
*cs)
>      g_assert_not_reached();
>  }
>=20=20
> +static inline void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
> +{
> +    g_assert_not_reached();
> +}
> +
>  #endif
>=20=20
>  static inline const char *gic_class_name(void)
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b99ae185016..06b514b25c3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2146,7 +2146,7 @@ static void machvirt_init(MachineState *machine)
>          exit(1);
>      }
>=20=20
> -    if (vms->mte && (kvm_enabled() || hvf_enabled())) {
> +    if (vms->mte && hvf_enabled()) {
>          error_report("mach-virt: %s does not support providing "
>                       "MTE to the guest CPU",
>                       current_accel_name());
> @@ -2216,39 +2216,48 @@ static void machvirt_init(MachineState *machine)
>          }
>=20=20
>          if (vms->mte) {
> -            /* Create the memory region only once, but link to all cpus.=
 */
> -            if (!tag_sysmem) {
> -                /*
> -                 * The property exists only if MemTag is supported.
> -                 * If it is, we must allocate the ram to back that up.
> -                 */
> -                if (!object_property_find(cpuobj, "tag-memory")) {
> -                    error_report("MTE requested, but not supported "
> -                                 "by the guest CPU");
> +            if (tcg_enabled()) {
> +                /* Create the memory region only once, but link to all c=
pus. */
> +                if (!tag_sysmem) {
> +                    /*
> +                     * The property exists only if MemTag is supported.
> +                     * If it is, we must allocate the ram to back that u=
p.
> +                     */
> +                    if (!object_property_find(cpuobj, "tag-memory")) {
> +                        error_report("MTE requested, but not supported "
> +                                     "by the guest CPU");
> +                        exit(1);
> +                    }
> +
> +                    tag_sysmem =3D g_new(MemoryRegion, 1);
> +                    memory_region_init(tag_sysmem, OBJECT(machine),
> +                                       "tag-memory", UINT64_MAX / 32);
> +
> +                    if (vms->secure) {
> +                        secure_tag_sysmem =3D g_new(MemoryRegion, 1);
> +                        memory_region_init(secure_tag_sysmem, OBJECT(mac=
hine),
> +                                           "secure-tag-memory",
> +                                           UINT64_MAX / 32);
> +
> +                        /* As with ram, secure-tag takes precedence over=
 tag. */
> +                        memory_region_add_subregion_overlap(secure_tag_s=
ysmem,
> +                                                            0, tag_sysme=
m, -1);
> +                    }
> +                }
> +
> +                object_property_set_link(cpuobj, "tag-memory",
> +                                         OBJECT(tag_sysmem), &error_abor=
t);
> +                if (vms->secure) {
> +                    object_property_set_link(cpuobj, "secure-tag-memory",
> +                                             OBJECT(secure_tag_sysmem),
> +                                             &error_abort);
> +                }
> +            } else if (kvm_enabled()) {
> +                if (!kvm_arm_mte_supported()) {
> +                    error_report("MTE requested, but not supported by KV=
M");
>                      exit(1);
>                  }
> -
> -                tag_sysmem =3D g_new(MemoryRegion, 1);
> -                memory_region_init(tag_sysmem, OBJECT(machine),
> -                                   "tag-memory", UINT64_MAX / 32);
> -
> -                if (vms->secure) {
> -                    secure_tag_sysmem =3D g_new(MemoryRegion, 1);
> -                    memory_region_init(secure_tag_sysmem, OBJECT(machine=
),
> -                                       "secure-tag-memory", UINT64_MAX /=
 32);
> -
> -                    /* As with ram, secure-tag takes precedence over tag=
.  */
> -                    memory_region_add_subregion_overlap(secure_tag_sysme=
m, 0,
> -                                                        tag_sysmem, -1);
> -                }
> -            }
> -
> -            object_property_set_link(cpuobj, "tag-memory", OBJECT(tag_sy=
smem),
> -                                     &error_abort);
> -            if (vms->secure) {
> -                object_property_set_link(cpuobj, "secure-tag-memory",
> -                                         OBJECT(secure_tag_sysmem),
> -                                         &error_abort);
> +                kvm_arm_enable_mte(cpuobj, &error_abort);
>              }
>          }
>=20=20
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 5182ed0c911..f6a88e52ac2 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1480,6 +1480,7 @@ void arm_cpu_post_init(Object *obj)
>                                       qdev_prop_allow_set_link_before_rea=
lize,
>                                       OBJ_PROP_LINK_STRONG);
>          }
> +        cpu->has_mte =3D true;
>      }
>  #endif
>  }
> @@ -1616,7 +1617,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>          }
>          if (cpu->tag_memory) {
>              error_setg(errp,
> -                       "Cannot enable %s when guest CPUs has MTE enabled=
",
> +                       "Cannot enable %s when guest CPUs has tag memory =
enabled",
>                         current_accel_name());
>              return;
>          }
> @@ -1996,10 +1997,10 @@ static void arm_cpu_realizefn(DeviceState *dev, E=
rror **errp)
>      }
>=20=20
>  #ifndef CONFIG_USER_ONLY
> -    if (cpu->tag_memory =3D=3D NULL && cpu_isar_feature(aa64_mte, cpu)) {
> +    if (!cpu->has_mte && cpu_isar_feature(aa64_mte, cpu)) {
>          /*
> -         * Disable the MTE feature bits if we do not have tag-memory
> -         * provided by the machine.
> +         * Disable the MTE feature bits if we do not have the feature
> +         * setup by the machine.
>           */
>          cpu->isar.id_aa64pfr1 =3D
>              FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 84da49332c4..9553488ecd1 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -31,6 +31,7 @@
>  #include "hw/boards.h"
>  #include "hw/irq.h"
>  #include "qemu/log.h"
> +#include "migration/blocker.h"
>=20=20
>  const KVMCapabilityInfo kvm_arch_required_capabilities[] =3D {
>      KVM_CAP_LAST_INFO
> @@ -1064,3 +1065,37 @@ bool kvm_arch_cpu_check_are_resettable(void)
>  void kvm_arch_accel_class_init(ObjectClass *oc)
>  {
>  }
> +
> +void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
> +{
> +    static bool tried_to_enable;
> +    static bool succeeded_to_enable;
> +    Error *mte_migration_blocker =3D NULL;
> +    int ret;
> +
> +    if (!tried_to_enable) {
> +        /*
> +         * MTE on KVM is enabled on a per-VM basis (and retrying doesn't=
 make
> +         * sense), and we only want a single migration blocker as well.
> +         */
> +        tried_to_enable =3D true;
> +
> +        ret =3D kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_MTE, 0);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Failed to enable KVM_CAP_ARM_M=
TE");
> +            return;
> +        }
> +
> +        /* TODO: add proper migration support with MTE enabled */
> +        error_setg(&mte_migration_blocker,
> +                   "Live migration disabled due to MTE enabled");
> +        if (migrate_add_blocker(mte_migration_blocker, errp)) {
> +            error_free(mte_migration_blocker);
> +            return;
> +        }
> +        succeeded_to_enable =3D true;
> +    }
> +    if (succeeded_to_enable) {
> +        object_property_set_bool(cpuobj, "has_mte", true, NULL);
> +    }
> +}
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 810db33ccbd..1893f387936 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -756,6 +756,11 @@ bool kvm_arm_steal_time_supported(void)
>      return kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
>  }
>=20=20
> +bool kvm_arm_mte_supported(void)
> +{
> +    return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
> +}
> +
>  QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN !=3D 1);
>=20=20
>  uint32_t kvm_arm_sve_get_vls(CPUState *cs)


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

