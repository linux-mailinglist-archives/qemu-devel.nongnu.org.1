Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3180A99F0C
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Apr 2025 04:57:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7mkj-0000d5-3t; Wed, 23 Apr 2025 22:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u7mkN-0000ZQ-C0
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 22:55:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u7mkK-0008WS-CG
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 22:55:31 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxJHAXqAlojQbFAA--.64218S3;
 Thu, 24 Apr 2025 10:55:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCxrhsVqAlogNaSAA--.53120S2;
 Thu, 24 Apr 2025 10:55:18 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, peter.maydell@linaro.org, richard.henderson@linaro.org
Subject: [PULL 00/13] loongarch-to-apply queue
Date: Thu, 24 Apr 2025 10:33:04 +0800
Message-Id: <20250424023317.3980755-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxrhsVqAlogNaSAA--.53120S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 91d0d16b44c93fa82cf76ae12990ce3aa96096c9:

  Merge tag 'pull-avr-20250422' of https://gitlab.com/rth7680/qemu into staging (2025-04-23 09:29:33 -0400)

are available in the Git repository at:

  https://github.com/gaosong715/qemu.git tags/pull-loongarch-20250424

for you to fetch changes up to 875caabdb1701a7c57ad0655a7963d74afc1b4d9:

  target/loongarch: Guard BCEQZ/BCNEZ instructions with FP feature (2025-04-24 10:46:31 +0800)

----------------------------------------------------------------
pull-loongarch-20230424

----------------------------------------------------------------
Bibo Mao (10):
      hw/intc/loongarch_pch_msi: Remove gpio input handler
      target/loongarch: Move header file helper.h to directory tcg
      target/loongarch: Add function loongarch_get_addr_from_tlb
      target/loongarch: Move function get_dir_base_width to common directory
      target/loongarch: Add stub function loongarch_get_addr_from_tlb
      target/loongarch: Set function loongarch_map_address() with common code
      target/loongarch: Define function loongarch_get_addr_from_tlb() non-static
      target/loongarch: Move function loongarch_tlb_search to directory tcg
      target/loongarch: Add static definition with function loongarch_tlb_search()
      target/loongarch: Move definition of TCG specified function to tcg directory

WANG Rui (3):
      linux-user/loongarch64: Decode BRK break codes for FPE signals
      target/loongarch: Add CRC feature flag and use it to gate CRC instructions
      target/loongarch: Guard BCEQZ/BCNEZ instructions with FP feature

 hw/intc/loongarch_pch_msi.c                        |   9 -
 linux-user/loongarch64/cpu_loop.c                  |  25 +-
 target/loongarch/cpu.c                             |   5 +-
 target/loongarch/cpu.h                             |   2 +-
 target/loongarch/cpu_helper.c                      | 177 +----
 target/loongarch/helper.h                          | 720 +-------------------
 target/loongarch/internals.h                       |   7 -
 target/loongarch/tcg/helper.h                      | 722 +++++++++++++++++++++
 target/loongarch/tcg/insn_trans/trans_branch.c.inc |   4 +-
 target/loongarch/tcg/insn_trans/trans_extra.c.inc  |  16 +-
 target/loongarch/tcg/tcg_loongarch.h               |   9 +
 target/loongarch/tcg/tlb_helper.c                  | 173 ++++-
 target/loongarch/translate.h                       |   1 +
 13 files changed, 953 insertions(+), 917 deletions(-)
 create mode 100644 target/loongarch/tcg/helper.h


