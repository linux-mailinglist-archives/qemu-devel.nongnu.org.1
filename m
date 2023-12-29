Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E0C8201E1
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:33:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKQH-0000TN-Sm; Fri, 29 Dec 2023 16:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPz-0008QK-J1
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:25 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPu-0000Nw-7D
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:19 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6d9b37f4804so2673100b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885352; x=1704490152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzNGhzq81QTlaN12LzVhmURoRRihF1DCyuym+umxPGo=;
 b=fn8AvMqqQ1y8K0uGGdmD4hKlZIzraw9gSnavPjdk8B3zSFIujqm4V0+k/f0LeNhlzb
 2UuEwvV5anvtb4c7QMrVa50EwDbttCsb9T8Cdt7rizf86Mt+1/gxu/RZxgtzNP2h4sni
 gGkISTseIxbGGavmN7x2/84GCGTgYYbUgu+rxQqGNPWkmObp+fEtRwRqmrIEfFqm9eAg
 awgXPOLDDRh4xfW8wpPFLeVjaUixTZM71WivnYbkemjgVCJiG6PiTgFjscN4VsQvm8AH
 rakVQeXQBaPJVWrEPme/vYz/2h7Nl0iZqaLyhT7UipsP2A0/iaXN3j1ZVzFl+tdFpIkk
 c1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885352; x=1704490152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MzNGhzq81QTlaN12LzVhmURoRRihF1DCyuym+umxPGo=;
 b=D22m+NRyPT4OF1mEAJZ+KyhpdQrfUPfUePjupy2CuaSqgmj+NMzKKrZZRdCW58Ak5H
 lzYhIikz7rhUIQQC/ad8ZDS1a2GbxJEcu8BCFNcSmxJK4/r26czy35+Cr2rf2s/tRQDO
 m25MYDl9P6TbGNtJAIcwAnlATGpm4PnP4Fh4j1+ItNHt/I8UXUeZeEYF5HQ7KQ+XtJ4j
 u/7YNzh9RDMc2mvWW6CgDjTDYm39FqktU3GNu2h862XIrw2HpQyrgrVfEm+UxT7gSq9R
 mi9bltHVnPLYwJM2PpeNo50gyMyzF1cDhAXiF9UuniFu8BUqH6Z886juh617YRjyFnND
 vF0Q==
X-Gm-Message-State: AOJu0YwgoQAx7aCFALCmMqSR/uHNEZ1xaj9Jqw7nQR+bRfBntpgNRi6V
 3ao+7arDIgR49i+6aVaVzJF6eeLk5W7zsvyjGhRc1mQ8ufMHeA==
X-Google-Smtp-Source: AGHT+IGbiXk7Zakn4jHT7g/5ohoFPdVwbKmKcmoP2DQSUAzM9MjK5vU10hlPJ6jyi/yWR4RHCyauQw==
X-Received: by 2002:a05:6a20:e127:b0:196:2550:d6d6 with SMTP id
 kr39-20020a056a20e12700b001962550d6d6mr5702899pzb.13.1703885352053; 
 Fri, 29 Dec 2023 13:29:12 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:29:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 59/71] hw/vfio: Constify VMState
Date: Sat, 30 Dec 2023 08:23:34 +1100
Message-Id: <20231229212346.147149-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20231221031652.119827-60-richard.henderson@linaro.org>
---
 hw/vfio/display.c | 2 +-
 hw/vfio/pci.c     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 7a10fa8604..1aa440c663 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -560,7 +560,7 @@ const VMStateDescription vfio_display_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = migrate_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_POINTER(ramfb, VFIODisplay, ramfb_vmstate, RAMFBState),
         VMSTATE_END_OF_LIST(),
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1874ec1aba..9f838978be 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2561,7 +2561,7 @@ const VMStateDescription vmstate_vfio_display = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vfio_display_migration_needed,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_STRUCT_POINTER(dpy, VFIOPCIDevice, vfio_display_vmstate,
                                VFIODisplay),
         VMSTATE_END_OF_LIST()
@@ -2572,12 +2572,12 @@ const VMStateDescription vmstate_vfio_pci_config = {
     .name = "VFIOPCIDevice",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
         VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_vfio_display,
         NULL
     }
-- 
2.34.1


