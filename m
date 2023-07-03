Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66693745BD2
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 14:05:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGIHd-0001od-41; Mon, 03 Jul 2023 08:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGIHZ-0001jr-J6; Mon, 03 Jul 2023 08:03:53 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGIHX-0003YW-PG; Mon, 03 Jul 2023 08:03:53 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b7206f106cso3364301a34.1; 
 Mon, 03 Jul 2023 05:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688385829; x=1690977829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H5NUNFE+EU3Pgyk+pvL+VmpnC5N+XQRe75iRJQPkSCo=;
 b=O+eBW6h10njXuKmBBRS+B2Ja2wIpfRccC3qsMXI/wrAm7Z0UyXZMgfTBpHmO9u75w0
 UzhQ7xUJweCiQHUCTPOzdyF2zA6HRj40uv90hg8WD5jMqBG+QuGJ5KkTjtruBzBQWPad
 d/IbMXTUt3+N08X4wXVMHvRPliqeXfOu4z4wvUYNpGfl2bJ2w2hYWApCCh417nhIrJlA
 OVzXzUDonaQDWcNuvJON8V2iv5FPv+/NEG+U+k5BYk5M23O0u9fYIA4/NYjN1jQt+g4R
 ouQQruU3NLjTblX18VY8dyHTJomzTtqLe2PdmjZojc0o7V1Xo/gRIQMnlEJ8nIEW2QTx
 +3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688385829; x=1690977829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H5NUNFE+EU3Pgyk+pvL+VmpnC5N+XQRe75iRJQPkSCo=;
 b=BmvqGzp35VmgL+48vkclsJS61riVprrjbTUukaPr25MFrkJThSo8ABplN+xUwuJAxo
 nVHddhGZiUPQsVunWiD+vL7nZKXwiWlmZJPt/mwg/dA9eyqTJVlZqSxd+CBmgRU2yBAa
 L/vq330GK5f6VYUe/5PZ6cmWMu54+xJJ4zSzhCCTJUNqdrIn42T5eeSZTk4mVRA70del
 8yG/C/ZdAmg5B7Nf0S6HIphEMeusz2lXnogTvtkBtJoob5W5fNk7lXruefWqzVNyQxR3
 jHiRjZl7mnPlNFWD9NTXjbuQOykBLbe2RRgbqa4KiN3v0D/quLWS5bgz1Wb9WF/ggx3p
 3A3w==
X-Gm-Message-State: AC+VfDzNYAaffvKAgoWlU9Cp/OA0Abz0rAYrkhfJBlNxJ8cEue3EWQqh
 SPZptzLXZCmNCW7l7KxiolO5pMs9T9M=
X-Google-Smtp-Source: ACHHUZ5zhIUR2u35/VgfhapMhpGQTAdPl2zLnSjmZ+BMM9VUgLdIjwQPvBOyyhUAHQBJNSBfrJOxOA==
X-Received: by 2002:a9d:65d8:0:b0:6b7:206e:edf7 with SMTP id
 z24-20020a9d65d8000000b006b7206eedf7mr8152804oth.1.1688385829599; 
 Mon, 03 Jul 2023 05:03:49 -0700 (PDT)
Received: from wheely.local0.net ([118.210.96.60])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a63e64f000000b0051b0e564963sm14891408pgj.49.2023.07.03.05.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 05:03:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3] target/ppc: Make checkstop actually stop the system
Date: Mon,  3 Jul 2023 22:03:39 +1000
Message-Id: <20230703120340.45349-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x32c.google.com
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

checkstop state does not halt the system, interrupts continue to be
serviced, and other CPUs run. Stop the machine with
qemu_system_guest_panicked.

Change the logging not to print separately to stderr because a
checkstop is a guest error (or perhaps a simulated machine error)
rather than a QEMU error. CPU registers are dumped.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Since v1:
- Fix loop exit so it stops on the checkstop-causing instruction, rather than
  after it.

Since v2:
- Rebase on ppc-next.
- Use qemu_system_guest_panicked rather than vm_stop (Richard)
- Move away from printing to stderr (Zoltan)
- Reduce changes to log messages.
- Split out from larger series since it's independent (will skip attn
  instruction for now).
---
 target/ppc/excp_helper.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index e49e13a30d..a588285ef1 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
+#include "sysemu/runstate.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "internal.h"
@@ -427,20 +428,29 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
 static void powerpc_mcheck_checkstop(CPUPPCState *env)
 {
     CPUState *cs = env_cpu(env);
+    FILE *f;
 
     if (FIELD_EX64(env->msr, MSR, ME)) {
         return;
     }
 
-    /* Machine check exception is not enabled. Enter checkstop state. */
-    fprintf(stderr, "Machine check while not allowed. "
-            "Entering checkstop state\n");
-    if (qemu_log_separate()) {
-        qemu_log("Machine check while not allowed. "
-                 "Entering checkstop state\n");
+    /*
+     * This stops the machine and logs CPU state without killing QEMU
+     * (like cpu_abort()) so the machine can still be debugged (because
+     * it is often a guest error).
+     */
+
+    f = qemu_log_trylock();
+    if (f) {
+        fprintf(f, "Machine check while not allowed. "
+                "Entering checkstop state.\n");
+        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
+        qemu_log_unlock(f);
     }
-    cs->halted = 1;
-    cpu_interrupt_exittb(cs);
+
+    qemu_system_guest_panicked(NULL);
+
+    cpu_loop_exit_noexc(cs);
 }
 
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
-- 
2.40.1


