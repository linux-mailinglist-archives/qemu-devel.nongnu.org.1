Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 669D1805FA3
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 21:43:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAcEO-0007SH-Ka; Tue, 05 Dec 2023 15:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEG-0007Qn-CB
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:16 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEE-0002Fl-In
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:16 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40c09f4bea8so29022645e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 12:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701808873; x=1702413673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nlo6CezYV3r03v3L8dVzCnnygHyr+7WQt60cA9zru2s=;
 b=Rz5ED1JFG/OHwJhRSuGcoTM00ALIt7PSBeSSE00vybgDWnjfDVgvH3qUAZiagXdpji
 p3Cu1AK9BOadylYWwqzMajL/y8mZEn663MHVoEZe3k9bP7y/tmBVNBNnxOHYtyP8UkLD
 86Ikh0S9MM21/67AHzXnixYD6agtfNNQUL+gOE09kfRvzUgdZcQ5jaLdAToRyYXEbTnd
 1hndvUkv8EDS77jgNljgrxjj7bzTJ9kfgqTQJRYYCRnMFTYtEsgs+DXjtzLIL/MK/v0R
 Gkk/50rt2dQy9BhCtB6RDwMldPqxH9Uooej4Gd/jt8Nr6ind60iAmNF1Qu5rWgGTyEO/
 LzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701808873; x=1702413673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nlo6CezYV3r03v3L8dVzCnnygHyr+7WQt60cA9zru2s=;
 b=PWJW+9joA90tNsHlrsRObtstIXTktur7m/0oVDbxD+rHwDYNChljEHYRP+Gj2zmMVu
 5FOhObl1FLfCl5GTFkmmP1kG18WjsJSZtIfLTPvizstXno/Vu4Q9fdMiEbwW6X6+p7F6
 sz+maTHfoSpRN8TrcZM/queoJsyGfISAZ+9VCj6IjpV8b+Yzx2jfduk8Ey28AehnZlW6
 HEChJS04nTKHaPwbdMdZ9LkZ7FLIpU5Y4q5An5IMHo2c0/1JpB40lLACaNczX0lFRJ7t
 Zq5kLrtsVwX5x9DTsdNcYsIXCf2iws09v7StGNZZDHHeiqwhLL27nfMHtGTeDgcov5jz
 lHWw==
X-Gm-Message-State: AOJu0YwGhEjgQ2bz4d51JpCx9AxCtABP1gMub74J+hTd3BZ7a3oLN64F
 yxMndl/llia/XUKGXvJYjye6Lg==
X-Google-Smtp-Source: AGHT+IG7qbfIJ+TeagYqzOdFVQSKN/ifiE+mZzFoLvqx70MC8FR1TBTdVhGxDI1MflXBtvaMlh4fbQ==
X-Received: by 2002:a05:600c:1f90:b0:407:7ea1:e9a4 with SMTP id
 je16-20020a05600c1f9000b004077ea1e9a4mr1011296wmb.5.1701808872877; 
 Tue, 05 Dec 2023 12:41:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w18-20020a5d4b52000000b0033334df1259sm11421633wrs.20.2023.12.05.12.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 12:41:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AC8F25FBC8;
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
Subject: [PATCH 08/11] replay: introduce a central report point for sync errors
Date: Tue,  5 Dec 2023 20:41:03 +0000
Message-Id: <20231205204106.95531-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205204106.95531-1-alex.bennee@linaro.org>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 replay/replay-internal.h | 12 ++++++++++++
 replay/replay-char.c     |  6 ++----
 replay/replay-internal.c |  1 +
 replay/replay.c          |  9 +++++++++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 1bc8fd5086..709e2eb4cb 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -74,6 +74,7 @@ enum ReplayEvents {
  * @cached_clock: Cached clocks values
  * @current_icount: number of processed instructions
  * @instruction_count: number of instructions until next event
+ * @current_event: current event index
  * @data_kind: current event
  * @has_unread_data: true if event not yet processed
  * @file_offset: offset into replay log at replay snapshot
@@ -84,6 +85,7 @@ typedef struct ReplayState {
     int64_t cached_clock[REPLAY_CLOCK_COUNT];
     uint64_t current_icount;
     int instruction_count;
+    unsigned int current_event;
     unsigned int data_kind;
     bool has_unread_data;
     uint64_t file_offset;
@@ -188,6 +190,16 @@ void replay_event_net_save(void *opaque);
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
diff --git a/replay/replay-char.c b/replay/replay-char.c
index a31aded032..72b1f832dd 100644
--- a/replay/replay-char.c
+++ b/replay/replay-char.c
@@ -113,8 +113,7 @@ void replay_char_write_event_load(int *res, int *offset)
         *offset = replay_get_dword();
         replay_finish_event();
     } else {
-        error_report("Missing character write event in the replay log");
-        exit(1);
+        replay_sync_error("Missing character write event in the replay log");
     }
 }
 
@@ -135,8 +134,7 @@ int replay_char_read_all_load(uint8_t *buf)
         replay_finish_event();
         return res;
     } else {
-        error_report("Missing character read all event in the replay log");
-        exit(1);
+        replay_sync_error("Missing character read all event in the replay log");
     }
 }
 
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
diff --git a/replay/replay.c b/replay/replay.c
index d729214197..e83c01285c 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -226,6 +226,14 @@ bool replay_has_event(void)
     return res;
 }
 
+G_NORETURN void replay_sync_error(const char *error)
+{
+    error_report("%s (insn total %"PRId64"/%d left, event %u/%u)", error,
+                 replay_state.current_icount, replay_state.instruction_count,
+                 replay_state.current_event, replay_state.data_kind);
+    abort();
+}
+
 static void replay_enable(const char *fname, int mode)
 {
     const char *fmode = NULL;
@@ -258,6 +266,7 @@ static void replay_enable(const char *fname, int mode)
     replay_state.data_kind = -1;
     replay_state.instruction_count = 0;
     replay_state.current_icount = 0;
+    replay_state.current_event = 0;
     replay_state.has_unread_data = false;
 
     /* skip file header for RECORD and check it for PLAY */
-- 
2.39.2


