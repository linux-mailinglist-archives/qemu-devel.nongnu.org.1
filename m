Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CECDB0192A
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 12:02:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAZI-00030b-0Y; Fri, 11 Jul 2025 06:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAYS-0001Uz-8e
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:00:32 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAYN-0005Ev-9G
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752228027; x=1783764027;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=H6ETqN1jDQqJmiymH9L23jx+yipT5qi1Rjab222rU/c=;
 b=mpMaNSV+gFhbH9U5kwjMmf91DjAeb0BhD0ZC+X6mOU3xRS3f9qBPhZlR
 jgdcHZL3lgiDO7g0wLYNUtZjjAfAgJTRfw8kQy/UrjRFaPSpzOR25TNmv
 F2ggoK8JzuQ/K9AWqoC8Pd8nvpFIJ2uSSGrIpBpn0RfaV3Z3KfHj1+9Yy
 Wi9KE3APr8/fOSCef4T8IYBGoDbE2k+VGauT1HAoKM0olySweUkVrUl5f
 fb4V5/X5q9QPs1II9No1iY9Jzl5tMejgzVAdoRGSWsvGce7OsfR6Ean1t
 9vHwRUTKdSmJla4OHg7elIT90KN/xH3RlDcOXTBqiITBevNvOooWlTy37 A==;
X-CSE-ConnectionGUID: D7+MGrRGTm2d36/04jYfFw==
X-CSE-MsgGUID: AwJ2yx72T32kdMXwVBBZ9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54496171"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="54496171"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:00:21 -0700
X-CSE-ConnectionGUID: hBW1ChNTQ8OdjBfgFalZAg==
X-CSE-MsgGUID: eeLLId50Rrisyyu/4vYKLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="160661966"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 11 Jul 2025 03:00:16 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 00/18] i386/cpu: Unify the cache model in X86CPUState
Date: Fri, 11 Jul 2025 18:21:25 +0800
Message-Id: <20250711102143.1622339-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi,

This series tries to unify the three cache models currently in
X86CPUState: cache_info_cpuid2, cache_info_cpuid4 and cache_info_amd,
into a single cache_info.

Fix, clean up, and simplify the current x86 CPU cache model support.
Especially, make the cache infomation in CPUID aligns with the vendor's
specifications.

QEMU x86 supports four vendors, and the impact of this series is as
follows:
  * AMD: No change.

  * Hygon (mostly follows AMD): No change.
    - However, I suspect that Hygon should skip the 0x2 and 0x4 leaves
      just like AMD. But since this cannot be confirmed for me, I just
      leave everything unchanged. If necessary, we can fix it.

  * Intel:
    - Clarify the use of legacy_l2_cache_cpuid2. And for very older
      named CPUs ("486", "pentium", "pentium2" and "pentium3") that do
      not support CPUID 0x4, use the cache model like cache_info_cpuid2.
    - For other CPUs, use the cache model like cache_info_cpuid4.
    - CPUID 0x2, 0x4 and 0x80000006 use the consistent cache model.
    - CPUID 0x80000005 is marked reserved as SDM requires.

  * Zhaoxin (mostly follows Intel): mostly consistent with Intel's
    changes, except for CPUID 0x80000005, which follows AMD behavior but
    can correctly use the cache model consistent with CPUID 0x4.

Please note that one significant reason Intel requires so many fixes
(which also implies such confusion) is that Intel's named CPUs currently
do not have specific cache models and instead use the default legacy
cache models. This reflects the importance of adding cache models [1]
for named CPUs.

Philippe already has the patch [2] to remove "legacy-cache" compat
property. I initially intended to base upon his work (which could get
some simplification). However, I found that this series and [2] can be
well decoupled, making it easier to review and apply, so this series now
is based on the master branch at df6fe2abf2e9 ("Merge tag 'pull-target-
arm-20250704' of https://gitlab.com/pm215/qemu into staging").

You can also find the patches at here (branch: cache-model-v3.0-rebase-
07-10-2025):

https://gitlab.com/zhao.liu/qemu/-/tree/cache-model-v3.0-rebase-07-10-2025?ref_type=heads

Lai Yi and I conducted comprehensive testing on as many as possible
cases to ensure compability (Please check the "Test Case" section).


(Next, I will detail the thought process behind the solution. You can
 skip to the end of cover letter for a concise "Patch Summary")

Thanks for your patience and feedback!


Test Cases
==========

Lai Yi and me tested with these cases:

* Intel (this series doesn't add cache model so all Intel CPUs are still
  using legacy cache models):
  - pc-i440fx-6.0/pc-i440fx-10.0/pc-i440fx-10.1
  - Check the CPUID 0x2/0x4/0x80000005/0x80000006

We ensure the cache info isn't changed on v6.0 (x-vendor-cpuid-only is
introduced after v6.0) & v10.0. And v10.1 will use the correct cache
model for all CPUIDs.

* AMD:
  
  Almost all modern AMD CPUs have their own cache model and don't
  use legacy AMD cache model (this series only affect legacy models).

  We compared legacy-cache=on/off on EPYC-Turin. If legacy-cache=on, AMD
  CPU will use legacy cache model. Otherwise, the named CPU has its own
  cache model.
  - pc-i440fx-6.0/pc-i440fx-10.0/pc-i440fx-10.1
  - Check the CPUID 0x2/0x4/0x80000005/0x80000006/0x8000001d

This series doesn't change any cache info for AMD CPUs.

* Zhaoxin: (mostly following Intel)
  - pc-i440fx-6.0/pc-i440fx-10.0/pc-i440fx-10.1
  - Check the CPUID 0x2/0x4/0x80000005/0x80000006

Similarrly, we ensure the cache info isn't changed on v6.0 & v10.0. And
v10.1 will use the correct cache model for all CPUIDs.

(*** TODO: Make all these cases as unit tests. ***)


Background
==========

First of all, this the typical CPUIDs (cache related) from an Intel Guest:

CPU 0:
   ...
   0x00000002 0x00: eax=0x00000001 ebx=0x00000000 ecx=0x0000004d edx=0x002c307d

   * X86CPUState.cache_info_cpuid2:

            L1 data cache:  32K,  8-way, 64 byte lines
     L1 instruction cache:  32K,  8-way, 64 byte lines
                 L2 cache:   2M,  8-way, 64 byte lines  <--- legacy_l2_cache_cpuid2
                 L3 cache:  16M, 16-way, 64 byte lines)

   ...
   0x00000004 0x00: eax=0x00000121 ebx=0x01c0003f ecx=0x0000003f edx=0x00000001
   0x00000004 0x01: eax=0x00000122 ebx=0x01c0003f ecx=0x0000003f edx=0x00000001
   0x00000004 0x02: eax=0x00000143 ebx=0x03c0003f ecx=0x00000fff edx=0x00000001
   0x00000004 0x03: eax=0x00000163 ebx=0x03c0003f ecx=0x00003fff edx=0x00000006
   0x00000004 0x04: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00000000

   * X86CPUState.cache_info_cpuid4:

            L1 data cache:  32K,  8-way, 64 byte lines
     L1 instruction cache:  32K,  8-way, 64 byte lines
                 L2 cache:   4M, 16-way, 64 byte lines  <--- legacy_l2_cache_cpuid4
                 L3 cache:  16M, 16-way, 64 byte lines)

   ...
   0x80000006 0x00: eax=0x00000000 ebx=0x42004200 ecx=0x02008140 edx=0x00808140
   0x80000007 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00000000

   * X86CPUState.cache_info_amd:

            L1 data cache:  64K,  2-way, 64 byte lines  <--- legacy_l1d_cache_amd
     L1 instruction cache:  64K,  2-way, 64 byte lines  <--- legacy_l1i_cache_amd
                 L2 cache: 512K, 16-way, 64 byte lines  <--- legacy_l2_cache_amd
                 L3 cache:  16M, 16-way, 64 byte lines

    Note: L1 & L3 fields should be reserved for Intel in these 2 leaves.


It's quite surprising that an Intel Guest CPU actually includes three
different cache models!

The reason, as I mentioned at the beginning, is that Intel named CPUs
lack the built-in "named" cache model and can only use the legacy cache
model. The issues above are caused by having three legacy cache models.
Of course, host/max CPUs will also have these issues.

Despite the confusion, fortunately, software that follows the SDM will
prefer CPUID 0x4. So, no related bug reports have been observed.

But this issue has already been noticed for quite some time, like the
many "FIXME" notes left by Eduardo:

/*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
/*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
/*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
/*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */


Solution
========

The most challenging thing to fix this issue, is how to handle
compatibility!

Among the legacy cache models, the oldest, legacy_l2_cache_cpuid2, was
introduced during the Pentium era (2007, for more details, please refer
to the commit message of patch 4).

Moreover, after then, QEMU has continuously introduced various compat
properties, making any change likely to have widespread effects. But
eventually, I realized that the most crucial compat property is
"x-vendor-cpuid-only".

And, the entire cleanup process can be divided into two steps:


1. Merge cache_info_cpuid2 and cache_info_cpuid4
------------------------------------------------

These 2 cache models are both used for Intel, but one is used in CPUID
0x2 and another is for 0x4.

I introduced the x-consistent-cache compat property and, according to
the SDM, reworked the encoding of 0x2, marking 0x2 as unavailiable for
cache info. This way, only cache_info_cpuid4 is needed.

For the older CPUs without 0x4 ("486", "pentium", "pentium2" and
"pentium3"), I add a "named" cache model (based on cache_info_cpuid2)
and build it into the definition structures of these old CPU models.


2. Merge cache_info_cpuid4 and cache_info_cpuid_amd
---------------------------------------------------

Merging these two cache models requires consideration of the following
issues:

 1) The final unified cache model is based on the vendor.

 2) Compatibility with older machines is needed:
    - x-vendor-cpuid-only=false for PC v6.0 and older.
    - x-vendor-cpuid-only=true for PC v6.0 to PC v10.0 - and newer).

Therefore, I have the following table to reflect the behavior of
historical machines:

[Table 1: Cache models used in CPUID leaves for different versioned
 machines]

Diagram: C4 = cache_info_cpuid4, CA = cache_info_cpuid_amd

* Intel CPU:

           | x-vendor-cpuid-only=false |  x-vendor-cpuid-only=true  || ideal (x-vendor-cpuid-only-v2=true)
           |    (PC v6.0 and older)    |    (PC v6.0 to PC v10.0)   ||          (PC v10.1 ~)
----------------------------------------------------------------------------------------------------------
       0x2 |           C4              |             C4             ||               C4
           |                           |                            ||
----------------------------------------------------------------------------------------------------------
       0x4 |           C4              |             C4             ||               C4
           |                           |                            ||
----------------------------------------------------------------------------------------------------------
0x80000005 |           CA              |             CA             ||               0 (Reserved)
           |                           |                            ||   [Note: "0" <==> "C4"]
----------------------------------------------------------------------------------------------------------
0x80000006 |           CA              |             CA             ||               C4 (eax=ebx=edx=0)
           |                           |                            ||   [Note: "0" <==> "C4"]
----------------------------------------------------------------------------------------------------------
0x8000001D |           - (Unreached)   |             - (Unreached)  ||               - (Unreached)
           |  [Note: "-" <==> "CA"]    |    [Note: "-" <==> "CA"]   ||   [Note: "0" <==> "C4"]


* AMD CPU:

           | x-vendor-cpuid-only=false |  x-vendor-cpuid-only=true  || ideal (x-vendor-cpuid-only-v2=true)
           |    (PC v6.0 and older)    |    (PC v6.0 to PC v10.0)   ||         (PC v10.1 ~)
----------------------------------------------------------------------------------------------------------
       0x2 |           C4              |             0 (Reserved)   ||               CA
           |                           | [Note: "0" <==> "C4"]      ||
----------------------------------------------------------------------------------------------------------
       0x4 |           C4              |             0 (Reserved)   ||               CA
           |                           | [Note: "0" <==> "C4"]      ||
----------------------------------------------------------------------------------------------------------
0x80000005 |           CA              |             CA             ||               CA
           |                           |                            ||
----------------------------------------------------------------------------------------------------------
0x80000006 |           CA              |             CA             ||               CA
           |                           |                            ||
----------------------------------------------------------------------------------------------------------
0x8000001D |           CA              |             CA             ||               CA
           |                           |                            ||

Our final goal is to select between legacy AMD cache model and legacy
Intel cache model based on the vendor.

At first glance, this table appears very chaotic, seemingly consisting
of various unrelated cases, like a somewhat unsightly monster composed
of "different vendors", "different CPUID leaves", "different versioned
machines", as well as reserved "0" and unreached "-".

But brain teaser!
 * Reserved: If a leaf is reserved, which means whatever the cache
   models it selects, it always have all-0 registers! Thus, we can

   It's valid to consider this leaf as choosing either the Intel cache
   model or the AMD cache model, because the specific values will be
   ignored.

 * Unreached: In practice, it's similar to being reserved, although the
   spec doesn't explicitly state it as reserved. Similarly, choosing any
   cache model doesn't affect the encoding of the "Unreached" leaf.

With this consideration, (and by combining the "Note" in square brackets
within the table,) we can replace the "reserved" and "unreached" cases
with the specific cache models noted in the annotations. This reveals
the underlying pattern:


[Table 2: "Refined" cache models used in CPUID leaves for different
 versioned machines]

* Intel CPU:

           | x-vendor-cpuid-only=false |  x-vendor-cpuid-only=true  || ideal (x-vendor-cpuid-only-v2=true)
           |    (PC v6.0 and older)    |    (PC v6.0 to PC v10.0)   ||          (PC v10.1 ~)
----------------------------------------------------------------------------------------------------------
       0x2 |           C4              |             C4             ||               C4
           |                           |                            ||
----------------------------------------------------------------------------------------------------------
       0x4 |           C4              |             C4             ||               C4
           |                           |                            ||
----------------------------------------------------------------------------------------------------------
0x80000005 |           CA              |             CA             ||              "C4"
           |                           |                            ||
----------------------------------------------------------------------------------------------------------
0x80000006 |           CA              |             CA             ||              "C4"
           |                           |                            ||
----------------------------------------------------------------------------------------------------------
0x8000001D |          "CA"             |            "CA"            ||              "C4"
           |                           |                            ||

* AMD CPU:

           | x-vendor-cpuid-only=false |  x-vendor-cpuid-only=true  || ideal (x-vendor-cpuid-only-v2=true)
           |    (PC v6.0 and older)    |    (PC v6.0 to PC v10.0)   ||         (PC v10.1 ~)
----------------------------------------------------------------------------------------------------------
       0x2 |           C4              |            "C4"            ||               CA
           |                           |                            ||
----------------------------------------------------------------------------------------------------------
       0x4 |           C4              |            "C4"            ||               CA
           |                           |                            ||
----------------------------------------------------------------------------------------------------------
0x80000005 |           CA              |             CA             ||               CA
           |                           |                            ||
----------------------------------------------------------------------------------------------------------
0x80000006 |           CA              |             CA             ||               CA
           |                           |                            ||
----------------------------------------------------------------------------------------------------------
0x8000001D |           CA              |             CA             ||               CA
           |                           |                            ||

Based on Table 2, where the "reserved"/"unreached" fields have been
equivalently replaced, we can see that although x-vendor-cpuid-only
(since v6.1) affects the specific CPUID leaf encoding, its essence can
be regarded as not changing the underlying cache model choice
(cache_info_amd vs. cache_info_cpuid4).

Therefore, we can confidently propose this solution:

 * For v10.1 and future, select legacy cache model based Guest CPU's
   vendor.
   - Then we can merge cache_info_cpuid4 and cache_info_amd into a
     single cache_info, but just initialize cache_info based on vendor.

 * For v10.0 and older:
   - Use legacy Intel cache model (original cache_info_cpuid4) by
     default in CPUID 0x2 and 0x4 leaves.
   - Use legacy AMD cache model (original cache_info_amd) by default
     in CPUID 0x80000005, 0x80000006 and 0x8000001D.


Patch Summary
=============

Patch 01-06: Merge cache_info_cpuid2 and cache_info_cpuid4
Patch 07-16: Merge cache_info_cpuid4 and cache_info_amd

Note: patch 11-15 they each provide more specific evidence that
selecting a legacy cache model based on the Guest vendor in CPUID 0x2,
0x4, 0x80000005, 0x80000006, and 0x8000001D leaves is both valid and
safe, and doesn't break compatibility.


Change Log
==========

Changes Since v1:
 * Add Tested-by & Reviewed-by.
 * Address the comments from Dapeng & Ewan.
 * Split the x-vendor-cpuid-only-v2/AMD_ENC_ASSOC renaming into 2
   seperate patches.


Reference
=========

[1]: https://lore.kernel.org/qemu-devel/20250423114702.1529340-1-zhao1.liu@intel.com/
[2]: https://lore.kernel.org/qemu-devel/20250501223522.99772-9-philmd@linaro.org/
                                                                                                                             

Thanks and Best Regards,
Zhao
---
Zhao Liu (18):
  i386/cpu: Refine comment of CPUID2CacheDescriptorInfo
  i386/cpu: Add descriptor 0x49 for CPUID 0x2 encoding
  i386/cpu: Add default cache model for Intel CPUs with level < 4
  i386/cpu: Present same cache model in CPUID 0x2 & 0x4
  i386/cpu: Consolidate CPUID 0x4 leaf
  i386/cpu: Drop CPUID 0x2 specific cache info in X86CPUState
  i386/cpu: Add x-vendor-cpuid-only-v2 option for compatibility
  i386/cpu: Mark CPUID[0x80000005] as reserved for Intel
  i386/cpu: Rename AMD_ENC_ASSOC to X86_ENC_ASSOC
  i386/cpu: Fix CPUID[0x80000006] for Intel CPU
  i386/cpu: Add legacy_intel_cache_info cache model
  i386/cpu: Add legacy_amd_cache_info cache model
  i386/cpu: Select legacy cache model based on vendor in CPUID 0x2
  i386/cpu: Select legacy cache model based on vendor in CPUID 0x4
  i386/cpu: Select legacy cache model based on vendor in CPUID
    0x80000005
  i386/cpu: Select legacy cache model based on vendor in CPUID
    0x80000006
  i386/cpu: Select legacy cache model based on vendor in CPUID
    0x8000001D
  i386/cpu: Use a unified cache_info in X86CPUState

 hw/i386/pc.c      |   5 +-
 target/i386/cpu.c | 545 +++++++++++++++++++++++++++++-----------------
 target/i386/cpu.h |  25 ++-
 3 files changed, 376 insertions(+), 199 deletions(-)

-- 
2.34.1


