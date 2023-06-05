Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8274721C79
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 05:20:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q60kl-0006I8-64; Sun, 04 Jun 2023 23:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1q60kj-0006Ht-Az
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 23:19:29 -0400
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1q60kh-0006Lo-BR
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 23:19:29 -0400
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx5OEZVH1k+xwAAA--.559S2; 
 Mon, 05 Jun 2023 11:18:49 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/1] loongarch-to-apply queue
Date: Mon,  5 Jun 2023 11:18:47 +0800
Message-Id: <20230605031848.1428047-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx5OEZVH1k+xwAAA--.559S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF4kJr4rZF4xAw4kJw1kKrg_yoWDGFb_GF
 yxtFy8JrW7JF1UZw4UGr18Aw17Jw1fXF15AryDXrs7Gry7Jw1UXr4kJrW5Zr1jqF1UJr98
 Gr48Ar15Ar1UJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

The following changes since commit 848a6caa88b9f082c89c9b41afa975761262981d:

  Merge tag 'migration-20230602-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-06-02 17:33:29 -0700)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20230605

for you to fetch changes up to 8555ddc671203969b0e6eb651e538d02a9a79b3a:

  hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes (2023-06-05 11:08:55 +0800)

----------------------------------------------------------------
Fixes Coverity CID: 1512452, 1512453
Fixes: 78464f023b54 ("hw/loongarch/virt: Modify ipi as percpu device")

----------------------------------------------------------------
Jiaxun Yang (1):
      hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes

 hw/intc/loongarch_ipi.c         | 6 +++---
 include/hw/intc/loongarch_ipi.h | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)


