Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D66E3A356AB
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Feb 2025 06:57:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiofm-0000aS-GE; Fri, 14 Feb 2025 00:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tiofi-0000Yp-FH; Fri, 14 Feb 2025 00:55:30 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tiofg-00084H-Sp; Fri, 14 Feb 2025 00:55:30 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BE866EAB0D;
 Fri, 14 Feb 2025 08:55:12 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BDE691B5FC3;
 Fri, 14 Feb 2025 08:55:20 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AB8AF53462; Fri, 14 Feb 2025 08:55:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 2/4] qemu/timer: Clarify timer_new*() must be freed with
 timer_free()
Date: Fri, 14 Feb 2025 08:55:18 +0300
Message-Id: <20250214055520.3159764-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250214055520.3159764-1-mjt@tls.msk.ru>
References: <20250214055520.3159764-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

There was not mention QEMUTimer created with timer_new*() must
be released with timer_free() instead of g_free(), because then
active timers are removed from the active list. Update the
documentation mentioning timer_free().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/qemu/timer.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index cc167bd825..abd2204f3b 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -507,6 +507,8 @@ static inline void timer_init_ms(QEMUTimer *ts, QEMUClockType type,
  * with an AioContext---each of them runs its timer callbacks in its own
  * AioContext thread.
  *
+ * The timer returned must be freed using timer_free().
+ *
  * Returns: a pointer to the timer
  */
 static inline QEMUTimer *timer_new_full(QEMUTimerListGroup *timer_list_group,
@@ -530,6 +532,8 @@ static inline QEMUTimer *timer_new_full(QEMUTimerListGroup *timer_list_group,
  * and associate it with the default timer list for the clock type @type.
  * See timer_new_full for details.
  *
+ * The timer returned must be freed using timer_free().
+ *
  * Returns: a pointer to the timer
  */
 static inline QEMUTimer *timer_new(QEMUClockType type, int scale,
@@ -548,6 +552,8 @@ static inline QEMUTimer *timer_new(QEMUClockType type, int scale,
  * associated with the clock.
  * See timer_new_full for details.
  *
+ * The timer returned must be freed using timer_free().
+ *
  * Returns: a pointer to the newly created timer
  */
 static inline QEMUTimer *timer_new_ns(QEMUClockType type, QEMUTimerCB *cb,
@@ -566,6 +572,8 @@ static inline QEMUTimer *timer_new_ns(QEMUClockType type, QEMUTimerCB *cb,
  * associated with the clock.
  * See timer_new_full for details.
  *
+ * The timer returned must be freed using timer_free().
+ *
  * Returns: a pointer to the newly created timer
  */
 static inline QEMUTimer *timer_new_us(QEMUClockType type, QEMUTimerCB *cb,
@@ -584,6 +592,8 @@ static inline QEMUTimer *timer_new_us(QEMUClockType type, QEMUTimerCB *cb,
  * associated with the clock.
  * See timer_new_full for details.
  *
+ * The timer returned must be freed using timer_free().
+ *
  * Returns: a pointer to the newly created timer
  */
 static inline QEMUTimer *timer_new_ms(QEMUClockType type, QEMUTimerCB *cb,
-- 
2.39.5


