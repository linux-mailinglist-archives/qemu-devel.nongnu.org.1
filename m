Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6847E81AD67
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9eo-0007fv-Bm; Wed, 20 Dec 2023 22:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ef-0007ST-Fe
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:25 -0500
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ee-0006mV-24
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:25 -0500
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-67f296ecb2dso11247866d6.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129002; x=1703733802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdv35G3T+A4gKg/Gxg6M1zcFHs/vftubJ4fYNQHlRAI=;
 b=EumBMpTNW/e8mqIn4MNSaU1druprPXkuRwz4vaKUfXu7jqKdm+wp3mb6L2+pWpn5zP
 /amtTw+8WTlYdZD/9CUit7Q14abkSH+mtZMEbTIO2jh1AfTbKpgdYM3+KKN/F9phtoz3
 LOZZd1BfcKuqmRSpb08bWCclEPxAqiRehI1duwan78H+4+y8WwbHELPQlyg/L4GQaOxi
 dp6oo1tnm9ti0RsNMd+HP3Wgd+ZttLUuPWFGlH4MF0gLH1VtZ4iIFzknYzIvyGau8PUm
 2WZHs0hrdEkJOxjQzlRJQgEH2F0V8ilnUgEMrtaMn+8+gi1iMCdfHYn0/X1BsgVvgpwv
 hCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129002; x=1703733802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdv35G3T+A4gKg/Gxg6M1zcFHs/vftubJ4fYNQHlRAI=;
 b=nN4Cqnx1K0OnSohi4aq0hC1PAv5aWILDbiChiU9KlWWSA81eX2zcOI2t0xm+gNogEH
 /S57H3yqDhJE3FQ6iahmd3cba4nnKxpj8DhzAOftZXidDJDFEMMCVrjI8qRNzWlpL6hQ
 NzZbt2EdTgEXAmRumdeWZDR0gfuTpuQoO/kc0hromVAiu6eLj3dcmtkhcfr/j9S01c61
 r3F/EIqu4sg5mZQcsJLqGiZtLqDx6XYgIaLQ/mGhP84zReeVVeSfE3m6Q8Vwf6hCGJsz
 xLKhcxHTDtrwnkivXeQdfC78fozXRpQOCrI4iDCSfJ6MBTcAedF22IFJpdfapw13j26o
 sKEw==
X-Gm-Message-State: AOJu0YxBKU6s3XIGdXaCzBQBodIlAlz5RzImvfrGf58UDE3hynUiq+Ku
 Tn30WzzYkYmUhlbol0El76KYNLdnFwWADrJVrtOOLb4SdBwT0Rks
X-Google-Smtp-Source: AGHT+IF8eW6TjkGXg33l5uytYW2XyZcpZJ2q2bOTTTNaoM/rBOLiDvFmKcb0FS/nPvkUY2L+qbtlVQ==
X-Received: by 2002:a05:6214:caf:b0:67f:40eb:bfa7 with SMTP id
 s15-20020a0562140caf00b0067f40ebbfa7mr62775qvs.48.1703129002650; 
 Wed, 20 Dec 2023 19:23:22 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:23:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 48/71] hw/riscv: Constify VMState
Date: Thu, 21 Dec 2023 14:16:29 +1100
Message-Id: <20231221031652.119827-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2b.google.com
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 7331248f59..d3bfaf502e 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -374,7 +374,7 @@ static const VMStateDescription vmstate_virt_acpi_build = {
     .name = "virt_acpi_build",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(patched, AcpiBuildState),
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1


