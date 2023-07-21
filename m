Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC7D75C0AC
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 10:02:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMl4q-0007At-2O; Fri, 21 Jul 2023 04:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1qMl4m-0007AX-Ul; Fri, 21 Jul 2023 04:01:25 -0400
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1qMl4k-0008FW-N3; Fri, 21 Jul 2023 04:01:24 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M7Jj2-1qHEkk47PI-007krL; Fri, 21 Jul 2023 10:01:03 +0200
Message-ID: <97ec681b-786a-b65b-2e3b-d62c61b00c76@vivier.eu>
Date: Fri, 21 Jul 2023 10:00:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw: Add compat machines for 8.2
Content-Language: fr
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <20230718142235.135319-1-cohuck@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230718142235.135319-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aSTYam1uo5cwxvh9a6B8qMKlBs3uV3mjfOgNUCwb6rZjQovQm3T
 nkW+YPoudvt5S8V1mrxWxRNJ/5J1l6OLGbUjlsY2e+LTNOu3PT1DvRccjhYuTTZIaGwl4R7
 dCM1QmfyULdJG2UM+sa+/Dl0MaDi5/JzeOcdttoC0EgMfMO/YN8Ec/6Ga54cFxa+sqfNAq+
 i7kYDzy0UhxFcYPnFu4oQ==
UI-OutboundReport: notjunk:1;M01:P0:vbmZv0mu2aQ=;VvegFnKIKMqrBWxWpgzdv+imVUD
 Bhx7Y4LoZc4Qt/40h+olXhNuDo1vh6a5EG6xCvBc90a40v8EffVBTkC3j4XEvl5rJi3geG40G
 3h6JiCZ831Lx+tKrLGs57QDRwFyN03OVThJBZs1tV49nRspYbBAcD2yqi3usAhmESuCTtJ6oU
 ebtM2s7ecYlZO6+FQYhe4MYYeXAV13NCUoyDtJrj1j9fwvyQvbc0sw6gS3GdtBOHIBM7/lWZs
 bHiJ8u4jm337M1MbtbDOrYS9/+QhE51Zc+7MFGpz0NOQOU3mPg7jKC4RD7lKig8yIvDaoBK9M
 2dwD+Av1LWw6vkqa7B34hwZ37SjsA37Kxg8yLgLVNYkpjRHYWAqYElkVVJ6i1SxRDdVsgzihE
 ZVSqAm+cMU1ehCi5Ug/EhmzbeqB8G2dxkzCkrCNzDTtaKQfkNou/SNKe7+uyq0p0L0umivmzp
 V40qAJ89pyKHjgOiVMwSCEfH2RpdmrV34lhpMtxsJ5eN0MKg3sFpw1AFpCknYr2RMbm1k8jmu
 yao6bHIy8o2sceRUDr2NDY+Pkbgqc8lP0TMpypUKopov7Hx8JG28oWDMs78841LuNj8VCK3vj
 dBL+Kw4YhxkEBe6DLmTUrA/cyak1iQ8I5kKMaAtD0W2Z2I/zMZZ1m5MDRhh08A8AueQwJ1Aok
 8fodjx6VGtUsz+tHblOcblm0//uREh7wZioqjmy21w==
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.096,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 18/07/2023 à 16:22, Cornelia Huck a écrit :
> Add 8.2 machine types for arm/i440fx/m68k/q35/s390x/spapr.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/arm/virt.c              |  9 ++++++++-
>   hw/core/machine.c          |  3 +++
>   hw/i386/pc.c               |  3 +++
>   hw/i386/pc_piix.c          | 16 +++++++++++++---
>   hw/i386/pc_q35.c           | 14 ++++++++++++--
>   hw/m68k/virt.c             |  9 ++++++++-
>   hw/ppc/spapr.c             | 15 +++++++++++++--
>   hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>   include/hw/boards.h        |  3 +++
>   include/hw/i386/pc.h       |  3 +++
>   10 files changed, 79 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7d9dbc26633a..2a560271b5fc 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3170,10 +3170,17 @@ static void machvirt_machine_init(void)
>   }
>   type_init(machvirt_machine_init);
>   
> +static void virt_machine_8_2_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(8, 2)
> +
>   static void virt_machine_8_1_options(MachineClass *mc)
>   {
> +    virt_machine_8_2_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
>   }
> -DEFINE_VIRT_MACHINE_AS_LATEST(8, 1)
> +DEFINE_VIRT_MACHINE(8, 1)
>   
>   static void virt_machine_8_0_options(MachineClass *mc)
>   {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f0d35c640184..da699cf4e147 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -39,6 +39,9 @@
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-pci.h"
>   
> +GlobalProperty hw_compat_8_1[] = {};
> +const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
> +
>   GlobalProperty hw_compat_8_0[] = {
>       { "migration", "multifd-flush-after-each-section", "on"},
>       { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3109d5e0e035..54838c0c411d 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -114,6 +114,9 @@
>       { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
>       { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
>   
> +GlobalProperty pc_compat_8_1[] = {};
> +const size_t pc_compat_8_1_len = G_N_ELEMENTS(pc_compat_8_1);
> +
>   GlobalProperty pc_compat_8_0[] = {
>       { "virtio-mem", "unplugged-inaccessible", "auto" },
>   };
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index ac72e8f5bee1..ce1ac9527493 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -504,13 +504,25 @@ static void pc_i440fx_machine_options(MachineClass *m)
>       machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
>   }
>   
> -static void pc_i440fx_8_1_machine_options(MachineClass *m)
> +static void pc_i440fx_8_2_machine_options(MachineClass *m)
>   {
>       pc_i440fx_machine_options(m);
>       m->alias = "pc";
>       m->is_default = true;
>   }
>   
> +DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2", NULL,
> +                      pc_i440fx_8_2_machine_options);
> +
> +static void pc_i440fx_8_1_machine_options(MachineClass *m)
> +{
> +    pc_i440fx_8_2_machine_options(m);
> +    m->alias = NULL;
> +    m->is_default = false;
> +    compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
> +    compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
> +}
> +
>   DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
>                         pc_i440fx_8_1_machine_options);
>   
> @@ -519,8 +531,6 @@ static void pc_i440fx_8_0_machine_options(MachineClass *m)
>       PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>   
>       pc_i440fx_8_1_machine_options(m);
> -    m->alias = NULL;
> -    m->is_default = false;
>       compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
>       compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
>   
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index dc27a9e223a2..37c4814bedf2 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -379,12 +379,23 @@ static void pc_q35_machine_options(MachineClass *m)
>       machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
>   }
>   
> -static void pc_q35_8_1_machine_options(MachineClass *m)
> +static void pc_q35_8_2_machine_options(MachineClass *m)
>   {
>       pc_q35_machine_options(m);
>       m->alias = "q35";
>   }
>   
> +DEFINE_Q35_MACHINE(v8_2, "pc-q35-8.2", NULL,
> +                   pc_q35_8_2_machine_options);
> +
> +static void pc_q35_8_1_machine_options(MachineClass *m)
> +{
> +    pc_q35_8_2_machine_options(m);
> +    m->alias = NULL;
> +    compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
> +    compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
> +}
> +
>   DEFINE_Q35_MACHINE(v8_1, "pc-q35-8.1", NULL,
>                      pc_q35_8_1_machine_options);
>   
> @@ -393,7 +404,6 @@ static void pc_q35_8_0_machine_options(MachineClass *m)
>       PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>   
>       pc_q35_8_1_machine_options(m);
> -    m->alias = NULL;
>       compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
>       compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
>   
> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
> index 731205b215b2..a0813f75c060 100644
> --- a/hw/m68k/virt.c
> +++ b/hw/m68k/virt.c
> @@ -347,10 +347,17 @@ type_init(virt_machine_register_types)
>       } \
>       type_init(machvirt_machine_##major##_##minor##_init);
>   
> +static void virt_machine_8_2_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE(8, 2, true)
> +
>   static void virt_machine_8_1_options(MachineClass *mc)
>   {
> +    virt_machine_8_2_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
>   }
> -DEFINE_VIRT_MACHINE(8, 1, true)
> +DEFINE_VIRT_MACHINE(8, 1, false)
>   
>   static void virt_machine_8_0_options(MachineClass *mc)
>   {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1c8b8d57a70a..622fea825605 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4752,15 +4752,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
>       }                                                                \
>       type_init(spapr_machine_register_##suffix)
>   
> +/*
> + * pseries-8.2
> + */
> +static void spapr_machine_8_2_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE(8_2, "8.2", true);
> +
>   /*
>    * pseries-8.1
>    */
>   static void spapr_machine_8_1_class_options(MachineClass *mc)
>   {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    spapr_machine_8_2_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
>   }
>   
> -DEFINE_SPAPR_MACHINE(8_1, "8.1", true);
> +DEFINE_SPAPR_MACHINE(8_1, "8.1", false);
>   
>   /*
>    * pseries-8.0
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 4516d73ff5fc..c52a1fcf6700 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -828,14 +828,26 @@ bool css_migration_enabled(void)
>       }                                                                         \
>       type_init(ccw_machine_register_##suffix)
>   
> +static void ccw_machine_8_2_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_8_2_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE(8_2, "8.2", true);
> +
>   static void ccw_machine_8_1_instance_options(MachineState *machine)
>   {
> +    ccw_machine_8_2_instance_options(machine);
>   }
>   
>   static void ccw_machine_8_1_class_options(MachineClass *mc)
>   {
> +    ccw_machine_8_2_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
>   }
> -DEFINE_CCW_MACHINE(8_1, "8.1", true);
> +DEFINE_CCW_MACHINE(8_1, "8.1", false);
>   
>   static void ccw_machine_8_0_instance_options(MachineState *machine)
>   {
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index ed8336019801..3b541ffd2472 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -390,6 +390,9 @@ struct MachineState {
>       } \
>       type_init(machine_initfn##_register_types)
>   
> +extern GlobalProperty hw_compat_8_1[];
> +extern const size_t hw_compat_8_1_len;
> +
>   extern GlobalProperty hw_compat_8_0[];
>   extern const size_t hw_compat_8_0_len;
>   
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index d54e8b1101e4..0fabece236cf 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -200,6 +200,9 @@ void pc_madt_cpu_entry(int uid, const CPUArchIdList *apic_ids,
>   /* sgx.c */
>   void pc_machine_init_sgx_epc(PCMachineState *pcms);
>   
> +extern GlobalProperty pc_compat_8_1[];
> +extern const size_t pc_compat_8_1_len;
> +
>   extern GlobalProperty pc_compat_8_0[];
>   extern const size_t pc_compat_8_0_len;
>   

For m68k part:
Acked-by: Laurent Vivier <laurent@vivier.eu>

