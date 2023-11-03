Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D9E7DFF2A
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 07:26:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qynb3-0006BK-QW; Fri, 03 Nov 2023 02:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qynav-00068O-M4
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 02:23:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qynaq-0004BN-V6
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 02:23:49 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxfOrjkURlvag2AA--.14506S3;
 Fri, 03 Nov 2023 14:23:31 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxH93hkURlQfg4AA--.60029S2; 
 Fri, 03 Nov 2023 14:23:29 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com
Subject: [PULL 00/10] loongarch-to-apply queue
Date: Fri,  3 Nov 2023 14:23:22 +0800
Message-Id: <20231103062332.2413724-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxH93hkURlQfg4AA--.60029S2
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

The following changes since commit d762bf97931b58839316b68a570eecc6143c9e3e:

  Merge tag 'pull-target-arm-20231102' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-11-03 10:04:12 +0800)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20231103

for you to fetch changes up to f7077737531b40aa879d4644837aeda0f7fc6aa8:

  linux-user/loongarch64: Add LASX sigcontext save/restore (2023-11-03 14:13:46 +0800)

----------------------------------------------------------------
pull-loongarch-20231103

----------------------------------------------------------------
Richard Henderson (1):
      linux-user/loongarch64: Use traps to track LSX/LASX usage

Song Gao (9):
      target/loongarch: Add cpu model 'max'
      target/loongarch: Allow user enable/disable LSX/LASX features
      target/loongarch: Implement query-cpu-model-expansion
      target/loongarch: Support 4K page size
      linux-user/loongarch64: Fix setup_extcontext alloc wrong fpu_context size
      linux-user/loongarch64: setup_sigframe() set 'end' context size 0
      linux-user/loongarch64: Use abi_{ulong,uint} types
      linux-user/loongarch64: Add LSX sigcontext save/restore
      linux-user/loongarch64: Add LASX sigcontext save/restore

 linux-user/loongarch64/cpu_loop.c           |  13 ++
 linux-user/loongarch64/signal.c             | 189 +++++++++++++++++++++++-----
 qapi/machine-target.json                    |   6 +-
 target/loongarch/cpu-param.h                |   2 +-
 target/loongarch/cpu.c                      |  74 +++++++++++
 target/loongarch/cpu.h                      |   2 +
 target/loongarch/insn_trans/trans_vec.c.inc |  11 --
 target/loongarch/loongarch-qmp-cmds.c       |  64 ++++++++++
 target/loongarch/tlb_helper.c               |   9 +-
 9 files changed, 318 insertions(+), 52 deletions(-)


