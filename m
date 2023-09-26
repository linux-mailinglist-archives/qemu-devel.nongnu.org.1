Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD1F7AEB1E
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:13:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5zn-0007p0-Mf; Tue, 26 Sep 2023 07:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ql5zb-0007co-Ub
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ql5zZ-000189-SZ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695726756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=haUavF/gI1iqDHyy0Z/T1BH/vKsD3n/OhBbjzDDEip4=;
 b=Z4ue+1mYxPyZ25WT2p+raPSqaMUIL1OHUF24vbKYcUIVOpzsP8PCheLl8WtZijfHJzYhkr
 jR0CF38EVNTLcnCB36kRTyVuv2FCPMkH6ixrmaaUOBAXw2dvDBrw60NUahm6JJwMIul+Hz
 geFkiWtT8e+fe2oqYByKT4A7wDfj++Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-khNFHzdRNvaWJMVgL22FoQ-1; Tue, 26 Sep 2023 07:12:35 -0400
X-MC-Unique: khNFHzdRNvaWJMVgL22FoQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-533c6d0b377so4660360a12.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 04:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695726754; x=1696331554;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=haUavF/gI1iqDHyy0Z/T1BH/vKsD3n/OhBbjzDDEip4=;
 b=r+6josRLTOKQcBucTF0pNT3/ODGYvJ3d8uTdBNknXTa5fxx6nPVrIPGAWX0rXBbDoO
 PtoaQAePP0mOhoHVYDEENG5y1bSApfXsffkBzFI2ZlOigNtArJCdReobxLgjMY2XnawA
 wFbDxrgYPdmhz6uSPZCefniuc8VCoHajADzfRSeW68W9KmhAYXl01wzMVfxvFaKpDEtL
 OxIlpCG4he4pzvGDeqgqgz3glWRlbdx2jlM5QdEAekjV6VWBFnEhptm5Vmr6sbYz03LH
 UadalYWc5yq0lBLE0DVE2rvk9FSY58JW0avh3jXNQnP54LZAkwX4x0Pj2vcw6E/0dRtp
 5Gow==
X-Gm-Message-State: AOJu0YzJLGfl9llP3BTXO7rc381DlTwvfO5nPITdokdsxc+Kt45gcKlq
 wq+bjcEqjQTuE96W7Dmxw0reEdqTQv3fXG11CrWphUa1lx6OP2dMSpdo1WglqzkXaunw+G4VVQ1
 3hCPHZWaluzfj9Do=
X-Received: by 2002:aa7:d346:0:b0:530:f880:ca74 with SMTP id
 m6-20020aa7d346000000b00530f880ca74mr8491971edr.28.1695726754035; 
 Tue, 26 Sep 2023 04:12:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMFHK1AJsHoB2sBoS7Zf+sQvCpx1EZ2svyTui/mDT8H7bt3PQ56hmQ2C00jSLqVhlCLwkf0g==
X-Received: by 2002:aa7:d346:0:b0:530:f880:ca74 with SMTP id
 m6-20020aa7d346000000b00530f880ca74mr8491953edr.28.1695726753701; 
 Tue, 26 Sep 2023 04:12:33 -0700 (PDT)
Received: from redhat.com ([2.52.31.177]) by smtp.gmail.com with ESMTPSA id
 dz12-20020a0564021d4c00b0052fdc837d93sm3425080edb.47.2023.09.26.04.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 04:12:33 -0700 (PDT)
Date: Tue, 26 Sep 2023 07:12:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: xianglai li <lixianglai@loongson.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Bernhard Beschow <shentey@gmail.com>, Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
Message-ID: <20230926071055-mutt-send-email-mst@kernel.org>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <c2ab409710f5e0f0346727b47aaabd14537d45b8.1695697701.git.lixianglai@loongson.cn>
 <17a09b8ab65542be8561cb0480dae6bd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17a09b8ab65542be8561cb0480dae6bd@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 26, 2023 at 10:49:08AM +0000, Salil Mehta wrote:
> Hi Xianglai,
> FYI. RFC V2 is out and you can now drop the arch agnostic patches from
> your patch-set. Please check the details in the cover letter which one
> you need to pick and rebase from:
> 
> https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/T/#t
> 
> I am planning to float the architecture agnostic patch-set within this
> week which will have same patches and in same order as mentioned in
> the cover letter. This will untie the development across different
> architectures.
> 
> Many thanks
> Salil.

However, please get authorship info right. This claims patch has been
codeveloped by Bernhard Beschow, xianglai li and yourself.
Your patch claims a completely different list of authors
with yourself being the only common author.
Not nice.


> > From: xianglai li <lixianglai@loongson.cn>
> > Sent: Tuesday, September 26, 2023 10:54 AM
> > To: qemu-devel@nongnu.org
> > Cc: Bernhard Beschow <shentey@gmail.com>; Salil Mehta
> > <salil.mehta@opnsrc.net>; Salil Mehta <salil.mehta@huawei.com>; Xiaojuan
> > Yang <yangxiaojuan@loongson.cn>; Song Gao <gaosong@loongson.cn>; Michael S.
> > Tsirkin <mst@redhat.com>; Igor Mammedov <imammedo@redhat.com>; Ani Sinha
> > <anisinha@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
> > Henderson <richard.henderson@linaro.org>; Eduardo Habkost
> > <eduardo@habkost.net>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>;
> > Philippe Mathieu-Daudé <philmd@linaro.org>; wangyanan (Y)
> > <wangyanan55@huawei.com>; Daniel P. Berrangé <berrange@redhat.com>; Peter
> > Xu <peterx@redhat.com>; David Hildenbrand <david@redhat.com>; Bibo Mao
> > <maobibo@loongson.cn>
> > Subject: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
> > 
> > CPUs Control device(\\_SB.PCI0) register interface for the x86 arch
> > is based on PCI and is IO port based and hence existing cpus AML code
> > assumes _CRS objects would evaluate to a system resource which describes
> > IO Port address.
> > But on Loongarch arch CPUs control device(\\_SB.PRES) register interface
> > is memory-mapped hence _CRS object should evaluate to system resource
> > which describes memory-mapped base address.
> > 
> > This cpus AML code change updates the existing interface of the build cpus
> > AML
> > function to accept both IO/MEMORY type regions and update the _CRS object
> > correspondingly.
> > 
> > Co-authored-by: "Bernhard Beschow" <shentey@gmail.com>
> > Co-authored-by: "Salil Mehta" <salil.mehta@opnsrc.net>
> > Co-authored-by: "Salil Mehta" <salil.mehta@huawei.com>
> > Cc: "Bernhard Beschow" <shentey@gmail.com>
> > Cc: "Salil Mehta" <salil.mehta@huawei.com>
> > Cc: "Salil Mehta" <salil.mehta@opnsrc.net>
> > Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> > Cc: Song Gao <gaosong@loongson.cn>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Cc: Ani Sinha <anisinha@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Cc: Eduardo Habkost <eduardo@habkost.net>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> > Cc: Yanan Wang <wangyanan55@huawei.com>
> > Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Bibo Mao <maobibo@loongson.cn>
> > Signed-off-by: xianglai li <lixianglai@loongson.cn>
> > ---
> >  hw/acpi/cpu.c         | 20 +++++++++++++++-----
> >  hw/i386/acpi-build.c  |  3 ++-
> >  include/hw/acpi/cpu.h |  5 +++--
> >  3 files changed, 20 insertions(+), 8 deletions(-)
> > 
> > diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> > index 5bad983928..0afa04832e 100644
> > --- a/hw/acpi/cpu.c
> > +++ b/hw/acpi/cpu.c
> > @@ -6,6 +6,7 @@
> >  #include "qapi/qapi-events-acpi.h"
> >  #include "trace.h"
> >  #include "sysemu/numa.h"
> > +#include "hw/acpi/cpu_hotplug.h"
> > 
> >  #define OVMF_CPUHP_SMI_CMD 4
> > 
> > @@ -332,9 +333,10 @@ const VMStateDescription vmstate_cpu_hotplug = {
> >  #define CPU_FW_EJECT_EVENT "CEJF"
> > 
> >  void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures
> > opts,
> > -                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
> > +                    build_madt_cpu_fn build_madt_cpu, hwaddr mmap_io_base,
> >                      const char *res_root,
> > -                    const char *event_handler_method)
> > +                    const char *event_handler_method,
> > +                    AmlRegionSpace rs)
> >  {
> >      Aml *ifctx;
> >      Aml *field;
> > @@ -359,14 +361,22 @@ void build_cpus_aml(Aml *table, MachineState
> > *machine, CPUHotplugFeatures opts,
> >          aml_append(cpu_ctrl_dev, aml_mutex(CPU_LOCK, 0));
> > 
> >          crs = aml_resource_template();
> > -        aml_append(crs, aml_io(AML_DECODE16, io_base, io_base, 1,
> > +        if (rs == AML_SYSTEM_IO) {
> > +            aml_append(crs, aml_io(AML_DECODE16, mmap_io_base,
> > mmap_io_base, 1,
> >                                 ACPI_CPU_HOTPLUG_REG_LEN));
> > +        } else {
> > +            aml_append(crs, aml_memory32_fixed(mmap_io_base,
> > +                               ACPI_CPU_HOTPLUG_REG_LEN, AML_READ_WRITE));
> > +        }
> > +
> >          aml_append(cpu_ctrl_dev, aml_name_decl("_CRS", crs));
> > 
> > +        g_assert(rs == AML_SYSTEM_IO || rs == AML_SYSTEM_MEMORY);
> >          /* declare CPU hotplug MMIO region with related access fields */
> >          aml_append(cpu_ctrl_dev,
> > -            aml_operation_region("PRST", AML_SYSTEM_IO, aml_int(io_base),
> > -                                 ACPI_CPU_HOTPLUG_REG_LEN));
> > +            aml_operation_region("PRST", rs,
> > +                                         aml_int(mmap_io_base),
> > +                                         ACPI_CPU_HOTPLUG_REG_LEN));
> > 
> >          field = aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK,
> >                            AML_WRITE_AS_ZEROS);
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 863a939210..7016205d15 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1550,7 +1550,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >              .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
> >          };
> >          build_cpus_aml(dsdt, machine, opts, pc_madt_cpu_entry,
> > -                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02");
> > +                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02",
> > +                       AML_SYSTEM_IO);
> >      }
> > 
> >      if (pcms->memhp_io_base && nr_mem) {
> > diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> > index bc901660fb..601f644e57 100644
> > --- a/include/hw/acpi/cpu.h
> > +++ b/include/hw/acpi/cpu.h
> > @@ -60,9 +60,10 @@ typedef void (*build_madt_cpu_fn)(int uid, const
> > CPUArchIdList *apic_ids,
> >                                    GArray *entry, bool force_enabled);
> > 
> >  void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures
> > opts,
> > -                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
> > +                    build_madt_cpu_fn build_madt_cpu, hwaddr mmap_io_base,
> >                      const char *res_root,
> > -                    const char *event_handler_method);
> > +                    const char *event_handler_method,
> > +                    AmlRegionSpace rs);
> > 
> >  void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList
> > ***list);
> > 
> > --
> > 2.39.1
> > 
> 


