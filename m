Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42899B51AE1
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 17:07:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwMOP-0005XF-5M; Wed, 10 Sep 2025 11:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1uwMOK-0005VR-D5; Wed, 10 Sep 2025 11:05:48 -0400
Received: from [115.124.30.99] (helo=out30-99.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1uwMOF-0003f7-So; Wed, 10 Sep 2025 11:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1757516722; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
 bh=3hTwrgSwdp3Rfn+8E33xqC1mmHPXNZ2zKgx8QMkf6aE=;
 b=jmgO5tCBHWIRdwvTECIAaNSVlhUkrjJxYNb0q0Xy6LaNrG2F3/QDcDnwfLl/qH0E0mCfjabSORxXp9E9QZd2gm7j8AKfR0Fe9q2/6t0S/kKsHrnJdMngk2izB1z3RDdJOAkUSK/1UOrTL6Y+R8cq1T748ypHYQh++ddEvHgikdQ=
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0WniJAy3_1757516717 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 10 Sep 2025 23:05:20 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Subject: [PATCH v2 0/4] Fix RISC-V timer migration issues
Date: Wed, 10 Sep 2025 23:04:24 +0800
Message-Id: <20250910-timers-v2-0-31359f1f6ee8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHiTwWgC/2XMyw7CIBCF4VdpZi0NELXgyvcwXQx0aifpxUAlN
 Q3vLnbr8j85+XaIFJgi3KodAiWOvMwl9KkCP+D8JMFdadBSX6SVVqw8UYhCGa/9tXEKNUI5vwL
 1vB3Qoy09cFyX8DncpH7rH5GUkKIhUgZtZ/qzu488v7caR3bosPbLBG3O+QvxfZrhpAAAAA==
X-Change-ID: 20250909-timers-18c2c67b1a2a
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757516719; l=2207;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=qhskT1NkJirVHE9x1Qr/P1472g+XACtByXEXvsPkUIU=;
 b=ZGnZciczPKSXNsu9v03kmH1SviK+rHMy0PAiBZISnpa3Ek32ZfKMzTgWRmo2RQZlR2YFhiO/d
 4CUf+KA2h61CCVtNuCtr3v2ydW2XhaK0Y12muCWNuE4ag2ty5FdCLyv
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.99 (deferred)
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=lyndra@linux.alibaba.com; helo=out30-99.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

This patch set fixes several timer-related migration issues in QEMU's
RISC-V implementation that cause timer events to be lost or behave
incorrectly after snapshot save/restore or live migration.

The problems addressed are:

1. ACLINT mtimer time_delta not migrated: The time_delta field in
   RISCVAclintMTimerState was missing from vmstate, causing incorrect
   mtime values after snapshot restore. This resulted in guest time
   appearing "frozen" until enough virtual time elapsed to compensate
   for the offset error.

2. ACLINT mtimer timers array not migrated: Active timer events
   scheduled via riscv_aclint_mtimer_write_timecmp() were not being
   migrated, causing pending timer interrupts to be lost after restore.

3. CPU stimer/vstimer not migrated: The S-mode and VS-mode timer
   pointers in CPURISCVState were missing from vmstate_riscv_cpu,
   causing supervisor-level timer events to be lost.

The patch set introduces a new VMSTATE_TIMER_PTR_VARRAY macro to handle
migration of variable-length timer pointer arrays, and adds the missing
timer fields to the appropriate vmstate structures.

Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
Changes in v2:
- Split VMSTATE_VARRAY_OF_POINTER_UINT32() into a separate patch,
  and define VMSTATE_TIMER_PTR_VARRAY() in riscv_aclint.h.
- Added Reviewed-by from Daniel Henrique Barboza.
- Link to v1: https://lore.kernel.org/qemu-devel/20250909-timers-v1-0-7ee18a9d8f4b@linux.alibaba.com

---
TANG Tiancheng (4):
      hw/intc: Save time_delta in RISC-V mtimer VMState
      include/migration: Add support for a variable-length array of UINT32 pointers
      hw/intc: Save timers array in RISC-V mtimer VMState
      target/riscv: Save stimer and vstimer in CPU vmstate

 hw/intc/riscv_aclint.c         |  7 +++++--
 include/hw/intc/riscv_aclint.h |  4 ++++
 include/migration/vmstate.h    | 10 ++++++++++
 target/riscv/machine.c         | 25 +++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 2 deletions(-)
---
base-commit: 6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8
change-id: 20250909-timers-18c2c67b1a2a

Best regards,
-- 
TANG Tiancheng <lyndra@linux.alibaba.com>


