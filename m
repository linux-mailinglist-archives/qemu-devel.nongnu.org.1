Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA39805F9F
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 21:42:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAcEP-0007Sg-3z; Tue, 05 Dec 2023 15:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEG-0007Qz-Sw
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:16 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEF-0002Fg-4b
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:16 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c0a11a914so28309695e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 12:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701808872; x=1702413672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WUlXUbQdrj2zN2x2QSDq9TzSC9U/EAD4vSnBXQIoxM8=;
 b=r77Z25BZR/RG/lIOQIOMsUAymqpIYr6ziT1zA6OZEUrLkyiOYDPQ/QZgzoNXIEh/T6
 6YdagoaDAabwxNBsxDzW4O37g4Q6Wew1PGOT5w61optK27JHr/jWPmgiXEXIANVL9oSA
 NGYHGpLE6x5BoBrmBZgrbgO6TC/RMR5GwZvYLeW3Heaq64+QYT/VY6sC68VNNQ2PvToR
 CXP9JsJnAubodX2eddVvDvL+30dbjJDlgN1ITSUKMA7wg6yvAs3Y+jKqgfVvIOnj7tHs
 TEfr3y9CcVAMOxiGdxkalU39Zi6aLOGb5bUwd0f2wwrjXcvTKtr80SKeoRy9yHhdOGxU
 I4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701808872; x=1702413672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WUlXUbQdrj2zN2x2QSDq9TzSC9U/EAD4vSnBXQIoxM8=;
 b=RrjivUoEpTxFjaedxKzx44pZcOFHBt3DBUTKJw6dnO4GCn2mCrY20d7qg2KqUW3v4l
 VDSMz0ugy0UPVqdd73Abhzm9yCJrFXiTNRG0NRnzcEXRKpClpld0L8Tg3muoQnNGRgUu
 BzNUqQdkN5qLeZODd6viuBzqkl3OKh3hirz0Q9Hb6OVGE6fKwvu70SLGdLLyjnIKGtgS
 clSmRlGVKsmQyfqx0l4tVET3bQD37cOVq1W4nLeE9qb72dsN3+YaZS3SO8+0zO9lPRGV
 O6L1VrfjQ5nDkLGSFVjsRz4dCJl6jf1xvRpLxDRO21YrBPLyUoUaqT5qMjzPmOIdK2WM
 5kQw==
X-Gm-Message-State: AOJu0YwxHKLF3Qg9Mm4OySJkqlpQcrj2i5X6AaBnTOQDfwbiEJPL74XL
 K/dS79QR674P6tz37lPhrgZXjw==
X-Google-Smtp-Source: AGHT+IE+6x8TOdKzl2SgGuAsymv1Nq78tToMCiz4gejngXqHRacjLbfQqJ/L+h44qIa2FKe2NR3W8g==
X-Received: by 2002:a05:600c:3512:b0:40b:5e1e:b3b6 with SMTP id
 h18-20020a05600c351200b0040b5e1eb3b6mr975084wmq.52.1701808872704; 
 Tue, 05 Dec 2023 12:41:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i1-20020a05600c354100b0040588d85b3asm23273563wmq.15.2023.12.05.12.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 12:41:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 81A585FBC4;
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
Subject: [PATCH 06/11] replay: add proper kdoc for ReplayState
Date: Tue,  5 Dec 2023 20:41:01 +0000
Message-Id: <20231205204106.95531-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205204106.95531-1-alex.bennee@linaro.org>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
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

Remove the non-standard comment formatting and move the descriptions
into a proper kdoc comment.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 replay/replay-internal.h               | 27 ++++++++++++++++----------
 roms/SLOF                              |  2 +-
 tests/tcg/i386/Makefile.softmmu-target | 19 ++++++++++++++++++
 3 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 516147ddbc..98ca3748ed 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -63,24 +63,31 @@ enum ReplayEvents {
     EVENT_COUNT
 };
 
+/**
+ * typedef ReplayState - global tracking Replay state
+ *
+ * This structure tracks where we are in the current ReplayState
+ * including the logged events from the recorded replay stream. Some
+ * of the data is also stored/restored from VMStateDescription when VM
+ * save/restore events take place.
+ *
+ * @cached_clock: Cached clocks values
+ * @current_icount: number of processed instructions
+ * @instruction_count: number of instructions until next event
+ * @data_kind: current event
+ * @has_unread_data: 1 if event not yet processed
+ * @file_offset: offset into replay log at replay snapshot
+ * @block_request_id: current serialised block request id
+ * @read_event_id: current async read event id
+ */
 typedef struct ReplayState {
-    /*! Cached clock values. */
     int64_t cached_clock[REPLAY_CLOCK_COUNT];
-    /*! Current icount - number of processed instructions. */
     uint64_t current_icount;
-    /*! Number of instructions to be executed before other events happen. */
     int instruction_count;
-    /*! Type of the currently executed event. */
     unsigned int data_kind;
-    /*! Flag which indicates that event is not processed yet. */
     unsigned int has_unread_data;
-    /*! Temporary variable for saving current log offset. */
     uint64_t file_offset;
-    /*! Next block operation id.
-        This counter is global, because requests from different
-        block devices should not get overlapping ids. */
     uint64_t block_request_id;
-    /*! Asynchronous event id read from the log */
     uint64_t read_event_id;
 } ReplayState;
 extern ReplayState replay_state;
diff --git a/roms/SLOF b/roms/SLOF
index 3a259df244..6b6c16b4b4 160000
--- a/roms/SLOF
+++ b/roms/SLOF
@@ -1 +1 @@
-Subproject commit 3a259df2449fc4a4e43ab5f33f0b2c66484b4bc3
+Subproject commit 6b6c16b4b40763507cf1f518096f3c3883c5cf2d
diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index 5266f2335a..b9bef72dcf 100644
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ b/tests/tcg/i386/Makefile.softmmu-target
@@ -33,5 +33,24 @@ EXTRA_RUNS+=$(MULTIARCH_RUNS)
 
 memory: CFLAGS+=-DCHECK_UNALIGNED=1
 
+# Simple Record/Replay Test
+.PHONY: memory-record
+run-memory-record: memory-record memory
+	$(call run-test, $<, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
+		  -icount shift=5$(COMMA)rr=record$(COMMA)rrfile=record.bin \
+		  $(QEMU_OPTS) memory)
+
+.PHONY: memory-replay
+run-memory-replay: memory-replay run-memory-record
+	$(call run-test, $<, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
+		  -icount shift=5$(COMMA)rr=replay$(COMMA)rrfile=record.bin \
+		  $(QEMU_OPTS) memory)
+
+EXTRA_RUNS+=run-memory-replay
+
 # Running
 QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
-- 
2.39.2


