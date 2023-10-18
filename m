Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A477CDB48
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:07:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt5KJ-0001iX-Dt; Wed, 18 Oct 2023 08:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt5KH-0001iO-5n
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt5KE-0003zm-Su
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697630818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wp+nnpbqnoeHwlS/BrzRice9iJcDcyyrfWzNC6gGiZ0=;
 b=Vm2gifLfZRoCTR6ersDuj1UPxhmI3IguzmEvNUB16PihjEXOY6Bn54t57alEXVZA0oKqBL
 f8nKm0BNClT+mN+Qjatu0MV9jddN2lziA547d4VT6L6wYX2hWSCna/OdfYDAzbTD/z341n
 xYc8PEb65/FWjNxCKcRIBWPKwgjtxKU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-qrbRnewjO_6kumnMeWfF3w-1; Wed, 18 Oct 2023 08:06:57 -0400
X-MC-Unique: qrbRnewjO_6kumnMeWfF3w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9c749c28651so51857666b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 05:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697630816; x=1698235616;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wp+nnpbqnoeHwlS/BrzRice9iJcDcyyrfWzNC6gGiZ0=;
 b=lL14m0AIfvoHH0AOrv3loUkcAgHhMFgj6UVMZHzqHicXoZ75M2RiF8+YADempO6LUY
 Ay3wckpYi06eyJHUgT3a7aniDhQDNmT/NHv5DRyLHC+CfvBX29w27d8htA4TQ8AfMR7C
 Y4apXt3GRGlOk0P/FAbbVN0DKR4z/xmA9N4JWErqMcLecj1ikZjipPMuJAXND7LtAaHZ
 uoo5oQy3Pbr3KjmVOJ4YA++uw0TxN+hm6ysLpmzGqDuG1w3bQyQ5rkwN9nSzNDUh3TCk
 91SBQtIqnqQqBwsn+zsQZnYTiiYQHcRi6uxy0yE8714po/o7dDLUuwzpR7fkaHBR8JV9
 5f+g==
X-Gm-Message-State: AOJu0Yz+HGZ1v2aMshU2SJM2JwRFXEwanEprJtnospM1Sj9UIvK0PAmB
 1aaEvt4+Zutc3KoKggGQcxRCLA0ESaH4v3UZP77DDjcCqZFC1z+p5cuOf4z05dpRF2TEkpiMX78
 nEJAQ/E0nlZH5Tm8=
X-Received: by 2002:a17:907:d48d:b0:9c6:7ec2:e129 with SMTP id
 vj13-20020a170907d48d00b009c67ec2e129mr2478568ejc.42.1697630815808; 
 Wed, 18 Oct 2023 05:06:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYjgZUkH5zaoIxdkrnpv0y6okj95EUGDpmRG5ruQ8aDmWHLiSig5IWNr6XNPBZ6aU7s9zldw==
X-Received: by 2002:a17:907:d48d:b0:9c6:7ec2:e129 with SMTP id
 vj13-20020a170907d48d00b009c67ec2e129mr2478549ejc.42.1697630815284; 
 Wed, 18 Oct 2023 05:06:55 -0700 (PDT)
Received: from redhat.com ([193.142.201.38]) by smtp.gmail.com with ESMTPSA id
 lm18-20020a170906981200b009929d998abcsm1522415ejb.209.2023.10.18.05.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 05:06:54 -0700 (PDT)
Date: Wed, 18 Oct 2023 08:06:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 00/21] Support smp.clusters for x86 in QEMU
Message-ID: <20231018080635-mutt-send-email-mst@kernel.org>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 14, 2023 at 03:21:38PM +0800, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Hi list,
> 
> (CC kvm@vger.kernel.org for better browsing.)
> 
> This is the our v4 patch series, rebased on the master branch at the
> commit 9ef497755afc2 ("Merge tag 'pull-vfio-20230911' of
> https://github.com/legoater/qemu into staging").
> 
> Comparing with v3 [1], v4 mainly refactors the CPUID[0x1F] encoding and
> exposes module level in CPUID[0x1F] with these new patches:
> 
> * [PATCH v4 08/21] i386: Split topology types of CPUID[0x1F] from the
> definitions of CPUID[0xB]
> * [PATCH v4 09/21] i386: Decouple CPUID[0x1F] subleaf with specific
> topology level
> * [PATCH v4 12/21] i386: Expose module level in CPUID[0x1F]
> 
> v4 also fixes compile warnings and fixes cache topology uninitialization
> bugs for some AMD CPUs.
> 
> Welcome your comments!

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> 
> # Introduction
> 
> This series add the cluster support for x86 PC machine, which allows
> x86 can use smp.clusters to configure the module level CPU topology
> of x86.
> 
> And since the compatibility issue (see section: ## Why not share L2
> cache in cluster directly), this series also introduce a new command
> to adjust the topology of the x86 L2 cache.
> 
> Welcome your comments!
> 
> 
> # Background
> 
> The "clusters" parameter in "smp" is introduced by ARM [2], but x86
> hasn't supported it.
> 
> At present, x86 defaults L2 cache is shared in one core, but this is
> not enough. There're some platforms that multiple cores share the
> same L2 cache, e.g., Alder Lake-P shares L2 cache for one module of
> Atom cores [3], that is, every four Atom cores shares one L2 cache.
> Therefore, we need the new CPU topology level (cluster/module).
> 
> Another reason is for hybrid architecture. cluster support not only
> provides another level of topology definition in x86, but would also
> provide required code change for future our hybrid topology support.
> 
> 
> # Overview
> 
> ## Introduction of module level for x86
> 
> "cluster" in smp is the CPU topology level which is between "core" and
> die.
> 
> For x86, the "cluster" in smp is corresponding to the module level [4],
> which is above the core level. So use the "module" other than "cluster"
> in x86 code.
> 
> And please note that x86 already has a cpu topology level also named
> "cluster" [4], this level is at the upper level of the package. Here,
> the cluster in x86 cpu topology is completely different from the
> "clusters" as the smp parameter. After the module level is introduced,
> the cluster as the smp parameter will actually refer to the module level
> of x86.
> 
> 
> ## Why not share L2 cache in cluster directly
> 
> Though "clusters" was introduced to help define L2 cache topology
> [2], using cluster to define x86's L2 cache topology will cause the
> compatibility problem:
> 
> Currently, x86 defaults that the L2 cache is shared in one core, which
> actually implies a default setting "cores per L2 cache is 1" and
> therefore implicitly defaults to having as many L2 caches as cores.
> 
> For example (i386 PC machine):
> -smp 16,sockets=2,dies=2,cores=2,threads=2,maxcpus=16 (*)
> 
> Considering the topology of the L2 cache, this (*) implicitly means "1
> core per L2 cache" and "2 L2 caches per die".
> 
> If we use cluster to configure L2 cache topology with the new default
> setting "clusters per L2 cache is 1", the above semantics will change
> to "2 cores per cluster" and "1 cluster per L2 cache", that is, "2
> cores per L2 cache".
> 
> So the same command (*) will cause changes in the L2 cache topology,
> further affecting the performance of the virtual machine.
> 
> Therefore, x86 should only treat cluster as a cpu topology level and
> avoid using it to change L2 cache by default for compatibility.
> 
> 
> ## module level in CPUID
> 
> Linux kernel (from v6.4, with commit edc0a2b595765 ("x86/topology: Fix
> erroneous smp_num_siblings on Intel Hybrid platforms") is able to
> handle platforms with Module level enumerated via CPUID.1F.
> 
> Expose the module level in CPUID[0x1F] (for Intel CPUs) if the machine
> has more than 1 modules since v3.
> 
> We can configure CPUID.04H.02H (L2 cache topology) with module level by
> a new command:
> 
>         "-cpu,x-l2-cache-topo=cluster"
> 
> More information about this command, please see the section: "## New
> property: x-l2-cache-topo".
> 
> 
> ## New cache topology info in CPUCacheInfo
> 
> Currently, by default, the cache topology is encoded as:
> 1. i/d cache is shared in one core.
> 2. L2 cache is shared in one core.
> 3. L3 cache is shared in one die.
> 
> This default general setting has caused a misunderstanding, that is, the
> cache topology is completely equated with a specific cpu topology, such
> as the connection between L2 cache and core level, and the connection
> between L3 cache and die level.
> 
> In fact, the settings of these topologies depend on the specific
> platform and are not static. For example, on Alder Lake-P, every
> four Atom cores share the same L2 cache [2].
> 
> Thus, in this patch set, we explicitly define the corresponding cache
> topology for different cpu models and this has two benefits:
> 1. Easy to expand to new CPU models in the future, which has different
>    cache topology.
> 2. It can easily support custom cache topology by some command (e.g.,
>    x-l2-cache-topo).
> 
> 
> ## New property: x-l2-cache-topo
> 
> The property x-l2-cache-topo will be used to change the L2 cache
> topology in CPUID.04H.
> 
> Now it allows user to set the L2 cache is shared in core level or
> cluster level.
> 
> If user passes "-cpu x-l2-cache-topo=[core|cluster]" then older L2 cache
> topology will be overrode by the new topology setting.
> 
> Since CPUID.04H is used by Intel CPUs, this property is available on
> Intel CPUs as for now.
> 
> When necessary, it can be extended to CPUID[0x8000001D] for AMD CPUs.
> 
> 
> # Patch description
> 
> patch 1-2 Cleanups about coding style and test name.
> 
> patch 3-5 Fixes about x86 topology and Intel l1 cache topology.
> 
> patch 6-7 Cleanups about topology related CPUID encoding and QEMU
>           topology variables.
> 
> patch 8-9 Refactor CPUID[0x1F] encoding to prepare to introduce module
>           level.
> 
> patch 10-16 Add the module as the new CPU topology level in x86, and it
>             is corresponding to the cluster level in generic code.
> 
> patch 17,18,20 Add cache topology information in cache models.
> 
> patch 19 Update AMD CPUs' cache topology encoding.
> 
> patch 21 Introduce a new command to configure L2 cache topology.
> 
> 
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00022.html
> [2]: https://patchew.org/QEMU/20211228092221.21068-1-wangyanan55@huawei.com/
> [3]: https://www.intel.com/content/www/us/en/products/platforms/details/alder-lake-p.html
> [4]: SDM, vol.3, ch.9, 9.9.1 Hierarchical Mapping of Shared Resources.
> 
> Best Regards,
> Zhao
> ---
> Changelog:
> 
> Changes since v3 (main changes):
>  * Expose module level in CPUID[0x1F].
>  * Fix compile warnings. (Babu)
>  * Fixes cache topology uninitialization bugs for some AMD CPUs. (Babu)
> 
> Changes since v2:
>  * Add "Tested-by", "Reviewed-by" and "ACKed-by" tags.
>  * Use newly added wrapped helper to get cores per socket in
>    qemu_init_vcpu().
> 
> Changes since v1:
>  * Reordered patches. (Yanan)
>  * Deprecated the patch to fix comment of machine_parse_smp_config().
>    (Yanan)
>  * Rename test-x86-cpuid.c to test-x86-topo.c. (Yanan)
>  * Split the intel's l1 cache topology fix into a new separate patch.
>    (Yanan)
>  * Combined module_id and APIC ID for module level support into one
>    patch. (Yanan)
>  * Make cache_into_passthrough case of cpuid 0x04 leaf in
>  * cpu_x86_cpuid() use max_processor_ids_for_cache() and
>    max_core_ids_in_package() to encode CPUID[4]. (Yanan)
>  * Add the prefix "CPU_TOPO_LEVEL_*" for CPU topology level names.
>    (Yanan)
> ---
> Zhao Liu (14):
>   i386: Fix comment style in topology.h
>   tests: Rename test-x86-cpuid.c to test-x86-topo.c
>   hw/cpu: Update the comments of nr_cores and nr_dies
>   i386/cpu: Fix i/d-cache topology to core level for Intel CPU
>   i386/cpu: Use APIC ID offset to encode cache topo in CPUID[4]
>   i386/cpu: Consolidate the use of topo_info in cpu_x86_cpuid()
>   i386: Split topology types of CPUID[0x1F] from the definitions of
>     CPUID[0xB]
>   i386: Decouple CPUID[0x1F] subleaf with specific topology level
>   i386: Expose module level in CPUID[0x1F]
>   i386: Add cache topology info in CPUCacheInfo
>   i386: Use CPUCacheInfo.share_level to encode CPUID[4]
>   i386: Use offsets get NumSharingCache for CPUID[0x8000001D].EAX[bits
>     25:14]
>   i386: Use CPUCacheInfo.share_level to encode
>     CPUID[0x8000001D].EAX[bits 25:14]
>   i386: Add new property to control L2 cache topo in CPUID.04H
> 
> Zhuocheng Ding (7):
>   softmmu: Fix CPUSTATE.nr_cores' calculation
>   i386: Introduce module-level cpu topology to CPUX86State
>   i386: Support modules_per_die in X86CPUTopoInfo
>   i386: Support module_id in X86CPUTopoIDs
>   i386/cpu: Introduce cluster-id to X86CPU
>   tests: Add test case of APIC ID for module level parsing
>   hw/i386/pc: Support smp.clusters for x86 PC machine
> 
>  MAINTAINERS                                   |   2 +-
>  hw/i386/pc.c                                  |   1 +
>  hw/i386/x86.c                                 |  49 ++-
>  include/hw/core/cpu.h                         |   2 +-
>  include/hw/i386/topology.h                    |  68 ++--
>  qemu-options.hx                               |  10 +-
>  softmmu/cpus.c                                |   2 +-
>  target/i386/cpu.c                             | 322 ++++++++++++++----
>  target/i386/cpu.h                             |  46 ++-
>  target/i386/kvm/kvm.c                         |   2 +-
>  tests/unit/meson.build                        |   4 +-
>  .../{test-x86-cpuid.c => test-x86-topo.c}     |  58 ++--
>  12 files changed, 437 insertions(+), 129 deletions(-)
>  rename tests/unit/{test-x86-cpuid.c => test-x86-topo.c} (73%)
> 
> -- 
> 2.34.1


