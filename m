Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 683DCB09CD9
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Jul 2025 09:42:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucfj5-0001dq-Ma; Fri, 18 Jul 2025 03:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ucfW4-0002dd-83
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:28:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ucfVy-0002ik-MU
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:28:22 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxmnGK93lousksAQ--.26689S3;
 Fri, 18 Jul 2025 15:28:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxocKI93lo0QwcAA--.17387S2;
 Fri, 18 Jul 2025 15:28:09 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/9] target/loongarch: Enhancement about tcg mmu
Date: Fri, 18 Jul 2025 15:27:58 +0800
Message-Id: <20250718072807.3585466-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxocKI93lo0QwcAA--.17387S2
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

There is some enhance about LoongArch mmu tcg emulation, add new
header file cpu-mmu.h and function loongarch_check_pte(). Function
loongarch_check_pte() can work on both TLB entry and pte entry.

This patchset mainly is code cleanup and enhancement, its main
purpose is to work for hardware page table walk emluation in future.
---
v1 ... v2:
  1. Rename structure name pte_context with mmu_context, since it
     can be extended to get DMW or DA mmu idx and window size
  2. Add fine-grained tlb flush method
  3. Fix some issues in function invalidate_tlb_entry() to flush tlb,
     such as bitmap method with mmu idx, page size and address
     calculation
---
Bibo Mao (9):
  target/loongarch: Move some function definition to kvm directory
  target/loongarch: Define function loongarch_cpu_post_init as static
  target/loongarch: Set page size in TLB misc with STLB
  target/loongarch: Add header file cpu-mmu.h
  target/loongarch: Add common function loongarch_check_pte()
  target/loongarch: Use loongarch_check_pte() with page table walking
  target/loongarch: Use mmu idx bitmap method when flush tlb
  target/loongarch: Use correct page size when flush tlb
  target/loongarch: Use fine-grained tlb flush method

 hw/loongarch/virt.c                  |   1 +
 target/loongarch/cpu-mmu.h           |  38 ++++++
 target/loongarch/cpu.c               | 181 ++++++++++++++-------------
 target/loongarch/cpu.h               |  11 --
 target/loongarch/cpu_helper.c        |  98 +++++++++++----
 target/loongarch/internals.h         |  20 ---
 target/loongarch/kvm/kvm_loongarch.h |   4 +-
 target/loongarch/tcg/csr_helper.c    |   1 +
 target/loongarch/tcg/tlb_helper.c    | 136 ++++++--------------
 9 files changed, 247 insertions(+), 243 deletions(-)
 create mode 100644 target/loongarch/cpu-mmu.h


base-commit: c079d3a31e45093286c65f8ca5350beb3a4404a9
-- 
2.39.3


