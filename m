Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F467161F4
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:31:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zO8-0008DN-4V; Tue, 30 May 2023 09:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMy-0005ho-CA
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:38 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMr-0001Oc-U8
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f70fc4682aso4423685e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453189; x=1688045189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OEM4QdRDsKTVTW023PTpS/Eh2IMIwawTW26exYo7wxw=;
 b=Vwe6dureK6+CXlsI3gcTveBAdIgKTqBAOtcWm3Fl6qTh35AqmqgaIQgVSezGW0hR1P
 UrnkmSe3slYJVfiILks3jiMOsOUe46Jodlc+Xh1pg/4z56Pdoa2BCAMck0ZkW693EWeV
 bmnyn3qfW+8yKHmVHYziQjHnbRubs6YNdjzIYh8J0X7PE/Z32mBozI4u5QAIWYh73WHF
 3iBkwZxcJ1H03DjUAifXyw1eTmT2fHate8d6E91PC7fyHYENPlVoSpIixQmuWDdPc9P0
 dkOpXS4zzTpryJjWc6S/LcwxxQr3asU6LhNPZd27DOdBi53BGviiN+45OniYzBnQ+KsD
 EGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453189; x=1688045189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OEM4QdRDsKTVTW023PTpS/Eh2IMIwawTW26exYo7wxw=;
 b=Yas5+RV2dW4PODERmL5gN/xUG+/rDD8ibZn42EQthr8buC2YQWMVuMrr+sjHkJzY7K
 6Stqo2BeQKvqeejrcV3M4KBc9G4xlMdotsP7Q6P/Lrhl23VkyIh7UescIrM/z7NXW+M9
 ctXld+ACUa/WOo/nlQQQROx0uQBRuPkXsIJ9O/+V6ky4YYhu+dpsldd5F3UsNzmNgC4r
 mm8VGXMKvmTj0N+mr6fKai/1daaG0DUo7MPjJlskH9xUgH8dUBPHPz/ucMubWCkvPUSI
 gkH9GtUz1EX4DsmeDwNPA90NVFvnCh7kkQOVeCZF48kE6uTsH5eT4QXrhixQXb1306Em
 JV5g==
X-Gm-Message-State: AC+VfDxhc/6vXEW1IIfyQ3WZqQPA9uSaWTZR6dGpwRynR7FbFEYAJZ0v
 2qNM0fJVexktg+Vle3bnXkiEpNEh5DzsW+2UtuI=
X-Google-Smtp-Source: ACHHUZ70mi+3ZNSyVCX556KaPaYMFfu6b7iZ4Sut3Sdz7tJ8NFVk7lOJYH0thNp0Dt/NIpPk3Vu8aA==
X-Received: by 2002:a05:600c:283:b0:3f4:fffc:add with SMTP id
 3-20020a05600c028300b003f4fffc0addmr1567011wmk.27.1685453189175; 
 Tue, 30 May 2023 06:26:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/21] target/arm: Explain why we need to select ARM_V7M
Date: Tue, 30 May 2023 14:26:15 +0100
Message-Id: <20230530132620.1583658-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

We currently need to select ARM_V7M unconditionally when TCG is
present in the build because some translate.c helpers and the whole of
m_helpers.c are not yet under CONFIG_ARM_V7M.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230523180525.29994-2-farosas@suse.de
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/Kconfig b/target/arm/Kconfig
index 5947366f6e4..bf57d739cd1 100644
--- a/target/arm/Kconfig
+++ b/target/arm/Kconfig
@@ -1,6 +1,9 @@
 config ARM
     bool
     select ARM_COMPATIBLE_SEMIHOSTING if TCG
+
+    # We need to select this until we move m_helper.c and the
+    # translate.c v7m helpers under ARM_V7M.
     select ARM_V7M if TCG
 
 config AARCH64
-- 
2.34.1


