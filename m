Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFCFBEFD83
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Oct 2025 10:13:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAl05-00076W-EN; Mon, 20 Oct 2025 04:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vAl01-00075q-So
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:12:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vAkzy-0005mg-SK
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:12:13 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxF9HT7vVo_DQYAA--.52031S3;
 Mon, 20 Oct 2025 16:12:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxZOTQ7vVohSf4AA--.18451S2;
 Mon, 20 Oct 2025 16:12:01 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC 0/2] target/loongarch: Add PTW feature support in KVM mode
Date: Mon, 20 Oct 2025 16:11:57 +0800
Message-Id: <20251020081159.2370512-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxZOTQ7vVohSf4AA--.18451S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Implement Hardware page table walker(PTW for short) feature in KVM mode.
Use OnOffAuto type variable ptw to check the PTW feature. If the PTW
feature is not supported with KVM host, it reports error if there is
ptw=on option.

This patchset is based on PTW feature on TCG mode:
https://lore.kernel.org/qemu-devel/20251016015027.1695116-1-maobibo@loongson.cn/

With PTW enabled, there is no obvious performance improvement with
generic macro benchmark, and somewhat improvement with micro benchmark
such as test-tlb located at https://github.com/torvalds/test-tlb,
overwall there is no negative effective with PTW enabled.

Here is result about test-tlb with command ./test-tlb 0x40000000 0x8000
             host    VM without HW PTW    VM with HW PTW   improvement
cycles       180         320                 261              20%

And TLB miss rate is about 52% n this scenerary.
Performance counter stats for 'taskset 0xf ./test-tlb 0x40000000 0x8000':
   67,724,819      dTLB-load-misses     #52.24% of all dTLB cache accesses
  129,639,899      dTLB-loads 

Bibo Mao (2):
  linux-headers: Update to Linux v6.18-rc2
  target/loongarch: Add PTW feature support in KVM mode

 include/standard-headers/linux/ethtool.h      |  1 +
 include/standard-headers/linux/fuse.h         | 22 ++++++++++--
 .../linux/input-event-codes.h                 |  1 +
 include/standard-headers/linux/input.h        | 22 +++++++++++-
 include/standard-headers/linux/pci_regs.h     | 10 ++++++
 include/standard-headers/linux/virtio_ids.h   |  1 +
 linux-headers/asm-loongarch/kvm.h             |  1 +
 linux-headers/asm-riscv/kvm.h                 | 23 +++++++++++-
 linux-headers/asm-riscv/ptrace.h              |  4 +--
 linux-headers/asm-x86/kvm.h                   | 34 ++++++++++++++++++
 linux-headers/asm-x86/unistd_64.h             |  1 +
 linux-headers/asm-x86/unistd_x32.h            |  1 +
 linux-headers/linux/kvm.h                     |  3 ++
 linux-headers/linux/psp-sev.h                 | 10 +++++-
 linux-headers/linux/stddef.h                  |  1 -
 linux-headers/linux/vduse.h                   |  2 +-
 linux-headers/linux/vhost.h                   |  4 +--
 target/loongarch/cpu.c                        |  5 +--
 target/loongarch/cpu.h                        |  1 +
 target/loongarch/kvm/kvm.c                    | 35 +++++++++++++++++++
 20 files changed, 169 insertions(+), 13 deletions(-)


base-commit: 36df9f3764a5d18683e79f743bc9fa1550d76da0
-- 
2.39.3


