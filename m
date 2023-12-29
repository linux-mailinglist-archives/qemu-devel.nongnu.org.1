Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 962208201A7
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:27:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLm-0007mp-0x; Fri, 29 Dec 2023 16:25:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLj-0007bF-QZ
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:59 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLd-0006zS-DV
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:59 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso5217137a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885091; x=1704489891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=INy+429BuuQVoZsuJFK2Hhv1zxxE+m6svEuazNu+L7w=;
 b=mrYz5FiwZUwQ1aYgsYQFH240Q+4D9twZeYegx1qHATHHRhO5DiP3r1Od9tdJssFMop
 qIqdMNYEo+IqNUaIpiHb+sYmy7g0Lj85o5ZYoTZRoQ5/tIPNYBVUC5jmsxY6pP3cySrw
 V/9tbHX0exKQ8TKI74ym3gbjFmsmrMypWCObbSvJFmQ14jfK69gvy1nZfhhU6N+qLWC8
 MQi3upjRdJYnizMAaFHVsbMoQdfl84zhabouYzH6CeN8AxXQFPbwl4jf8V1dW6du63HQ
 O8IJSK11xtZnzZb1h9BhmFPxKokR2jbXaGqb+cx06lIOdpFrhnuIuErduh/khyeOkZZY
 YilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885091; x=1704489891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=INy+429BuuQVoZsuJFK2Hhv1zxxE+m6svEuazNu+L7w=;
 b=jPkbGeYIiKaqJ93hazIqqBdlz+F9aMqg0gWknoRupJ8YWnifYYtICGvxlgMU6yY0Kw
 FrQf/x2EKrIjm5hysEjbWyDwTox/HgDAAMUiT/01hkXt7GYsdnN3jYdIuOWLZDUnosN3
 /tACM03LxNRzEGDAUCCUPaD+ar1aFIT7FHKO1EqIE3tiaQMg0F52ddHpN3HHFhRo5Bmd
 saJNROPSIW9DhYGWJHSM4h7yu61DITJsuiUexICzY+gSQQYSkU2GBspvmJtc80KArjSO
 kFmMWoyhq4GaZJbmUOqnlfMWOrKRNimteB/lqYU/By28Dd28pdV70eo8Ecbpi1iwFk0P
 G/DA==
X-Gm-Message-State: AOJu0YyR1HCAoVqd1havcCnCmbshKvTPnPuMgaNd3OmNa2SshBpgC98z
 9oNpgdPu6KFokozpwPjGJt4Lvn5DDIgSIGYnpR40qmlLhO7c1Q==
X-Google-Smtp-Source: AGHT+IFRMeX11n+nELpUnm2KXQZb2no2sAFpZwalxSLHDTEQ4Ra73WWPnZLCSNPlaViPeOgAg6PPsw==
X-Received: by 2002:a05:6a21:78a5:b0:196:ac07:e18e with SMTP id
 bf37-20020a056a2178a500b00196ac07e18emr89785pzc.115.1703885090792; 
 Fri, 29 Dec 2023 13:24:50 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/71] hw/block: Constify VMState
Date: Sat, 30 Dec 2023 08:22:59 +1100
Message-Id: <20231229212346.147149-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Message-Id: <20231221031652.119827-25-richard.henderson@linaro.org>
---
 hw/block/ecc.c            |  2 +-
 hw/block/fdc-isa.c        |  2 +-
 hw/block/fdc-sysbus.c     |  2 +-
 hw/block/fdc.c            | 20 ++++++++++----------
 hw/block/m25p80.c         | 12 ++++++------
 hw/block/nand.c           |  2 +-
 hw/block/onenand.c        |  2 +-
 hw/block/pflash_cfi01.c   |  2 +-
 hw/block/swim.c           |  6 +++---
 hw/block/vhost-user-blk.c |  2 +-
 hw/block/virtio-blk.c     |  2 +-
 11 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/hw/block/ecc.c b/hw/block/ecc.c
index 6e0d63842c..ed889a4184 100644
--- a/hw/block/ecc.c
+++ b/hw/block/ecc.c
@@ -82,7 +82,7 @@ const VMStateDescription vmstate_ecc_state = {
     .name = "ecc-state",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(cp, ECCState),
         VMSTATE_UINT16_ARRAY(lp, ECCState, 2),
         VMSTATE_UINT16(count, ECCState),
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 7ec075e470..ad0921c7d3 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -259,7 +259,7 @@ static const VMStateDescription vmstate_isa_fdc = {
     .name = "fdc",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(state, FDCtrlISABus, 0, vmstate_fdc, FDCtrl),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/block/fdc-sysbus.c b/hw/block/fdc-sysbus.c
index 86ea51d003..266bc4d145 100644
--- a/hw/block/fdc-sysbus.c
+++ b/hw/block/fdc-sysbus.c
@@ -168,7 +168,7 @@ static const VMStateDescription vmstate_sysbus_fdc = {
     .name = "fdc",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(state, FDCtrlSysBus, 0, vmstate_fdc, FDCtrl),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index d7cc4d3ec1..6dd94e98bc 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -854,7 +854,7 @@ static const VMStateDescription vmstate_fdrive_media_changed = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = fdrive_media_changed_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(media_changed, FDrive),
         VMSTATE_END_OF_LIST()
     }
@@ -864,7 +864,7 @@ static const VMStateDescription vmstate_fdrive_media_rate = {
     .name = "fdrive/media_rate",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(media_rate, FDrive),
         VMSTATE_END_OF_LIST()
     }
@@ -882,7 +882,7 @@ static const VMStateDescription vmstate_fdrive_perpendicular = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = fdrive_perpendicular_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(perpendicular, FDrive),
         VMSTATE_END_OF_LIST()
     }
@@ -899,13 +899,13 @@ static const VMStateDescription vmstate_fdrive = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = fdrive_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(head, FDrive),
         VMSTATE_UINT8(track, FDrive),
         VMSTATE_UINT8(sect, FDrive),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_fdrive_media_changed,
         &vmstate_fdrive_media_rate,
         &vmstate_fdrive_perpendicular,
@@ -977,7 +977,7 @@ static const VMStateDescription vmstate_fdc_reset_sensei = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = fdc_reset_sensei_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(reset_sensei, FDCtrl),
         VMSTATE_END_OF_LIST()
     }
@@ -995,7 +995,7 @@ static const VMStateDescription vmstate_fdc_result_timer = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = fdc_result_timer_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_PTR(result_timer, FDCtrl),
         VMSTATE_END_OF_LIST()
     }
@@ -1013,7 +1013,7 @@ static const VMStateDescription vmstate_fdc_phase = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = fdc_phase_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(phase, FDCtrl),
         VMSTATE_END_OF_LIST()
     }
@@ -1026,7 +1026,7 @@ const VMStateDescription vmstate_fdc = {
     .pre_save = fdc_pre_save,
     .pre_load = fdc_pre_load,
     .post_load = fdc_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /* Controller State */
         VMSTATE_UINT8(sra, FDCtrl),
         VMSTATE_UINT8(srb, FDCtrl),
@@ -1057,7 +1057,7 @@ const VMStateDescription vmstate_fdc = {
                              vmstate_fdrive, FDrive),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_fdc_reset_sensei,
         &vmstate_fdc_result_timer,
         &vmstate_fdc_phase,
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index afc3fdf4d6..26ce895628 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1684,7 +1684,7 @@ static const VMStateDescription vmstate_m25p80_data_read_loop = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = m25p80_data_read_loop_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(data_read_loop, Flash),
         VMSTATE_END_OF_LIST()
     }
@@ -1702,7 +1702,7 @@ static const VMStateDescription vmstate_m25p80_aai_enable = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = m25p80_aai_enable_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(aai_enable, Flash),
         VMSTATE_END_OF_LIST()
     }
@@ -1720,7 +1720,7 @@ static const VMStateDescription vmstate_m25p80_write_protect = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = m25p80_wp_level_srwd_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(wp_level, Flash),
         VMSTATE_BOOL(status_register_write_disabled, Flash),
         VMSTATE_END_OF_LIST()
@@ -1743,7 +1743,7 @@ static const VMStateDescription vmstate_m25p80_block_protect = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = m25p80_block_protect_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(block_protect0, Flash),
         VMSTATE_BOOL(block_protect1, Flash),
         VMSTATE_BOOL(block_protect2, Flash),
@@ -1759,7 +1759,7 @@ static const VMStateDescription vmstate_m25p80 = {
     .minimum_version_id = 0,
     .pre_save = m25p80_pre_save,
     .pre_load = m25p80_pre_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(state, Flash),
         VMSTATE_UINT8_ARRAY(data, Flash, M25P80_INTERNAL_DATA_BUFFER_SZ),
         VMSTATE_UINT32(len, Flash),
@@ -1781,7 +1781,7 @@ static const VMStateDescription vmstate_m25p80 = {
         VMSTATE_UINT8(spansion_cr4nv, Flash),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_m25p80_data_read_loop,
         &vmstate_m25p80_aai_enable,
         &vmstate_m25p80_write_protect,
diff --git a/hw/block/nand.c b/hw/block/nand.c
index 9c1b89cfa6..d1435f2207 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -345,7 +345,7 @@ static const VMStateDescription vmstate_nand = {
     .minimum_version_id = 1,
     .pre_save = nand_pre_save,
     .post_load = nand_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(cle, NANDFlashState),
         VMSTATE_UINT8(ale, NANDFlashState),
         VMSTATE_UINT8(ce, NANDFlashState),
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 50d3d1c985..d8a6944027 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -179,7 +179,7 @@ static const VMStateDescription vmstate_onenand = {
     .minimum_version_id = 1,
     .pre_save = onenand_pre_save,
     .post_load = onenand_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(current_direction, OneNANDState),
         VMSTATE_INT32(cycle, OneNANDState),
         VMSTATE_INT32(otpmode, OneNANDState),
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 62056b1d74..3e2dc08bd7 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -95,7 +95,7 @@ static const VMStateDescription vmstate_pflash = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = pflash_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(wcycle, PFlashCFI01),
         VMSTATE_UINT8(cmd, PFlashCFI01),
         VMSTATE_UINT8(status, PFlashCFI01),
diff --git a/hw/block/swim.c b/hw/block/swim.c
index fd65c59f8a..44761c11cb 100644
--- a/hw/block/swim.c
+++ b/hw/block/swim.c
@@ -516,7 +516,7 @@ static const VMStateDescription vmstate_fdrive = {
     .name = "fdrive",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_END_OF_LIST()
     },
 };
@@ -525,7 +525,7 @@ static const VMStateDescription vmstate_swim = {
     .name = "swim",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(mode, SWIMCtrl),
         /* IWM mode */
         VMSTATE_INT32(iwm_switch, SWIMCtrl),
@@ -545,7 +545,7 @@ static const VMStateDescription vmstate_swim = {
 static const VMStateDescription vmstate_sysbus_swim = {
     .name = "SWIM",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(ctrl, Swim, 0, vmstate_swim, SWIMCtrl),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 2863d80d15..6a856ad51a 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -554,7 +554,7 @@ static const VMStateDescription vmstate_vhost_user_blk = {
     .name = "vhost-user-blk",
     .minimum_version_id = 1,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 46e73b2c96..315b7b364c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1743,7 +1743,7 @@ static const VMStateDescription vmstate_virtio_blk = {
     .name = "virtio-blk",
     .minimum_version_id = 2,
     .version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1


