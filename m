Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F199A7E1ACA
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:11:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztdy-0002lT-Sk; Mon, 06 Nov 2023 02:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd0-0000cA-PV
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:32 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcj-0001zb-MA
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:22 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5b9a7357553so3264768a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254132; x=1699858932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dA/G+LV4+Fdy+76bVhkpBzPTtexXhIXWrwKeneJAp7s=;
 b=GkMlue6KF1HNbKDLpmtVF/AUej30kUxln+FqCRKnCSLOJYvVg8+SvVf90gE4HtKYmb
 eyGXuo85Dpy8SPHkAkpqlVn26g6GNxcyjK/X7NOyew2kINKvkP0fqHzLgHeztM8QCAF1
 49XrMQ/kR/iMcYCl91oUNixiBXFUGt7Q3Bqmi8CTHe50HefknULMnKwONpMWAUysGcsJ
 EVLxOZzBo60R/da03qjekqPKeA0CCWXNPcIbrZJCiEjawsaxmO3xxixMD8Tg7rQzN8a+
 qV8G0crtEOtIvFPmj5Rx3JqzAUQ5yqFXWXGhMrHh71OUSpqoSRDyg6H5/QIAmwCJx/LG
 6Y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254132; x=1699858932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dA/G+LV4+Fdy+76bVhkpBzPTtexXhIXWrwKeneJAp7s=;
 b=bh1Eak8o6OgsDfxw+45/eTu7z/zAhA6i/NBsJ0midVt8GZCtWYfHy0nluu42nchYJO
 DiN8hZzgYpejDTv/ECi6dHWZh0BtZMlrVGRVugwTKBadrypKM+ykbQ61Ck4c2tTBZEaj
 8oiQKn/U6t8As4yEvm5C6T7DrQIIaSY0YwKmrLOMH3YFMew0Nych+/OoJisB0nbOnymq
 E9wBKVdtd4nC6C/GU3Uyb1n5kkEM+rgH+QugJ1reCQYZoIScGC8+vlDdYqvq9fRKivj0
 LX94R1oaPOiESqcCGBHYiUd3cTF+8J+X+HRT9TcLaiNjg1b+5AfPx02JGElEQhteWJ0B
 ac/g==
X-Gm-Message-State: AOJu0YzQgkJg/W2KWQKuYniFaocY+7Fu9d58ugMcUzj+4Lyaxoq6hmR3
 0Vn1r4+FZrIe2LUTxdS09mQ7NAld2ZSbW2N7h/g=
X-Google-Smtp-Source: AGHT+IEsVODmhh91IsZR3cOytHwu3VFB9FwPS+hpoz9HL12JrStqcK+u1ALSpGZPyodhFDfgN0KcIA==
X-Received: by 2002:a17:90a:f48d:b0:280:46ac:be71 with SMTP id
 bx13-20020a17090af48d00b0028046acbe71mr20555311pjb.15.1699254132214; 
 Sun, 05 Nov 2023 23:02:12 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 49/71] hw/rtc: Constify VMState
Date: Sun,  5 Nov 2023 22:58:05 -0800
Message-Id: <20231106065827.543129-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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
 hw/rtc/allwinner-rtc.c   | 2 +-
 hw/rtc/aspeed_rtc.c      | 2 +-
 hw/rtc/ds1338.c          | 2 +-
 hw/rtc/exynos4210_rtc.c  | 2 +-
 hw/rtc/goldfish_rtc.c    | 2 +-
 hw/rtc/ls7a_rtc.c        | 2 +-
 hw/rtc/m48t59.c          | 2 +-
 hw/rtc/mc146818rtc.c     | 6 +++---
 hw/rtc/pl031.c           | 6 +++---
 hw/rtc/twl92230.c        | 4 ++--
 hw/rtc/xlnx-zynqmp-rtc.c | 2 +-
 11 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/rtc/allwinner-rtc.c b/hw/rtc/allwinner-rtc.c
index 7e493f0e79..2ac50b30cb 100644
--- a/hw/rtc/allwinner-rtc.c
+++ b/hw/rtc/allwinner-rtc.c
@@ -305,7 +305,7 @@ static const VMStateDescription allwinner_rtc_vmstate = {
     .name = "allwinner-rtc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AwRtcState, AW_RTC_REGS_NUM),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/rtc/aspeed_rtc.c b/hw/rtc/aspeed_rtc.c
index fa861e2d49..589d9a5a7a 100644
--- a/hw/rtc/aspeed_rtc.c
+++ b/hw/rtc/aspeed_rtc.c
@@ -137,7 +137,7 @@ static const MemoryRegionOps aspeed_rtc_ops = {
 static const VMStateDescription vmstate_aspeed_rtc = {
     .name = TYPE_ASPEED_RTC,
     .version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(reg, AspeedRtcState, 0x18),
         VMSTATE_INT64(offset, AspeedRtcState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index 36d8121ddd..e479661c39 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -46,7 +46,7 @@ static const VMStateDescription vmstate_ds1338 = {
     .name = "ds1338",
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_I2C_SLAVE(parent_obj, DS1338State),
         VMSTATE_INT64(offset, DS1338State),
         VMSTATE_UINT8_V(wday_offset, DS1338State, 2),
diff --git a/hw/rtc/exynos4210_rtc.c b/hw/rtc/exynos4210_rtc.c
index cc7101c530..319371f97d 100644
--- a/hw/rtc/exynos4210_rtc.c
+++ b/hw/rtc/exynos4210_rtc.c
@@ -122,7 +122,7 @@ static const VMStateDescription vmstate_exynos4210_rtc_state = {
     .name = "exynos4210.rtc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(reg_intp, Exynos4210RTCState),
         VMSTATE_UINT32(reg_rtccon, Exynos4210RTCState),
         VMSTATE_UINT32(reg_ticcnt, Exynos4210RTCState),
diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 19a56402a0..01acf30b27 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -242,7 +242,7 @@ static const VMStateDescription goldfish_rtc_vmstate = {
     .version_id = 2,
     .pre_save = goldfish_rtc_pre_save,
     .post_load = goldfish_rtc_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(tick_offset_vmstate, GoldfishRTCState),
         VMSTATE_UINT64(alarm_next, GoldfishRTCState),
         VMSTATE_UINT32(alarm_running, GoldfishRTCState),
diff --git a/hw/rtc/ls7a_rtc.c b/hw/rtc/ls7a_rtc.c
index 1f9e38a735..ac28c1165b 100644
--- a/hw/rtc/ls7a_rtc.c
+++ b/hw/rtc/ls7a_rtc.c
@@ -454,7 +454,7 @@ static const VMStateDescription vmstate_ls7a_rtc = {
     .minimum_version_id = 1,
     .pre_save = ls7a_rtc_pre_save,
     .post_load = ls7a_rtc_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT64(offset_toy, LS7ARtcState),
         VMSTATE_INT64(offset_rtc, LS7ARtcState),
         VMSTATE_UINT32_ARRAY(toymatch, LS7ARtcState, TIMER_NUMS),
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 2e2c849985..aa44c4b20c 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -526,7 +526,7 @@ static const VMStateDescription vmstate_m48t59 = {
     .name = "m48t59",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(lock, M48t59State),
         VMSTATE_UINT16(addr, M48t59State),
         VMSTATE_VBUFFER_UINT32(buffer, M48t59State, 0, NULL, size),
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index c27c362db9..a66a520441 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -817,7 +817,7 @@ static const VMStateDescription vmstate_rtc_irq_reinject_on_ack_count = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = rtc_irq_reinject_on_ack_count_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(irq_reinject_on_ack_count, MC146818RtcState),
         VMSTATE_END_OF_LIST()
     }
@@ -829,7 +829,7 @@ static const VMStateDescription vmstate_rtc = {
     .minimum_version_id = 1,
     .pre_save = rtc_pre_save,
     .post_load = rtc_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BUFFER(cmos_data, MC146818RtcState),
         VMSTATE_UINT8(cmos_index, MC146818RtcState),
         VMSTATE_UNUSED(7*4),
@@ -845,7 +845,7 @@ static const VMStateDescription vmstate_rtc = {
         VMSTATE_UINT64_V(next_alarm_time, MC146818RtcState, 3),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_rtc_irq_reinject_on_ack_count,
         NULL
     }
diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index b01d0e75d1..837b0bdf9b 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -290,7 +290,7 @@ static const VMStateDescription vmstate_pl031_tick_offset = {
     .minimum_version_id = 1,
     .needed = pl031_tick_offset_needed,
     .post_load = pl031_tick_offset_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(tick_offset, PL031State),
         VMSTATE_END_OF_LIST()
     }
@@ -303,7 +303,7 @@ static const VMStateDescription vmstate_pl031 = {
     .pre_save = pl031_pre_save,
     .pre_load = pl031_pre_load,
     .post_load = pl031_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(tick_offset_vmstate, PL031State),
         VMSTATE_UINT32(mr, PL031State),
         VMSTATE_UINT32(lr, PL031State),
@@ -312,7 +312,7 @@ static const VMStateDescription vmstate_pl031 = {
         VMSTATE_UINT32(is, PL031State),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_pl031_tick_offset,
         NULL
     }
diff --git a/hw/rtc/twl92230.c b/hw/rtc/twl92230.c
index 64c61c3dae..efd19a76e6 100644
--- a/hw/rtc/twl92230.c
+++ b/hw/rtc/twl92230.c
@@ -768,7 +768,7 @@ static const VMStateDescription vmstate_menelaus_tm = {
     .name = "menelaus_tm",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16_HACK(tm_sec, struct tm),
         VMSTATE_UINT16_HACK(tm_min, struct tm),
         VMSTATE_UINT16_HACK(tm_hour, struct tm),
@@ -810,7 +810,7 @@ static const VMStateDescription vmstate_menelaus = {
     .minimum_version_id = 0,
     .pre_save = menelaus_pre_save,
     .post_load = menelaus_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(firstbyte, MenelausState),
         VMSTATE_UINT8(reg, MenelausState),
         VMSTATE_UINT8_ARRAY(vcore, MenelausState, 5),
diff --git a/hw/rtc/xlnx-zynqmp-rtc.c b/hw/rtc/xlnx-zynqmp-rtc.c
index 3e7d61a41c..613c6407a6 100644
--- a/hw/rtc/xlnx-zynqmp-rtc.c
+++ b/hw/rtc/xlnx-zynqmp-rtc.c
@@ -244,7 +244,7 @@ static const VMStateDescription vmstate_rtc = {
     .minimum_version_id = 1,
     .pre_save = rtc_pre_save,
     .post_load = rtc_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPRTC, XLNX_ZYNQMP_RTC_R_MAX),
         VMSTATE_UINT32(tick_offset, XlnxZynqMPRTC),
         VMSTATE_END_OF_LIST(),
-- 
2.34.1


