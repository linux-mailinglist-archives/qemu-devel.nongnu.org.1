Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C57A78D6B8
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:56:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMaK-0001CO-1T; Wed, 30 Aug 2023 10:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaI-0001Bd-5e
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:18 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaD-0000k9-QF
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:17 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c3df710bdso4532326f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407252; x=1694012052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xMHxg0y53JN4TLoRHDzXOhPXJYR1t6X3GOG4+zpqXU=;
 b=ACTcTJK8waim6t7kC7LAhybS2nHfY3+CHPg3h1Fnox6RRO6wo4BHdOR5oNFhBQB1kh
 m2S0xdCM6qchbv4R+YAbwbx7NqCBa1AsNnesklc6h1o1FIu+OlXfrBj3TY3rObxY+LCn
 ub2tGJYy36NXKKOOK48W6OKiZzKhUW8aX3mQZMhbUnL+t6nh7sIn7F5A67UTOBzDq5mf
 BXy7saqoDrog+lnlNQ/hzY3XSbA6uPggAw68JXlWhF6aQFrxLY/7C++3XgmNB+LbuTL1
 hx6E5RtKz9IA9U9DRUWmi87piWrl227LhqEK3VRmZhHPxX/Qufqz2YFL9ortJNkzDSol
 7L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407252; x=1694012052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xMHxg0y53JN4TLoRHDzXOhPXJYR1t6X3GOG4+zpqXU=;
 b=PaMIZxvQhNlRhQjcb1MjFJzxa3KYo6MIqJs5INPB0EvXpe15pb98MYOysZxiHmNIQa
 /Fef75WUo2wOzQKKHZpwvwouQ966g7/nFadm51en2eoIdKgyALbqeCuAZhOV/3YX1vjV
 xaKyxIIgQOXZDfvttoXBh/meoAdSrCIHHTkFzP9qPAWquGIgviqe0OedqAYbSAs8KCo8
 reBeJDAIbMsuwI8ce/bFUZlpZpzLimntjo7mjJ1k2GpzWLHjJk2WWOG8DCNKrsy3VLpQ
 0R3PEzp+rwjIN3oopKpgmKktMGCyYvm2OZSHoO6XK3Fuu73ngGSdjje0+xwfGbDsGJo9
 ALKA==
X-Gm-Message-State: AOJu0YwqmUdDIGlCQqjNLkKyw7iV48hOH88N6cpndSn+IhYgftuLerxd
 p8zmFHQnD7mROuALSsCoSKtotA==
X-Google-Smtp-Source: AGHT+IGM2JVAQc/eAyd2w39EKOV3zL7Xjw/h0y8qyIe9CGQZ1qNZvBC1j9NlF3Et2ygxLmgiUEeFaw==
X-Received: by 2002:adf:ea41:0:b0:319:7428:9caa with SMTP id
 j1-20020adfea41000000b0031974289caamr2313798wrn.38.1693407252372; 
 Wed, 30 Aug 2023 07:54:12 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a5d4bcd000000b003141e629cb6sm16730710wrt.101.2023.08.30.07.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:54:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 86DBE1FFBB;
 Wed, 30 Aug 2023 15:54:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matheus Branco Borella <dark.ryu.550@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/12] gdbstub: fixes cases where wrong threads were reported
 to GDB on SIGINT
Date: Wed, 30 Aug 2023 15:54:03 +0100
Message-Id: <20230830145407.3064249-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830145407.3064249-1-alex.bennee@linaro.org>
References: <20230830145407.3064249-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Matheus Branco Borella <dark.ryu.550@gmail.com>

This fix is implemented by having the vCont handler set the value of
`gdbserver_state.c_cpu` if any threads are to be resumed. The specific
CPU picked is arbitrarily from the ones to be resumed, but it should
be okay, as all GDB cares about is that it is a resumed thread.

Signed-off-by: Matheus Branco Borella <dark.ryu.550@gmail.com>
Message-Id: <20230804182633.47300-2-dark.ryu.550@gmail.com>
[AJB: style and whitespace fixes]
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1725
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230829161528.2707696-9-alex.bennee@linaro.org>

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 5f28d5cf57..e7d48fa0d4 100644
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
diff --git a/tests/tcg/multiarch/system/interrupt.c b/tests/tcg/multiarch/system/interrupt.c
new file mode 100644
index 0000000000..98d4f2eff9
--- /dev/null
+++ b/tests/tcg/multiarch/system/interrupt.c
@@ -0,0 +1,28 @@
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
+    do {
+        /*
+         * Loop forever. Just make sure the condition is always a constant
+         * expression, so that this loop is not UB, as per the C
+         * standard.
+         */
+    } while (1);
+}
+
+int main(void)
+{
+    return 0;
+}
+
+
diff --git a/tests/tcg/multiarch/gdbstub/interrupt.py b/tests/tcg/multiarch/gdbstub/interrupt.py
new file mode 100644
index 0000000000..e222ac94c5
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/interrupt.py
@@ -0,0 +1,97 @@
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
+
+def run_test():
+    """
+    Test if interrupting the code always lands us on the same thread when
+    running with scheduler-lock enabled.
+    """
+
+    gdb.execute("set scheduler-locking on")
+    for thread in gdb.selected_inferior().threads():
+        report(check_interrupt(thread),
+               "thread %d resumes correctly on interrupt" % thread.num)
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
+    # Run the actual tests
+    run_test()
+except (gdb.error):
+    print("GDB Exception: %s" % (sys.exc_info()[0]))
+    failcount += 1
+    pass
+
+# Finally kill the inferior and exit gdb with a count of failures
+gdb.execute("kill")
+exit(failcount)
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
index a051d689d7..90810a32b2 100644
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
-- 
2.39.2


