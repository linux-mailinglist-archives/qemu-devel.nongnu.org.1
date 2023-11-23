Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B227F6655
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:36:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EYB-0007xJ-W4; Thu, 23 Nov 2023 13:35:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EXy-0007bN-E1
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:35:33 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EXw-0002m0-V7
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:35:30 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso9075445e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764527; x=1701369327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EggnDxiS3lb3CDYKGlg1a7WOxUSv7txLuyeSgPzo5Gg=;
 b=jc5YS1ysaXGid2dJ8paaQL3XXcEjWfoJVN08kZNzuL0ZXA2QUnEAJAaiBzuElubUPG
 aO5mvzqLWjqQyTx0GtBxmwhwEdmaTfHD70NRNVOw+1e8vF97SiCDo/cjOoZXddWYGSUT
 i2IFpEfM0du32Prlx0zBmxLrX5C5gYdGDE9za7DSoBqGcoKTEAoztCqliuL96jOSosfX
 96pWuEFqE1fiHx5Ji4o7c3iZQ0OrywMHdiI2YO1HWYKh0dXa/dEaG7NdHMVFyGc2IWMM
 e50tgWPZ0D2HU9mZgasMxBr02Fd7PXFijP+dY9qgsszIxURVZBaBX3rSyV1TDUzOq8uz
 SjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764527; x=1701369327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EggnDxiS3lb3CDYKGlg1a7WOxUSv7txLuyeSgPzo5Gg=;
 b=Ghmt+n/49tRMOYV+4+GYDFkYAwzmyIONDCx6zK38tZOSiKWo6L/Hfw31TitJv3HE9+
 Jts9ezBAlaKo/KjeRLFGvo5+0UmPHFOSIk3q/VIqP2CImjM+7WDq9XDAXNjmIBi7oxPV
 qlDLS/Sxd3kjuSP45yXtBEx8AoHvTWnUnrlaRFj2m8Kh4HAMpm+y2SY3pk3yWNiPrf4x
 LgMyMAbM1TfA3aMQfPQQQxcCcsDiqvHoix1igHEm6af/eNiSi0nCv37u+j5SRiq3x9Xj
 02CX8ikti4UgG3C1//CczfhLp29M0V6VgJabl70cHFXgRigJ0IH8zLC+s5M2n+xQfvf4
 awFA==
X-Gm-Message-State: AOJu0YyjHrN7LJMEe8f6xjHNDnrLXxYcb/XzZ1grcIBlNp20Xyml6L0B
 7CIoMu9L0pq80B4Pu/261N9kaskIICmTZYWn4aI=
X-Google-Smtp-Source: AGHT+IFvWOwOd7e1Y5lDPZTFF3Xq4nOUA9yN5q2GNMAzYiEapwPBFpCHPMn1UoTV4j1koXw+yTkL1A==
X-Received: by 2002:a7b:c8cc:0:b0:40b:346c:f3f5 with SMTP id
 f12-20020a7bc8cc000000b0040b346cf3f5mr345640wml.30.1700764526586; 
 Thu, 23 Nov 2023 10:35:26 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a05600c451100b0040b379e8526sm2034152wmo.25.2023.11.23.10.35.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:35:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 01/16] hw/intc/arm_gicv3: Include missing
 'qemu/error-report.h' header
Date: Thu, 23 Nov 2023 19:35:02 +0100
Message-ID: <20231123183518.64569-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
References: <20231123183518.64569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

kvm_arm_its_reset_hold() calls warn_report(), itself declared
in "qemu/error-report.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/arm_gicv3_its_kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index f7df602cff..3befc960db 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/runstate.h"
-- 
2.41.0


