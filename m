Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F49980C428
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:15:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcMQ-0001Pc-P2; Mon, 11 Dec 2023 04:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMO-0001PP-Ab
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:56 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMM-0004LJ-8b
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:56 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3332efd75c9so3883228f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286032; x=1702890832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1cZ8rGcMVRz/ykfSTmDydjLIdSR950YfUbOQT8uOwo=;
 b=KGgKrk+8Bf+dJFtmWBVg05DLPWCHtxY9yGBJjbllP2Lvb1Wg0lHq/GJwex8pu/V2Af
 FsQbUUqcIburb+I1T0hEKbTVAaL1gbEWPyU9e+drtGMLt/WFaaML334dQOmfJ5jIpaEv
 A1b8QgduwjDegIPPlMsQ9KKxinm9fx5Ia+9To22Xsmv20fbNjqbyPECtAr0AGD3XlCzk
 +dbZWCGsELBT03VGUREWxswvqLFPxQFRdE8MUCM4SJaT8kH6f1kClnDti9P3VuIgmlBz
 YrUI12QtnqN/+kVIvBI615LmBBb9CKBKhsjfb808CN2cM8m3fbjMolf8FSiTxiWP4vj9
 DjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286032; x=1702890832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1cZ8rGcMVRz/ykfSTmDydjLIdSR950YfUbOQT8uOwo=;
 b=ZUBpBE6DvzyLmG/0XD6N8sdhpG1FchPKODWrXt6MraQALxKSzmQneECE9uEwEYgHD8
 VA4pgKGCBZAQUq2tiHgPiaqjdJQt2L5LeqWKNyMvMIV0EcbgfUbwS7YAsVnIXa1JusKK
 rqXzHrXAegRwuwEdj4m5ZXX8dzRQzcIdnOCo/2+vLgmN+JGm5sxxRbFAhY4qqqObSnVC
 eFPiGK9C4mjs7QysZM8E6z2IMZu8CPaxxWnYL7UiX3TqC7g9qyEC/8eAIZEywZgEtEur
 JEHsv5AIVh3DuqUjoWIp4gh73Omre+o5Ualps5K4NghxBlHJM9xfkRXQZSWLglTrx9Gw
 9u2g==
X-Gm-Message-State: AOJu0Yx27Mfl0nRcFVJ/G2J+xsTFd72lPt7E7qphaL+/XBvvmHT4VVkA
 XHkGvXN0sWxlmtG5tib+pvFCQw==
X-Google-Smtp-Source: AGHT+IE9FkAOi1dlFQcWo5o/ejYv+LB/AM73V0gU9tJ+X7JrZs4dtGSQDsQB2Ht3vpIuCXHfXc6XWw==
X-Received: by 2002:a5d:54c4:0:b0:333:49a8:73ea with SMTP id
 x4-20020a5d54c4000000b0033349a873eamr839277wrv.249.1702286032722; 
 Mon, 11 Dec 2023 01:13:52 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d16-20020a5d4f90000000b0033349bccac6sm8151663wru.1.2023.12.11.01.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:13:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AFD245FBEA;
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
Subject: [PATCH v2 07/16] replay: add proper kdoc for ReplayState
Date: Mon, 11 Dec 2023 09:13:36 +0000
Message-Id: <20231211091346.14616-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Message-Id: <20231205204106.95531-7-alex.bennee@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 replay/replay-internal.h | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

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
-- 
2.39.2


