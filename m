Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5AF7E1AAF
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:05:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzta6-0005HR-4x; Mon, 06 Nov 2023 01:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZW-0004XM-KX
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:54 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZT-0001QM-IO
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:54 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc30bf9e22so32847245ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253930; x=1699858730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9DLrTalTcJndhqqHcqb+nLiTVX9/SlM1pEgjvYTilk=;
 b=KATRN1nWW7isQQKe09KIZ7NUhdZ0urBnalx8MpwY4pBKmyZ+zA/K+ObtvC/WJLgrW5
 4EhhLKar2zdZLzSXJtiZUuQxB3EMrBgGkv1vLPjkSvhHv2aOYrBE77A0jKzqZgYdxP2m
 ZmEpI0TvZgqvBmprBHGmb2hhnbZtsgCr9uTFBc17Bt5Xz+rLhlZFEOegxMP5nOKoHNwf
 DJbDoOcbQFOWDU0XyxQ00f+kuSlqrGYhlpHke0KW27cqaSFv3okS+n42a0J6ZZORaFjQ
 ZbTdH2isu0EO0WZMccQfK7nY03pjXMIbnouJilTSzhYyBEBLDQ/FDHIA5l/BNVaCzh3h
 vJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253930; x=1699858730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9DLrTalTcJndhqqHcqb+nLiTVX9/SlM1pEgjvYTilk=;
 b=gWaZfuFT2bInX9SYK5yXHL/cwlTxjzRq/mZVQmrpndhFw3c6IyTx4sr7IfgUyY+K6w
 1cqXjYeYxQHAFF/4p4NRJMdqpKf5OukHSea3Avuhn3bPpbCYvfAbQB9aZCILN62HaHmF
 RR7GeMb8ba/dFJm9VdD+wgxcpvu9l/WNXgZt7zz2eVX7UvKSCEgEJtW/FsuawUQ3c/2u
 XVwf13yCdbWclVb09jbREvI/VsLU2MC56c4qZbjML1BsKjvQnZAg6rDE2dM3zRiqwKAo
 yZpgTrncQPM8JMIjX1VkxwtVBuJ8IFM4l30n7M/Oot2dQ1RksItVE6Ai2WaKB9QXq8KW
 nh4g==
X-Gm-Message-State: AOJu0YxZCGnYpj4KesQiJ8H0v99eTmT7YrnyDZEXwBRlv1C19ujMu4Ku
 SWvTSF26SYlRM6G1/bN7dKGvY5Yog7JseJtm7Uo=
X-Google-Smtp-Source: AGHT+IHzcjPtvl+6HR7dJkQj5PZUUb9sGyR8lyqMdsue1iJkKourFXm1hAEFS8GqK/ZDSGXJ+JrqvQ==
X-Received: by 2002:a17:902:c412:b0:1cc:5ce4:f64b with SMTP id
 k18-20020a170902c41200b001cc5ce4f64bmr14349756plk.8.1699253929947; 
 Sun, 05 Nov 2023 22:58:49 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 24/71] hw/block: Constify VMState
Date: Sun,  5 Nov 2023 22:57:40 -0800
Message-Id: <20231106065827.543129-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
index 818b833108..9aca975245 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -556,7 +556,7 @@ static const VMStateDescription vmstate_vhost_user_blk = {
     .name = "vhost-user-blk",
     .minimum_version_id = 1,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index a1f8e15522..a73a834d71 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1698,7 +1698,7 @@ static const VMStateDescription vmstate_virtio_blk = {
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


