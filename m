Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ACE8272C6
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:17:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrKN-0004J9-Tp; Mon, 08 Jan 2024 10:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKL-0004Gj-Ms
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:09 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKF-0001c2-MQ
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:08 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e4b20a52bso2169005e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704726842; x=1705331642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/3f/gZt7kuZhNsGlk9QFjConVSBhlieoHxarURcJ0oU=;
 b=I/LFI0BL5RQe6weroZ1gezUBYUaosPFCVYGZUnqcUcmZPJngqqw62jmJtT88Hypvl9
 pwPrhRrUucZwTdbFk1ph0Bq9LUEJN9tNBXWEiSJf5e+FneiF7X53V62uqHhAZfUjJKaD
 a3v9whsDxjCTTL/AmISoxwXtFrQkcCwVaq/h4DT2QxDn7fafbT2s+XR9AUefjBWHyIPq
 9I7h9EwyAa0CKLDTRokHTVwOPIAN/MTEl7QXfD4x+3JwvjQJLopJkCCIiR/Oqu8qcXjC
 /1h3JC8MIBNbXPoLv6KW/Zk3ekc+ArpZKx//ObdfTHhyR7ZIXIggVIOhh74K60VBPbzq
 Ql2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704726842; x=1705331642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/3f/gZt7kuZhNsGlk9QFjConVSBhlieoHxarURcJ0oU=;
 b=VltuFMbzxdKQop/ypg35ii8BwOKhmwMv+QVED/euvGdPDZme2qFDuS00t9cvOPd54z
 kJolC4AJDvDO5ui4fY+ebS+rUGSEsFbyP1cp6n7XVl6U/N4fOEPndL/wVc4kuCXmYq0Z
 PR4zU+bNe3GGmxFYQGbZJUB9mqryNmsWZCxBhyuDEI6SjXQS4i1Z8quMFLzAijT3a1Gl
 2YsecVBkMtBggOk034KSdD5yGAg/zZ8i4sW1TaVK0k9BFu0L86sKSZypRU3ezByxdKNJ
 9L3j4UGWd27ivlhkEta9dTRnckfkhYxKps+R8Cvicnj4jwCewTV5xNY0OsktNhTElc+Q
 gq5A==
X-Gm-Message-State: AOJu0YyMadkkO3AyJq2SI1PqWAef5+SIq9LG/C//8zIyTYK1vVxfQmXK
 In2cj44aqr9Oc3swuUKUkm9VctiJwMjLwA==
X-Google-Smtp-Source: AGHT+IH4ed5oIIydyYvlM/aTrzFpYYXIb19bG6WCEp6jHrwcz+wH2DdAvLIjtlNN8ycxoPkT+WRr8g==
X-Received: by 2002:a7b:c4c5:0:b0:40e:4a75:e6c8 with SMTP id
 g5-20020a7bc4c5000000b0040e4a75e6c8mr410391wmk.116.1704726842222; 
 Mon, 08 Jan 2024 07:14:02 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k25-20020a05600c1c9900b0040d87b9eec7sm11452358wms.32.2024.01.08.07.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:14:01 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CD36F5F950;
 Mon,  8 Jan 2024 15:13:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 11/13] replay: stop us hanging in rr_wait_io_event
Date: Mon,  8 Jan 2024 15:13:50 +0000
Message-Id: <20240108151352.2199097-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108151352.2199097-1-alex.bennee@linaro.org>
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231211091346.14616-12-alex.bennee@linaro.org>

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 08aae5869fc..83995ae4bd4 100644
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
index 611932f3c3a..825e35b3dc4 100644
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
index ff197f436bf..3fd241a4fcc 100644
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


