Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A4B7711DF
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 21:41:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSN9a-0007Yy-GK; Sat, 05 Aug 2023 15:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSN9X-0007Xu-QA; Sat, 05 Aug 2023 15:41:31 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSN9V-0007rF-Pj; Sat, 05 Aug 2023 15:41:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BC40D1865C;
 Sat,  5 Aug 2023 22:41:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 98E1F1BA42;
 Sat,  5 Aug 2023 22:41:27 +0300 (MSK)
Received: (nullmailer pid 70344 invoked by uid 1000);
 Sat, 05 Aug 2023 19:41:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 00/71] Patch Round-up for stable 8.0.4,
 freeze on 2023-08-05
Date: Sat,  5 Aug 2023 22:41:04 +0300
Message-Id: <qemu-stable-8.0.4-20230805223954@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v8.0.4:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-8.0

Patch freeze is 2023-08-05, and the release is planned for 2023-08-07:

  https://wiki.qemu.org/Planning/8.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 4271f4038372 Laurent Vivier:
   virtio-net: correctly report maximum tx_queue_size value
02* ca2a5e630dc1 Fiona Ebner:
   qemu_cleanup: begin drained section after vm_shutdown()
03* 2ad2e113deb5 Nicholas Piggin:
   hw/ppc: Fix clock update drift
04* e0ddf8eac9f8 Helge Deller:
   linux-user: Fix fcntl() and fcntl64() to return O_LARGEFILE for 32-bit 
   targets
05* dca4c8384d68 Helge Deller:
   linux-user: Fix accept4(SOCK_NONBLOCK) syscall
06* 8af87a3ec7e4 Avihai Horon:
   vfio: Fix null pointer dereference bug in vfio_bars_finalize()
07* 110b1bac2ecd Ilya Leoshkevich:
   target/s390x: Fix EPSW CC reporting
08* fed9a4fe0ce0 Ilya Leoshkevich:
   target/s390x: Fix MDEB and MDEBR
09* 92a57534619a Ilya Leoshkevich:
   target/s390x: Fix MVCRL with a large value in R0
10* 6da311a60d58 Ilya Leoshkevich:
   target/s390x: Fix LRA overwriting the top 32 bits on DAT error
11* b0ef81062d24 Ilya Leoshkevich:
   target/s390x: Fix LRA when DAT is off
12* baf21eebc3e1 Marcin Nowakowski:
   target/mips: enable GINVx support for I6400 and I6500
13* 230dfd9257e9 Olaf Hering:
   hw/ide/piix: properly initialize the BMIBA register
14* 7a8d9f3a0e88 Pierrick Bouvier:
   linux-user/syscall: Implement execve without execveat
15* e18ed26ce785 Richard Henderson:
   tcg: Fix info_in_idx increment in layout_arg_by_ref
16* d713cf4d6c71 Philippe Mathieu-Daudé:
   linux-user/arm: Do not allocate a commpage at all for M-profile CPUs
17* d921fea338c1 Mauro Matteo Cascella:
   ui/vnc-clipboard: fix infinite loop in inflate_buffer (CVE-2023-3255)
18* d28b3c90cfad Andreas Schwab:
   linux-user: Make sure initial brk(0) is page-aligned
19* ea3c76f1494d Klaus Jensen:
   hw/nvme: fix endianness issue for shadow doorbells
20* 15ad98536ad9 Helge Deller:
   linux-user: Fix qemu brk() to not zero bytes on current page
21* dfe49864afb0 Helge Deller:
   linux-user: Prohibit brk() to to shrink below initial heap address
22* eac78a4b0b7d Helge Deller:
   linux-user: Fix signed math overflow in brk() syscall
23* 03b67621445d Denis V. Lunev:
   qemu-nbd: pass structure into nbd_client_thread instead of plain char*
24* 5c56dd27a2c9 Denis V. Lunev:
   qemu-nbd: fix regression with qemu-nbd --fork run over ssh
25* e5b815b0defc Denis V. Lunev:
   qemu-nbd: regression with arguments passing into nbd_client_thread()
26* 736a1588c104 Jordan Niethe:
   tcg/ppc: Fix race in goto_tb implementation
27* 22d2e5351a18 Ilya Leoshkevich:
   tcg/{i386, s390x}: Add earlyclobber to the op_add2's first output
28* 761b0aa9381e Ilya Leoshkevich:
   target/s390x: Make CKSM raise an exception if R2 is odd
29* 4b6e4c0b8223 Ilya Leoshkevich:
   target/s390x: Fix CLM with M3=0
30* 53684e344a27 Ilya Leoshkevich:
   target/s390x: Fix CONVERT TO LOGICAL/FIXED with out-of-range inputs
31* a2025557ed4d Ilya Leoshkevich:
   target/s390x: Fix ICM with M3=0
32* 9c028c057adc Ilya Leoshkevich:
   target/s390x: Make MC raise specification exception when class >= 16
33* ff537b0370ab Ilya Leoshkevich:
   target/s390x: Fix assertion failure in VFMIN/VFMAX with type 13
34* c34ad459926f Thomas Huth:
   target/loongarch: Fix the CSRRD CPUID instruction on big endian hosts
35* 206e91d14330 Viktor Prutyanov:
   virtio-pci: add handling of PCI ATS and Device-TLB enable/disable
36* ee071f67f7a1 Viktor Prutyanov:
   vhost: register and change IOMMU flag depending on Device-TLB state
37* cd9b83468843 Viktor Prutyanov:
   virtio-net: pass Device-TLB enable/disable events to vhost
38* c6445544d4ce Peter Maydell:
   hw/arm/smmu: Handle big-endian hosts correctly
39* 5d78893f39ca Peter Maydell:
   target/arm: Special case M-profile in debug_helper.c code
40* 2b0d656ab648 Peter Maydell:
   target/arm: Avoid writing to constant TCGv in trans_CSEL()
41* 055b86e0f0b4 Richard Henderson:
   util/interval-tree: Use qatomic_read for left/right while searching
42* 4c8baa02d363 Richard Henderson:
   util/interval-tree: Use qatomic_set_mb in rb_link_node
43* 2e718e665706 Richard Henderson:
   target/ppc: Disable goto_tb with architectural singlestep
44* 38dd78c41eaf Helge Deller:
   linux-user/armeb: Fix __kernel_cmpxchg() for armeb
45* f4f71363fcdb Anthony PERARD:
   thread-pool: signal "request_cond" while locked
46* aa36243514a7 Anthony PERARD:
   xen-block: Avoid leaks on new error path
47* 10be627d2b5e Daniel P. Berrangé:
   io: remove io watch if TLS channel is closed during handshake
48* cf885b195796 David Woodhouse:
   hw/xen: fix off-by-one in xen_evtchn_set_gsi()
49* c11d5bdae79a Keith Packard:
   target/nios2: Pass semihosting arg to exit
50* 71e2dd6aa1bd Keith Packard:
   target/nios2: Fix semihost lseek offset computation
51* 8caaae7319a5 Peter Maydell:
   target/m68k: Fix semihost lseek offset computation
52* cf2f89edf36a Eric Auger:
   hw/virtio-iommu: Fix potential OOB access in virtio_iommu_handle_command()
53* 18f2971ce403 Li Feng:
   vhost: fix the fd leak
54* 9d38a8434721 zhenwei pi:
   virtio-crypto: verify src&dst buffer length for sym request
55* 15b11a1da6a4 zhenwei pi:
   cryptodev: Handle unexpected request to avoid crash
56* f8c0fd9804f4 Helge Deller:
   target/hppa: Move iaoq registers and thus reduce generated code size
57* 348e354417b6 Yuri Benditovich:
   pci: do not respond config requests after PCI device eject
58* cc2a08480e19 Thomas Huth:
   hw/i386/intel_iommu: Fix trivial endianness problems
59* 642ba8967227 Thomas Huth:
   hw/i386/intel_iommu: Fix endianness problems related to VTD_IR_TableEntry
60* 4572b22cf9ba Thomas Huth:
   hw/i386/intel_iommu: Fix struct VTDInvDescIEC on big endian hosts
61* fcd802742330 Thomas Huth:
   hw/i386/intel_iommu: Fix index calculation in vtd_interrupt_remap_msi()
62* 37cf5cecb039 Thomas Huth:
   hw/i386/x86-iommu: Fix endianness issue in x86_iommu_irq_to_msi_message()
63* e1e56c07d1fa Thomas Huth:
   include/hw/i386/x86-iommu: Fix struct X86IOMMU_MSIMessage for big endian 
   hosts
64 adee0da0368f Zhenzhong Duan:
   vfio/pci: Disable INTx in vfio_realize error path
65 031b1abacbdb Hawkins Jiawei:
   vdpa: Fix possible use-after-free for VirtQueueElement
66 b479bc3c9d5e Hawkins Jiawei:
   vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mac()
67 f45fd95ec9e8 Hawkins Jiawei:
   vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mq()
68 9201af096962 Nicholas Piggin:
   target/ppc: Implement ASDR register for ISA v3.0 for HPT
69 9915dac4847f Nicholas Piggin:
   target/ppc: Fix pending HDEC when entering PM state
70 0e2a3ec36885 Nicholas Piggin:
   target/ppc: Fix VRMA page size for ISA v3.0
71 b2ea6450d8e1 Matt Borgerson:
   target/i386: Check CR0.TS before enter_mmx

(commit(s) marked with * were in previous series and are not resent)

