Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3E081AD5F
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9ax-0006FI-Fz; Wed, 20 Dec 2023 22:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9av-0006D0-TT
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:33 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9au-00046Q-3Y
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:33 -0500
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7811c02cfecso16156585a.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128769; x=1703733569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ByLm8N2FJxPLHay8ZgvNMju3lIZ/h8K2D6utyHQF+c=;
 b=LObUrJhBTRUaPLvYyZyb+ZxrhcyjaltTRgJ6ok4rAG+uZUxWRm9d62XQS6VZYWuhSi
 6nymlv56ijk0fNLUb0NC86nSLfWqUT1QLpSNAvJI5TLHOnGgxPcB6wth3liYn4eY6m+P
 QZBFWBsw1FXhuT3SsUnwD/B6r48+2ivPNkFhfvxeiWXh+IM2LTQqAT/VfYhRLh+QGCpp
 FagiOxi6/WfAJqvfVc8EJd3ECTU4wIzOOpJ1SSETJqEi+Pi7Se88o8yyNbO+oN/bnXtB
 a5LwSjULdYrsX5nU9FfrSVudEzIcfpFq2dSB7MJoUp0/eFqDx5h1hBtNphNXrzgb8CFY
 MtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128769; x=1703733569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ByLm8N2FJxPLHay8ZgvNMju3lIZ/h8K2D6utyHQF+c=;
 b=IxpPGDX9x0XPbZhRm3kNFJhm3NyHqcT0IIzuztGRy6J7q2paJ+qvOZA2qwV3rW21x8
 0IUednLdkzSQd9f6PS1C/+nS7USM0+UG+9Ca+/vkIbbpr/Uc7fpxeUFa8v8JqDnUqk82
 Ay5hxBbhjSeg61BYf6N2kfcoDJTHMqC6QuZNprqI+xJZrQnxiiZtm0PdhF7/3Nc/dUvz
 HmZRgfoVGTwbyuot+spTOb+BjPe7bZba9TG4uzYxHRMLWvVjy9SunCGM4kNO9VGTdNT1
 EgtvyMMILKuKa6PiEnFsjwnJYIn81dbTZPr/e25dMA06deYvUPa71PCYFu8srYJNXNAN
 ljhA==
X-Gm-Message-State: AOJu0YxA2CSF3ewCGY5YIq7KLJ13JOWo0jj7upe/QaaWFZ1lKDd3Hs6V
 JNTBuJXimx7moNUu2kMyioXDrQbVc4KQ94f3kjLKZDhD
X-Google-Smtp-Source: AGHT+IGwE47YRYZXZZuLysoyMEjWJjKMvIW2b1zLMkjY5poUtE/DIxKlquNTWswQ0BsUyboXocHjnw==
X-Received: by 2002:a05:620a:2724:b0:77e:fba3:759b with SMTP id
 b36-20020a05620a272400b0077efba3759bmr20700269qkp.147.1703128769591; 
 Wed, 20 Dec 2023 19:19:29 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:19:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 37/71] hw/isa: Constify VMState
Date: Thu, 21 Dec 2023 14:16:18 +1100
Message-Id: <20231221031652.119827-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x732.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/isa/apm.c      | 2 +-
 hw/isa/i82378.c   | 2 +-
 hw/isa/lpc_ich9.c | 8 ++++----
 hw/isa/pc87312.c  | 2 +-
 hw/isa/piix.c     | 8 ++++----
 hw/isa/vt82c686.c | 4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/isa/apm.c b/hw/isa/apm.c
index dfe9020d30..e34edb864c 100644
--- a/hw/isa/apm.c
+++ b/hw/isa/apm.c
@@ -68,7 +68,7 @@ const VMStateDescription vmstate_apm = {
     .name = "APM State",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(apmc, APMState),
         VMSTATE_UINT8(apms, APMState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 203b92c264..cbaa152a89 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -40,7 +40,7 @@ static const VMStateDescription vmstate_i82378 = {
     .name = "pci-i82378",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, I82378State),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 23eba64f22..3924eec483 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -768,7 +768,7 @@ static const VMStateDescription vmstate_ich9_rst_cnt = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ich9_rst_cnt_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(rst_cnt, ICH9LPCState),
         VMSTATE_END_OF_LIST()
     }
@@ -788,7 +788,7 @@ static const VMStateDescription vmstate_ich9_smi_feat = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ich9_smi_feat_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(smi_guest_features_le, ICH9LPCState,
                             sizeof(uint64_t)),
         VMSTATE_UINT8(smi_features_ok, ICH9LPCState),
@@ -802,7 +802,7 @@ static const VMStateDescription vmstate_ich9_lpc = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = ich9_lpc_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(d, ICH9LPCState),
         VMSTATE_STRUCT(apm, ICH9LPCState, 0, vmstate_apm, APMState),
         VMSTATE_STRUCT(pm, ICH9LPCState, 0, vmstate_ich9_pm, ICH9LPCPMRegs),
@@ -810,7 +810,7 @@ static const VMStateDescription vmstate_ich9_lpc = {
         VMSTATE_UINT32(sci_level, ICH9LPCState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_ich9_rst_cnt,
         &vmstate_ich9_smi_feat,
         NULL
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 8d7b8d3db2..ee23f3e164 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -319,7 +319,7 @@ static const VMStateDescription vmstate_pc87312 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = pc87312_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(read_id_step, PC87312State),
         VMSTATE_UINT8(selected_index, PC87312State),
         VMSTATE_UINT8_ARRAY(regs, PC87312State, 3),
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 04ebed5b52..344bf32e54 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -230,7 +230,7 @@ static const VMStateDescription vmstate_piix3_rcr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = piix3_rcr_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(rcr, PIIXState),
         VMSTATE_END_OF_LIST()
     }
@@ -242,13 +242,13 @@ static const VMStateDescription vmstate_piix3 = {
     .minimum_version_id = 2,
     .post_load = piix_post_load,
     .pre_save = piix3_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PIIXState),
         VMSTATE_INT32_ARRAY_V(pci_irq_levels_vmstate, PIIXState,
                               PIIX_NUM_PIRQS, 3),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_piix3_rcr,
         NULL
     }
@@ -259,7 +259,7 @@ static const VMStateDescription vmstate_piix4 = {
     .version_id = 3,
     .minimum_version_id = 2,
     .post_load = piix4_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PIIXState),
         VMSTATE_UINT8_V(rcr, PIIXState, 3),
         VMSTATE_END_OF_LIST()
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 9c2333a277..d3e0f6d01f 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -82,7 +82,7 @@ static const VMStateDescription vmstate_acpi = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = vmstate_acpi_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, ViaPMState),
         VMSTATE_UINT16(ar.pm1.evt.sts, ViaPMState),
         VMSTATE_UINT16(ar.pm1.evt.en, ViaPMState),
@@ -563,7 +563,7 @@ static const VMStateDescription vmstate_via = {
     .name = "via-isa",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, ViaISAState),
         VMSTATE_END_OF_LIST()
     }
-- 
2.34.1


