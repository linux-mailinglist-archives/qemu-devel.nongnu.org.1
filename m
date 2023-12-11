Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4542380C430
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:16:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcMS-0001Qj-9J; Mon, 11 Dec 2023 04:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMQ-0001Q6-7j
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:58 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMO-0004Ly-9t
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:57 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c2718a768so45115485e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286035; x=1702890835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Empg023tjpYJtJwnns0c9XdxnArIwdv6MObgi9qbIew=;
 b=rQDDM3s8KLfCwkuv23t5/KkDoNOnMqT//ByV2CnGjWCuD6STlgdjXuyptQMd+Ii1dx
 /czy48QLd13VDjqWIfHcV1ilz+4mP/5/Fu7qNNdmnq4ySSGdGlRSFvt6fgRWmmSBlVCO
 qqYv4Qg1LUzNPLJGRzyOqwYb9vPaS2pRtHm+BjzHE/hZgMD8n0WNUmzDcO01NqI9QWLi
 bXW70eY2CPbYOImnyIzlG00g4qogkpzSa6sCls1ooVSzHsP2RAxtiErbTGCyn/9D1KUQ
 mSW77SYN8l8l7HbxDHaljN+2y9QCqkN1o3Wa2P5v0x+gWKknCOFAdvkG2KznIj/VhkUF
 OqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286035; x=1702890835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Empg023tjpYJtJwnns0c9XdxnArIwdv6MObgi9qbIew=;
 b=flZOPvmrGfrJ42+7A4nI4hQUvkQNv+EaO8gEsGijM/dm1Vt5DE2wz8Aut6+2XDgsF0
 6GI7i/b+MRgR0gChNlF7UQPz0paJllCfsS41mnOXnpZt+eV3KVOp3lR7zJmaT5ySV7Zl
 4gkqMccp3nvN8xeJO4HyaubmZMhiyCo+LRkaI66wcWOftuEdDleiJAeAYVrlJgwHxfs/
 +9jDan5JlYl/HeD5wdG1id2mg5g+aPAKhg7hjEjp5+LlgHz6UAeshmv5S0QZ/I7/UIjc
 SnPyTODLOHFuMcSC1q8IMhQjn5p0KpHxR/5Cp3FYrW0JPpgp1nXLFboXw1IskuhYAdEx
 nfDg==
X-Gm-Message-State: AOJu0Yz3wCGdyWYOa5FmQssvIMSd3kd/9xy2A0L3TB7VxlbRorcd29XM
 w/b0UPNDLgrymy7aRYZJ8ZEpHQ==
X-Google-Smtp-Source: AGHT+IEbBXo7f8MabZd/lRWJp93qVORtQ/gJp/MDpYMPAjfh5bcpw9MNucWgvFKTnWwOTNCdsrc9Vw==
X-Received: by 2002:a05:600c:21cf:b0:40c:2bb5:f8d with SMTP id
 x15-20020a05600c21cf00b0040c2bb50f8dmr2499931wmj.123.1702286034844; 
 Mon, 11 Dec 2023 01:13:54 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n10-20020a05600c500a00b004094e565e71sm12279016wmr.23.2023.12.11.01.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:13:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DDDC85FBEE;
 Mon, 11 Dec 2023 09:13:46 +0000 (GMT)
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
Subject: [PATCH v2 09/16] replay: introduce a central report point for sync
 errors
Date: Mon, 11 Dec 2023 09:13:38 +0000
Message-Id: <20231211091346.14616-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Figuring out why replay has failed is tricky at the best of times.
Lets centralise the reporting of a replay sync error and add a little
bit of extra information to help with debugging.

Message-Id: <20231205204106.95531-9-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - split the char reporting into new commit
  - report the event name rather than id
  - add current_event to VMState snapshot
---
 replay/replay-internal.h |  19 ++++++-
 replay/replay-internal.c |   1 +
 replay/replay-snapshot.c |   1 +
 replay/replay.c          | 111 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 1bc8fd5086..75249b7693 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -25,7 +25,12 @@ typedef enum ReplayAsyncEventKind {
     REPLAY_ASYNC_COUNT
 } ReplayAsyncEventKind;
 
-/* Any changes to order/number of events will need to bump REPLAY_VERSION */
+/*
+ * Any changes to order/number of events will need to bump
+ * REPLAY_VERSION to prevent confusion with old logs. Also don't
+ * forget to update replay_event_name() to make your debugging life
+ * easier.
+ */
 enum ReplayEvents {
     /* for instruction event */
     EVENT_INSTRUCTION,
@@ -74,6 +79,7 @@ enum ReplayEvents {
  * @cached_clock: Cached clocks values
  * @current_icount: number of processed instructions
  * @instruction_count: number of instructions until next event
+ * @current_event: current event index
  * @data_kind: current event
  * @has_unread_data: true if event not yet processed
  * @file_offset: offset into replay log at replay snapshot
@@ -84,6 +90,7 @@ typedef struct ReplayState {
     int64_t cached_clock[REPLAY_CLOCK_COUNT];
     uint64_t current_icount;
     int instruction_count;
+    unsigned int current_event;
     unsigned int data_kind;
     bool has_unread_data;
     uint64_t file_offset;
@@ -188,6 +195,16 @@ void replay_event_net_save(void *opaque);
 /*! Reads network from the file. */
 void *replay_event_net_load(void);
 
+/* Diagnostics */
+
+/**
+ * replay_sync_error(): report sync error and exit
+ *
+ * When we reach an error condition we want to report it centrally so
+ * we can also dump some useful information into the logs.
+ */
+G_NORETURN void replay_sync_error(const char *error);
+
 /* VMState-related functions */
 
 /* Registers replay VMState.
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 634025096e..654b99cfb5 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -175,6 +175,7 @@ void replay_fetch_data_kind(void)
     if (replay_file) {
         if (!replay_state.has_unread_data) {
             replay_state.data_kind = replay_get_byte();
+            replay_state.current_event++;
             if (replay_state.data_kind == EVENT_INSTRUCTION) {
                 replay_state.instruction_count = replay_get_dword();
             }
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index bf75c2ed28..a24d8a7483 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -55,6 +55,7 @@ static const VMStateDescription vmstate_replay = {
         VMSTATE_INT64_ARRAY(cached_clock, ReplayState, REPLAY_CLOCK_COUNT),
         VMSTATE_UINT64(current_icount, ReplayState),
         VMSTATE_INT32(instruction_count, ReplayState),
+        VMSTATE_UINT32(current_event, ReplayState),
         VMSTATE_UINT32(data_kind, ReplayState),
         VMSTATE_BOOL(has_unread_data, ReplayState),
         VMSTATE_UINT64(file_offset, ReplayState),
diff --git a/replay/replay.c b/replay/replay.c
index d729214197..3ab6360cfa 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -38,6 +38,107 @@ static GSList *replay_blockers;
 uint64_t replay_break_icount = -1ULL;
 QEMUTimer *replay_break_timer;
 
+/* Pretty print event names */
+
+static const char *replay_async_event_name(ReplayAsyncEventKind event)
+{
+    switch (event) {
+#define ASYNC_EVENT(_x) case REPLAY_ASYNC_EVENT_ ## _x: return "ASYNC_EVENT_"#_x
+        ASYNC_EVENT(BH);
+        ASYNC_EVENT(BH_ONESHOT);
+        ASYNC_EVENT(INPUT);
+        ASYNC_EVENT(INPUT_SYNC);
+        ASYNC_EVENT(CHAR_READ);
+        ASYNC_EVENT(BLOCK);
+        ASYNC_EVENT(NET);
+#undef ASYNC_EVENT
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const char *replay_clock_event_name(ReplayClockKind clock)
+{
+    switch (clock) {
+#define CLOCK_EVENT(_x) case REPLAY_CLOCK_ ## _x: return "CLOCK_" #_x
+        CLOCK_EVENT(HOST);
+        CLOCK_EVENT(VIRTUAL_RT);
+#undef CLOCK_EVENT
+    default:
+        g_assert_not_reached();
+    }
+}
+
+/* Pretty print shutdown event names */
+static const char *replay_shutdown_event_name(ShutdownCause cause)
+{
+    switch (cause) {
+#define SHUTDOWN_EVENT(_x) case SHUTDOWN_CAUSE_ ## _x: return "SHUTDOWN_CAUSE_" #_x
+        SHUTDOWN_EVENT(NONE);
+        SHUTDOWN_EVENT(HOST_ERROR);
+        SHUTDOWN_EVENT(HOST_QMP_QUIT);
+        SHUTDOWN_EVENT(HOST_QMP_SYSTEM_RESET);
+        SHUTDOWN_EVENT(HOST_SIGNAL);
+        SHUTDOWN_EVENT(HOST_UI);
+        SHUTDOWN_EVENT(GUEST_SHUTDOWN);
+        SHUTDOWN_EVENT(GUEST_RESET);
+        SHUTDOWN_EVENT(GUEST_PANIC);
+        SHUTDOWN_EVENT(SUBSYSTEM_RESET);
+        SHUTDOWN_EVENT(SNAPSHOT_LOAD);
+#undef SHUTDOWN_EVENT
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const char *replay_checkpoint_event_name(enum ReplayCheckpoint checkpoint)
+{
+    switch (checkpoint) {
+#define CHECKPOINT_EVENT(_x) case CHECKPOINT_ ## _x: return "CHECKPOINT_" #_x
+        CHECKPOINT_EVENT(CLOCK_WARP_START);
+        CHECKPOINT_EVENT(CLOCK_WARP_ACCOUNT);
+        CHECKPOINT_EVENT(RESET_REQUESTED);
+        CHECKPOINT_EVENT(SUSPEND_REQUESTED);
+        CHECKPOINT_EVENT(CLOCK_VIRTUAL);
+        CHECKPOINT_EVENT(CLOCK_HOST);
+        CHECKPOINT_EVENT(CLOCK_VIRTUAL_RT);
+        CHECKPOINT_EVENT(INIT);
+        CHECKPOINT_EVENT(RESET);
+#undef CHECKPOINT_EVENT
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const char *replay_event_name(enum ReplayEvents event)
+{
+    /* First deal with the simple ones */
+    switch (event) {
+#define EVENT(_x) case EVENT_ ## _x: return "EVENT_"#_x
+        EVENT(INSTRUCTION);
+        EVENT(INTERRUPT);
+        EVENT(EXCEPTION);
+        EVENT(CHAR_WRITE);
+        EVENT(CHAR_READ_ALL);
+        EVENT(AUDIO_OUT);
+        EVENT(AUDIO_IN);
+        EVENT(RANDOM);
+#undef EVENT
+    default:
+        if (event >= EVENT_ASYNC && event <= EVENT_ASYNC_LAST) {
+            return replay_async_event_name(event - EVENT_ASYNC);
+        } else if (event >= EVENT_SHUTDOWN && event <= EVENT_SHUTDOWN_LAST) {
+            return replay_shutdown_event_name(event - EVENT_SHUTDOWN);
+        } else if (event >= EVENT_CLOCK && event <= EVENT_CLOCK_LAST) {
+            return replay_clock_event_name(event - EVENT_CLOCK);
+        } else if (event >= EVENT_CHECKPOINT && event <= EVENT_CHECKPOINT_LAST) {
+            return replay_checkpoint_event_name(event - EVENT_CHECKPOINT);
+        }
+    }
+
+    g_assert_not_reached();
+}
+
 bool replay_next_event_is(int event)
 {
     bool res = false;
@@ -226,6 +327,15 @@ bool replay_has_event(void)
     return res;
 }
 
+G_NORETURN void replay_sync_error(const char *error)
+{
+    error_report("%s (insn total %"PRId64"/%d left, event %d is %s)", error,
+                 replay_state.current_icount, replay_state.instruction_count,
+                 replay_state.current_event,
+                 replay_event_name(replay_state.data_kind));
+    abort();
+}
+
 static void replay_enable(const char *fname, int mode)
 {
     const char *fmode = NULL;
@@ -258,6 +368,7 @@ static void replay_enable(const char *fname, int mode)
     replay_state.data_kind = -1;
     replay_state.instruction_count = 0;
     replay_state.current_icount = 0;
+    replay_state.current_event = 0;
     replay_state.has_unread_data = false;
 
     /* skip file header for RECORD and check it for PLAY */
-- 
2.39.2


