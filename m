Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2978A7C878E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrItO-0007RJ-37; Fri, 13 Oct 2023 10:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrItM-0007Ql-4g
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:11:52 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrItJ-0004O9-HM
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:11:51 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9a58dbd5daeso356578466b.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697206308; x=1697811108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9tZVJmu9kzGvsLFPu4hpPnpsYV8GknZmAK3SQkWufw=;
 b=DlScgFwHf4Ru11bhBCZ1tD5Z7Z4vPeb9GTCggYNBTQVDj1s6c7n2xkJfpltupClxrN
 eXy/KFTaKtFeHhvcSdeBPt3sGjoHMQrd38t96XFkMW1teHX8AiuK48CuD1+6JBK+Xi1a
 GJbt27VuqaTw17XKdypGzBKhiHMNMeo7H3PAvmyHyCwWxN+/uz0gUopIXx/UXbAo25S/
 gftM88Hfddecjo+gh/6+ZQLd4vw/Hn8MLjokOE1WQxzCvIzGxAIed1Usx6569R0gNAJs
 gTNjvvQLnjy7AAY4SLNcdlOKbXb17o333L0DnzJVqezzYhjEP4nynuC7gPLBUPSdbRUH
 yh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697206308; x=1697811108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9tZVJmu9kzGvsLFPu4hpPnpsYV8GknZmAK3SQkWufw=;
 b=tPlD4X0eOxlKUcXl/Kx+HfkSotQgvgjzg61xPV1HNtDXZi9Q3W6q3WV5ptjMwfJZpW
 wLLMpCOec6fxJympB80nS8cpAEP4kshyi/ol/3iOUdp/0df9MJ/ASLOMwMQ5nIBWbwEU
 iQvBajnMpBU6txDSxvpwJvN4JbChkwsxsFlZ7nxJyPVbAVgDYgQq9gaV9ZhMdTZks6eE
 qofiHTEL3V6ds/rSCU/TKeMOf1RFv2RyE6+QnrCcMgjGjpRoUmPVIFVY0zE4quuxjVBW
 F//5tpzO51gRZLUDiCoeX23VnrFfuL4a74E1oINOkd6WKu3AeyepLbl4q9ipOiOuwaEt
 b0Eg==
X-Gm-Message-State: AOJu0Yxsnn1+wvDBMZ6AMLGFFISX7g1zx9pWrGo6CRCnkcJ9EO2LhD25
 y8xu/KtshNBy4YE+NuHlOuqzn8HJiS8citG55+A=
X-Google-Smtp-Source: AGHT+IEWxZGoNekV1CrxCAV+maMmGBnOjA50M6xT9ODRIsrhs0cUOEe9/9l9tGca1COb/51yFRqMvw==
X-Received: by 2002:a17:907:2e19:b0:9b2:c2a9:357a with SMTP id
 ig25-20020a1709072e1900b009b2c2a9357amr23260747ejc.68.1697206308015; 
 Fri, 13 Oct 2023 07:11:48 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a1709066d0e00b00991d54db2acsm12404171ejr.44.2023.10.13.07.11.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 07:11:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Francisco Iglesias <frasse.iglesias@gmail.com>
Subject: [PATCH v3 2/10] util/fifo8: Introduce fifo8_peek_buf()
Date: Fri, 13 Oct 2023 16:11:23 +0200
Message-ID: <20231013141131.1531-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013141131.1531-1-philmd@linaro.org>
References: <20231013141131.1531-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

To be able to peek at FIFO content without popping it,
introduce the fifo8_peek_buf() method by factoring
common content from fifo8_pop_buf().

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


