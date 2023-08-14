Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA3277BE20
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 18:33:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVaTz-0000Uh-Lu; Mon, 14 Aug 2023 12:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qVaTx-0000UV-Hj
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:31:53 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qVaTv-0004qI-I8
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:31:53 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bdc19b782aso17134025ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692030710; x=1692635510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vp6gU892XZK0ouQnofmt9i+CmckUy2isN46xGuzvKXk=;
 b=Yza0XjjWsH2MApMdyOANoSYFkvvqMpglfGIkb9+WXmxiBENfvuDA4O5gwR9oOMxrlD
 QVQLzPJaR2glOvsrfg2iqUijNIALlRump58wh3BO68fL4V0B36XtWW2KNjHhWlcMnKZ9
 4AA5GF8tN82t5oOjq7CFm4XMqlN7zaSaAC/wS8j0xS/Ceo/C7cOnhSrmOUF9XF1ogNnZ
 vsdO1o+13MchT77NCgjhQTUEoOJYmGlIUc5WWop3cgIhvJgHQYNAEQWRSNj7zoIjOx7+
 ATxCM12Pg8Gl87zcCsw0/tfAK7B5wrNQWYEq3c4q6vh0QGN4+sZ44FOnGA6xf6t2lPvo
 LdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692030710; x=1692635510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vp6gU892XZK0ouQnofmt9i+CmckUy2isN46xGuzvKXk=;
 b=kky5P9miP1AGJX0T7l0KRnVPegnafD9BSjN912S/p6iY4k56VX7G3N3j5kgzKzV6yg
 dQFWni6kjidSSU3bnweseSU5Ps7Q0X2TPW1lg7j1rTAaFBCMj0gB5ncT+V5uMm1CVU0X
 Fx+PnjQbNd7wm/VOOdrAu6dpezqvWXWxAY/Tmj3Bl9exnt6J5X8qAuEqFLXh42uofalw
 eFU31/eHNn9NUNJwKCNVusZ8Jt7N0lS/8qAV9XmwoKv+LXMHtGS7Eu/QfQ5k+a0fsDjy
 GwIBw6cGpalyVmzgjJtZnuN/QbYJwftlRdqNhdyF282Q73KBFEwqN7h1FPVLRHoRNgbQ
 baUQ==
X-Gm-Message-State: AOJu0Yz25UpKocjw8Vi5CL7qKKNUr9KQ6GMccXxRqVr+FF0dQ65zZVkV
 ZfqRIrqPn07oOn+krqaiaPc=
X-Google-Smtp-Source: AGHT+IE51zvn7/jg4pjLaGi99ZaebyzC1eH4zizPHfi3ncdvv16NRSsshbf5Dwxco/4/Tdg//Wpg5A==
X-Received: by 2002:a17:902:e742:b0:1bc:7312:78db with SMTP id
 p2-20020a170902e74200b001bc731278dbmr10717324plf.57.1692030710148; 
 Mon, 14 Aug 2023 09:31:50 -0700 (PDT)
Received: from wheely.local0.net ([61.68.161.249])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a170902c1c600b001b8a3a0c928sm9613263plc.181.2023.08.14.09.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 09:31:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/4] scripts/replay_dump.sh: Update to current rr record format
Date: Tue, 15 Aug 2023 02:31:32 +1000
Message-Id: <20230814163135.187882-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814163135.187882-1-npiggin@gmail.com>
References: <20230814163135.187882-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This thing seems to have fallen by the wayside. This gets it working with
the current format, although does not quite implement all events.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
My python skills are not good. Any help on this or patch 2 is
appreciated.

Thanks,
Nick

 scripts/replay-dump.py | 107 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 101 insertions(+), 6 deletions(-)

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 3ba97a6d30..937ae19ff1 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -20,6 +20,7 @@
 
 import argparse
 import struct
+import os
 from collections import namedtuple
 
 # This mirrors some of the global replay state which some of the
@@ -62,6 +63,10 @@ def read_byte(fin):
     "Read a single byte"
     return struct.unpack('>B', fin.read(1))[0]
 
+def read_bytes(fin, nr):
+    "Read a nr bytes"
+    return fin.read(nr)
+
 def read_event(fin):
     "Read a single byte event, but save some state"
     if replay_state.already_read:
@@ -122,12 +127,18 @@ def swallow_async_qword(eid, name, dumpfile):
     print("  %s(%d) @ %d" % (name, eid, step_id))
     return True
 
+def swallow_bytes(eid, name, dumpfile, nr):
+    "Swallow nr bytes of data without looking at it"
+    dumpfile.seek(nr, os.SEEK_CUR)
+    return True
+
 async_decode_table = [ Decoder(0, "REPLAY_ASYNC_EVENT_BH", swallow_async_qword),
-                       Decoder(1, "REPLAY_ASYNC_INPUT", decode_unimp),
-                       Decoder(2, "REPLAY_ASYNC_INPUT_SYNC", decode_unimp),
-                       Decoder(3, "REPLAY_ASYNC_CHAR_READ", decode_unimp),
-                       Decoder(4, "REPLAY_ASYNC_EVENT_BLOCK", decode_unimp),
-                       Decoder(5, "REPLAY_ASYNC_EVENT_NET", decode_unimp),
+                       Decoder(1, "REPLAY_ASYNC_BH_ONESHOT", decode_unimp),
+                       Decoder(2, "REPLAY_ASYNC_INPUT", decode_unimp),
+                       Decoder(3, "REPLAY_ASYNC_INPUT_SYNC", decode_unimp),
+                       Decoder(4, "REPLAY_ASYNC_CHAR_READ", decode_unimp),
+                       Decoder(5, "REPLAY_ASYNC_EVENT_BLOCK", decode_unimp),
+                       Decoder(6, "REPLAY_ASYNC_EVENT_NET", decode_unimp),
 ]
 # See replay_read_events/replay_read_event
 def decode_async(eid, name, dumpfile):
@@ -156,6 +167,13 @@ def decode_audio_out(eid, name, dumpfile):
     print_event(eid, name, "%d" % (audio_data))
     return True
 
+def decode_random(eid, name, dumpfile):
+    ret = read_dword(dumpfile)
+    size = read_dword(dumpfile)
+    swallow_bytes(eid, name, dumpfile, size)
+    print_event(eid, name, "%d %d" % (ret, size))
+    return True
+
 def decode_checkpoint(eid, name, dumpfile):
     """Decode a checkpoint.
 
@@ -184,6 +202,38 @@ def decode_interrupt(eid, name, dumpfile):
     print_event(eid, name)
     return True
 
+def decode_exception(eid, name, dumpfile):
+    print_event(eid, name)
+    return True
+
+def decode_shutdown(eid, name, dumpfile):
+    print_event(eid, name)
+    return True
+
+def decode_end(eid, name, dumpfile):
+    print_event(eid, name)
+    return False
+
+def decode_char_write(eid, name, dumpfile):
+    res = read_dword(dumpfile)
+    offset = read_dword(dumpfile)
+    print_event(eid, name)
+    return True
+
+def decode_async_char_read(eid, name, dumpfile):
+    char_id = read_byte(dumpfile)
+    size = read_dword(dumpfile)
+    print_event(eid, name, "device:%x chars:%s" % (char_id, read_bytes(dumpfile, size)))
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
 def decode_clock(eid, name, dumpfile):
     clock_data = read_qword(dumpfile)
     print_event(eid, name, "0x%x" % (clock_data))
@@ -268,6 +318,48 @@ def decode_clock(eid, name, dumpfile):
                   Decoder(28, "EVENT_CP_RESET", decode_checkpoint),
 ]
 
+v12_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
+                  Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
+                  Decoder(2, "EVENT_EXCEPTION", decode_exception),
+                  Decoder(3, "EVENT_ASYNC_BH", swallow_async_qword),
+                  Decoder(4, "EVENT_ASYNC_BH_ONESHOT", swallow_async_qword),
+                  Decoder(5, "EVENT_ASYNC_INPUT", decode_unimp),
+                  Decoder(6, "EVENT_ASYNC_INPUT_SYNC", decode_unimp),
+                  Decoder(7, "EVENT_ASYNC_CHAR_READ", decode_async_char_read),
+                  Decoder(8, "EVENT_ASYNC_BLOCK", swallow_async_qword),
+                  Decoder(9, "EVENT_ASYNC_NET", decode_async_net),
+                  Decoder(10, "EVENT_SHUTDOWN", decode_unimp),
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
+                  Decoder(22, "EVENT_CHAR_WRITE", decode_char_write),
+                  Decoder(23, "EVENT_CHAR_READ_ALL", decode_unimp),
+                  Decoder(24, "EVENT_CHAR_READ_ALL_ERROR", decode_unimp),
+                  Decoder(25, "EVENT_AUDIO_OUT", decode_audio_out),
+                  Decoder(26, "EVENT_AUDIO_IN", decode_unimp),
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
+                  Decoder(39, "EVENT_END", decode_end),
+]
+
 def parse_arguments():
     "Grab arguments for script"
     parser = argparse.ArgumentParser()
@@ -285,7 +377,10 @@ def decode_file(filename):
 
     print("HEADER: version 0x%x" % (version))
 
-    if version == 0xe02007:
+    if version == 0xe0200c:
+        event_decode_table = v12_event_table
+        replay_state.checkpoint_start = 12
+    elif version == 0xe02007:
         event_decode_table = v7_event_table
         replay_state.checkpoint_start = 12
     elif version == 0xe02006:
-- 
2.40.1


