Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 981937DEA3B
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:40:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcX-00080r-C8; Wed, 01 Nov 2023 21:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb3-0006Ry-SQ
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:11 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb1-0001xB-Oc
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:09 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc30bf9e22so3686485ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888846; x=1699493646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7uijs1bn5TXW8wsEr2aove5t1QenLBfPQgRPY54EFkA=;
 b=datj6WQIZmJbqOuVr6Uy39Ddm1TmGo16xJ9HrnGpO6ZCLjeBsjiTBA2nSJgOfbzh7T
 X6Uq+Op+KheTHoec7YXcJ9KPUxoSwpbFoCIIYXhtnTlDzd+FgOA5qm2Usx/dpgIsTWa5
 gFqdZqyd5nDUx/PujjNEXdsGef6+Ii7lIl7HGGCsc4T2T6XW6JrDubtz4Ws3qyAsDetO
 djnDohBKxRnLvf9R+JViRdm4IlamUzxNZ7TWj5VBZvl4Hf6swWNH3DgUyz7wALt7z1F4
 YxU83OW4+ND6YWtJPPsSmMq3lWFTVrUkIduX9k/QnFyjUAaOaoHChSP+BqT4N0vV7anL
 0Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888846; x=1699493646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7uijs1bn5TXW8wsEr2aove5t1QenLBfPQgRPY54EFkA=;
 b=kbnDkSbZ+BlgK0YyqEvHhxEBHNphhzwuwXcG2P4j2js0wI9CVZa/YKCTYHOXa5TKyR
 7cOb5ouGyp9UBpB7SEz8hwbUAdMLjnX6fVJ/eOvshk0PtWcdemGLsKySgDewVU5Y2D44
 X3yvDudcA8CSQRA5aCIMJqLjST4gweWwSKjJkf5jWqxAp/JFQNLhknb+Wb4pyiNGCZ7d
 ivbMGy77uwkGZ74ThcFCZvQklSodKqX3XPfnN4I3Fb1iWtGlV+HV5XRzSE3z4j1XnHop
 ZUp8JZVQivjFspXSLR2WZNR0LKYSfragKTLR3tOZr3L3I/O2MN9cXVh6Qji9IGD1Sgfl
 Ej3A==
X-Gm-Message-State: AOJu0YzCrSe+DoiK1jNioCCJ/wPIoYO1z1AlWp7d/R+1/5mJAJNuDxZj
 ftyxLr4XYiH9YRSV2RKhl/+gSewhdyZ7hXW1prc=
X-Google-Smtp-Source: AGHT+IE9V6j0jvB5jMLHt3LuqLkx0XxDUITVbw3yh8ldurjpxAvNidDf1Z3i4oJq2ZJCPzLL3wznIw==
X-Received: by 2002:a17:902:dac9:b0:1cc:2518:ef02 with SMTP id
 q9-20020a170902dac900b001cc2518ef02mr6226228plx.14.1698888846418; 
 Wed, 01 Nov 2023 18:34:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 56/88] hw/hppa: Use uint32_t instead of target_ureg
Date: Wed,  1 Nov 2023 18:29:44 -0700
Message-Id: <20231102013016.369010-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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


