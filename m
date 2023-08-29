Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E0078C97F
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:19:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1Nq-00058y-ND; Tue, 29 Aug 2023 12:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1Ng-0004uO-9t
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:53 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NT-0004Pa-7c
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso29005845e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693325732; x=1693930532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWAw3yoUeeJNMPe6CX9phpQMFB1kiw2oQRZp+zWhjgY=;
 b=tSHJ2RHunsRg7Clom3CMqvc0+KPdhsEyi4+oGGI2r+RCvogE0b8MVB0zUaVblz6aq3
 8PouThfWdLySns7ER3elFHDZf7BsZ2dtjCjzynA/zGLrZjf8fRtWuLNY4ZOelhVBcam9
 sXG4WoWEc6ZqADMhtYjNgtZ3kl+QjR51OnuEPZbSuX8e+qBIpj7Gch8AhOPgvAN6yBUK
 2X/rI25KwoX4bNBfEH4K/f0MZSSykyPuztQ8sjCE1I8uSwPmvzCQHCKh73+hZkpWE++y
 3AXyrv4fIHFico+AYW51WSUAU8/lj9NtefbQJzs+AqBCoQH4mivXvc6BoePgG+Qpo8/i
 jvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693325732; x=1693930532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWAw3yoUeeJNMPe6CX9phpQMFB1kiw2oQRZp+zWhjgY=;
 b=LkP2ZMJ/fSIboRlP2EiLPq9hwvxGZ7gjYLFFx4MUqYFHm5CmLnHLF2I0B/Pdcy1XdJ
 D4GQiskgwhjQhVlGfpuixzldZDAotB6Ho5N2WVuwfopLqFXyWIplIpAI1GJmPW8IVr+X
 HDROovyu7OEnLEZYM4pQQHDWci+UtcFDU1vHhw1tYBJyYuLoLakesNZ+0Dfaoev5G04+
 QY1MEoQWqskGpk3p60iv43ChlamobiTvCPQ/H5hMKkLHutsH5oFCXEgF7ZDepQjAUnau
 j7cvuzvXP/iwpKNXwKBwSBUwvGvcj73GsxWGxSoydEj9wSNNnhs21QNR/eP+9y4QEF/2
 Z5gw==
X-Gm-Message-State: AOJu0YyngDWHPCsNpE2B0eg1XZwUAJWfq+vJ+KXZ2LS5h8DpiOhLvBfE
 jBxq5DzdcagXDwSd3b6HB3e/zw==
X-Google-Smtp-Source: AGHT+IHIIVld0NGumENqoIVw7lJuZM/9oSP/UdxYa20tmtv2DnEvVWPG2c0t7OHbW/mGDvSGl6Utlg==
X-Received: by 2002:a1c:6a11:0:b0:3fb:416d:7324 with SMTP id
 f17-20020a1c6a11000000b003fb416d7324mr2446803wmc.6.1693325732031; 
 Tue, 29 Aug 2023 09:15:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m24-20020a7bca58000000b00401b242e2e6sm15458189wml.47.2023.08.29.09.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 09:15:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D68671FFC1;
 Tue, 29 Aug 2023 17:15:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Juan Quintela <quintela@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 06/12] tests: remove test-gdbstub.py
Date: Tue, 29 Aug 2023 17:15:22 +0100
Message-Id: <20230829161528.2707696-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829161528.2707696-1-alex.bennee@linaro.org>
References: <20230829161528.2707696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

This isn't directly called by our CI and because it doesn't run via
our run-test.py script does things slightly differently. Lets remove
it as we have plenty of working in-tree tests now for various aspects
of gdbstub.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/guest-debug/test-gdbstub.py | 177 ------------------------------
 1 file changed, 177 deletions(-)
 delete mode 100644 tests/guest-debug/test-gdbstub.py

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


