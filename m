Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 270507A9844
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:39:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcY-00027o-Dt; Thu, 21 Sep 2023 13:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcT-00025e-IO
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:41 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcE-0007ew-DD
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40528376459so12853165e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317845; x=1695922645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f4JCz6oW705FmXRb/erPYyuDAbijRvdAgvDYCus9zWk=;
 b=qlLGZQsBGPwwyTyon1DmDLyIGi0tqkCAtvllaHQI7W/MrQ3WqtKQ0SGHKErdYrr7om
 J3XMXFrwd3dHLO/Fnt7RojKSu4qiEdcdr21WSxtzXu+Zc/BbnSEn/s1L3AZDYpL3K5Uh
 d/rgugPVk4Zn84O4lu8k9xCaAIfZRz2IR8S7aeBh1KcM+jFMuqSDxZvWzlmuL6DUFQHb
 YVMVOE/NkF+KFBJSG17CHAt16UpoeyZe7P8XM8HO86bZgvxhvpOLp94yNwq+PcWG4IDw
 3c4JPXZoF+eqhL0LRPBCOzI5gbnFS2NbhbSD75qlBEOc/Euzb0Dhvi4B8hxpBfkdBdLe
 JuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317845; x=1695922645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f4JCz6oW705FmXRb/erPYyuDAbijRvdAgvDYCus9zWk=;
 b=VZZ/nOnm4zgZCZMrKa+3mPTfCAZwUlzIsloT2O+Y9YQkFoLX7Atz6rfUvSG6rkeuuR
 /lvFaPLjLQS688RIwBoHdysH18UgE1OSJcG2fzY99GAwWcuz5j7vSiq4LaslDxnpX4pA
 Ald9MEVfhigN2hN+knZNV/xu1P0/LsFiFWD9JnRNJEoWIp3A5MdT4OiRdDJTr59MEJUM
 /1QfAmDnRTLoXhmK7jd3PnISG+ehf9Ssg/ZA4MzfBMrHetoF7U//bOGqxP0nypLQYDzh
 qewwQTGnHmzewSP8nG/jKzpnbTJXuWuAs+B/pNE+8grooxfHNq5WsWiqtbDedL/E0yxB
 RXmw==
X-Gm-Message-State: AOJu0YznNgfL8fPbVF1tI+hfToN5AQYVeyiwqhwlXp8KMGqUHhWEeX7B
 rXRYlGkRLkyjlr8r0mWZJcIoKdTrjQqdTMIA+bU=
X-Google-Smtp-Source: AGHT+IFYnn8gutmAThGQAgO6c69LAwKfPfGMYS4nijGn/ZdaopC3IiR9rkXk8BD9C1gt1UKEsriSMg==
X-Received: by 2002:a05:600c:2312:b0:3fe:d71a:d84e with SMTP id
 18-20020a05600c231200b003fed71ad84emr5450548wmo.1.1695317845030; 
 Thu, 21 Sep 2023 10:37:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/30] linux-user/elfload.c: Report previously missing arm32
 hwcaps
Date: Thu, 21 Sep 2023 18:36:56 +0100
Message-Id: <20230921173720.3250581-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the code to report the arm32 hwcaps we were previously missing:
 ss, ssbs, fphp, asimdhp, asimddp, asimdfhm, asimdbf16, i8mm

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d51d077998a..bbb4f08109c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -506,6 +506,16 @@ uint32_t get_elf_hwcap(void)
         }
     }
     GET_FEATURE_ID(aa32_simdfmac, ARM_HWCAP_ARM_VFPv4);
+    /*
+     * MVFR1.FPHP and .SIMDHP must be in sync, and QEMU uses the same
+     * isar_feature function for both. The kernel reports them as two hwcaps.
+     */
+    GET_FEATURE_ID(aa32_fp16_arith, ARM_HWCAP_ARM_FPHP);
+    GET_FEATURE_ID(aa32_fp16_arith, ARM_HWCAP_ARM_ASIMDHP);
+    GET_FEATURE_ID(aa32_dp, ARM_HWCAP_ARM_ASIMDDP);
+    GET_FEATURE_ID(aa32_fhm, ARM_HWCAP_ARM_ASIMDFHM);
+    GET_FEATURE_ID(aa32_bf16, ARM_HWCAP_ARM_ASIMDBF16);
+    GET_FEATURE_ID(aa32_i8mm, ARM_HWCAP_ARM_I8MM);
 
     return hwcaps;
 }
@@ -520,6 +530,8 @@ uint32_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa32_sha1, ARM_HWCAP2_ARM_SHA1);
     GET_FEATURE_ID(aa32_sha2, ARM_HWCAP2_ARM_SHA2);
     GET_FEATURE_ID(aa32_crc32, ARM_HWCAP2_ARM_CRC32);
+    GET_FEATURE_ID(aa32_sb, ARM_HWCAP2_ARM_SB);
+    GET_FEATURE_ID(aa32_ssbs, ARM_HWCAP2_ARM_SSBS);
     return hwcaps;
 }
 
-- 
2.34.1


