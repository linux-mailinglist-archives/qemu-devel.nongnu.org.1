Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFC0A05F2C
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Jan 2025 15:44:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVXHF-0001K6-Su; Wed, 08 Jan 2025 09:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVXHD-0001Jx-VE
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:43:19 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVXHA-0008Le-VR
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736347397; x=1767883397;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8HbL3R0maWyTV35bsO/QEjd/9N1bmV+pEYCDDGAK5iA=;
 b=YtQ7Spj07UmbxhYQYaBvwCiFgD/gm/uKdEf/gewfGkuMbVv0Dng881+O
 HG4dV0J0rZMb9eLUyZMG3I5H1zP8SdUooVDZ0r97N8bE8XI/FSwsl+1Hr
 +EBm3gLlgYwvTBuxewRLQK5nVJspZXNvUSc1xmt9SRbcMEJOxl2sTnU3l
 MYqsUQ/3BbIlx/ZzRQeI0E4RElUsT54TByA4/2+A9DdFC9uxnMhA63XRR
 WpXvL67YLAdP8l0W8bjOBx0fBbPMhlGZW7qolQq+oJOcWWfnfrP5JCaBq
 oGq/0we0O6amxamW1Lm82lXwWRm0r7HKwDAwYyiYTqBPH/TpVKJsyg1c+ Q==;
X-CSE-ConnectionGUID: Df+zQ4S5SLKeBEI8X1MrnQ==
X-CSE-MsgGUID: 9VMhOgCIQriDwNjY1R4Mcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36737334"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; d="scan'208";a="36737334"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2025 06:43:13 -0800
X-CSE-ConnectionGUID: gEa0wccwQR23jwx9YNum2Q==
X-CSE-MsgGUID: QmPF3t3GQnSNNwgQ+iEEkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="103969384"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 08 Jan 2025 06:43:09 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v7 0/5] i386: Support SMP Cache Topology
Date: Wed,  8 Jan 2025 23:01:45 +0800
Message-Id: <20250108150150.1258529-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi folks,

This is my v7.

Compared with v6 [1], v7 dropped the "thread" level cache topology
(cache per thread):

 - Patch 1 is the new patch to reject "thread" parameter for smp-cache.
 - Ptach 2 dropped cache per thread support.
 (Others remain unchanged.)

There're several reasons:

 * Currently, neither i386 nor ARM have real hardware support for per-
   thread cache.
 * Supporting this special cache topology on ARM requires extra effort
   [2].

So it is unnecessary to support it at this moment, even though per-
thread cache might have potential scheduling benefits for VMs without
CPU affinity.

In the future, if there is a clear demand for this feature, the correct
approach would be to add a new control field in MachineClass.smp_props
and enable it only for the machines that require it.


This series is based on the master branch at commit aa3a285b5bc5 ("Merge
tag 'mem-2024-12-21' of https://github.com/davidhildenbrand/qemu into
staging").

Smp-cache support of ARM side can be found at [3].


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

The API design has been discussed heavily in [4].

Now, smp-cache is implemented as a array integrated in -machine. Though
-machine currently can't support JSON format, this is the one of the
directions of future.

An example is as follows:

smp_cache=smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=module,smp-cache.3.cache=l3,smp-cache.3.topology=die

"cache" specifies the cache that the properties will be applied on. This
field is the combination of cache level and cache type. Now it supports
"l1d" (L1 data cache), "l1i" (L1 instruction cache), "l2" (L2 unified
cache) and "l3" (L3 unified cache).

"topology" field accepts CPU topology levels including "core", "module",
"cluster", "die", "socket", "book", "drawer" and a special value
"default". (Note, now, in v7, smp-cache doesn't support "thread".)

The "default" is introduced to make it easier for libvirt to set a
default parameter value without having to care about the specific
machine (because currently there is no proper way for machine to
expose supported topology levels and caches).

If "default" is set, then the cache topology will follow the
architecture's default cache topology model. If other CPU topology level
is set, the cache will be shared at corresponding CPU topology level.


[1]: Patch v6: https://lore.kernel.org/qemu-devel/20241219083237.265419-1-zhao1.liu@intel.com/
[2]: Gap of cache per thread for ARM: https://lore.kernel.org/qemu-devel/Z3efFsigJ6SxhqMf@intel.com/#t
[3]: ARM smp-cache: https://lore.kernel.org/qemu-devel/20250102152012.1049-1-alireza.sanaee@huawei.com/
[4]: API disscussion: https://lore.kernel.org/qemu-devel/8734ndj33j.fsf@pond.sub.org/

Thanks and Best Regards,
Zhao
---
Alireza Sanaee (1):
  i386/cpu: add has_caches flag to check smp_cache configuration

Zhao Liu (4):
  hw/core/machine: Reject thread level cache
  i386/cpu: Support module level cache topology
  i386/cpu: Update cache topology with machine's configuration
  i386/pc: Support cache topology in -machine for PC machine

 hw/core/machine-smp.c |  9 ++++++
 hw/i386/pc.c          |  4 +++
 include/hw/boards.h   |  3 ++
 qemu-options.hx       | 30 +++++++++++++++++-
 target/i386/cpu.c     | 71 ++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 115 insertions(+), 2 deletions(-)

-- 
2.34.1


