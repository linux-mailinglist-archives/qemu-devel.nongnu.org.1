Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DACE780C446
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:17:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcMN-0001Ow-CK; Mon, 11 Dec 2023 04:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMK-0001Nw-S5
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:52 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMI-0004Ka-QS
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:52 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c339d2b88so28723345e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286029; x=1702890829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eWQTJxjAvJ/tjtG2WMzLhaHBUimTZHZjiblNAYR41mE=;
 b=c22eghQPmHcNyK9fnWQ+DeiOU8ZDPUy91AsJ93PqGoAKtxIt4N//WmEWL5GgUyYQzV
 /3+CuP5OvcDaPUQolZOLiOuL5Bv6CJma+OdA7HDI9WHzom5oB2KdRLoKr1rajneJsLd1
 +WZucqimake2qzo883wzqQlNbmVKXEcjgIoXOsMwDTbwuWQJ75hiRIcflUZ4KS68L4nl
 6A1fzDruoGxvdug/Nd5VjLHfoJarhIxx0Dbwu373YZpqQiNBw3zbeZy0l5JjGfvfD94z
 4Msyyd1b9VMvFmNBCz5crU7KgSBjjjbotiLZBPG3m+2t0QwEV/K0IQBl8sMalzltIAR2
 FSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286029; x=1702890829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eWQTJxjAvJ/tjtG2WMzLhaHBUimTZHZjiblNAYR41mE=;
 b=VvJIcD6lMh1ueWuMB3K2g+WXo2Yo3gjFS762yCJezCUf4i38eL6Q0ShzrpwTeeWRAH
 9UcjDGztwnDOAVpazqBacCmGwh7l5hVD3z0HsN2Itw2KPmYZ6t1DDGNXtuXP0kyHR+1K
 r2UEORvXgx2SUrc7EllLPxyeRjBVMFEryJHss6XMmdwWb/QkA4mz20VoqQwRjxaRd/0O
 217t1pZXSIatovkuj353gCxa41K3AoeheBEsvxeFt9ZahZgHZ1dmibnVDoZLhi1wyM/X
 +eWqRymQiArjpoOj1Y/lBvCMGC9vay6jrkmkvak3S10Vbk0fhLIK85fHVVsMmOeqnOnm
 W66w==
X-Gm-Message-State: AOJu0YyUfIs0zycDmrVDOKkWubjZCjU+xAQ88k93Qiua8aqd81dyAGYq
 sM/rqdFzU6ilsUGsmwPKMeHNoonAwTjpzd8Lpi4=
X-Google-Smtp-Source: AGHT+IHlpbvLdmaMY8VFCL4BP+gXKhx7Yk+v0Cwc072+Vn0V7ax2N3ft63I7i90nusz8UFA1/vp7xg==
X-Received: by 2002:a05:600c:4d8f:b0:40c:2654:5705 with SMTP id
 v15-20020a05600c4d8f00b0040c26545705mr1996303wmp.119.1702286029309; 
 Mon, 11 Dec 2023 01:13:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i1-20020a05600c354100b0040c411da99csm6827146wmq.48.2023.12.11.01.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:13:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6DFCF5FBE0;
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 04/16] scripts/replay-dump: update to latest format
Date: Mon, 11 Dec 2023 09:13:33 +0000
Message-Id: <20231211091346.14616-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
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

Message-Id: <20231205204106.95531-4-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add EVENT_RANDOM decoding
---
 scripts/replay-dump.py | 90 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 8 deletions(-)

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index b89dc29555..6f300e4c54 100755
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


