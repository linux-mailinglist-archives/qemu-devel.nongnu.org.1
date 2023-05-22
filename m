Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCEB70C27B
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:34:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17Wc-0007VB-Bm; Mon, 22 May 2023 11:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17W4-0007NO-6T
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17W2-0001Lg-AC
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f42b984405so38783925e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684769524; x=1687361524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/v69wjcgQjzqhC98DKwcbYpCW+hDbd/3U2ovkdSDfw=;
 b=GcIeHWq7ho6Wb3vxdbkOS5rHBfm+Q2V7gO4V4OinnFC6S0gSjLClHkroxEPcEyBaiu
 7MN6KFbKVsg6IS2/mEYBDXvvWGb5hFPXSOYD8BTCxDIs2O3v0Z2hXbxqz/04U0D2XO81
 zfmxZ1tI2Kgjtvi4WPDOOwZx+MhlPIzOCmN//oGJgNdRbHG98G30XTWgB4dArEtQHTEs
 yPZoNvsSaATl7Vpc/dk4BOvEEwPVxp1b6X2mlxkv8eqLchb+TTC1dtkBsUF2CWhh1B0C
 AXudY0VYO+0Jz0PNoSG0gV0Y410OlUG7MEioweVbxP+FhwaiBT/CsVCVxoCnsld6T4Ej
 X1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684769524; x=1687361524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/v69wjcgQjzqhC98DKwcbYpCW+hDbd/3U2ovkdSDfw=;
 b=f82gFw7GBNDKrOXc1Qn/DOfzCecOlbwYlv2FRwViaTFNDrkaP8/fnzEVo0+WTDmrHo
 yb2H/rRrSJgQ4bpfrck2FsMG81U1FVrGDEYbdFVkJGDzYBdGsh6R2DWELivhIIc2o8rQ
 BjTldXkvECJkd/uVRk6J+Ho+ts3FiwhuEOoLyLYLCh7hWs1F6vPjZRpM7LR2JciTiQNK
 kM1T0NiVysWS4UYC0cjS2uZ4PtDaBvY8m0xZ99UZlvs9UCtQebI0jv168H2HdN+/JA5g
 WJz/PsR/LrMtcTZvTLizEue5jUkJfSJy0eFAvOAsgNTTegCmugABKIOCuW5Wsll2LS/Z
 8Reg==
X-Gm-Message-State: AC+VfDzHbGckKVYMSlLIEGk4FFRaFErVIn22ypKCveL772u5wFFj442r
 E2LU36hBs3V5O7wunNGaF0kO5xDPyNxCrOQUawY=
X-Google-Smtp-Source: ACHHUZ4DB49NeA6IuP4gNB8rRn3/y8nnkvLLXF4r34C3aepgjSKB030tIOAZ6MWs9ndDwosRDKjDMA==
X-Received: by 2002:a1c:f70e:0:b0:3f4:2b1a:553b with SMTP id
 v14-20020a1cf70e000000b003f42b1a553bmr7727352wmh.28.1684769524506; 
 Mon, 22 May 2023 08:32:04 -0700 (PDT)
Received: from localhost.localdomain ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a1c7503000000b003f09d7b6e20sm8747145wmc.2.2023.05.22.08.32.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 08:32:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/12] util/fifo8: Introduce fifo8_peek_buf()
Date: Mon, 22 May 2023 17:31:35 +0200
Message-Id: <20230522153144.30610-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230522153144.30610-1-philmd@linaro.org>
References: <20230522153144.30610-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

To be able to poke at FIFO content without popping it,
introduce the fifo8_peek_buf() method by factoring
common content from fifo8_pop_buf().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/fifo8.h | 26 ++++++++++++++++++++++++++
 util/fifo8.c         | 22 ++++++++++++++++++----
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index d0d02bc73d..7acf6d1347 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -93,6 +93,32 @@ uint8_t fifo8_pop(Fifo8 *fifo);
  */
 const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
 
+/**
+ * fifo8_peek_buf:
+ * @fifo: FIFO to poke from
+ * @max: maximum number of bytes to pop
+ * @numptr: pointer filled with number of bytes returned (can be NULL)
+ *
+ * Pop a number of elements from the FIFO up to a maximum of max. The buffer
+ * containing the popped data is returned. This buffer points directly into
+ * the FIFO backing store and data is invalidated once any of the fifo8_* APIs
+ * are called on the FIFO.
+ *
+ * The function may return fewer bytes than requested when the data wraps
+ * around in the ring buffer; in this case only a contiguous part of the data
+ * is returned.
+ *
+ * The number of valid bytes returned is populated in *numptr; will always
+ * return at least 1 byte. max must not be 0 or greater than the number of
+ * bytes in the FIFO.
+ *
+ * Clients are responsible for checking the availability of requested data
+ * using fifo8_num_used().
+ *
+ * Returns: A pointer to peekable data.
+ */
+const uint8_t *fifo8_peek_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
+
 /**
  * fifo8_reset:
  * @fifo: FIFO to reset
diff --git a/util/fifo8.c b/util/fifo8.c
index 032e985440..e12477843e 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -66,7 +66,8 @@ uint8_t fifo8_pop(Fifo8 *fifo)
     return ret;
 }
 
-const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
+static const uint8_t *fifo8_peekpop_buf(Fifo8 *fifo, uint32_t max,
+                                        uint32_t *numptr, bool do_pop)
 {
     uint8_t *ret;
     uint32_t num;
@@ -74,15 +75,28 @@ const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
     assert(max > 0 && max <= fifo->num);
     num = MIN(fifo->capacity - fifo->head, max);
     ret = &fifo->data[fifo->head];
-    fifo->head += num;
-    fifo->head %= fifo->capacity;
-    fifo->num -= num;
+
+    if (do_pop) {
+        fifo->head += num;
+        fifo->head %= fifo->capacity;
+        fifo->num -= num;
+    }
     if (numptr) {
         *numptr = num;
     }
     return ret;
 }
 
+const uint8_t *fifo8_peek_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
+{
+    return fifo8_peekpop_buf(fifo, max, numptr, false);
+}
+
+const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
+{
+    return fifo8_peekpop_buf(fifo, max, numptr, true);
+}
+
 void fifo8_reset(Fifo8 *fifo)
 {
     fifo->num = 0;
-- 
2.38.1


