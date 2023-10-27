Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6362C7D9BBC
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:41:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO09-0007Dn-Ti; Fri, 27 Oct 2023 10:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO08-0007Cs-Bv
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:52 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO06-00088A-QC
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:52 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso1393834f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417589; x=1699022389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HGUtiMRS0+Lv2+oiMjotQOi7uPWbvV9MFPbKTgd0KCU=;
 b=t9/xTuT40+GWo0Sto9I3G6do2vZsd3hqMZsRxw9L33SxSbvrfISqI0ddmuH6aSxhqQ
 rOnGZsPZ3Z8HWpf1gID0+y8sBaNHnLfBqwMsPfVk8mn5HTW6x/89Gaxu6R6hF5Rj9cKQ
 1nVIYcm0X7VQJV6TxJdiL5sG8470A4qDg+hqI/oTZ6hsmjA4fa8HUwNAB/7Qlx/gWv3r
 DSBOvImrzPr8SnUIqmgqHL4zOc/xbQepHOMvtbhErTaprSPJad3DoJiF9pvjoYVLcOfV
 DBln9goGcAqewEpadIQ+oV8nBSXpmffaDIqZ5dczQ6M3qDkUx3BL4J1iEewNfmIY28t7
 gRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417589; x=1699022389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HGUtiMRS0+Lv2+oiMjotQOi7uPWbvV9MFPbKTgd0KCU=;
 b=rUfcnw9LmgqmeGB15HWPE4C4ncH0UaUKj4crLT52klU4JfZvv+fN2KkMRQFDRTuKQ6
 JRz2J5rTvAvd3uGqsHEGRYmRaGxfFBpSca4OvRaMM/6ctsLzijcIQ4Vekhz1MLGM29TR
 ggg2wWo5RIl0tzKdCKztYyqYczATGWzodpjWJqW4p4gCGqkowj8/KrnHQApchvav7GC3
 8T75DFtcZnySg+sHvxbZk20fipuLPOZINIZcRzUct7d+KKUU8fEPC8a6AI6xMcb3wvCW
 kYPUD9BMZE+PiXe+ZQRSvS6BrfNLufG4bWwOGkljEccsik7NkpKltJp0tIw7SJQZQj/R
 FEYw==
X-Gm-Message-State: AOJu0Yw4uTYmj7MCj3s21dVC5g5IssZ7Ftcnn4wYDE7aK+scAGNa7eDJ
 Alydl9Iatd4bSLKWx59JfglCYp3/U8gWqnX1EDc=
X-Google-Smtp-Source: AGHT+IHdUXF2HIsyodz4cV2yOftbjzDDKitiWroz0gCJfcHhYM6g+O8L7hbGi77tJ8wrLl2XR2FY8A==
X-Received: by 2002:a05:6000:c8:b0:32d:90e6:c477 with SMTP id
 q8-20020a05600000c800b0032d90e6c477mr2212244wrx.26.1698417589242; 
 Fri, 27 Oct 2023 07:39:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/41] hw/arm/allwinner-h3: Remove 'hw/arm/boot.h' from header
Date: Fri, 27 Oct 2023 15:39:12 +0100
Message-Id: <20231027143942.3413881-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

"hw/arm/boot.h" is only required on the source file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Message-id: 20231025065316.56817-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/allwinner-h3.h | 1 -
 hw/arm/orangepi.c             | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index f15d6d7cc7d..24ba4e1bf41 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -36,7 +36,6 @@
 #define HW_ARM_ALLWINNER_H3_H
 
 #include "qom/object.h"
-#include "hw/arm/boot.h"
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/misc/allwinner-h3-ccu.h"
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 10653361ed5..d0eca54cd95 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -25,6 +25,7 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-h3.h"
+#include "hw/arm/boot.h"
 
 static struct arm_boot_info orangepi_binfo;
 
-- 
2.34.1


