Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1D8053EF
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 13:15:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAUJr-0001Un-F2; Tue, 05 Dec 2023 07:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAUJo-0001UA-GN
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 07:14:29 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAUJm-0000H3-54
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 07:14:28 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40c05ce04a8so34084225e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 04:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701778464; x=1702383264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O2i2l7UTXcwW/1BuKVwvqkiOKtZAZuK4tBGvO7/lqVE=;
 b=ogm9QPYBCJKqM9gkyPjMaRufSqIM7kL0/eJ3k6+CLpLWj7nYKA4GqhbDpglMaLxS4R
 7oUZIw4n781uQIYEtbzOIdeogIvEIQDBNmYcfPVrOPXgHkZ+j/m6+CIPp6xmDilPOF+9
 kweJ5RUGaXpJQABgJmt5nmK725HmL0JeNCtYcq95CrgxsSbQAfvx14eZOPtHskfOwtJA
 Y6LOsdKXHdSHCuoQDXv6TC/LpR0cdT/2fWy86bbyA9rYXlkDZR/03jxcZob1MKaeg0ZE
 VZQdBPrtjNWD3AYuxylgJy8JpjQsNgCMvSwXaqep6yDkPhtv5EBhk1j8P8INVbMYlBVd
 l7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701778464; x=1702383264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O2i2l7UTXcwW/1BuKVwvqkiOKtZAZuK4tBGvO7/lqVE=;
 b=FNT+D8ayTcQ7XdIQC5LJN0avsR1TbYO/RoHjPV8AeB9rsRVG5zsvEOiHIA0cA1J7hv
 iE5OtFCrisfS/dcFT1u9NHdrhmNcuiwBKjaAxiPqKSEZ+KIODIK5wwUhgEB8D6IbvxaE
 1gJvF67nCbRvQK0NWvfF2YsWZzo5WVPH2RZiz1U1nFYOy7LOfy1vpxUyAaly8GNiON3O
 AM0WWjwgMU2Yowj87zLwMFQwMFVZsBrc83UPskQ7yUlyA2I0+s6j4uxU6aDeKy0ap7uZ
 rs/HH1XV29hZB1B9BlrkBbwuwrDHzJtIBbnDqFXxc9uU22w7hpTGA+4LYAZtYAaWOuVb
 q0+g==
X-Gm-Message-State: AOJu0YwAOwhyntGJPM22NL/G3dl/O7Skt+z0Eyxh0GJRE0aDi/SOioUl
 K+RQNp8saInDR9y09oHWL64zXA==
X-Google-Smtp-Source: AGHT+IEWUbEoeZBdGdg5uvUdLutk4Qzyj5cP4RKcZ4WSKQk1VJ4x/ZF/yoaQcP3gNsSQzWSy+X3onw==
X-Received: by 2002:a1c:7416:0:b0:40c:a15:eee5 with SMTP id
 p22-20020a1c7416000000b0040c0a15eee5mr914999wmc.50.1701778463867; 
 Tue, 05 Dec 2023 04:14:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u2-20020a05600c138200b00405d9a950a2sm22225347wmf.28.2023.12.05.04.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 04:14:23 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 268815F79A;
 Tue,  5 Dec 2023 12:14:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH] replay: stop us hanging in rr_wait_io_event
Date: Tue,  5 Dec 2023 12:14:20 +0000
Message-Id: <20231205121420.3287637-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
index 0f7d766efe..e71cdbf819 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -338,6 +338,30 @@ void replay_start(void)
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


