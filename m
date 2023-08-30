Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0B078D6AD
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:55:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMaJ-0001CM-P8; Wed, 30 Aug 2023 10:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaG-0001AM-63
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:16 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaC-0000jw-HZ
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fef56f7223so51457115e9.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407251; x=1694012051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUJU7I/ZCoEcB3CxWQsoadwO8esnJuOP81/I/ouJ2ZE=;
 b=Ak/g7ZxG26UCmJViIpR7uKdc3arGt36xDIKI1JiK0hgyAh8UVFvDPPYP5I2gjRSARw
 LfuDLJGfpr1eFrTGGNI8jtzU4gAMkEPudMFwO3K1R6j7d1Ny2mQ5GqsSLNc2za+OFV2Z
 OvW/7lmVG9ReyJPM9MpdhRZwYo1xncRmlK/V4RrVNP77tSP6BzWjb1Ll9xLusyA1q/cG
 Iw6syV6YsphKaAWjDlZmW8GlbgfvT6MhwOxxauvC2KOucBsshWvVD0aLDQ06xw8/+t8I
 h7oFAbhS82DznzOu1nygcu7bAQP0tpX8M2OJpzxXsKrPGson5tT4JM2Drh3whWwFpWgm
 dTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407251; x=1694012051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RUJU7I/ZCoEcB3CxWQsoadwO8esnJuOP81/I/ouJ2ZE=;
 b=PlwlYdL7JbtNbJWh59KVHJ8EhkjcQFeiLRnlv2n1g0ZVaoZRlRIQJP6oMcPFG/sGya
 LOrwHhCr4aIeDMJaj1C8SzhWk1stNqSh5brJujbfQ6/hO9Q7cLaOzioF5+0qzIP4eGSy
 2X3pKoLWDHBQsdz28xXxUOAweAw9I+rCvZuHxmqLdJn9OsK9/3LP0EE1JG57NUDWkvOp
 yfT2F72VsQFdnJ8jTf0nYqjCIdJHLmabS1D+y+Vo8LMlvRhBlV7Cs3raTHymplrI4o1U
 NkWcZSrRybB99OPPki7JsiGZLAWXowO+WkZRFVcsLzQDk9CJ59/DMqlTUFpk8hc39mWW
 3ufQ==
X-Gm-Message-State: AOJu0YzvW6/qaFKKUZCcs8aflv/P+lSArHOvIWw9xljZIN9qTOHLYIXe
 dOg7K0DTqdof8CHcV9v2Nibf+t5fGYGhirydLnw=
X-Google-Smtp-Source: AGHT+IFW1U2I5sw7ZNMpgf/z2mztkftJ0i0luA4ENeaOkKwkLoO4pcEf9UJ815ZX25/LhB1atYg40A==
X-Received: by 2002:a7b:c389:0:b0:401:b705:ebea with SMTP id
 s9-20020a7bc389000000b00401b705ebeamr2301291wmj.12.1693407251067; 
 Wed, 30 Aug 2023 07:54:11 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a5d664a000000b0031c79de4d8bsm16858223wrw.106.2023.08.30.07.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:54:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3A4EC1FFC1;
 Wed, 30 Aug 2023 15:54:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/12] tests: remove test-gdbstub.py
Date: Wed, 30 Aug 2023 15:54:01 +0100
Message-Id: <20230830145407.3064249-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830145407.3064249-1-alex.bennee@linaro.org>
References: <20230830145407.3064249-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

This isn't directly called by our CI and because it doesn't run via
our run-test.py script does things slightly differently. Lets remove
it as we have plenty of working in-tree tests now for various aspects
of gdbstub.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230829161528.2707696-7-alex.bennee@linaro.org>

diff --git a/tests/guest-debug/test-gdbstub.py b/tests/guest-debug/test-gdbstub.py
deleted file mode 100644
index 98a5df4d42..0000000000
--- a/tests/guest-debug/test-gdbstub.py
+++ /dev/null
@@ -1,177 +0,0 @@
-#
-# This script needs to be run on startup
-# qemu -kernel ${KERNEL} -s -S
-# and then:
-# gdb ${KERNEL}.vmlinux -x ${QEMU_SRC}/tests/guest-debug/test-gdbstub.py
-
-import gdb
-
-failcount = 0
-
-
-def report(cond, msg):
-    "Report success/fail of test"
-    if cond:
-        print ("PASS: %s" % (msg))
-    else:
-        print ("FAIL: %s" % (msg))
-        global failcount
-        failcount += 1
-
-
-def check_step():
-    "Step an instruction, check it moved."
-    start_pc = gdb.parse_and_eval('$pc')
-    gdb.execute("si")
-    end_pc = gdb.parse_and_eval('$pc')
-
-    return not (start_pc == end_pc)
-
-
-def check_break(sym_name):
-    "Setup breakpoint, continue and check we stopped."
-    sym, ok = gdb.lookup_symbol(sym_name)
-    bp = gdb.Breakpoint(sym_name)
-
-    gdb.execute("c")
-
-    # hopefully we came back
-    end_pc = gdb.parse_and_eval('$pc')
-    print ("%s == %s %d" % (end_pc, sym.value(), bp.hit_count))
-    bp.delete()
-
-    # can we test we hit bp?
-    return end_pc == sym.value()
-
-
-# We need to do hbreak manually as the python interface doesn't export it
-def check_hbreak(sym_name):
-    "Setup hardware breakpoint, continue and check we stopped."
-    sym, ok = gdb.lookup_symbol(sym_name)
-    gdb.execute("hbreak %s" % (sym_name))
-    gdb.execute("c")
-
-    # hopefully we came back
-    end_pc = gdb.parse_and_eval('$pc')
-    print ("%s == %s" % (end_pc, sym.value()))
-
-    if end_pc == sym.value():
-        gdb.execute("d 1")
-        return True
-    else:
-        return False
-
-
-class WatchPoint(gdb.Breakpoint):
-
-    def get_wpstr(self, sym_name):
-        "Setup sym and wp_str for given symbol."
-        self.sym, ok = gdb.lookup_symbol(sym_name)
-        wp_addr = gdb.parse_and_eval(sym_name).address
-        self.wp_str = '*(%(type)s)(&%(address)s)' % dict(
-            type = wp_addr.type, address = sym_name)
-
-        return(self.wp_str)
-
-    def __init__(self, sym_name, type):
-        wp_str = self.get_wpstr(sym_name)
-        super(WatchPoint, self).__init__(wp_str, gdb.BP_WATCHPOINT, type)
-
-    def stop(self):
-        end_pc = gdb.parse_and_eval('$pc')
-        print ("HIT WP @ %s" % (end_pc))
-        return True
-
-
-def do_one_watch(sym, wtype, text):
-
-    wp = WatchPoint(sym, wtype)
-    gdb.execute("c")
-    report_str = "%s for %s (%s)" % (text, sym, wp.sym.value())
-
-    if wp.hit_count > 0:
-        report(True, report_str)
-        wp.delete()
-    else:
-        report(False, report_str)
-
-
-def check_watches(sym_name):
-    "Watch a symbol for any access."
-
-    # Should hit for any read
-    do_one_watch(sym_name, gdb.WP_ACCESS, "awatch")
-
-    # Again should hit for reads
-    do_one_watch(sym_name, gdb.WP_READ, "rwatch")
-
-    # Finally when it is written
-    do_one_watch(sym_name, gdb.WP_WRITE, "watch")
-
-
-class CatchBreakpoint(gdb.Breakpoint):
-    def __init__(self, sym_name):
-        super(CatchBreakpoint, self).__init__(sym_name)
-        self.sym, ok = gdb.lookup_symbol(sym_name)
-
-    def stop(self):
-        end_pc = gdb.parse_and_eval('$pc')
-        print ("CB: %s == %s" % (end_pc, self.sym.value()))
-        if end_pc == self.sym.value():
-            report(False, "Hit final catchpoint")
-
-
-def run_test():
-    "Run through the tests one by one"
-
-    print ("Checking we can step the first few instructions")
-    step_ok = 0
-    for i in range(3):
-        if check_step():
-            step_ok += 1
-
-    report(step_ok == 3, "single step in boot code")
-
-    print ("Checking HW breakpoint works")
-    break_ok = check_hbreak("kernel_init")
-    report(break_ok, "hbreak @ kernel_init")
-
-    # Can't set this up until we are in the kernel proper
-    # if we make it to run_init_process we've over-run and
-    # one of the tests failed
-    print ("Setup catch-all for run_init_process")
-    cbp = CatchBreakpoint("run_init_process")
-    cpb2 = CatchBreakpoint("try_to_run_init_process")
-
-    print ("Checking Normal breakpoint works")
-    break_ok = check_break("wait_for_completion")
-    report(break_ok, "break @ wait_for_completion")
-
-    print ("Checking watchpoint works")
-    check_watches("system_state")
-
-#
-# This runs as the script it sourced (via -x)
-#
-
-try:
-    print ("Connecting to remote")
-    gdb.execute("target remote localhost:1234")
-
-    # These are not very useful in scripts
-    gdb.execute("set pagination off")
-    gdb.execute("set confirm off")
-
-    # Run the actual tests
-    run_test()
-
-except:
-    print ("GDB Exception: %s" % (sys.exc_info()[0]))
-    failcount += 1
-    import code
-    code.InteractiveConsole(locals=globals()).interact()
-    raise
-
-# Finally kill the inferior and exit gdb with a count of failures
-gdb.execute("kill")
-exit(failcount)
-- 
2.39.2


