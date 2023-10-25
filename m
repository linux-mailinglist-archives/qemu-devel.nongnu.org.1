Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5EF7D61E9
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 08:55:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXmk-0000TC-8U; Wed, 25 Oct 2023 02:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXmd-0000Gq-OL
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:54:28 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXma-00075c-PE
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:54:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-408002b5b9fso43146605e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 23:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698216861; x=1698821661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eqPNYapoHabm/VWRpga1kGUl+2jHRCqpJOCNvX0dn3s=;
 b=CsYfI7JL3pcuKoYOwruhKDwDhHtsh1vwbX68s9oI85dexDNdO6rdxNC59WtC3uYwyq
 fx9rIqEY9GUunVOM5UhN796b3e/H/fAcfqvkxTzRNwcjrKs7hUmE1Rve215euX0bHqkz
 vGE3g8PQOIFoV1LzN/T0IYC5WZwUf7itHzZ/euT6yUoNBDrvyg0MLuMR24tVbD9KzPkJ
 Dw/gzaLMLl2w+azcYN38nCBUZd1GwGs5Uxc3dQbPLkmwFzJcPvAhZ/OB2pfdOI9d2ZlF
 PLabTsxmPJBnIeDkmtE/04bRRFmncreE5x8qxYlfIQ+auk8Z5Gg0mei9kvjj4/qXUgAm
 J9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698216861; x=1698821661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eqPNYapoHabm/VWRpga1kGUl+2jHRCqpJOCNvX0dn3s=;
 b=p0h4hOBFMU9xedKMSE8s9Is/O04qFESdCy+UAUmPfOWcdxNhgSTZRmmbgGOaX0mMGk
 Byod8IiRt5u+lYciBY8g0APFJTZ43xWNrVr1Vsp6h8KJuvmvq1B135BkeYvz1mVO5X8/
 yLr8TxzpYkqyI1/3Mxtr73KxDoJDkISxhmd3yPABdRNr87A3fj+O9e0PWtsYmnXKjRzr
 vyFilbxWU4eUhFaZ5m9LIKWXQCx3dS6eWB8uRgzPXZp3hj0phv08t4HJQvSWsMBb0FSF
 KUo+siNUxoiObg6HNvN81o5czMBGvMQ2vdaeqDWegtZHW1wjDsjq1xs76Ad2BlZd6+e1
 iIjw==
X-Gm-Message-State: AOJu0YxUTJetFhbixIk3tpe+76RtJ6y9ZSygDKuNsvaPZcojSLXRvjUi
 wi7QiV7qgQWU0r2OfrT5p5dp7sxR0CmqCNIrRBw=
X-Google-Smtp-Source: AGHT+IFwy2bdeSO+y67tGfR1KCseIPaGe+2tVm+hCriQVOFtnkHYNkXYUHkx2tTrFjONhZxI1EkdLw==
X-Received: by 2002:a05:600c:4e91:b0:408:4551:fade with SMTP id
 f17-20020a05600c4e9100b004084551fademr11646248wmq.38.1698216861494; 
 Tue, 24 Oct 2023 23:54:21 -0700 (PDT)
Received: from m1x-phil.lan (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c158900b0040776008abdsm13659452wmf.40.2023.10.24.23.54.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 23:54:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 10/10] hw/arm/xlnx-zynqmp: Remove 'hw/arm/boot.h' from header
Date: Wed, 25 Oct 2023 08:53:16 +0200
Message-ID: <20231025065316.56817-11-philmd@linaro.org>
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
 include/hw/arm/xlnx-zynqmp.h | 1 -
 hw/arm/xlnx-zcu102.c         | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 687c75e3b0..96358d51eb 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -18,7 +18,6 @@
 #ifndef XLNX_ZYNQMP_H
 #define XLNX_ZYNQMP_H
 
-#include "hw/arm/boot.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/char/cadence_uart.h"
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index c5a07cfe19..4667cb333c 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/xlnx-zynqmp.h"
+#include "hw/arm/boot.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
-- 
2.41.0


