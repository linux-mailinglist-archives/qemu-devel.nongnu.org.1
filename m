Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EE5770B10
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 23:35:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2R0-0006Ex-Ff; Fri, 04 Aug 2023 17:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qw-0006BU-VV
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:06 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qt-0001u2-Tu
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:06 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bba48b0bd2so18423395ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691184841; x=1691789641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5oE4+VawxP53rOCLWmxeNePvIcIJOdD/vpw31mMUWo=;
 b=UPoCeymMzGnTBs7rPD2U40pVUXs+pHUREb+urVevkjKv0vF8ykW7dQliPFvXp0wHSB
 5WWouf2GCycui5PtlMcuHbjIUr5z+hThtlkGOMxGAMwPyw8jhDKAa3FxxfIWIrLnG6Le
 eWgKa5dWyxeqOw5xD5yfdVMqVCIpPzM9dzLf1sox377zTVr9pPb7SMj1/KWDo3HY0lP8
 6xYoO+5tsFavuU62AU9VPK+2mD9GMJKjwBi1kmvNx63N0GRG321v7xGxJSM23xecHldO
 EzbzHa3rCnUC2uOhepDxjvmH749SToTT0ERQWAP4PoAw5fY/QlNVIsxeDGZuHrRrXP0d
 4HIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691184841; x=1691789641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5oE4+VawxP53rOCLWmxeNePvIcIJOdD/vpw31mMUWo=;
 b=iHy/b0dY2J/QFBJVO8NnGtsDs1AATU+qjIvZTtjVUjIcgeTJ22UldtUCsXUrTo2zhr
 LcPtnPXaLd0kqLyLHnY7qvvlhLNXuU2BtoGWzXetjExcJ+CM3YwlhCuDh3MKqO6QZd4N
 yCkhoIjkTFPjmHFVvFX1vuixyDPcO4+xmDyCCtnWx0jE0MqsNyR6pGnSNps8l5f5WV6k
 MT2eZvxvpZlmGCBUvB/TIB+OekANVT8zS1VPOptZdJnUCXKPGd2RBKC1fNC8eq8Ww4ni
 OooaO3Q/JE9MvbvF5vv4GLug8QgiuqZArEN5diQM8nPNGIZaZoB0DimFzz9W61D2q+hd
 NPXA==
X-Gm-Message-State: AOJu0YwK0VHAZPykBw2Y+OvuRw6CShy2yBj8XlLZUeoXWe4x3hfFa4fg
 eipObKC5Rq4f8EXpHKSeQ/LBzoIRTAaHaQD+vjo=
X-Google-Smtp-Source: AGHT+IGaffblbGk6Yc23781WvRSH1IEHMTNtFd/CMErOhUrN4mhAtxMCaZFvdfSYFOLgFsPRQgVuVg==
X-Received: by 2002:a17:902:dad2:b0:1b3:fafd:11c5 with SMTP id
 q18-20020a170902dad200b001b3fafd11c5mr2594356plx.44.1691184841626; 
 Fri, 04 Aug 2023 14:34:01 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001ae0152d280sm2188662plg.193.2023.08.04.14.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 14:34:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com,
	qemu-ppc@nongnu.org,
	bgray@linux.ibm.com
Subject: [PATCH 6/7] tcg/ppc: Disable USE_REG_TB for Power v3.1
Date: Fri,  4 Aug 2023 14:33:54 -0700
Message-Id: <20230804213355.294443-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804213355.294443-1-richard.henderson@linaro.org>
References: <20230804213355.294443-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

With Power v3.1, we have pc-relative addressing and so
do not require a register holding the current TB.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index e8eced7cf3..5b243b2353 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -83,7 +83,7 @@
 #define TCG_VEC_TMP2    TCG_REG_V1
 
 #define TCG_REG_TB     TCG_REG_R31
-#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64)
+#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64 && !have_isa_3_10)
 
 /* Shorthand for size of a pointer.  Avoid promotion to unsigned.  */
 #define SZP  ((int)sizeof(void *))
-- 
2.34.1


