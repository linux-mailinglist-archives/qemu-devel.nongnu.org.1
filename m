Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 542C38272C4
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:16:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrKI-0004Ei-3P; Mon, 08 Jan 2024 10:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKF-0004Do-Nu
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:03 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKA-0001YM-5M
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:03 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-336788cb261so1852102f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704726836; x=1705331636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytoJGUOfVhpGlmTk7EPY0JIdgCeWa/v+zzjLeogcti8=;
 b=DpUrXjZV95ey8DPQn+7cGZO+fQof3YY2Ni12pA92IRMpzVJ7YGOcHnDk7BKV2LYttK
 S6SdbYMF+oTgF2XB+OR2fHpY04vyz6Z9HK520G4hiLy3NKebl3O54DGr1QmJGzvo8LB3
 e/JO2xDMLqJlDd6q+2hif7vpu8qYFP2MBw+GNn7wFi0e3kY8AAO6/K5Klzd8yhLarWpJ
 ywHTwIgbmMMzq4y/T62PRVbQ09zjYkJsD9eEMKiwZ+FuvYRHxayfOkQ/XPRkgQY/Izlb
 jSOQQomHe6Ig2+C59Fq9d5Rm2S9ntAV3WtdGGMbEFKOg5P9fkYOJk/cgqKp1WbJlm0e/
 M8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704726836; x=1705331636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ytoJGUOfVhpGlmTk7EPY0JIdgCeWa/v+zzjLeogcti8=;
 b=jOB5jNRYlwe/Eb8EUvtguNt+KwYDahkeIvRl6YxhzRpSX+RyHSaDr1FLYo6FKBvlqM
 sSBLcTroZ/ZsSkQpht/caZWsxvwlq8QNSwaw3q8I9Hdv+YxqWcJ4TpqpSpy3AMzj6xKd
 D+mBBgZ4OfkB1WOaBErW//mv7DjbfPEX3v0GElwhFGmssOEqObrp8EbIr9uVgsq64XP2
 Wb9uIUPT6w3/D374o2dnD26N71bsut4QnZjzHeuagmDkCTdxMs0InJdvaOpwMxuZaBoQ
 1ACE4GabV+OZh1V93XRiS03Z2ozfma7Dy/BhQGJZWG+99WnTL492CZHh6Eot6Uduwubh
 CIPg==
X-Gm-Message-State: AOJu0YyO9PlSBMHO0vwrbhO0TZmmtxxDp0MFeu3GHJvN8zw43fZPw32p
 KUsK5iznHL/jn1Swo2jjqp3HX07ShQyvlcuZVF2Rrv/zEv8=
X-Google-Smtp-Source: AGHT+IENL7Sysu+xb8vai5o+U0jJsJnlYMT6PkjU4Wlsmi1yePO4/baA18SIm4JqAoNmL4/a0yjdiw==
X-Received: by 2002:a5d:4343:0:b0:337:5b64:7414 with SMTP id
 u3-20020a5d4343000000b003375b647414mr1763861wrr.100.1704726836540; 
 Mon, 08 Jan 2024 07:13:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l3-20020adff483000000b0033719111458sm8056448wro.36.2024.01.08.07.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:13:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3C7F25F944;
 Mon,  8 Jan 2024 15:13:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL 04/13] scripts/replay-dump: update to latest format
Date: Mon,  8 Jan 2024 15:13:43 +0000
Message-Id: <20240108151352.2199097-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108151352.2199097-1-alex.bennee@linaro.org>
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231211091346.14616-5-alex.bennee@linaro.org>

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index b89dc29555a..6f300e4c54e 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -21,6 +21,7 @@
 import argparse
 import struct
 from collections import namedtuple
+from os import path
 
 # This mirrors some of the global replay state which some of the
 # stream loading refers to. Some decoders may read the next event so
@@ -82,6 +83,12 @@ def read_qword(fin):
     "Read a 64 bit word"
     return struct.unpack('>Q', fin.read(8))[0]
 
+def read_array(fin):
+    "Read a sized array"
+    size = read_dword(fin)
+    data = fin.read(size)
+    return data
+
 # Generic decoder structure
 Decoder = namedtuple("Decoder", "eid name fn")
 
@@ -115,6 +122,11 @@ def decode_unimp(eid, name, _unused_dumpfile):
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
@@ -151,6 +163,12 @@ def decode_instruction(eid, name, dumpfile):
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
@@ -189,14 +207,19 @@ def decode_clock(eid, name, dumpfile):
     print_event(eid, name, "0x%x" % (clock_data))
     return True
 
+def decode_random(eid, name, dumpfile):
+    ret = read_dword(dumpfile)
+    data = read_array(dumpfile)
+    print_event(eid, "%d bytes of random data" % len(data))
+    return True
 
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
@@ -215,10 +238,10 @@ def decode_clock(eid, name, dumpfile):
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
@@ -250,7 +273,7 @@ def decode_clock(eid, name, dumpfile):
                   Decoder(10, "EVENT_SHUTDOWN_GUEST_RESET", decode_unimp),
                   Decoder(11, "EVENT_SHUTDOWN_GUEST_PANIC", decode_unimp),
                   Decoder(12, "EVENT_SHUTDOWN___MAX", decode_unimp),
-                  Decoder(13, "EVENT_CHAR_WRITE", decode_unimp),
+                  Decoder(13, "EVENT_CHAR_WRITE", decode_char_write),
                   Decoder(14, "EVENT_CHAR_READ_ALL", decode_unimp),
                   Decoder(15, "EVENT_CHAR_READ_ALL_ERROR", decode_unimp),
                   Decoder(16, "EVENT_AUDIO_OUT", decode_audio_out),
@@ -268,6 +291,48 @@ def decode_clock(eid, name, dumpfile):
                   Decoder(28, "EVENT_CP_RESET", decode_checkpoint),
 ]
 
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
+                  Decoder(27, "EVENT_RANDOM", decode_random),
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
@@ -278,14 +343,18 @@ def parse_arguments():
 def decode_file(filename):
     "Decode a record/replay dump"
     dumpfile = open(filename, "rb")
-
+    dumpsize = path.getsize(filename)
     # read and throwaway the header
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
@@ -299,8 +368,13 @@ def decode_file(filename):
         decode_ok = True
         while decode_ok:
             event = read_event(dumpfile)
-            decode_ok = call_decode(event_decode_table, event, dumpfile)
+            decode_ok = call_decode(event_decode_table, event,
+                                    dumpfile)
+    except Exception as inst:
+        print(f"error {inst}")
+
     finally:
+        print(f"Reached {dumpfile.tell()} of {dumpsize} bytes")
         dumpfile.close()
 
 if __name__ == "__main__":
-- 
2.39.2


