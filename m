Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED137161F2
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:31:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNW-0007Gy-Vg; Tue, 30 May 2023 09:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMy-0005hp-Ck
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:38 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMs-0001RG-SE
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f6e1394060so30676905e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453189; x=1688045189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vp7gygnAm6XXHeiGhtN9mXQuBKRZfSn5XO0wHXJv7Bs=;
 b=eTmo+//kr8xtR6aGox/6QJUWd2OqdH1gSsiiYmmyd5foxPrWRpmCQmKqvBmAJeBZ7P
 CAf5qFRYTrjBZIM8hH8hZHywV1ahw+VARFWHTwill8Uuk96v5KI4WiECoNODcymRrct8
 PpQHcQ9tvUTUEWlxUhDil2RdzVqxkVgQDgf7XudcfPXUWMmdyPvalHtW+DABxaM4r9B1
 4XiL9ORIR59pE9Fnk2yO3eFIB9r/MC+5thruGHv4iJG5alCUic4lMCKormMdnvQDFKzV
 AnFFpY8V4kVURG7iQfAuoXAy6v/Edq0nNzqW/cabpULlJFFBtw0rKdB1wFo7Ys1qeJ79
 9Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453189; x=1688045189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vp7gygnAm6XXHeiGhtN9mXQuBKRZfSn5XO0wHXJv7Bs=;
 b=cSr/NJKncK13r77PoXjTCwbSUcbu6skqcN+qQoAfUrYNE07v8dLjoTUPfw6iYtskFd
 zHWQWhPTi6G7uHj7oTcSvbe1V1pTnPOjX3GXZC1T3GHlPk42sMwyoSUp5C2VElifSCg9
 wSBeFXI2BmV2Cate9Lbh6TaPygqUesRmYJd2WwCJFR2r+7sBd/BXshHVU5hpdZqQIqnS
 aEC8sZOs01oCeIjot0Y3X8ucVb1umg58mnXGjH3QonLz0Lt9ZraivjdXAu/VJFzbxs6b
 R00OHxY9rR2zRz/TzN0I6HbC9haeFdz4fFGTgZFKhdzXF4oeAN5vfnfmcMayV/kikRZs
 eA8g==
X-Gm-Message-State: AC+VfDyFf1bxYBGJEhttfNXniAzU3AmftPwVov9AURzgA6hsAjFJYc7G
 fD2aV8McDKDXhayDCSmzcHhwFjKcsASdhGsWU0E=
X-Google-Smtp-Source: ACHHUZ4k433+liNPqBOwJWD9qw4S7UkUZVqbOfb49SqE1rtJPO//1+Z/i5ViPBsQ8sZuEx7QNxYujA==
X-Received: by 2002:a7b:c4c7:0:b0:3f4:f0c2:125 with SMTP id
 g7-20020a7bc4c7000000b003f4f0c20125mr1829311wmk.23.1685453189534; 
 Tue, 30 May 2023 06:26:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/21] arm/Kconfig: Keep Kconfig default entries in default.mak
 as documentation
Date: Tue, 30 May 2023 14:26:16 +0100
Message-Id: <20230530132620.1583658-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Fabiano Rosas <farosas@suse.de>

When we moved the arm default CONFIGs into Kconfig and removed them
from default.mak, we made it harder to identify which CONFIGs are
selected by default in case users want to disable them.

Bring back the default entries into default.mak, but keep them
commented out. This way users can keep their workflows of editing
default.mak to remove build options without needing to search through
Kconfig.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20230523180525.29994-3-farosas@suse.de
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configs/devices/aarch64-softmmu/default.mak |  6 ++++
 configs/devices/arm-softmmu/default.mak     | 40 +++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/configs/devices/aarch64-softmmu/default.mak b/configs/devices/aarch64-softmmu/default.mak
index 70e05a197dc..f82a04c27d1 100644
--- a/configs/devices/aarch64-softmmu/default.mak
+++ b/configs/devices/aarch64-softmmu/default.mak
@@ -2,3 +2,9 @@
 
 # We support all the 32 bit boards so need all their config
 include ../arm-softmmu/default.mak
+
+# These are selected by default when TCG is enabled, uncomment them to
+# keep out of the build.
+# CONFIG_XLNX_ZYNQMP_ARM=n
+# CONFIG_XLNX_VERSAL=n
+# CONFIG_SBSA_REF=n
diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
index 647fbce88d3..980c48a7d99 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -4,3 +4,43 @@
 # CONFIG_TEST_DEVICES=n
 
 CONFIG_ARM_VIRT=y
+
+# These are selected by default when TCG is enabled, uncomment them to
+# keep out of the build.
+# CONFIG_CUBIEBOARD=n
+# CONFIG_EXYNOS4=n
+# CONFIG_HIGHBANK=n
+# CONFIG_INTEGRATOR=n
+# CONFIG_FSL_IMX31=n
+# CONFIG_MUSICPAL=n
+# CONFIG_MUSCA=n
+# CONFIG_CHEETAH=n
+# CONFIG_SX1=n
+# CONFIG_NSERIES=n
+# CONFIG_STELLARIS=n
+# CONFIG_STM32VLDISCOVERY=n
+# CONFIG_REALVIEW=n
+# CONFIG_VERSATILE=n
+# CONFIG_VEXPRESS=n
+# CONFIG_ZYNQ=n
+# CONFIG_MAINSTONE=n
+# CONFIG_GUMSTIX=n
+# CONFIG_SPITZ=n
+# CONFIG_TOSA=n
+# CONFIG_Z2=n
+# CONFIG_NPCM7XX=n
+# CONFIG_COLLIE=n
+# CONFIG_ASPEED_SOC=n
+# CONFIG_NETDUINO2=n
+# CONFIG_NETDUINOPLUS2=n
+# CONFIG_OLIMEX_STM32_H405=n
+# CONFIG_MPS2=n
+# CONFIG_RASPI=n
+# CONFIG_DIGIC=n
+# CONFIG_SABRELITE=n
+# CONFIG_EMCRAFT_SF2=n
+# CONFIG_MICROBIT=n
+# CONFIG_FSL_IMX25=n
+# CONFIG_FSL_IMX7=n
+# CONFIG_FSL_IMX6UL=n
+# CONFIG_ALLWINNER_H3=n
-- 
2.34.1


