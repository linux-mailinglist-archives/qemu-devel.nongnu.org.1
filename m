Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 102A97484D5
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 15:20:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH2QZ-00011Y-Nx; Wed, 05 Jul 2023 09:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH2QM-0000oD-KX
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:20:02 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH2QK-0007B9-MK
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:20:02 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b69dcf45faso109834851fa.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688563198; x=1691155198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FSxovuSb9d76pAZNtRHp6Si7EzkK1vbEMwhu48Hxi5Q=;
 b=DThlPy4WXVDVxtW/w3OX7s26ifvz9HJl8lSLo8Cwj4Rdw1ZxEMxRmdZZiqJX+MCtug
 4Hh4r+/ksgTtKZCIbIjdPK2ggakJnAwQxVIG0VP6T9FLSllo72XcD3NKuP5yxDGqDFf3
 vDvZNafTmECcXsfVrCAUPeoS4SvpUPSbiDhWX2C9YanRmJbIMKJxT5yA84UTqTPyAxop
 EjJyYvdpY02o8schoFLIdBuWRZI9x4HzyNcv8+sfxQBl0zeqLpQgwbBk7y7+Bj8s+tih
 u5gKC9pw7TBfT1dqf6t7XFtle/wZbOlDKG1I3FE8Ek6OLqDv94o4QcR7NNy6XQ1fckfi
 SbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688563198; x=1691155198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FSxovuSb9d76pAZNtRHp6Si7EzkK1vbEMwhu48Hxi5Q=;
 b=SL+aYAOZqCPqnB/PyvQK+WCpTh+auTZKfcn9xH4iIc1oHCpcOvlKXfbCOr8igbURbI
 9yrNm6kAe0zP0ehLuV73q3vuT4S5jI+SE3R/RDQ5BBmEFOy0vAJQkyPFGAeLTUP02DMo
 9w8JZPX+aT1JKtStIdUSP2TgFYEJNHwEZdDqGOZBNHzFB2wJr4H0xx6+maiFlFgWQdtD
 KEm7BI/nsZNVa3SDZH2mCSl986ohgYmBRCPmoZ7DtRCE+tZcc4ZK9vtRq4J53KuRALTB
 pY7DVZyDzVNUkAB95WqfeW8gDQSP4KiV2HFbaKeCQA6+hmc814JKLvVo8G3jt4Okd2Rh
 qy3A==
X-Gm-Message-State: ABy/qLYJTKzq/Iosdk0sq9ErNAbXzIySADz1rqJ1gfduhQq8Ud2ilkFd
 kyRBkp48c/rHSswLOKJEDDtXTK8+x2ucJTCaMic=
X-Google-Smtp-Source: APBJJlFE+HdXFUP2NDBhLI7P8Tvw2bmVX5RLddb5H6Mf4gAnFJPYzDINKte11JfBm1S83TQE0l21yw==
X-Received: by 2002:a2e:7011:0:b0:2b5:8bb9:4dd6 with SMTP id
 l17-20020a2e7011000000b002b58bb94dd6mr10792418ljc.12.1688563198451; 
 Wed, 05 Jul 2023 06:19:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.96])
 by smtp.gmail.com with ESMTPSA id
 ha22-20020a170906a89600b0098e0c0cfb66sm13974548ejb.38.2023.07.05.06.19.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Jul 2023 06:19:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Francisco Iglesias <frasse.iglesias@gmail.com>
Subject: [PATCH v2 3/3] util/fifo8: Introduce fifo8_peek_buf()
Date: Wed,  5 Jul 2023 15:18:59 +0200
Message-Id: <20230705131859.53970-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230705131859.53970-1-philmd@linaro.org>
References: <20230705131859.53970-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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
2.38.1


