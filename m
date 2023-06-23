Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B3873B855
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:59:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgMD-0000P8-G4; Fri, 23 Jun 2023 08:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCgM5-0000O8-2n; Fri, 23 Jun 2023 08:57:38 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCgM3-0006Lw-78; Fri, 23 Jun 2023 08:57:36 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b5422163f4so4227865ad.2; 
 Fri, 23 Jun 2023 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687525052; x=1690117052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLjwbrwCcnOwIHYqGly36m5ilqRyrKG/b9OdDLkfmVo=;
 b=onCmxQFSjYlYAiC+Q9KjRVx4st5gL+lvipu6Qfzm30XyOQdGEWvJKgKwgIP0tL8b//
 WQ6sG/2lzrgyy1hazDFIv6SWgoQCHE7SIpnLsB0m1+L4ko6Iv4lnIP0oz5kQ/cGfe3ap
 L65mmHsNQog7cDdPWGURYF+a3Nj8IXm6d1G+uGaOvhZi6vk7/dxvxaP/84xCSwE/SyjM
 mpN24cNLwd1adiHTmDaZln99X3sRTB7J13UGS/WDikF8c1179+Ld9L2yngtif2OmnBSk
 wC5HyOZKKqYqCdeJ2CXykL8eKMQZWigqSwY+q+kj1TIEplJ5p6ZtEDR6L0fWtnAiW7Ph
 ZWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687525052; x=1690117052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WLjwbrwCcnOwIHYqGly36m5ilqRyrKG/b9OdDLkfmVo=;
 b=M8OxOTa7ST/tHnUKwh3Wx6jao7m97qilejEzio/6UZb823/wKfQC+01ao4T0CQgVQH
 beXHivwV7omAnrlbW1fmqiuQ0IuX6yFqc99c8moRBzD2PboCdajQBRu66uqB60S8bBvu
 fyNuB5P9BA7st3aW/emmPI5uB5pez+QOVFR2y9Rq2b4CCrrqP5FAnEMuvE9IremlnVm2
 o6FVWv7h3tHH+40XyWQ8HpVSdBeXrfK0r0OrPZMKYH/CcZ08Vpn8rreXa+j3TapC0aWT
 CsyZWaznl+ltmjFYrWEbMpYJfQGLUUFLz8HUL15UwIAyMOe+wk7jOTJ05GYZkDL/WXFS
 b+Dw==
X-Gm-Message-State: AC+VfDwlKLfoJf4Juu7gsWUZcZ974CYEjNt83b7NSwHoZeLedpgoTeWh
 DtjSkNML8ajkgWGO09IMPq8sHKxa+Os=
X-Google-Smtp-Source: ACHHUZ4EdfkQpEObJ2Dr5MfwBoTxg7qPgp8LSaML9GvgJUYIbSC1FZuTDdiUTgk2enuHrMqL369aTQ==
X-Received: by 2002:a17:902:f542:b0:1b6:ba60:780e with SMTP id
 h2-20020a170902f54200b001b6ba60780emr3869055plf.24.1687525052417; 
 Fri, 23 Jun 2023 05:57:32 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 b12-20020a170902bd4c00b001a04d27ee92sm7141795plx.241.2023.06.23.05.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:57:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/7] scripts/replay_dump.sh: Update to current rr record format
Date: Fri, 23 Jun 2023 22:57:02 +1000
Message-Id: <20230623125707.323517-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623125707.323517-1-npiggin@gmail.com>
References: <20230623125707.323517-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

This thing seems to have fallen by the wayside. This quick hack gets
it vaguely working with the current format. It was some use in fixing
rr support for ppc, so maybe others will find it useful too.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 scripts/replay-dump.py | 89 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 6 deletions(-)

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 3ba97a6d30..c46ff8ffd6 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -122,12 +122,19 @@ def swallow_async_qword(eid, name, dumpfile):
     print("  %s(%d) @ %d" % (name, eid, step_id))
     return True
 
+def swallow_bytes(eid, name, dumpfile, nr):
+    "Swallow nr bytes of data without looking at it"
+    for x in range(nr):
+         read_byte(dumpfile)
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
@@ -156,6 +163,13 @@ def decode_audio_out(eid, name, dumpfile):
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
 
@@ -184,6 +198,24 @@ def decode_interrupt(eid, name, dumpfile):
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
 def decode_clock(eid, name, dumpfile):
     clock_data = read_qword(dumpfile)
     print_event(eid, name, "0x%x" % (clock_data))
@@ -268,6 +300,48 @@ def decode_clock(eid, name, dumpfile):
                   Decoder(28, "EVENT_CP_RESET", decode_checkpoint),
 ]
 
+v12_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
+                  Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
+                  Decoder(2, "EVENT_EXCEPTION", decode_exception),
+                  Decoder(3, "EVENT_ASYNC_BH", swallow_async_qword),
+                  Decoder(4, "EVENT_ASYNC_BH_ONESHOT", decode_unimp),
+                  Decoder(5, "EVENT_ASYNC_INPUT", decode_unimp),
+                  Decoder(6, "EVENT_ASYNC_INPUT_SYNC", decode_unimp),
+                  Decoder(7, "EVENT_ASYNC_CHAR_READ", decode_unimp),
+                  Decoder(8, "EVENT_ASYNC_BLOCK", decode_unimp),
+                  Decoder(9, "EVENT_ASYNC_NET", decode_unimp),
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
@@ -285,7 +359,10 @@ def decode_file(filename):
 
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


