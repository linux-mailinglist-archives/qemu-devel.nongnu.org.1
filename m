Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3307770859
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 20:58:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRzyB-0006Cm-3I; Fri, 04 Aug 2023 14:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzxb-0005n9-Sp; Fri, 04 Aug 2023 14:55:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzxa-0000BQ-34; Fri, 04 Aug 2023 14:55:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6DDDF1841B;
 Fri,  4 Aug 2023 21:54:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E26AB1B892;
 Fri,  4 Aug 2023 21:54:01 +0300 (MSK)
Received: (nullmailer pid 1874263 invoked by uid 1000);
 Fri, 04 Aug 2023 18:53:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 00/36] Patch Round-up for stable 7.2.5,
 freeze on 2023-08-05
Date: Fri,  4 Aug 2023 21:53:50 +0300
Message-Id: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

The following patches are queued for QEMU stable v7.2.5:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2023-08-05, and the release is planned for 2023-08-07:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 230dfd9257e9 Olaf Hering:
   hw/ide/piix: properly initialize the BMIBA register
02* d921fea338c1 Mauro Matteo Cascella:
   ui/vnc-clipboard: fix infinite loop in inflate_buffer (CVE-2023-3255)
03* 03b67621445d Denis V. Lunev:
   qemu-nbd: pass structure into nbd_client_thread instead of plain char*
04* 5c56dd27a2c9 Denis V. Lunev:
   qemu-nbd: fix regression with qemu-nbd --fork run over ssh
05 e5b815b0defc Denis V. Lunev:
   qemu-nbd: regression with arguments passing into nbd_client_thread()
06* 761b0aa9381e Ilya Leoshkevich:
   target/s390x: Make CKSM raise an exception if R2 is odd
07* 4b6e4c0b8223 Ilya Leoshkevich:
   target/s390x: Fix CLM with M3=0
08* 53684e344a27 Ilya Leoshkevich:
   target/s390x: Fix CONVERT TO LOGICAL/FIXED with out-of-range inputs
09* a2025557ed4d Ilya Leoshkevich:
   target/s390x: Fix ICM with M3=0
10* 9c028c057adc Ilya Leoshkevich:
   target/s390x: Make MC raise specification exception when class >= 16
11* ff537b0370ab Ilya Leoshkevich:
   target/s390x: Fix assertion failure in VFMIN/VFMAX with type 13
12* c34ad459926f Thomas Huth:
   target/loongarch: Fix the CSRRD CPUID instruction on big endian hosts
13 206e91d14330 Viktor Prutyanov:
   virtio-pci: add handling of PCI ATS and Device-TLB enable/disable
14* ee071f67f7a1 Viktor Prutyanov:
   vhost: register and change IOMMU flag depending on Device-TLB state
15* cd9b83468843 Viktor Prutyanov:
   virtio-net: pass Device-TLB enable/disable events to vhost
16 c6445544d4ce Peter Maydell:
   hw/arm/smmu: Handle big-endian hosts correctly
17 2b0d656ab648 Peter Maydell:
   target/arm: Avoid writing to constant TCGv in trans_CSEL()
18 2e718e665706 Richard Henderson:
   target/ppc: Disable goto_tb with architectural singlestep
19 38dd78c41eaf Helge Deller:
   linux-user/armeb: Fix __kernel_cmpxchg() for armeb
20 07ce178a2b07 Konstantin Kostiuk:
   qga/win32: Use rundll for VSS installation
21 f4f71363fcdb Anthony PERARD:
   thread-pool: signal "request_cond" while locked
22 aa36243514a7 Anthony PERARD:
   xen-block: Avoid leaks on new error path
23 10be627d2b5e Daniel P. Berrangé:
   io: remove io watch if TLS channel is closed during handshake
24 c11d5bdae79a Keith Packard:
   target/nios2: Pass semihosting arg to exit
25 71e2dd6aa1bd Keith Packard:
   target/nios2: Fix semihost lseek offset computation
26 8caaae7319a5 Peter Maydell:
   target/m68k: Fix semihost lseek offset computation
27 cf2f89edf36a Eric Auger:
   hw/virtio-iommu: Fix potential OOB access in virtio_iommu_handle_command()
28 9d38a8434721 zhenwei pi:
   virtio-crypto: verify src&dst buffer length for sym request
29 f8c0fd9804f4 Helge Deller:
   target/hppa: Move iaoq registers and thus reduce generated code size
30 348e354417b6 Yuri Benditovich:
   pci: do not respond config requests after PCI device eject
31 cc2a08480e19 Thomas Huth:
   hw/i386/intel_iommu: Fix trivial endianness problems
32 642ba8967227 Thomas Huth:
   hw/i386/intel_iommu: Fix endianness problems related to VTD_IR_TableEntry
33 4572b22cf9ba Thomas Huth:
   hw/i386/intel_iommu: Fix struct VTDInvDescIEC on big endian hosts
34 fcd802742330 Thomas Huth:
   hw/i386/intel_iommu: Fix index calculation in vtd_interrupt_remap_msi()
35 37cf5cecb039 Thomas Huth:
   hw/i386/x86-iommu: Fix endianness issue in x86_iommu_irq_to_msi_message()
36 e1e56c07d1fa Thomas Huth:
   include/hw/i386/x86-iommu: Fix struct X86IOMMU_MSIMessage for big endian 
   hosts

(commit(s) marked with * were in previous series and are not resent)

