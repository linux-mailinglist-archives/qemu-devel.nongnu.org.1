Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9127F169A
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:02:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55mL-00018S-7E; Mon, 20 Nov 2023 10:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r55mH-00017u-SV
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:01:33 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r55mA-00050e-U0
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:01:33 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32f737deedfso2912936f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492483; x=1701097283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AonQASN02H39ayyy5tLjqfhpjijh85lAG7GVs3CstAI=;
 b=CHr/C63neF3vNlkR0hj0E3fV+qQoJtfQmL7/Tu9TYNqD+IkVqs9DEaRYtzkiEIk9n/
 TYj+8n1kzjLyCRXWzk0+GnQd+M8QrjmZgtnXRPTR546tsAacnjDmpiqVnhjK/+ulY1js
 GAw9yzqehp7VcohVqTmrsaWmwwOADpCsttCapTqqUsaUYfZ00ts83V6TsFNvKFlQ2ftQ
 l62dAh+bCybMDebjcgC8Sbb6Z1KNLPI7HOnzlxHk8zuFSDSz6hE7xAkK9G8S5AjmDFgo
 wjbruHsMP4lYdfsJkfuENcLWVeuLFwgu62Il4U3WVkcQkx1bEDth3jJbm97l27NaYjaY
 8jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492483; x=1701097283;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AonQASN02H39ayyy5tLjqfhpjijh85lAG7GVs3CstAI=;
 b=N/JmfpVYZ8GnHg+Ux6u9I0S+E7/PExvdy7TWV9IfKAatf6c0URwlP6CYJ6bAUnUmH5
 M0ixxwIRuJnf9aqtgno9lC27csQvi+FN5WaeW1S6nyLqkBBxZYSMBd2TmxYqrcsuTNCR
 H232yvpq7znXsxQd/bsoTytz7qkQDtcj3iYYDK1uSax0Vk6uadWBT6XjqmgwNQ2OS98r
 xqmQHz5k5QtSCI6RwRad+eNTH0JDOBBck++OG8JglJHqpqDSWoQmObB9z8coruujwRrn
 wAeVYAZ5wqqXLd4fbGTzFLc8VhjLOOSoeyPp0jK2/wRDG25jEbhLDOEVSBnamNteju5D
 LFjg==
X-Gm-Message-State: AOJu0YzI9ouAQ+gRhR2+Ah6V/6wiC+v+2e9E4G8MZ8U/3doysN5m7Let
 WyNp6i52i14hdXk3v6xxz1jNug==
X-Google-Smtp-Source: AGHT+IGETjmCB9kWzLeSjE+lPAbAsVtpQ7pYI/pzwIUxitekA6/IDJ4RwiKZtVK7mU4OlNs+owJZcQ==
X-Received: by 2002:a5d:5cd1:0:b0:32d:9df1:6f68 with SMTP id
 cg17-20020a5d5cd1000000b0032d9df16f68mr4646025wrb.22.1700492482801; 
 Mon, 20 Nov 2023 07:01:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a5d6404000000b0032fc5f5abafsm11389045wru.96.2023.11.20.07.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:01:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH for-8.2] target/arm: Set IL bit for pauth, SVE access,
 BTI trap syndromes
Date: Mon, 20 Nov 2023 15:01:21 +0000
Message-Id: <20231120150121.3458408-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

The syndrome register value always has an IL field at bit 25, which
is 0 for a trap on a 16 bit instruction, and 1 for a trap on a 32
bit instruction (or for exceptions which aren't traps on a known
instruction, like PC alignment faults). This means that our
syn_*() functions should always either take an is_16bit argument to
determine whether to set the IL bit, or else unconditionally set it.

We missed setting the IL bit for the syndrome for three kinds of trap:
 * an SVE access exception
 * a pointer authentication check failure
 * a BTI (branch target identification) check failure

All of these traps are AArch64 only, and so the instruction causing
the trap is always 64 bit. This means we can unconditionally set
the IL bit in the syn_*() function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
---
 target/arm/syndrome.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 5d34755508d..95454b5b3bb 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -216,7 +216,7 @@ static inline uint32_t syn_simd_access_trap(int cv, int cond, bool is_16bit)
 
 static inline uint32_t syn_sve_access_trap(void)
 {
-    return EC_SVEACCESSTRAP << ARM_EL_EC_SHIFT;
+    return (EC_SVEACCESSTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL;
 }
 
 /*
@@ -242,12 +242,12 @@ static inline uint32_t syn_pacfail(bool data, int keynumber)
 
 static inline uint32_t syn_pactrap(void)
 {
-    return EC_PACTRAP << ARM_EL_EC_SHIFT;
+    return (EC_PACTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL;
 }
 
 static inline uint32_t syn_btitrap(int btype)
 {
-    return (EC_BTITRAP << ARM_EL_EC_SHIFT) | btype;
+    return (EC_BTITRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL | btype;
 }
 
 static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
-- 
2.34.1


