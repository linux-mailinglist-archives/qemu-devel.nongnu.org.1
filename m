Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D51382A1A1
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:56:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNefW-0003VV-HV; Wed, 10 Jan 2024 14:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNefS-0002se-8w
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:55:14 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNefQ-0002wK-Eb
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:55:13 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e4d515cdeso26633025e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704916511; x=1705521311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEBz6KLcksNDKwrjuJDS9F6r+wqfQ84qV7D0vYA4a10=;
 b=XrJiYCcwuxBjHgJKBtqCAqZzUiSxTC3hAjGrAP40kNnNEkoOQ63w8Y8bjJTnXToUxv
 JVZvJUJDj4wDFpjpr31S4eaemvdpAhZtTItVjJCTdU4EA7eujJPvPqTlr6vWKziVYOdM
 fXUptefHKkZ3mXO9xcJ7HtCOQsx50hxu31q657my5y1dXKToUx0vbj6lhRdH1W0y93n3
 hNxsXUCwoH+Gi2uaCP3Q6hWKIWv6o/6lji8YU3TeQtryGCJxNDVcOz/a0bM/QqcFlgtV
 oF8gDiSkk4/0qyrLzQUUMCcgo1RJosEZDjY5freoXEZh/6skRuSpH0LY2eNKCXnuMQ3x
 ffLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704916511; x=1705521311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEBz6KLcksNDKwrjuJDS9F6r+wqfQ84qV7D0vYA4a10=;
 b=O0LmRnbH7X5tQPBTIWr28fXzfli+W8G/pAZsV390CJxlG4thrRpFEerKihpysdQha9
 MbkR0ZHYpcnmfzGZ4Q2Yz/3nk/RoNs7gyOWfmyGydDRfwQpQi/rpIAQr8bwEIR7Jcu97
 ZKPklDSJH9VfHLrItGot4rnlec/qamt50GTiQaOQmJALQ11Tsf4QV4eUoa4DbCafMNcf
 1jUFLT8UOBvVCB8I6DYKWR2wbHNVW0mKDLovlfEHJzz11ET6yrJr5t3HWCrQ0qwgUhhx
 DFQqMRfcaFiLNHdB0SBF7TlPTvtb6NgwOnlDXenWDsppKlUfKscicJrHx0xW0cB3xQjO
 WxLw==
X-Gm-Message-State: AOJu0Yycs0U153k7OZv7y9d6xGQrpvc7eTcEg70NZSJ7lKXyaCdH8eTv
 RN5tYqHO8qqpDOHdFm/BSUxNcHG2x/eapHira/QBOg37PtU=
X-Google-Smtp-Source: AGHT+IGQd32Lk+oKb8zN1vlG98owUctcXADDH4Oa7B8063z1oucGBdFgJ+DlBJYIvHCVRrc9BwWp0g==
X-Received: by 2002:a05:600c:74a:b0:40e:4cae:a3d4 with SMTP id
 j10-20020a05600c074a00b0040e4caea3d4mr858800wmn.184.1704916510871; 
 Wed, 10 Jan 2024 11:55:10 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 c3-20020a05600c0a4300b0040e47dc2e8fsm3234850wmq.6.2024.01.10.11.55.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 11:55:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 14/14] hw/arm: Prefer cpu_isar_feature(aa64_mte) over
 property_find(tag-memory)
Date: Wed, 10 Jan 2024 20:53:28 +0100
Message-ID: <20240110195329.3995-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110195329.3995-1-philmd@linaro.org>
References: <20240110195329.3995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The "tag-memory" property is added to ARMCPU when the
A64_MTE bit is set in the feature ID register. Rather
than checking whether the QOM property is present, directly
check the feature bit.

Since when ARM_FEATURE_AARCH64 is disabled the isar_aa64_mte
register is invalid, also check for it (see the 'aarch64'
variable set in the previous commit).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a43e87874c..7fd7173b5b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2188,7 +2188,7 @@ static void machvirt_init(MachineState *machine)
                  * The property exists only if MemTag is supported.
                  * If it is, we must allocate the ram to back that up.
                  */
-                if (!object_property_find(cpuobj, "tag-memory")) {
+                if (!aarch64 || !cpu_isar_feature(aa64_mte, ARM_CPU(cs))) {
                     error_report("MTE requested, but not supported "
                                  "by the guest CPU");
                     exit(1);
-- 
2.41.0


