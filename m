Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76585B52DD0
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Sep 2025 11:58:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwe35-0001jP-Ud; Thu, 11 Sep 2025 05:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1uwe2u-0001dU-JY; Thu, 11 Sep 2025 05:56:52 -0400
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1uwe2l-0005Ow-4b; Thu, 11 Sep 2025 05:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1757584578; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=EfbDjTEkKmQSHkupOEfM7fT9Z4bCEggf+NrkPcGjW4U=;
 b=iIq/kBG0msveohs/7q5yiGqm7sgANFwTsqPhC35993JdDhp8K6DeqWCu+YV602yDXlaXVXVGtD7wwLN3UAgVC8Dm0J4+bLRHoiQrfnVTUBX2HDw5PVMYnbGkN2/hI39x7owWM481SavDmb9QnTw8yxWhWI8hNG+7BC4dvd5Ubqw=
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0Wnlj.KH_1757584577 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 11 Sep 2025 17:56:17 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Thu, 11 Sep 2025 17:56:13 +0800
Subject: [PATCH v3 1/4] hw/intc: Save time_delta in RISC-V mtimer VMState
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-timers-v3-1-60508f640050@linux.alibaba.com>
References: <20250911-timers-v3-0-60508f640050@linux.alibaba.com>
In-Reply-To: <20250911-timers-v3-0-60508f640050@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757584576; l=2874;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=V0J1o0BTyrUgt1B4k2jqg8yY3dbSFHQu27VONEAoIxs=;
 b=60JYPjSoSTm6LVe5EEvr5knCnNMthZtImWJCfNyf9Y4K9qGy9Qvu86yY+AoKxWK7zlF75G9VU
 5HDmybUoyBMDA0r9pqeOgFUjpZiLSzmJ+/rjOA5BrGZlR0ZieZLD58N
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
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

In QEMU's RISC-V ACLINT timer model, 'mtime' is not stored directly as a
state variable. It is computed on demand as:

    mtime = rtc_r + time_delta

where:
- 'rtc_r' is the current VM virtual time (in ticks) obtained via
  cpu_riscv_read_rtc_raw() from QEMU_CLOCK_VIRTUAL.
- 'time_delta' is an offset applied when the guest writes a new 'mtime'
  value via riscv_aclint_mtimer_write():

    time_delta = value - rtc_r

Under this design, 'rtc_r' is assumed to be monotonically increasing
during VM execution. Even if the guest writes an 'mtime' value smaller
than the current one (making 'time_delta' negative in signed arithmetic,
or underflow in unsigned arithmetic), the computed 'mtime' remains
correct because 'rtc_r_new > rtc_r_old':

    mtime_new = rtc_r_new + (value - rtc_r_old)

However, this monotonicity assumption breaks on snapshot load.

Before restoring a snapshot, QEMU resets the guest, which calls
riscv_aclint_mtimer_reset_enter() to set 'mtime' to 0 and recompute
'time_delta' as:

    time_delta = 0 - rtc_r_reset

Here, the time_delta differs from the value that was present when the
snapshot was saved. As a result, subsequent reads produce a fixed offset
from the true mtime.

This can be observed with the 'date' command inside the guest: after loading
a snapshot, the reported time appears "frozen" at the save point, and only
resumes correctly after the guest has run long enough to compensate for the
erroneous offset.

The fix is to treat 'time_delta' as part of the device's migratable
state and save/restore it via vmstate. This preserves the correct
relation between 'rtc_r' and 'mtime' across snapshot save/load, ensuring
'mtime' continues incrementing from the precise saved value after
restore.

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 hw/intc/riscv_aclint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 4623cfa029365c6cbdead4bd4a9f0d8b9e88b939..318a9c8248432a8cd4c3f3fa990739917ecf7ca1 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -323,9 +323,10 @@ static void riscv_aclint_mtimer_reset_enter(Object *obj, ResetType type)
 
 static const VMStateDescription vmstate_riscv_mtimer = {
     .name = "riscv_mtimer",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
+            VMSTATE_UINT64(time_delta, RISCVAclintMTimerState),
             VMSTATE_VARRAY_UINT32(timecmp, RISCVAclintMTimerState,
                                   num_harts, 0,
                                   vmstate_info_uint64, uint64_t),

-- 
2.43.0


