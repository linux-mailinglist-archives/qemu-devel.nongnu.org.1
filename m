Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D4A866C42
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Feb 2024 09:30:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWNH-00022V-Ar; Mon, 26 Feb 2024 03:30:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWNF-00022B-I3
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:09 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWND-0005c7-FN
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:09 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dca3951ad9so5377575ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708936205; x=1709541005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ty0wrWccgu1Eia9+bikPFTR78Ammp00W40/fB+nlmUo=;
 b=YKtk+3ftGYWPEWmpfW2rcU/XcY4KIvd70rEGg4//tNxjE+wK2m31vm4HQdNnyc1WcW
 eWNI+JsW94NGel+VFZ9cXKUUsxhbuQHvuqshG5Xw8qiN9rfpvphtmNdCrsezaTfdKsu2
 Nu9yoxnKhKMI1iUcbC9JC5iccb/xAlKCPB5Pg69JRijNlxNxnM93dXxb7gPL93jJEyc5
 C76a/otjFVREQuBNYYOqneQhQNSQtlvRYJzhpo8qwK5UVdjKkQWvjW+ftjL/WnLMJcQn
 dUjfs6nzVqWM1KNQva5wYS3fzvl2W2j0UaCAHDLvOa9tsxR8wIiBuW9emCYoa/nD3hrD
 ppug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936205; x=1709541005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ty0wrWccgu1Eia9+bikPFTR78Ammp00W40/fB+nlmUo=;
 b=un4jqXpGaWPB97uq7gkRGVK1zZqqUHHh/Woa/22ls3gveguJrHYCpeWlf+Zovbr9yb
 GPyN3YAaRYLAH2plezC2bp7NIKrWHTVb80No0i1AfjzQoTOFj4wuB5xTfUNm899pjMLh
 jODhr8OJb/kCPK0vDG6D5FhhhmK0glNVWQbG47CcmYNGqzoOsVri7mO2rJXXvhTNACgo
 5C6eYZeeKZAtzVhhjb0AxDZsXdwdwFrqEGCAfeTVjT3QzZD6c39830vyrijyFejnuT5k
 IE6bK+3tRWHseu4r6RcDEf6GcOCiWkbvvQ+UzQU2z31e3iz+dzqAwsi49lfGAevJAVh6
 pV1w==
X-Gm-Message-State: AOJu0YypFTJ3ODxfI+7sRBGT1Om6I9m4BdrUH+tSSdm0YLx8cefJutGm
 YCyq/Lmoz2Nj2SIlTAPdFmllfPortb/h90BlLXEIdKmB1WuVnIIka6Srs/2u
X-Google-Smtp-Source: AGHT+IGpL6phHuAvNJ2RnDT3656KLFgo36s2qsoo+X2yi4RcopjMYFKW4HhFs70GAyXPbdZTi/w6QA==
X-Received: by 2002:a17:903:2446:b0:1dc:540f:c5eb with SMTP id
 l6-20020a170903244600b001dc540fc5ebmr8736797pls.51.1708936205472; 
 Mon, 26 Feb 2024 00:30:05 -0800 (PST)
Received: from wheely.local0.net ([1.146.74.212])
 by smtp.gmail.com with ESMTPSA id
 w16-20020a1709026f1000b001d9641003cfsm3511260plk.142.2024.02.26.00.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:30:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v3 1/9] scripts/replay-dump.py: Update to current rr record
 format
Date: Mon, 26 Feb 2024 18:29:37 +1000
Message-ID: <20240226082945.1452499-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240226082945.1452499-1-npiggin@gmail.com>
References: <20240226082945.1452499-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The v12 format support for replay-dump has a few issues still. This
fixes async decoding; adds event, shutdown, and end decoding; fixes
audio in / out events, fixes checkpoint checking of following async
events.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 scripts/replay-dump.py | 127 ++++++++++++++++++++++++++++++-----------
 1 file changed, 93 insertions(+), 34 deletions(-)

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index d668193e79..419ee3257b 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -20,6 +20,7 @@
 
 import argparse
 import struct
+import os
 from collections import namedtuple
 from os import path
 
@@ -134,6 +135,17 @@ def swallow_async_qword(eid, name, dumpfile):
     print("  %s(%d) @ %d" % (name, eid, step_id))
     return True
 
+def swallow_bytes(eid, name, dumpfile, nr):
+    """Swallow nr bytes of data without looking at it"""
+    dumpfile.seek(nr, os.SEEK_CUR)
+
+def decode_exception(eid, name, dumpfile):
+    print_event(eid, name)
+    return True
+
+# v12 does away with the additional event byte and encodes it in the main type
+# Between v8 and v9, REPLAY_ASYNC_BH_ONESHOT was added, but we don't decode
+# those versions so leave it out.
 async_decode_table = [ Decoder(0, "REPLAY_ASYNC_EVENT_BH", swallow_async_qword),
                        Decoder(1, "REPLAY_ASYNC_INPUT", decode_unimp),
                        Decoder(2, "REPLAY_ASYNC_INPUT_SYNC", decode_unimp),
@@ -142,8 +154,8 @@ def swallow_async_qword(eid, name, dumpfile):
                        Decoder(5, "REPLAY_ASYNC_EVENT_NET", decode_unimp),
 ]
 # See replay_read_events/replay_read_event
-def decode_async(eid, name, dumpfile):
-    """Decode an ASYNC event"""
+def decode_async_old(eid, name, dumpfile):
+    """Decode an ASYNC event (pre-v8)"""
 
     print_event(eid, name)
 
@@ -157,6 +169,35 @@ def decode_async(eid, name, dumpfile):
 
     return call_decode(async_decode_table, async_event_kind, dumpfile)
 
+def decode_async_bh(eid, name, dumpfile):
+    op_id = read_qword(dumpfile)
+    print_event(eid, name)
+    return True
+
+def decode_async_bh_oneshot(eid, name, dumpfile):
+    op_id = read_qword(dumpfile)
+    print_event(eid, name)
+    return True
+
+def decode_async_char_read(eid, name, dumpfile):
+    char_id = read_byte(dumpfile)
+    size = read_dword(dumpfile)
+    print_event(eid, name, "device:%x chars:%s" % (char_id, dumpfile.read(size)))
+    return True
+
+def decode_async_block(eid, name, dumpfile):
+    op_id = read_qword(dumpfile)
+    print_event(eid, name)
+    return True
+
+def decode_async_net(eid, name, dumpfile):
+    net_id = read_byte(dumpfile)
+    flags = read_dword(dumpfile)
+    size = read_dword(dumpfile)
+    swallow_bytes(eid, name, dumpfile, size)
+    print_event(eid, name, "net:%x flags:%x bytes:%d" % (net_id, flags, size))
+    return True
+
 total_insns = 0
 
 def decode_instruction(eid, name, dumpfile):
@@ -166,6 +207,10 @@ def decode_instruction(eid, name, dumpfile):
     print_event(eid, name, "+ %d -> %d" % (ins_diff, total_insns))
     return True
 
+def decode_shutdown(eid, name, dumpfile):
+    print_event(eid, name)
+    return True
+
 def decode_char_write(eid, name, dumpfile):
     res = read_dword(dumpfile)
     offset = read_dword(dumpfile)
@@ -177,7 +222,7 @@ def decode_audio_out(eid, name, dumpfile):
     print_event(eid, name, "%d" % (audio_data))
     return True
 
-def decode_checkpoint(eid, name, dumpfile):
+def __decode_checkpoint(eid, name, dumpfile, old):
     """Decode a checkpoint.
 
     Checkpoints contain a series of async events with their own specific data.
@@ -189,14 +234,20 @@ def decode_checkpoint(eid, name, dumpfile):
 
     # if the next event is EVENT_ASYNC there are a bunch of
     # async events to read, otherwise we are done
-    if next_event != 3:
-        print_event(eid, name, "no additional data", event_number)
-    else:
+    if (old and next_event == 3) or (not old and next_event >= 3 and next_event <= 9):
         print_event(eid, name, "more data follows", event_number)
+    else:
+        print_event(eid, name, "no additional data", event_number)
 
     replay_state.reuse_event(next_event)
     return True
 
+def decode_checkpoint_old(eid, name, dumpfile):
+    return __decode_checkpoint(eid, name, dumpfile, False)
+
+def decode_checkpoint(eid, name, dumpfile):
+    return __decode_checkpoint(eid, name, dumpfile, True)
+
 def decode_checkpoint_init(eid, name, dumpfile):
     print_event(eid, name)
     return True
@@ -212,15 +263,23 @@ def decode_clock(eid, name, dumpfile):
 
 def decode_random(eid, name, dumpfile):
     ret = read_dword(dumpfile)
-    data = read_array(dumpfile)
-    print_event(eid, "%d bytes of random data" % len(data))
+    size = read_dword(dumpfile)
+    swallow_bytes(eid, name, dumpfile, size)
+    if (ret):
+        print_event(eid, name, "%d bytes (getrandom failed)" % (size))
+    else:
+        print_event(eid, name, "%d bytes" % (size))
     return True
 
+def decode_end(eid, name, dumpfile):
+    print_event(eid, name)
+    return False
+
 # pre-MTTCG merge
 v5_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
                   Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
                   Decoder(2, "EVENT_EXCEPTION", decode_plain),
-                  Decoder(3, "EVENT_ASYNC", decode_async),
+                  Decoder(3, "EVENT_ASYNC", decode_async_old),
                   Decoder(4, "EVENT_SHUTDOWN", decode_unimp),
                   Decoder(5, "EVENT_CHAR_WRITE", decode_char_write),
                   Decoder(6, "EVENT_CHAR_READ_ALL", decode_unimp),
@@ -242,7 +301,7 @@ def decode_random(eid, name, dumpfile):
 v6_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
                   Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
                   Decoder(2, "EVENT_EXCEPTION", decode_plain),
-                  Decoder(3, "EVENT_ASYNC", decode_async),
+                  Decoder(3, "EVENT_ASYNC", decode_async_old),
                   Decoder(4, "EVENT_SHUTDOWN", decode_unimp),
                   Decoder(5, "EVENT_CHAR_WRITE", decode_char_write),
                   Decoder(6, "EVENT_CHAR_READ_ALL", decode_unimp),
@@ -266,7 +325,7 @@ def decode_random(eid, name, dumpfile):
 v7_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
                   Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
                   Decoder(2, "EVENT_EXCEPTION", decode_unimp),
-                  Decoder(3, "EVENT_ASYNC", decode_async),
+                  Decoder(3, "EVENT_ASYNC", decode_async_old),
                   Decoder(4, "EVENT_SHUTDOWN", decode_unimp),
                   Decoder(5, "EVENT_SHUTDOWN_HOST_ERR", decode_unimp),
                   Decoder(6, "EVENT_SHUTDOWN_HOST_QMP", decode_unimp),
@@ -296,32 +355,31 @@ def decode_random(eid, name, dumpfile):
 
 v12_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
                   Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
-                  Decoder(2, "EVENT_EXCEPTION", decode_plain),
-                  Decoder(3, "EVENT_ASYNC", decode_async),
-                  Decoder(4, "EVENT_ASYNC", decode_async),
-                  Decoder(5, "EVENT_ASYNC", decode_async),
-                  Decoder(6, "EVENT_ASYNC", decode_async),
-                  Decoder(6, "EVENT_ASYNC", decode_async),
-                  Decoder(8, "EVENT_ASYNC", decode_async),
-                  Decoder(9, "EVENT_ASYNC", decode_async),
-                  Decoder(10, "EVENT_ASYNC", decode_async),
-                  Decoder(11, "EVENT_SHUTDOWN", decode_unimp),
-                  Decoder(12, "EVENT_SHUTDOWN_HOST_ERR", decode_unimp),
-                  Decoder(13, "EVENT_SHUTDOWN_HOST_QMP_QUIT", decode_unimp),
-                  Decoder(14, "EVENT_SHUTDOWN_HOST_QMP_RESET", decode_unimp),
-                  Decoder(14, "EVENT_SHUTDOWN_HOST_SIGNAL", decode_unimp),
-                  Decoder(15, "EVENT_SHUTDOWN_HOST_UI", decode_unimp),
-                  Decoder(16, "EVENT_SHUTDOWN_GUEST_SHUTDOWN", decode_unimp),
-                  Decoder(17, "EVENT_SHUTDOWN_GUEST_RESET", decode_unimp),
-                  Decoder(18, "EVENT_SHUTDOWN_GUEST_PANIC", decode_unimp),
-                  Decoder(19, "EVENT_SHUTDOWN_GUEST_SUBSYSTEM_RESET", decode_unimp),
-                  Decoder(20, "EVENT_SHUTDOWN_GUEST_SNAPSHOT_LOAD", decode_unimp),
-                  Decoder(21, "EVENT_SHUTDOWN___MAX", decode_unimp),
+                  Decoder(2, "EVENT_EXCEPTION", decode_exception),
+                  Decoder(3, "EVENT_ASYNC_BH", decode_async_bh),
+                  Decoder(4, "EVENT_ASYNC_BH_ONESHOT", decode_async_bh_oneshot),
+                  Decoder(5, "EVENT_ASYNC_INPUT", decode_unimp),
+                  Decoder(6, "EVENT_ASYNC_INPUT_SYNC", decode_unimp),
+                  Decoder(7, "EVENT_ASYNC_CHAR_READ", decode_async_char_read),
+                  Decoder(8, "EVENT_ASYNC_BLOCK", decode_async_block),
+                  Decoder(9, "EVENT_ASYNC_NET", decode_async_net),
+                  Decoder(10, "EVENT_SHUTDOWN", decode_shutdown),
+                  Decoder(11, "EVENT_SHUTDOWN_HOST_ERR", decode_shutdown),
+                  Decoder(12, "EVENT_SHUTDOWN_HOST_QMP_QUIT", decode_shutdown),
+                  Decoder(13, "EVENT_SHUTDOWN_HOST_QMP_RESET", decode_shutdown),
+                  Decoder(14, "EVENT_SHUTDOWN_HOST_SIGNAL", decode_shutdown),
+                  Decoder(15, "EVENT_SHUTDOWN_HOST_UI", decode_shutdown),
+                  Decoder(16, "EVENT_SHUTDOWN_GUEST_SHUTDOWN", decode_shutdown),
+                  Decoder(17, "EVENT_SHUTDOWN_GUEST_RESET", decode_shutdown),
+                  Decoder(18, "EVENT_SHUTDOWN_GUEST_PANIC", decode_shutdown),
+                  Decoder(19, "EVENT_SHUTDOWN_SUBSYS_RESET", decode_shutdown),
+                  Decoder(20, "EVENT_SHUTDOWN_SNAPSHOT_LOAD", decode_shutdown),
+                  Decoder(21, "EVENT_SHUTDOWN___MAX", decode_shutdown),
                   Decoder(22, "EVENT_CHAR_WRITE", decode_char_write),
                   Decoder(23, "EVENT_CHAR_READ_ALL", decode_unimp),
                   Decoder(24, "EVENT_CHAR_READ_ALL_ERROR", decode_unimp),
-                  Decoder(25, "EVENT_AUDIO_IN", decode_unimp),
-                  Decoder(26, "EVENT_AUDIO_OUT", decode_audio_out),
+                  Decoder(25, "EVENT_AUDIO_OUT", decode_audio_out),
+                  Decoder(26, "EVENT_AUDIO_IN", decode_unimp),
                   Decoder(27, "EVENT_RANDOM", decode_random),
                   Decoder(28, "EVENT_CLOCK_HOST", decode_clock),
                   Decoder(29, "EVENT_CLOCK_VIRTUAL_RT", decode_clock),
@@ -334,6 +392,7 @@ def decode_random(eid, name, dumpfile):
                   Decoder(36, "EVENT_CP_CLOCK_VIRTUAL_RT", decode_checkpoint),
                   Decoder(37, "EVENT_CP_INIT", decode_checkpoint_init),
                   Decoder(38, "EVENT_CP_RESET", decode_checkpoint),
+                  Decoder(39, "EVENT_END", decode_end),
 ]
 
 def parse_arguments():
-- 
2.42.0


