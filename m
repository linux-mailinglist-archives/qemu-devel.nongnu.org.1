Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA9382BA5B
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 05:23:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO93W-0006Ha-Am; Thu, 11 Jan 2024 23:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rO93U-0006HB-C1
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 23:22:04 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rO93S-0004os-SP
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 23:22:04 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d3ed1ca402so55408025ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 20:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705033321; x=1705638121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6hE4eJitCTZpl51/ZHF6oGfhVBhaOGAVbSFzwGAmZo4=;
 b=aahZNSuYgLCRduR0NTUJLMylLK4VgjHACzBzMVBpvUSAzGa+lF2Q57isu00OXRBg/z
 bnhvNttATN/TpVarXQ7zutmVptKHHUa04blshPjXG+eLDy/tg8diaxItWjEmVn5fYG1d
 kjr3HOjpyeqqvoC7mHVvfKAdqevrzr1TLh6hkFb116RRQQuBEi4Iu1eC0GSboP7HJq4b
 IKnwsN+iiErQx2NXB3ViaJUfxcNz486pY17czdGgDTisfiqo1tru4CwTJwsLo+bmJ1Mv
 bec0tg+G81riV8qjsFgVB2I7jXL0nHRNthIB/UTQsQIn6muGkvo41Lf/XXhQ8TF6YV4J
 FWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705033321; x=1705638121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6hE4eJitCTZpl51/ZHF6oGfhVBhaOGAVbSFzwGAmZo4=;
 b=kcoKolHEAKTEDQKoERrkIWJhf/M0YIaxjnOmKV2UZ0wiK43ll2vQ54Gw/20dbSF7Ri
 B9rndxaLOXY/icLUHsgu9pMcXEHTa22YiR61ZcqACJqLdiqVqzXK0JjdBoI+t5MXWJJW
 srLjkgPpWxXn+E+rdJZHXwCkc9IxfEaBEi9lGUDij/CGxjqm3LShFBD+vBUoI1ohhVd9
 32WaBF+/MLAMZf8Zqy0pTcQ3vQl4boqhw54+E5FDg79/CCo+VP9KjSr3fM+ZvfT2qg/+
 G8Rs/3R4D6jp2ZHQNP49qIkPaopXcANnshF+hgRin3lu09DKgeyXPGArTJ6YYMKMaFKU
 hjIA==
X-Gm-Message-State: AOJu0YyyDqVSFQobSI12O5crqoXjVA0UU5aABMDYuhaIyqb/TA/qfv2o
 zElmJkj9NEnFlBjPLWZcaRzewUHV5eM=
X-Google-Smtp-Source: AGHT+IH9WamLNFg8R5B7oY/TbLj2h4ygN3g8IiYg24Q44YqdCaJdYV9+hFdfQCqpIlHyyVoybYx/bg==
X-Received: by 2002:a17:903:40cb:b0:1d4:7863:7586 with SMTP id
 t11-20020a17090340cb00b001d478637586mr470271pld.78.1705033321303; 
 Thu, 11 Jan 2024 20:22:01 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net
 (c-73-63-239-93.hsd1.ca.comcast.net. [73.63.239.93])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a170902d4d100b001d4c98c7439sm2018576plg.276.2024.01.11.20.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 20:22:00 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4/4] tests/tcg/xtensa: fix SR test for configs with MPU
Date: Thu, 11 Jan 2024 20:21:28 -0800
Message-Id: <20240112042128.3569220-5-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112042128.3569220-1-jcmvbkbc@gmail.com>
References: <20240112042128.3569220-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

- atomctl is available not only in the presence of s32c1i, but also with
  the exclusive access option
- cacheadrdis SR has the same number as cacheattr, mpuenb SR has the
  same number as rasid and mpucfg SR has the same number as dtlbcfg,
  add MPU case to the tests of these SR numbers

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_sr.S | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/xtensa/test_sr.S b/tests/tcg/xtensa/test_sr.S
index 34441c7afff7..661ef6c66ed1 100644
--- a/tests/tcg/xtensa/test_sr.S
+++ b/tests/tcg/xtensa/test_sr.S
@@ -62,7 +62,7 @@ test_sr_mask /*acchi*/17, 0, 0
 test_sr_mask /*acclo*/16, 0, 0
 #endif
 
-#if XCHAL_HAVE_S32C1I && XCHAL_HW_VERSION >= 230000
+#if XCHAL_HAVE_S32C1I && XCHAL_HW_VERSION >= 230000 || XCHAL_HAVE_EXCLUSIVE
 test_sr atomctl, 1
 #else
 test_sr_mask /*atomctl*/99, 0, 0
@@ -74,7 +74,11 @@ test_sr br, 1
 test_sr_mask /*br*/4, 0, 0
 #endif
 
+#if XCHAL_HAVE_MPU
+test_sr cacheadrdis, 1
+#else
 test_sr_mask /*cacheattr*/98, 0, 0
+#endif
 
 #if XCHAL_HAVE_CCOUNT
 test_sr ccompare0, 1
@@ -106,6 +110,8 @@ test_sr depc, 1
 
 #if XCHAL_HAVE_PTP_MMU
 test_sr dtlbcfg, 1
+#elif XCHAL_HAVE_MPU
+test_sr_mask /*mpucfg*/92, 0, 3
 #else
 test_sr_mask /*dtlbcfg*/92, 0, 0
 #endif
@@ -205,9 +211,15 @@ test_sr ps, 1
 
 #if XCHAL_HAVE_PTP_MMU
 test_sr ptevaddr, 1
-test_sr rasid, 1
 #else
 test_sr_mask /*ptevaddr*/83, 0, 0
+#endif
+
+#if XCHAL_HAVE_PTP_MMU
+test_sr rasid, 1
+#elif XCHAL_HAVE_MPU
+test_sr mpuenb, 1
+#else
 test_sr_mask /*rasid*/90, 0, 0
 #endif
 
-- 
2.39.2


