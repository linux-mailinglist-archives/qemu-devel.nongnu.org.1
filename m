Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E8B833739
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 01:22:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRLaO-0002Xv-D9; Sat, 20 Jan 2024 19:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLaL-0002Xm-9e
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:21:13 -0500
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLaH-0007QJ-Ti
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:21:13 -0500
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7bf617dcedaso92352739f.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 16:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705796469; x=1706401269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlgMoCbNlbK2kYnDr6aEn76H+rXWsz2BjY76x4m7kmQ=;
 b=dxpicevosLthobJj7mqrQNSfJH0Qitxn8m1/JJNkdjAtoyaceeh5kWgVfEOQkuXxVQ
 U+QORA90rlP7+5wfz4o9w4k2mzRfAK78EDrdqnFi61mYlMogwwioSZIFzBEc3wHCCCkS
 hGKheBTdY858gu/kKamDPB4kvttxn8SqfU+RPQnqPllOxJkqyv4EAubNiwFFTsW/IW4Q
 rBAL04ygKcuqt0wndvycnzSGwZOJvMSrPPXnq4CbhteyEr6XNsA/bhL8ZuxyXVHV5hfS
 1U0hkNRj/8nHXJ9ejwyOxZtm5R5lKywQHphpQCmzfCFmvfMOp/9QsBpnCqqqLWpr4cFJ
 EeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705796469; x=1706401269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlgMoCbNlbK2kYnDr6aEn76H+rXWsz2BjY76x4m7kmQ=;
 b=BKwv/nhj6sqe+CANlA1W7/oA25IjFfb3omyKs+0DoY7IHiUDHOxgE8kqqm42kdH0q0
 EVtQHOUM3P+cRAFhG7lmp0ckOFZLXTrMEXW2lYRViYGlL5uTFltepLECUuTtehrDsRx4
 sBilkrVA/UyGBo363zCa/P44NLFWAARECuiLpaLHLkDtcKqod+saLEf6hejtbsatkaW1
 UsNAdOHQbPg+kB0sOSsA7Z0rtrvHsKZdrsdkH2YSbSt/CPQOugGkxW51VRX5jJQ17Upe
 iR3qN8rd1Ba0oEGFqzN9V8P3QpEiT+4CTg8OLpchJInZ7Dt+zSxYMGx0u+1YkibWewPS
 DzfA==
X-Gm-Message-State: AOJu0YyiCjgo60/ljFghZgwXBdMgMLcmhcAgk90uooMg/oYHDdRDHDQJ
 1R3ycGICw4xx/mMalz/qv2AWZsSBVZtXR8Wd8piQNjM9k+9n+Dz7EGlDvlPRfyfxZEv01dBSIbH
 AnR4=
X-Google-Smtp-Source: AGHT+IHd4UOpxzBPFDAw4SCSZ1+He9gU8L0hFeeHtd/CLCVk5s1ek3dop3ZOhk7o2k0W426VymLROQ==
X-Received: by 2002:a92:d24d:0:b0:361:ae2c:f8c3 with SMTP id
 v13-20020a92d24d000000b00361ae2cf8c3mr3298337ilg.52.1705796468694; 
 Sat, 20 Jan 2024 16:21:08 -0800 (PST)
Received: from stoup.net ([2001:8004:5170:1e39:1361:3840:4873:7990])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a17090276c400b001d5af7fbda0sm5023546plt.122.2024.01.20.16.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 16:21:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	Thomas Huth <thuth@redhat.com>
Subject: [PULL 5/8] tests/tcg/s390x: Import linux
 tools/testing/crypto/chacha20-s390
Date: Sun, 21 Jan 2024 11:20:44 +1100
Message-Id: <20240121002047.89234-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121002047.89234-1-richard.henderson@linaro.org>
References: <20240121002047.89234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd2c.google.com
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

Modify and simplify the driver, as we're really only interested
in correctness of translation of chacha-vx.S.

Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240117213646.159697-3-richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/s390x/chacha.c        | 341 ++++++++++++
 tests/tcg/s390x/Makefile.target |   4 +
 tests/tcg/s390x/chacha-vx.S     | 914 ++++++++++++++++++++++++++++++++
 3 files changed, 1259 insertions(+)
 create mode 100644 tests/tcg/s390x/chacha.c
 create mode 100644 tests/tcg/s390x/chacha-vx.S

diff --git a/tests/tcg/s390x/chacha.c b/tests/tcg/s390x/chacha.c
new file mode 100644
index 0000000000..ca9e4c1959
--- /dev/null
+++ b/tests/tcg/s390x/chacha.c
@@ -0,0 +1,341 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Derived from linux kernel sources:
+ *   ./include/crypto/chacha.h
+ *   ./crypto/chacha_generic.c
+ *   ./arch/s390/crypto/chacha-glue.c
+ *   ./tools/testing/crypto/chacha20-s390/test-cipher.c
+ *   ./tools/testing/crypto/chacha20-s390/run-tests.sh
+ */
+
+#include <stdlib.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <inttypes.h>
+#include <sys/random.h>
+
+typedef uint8_t u8;
+typedef uint32_t u32;
+typedef uint64_t u64;
+
+static unsigned data_size;
+static bool debug;
+
+#define CHACHA_IV_SIZE          16
+#define CHACHA_KEY_SIZE         32
+#define CHACHA_BLOCK_SIZE       64
+#define CHACHAPOLY_IV_SIZE      12
+#define CHACHA_STATE_WORDS      (CHACHA_BLOCK_SIZE / sizeof(u32))
+
+static u32 rol32(u32 val, u32 sh)
+{
+    return (val << (sh & 31)) | (val >> (-sh & 31));
+}
+
+static u32 get_unaligned_le32(const void *ptr)
+{
+    u32 val;
+    memcpy(&val, ptr, 4);
+    return __builtin_bswap32(val);
+}
+
+static void put_unaligned_le32(u32 val, void *ptr)
+{
+    val = __builtin_bswap32(val);
+    memcpy(ptr, &val, 4);
+}
+
+static void chacha_permute(u32 *x, int nrounds)
+{
+    for (int i = 0; i < nrounds; i += 2) {
+        x[0]  += x[4];    x[12] = rol32(x[12] ^ x[0],  16);
+        x[1]  += x[5];    x[13] = rol32(x[13] ^ x[1],  16);
+        x[2]  += x[6];    x[14] = rol32(x[14] ^ x[2],  16);
+        x[3]  += x[7];    x[15] = rol32(x[15] ^ x[3],  16);
+
+        x[8]  += x[12];   x[4]  = rol32(x[4]  ^ x[8],  12);
+        x[9]  += x[13];   x[5]  = rol32(x[5]  ^ x[9],  12);
+        x[10] += x[14];   x[6]  = rol32(x[6]  ^ x[10], 12);
+        x[11] += x[15];   x[7]  = rol32(x[7]  ^ x[11], 12);
+
+        x[0]  += x[4];    x[12] = rol32(x[12] ^ x[0],   8);
+        x[1]  += x[5];    x[13] = rol32(x[13] ^ x[1],   8);
+        x[2]  += x[6];    x[14] = rol32(x[14] ^ x[2],   8);
+        x[3]  += x[7];    x[15] = rol32(x[15] ^ x[3],   8);
+
+        x[8]  += x[12];   x[4]  = rol32(x[4]  ^ x[8],   7);
+        x[9]  += x[13];   x[5]  = rol32(x[5]  ^ x[9],   7);
+        x[10] += x[14];   x[6]  = rol32(x[6]  ^ x[10],  7);
+        x[11] += x[15];   x[7]  = rol32(x[7]  ^ x[11],  7);
+
+        x[0]  += x[5];    x[15] = rol32(x[15] ^ x[0],  16);
+        x[1]  += x[6];    x[12] = rol32(x[12] ^ x[1],  16);
+        x[2]  += x[7];    x[13] = rol32(x[13] ^ x[2],  16);
+        x[3]  += x[4];    x[14] = rol32(x[14] ^ x[3],  16);
+
+        x[10] += x[15];   x[5]  = rol32(x[5]  ^ x[10], 12);
+        x[11] += x[12];   x[6]  = rol32(x[6]  ^ x[11], 12);
+        x[8]  += x[13];   x[7]  = rol32(x[7]  ^ x[8],  12);
+        x[9]  += x[14];   x[4]  = rol32(x[4]  ^ x[9],  12);
+
+        x[0]  += x[5];    x[15] = rol32(x[15] ^ x[0],   8);
+        x[1]  += x[6];    x[12] = rol32(x[12] ^ x[1],   8);
+        x[2]  += x[7];    x[13] = rol32(x[13] ^ x[2],   8);
+        x[3]  += x[4];    x[14] = rol32(x[14] ^ x[3],   8);
+
+        x[10] += x[15];   x[5]  = rol32(x[5]  ^ x[10],  7);
+        x[11] += x[12];   x[6]  = rol32(x[6]  ^ x[11],  7);
+        x[8]  += x[13];   x[7]  = rol32(x[7]  ^ x[8],   7);
+        x[9]  += x[14];   x[4]  = rol32(x[4]  ^ x[9],   7);
+    }
+}
+
+static void chacha_block_generic(u32 *state, u8 *stream, int nrounds)
+{
+    u32 x[16];
+
+    memcpy(x, state, 64);
+    chacha_permute(x, nrounds);
+
+    for (int i = 0; i < 16; i++) {
+        put_unaligned_le32(x[i] + state[i], &stream[i * sizeof(u32)]);
+    }
+    state[12]++;
+}
+
+static void crypto_xor_cpy(u8 *dst, const u8 *src1,
+                           const u8 *src2, unsigned len)
+{
+    while (len--) {
+        *dst++ = *src1++ ^ *src2++;
+    }
+}
+
+static void chacha_crypt_generic(u32 *state, u8 *dst, const u8 *src,
+                                 unsigned int bytes, int nrounds)
+{
+    u8 stream[CHACHA_BLOCK_SIZE];
+
+    while (bytes >= CHACHA_BLOCK_SIZE) {
+        chacha_block_generic(state, stream, nrounds);
+        crypto_xor_cpy(dst, src, stream, CHACHA_BLOCK_SIZE);
+        bytes -= CHACHA_BLOCK_SIZE;
+        dst += CHACHA_BLOCK_SIZE;
+        src += CHACHA_BLOCK_SIZE;
+    }
+    if (bytes) {
+        chacha_block_generic(state, stream, nrounds);
+        crypto_xor_cpy(dst, src, stream, bytes);
+    }
+}
+
+enum chacha_constants { /* expand 32-byte k */
+    CHACHA_CONSTANT_EXPA = 0x61707865U,
+    CHACHA_CONSTANT_ND_3 = 0x3320646eU,
+    CHACHA_CONSTANT_2_BY = 0x79622d32U,
+    CHACHA_CONSTANT_TE_K = 0x6b206574U
+};
+
+static void chacha_init_generic(u32 *state, const u32 *key, const u8 *iv)
+{
+    state[0]  = CHACHA_CONSTANT_EXPA;
+    state[1]  = CHACHA_CONSTANT_ND_3;
+    state[2]  = CHACHA_CONSTANT_2_BY;
+    state[3]  = CHACHA_CONSTANT_TE_K;
+    state[4]  = key[0];
+    state[5]  = key[1];
+    state[6]  = key[2];
+    state[7]  = key[3];
+    state[8]  = key[4];
+    state[9]  = key[5];
+    state[10] = key[6];
+    state[11] = key[7];
+    state[12] = get_unaligned_le32(iv +  0);
+    state[13] = get_unaligned_le32(iv +  4);
+    state[14] = get_unaligned_le32(iv +  8);
+    state[15] = get_unaligned_le32(iv + 12);
+}
+
+void chacha20_vx(u8 *out, const u8 *inp, size_t len, const u32 *key,
+                 const u32 *counter);
+
+static void chacha20_crypt_s390(u32 *state, u8 *dst, const u8 *src,
+                                unsigned int nbytes, const u32 *key,
+                                u32 *counter)
+{
+    chacha20_vx(dst, src, nbytes, key, counter);
+    *counter += (nbytes + CHACHA_BLOCK_SIZE - 1) / CHACHA_BLOCK_SIZE;
+}
+
+static void chacha_crypt_arch(u32 *state, u8 *dst, const u8 *src,
+                              unsigned int bytes, int nrounds)
+{
+    /*
+     * s390 chacha20 implementation has 20 rounds hard-coded,
+     * it cannot handle a block of data or less, but otherwise
+     * it can handle data of arbitrary size
+     */
+    if (bytes <= CHACHA_BLOCK_SIZE || nrounds != 20) {
+        chacha_crypt_generic(state, dst, src, bytes, nrounds);
+    } else {
+        chacha20_crypt_s390(state, dst, src, bytes, &state[4], &state[12]);
+    }
+}
+
+static void print_hex_dump(const char *prefix_str, const void *buf, int len)
+{
+    for (int i = 0; i < len; i += 16) {
+        printf("%s%.8x: ", prefix_str, i);
+        for (int j = 0; j < 16; ++j) {
+            printf("%02x%c", *(u8 *)(buf + i + j), j == 15 ? '\n' : ' ');
+        }
+    }
+}
+
+/* Perform cipher operations with the chacha lib */
+static int test_lib_chacha(u8 *revert, u8 *cipher, u8 *plain, bool generic)
+{
+    u32 chacha_state[CHACHA_STATE_WORDS];
+    u8 iv[16], key[32];
+
+    memset(key, 'X', sizeof(key));
+    memset(iv, 'I', sizeof(iv));
+
+    if (debug) {
+        print_hex_dump("key: ", key, 32);
+        print_hex_dump("iv:  ", iv, 16);
+    }
+
+    /* Encrypt */
+    chacha_init_generic(chacha_state, (u32*)key, iv);
+
+    if (generic) {
+        chacha_crypt_generic(chacha_state, cipher, plain, data_size, 20);
+    } else {
+        chacha_crypt_arch(chacha_state, cipher, plain, data_size, 20);
+    }
+
+    if (debug) {
+        print_hex_dump("encr:", cipher,
+                       (data_size > 64 ? 64 : data_size));
+    }
+
+    /* Decrypt */
+    chacha_init_generic(chacha_state, (u32 *)key, iv);
+
+    if (generic) {
+        chacha_crypt_generic(chacha_state, revert, cipher, data_size, 20);
+    } else {
+        chacha_crypt_arch(chacha_state, revert, cipher, data_size, 20);
+    }
+
+    if (debug) {
+        print_hex_dump("decr:", revert,
+                       (data_size > 64 ? 64 : data_size));
+    }
+    return 0;
+}
+
+static int chacha_s390_test_init(void)
+{
+    u8 *plain = NULL, *revert = NULL;
+    u8 *cipher_generic = NULL, *cipher_s390 = NULL;
+    int ret = -1;
+
+    printf("s390 ChaCha20 test module: size=%d debug=%d\n",
+           data_size, debug);
+
+    /* Allocate and fill buffers */
+    plain = malloc(data_size);
+    if (!plain) {
+        printf("could not allocate plain buffer\n");
+        ret = -2;
+        goto out;
+    }
+
+    memset(plain, 'a', data_size);
+    for (unsigned i = 0, n = data_size > 256 ? 256 : data_size; i < n; ) {
+        ssize_t t = getrandom(plain + i, n - i, 0);
+        if (t < 0) {
+            break;
+        }
+        i -= t;
+    }
+
+    cipher_generic = calloc(1, data_size);
+    if (!cipher_generic) {
+        printf("could not allocate cipher_generic buffer\n");
+        ret = -2;
+        goto out;
+    }
+
+    cipher_s390 = calloc(1, data_size);
+    if (!cipher_s390) {
+        printf("could not allocate cipher_s390 buffer\n");
+        ret = -2;
+        goto out;
+    }
+
+    revert = calloc(1, data_size);
+    if (!revert) {
+        printf("could not allocate revert buffer\n");
+        ret = -2;
+        goto out;
+    }
+
+    if (debug) {
+        print_hex_dump("src: ", plain,
+                       (data_size > 64 ? 64 : data_size));
+    }
+
+    /* Use chacha20 lib */
+    test_lib_chacha(revert, cipher_generic, plain, true);
+    if (memcmp(plain, revert, data_size)) {
+        printf("generic en/decryption check FAILED\n");
+        ret = -2;
+        goto out;
+    }
+    printf("generic en/decryption check OK\n");
+
+    test_lib_chacha(revert, cipher_s390, plain, false);
+    if (memcmp(plain, revert, data_size)) {
+        printf("lib en/decryption check FAILED\n");
+        ret = -2;
+        goto out;
+    }
+    printf("lib en/decryption check OK\n");
+
+    if (memcmp(cipher_generic, cipher_s390, data_size)) {
+        printf("lib vs generic check FAILED\n");
+        ret = -2;
+        goto out;
+    }
+    printf("lib vs generic check OK\n");
+
+    printf("--- chacha20 s390 test end ---\n");
+
+out:
+    free(plain);
+    free(cipher_generic);
+    free(cipher_s390);
+    free(revert);
+    return ret;
+}
+
+int main(int ac, char **av)
+{
+    static const unsigned sizes[] = {
+        63, 64, 65, 127, 128, 129, 511, 512, 513, 4096, 65611,
+        /* too slow for tcg: 6291456, 62914560 */
+    };
+
+    debug = ac >= 2;
+    for (int i = 0; i < sizeof(sizes) / sizeof(sizes[0]); ++i) {
+        data_size = sizes[i];
+        if (chacha_s390_test_init() != -1) {
+            return 1;
+        }
+    }
+    return 0;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 30994dcf9c..b9dc12dc8a 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -66,9 +66,13 @@ Z13_TESTS+=vcksm
 Z13_TESTS+=vstl
 Z13_TESTS+=vrep
 Z13_TESTS+=precise-smc-user
+Z13_TESTS+=chacha
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
+chacha: chacha.c chacha-vx.S
+	$(CC) $(LDFLAGS) $(CFLAGS) $(EXTRA_CFLAGS) $^ -o $@
+
 ifneq ($(CROSS_CC_HAS_Z14),)
 Z14_TESTS=vfminmax
 vfminmax: LDFLAGS+=-lm
diff --git a/tests/tcg/s390x/chacha-vx.S b/tests/tcg/s390x/chacha-vx.S
new file mode 100644
index 0000000000..dcb55b4324
--- /dev/null
+++ b/tests/tcg/s390x/chacha-vx.S
@@ -0,0 +1,914 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Original implementation written by Andy Polyakov, @dot-asm.
+ * This is an adaptation of the original code for kernel use.
+ *
+ * Copyright (C) 2006-2019 CRYPTOGAMS by <appro@openssl.org>. All Rights Reserved.
+ *
+ * For qemu testing, drop <asm/vx-insn-asm.h> and assume assembler support.
+ */
+
+#define SP	%r15
+#define FRAME	(16 * 8 + 4 * 8)
+
+	.data
+	.balign	32
+
+sigma:
+	.long	0x61707865,0x3320646e,0x79622d32,0x6b206574	# endian-neutral
+	.long	1,0,0,0
+	.long	2,0,0,0
+	.long	3,0,0,0
+	.long	0x03020100,0x07060504,0x0b0a0908,0x0f0e0d0c	# byte swap
+
+	.long	0,1,2,3
+	.long	0x61707865,0x61707865,0x61707865,0x61707865	# smashed sigma
+	.long	0x3320646e,0x3320646e,0x3320646e,0x3320646e
+	.long	0x79622d32,0x79622d32,0x79622d32,0x79622d32
+	.long	0x6b206574,0x6b206574,0x6b206574,0x6b206574
+
+	.type	sigma, @object
+	.size	sigma, . - sigma
+
+	.previous
+
+	.text
+
+#############################################################################
+# void chacha20_vx_4x(u8 *out, counst u8 *inp, size_t len,
+#		      counst u32 *key, const u32 *counter)
+
+#define	OUT		%r2
+#define	INP		%r3
+#define	LEN		%r4
+#define	KEY		%r5
+#define	COUNTER		%r6
+
+#define BEPERM		%v31
+#define CTR		%v26
+
+#define K0		%v16
+#define K1		%v17
+#define K2		%v18
+#define K3		%v19
+
+#define XA0		%v0
+#define XA1		%v1
+#define XA2		%v2
+#define XA3		%v3
+
+#define XB0		%v4
+#define XB1		%v5
+#define XB2		%v6
+#define XB3		%v7
+
+#define XC0		%v8
+#define XC1		%v9
+#define XC2		%v10
+#define XC3		%v11
+
+#define XD0		%v12
+#define XD1		%v13
+#define XD2		%v14
+#define XD3		%v15
+
+#define XT0		%v27
+#define XT1		%v28
+#define XT2		%v29
+#define XT3		%v30
+
+	.balign	32
+chacha20_vx_4x:
+	stmg	%r6,%r7,6*8(SP)
+
+	larl	%r7,sigma
+	lhi	%r0,10
+	lhi	%r1,0
+
+	vl	K0,0(%r7)		# load sigma
+	vl	K1,0(KEY)		# load key
+	vl	K2,16(KEY)
+	vl	K3,0(COUNTER)		# load counter
+
+	vl	BEPERM,0x40(%r7)
+	vl	CTR,0x50(%r7)
+
+	vlm	XA0,XA3,0x60(%r7),4	# load [smashed] sigma
+
+	vrepf	XB0,K1,0		# smash the key
+	vrepf	XB1,K1,1
+	vrepf	XB2,K1,2
+	vrepf	XB3,K1,3
+
+	vrepf	XD0,K3,0
+	vrepf	XD1,K3,1
+	vrepf	XD2,K3,2
+	vrepf	XD3,K3,3
+	vaf	XD0,XD0,CTR
+
+	vrepf	XC0,K2,0
+	vrepf	XC1,K2,1
+	vrepf	XC2,K2,2
+	vrepf	XC3,K2,3
+
+.Loop_4x:
+	vaf	XA0,XA0,XB0
+	vx	XD0,XD0,XA0
+	verllf	XD0,XD0,16
+
+	vaf	XA1,XA1,XB1
+	vx	XD1,XD1,XA1
+	verllf	XD1,XD1,16
+
+	vaf	XA2,XA2,XB2
+	vx	XD2,XD2,XA2
+	verllf	XD2,XD2,16
+
+	vaf	XA3,XA3,XB3
+	vx	XD3,XD3,XA3
+	verllf	XD3,XD3,16
+
+	vaf	XC0,XC0,XD0
+	vx	XB0,XB0,XC0
+	verllf	XB0,XB0,12
+
+	vaf	XC1,XC1,XD1
+	vx	XB1,XB1,XC1
+	verllf	XB1,XB1,12
+
+	vaf	XC2,XC2,XD2
+	vx	XB2,XB2,XC2
+	verllf	XB2,XB2,12
+
+	vaf	XC3,XC3,XD3
+	vx	XB3,XB3,XC3
+	verllf	XB3,XB3,12
+
+	vaf	XA0,XA0,XB0
+	vx	XD0,XD0,XA0
+	verllf	XD0,XD0,8
+
+	vaf	XA1,XA1,XB1
+	vx	XD1,XD1,XA1
+	verllf	XD1,XD1,8
+
+	vaf	XA2,XA2,XB2
+	vx	XD2,XD2,XA2
+	verllf	XD2,XD2,8
+
+	vaf	XA3,XA3,XB3
+	vx	XD3,XD3,XA3
+	verllf	XD3,XD3,8
+
+	vaf	XC0,XC0,XD0
+	vx	XB0,XB0,XC0
+	verllf	XB0,XB0,7
+
+	vaf	XC1,XC1,XD1
+	vx	XB1,XB1,XC1
+	verllf	XB1,XB1,7
+
+	vaf	XC2,XC2,XD2
+	vx	XB2,XB2,XC2
+	verllf	XB2,XB2,7
+
+	vaf	XC3,XC3,XD3
+	vx	XB3,XB3,XC3
+	verllf	XB3,XB3,7
+
+	vaf	XA0,XA0,XB1
+	vx	XD3,XD3,XA0
+	verllf	XD3,XD3,16
+
+	vaf	XA1,XA1,XB2
+	vx	XD0,XD0,XA1
+	verllf	XD0,XD0,16
+
+	vaf	XA2,XA2,XB3
+	vx	XD1,XD1,XA2
+	verllf	XD1,XD1,16
+
+	vaf	XA3,XA3,XB0
+	vx	XD2,XD2,XA3
+	verllf	XD2,XD2,16
+
+	vaf	XC2,XC2,XD3
+	vx	XB1,XB1,XC2
+	verllf	XB1,XB1,12
+
+	vaf	XC3,XC3,XD0
+	vx	XB2,XB2,XC3
+	verllf	XB2,XB2,12
+
+	vaf	XC0,XC0,XD1
+	vx	XB3,XB3,XC0
+	verllf	XB3,XB3,12
+
+	vaf	XC1,XC1,XD2
+	vx	XB0,XB0,XC1
+	verllf	XB0,XB0,12
+
+	vaf	XA0,XA0,XB1
+	vx	XD3,XD3,XA0
+	verllf	XD3,XD3,8
+
+	vaf	XA1,XA1,XB2
+	vx	XD0,XD0,XA1
+	verllf	XD0,XD0,8
+
+	vaf	XA2,XA2,XB3
+	vx	XD1,XD1,XA2
+	verllf	XD1,XD1,8
+
+	vaf	XA3,XA3,XB0
+	vx	XD2,XD2,XA3
+	verllf	XD2,XD2,8
+
+	vaf	XC2,XC2,XD3
+	vx	XB1,XB1,XC2
+	verllf	XB1,XB1,7
+
+	vaf	XC3,XC3,XD0
+	vx	XB2,XB2,XC3
+	verllf	XB2,XB2,7
+
+	vaf	XC0,XC0,XD1
+	vx	XB3,XB3,XC0
+	verllf	XB3,XB3,7
+
+	vaf	XC1,XC1,XD2
+	vx	XB0,XB0,XC1
+	verllf	XB0,XB0,7
+	brct	%r0,.Loop_4x
+
+	vaf	XD0,XD0,CTR
+
+	vmrhf	XT0,XA0,XA1		# transpose data
+	vmrhf	XT1,XA2,XA3
+	vmrlf	XT2,XA0,XA1
+	vmrlf	XT3,XA2,XA3
+	vpdi	XA0,XT0,XT1,0b0000
+	vpdi	XA1,XT0,XT1,0b0101
+	vpdi	XA2,XT2,XT3,0b0000
+	vpdi	XA3,XT2,XT3,0b0101
+
+	vmrhf	XT0,XB0,XB1
+	vmrhf	XT1,XB2,XB3
+	vmrlf	XT2,XB0,XB1
+	vmrlf	XT3,XB2,XB3
+	vpdi	XB0,XT0,XT1,0b0000
+	vpdi	XB1,XT0,XT1,0b0101
+	vpdi	XB2,XT2,XT3,0b0000
+	vpdi	XB3,XT2,XT3,0b0101
+
+	vmrhf	XT0,XC0,XC1
+	vmrhf	XT1,XC2,XC3
+	vmrlf	XT2,XC0,XC1
+	vmrlf	XT3,XC2,XC3
+	vpdi	XC0,XT0,XT1,0b0000
+	vpdi	XC1,XT0,XT1,0b0101
+	vpdi	XC2,XT2,XT3,0b0000
+	vpdi	XC3,XT2,XT3,0b0101
+
+	vmrhf	XT0,XD0,XD1
+	vmrhf	XT1,XD2,XD3
+	vmrlf	XT2,XD0,XD1
+	vmrlf	XT3,XD2,XD3
+	vpdi	XD0,XT0,XT1,0b0000
+	vpdi	XD1,XT0,XT1,0b0101
+	vpdi	XD2,XT2,XT3,0b0000
+	vpdi	XD3,XT2,XT3,0b0101
+
+	vaf	XA0,XA0,K0
+	vaf	XB0,XB0,K1
+	vaf	XC0,XC0,K2
+	vaf	XD0,XD0,K3
+
+	vperm	XA0,XA0,XA0,BEPERM
+	vperm	XB0,XB0,XB0,BEPERM
+	vperm	XC0,XC0,XC0,BEPERM
+	vperm	XD0,XD0,XD0,BEPERM
+
+	vlm	XT0,XT3,0(INP),0
+
+	vx	XT0,XT0,XA0
+	vx	XT1,XT1,XB0
+	vx	XT2,XT2,XC0
+	vx	XT3,XT3,XD0
+
+	vstm	XT0,XT3,0(OUT),0
+
+	la	INP,0x40(INP)
+	la	OUT,0x40(OUT)
+	aghi	LEN,-0x40
+
+	vaf	XA0,XA1,K0
+	vaf	XB0,XB1,K1
+	vaf	XC0,XC1,K2
+	vaf	XD0,XD1,K3
+
+	vperm	XA0,XA0,XA0,BEPERM
+	vperm	XB0,XB0,XB0,BEPERM
+	vperm	XC0,XC0,XC0,BEPERM
+	vperm	XD0,XD0,XD0,BEPERM
+
+	clgfi	LEN,0x40
+	jl	.Ltail_4x
+
+	vlm	XT0,XT3,0(INP),0
+
+	vx	XT0,XT0,XA0
+	vx	XT1,XT1,XB0
+	vx	XT2,XT2,XC0
+	vx	XT3,XT3,XD0
+
+	vstm	XT0,XT3,0(OUT),0
+
+	la	INP,0x40(INP)
+	la	OUT,0x40(OUT)
+	aghi	LEN,-0x40
+	je	.Ldone_4x
+
+	vaf	XA0,XA2,K0
+	vaf	XB0,XB2,K1
+	vaf	XC0,XC2,K2
+	vaf	XD0,XD2,K3
+
+	vperm	XA0,XA0,XA0,BEPERM
+	vperm	XB0,XB0,XB0,BEPERM
+	vperm	XC0,XC0,XC0,BEPERM
+	vperm	XD0,XD0,XD0,BEPERM
+
+	clgfi	LEN,0x40
+	jl	.Ltail_4x
+
+	vlm	XT0,XT3,0(INP),0
+
+	vx	XT0,XT0,XA0
+	vx	XT1,XT1,XB0
+	vx	XT2,XT2,XC0
+	vx	XT3,XT3,XD0
+
+	vstm	XT0,XT3,0(OUT),0
+
+	la	INP,0x40(INP)
+	la	OUT,0x40(OUT)
+	aghi	LEN,-0x40
+	je	.Ldone_4x
+
+	vaf	XA0,XA3,K0
+	vaf	XB0,XB3,K1
+	vaf	XC0,XC3,K2
+	vaf	XD0,XD3,K3
+
+	vperm	XA0,XA0,XA0,BEPERM
+	vperm	XB0,XB0,XB0,BEPERM
+	vperm	XC0,XC0,XC0,BEPERM
+	vperm	XD0,XD0,XD0,BEPERM
+
+	clgfi	LEN,0x40
+	jl	.Ltail_4x
+
+	vlm	XT0,XT3,0(INP),0
+
+	vx	XT0,XT0,XA0
+	vx	XT1,XT1,XB0
+	vx	XT2,XT2,XC0
+	vx	XT3,XT3,XD0
+
+	vstm	XT0,XT3,0(OUT),0
+
+.Ldone_4x:
+	lmg	%r6,%r7,6*8(SP)
+	br	%r14
+
+.Ltail_4x:
+	vlr	XT0,XC0
+	vlr	XT1,XD0
+
+	vst	XA0,8*8+0x00(SP)
+	vst	XB0,8*8+0x10(SP)
+	vst	XT0,8*8+0x20(SP)
+	vst	XT1,8*8+0x30(SP)
+
+	lghi	%r1,0
+
+.Loop_tail_4x:
+	llgc	%r5,0(%r1,INP)
+	llgc	%r6,8*8(%r1,SP)
+	xr	%r6,%r5
+	stc	%r6,0(%r1,OUT)
+	la	%r1,1(%r1)
+	brct	LEN,.Loop_tail_4x
+
+	lmg	%r6,%r7,6*8(SP)
+	br	%r14
+
+	.type	chacha20_vx_4x, @function
+	.size	chacha20_vx_4x, . - chacha20_vx_4x
+
+#undef	OUT
+#undef	INP
+#undef	LEN
+#undef	KEY
+#undef	COUNTER
+
+#undef BEPERM
+
+#undef K0
+#undef K1
+#undef K2
+#undef K3
+
+
+#############################################################################
+# void chacha20_vx(u8 *out, counst u8 *inp, size_t len,
+#		   counst u32 *key, const u32 *counter)
+
+#define	OUT		%r2
+#define	INP		%r3
+#define	LEN		%r4
+#define	KEY		%r5
+#define	COUNTER		%r6
+
+#define BEPERM		%v31
+
+#define K0		%v27
+#define K1		%v24
+#define K2		%v25
+#define K3		%v26
+
+#define A0		%v0
+#define B0		%v1
+#define C0		%v2
+#define D0		%v3
+
+#define A1		%v4
+#define B1		%v5
+#define C1		%v6
+#define D1		%v7
+
+#define A2		%v8
+#define B2		%v9
+#define C2		%v10
+#define D2		%v11
+
+#define A3		%v12
+#define B3		%v13
+#define C3		%v14
+#define D3		%v15
+
+#define A4		%v16
+#define B4		%v17
+#define C4		%v18
+#define D4		%v19
+
+#define A5		%v20
+#define B5		%v21
+#define C5		%v22
+#define D5		%v23
+
+#define T0		%v27
+#define T1		%v28
+#define T2		%v29
+#define T3		%v30
+
+	.balign	32
+chacha20_vx:
+	clgfi	LEN,256
+	jle	chacha20_vx_4x
+	stmg	%r6,%r7,6*8(SP)
+
+	lghi	%r1,-FRAME
+	lgr	%r0,SP
+	la	SP,0(%r1,SP)
+	stg	%r0,0(SP)		# back-chain
+
+	larl	%r7,sigma
+	lhi	%r0,10
+
+	vlm	K1,K2,0(KEY),0		# load key
+	vl	K3,0(COUNTER)		# load counter
+
+	vlm	K0,BEPERM,0(%r7),4	# load sigma, increments, ...
+
+.Loop_outer_vx:
+	vlr	A0,K0
+	vlr	B0,K1
+	vlr	A1,K0
+	vlr	B1,K1
+	vlr	A2,K0
+	vlr	B2,K1
+	vlr	A3,K0
+	vlr	B3,K1
+	vlr	A4,K0
+	vlr	B4,K1
+	vlr	A5,K0
+	vlr	B5,K1
+
+	vlr	D0,K3
+	vaf	D1,K3,T1		# K[3]+1
+	vaf	D2,K3,T2		# K[3]+2
+	vaf	D3,K3,T3		# K[3]+3
+	vaf	D4,D2,T2		# K[3]+4
+	vaf	D5,D2,T3		# K[3]+5
+
+	vlr	C0,K2
+	vlr	C1,K2
+	vlr	C2,K2
+	vlr	C3,K2
+	vlr	C4,K2
+	vlr	C5,K2
+
+	vlr	T1,D1
+	vlr	T2,D2
+	vlr	T3,D3
+
+.Loop_vx:
+	vaf	A0,A0,B0
+	vaf	A1,A1,B1
+	vaf	A2,A2,B2
+	vaf	A3,A3,B3
+	vaf	A4,A4,B4
+	vaf	A5,A5,B5
+	vx	D0,D0,A0
+	vx	D1,D1,A1
+	vx	D2,D2,A2
+	vx	D3,D3,A3
+	vx	D4,D4,A4
+	vx	D5,D5,A5
+	verllf	D0,D0,16
+	verllf	D1,D1,16
+	verllf	D2,D2,16
+	verllf	D3,D3,16
+	verllf	D4,D4,16
+	verllf	D5,D5,16
+
+	vaf	C0,C0,D0
+	vaf	C1,C1,D1
+	vaf	C2,C2,D2
+	vaf	C3,C3,D3
+	vaf	C4,C4,D4
+	vaf	C5,C5,D5
+	vx	B0,B0,C0
+	vx	B1,B1,C1
+	vx	B2,B2,C2
+	vx	B3,B3,C3
+	vx	B4,B4,C4
+	vx	B5,B5,C5
+	verllf	B0,B0,12
+	verllf	B1,B1,12
+	verllf	B2,B2,12
+	verllf	B3,B3,12
+	verllf	B4,B4,12
+	verllf	B5,B5,12
+
+	vaf	A0,A0,B0
+	vaf	A1,A1,B1
+	vaf	A2,A2,B2
+	vaf	A3,A3,B3
+	vaf	A4,A4,B4
+	vaf	A5,A5,B5
+	vx	D0,D0,A0
+	vx	D1,D1,A1
+	vx	D2,D2,A2
+	vx	D3,D3,A3
+	vx	D4,D4,A4
+	vx	D5,D5,A5
+	verllf	D0,D0,8
+	verllf	D1,D1,8
+	verllf	D2,D2,8
+	verllf	D3,D3,8
+	verllf	D4,D4,8
+	verllf	D5,D5,8
+
+	vaf	C0,C0,D0
+	vaf	C1,C1,D1
+	vaf	C2,C2,D2
+	vaf	C3,C3,D3
+	vaf	C4,C4,D4
+	vaf	C5,C5,D5
+	vx	B0,B0,C0
+	vx	B1,B1,C1
+	vx	B2,B2,C2
+	vx	B3,B3,C3
+	vx	B4,B4,C4
+	vx	B5,B5,C5
+	verllf	B0,B0,7
+	verllf	B1,B1,7
+	verllf	B2,B2,7
+	verllf	B3,B3,7
+	verllf	B4,B4,7
+	verllf	B5,B5,7
+
+	vsldb	C0,C0,C0,8
+	vsldb	C1,C1,C1,8
+	vsldb	C2,C2,C2,8
+	vsldb	C3,C3,C3,8
+	vsldb	C4,C4,C4,8
+	vsldb	C5,C5,C5,8
+	vsldb	B0,B0,B0,4
+	vsldb	B1,B1,B1,4
+	vsldb	B2,B2,B2,4
+	vsldb	B3,B3,B3,4
+	vsldb	B4,B4,B4,4
+	vsldb	B5,B5,B5,4
+	vsldb	D0,D0,D0,12
+	vsldb	D1,D1,D1,12
+	vsldb	D2,D2,D2,12
+	vsldb	D3,D3,D3,12
+	vsldb	D4,D4,D4,12
+	vsldb	D5,D5,D5,12
+
+	vaf	A0,A0,B0
+	vaf	A1,A1,B1
+	vaf	A2,A2,B2
+	vaf	A3,A3,B3
+	vaf	A4,A4,B4
+	vaf	A5,A5,B5
+	vx	D0,D0,A0
+	vx	D1,D1,A1
+	vx	D2,D2,A2
+	vx	D3,D3,A3
+	vx	D4,D4,A4
+	vx	D5,D5,A5
+	verllf	D0,D0,16
+	verllf	D1,D1,16
+	verllf	D2,D2,16
+	verllf	D3,D3,16
+	verllf	D4,D4,16
+	verllf	D5,D5,16
+
+	vaf	C0,C0,D0
+	vaf	C1,C1,D1
+	vaf	C2,C2,D2
+	vaf	C3,C3,D3
+	vaf	C4,C4,D4
+	vaf	C5,C5,D5
+	vx	B0,B0,C0
+	vx	B1,B1,C1
+	vx	B2,B2,C2
+	vx	B3,B3,C3
+	vx	B4,B4,C4
+	vx	B5,B5,C5
+	verllf	B0,B0,12
+	verllf	B1,B1,12
+	verllf	B2,B2,12
+	verllf	B3,B3,12
+	verllf	B4,B4,12
+	verllf	B5,B5,12
+
+	vaf	A0,A0,B0
+	vaf	A1,A1,B1
+	vaf	A2,A2,B2
+	vaf	A3,A3,B3
+	vaf	A4,A4,B4
+	vaf	A5,A5,B5
+	vx	D0,D0,A0
+	vx	D1,D1,A1
+	vx	D2,D2,A2
+	vx	D3,D3,A3
+	vx	D4,D4,A4
+	vx	D5,D5,A5
+	verllf	D0,D0,8
+	verllf	D1,D1,8
+	verllf	D2,D2,8
+	verllf	D3,D3,8
+	verllf	D4,D4,8
+	verllf	D5,D5,8
+
+	vaf	C0,C0,D0
+	vaf	C1,C1,D1
+	vaf	C2,C2,D2
+	vaf	C3,C3,D3
+	vaf	C4,C4,D4
+	vaf	C5,C5,D5
+	vx	B0,B0,C0
+	vx	B1,B1,C1
+	vx	B2,B2,C2
+	vx	B3,B3,C3
+	vx	B4,B4,C4
+	vx	B5,B5,C5
+	verllf	B0,B0,7
+	verllf	B1,B1,7
+	verllf	B2,B2,7
+	verllf	B3,B3,7
+	verllf	B4,B4,7
+	verllf	B5,B5,7
+
+	vsldb	C0,C0,C0,8
+	vsldb	C1,C1,C1,8
+	vsldb	C2,C2,C2,8
+	vsldb	C3,C3,C3,8
+	vsldb	C4,C4,C4,8
+	vsldb	C5,C5,C5,8
+	vsldb	B0,B0,B0,12
+	vsldb	B1,B1,B1,12
+	vsldb	B2,B2,B2,12
+	vsldb	B3,B3,B3,12
+	vsldb	B4,B4,B4,12
+	vsldb	B5,B5,B5,12
+	vsldb	D0,D0,D0,4
+	vsldb	D1,D1,D1,4
+	vsldb	D2,D2,D2,4
+	vsldb	D3,D3,D3,4
+	vsldb	D4,D4,D4,4
+	vsldb	D5,D5,D5,4
+	brct	%r0,.Loop_vx
+
+	vaf	A0,A0,K0
+	vaf	B0,B0,K1
+	vaf	C0,C0,K2
+	vaf	D0,D0,K3
+	vaf	A1,A1,K0
+	vaf	D1,D1,T1		# +K[3]+1
+
+	vperm	A0,A0,A0,BEPERM
+	vperm	B0,B0,B0,BEPERM
+	vperm	C0,C0,C0,BEPERM
+	vperm	D0,D0,D0,BEPERM
+
+	clgfi	LEN,0x40
+	jl	.Ltail_vx
+
+	vaf	D2,D2,T2		# +K[3]+2
+	vaf	D3,D3,T3		# +K[3]+3
+	vlm	T0,T3,0(INP),0
+
+	vx	A0,A0,T0
+	vx	B0,B0,T1
+	vx	C0,C0,T2
+	vx	D0,D0,T3
+
+	vlm	K0,T3,0(%r7),4		# re-load sigma and increments
+
+	vstm	A0,D0,0(OUT),0
+
+	la	INP,0x40(INP)
+	la	OUT,0x40(OUT)
+	aghi	LEN,-0x40
+	je	.Ldone_vx
+
+	vaf	B1,B1,K1
+	vaf	C1,C1,K2
+
+	vperm	A0,A1,A1,BEPERM
+	vperm	B0,B1,B1,BEPERM
+	vperm	C0,C1,C1,BEPERM
+	vperm	D0,D1,D1,BEPERM
+
+	clgfi	LEN,0x40
+	jl	.Ltail_vx
+
+	vlm	A1,D1,0(INP),0
+
+	vx	A0,A0,A1
+	vx	B0,B0,B1
+	vx	C0,C0,C1
+	vx	D0,D0,D1
+
+	vstm	A0,D0,0(OUT),0
+
+	la	INP,0x40(INP)
+	la	OUT,0x40(OUT)
+	aghi	LEN,-0x40
+	je	.Ldone_vx
+
+	vaf	A2,A2,K0
+	vaf	B2,B2,K1
+	vaf	C2,C2,K2
+
+	vperm	A0,A2,A2,BEPERM
+	vperm	B0,B2,B2,BEPERM
+	vperm	C0,C2,C2,BEPERM
+	vperm	D0,D2,D2,BEPERM
+
+	clgfi	LEN,0x40
+	jl	.Ltail_vx
+
+	vlm	A1,D1,0(INP),0
+
+	vx	A0,A0,A1
+	vx	B0,B0,B1
+	vx	C0,C0,C1
+	vx	D0,D0,D1
+
+	vstm	A0,D0,0(OUT),0
+
+	la	INP,0x40(INP)
+	la	OUT,0x40(OUT)
+	aghi	LEN,-0x40
+	je	.Ldone_vx
+
+	vaf	A3,A3,K0
+	vaf	B3,B3,K1
+	vaf	C3,C3,K2
+	vaf	D2,K3,T3		# K[3]+3
+
+	vperm	A0,A3,A3,BEPERM
+	vperm	B0,B3,B3,BEPERM
+	vperm	C0,C3,C3,BEPERM
+	vperm	D0,D3,D3,BEPERM
+
+	clgfi	LEN,0x40
+	jl	.Ltail_vx
+
+	vaf	D3,D2,T1		# K[3]+4
+	VLM	A1,D1,0(INP),0
+
+	vx	A0,A0,A1
+	vx	B0,B0,B1
+	vx	C0,C0,C1
+	vx	D0,D0,D1
+
+	vstm	A0,D0,0(OUT),0
+
+	la	INP,0x40(INP)
+	la	OUT,0x40(OUT)
+	aghi	LEN,-0x40
+	je	.Ldone_vx
+
+	vaf	A4,A4,K0
+	vaf	B4,B4,K1
+	vaf	C4,C4,K2
+	vaf	D4,D4,D3		# +K[3]+4
+	vaf	D3,D3,T1		# K[3]+5
+	vaf	K3,D2,T3		# K[3]+=6
+
+	vperm	A0,A4,A4,BEPERM
+	vperm	B0,B4,B4,BEPERM
+	vperm	C0,C4,C4,BEPERM
+	vperm	D0,D4,D4,BEPERM
+
+	clgfi	LEN,0x40
+	jl	.Ltail_vx
+
+	vlm	A1,D1,0(INP),0
+
+	vx	A0,A0,A1
+	vx	B0,B0,B1
+	vx	C0,C0,C1
+	vx	D0,D0,D1
+
+	vstm	A0,D0,0(OUT),0
+
+	la	INP,0x40(INP)
+	la	OUT,0x40(OUT)
+	aghi	LEN,-0x40
+	je	.Ldone_vx
+
+	vaf	A5,A5,K0
+	vaf	B5,B5,K1
+	vaf	C5,C5,K2
+	vaf	D5,D5,D3		# +K[3]+5
+
+	vperm	A0,A5,A5,BEPERM
+	vperm	B0,B5,B5,BEPERM
+	vperm	C0,C5,C5,BEPERM
+	vperm	D0,D5,D5,BEPERM
+
+	clgfi	LEN,0x40
+	jl	.Ltail_vx
+
+	vlm	A1,D1,0(INP),0
+
+	vx	A0,A0,A1
+	vx	B0,B0,B1
+	vx	C0,C0,C1
+	vx	D0,D0,D1
+
+	vstm	A0,D0,0(OUT),0
+
+	la	INP,0x40(INP)
+	la	OUT,0x40(OUT)
+	lhi	%r0,10
+	aghi	LEN,-0x40
+	jne	.Loop_outer_vx
+
+.Ldone_vx:
+	lmg	%r6,%r7,FRAME+6*8(SP)
+	la	SP,FRAME(SP)
+	br	%r14
+
+.Ltail_vx:
+	vstm	A0,D0,8*8(SP),3
+	lghi	%r1,0
+
+.Loop_tail_vx:
+	llgc	%r5,0(%r1,INP)
+	llgc	%r6,8*8(%r1,SP)
+	xr	%r6,%r5
+	stc	%r6,0(%r1,OUT)
+	la	%r1,1(%r1)
+	brct	LEN,.Loop_tail_vx
+
+	lmg	%r6,%r7,FRAME+6*8(SP)
+	la	SP,FRAME(SP)
+	br	%r14
+
+	.type	chacha20_vx, @function
+	.size	chacha20_vx, . - chacha20_vx
+	.globl	chacha20_vx
+
+.previous
+.section .note.GNU-stack,"",%progbits
-- 
2.34.1


