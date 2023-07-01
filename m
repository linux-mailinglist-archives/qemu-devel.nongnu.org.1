Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDBF744773
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:56:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUVs-0007Ui-Eu; Sat, 01 Jul 2023 02:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVr-0007UV-1d
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:19 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVp-0007Ex-7H
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbc59de009so20388975e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 23:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688194515; x=1690786515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=guLrkyvnxpE2Di61jdSFFK1pil20iWnpknoQn5xGxP4=;
 b=FvKPMtkac/boNy3/r1tm2aIAobRFpgPHT93iGO6YkmhwpTzvNcxwpgt/C+IRhHaiK/
 rB2t91xQ/8TeCfxDbd6MBXVwQNPa2C5Inj0WQj8h5LfCWwR40HSWGKy9wwuidUC6Oxv4
 ANcHuxOzRNZ0f3l++bsBL4sfWhto+NfD5PimOR9fC9orcjxabdZlB0ZMD1q66QNOxt31
 h1apDS/MfveZwLkdY2tht2EAU3m1UhtajodRNhewRCDuuN5gmFIYxc74RIXbtWfUlK0e
 cYQqCRZcFPea/KrN4VPRDtp2GqdZUkrmNK5SbbboXDPS6bid8qQRJNvukYGqBGmapti3
 /GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194515; x=1690786515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=guLrkyvnxpE2Di61jdSFFK1pil20iWnpknoQn5xGxP4=;
 b=UOu4QsZHR+B9x9GuBAeU3LuhHwZdByID3wVH4M0EDtO2Lcxiql1BMrB4TjFybk4+/K
 XxiH8iOUcreegVMqLRr7Gd8omz768/pYV8LOH6z790Cd3S811dYqcflhyc6zenLT1w0S
 SRXd9Py2DXkAuMeHK6wV2wDaxfM96+Nvcx2TtpgMLZL3Utm90l12MS0CVeim9+wXc/No
 sfWNZDOIOjn4j6Gy8NFBKKT90G5HkNxqWq+VQpPVN2HOtFvG6avn/eqfv/peQAH+hQUf
 TQhLiBrpqCFpKkvQM1YeKThJAFFmKGeD41b1xtU5W9Tq+ryrdFgMMhDs/Fgx3s+hKusF
 u3eA==
X-Gm-Message-State: AC+VfDxLoEb+oIO0yMadkjeNk+K3xuo/8ybBJKY545IpxOmSSDAgQeoc
 qysMdsEYZV4ln9HWtqokNOoZW9sIgHjFCnxMmwnjMg==
X-Google-Smtp-Source: ACHHUZ6Ygn64FVhTDwcL/YGjYGDQiMxYVjM3AhTyzgi121WJl7tbxMlANHTKtlUzG4IiNVs/JkffNA==
X-Received: by 2002:a05:600c:2292:b0:3f8:fc2a:c7eb with SMTP id
 18-20020a05600c229200b003f8fc2ac7ebmr3381081wmf.5.1688194515409; 
 Fri, 30 Jun 2023 23:55:15 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a1cf60a000000b003f9bd9e3226sm20874918wmc.7.2023.06.30.23.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 23:55:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/11] accel/tcg: Assert one page in
 tb_invalidate_phys_page_range__locked
Date: Sat,  1 Jul 2023 08:55:03 +0200
Message-Id: <20230701065510.514743-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701065510.514743-1-richard.henderson@linaro.org>
References: <20230701065510.514743-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Ensure that that both the start and last addresses are within
the same guest page.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230629082522.606219-3-mark.cave-ayland@ilande.co.uk>
[rth: Use tcg_debug_assert, simplify the expression]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-maint.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 33ea1aadd1..9566224d18 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1092,6 +1092,9 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
     TranslationBlock *current_tb = retaddr ? tcg_tb_lookup(retaddr) : NULL;
 #endif /* TARGET_HAS_PRECISE_SMC */
 
+    /* Range may not cross a page. */
+    tcg_debug_assert(((start ^ last) & TARGET_PAGE_MASK) == 0);
+
     /*
      * We remove all the TBs in the range [start, last].
      * XXX: see if in some cases it could be faster to invalidate all the code
-- 
2.34.1


