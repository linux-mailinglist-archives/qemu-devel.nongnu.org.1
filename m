Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8213752BEA
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:16:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3eb-0000QP-9B; Thu, 13 Jul 2023 17:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eQ-0000Mr-7T
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:15:04 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eC-00016F-Cu
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:15:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3141c3a7547so1322193f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282885; x=1691874885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uiRxUWQ/HM/fmJF0BXMvciSYviZrpuPjzgLczxVKcDA=;
 b=VlDqWrH/ORjSn+/ojaVyuYiDoF8hi91RgmPXuZw1PpXzH3X8nfDlYA6T5NEvvDWpiy
 Jr8EGE9k1e6CNXDLoBsHF91xGt4kvKLwRKfDHHqQsK9bwFFIbySRS+gBzYnsmrlHJRy9
 ZYU08Z/9kwbDPOeGGDe3ECNruoQAeACnXGC48DN3+osnWYBR3gm+BOce/xpQ/VqU0Jyj
 a5j8CYoHiVm4us5EMlcADlZ5KgN4QBwU28RPVd//Xmh7qgDSaqYfewfFLHOJOrNLgT/G
 1wVEhU2Is3LKIDmZg7cH11ZqMZdRl7Ursrx1vdSQ+Wk4lcr6bvjS4A9sJ0Mv4mQMboxj
 ITmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282885; x=1691874885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uiRxUWQ/HM/fmJF0BXMvciSYviZrpuPjzgLczxVKcDA=;
 b=K5MhPdGfWqhKcj9X9T/mhUr3OmPQ1dAD/M0TSVXfdnEVCYFuEVwP6nvPBFofFYwo3j
 ISnUkSNYirQ7iol2HjCP34CGJeb8oyIREePr9kmsUZmP+I8xSLn3JHfMHo/cTcnA73ZJ
 HfJ+efUQQpJByeVzBMtwWyMhcjQzCAF0KNOESdjqsOD0BNTkm5GfZk7W5Q98jNyW3m3r
 vUpbuKlh8wt5mt0VIUKWZkboMGmxwPL20aGb3RWgbIr4injCK34QC+h/Uwt7vFzJpJCf
 faxY7dEeRCRedBuiI0f3MQnvul9px1JElBcFqjXuP4XfYwOAaYq3kcSnw7tP86KCT+sN
 8W8g==
X-Gm-Message-State: ABy/qLbuJANSXpCTKNwZ4Sd3ziY3ktd5mPovm9YUN0SJfreZd4kr4QqF
 eZoLPjuUvXbDajiVTOPM5ADkaf1mBQpF9GGe2jN37ZOx
X-Google-Smtp-Source: APBJJlG0jPqI4l8kGNT7wrzvc6423Sh4Ygla4z4rQZcfykRutyRakYJspZOzBEr+Xz1jFyvYqzZUKA==
X-Received: by 2002:adf:fa52:0:b0:313:f07b:8025 with SMTP id
 y18-20020adffa52000000b00313f07b8025mr2404490wrr.47.1689282885800; 
 Thu, 13 Jul 2023 14:14:45 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 04/18] target/ppc: Use clmul_8* routines
Date: Thu, 13 Jul 2023 22:14:21 +0100
Message-Id: <20230713211435.13505-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use generic routines for 8-bit carry-less multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 834da80fe3..3bf0f5dbe5 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -26,6 +26,7 @@
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
 #include "crypto/aes-round.h"
+#include "crypto/clmul.h"
 #include "fpu/softfloat.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
@@ -1425,6 +1426,15 @@ void helper_vbpermq(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 #undef VBPERMQ_INDEX
 #undef VBPERMQ_DW
 
+void helper_vpmsumb(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+{
+    Int128 ia = a->s128;
+    Int128 ib = b->s128;
+    Int128 e = clmul_8x8_even(ia, ib);
+    Int128 o = clmul_8x8_odd(ia, ib);
+    r->s128 = int128_xor(e, o);
+}
+
 #define PMSUM(name, srcfld, trgfld, trgtyp)                   \
 void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
 {                                                             \
@@ -1445,7 +1455,6 @@ void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
     }                                                         \
 }
 
-PMSUM(vpmsumb, u8, u16, uint16_t)
 PMSUM(vpmsumh, u16, u32, uint32_t)
 PMSUM(vpmsumw, u32, u64, uint64_t)
 
-- 
2.34.1


