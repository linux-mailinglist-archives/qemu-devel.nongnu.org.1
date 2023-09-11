Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA9C79A866
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 15:55:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfhMQ-0005ho-VK; Mon, 11 Sep 2023 09:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfhMO-0005gV-SK
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:53:52 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfhMI-0003AF-Dt
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:53:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31fa666000dso1047293f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694440425; x=1695045225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7xwR18hbzVHxpKvFfeyl3S2ZQU85H+wD13Io+R8gRBg=;
 b=WtplurwcAyq6S4cZXC9uJh0segdLG5IAeNe9OHmj4GRrCML3HKCb+ltNB/yy2lVixK
 tMZGzRLfFDvCODB8QvPRL6KqaEk0qYCbWkrjjhLSSck/miCJ67VE6uP7SA/mZOXIWjo+
 XLiyYujYxVXWxXWVyOQjDff1QgizkBzsmvDTJu0uQOBqhoJ4jLgBYk+mxgIZEJlqBvqY
 ydscKvCrgIc/rntur/VID4TJQRGu0TzMK2GVWRbQFnaH0tB8+z7rLKq6JGIzR/UyIWGS
 WjemK9oBPx/z61B3WU/O0SAKX4iycLU/mk5jP25xIgecmSlop2OdasUQN1IjNuhUc7fB
 QjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694440425; x=1695045225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7xwR18hbzVHxpKvFfeyl3S2ZQU85H+wD13Io+R8gRBg=;
 b=YqXjUrqyJE02FFNKJnZoth5NyrqMHjGsA9pysjm4MfWvkS9AyFGM+QgIuaCROhlj7S
 +pP/NT74H1gS4AoT/szOCqwPZHHKphkxDMrs3yqvRa9Vnz9+UmXHmVzY6jErRA54zLKC
 Jphgcmwld8nAWFIVOUmbnbax/yd2OIWyGDzbndpJCbu38Zol5tXyEBjVSbazp59HTeri
 /N8ZY7OaUhaTUeFUJ3lsG8jJedmbLHSOdrObtwCiPR04sZjElh1r7c5qwjdXEgokAny4
 sLPzT7zcz1muTkeCaobVPsLUoVcl11dMQNHuJDhk5hp8waNtgnHl5jdTXjhHHHEJDaEx
 bItw==
X-Gm-Message-State: AOJu0YyvgB0TuTneVs6ROcYTMjz/1nPsn3HuaFftuZbMxx8PniMcd9sG
 gUJnYXk1ueFHHdOl3nTWl4wHQw==
X-Google-Smtp-Source: AGHT+IGKYIPaoNuLAocktkE8cQ57GZW65jyzddykHIA+HpoF+evfwmBWuchL+tTA88/MP6n98xMwHw==
X-Received: by 2002:a5d:4702:0:b0:31a:d9bc:47a2 with SMTP id
 y2-20020a5d4702000000b0031ad9bc47a2mr6719854wrq.53.1694440424799; 
 Mon, 11 Sep 2023 06:53:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a5d4983000000b00317ab75748bsm10079758wrq.49.2023.09.11.06.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 06:53:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/7] linux-user/elfload.c: Report previously missing arm32
 hwcaps
Date: Mon, 11 Sep 2023 14:53:37 +0100
Message-Id: <20230911135340.1139553-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911135340.1139553-1-peter.maydell@linaro.org>
References: <20230911135340.1139553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


