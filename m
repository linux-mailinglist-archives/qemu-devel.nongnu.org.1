Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DDA7D61E2
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 08:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXm4-0008OI-R5; Wed, 25 Oct 2023 02:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXm1-0008MT-8P
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:53:49 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXly-0006zK-PF
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:53:49 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32d9552d765so3821025f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 23:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698216825; x=1698821625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kk1MKBsSyK/FlsG1AzvO5dNDp1vcoAxg0jnivAM+YA=;
 b=pguN2W+LCWbcAaMK0BGVtFnSl9qDZzFp6Bxng63K0V/qJkQvGsSE3M0g5mYyrdJtTP
 pxQ4iCkWBXCdepWhZfNGdn+QCbZDMg0D4phvC/U1yoGaEoHkoJdKbqKi0Y/1eveUdCZh
 UgbifG+3kmuAZ6kHMMN86PTMn7YxvcURjyLFpbJUwO+KUJ0WGFUdl4Lct+AHkh4WIzh+
 OS81MXMUAM1/YRtD/OEzyvJ2PdlPznsH4vjbp/1XBKt+uoxQNwzG5yy9pwpYFOnLs99A
 UBQLdk/Gr+sjGeprGJXPJJJrEwQy96OxpSKrCzL5vl3jXkd9OFzLUIE8EHN59cxNYYqL
 jT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698216825; x=1698821625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4kk1MKBsSyK/FlsG1AzvO5dNDp1vcoAxg0jnivAM+YA=;
 b=gzPVJBAmv2e5f3Qt4Hh7kLiFZ3WmmN+pg5kVX1IBhdBrFSkj/nhhY+rPuIgT3Ps8j/
 4oSo2XIaZNHPLd504K7EHTXAeb2NYzcKF8C+n6U5xJxL8/xnOsqzomU6ZQK3oppjhUGK
 LECUl3sKs+bNPVkHZtzPKyvAbQ/0Ry2zvpDLyQ5P9Pa+jloRo+PfiRJ8Pe6ubwh6fNkL
 kN1O/snWQcGWeVTEiDgfAR8pZFts3Awfb3CsZSr+gv7mfHZpOKs0JV4OxYnTg4G1PJUs
 EbPETLV86KLVqs2zimDYPv1/yRsAi/KlRY1Z81mRMZY+JlIv8kqhL7LBNclGQU2lPwBs
 4/3g==
X-Gm-Message-State: AOJu0YxkLd0WrElfQO0n7u5KR8TjidlJKQPHiy/08CjaRnSGh9o9Uwbh
 6HBcMk560FEYsW4KxZmQMFPaZ5jYL6mTyLeIEqo=
X-Google-Smtp-Source: AGHT+IHTXykVjfJDPxA2/FrPmFrHp/SMCWppec3M4ojkS35WIYtQ+SITIFYrsx1boXGfH+FoDLpXoQ==
X-Received: by 2002:adf:fd0c:0:b0:32d:9a7c:56ed with SMTP id
 e12-20020adffd0c000000b0032d9a7c56edmr9938032wrr.10.1698216825026; 
 Tue, 24 Oct 2023 23:53:45 -0700 (PDT)
Received: from m1x-phil.lan (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 c14-20020adfe74e000000b0032d72f48555sm11390267wrn.36.2023.10.24.23.53.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 23:53:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Subject: [PATCH 04/10] hw/arm/fsl-imx25: Remove 'hw/arm/boot.h' from header
Date: Wed, 25 Oct 2023 08:53:10 +0200
Message-ID: <20231025065316.56817-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025065316.56817-1-philmd@linaro.org>
References: <20231025065316.56817-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
 include/hw/arm/fsl-imx25.h | 1 -
 hw/arm/imx25_pdk.c         | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 1b1086e945..df2f83980f 100644
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
index b4f7f4e8a7..7dfddd49e2 100644
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
2.41.0


