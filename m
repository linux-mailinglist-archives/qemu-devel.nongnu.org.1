Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 936F297522F
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Sep 2024 14:30:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMK9-0004gY-0G; Wed, 11 Sep 2024 08:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMK6-0004bT-WF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:51 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMK5-0007jL-FD
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:50 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4280ca0791bso62816645e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057188; x=1726661988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZUo8rGZSom7mlAfCU5Z2bDlbbhMhxBWW2+c4LGYwQ+E=;
 b=jhgSymHRtJweLm4rOEYW4zXS5jqZU/ehAKsteK6I4Gi1tuPTlcIndQXbNmJ7+rx6Tq
 fZ5y0MZA3jgp0D3UEKKDLAunXE/2egDCFg1ho+kgxfseiPBeSNhBXus6CjYVizXSZFoV
 fgXFYCsPn/T4FTJCkiigAd5wAT8gTn4Ue8aSsyzZqvIuoh4nUdHKGrvHu2lEICiz0rcy
 3pFuFHfhkvvLrIZZ9vsTICujJwrkYj3HK3iG1TzfFxr2xaQzrG78FJ5hs1vZY5RBI7YM
 Dwn51LkY9N1SekT60GcKDgwI/pSFszZY2uljSKDQgm2GCX+OQkLElocDbheDagqQUvZH
 jdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057188; x=1726661988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZUo8rGZSom7mlAfCU5Z2bDlbbhMhxBWW2+c4LGYwQ+E=;
 b=I5eW7BIQYtAMA2oFZCP0PQo91shd+CEfdsiKnix70ueUHJW/coIVvSF0EsrJ8uIwe2
 YDpPCYvIgkr0QjycyhXemWuEjg8tgppu7c4nwGLVdDdrhZ0wDtBMdLpe20lgFaC3b3wO
 HdQ9MXfG6haSATSm1EZ5SwR113CRmCFRmWu0yFtqJ0nnqA1H+BfB86+M7tsR39/eKJXe
 8APl2WE5ofH2PrUxTz0Kd+yAhCEyX2J/JbGI1tYOhTLVVVU2uVeiC874CJKlx/cHiffB
 gC2brljanwiAQdGYrGnymFz2mMrIVsotF8S4cRFq/ggLBD+dHYDycvSBlQJktBKSotwP
 zf7g==
X-Gm-Message-State: AOJu0YwTr8XOW0wp8HDpxsSBOvlqLkZd9lJl1jBZ3k8c1O+YN1iu26K0
 AKuBfEGpwwIIR/+B1DqSKxwsY25ll9w6xGTdE79t+C64ET9gSXXy0zze2nzm1vNMvYXNF9rFEHb
 o
X-Google-Smtp-Source: AGHT+IGgAFDjM2lpLym7EF1EulrqmgGPrdtcIvf4+b5Fgc7dUWijLaOrSSIaRIxMLDJAngB6O6qF0Q==
X-Received: by 2002:a05:600c:4798:b0:42c:a574:6364 with SMTP id
 5b1f17b1804b1-42ca574664amr121721125e9.12.1726057187581; 
 Wed, 11 Sep 2024 05:19:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb4444asm140843695e9.22.2024.09.11.05.19.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:19:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 47/56] hw/core: replace assert(0) with g_assert_not_reached()
Date: Wed, 11 Sep 2024 14:14:12 +0200
Message-ID: <20240911121422.52585-48-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910221606.1817478-6-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index f8ce332cfe..14283293b4 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -380,7 +380,7 @@ void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
         }
         lb_data.data = node->bandwidth;
     } else {
-        assert(0);
+        g_assert_not_reached();
     }
 
     g_array_append_val(hmat_lb->list, lb_data);
-- 
2.45.2


