Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9692583C795
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Jan 2024 17:10:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2Hu-0006yl-TG; Thu, 25 Jan 2024 11:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rT2Ht-0006vj-44
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:09:09 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rT2Hr-0000NS-75
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:09:08 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so5279253a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706198944; x=1706803744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkwo7UCJpMNv5mPn2sWjbV8ooarPUagmTu1VnxL99W0=;
 b=Pb+EbWFzONOflOcPXQ+B5pwth+kHgsvb/MiYrXFZ0nsweoNwnq7GQVn4FJ6M4C88m6
 hmG9ZgsJJvifsfA87N2ILv2Nl0TD4ahRn8/B0YDC7abGtEy2gkr/N8vW3DwcLpaDJeHA
 +FS5M33G/IYybzkvDgweJXBvM0M9yNy8iZWKOzyFzEJmM2D9yTdyb6xcaTq++QV7bld7
 FeCpxDH9Sy/QjkmQzZTlARyG4pvIj+nxjupqLWM3IkXWuCBED7PmPlvew5/st2IOgqoB
 uNXS5w/H/cC/+IToIQmWTnCNGrR6Bf46wL8OWv99gDS/rSitfiIjBorxGASWTQjJclnn
 n41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706198944; x=1706803744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pkwo7UCJpMNv5mPn2sWjbV8ooarPUagmTu1VnxL99W0=;
 b=W6sDYXQi8ec70dspaqj3GjUjS/HWr5+WfHfXbV732y//R+Rqe+h0hc7MPuFqDYm9YW
 N8N4FN49EtSb04hI4Pajk8AAIHGM7u2rmFAvTQa6Azdd9vQc1Ga1Bqjos0LUurxoTYTf
 K0DoZJ9UrcM4LOS4k89DDxApBbCOORdayPwj4LN0Kuf2QWFXQoXjIcsF+mIq5h7TtTFi
 D37tGJhkY1MNPUwRjHtiqcE3F+qUDBs1RZUqoFNN1xRD2HUL09vm0WTE4X1yvY1qCGDt
 U3a4uRKlk4wj7wMDoHsBsEN1P3CzRyB5O1siAB6nQfDjyk98RoIyWGdSTH9kSFbW6joO
 bATA==
X-Gm-Message-State: AOJu0Ywnb05iUu+gcgbw9SyKGVlUyY1t3rQHJpaVpEVTePbauZ4rPp8y
 52kF4MD/oZyaFV6aInXFnvF7MqlmMsZfrzCcN5B686Y5xD3lyPxg4q+hLXtC
X-Google-Smtp-Source: AGHT+IHkq+KFB8siFeMpeiKhcBdVZCuCCy+rsE0uDvcSnJYCyTlA2yC3AXNw0dMDgrsuaHhs9EcEaw==
X-Received: by 2002:a17:90a:d313:b0:290:f9b6:8078 with SMTP id
 p19-20020a17090ad31300b00290f9b68078mr1050445pju.7.1706198944532; 
 Thu, 25 Jan 2024 08:09:04 -0800 (PST)
Received: from wheely.local0.net (110-175-3-177.tpgi.com.au. [110.175.3.177])
 by smtp.gmail.com with ESMTPSA id
 oe7-20020a17090b394700b00293851b198csm14190pjb.56.2024.01.25.08.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:09:04 -0800 (PST)
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
Subject: [PATCH v2 4/4] tests/avocado: excercise scripts/replay-dump.py in
 replay tests
Date: Fri, 26 Jan 2024 02:08:35 +1000
Message-ID: <20240125160835.480488-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240125160835.480488-1-npiggin@gmail.com>
References: <20240125160835.480488-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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

This runs replay-dump.py after recording a trace, and fails the test if
the script fails.

replay-dump.py is modified to exit with non-zero if an error is
encountered while parsing, to support this.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 scripts/replay-dump.py         |  6 ++++--
 tests/avocado/replay_kernel.py | 16 ++++++++++++++++
 tests/avocado/replay_linux.py  | 16 ++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index a1d7ae0364..bfea9c099b 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -21,6 +21,7 @@
 import argparse
 import struct
 import os
+import sys
 from collections import namedtuple
 from os import path
 
@@ -104,7 +105,7 @@ def call_decode(table, index, dumpfile):
         print("Could not decode index: %d" % (index))
         print("Entry is: %s" % (decoder))
         print("Decode Table is:\n%s" % (table))
-        return False
+        raise(Exception("unknown event"))
     else:
         return decoder.fn(decoder.eid, decoder.name, dumpfile)
 
@@ -125,7 +126,7 @@ def print_event(eid, name, string=None, event_count=None):
 def decode_unimp(eid, name, _unused_dumpfile):
     "Unimplemented decoder, will trigger exit"
     print("%s not handled - will now stop" % (name))
-    return False
+    raise(Exception("unhandled event"))
 
 def decode_plain(eid, name, _unused_dumpfile):
     "Plain events without additional data"
@@ -439,6 +440,7 @@ def decode_file(filename):
                                     dumpfile)
     except Exception as inst:
         print(f"error {inst}")
+        sys.exit(1)
 
     finally:
         print(f"Reached {dumpfile.tell()} of {dumpsize} bytes")
diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 10d99403a4..9b3ee6726b 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -13,6 +13,7 @@
 import shutil
 import logging
 import time
+import subprocess
 
 from avocado import skip
 from avocado import skipUnless
@@ -22,6 +23,11 @@
 from avocado.utils import process
 from boot_linux_console import LinuxKernelTest
 
+from pathlib import Path
+
+self_dir = Path(__file__).parent
+src_dir = self_dir.parent.parent
+
 class ReplayKernelBase(LinuxKernelTest):
     """
     Boots a Linux kernel in record mode and checks that the console
@@ -63,6 +69,8 @@ def run_vm(self, kernel_path, kernel_command_line, console_pattern,
             vm.shutdown()
             logger.info('finished the recording with log size %s bytes'
                         % os.path.getsize(replay_path))
+            self.run_replay_dump(replay_path)
+            logger.info('successfully tested replay-dump.py')
         else:
             vm.wait()
             logger.info('successfully finished the replay')
@@ -70,6 +78,14 @@ def run_vm(self, kernel_path, kernel_command_line, console_pattern,
         logger.info('elapsed time %.2f sec' % elapsed)
         return elapsed
 
+    def run_replay_dump(self, replay_path):
+        try:
+            subprocess.check_call(["./scripts/replay-dump.py",
+                                   "-f", replay_path],
+                                  cwd=src_dir, stdout=subprocess.DEVNULL)
+        except subprocess.CalledProcessError:
+            self.fail('replay-dump.py failed')
+
     def run_rr(self, kernel_path, kernel_command_line, console_pattern,
                shift=7, args=None):
         replay_path = os.path.join(self.workdir, 'replay.bin')
diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index f3a43dc98c..dd148ff639 100644
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
@@ -94,6 +100,8 @@ def launch_and_wait(self, record, args, shift):
             vm.shutdown()
             logger.info('finished the recording with log size %s bytes'
                 % os.path.getsize(replay_path))
+            self.run_replay_dump(replay_path)
+            logger.info('successfully tested replay-dump.py')
         else:
             vm.event_wait('SHUTDOWN', self.timeout)
             vm.wait()
@@ -108,6 +116,14 @@ def run_rr(self, args=None, shift=7):
         logger = logging.getLogger('replay')
         logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
 
+    def run_replay_dump(self, replay_path):
+        try:
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
2.42.0


