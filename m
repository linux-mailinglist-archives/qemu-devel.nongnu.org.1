Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F06C9B8CCD
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Nov 2024 09:17:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6mpW-0004r8-9k; Fri, 01 Nov 2024 04:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6mpB-0004nF-No; Fri, 01 Nov 2024 04:16:08 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6mp8-0001N2-FV; Fri, 01 Nov 2024 04:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730448963; x=1761984963;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OeRYF2apaD+NDr933mJ/vBCoF1Va5KOdDbSi5mJxQUk=;
 b=gkSzPysj4x6WrKei9bZ9DEujBxM05JiJtFrQKfbox7PCKWtgnpafjqxN
 wYtPsAvHrs1v7wOTKDWk2MYn/UskOlrZJXOgS3ZFSA0jxQBu6VBwVkZkq
 76flgOA/LHd/jqZNbf4YGTgia+g61vP6ou1E9Ych3ndDjMSzt2MFvZj24
 MtK60Rp2gt9ZEFIrvbVdWxHqAMtgA7MxoB9aKIm2rc8VYHPH+PepWJ6P9
 u9tp3AA2Lr1KtU4UmUAy1+6X0hf6FURKXo2Gl0rL5nBjwNbVR9IKVmhSK
 3l3dchGxXpiQMXqIQw0BCX7dYwM5OLi/LcIRW3Iy9AgPsNE/tKfVM27hv Q==;
X-CSE-ConnectionGUID: +BZgc/hWQvK2JyvV1pYlfg==
X-CSE-MsgGUID: xDzZMAweSE2uoCRKF0Hxvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="17845999"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; d="scan'208";a="17845999"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2024 01:15:59 -0700
X-CSE-ConnectionGUID: FKT23MALQ2CRulJ7gc80ig==
X-CSE-MsgGUID: t3SK6hiQRqeSZcJtirYTcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; d="scan'208";a="86834534"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 01 Nov 2024 01:15:54 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 0/9] Introduce SMP Cache Topology
Date: Fri,  1 Nov 2024 16:33:22 +0800
Message-Id: <20241101083331.340178-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Paolo,

This is my v5, if you think it's okay, could this feature get the final
merge? (Before the 9.2 cycle ends) :-)

Compared with v4 [1], there's no more changes except rebase and adding
Acked/Reviewed-by tags (thanks!).

ARM side has also worked a lot on the smp-cache based on this series [2].

This series is based on the Paolo's for-upstream-i386 (commit 1a519388a882
("target/i386: Introduce GraniteRapids-v2 model")).

Since AMD's Turin model hasn't been picked, there's actually no conflict
at the moment, and this series can be applied to the master as well


Background
==========

The x86 and ARM (RISCV) need to allow user to configure cache properties
(current only topology):
 * For x86, the default cache topology model (of max/host CPU) does not
   always match the Host's real physical cache topology. Performance can
   increase when the configured virtual topology is closer to the
   physical topology than a default topology would be.
 * For ARM, QEMU can't get the cache topology information from the CPU
   registers, then user configuration is necessary. Additionally, the
   cache information is also needed for MPAM emulation (for TCG) to
   build the right PPTT. (Originally from Jonathan)


About smp-cache
===============

The API design has been discussed heavily in [3].

Now, smp-cache is implemented as a array integrated in -machine. Though
-machine currently can't support JSON format, this is the one of the
directions of future.

An example is as follows:

smp_cache=smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=module,smp-cache.3.cache=l3,smp-cache.3.topology=die

"cache" specifies the cache that the properties will be applied on. This
field is the combination of cache level and cache type. Now it supports
"l1d" (L1 data cache), "l1i" (L1 instruction cache), "l2" (L2 unified
cache) and "l3" (L3 unified cache).

"topology" field accepts CPU topology levels including "thread", "core",
"module", "cluster", "die", "socket", "book", "drawer" and a special
value "default".

The "default" is introduced to make it easier for libvirt to set a
default parameter value without having to care about the specific
machine (because currently there is no proper way for machine to
expose supported topology levels and caches).

If "default" is set, then the cache topology will follow the
architecture's default cache topology model. If other CPU topology level
is set, the cache will be shared at corresponding CPU topology level.


[1]: Patch v4: https://lore.kernel.org/qemu-devel/20241022135151.2052198-1-zhao1.liu@intel.com/
[2]: ARM smp-cache: https://lore.kernel.org/qemu-devel/20241010111822.345-1-alireza.sanaee@huawei.com/
[3]: API disscussion: https://lore.kernel.org/qemu-devel/8734ndj33j.fsf@pond.sub.org/

Thanks and Best Regards,
Zhao
---
Changelog:

Changes since Patch v4:
 * Added Acked/Reviewed-by tags.
 * Rebased on Paolo's for-upstream-i386 tag.

Main changes since Patch v3:
 * Stopped exposing "invalid" enumeration in QAPI and define it by a
   macro instead. (Dainel)
 * Checked cache topology after the arch machine loads the
   user-configured cache model from MachineState.smp_cache and consumes
   the special "default" level by replacing it with the specific level.
   (Daniel)
 * Described the omitting cache will use "default" level and described
   the default cache topology model of i386 PC machine. (Daniel)

Main changes since Patch v2:
 * Updated version of new QAPI structures to v9.2. (Jonathan)
 * Merged the QAPI change and smp-cache property support of machine
   into one commit. (Jonathan)
 * Picked Alireza's patch to add a has_caches flag.
 * Polished english and coding style. (Jonathan)

Main changes since Patch v1:
 * Dropped handwriten smp-cache object and integrated cache properties
   list into MachineState and used -machine to configure SMP cache
   properties. (Markus)
 * Dropped prefix of CpuTopologyLevel enumeration. (Markus)
 * Rename CPU_TOPO_LEVEL_* to CPU_TOPOLOGY_LEVEL_* to match the QAPI's
   generated code. (Markus)
 * Renamed SMPCacheProperty/SMPCacheProperties (QAPI structures) to
   SmpCacheProperties/SmpCachePropertiesWrapper. (Markus)
 * Renamed SMPCacheName (QAPI structure) to SmpCacheLevelAndType and
   dropped prefix. (Markus)
 * Renamed 'name' field in SmpCacheProperties to 'cache', since the
   type and level of the cache in SMP system could be able to specify
   all of these kinds of cache explicitly enough.
 * Renamed 'topo' field in SmpCacheProperties to 'topology'. (Markus)
 * Returned error information when user repeats setting cache
   properties. (Markus)
 * Renamed SmpCacheLevelAndType to CacheLevelAndType, since this
   representation is general across SMP or hybrid system.
 * Dropped machine_check_smp_cache_support() and did the check when
   -machine parses smp-cache in machine_parse_smp_cache().

Main changes since RFC v2:
 * Dropped cpu-topology.h and cpu-topology.c since QAPI has the helper
   (CpuTopologyLevel_str) to convert enum to string. (Markus)
 * Fixed text format in machine.json (CpuTopologyLevel naming, 2 spaces
   between sentences). (Markus)
 * Added a new level "default" to de-compatibilize some arch-specific
   topo settings. (Daniel)
 * Moved CpuTopologyLevel to qapi/machine-common.json, at where the
   cache enumeration and smp-cache object would be added.
   - If smp-cache object is defined in qapi/machine.json, storage-daemon
     will complain about the qmp cmds in qapi/machine.json during
     compiling.
 * Referred to Daniel's suggestion to introduce cache JSON list, though
   as a standalone object since -smp/-machine can't support JSON.
 * Linked machine's smp_cache to smp-cache object instead of a builtin
   structure. This is to get around the fact that the keyval format of
   -machine can't support JSON.
 * Wrapped the cache topology level access into a helper.
 * Split as a separate commit to just include compatibility checking and
   topology checking.
 * Allow setting "default" topology level even though the cache
   isn't supported by machine. (Daniel)
 * Rewrote the document of smp-cache object.

Main changes since RFC v1:
 * Split CpuTopology renaimg out of this RFC.
 * Use QAPI to enumerate CPU topology levels.
 * Drop string_to_cpu_topo() since QAPI will help to parse the topo
   levels.
 * Set has_*_cache field in machine_get_smp(). (JeeHeng)
 * Use "*_cache=topo_level" as -smp example as the original "level"
   term for a cache has a totally different meaning. (Jonathan)
---
Alireza Sanaee (1):
  i386/cpu: add has_caches flag to check smp_cache configuration

Zhao Liu (8):
  i386/cpu: Don't enumerate the "invalid" CPU topology level
  hw/core: Make CPU topology enumeration arch-agnostic
  qapi/qom: Define cache enumeration and properties for machine
  hw/core: Check smp cache topology support for machine
  hw/core: Add a helper to check the cache topology level
  i386/cpu: Support thread and module level cache topology
  i386/cpu: Update cache topology with machine's configuration
  i386/pc: Support cache topology in -machine for PC machine

 hw/core/machine-smp.c      | 128 +++++++++++++++++++++
 hw/core/machine.c          |  44 ++++++++
 hw/i386/pc.c               |   4 +
 hw/i386/x86-common.c       |   4 +-
 include/hw/boards.h        |  19 ++++
 include/hw/i386/topology.h |  22 +---
 qapi/machine-common.json   |  94 +++++++++++++++-
 qemu-options.hx            |  31 ++++-
 target/i386/cpu.c          | 225 ++++++++++++++++++++++++-------------
 target/i386/cpu.h          |   4 +-
 10 files changed, 474 insertions(+), 101 deletions(-)

-- 
2.34.1


