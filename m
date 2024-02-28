Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A550B86B91C
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 21:37:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQeR-00051v-JC; Wed, 28 Feb 2024 15:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfQeM-00050p-Qc; Wed, 28 Feb 2024 15:35:35 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfQeD-0001GR-CG; Wed, 28 Feb 2024 15:35:34 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0D3A45176B;
 Wed, 28 Feb 2024 23:35:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9A0F78BA73;
 Wed, 28 Feb 2024 23:35:21 +0300 (MSK)
Received: (nullmailer pid 267606 invoked by uid 1000);
 Wed, 28 Feb 2024 20:35:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 v1 00/47] Patch Round-up for stable 7.2.10,
 freeze on 2024-03-02
Date: Wed, 28 Feb 2024 23:35:01 +0300
Message-Id: <qemu-stable-7.2.10-20240228233111@cover.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

The following patches are queued for QEMU stable v7.2.10:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2024-03-02, and the release is planned for 2024-03-04:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 27eb8499edb2 Fabiano Rosas:
   migration: Fix use-after-free of migration state object
02* db101376af52 Yihuan Pan:
   qemu-docs: Update options for graphical frontends
03* 615eaeab3d31 Richard W.M. Jones:
   block/blkio: Make s->mem_region_alignment be 64 bits
04* f670be1aad33 Jan Klötzke:
   target/arm: fix exception syndrome for AArch32 bkpt insn
05* d2019a9d0c34 Peter Maydell:
   system/vl.c: Fix handling of '-serial none -serial something'
06* 747bfaf3a9d2 Peter Maydell:
   qemu-options.hx: Improve -serial option documentation
07* 8a7315202033 Guenter Roeck:
   pci-host: designware: Limit value range of iATU viewport register
08* cd8a35b913c2 Akihiko Odaki:
   hw/smbios: Fix OEM strings table option validation
09* 196578c9d051 Akihiko Odaki:
   hw/smbios: Fix port connector option validation
10* aa05bd9ef407 Andrey Ignatov:
   vhost-user.rst: Fix vring address description
11* c62926f730d0 Ira Weiny:
   cxl/cdat: Handle cdat table build errors
12* 64fdad5e6758 Ira Weiny:
   cxl/cdat: Fix header sum value in CDAT checksum
13* 729d45a6af06 Li Zhijian:
   hw/cxl: Pass CXLComponentState to cache_mem_ops
14* 9a457383ce9d Zhenzhong Duan:
   virtio_iommu: Clear IOMMUPciBus pointer cache when system reset
15* 8a6b3f4dc95a Zhenzhong Duan:
   smmu: Clear SMMUPciBus pointer cache when system reset
16* 14ec4ff3e429 Jonathan Cameron:
   tests/acpi: Allow update of DSDT.cxl
17* d9ae5802f656 Jonathan Cameron:
   hw/i386: Fix _STA return value for ACPI0017
18* b24a981b9f1c Jonathan Cameron:
   tests/acpi: Update DSDT.cxl to reflect change _STA return value.
19* 681dfc0d5529 Richard Henderson:
   linux-user/aarch64: Choose SYNC as the preferred MTE mode
20* 64c6e7444dff Richard Henderson:
   target/arm: Fix nregs computation in do_{ld,st}_zpa
21* 855f94eca80c Richard Henderson:
   target/arm: Fix SVE/SME gross MTE suppression checks
22* ac1d88e9e7ca Peter Maydell:
   target/arm: Don't get MDCR_EL2 in pmu_counter_enabled() before checking 
   ARM_FEATURE_PMU
23* cc29c12ec629 Kevin Wolf:
   iotests: Make 144 deterministic again
24* 81f5cad3858f Xiaoyao Li:
   i386/cpu: Clear FEAT_XSAVE_XSS_LO/HI leafs when CPUID_EXT_XSAVE is not 
   available
25* a11a365159b9 Xiaoyao Li:
   i386/cpu: Mask with XCR0/XSS mask for FEAT_XSAVE_XCR0_HI and 
   FEAT_XSAVE_XSS_HI leafs
26* 10f92799af8b Xiaoyao Li:
   i386/cpuid: Decrease cpuid_i when skipping CPUID leaf 1F
27* 0729857c7075 Xiaoyao Li:
   i386/cpuid: Move leaf 7 to correct group
28* 99d0dcd7f102 Ziqiao Kong:
   target/i386: Generate an illegal opcode exception on cmp instructions 
   with lock prefix
29* 4cba8388968b Daniel P. Berrangé:
   ui: reject extended clipboard message if not activated
30* 405484b29f65 Fiona Ebner:
   ui/clipboard: mark type as not available when there is no data
31* 9c416582611b Fiona Ebner:
   ui/clipboard: add asserts for update and request
32* 95b08fee8f68 Tianlan Zhou:
   ui/console: Fix console resize with placeholder surface
33 1222070e7728 Marc-André Lureau:
   meson: ensure dbus-display generated code is built before other units
34* d67611907590 Akihiko Odaki:
   audio: Depend on dbus_display1_dep
35 4a20ac400ff0 Tianlan Zhou:
   docs/system: Update description for input grab key
36 185311130f54 Tianlan Zhou:
   system/vl: Update description for input grab key
37 5cd3ae4903e3 Peter Maydell:
   .gitlab-ci.d/windows.yml: Drop msys2-32bit job
38 2cc0e449d173 Nicholas Piggin:
   target/ppc: Fix lxv/stxv MSR facility check
39 d2b5bb860e6c Klaus Jensen:
   hw/nvme: fix invalid endian conversion
40 4d28d57c9f2e Jessica Clarke:
   pl031: Update last RTCLR value on write in case it's read back
41 68fb78d7d572 Paolo Bonzini:
   target/i386: mask high bits of CR3 in 32-bit mode
42 d09c79010ffd Paolo Bonzini:
   target/i386: check validity of VMCB addresses
43 b1661801c184 Paolo Bonzini:
   target/i386: Fix physical address truncation
44 a28fe7dc1939 Paolo Bonzini:
   target/i386: remove unnecessary/wrong application of the A20 mask
45 b5a9de3259f4 Paolo Bonzini:
   target/i386: leave the A20 bit set in the final NPT walk
46 8467ac75b3b7 Alex Bennée:
   tests/vm: update openbsd image to 7.4
47 151b7dba391f Alex Bennée:
   tests/vm: avoid re-building the VM images all the time

(commit(s) marked with * were in previous series and are not resent)

