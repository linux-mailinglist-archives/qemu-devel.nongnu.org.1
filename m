Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC6D7707F9
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 20:28:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRzWL-0005BY-9v; Fri, 04 Aug 2023 14:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dark.ryu.550@gmail.com>)
 id 1qRzWJ-0005B1-3N
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 14:27:27 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dark.ryu.550@gmail.com>)
 id 1qRzWG-0007pV-VZ
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 14:27:26 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6bcb5df95c5so1995058a34.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 11:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691173643; x=1691778443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cpgaui1aSX7sHKdB2dVBJ/m2ZUNWq+mfb48OaAKgo1M=;
 b=KihyStJMbX9IJZRACotLw3Ll9WwnVywR/j2+K0r9jmHrUZZVLhXnK6LjCsbYwhi2Xe
 WzO+97Z1Yzu3hmAKKiJ//bFUV9Xhc5X7tFKCdwh2pCu0lhdyAvKr9NpZKkDmWWO9lzv2
 Ly8kcm/KVSvi7lQCKu8zWtBLarjG7sbZm966Rnk1ApRRjVydls1LRtVlyBUW30Ule8K2
 Yuvuzx87jYcMI7jqIH6bSLysvxooYVItmOtvFMaBWnCyZd01UmGlbUYg6TSOkJM19r2i
 s6WyuROASiZ9bQn88eLJFNjiR3W8qHBc2vh1BAW3DP2etW2hKEKVjwZB1qGamcFNHFXc
 lUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691173643; x=1691778443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cpgaui1aSX7sHKdB2dVBJ/m2ZUNWq+mfb48OaAKgo1M=;
 b=gMhzB+NwnE2+AmXcGxScgW42qNMIhg/jkT+TbB9nUpAReifJNgw36PvLVsKkZS9r8G
 IF1DT5epz8C+nC2SkQMb2S1Z9j89227T0ehPde+sEcEjm7eYdwyUbaVU1znNYpqw9frQ
 IsKdE2VUpBYHBZmjdd+gXBsAifvnvpNooXcbZOY3LI2zkcJJS/y+BEZ5e6Ad2hM0t7VM
 Pq49CV5jvSohzV2JFpL23JkPt3O+pfHMlEdRppOU9sF9OOS++sTYZ9G7YVNp2OZsqorV
 f4Z8+ky4rKnUAKHhkMuSsLjZpaiF9+F7D3kqBVdh/1mS7RIxZkZvMEbqGu2TVY1j/iwX
 nIMQ==
X-Gm-Message-State: AOJu0YwZX9AuZlnzpQIkBsW+s9hg8xyj6kymWIPgasKhifVjia7Pk0E3
 GB6I+ZJDbQdd3xsEWje16kHs3ndNNACd4KEH
X-Google-Smtp-Source: AGHT+IH51LgbaFdLTyQXss6s2FJ5U81Ev5cg0/obAOW2fY9augkawE1u7fSjH5HH/Pp2ummNWHXIjw==
X-Received: by 2002:a05:6830:1e85:b0:6b9:9dc3:5eb3 with SMTP id
 n5-20020a0568301e8500b006b99dc35eb3mr2603123otr.4.1691173642860; 
 Fri, 04 Aug 2023 11:27:22 -0700 (PDT)
Received: from localhost.localdomain ([177.200.70.162])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a9d624e000000b006b92509e76esm1448346otk.32.2023.08.04.11.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 11:27:22 -0700 (PDT)
From: Matheus Branco Borella <dark.ryu.550@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	Matheus Branco Borella <dark.ryu.550@gmail.com>
Subject: [PATCH v2] gdbstub: fixes cases where wrong threads were reported to
 GDB on SIGINT
Date: Fri,  4 Aug 2023 15:26:28 -0300
Message-ID: <20230804182633.47300-2-dark.ryu.550@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <87y1k5yxiy.fsf@linaro.org>
References: <87y1k5yxiy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=dark.ryu.550@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Alex Bennée <alex.bennee@linaro.org> writes:
> Can gdb switch which packet sequence it uses to halt and restart
> threads?

Yes, but the way it does it does not trigger the behavior I was concerned 
about. GDB falls back to the old sequence when either (1) the target does not
support the vCont command it's trying to send or (2) you step backwards. In both
cases, though, whenever it does fall back, it will first send an Hc packet 
before continuing or stepping, which means we won't ever see a sequence such as
["Hc", "vCont;c:*", "c"]. This means, in short, that, while the shortcoming does
exist in the code, GDB never actually triggers it.

> The test I would like see is pretty much your test case
> 
>  - load a multi-threaded program
>  - wait until threads running
>  - pause
>  - resume thread
>  - check resumed thread was the right one

What I have here should be pretty much that. 

Is there something else you think I'm missing?

---
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1725

This fix is implemented by having the vCont handler set the value of
`gdbserver_state.c_cpu` if any threads are to be resumed. The specific CPU
picked is arbitrarily from the ones to be resumed, but it should be okay, as all
GDB cares about is that it is a resumed thread.

Signed-off-by: Matheus Branco Borella <dark.ryu.550@gmail.com>
---
 gdbstub/gdbstub.c                             | 29 ++++++
 tests/tcg/multiarch/gdbstub/interrupt.py      | 99 +++++++++++++++++++
 .../multiarch/system/Makefile.softmmu-target  | 12 ++-
 tests/tcg/multiarch/system/interrupt.c        | 25 +++++
 4 files changed, 163 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/interrupt.py
 create mode 100644 tests/tcg/multiarch/system/interrupt.c

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 6911b73c07..5763399f8b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -597,6 +597,15 @@ static int gdb_handle_vcont(const char *p)
      *  or incorrect parameters passed.
      */
     res = 0;
+
+    /*
+     * target_count and last_target keep track of how many CPUs we are going to
+     * step or resume, and a pointer to the state structure of one of them,
+     * respectivelly
+     */
+    int target_count = 0;
+    CPUState *last_target = NULL;
+
     while (*p) {
         if (*p++ != ';') {
             return -ENOTSUP;
@@ -637,6 +646,9 @@ static int gdb_handle_vcont(const char *p)
             while (cpu) {
                 if (newstates[cpu->cpu_index] == 1) {
                     newstates[cpu->cpu_index] = cur_action;
+
+                    target_count++;
+                    last_target = cpu;
                 }
 
                 cpu = gdb_next_attached_cpu(cpu);
@@ -654,6 +666,9 @@ static int gdb_handle_vcont(const char *p)
             while (cpu) {
                 if (newstates[cpu->cpu_index] == 1) {
                     newstates[cpu->cpu_index] = cur_action;
+
+                    target_count++;
+                    last_target = cpu;
                 }
 
                 cpu = gdb_next_cpu_in_process(cpu);
@@ -671,11 +686,25 @@ static int gdb_handle_vcont(const char *p)
             /* only use if no previous match occourred */
             if (newstates[cpu->cpu_index] == 1) {
                 newstates[cpu->cpu_index] = cur_action;
+
+                target_count++;
+                last_target = cpu;
             }
             break;
         }
     }
 
+    /*
+     * if we're about to resume a specific set of CPUs/threads, make it so that
+     * in case execution gets interrupted, we can send GDB a stop reply with a
+     * correct value. it doesn't really matter which CPU we tell GDB the signal
+     * happened in (VM pauses stop all of them anyway), so long as it is one of
+     * the ones we resumed/single stepped here.
+     */
+    if (target_count > 0) {
+        gdbserver_state.c_cpu = last_target;
+    }
+
     gdbserver_state.signal = signal;
     gdb_continue_partial(newstates);
     return res;
diff --git a/tests/tcg/multiarch/gdbstub/interrupt.py b/tests/tcg/multiarch/gdbstub/interrupt.py
new file mode 100644
index 0000000000..0b0b5a30f6
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/interrupt.py
@@ -0,0 +1,99 @@
+from __future__ import print_function
+#
+# Test some of the softmmu debug features with the multiarch memory
+# test. It is a port of the original vmlinux focused test case but
+# using the "memory" test instead.
+#
+# This is launched via tests/guest-debug/run-test.py
+#
+
+import gdb
+import sys
+
+failcount = 0
+
+
+def report(cond, msg):
+    "Report success/fail of test"
+    if cond:
+        print("PASS: %s" % (msg))
+    else:
+        print("FAIL: %s" % (msg))
+        global failcount
+        failcount += 1
+
+def check_interrupt(thread):
+    """
+    Check that, if thread is resumed, we go back to the same thread when the
+    program gets interrupted.
+    """
+
+    # Switch to the thread we're going to be running the test in.
+    print("thread ", thread.num)
+    gdb.execute("thr %d" % thread.num)
+
+    # Enter the loop() function on this thread.
+    #
+    # While there are cleaner ways to do this, we want to minimize the number of
+    # side effects on the gdbstub's internal state, since those may mask bugs.
+    # Ideally, there should be no difference between what we're doing here and
+    # the program reaching the loop() function on its own.
+    #
+    # For this to be safe, we only need the prologue of loop() to not have
+    # instructions that may have problems with what we're doing here. We don't
+    # have to worry about anything else, as this function never returns.
+    gdb.execute("set $pc = loop")
+
+    # Continue and then interrupt the task.
+    gdb.post_event(lambda: gdb.execute("interrupt"))
+    gdb.execute("c")
+
+    # Check whether the thread we're in after the interruption is the same we
+    # ran continue from.
+    return (thread.num == gdb.selected_thread().num)
+
+def run_test():
+    """
+    Test if interrupting the code always lands us on the same thread when
+    running with scheduler-lock enabled.
+    """
+
+    gdb.execute("set scheduler-locking on")
+    for thread in gdb.selected_inferior().threads():
+        report(
+            check_interrupt(thread), 
+            "thread %d resumes correctly on interrupt" % thread.num)
+
+
+#
+# This runs as the script it sourced (via -x, via run-test.py)
+#
+try:
+    inferior = gdb.selected_inferior()
+    arch = inferior.architecture()
+    print("ATTACHED: %s" % arch.name())
+except (gdb.error, AttributeError):
+    print("SKIPPING (not connected)", file=sys.stderr)
+    exit(0)
+
+if gdb.parse_and_eval('$pc') == 0:
+    print("SKIP: PC not set")
+    exit(0)
+if len(gdb.selected_inferior().threads()) == 1:
+    print("SKIP: set to run on a single thread")
+    exit(0)
+
+try:
+	# These are not very useful in scripts
+	gdb.execute("set pagination off")
+
+	# Run the actual tests
+	run_test()
+except (gdb.error):
+    print("GDB Exception: %s" % (sys.exc_info()[0]))
+    failcount += 1
+    pass
+
+# Finally kill the inferior and exit gdb with a count of failures
+gdb.execute("kill")
+exit(failcount)
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
index fe40195d39..ad3b727ffc 100644
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
@@ -27,7 +27,15 @@ run-gdbstub-memory: memory
 		"-monitor none -display none -chardev file$(COMMA)path=$<.out$(COMMA)id=output $(QEMU_OPTS)" \
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/memory.py, \
 	softmmu gdbstub support)
-
+run-gdbstub-interrupt: interrupt
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(HAVE_GDB_BIN) \
+		--qemu $(QEMU) \
+		--output $<.gdb.out \
+		--qargs \
+		"-smp 2 -monitor none -display none -chardev file$(COMMA)path=$<.out$(COMMA)id=output $(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/interrupt.py, \
+	softmmu gdbstub support)
 run-gdbstub-untimely-packet: hello
 	$(call run-test, $@, $(GDB_SCRIPT) \
 		--gdb $(HAVE_GDB_BIN) \
@@ -50,4 +58,4 @@ run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb")
 endif
 
-MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-untimely-packet
+MULTIARCH_RUNS += run-gdbstub-memory run-gdbstub-interrupt run-gdbstub-untimely-packet
diff --git a/tests/tcg/multiarch/system/interrupt.c b/tests/tcg/multiarch/system/interrupt.c
new file mode 100644
index 0000000000..64899caf09
--- /dev/null
+++ b/tests/tcg/multiarch/system/interrupt.c
@@ -0,0 +1,25 @@
+/*
+ * External interruption test. This test is structured in such a way that it
+ * passes the cases that require it to exit, but we can make it enter an
+ * infinite loop from GDB.
+ *
+ * We don't have the benefit of libc, just builtin C primitives and
+ * whatever is in minilib.
+ */
+
+#include <minilib.h>
+
+void loop(void)
+{
+    while(1)
+        /* Loop forever. Just make sure the condition is always a constant
+         * expression, so that this loop is not UB, as per the C standard. */
+        ;
+}
+
+int main(void)
+{
+    return 0;
+}
+
+
-- 
2.41.0


