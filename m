Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F38D8201DA
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:32:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKQG-0000IZ-PL; Fri, 29 Dec 2023 16:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQ3-0008RZ-GL
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:32 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPx-0000OZ-Nl
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:25 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6dbfdb41a63so2432553a34.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885358; x=1704490158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yMiyXLSoDy5ZHKBGF4zdLgoSUDciZZMKn07QJW7rkcw=;
 b=NU2uL2j/VxUsTC4Fnq33gPRnn+UUjwGv3WsibgZ9+2IhJNf5ttusqVj8aHBtGfNuT6
 8rwB8KaJ4sUNdDCi7RI0VWjC6HeMzBIEO/JKg1U22SEY+A7uzNaG68e2O9nYSAMeR488
 WJUQLHoBdXoKZ4eEMTFZVW1EM/VMtroVwHrlIHkBH0mjNIfi3MJrN/uINeg1CLX7S5vU
 /qlwrlYS9vi0VFw5yjXr748UGEtaia4onAJxUUGp96BjpRSaDVksH7XEf92KxUX/lqhy
 QsqLQ3MxtuYSZqVi1G9NVfXb3pZ71oKVquAsM35YGqvKsqgmePErrU+wxivNlZ+L4A4B
 UNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885358; x=1704490158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yMiyXLSoDy5ZHKBGF4zdLgoSUDciZZMKn07QJW7rkcw=;
 b=LaZuDNVBh3lUWT9+IhswROXJfd/eR1HYWe0f9btPlHs6L9YHC7ASEksYun6oy/ZR/u
 JiVnUInelPKaNpvdKQKG7+o/Er+vOPckTH1OlWV1pHclZH3UDl3QlqaYT7j/xKTMPc9f
 NZKKJ7Vmy4CDLIXIECACS2owNw+vaVPq/5Ymw9f1v4E9XGmIELzFIrtZDtWVpVdYu5uu
 rByIh376/9koT9kGNsUGlDucA00P1o8la1UDrzwBoWIbfVKds0OPBr+VzpDMiPsRY6WO
 gg2HK0OXFPL7BIMZ2/oEzSRvFD4uHOkE9CSK4fpgOefURk968JN1OH46du3Jm/zw9+7Z
 zzfQ==
X-Gm-Message-State: AOJu0YwHbrprFKkjEJstYuvbGKrC6jQDLTHcIHgG4wgaY0YaGnMIAT+R
 pMnI82KwxK7aBWqT8vKA6yCJlUphbtLoHqJ2l1y5pEdW5RAIrg==
X-Google-Smtp-Source: AGHT+IErlgaitNT3w3HvjnB7qJ/mI7UyCE7WLD7YfKqGpVIxvHC5qkoE/+GZ1a3w+iOeOrGF31ZqJQ==
X-Received: by 2002:a9d:7412:0:b0:6db:b1b1:769f with SMTP id
 n18-20020a9d7412000000b006dbb1b1769fmr9665672otk.27.1703885358383; 
 Fri, 29 Dec 2023 13:29:18 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.29.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:29:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 62/71] hw/misc/macio: Constify VMState
Date: Sat, 30 Dec 2023 08:23:37 +1100
Message-Id: <20231229212346.147149-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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
Message-Id: <20231221031652.119827-63-richard.henderson@linaro.org>
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


