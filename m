Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 657867875B5
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:42:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDMq-0006QP-Am; Thu, 24 Aug 2023 12:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMn-0006O8-SX
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:29 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMb-00087U-GD
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:29 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fed6c2a5cfso59323045e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692895156; x=1693499956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3HpoGymUAOECIzpXws+SoFW7NCUK3OvK2CLae4WjpQ=;
 b=g1OWyylXHUniLRMmrogJ5c+EJkbvWWpazU6rgmjIIKnC0ENMBE5QYApg7ayL/QTvqP
 CRAHdUMU4AheXY+wcDGpPPOOfPJp9GSIQZPwKM+pCwNCMb9d4vZD0MOdPTQYhUKLTJyJ
 o04vKz/MJjvnmA+wpZpa2q/oB5a3oe4+a1MPR048yV+o08IIllVkcWXEkq2s3YkJ6YTr
 gkcadQJxkOZ39Xoco4pplQqemoKHZUEIdoDZZQN50kdqaBdWgMO+D4Ml9Q2xuIQHJpGi
 jp6Rh0y8SUOuFw9vytPt0MAAeBVJdv8BqdxsqIOe1n350FgWkrErRRKxM6k6GKL7JPvL
 JHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692895156; x=1693499956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M3HpoGymUAOECIzpXws+SoFW7NCUK3OvK2CLae4WjpQ=;
 b=Ei9OZaLSslZMFUTaAwSulAjwuGYRcCqdLdds2j7o1hwlKdaTBRvLcv+HKeHmv9Inj2
 uRA0Vh3ZcIZ3JBANG3KbVd7a3NM4Iukg1dQtVF4pwj9HzVw54NyEf3iEs45C/sw6ApHM
 PaIbK1a+X4idx06w7/xc9E1fTOAO3dwle6Hwm66Rw1EWHMOCkTM3/AfQq29LfJyTHxau
 Zzrh4MbxfDtvRn7Gfl8Djc33OGdCL/4ScKoyeRTsRPlGskreCZ23WBWFAdU9COcPD6N7
 nzbjjKpnq5CHCH9AX5v5Nc6ydzqClPddE8X86NwYVqn05MoNm10zwRI8g8+bOoSkIz2L
 wj7A==
X-Gm-Message-State: AOJu0YyR+iIZcMG+z28K4wU60iDCzVQijqhVt+TxmCi86lQo0kPqEy7r
 JCeL6mJFgIq7GFRIGmNALFWFhA==
X-Google-Smtp-Source: AGHT+IFrKtMSWx+uF1j+/YmPA90KQnL/2RkaBo7ne8fODjZdgErheH8IrlmxCnAY0zm1NO4LJWNA7w==
X-Received: by 2002:a05:600c:2291:b0:3f9:b8df:26ae with SMTP id
 17-20020a05600c229100b003f9b8df26aemr12135286wmf.34.1692895155856; 
 Thu, 24 Aug 2023 09:39:15 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a05600c00c200b003fe17901fcdsm3091345wmm.32.2023.08.24.09.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:39:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 35BC01FFC3;
 Thu, 24 Aug 2023 17:39:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Matheus Branco Borella <dark.ryu.550@gmail.com>
Subject: [PATCH v2 08/12] gdbstub: fixes cases where wrong threads were
 reported to GDB on SIGINT
Date: Thu, 24 Aug 2023 17:39:06 +0100
Message-Id: <20230824163910.1737079-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824163910.1737079-1-alex.bennee@linaro.org>
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1725

---
v2
  - fix up some whitespace
---
 gdbstub/gdbstub.c                             | 29 ++++++
 tests/tcg/multiarch/system/interrupt.c        | 28 ++++++
 tests/tcg/multiarch/gdbstub/interrupt.py      | 97 +++++++++++++++++++
 .../multiarch/system/Makefile.softmmu-target  | 12 ++-
 4 files changed, 164 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/multiarch/system/interrupt.c
 create mode 100644 tests/tcg/multiarch/gdbstub/interrupt.py

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


