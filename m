Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F1E7E1AD7
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:13:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztaA-0005Yc-5X; Mon, 06 Nov 2023 01:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZi-0004g7-OS
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:59:08 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZf-0001SZ-16
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:59:04 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc29f39e7aso25775095ad.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253941; x=1699858741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F64aY4h431jxIwqZ37DtT6CrCFa6U1gi51OfNBzKaxY=;
 b=FMfkottE0zJD96D6DX0yQeXUnMa87vquJ5AV5Emp7L4myisVueQehIuLOYZeJyPX16
 ZyKb0weni2/L3OIrmaZR3McJZ2pgHf8NJ5uNn8icPLmV9PMXhxf79Zx5FKxEPd5lnux3
 eZrFn//izCy4NjVBjNFYwZDYgVh5QGc5mnCKbV+47pvoBYGjlFjdkd2Ia5UA0o9Vdr1z
 c+L+8e3VLKZqskLsmhxk4iLZU1Yn2m8SgYmF8jBrEDNL7Daok7pBTazqyaMz10N2GX6t
 QX11mHUDnCz/EBVIk5gdZQVKjPu/sQie8vM56D88zIRqiXZi+ska5pE7G+NHGYh+O5jH
 sbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253941; x=1699858741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F64aY4h431jxIwqZ37DtT6CrCFa6U1gi51OfNBzKaxY=;
 b=WJxzTjFdbYnS2yweyXnLbu0vV3MnhJbC9bCBBDdXYjga+dThIEiZldWV6MytGqqJth
 8KXJucPZC0XVcqInozpCZjdyjLrE979qS5CQT2A/zGFjFS7u+6fM3fovVgpH1mCd5Ra5
 ZuaPKKo67Fk6HTtQpjTfVfDVvfnaE12c6X7C1u0XSGmQgoqrOz7vYCq13zXaVIgts192
 jxmlmNSse6hAeVsbsPka4bgGJNOjqAmH2FA6ZQKQsZEkPd4ZNAbhDEvBRbpiarpjGXGo
 4JZm00v35ivcsv9807PJ+6vgco2AffzVkSWWz73+TIGTY2mJJ3SRe/eAwye2RRhwdksr
 hphg==
X-Gm-Message-State: AOJu0YxW3ZeWX9YwUAajUkWgOetSwEiZecY15jZYn7MTWK3A82juHaud
 /JOHll1tMZfpx5+Obg7evFaPFja8FW+ahecgzGo=
X-Google-Smtp-Source: AGHT+IGPKUydFquZ8JpbevWrNKwUjz+gslQQp9R8pVDU8tGWc7t15EoVvGsIsLZFKLaS3evcIzLHBQ==
X-Received: by 2002:a17:902:f552:b0:1cc:6906:c016 with SMTP id
 h18-20020a170902f55200b001cc6906c016mr17718680plf.9.1699253941642; 
 Sun, 05 Nov 2023 22:59:01 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:59:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 37/71] hw/isa: Constify VMState
Date: Sun,  5 Nov 2023 22:57:53 -0800
Message-Id: <20231106065827.543129-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
index 79ffbb52a0..b8072c1a25 100644
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
index 57bdfb4e78..2e6bdb49eb 100644
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
@@ -562,7 +562,7 @@ static const VMStateDescription vmstate_via = {
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


