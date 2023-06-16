Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C144B732CB0
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 12:03:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA6HW-0007IR-V3; Fri, 16 Jun 2023 06:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qA6HQ-0007GF-Ve
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 06:02:08 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qA6HM-0000ci-VG
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 06:02:08 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxKuoXM4xkPu8FAA--.12671S3;
 Fri, 16 Jun 2023 18:01:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxFOQWM4xkSygdAA--.17116S2; 
 Fri, 16 Jun 2023 18:01:58 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/5] loongarch-to-apply queue
Date: Fri, 16 Jun 2023 18:01:53 +0800
Message-Id: <20230616100158.1845239-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxFOQWM4xkSygdAA--.17116S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 7efd65423ab22e6f5890ca08ae40c84d6660242f:

  Merge tag 'pull-riscv-to-apply-20230614' of https://github.com/alistair23/qemu into staging (2023-06-14 05:28:51 +0200)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20230616

for you to fetch changes up to 505aa8d8f29b79fcef77563bb4124208badbd8d4:

  target/loongarch: Fix CSR.DMW0-3.VSEG check (2023-06-16 17:58:46 +0800)

----------------------------------------------------------------
pull-loongarch-20230616

* Fix CSR.DMW0-3.VSEG check
* Add cpu arch_id support
* Set physical cpuid route for LoongArch ipi device
* Add numa support
* Supplement cpu topology arguments

----------------------------------------------------------------
Jiajie Chen (1):
      target/loongarch: Fix CSR.DMW0-3.VSEG check

Tianrui Zhao (4):
      hw/loongarch/virt: Add cpu arch_id support
      hw/intc: Set physical cpuid route for LoongArch ipi device
      hw/loongarch: Add numa support
      hw/loongarch: Supplement cpu topology arguments

 hw/intc/loongarch_ipi.c       |  44 +++++++++++--
 hw/loongarch/Kconfig          |   1 +
 hw/loongarch/acpi-build.c     |  78 ++++++++++++++++++-----
 hw/loongarch/virt.c           | 144 ++++++++++++++++++++++++++++++++++++++----
 target/loongarch/cpu.h        |   2 +
 target/loongarch/tlb_helper.c |   4 +-
 6 files changed, 235 insertions(+), 38 deletions(-)


