Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D8981451D
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 11:04:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE52u-0003QT-DT; Fri, 15 Dec 2023 05:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rE52p-0003PR-2T
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 05:03:47 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rE52l-0004uP-HJ
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 05:03:46 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxZfB2JHxlPlABAA--.7477S3;
 Fri, 15 Dec 2023 18:03:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxrnN1JHxldl0FAA--.26862S2; 
 Fri, 15 Dec 2023 18:03:33 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] hw/loongarch/virt: Set iocsr address space per-board
 rather percpu
Date: Fri, 15 Dec 2023 18:03:29 +0800
Message-Id: <20231215100333.3933632-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxrnN1JHxldl0FAA--.26862S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWrKr1Uur18WFy3uF48try7Arc_yoW8JF45pr
 ZxuwsIgr4kAryavwnxW343Wr98GFn7WF12vF43KryrCr43ZFyj9w18Cas5XFyUG34rJry0
 qr1Fkw1UWF1UZwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

On LoongArch system, there is iocsr address space simliar system io
address space on x86. And each cpu has its separate iocsr address space now,
with this patch, iocsr address space is changed with per-board, and
MemTxAttrs.requester_id is used to differentiate cpu cores.

---
Changes in v2:
  1. Add num-cpu property for extioi interrupt controller
  2. Add post_load support for extioi vmstate to calculate sw_ipmap/sw_coremap info
---
Bibo Mao (4):
  hw/intc/loongarch_ipi: Use MemTxAttrs interface for ipi ops
  hw/loongarch/virt: Set iocsr address space per-board rather than
    percpu
  hw/intc/loongarch_extioi: Add dynamic cpu number support
  hw/intc/loongarch_extioi: Add vmstate post_load support

 hw/intc/loongarch_extioi.c         | 230 ++++++++++++++++++-----------
 hw/intc/loongarch_ipi.c            | 191 +++++++++++++++---------
 hw/loongarch/virt.c                |  94 ++++++++----
 include/hw/intc/loongarch_extioi.h |  12 +-
 include/hw/intc/loongarch_ipi.h    |   3 +-
 include/hw/loongarch/virt.h        |   3 +
 target/loongarch/cpu.c             |  48 ------
 target/loongarch/cpu.h             |   4 +-
 target/loongarch/iocsr_helper.c    |  16 +-
 9 files changed, 358 insertions(+), 243 deletions(-)


base-commit: 039afc5ef7367fbc8fb475580c291c2655e856cb
-- 
2.39.3


