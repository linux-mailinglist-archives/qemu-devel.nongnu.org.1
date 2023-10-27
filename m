Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 906087D9BBB
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:41:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0F-0007Gx-FU; Fri, 27 Oct 2023 10:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0A-0007FB-Rr
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:54 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO08-00088i-7n
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:54 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507a55302e0so2761494e87.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417590; x=1699022390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bz4quSw4XJYtn+zFkVNPcs33W3qafYQj8GznRVOZI7w=;
 b=d+PEMrMBea7jgrZf6WMZkecJUbo7KjN65Ksw1o7fF4JKgD1Pov7/y895TtVtA8for6
 gMX+MRAkXh/DHgCc3XuGqnozHxjacEbwW8xwoVuEqwjTBO7gDpw7/aLqmf4C6Qp2u+4m
 yTet+ajOnD9eKoU1DFZV4Rg5jxB52In7RUb+bzCWTuQwF2h3QrC9PwT+e+ngmkCIZ/bI
 sEc020hU2OAAbM75EQ5JGgQ93CiM1cAV0VeXl1eKkeu7TLCjAozqI4fdDlxWBw1t1Gtf
 HP98oSRg5YkaI959LOxJURqeiGafEc/ivL1knJdd1CAeqT6SKIgFMt0OgzhL3alzG02/
 uuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417590; x=1699022390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bz4quSw4XJYtn+zFkVNPcs33W3qafYQj8GznRVOZI7w=;
 b=nTC3/j2i6cbbZT9/L9zP1Q4OcyO6Qk2XkJJdE7ddPa4H/eTJBGT1itBHTKlco3iF7j
 hf0Twqfo1CvlmJRyV6isO8K1bfERSRudZBxR6O3Gc7yc+swm+2tIFSIh88R6Rxz4Fm9L
 boO32en3ci4OX2sEA9SebdcEpisVnYVKeWc2zKJynHFLa9GHG7nJdGOqm1hQ4HCKZYmB
 9j9vyQLG/oQXjxKSSdMLiuK6UIrHSAatVZqysDTzgNDEckOCIcwuPPK+MFqZhbdk0I5t
 JElUVTFNpaUcuTTuBuvFPGEg9JJibgkYjLfgv4MkNZ05DWlqqaEr18TWbsTC0TXoLwq1
 sztQ==
X-Gm-Message-State: AOJu0YzWvwvRLVJEePnZmYGbLLfVGqxsHcNk5LNV3lZ5ieg1nmMzknVY
 T1UUri/Q4G/VekyffkKjUM0CGfRsWzdZi8gtZUg=
X-Google-Smtp-Source: AGHT+IHWPHTmV8sLR/oxZUV+Hz8b12aEKhVXQaaG1YYO3FNsO6TI218vmy8FyOh63trDI4+zMftiGQ==
X-Received: by 2002:a05:6512:2349:b0:507:bc6b:38a6 with SMTP id
 p9-20020a056512234900b00507bc6b38a6mr2582107lfu.33.1698417590364; 
 Fri, 27 Oct 2023 07:39:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/41] hw/arm/fsl-imx25: Remove 'hw/arm/boot.h' from header
Date: Fri, 27 Oct 2023 15:39:14 +0100
Message-Id: <20231027143942.3413881-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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
Message-id: 20231025065316.56817-5-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx25.h | 1 -
 hw/arm/imx25_pdk.c         | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 1b1086e9458..df2f83980f0 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -17,7 +17,6 @@
 #ifndef FSL_IMX25_H
 #define FSL_IMX25_H
 
-#include "hw/arm/boot.h"
 #include "hw/intc/imx_avic.h"
 #include "hw/misc/imx25_ccm.h"
 #include "hw/char/imx_serial.h"
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index b4f7f4e8a7f..7dfddd49e23 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -27,6 +27,7 @@
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/fsl-imx25.h"
+#include "hw/arm/boot.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
-- 
2.34.1


