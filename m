Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC33E7D61E7
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 08:55:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXmi-0000Mg-RA; Wed, 25 Oct 2023 02:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXmR-00006K-F9
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:54:17 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXmM-000747-QS
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:54:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40837ebba42so38812955e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 23:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698216849; x=1698821649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbX9ix0vxP1Hq2bipHzMFUuRkuwci5ry9OmEL3H5n7Q=;
 b=j54g5TNlZUQLUtnsMmgthscqlD7xEubGFFp4m19oqm6AmYOSVsj4zNPXWg+8fHjYve
 tgWd6FfJUiwE2U4i47kRdo5ZMDOa77ubQsXX11JoCAY3RRDdn4rIKdg1e055cmvKLx16
 qLv26FEaOprCXDGSeRIC0DW2BINu+g8vxr1fzmFQKOBBMJ3fyN2jrTUx6lJeEir7Beo/
 K7z2L2GvEkJZnJ2FF/Yevij5fZxH+pmnEXgaq76QSebxoDNYS3MwnDb8eTiZays5N6bG
 woiACx/hEcDVPo3xDMsaiA89WTSvm+UlYQS+eA3xrW7pCDFGqFW+3bsluvss+RlV5sWh
 a+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698216849; x=1698821649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gbX9ix0vxP1Hq2bipHzMFUuRkuwci5ry9OmEL3H5n7Q=;
 b=hLjZKJiXejQtOY/pc6R74Dv+sVG+DmJd5vkHozBvZHp+hrEkENTo6+d+rzCgEQ1QSC
 JsKNRinZaesJmrC2wByiB5LcaLqLQEuTrUZMrKrWNQ+0Hm4wLkIQMCCaCjO8aBe17Oe7
 McZlAwmGCw1r/kHEJfoSHkHJwyycLHJIL2XlrPe6wHwXjegA2grkUcPzMgj2EkJh/+gr
 xD/jpQoaJE/iQDSMZJGj0FS/OBC0ju16FpVfWPgKRWZl8KNRZafcYWtPel3UfXkmZ+rP
 ME6K//3j7OuYysAf9/8EfkJ5GgqWQexZkXYf31tiAWIDPl1FZdguLDTn5mFSADnRjkwD
 DroA==
X-Gm-Message-State: AOJu0YwRpOdKmBNf5wFUGfZe6X3NbshNrYmDCYsaiI4NCLBoA7X1OwNF
 AESjMz0/0kln59eCgn8/fhdlcz7UpMOYiYGRfTY=
X-Google-Smtp-Source: AGHT+IFU7XZi5jnLNPGSl2hvT5RAqpIsJqgIEC8EOuPjfFHcV021y7ZxwGmwvnsx6G/6+gq14XlkxA==
X-Received: by 2002:a05:600c:a4b:b0:3fe:2a98:a24c with SMTP id
 c11-20020a05600c0a4b00b003fe2a98a24cmr10556858wmq.26.1698216849091; 
 Tue, 24 Oct 2023 23:54:09 -0700 (PDT)
Received: from m1x-phil.lan (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 x10-20020a05600c21ca00b003feea62440bsm13487575wmj.43.2023.10.24.23.54.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 23:54:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 08/10] hw/arm/fsl-imx7: Remove 'hw/arm/boot.h' from header
Date: Wed, 25 Oct 2023 08:53:14 +0200
Message-ID: <20231025065316.56817-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025065316.56817-1-philmd@linaro.org>
References: <20231025065316.56817-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"hw/arm/boot.h" is only required on the source file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/fsl-imx7.h | 1 -
 hw/arm/mcimx7d-sabre.c    | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 2cbfc6b2b2..411fa1c2e3 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -19,7 +19,6 @@
 #ifndef FSL_IMX7_H
 #define FSL_IMX7_H
 
-#include "hw/arm/boot.h"
 #include "hw/cpu/a15mpcore.h"
 #include "hw/intc/imx_gpcv2.h"
 #include "hw/misc/imx7_ccm.h"
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index d1778122b6..693a1023b6 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx7.h"
+#include "hw/arm/boot.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
-- 
2.41.0


