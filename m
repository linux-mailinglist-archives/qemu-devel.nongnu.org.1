Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D1B7057A7
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yd-0006e4-Bh; Tue, 16 May 2023 15:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yb-0006di-BZ
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:01 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0YZ-0002lw-Ke
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:01 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-52caed90d17so9528070a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266118; x=1686858118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nP6uwN475NI4kEPgZuacjyw/HnU7r6xvn2JKlD8Wx/Y=;
 b=fwWcOFw0g3RNCfIsNcyJc89wsK0h5ZExv7lKDKVHJ4oy5iOuGeT4aUJq0rOw3IRM2C
 1mLpyCICrHPRWEf5w0n3RDOL8uDG6kxroY7sVGSTZE+GTiX9dQubAwDRc4xBdB5muy2z
 XXrCSuR+fEDc+UuXJaeNYGwHLdaUuo1UL5YBKDJ6w45EwRDzFDVIiaiVUgcWaQqGI5Vr
 YLF6sTTd5uq3SRPDI+xdc7BK4S8uykD3jJ1sqpNf4Kgi/O5xMEoQdHw2v/H6yR4aDYZH
 Ij9NTVPjr9Qwb6Wox7PDLry4kwacBNERNyHK9R53lgCiVcehCqqTo0ll5d06eesHKAWB
 Syzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266118; x=1686858118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nP6uwN475NI4kEPgZuacjyw/HnU7r6xvn2JKlD8Wx/Y=;
 b=J6By+6AdDTDeAKRImkS98ZN85yEG60dERKojMIaHTHQ4bwKD6FpOSSsgz/9lSTj63t
 quLK2ZyDeoS11lmLDZYLoHGy0SQYAbtj29PDLig5bSAHq8u/+CVzZcxTFiEekzlNqYYK
 pX9Dy8oiGkXUpSwKPh8Kv9ZO6Re58kRIzFJJZhyUjIETJdPNc1VMWEpwmTqf7QrswrJg
 7FYdvlzT2lr3abLvmHyu9YtOFogI2IdnRZsHAo4T/Od0cyHEWdaJknqMUPHbCjU3ugao
 H35E7+SWK9wptMW2yTviZrntmA7eK290YifADvQp+Cuw0ggbAP3luZyML8iu5F5CLlwB
 xh7g==
X-Gm-Message-State: AC+VfDzTuHUbOlYdpErf6lPfDzEARY/Sp6trMpwwVktzfBMR1Pdjr/8I
 d0G9l/klxsI6d6jWCH0sfEGH6zC1GRA/WyoyRHc=
X-Google-Smtp-Source: ACHHUZ6uUsBLziYiTZ8h7pDnNd1PhyAr4muXTIud9PX0CeD8HWQqud0YfENmSv3A6KOyOjeib3UhrQ==
X-Received: by 2002:a05:6a20:8e06:b0:101:ab2:eaa8 with SMTP id
 y6-20020a056a208e0600b001010ab2eaa8mr37857010pzj.18.1684266118248; 
 Tue, 16 May 2023 12:41:58 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:41:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/80] tcg/aarch64: Detect have_lse, have_lse2 for darwin
Date: Tue, 16 May 2023 12:40:37 -0700
Message-Id: <20230516194145.1749305-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

These features are present for Apple M1.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index fc551a3d10..c64606af5b 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -16,6 +16,9 @@
 #ifdef __linux__
 #include <asm/hwcap.h>
 #endif
+#ifdef CONFIG_DARWIN
+#include <sys/sysctl.h>
+#endif
 
 /* We're going to re-use TCGType in setting of the SF bit, which controls
    the size of the operation performed.  If we know the values match, it
@@ -2903,6 +2906,27 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     }
 }
 
+#ifdef CONFIG_DARWIN
+static bool sysctl_for_bool(const char *name)
+{
+    int val = 0;
+    size_t len = sizeof(val);
+
+    if (sysctlbyname(name, &val, &len, NULL, 0) == 0) {
+        return val != 0;
+    }
+
+    /*
+     * We might in the future ask for properties not present in older kernels,
+     * but we're only asking about static properties, all of which should be
+     * 'int'.  So we shouln't see ENOMEM (val too small), or any of the other
+     * more exotic errors.
+     */
+    assert(errno == ENOENT);
+    return false;
+}
+#endif
+
 static void tcg_target_init(TCGContext *s)
 {
 #ifdef __linux__
@@ -2910,6 +2934,10 @@ static void tcg_target_init(TCGContext *s)
     have_lse = hwcap & HWCAP_ATOMICS;
     have_lse2 = hwcap & HWCAP_USCAT;
 #endif
+#ifdef CONFIG_DARWIN
+    have_lse = sysctl_for_bool("hw.optional.arm.FEAT_LSE");
+    have_lse2 = sysctl_for_bool("hw.optional.arm.FEAT_LSE2");
+#endif
 
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffffu;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffffu;
-- 
2.34.1


