Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 640DC7E340D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:15:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRe-0004hv-UA; Mon, 06 Nov 2023 22:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRT-0004H3-QQ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:51 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRS-0001OO-1O
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:51 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc394f4cdfso35691165ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326469; x=1699931269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7uijs1bn5TXW8wsEr2aove5t1QenLBfPQgRPY54EFkA=;
 b=o3+SF6NqLTnqYppho0SQIaVORcrfNQvZUxHC4F3llKBUpd6tj4uaV9sYOiQ6fp0Evs
 oNG8mOS/KopDj/5ILgvQnpnaGNXfq/NM1ZNCehHyWnuL5dnGGRwWmh6NUARFGLU6tsp3
 tHwJgIYVWpCg5myW/Qmv38F2zQBmOmoWnz5x9Vt3dObJneDlrVqT1YE/eaQB/ra5tMZ8
 WIsf9MfPbr4BgHBGvx1saGgJ0VXeF8u4VK+VmahszTmij7YG81Cg7kaFRgftHljRK7kY
 Q8Huh4DNDc/VmMvvQbBOmua0+p/cKRVksHB08uEFwkL9L1VZOgWcXNsQQy3Qhq5N4kex
 cGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326469; x=1699931269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7uijs1bn5TXW8wsEr2aove5t1QenLBfPQgRPY54EFkA=;
 b=EXB/VSOnTD5A4uD2F22lypcvRT9DhmWhLUY/HcXTuV0aHqdw6eIwz478plQObxsuKw
 6WqIRraghj+Kn8xW2OWJJeeKKdbed7qN0Mr5M0Zv6dSZaqW17u66+Bt/PWzmvDAQwa0/
 ZZkGpxrIMONdD60mBjkB/WmTo6qvbbn8m18x3/5kELx1o3jDizfYVMX/bbLDoPvyJvc1
 esMlnmFWJ052Yekr9E5W44NzSUnbRlw5kVltMx3+uB2vI4Pvmz1PyT54ODvnqyw6n4Qk
 k2imwoF75BO0XTqxwAig87I9phWK4UlCoLszgWsyrAyk6raabfmmgK/Pws5KSDcsD0dp
 x+Rw==
X-Gm-Message-State: AOJu0YyoWHDppYlfmjD7DzGhF3GGpPlXK4d1fZ5XheirR73Gfk2cpTgV
 261ImfolpUCNUtbYgUxQh/wEtinUUX0nhS29V8A=
X-Google-Smtp-Source: AGHT+IGsAcDunNpshuhriTNY1yzCtrqJTfMvMIJ3Sm3fdkppTeLuBj3oEAMI271N80fVDEyQlPL4Cw==
X-Received: by 2002:a17:90b:1b46:b0:27d:2109:6279 with SMTP id
 nv6-20020a17090b1b4600b0027d21096279mr7987913pjb.12.1699326468815; 
 Mon, 06 Nov 2023 19:07:48 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 54/85] hw/hppa: Use uint32_t instead of target_ureg
Date: Mon,  6 Nov 2023 19:03:36 -0800
Message-Id: <20231107030407.8979-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

The size of target_ureg is going to change.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 85682e6bab..1f09b4b490 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -391,9 +391,9 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus)
                     true, EM_PARISC, 0, 0);
 
     /* Unfortunately, load_elf sign-extends reading elf32.  */
-    firmware_entry = (target_ureg)firmware_entry;
-    firmware_low = (target_ureg)firmware_low;
-    firmware_high = (target_ureg)firmware_high;
+    firmware_entry = (uint32_t)firmware_entry;
+    firmware_low = (uint32_t)firmware_low;
+    firmware_high = (uint32_t)firmware_high;
 
     if (size < 0) {
         error_report("could not load firmware '%s'", firmware_filename);
@@ -420,9 +420,9 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus)
                         true, EM_PARISC, 0, 0);
 
         /* Unfortunately, load_elf sign-extends reading elf32.  */
-        kernel_entry = (target_ureg) cpu_hppa_to_phys(NULL, kernel_entry);
-        kernel_low = (target_ureg)kernel_low;
-        kernel_high = (target_ureg)kernel_high;
+        kernel_entry = (uint32_t) cpu_hppa_to_phys(NULL, kernel_entry);
+        kernel_low = (uint32_t)kernel_low;
+        kernel_high = (uint32_t)kernel_high;
 
         if (size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
-- 
2.34.1


