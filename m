Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6809D81AD61
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9fn-0002El-Jj; Wed, 20 Dec 2023 22:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fa-00020n-BH
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:24 -0500
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fX-0000z7-S3
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:21 -0500
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-67ab16c38caso1844146d6.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129059; x=1703733859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6qb5wT872vgkkQeZLcaPPTqHv9wq2aCmdY3hodAPUnI=;
 b=P+dgwG/DvJsrR3pHoTvzn5G4BG8zQeI/i0hU/PdWpO+8DtsAdWCDbRJZTCSF6V5WzN
 bdvp1H1r18xl71MAfHKt/dnZryPxTiHocYfWRKnySPg+SSHspe4VlsAW4nokfjZmsfHS
 R2DEJBnCpiENkOk9zEcmyq/d5K3od7S0Z+7P7IR8y0yeozHOq3vbF3dGJWMJ1SXVbcXB
 Ox++QcAjtkGBK+xEkRSo22t20OTYlRgLChkWtFovJojnrCZl5z/FglTBMn60eZi6zuS8
 /+E3A1juDodhxoAL7/07mRcCSq3J7AhNm+8+WjSrLO1VLyYVYGc1TuQ7RRK9mM3hTMt8
 smrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129059; x=1703733859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qb5wT872vgkkQeZLcaPPTqHv9wq2aCmdY3hodAPUnI=;
 b=b+FXgi39dUOOOcjBdZnLKQ3nRoCU1wipaCY5sLL8f2fj6ZZn2406I0Desx0+JFceVC
 Yw5sujszai6AaI5COIGGMafQYGeowxirrJKMf+hhPDfTmVh+3xaia1NqVuRsj7Ey57Mw
 FLoWquTGApAa0o4VxTQ1GkR4XUPtJvftszJ2fojoFlLuBxx0aSJZAAB6e4fzJHh1N2Lo
 6fI9stfat62ulmyOX2vtf63zTJPrvVrw0aV3GQKA0JKBjSvamhOWEWo3l9v5NVvZXTft
 D4YYP+oCIuAty4lC3tjy9XDY8qgCDNPUF55p1HvPs5SYB0ZqvNSCsQPdc9l2LZ2G+azz
 t68A==
X-Gm-Message-State: AOJu0YzH8ErFJXz1lg9ZrDcarKQp4os5d4n8ETqbskkmstYHTXND7gYt
 7e3oUPFJeCkknWVt3vCy3qYkfDEiAk0AZG9YabeQrOh2
X-Google-Smtp-Source: AGHT+IF7yQyV/XQT8TgWlSmbo77jgTQjJe9dFZXAz38ywNHMxMMxGuY60VL8nMxRS1UKV8+E4AI+0g==
X-Received: by 2002:ad4:5d45:0:b0:67f:27be:51ec with SMTP id
 jk5-20020ad45d45000000b0067f27be51ecmr16250830qvb.100.1703129059008; 
 Wed, 20 Dec 2023 19:24:19 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.24.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:24:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 62/71] hw/misc/macio: Constify VMState
Date: Thu, 21 Dec 2023 14:16:43 +1100
Message-Id: <20231221031652.119827-63-richard.henderson@linaro.org>
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
 hw/misc/macio/cuda.c      | 2 +-
 hw/misc/macio/gpio.c      | 2 +-
 hw/misc/macio/mac_dbdma.c | 8 ++++----
 hw/misc/macio/macio.c     | 4 ++--
 hw/misc/macio/pmu.c       | 6 +++---
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 6336dcb194..41934e2cf8 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -487,7 +487,7 @@ static const VMStateDescription vmstate_cuda = {
     .name = "cuda",
     .version_id = 6,
     .minimum_version_id = 6,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(mos6522_cuda.parent_obj, CUDAState, 0, vmstate_mos6522,
                        MOS6522State),
         VMSTATE_UINT8(last_b, CUDAState),
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 4deb330471..549563747d 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -168,7 +168,7 @@ static const VMStateDescription vmstate_macio_gpio = {
     .name = "macio_gpio",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(gpio_levels, MacIOGPIOState, 8),
         VMSTATE_UINT8_ARRAY(gpio_regs, MacIOGPIOState, 36),
         VMSTATE_END_OF_LIST()
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 80a789f32b..2a528ea08c 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -807,7 +807,7 @@ static const VMStateDescription vmstate_dbdma_io = {
     .name = "dbdma_io",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(addr, struct DBDMA_io),
         VMSTATE_INT32(len, struct DBDMA_io),
         VMSTATE_INT32(is_last, struct DBDMA_io),
@@ -821,7 +821,7 @@ static const VMStateDescription vmstate_dbdma_cmd = {
     .name = "dbdma_cmd",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(req_count, dbdma_cmd),
         VMSTATE_UINT16(command, dbdma_cmd),
         VMSTATE_UINT32(phy_addr, dbdma_cmd),
@@ -836,7 +836,7 @@ static const VMStateDescription vmstate_dbdma_channel = {
     .name = "dbdma_channel",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, struct DBDMA_channel, DBDMA_REGS),
         VMSTATE_STRUCT(io, struct DBDMA_channel, 0, vmstate_dbdma_io, DBDMA_io),
         VMSTATE_STRUCT(current, struct DBDMA_channel, 0, vmstate_dbdma_cmd,
@@ -849,7 +849,7 @@ static const VMStateDescription vmstate_dbdma = {
     .name = "dbdma",
     .version_id = 3,
     .minimum_version_id = 3,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(channels, DBDMAState, DBDMA_CHANNELS, 1,
                              vmstate_dbdma_channel, DBDMA_channel),
         VMSTATE_END_OF_LIST()
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 265c0bbd8d..c9f22f8515 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -376,7 +376,7 @@ static const VMStateDescription vmstate_macio_oldworld = {
     .name = "macio-oldworld",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj.parent, OldWorldMacIOState),
         VMSTATE_END_OF_LIST()
     }
@@ -396,7 +396,7 @@ static const VMStateDescription vmstate_macio_newworld = {
     .name = "macio-newworld",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj.parent, NewWorldMacIOState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 58316d1871..e9a90da88f 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -668,7 +668,7 @@ static const VMStateDescription vmstate_pmu_adb = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pmu_adb_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(adb_reply_size, PMUState),
         VMSTATE_BUFFER(adb_reply, PMUState),
         VMSTATE_END_OF_LIST()
@@ -679,7 +679,7 @@ static const VMStateDescription vmstate_pmu = {
     .name = "pmu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(mos6522_pmu.parent_obj, PMUState, 0, vmstate_mos6522,
                        MOS6522State),
         VMSTATE_UINT8(last_b, PMUState),
@@ -698,7 +698,7 @@ static const VMStateDescription vmstate_pmu = {
         VMSTATE_INT64(one_sec_target, PMUState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_pmu_adb,
         NULL
     }
-- 
2.34.1


