Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AD8988EA8
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Sep 2024 11:00:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suTIM-0003Xi-Fh; Sat, 28 Sep 2024 04:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTIJ-0003K0-Pt
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:59:15 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTIG-0002Pm-6H
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:59:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cb806623eso23298055e9.2
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 01:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1727513951; x=1728118751;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5GE78W+mN6uEIVTw8QGR5xCCkDAxEmOwTVSHyseW6I=;
 b=ORWH0Po2EE+G15v3KJHCF24IcGH5YIw//Fx/8TT50iVptOkZRfNjIvk6d3hwAroe8k
 4BMML7gY0hEjEEBOqum3sAR4mt9RnpOQsm7YlWPN601iXymKZwELBlEw4At0qxzcx06n
 YFiEm4nDlmwOj6NVoQAJ2mDtmj93lGMYJ8UyCpuDrVdcMvDZ9ZKxD30uRChWTjYUaq9e
 Q/pxgbszaxDgOseodHH7T/Sn6HjghAeR700PUhJ/ZuucdqNulioqBuMCLB3k3A3poUPH
 bugn4+gKSwHG9Un5nmR1cghKcC4HiO9d9ajlypJP59DdKjlJr6k0fRPBwHWdoDY+NWcu
 zH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727513951; x=1728118751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s5GE78W+mN6uEIVTw8QGR5xCCkDAxEmOwTVSHyseW6I=;
 b=YS9VG4Tbq3Zj00ZnF7fkhSSjxk4SLjL5chituvDLNN+1+MnSUulvlRv20GnCF15c3J
 PTbpS/7xTAa1k7Z01Wp4eN+zemduLZ02oQubWnl5ZHGZoMZ8Y+cXbfzPMno/oIpDNUsl
 wnfN4g6XleOglsQjJTLN/3x0TIEB8egwFo3B3uDyMxp5GneAky+WbYUiC343MEqV0H2f
 DIrlzmnmvpOIV1GnDma6RD673lJLDbv/bwfxfsx9PIDr7AXKhEYXP2eC8udrj1CDM3M8
 iclaCRHLPjOOWalPqXfXzcCVcEFaXa0OVqZuNpdzFyQ3xA3/zm6Z9ZxWUmIjjqWHuiq0
 f9Ow==
X-Gm-Message-State: AOJu0Yw9oOELGMtkFNjljOUfJR4WOTEukRviezntSU0/qc5aejrdme4h
 PLLLL/YTcnPWNpv2U2/tGkToycgwUQr/XNL1fD7LQTjbFGzCDt+RCO1wQY8j58xuJwMJvLuwd1c
 YKg==
X-Google-Smtp-Source: AGHT+IHA2izUfuhANExjGzzXRisS58eiLsaJoV1z6wlIRHSNVDI479qZfPjEtGjXAgK+/FcKS0nW9Q==
X-Received: by 2002:a05:600c:cc8:b0:428:1965:450d with SMTP id
 5b1f17b1804b1-42f58439cdcmr41480265e9.17.1727513950654; 
 Sat, 28 Sep 2024 01:59:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bb8:2ae:e42d:7dbb:76ba:120d:8a28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57423afsm4313167f8f.90.2024.09.28.01.59.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Sep 2024 01:59:10 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Subject: [PATCH v3 10/14] hw/vmapple/aes: Introduce aes engine
Date: Sat, 28 Sep 2024 10:57:23 +0200
Message-Id: <20240928085727.56883-11-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240928085727.56883-1-phil@philjordan.eu>
References: <20240928085727.56883-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::32b;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

VMApple contains an "aes" engine device that it uses to encrypt and
decrypt its nvram. It has trivial hard coded keys it uses for that
purpose.

Add device emulation for this device model.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

---
v3:

 * Rebased on latest upstream and fixed minor breakages.
 * Replaced legacy device reset method with Resettable method

 hw/vmapple/Kconfig      |   2 +
 hw/vmapple/aes.c        | 584 ++++++++++++++++++++++++++++++++++++++++
 hw/vmapple/meson.build  |   1 +
 hw/vmapple/trace-events |  19 ++
 4 files changed, 606 insertions(+)
 create mode 100644 hw/vmapple/aes.c

diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
index 8b137891791..a73504d5999 100644
--- a/hw/vmapple/Kconfig
+++ b/hw/vmapple/Kconfig
@@ -1 +1,3 @@
+config VMAPPLE_AES
+    bool
 
diff --git a/hw/vmapple/aes.c b/hw/vmapple/aes.c
new file mode 100644
index 00000000000..074fbdd9c36
--- /dev/null
+++ b/hw/vmapple/aes.c
@@ -0,0 +1,584 @@
+/*
+ * QEMU Apple AES device emulation
+ *
+ * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "trace.h"
+#include "hw/sysbus.h"
+#include "crypto/hash.h"
+#include "crypto/aes.h"
+#include "crypto/cipher.h"
+
+#define TYPE_AES          "apple-aes"
+#define MAX_FIFO_SIZE     9
+
+#define CMD_KEY           0x1
+#define CMD_KEY_CONTEXT_SHIFT    27
+#define CMD_KEY_CONTEXT_MASK     (0x1 << CMD_KEY_CONTEXT_SHIFT)
+#define CMD_KEY_SELECT_SHIFT     24
+#define CMD_KEY_SELECT_MASK      (0x7 << CMD_KEY_SELECT_SHIFT)
+#define CMD_KEY_KEY_LEN_SHIFT    22
+#define CMD_KEY_KEY_LEN_MASK     (0x3 << CMD_KEY_KEY_LEN_SHIFT)
+#define CMD_KEY_ENCRYPT_SHIFT    20
+#define CMD_KEY_ENCRYPT_MASK     (0x1 << CMD_KEY_ENCRYPT_SHIFT)
+#define CMD_KEY_BLOCK_MODE_SHIFT 16
+#define CMD_KEY_BLOCK_MODE_MASK  (0x3 << CMD_KEY_BLOCK_MODE_SHIFT)
+#define CMD_IV            0x2
+#define CMD_IV_CONTEXT_SHIFT     26
+#define CMD_IV_CONTEXT_MASK      (0x3 << CMD_KEY_CONTEXT_SHIFT)
+#define CMD_DSB           0x3
+#define CMD_SKG           0x4
+#define CMD_DATA          0x5
+#define CMD_DATA_KEY_CTX_SHIFT   27
+#define CMD_DATA_KEY_CTX_MASK    (0x1 << CMD_DATA_KEY_CTX_SHIFT)
+#define CMD_DATA_IV_CTX_SHIFT    25
+#define CMD_DATA_IV_CTX_MASK     (0x3 << CMD_DATA_IV_CTX_SHIFT)
+#define CMD_DATA_LEN_MASK        0xffffff
+#define CMD_STORE_IV      0x6
+#define CMD_STORE_IV_ADDR_MASK   0xffffff
+#define CMD_WRITE_REG     0x7
+#define CMD_FLAG          0x8
+#define CMD_FLAG_STOP_MASK       BIT(26)
+#define CMD_FLAG_RAISE_IRQ_MASK  BIT(27)
+#define CMD_FLAG_INFO_MASK       0xff
+#define CMD_MAX           0x10
+
+#define CMD_SHIFT         28
+
+#define REG_STATUS            0xc
+#define REG_STATUS_DMA_READ_RUNNING     BIT(0)
+#define REG_STATUS_DMA_READ_PENDING     BIT(1)
+#define REG_STATUS_DMA_WRITE_RUNNING    BIT(2)
+#define REG_STATUS_DMA_WRITE_PENDING    BIT(3)
+#define REG_STATUS_BUSY                 BIT(4)
+#define REG_STATUS_EXECUTING            BIT(5)
+#define REG_STATUS_READY                BIT(6)
+#define REG_STATUS_TEXT_DPA_SEEDED      BIT(7)
+#define REG_STATUS_UNWRAP_DPA_SEEDED    BIT(8)
+
+#define REG_IRQ_STATUS        0x18
+#define REG_IRQ_STATUS_INVALID_CMD      BIT(2)
+#define REG_IRQ_STATUS_FLAG             BIT(5)
+#define REG_IRQ_ENABLE        0x1c
+#define REG_WATERMARK         0x20
+#define REG_Q_STATUS          0x24
+#define REG_FLAG_INFO         0x30
+#define REG_FIFO              0x200
+
+static const uint32_t key_lens[4] = {
+    [0] = 16,
+    [1] = 24,
+    [2] = 32,
+    [3] = 64,
+};
+
+struct key {
+    uint32_t key_len;
+    uint32_t key[8];
+};
+
+struct iv {
+    uint32_t iv[4];
+};
+
+struct context {
+    struct key key;
+    struct iv iv;
+};
+
+static struct key builtin_keys[7] = {
+    [1] = {
+        .key_len = 32,
+        .key = { 0x1 },
+    },
+    [2] = {
+        .key_len = 32,
+        .key = { 0x2 },
+    },
+    [3] = {
+        .key_len = 32,
+        .key = { 0x3 },
+    }
+};
+
+typedef struct AESState {
+    /* Private */
+    SysBusDevice parent_obj;
+
+    /* Public */
+    qemu_irq irq;
+    MemoryRegion iomem1;
+    MemoryRegion iomem2;
+
+    uint32_t status;
+    uint32_t q_status;
+    uint32_t irq_status;
+    uint32_t irq_enable;
+    uint32_t watermark;
+    uint32_t flag_info;
+    uint32_t fifo[MAX_FIFO_SIZE];
+    uint32_t fifo_idx;
+    struct key key[2];
+    struct iv iv[4];
+    bool is_encrypt;
+    QCryptoCipherMode block_mode;
+} AESState;
+
+OBJECT_DECLARE_SIMPLE_TYPE(AESState, AES)
+
+static void aes_update_irq(AESState *s)
+{
+    qemu_set_irq(s->irq, !!(s->irq_status & s->irq_enable));
+}
+
+static uint64_t aes1_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AESState *s = opaque;
+    uint64_t res = 0;
+
+    switch (offset) {
+    case REG_STATUS:
+        res = s->status;
+        break;
+    case REG_IRQ_STATUS:
+        res = s->irq_status;
+        break;
+    case REG_IRQ_ENABLE:
+        res = s->irq_enable;
+        break;
+    case REG_WATERMARK:
+        res = s->watermark;
+        break;
+    case REG_Q_STATUS:
+        res = s->q_status;
+        break;
+    case REG_FLAG_INFO:
+        res = s->flag_info;
+        break;
+
+    default:
+        trace_aes_read_unknown(offset);
+        break;
+    }
+
+    trace_aes_read(offset, res);
+
+    return res;
+}
+
+static void fifo_append(AESState *s, uint64_t val)
+{
+    if (s->fifo_idx == MAX_FIFO_SIZE) {
+        /* Exceeded the FIFO. Bail out */
+        return;
+    }
+
+    s->fifo[s->fifo_idx++] = val;
+}
+
+static bool has_payload(AESState *s, uint32_t elems)
+{
+    return s->fifo_idx >= (elems + 1);
+}
+
+static bool cmd_key(AESState *s)
+{
+    uint32_t cmd = s->fifo[0];
+    uint32_t key_select = (cmd & CMD_KEY_SELECT_MASK) >> CMD_KEY_SELECT_SHIFT;
+    uint32_t ctxt = (cmd & CMD_KEY_CONTEXT_MASK) >> CMD_KEY_CONTEXT_SHIFT;
+    uint32_t key_len;
+
+    switch ((cmd & CMD_KEY_BLOCK_MODE_MASK) >> CMD_KEY_BLOCK_MODE_SHIFT) {
+    case 0:
+        s->block_mode = QCRYPTO_CIPHER_MODE_ECB;
+        break;
+    case 1:
+        s->block_mode = QCRYPTO_CIPHER_MODE_CBC;
+        break;
+    default:
+        return false;
+    }
+
+    s->is_encrypt = !!((cmd & CMD_KEY_ENCRYPT_MASK) >> CMD_KEY_ENCRYPT_SHIFT);
+    key_len = key_lens[((cmd & CMD_KEY_KEY_LEN_MASK) >> CMD_KEY_KEY_LEN_SHIFT)];
+
+    if (key_select) {
+        trace_aes_cmd_key_select_builtin(ctxt, key_select,
+                                         s->is_encrypt ? "en" : "de",
+                                         QCryptoCipherMode_str(s->block_mode));
+        s->key[ctxt] = builtin_keys[key_select];
+    } else {
+        trace_aes_cmd_key_select_new(ctxt, key_len,
+                                     s->is_encrypt ? "en" : "de",
+                                     QCryptoCipherMode_str(s->block_mode));
+        if (key_len > sizeof(s->key[ctxt].key)) {
+            return false;
+        }
+        if (!has_payload(s, key_len / sizeof(uint32_t))) {
+            /* wait for payload */
+            return false;
+        }
+        memcpy(&s->key[ctxt].key, &s->fifo[1], key_len);
+        s->key[ctxt].key_len = key_len;
+    }
+
+    return true;
+}
+
+static bool cmd_iv(AESState *s)
+{
+    uint32_t cmd = s->fifo[0];
+    uint32_t ctxt = (cmd & CMD_IV_CONTEXT_MASK) >> CMD_IV_CONTEXT_SHIFT;
+
+    if (!has_payload(s, 4)) {
+        /* wait for payload */
+        return false;
+    }
+    memcpy(&s->iv[ctxt].iv, &s->fifo[1], sizeof(s->iv[ctxt].iv));
+    trace_aes_cmd_iv(ctxt, s->fifo[1], s->fifo[2], s->fifo[3], s->fifo[4]);
+
+    return true;
+}
+
+static char hexdigit2str(uint8_t val)
+{
+    g_assert(val < 0x10);
+    if (val >= 0xa) {
+        return 'a' + (val - 0xa);
+    } else {
+        return '0' + val;
+    }
+}
+
+static void dump_data(const char *desc, const void *p, size_t len)
+{
+    char *hex = alloca((len * 2) + 1);
+    const uint8_t *data = p;
+    char *hexp = hex;
+    size_t i;
+
+    if (len > 0x1000) {
+        /* Too large buffer, let's bail out */
+        return;
+    }
+
+    for (i = 0; i < len; i++) {
+        uint8_t val = data[i];
+        *(hexp++) = hexdigit2str(val >> 4);
+        *(hexp++) = hexdigit2str(val & 0xf);
+    }
+    *hexp = '\0';
+
+    trace_aes_dump_data(desc, hex);
+}
+
+static bool cmd_data(AESState *s)
+{
+    uint32_t cmd = s->fifo[0];
+    uint32_t ctxt_iv = 0;
+    uint32_t ctxt_key = (cmd & CMD_DATA_KEY_CTX_MASK) >> CMD_DATA_KEY_CTX_SHIFT;
+    uint32_t len = cmd & CMD_DATA_LEN_MASK;
+    uint64_t src_addr = s->fifo[2];
+    uint64_t dst_addr = s->fifo[3];
+    QCryptoCipherAlgo alg;
+    QCryptoCipher *cipher;
+    char *src;
+    char *dst;
+
+    src_addr |= ((uint64_t)s->fifo[1] << 16) & 0xffff00000000ULL;
+    dst_addr |= ((uint64_t)s->fifo[1] << 32) & 0xffff00000000ULL;
+
+    trace_aes_cmd_data(ctxt_key, ctxt_iv, src_addr, dst_addr, len);
+
+    if (!has_payload(s, 3)) {
+        /* wait for payload */
+        trace_aes_cmd_data_error("No payload");
+        return false;
+    }
+
+    if (ctxt_key >= ARRAY_SIZE(s->key) ||
+        ctxt_iv >= ARRAY_SIZE(s->iv)) {
+        /* Invalid input */
+        trace_aes_cmd_data_error("Invalid key or iv");
+        return false;
+    }
+
+    src = g_malloc0(len);
+    dst = g_malloc0(len);
+
+    cpu_physical_memory_read(src_addr, src, len);
+
+    dump_data("cmd_data(): src_data=", src, len);
+
+    switch (s->key[ctxt_key].key_len) {
+    case 128 / 8:
+        alg = QCRYPTO_CIPHER_ALGO_AES_128;
+        break;
+    case 192 / 8:
+        alg = QCRYPTO_CIPHER_ALGO_AES_192;
+        break;
+    case 256 / 8:
+        alg = QCRYPTO_CIPHER_ALGO_AES_256;
+        break;
+    default:
+        trace_aes_cmd_data_error("Invalid key len");
+        goto err_free;
+    }
+    cipher = qcrypto_cipher_new(alg, s->block_mode,
+                                (void *)s->key[ctxt_key].key,
+                                s->key[ctxt_key].key_len, NULL);
+    g_assert(cipher != NULL);
+    if (s->block_mode != QCRYPTO_CIPHER_MODE_ECB) {
+        if (qcrypto_cipher_setiv(cipher, (void *)s->iv[ctxt_iv].iv,
+                                 sizeof(s->iv[ctxt_iv].iv), NULL) != 0) {
+            trace_aes_cmd_data_error("Failed to set IV");
+            goto err_free_cipher;
+        }
+    }
+    if (s->is_encrypt) {
+        if (qcrypto_cipher_encrypt(cipher, src, dst, len, NULL) != 0) {
+            trace_aes_cmd_data_error("Encrypt failed");
+            goto err_free_cipher;
+        }
+    } else {
+        if (qcrypto_cipher_decrypt(cipher, src, dst, len, NULL) != 0) {
+            trace_aes_cmd_data_error("Decrypt failed");
+            goto err_free_cipher;
+        }
+    }
+    qcrypto_cipher_free(cipher);
+
+    dump_data("cmd_data(): dst_data=", dst, len);
+    cpu_physical_memory_write(dst_addr, dst, len);
+    g_free(src);
+    g_free(dst);
+
+    return true;
+
+err_free_cipher:
+    qcrypto_cipher_free(cipher);
+err_free:
+    g_free(src);
+    g_free(dst);
+    return false;
+}
+
+static bool cmd_store_iv(AESState *s)
+{
+    uint32_t cmd = s->fifo[0];
+    uint32_t ctxt = (cmd & CMD_IV_CONTEXT_MASK) >> CMD_IV_CONTEXT_SHIFT;
+    uint64_t addr = s->fifo[1];
+
+    if (!has_payload(s, 1)) {
+        /* wait for payload */
+        return false;
+    }
+
+    if (ctxt >= ARRAY_SIZE(s->iv)) {
+        /* Invalid context selected */
+        return false;
+    }
+
+    addr |= ((uint64_t)cmd << 32) & 0xff00000000ULL;
+    cpu_physical_memory_write(addr, &s->iv[ctxt].iv, sizeof(s->iv[ctxt].iv));
+
+    trace_aes_cmd_store_iv(ctxt, addr, s->iv[ctxt].iv[0], s->iv[ctxt].iv[1],
+                           s->iv[ctxt].iv[2], s->iv[ctxt].iv[3]);
+
+    return true;
+}
+
+static bool cmd_flag(AESState *s)
+{
+    uint32_t cmd = s->fifo[0];
+    uint32_t raise_irq = cmd & CMD_FLAG_RAISE_IRQ_MASK;
+
+    /* We always process data when it's coming in, so fire an IRQ immediately */
+    if (raise_irq) {
+        s->irq_status |= REG_IRQ_STATUS_FLAG;
+    }
+
+    s->flag_info = cmd & CMD_FLAG_INFO_MASK;
+
+    trace_aes_cmd_flag(!!raise_irq, s->flag_info);
+
+    return true;
+}
+
+static void fifo_process(AESState *s)
+{
+    uint32_t cmd = s->fifo[0] >> CMD_SHIFT;
+    bool success = false;
+
+    if (!s->fifo_idx) {
+        return;
+    }
+
+    switch (cmd) {
+    case CMD_KEY:
+        success = cmd_key(s);
+        break;
+    case CMD_IV:
+        success = cmd_iv(s);
+        break;
+    case CMD_DATA:
+        success = cmd_data(s);
+        break;
+    case CMD_STORE_IV:
+        success = cmd_store_iv(s);
+        break;
+    case CMD_FLAG:
+        success = cmd_flag(s);
+        break;
+    default:
+        s->irq_status |= REG_IRQ_STATUS_INVALID_CMD;
+        break;
+    }
+
+    if (success) {
+        s->fifo_idx = 0;
+    }
+
+    trace_aes_fifo_process(cmd, success ? 1 : 0);
+}
+
+static void aes1_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    AESState *s = opaque;
+
+    trace_aes_write(offset, val);
+
+    switch (offset) {
+    case REG_IRQ_STATUS:
+        s->irq_status &= ~val;
+        break;
+    case REG_IRQ_ENABLE:
+        s->irq_enable = val;
+        break;
+    case REG_FIFO:
+        fifo_append(s, val);
+        fifo_process(s);
+        break;
+    default:
+        trace_aes_write_unknown(offset);
+        return;
+    }
+
+    aes_update_irq(s);
+}
+
+static const MemoryRegionOps aes1_ops = {
+    .read = aes1_read,
+    .write = aes1_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static uint64_t aes2_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint64_t res = 0;
+
+    switch (offset) {
+    case 0:
+        res = 0;
+        break;
+    default:
+        trace_aes_2_read_unknown(offset);
+        break;
+    }
+
+    trace_aes_2_read(offset, res);
+
+    return res;
+}
+
+static void aes2_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    trace_aes_2_write(offset, val);
+
+    switch (offset) {
+    default:
+        trace_aes_2_write_unknown(offset);
+        return;
+    }
+}
+
+static const MemoryRegionOps aes2_ops = {
+    .read = aes2_read,
+    .write = aes2_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void aes_reset(Object *obj, ResetType type)
+{
+    AESState *s = AES(obj);
+
+    s->status = 0x3f80;
+    s->q_status = 2;
+    s->irq_status = 0;
+    s->irq_enable = 0;
+    s->watermark = 0;
+}
+
+static void aes_init(Object *obj)
+{
+    AESState *s = AES(obj);
+
+    memory_region_init_io(&s->iomem1, obj, &aes1_ops, s, TYPE_AES, 0x4000);
+    memory_region_init_io(&s->iomem2, obj, &aes2_ops, s, TYPE_AES, 0x4000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem1);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem2);
+    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
+}
+
+static void aes_realize(DeviceState *dev, Error **errp)
+{
+}
+
+static void aes_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = aes_reset;
+    dc->realize = aes_realize;
+}
+
+static const TypeInfo aes_info = {
+    .name          = TYPE_AES,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AESState),
+    .class_init    = aes_class_init,
+    .instance_init = aes_init,
+};
+
+static void aes_register_types(void)
+{
+    type_register_static(&aes_info);
+}
+
+type_init(aes_register_types)
diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
index e69de29bb2d..bcd4dcb28d2 100644
--- a/hw/vmapple/meson.build
+++ b/hw/vmapple/meson.build
@@ -0,0 +1 @@
+system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events
index 9ccc5790487..1c9a3326eb4 100644
--- a/hw/vmapple/trace-events
+++ b/hw/vmapple/trace-events
@@ -1,2 +1,21 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# aes.c
+aes_read_unknown(uint64_t offset) "offset=0x%"PRIx64
+aes_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
+aes_cmd_key_select_builtin(uint32_t ctx, uint32_t key_id, const char *direction, const char *cipher) "[%d] Selecting builtin key %d to %scrypt with %s"
+aes_cmd_key_select_new(uint32_t ctx, uint32_t key_len, const char *direction, const char *cipher) "[%d] Selecting new key size=%d to %scrypt with %s"
+aes_cmd_iv(uint32_t ctx, uint32_t iv0, uint32_t iv1, uint32_t iv2, uint32_t iv3) "[%d] 0x%08x 0x%08x 0x%08x 0x%08x"
+aes_cmd_data(uint32_t key, uint32_t iv, uint64_t src, uint64_t dst, uint32_t len) "[key=%d iv=%d] src=0x%"PRIx64" dst=0x%"PRIx64" len=0x%x"
+aes_cmd_data_error(const char *reason) "reason=%s"
+aes_cmd_store_iv(uint32_t ctx, uint64_t addr, uint32_t iv0, uint32_t iv1, uint32_t iv2, uint32_t iv3) "[%d] addr=0x%"PRIx64"x -> 0x%08x 0x%08x 0x%08x 0x%08x"
+aes_cmd_flag(uint32_t raise, uint32_t flag_info) "raise=%d flag_info=0x%x"
+aes_fifo_process(uint32_t cmd, uint32_t success) "cmd=%d success=%d"
+aes_write_unknown(uint64_t offset) "offset=0x%"PRIx64
+aes_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
+aes_2_read_unknown(uint64_t offset) "offset=0x%"PRIx64
+aes_2_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
+aes_2_write_unknown(uint64_t offset) "offset=0x%"PRIx64
+aes_2_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
+aes_dump_data(const char *desc, const char *hex) "%s%s"
+
-- 
2.39.3 (Apple Git-145)


