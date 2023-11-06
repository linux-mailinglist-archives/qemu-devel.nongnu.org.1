Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9EA7E1AC2
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:10:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztg2-0006Lm-T0; Mon, 06 Nov 2023 02:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd7-0000yY-HK
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:44 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcu-00021P-0F
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:36 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6c396ef9a3dso1447386b3a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254142; x=1699858942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qb5wT872vgkkQeZLcaPPTqHv9wq2aCmdY3hodAPUnI=;
 b=Ts86OAMAH5KTXJeC6B1SuVz9wZl1HA8nhWu3fm7/B0SY5ICoi572s+DBX7Rq9HI6w4
 oSRvqI6E9+sWqW5aw/R5FeKLw1MQ2BCeAYd2I3uRYCG2QtROXBHsJ1kQEk9R7VJmrFja
 HbIs3I0iji3Tp9kG3hO9shUoz7ZWX0SarHmJhXfx6gkYkcdmH78SxVGNb9aRoX1QgEFQ
 OAHcJm5F5V9mITNWGW7oJx6quaN9Uj/qBOhFyRHFoUb8QzAm4biK6ArJarUaSXt+Qwvo
 Ev9MRn2GgZykHUgG5KT+zC9eOKFoTUWVOggnLF3oZMEJ6kwNcLUpcnvM3BYUmTx/SPjs
 lZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254142; x=1699858942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qb5wT872vgkkQeZLcaPPTqHv9wq2aCmdY3hodAPUnI=;
 b=EiCjKQSpI7mkbPb4mc/m84smZ0975MUfUDAJq+u1pu/kfzOu/j7kTuwtHWyLuscNnn
 NSH+x/dnFFj01WPqmRITk2kLrGzbEtWbS6KME4Geo23HTi9VAOsDPyLs651ntm/K4wE+
 c6RLfgGoQxhKx0wR1SYeALXyQz0z7iClf+/Xe6pD1bxymWJ9aKOjsL91H3F9JuNffWd4
 ZI0+TK+n63QGrKseigvdBKdQkjCWkIoWQ/WXdztukXw+kzCUG2epH8qj1afoHgZXzNMO
 b7Eqk5JvjT0OjJAMS8EMEiKiP9I/2ai40vKuJp1CgvaokTwHPGerI0hpVgoDRZ9/yxcT
 RLOQ==
X-Gm-Message-State: AOJu0YxTyZ6qKIzAx+dfxSXMLKgrKNQMMX7LEeE0Mt1BgMV2QEv/ek78
 wzIIybGY9X+Ju0SxlrypGQMHtDzNBBepAZaSgbg=
X-Google-Smtp-Source: AGHT+IH1C3pw1tDC9XZWZ01U++BOxOvNDfdm7OAf/ezzicCOmt0ZhldO1yCKFqnKrQJs9NWSZ8pohw==
X-Received: by 2002:a05:6a20:daaa:b0:181:a5a7:291d with SMTP id
 iy42-20020a056a20daaa00b00181a5a7291dmr12622865pzb.6.1699254142249; 
 Sun, 05 Nov 2023 23:02:22 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 62/71] hw/misc/macio: Constify VMState
Date: Sun,  5 Nov 2023 22:58:18 -0800
Message-Id: <20231106065827.543129-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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


