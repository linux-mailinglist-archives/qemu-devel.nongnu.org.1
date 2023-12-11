Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B8480C429
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:15:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcMU-0001Rg-LT; Mon, 11 Dec 2023 04:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMT-0001R5-1K
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:14:01 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMR-0004MF-9k
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:14:00 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c29f7b068so40058415e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286036; x=1702890836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HdDx5EiLjddIKUt2fw45zi8pgfokyd/tBcuj5PJ4A5k=;
 b=AE4/f/VcVmd7cYxY+SnfA8AGSm3DmSYVkVAnRHqvfdVvkTW/F039zfjqToBvzDTJnt
 UWw5W+sqkbJOhq/Kb6cbie+feX/qC8PcSGRZldPSHwAtG4ZXeerYLGuL0qJ8CicICEh2
 8K7zMpICGX0AmVkHt9e7wemYizxwCtIinpwpm7EVxbMvJP80TCMCh9lD8ZCnD0p6X2n4
 iCGDeAffyV7tWis1Wsg9joqBjC6CepvCnrmowNWr3amG4t2TFMjWDDzLhgfg+qj5SpfY
 rHLlgzqGMA6T2iMDmAeqEGy3pMYorXSZK7AhreL9E0EzFW2FWWxZPehHRHvaKawE8vQO
 E3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286036; x=1702890836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HdDx5EiLjddIKUt2fw45zi8pgfokyd/tBcuj5PJ4A5k=;
 b=U8/lZ4ugoKPTh2G0SOhD1K5dmlCqDTMxQPvMt7iY3w74kjo8UA1Din9nD6dnRb11Jt
 W1DwzckbmUA5xe67hdIehKzlY7JdV9+czCC/QsUPp/9pYvIVvHvmMH2Q+Fp/U5x7tJqC
 P5/tEHwSr7BQTnej8AGdmNA0DyB+JfWaSbs1Lk68OEuu0QoCIQ2LU4t4QO0p9VEQdLjp
 c7m8xQrNgfi9O0ZoTp+cPmFEvUnk1tpOVZ5/3bqvQQXq39DB186BTiWi53FLFwXjjjDC
 d0KxnF5Lt+yxACoAbfPWiATisyS3i04l39hIvL3ZXTp0lP4swLlbcZIDXNswtzpWncBh
 jWZA==
X-Gm-Message-State: AOJu0YwC0BaGBkh3rVWp/SMnkUtcP8CHxB+sslY6eGOqsP+Bt7N/Q/xE
 8A0ti820JONpIoTx4SA7ZtBEyg==
X-Google-Smtp-Source: AGHT+IEjD4uY8VsRX3UFLnuU7LBSCQRWYoEXQ9InYN+E2Rl0d7R0Cf+OT3fnnTwl9VDU/o7uVGRcig==
X-Received: by 2002:a05:600c:20e:b0:40c:330f:f2fb with SMTP id
 14-20020a05600c020e00b0040c330ff2fbmr1766679wmi.162.1702286036538; 
 Mon, 11 Dec 2023 01:13:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t15-20020a05600c198f00b0040c4620b9fasm3864005wmq.11.2023.12.11.01.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:13:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C60B75FBEC;
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v2 08/16] replay: make has_unread_data a bool
Date: Mon, 11 Dec 2023 09:13:37 +0000
Message-Id: <20231211091346.14616-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Message-Id: <20231205204106.95531-8-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


