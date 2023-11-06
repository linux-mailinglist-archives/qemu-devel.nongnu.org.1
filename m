Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8117E1AC9
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:10:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztg4-0006RZ-W5; Mon, 06 Nov 2023 02:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd1-0000cV-4h
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:32 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcr-00020p-L7
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:29 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6c320a821c4so3710378b3a.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254140; x=1699858940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wER6he+enBklnSNbIQSi4AtnKBowbxVd2VG2BjlXQmQ=;
 b=vj1GLD1OtZ4G00Iz6PRb8CDOwETa6Ayt8BDkw+TyT2el+a/Xd3SgN3NSQNpSG3epWQ
 QhnV5G4V93ZZadRacTAonq9qseJI7R0XS180Qv26PaA7WbJcIxJVsVpqR322oiwfTtV4
 Vmid8RU/HRNlB29fS6WInu4a+Gp1fpuS0dypn6I4MOLdMqz1KLJXQEOOoefN/WEd0YjL
 a10HL2ydQ0z38tO/0mr8NKRzX/UefEAsQ+KuNPBQSk/Q9DAlyxnuawc3yQ2sXy6+Hl7u
 RiztgbxSvDFV/5sHBDpMA5AALxXl8fEzse9vpbSKJ/Fz2o9UrDXKzmVQxvhuIGNwJHsL
 rZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254140; x=1699858940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wER6he+enBklnSNbIQSi4AtnKBowbxVd2VG2BjlXQmQ=;
 b=tBQ1KCK4mJTlLhZiIhgXrDyS4uPgMJ19nE5Wn2j1rWWM+XvBtB/XwoQ2nzFxMWlpfY
 Us+byhzgfEzJKfrooi4W2zkOhVJrq2kODoFEE3g6nOR4AcrxDBMbiIYeiIOGMVZ+iNZZ
 ZlKlSDaoeduEYEGEFVLmINBTsIRMVoIPm3yqwGOgaX/cdRIfdvdNHMz5EM6M5zLgCdaE
 2z0O0vcAP7OK4ffYA41DoGtQzw9gZ+xIbjQhal65eblMYPjUA1g4ilOfM6/g8bgCuYof
 zfS6Y7Gsun6tA+5yN8vjBjI2Bxu9GpC0L/5t1wKHzV4pRQjI1gwRU8Dw2ohrXvigKsf8
 zfQw==
X-Gm-Message-State: AOJu0YzvvMYorkudhOkUUtmb1a+gCEmR4U9is4aEGPKbz/jROoDwfdxL
 cdbc4+XazegWVM6neRV9k5V/Y9dQyoTFqI+kzdc=
X-Google-Smtp-Source: AGHT+IEFGlagk15aCWa4GZPFBvQQC+bYQzVihKk/xrTefPTN4tOh6aWCuDTBsxg8DLm50E1Y2+pCgA==
X-Received: by 2002:a05:6a20:8406:b0:182:1c26:e01a with SMTP id
 c6-20020a056a20840600b001821c26e01amr6577412pzd.62.1699254139993; 
 Sun, 05 Nov 2023 23:02:19 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 59/71] hw/vfio: Constify VMState
Date: Sun,  5 Nov 2023 22:58:15 -0800
Message-Id: <20231106065827.543129-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
index b27011cee7..2a9bce0041 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2695,7 +2695,7 @@ const VMStateDescription vmstate_vfio_display = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vfio_display_migration_needed,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_STRUCT_POINTER(dpy, VFIOPCIDevice, vfio_display_vmstate,
                                VFIODisplay),
         VMSTATE_END_OF_LIST()
@@ -2706,12 +2706,12 @@ const VMStateDescription vmstate_vfio_pci_config = {
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


