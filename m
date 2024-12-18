Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B02579F5F19
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Dec 2024 08:16:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNoHs-0007ay-Or; Wed, 18 Dec 2024 02:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tNoHp-0007Zp-PQ; Wed, 18 Dec 2024 02:16:01 -0500
Received: from out28-97.mail.aliyun.com ([115.124.28.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1tNoHl-00054a-3x; Wed, 18 Dec 2024 02:16:00 -0500
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.agz-7W-_1734506143 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 18 Dec 2024 15:15:44 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: bmeng.cn@gmail.com, liwei1518@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, max.chou@sifive.com, alistair23@gmail.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, zqz00548@tecorigin.com,
 Chao Liu <lc00631@tecorigin.com>
Subject: [PATCH v2 0/2] Enhanced VSTART and VL Checks for Vector Instructions
Date: Wed, 18 Dec 2024 15:15:29 +0800
Message-ID: <cover.1734504907.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.97; envelope-from=lc00631@tecorigin.com;
 helo=out28-97.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi, all:

In the second version of this patch, I addressed the issue that other vector
instructions didn't check for vstart >= vl correctly.

I refactored the VSTART_CHECK_EARLY_EXIT() macro. This change is intended to:
Vector instructions with special vl values can also be checked with this macro,
such as vlm.v instruction (real vl = ceil(vl / 8)).

PATCH v1:
https://lore.kernel.org/qemu-riscv/cover.1734423785.git.lc00631@tecorigin.com/

Chao Liu (2):
  target/riscv: refactor VSTART_CHECK_EARLY_EXIT() to accept vl as a
    parameter
  target/riscv: fix handling of nop for vstart >= vl in some vector
    instruction

 target/riscv/vcrypto_helper.c   | 32 ++++++-------
 target/riscv/vector_helper.c    | 83 ++++++++++++++++++---------------
 target/riscv/vector_internals.c |  4 +-
 target/riscv/vector_internals.h | 12 ++---
 4 files changed, 69 insertions(+), 62 deletions(-)

-- 
2.47.1


