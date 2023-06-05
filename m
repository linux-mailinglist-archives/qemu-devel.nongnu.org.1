Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10562723094
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GMJ-0006px-Fo; Mon, 05 Jun 2023 15:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6GMH-0006pl-Qm
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:59:17 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6GMG-0002tL-8Y
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:59:17 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so5286328f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 12:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685995154; x=1688587154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HzdINXCsYw0zym0hC+hQh9rtw8qpwjppdu7/nsvwA5s=;
 b=P9ALl6VDl6wa6kzj/rBJZrZFX8ud8gPURpHrNhCQC15hWFdeCELL095pcIttnS59O5
 0IC/Blk/tFdtHm842hLWiWvU3q8LRKtL4ex5Lxyby9vc+WQUGaO5BVBOSVI6VI2930Z8
 lSSBevfAatXyVmA76Prcf59Y8iocLRga5enPNjkbfZ6fOsNcAh+gYy61/CNQ81eXwaXR
 Zbj/+/vDAZ1wulY0y3SfyLT0w8J4dDDoci2KS3+WK9qe7MPpCQ3EbsUObxrwbPN19O6M
 XY/BLxe/2nCpPEOnGRe6GuVRRo8erwGXHbs7/6faf57ydAsHE/JUmq9msATpziIt+2I5
 PiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685995154; x=1688587154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HzdINXCsYw0zym0hC+hQh9rtw8qpwjppdu7/nsvwA5s=;
 b=UacJNYwtz64PtFCQIw4/DlbUWhz7aEkZ/cQTrhmakpLTtyXYj1637kynHVMvLP5Gn2
 XWQD3L5erstoLGsVBAVH8t7Q1MIj7jXfPT+2uqVBi2p2f3VeUsUVTJ/bH2neMB3mRZ+j
 ya/hMvPh73wmhikFMzhScCKEE+CZv9CE2dBqJKGOR6tg81OTYHeUDbM+FAfhOVQCjARF
 Y584Lgu8RdNFWYiRPUMAYHlwrHvs1E4ljOIcnrYmDpujM0Z9UgsH2h1fbWtN0JktUhey
 ScspQEsW3aFCVkqbHI7BgAP3yetds26DqXGC1PZx8wPdK3n+V2FnKywlhH75X2f5Fn+n
 R+9w==
X-Gm-Message-State: AC+VfDw+MApG1ZMYghkWBpBtLunYRAA1Ww+qjTsjjbH1zC6XkAX5iGvB
 kqd8FBpTq0eOsVwyirCj8Rq3SgXuD2s9t5jP80M=
X-Google-Smtp-Source: ACHHUZ5pZ1sx0iAFbpUqizQyho1LPkd3NIEJtPVq52jDatNtv1vJk7wkdMlhEXyGkHEWvh1o3x5iXw==
X-Received: by 2002:a5d:4492:0:b0:2f4:170:3807 with SMTP id
 j18-20020a5d4492000000b002f401703807mr7915714wrq.44.1685995154262; 
 Mon, 05 Jun 2023 12:59:14 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a056000110a00b003063a92bbf5sm10629676wrw.70.2023.06.05.12.59.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 12:59:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] util/cacheflush: Avoid flushing dcache twice when not
 necessary
Date: Mon,  5 Jun 2023 21:59:11 +0200
Message-Id: <20230605195911.96033-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

<libkern/OSCacheControl.h> describes sys_icache_invalidate() as
"equivalent to sys_cache_control(kCacheFunctionPrepareForExecution)",
having kCacheFunctionPrepareForExecution defined as:

  /* Prepare memory for execution.  This should be called
   * after writing machine instructions to memory, before
   * executing them.  It syncs the dcache and icache. [...]
   */

Since the dcache is also sync'd, we can avoid the sys_dcache_flush()
call when both rx/rw pointers are equal.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20230605175647.88395-2-philmd@linaro.org>
---
 util/cacheflush.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/util/cacheflush.c b/util/cacheflush.c
index de35616718..a08906155a 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -241,7 +241,14 @@ static void __attribute__((constructor)) init_cache_info(void)
 
 void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
-    sys_dcache_flush((void *)rw, len);
+    if (rx == rw) {
+        /*
+         * sys_icache_invalidate() syncs the dcache and icache,
+         * so no need to call sys_dcache_flush().
+         */
+    } else {
+        sys_dcache_flush((void *)rw, len);
+    }
     sys_icache_invalidate((void *)rx, len);
 }
 #else
-- 
2.38.1


