Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C65A58A81
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Mar 2025 03:39:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trT1Z-0003dz-Mf; Sun, 09 Mar 2025 22:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1trT1V-0003dA-4k; Sun, 09 Mar 2025 22:37:45 -0400
Received: from out28-197.mail.aliyun.com ([115.124.28.197])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1trT1S-0003QR-Sz; Sun, 09 Mar 2025 22:37:44 -0400
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.booCGZK_1741574245 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 10 Mar 2025 10:37:29 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: alistair23@gmail.com
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, dbarboza@ventanamicro.com,
 lc00631@tecorigin.com, liwei1518@gmail.com, palmer@dabbelt.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 zqz00548@tecorigin.com
Subject: [PATCH v4 0/2] Enhanced VSTART and VL checks for vector instructions
Date: Mon, 10 Mar 2025 10:35:23 +0800
Message-ID: <cover.1741573286.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.47.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.197;
 envelope-from=lc00631@tecorigin.com; helo=out28-197.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi, Alistair:

I rebase both patches based on the riscv-to-apply.next branch and tested them.
https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Only the first patch had two conflicts, which were resolved nicely,
and the second patch rebased fine, so you can review it again if necessary,
thanks!

PATCH v3 review:
https://lore.kernel.org/qemu-riscv/71f15782-ec28-4763-8197-c10ec12811ec@ventanamicro.com/

PATCH v2 review:
https://lore.kernel.org/qemu-devel/61e8f7d8-607a-4d63-b9dd-cfbfc840716e@ventanamicro.com/

PATCH v1 review:
https://lore.kernel.org/qemu-devel/CAKmqyKPFYxhK8PANOVzV3FMWxd79wZSJYLWkKOAgEMt_b2KvZA@mail.gmail.com/

--
Regards,
Chao

Chao Liu (2):
  target/riscv: refactor VSTART_CHECK_EARLY_EXIT() to  accept vl as a
    parameter
  target/riscv: fix handling of nop for vstart >= vl in some vector
    instruction

 target/riscv/vcrypto_helper.c   | 32 ++++++-------
 target/riscv/vector_helper.c    | 83 ++++++++++++++++++---------------
 target/riscv/vector_internals.c |  4 +-
 target/riscv/vector_internals.h | 12 ++---
 4 files changed, 69 insertions(+), 62 deletions(-)

-- 
2.48.1


