Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD68D7D9BDA
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:43:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0N-0007LX-Tw; Fri, 27 Oct 2023 10:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0D-0007Gq-27
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:57 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0A-00089e-4n
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:56 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9c773ac9b15so317375666b.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417592; x=1699022392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q1/21Qej9F0ur5kxVcfbwd5gynXPn44FfuU8/fDsIJg=;
 b=GCtir2hobDjveU1ba5SMDRUzP0mCz7hh1BKmq8a57QbT1ImjFjF3QeekhcI+n6sBpx
 AVAmMdFkkYaJh6u/T52mwbLZpCeFmt6BGbo4NvMiZouq43zo0/JEYXvrGD4CMnhESJ+Z
 6LHo+3ajRtzqfqKdG/jJ2xK2KqTX3PuNK3URYyvd251C403vP11Kysf/1UImgoaZ/tG/
 uheK77ViJEdzYPy7eVw+qcm+Kn6Z88Wrqb5B0la/bPicSIy/WLkwWoYCee5IMrqkzT9C
 ovQCkCflnEMYmV7OD2RbR+xW+DYRFFquaTW7trKFnHNJvK1LwQvVTC15nDe6yjBiH5Yn
 Dsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417592; x=1699022392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q1/21Qej9F0ur5kxVcfbwd5gynXPn44FfuU8/fDsIJg=;
 b=PxdbzFOo0G2qJubJrO9i9M1ML0HhdDlxKDqqFf3i5Ded/JnQS+8+R/mNnCNS+Ic6Im
 len1nRJjaTMQ5fdC7Pfe9LuF5yuQdZbT+zTnSqNYCIOMedeEOeKHJyLKIoO67o7mLyRZ
 wB+opew43d8boihzK2cip2qWa5AyRD+wYTuaSH+GX31kFATAIkfnp+chW6tXG4h1CyLw
 WA+AWWz4DcaGf3s9C/YAjH35mg/wdwXS0z6KQORshUs1r8dIAGb3lonkC3myqn93kM5C
 BlenFh8r0SJG4SF76S2FkckknW6sfd6kB133yl8KY+X/Doy+qsDNLY5YAJwViVIHLM6L
 XFpQ==
X-Gm-Message-State: AOJu0Yxr3WxG/pD+szi/mC8CJQTIPCewQRScEdh3nHsz6Gm+nD+EevYM
 cJEx6ixSYiJLing1FOdNF4e3gya88BSQgq4mL6U=
X-Google-Smtp-Source: AGHT+IEHKmpZdgtXO9/lDDsRrrLDKaCTcFY0Vfv7wl/IfP91uE/CJ3/cK12BPvr8kdR6HvvY26DVvQ==
X-Received: by 2002:a17:907:3603:b0:9be:40ba:5f1 with SMTP id
 bk3-20020a170907360300b009be40ba05f1mr2637804ejc.60.1698417592757; 
 Fri, 27 Oct 2023 07:39:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/41] hw/arm/xlnx-versal: Remove 'hw/arm/boot.h' from header
Date: Fri, 27 Oct 2023 15:39:19 +0100
Message-Id: <20231027143942.3413881-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
Message-id: 20231025065316.56817-10-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h | 1 -
 hw/arm/xlnx-versal-virt.c    | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 7b419f88c2c..b710d71fb08 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -13,7 +13,6 @@
 #define XLNX_VERSAL_H
 
 #include "hw/sysbus.h"
-#include "hw/arm/boot.h"
 #include "hw/cpu/cluster.h"
 #include "hw/or-irq.h"
 #include "hw/sd/sdhci.h"
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 88c561ff632..537118224fb 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -19,6 +19,7 @@
 #include "cpu.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/xlnx-versal.h"
+#include "hw/arm/boot.h"
 #include "qom/object.h"
 
 #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
-- 
2.34.1


