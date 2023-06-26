Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EC773E3E6
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:48:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoKs-0001QU-5c; Mon, 26 Jun 2023 11:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoK0-0000L5-1C
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:08 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJx-0002tQ-0z
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:07 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31297125334so2982238f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687794000; x=1690386000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hw+j4cSax+vSnxcR+a5aYOGnySUJZmXer1KgvbIDXQM=;
 b=ZMwziPnqiDpNVb12vvx6CXVV81n6d3gQAck/i8+8upRueImH4L6qwrT6ZFtVH4GfQf
 js+LQnVgUsG4sM9o7ZxkIjq6e5KHazEavoE8wt+ah4owuyBVxWHZHM7UT9RKeID5zjUK
 XF1zne+2kY+O7Job54H5M6xX7hLW5OtNpGa+iXnFF050i92eN0nIHfWrHXz5XBEFw5fj
 SHAZuFXOiYUd/Xhons0uSt5pbdNaBw6ic5fJvA2T2dKTy7xHCLWhRU7ahadKULS4Qg+b
 HHIdl0oXDjyGKI1csIe4iMGcJ+kA36YMEE1K45Nrf398D89S8DLoFmbAQXLYLvZS0Hy9
 5GMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687794000; x=1690386000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hw+j4cSax+vSnxcR+a5aYOGnySUJZmXer1KgvbIDXQM=;
 b=lbKe18ky7fQtuOUMs2ZeuMLUxmSdOSAl0riIwIFgr9FCJsTzrWeQzsSyRpWjvvwPMV
 xCW/pDm6KJjujVNMLrtZFLG6W2Gs62QKJC7uPcuy9jY/MEE59FXKVtVwK1+xu7zuCGow
 g+Q79N2NH5QU+d6+8K7gPlnBTN6ZwGrI0h2yFACxC/CN9P1m4uRdRh3ATNgNViAu4U0p
 ge0kAawMqESFB6nWGBc39wfh/pPEWuFagOAeKw1ZDkZ5fFRT+4cDrV9CgtHLFtYLH80W
 QBwMdXaxQOB7MTh8fIm2zKp52rGaugyqDD7YkskP+bXlVMo8fqH4EZdknlq5rpaYsCbn
 2qJw==
X-Gm-Message-State: AC+VfDyMMXAPsgijcc5jRHcPQQrYg+DIGAHF3n1Ymd66a39aDxGBoEOp
 H4TO8HXXwr+ffd8HUOE1CydrYyI4UcXnV0pSa878Cdfp
X-Google-Smtp-Source: ACHHUZ7ooT0KTzoPMDj8YNbvVtYBwlLv/f9mIyZR2yCqwMsInoIRRkFut2RWLbljz5Ah3e7+7UeWEg==
X-Received: by 2002:adf:e5c7:0:b0:30a:e3bb:ba8b with SMTP id
 a7-20020adfe5c7000000b0030ae3bbba8bmr32068274wrn.29.1687794000440; 
 Mon, 26 Jun 2023 08:40:00 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:40:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/22] accel/tcg: Renumber TLB_DISCARD_WRITE
Date: Mon, 26 Jun 2023 17:39:45 +0200
Message-Id: <20230626153945.76180-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

Move to fill a hole in the set of bits.
Reduce the total number of tlb bits by 1.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 4 ++--
 tcg/tcg-op-ldst.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index b5618613cc..8018ce783e 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -325,10 +325,10 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
 /* Set if TLB entry is an IO callback.  */
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
+/* Set if TLB entry writes ignored.  */
+#define TLB_DISCARD_WRITE   (1 << (TARGET_PAGE_BITS_MIN - 4))
 /* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
 #define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 5))
-/* Set if TLB entry writes ignored.  */
-#define TLB_DISCARD_WRITE   (1 << (TARGET_PAGE_BITS_MIN - 6))
 
 /*
  * Use this mask to check interception with an alignment mask
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index a4f51bfb6e..0fcc1618e5 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -39,7 +39,7 @@ static void check_max_alignment(unsigned a_bits)
      * The requested alignment cannot overlap the TLB flags.
      * FIXME: Must keep the count up-to-date with "exec/cpu-all.h".
      */
-    tcg_debug_assert(a_bits + 6 <= tcg_ctx->page_bits);
+    tcg_debug_assert(a_bits + 5 <= tcg_ctx->page_bits);
 #endif
 }
 
-- 
2.34.1


