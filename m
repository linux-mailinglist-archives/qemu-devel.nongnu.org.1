Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8717900E52
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jun 2024 01:09:28 +0200 (CEST)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf4U-0000QN-SM; Fri, 07 Jun 2024 15:16:18 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf4S-0000HE-RU; Fri, 07 Jun 2024 15:16:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf4R-0002lt-7P; Fri, 07 Jun 2024 15:16:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3D06A6E55D;
 Fri,  7 Jun 2024 22:14:53 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 70D2FE2757;
 Fri,  7 Jun 2024 22:13:58 +0300 (MSK)
Received: (nullmailer pid 529419 invoked by uid 1000);
 Fri, 07 Jun 2024 19:13:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrey Shumilin <shum.sdl@nppct.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 48/71] hw/intc/arm_gic: Fix handling of NS view of
 GICC_APR<n>
Date: Fri,  7 Jun 2024 22:13:29 +0300
Message-Id: <20240607191356.529336-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Andrey Shumilin <shum.sdl@nppct.ru>

In gic_cpu_read() and gic_cpu_write(), we delegate the handling of
reading and writing the Non-Secure view of the GICC_APR<n> registers
to functions gic_apr_ns_view() and gic_apr_write_ns_view().
Unfortunately we got the order of the arguments wrong, swapping the
CPU number and the register number (which the compiler doesn't catch
because they're both integers).

Most guests probably didn't notice this bug because directly
accessing the APR registers is typically something only done by
firmware when it is doing state save for going into a sleep mode.

Correct the mismatched call arguments.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: qemu-stable@nongnu.org
Fixes: 51fd06e0ee ("hw/intc/arm_gic: Fix handling of GICC_APR<n>, GICC_NSAPR<n> registers")
Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
[PMM: Rewrote commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
(cherry picked from commit daafa78b297291fea36fb4daeed526705fa7c035)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 074cf50af2..e4b8437f8b 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1658,7 +1658,7 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
             *data = s->h_apr[gic_get_vcpu_real_id(cpu)];
         } else if (gic_cpu_ns_access(s, cpu, attrs)) {
             /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
-            *data = gic_apr_ns_view(s, regno, cpu);
+            *data = gic_apr_ns_view(s, cpu, regno);
         } else {
             *data = s->apr[regno][cpu];
         }
@@ -1746,7 +1746,7 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
             s->h_apr[gic_get_vcpu_real_id(cpu)] = value;
         } else if (gic_cpu_ns_access(s, cpu, attrs)) {
             /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
-            gic_apr_write_ns_view(s, regno, cpu, value);
+            gic_apr_write_ns_view(s, cpu, regno, value);
         } else {
             s->apr[regno][cpu] = value;
         }
-- 
2.39.2


