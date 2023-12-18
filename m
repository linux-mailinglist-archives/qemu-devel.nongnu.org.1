Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3870816C6F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:38:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsG-00070U-6o; Mon, 18 Dec 2023 06:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsD-0006vr-DJ
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:25 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs5-0003LS-Mk
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:25 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3363aa1b7d2so2625819f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899196; x=1703503996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8VnUA3Fueqk12WZS/CbUJV8o9iWN9VQ36taC6t7Xhbo=;
 b=aXB69FuLQIO2bLbh6Oy8u3fVu8q1sTVD1QoiEQDUx62eRR+qOKIhVqAKNhghCJPMHY
 8UPpo73UuX4FZ5eYV/f8ZpvH7cR8+U11YowB6S+GdGpBUCarHOGAfZaOO5Vz36O46f4J
 k5q+P4rMQu49pfdKeE8pszR1cL/yv8p4fi2SCD/uZP9JNOA0Ar17bEGU5TrZB5Z7V/od
 RmNcVQRSyYGpNap7NSOJtKA7hL5M0VJgXOph9Q8lZXMIQyrbR43iLsem8OsSCOtiUZZQ
 CT09bgPTAFMT8Un84/8sNkH4MvKJN+FHfQx/wVvnhr3yXLLbDotgOq2A5tL039WaBVQb
 Y8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899196; x=1703503996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8VnUA3Fueqk12WZS/CbUJV8o9iWN9VQ36taC6t7Xhbo=;
 b=pQhAMedjNr7GE98HSWUKQguJn2Gwz1NE7nMKhXo2MBuv6INsACp6v6iIYKyRp5uEnz
 akHx+cY9ATI+EmHY3WYPH2zpVKN02YrGfyOZneTronTQGxcRfOXUKYUyzPu8jkoO1rfE
 s7wa8Oip9FlJ7tVbkXn9YrZMWj/BL++vpyI4pe4wo0anqtAxaiBQ29Zfb6jmmR1XtklN
 VzGtnu2CUDrGs62rJMQnoiWmsM5BlRUVq0dffcofwmwgMjcviCGWCPSC1S61rMZdDsqy
 vjF8dxmRrt4esIDRQ7oWbLMSIrPpAyMp40fHZYRFOhh524GT/Q/TuJGq1EbfXVvtvlnR
 kI+w==
X-Gm-Message-State: AOJu0YwDXgVc8Tj9ZD5yA7EkjB1ulcx5V0/2/XC4zONHrToZGZ2sMow8
 dEl8njZsnw0OyK4l6ijOSsp6hA==
X-Google-Smtp-Source: AGHT+IHz7gxnjcyxQImQFq/Iq28oVh4yXGwJ/JfdM1qHYIGoIoypS4xLu7mC+b+DzzKtT+VK+h1Y7A==
X-Received: by 2002:adf:ed09:0:b0:336:60ab:12b8 with SMTP id
 a9-20020adfed09000000b0033660ab12b8mr1225373wro.56.1702899196248; 
 Mon, 18 Dec 2023 03:33:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 20/35] target/arm: Handle FEAT_NV page table attribute changes
Date: Mon, 18 Dec 2023 11:32:50 +0000
Message-Id: <20231218113305.2511480-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

FEAT_NV requires that when HCR_EL2.{NV,NV1} == {1,1} the handling
of some of the page table attribute bits changes for the EL1&0
translation regime:

 * for block and page descriptors:
  - bit [54] holds PXN, not UXN
  - bit [53] is RES0, and the effective value of UXN is 0
  - bit [6], AP[1], is treated as 0
 * for table descriptors, when hierarchical permissions are enabled:
  - bit [60] holds PXNTable, not UXNTable
  - bit [59] is RES0
  - bit [61], APTable[0] is treated as 0

Implement these changes to the page table attribute handling.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 1762b058aec..cab30f0bf46 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1581,6 +1581,12 @@ static bool lpae_block_desc_valid(ARMCPU *cpu, bool ds,
     }
 }
 
+static bool nv_nv1_enabled(CPUARMState *env, S1Translate *ptw)
+{
+    uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
+    return (hcr & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1);
+}
+
 /**
  * get_phys_addr_lpae: perform one stage of page table walk, LPAE format
  *
@@ -1989,6 +1995,21 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         xn = extract64(attrs, 54, 1);
         pxn = extract64(attrs, 53, 1);
 
+        if (el == 1 && nv_nv1_enabled(env, ptw)) {
+            /*
+             * With FEAT_NV, when HCR_EL2.{NV,NV1} == {1,1}, the block/page
+             * descriptor bit 54 holds PXN, 53 is RES0, and the effective value
+             * of UXN is 0. Similarly for bits 59 and 60 in table descriptors
+             * (which we have already folded into bits 53 and 54 of attrs).
+             * AP[1] (descriptor bit 6, our ap bit 0) is treated as 0.
+             * Similarly, APTable[0] from the table descriptor is treated as 0;
+             * we already folded this into AP[1] and squashing that to 0 does
+             * the right thing.
+             */
+            pxn = xn;
+            xn = 0;
+            ap &= ~1;
+        }
         /*
          * Note that we modified ptw->in_space earlier for NSTable, but
          * result->f.attrs retains a copy of the original security space.
-- 
2.34.1


