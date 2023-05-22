Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C65DF70C296
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:37:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17Wd-0007aA-H5; Mon, 22 May 2023 11:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17Vz-0007NB-3K
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:07 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17Vx-0001Kb-Fu
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:02 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f60410106cso9527775e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684769518; x=1687361518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HFQ4TQ858TQsjYOnqPZRPL59qIZV5loVHcO3ItffVk=;
 b=JxZXjjckkKkgHydUr4Lviu/5YMUz8RRXJdofqyzRla9aFSCih3kMeEDlzc2dZd/rWC
 FxQ9L2UweED6uJXGa0Y81/Z4T6f6Bz9FKWyYoUC5JttfiFuZhwTETVkLqQ2tit4YqZi+
 vFmuLxNql1IRFauW+5HqdfsALBV4Fz44tHok7cwNt7ZL0yYKGBsCRSp7Vz056zNr3vDp
 ORncD5wf0HsEv+t3uB5Y2g2pFu3lDF8bmNO2c38k4VqqANiwfKywKHHHzQsXFcG+PRK/
 Eo7VTZypnqH16KVBJPLkalAdIbuBHex0TrcdF5lc4QeYq2+jB8ewG+lNUujRE3xNcQe2
 lDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684769518; x=1687361518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/HFQ4TQ858TQsjYOnqPZRPL59qIZV5loVHcO3ItffVk=;
 b=It3wE8MCMCKOatRrUREl+v2PykgBlXK1JCD0kXvexrft1rdrWdfhxYMZ/CjdqOAGWD
 w6tUpMjFZ3+bs/Qtdsk0mip+grCyCjY3BNIFDST0cw+CeTrTP/CVKoUmZxxnM384GEhD
 0a2gB5CmL/KQC5WI1caAYZ9zs0R3Vl6p0SW39NXF7sQ008D0ByeSUoLGFatuTlT7aInh
 CEaZSFhLXqxG9U4FGjTgGHUc8tLXn03ugcth2WLSFapwSQjj3janJVxwf5uS3WytrxHm
 KLMhnG5OeIJA93+h2simPrYN9EpQQwQaWbVp0UxtDk1V85D1Xp+Rx+sedl0GCcMdiFSv
 7xQA==
X-Gm-Message-State: AC+VfDwhe3a8o7Hudb8mB2HIT2mO5+SyGX9K6p11uSHlQLVUSUWyoQ/O
 g2TLPRIoFVR8wrzJrg1sSV9V1Z9CTcgRaWHW0nw=
X-Google-Smtp-Source: ACHHUZ7/Wq1BH2VOBPcnbW2UzMD8xKd0wdpFsluJ0Pacj+5WeRF3tY8x34tlDTeMgoIOek98Ynit0w==
X-Received: by 2002:a7b:c046:0:b0:3f6:1c0:aa7a with SMTP id
 u6-20020a7bc046000000b003f601c0aa7amr3844982wmc.29.1684769518388; 
 Mon, 22 May 2023 08:31:58 -0700 (PDT)
Received: from localhost.localdomain ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 z20-20020a7bc7d4000000b003f4ecf1fcbcsm11862770wmk.22.2023.05.22.08.31.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 08:31:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/12] util/fifo8: Allow fifo8_pop_buf() to not populate
 popped length
Date: Mon, 22 May 2023 17:31:34 +0200
Message-Id: <20230522153144.30610-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230522153144.30610-1-philmd@linaro.org>
References: <20230522153144.30610-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

There might be cases where we know the number of bytes we can
pop from the FIFO, or we simply don't care how many bytes is
returned. Allow fifo8_pop_buf() to take a NULL numptr.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


