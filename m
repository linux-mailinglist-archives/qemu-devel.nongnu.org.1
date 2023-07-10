Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 699BE74E134
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzL3-0003Sa-MT; Mon, 10 Jul 2023 18:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzL1-0003SC-Sp
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzKy-0001iK-Q0
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fba8e2aa52so56054735e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689027991; x=1691619991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQn1GjoC4A2rsKEvs+LWc6jELr6JbHXlZFPyo2gF2Rw=;
 b=SH3nekmRsrrP45NJiKYFzciJ0htGs7u1GTzBkcGtTNdr9BDOq1oEW6UlpkM4K7a0PD
 G2BLqpHb2GGVDgR3/T2l3xIhxrmn1tiltyrcgc+zLISf1QsokxK7tPttsf8+jJR51wXR
 QfMJ5vB4aAJLdENM9Y1LPh1HAFD9ATfPbZfHm6u0vod3BXrjIyEbNiDetxyOEDRC+HRX
 Owlscsl3uLnEwHaKok75VS1psTZypZhrFkkEzOfpB5nENvUVqxlJLVTGQ4/mwj08kwGI
 a1LMACpziopJ5IrWueW9h7TgsicJQbimrJN/eOXsI1VNNtcCxqMkaNH8+uqYIbJGqwgo
 S3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689027991; x=1691619991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQn1GjoC4A2rsKEvs+LWc6jELr6JbHXlZFPyo2gF2Rw=;
 b=P1DOz7XzfTIZlHmWI9TtWLj9KEIlQygF1lbIY53kzb219RIU/QGXSMbo+AakSCBtZM
 B2YkQnLvghtCgDs35m53Ly5K86liD5FVWjzmJUp3RXW+fbH3nqh1oOsg95TFuBYDEZQX
 QCX35VC2rW1XLlaZoL4pIxhHccr/Tq5vJhF2UTpDweTyX7YcvRcMZQfbYyqShdJpZD99
 57vr9xhKzRLJF40dzIekgQ5Oa5sYpu3xjMdet5GDRolc+rGYVokwP5QnHkvLpw6Rny4S
 pZ+fsk8MfvmQCLM3KDccigLlGIFhinbVHprhOgBKKTNJJQP/UAcRYbyXAmqSmw9fLTvq
 hsyw==
X-Gm-Message-State: ABy/qLbdn7plTdDfh5ASUtasUinrzdRukDoFeA1BcdR5IhpLNxZfnXh+
 BzWP6TsUzRGP3ng3TpjQWAPVN6oXXgSZJuU76Gapmw==
X-Google-Smtp-Source: APBJJlGg7LoLNbrIlpZDGwic2mPGU5NY7MFSj2NIENqU3SPB0Kc8z4O6mOJ2ap+gLBEFvSgfYzz9IA==
X-Received: by 2002:a5d:4d8e:0:b0:314:3e77:f210 with SMTP id
 b14-20020a5d4d8e000000b003143e77f210mr13084116wru.59.1689027991419; 
 Mon, 10 Jul 2023 15:26:31 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 c7-20020a5d4147000000b003141a3c4353sm542731wrq.30.2023.07.10.15.26.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:26:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 03/44] hw/mips/loongson3_virt: Relax CPU restrictions for TCG
Date: Tue, 11 Jul 2023 00:25:30 +0200
Message-Id: <20230710222611.50978-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

After implemented CPUCFG and CSR, we are now able to boot Linux
kernel with Loongson-3A4000 CPU, so there is no point to restrict
CPU type to 3A1000 only, instead we just check for presence of
INSN_LOONGSON3A.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20230521214832.20145-3-jiaxun.yang@flygoat.com>
[JY: Check for cpu_type_supports_isa(INSN_LOONGSON3A)]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 3dd91da7a6..4018b8c1d3 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -481,8 +481,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
         if (!machine->cpu_type) {
             machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A1000");
         }
-        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
-            error_report("Loongson-3/TCG needs cpu type Loongson-3A1000");
+        if (!cpu_type_supports_isa(machine->cpu_type, INSN_LOONGSON3A)) {
+            error_report("Loongson-3/TCG needs a Loongson-3 series cpu");
             exit(1);
         }
     } else {
-- 
2.38.1


