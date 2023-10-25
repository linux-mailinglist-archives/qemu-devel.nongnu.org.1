Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CBA7D6648
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:10:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZt5-0005A7-GW; Wed, 25 Oct 2023 05:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qvWRj-0004GC-Jr
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:28:47 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qvWRf-00015D-QT
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:28:47 -0400
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 39P5F10J024420
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 13:15:01 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39P5EqZs024255
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 13:14:52 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox.andestech.com (10.0.12.51) by
 ATCPCS16.andestech.com (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; 
 Wed, 25 Oct 2023 13:14:49 +0800
To: <qemu-devel@nongnu.org>
CC: Ethan Chen <ethan84@andestech.com>
Subject: [PATCH 0/6] Support RISC-V IOPMP
Date: Wed, 25 Oct 2023 13:14:24 +0800
Message-ID: <20231025051430.493079-1-ethan84@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.12.51]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39P5F10J024420
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Oct 2023 05:09:12 -0400
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This series implements IOPMP specification v1.0.0-draft4 rapid-k model:
https://github.com/riscv-non-isa/iopmp-spec/blob/main/riscv_iopmp_specification.pdf

When IOPMP is enabled, a DMA device ATCDMAC300 is added to RISC-V virt platform.
This DMA devce is connected to the IOPMP and has the functionalities required
by IOPMP, including:
- Support specify source-id (SID)
- Support asynchronous I/O to handle stall transcations

Ethan Chen (6):
  exec/memory: Introduce the translate_size function within the IOMMU
    class
  system/physmem: IOMMU: Invoke the translate_size function if it is
    implemented
  exec/memattrs: Add iopmp source id to MemTxAttrs
  Add RISC-V IOPMP support
  hw/dma: Add Andes ATCDMAC300 support
  hw/riscv/virt: Add IOPMP support

 hw/dma/Kconfig                |   3 +
 hw/dma/atcdmac300.c           | 435 +++++++++++++++++
 hw/dma/meson.build            |   1 +
 hw/misc/Kconfig               |   3 +
 hw/misc/meson.build           |   1 +
 hw/misc/riscv_iopmp.c         | 881 ++++++++++++++++++++++++++++++++++
 hw/riscv/Kconfig              |   2 +
 hw/riscv/virt.c               |  72 ++-
 include/exec/memattrs.h       |   3 +
 include/exec/memory.h         |  19 +
 include/hw/dma/atcdmac300.h   | 171 +++++++
 include/hw/misc/riscv_iopmp.h | 322 +++++++++++++
 include/hw/riscv/virt.h       |  10 +-
 system/physmem.c              |   9 +-
 14 files changed, 1927 insertions(+), 5 deletions(-)
 create mode 100644 hw/dma/atcdmac300.c
 create mode 100644 hw/misc/riscv_iopmp.c
 create mode 100644 include/hw/dma/atcdmac300.h
 create mode 100644 include/hw/misc/riscv_iopmp.h

-- 
2.34.1


