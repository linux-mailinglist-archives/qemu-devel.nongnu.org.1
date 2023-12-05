Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A13805FA5
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 21:43:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAcEK-0007RK-Bv; Tue, 05 Dec 2023 15:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEF-0007QO-Mq
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:15 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcED-0002FY-TH
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:15 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3316c6e299eso75934f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 12:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701808872; x=1702413672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4GcixrJLz9YAIgU+u8MRbzGUgAv+ZLjiVh41JlVLC0=;
 b=ArJAr8CmoGO6mRxH+TVptMJo8H9OPnmrFIB2WlVJN3fr6sESS2yliRHpjHxDRiW2lm
 lyICFBSJSMPhkHZySZxqUfuvG0D+Dm4i6t129CQ2Ad7mPs25CNr6W4MQhZh5hpI65Ebk
 jApWmAf0Ws7ybIG/Jc+QrxkH/T2SCZRB1T5Pp3IekMQoQiwm3/1+L5eh3MdSWYdh6OLa
 5gnQkl9MLpTwm7lLbLzt1yw1cXLr/v+ShrtDoQ3O5yZlLbzgLRAitB6sd3KkMtHzz3cG
 XXqD5xSbgq33xTI2UshxywHzlUvEUxZ/wYm4bSrEE83rKqVYmDcGvl8aulspTQi9UCiR
 7Emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701808872; x=1702413672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d4GcixrJLz9YAIgU+u8MRbzGUgAv+ZLjiVh41JlVLC0=;
 b=t4TXet0xhSevsEr/Lx2KKAexPnax4EY6Qi4PETyjZLNpI6OKcztUL0kH8biLJ8758y
 57JPZ4jpg0ldkR5gZQuNcSBmhVljOrhq04z1XX1sG/5AghJihHuMqTxt3RnG9npl0Sn7
 qvUZCjL404Be5y13Qfl1RyA7Lap1do9ZTH0mkyCZFIs49JcEhAKW6dxKaGoeXbDs4Lgp
 62x0QH8Z2FwR91ndcNGXnkH9ialilK/TIUjyS8nUUgbXTWfs+1HDozgYJYlkOOWN2dPt
 SRPtDgIyk0mArgsJ31lZmYa0BBqZOgYrKy1M6ANUPpeLg+mBAU7Cg4GAdWR2kcnkqN80
 PwjA==
X-Gm-Message-State: AOJu0Yz+gBpDqa6uiQYwrEVwfMLIdLySYxqZQWeiiU6eBiw0hTI1VEgn
 NEPZCZ30MysbzNy/AY0V/DnrpA==
X-Google-Smtp-Source: AGHT+IG50INnoos3vW7nHMWwz6PcwtMTnR1tTuOZmNIpbs2GBVdbiBiUuCWKsZ1WaE8o5wv/bJPoTA==
X-Received: by 2002:a5d:480f:0:b0:333:2fd2:3c02 with SMTP id
 l15-20020a5d480f000000b003332fd23c02mr3241851wrq.187.1701808872500; 
 Tue, 05 Dec 2023 12:41:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6046000000b0033326e90496sm14426972wrt.18.2023.12.05.12.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 12:41:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C12755FBB6;
 Tue,  5 Dec 2023 20:41:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 09/11] replay: stop us hanging in rr_wait_io_event
Date: Tue,  5 Dec 2023 20:41:04 +0000
Message-Id: <20231205204106.95531-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205204106.95531-1-alex.bennee@linaro.org>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

A lot of the hang I see are when we end up spinning in
rr_wait_io_event for an event that will never come in playback. As a
new check functions which can see if we are in PLAY mode and kick us
us the wait function so the event can be processed.

This fixes most of the failures in replay_kernel.py

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2013
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 include/sysemu/replay.h      |  5 +++++
 accel/tcg/tcg-accel-ops-rr.c |  2 +-
 replay/replay.c              | 24 ++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 08aae5869f..83995ae4bd 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -70,6 +70,11 @@ int replay_get_instructions(void);
 /*! Updates instructions counter in replay mode. */
 void replay_account_executed_instructions(void);
 
+/**
+ * replay_can_wait: check if we should pause for wait-io
+ */
+bool replay_can_wait(void);
+
 /* Processing clocks and other time sources */
 
 /*! Save the specified clock */
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 611932f3c3..825e35b3dc 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -109,7 +109,7 @@ static void rr_wait_io_event(void)
 {
     CPUState *cpu;
 
-    while (all_cpu_threads_idle()) {
+    while (all_cpu_threads_idle() && replay_can_wait()) {
         rr_stop_kick_timer();
         qemu_cond_wait_iothread(first_cpu->halt_cond);
     }
diff --git a/replay/replay.c b/replay/replay.c
index e83c01285c..042a6a9636 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -347,6 +347,30 @@ void replay_start(void)
     replay_enable_events();
 }
 
+/*
+ * For none/record the answer is yes.
+ */
+bool replay_can_wait(void)
+{
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        /*
+         * For playback we shouldn't ever be at a point we wait. If
+         * the instruction count has reached zero and we have an
+         * unconsumed event we should go around again and consume it.
+         */
+        if (replay_state.instruction_count == 0 && replay_state.has_unread_data) {
+            return false;
+        } else {
+            fprintf(stderr, "Error: Invalid replay state\n");
+            fprintf(stderr,"instruction_count = %d, has = %d, event_kind = %d\n",
+                    replay_state.instruction_count, replay_state.has_unread_data, replay_state.data_kind);
+            abort();
+        }
+    }
+    return true;
+}
+
+
 void replay_finish(void)
 {
     if (replay_mode == REPLAY_MODE_NONE) {
-- 
2.39.2


