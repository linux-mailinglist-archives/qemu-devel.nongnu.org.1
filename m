Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A867476DB
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:37:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGj1E-0001Jv-Cz; Tue, 04 Jul 2023 12:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj1B-0001HU-L3
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:45 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj16-0001oQ-Dn
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:42 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3094910b150so6599627f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688488598; x=1691080598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1+5gA5Gx3OWByEd+ONnCyhPvuTERrBtfW0lccmJX71g=;
 b=dSmoL2fswgMTjD2+L8AJ+20j1hRoKmC22Sjds6uaji0DDPoluNBiOC13b0QT+MLcQf
 hW2k3zHcTqgkCojOSZv41VfNnWF5rOjx6hQchpCuOjTuCNgu+IIjZ4xGqes114gVl1Jo
 lNvxA7p0ebu7GHrSd2ZlA0d/Y8hjrR1FtObnYUi4JV89KncDEZm9ZJnZB/IZmsIDg51n
 Aw9pTmbdOjVX3MBL35cU4iO2B7paBXngGptVEXflmjx/lqynWfC44Lt9hy2ERcLluuQ+
 88JLmX1vav1iw4/vTZ3AkmdICEsX8wWW+2xYiYS17tIBtLCkvzhn8helBcTcBBnPrvhO
 yFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688488598; x=1691080598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1+5gA5Gx3OWByEd+ONnCyhPvuTERrBtfW0lccmJX71g=;
 b=gi27aB1pjgpB0PzJRTSsihjR9NT86pOjFPhVkLw6aHd8oX6uxl5pKOCSInzp7HfPXe
 j4VoSNRUJxDkaEuq4HJt1QVDNThADeKQmaoYN5UGiAY6EL4G/Y7WXclE3xRiFupZ3Czg
 gkPhc+G6tdxIpRw8xAKKvVceQEZip6kTq9TuRwoJL4Vhb/2sIx4h83XGWcZ2TtTEqERo
 A7EtiumYP3ShYntm1WQ5hiYSA3M11cMe+xWjz/cyjSfmvjSFJX7V/9KSSZ65oWfqRYlH
 N0YJ/IJQtxzpFhCC8TPVacEcHtvGGjIz0UwAKK7jg+4YMj1SX04XGLtXMpsM/TAbOON0
 kT5g==
X-Gm-Message-State: ABy/qLYQ6HpUWhBPXTPIgN4+nesloVmuEQ2YWNr3MUdsvoRI/fkqZxxL
 9xNvs+rHcKqCxdgnkmGhX1IVOXrXZWkOfE+lP8Q=
X-Google-Smtp-Source: APBJJlFoO85zAokrmnd3dAcy1j90IR902CV3vXpN2Ro3PK5EKmgUFeJ4TGQKC/h1B7PB1XijNvfzPw==
X-Received: by 2002:adf:ee0e:0:b0:313:f1c8:a963 with SMTP id
 y14-20020adfee0e000000b00313f1c8a963mr13082458wrn.2.1688488598759; 
 Tue, 04 Jul 2023 09:36:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b003143b032b7asm4354258wrx.116.2023.07.04.09.36.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 09:36:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/11] tests/tcg/aarch64: Add testcases for IC IVAU and
 dual-mapped code
Date: Tue,  4 Jul 2023 17:36:30 +0100
Message-Id: <20230704163634.3188465-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704163634.3188465-1-peter.maydell@linaro.org>
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: John Högberg <john.hogberg@ericsson.com>

https://gitlab.com/qemu-project/qemu/-/issues/1034

Signed-off-by: John Högberg <john.hogberg@ericsson.com>
Message-id: 168778890374.24232.3402138851538068785-2@git.sr.ht
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: fixed typo in comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/icivau.c        | 189 ++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |   3 +-
 2 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/icivau.c

diff --git a/tests/tcg/aarch64/icivau.c b/tests/tcg/aarch64/icivau.c
new file mode 100644
index 00000000000..77b9e98d5e5
--- /dev/null
+++ b/tests/tcg/aarch64/icivau.c
@@ -0,0 +1,189 @@
+/*
+ * Tests the IC IVAU-driven workaround for catching changes made to dual-mapped
+ * code that would otherwise go unnoticed in user mode.
+ *
+ * Copyright (c) 2023 Ericsson AB
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <string.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#define MAX_CODE_SIZE 128
+
+typedef int (SelfModTest)(uint32_t, uint32_t*);
+typedef int (BasicTest)(int);
+
+static void mark_code_modified(const uint32_t *exec_data, size_t length)
+{
+    int dc_required, ic_required;
+    unsigned long ctr_el0;
+
+    /*
+     * Clear the data/instruction cache, as indicated by the CTR_ELO.{DIC,IDC}
+     * flags.
+     *
+     * For completeness we might be tempted to assert that we should fail when
+     * the whole code update sequence is omitted, but that would make the test
+     * flaky as it can succeed by coincidence on actual hardware.
+     */
+    asm ("mrs %0, ctr_el0\n" : "=r"(ctr_el0));
+
+    /* CTR_EL0.IDC */
+    dc_required = !((ctr_el0 >> 28) & 1);
+
+    /* CTR_EL0.DIC */
+    ic_required = !((ctr_el0 >> 29) & 1);
+
+    if (dc_required) {
+        size_t dcache_stride, i;
+
+        /*
+         * Step according to the minimum cache size, as the cache maintenance
+         * instructions operate on the cache line of the given address.
+         *
+         * We assume that exec_data is properly aligned.
+         */
+        dcache_stride = (4 << ((ctr_el0 >> 16) & 0xF));
+
+        for (i = 0; i < length; i += dcache_stride) {
+            const char *dc_addr = &((const char *)exec_data)[i];
+            asm volatile ("dc cvau, %x[dc_addr]\n"
+                          : /* no outputs */
+                          : [dc_addr] "r"(dc_addr)
+                          : "memory");
+        }
+
+        asm volatile ("dmb ish\n");
+    }
+
+    if (ic_required) {
+        size_t icache_stride, i;
+
+        icache_stride = (4 << (ctr_el0 & 0xF));
+
+        for (i = 0; i < length; i += icache_stride) {
+            const char *ic_addr = &((const char *)exec_data)[i];
+            asm volatile ("ic ivau, %x[ic_addr]\n"
+                          : /* no outputs */
+                          : [ic_addr] "r"(ic_addr)
+                          : "memory");
+        }
+
+        asm volatile ("dmb ish\n");
+    }
+
+    asm volatile ("isb sy\n");
+}
+
+static int basic_test(uint32_t *rw_data, const uint32_t *exec_data)
+{
+    /*
+     * As user mode only misbehaved for dual-mapped code when previously
+     * translated code had been changed, we'll start off with this basic test
+     * function to ensure that there's already some translated code at
+     * exec_data before the next test. This should cause the next test to fail
+     * if `mark_code_modified` fails to invalidate the code.
+     *
+     * Note that the payload is in binary form instead of inline assembler
+     * because we cannot use __attribute__((naked)) on this platform and the
+     * workarounds are at least as ugly as this is.
+     */
+    static const uint32_t basic_payload[] = {
+        0xD65F03C0 /* 0x00: RET */
+    };
+
+    BasicTest *copied_ptr = (BasicTest *)exec_data;
+
+    memcpy(rw_data, basic_payload, sizeof(basic_payload));
+    mark_code_modified(exec_data, sizeof(basic_payload));
+
+    return copied_ptr(1234) == 1234;
+}
+
+static int self_modification_test(uint32_t *rw_data, const uint32_t *exec_data)
+{
+    /*
+     * This test is self-modifying in an attempt to cover an edge case where
+     * the IC IVAU instruction invalidates itself.
+     *
+     * Note that the IC IVAU instruction is 16 bytes into the function, in what
+     * will be the same cache line as the modified instruction on machines with
+     * a cache line size >= 16 bytes.
+     */
+    static const uint32_t self_mod_payload[] = {
+        /* Overwrite the placeholder instruction with the new one. */
+        0xB9001C20, /* 0x00: STR w0, [x1, 0x1C] */
+
+        /* Get the executable address of the modified instruction. */
+        0x100000A8, /* 0x04: ADR x8, <0x1C> */
+
+        /* Mark the modified instruction as updated. */
+        0xD50B7B28, /* 0x08: DC CVAU x8 */
+        0xD5033BBF, /* 0x0C: DMB ISH */
+        0xD50B7528, /* 0x10: IC IVAU x8 */
+        0xD5033BBF, /* 0x14: DMB ISH */
+        0xD5033FDF, /* 0x18: ISB */
+
+        /* Placeholder instruction, overwritten above. */
+        0x52800000, /* 0x1C: MOV w0, 0 */
+
+        0xD65F03C0  /* 0x20: RET */
+    };
+
+    SelfModTest *copied_ptr = (SelfModTest *)exec_data;
+    int i;
+
+    memcpy(rw_data, self_mod_payload, sizeof(self_mod_payload));
+    mark_code_modified(exec_data, sizeof(self_mod_payload));
+
+    for (i = 1; i < 10; i++) {
+        /* Replace the placeholder instruction with `MOV w0, i` */
+        uint32_t new_instr = 0x52800000 | (i << 5);
+
+        if (copied_ptr(new_instr, rw_data) != i) {
+            return 0;
+        }
+    }
+
+    return 1;
+}
+
+int main(int argc, char **argv)
+{
+    const char *shm_name = "qemu-test-tcg-aarch64-icivau";
+    int fd;
+
+    fd = shm_open(shm_name, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
+
+    if (fd < 0) {
+        return EXIT_FAILURE;
+    }
+
+    /* Unlink early to avoid leaving garbage in case the test crashes. */
+    shm_unlink(shm_name);
+
+    if (ftruncate(fd, MAX_CODE_SIZE) == 0) {
+        const uint32_t *exec_data;
+        uint32_t *rw_data;
+
+        rw_data = mmap(0, MAX_CODE_SIZE, PROT_READ | PROT_WRITE,
+                       MAP_SHARED, fd, 0);
+        exec_data = mmap(0, MAX_CODE_SIZE, PROT_READ | PROT_EXEC,
+                         MAP_SHARED, fd, 0);
+
+        if (rw_data && exec_data) {
+            if (basic_test(rw_data, exec_data) &&
+                self_modification_test(rw_data, exec_data)) {
+                return EXIT_SUCCESS;
+            }
+        }
+    }
+
+    return EXIT_FAILURE;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 97cfc43600a..bf9d21d72fb 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -9,9 +9,10 @@ AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
 VPATH 		+= $(AARCH64_SRC)
 
 # Base architecture tests
-AARCH64_TESTS=fcvt pcalign-a64
+AARCH64_TESTS=fcvt pcalign-a64 icivau
 
 fcvt: LDFLAGS+=-lm
+icivau: LDFLAGS+=-lrt
 
 run-fcvt: fcvt
 	$(call run-test,$<,$(QEMU) $<, "$< on $(TARGET_NAME)")
-- 
2.34.1


