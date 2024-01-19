Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3131A833078
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 22:52:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQwm0-0003w1-Gn; Fri, 19 Jan 2024 16:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQwls-0003ui-U0
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:51:29 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQwlo-0005QA-Dc
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:51:27 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e775695c6so11052255e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 13:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705701077; x=1706305877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xysxads+f6wQHkPyNi+ecSReQgoBfvy3gKHTba22J0I=;
 b=w6svMHpEazws9re7lRha6j+xyDlUiowGOjgL4mc/VhC+RPtrWVoOsk5nGDNolUSmd9
 QSAFdFWc7ReoXoxfS8i2+f2E9fG2h6j5zPkjJAs8/Oc1uVnwa34g8E8XsZgPd0uiq4ih
 xi0ujxixb+3R5F/EojWFz7rtoGqCV5Ej90Mr+fBMRB7aFjSuwXZqd4BKfRIFFzAnNrbE
 IgVqSAWRJC1I1JD92d1KPNc22Nqn3ysF0/l65Yf6fPv0fdz1VutcVTeaFmffyPsrzNI4
 IiFl221crHDrrOXfHhzEuv1epdxNEqGH3v6YdtOsoZT7PGSsvC4FH9MIAICptjGtS3T9
 1Npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705701077; x=1706305877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xysxads+f6wQHkPyNi+ecSReQgoBfvy3gKHTba22J0I=;
 b=dn9ye5/8VoeJN7SsEMQMAFNl9D7aWm1/edzsXCn3NcYe6K9FUPc5He0U9ZWqoMOS3a
 jmKoRTb8rNnzOqtdeAuZPhOgL+cpw7Ol0hC6ozwqzWx4qZUyUizz0aG8dfkDoMBDnA2/
 kZJehgwdtV4ebHCnUP/vhA6vMQVso/g2DWa6zoJ6lSvms9NgbmPgxJY3dyPaav6LIHRd
 BOHGj8vt+QVEURrveVRi8Qu5sySwp4vySeZ1+5HPaoi4pAQTelN65/p450/40x64vXYe
 1GFGQALrb6WKoKBkpj1XLlj0pdGIVGwbPhVoFBsu3oCGbiiTTK5sD2SDloq38+jD2Qzn
 i4YQ==
X-Gm-Message-State: AOJu0YyNtNHzZptWJhBX6QAXSOxH5cUUsOb9oJblz1mqUzfHjdK5aMmT
 BJXzvVL6zNKNsQQQbKnT7/sSR8V7kTGsUWXkNYwos5IJJHjrTBzMmWkBxEHQA9YUBbAyRzlDiNJ
 U
X-Google-Smtp-Source: AGHT+IHhKsibEG8OQ7j0TmGCWxY8bYc9gtyYpy1pa/rC1M2XG68QNKXvmJR1Smww34Jk+tpgq6qU+g==
X-Received: by 2002:a05:600c:1ca2:b0:40e:6397:f42c with SMTP id
 k34-20020a05600c1ca200b0040e6397f42cmr257260wms.7.1705701077612; 
 Fri, 19 Jan 2024 13:51:17 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 c11-20020a05600c0a4b00b0040d53588d94sm34241069wmq.46.2024.01.19.13.51.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 13:51:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] hw/arm/nseries: Unconditionally map the TUSB6010 USB
 Host controller
Date: Fri, 19 Jan 2024 22:51:06 +0100
Message-ID: <20240119215106.45776-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119215106.45776-1-philmd@linaro.org>
References: <20240119215106.45776-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The TUSB6010 USB controller is solderer on the N800 and N810
tablets, thus is always present.

This is a migration compatibility break for the n800/n810
machines started with the '-usb none' option.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/nseries.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 35aff46b4b..35deb74f65 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1353,9 +1353,7 @@ static void n8x0_init(MachineState *machine,
     n8x0_spi_setup(s);
     n8x0_dss_setup(s);
     n8x0_cbus_setup(s);
-    if (machine_usb(machine)) {
-        n8x0_usb_setup(s);
-    }
+    n8x0_usb_setup(s);
 
     if (machine->kernel_filename) {
         /* Or at the linux loader.  */
-- 
2.41.0


