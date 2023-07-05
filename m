Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF5F7484D4
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 15:20:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH2Q6-0008Io-Qu; Wed, 05 Jul 2023 09:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH2Pt-0007lg-QK
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:19:34 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH2Pr-00075u-Kl
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:19:33 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9891c73e0fbso140551166b.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 06:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688563169; x=1691155169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9kg0aNLZM4S8bjUKxesX7u6cAm6btVjZ5SYrsKBPTY=;
 b=up+tjzeYMuoRy3EgEMNfJWCw+FsnqGns77gtu4TaKHBH99V2VVUbDhYs+nvhNxISYI
 uKdbct4fB4cn3/oXG/NjtAFn+cnETO/eR8T9VvypMDPMy4Rti8yaPd+Omo2z/J+YZ5jV
 lU8ToMQ1JnjxPRlHDly5YvqaaBnnoi1A+5A83UfF1dUqwL2SZ3jLD6NuE2C/HZriGJ0Z
 +dovGAKEviwMOrEOAWVV871H9evk7vmqkgph++ukL+1xAMxncDCoAGE8gazsx8fx0VI7
 feCq1yuYsdGzpUYo+7F3/L8XLupM6mSJTIZEIYmwPK3Qb+UQmGKXQwDr/PPPgsMEbBHD
 dPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688563169; x=1691155169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z9kg0aNLZM4S8bjUKxesX7u6cAm6btVjZ5SYrsKBPTY=;
 b=PpbtNmOdh8TZLHJ8PnBFabsaRyYIRXtV/1L9tJPkrlBVTaWVw1nr+rEf3Aw/GnUDDa
 mRMlQS6VbXNjazR3tyOdk59GWy0zl8Skxs2ZFINHq+YT6dyqyvvr2tIxUNKKVFKjJMGf
 TN/YiwdGioD24yil36ZBGLeLzePdbclCMYpCPHFFAw+Y5/tqd3TIaMNgA7fBDn0DU2NF
 kFLF5wrGvhsJh/zXGur32m0I/rQmzhiax7PM5G6FKFIKR1WiI8bDj5Eep96k/NULC2bj
 +jv7FoeTSHy0E12ewxfriYS5Up4AaqQJBctUH8fDOfBIfg3FwwFQDKI7hFsuUhl6sf42
 pjXw==
X-Gm-Message-State: ABy/qLYi0QnRfZ3lvqZuLBS8RresPpQWvp+tD7DzCU6p0FXJCH8pmpTw
 M3w/Hpu/KqECRQSQx8EGZwo14eI9CB2Zi5aVAyg=
X-Google-Smtp-Source: APBJJlEBSXv6zc868BPuu8NCih9vlqtvg1AfyBsViPSg0J8CuePCE+6ZnL7cXaAFA11RCMgPYTe0Gw==
X-Received: by 2002:a17:907:6285:b0:978:2b56:d76e with SMTP id
 nd5-20020a170907628500b009782b56d76emr1858262ejc.12.1688563169811; 
 Wed, 05 Jul 2023 06:19:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.96])
 by smtp.gmail.com with ESMTPSA id
 k24-20020aa7c398000000b0051def9be785sm7062702edq.85.2023.07.05.06.19.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Jul 2023 06:19:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 2/3] util/fifo8: Allow fifo8_pop_buf() to not populate
 popped length
Date: Wed,  5 Jul 2023 15:18:58 +0200
Message-Id: <20230705131859.53970-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230705131859.53970-1-philmd@linaro.org>
References: <20230705131859.53970-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

There might be cases where we know the number of bytes we can
pop from the FIFO, or we simply don't care how many bytes is
returned. Allow fifo8_pop_buf() to take a NULL numptr.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/fifo8.h | 10 +++++-----
 util/fifo8.c         | 12 ++++++++----
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index 16be02f361..d0d02bc73d 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -71,7 +71,7 @@ uint8_t fifo8_pop(Fifo8 *fifo);
  * fifo8_pop_buf:
  * @fifo: FIFO to pop from
  * @max: maximum number of bytes to pop
- * @num: actual number of returned bytes
+ * @numptr: pointer filled with number of bytes returned (can be NULL)
  *
  * Pop a number of elements from the FIFO up to a maximum of max. The buffer
  * containing the popped data is returned. This buffer points directly into
@@ -82,16 +82,16 @@ uint8_t fifo8_pop(Fifo8 *fifo);
  * around in the ring buffer; in this case only a contiguous part of the data
  * is returned.
  *
- * The number of valid bytes returned is populated in *num; will always return
- * at least 1 byte. max must not be 0 or greater than the number of bytes in
- * the FIFO.
+ * The number of valid bytes returned is populated in *numptr; will always
+ * return at least 1 byte. max must not be 0 or greater than the number of
+ * bytes in the FIFO.
  *
  * Clients are responsible for checking the availability of requested data
  * using fifo8_num_used().
  *
  * Returns: A pointer to popped data.
  */
-const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *num);
+const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
 
 /**
  * fifo8_reset:
diff --git a/util/fifo8.c b/util/fifo8.c
index d4d1c135e0..032e985440 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -66,16 +66,20 @@ uint8_t fifo8_pop(Fifo8 *fifo)
     return ret;
 }
 
-const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *num)
+const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
 {
     uint8_t *ret;
+    uint32_t num;
 
     assert(max > 0 && max <= fifo->num);
-    *num = MIN(fifo->capacity - fifo->head, max);
+    num = MIN(fifo->capacity - fifo->head, max);
     ret = &fifo->data[fifo->head];
-    fifo->head += *num;
+    fifo->head += num;
     fifo->head %= fifo->capacity;
-    fifo->num -= *num;
+    fifo->num -= num;
+    if (numptr) {
+        *numptr = num;
+    }
     return ret;
 }
 
-- 
2.38.1


