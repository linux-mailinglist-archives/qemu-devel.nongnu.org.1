Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFE281AD60
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9fm-00021I-MD; Wed, 20 Dec 2023 22:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fO-0001Xg-Bb
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:10 -0500
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fM-0000qC-MZ
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:10 -0500
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-67aa9a99915so2182286d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129047; x=1703733847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UFDIv+0B5QiSwQn+3TIbVlZCmdkEBrIDhqvxZY7o6rY=;
 b=lpyc5k9BOPbviixaFmXDhjRiko/Taxv4pPoM1LmDrLryWOd4ewNHEJKpkRlmfbs4vF
 3C48WAQ1KCk6PL/LTgYsyIdmpqLOQ22PA7QrsrhI01G9M/pKaPQ5GbeLCPsAui41v8OB
 IZuzm2a43Pl5D1tuCLGM+zeP4tstgQtLmtns6OO1IhgayjJzWa6mTbSvhWZNsrkEwDCK
 nE9ldlvXk4x4aUny7O5EQDb34LfeV6VYZ5Oz1FObwGfhQ4309IqHl9j9ubLxEBBhMIb8
 WRDCbZ8u8+aHyUF6VB99n+dlcBLPj37vv419p7ESub7eOXnqNd/UY/93ljCz/uAN997R
 VRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129047; x=1703733847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UFDIv+0B5QiSwQn+3TIbVlZCmdkEBrIDhqvxZY7o6rY=;
 b=XT7UYfV2SqLZW1O3wIo8Vnk4v9dEAo0Bo0BM7wZjhHsRjUkc302vfsTr0BBPN6eTY6
 zXSVGxQZoILp5GGsWBWM6jpLnrNeQS+6iVod7HA9rTnwYaSTw0MSoEtsQ0hL3HB1dQ95
 Y7JuZxokiPYURepCEEZdw7KllOsBDyI4LlXNljBkl1u+h9hlojU/0tw6Zgjz+rlc74mI
 qo8rm9Cy8TVkl/GPtOAz7HXuzDq7ueYB8Euino45HB8umpv8ed+hYv5EnaWHpmGkezvW
 veupdsKctiYDSjNVPsLChCiPg50vVUAPyd8zWfnrS7Tm58RuxmPFcSD4tvZHQ9gxcgqx
 zyCA==
X-Gm-Message-State: AOJu0YyGuZaVe8PZz7/9JV2Zuhe5bfWLdH1ohxGZ83JRQKfHqVWqq70O
 0CQdRHFxNnXAxFysmKq/SQFKgIyNucg6BFgO/mhtB5G9
X-Google-Smtp-Source: AGHT+IHsu+cICMhz1bTZVPZObhYBPJVytIQJD2gI7LC7eryG5fYtmwQyfG3KRmwuuOp7PizLMxHwsA==
X-Received: by 2002:ad4:574c:0:b0:67f:d89:8f1e with SMTP id
 q12-20020ad4574c000000b0067f0d898f1emr16487867qvx.87.1703129047711; 
 Wed, 20 Dec 2023 19:24:07 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.24.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:24:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 59/71] hw/vfio: Constify VMState
Date: Thu, 21 Dec 2023 14:16:40 +1100
Message-Id: <20231221031652.119827-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf29.google.com
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


