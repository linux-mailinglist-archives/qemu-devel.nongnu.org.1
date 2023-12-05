Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F86805F98
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 21:42:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAcEF-0007PX-Gz; Tue, 05 Dec 2023 15:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcED-0007OL-CR
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:13 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEB-0002Ep-Ky
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:13 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40bda47c489so42985715e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 12:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701808870; x=1702413670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+OK2n1Fz+j7PdxiFIWkIMZ0hIcv40Fig/K+AFS5+zk=;
 b=kE/hA+dXIb7p05MtCkoAnZF3DyyT/4/p4qGWNDfDGouMaIBQ1S6vmIk3eJozbxbqDq
 xs5GLckf0/03g+1jM5L8Fw/3Mvhxc3SPXgwzmefoEus19LaNz84B5PAQR7fl9W9ZQ003
 30InIVhtQOKbDkyGncrz5sYwOy1giI7JCZwPnJy8Mvp1mEj2l63x2UT4NFewUoOYJueB
 I8oz0ayeWY9IdBJGuwDuLRbOj6RUwGWzNu5riOaxaO1MBSbcVf987C6jDex1LI2G5hY8
 qsDrawLIBdeV9dTRFAkYUNrHh9hvE+nn0nYFbqRDGSQVLN0FFleX3ntBCrU+4KRTjDhQ
 lMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701808870; x=1702413670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+OK2n1Fz+j7PdxiFIWkIMZ0hIcv40Fig/K+AFS5+zk=;
 b=slGKLzKRDJ5XS/k1SKPKbwPI5l9/8MyeaCfIimTtvzO1yeQeIOZ5uO+yyFluTGMSMz
 Xskywz9py0khyRrwLVtF85zulvuNysbRqWK34S7EXkHJt7JWuYx+sTcVumvXlAvaXEOO
 ae4+QXdiS6I2Tpd6rBPZpQzzqmI4hRoWdbQX1k67YZPuwqKvKvJYPChkpONcw/fGqows
 rmHlU0zPAm/9qpbMEYIIrZKbE7V2N1V1oLr+ibCgqH+RMf3pYoyGcFwp1JzfuDQVMAvn
 0kgANs1w9VSHvVxqMtMaYxZbBZPTaBNlc1/ggCeA157uY3yGEg0D+3alhkrL/5TmJ1L7
 XMLw==
X-Gm-Message-State: AOJu0Ywi4HMpOs0sM1T0XFVWU7h5FRIfgkozza31yIOGxG27cwbW+k/L
 tfNtNR1c5gZYK9SGR1TUGphgSw==
X-Google-Smtp-Source: AGHT+IE+SYLWCK7eyRcJYpw1Bq3uOrgKxy2QIdPZIrUlG68Ez4zu9nvBvHK4JAr8xBU7VK5uVbBhag==
X-Received: by 2002:a05:600c:2491:b0:40b:5e59:c565 with SMTP id
 17-20020a05600c249100b0040b5e59c565mr928955wms.143.1701808870068; 
 Tue, 05 Dec 2023 12:41:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 az33-20020a05600c602100b0040c03c3289bsm13514716wmb.37.2023.12.05.12.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 12:41:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9758C5FBC6;
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
Subject: [PATCH 07/11] replay: make has_unread_data a bool
Date: Tue,  5 Dec 2023 20:41:02 +0000
Message-Id: <20231205204106.95531-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205204106.95531-1-alex.bennee@linaro.org>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

For clarity given it only has two states.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 replay/replay-internal.h | 4 ++--
 replay/replay-internal.c | 4 ++--
 replay/replay-snapshot.c | 6 +++---
 replay/replay.c          | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 98ca3748ed..1bc8fd5086 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -75,7 +75,7 @@ enum ReplayEvents {
  * @current_icount: number of processed instructions
  * @instruction_count: number of instructions until next event
  * @data_kind: current event
- * @has_unread_data: 1 if event not yet processed
+ * @has_unread_data: true if event not yet processed
  * @file_offset: offset into replay log at replay snapshot
  * @block_request_id: current serialised block request id
  * @read_event_id: current async read event id
@@ -85,7 +85,7 @@ typedef struct ReplayState {
     uint64_t current_icount;
     int instruction_count;
     unsigned int data_kind;
-    unsigned int has_unread_data;
+    bool has_unread_data;
     uint64_t file_offset;
     uint64_t block_request_id;
     uint64_t read_event_id;
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 77d0c82327..634025096e 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -179,7 +179,7 @@ void replay_fetch_data_kind(void)
                 replay_state.instruction_count = replay_get_dword();
             }
             replay_check_error();
-            replay_state.has_unread_data = 1;
+            replay_state.has_unread_data = true;
             if (replay_state.data_kind >= EVENT_COUNT) {
                 error_report("Replay: unknown event kind %d",
                              replay_state.data_kind);
@@ -191,7 +191,7 @@ void replay_fetch_data_kind(void)
 
 void replay_finish_event(void)
 {
-    replay_state.has_unread_data = 0;
+    replay_state.has_unread_data = false;
     replay_fetch_data_kind();
 }
 
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 10a7cf7992..bf75c2ed28 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -47,8 +47,8 @@ static int replay_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_replay = {
     .name = "replay",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .pre_save = replay_pre_save,
     .post_load = replay_post_load,
     .fields = (VMStateField[]) {
@@ -56,7 +56,7 @@ static const VMStateDescription vmstate_replay = {
         VMSTATE_UINT64(current_icount, ReplayState),
         VMSTATE_INT32(instruction_count, ReplayState),
         VMSTATE_UINT32(data_kind, ReplayState),
-        VMSTATE_UINT32(has_unread_data, ReplayState),
+        VMSTATE_BOOL(has_unread_data, ReplayState),
         VMSTATE_UINT64(file_offset, ReplayState),
         VMSTATE_UINT64(block_request_id, ReplayState),
         VMSTATE_UINT64(read_event_id, ReplayState),
diff --git a/replay/replay.c b/replay/replay.c
index 0f7d766efe..d729214197 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -258,7 +258,7 @@ static void replay_enable(const char *fname, int mode)
     replay_state.data_kind = -1;
     replay_state.instruction_count = 0;
     replay_state.current_icount = 0;
-    replay_state.has_unread_data = 0;
+    replay_state.has_unread_data = false;
 
     /* skip file header for RECORD and check it for PLAY */
     if (replay_mode == REPLAY_MODE_RECORD) {
-- 
2.39.2


