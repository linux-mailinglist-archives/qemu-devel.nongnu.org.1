Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9166D78EE26
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:10:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhLF-0007q6-C4; Thu, 31 Aug 2023 09:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhGn-0004bM-I8
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:59:37 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhGi-0005wB-0S
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:59:32 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-529fb04a234so983955a12.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486762; x=1694091562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24nF/N+YzUtE3HhDlO2XU4XzAEvrvbZNN4parmEdVAE=;
 b=AdqSwMeSmeNpTUxF+OoIEvGdlgYKiIQlQFeWvycyrkJt6VfM8Ai8r42IKy/SdEHFId
 SE+6OSAoplnWZJxnthYiHgaCmsolT06mSriZPNBfnaRFaag+yLZKVgFaoeOkUOdj+arE
 OXXaPDLzrHu5p40qzzbJ0W6Hbrkz2u1MVwKGx03KbzTq+xXKCCiuZwGwPY6L/vLUAm58
 SbCx9EaJoVXznyVSIWzUVTg/Q9o+3bTJnnwILOsyUL4dGoI8mMgOBPlUBbl7R2FZUWhn
 qrV6C7E3bv7L3ENXpO3m+zeMQzd0W5pasiyX1FH2LlJTG7Z0nDZOqvPeRyUqhMoK2+gC
 Qe4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486762; x=1694091562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24nF/N+YzUtE3HhDlO2XU4XzAEvrvbZNN4parmEdVAE=;
 b=JHXREMHtM//9fVVe+jRM33dj6SqfMtgyod79ECFZz37z0glaxvyrv9H+hypGZGPTTG
 kr9uZseW2yjtEVsXQsWbgXMigXqX+5is2D0CePyYO5Hut5oEw4AUqr+ZDRVaBQdwn1uS
 oMj30quvLMo7hxfP3srGjJ7bSKyGa9pmCGHxgNy5Ve+Q6b9go0gzyWB/vIHka1xlEjvB
 OsBMBIJapqv6/F+vPf0WP6+2OC2g+qo9qpie7RnMSS+IR/KZh0FSD5woeSueq8YgTu75
 oLcuYJEs23s13Pm/fHhbpAEcvaepUsgAYAkkLSlWj1rb3dC/5foWFAiCoGvroduO3dAw
 QScw==
X-Gm-Message-State: AOJu0YwdrhYXsQxPWU0CXivaiACdYt9x6DVBi4hiMwl0AVtkEhB9Fs+g
 8Ta3yv7Cu8Mo/qUCRPgngpU7O8Krx+2YnZAjtII=
X-Google-Smtp-Source: AGHT+IEJndlv4FOjjHD0urZaoFW5piSdOIxRYpDTk+s3vMcsrjx8/dtQecEcYbDkv/K0TyDW/U3YrQ==
X-Received: by 2002:a50:ec95:0:b0:523:b1b0:f69f with SMTP id
 e21-20020a50ec95000000b00523b1b0f69fmr4078743edr.32.1693486762097; 
 Thu, 31 Aug 2023 05:59:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a056402055300b005233609e39dsm777727edx.30.2023.08.31.05.59.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 05:59:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Titus Rwantare <titusr@google.com>
Subject: [PULL 25/41] hw/i2c/pmbus_device: Fix modifying QOM class internals
 from instance
Date: Thu, 31 Aug 2023 14:56:27 +0200
Message-ID: <20230831125646.67855-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

QOM object instance should not modify its class state (because
all other objects instanciated from this class get affected).

Instead of modifying the PMBusDeviceClass 'device_num_pages' field
the first time a instance is initialized (in pmbus_pages_alloc),
introduce a new pmbus_pages_num() helper which returns the page
number from the class without modifying the class state.

The code logic become slighly simplified.

Inspired-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230523064408.57941-4-philmd@linaro.org>
---
 hw/i2c/pmbus_device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index 44fe4eddbb..8bc9d5108a 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -190,15 +190,18 @@ static void pmbus_quick_cmd(SMBusDevice *smd, uint8_t read)
     }
 }
 
+static uint8_t pmbus_pages_num(PMBusDevice *pmdev)
+{
+    const PMBusDeviceClass *k = PMBUS_DEVICE_GET_CLASS(pmdev);
+
+    /* some PMBus devices don't use the PAGE command, so they get 1 page */
+    return k->device_num_pages ? : 1;
+}
+
 static void pmbus_pages_alloc(PMBusDevice *pmdev)
 {
-    /* some PMBus devices don't use the PAGE command, so they get 1 page */
-    PMBusDeviceClass *k = PMBUS_DEVICE_GET_CLASS(pmdev);
-    if (k->device_num_pages == 0) {
-        k->device_num_pages = 1;
-    }
-    pmdev->num_pages = k->device_num_pages;
-    pmdev->pages = g_new0(PMBusPage, k->device_num_pages);
+    pmdev->num_pages = pmbus_pages_num(pmdev);
+    pmdev->pages = g_new0(PMBusPage, pmdev->num_pages);
 }
 
 void pmbus_check_limits(PMBusDevice *pmdev)
-- 
2.41.0


