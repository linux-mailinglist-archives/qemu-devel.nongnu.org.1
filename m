Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E756D72E1B1
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:31:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90UL-0005Pt-5V; Tue, 13 Jun 2023 05:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90UI-0005M1-B5
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:38:54 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90UE-0005Yg-Kz
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:38:54 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9745baf7c13so781169266b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649127; x=1689241127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSCMOMiEbLUM1Wk1LAbR+FG1B8HkFWQqVaD6LVaKVVI=;
 b=Fbx+Y2sTOWlOzGtF+XOqdQ4xEH5zruDmrJtMnBiflePZ5DCREag2JlKofH+6PdUQwi
 5sJLb50AhBsk/zSAl9yN+kpF5I28dIpL2fM1v7B+i0jEl0rMeOux6y2xlxpKf1qacl6r
 GI5iDqFJz/bYQ/HKzgp7ay2YRpGdwFGZCnHCZIHR7cpjU5kEKi3BO2SLzmcr9P4OHeWW
 N9YTE1SXJGN3OrLQUD5de+PJyQUJj8agOabGVTkfkLMrk9+pNlJUd2KHiVGPH6VxK4HL
 BXHx11A2ALhFDNLLWW90m5acF0TgOl3Hh2X7I7Qj1HxCwJeWgtZ5lCyfnYeeaJMynFkJ
 YvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649127; x=1689241127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YSCMOMiEbLUM1Wk1LAbR+FG1B8HkFWQqVaD6LVaKVVI=;
 b=L3AH7HgD9kb7ufqFCKJJPmu8WrD0g7cXwkF3Ilfg6I1lIiUCF2ofk7LRdPPOJLiwd9
 hCaCv7FpYMDm3IqGsaQxHFtxHbXMFVOXbxBsi9KQG2qOHunaGDgEWWmSXU1sKtoqrVw5
 kE5UppMawH1AG+gtRrFTgNgoEUJCPBkOrjJg23Mru3Nt3zEkatJ9j19W5Ie70qD1Jzfz
 8X+VcbyAlegXderMg0Zv/GE8U35kUkUgnP5w/3kUvlPWI9f9SvI2P7UTTS2OfGUChzCp
 VyRwFnlF+TtCnnMD3UxZVq2kxVbaV2xisPfLsijhdpBRMKYOlmLTZSyLEW3meSqveR/u
 hUcQ==
X-Gm-Message-State: AC+VfDwkBXS/kozi89f393spH4x28M2tgB9pvs1lWdFy/dst1gHsrkDq
 E3v5YOi83jpuoYC20mhycqruCl3BI/Tsf6SuLxiMAA==
X-Google-Smtp-Source: ACHHUZ5ve+O8D8woiB0/eljv2RXuGAKJXZOeX2O7av+uzh85x4tqsIOoSgBkhLyvG7m0r1INRLcBJg==
X-Received: by 2002:a17:907:97c5:b0:982:45ca:ac06 with SMTP id
 js5-20020a17090797c500b0098245caac06mr335280ejc.60.1686649127569; 
 Tue, 13 Jun 2023 02:38:47 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 qc11-20020a170906d8ab00b00977d7ccd9fdsm6532138ejb.95.2023.06.13.02.38.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:38:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Antonio Caggiano <quic_acaggian@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/17] accel/hvf: Report HV_DENIED error
Date: Tue, 13 Jun 2023 11:38:10 +0200
Message-Id: <20230613093822.63750-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Antonio Caggiano <quic_acaggian@quicinc.com>

On MacOS 11 and subsequent versions, in case the resulting binary is not
signed with the proper entitlement, handle and report the HV_DENIED
error.

Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Message-Id: <20230608123014.28715-1-quic_acaggian@quicinc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 754707dbfb..4920787af6 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -38,6 +38,12 @@ void assert_hvf_ok(hv_return_t ret)
     case HV_UNSUPPORTED:
         error_report("Error: HV_UNSUPPORTED");
         break;
+#if defined(MAC_OS_VERSION_11_0) && \
+    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
+    case HV_DENIED:
+        error_report("Error: HV_DENIED");
+        break;
+#endif
     default:
         error_report("Unknown Error");
     }
-- 
2.38.1


