Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DC77D9BB5
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:41:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO09-0007D7-E7; Fri, 27 Oct 2023 10:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO07-0007Ch-Qw
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO06-000881-37
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:51 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32f5b83f254so1475540f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417589; x=1699022389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eWOBdgQ7vK1VMcf/yXxF0qOWq66TWAm+9h+xR++3zSQ=;
 b=EJy4Ll16TiMbgrrPFBiTntQy+0QH9qh6sV0wSPRK+Fd7Ovz9LkSIUt05oXWNC5ogPV
 wEvsoZNHH+6vd1lM84cSMncq8ntmc1ik+2+lxKusHfIwvLnAnBl4Bw2mMWL8wOyxqfzm
 sZb2WZ9oADCEO9QAFeLoX7UpKzASpOqALL4D7FCmCC6jzmAduDlkJzDvsUSpqM8Zfubq
 2kqoOPzQgL1uWtm8R0ioldVdlesYF7Yo52SQv1T4ntMsKcwDnVNq9bfZtX6WsBVrqZNR
 Ll9xUl6jQbBJWrp7qGajeJqPF7nJeE9eVBKI74FIfN6wn5iIUUVVDkkjedl2Rr5iklP4
 e2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417589; x=1699022389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eWOBdgQ7vK1VMcf/yXxF0qOWq66TWAm+9h+xR++3zSQ=;
 b=O24uoJQ4MNMGiXFyQrmJqYLu5yyzBwkx+mgWAb5u1LUYE9hac/K9t5/frC6Ipgv1tO
 3FxElapFC+wp+6wS+8a5wXn2wedYsqr8BOF6C/vOjfX3hdU4EmFnnz2tN/IMsi+csfb9
 c6s/8G0v2A6Y189KrZ3M5X2PNi/kupmOCQk+JKNhjFmDHtXzURcK5WKjjaV63pNusoG2
 Q+dQvB1AP/oQKYJ/AvsQvBY5Iy5bwBwerpGCckPik30R8zwe2FT+KBXg5x+wD26c0jV0
 YwCEu8MvONA7Xf3CVuAZCUFVAOuMnUilPe11xMn4OU5Z2mGIzbYGFhkXPkKlh8oqM7AC
 bhog==
X-Gm-Message-State: AOJu0YzgyOS3st9e04kOrnv8mqbMECj37Wtht2SDqav5pIm+6QBCUclO
 62P3LoPJmPQoihunr8dTCLYimgzEKL1ndaX5r34=
X-Google-Smtp-Source: AGHT+IE35y/QOQf7Ok7UkN+recCFPW/tH60L7/MVaMP6/0uBO7pEC8OUlzFmNGlsVFQvVjCIpJ3TIQ==
X-Received: by 2002:a5d:4d09:0:b0:32d:9d99:94e7 with SMTP id
 z9-20020a5d4d09000000b0032d9d9994e7mr2473378wrt.49.1698417588857; 
 Fri, 27 Oct 2023 07:39:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/41] hw/arm/allwinner-a10: Remove 'hw/arm/boot.h' from header
Date: Fri, 27 Oct 2023 15:39:11 +0100
Message-Id: <20231027143942.3413881-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
Message-id: 20231025065316.56817-2-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/allwinner-a10.h | 1 -
 hw/arm/cubieboard.c            | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index cd1465c6138..2eb83a17eae 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -1,7 +1,6 @@
 #ifndef HW_ARM_ALLWINNER_A10_H
 #define HW_ARM_ALLWINNER_A10_H
 
-#include "hw/arm/boot.h"
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/allwinner-a10-pic.h"
 #include "hw/net/allwinner_emac.h"
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 8c7fa91529e..29146f50181 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -21,6 +21,7 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-a10.h"
+#include "hw/arm/boot.h"
 #include "hw/i2c/i2c.h"
 
 static struct arm_boot_info cubieboard_binfo = {
-- 
2.34.1


