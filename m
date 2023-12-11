Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D3180C420
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:15:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcMW-0001SB-2y; Mon, 11 Dec 2023 04:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMT-0001RX-OI
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:14:01 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMS-0004MH-33
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:14:01 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3332efd75c9so3883296f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286037; x=1702890837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZyUUUbIxqiiG4umBh+NSFFGXFuKjw1v2RZdUYXJB6cI=;
 b=BBaZdwmGvcVsnne6vn9pZ3ooD8i4Yd5SpMVx0dVThqwXAvQZQHMOK2PZRbJd7LSEwB
 bDZI+WpVvpR1R+UGlx6SU59eNGYnE2xvK/K5tsFLzQGAo4gXGVQvAe+1wdKU4+hZqOtD
 2kEYT3hg+n5RphfaGUNFQNpLAiYIuMwMDrBNQfq/p7HV+MoC7FVhDhqXXvb7RcYwK8Dv
 u81qYvWvVGWFlhRtzfOPN1HVGbtZ9UgFHSUMukPHmXvoTBVGtwLydIt5UqoBUkdLnk4S
 xYMB1tKTgTTUf+KggIbBach1ZADBVFmIGKqlHehTN+TX0mibr8ejFMpiPTMfgX11kQ7g
 euwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286037; x=1702890837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZyUUUbIxqiiG4umBh+NSFFGXFuKjw1v2RZdUYXJB6cI=;
 b=Kd+Jk0HtR5yVx7mVQ7fqF1xQpHhAYbvhoYaM7YkQwO4UvlzZpN/HSA/4uDoQDpKQw0
 Fsfmi3kT8Kqoltr6GSoaR6jthbQDKoKtm+Miax/znyhupYONAov57TYH3mx3qo/KNmyt
 GeMqeqsSNL+2xPysudMVMrFE4xsBrG8p4OQpaglHYOgKQJj3Y3grndboK4q8xu+tkZXu
 dimz9eFB4OdHdLAeMkzNaGCw43Sz1wCvPRt+nESa6PxmF+7itmJLgwlfStBjnMLTYj3W
 IqjQgsGlAv0VucwITvGHsvTfqSPU9K2j6xS/32IIva+B/y6gkFXXDT+6xQ3vja+PIaro
 hbxQ==
X-Gm-Message-State: AOJu0YzExZSlASbD6I5H0IilZ4ZmUCKbCZD0hFeN56eEVOJwp4iHn1TO
 XrGG7vFVHy+1h3R+5VWhyaz1UQ==
X-Google-Smtp-Source: AGHT+IFKH3+rvZ3KmVY2lBwc7RwlO9vZtgfXoEMugRzZ0i5pd5mELv+AyZ1vSo+XLedN99G5e/mcaw==
X-Received: by 2002:adf:f60f:0:b0:332:dfeb:76ab with SMTP id
 t15-20020adff60f000000b00332dfeb76abmr997353wrp.60.1702286036736; 
 Mon, 11 Dec 2023 01:13:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b18-20020adfe652000000b003333f5f5fd7sm8073340wrn.31.2023.12.11.01.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:13:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 14DA15FBF2;
 Mon, 11 Dec 2023 09:13:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 11/16] replay: stop us hanging in rr_wait_io_event
Date: Mon, 11 Dec 2023 09:13:40 +0000
Message-Id: <20231211091346.14616-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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
v2
  - report failure with replay_sync_error
---
 include/sysemu/replay.h      |  5 +++++
 accel/tcg/tcg-accel-ops-rr.c |  2 +-
 replay/replay.c              | 21 +++++++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

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
index 3ab6360cfa..665dbb34fb 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -449,6 +449,27 @@ void replay_start(void)
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
+            replay_sync_error("Playback shouldn't have to iowait");
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


