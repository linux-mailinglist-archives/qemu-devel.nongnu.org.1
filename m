Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A016763A24
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:05:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWu-00037V-Lt; Wed, 26 Jul 2023 09:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWP-0002ky-I5; Wed, 26 Jul 2023 09:25:47 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWM-0003Gz-V2; Wed, 26 Jul 2023 09:25:45 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fbb281eec6so10687905e87.1; 
 Wed, 26 Jul 2023 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377940; x=1690982740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JgGkyVWJMQK7TKygVcUEwT34yJ1BOQ4MC4oIpVtceNU=;
 b=U9kdHREFcnNHlLUt3alpYWYEGSOb69XY5nI2Q7bULLKBamoeixRWqvJ7DG1NsNBgbi
 aOI/r+8b+GuMxhRulbU1jHJQlDhuJrda2RbRHxuGDzbPY3uRAfWlgB961sbFO2mQH04k
 vPsCSHYGIyOMYfvg7rTFY6b/AWdkJ7undkkcSeFYoIEHfm0z6P/2NsjAgfTxsRyTX0mv
 wOb+tDzXXNlVy/RkNZdYr7t218iqS5VelEp/fSKXgiwGtQgfGP+A4iSLNvs3Wy6aDybw
 KepNGrrNH2mJB8UAhbki04IHU86iRbooPXxCgkzHURJqQgzZsEtLcGDNjnsozqqjPQm+
 cRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377940; x=1690982740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JgGkyVWJMQK7TKygVcUEwT34yJ1BOQ4MC4oIpVtceNU=;
 b=L6XQksB41MNjtSkyc6bI8JyyQV+t7M65o9o23UA6OcOOCr3gQVZHD6BR/X0qzfUcdF
 8VApP7VOL2bKxmj1VR3iHTRF26FjhDfpnnyIJx8louOXSSsfmNyMlBa88AaXCxfVg+v0
 OUoXchrQEkscXm9T6a/Va48T0OZUrrl6T7R3l0ymGOzExdqdolo3R8TY7on78p8gqiaw
 dDUUk0RhKjDuDa7bumuYyQHhqcBMj1QU9EBihTNsF1zwN9f83zx7r1SNsJv2HPXhtM6c
 nkjtjqmznzjWGFHJ6c8EknB9SNykMepHeVCPhd+nGk/Py/CZqIX+wIGA+VUWLsYo+cFv
 E5vw==
X-Gm-Message-State: ABy/qLYm8uuT++ePQx7OUSNo2PAIwbg5QxUeoeQ9+W1wXly4fqyQk1ct
 JV9g522mmJ0+Ou1jXF7DJLdUKM+LTd4=
X-Google-Smtp-Source: APBJJlEZ9Uaw0wqTHiqj6ZG03DxmH1iWLAn37Kug9tF2Uwtakl3Cokc5hWcX1cPaLa5C+UjMXbjjtw==
X-Received: by 2002:a05:6512:68c:b0:4fe:af1:c3ae with SMTP id
 t12-20020a056512068c00b004fe0af1c3aemr1692793lfe.15.1690377940054; 
 Wed, 26 Jul 2023 06:25:40 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:39 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 18/44] Add RNG200 RNG and RBG
Date: Wed, 26 Jul 2023 16:24:46 +0300
Message-Id: <20230726132512.149618-19-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/misc/bcm2838_rng200.c | 218 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 1 deletion(-)

diff --git a/hw/misc/bcm2838_rng200.c b/hw/misc/bcm2838_rng200.c
index a17e8f2cda..bfc40658e2 100644
--- a/hw/misc/bcm2838_rng200.c
+++ b/hw/misc/bcm2838_rng200.c
@@ -8,23 +8,194 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/misc/bcm2838_rng200.h"
 #include "trace.h"
 
+#define RNG_CTRL_OFFSET                      0x00
+#define RNG_SOFT_RESET                       0x01
+#define RNG_SOFT_RESET_OFFSET                0x04
+#define RBG_SOFT_RESET_OFFSET                0x08
+#define RNG_TOTAL_BIT_COUNT_OFFSET           0x0C
+#define RNG_TOTAL_BIT_COUNT_THRESHOLD_OFFSET 0x10
+#define RNG_INT_STATUS_OFFSET                0x18
+#define RNG_INT_ENABLE_OFFSET                0x1C
+#define RNG_FIFO_DATA_OFFSET                 0x20
+#define RNG_FIFO_COUNT_OFFSET                0x24
+
+#define RNG_WARM_UP_PERIOD_ELAPSED           17
+
+#define BCM2838_RNG200_PTIMER_POLICY         (PTIMER_POLICY_CONTINUOUS_TRIGGER)
+
+static void bcm2838_rng200_update_irq(BCM2838Rng200State *state)
+{
+    qemu_set_irq(state->irq, !!(state->rng_int_enable.value
+                              & state->rng_int_status.value));
+}
+
+static void bcm2838_rng200_update_fifo(void *opaque, const void *buf,
+                                       size_t size)
+{
+    BCM2838Rng200State *state = (BCM2838Rng200State *)opaque;
+    Fifo8 *fifo = &state->fifo;
+    size_t num = MIN(size, fifo8_num_free(fifo));
+    uint32_t num_bits = num * 8;
+    uint32_t bit_threshold_left = 0;
+
+    state->rng_total_bit_count += num_bits;
+    if (state->rng_bit_count_threshold > state->rng_total_bit_count) {
+        bit_threshold_left =
+            state->rng_bit_count_threshold - state->rng_total_bit_count;
+    } else {
+        bit_threshold_left = 0;
+    }
+
+    if (bit_threshold_left < num_bits) {
+        num_bits -= bit_threshold_left;
+    } else {
+        num_bits = 0;
+    }
+
+    num = num_bits / 8;
+    if ((num == 0) && (num_bits > 0)) {
+        num = 1;
+    }
+    if (num > 0) {
+        fifo8_push_all(fifo, buf, num);
+
+        if (fifo8_num_used(fifo) > state->rng_fifo_count.thld) {
+            state->rng_int_status.total_bits_count_irq = 1;
+        }
+    }
+
+    state->rng_fifo_count.count = fifo8_num_used(fifo) >> 2;
+    bcm2838_rng200_update_irq(state);
+    trace_bcm2838_rng200_update_fifo(num, fifo8_num_used(fifo));
+}
+
+static void bcm2838_rng200_fill_fifo(BCM2838Rng200State *state)
+{
+    rng_backend_request_entropy(state->rng,
+                                fifo8_num_free(&state->fifo),
+                                bcm2838_rng200_update_fifo, state);
+}
+
+/* state is temporary unused */
+static void bcm2838_rng200_disable_rbg(BCM2838Rng200State *state
+                                       __attribute__((unused)))
+{
+    trace_bcm2838_rng200_disable_rbg();
+}
+
+static void bcm2838_rng200_enable_rbg(BCM2838Rng200State *state)
+{
+    state->rng_total_bit_count = RNG_WARM_UP_PERIOD_ELAPSED;
+
+    bcm2838_rng200_fill_fifo(state);
+
+    trace_bcm2838_rng200_enable_rbg();
+}
+
 static void bcm2838_rng200_rng_reset(BCM2838Rng200State *state)
 {
     state->rng_ctrl.value = 0;
+    state->rng_total_bit_count = 0;
+    state->rng_bit_count_threshold = 0;
+    state->rng_fifo_count.value = 0;
+    state->rng_int_status.value = 0;
+    state->rng_int_status.startup_transition_met_irq = 1;
+    state->rng_int_enable.value = 0;
+    fifo8_reset(&state->fifo);
 
     trace_bcm2838_rng200_rng_soft_reset();
 }
 
+static void bcm2838_rng200_rbg_reset(BCM2838Rng200State *state)
+{
+    trace_bcm2838_rng200_rbg_soft_reset();
+}
+
+static uint32_t bcm2838_rng200_read_fifo_data(BCM2838Rng200State *state)
+{
+    Fifo8 *fifo = &state->fifo;
+    const uint8_t *buf;
+    uint32_t ret = 0;
+    uint32_t num = 0;
+    uint32_t max = MIN(fifo8_num_used(fifo), sizeof(ret));
+
+    if (max > 0) {
+        buf = fifo8_pop_buf(fifo, max, &num);
+        if ((buf != NULL) && (num > 0)) {
+            memcpy(&ret, buf, num);
+        }
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "bcm2838_rng200_read_fifo_data: FIFO is empty\n"
+        );
+    }
+
+    state->rng_fifo_count.count = fifo8_num_used(fifo) >> 2;
+    bcm2838_rng200_fill_fifo(state);
+
+    return ret;
+}
+
+static void bcm2838_rng200_ctrl_write(BCM2838Rng200State *s, uint64_t value)
+{
+    bool rng_enable = s->rng_ctrl.rbg_enable;
+
+    s->rng_ctrl.value = value;
+    if (!s->rng_ctrl.rbg_enable && rng_enable) {
+        bcm2838_rng200_disable_rbg(s);
+    } else if (s->rng_ctrl.rbg_enable && !rng_enable) {
+        bcm2838_rng200_enable_rbg(s);
+    }
+}
+
 static uint64_t bcm2838_rng200_read(void *opaque, hwaddr offset,
                                     unsigned size)
 {
+    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
     uint32_t res = 0;
 
+    switch (offset) {
+    case RNG_CTRL_OFFSET:
+        res = s->rng_ctrl.value;
+        break;
+    case RNG_SOFT_RESET_OFFSET:
+    case RBG_SOFT_RESET_OFFSET:
+        break;
+    case RNG_INT_STATUS_OFFSET:
+        res = s->rng_int_status.value;
+        break;
+    case RNG_INT_ENABLE_OFFSET:
+        res = s->rng_int_enable.value;
+        break;
+    case RNG_FIFO_DATA_OFFSET:
+        res = bcm2838_rng200_read_fifo_data(s);
+        break;
+    case RNG_FIFO_COUNT_OFFSET:
+        res = s->rng_fifo_count.value;
+        break;
+    case RNG_TOTAL_BIT_COUNT_OFFSET:
+        res = s->rng_total_bit_count;
+        break;
+    case RNG_TOTAL_BIT_COUNT_THRESHOLD_OFFSET:
+        res = s->rng_bit_count_threshold;
+        break;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "bcm2838_rng200_read: Bad offset 0x%" HWADDR_PRIx "\n",
+            offset
+        );
+        res = 0;
+        break;
+    }
+
     trace_bcm2838_rng200_read((void *)offset, size, res);
     return res;
 }
@@ -32,8 +203,50 @@ static uint64_t bcm2838_rng200_read(void *opaque, hwaddr offset,
 static void bcm2838_rng200_write(void *opaque, hwaddr offset,
                                  uint64_t value, unsigned size)
 {
+    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
 
     trace_bcm2838_rng200_write((void *)offset, value, size);
+
+    switch (offset) {
+    case RNG_CTRL_OFFSET:
+        bcm2838_rng200_ctrl_write(s, value);
+        break;
+    case RNG_SOFT_RESET_OFFSET:
+        if (value & RNG_SOFT_RESET) {
+            bcm2838_rng200_rng_reset(s);
+        }
+        break;
+    case RBG_SOFT_RESET_OFFSET:
+        if (value & RNG_SOFT_RESET) {
+            bcm2838_rng200_rbg_reset(s);
+        }
+        break;
+    case RNG_INT_STATUS_OFFSET:
+        s->rng_int_status.value &= ~value;
+        bcm2838_rng200_update_irq(s);
+        break;
+    case RNG_INT_ENABLE_OFFSET:
+        s->rng_int_enable.value = value;
+        bcm2838_rng200_update_irq(s);
+        break;
+    case RNG_FIFO_COUNT_OFFSET:
+        {
+            BCM2838Rng200FifoCount tmp = {.value = value};
+            s->rng_fifo_count.thld = tmp.thld;
+        }
+        break;
+    case RNG_TOTAL_BIT_COUNT_THRESHOLD_OFFSET:
+        s->rng_bit_count_threshold = value;
+        s->rng_total_bit_count = value + 1;
+        break;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "bcm2838_rng200_write: Bad offset 0x%" HWADDR_PRIx "\n",
+            offset
+        );
+        break;
+    }
 }
 
 static const MemoryRegionOps bcm2838_rng200_ops = {
@@ -57,6 +270,7 @@ static void bcm2838_rng200_realize(DeviceState *dev, Error **errp)
                                  errp);
     }
 
+    fifo8_create(&s->fifo, s->rng_fifo_cap);
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 }
 
@@ -81,6 +295,8 @@ static void bcm2838_rng200_init(Object *obj)
 static void bcm2838_rng200_reset(DeviceState *dev)
 {
     BCM2838Rng200State *s = BCM2838_RNG200(dev);
+
+    bcm2838_rng200_rbg_reset(s);
     bcm2838_rng200_rng_reset(s);
 }
 
@@ -89,7 +305,7 @@ static Property bcm2838_rng200_properties[] = {
     DEFINE_PROP_UINT32("rng-fifo-cap", BCM2838Rng200State, rng_fifo_cap, 128),
     DEFINE_PROP_LINK("rng", BCM2838Rng200State, rng,
                      TYPE_RNG_BACKEND, RngBackend *),
-    DEFINE_PROP_BOOL("use-timer", BCM2838Rng200State, use_timer, true),
+    DEFINE_PROP_BOOL("use-timer", BCM2838Rng200State, use_timer, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


