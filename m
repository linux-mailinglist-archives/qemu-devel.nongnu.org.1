Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4002579E918
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:22:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPly-0007mu-9H; Wed, 13 Sep 2023 09:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPlv-0007iy-Mx; Wed, 13 Sep 2023 09:19:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPlr-0003jb-CU; Wed, 13 Sep 2023 09:19:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 799A42176B;
 Wed, 13 Sep 2023 16:18:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7188627C8E;
 Wed, 13 Sep 2023 16:18:04 +0300 (MSK)
Received: (nullmailer pid 4073316 invoked by uid 1000);
 Wed, 13 Sep 2023 13:18:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Chien <jason.chien@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 60/66] hw/intc: Fix upper/lower mtime write calculation
Date: Wed, 13 Sep 2023 16:17:41 +0300
Message-Id: <20230913131757.4073200-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jason Chien <jason.chien@sifive.com>

When writing the upper mtime, we should keep the original lower mtime
whose value is given by cpu_riscv_read_rtc() instead of
cpu_riscv_read_rtc_raw(). The same logic applies to writes to lower mtime.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230728082502.26439-1-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit e0922b73baf00c4c19d4ad30d09bb94f7ffea0f4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index b466a6abaf..bf77e29a70 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -208,11 +208,12 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
         return;
     } else if (addr == mtimer->time_base || addr == mtimer->time_base + 4) {
         uint64_t rtc_r = cpu_riscv_read_rtc_raw(mtimer->timebase_freq);
+        uint64_t rtc = cpu_riscv_read_rtc(mtimer);
 
         if (addr == mtimer->time_base) {
             if (size == 4) {
                 /* time_lo for RV32/RV64 */
-                mtimer->time_delta = ((rtc_r & ~0xFFFFFFFFULL) | value) - rtc_r;
+                mtimer->time_delta = ((rtc & ~0xFFFFFFFFULL) | value) - rtc_r;
             } else {
                 /* time for RV64 */
                 mtimer->time_delta = value - rtc_r;
@@ -220,7 +221,7 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
         } else {
             if (size == 4) {
                 /* time_hi for RV32/RV64 */
-                mtimer->time_delta = (value << 32 | (rtc_r & 0xFFFFFFFF)) - rtc_r;
+                mtimer->time_delta = (value << 32 | (rtc & 0xFFFFFFFF)) - rtc_r;
             } else {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "aclint-mtimer: invalid time_hi write: %08x",
-- 
2.39.2


