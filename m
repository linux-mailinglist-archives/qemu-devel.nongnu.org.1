Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCFCAE5E68
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Jun 2025 09:50:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTyPG-00009U-A1; Tue, 24 Jun 2025 03:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1uTyPC-00008Z-Oy
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 03:49:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1uTyPA-0007Se-9A
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 03:49:22 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O7fcC5004449;
 Tue, 24 Jun 2025 07:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=S7Y4Y7QwwEtPGhQ1qP1HYcOK4wPf+
 b0BqE47i5KwRoM=; b=BvbCpUm50VeeglHZqnre6bELCwnPjJT/u4K0xpUZhB1uF
 R0O4/HYKk5K84acWjwyhwmQbEKTmlh7eX7V+uhDir4Oj5kgzeVQE+LPvS2uIpkZk
 015ouTb/QUbZOgUiGnoDt9nfLoD2lviTVesAgDQpgHtab2ULkvs04oNhltZgXckv
 drvDFeT1qKkLvS1hrwb3Gd+vRj8mbJswfIiEHsJsPXc/nIQIync1t0x+XgglufP2
 0qdhHVp8/srPfE6aG4B+OoVOkeCmOtpD6/GEjRq7FZEogf6+EvdALhvPp3z+y8tu
 ZoJ4gpV5FNSVjKWiSGs1F9hd9TeWuYc2YnXPziLqw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds87vh69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Jun 2025 07:49:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55O61ju6006903; Tue, 24 Jun 2025 07:49:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ehq3ar21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Jun 2025 07:49:06 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55O7n5Xg006279;
 Tue, 24 Jun 2025 07:49:05 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 47ehq3ar1g-1; Tue, 24 Jun 2025 07:49:05 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
Subject: [PATCH v6 0/9] target/i386/kvm/pmu: PMU Enhancement,
 Bugfix and Cleanup
Date: Tue, 24 Jun 2025 00:43:19 -0700
Message-ID: <20250624074421.40429-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506240066
X-Authority-Analysis: v=2.4 cv=a8gw9VSF c=1 sm=1 tr=0 ts=685a5873 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=NMLfzRoFxyNNWpThmMoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA2NiBTYWx0ZWRfXwpoWEKNgMOMA
 7xd/beEobb0j6gSjTXMzXh+FINFKr21EtiSvlzOT9OX1NG/hz6lRaCbEdlcGUXENiL7CDFipAvV
 FC9f+nwCT/eCPS7z/kzsVrcfmKOfl0RozOms3Cw1Dv+wNpqSyfCOolC6GwXUFIS2zNaCQ0ofd0x
 oqSaahQpjw6oJougwPxIu0m3XVXPKLeyNsYuaI+853lvlcQkWGB4NaNu6k2kIy4QPbJrBEU6bKd
 CSx11UtQjSrBtgGzUbQ5WsIJoQsV3Epwgq5vv6YSI5sg5UsYWYPFMivTwoMQxU7UhJ69JSJ4nXy
 mq56NAkwGLOjR4D1YAi+QMp0F5fM902MpFwpRyOWUZ/8MYhtQH2aszsG0SchGUKslK2S8F9nSCn
 IrhuJfGCa/kX4dRSOOd0A/KVrVXtn/oI1qdRGXvws2e7AeNR6NNKNh6f6Fl+DfySHI0API4x
X-Proofpoint-GUID: worRoaCAl4saazWi9G0Tb24k3A2AI21c
X-Proofpoint-ORIG-GUID: worRoaCAl4saazWi9G0Tb24k3A2AI21c
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This patchset addresses four bugs related to AMD PMU virtualization.

1. The PerfMonV2 is still available if PERCORE if disabled via
"-cpu host,-perfctr-core".

2. The VM 'cpuid' command still returns PERFCORE although "-pmu" is
configured.

3. The third issue is that using "-cpu host,-pmu" does not disable AMD PMU
virtualization. When using "-cpu EPYC" or "-cpu host,-pmu", AMD PMU
virtualization remains enabled. On the VM's Linux side, you might still
see:

[    0.510611] Performance Events: Fam17h+ core perfctr, AMD PMU driver.

instead of:

[    0.596381] Performance Events: PMU not available due to virtualization, using software events only.
[    0.600972] NMI watchdog: Perf NMI watchdog permanently disabled

To address this, KVM_CAP_PMU_CAPABILITY is used to set KVM_PMU_CAP_DISABLE
when "-pmu" is configured.

4. The fourth issue is that unreclaimed performance events (after a QEMU
system_reset) in KVM may cause random, unwanted, or unknown NMIs to be
injected into the VM.

The AMD PMU registers are not reset during QEMU system_reset.

(1) If the VM is reset (e.g., via QEMU system_reset or VM kdump/kexec) while
running "perf top", the PMU registers are not disabled properly.

(2) Despite x86_cpu_reset() resetting many registers to zero, kvm_put_msrs()
does not handle AMD PMU registers, causing some PMU events to remain
enabled in KVM.

(3) The KVM kvm_pmc_speculative_in_use() function consistently returns true,
preventing the reclamation of these events. Consequently, the
kvm_pmc->perf_event remains active.

(4) After a reboot, the VM kernel may report the following error:

[    0.092011] Performance Events: Fam17h+ core perfctr, Broken BIOS detected, complain to your hardware vendor.
[    0.092023] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 530076)

(5) In the worst case, the active kvm_pmc->perf_event may inject unknown
NMIs randomly into the VM kernel:

[...] Uhhuh. NMI received for unknown reason 30 on CPU 0.

To resolve these issues, we propose resetting AMD PMU registers during the
VM reset process


Changed since v1:
  - Use feature_dependencies for CPUID_EXT3_PERFCORE and
    CPUID_8000_0022_EAX_PERFMON_V2.
  - Remove CPUID_EXT3_PERFCORE when !cpu->enable_pmu.
  - Pick kvm_arch_pre_create_vcpu() patch from Xiaoyao Li.
  - Use "-pmu" but not a global "pmu-cap-disabled" for KVM_PMU_CAP_DISABLE.
  - Also use sysfs kvm.enable_pmu=N to determine if PMU is supported.
  - Some changes to PMU register limit calculation.
Changed since v2:
  - Change has_pmu_cap to pmu_cap.
  - Use cpuid_find_entry() instead of cpu_x86_cpuid().
  - Rework the code flow of PATCH 07 related to kvm.enable_pmu=N following
    Zhao's suggestion.
  - Use object_property_get_int() to get CPU family.
  - Add support to Zhaoxin.
Changed since v3:
  - Re-base on top of Zhao's queued patch.
  - Use host_cpu_vendor_fms() from Zhao's patch.
  - Pick new version of kvm_arch_pre_create_vcpu() patch from Xiaoyao.
  - Re-split the cases into enable_pmu and !enable_pmu, following Zhao's
    suggestion.
  - Check AMD directly makes the "compat" rule clear.
  - Some changes on commit message and comment.
  - Bring back global static variable 'kvm_pmu_disabled' read from
    /sys/module/kvm/parameters/enable_pmu.
Changed since v4:
  - Re-base on top of most recent mainline QEMU.
  - Add more Reviewed-by.
  - All patches are reviewed.
Changed since v5:
  - Re-base on top of most recent mainline QEMU.
  - Remove patch "kvm: Introduce kvm_arch_pre_create_vcpu()" as it is
    already merged.
  - To resolve conflicts in new [PATCH v6 3/9] , move the PMU related code
    before the call site of is_tdx_vm().


There is regression in mainline QEMU when "vendor=" is involved in QEMU
command line. I have reverted it when testing with "vendor=".

https://lore.kernel.org/all/d429b6f5-b59c-4884-b18f-8db71cb8dc7b@oracle.com/


Dongli Zhang (9):
  target/i386: disable PerfMonV2 when PERFCORE unavailable
  target/i386: disable PERFCORE when "-pmu" is configured
  target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu" is configured
  target/i386/kvm: extract unrelated code out of kvm_x86_build_cpuid()
  target/i386/kvm: rename architectural PMU variables
  target/i386/kvm: query kvm.enable_pmu parameter
  target/i386/kvm: reset AMD PMU registers during VM reset
  target/i386/kvm: support perfmon-v2 for reset
  target/i386/kvm: don't stop Intel PMU counters

 target/i386/cpu.c     |   8 +
 target/i386/cpu.h     |  16 ++
 target/i386/kvm/kvm.c | 355 +++++++++++++++++++++++++++++++++++++++------
 3 files changed, 332 insertions(+), 47 deletions(-)

base-commit: 43ba160cb4bbb193560eb0d2d7decc4b5fc599fe

Thank you very much!

Dongli Zhang


