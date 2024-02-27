Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 406BA8685B8
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Feb 2024 02:26:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1remD7-0003ym-6F; Mon, 26 Feb 2024 20:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1remD5-0003y2-0U
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 20:24:43 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1remD2-0000Dq-Lg
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 20:24:42 -0500
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 41R1OE3q023303;
 Tue, 27 Feb 2024 09:24:14 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from alvinga-VirtualBox.andestech.com (10.0.13.68) by
 ATCPCS16.andestech.com (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; 
 Tue, 27 Feb 2024 09:24:09 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, Alvin Chang <alvinga@andestech.com>
Subject: [PATCH v4 0/4] RISC-V: Modularize common match conditions for trigger
Date: Tue, 27 Feb 2024 09:24:01 +0800
Message-ID: <20240227012405.71650-1-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.13.68]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 41R1OE3q023303
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Alvin Chang <alvinga@andestech.com>
From:  Alvin Chang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

According to RISC-V Debug specification ratified version 0.13 [1]
(also applied to version 1.0 [2] but it has not been ratified yet), the
enabled privilege levels of the trigger is common match conditions for
all the types of the trigger.

This series modularize the code for checking the privilege levels of
type 2/3/6 triggers by implementing functions trigger_common_match()
and trigger_priv_match().

Additional match conditions, such as CSR tcontrol and textra, can be
further implemented into trigger_common_match() in the future.

[1]: https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_vote
[2]: https://github.com/riscv/riscv-debug-spec/releases/tag/1.0.0-rc1-asciidoc

Changes from v3:
- Change this series to target Debug Spec. version 0.13

Changes from v2:
- Explicitly mention the targeting version of RISC-V Debug Spec.

Changes from v1:
- Fix typo
- Add commit description for changing behavior of looping the triggers
  when we check type 2 triggers.

Alvin Chang (4):
  target/riscv: Add functions for common matching conditions of trigger
  target/riscv: Apply modularized matching conditions for breakpoint
  target/riscv: Apply modularized matching conditions for watchpoint
  target/riscv: Apply modularized matching conditions for icount trigger

 target/riscv/debug.c | 124 +++++++++++++++++++++++++++++--------------
 1 file changed, 83 insertions(+), 41 deletions(-)

-- 
2.34.1


