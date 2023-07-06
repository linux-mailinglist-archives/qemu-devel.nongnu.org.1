Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2309B74A7EC
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 01:52:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHYk7-0002yz-9w; Thu, 06 Jul 2023 19:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dark.ryu.550@gmail.com>)
 id 1qHYk4-0002yh-Sa
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 19:50:32 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dark.ryu.550@gmail.com>)
 id 1qHYk2-0007Vl-Pn
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 19:50:32 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-557790487feso962674a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 16:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688687429; x=1691279429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V36dzBbMjgTcATbh5oHkXI8oRz0KP+hebxmkdrmyx7A=;
 b=syi45leXzsO/u+7oZhNxP8mm7ogU/vfQbwODfs9VxaPwRo5jfmQY9kXXGRAOvneu+7
 Rwxofjmge/xrHul+ZdKvqjbZOLVrhke1DUrEJLqvPYryeOmnnO6AqsQ2NqSAl71/09zd
 Bnd99UPzs0t3luJo62SPbz0vK0LIYOWY5YYzglk+ELuWpPdVQT+Vx1tWqmnNOCmzyEva
 TnRs+ynB+TchvYEbn4fzhI3CrkhpH0eTXX+cKInPYPq2Q7eGWaUqC7iVCkGXvKezy6yM
 XwVptWecoP3T4aLv+gKZYPibl0vq5cEEYbN1PmufKdEEwngMaOPF3nhJ8/kfl4pcW1My
 svOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688687429; x=1691279429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V36dzBbMjgTcATbh5oHkXI8oRz0KP+hebxmkdrmyx7A=;
 b=hpkddTk4Q5GiAjeVkkelzdhFzRQ/2XNGSoXINvVD/0/kulGpvUDcQB6TISZEFXWgQ1
 wjt1OkDtRY4Sy8i1S1R7tsqT8IlSNRVpZEyqkbSiEUEAg64FE896UJsVlzl8Ci8GyKYu
 3Hc0t+uKGg3ptVMJeJQJLQ9m976z1XsQEm4GslvXQWZHd8V35jYjOGmdGQCf1Gu4rbzw
 cx2XyyaYf27B5d/LtlHe9bFqcljhVxfoIylNoIJ8s9ZplgbNAuNf/gnXInDttTybH2Yy
 SAxF2um53yGreO721xam7aL8K9IUeJPL3Kr5I6mDovVlS9za9zPC4ma3cWbFSMVQfdOj
 tROQ==
X-Gm-Message-State: ABy/qLZ2f+Y8MkBl0j/PlNGMdiKJzsjwyHYFbK8U5unjvAoxWH6PPFfs
 i1e6qMmi/uVYjSU9smH+NQY=
X-Google-Smtp-Source: APBJJlESg+0Ai1Cw4xGnxODFP9Ygy7QIJKcnUqp7r+NVQbLopVtXgyyZqtOcV+VWhcAPFpRk5YBedQ==
X-Received: by 2002:a05:6a20:429f:b0:12f:6500:8504 with SMTP id
 o31-20020a056a20429f00b0012f65008504mr3892922pzj.46.1688687428432; 
 Thu, 06 Jul 2023 16:50:28 -0700 (PDT)
Received: from localhost.localdomain ([177.200.77.243])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a170902694600b001b246dcffb7sm1908430plt.300.2023.07.06.16.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 16:50:27 -0700 (PDT)
From: Matheus Branco Borella <dark.ryu.550@gmail.com>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	Matheus Branco Borella <dark.ryu.550@gmail.com>
Subject: [PATCH] gdbstub: fixes cases where wrong threads were reported to GDB
 on SIGINT
Date: Thu,  6 Jul 2023 20:50:08 -0300
Message-Id: <20230706235007.24527-1-dark.ryu.550@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <87y1k5yxiy.fsf@linaro.org>
References: <87y1k5yxiy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=dark.ryu.550@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
index 6911b73c07..6a5a400348 100644
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
index 0000000000..042d6fede9
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/interrupt.py
@@ -0,0 +1,99 @@
+from __future__ import print_function
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
index 0000000000..19fd831a5c
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
2.40.1


