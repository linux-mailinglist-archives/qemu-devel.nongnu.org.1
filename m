Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF008927F6C
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jul 2024 02:36:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPWuy-0003Je-Rc; Thu, 04 Jul 2024 20:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPWuv-0003Cj-Du
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:35:14 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPWur-0000Lf-E8
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:35:11 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70b04cb28baso625819b3a.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 17:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720139706; x=1720744506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSYKX7tgmPWgH1eoungM9Ek83i1kIQO2hxPk9JjJ0jw=;
 b=vRkAzjdTvPGmU/1+xUouQGopLgI2z3kIUt/HjGCMvn7rMNfuB6wJSwB13Oll9ou9bx
 lbSx6TWARqdSm1y7JCvir+NOQEpVXKi2e5oO+0no7Zg8WsI1N4jneUc1bpzUhNyc3CBi
 mCQpxruPL2etgW2JkkPX/9WraBUmCJ+8WDGmnnfrkBD/c1FOG5iM0BF3eMOdH4vHIPkG
 qR+BdxfeU7y6DFz6HcCqsQ1vae/Ob5B1KwbytRAoTALsOww6Z2nnJB18kOwE3NaHOQ62
 IWaFeH0lC/uydHDC6aSRWrS1h1hsMK9Ior46l3eYn/RT0jU99jDhIKXEds5fr7dce9hr
 V05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720139706; x=1720744506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jSYKX7tgmPWgH1eoungM9Ek83i1kIQO2hxPk9JjJ0jw=;
 b=IBCGdX47Vm0JN7c1i6bRN+GHTjImjYpQZRx2aHjhcYVTEnk0kbUP0so6PHCVtfS/M2
 XXvcFOj22OTKUlXBS390k2ItIbstIMOr8KvuCbz67KQQSK/V760q4d5A2nLW5wJn3E3o
 Kzz8kARbVCoFJLQedKyGngBAaDkDz76TWhinhRBU5iODmm8zcrKnfD4hM5WavnbWtkx4
 vkVHIhid3QetGV3hjuCORLkhksZL/1XiYNhGeJDleERQ9Gj5UWnlU5m18ccjD8jvD97o
 IAk5uPUOupmJGyP9gI1xCuUMc6W26MKqPYkWcipTOJQ/69KWxY6q/dgwtrZeOiJBn7PH
 0drw==
X-Gm-Message-State: AOJu0YyjkqPUddu9oFVAOLAddeR/8/vojOdQpZVvhxIfAp27iEVIGupB
 znH+Sd3K0iZyi59P02PYbH2cMadcUbBTFNa2Ep7sBA22CdrooWbmlM9UbmPxIyxex22zB6dbTmC
 lYlQ=
X-Google-Smtp-Source: AGHT+IGXX1fw1KdjhgHNamSlEU4PFJDcvnjPC3/CjSIQ2ODb6YEu6GBqZ7HcoF/grzrOptaRa9bFsQ==
X-Received: by 2002:a05:6a20:4f22:b0:1bd:4bc7:1ee4 with SMTP id
 adf61e73a8af0-1c0ccb0fa0dmr2609174637.58.1720139706195; 
 Thu, 04 Jul 2024 17:35:06 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb1a075616sm39008595ad.15.2024.07.04.17.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 17:35:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v5 7/7] tests/tcg/x86_64: add test for plugin memory access
Date: Thu,  4 Jul 2024 17:34:21 -0700
Message-Id: <20240705003421.750895-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705003421.750895-1-pierrick.bouvier@linaro.org>
References: <20240705003421.750895-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

Add an explicit test to check expected memory values are read/written.
For sizes 8, 16, 32, 64 and 128, we generate a load/store operation.
For size 8 -> 64, we generate an atomic __sync_val_compare_and_swap too.
For 128bits memory access, we rely on SSE2 instructions.

By default, atomic accesses are non atomic if a single cpu is running,
so we force creation of a second one by creating a new thread first.

load/store helpers code path can't be triggered easily in user mode (no
softmmu), so we can't test it here.

Can be run with:
make -C build/tests/tcg/x86_64-linux-user run-plugin-test-plugin-mem-access-with-libmem.so

Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/x86_64/test-plugin-mem-access.c   | 89 +++++++++++++++++++++
 tests/tcg/x86_64/Makefile.target            |  7 ++
 tests/tcg/x86_64/check-plugin-mem-access.sh | 48 +++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 tests/tcg/x86_64/test-plugin-mem-access.c
 create mode 100755 tests/tcg/x86_64/check-plugin-mem-access.sh

diff --git a/tests/tcg/x86_64/test-plugin-mem-access.c b/tests/tcg/x86_64/test-plugin-mem-access.c
new file mode 100644
index 00000000000..7fdd6a55829
--- /dev/null
+++ b/tests/tcg/x86_64/test-plugin-mem-access.c
@@ -0,0 +1,89 @@
+#include <emmintrin.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+static void *data;
+
+#define DEFINE_STORE(name, type, value) \
+static void store_##name(void)          \
+{                                       \
+    *((type *)data) = value;            \
+}
+
+#define DEFINE_ATOMIC_OP(name, type, value)                 \
+static void atomic_op_##name(void)                          \
+{                                                           \
+    *((type *)data) = 0x42;                                 \
+    __sync_val_compare_and_swap((type *)data, 0x42, value); \
+}
+
+#define DEFINE_LOAD(name, type)                         \
+static void load_##name(void)                           \
+{                                                       \
+    register type var asm("eax") = *((type *) data);    \
+    (void)var;                                          \
+}
+
+DEFINE_STORE(u8, uint8_t, 0xf1)
+DEFINE_ATOMIC_OP(u8, uint8_t, 0xf1)
+DEFINE_LOAD(u8, uint8_t)
+DEFINE_STORE(u16, uint16_t, 0xf123)
+DEFINE_ATOMIC_OP(u16, uint16_t, 0xf123)
+DEFINE_LOAD(u16, uint16_t)
+DEFINE_STORE(u32, uint32_t, 0xff112233)
+DEFINE_ATOMIC_OP(u32, uint32_t, 0xff112233)
+DEFINE_LOAD(u32, uint32_t)
+DEFINE_STORE(u64, uint64_t, 0xf123456789abcdef)
+DEFINE_ATOMIC_OP(u64, uint64_t, 0xf123456789abcdef)
+DEFINE_LOAD(u64, uint64_t)
+
+static void store_u128(void)
+{
+    _mm_store_si128(data, _mm_set_epi32(0xf1223344, 0x55667788,
+                                        0xf1234567, 0x89abcdef));
+}
+
+static void load_u128(void)
+{
+    __m128i var = _mm_load_si128(data);
+    (void)var;
+}
+
+static void *f(void *p)
+{
+    return NULL;
+}
+
+int main(void)
+{
+    /*
+     * We force creation of a second thread to enable cpu flag CF_PARALLEL.
+     * This will generate atomic operations when needed.
+     */
+    pthread_t thread;
+    pthread_create(&thread, NULL, &f, NULL);
+    pthread_join(thread, NULL);
+
+    data = malloc(sizeof(__m128i));
+    atomic_op_u8();
+    store_u8();
+    load_u8();
+
+    atomic_op_u16();
+    store_u16();
+    load_u16();
+
+    atomic_op_u32();
+    store_u32();
+    load_u32();
+
+    atomic_op_u64();
+    store_u64();
+    load_u64();
+
+    store_u128();
+    load_u128();
+
+    free(data);
+}
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index eda9bd7396c..3edc29b924d 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -16,6 +16,7 @@ X86_64_TESTS += noexec
 X86_64_TESTS += cmpxchg
 X86_64_TESTS += adox
 X86_64_TESTS += test-1648
+PLUGINS_TESTS += test-plugin-mem-access
 TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
 else
 TESTS=$(MULTIARCH_TESTS)
@@ -26,6 +27,12 @@ adox: CFLAGS=-O2
 run-test-i386-ssse3: QEMU_OPTS += -cpu max
 run-plugin-test-i386-ssse3-%: QEMU_OPTS += -cpu max
 
+run-plugin-test-plugin-mem-access-with-libmem.so: \
+	PLUGIN_ARGS=$(COMMA)print-accesses=true
+run-plugin-test-plugin-mem-access-with-libmem.so: \
+	CHECK_PLUGIN_OUTPUT_COMMAND= \
+	$(SRC_PATH)/tests/tcg/x86_64/check-plugin-mem-access.sh
+
 test-x86_64: LDFLAGS+=-lm -lc
 test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h
 	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
diff --git a/tests/tcg/x86_64/check-plugin-mem-access.sh b/tests/tcg/x86_64/check-plugin-mem-access.sh
new file mode 100755
index 00000000000..163f1cfad34
--- /dev/null
+++ b/tests/tcg/x86_64/check-plugin-mem-access.sh
@@ -0,0 +1,48 @@
+#!/usr/bin/env bash
+
+set -euo pipefail
+
+die()
+{
+    echo "$@" 1>&2
+    exit 1
+}
+
+check()
+{
+    file=$1
+    pattern=$2
+    grep "$pattern" "$file" > /dev/null || die "\"$pattern\" not found in $file"
+}
+
+[ $# -eq 1 ] || die "usage: plugin_out_file"
+
+plugin_out=$1
+
+expected()
+{
+    cat << EOF
+,store_u8,.*,8,store,0xf1
+,atomic_op_u8,.*,8,load,0x42
+,atomic_op_u8,.*,8,store,0xf1
+,load_u8,.*,8,load,0xf1
+,store_u16,.*,16,store,0xf123
+,atomic_op_u16,.*,16,load,0x0042
+,atomic_op_u16,.*,16,store,0xf123
+,load_u16,.*,16,load,0xf123
+,store_u32,.*,32,store,0xff112233
+,atomic_op_u32,.*,32,load,0x00000042
+,atomic_op_u32,.*,32,store,0xff112233
+,load_u32,.*,32,load,0xff112233
+,store_u64,.*,64,store,0xf123456789abcdef
+,atomic_op_u64,.*,64,load,0x0000000000000042
+,atomic_op_u64,.*,64,store,0xf123456789abcdef
+,load_u64,.*,64,load,0xf123456789abcdef
+,store_u128,.*,128,store,0xf122334455667788f123456789abcdef
+,load_u128,.*,128,load,0xf122334455667788f123456789abcdef
+EOF
+}
+
+expected | while read line; do
+    check "$plugin_out" "$line"
+done
-- 
2.39.2


