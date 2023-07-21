Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D69375C148
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 10:20:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMlMB-0004oF-Gl; Fri, 21 Jul 2023 04:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qMlM9-0004o7-VG
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 04:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qMlM7-0003Wk-RC
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 04:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689927558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pRJy7Tbp08IAiIaPCUWlUMndjI8xNFqSlJ0wmYaxmPo=;
 b=KrmhDlDjMi9HiMGeLoizIXkEa4NuRK/nyDLjS5TbV96C+HkVvSClRaN54x5y3uaDU5/zZv
 she4yVBO2snsNpllun52t/M26OX97SaZ/+/GhjjuIDuO4dAZS8cSnzwmwDGQzyHuRV94jr
 +PxazUSj7weHA3+eFqbaRggBdRjDRxk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-Z0klMpyRNz6WSNXkQDUTCA-1; Fri, 21 Jul 2023 04:19:16 -0400
X-MC-Unique: Z0klMpyRNz6WSNXkQDUTCA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fd0fa4d08cso9128365e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 01:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689927555; x=1690532355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRJy7Tbp08IAiIaPCUWlUMndjI8xNFqSlJ0wmYaxmPo=;
 b=LCrjF22ymkbIGsWRxJjcVF6qh4rO9BzTDnIP2VE3ReeClfC/1LdIlL12dof919bf9V
 NQJ7ElZDJJtLMOnTNPD2Aastva2UNRtXWsS+XudvNhlqH9L/Um0T/fpZfkWOTpa0haqh
 FddO27jAHo13PYodeU2HFeXtuZxbJzvR0SzwKYsrcTI83f2rvTHZKFecrMNK26UuXXxF
 7ttAt04UyQKcAwwp+2Qg6nh6YJqJcZ+7KaSIK8p2LRYiB62wrVA1QlHe+zR1T3ru651u
 q0qE3lAwfTGnYgEQsbNDO+4/RY2n7j0C505CxPQmsjNSGXA0nQ3WgLbApGjMLXeK1smx
 1UVw==
X-Gm-Message-State: ABy/qLZ59kfgJajdA4ApvNYNYmsBxR7T79P0XJCs4DZ7XCseA73GWDQe
 zIDdXryuaZKmVCAsgKGMsfXn3K+Fj7mHLKN4gGXtzIjpyVEHh5/otXqMS6dtB0wFdqj9Y+PrY+g
 jVbLolEeejfXRx5c=
X-Received: by 2002:a7b:c40a:0:b0:3fc:5d2:1f47 with SMTP id
 k10-20020a7bc40a000000b003fc05d21f47mr809768wmi.20.1689927555239; 
 Fri, 21 Jul 2023 01:19:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF+/fsGZgpDXGVtF94oXr1Uy2Dol3ulQMMaKW0QsOidKUfcfORgz3hLBv94AsmUVwVh/aPP+g==
X-Received: by 2002:a7b:c40a:0:b0:3fc:5d2:1f47 with SMTP id
 k10-20020a7bc40a000000b003fc05d21f47mr809754wmi.20.1689927554832; 
 Fri, 21 Jul 2023 01:19:14 -0700 (PDT)
Received: from redhat.com ([2.52.16.41]) by smtp.gmail.com with ESMTPSA id
 a1-20020adfdd01000000b0031411e46af3sm3490086wrm.97.2023.07.21.01.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 01:19:14 -0700 (PDT)
Date: Fri, 21 Jul 2023 04:19:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH] hw: Add compat machines for 8.2
Message-ID: <20230721041901-mutt-send-email-mst@kernel.org>
References: <20230718142235.135319-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718142235.135319-1-cohuck@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jul 18, 2023 at 04:22:35PM +0200, Cornelia Huck wrote:
> Add 8.2 machine types for arm/i440fx/m68k/q35/s390x/spapr.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/arm/virt.c              |  9 ++++++++-
>  hw/core/machine.c          |  3 +++
>  hw/i386/pc.c               |  3 +++
>  hw/i386/pc_piix.c          | 16 +++++++++++++---
>  hw/i386/pc_q35.c           | 14 ++++++++++++--
>  hw/m68k/virt.c             |  9 ++++++++-
>  hw/ppc/spapr.c             | 15 +++++++++++++--
>  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>  include/hw/boards.h        |  3 +++
>  include/hw/i386/pc.h       |  3 +++
>  10 files changed, 79 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7d9dbc26633a..2a560271b5fc 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3170,10 +3170,17 @@ static void machvirt_machine_init(void)
>  }
>  type_init(machvirt_machine_init);
>  
> +static void virt_machine_8_2_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(8, 2)
> +
>  static void virt_machine_8_1_options(MachineClass *mc)
>  {
> +    virt_machine_8_2_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
>  }
> -DEFINE_VIRT_MACHINE_AS_LATEST(8, 1)
> +DEFINE_VIRT_MACHINE(8, 1)
>  
>  static void virt_machine_8_0_options(MachineClass *mc)
>  {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f0d35c640184..da699cf4e147 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -39,6 +39,9 @@
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-pci.h"
>  
> +GlobalProperty hw_compat_8_1[] = {};
> +const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
> +
>  GlobalProperty hw_compat_8_0[] = {
>      { "migration", "multifd-flush-after-each-section", "on"},
>      { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3109d5e0e035..54838c0c411d 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -114,6 +114,9 @@
>      { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
>      { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
>  
> +GlobalProperty pc_compat_8_1[] = {};
> +const size_t pc_compat_8_1_len = G_N_ELEMENTS(pc_compat_8_1);
> +
>  GlobalProperty pc_compat_8_0[] = {
>      { "virtio-mem", "unplugged-inaccessible", "auto" },
>  };
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index ac72e8f5bee1..ce1ac9527493 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -504,13 +504,25 @@ static void pc_i440fx_machine_options(MachineClass *m)
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
>  }
>  
> -static void pc_i440fx_8_1_machine_options(MachineClass *m)
> +static void pc_i440fx_8_2_machine_options(MachineClass *m)
>  {
>      pc_i440fx_machine_options(m);
>      m->alias = "pc";
>      m->is_default = true;
>  }
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
>  DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
>                        pc_i440fx_8_1_machine_options);
>  
> @@ -519,8 +531,6 @@ static void pc_i440fx_8_0_machine_options(MachineClass *m)
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>  
>      pc_i440fx_8_1_machine_options(m);
> -    m->alias = NULL;
> -    m->is_default = false;
>      compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
>      compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
>  
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index dc27a9e223a2..37c4814bedf2 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -379,12 +379,23 @@ static void pc_q35_machine_options(MachineClass *m)
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
>  }
>  
> -static void pc_q35_8_1_machine_options(MachineClass *m)
> +static void pc_q35_8_2_machine_options(MachineClass *m)
>  {
>      pc_q35_machine_options(m);
>      m->alias = "q35";
>  }
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
>  DEFINE_Q35_MACHINE(v8_1, "pc-q35-8.1", NULL,
>                     pc_q35_8_1_machine_options);
>  
> @@ -393,7 +404,6 @@ static void pc_q35_8_0_machine_options(MachineClass *m)
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>  
>      pc_q35_8_1_machine_options(m);
> -    m->alias = NULL;
>      compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
>      compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
>  
> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
> index 731205b215b2..a0813f75c060 100644
> --- a/hw/m68k/virt.c
> +++ b/hw/m68k/virt.c
> @@ -347,10 +347,17 @@ type_init(virt_machine_register_types)
>      } \
>      type_init(machvirt_machine_##major##_##minor##_init);
>  
> +static void virt_machine_8_2_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE(8, 2, true)
> +
>  static void virt_machine_8_1_options(MachineClass *mc)
>  {
> +    virt_machine_8_2_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
>  }
> -DEFINE_VIRT_MACHINE(8, 1, true)
> +DEFINE_VIRT_MACHINE(8, 1, false)
>  
>  static void virt_machine_8_0_options(MachineClass *mc)
>  {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1c8b8d57a70a..622fea825605 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4752,15 +4752,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
>      }                                                                \
>      type_init(spapr_machine_register_##suffix)
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
>  /*
>   * pseries-8.1
>   */
>  static void spapr_machine_8_1_class_options(MachineClass *mc)
>  {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    spapr_machine_8_2_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
>  }
>  
> -DEFINE_SPAPR_MACHINE(8_1, "8.1", true);
> +DEFINE_SPAPR_MACHINE(8_1, "8.1", false);
>  
>  /*
>   * pseries-8.0
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 4516d73ff5fc..c52a1fcf6700 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -828,14 +828,26 @@ bool css_migration_enabled(void)
>      }                                                                         \
>      type_init(ccw_machine_register_##suffix)
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
>  static void ccw_machine_8_1_instance_options(MachineState *machine)
>  {
> +    ccw_machine_8_2_instance_options(machine);
>  }
>  
>  static void ccw_machine_8_1_class_options(MachineClass *mc)
>  {
> +    ccw_machine_8_2_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
>  }
> -DEFINE_CCW_MACHINE(8_1, "8.1", true);
> +DEFINE_CCW_MACHINE(8_1, "8.1", false);
>  
>  static void ccw_machine_8_0_instance_options(MachineState *machine)
>  {
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index ed8336019801..3b541ffd2472 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -390,6 +390,9 @@ struct MachineState {
>      } \
>      type_init(machine_initfn##_register_types)
>  
> +extern GlobalProperty hw_compat_8_1[];
> +extern const size_t hw_compat_8_1_len;
> +
>  extern GlobalProperty hw_compat_8_0[];
>  extern const size_t hw_compat_8_0_len;
>  
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index d54e8b1101e4..0fabece236cf 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -200,6 +200,9 @@ void pc_madt_cpu_entry(int uid, const CPUArchIdList *apic_ids,
>  /* sgx.c */
>  void pc_machine_init_sgx_epc(PCMachineState *pcms);
>  
> +extern GlobalProperty pc_compat_8_1[];
> +extern const size_t pc_compat_8_1_len;
> +
>  extern GlobalProperty pc_compat_8_0[];
>  extern const size_t pc_compat_8_0_len;
>  
> -- 
> 2.41.0


