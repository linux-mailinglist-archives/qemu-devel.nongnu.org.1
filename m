Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4778201DD
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:33:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKPZ-0005zK-TE; Fri, 29 Dec 2023 16:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPU-0005XL-VH
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:54 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPT-0000LG-0p
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:52 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6d9bf6f24f3so1670832b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885330; x=1704490130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9J/A+VixeAwxo6Ne2AUmiugi6IsxWFbARnpr5oEGiSE=;
 b=b3Mig2qJV0FEtQxXKT7dPH6cipfsQerCBeLYaNZrOQr+g1nyWVtneSAPvTQ46wbuVR
 mJS6CZwunDL3ALS+H75hudiIl5aBZptVgI3IhtCaxpcIeFeVHl+jD9t8TkACdYREq4FX
 MbET7doXQtYUSutoKR/GwGblvBj4319fVNxufHSvDo6ILIbpzIPGM28KYZp1Yt6lJtpT
 LYTkDWd27tbCpE0pDafGJaICx5WUdEDKrgkme4kCwHU1oZHXX5HboyLYFZarHFJpiMYD
 nU3Z+8a3+DAjMzKIe/dbKTc/t/BH9B1Ue9lcBfAtChuC8/5I/yHvS70Qu3/s2Q/Fcbzb
 Au7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885330; x=1704490130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9J/A+VixeAwxo6Ne2AUmiugi6IsxWFbARnpr5oEGiSE=;
 b=JjogdvfN22iQ5S1o3KVCbyRUJuq8S2SddW+clX14XIgr3OLDZpLB1bQJCUUIMU1OeL
 jkFS0A471NMO0v2+b3kwrLFsbZ/HUGx1VYiu16FsvN0sTLh9fmL3PtX1nognapLc+66Z
 sNLH6MFsfy7tvh0+Ru6SirE8dJGYdlrF3kWnyc1Rnq+Euq5zPj+EoM8qAFAAxZGwWMWr
 BfWuHVkbb+cIDXBy1micQ+NxHvyeEbZirgzn7JACEG9qOuNY0Wmi4PesZCretI84EbpM
 Ntbu6xgkzXtplaY5NmXdyISRCKpTwsaT6myov7M3vAR1iJlpf4Yf2h6LqxIpuyJgOrH4
 iDiw==
X-Gm-Message-State: AOJu0Yw2ISfuLDLDUQtcRCAsctadjGr70rLa/rJEH6wMQ7jAxms4zZn5
 ZkMqFciLs+6sGdDlyolBWxPCvvoMMMNGrLUjQqYA9XlliYgUfw==
X-Google-Smtp-Source: AGHT+IHBqdG++buzgX4JMCi5UA23D+Ncd4JM/DgNheVdSyqBdbnsjBG6Xiak2fciBF64wHLtlsp+rQ==
X-Received: by 2002:a05:6a00:3249:b0:6d9:999b:3786 with SMTP id
 bn9-20020a056a00324900b006d9999b3786mr4603735pfb.57.1703885329696; 
 Fri, 29 Dec 2023 13:28:49 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:28:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 49/71] hw/rtc: Constify VMState
Date: Sat, 30 Dec 2023 08:23:24 +1100
Message-Id: <20231229212346.147149-50-richard.henderson@linaro.org>
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-50-richard.henderson@linaro.org>
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
index 2d391a8396..f4c1869232 100644
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


