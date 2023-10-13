Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4B27C7FE3
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:19:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDNC-0004Rw-6d; Fri, 13 Oct 2023 04:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qrDN3-0003hU-Io
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:18:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qrDN1-0003RU-1R
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:18:09 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxNvEu_Shl4qQxAA--.29790S3;
 Fri, 13 Oct 2023 16:17:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxbNwt_ShlyKIiAA--.7352S2; 
 Fri, 13 Oct 2023 16:17:49 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	stefanha@gmail.com
Subject: [PULL 0/7] loongarch-to-apply queue
Date: Fri, 13 Oct 2023 16:17:43 +0800
Message-Id: <20231013081750.2944412-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxbNwt_ShlyKIiAA--.7352S2
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 63011373ad22c794a013da69663c03f1297a5c56:

  Merge tag 'pull-riscv-to-apply-20231012-1' of https://github.com/alistair23/qemu into staging (2023-10-12 10:24:44 -0400)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20231013

for you to fetch changes up to 1bea6930ca7b9587ea8d8fbb77069b6a13aa031a:

  LoongArch: step down as general arch maintainer (2023-10-13 10:05:32 +0800)

----------------------------------------------------------------
pull-loongarch-20231013

*Fix ASXE flag conflict
*Add preldx instruction
*Add preldx instruction
*Remove unused region
*Xiao juan step down as general arch maintainer

----------------------------------------------------------------
Jiajie Chen (1):
      target/loongarch: fix ASXE flag conflict

Philippe Mathieu-Daudé (2):
      hw/loongarch/virt: Remove unused ISA UART
      hw/loongarch/virt: Remove unused ISA Bus

Song Gao (2):
      target/loongarch: Add preldx instruction
      hw/loongarch/virt: Remove unused 'loongarch_virt_pm' region

Thomas Weißschuh (1):
      hw/loongarch: remove global loaderparams variable

Xiaojuan Yang (1):
      LoongArch: step down as general arch maintainer

 MAINTAINERS                                    |   2 -
 hw/loongarch/Kconfig                           |   2 -
 hw/loongarch/virt.c                            | 103 +++++++------------------
 include/hw/loongarch/virt.h                    |   3 -
 target/loongarch/cpu.h                         |   4 +-
 target/loongarch/disas.c                       |   7 ++
 target/loongarch/insn_trans/trans_memory.c.inc |   5 ++
 target/loongarch/insns.decode                  |   3 +
 tests/tcg/loongarch64/system/boot.S            |   7 +-
 9 files changed, 49 insertions(+), 87 deletions(-)


