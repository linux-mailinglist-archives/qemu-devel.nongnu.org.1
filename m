Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F393E7E8791
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 02:33:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1crO-0002Br-1y; Fri, 10 Nov 2023 20:32:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crK-00024y-1t
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:26 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crI-0001bI-Ej
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:25 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1f04c5ed8d7so1483404fac.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 17:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699666343; x=1700271143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7D/Is0q9/XY5O6mimvb47xPlpmUh6SE4PEHCKmELxsQ=;
 b=wr2JMVjajQIaudnOILXp/z4+/VC3ytkvbvAM+vmrwvLl2XYLvZxXehqB1C4wHrLLrO
 WOu1dZTHb5MoJuj5lyajA9UvHaTU+1FGyhatXhq0lQf3MomGIYyWsLfnyCis9TJjES6J
 fyxy8SrVnBHR5SmRiAgND4E5N4ywJAQn3CLmMcq2WBvFUGw6xmPHG8VYgkkkEMG/mN7w
 wwuws0jjXC6w26nP2UBg+CXq32zq8sD2NEhH0V54WA9i5+9vBX7Kcx1SoV6fyWcIWLJo
 BlwfDQATVztXyshWhkPCmhWmTHKqPbPQBag7i4OMwKa7aC4E7V6Nk8ppLC5CO0IO5Xqq
 IMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699666343; x=1700271143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7D/Is0q9/XY5O6mimvb47xPlpmUh6SE4PEHCKmELxsQ=;
 b=u0ZNXB3uXfm8hWKFBZOkLqyHWYPSuyoPBNHMW3TgrUHwWZB2ZeZDhi4+LGbUti750q
 I8twVqRdfnWMSXPyWoQ17P5y029NbvqC7S+3foFatlHcWUuiPMPFtbl35F4dks8uVINP
 6w9bEYFLAZGCVM9h57rKcuA5vjUUF7w0UlRC76mLD2nWNd2b86AzrzjjgM9vrxRV7Kny
 XRMqTHmvlu9G7UKHpoqbHSFVKWKYF42FS++vLEQygGIJKD2NGv2FkEDw6wzOGZrnBjm3
 wP1BonRdgVjJ1JiUt9B7Y0Y6R7toBsHhXoTkftK3nwSUYFXyBidCx1rpHzNWcJM0c/O7
 QXmA==
X-Gm-Message-State: AOJu0YwfZEypLn53YVCo6cTYHXU2TeFX+GVvf5nvXVp4GoSxqGA1pAxH
 dUAqHtbFxuAJdYAwEzBp9iya41dWJxLmEHhBO+A=
X-Google-Smtp-Source: AGHT+IG8K+MVYC0//aNYotg9/jp0qzMs7R5vqNOHr/kKLDhgVgwpKUD15JqFQNzPA3RQaopN58E5ew==
X-Received: by 2002:a05:6870:3051:b0:1d5:8fb8:98ef with SMTP id
 u17-20020a056870305100b001d58fb898efmr1138307oau.31.1699666343047; 
 Fri, 10 Nov 2023 17:32:23 -0800 (PST)
Received: from stoup.hsd1.or.comcast.net
 ([2601:1c0:5e02:2a20:a99c:45a6:14e9:ea6])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a62f20b000000b006c1221bc58bsm333502pfh.115.2023.11.10.17.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 17:32:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 07/11] target/hppa: Fix possible overflow in TLB size
 calculation
Date: Fri, 10 Nov 2023 17:32:08 -0800
Message-Id: <20231111013212.229673-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111013212.229673-1-richard.henderson@linaro.org>
References: <20231111013212.229673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

From: Helge Deller <deller@gmx.de>

Coverty found that the shift of TARGET_PAGE_SIZE (32-bit type) might
overflow.  Fix it by casting TARGET_PAGE_SIZE to a 64-bit type before
doing the shift (CID 1523902 and CID 1523908).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <ZU6F/H8CZr3q4pP/@p100>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 858ce6ec7f..a13f200359 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -450,7 +450,7 @@ static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
     int mask_shift;
 
     mask_shift = 2 * (r1 & 0xf);
-    va_size = TARGET_PAGE_SIZE << mask_shift;
+    va_size = (uint64_t)TARGET_PAGE_SIZE << mask_shift;
     va_b &= -va_size;
     va_e = va_b + va_size - 1;
 
@@ -505,7 +505,7 @@ static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
      */
     end = start & 0xf;
     start &= TARGET_PAGE_MASK;
-    end = TARGET_PAGE_SIZE << (2 * end);
+    end = (vaddr)TARGET_PAGE_SIZE << (2 * end);
     end = start + end - 1;
 
     hppa_flush_tlb_range(env, start, end);
-- 
2.34.1


