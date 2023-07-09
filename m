Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB6C74C864
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 23:24:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIbsT-0003yX-3c; Sun, 09 Jul 2023 17:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=YYC6=C3=redhat.com=clg@ozlabs.org>)
 id 1qIbsQ-0003yK-5i
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 17:23:30 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=YYC6=C3=redhat.com=clg@ozlabs.org>)
 id 1qIbsO-00012X-4y
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 17:23:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qzg9044N6z4wxx;
 Mon, 10 Jul 2023 07:23:16 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qzg8y5Ks9z4wxN;
 Mon, 10 Jul 2023 07:23:14 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/1] linux-headers: update to v6.5-rc1
Date: Sun,  9 Jul 2023 23:23:07 +0200
Message-ID: <20230709212308.370699-1-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=YYC6=C3=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello,

Here is an update of Linux headers for two series needing new KVM
definitions :
  
* s390x/ap: fix hang when mdev attached to guest is removed
  https://lore.kernel.org/all/20230602141125.448833-1-akrowiak@linux.ibm.com/

* vfio/pci: Atomic Ops completer support
  https://lore.kernel.org/all/20230526231558.1660396-1-alex.williamson@redhat.com/

Please review and I will send a PR in my morning.

Thanks,

C. 

Cédric Le Goater (1):
  linux-headers: update to v6.5-rc1

 include/standard-headers/drm/drm_fourcc.h     |  43 ++++++
 include/standard-headers/linux/const.h        |   2 +-
 include/standard-headers/linux/pci_regs.h     |   1 +
 include/standard-headers/linux/vhost_types.h  |  16 +++
 include/standard-headers/linux/virtio_blk.h   |  18 +--
 .../standard-headers/linux/virtio_config.h    |   6 +
 include/standard-headers/linux/virtio_net.h   |   1 +
 linux-headers/asm-arm64/bitsperlong.h         |  23 ---
 linux-headers/asm-arm64/kvm.h                 |  33 +++++
 linux-headers/asm-generic/bitsperlong.h       |  13 +-
 linux-headers/asm-generic/unistd.h            | 134 +++++-------------
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/unistd_32.h         |   1 +
 linux-headers/asm-powerpc/unistd_64.h         |   1 +
 linux-headers/asm-riscv/bitsperlong.h         |  13 --
 linux-headers/asm-riscv/kvm.h                 | 134 +++++++++++++++++-
 linux-headers/asm-riscv/unistd.h              |   9 ++
 linux-headers/asm-s390/unistd_32.h            |   2 +
 linux-headers/asm-s390/unistd_64.h            |   2 +
 linux-headers/asm-x86/kvm.h                   |   3 +
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/const.h                   |   2 +-
 linux-headers/linux/kvm.h                     |  18 ++-
 linux-headers/linux/mman.h                    |  14 ++
 linux-headers/linux/psp-sev.h                 |   7 +
 linux-headers/linux/userfaultfd.h             |  17 ++-
 linux-headers/linux/vfio.h                    |  27 ++++
 linux-headers/linux/vhost.h                   |  31 ++++
 32 files changed, 423 insertions(+), 154 deletions(-)

-- 
2.41.0


