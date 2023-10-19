Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF7F7CFB3F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTBw-0001qb-9S; Thu, 19 Oct 2023 09:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBf-0001pL-OF
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:45 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBd-0001C7-0S
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:43 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so6754453f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722539; x=1698327339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=noOMC59/VFc6YCvUNgWuu27WqlcssERYUdLCM7PlKVI=;
 b=OdMaF6pkzMwJpiHx/c6woTs6lx/Rm+pt/Q5PaHpuHTT/od+sy2zaujcbA+vG3xfRPg
 YAtYPX4txNTYSAxFRHvPu6Ywye/DhW8mYjOAiqs8MPgDYV+4QbkLKgQmQvKqHBHoBde5
 KM9+3iLjqQATquavxaf2SHu866HKGNLqUBnWSzA/BZmFkislB+hgTJeOuBZbsKJBZ17H
 5Qhqq0yZ15ZgS5HQbV5NxW8MKXEE7uGfnw0dmydmK96wvCRzz9tTkfdg01Can53rULon
 rdEq4n2j5JenUtTTAa6gHyT+pSHY6m6Yo9zsXT3Kp4Q/5DCWk97RH1Zp/HptMvjiy8ex
 eX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722539; x=1698327339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=noOMC59/VFc6YCvUNgWuu27WqlcssERYUdLCM7PlKVI=;
 b=XYrmIoP0OiNhDRUuIQr6AyIXsXiX/trBhyfGeO8lfXn4XdpbUavmNV9RXn1HFL/6GT
 xS9+kkNNtnuZFqxEdXJ2u/LacPbwChxDdw13vi+NcOo3S43DZR+FPM7N4y2LW0Duvg7S
 ej0YebpqFKLa9HzTAm59gOrMuXU5wWfnmXnrNNe+lMO1h4o4kzPpjhGu1VoQCoEC45wU
 zT7CuSp3wlfx3r3BUkHkT5W9JyiAJ/mlLYWxN+8bG0D5WImXysWXmXmB5gLJUzd49lem
 i//YMhcKXnGX7KcuH1NHkfLLeM2R7cyXpLMPmECKHMv5vrZ2hbr8b9Tww4r+DZ20Dv3M
 zMmQ==
X-Gm-Message-State: AOJu0Yz6rQV/nyIoWJ9xkBNzoPBazht/ZgcVLtbK1l3koYEVw3b7EahQ
 aS3BJIHj+zcAWhdHvRRGxaWGwJN5gA63J2qP8jY=
X-Google-Smtp-Source: AGHT+IGi0/VeO8/Qb2gSWP+EmMyUYA7eRfBzL/bPlEL0VGUzjy46bMN5WinJpa0ZW9CC4K5g7Z7Uew==
X-Received: by 2002:adf:fdce:0:b0:32d:b06c:d30b with SMTP id
 i14-20020adffdce000000b0032db06cd30bmr1426737wrs.55.1697722538997; 
 Thu, 19 Oct 2023 06:35:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/24] hw/arm: Move raspberrypi-fw-defs.h to the
 include/hw/arm/ folder
Date: Thu, 19 Oct 2023 14:35:14 +0100
Message-Id: <20231019133537.2114929-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Thomas Huth <thuth@redhat.com>

The file is obviously related to the raspberrypi machine, so
it should reside in hw/arm/ instead of hw/misc/. And while we're
at it, also adjust the wildcard in MAINTAINERS so that it covers
this file, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231012073458.860187-1-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                                    | 2 +-
 include/hw/{misc => arm}/raspberrypi-fw-defs.h | 0
 hw/misc/bcm2835_property.c                     | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/hw/{misc => arm}/raspberrypi-fw-defs.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9bd4fe378d4..9282b4b0f55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -885,7 +885,7 @@ S: Odd Fixes
 F: hw/arm/raspi.c
 F: hw/arm/raspi_platform.h
 F: hw/*/bcm283*
-F: include/hw/arm/raspi*
+F: include/hw/arm/rasp*
 F: include/hw/*/bcm283*
 F: docs/system/arm/raspi.rst
 
diff --git a/include/hw/misc/raspberrypi-fw-defs.h b/include/hw/arm/raspberrypi-fw-defs.h
similarity index 100%
rename from include/hw/misc/raspberrypi-fw-defs.h
rename to include/hw/arm/raspberrypi-fw-defs.h
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 4ed9faa54a1..ff55a4e2cd2 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -12,7 +12,7 @@
 #include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
-#include "hw/misc/raspberrypi-fw-defs.h"
+#include "hw/arm/raspberrypi-fw-defs.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-- 
2.34.1


