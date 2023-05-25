Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB7E711A92
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:27:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2KLY-0005ps-Ly; Thu, 25 May 2023 19:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLP-0005mX-QO
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:12 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLK-0005kz-La
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:07 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ae763f9c0bso964205ad.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 16:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685057161; x=1687649161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvPlN3bWbcwG4Z4jy3Ej1l53fdQMXRJE0/Y4IwND3T4=;
 b=kL7pSfnZ1zEcjAqurOxGtT+rC1Fyfwi8qQgeASL9LYTZoM2/Flo1KbOcRkzp1DFnKI
 sbHH31cmSa0vuXQIoY+vnUUg2hGQZQ8yLa5W8l4dpuKeyWtU8MAuzNu6tAhfAtYO9Ph1
 yyLbYj3+eubo7JFb0FZ0aOZToSZodKA4vx0gov/IRrJfpbyL7dcI5U6wb5FiTc4JwV1V
 g6eCqywL4UfKb74Nc+nFRrQPJNZCw5AF00ByqHzjpx1Nv5cSIGHigNs2UTw2IqqtS4N9
 n//mII291xkmB8+yOcOJymbd3ZZkDL1jXwI1li/S9qyH5Rjwt1QNEcx4p104FofLrbra
 wzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685057161; x=1687649161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gvPlN3bWbcwG4Z4jy3Ej1l53fdQMXRJE0/Y4IwND3T4=;
 b=OmI4nBL5eP9R92ZJPbekjgIaF11eoyxNguTbpimBRHiyBJM6GbUN0NsSDmCiSjw4Iu
 PjXpjj6jjVP3GdLlGYWNDcylkwjtSbqsWatiS/tsvNPtsomGLFdlYP03FseXGdglfePD
 D/O4y/pB6JlZ4s9s79Q//TOw4F+pdFHY72ogtRbKcE/F9ajA8GFg5KmVzkYRZfWFlPwT
 lPoBQmkJ+o61SQk8M3uSxf8L4pxMAqbGHbzU6MIN2Dgct6VaxwbjaUBZq7qpK2NiTqIv
 yOo+9KJBLhfXBfo8g8hEKMKFcb2Ib/e9jlwYRj3pJ7OvXmkqZ0ZOCNqvHZVvcH9jJAj9
 JJ/A==
X-Gm-Message-State: AC+VfDzKlgu2J7OP0oE5SNW0Rp+Wava9Urifk1vX1DFter4UfAFyH/LS
 CaJM0ePWCsnrV8KP7kpHZ9MvTr0HFI4UI6gECzo=
X-Google-Smtp-Source: ACHHUZ5AOSaEw+TcmF/3IAur5gQ2zJvh0RuTETlZf7kDHb6wIqEAG4/tl+Tknt3pTXuGzGE9NwkGRw==
X-Received: by 2002:a17:903:22cd:b0:1aa:cf25:41d0 with SMTP id
 y13-20020a17090322cd00b001aacf2541d0mr422457plg.33.1685057161282; 
 Thu, 25 May 2023 16:26:01 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b0019e60c645b1sm1885036plg.305.2023.05.25.16.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 16:26:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 02/20] target/arm: Add feature test for FEAT_LSE2
Date: Thu, 25 May 2023 16:25:40 -0700
Message-Id: <20230525232558.1758967-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525232558.1758967-1-richard.henderson@linaro.org>
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4e16eab82e..36ab66d0c3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3850,6 +3850,11 @@ static inline bool isar_feature_aa64_st(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, ST) != 0;
 }
 
+static inline bool isar_feature_aa64_lse2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, AT) != 0;
+}
+
 static inline bool isar_feature_aa64_fwb(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, FWB) != 0;
-- 
2.34.1


