Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BF2736630
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:29:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWh7-0003pR-26; Tue, 20 Jun 2023 04:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgw-0003nA-GC
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:26 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgu-000665-Bk
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:21 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-988e6fc41ccso171861666b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249578; x=1689841578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o556aRlWUn3yc4y7x5nkfxHpEejIwC832DOVIUZc2bk=;
 b=rD4XSDohMWLDU340eivhZMPod0cgBC+TemU2LUdqhsZ0+vOwFRe/EbFYarU2t2Q1tY
 vBFRszJBIg5sA1mj4W72tQWiN6wEE+Kz/LFZq8abfSkubG4ecU/lwaDQaUc0zyJvuSop
 Za5HR0TmvdfMN4KLznEG0jtrllr8WbxED+KpJt5ZAUaKo2juTM1UPlUV33UYr4hSwmJp
 3vWjPwaZZZ51O+UzZjmEAfSSOvLlXqXOqBEaz0GkYLJOstP+DcWJ4tsq0ecgALABvN06
 Hwfv51H0TARxBSwYaQb+LxJvR9QjlLI9jd2213T7IEHlKgYzUysExjTUMbo35cQmIhr8
 ityQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249578; x=1689841578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o556aRlWUn3yc4y7x5nkfxHpEejIwC832DOVIUZc2bk=;
 b=Hf1IhxJdXOLD0g+EW6mDKv8O6p6IblEKQH9qDZN5CtAdkQWBprJVa8Xi66AjNYW7xN
 rEGFLK1EUBmpZT6wXZHQyRUK/8EK5S656/L2st4XojHJQn1iCtm6DSkWnihBpnMBS8Cf
 F6I9frYTrkhZvsA1nTUE1lqTdq1dPIaVZAiqhGzYKbxpeTZa2+OmA3Wz91eGjqznHXIo
 40RUWGLKihGRp9YpWIYYW2z2FheHkb+BGqHEWVSlwkLSKXjc/AjwkC+MXnKmtHL7i+kp
 rMU/BgE1Hl+grK0lmKm45Sd0GChOAsPrZD88MbsaTBG5H6jn+FK6tNoRR4w+7rBQXRy3
 vIyg==
X-Gm-Message-State: AC+VfDzV9E5artl7j4oLrTFZHd60G3ppAs7RUppIr1M4HntAmfPdTtVY
 ViSP9lXJ7gh02TIG59DIr7Lk5K8j/QYi0jQcAL6LIHJC
X-Google-Smtp-Source: ACHHUZ7dPjEhKGrwViOICvqe3UrmdEq6IrlJLcAxNOjMPpOatirHfFpahBGVpzp7CmX8VCoa+ZPq8g==
X-Received: by 2002:a17:907:6d8a:b0:988:9621:d855 with SMTP id
 sb10-20020a1709076d8a00b009889621d855mr4540252ejc.61.1687249578613; 
 Tue, 20 Jun 2023 01:26:18 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170906669300b00977c7566ccbsm935901ejo.164.2023.06.20.01.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 01:26:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PULL 05/16] target/tricore: Remove pointless CONFIG_SOFTMMU guard
Date: Tue, 20 Jun 2023 10:26:00 +0200
Message-Id: <20230620082611.770620-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620082611.770620-1-richard.henderson@linaro.org>
References: <20230620082611.770620-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We don't build any user emulation target for Tricore,
only the system emulation. No need to check for it as
it is always defined.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20230613133347.82210-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 284a749e50..951024d491 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -31,7 +31,6 @@ enum {
     TLBRET_MATCH = 0
 };
 
-#if defined(CONFIG_SOFTMMU)
 static int get_physical_address(CPUTriCoreState *env, hwaddr *physical,
                                 int *prot, target_ulong address,
                                 MMUAccessType access_type, int mmu_idx)
@@ -57,7 +56,6 @@ hwaddr tricore_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     }
     return phys_addr;
 }
-#endif
 
 /* TODO: Add exeption support*/
 static void raise_mmu_exception(CPUTriCoreState *env, target_ulong address,
-- 
2.34.1


