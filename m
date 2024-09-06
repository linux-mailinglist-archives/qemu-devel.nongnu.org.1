Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0496F2D0
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 13:21:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smX0p-0004i6-M7; Fri, 06 Sep 2024 07:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smX0P-0003pF-5t; Fri, 06 Sep 2024 07:20:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smX0L-0008My-FX; Fri, 06 Sep 2024 07:19:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D8A0F8C4B4;
 Fri,  6 Sep 2024 14:12:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E557D13371D;
 Fri,  6 Sep 2024 14:13:28 +0300 (MSK)
Received: (nullmailer pid 353765 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:25 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 67/69] Revert "replay: stop us hanging in
 rr_wait_io_event"
Date: Fri,  6 Sep 2024 14:13:16 +0300
Message-Id: <20240906111324.353230-67-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
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

From: Nicholas Piggin <npiggin@gmail.com>

This reverts commit 1f881ea4a444ef36a8b6907b0b82be4b3af253a2.

That commit causes reverse_debugging.py test failures, and does
not seem to solve the root cause of the problem x86-64 still
hangs in record/replay tests.

The problem with short-cutting the iowait that was taken during
record phase is that related events will not get consumed at the
same points (e.g., reading the clock).

A hang with zero icount always seems to be a symptom of an earlier
problem that has caused the recording to become out of synch with
the execution and consumption of events by replay.

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20240813050638.446172-6-npiggin@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-14-alex.bennee@linaro.org>
(cherry picked from commit 94962ff00d09674047aed896e87ba09736cd6941)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2524

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 894e73e52c..a942442a33 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -109,7 +109,7 @@ static void rr_wait_io_event(void)
 {
     CPUState *cpu;
 
-    while (all_cpu_threads_idle() && replay_can_wait()) {
+    while (all_cpu_threads_idle()) {
         rr_stop_kick_timer();
         qemu_cond_wait_bql(first_cpu->halt_cond);
     }
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index f229b2109c..8102fa54f0 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -73,11 +73,6 @@ int replay_get_instructions(void);
 /*! Updates instructions counter in replay mode. */
 void replay_account_executed_instructions(void);
 
-/**
- * replay_can_wait: check if we should pause for wait-io
- */
-bool replay_can_wait(void);
-
 /* Processing clocks and other time sources */
 
 /*! Save the specified clock */
diff --git a/replay/replay.c b/replay/replay.c
index a2c576c16e..325e275756 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -449,27 +449,6 @@ void replay_start(void)
     replay_enable_events();
 }
 
-/*
- * For none/record the answer is yes.
- */
-bool replay_can_wait(void)
-{
-    if (replay_mode == REPLAY_MODE_PLAY) {
-        /*
-         * For playback we shouldn't ever be at a point we wait. If
-         * the instruction count has reached zero and we have an
-         * unconsumed event we should go around again and consume it.
-         */
-        if (replay_state.instruction_count == 0 && replay_state.has_unread_data) {
-            return false;
-        } else {
-            replay_sync_error("Playback shouldn't have to iowait");
-        }
-    }
-    return true;
-}
-
-
 void replay_finish(void)
 {
     if (replay_mode == REPLAY_MODE_NONE) {
-- 
2.39.2


