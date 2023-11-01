Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 559FA7DDB57
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 04:09:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy1av-0003xp-0X; Tue, 31 Oct 2023 23:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qy1aq-0003wE-FM
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 23:08:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qy1am-0005qW-Vq
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 23:08:32 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxfesfwUFlxSM2AA--.37885S3;
 Wed, 01 Nov 2023 11:08:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdwdwUFltsk3AA--.55379S2; 
 Wed, 01 Nov 2023 11:08:13 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, laurent@vivier.eu,
 maobibo@loongson.cn
Subject: [PATCH v2 0/6] linux-user/loongarch64: Add LSX/LASX sigcontext
Date: Wed,  1 Nov 2023 11:08:10 +0800
Message-Id: <20231101030816.2353416-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdwdwUFltsk3AA--.55379S2
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

Hi,

This series adds save/restore LSX/LASX sigcontext.

test:
  - use V1 test.
  - test with RISU https://patchew.org/QEMU/20231025092915.902814-1-gaosong@loongson.cn/


V2:
  - Rebase;
  - Remove extctx_flags;
  - Use abi_{ulong, uint} types;
  - R-b.

Richard Henderson (1):
  linux-user/loongarch64: Use traps to track LSX/LASX usage

Song Gao (5):
  linux-user/loongarch64: Fix setup_extcontext alloc wrong fpu_context
    size
  linux-user/loongarch64: setup_sigframe() set 'end' context size 0
  linux-user/loongarch64: Use abi_{ulong,uint} types
  linux-user/loongarch64: Add LSX sigcontext save/restore
  linux-user/loongarch64: Add LASX sigcontext save/restore

 linux-user/loongarch64/cpu_loop.c           |  13 ++
 linux-user/loongarch64/signal.c             | 189 ++++++++++++++++----
 target/loongarch/insn_trans/trans_vec.c.inc |  11 --
 3 files changed, 169 insertions(+), 44 deletions(-)

-- 
2.25.1


