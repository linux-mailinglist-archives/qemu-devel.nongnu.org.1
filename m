Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B627F6013
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 14:19:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r69bu-0004W2-PN; Thu, 23 Nov 2023 08:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r69br-0004Vb-Vp
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 08:19:12 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r69bp-0002yu-8i
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 08:19:11 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40b34563987so5009075e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 05:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700745548; x=1701350348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/6bSnEglw6m4h+xy81DshF8cBTlnGobxHKJ/G0Fy98=;
 b=vLX6dbsKl2wnw7bBzyLdxe5qsxAV24qPDMkvDKAYDFGhA7guwj1z8txH0j7LBNUzQL
 UAXCshQcFrpdwWbz8p8SLOmjMCRVxsvWmdXp5WF0/US7cCNL2LgRNPBTy0bO7zOSPgrY
 Pwu0c1K6ytW4v7pVJxjZ/nVxTxGHRlqK6F941KIH9AKoV9nvOHWwgVXhDyQUT8ALWini
 o2YezQRnG+rlMHCA9eXsdXKVuvqtETMZ/GiaxUVd+ecjVvaY8kMD1246Efn3cqMzRS9K
 KLu8flg0u1Uc5/jCqjCUaIOmRUVVPpAjdluEtrKvrX1WK0KiQXML2yH8jW+OV+zBNsv2
 5jYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700745548; x=1701350348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q/6bSnEglw6m4h+xy81DshF8cBTlnGobxHKJ/G0Fy98=;
 b=o8DPioQrXT/Qhn9+O0drA/H8F2V65jiIE6maL5qoRPjZ3/I8emWoGacAYcFRcBv8bS
 p4Yos3WHF9XzmZMfLso+/g3LB6grnc1bWdCXGzc3mwtJyenTwtk1L8j/hblHG0dogn6X
 Q1sWTuPPaWmtZw1XNXNOSegcjlajxNfbeuMslSDLrzMrcTbQ7KvDeGXi1/vt2PAM8kEK
 tL7nmZQ8wJfle9YLxr9rA+Q1V1cD8qxLbXmWWb01WCB4aEbja2gYT9Ro7qlAui9EXywA
 z9gNexpdE2kuAm8WdemBE7hVkT+WCCr5rJEPk+63pC3F6BDiTIyW1xkx1xnGi/dZV7FU
 2VPw==
X-Gm-Message-State: AOJu0Ywfm0xQdXa/WTTL7GztFJSS/Zq/1Eh4KpjZnT1S3NYvp1NSq+Jh
 VXHpgfHNxFGzdIYiF9S6cNtK7Q==
X-Google-Smtp-Source: AGHT+IF3DtgBjkiHK6aHC+6M+iozIJryjIFPU5H8IWtW5obyAgGO9SKeAhIj45jJ3k9qm+OwCg0/Gg==
X-Received: by 2002:a05:600c:3587:b0:3fe:1fd9:bedf with SMTP id
 p7-20020a05600c358700b003fe1fd9bedfmr2380526wmq.11.1700745547696; 
 Thu, 23 Nov 2023 05:19:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m8-20020a05600c4f4800b0040b347d90d0sm2670786wmq.12.2023.11.23.05.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 05:19:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D799C5F756;
 Thu, 23 Nov 2023 13:19:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Luis Machado <luis.machado@arm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] gdbstub: use a better signal when we halt for IO reasons
Date: Thu, 23 Nov 2023 13:19:05 +0000
Message-Id: <20231123131905.2640498-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
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

The gdb description GDB_SIGNAL_IO is "I/O possible" and by default gdb
will try and restart the guest, getting us nowhere. Report
GDB_SIGNAL_STOP instead which should at least halt the session at the
failure point.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Luis Machado <luis.machado@arm.com>
---
 gdbstub/internals.h | 1 +
 gdbstub/system.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 465c24b36e..5c0c725e54 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -24,6 +24,7 @@ enum {
     GDB_SIGNAL_TRAP = 5,
     GDB_SIGNAL_ABRT = 6,
     GDB_SIGNAL_ALRM = 14,
+    GDB_SIGNAL_STOP = 17,
     GDB_SIGNAL_IO = 23,
     GDB_SIGNAL_XCPU = 24,
     GDB_SIGNAL_UNKNOWN = 143
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 783ac140b9..83fd452800 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -183,7 +183,7 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
         break;
     case RUN_STATE_IO_ERROR:
         trace_gdbstub_hit_io_error();
-        ret = GDB_SIGNAL_IO;
+        ret = GDB_SIGNAL_STOP;
         break;
     case RUN_STATE_WATCHDOG:
         trace_gdbstub_hit_watchdog();
-- 
2.39.2


