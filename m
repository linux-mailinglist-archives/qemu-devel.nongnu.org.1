Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E360D8272A4
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:14:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrKP-0004LU-Gw; Mon, 08 Jan 2024 10:14:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKO-0004Jx-0D
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:12 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKA-0001Yf-TN
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:11 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40d87df95ddso21231725e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704726837; x=1705331637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sGtlVmj/cLSRItSFI6o6Pd2FVVc8E9gmG7YjPACLCW8=;
 b=jPRLjZp3PetcpyNYsqbZve+HKDNZynXGDxa1QO7/T++T5HTUYpnndHHxndk8UPquUN
 RlcxaeKjOC3R651AtOSsuWRZTEmfxs+SWPUrNy+cgshaj3a439+PA/uuOz6cK3hufso3
 to6kXPSjaQCC5e1rdBMBRNGe3Rv6i7SkmW0Zo5SpN5UXbJNrBAQrmfPC1eZL1zbA0NxA
 yiaXARki24AjlQrgB1QD8bJ846/bWS6aAetc5kkSSLWGcrJ/Ap16y92VKbvfmny+ggOX
 lsydc9uI3kBG4eiFUmsMvIz18d8H6uwTRl8QZZvXJauQvASOj5XJBkif3uwMSL9dZLaL
 h91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704726837; x=1705331637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sGtlVmj/cLSRItSFI6o6Pd2FVVc8E9gmG7YjPACLCW8=;
 b=puUhRB7b7j+5nRGLHJ6ErYhwqcpfilozj+iq7GhD9oHfM6YuwLcZUSymVv77k8vTRP
 hm4l2xdXzwNW5+RhXk6PAfZ3igIItlAGdhmEbkXpDikc7rX/h/RSiE9pBtt3pkQCzaes
 rXgBw0uuMy3Qpubk6LCnWvOj6Aslp0Ettb7IaZaoPtJylc9Q8DAc1ASitNP1WvNqzVYP
 gqnWQJORl7iRjqXxB7KTan8vbIrEielhmmfRFxyo7OFD5PVCF3y013DiK0WUcshzbVzY
 D7+vVlEK2hkcG6d980UrcsXUqVa1v0acM4NE2R9Mlp29vtO/Y46FGlWZzmFYIKWWpB9h
 TglA==
X-Gm-Message-State: AOJu0Yx/boptH2Us+anGn4TyuEhQTwwzdrDan9AGMLGIyF+U3Y34V44z
 HuaK66lvyzmF4nMLmCgUapBtOTxpJRHqMA==
X-Google-Smtp-Source: AGHT+IF6/r/blh9ykR03g3UR7YNR7t3wTGE71UDHl93ONfvwScvHK2A2Ny7HQP+mmLed38GJagI3NA==
X-Received: by 2002:a05:600c:1f16:b0:40e:4239:5075 with SMTP id
 bd22-20020a05600c1f1600b0040e42395075mr876947wmb.364.1704726836992; 
 Mon, 08 Jan 2024 07:13:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u2-20020a7bc042000000b0040d79997731sm5233915wmc.0.2024.01.08.07.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:13:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 775185F949;
 Mon,  8 Jan 2024 15:13:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 07/13] replay: add proper kdoc for ReplayState
Date: Mon,  8 Jan 2024 15:13:46 +0000
Message-Id: <20240108151352.2199097-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108151352.2199097-1-alex.bennee@linaro.org>
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231211091346.14616-8-alex.bennee@linaro.org>

diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 516147ddbca..98ca3748edb 100644
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


