Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CDC74DD8B
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 20:43:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIvqh-0006SW-Hl; Mon, 10 Jul 2023 14:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIvqe-0006SB-TD
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 14:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIvqc-0001EI-Fj
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 14:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689014577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3lvYptRYi+BwG6RQVPzSArWbTc+yFRlbDq0PQkd5K8Q=;
 b=eIh76D1CuAz9u2BWQjrTuNLk/8GAjYCYpivKmHO3sUBfvqcGkASX0X030LLL8x0Kv42qi7
 JAByZZP7yGuuNGc159kw7j4gagROXP3sJ7AQVczs8DkZn1jMFe2TcUULqL7GGBHSufHgi2
 URBmlj/lKm/BMYTLYAJnCvQJTEPzatQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-O8pe_syxNEqEB5OhQNdfXw-1; Mon, 10 Jul 2023 14:42:56 -0400
X-MC-Unique: O8pe_syxNEqEB5OhQNdfXw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso2465595f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 11:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689014575; x=1691606575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lvYptRYi+BwG6RQVPzSArWbTc+yFRlbDq0PQkd5K8Q=;
 b=Cg9Ila3ENNuDZKsYj8i2AVqYJDg7YjftHfYZfHYlqi6K5MQDIWezb4dNnU3vB8qEQ9
 nKFLgTwkcPLNlEg8saLE5SfQ3tRyEbUH19YZOXYCbL6bVNZ5TnGGI38SWxE1Tiqt5Ham
 LBuNRCFylh3EkorCJZXkyM61L1LwJ9xbiW0kDe0XvB6oonrC7zGNSCygOvocAHElmcrT
 jUEwWHJvslZfDcO8vy+kJt2PgGyvdUB6X+5GqtOTREhwKuxYixjDxXgXBfCob9D0eIan
 PuyY4ofxgu2t6/iAZswIW8JlRTl1GQhKTJakGkxhSsa0hD1GXkt7xFDnVrlXYjExCvpC
 6Odg==
X-Gm-Message-State: ABy/qLZ0ZA2kDEy/i84xOdr1lwQZEyRRJCXexCqbMSeF38zbqkumvukf
 cSlPMMqHT/SnL1Dt5u+s+DJTbqYSZYieXy/B58myimqvsFyw5lGKkQjkajLDixxd+gHO3JcyV8h
 lsyzPFa3tZtF343k=
X-Received: by 2002:a5d:6789:0:b0:313:e8bf:a77 with SMTP id
 v9-20020a5d6789000000b00313e8bf0a77mr12199139wru.5.1689014575108; 
 Mon, 10 Jul 2023 11:42:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHmmTL8KxWP0RHOA945CgLZMWRhAGxf3tdiKVJ0ujs/SYq9FGjZigbau3Dw5ofwP+LsX0Q5lw==
X-Received: by 2002:a5d:6789:0:b0:313:e8bf:a77 with SMTP id
 v9-20020a5d6789000000b00313e8bf0a77mr12199127wru.5.1689014574794; 
 Mon, 10 Jul 2023 11:42:54 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 y3-20020a056000108300b003141f96ed36sm176438wrw.0.2023.07.10.11.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 11:42:54 -0700 (PDT)
Date: Mon, 10 Jul 2023 14:42:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 00/17] Support smp.clusters for x86
Message-ID: <20230710144242-mutt-send-email-mst@kernel.org>
References: <20230529123101.411267-1-zhao1.liu@linux.intel.com>
 <20230622161427-mutt-send-email-mst@kernel.org>
 <ZJuKTl9RJet6FEO2@liuzhao-OptiPlex-7080>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJuKTl9RJet6FEO2@liuzhao-OptiPlex-7080>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, Jun 28, 2023 at 09:18:06AM +0800, Zhao Liu wrote:
> On Thu, Jun 22, 2023 at 04:14:44PM -0400, Michael S. Tsirkin wrote:
> > Date: Thu, 22 Jun 2023 16:14:44 -0400
> > From: "Michael S. Tsirkin" <mst@redhat.com>
> > Subject: Re: [PATCH v2 00/17] Support smp.clusters for x86
> > 
> > On Mon, May 29, 2023 at 08:30:44PM +0800, Zhao Liu wrote:
> > > From: Zhao Liu <zhao1.liu@intel.com>
> > > 
> > > Hi list,
> > > 
> > > This is the our v2 patch series, rebased on the master branch at the
> > > commit ac84b57b4d74 ("Merge tag 'for-upstream' of
> > > https://gitlab.com/bonzini/qemu into staging").
> > > 
> > > Comparing with v1 [1], v2 mainly reorganizes patches and does some
> > > cleanup.
> > > 
> > > This series add the cluster support for x86 PC machine, which allows
> > > x86 can use smp.clusters to configure the modlue level CPU topology
> > > of x86.
> > > 
> > > And since the compatibility issue (see section: ## Why not share L2
> > > cache in cluster directly), this series also introduce a new command
> > > to adjust the topology of the x86 L2 cache.
> > > 
> > > Welcome your comments!
> > 
> > PC things:
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> 
> Thanks Michael!
> 
> Could I double check if I can add your ACK tag to the following patches?
> 
> [PATCH v2 01/17] i386: Fix comment style in topology.h
> [PATCH v2 02/17] tests: Rename test-x86-cpuid.c to test-x86-topo.c
> [PATCH v2 07/17] i386: Introduce module-level cpu topology to
> CPUX86State
> [PATCH v2 08/17] i386: Support modules_per_die in X86CPUTopoInfo
> [PATCH v2 09/17] i386: Support module_id in X86CPUTopoIDs
> [PATCH v2 10/17] i386/cpu: Introduce cluster-id to X86CPU
> [PATCH v2 11/17] tests: Add test case of APIC ID for module level parsing
> [PATCH v2 12/17] hw/i386/pc: Support smp.clusters for x86 PC machine
> 
> Zhao

Sure

> > 
> > 
> > > 
> > > # Backgroud
> > > 
> > > The "clusters" parameter in "smp" is introduced by ARM [2], but x86
> > > hasn't supported it.
> > > 
> > > At present, x86 defaults L2 cache is shared in one core, but this is
> > > not enough. There're some platforms that multiple cores share the
> > > same L2 cache, e.g., Alder Lake-P shares L2 cache for one module of
> > > Atom cores [3], that is, every four Atom cores shares one L2 cache.
> > > Therefore, we need the new CPU topology level (cluster/module).
> > > 
> > > Another reason is for hybrid architecture. cluster support not only
> > > provides another level of topology definition in x86, but would aslo
> > > provide required code change for future our hybrid topology support.
> > > 
> > > 
> > > # Overview
> > > 
> > > ## Introduction of module level for x86
> > > 
> > > "cluster" in smp is the CPU topology level which is between "core" and
> > > die.
> > > 
> > > For x86, the "cluster" in smp is corresponding to the module level [4],
> > > which is above the core level. So use the "module" other than "cluster"
> > > in x86 code.
> > > 
> > > And please note that x86 already has a cpu topology level also named
> > > "cluster" [4], this level is at the upper level of the package. Here,
> > > the cluster in x86 cpu topology is completely different from the
> > > "clusters" as the smp parameter. After the module level is introduced,
> > > the cluster as the smp parameter will actually refer to the module level
> > > of x86.
> > > 
> > > 
> > > ## Why not share L2 cache in cluster directly
> > > 
> > > Though "clusters" was introduced to help define L2 cache topology
> > > [2], using cluster to define x86's L2 cache topology will cause the
> > > compatibility problem:
> > > 
> > > Currently, x86 defaults that the L2 cache is shared in one core, which
> > > actually implies a default setting "cores per L2 cache is 1" and
> > > therefore implicitly defaults to having as many L2 caches as cores.
> > > 
> > > For example (i386 PC machine):
> > > -smp 16,sockets=2,dies=2,cores=2,threads=2,maxcpus=16 (*)
> > > 
> > > Considering the topology of the L2 cache, this (*) implicitly means "1
> > > core per L2 cache" and "2 L2 caches per die".
> > > 
> > > If we use cluster to configure L2 cache topology with the new default
> > > setting "clusters per L2 cache is 1", the above semantics will change
> > > to "2 cores per cluster" and "1 cluster per L2 cache", that is, "2
> > > cores per L2 cache".
> > > 
> > > So the same command (*) will cause changes in the L2 cache topology,
> > > further affecting the performance of the virtual machine.
> > > 
> > > Therefore, x86 should only treat cluster as a cpu topology level and
> > > avoid using it to change L2 cache by default for compatibility.
> > > 
> > > 
> > > ## module level in CPUID
> > > 
> > > Currently, we don't expose module level in CPUID.1FH because currently
> > > linux (v6.2-rc6) doesn't support module level. And exposing module and
> > > die levels at the same time in CPUID.1FH will cause linux to calculate
> > > wrong die_id. The module level should be exposed until the real machine
> > > has the module level in CPUID.1FH.
> > > 
> > > We can configure CPUID.04H.02H (L2 cache topology) with module level by
> > > a new command:
> > > 
> > >         "-cpu,x-l2-cache-topo=cluster"
> > > 
> > > More information about this command, please see the section: "## New
> > > property: x-l2-cache-topo".
> > > 
> > > 
> > > ## New cache topology info in CPUCacheInfo
> > > 
> > > Currently, by default, the cache topology is encoded as:
> > > 1. i/d cache is shared in one core.
> > > 2. L2 cache is shared in one core.
> > > 3. L3 cache is shared in one die.
> > > 
> > > This default general setting has caused a misunderstanding, that is, the
> > > cache topology is completely equated with a specific cpu topology, such
> > > as the connection between L2 cache and core level, and the connection
> > > between L3 cache and die level.
> > > 
> > > In fact, the settings of these topologies depend on the specific
> > > platform and are not static. For example, on Alder Lake-P, every
> > > four Atom cores share the same L2 cache [2].
> > > 
> > > Thus, in this patch set, we explicitly define the corresponding cache
> > > topology for different cpu models and this has two benefits:
> > > 1. Easy to expand to new CPU models in the future, which has different
> > >    cache topology.
> > > 2. It can easily support custom cache topology by some command (e.g.,
> > >    x-l2-cache-topo).
> > > 
> > > 
> > > ## New property: x-l2-cache-topo
> > > 
> > > The property l2-cache-topo will be used to change the L2 cache topology
> > > in CPUID.04H.
> > > 
> > > Now it allows user to set the L2 cache is shared in core level or
> > > cluster level.
> > > 
> > > If user passes "-cpu x-l2-cache-topo=[core|cluster]" then older L2 cache
> > > topology will be overrided by the new topology setting.
> > > 
> > > Since CPUID.04H is used by intel cpus, this property is available on
> > > intel cpus as for now.
> > > 
> > > When necessary, it can be extended to CPUID[0x8000001D] for amd cpus.
> > > 
> > > 
> > > # Patch description
> > > 
> > > patch 1-2 Cleanups about coding style and test name.
> > > 
> > > patch 3-4,15 Fixes about x86 topology, intel l1 cache topology and amd
> > >              cache topology encoding.
> > > 
> > > patch 5-6 Cleanups about topology related CPUID encoding and QEMU
> > >           topology variables.
> > > 
> > > patch 7-12 Add the module as the new CPU topology level in x86, and it
> > >            is corresponding to the cluster level in generic code.
> > > 
> > > patch 13,14,16 Add cache topology infomation in cache models.
> > > 
> > > patch 17 Introduce a new command to configure L2 cache topology.
> > > 
> > > 
> > > [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg03184.html
> > > [2]: https://patchew.org/QEMU/20211228092221.21068-1-wangyanan55@huawei.com/
> > > [3]: https://www.intel.com/content/www/us/en/products/platforms/details/alder-lake-p.html
> > > [4]: SDM, vol.3, ch.9, 9.9.1 Hierarchical Mapping of Shared Resources.
> > > 
> > > Best Regards,
> > > Zhao
> > > 
> > > ---
> > > Changelog:
> > > 
> > > Changes since v1:
> > >  * Reordered patches. (Yanan)
> > >  * Deprecated the patch to fix comment of machine_parse_smp_config().
> > >    (Yanan)
> > >  * Rename test-x86-cpuid.c to test-x86-topo.c. (Yanan)
> > >  * Split the intel's l1 cache topology fix into a new separate patch.
> > >    (Yanan)
> > >  * Combined module_id and APIC ID for module level support into one
> > >    patch. (Yanan)
> > >  * Make cache_into_passthrough case of cpuid 0x04 leaf in
> > >  * cpu_x86_cpuid() use max_processor_ids_for_cache() and
> > >    max_core_ids_in_package() to encode CPUID[4]. (Yanan)
> > >  * Add the prefix "CPU_TOPO_LEVEL_*" for CPU topology level names.
> > >    (Yanan)
> > >  * Rename the "INVALID" level to "CPU_TOPO_LEVEL_UNKNOW". (Yanan)
> > > 
> > > ---
> > > Zhao Liu (10):
> > >   i386: Fix comment style in topology.h
> > >   tests: Rename test-x86-cpuid.c to test-x86-topo.c
> > >   i386/cpu: Fix i/d-cache topology to core level for Intel CPU
> > >   i386/cpu: Use APIC ID offset to encode cache topo in CPUID[4]
> > >   i386/cpu: Consolidate the use of topo_info in cpu_x86_cpuid()
> > >   i386: Add cache topology info in CPUCacheInfo
> > >   i386: Use CPUCacheInfo.share_level to encode CPUID[4]
> > >   i386: Fix NumSharingCache for CPUID[0x8000001D].EAX[bits 25:14]
> > >   i386: Use CPUCacheInfo.share_level to encode
> > >     CPUID[0x8000001D].EAX[bits 25:14]
> > >   i386: Add new property to control L2 cache topo in CPUID.04H
> > > 
> > > Zhuocheng Ding (7):
> > >   softmmu: Fix CPUSTATE.nr_cores' calculation
> > >   i386: Introduce module-level cpu topology to CPUX86State
> > >   i386: Support modules_per_die in X86CPUTopoInfo
> > >   i386: Support module_id in X86CPUTopoIDs
> > >   i386/cpu: Introduce cluster-id to X86CPU
> > >   tests: Add test case of APIC ID for module level parsing
> > >   hw/i386/pc: Support smp.clusters for x86 PC machine
> > > 
> > >  MAINTAINERS                                   |   2 +-
> > >  hw/i386/pc.c                                  |   1 +
> > >  hw/i386/x86.c                                 |  49 +++++-
> > >  include/hw/core/cpu.h                         |   2 +-
> > >  include/hw/i386/topology.h                    |  68 +++++---
> > >  qemu-options.hx                               |  10 +-
> > >  softmmu/cpus.c                                |   2 +-
> > >  target/i386/cpu.c                             | 158 ++++++++++++++----
> > >  target/i386/cpu.h                             |  25 +++
> > >  tests/unit/meson.build                        |   4 +-
> > >  .../{test-x86-cpuid.c => test-x86-topo.c}     |  58 ++++---
> > >  11 files changed, 280 insertions(+), 99 deletions(-)
> > >  rename tests/unit/{test-x86-cpuid.c => test-x86-topo.c} (73%)
> > > 
> > > -- 
> > > 2.34.1
> > 


