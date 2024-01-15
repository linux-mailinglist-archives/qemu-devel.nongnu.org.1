Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C0482DE09
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 17:57:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPQGJ-0006He-SZ; Mon, 15 Jan 2024 11:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPQGG-0006Gu-DO
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:56:32 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPQGE-0001XU-9A
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:56:31 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3373a30af67so8059608f8f.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 08:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705337788; x=1705942588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4+bIenrzPyATM30XW9R1b9vb5/8yjsfQP7BFBOigBY=;
 b=eqUfngTtTQrrPqXxCH4HLFzlPwoB8tbKrJDJCBbBlmvW/5G3Ps8Tbc3AWT2i5IR7JZ
 kYsKQoXCXzhTXfmRGiVdwxS7mlnMjCZgCjGfj5Z3w9wsIk3Ghq7E9DGCUkN1aS86JET2
 iZscy+PsiAM8tiaWWZIwbdl/XpVYqBEBojmT5wzpuUh8Q8v6uuq8CsOZQUcnnsGAgr9X
 ysCZwiBdSh4OWnMyqgItMyPck/Zpo46i37DWCRiJJg+EIRduNjm3HheoA3J/QC0RMq9W
 8CjTVaxphVAGhQeln24t7IT8BL5WkmpX1QZMnsdLAg5rmFPRLx5cSv78/NAPKDGRDWJx
 tGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705337788; x=1705942588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4+bIenrzPyATM30XW9R1b9vb5/8yjsfQP7BFBOigBY=;
 b=CsSo89CHar4k0Dr9uDuZmJZDN5sqDCowJ+ssXKX3905+HmYIF+odLxvzldxxOtrVNG
 /qX7ntpziK1XJU2GRtN9ukB3kmb+5lu3yti0R6B610cetVVf9iDidfWnnR/00sRQBi35
 JCR/b1H5mDQhbPvGq+P+FRls7iktVtnLKBGplN51W2Kc8wF0dJdNdqHOBnSI195B9ULh
 TXw8E5fXHepaJVT/+jhPFvIxQL165nzediZ8NGsGrDJ2m+HNDFXNCa/qM78/RTb58V33
 8oBjFBgziMCgw0D8/NijeoTveCpaRpg36Oo/iojat8mHmw48jOp2RZzT7xlrxzRcH6CO
 uEUQ==
X-Gm-Message-State: AOJu0YxOUjGfQErzbZd6J9jC3XDwbMSVkNbSrv04Wx2iYv1Vgg1J8ciF
 ufhgat4Nh1EP80apbhiZaCnX8hpmgi5JSqQxHIdEtQVXLfU=
X-Google-Smtp-Source: AGHT+IEg5GTAHzzRxcAFeYVFA3CDThIOSsQQw0BPs8Zkh8cQvmOXApmAQ31nNobicUsCdoxUlumGBQ==
X-Received: by 2002:a5d:548e:0:b0:336:c52b:e282 with SMTP id
 h14-20020a5d548e000000b00336c52be282mr2353872wrv.203.1705337788418; 
 Mon, 15 Jan 2024 08:56:28 -0800 (PST)
Received: from m1x-phil.lan ([176.187.209.30])
 by smtp.gmail.com with ESMTPSA id
 e19-20020a5d5953000000b0033609b71825sm12312192wri.35.2024.01.15.08.56.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jan 2024 08:56:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] hw/arm/nseries: Unconditionally map the TUSB6010 USB Host
 controller
Date: Mon, 15 Jan 2024 17:56:15 +0100
Message-ID: <20240115165615.78323-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240115165615.78323-1-philmd@linaro.org>
References: <20240115165615.78323-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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


