Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B7C805F9D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 21:42:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAcEE-0007OT-97; Tue, 05 Dec 2023 15:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEB-0007Np-Ou
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:11 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcE8-0002E6-FJ
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:11 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40a4848c6e1so65989785e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 12:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701808867; x=1702413667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOmchX4uNJ3czMjsDLMZ3je7KxzFjicIJgluCE6g86g=;
 b=soLzwRrME1j0yKYKYsimtYQGAIBOzcwBVvflKgL6JW1VQ58/oy3aCxD38/mVSPG/sb
 sznfyRW8sYwT/xBhDH5Y5wRzT266iX8sdnRDJBURrnXYiglRKHPnOQnyLMHxz0SpLhy0
 li2t+iEQ6Wx/9B0PrvBd6bcaUBLx3ghz+98DGBYxv3Tme5cnUYz3uugbG/dyKoREIOcB
 Azl6/N2n9Fp3+x7GI7XnPEpIr7wL/Q1WtZqdJ2P1cOgw5aziUis6SakF0aW8d4LkPu8X
 2R/2e3iuRdwXWLag9dH1+pzdSqA4sKSYbVWhBjUSnl5WT46ODlPXvRZKg/WSlkOSEcsa
 rAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701808867; x=1702413667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bOmchX4uNJ3czMjsDLMZ3je7KxzFjicIJgluCE6g86g=;
 b=ITmrzzEFMwqQMt2mSFkGtqbEsbSCohM52lANtM+phqvPZfSD4+QPoZJc8pT+Fuy1LT
 wjAtdLsm6VL+qaWe9bP9HAtDE+xfqdUsor22x3vwZOmIm2kvfA3vFP05sCee/+yA/G3B
 vvVgt4A1C5mH+8kfNyViCexMpO8u7QRvGYqjxlvXjiK+o/cpyGp7HNIobLiLRJ6vOu4k
 ZibqLqpJjyp/NcWQRiivZz0KVHPAhFaX2VGimtD4MqliH5KnU//hQyzHoawBzCY4f9zX
 7rnkBygbobCGcU+Ia48JWcMxHc5ujel1La6iR//UANw2J7Fs8rMxWD3pUg0ucKrSsrpL
 jQxg==
X-Gm-Message-State: AOJu0YwmEE4PUU5QDyhu1Rs3MZdFg02mHsTYgUCDHNz2WEZNPNh5euhf
 71fn4okONfnxnRRtFfhZyu//7A==
X-Google-Smtp-Source: AGHT+IGSiXqg2McRYBm95evuAeCuKTa+uG/zAgKLXw2xVn+9QnX5+jbp7OLGJkKF1c/2UcHshhNfzQ==
X-Received: by 2002:a7b:cb98:0:b0:40b:5e21:bdd6 with SMTP id
 m24-20020a7bcb98000000b0040b5e21bdd6mr863698wmi.101.1701808867046; 
 Tue, 05 Dec 2023 12:41:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d13-20020a05600c34cd00b0040b540ff0a5sm19913400wmq.19.2023.12.05.12.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 12:41:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 49C4B5FBBD;
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
Subject: [PATCH 03/11] scripts/replay-dump: update to latest format
Date: Tue,  5 Dec 2023 20:40:58 +0000
Message-Id: <20231205204106.95531-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205204106.95531-1-alex.bennee@linaro.org>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

To help debugging replay logs I've implemented decode_plain and
decode_char_write as well as put in a new table for the current format
of log.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/replay-dump.py | 70 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index b89dc29555..8b9f914534 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -115,6 +115,11 @@ def decode_unimp(eid, name, _unused_dumpfile):
     print("%s not handled - will now stop" % (name))
     return False
 
+def decode_plain(eid, name, _unused_dumpfile):
+    "Plain events without additional data"
+    print_event(eid, name, "no data")
+    return True
+
 # Checkpoint decoder
 def swallow_async_qword(eid, name, dumpfile):
     "Swallow a qword of data without looking at it"
@@ -151,6 +156,12 @@ def decode_instruction(eid, name, dumpfile):
     print_event(eid, name, "0x%x" % (ins_diff))
     return True
 
+def decode_char_write(eid, name, dumpfile):
+    res = read_dword(dumpfile)
+    offset = read_dword(dumpfile)
+    print_event(eid, name, "%d -> %d" % (offset, res))
+    return True
+
 def decode_audio_out(eid, name, dumpfile):
     audio_data = read_dword(dumpfile)
     print_event(eid, name, "%d" % (audio_data))
@@ -193,10 +204,10 @@ def decode_clock(eid, name, dumpfile):
 # pre-MTTCG merge
 v5_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
                   Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
-                  Decoder(2, "EVENT_EXCEPTION", decode_unimp),
+                  Decoder(2, "EVENT_EXCEPTION", decode_plain),
                   Decoder(3, "EVENT_ASYNC", decode_async),
                   Decoder(4, "EVENT_SHUTDOWN", decode_unimp),
-                  Decoder(5, "EVENT_CHAR_WRITE", decode_unimp),
+                  Decoder(5, "EVENT_CHAR_WRITE", decode_char_write),
                   Decoder(6, "EVENT_CHAR_READ_ALL", decode_unimp),
                   Decoder(7, "EVENT_CHAR_READ_ALL_ERROR", decode_unimp),
                   Decoder(8, "EVENT_CLOCK_HOST", decode_clock),
@@ -215,10 +226,10 @@ def decode_clock(eid, name, dumpfile):
 # post-MTTCG merge, AUDIO support added
 v6_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
                   Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
-                  Decoder(2, "EVENT_EXCEPTION", decode_unimp),
+                  Decoder(2, "EVENT_EXCEPTION", decode_plain),
                   Decoder(3, "EVENT_ASYNC", decode_async),
                   Decoder(4, "EVENT_SHUTDOWN", decode_unimp),
-                  Decoder(5, "EVENT_CHAR_WRITE", decode_unimp),
+                  Decoder(5, "EVENT_CHAR_WRITE", decode_char_write),
                   Decoder(6, "EVENT_CHAR_READ_ALL", decode_unimp),
                   Decoder(7, "EVENT_CHAR_READ_ALL_ERROR", decode_unimp),
                   Decoder(8, "EVENT_AUDIO_OUT", decode_audio_out),
@@ -250,7 +261,7 @@ def decode_clock(eid, name, dumpfile):
                   Decoder(10, "EVENT_SHUTDOWN_GUEST_RESET", decode_unimp),
                   Decoder(11, "EVENT_SHUTDOWN_GUEST_PANIC", decode_unimp),
                   Decoder(12, "EVENT_SHUTDOWN___MAX", decode_unimp),
-                  Decoder(13, "EVENT_CHAR_WRITE", decode_unimp),
+                  Decoder(13, "EVENT_CHAR_WRITE", decode_char_write),
                   Decoder(14, "EVENT_CHAR_READ_ALL", decode_unimp),
                   Decoder(15, "EVENT_CHAR_READ_ALL_ERROR", decode_unimp),
                   Decoder(16, "EVENT_AUDIO_OUT", decode_audio_out),
@@ -268,6 +279,49 @@ def decode_clock(eid, name, dumpfile):
                   Decoder(28, "EVENT_CP_RESET", decode_checkpoint),
 ]
 
+# Shutdown cause added
+v12_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
+                  Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
+                  Decoder(2, "EVENT_EXCEPTION", decode_plain),
+                  Decoder(3, "EVENT_ASYNC", decode_async),
+                  Decoder(4, "EVENT_ASYNC", decode_async),
+                  Decoder(5, "EVENT_ASYNC", decode_async),
+                  Decoder(6, "EVENT_ASYNC", decode_async),
+                  Decoder(6, "EVENT_ASYNC", decode_async),
+                  Decoder(8, "EVENT_ASYNC", decode_async),
+                  Decoder(9, "EVENT_ASYNC", decode_async),
+                  Decoder(10, "EVENT_ASYNC", decode_async),
+                  Decoder(11, "EVENT_SHUTDOWN", decode_unimp),
+                  Decoder(12, "EVENT_SHUTDOWN_HOST_ERR", decode_unimp),
+                  Decoder(13, "EVENT_SHUTDOWN_HOST_QMP_QUIT", decode_unimp),
+                  Decoder(14, "EVENT_SHUTDOWN_HOST_QMP_RESET", decode_unimp),
+                  Decoder(14, "EVENT_SHUTDOWN_HOST_SIGNAL", decode_unimp),
+                  Decoder(15, "EVENT_SHUTDOWN_HOST_UI", decode_unimp),
+                  Decoder(16, "EVENT_SHUTDOWN_GUEST_SHUTDOWN", decode_unimp),
+                  Decoder(17, "EVENT_SHUTDOWN_GUEST_RESET", decode_unimp),
+                  Decoder(18, "EVENT_SHUTDOWN_GUEST_PANIC", decode_unimp),
+                  Decoder(19, "EVENT_SHUTDOWN_GUEST_SUBSYSTEM_RESET", decode_unimp),
+                  Decoder(20, "EVENT_SHUTDOWN_GUEST_SNAPSHOT_LOAD", decode_unimp),
+                  Decoder(21, "EVENT_SHUTDOWN___MAX", decode_unimp),
+                  Decoder(22, "EVENT_CHAR_WRITE", decode_char_write),
+                  Decoder(23, "EVENT_CHAR_READ_ALL", decode_unimp),
+                  Decoder(24, "EVENT_CHAR_READ_ALL_ERROR", decode_unimp),
+                  Decoder(25, "EVENT_AUDIO_IN", decode_unimp),
+                  Decoder(26, "EVENT_AUDIO_OUT", decode_audio_out),
+                  Decoder(27, "EVENT_RANDOM", decode_unimp),
+                  Decoder(28, "EVENT_CLOCK_HOST", decode_clock),
+                  Decoder(29, "EVENT_CLOCK_VIRTUAL_RT", decode_clock),
+                  Decoder(30, "EVENT_CP_CLOCK_WARP_START", decode_checkpoint),
+                  Decoder(31, "EVENT_CP_CLOCK_WARP_ACCOUNT", decode_checkpoint),
+                  Decoder(32, "EVENT_CP_RESET_REQUESTED", decode_checkpoint),
+                  Decoder(33, "EVENT_CP_SUSPEND_REQUESTED", decode_checkpoint),
+                  Decoder(34, "EVENT_CP_CLOCK_VIRTUAL", decode_checkpoint),
+                  Decoder(35, "EVENT_CP_CLOCK_HOST", decode_checkpoint),
+                  Decoder(36, "EVENT_CP_CLOCK_VIRTUAL_RT", decode_checkpoint),
+                  Decoder(37, "EVENT_CP_INIT", decode_checkpoint_init),
+                  Decoder(38, "EVENT_CP_RESET", decode_checkpoint),
+]
+
 def parse_arguments():
     "Grab arguments for script"
     parser = argparse.ArgumentParser()
@@ -283,9 +337,13 @@ def decode_file(filename):
     version = read_dword(dumpfile)
     junk = read_qword(dumpfile)
 
+    # see REPLAY_VERSION
     print("HEADER: version 0x%x" % (version))
 
-    if version == 0xe02007:
+    if version == 0xe0200c:
+        event_decode_table = v12_event_table
+        replay_state.checkpoint_start = 30
+    elif version == 0xe02007:
         event_decode_table = v7_event_table
         replay_state.checkpoint_start = 12
     elif version == 0xe02006:
-- 
2.39.2


