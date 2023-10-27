Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 721D97D9BBD
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:41:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0F-0007HY-F2; Fri, 27 Oct 2023 10:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0B-0007FS-CL
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO09-00089G-Be
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:55 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32d80ae19f8so1451825f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417592; x=1699022392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PmrQWRC5NaTWdnVXX29KPny7C1ylyTktaxRIFDqRHdE=;
 b=UJETF10E/rrw7y8tTbYoReAhtYI8C3GXEzBEAIC9qKhL8/ioCdEn21wqb+WarH7xyt
 zn1c+S9guhKQJUovafvAjTN2xMAukxIItSC4Anf8Qh0BL+ucEH47SzQwn//pw0+J8QJ5
 ySwBkW8Sir8SmAqVr7EamAK8gbG3821vVXDQckLeqRGwRpeIix301ckYUt8FlaSnPnG+
 aG/X4UnTBAwgHky9xkFlVvdO1jpj2wIjgDaQ0iAyxU2HFEiXI4lxvlXgCed/f1IflXOh
 ePnvMtoOljeC0RmuKD//WAhJmAJcl+T5hGr2hm088BnQP3S3sLBJjKs+s/gz/OHiH/Ff
 rzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417592; x=1699022392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PmrQWRC5NaTWdnVXX29KPny7C1ylyTktaxRIFDqRHdE=;
 b=vhSIGovTUFPc8TslNFS42LIDfIByTHPUN6K+I5jB7Fz4Q/wEpa4wtqv5eZe/6pNuUs
 Sk/rAZ3Ix3MenBoXoMXUKRAIdBeqYPdbXUTddpd0D0W9RO9JMt2xJebfKLABDgbw3Efb
 zli34MX8x/WMRO6pTsrR/kbCwkcHGsskRYmCtGkfYDlt/PmL2pehWy7bwQXPTU8U5aK9
 vZamnFz8pztlUHPS2/BbjFElrJ2KifWVoztTlu1zqOLGRjXZI9GXEJg4y1l2gHh7ldAm
 iTRiOulfX6DfRzvNakS7Jg5Iyc1qK69EB7mZgvBtMIVLdvMQxBzVmlmzLUwg19LVyTfF
 ZLwA==
X-Gm-Message-State: AOJu0Yy7lCKTH+rQ8bYghzYVy9O8AcpJk2HEKZo62t6y8RaQmMCwXUxP
 CrZucc4boPYeeZn513FHCSmmLcRdirt6q++7BGQ=
X-Google-Smtp-Source: AGHT+IEsTbT58KELAkP/dFD09RCEh4+5e58ZMKO6m45/UgUeZSn/QWNUlxRD8BmyVhIrF8qrEGaVhg==
X-Received: by 2002:a05:6000:acf:b0:329:6662:ac1d with SMTP id
 di15-20020a0560000acf00b003296662ac1dmr2660099wrb.24.1698417591844; 
 Fri, 27 Oct 2023 07:39:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/41] hw/arm/fsl-imx6ul: Remove 'hw/arm/boot.h' from header
Date: Fri, 27 Oct 2023 15:39:17 +0100
Message-Id: <20231027143942.3413881-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
Message-id: 20231025065316.56817-8-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6ul.h | 1 -
 hw/arm/mcimx6ul-evk.c       | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 63012628ff0..14390f60144 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -17,7 +17,6 @@
 #ifndef FSL_IMX6UL_H
 #define FSL_IMX6UL_H
 
-#include "hw/arm/boot.h"
 #include "hw/cpu/a15mpcore.h"
 #include "hw/misc/imx6ul_ccm.h"
 #include "hw/misc/imx6_src.h"
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 3ac1e2ea9b4..500427e94be 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6ul.h"
+#include "hw/arm/boot.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
-- 
2.34.1


