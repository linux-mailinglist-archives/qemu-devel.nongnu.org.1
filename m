Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2E377BE22
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 18:33:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVaU5-0000VZ-3N; Mon, 14 Aug 2023 12:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qVaU1-0000VA-P2
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:31:57 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qVaU0-0004uq-44
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 12:31:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bbc87ded50so27115505ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692030714; x=1692635514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNd0WOPv39XbbgsewCHXLS8Ws+tfcBl+X9eCoHKVg1Q=;
 b=B83SmmWdUxcsZGNBCYBW6sWXpALGsTSf4A+/3k7w9U5sr2WWJ+0NUPRACL5XryU/K6
 qvqDBQ/vgp1tmgC/AQ8NIAANBrsMgqpKrfCx+lzyu5OE9jEyIlwy/MR53KXdr4DGwhJa
 kFddAdsuoRTzfrSikt0DaT8+KZC2RY6+Y0Z4V7rOWoQbO39ORXQa+lqj9iPr5fnAjPex
 FTTs9SI2V78PiUn/duR8zuYCd78DkMArh6yAFbgFrQlxZMJbwxDJJ60zNRrwub2j3Q2a
 DNDkDnFXEd+cn82NbKpqW5lvtMI2xNBY8uC+ZQP4ZrEHgwTcAFRytAHt35b/nY9wuItT
 s/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692030714; x=1692635514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNd0WOPv39XbbgsewCHXLS8Ws+tfcBl+X9eCoHKVg1Q=;
 b=MCyuo6LduxCUNjtMN43pm246WfVgq649wHkg2V50O1GkP5ZTTEWizShMqJyIETb9Wv
 +sYIYFqTYZDbcSyK65T8k9w0xmIA/AkN6rd4oiWDCqwG5h/rNECpvC11+uHl3XjHwegy
 7BxurHwyETcaVdC7id9we8c+wwT89dobStcq3yvPANBgxxGKfgQr8N+4VJG5H/FPQrPQ
 yEW/AMG0xR348Sft2NsNlokToeowtquFC9+NAEzpd15W1mJ8wqT/RzxRtbSC0pxMAoWR
 LT6mDeMA157uzQ6EQ7kIJEDG1+K+zX8jjkLvJI/CaZAf2qoLEH3f7Nfu7KvEzKIpRRIq
 DfVg==
X-Gm-Message-State: AOJu0YxA6n+jeGIFWubzGl4Ce6Pf9MfFlOIB5DrbCeJEGPUWaHbyGnPm
 wfwRHLX7F6a6HjGS6VIxAFI=
X-Google-Smtp-Source: AGHT+IF5zFeIeJKwuhDy5IClUo+QpkU89YpXbtFIBDeLmLZB4ErVSjjXw5YyCCN8+LLPtcMMUpUwuQ==
X-Received: by 2002:a17:903:1ce:b0:1bc:382b:6897 with SMTP id
 e14-20020a17090301ce00b001bc382b6897mr10553450plh.13.1692030714296; 
 Mon, 14 Aug 2023 09:31:54 -0700 (PDT)
Received: from wheely.local0.net ([61.68.161.249])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a170902c1c600b001b8a3a0c928sm9613263plc.181.2023.08.14.09.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 09:31:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/4] tests/avocado: replay_linux.py add replay-dump.py test
Date: Tue, 15 Aug 2023 02:31:33 +1000
Message-Id: <20230814163135.187882-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814163135.187882-1-npiggin@gmail.com>
References: <20230814163135.187882-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

This runs replay-dump.py after recording a trace, and fails the test if
the script fails.

replay-dump.py is modified to exit with non-zero if an error is
encountered while parsing.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
It's possible this could introduce failures to existing test if an
unimplemented event gets recorded. I would make a new test for this but
it takes quite a while to record such a long trace that includes some
block and net events to excercise the script.

Thanks,
Nick

 scripts/replay-dump.py        |  6 ++++--
 tests/avocado/replay_linux.py | 16 +++++++++++++++-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 937ae19ff1..8f4715632a 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -21,6 +21,7 @@
 import argparse
 import struct
 import os
+import sys
 from collections import namedtuple
 
 # This mirrors some of the global replay state which some of the
@@ -97,7 +98,7 @@ def call_decode(table, index, dumpfile):
         print("Could not decode index: %d" % (index))
         print("Entry is: %s" % (decoder))
         print("Decode Table is:\n%s" % (table))
-        return False
+        sys.exit(1)
     else:
         return decoder.fn(decoder.eid, decoder.name, dumpfile)
 
@@ -118,7 +119,7 @@ def print_event(eid, name, string=None, event_count=None):
 def decode_unimp(eid, name, _unused_dumpfile):
     "Unimplimented decoder, will trigger exit"
     print("%s not handled - will now stop" % (name))
-    return False
+    sys.exit(1)
 
 # Checkpoint decoder
 def swallow_async_qword(eid, name, dumpfile):
@@ -401,3 +402,4 @@ def decode_file(filename):
 if __name__ == "__main__":
     args = parse_arguments()
     decode_file(args.file)
+    sys.exit(0)
diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index a76dd507fc..12937ce0ec 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -11,6 +11,7 @@
 import os
 import logging
 import time
+import subprocess
 
 from avocado import skipUnless
 from avocado_qemu import BUILD_DIR
@@ -21,6 +22,11 @@
 from avocado.utils.path import find_command
 from avocado_qemu import LinuxTest
 
+from pathlib import Path
+
+self_dir = Path(__file__).parent
+src_dir = self_dir.parent.parent
+
 class ReplayLinux(LinuxTest):
     """
     Boots a Linux system, checking for a successful initialization
@@ -94,7 +100,7 @@ def launch_and_wait(self, record, args, shift):
         else:
             vm.event_wait('SHUTDOWN', self.timeout)
             vm.shutdown(True)
-            logger.info('successfully fihished the replay')
+            logger.info('successfully finished the replay')
         elapsed = time.time() - start_time
         logger.info('elapsed time %.2f sec' % elapsed)
         return elapsed
@@ -105,6 +111,14 @@ def run_rr(self, args=None, shift=7):
         logger = logging.getLogger('replay')
         logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
 
+        try:
+            replay_path = os.path.join(self.workdir, 'replay.bin')
+            subprocess.check_call(["./scripts/replay-dump.py",
+                                   "-f", replay_path],
+                                  cwd=src_dir, stdout=subprocess.DEVNULL)
+        except subprocess.CalledProcessError:
+            self.fail('replay-dump.py failed')
+
 @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
 class ReplayLinuxX8664(ReplayLinux):
     """
-- 
2.40.1


