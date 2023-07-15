Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C53817548E8
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:55:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfiq-0004DC-7Q; Sat, 15 Jul 2023 09:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiK-00044H-Oy
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:38 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiH-0001Fw-6E
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742bso26494155e9.2
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429211; x=1692021211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HWNck64Rdzbsq9/3XcWJpVmBPzEh5+xH4mb3RyYLiec=;
 b=SO81RTHTX6hAXnhPXH5hUtz7J2K2eXxMhQ3xDDjgxO9Mdo/H+fkAcA5o9Q7hCLGpnj
 jjs3xTloO6e54r7HLF/nQKasg8zVgwOqIuZnbJzSHxfdJeBHwmIr4sSB4itTraINYwBW
 uiZ5vPUOeBeL0YhOj3KciJWmldCSjtnYUvtTXEgMRZwlczmyzMx56f+s+VHIZXL9FzjA
 A+dvdFxBmwG5Sm0b3b5o17vhAER4W83Qe9kt/TlNoBoFwEyjb0b5f1eMl2oTcJRd8RXG
 R4l0U7whBVo2qhNw8fuThY5hCI9xAQaJ1dFsVfflR9XPOrnk+UuSyJ1k/tQaQjgiG1td
 ZGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429211; x=1692021211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWNck64Rdzbsq9/3XcWJpVmBPzEh5+xH4mb3RyYLiec=;
 b=eC6Fs8sy7m+CUoPTEmgAAL8GkRcCB8ameAWtYriGBtcnIRpZbO+n2HsOOfzmaKTyr6
 Qn00yqq1M8EpPveoHms0vv+obUJJnhKwcqlaWJ9yq66nEhXy/G5JsC1WFXFEMR+1yQlj
 +kuUhs90psWsWsUMfcHZvzpoIXwgeBDXmMmNedxQgcCQMaWqfK/NwRo43QDRsDRrlOb7
 /+Fh4LBVsFhn+BFpsh1VaensY/ZvSdOAsY5PBE3enWMRm6ofeOc5O6NvkAgvbvuvCnrh
 4nMRXzK49kgEAft8WWCVMLrFkoro4nRWYH2Q8Qoq5V3G6qfBw6GVl2AilkNbS9WrSM5R
 6RgQ==
X-Gm-Message-State: ABy/qLZa6yYmSc6pdETIXheCALssHoE6jqidjkTIHSzMuhpJorga42Y5
 h6ggAtNRhQbcxXfVD1vu8EREj/rUSMjiiGcjRLyNuQ==
X-Google-Smtp-Source: APBJJlFSAr2Jbg783bkhwFTchGzNT7qyRxN7lO+xs1hXn/CkfWM61gVz9fl8SuKWM9+qMfn0IRVCVA==
X-Received: by 2002:a05:600c:2310:b0:3fa:8fb1:50fe with SMTP id
 16-20020a05600c231000b003fa8fb150femr6652640wmo.15.1689429211687; 
 Sat, 15 Jul 2023 06:53:31 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/47] include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for nios2
Date: Sat, 15 Jul 2023 14:52:45 +0100
Message-Id: <20230715135317.7219-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

Based on gcc's nios2.h setting BIGGEST_ALIGNMENT to 32 bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/user/abitypes.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index beba0a48c7..6191ce9f74 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -17,7 +17,8 @@
 
 #if (defined(TARGET_I386) && !defined(TARGET_X86_64)) \
     || defined(TARGET_SH4) \
-    || defined(TARGET_MICROBLAZE)
+    || defined(TARGET_MICROBLAZE) \
+    || defined(TARGET_NIOS2)
 #define ABI_LLONG_ALIGNMENT 4
 #endif
 
-- 
2.34.1


