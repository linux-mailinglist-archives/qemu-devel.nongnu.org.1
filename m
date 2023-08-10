Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60862777CA6
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7tZ-00013K-Jl; Thu, 10 Aug 2023 11:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU7tS-0000vL-R2
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:48:10 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU7tO-0005ta-LH
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:48:10 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-686fc0d3c92so788842b3a.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691682484; x=1692287284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=31QcrEnKIPElQsGKjnVGAqCQNo3S4RsklQmlCnbkjy0=;
 b=ZN+eep8+TEvVFC3AHcWnDimj0n/1A8sImpwHFzGhcNil9j3y0V9gYDM1ycPbBrbK5g
 bialK8qvZx1elP/zG5Q3kJf7VJfmnIjYZLNJEzcg79PMUKS6OlDRE6t3FkBC3WbV+Kfv
 WukrYrPWjAX114KecXyZ8FwKptK7k18IWMADuhln4ypoyenHophSeWte1QQ7XmSKgE98
 Vtx1y4VPALgGiD8bwpRZCwBf6qtomBvbCq/d2u35EcJqYuzJunnoW7RB0xu0WAsi6axZ
 kXheeKtUwrY1FqjqjxKf+cjZ4L/JgL4Q3w2ktbKTgCldPBevA+ZAtbeoF+C6zfoUHdC3
 /yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691682484; x=1692287284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=31QcrEnKIPElQsGKjnVGAqCQNo3S4RsklQmlCnbkjy0=;
 b=TC+7lg2+j7ykIAF8F14qfhWLnN487ATs9VCxeYUv7PRFK390VunGvD/5Xw2EBEoKEd
 wUVgsnyeUunliwpaO9oLhSsEagRETne1OCfDhJz80P+DDF2Knadq8DdKxSywkgqSROAv
 Ak9H14y/aEfjYkb+QPlvHXjEptIpAGBdz+3RxT/JDegJOImzpe1rQboGObi6D+xpbuno
 bU5KylcWM8GispNVko1vSph6zyPRA4wZELBThL9nxOkZ/yBT+MvD/B/DFE6MvqZPd2jK
 cJs6ZubEXa9wDb/heecAwDSSrLxVuK4ojrav3jOB5qKaF4ordSUgczhyFEwjyCKnMDYW
 46gg==
X-Gm-Message-State: AOJu0Yy26BOJ7UZiTA2+4jwGPZeSOqQeHUoanQrK0T0i6org8KOwceWj
 LPlaJ7SZa0AXmlRffXoBkd+Aj2CaUNPNsCug5Jw=
X-Google-Smtp-Source: AGHT+IFdgAbqj4u4nT4Taw383CA3wiGZ82R5kFr3g7phAayEFe35VkKHF/2B+1GE7NoQYHXMt+/Cdw==
X-Received: by 2002:a05:6a00:a1f:b0:67a:a4d1:e70 with SMTP id
 p31-20020a056a000a1f00b0067aa4d10e70mr3051928pfh.16.1691682484366; 
 Thu, 10 Aug 2023 08:48:04 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a056a00270300b00682b299b6besm1692231pfv.70.2023.08.10.08.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 08:48:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH for-8.1] accel/tcg: Avoid reading too much in load_atom_{2,4}
Date: Thu, 10 Aug 2023 08:48:02 -0700
Message-Id: <20230810154802.16663-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

When load_atom_extract_al16_or_al8 is inexpensive, we want to use
it early, in order to avoid the overhead of required_atomicity.
However, we must not read past the end of the page.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

This should solve the problem that Mark reported for m68k.  In his
system-mode scenario, we would need a tlb fault on the final 7 bytes
of the final page of system ram.

With aarch64 FEAT_LSE2 I can create an internal alignment fault that
leads to the same code path -- the test case fails before the fix.


r~

---
 tests/tcg/aarch64/lse2-fault.c    | 38 +++++++++++++++++++++++++++++++
 accel/tcg/ldst_atomicity.c.inc    | 10 ++++++--
 tests/tcg/aarch64/Makefile.target |  2 +-
 3 files changed, 47 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/aarch64/lse2-fault.c

diff --git a/tests/tcg/aarch64/lse2-fault.c b/tests/tcg/aarch64/lse2-fault.c
new file mode 100644
index 0000000000..2187219a08
--- /dev/null
+++ b/tests/tcg/aarch64/lse2-fault.c
@@ -0,0 +1,38 @@
+#include <sys/mman.h>
+#include <sys/shm.h>
+#include <unistd.h>
+#include <stdio.h>
+
+int main()
+{
+    int psize = getpagesize();
+    int id;
+    void *p;
+
+    /*
+     * We need a shared mapping to enter CF_PARALLEL mode.
+     * The easiest way to get that is shmat.
+     */
+    id = shmget(IPC_PRIVATE, 2 * psize, IPC_CREAT | 0600);
+    if (id < 0) {
+        perror("shmget");
+        return 2;
+    }
+    p = shmat(id, NULL, 0);
+    if (p == MAP_FAILED) {
+        perror("shmat");
+        return 2;
+    }
+
+    /* Protect the second page. */
+    if (mprotect(p + psize, psize, PROT_NONE) < 0) {
+        perror("mprotect");
+        return 2;
+    }
+
+    /*
+     * Load 4 bytes, 6 bytes from the end of the page.
+     * On success this will load 0 from the newly allocated shm.
+     */
+    return *(int *)(p + psize - 6);
+}
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index e5c590a499..5d92485a49 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -404,7 +404,10 @@ static uint16_t load_atom_2(CPUArchState *env, uintptr_t ra,
         return load_atomic2(pv);
     }
     if (HAVE_ATOMIC128_RO) {
-        return load_atom_extract_al16_or_al8(pv, 2);
+        intptr_t left_in_page = pi | TARGET_PAGE_MASK;
+        if (likely(left_in_page <= -16)) {
+            return load_atom_extract_al16_or_al8(pv, 2);
+        }
     }
 
     atmax = required_atomicity(env, pi, memop);
@@ -443,7 +446,10 @@ static uint32_t load_atom_4(CPUArchState *env, uintptr_t ra,
         return load_atomic4(pv);
     }
     if (HAVE_ATOMIC128_RO) {
-        return load_atom_extract_al16_or_al8(pv, 4);
+        intptr_t left_in_page = pi | TARGET_PAGE_MASK;
+        if (likely(left_in_page <= -16)) {
+            return load_atom_extract_al16_or_al8(pv, 4);
+        }
     }
 
     atmax = required_atomicity(env, pi, memop);
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 617f821613..681dfa077c 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -9,7 +9,7 @@ AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
 VPATH 		+= $(AARCH64_SRC)
 
 # Base architecture tests
-AARCH64_TESTS=fcvt pcalign-a64
+AARCH64_TESTS=fcvt pcalign-a64 lse2-fault
 
 fcvt: LDFLAGS+=-lm
 
-- 
2.34.1


