Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCD38272B7
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:15:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrKK-0004FK-9P; Mon, 08 Jan 2024 10:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKG-0004EK-W9
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:05 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKE-0001ai-HF
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:04 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40d89446895so11540495e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704726840; x=1705331640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPOk6AJuTFsbsY/JbpngsdrxHBBFNIYVyd4S9YTkZ9o=;
 b=elbBRmRyT5xCIwaPYLGpbkkLhHL1pETurwbivmsWFxxAYyaCKJhGsmcVYT+Sprr0ip
 zJUnGMEg6K+WRtgaIxmF5Nx3prqfSjr4I6nHOhEF+gC0UXAgKLZY7ebhxWKuczS2f+Bk
 R2726ECtzNvRvooOr2iO2fa9JNqQrbqExWF12O0fNuWCF9CZNqigUl8GaHQU6WQQUh4z
 JkLh1gL4OVPYbr3npcRPVO77AG3k2wkvz+EZZ+0KEokO0rXwqtUQSmMn8Ahv9tGKv5UN
 ba2L+HyFSAvG0iEzCs3UQ7pbYfIXEEaOPeV2DDrh44OFQowe3VMoohLWLP2q8glxH24H
 SxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704726840; x=1705331640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPOk6AJuTFsbsY/JbpngsdrxHBBFNIYVyd4S9YTkZ9o=;
 b=XvGpXpGjsCJ+OL9sdf04acm+JmAgfly9Ak+snMtQnsBZQQYHT7oyaw7JJ1kjOS9zkr
 NPhVlTyhQUpaEYQ54p0nBN6SEKoD7uXOSIJEDyy3y+XyyJutNuvvrLrpq5/Q5At0qdxl
 qbj0Xs/toPNBJL2bgDJCHhLZfV/gzV7VZ+sxOkhFAc6jtGqYVR3MHHL2hRyDnvneWnXU
 N3u2EtEXgx+4lPkfKa3tg8s41JiNQl76zQBpQsWsn98ga/It6nN2LLAh7eBKQcUqe4lu
 c0hImG7W5VPvs3FghRSzCusqtA//Bhz+jqN7Nq3b+Btvy4mE4xeddFevMuWkDJBBJBjW
 zZrA==
X-Gm-Message-State: AOJu0Yz8n2sJaCfofbIY3Hvzz+SNXNYw+6syt0O0f0Ao8q9x1WGBIsMp
 cBRATUUxILY06dXDqCIzeucpv0fx299Tmg==
X-Google-Smtp-Source: AGHT+IHR5k5TwixRpZ/ulpi5S8syMOx2df2djUykv9MpFgVvNnF4yiznCZBfpvVTfdof46esf6D1rw==
X-Received: by 2002:a05:600c:35d1:b0:40d:887e:fc85 with SMTP id
 r17-20020a05600c35d100b0040d887efc85mr1906231wmq.32.1704726839847; 
 Mon, 08 Jan 2024 07:13:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j8-20020a05600c190800b0040d6d755c90sm119705wmq.42.2024.01.08.07.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:13:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8D7FD5F94A;
 Mon,  8 Jan 2024 15:13:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 08/13] replay: make has_unread_data a bool
Date: Mon,  8 Jan 2024 15:13:47 +0000
Message-Id: <20240108151352.2199097-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108151352.2199097-1-alex.bennee@linaro.org>
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231211091346.14616-9-alex.bennee@linaro.org>

diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 98ca3748edb..1bc8fd50868 100644
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
index 77d0c82327e..634025096ef 100644
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
index e5e39161e33..d4f6cb7cda8 100644
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
     .fields = (const VMStateField[]) {
@@ -56,7 +56,7 @@ static const VMStateDescription vmstate_replay = {
         VMSTATE_UINT64(current_icount, ReplayState),
         VMSTATE_INT32(instruction_count, ReplayState),
         VMSTATE_UINT32(data_kind, ReplayState),
-        VMSTATE_UINT32(has_unread_data, ReplayState),
+        VMSTATE_BOOL(has_unread_data, ReplayState),
         VMSTATE_UINT64(file_offset, ReplayState),
         VMSTATE_UINT64(block_request_id, ReplayState),
         VMSTATE_UINT64(read_event_id, ReplayState),
-- 
2.39.2


