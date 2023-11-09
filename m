Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 431317E7251
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:29:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Ahf-00054S-PB; Thu, 09 Nov 2023 14:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1Ahd-00053k-Tj
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:28:33 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1Ahc-0005GV-8r
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:28:33 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9d267605ceeso209734566b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699558109; x=1700162909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BO0D2WVoS2EP+jLak3Jz2oTxKuP2p7K6nXjgv8ItBfQ=;
 b=tfNv+2mjSdiHuj6izxKvhPqyNSpT00DzsUACdTaTi/LgitchUy9nGEVrqdU4KvHnfH
 sSPVwyGRVULCB+c24BZbwimRyY+8tXKAoKpMfgSer/d2J/EAQvn+KsN8bXvXtQcN4GoB
 eYS3mkDHFQpN/DDcRwmXlBZa5UmYZ9wr7PUlTj6wDcL/F9tu5mVhiTV6SYOG49IK57VI
 OaV3KjisNz+TJqoFK86fdRP1J6NfRsMHPlBZmrge+nV5oJKn+Sz6mrSD7B8dInVevfgf
 Uzrymg0h9Ep5lr+MW3qzQLE4UP+GLr4SDvki8yuB+0i63AvJRrr4VUh1T7WS0aiqYD3I
 tpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699558109; x=1700162909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BO0D2WVoS2EP+jLak3Jz2oTxKuP2p7K6nXjgv8ItBfQ=;
 b=RrsrkKzlNUQgA4wqOKK5hXR3429bu1j5U0lUGv15Vpg6HamjF0WF2nYfTKfFUpUo+O
 ZlRrb+sZK50QUlfzsmGDgd1cp4YlrS61NyQazQcCDcjW+DH3k4vNGgNAikhi24KpiFLu
 sb44tDcLUGXELNlfg/yssqZ2KxX9t9LD1rvix98W0WE0qqcmBkFn0SpqhDKG335Dp/5n
 JD2D9vjKE430QWYdCVP5ub+hOoBivvJ5V2dqOuoV5evW1FExBvEs0CIDe2R2ExflfPxk
 XsFhJ+5qFD7RbNqpcY4LSyopoW6xjvWMmupTzX8co1/WIa0vX3Ulld2URNlQCDh9SThe
 1KMw==
X-Gm-Message-State: AOJu0Yx7VGTO4s1YapLH3plkNKuxZeRkMwZeGnYdk7QtA6kh4YqmCJz4
 2MPb3f2KQSLHxSr/D6ko+k7JLd7kU3WtCU7ycOL+hQ==
X-Google-Smtp-Source: AGHT+IErozPHp4wXVfvM31ctOVenAXpEfiALK8Ch0iN8zfmFu4saFlT+Vx/fZ+gXY7mkQxuDuPS/fQ==
X-Received: by 2002:a17:907:7faa:b0:9e0:5f68:143c with SMTP id
 qk42-20020a1709077faa00b009e05f68143cmr5572161ejc.35.1699558109337; 
 Thu, 09 Nov 2023 11:28:29 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 qh23-20020a170906ecb700b009a19701e7b5sm2954549ejb.96.2023.11.09.11.28.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Nov 2023 11:28:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Francisco Iglesias <frasse.iglesias@gmail.com>
Subject: [PATCH-for-8.2 v4 02/10] util/fifo8: Introduce fifo8_peek_buf()
Date: Thu,  9 Nov 2023 20:28:06 +0100
Message-ID: <20231109192814.95977-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109192814.95977-1-philmd@linaro.org>
References: <20231109192814.95977-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

To be able to peek at FIFO content without popping it,
introduce the fifo8_peek_buf() method by factoring
common content from fifo8_pop_buf().

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/fifo8.h | 27 +++++++++++++++++++++++++++
 util/fifo8.c         | 22 ++++++++++++++++++----
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index d0d02bc73d..c6295c6ff0 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -93,6 +93,33 @@ uint8_t fifo8_pop(Fifo8 *fifo);
  */
 const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
 
+/**
+ * fifo8_peek_buf: read upto max bytes from the fifo
+ * @fifo: FIFO to read from
+ * @max: maximum number of bytes to peek
+ * @numptr: pointer filled with number of bytes returned (can be NULL)
+ *
+ * Peek into a number of elements from the FIFO up to a maximum of max.
+ * The buffer containing the data peeked into is returned. This buffer points
+ * directly into the FIFO backing store. Since data is invalidated once any
+ * of the fifo8_* APIs are called on the FIFO, it is the caller responsibility
+ * to access it before doing further API calls.
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
2.41.0


