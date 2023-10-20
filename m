Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B5E7D1789
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:51:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwOt-0001no-9D; Fri, 20 Oct 2023 16:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOr-0001mr-6Q
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:17 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOp-0001Aq-Km
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:16 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-565334377d0so918087a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834834; x=1698439634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZidGRalLwOY7DoY6Z59b3Uu+qUnyVDoR533dncqCuKQ=;
 b=TYyWj7ERVwiTehoWl00ATJF3C1+RyoSnGT/VNvkrM1PWbxtXNNGSoFwgVWZAEwLmUq
 JFtknzcOtU1deVFFbOUAil3zJzx8U3uyJstChaVfHXo/0HjWufzgIbRiYssx/egsqWWO
 NoteOkWjBTDXnEw3WwaRrJVcqpTN16Ig/amgtkbqCk7Hh/Z0onDZmxvEZE3RpbP3izPW
 G+yK5wAQcjZTOvI7IsVjK3AyjtRXZPaDf5jExeKRTQHx2RMRp7PDnRbAdt6tRndo+J69
 MRtEHgplp4u7tAcL4eezjsJ6ZqtFw4ni25oQVNoDFBwZEHxTWSg0vk1zDu+YajpeT+4r
 skNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834834; x=1698439634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZidGRalLwOY7DoY6Z59b3Uu+qUnyVDoR533dncqCuKQ=;
 b=G+ygttd6OIINY9a75TG2f+9chg1w5F+EOvKGMHoacjN+hNwcknYy+/LIAt12XtD1ZN
 fB0QHXf3/BFgp2WVQmZmVGXjFx5EkaGfzS4XZxvE1YOv5Vq3663VebuPd0h4o7hZzNJA
 ufxbCHxV7FZkPjq3pVAtiNZcrB56yDcJXXJB80zRT4j+IS4qicgmbKHr+HBSXevST8A3
 Vqkzc9dnFu3udiSIDTo5pALIo23f9ba4Zr/A3/cDKzG0sVXWw94mA0n5TKOUL6mABEmB
 YwDuSZmQ9FjX4kEsUoLzq6qSoXDlyXS5mwfpWHgqNQ580epDzhC9Gj+VtW4g9344p3kB
 N2Tw==
X-Gm-Message-State: AOJu0YwQiafCZIFciT9oIqqRayhMg6yIUOZTfz9W7k0KO5vPP8NMRpaU
 UnpPiB2b/K1uNZxZC9GQFnKPFeItQTxWfwDc/XA=
X-Google-Smtp-Source: AGHT+IEFP55ATCFN+G94XJmCt3wRraixwdC1ujEb2lRTdf9+XW/SNut9Qout/F0DC8gEZcVE+HHv7Q==
X-Received: by 2002:a05:6a20:da9f:b0:16b:c20d:fcd1 with SMTP id
 iy31-20020a056a20da9f00b0016bc20dfcd1mr3758942pzb.21.1697834834380; 
 Fri, 20 Oct 2023 13:47:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 46/65] hw/hppa: Use uint32_t instead of target_ureg
Date: Fri, 20 Oct 2023 13:43:12 -0700
Message-Id: <20231020204331.139847-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


