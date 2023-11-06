Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 369CF7E1ACE
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:11:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztdl-0001RZ-W6; Mon, 06 Nov 2023 02:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd1-0000cQ-4s
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:32 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcp-0001zk-IR
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:26 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-27ff7fe7fbcso3818714a91.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254133; x=1699858933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+Nu0pFkUhooXTXvaItjSl51/axbBnM72tzErMTLic8=;
 b=xqVNFeQ80WhUlQf0VLVRWiXg8W/TPej5o0nCCgqFlINgImfrvVX3Zj2aypN9h+hR27
 4uNYSo00YnFBG8b6GLp/AGwLCG9TBYNlKpyL+YW9S0cX4p0CXlXEp2Hbdqg9FQIB7QaO
 eJsiupoVevz+uQTxWY9gaSNsxP8v7cpZZvj2u5B7wEDPXPujtjDuvLJ4uMzdZSh2+AqN
 4qEYKbz4zMzgsHgLF6Hxt9+thiVFjvw+jbsU6S3Xtzjrw/4lVkISJ7Vv7Wk7zJ6HZc4T
 O2FyjtuyqbVAGebYWyemMkfk3DvAfXKOnp9nlCZ/5/lr/JRTi0hGyAHj+UuqiWTxuC2c
 NrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254133; x=1699858933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+Nu0pFkUhooXTXvaItjSl51/axbBnM72tzErMTLic8=;
 b=ugXBczn8Oiie9xtZbrwDYXbgwzExbCxil2W/1U3kL9gz7/POLQ6lvJsrgA/0B7dxnI
 tlNpolCupBkcNA3IDWQl529eV3kvSlx7vZ4/7tNgfjdKcDL2xQcWgz/L3yIJEYIT7MYI
 CxeWRy4AVyTEjCM21cjN7ILdW8ZeaNz4LI+TDkK6NxL8jMXR1dkunpS3332h5fGs6fWC
 moJoecs5QDKFhWs+OOV/Fu8HwUpBSafCRZxwIW/6L/c5Fik0eEweYnOqUoMImdNUSXtK
 /wie/9uQlnWzyRnAonM4zHpwgCaafFyUewdEu91xcH4n7avJadcmGYmNeaz0amX+2vSg
 4RVA==
X-Gm-Message-State: AOJu0YyccaVX5fENDpsra34h8yoNkhvLrveImQy9MA0CZh617bWfBUpC
 qwtGaRE/3OR7ztst5nm/Iq3BQ9JtFsnY7VlpFk8=
X-Google-Smtp-Source: AGHT+IFCPI1mMT3dMuO7izTP9b1VKK4pCkKvJCiZUBBXRNIotofbsogODHlBrqsuNbaPHT7cwxv78Q==
X-Received: by 2002:a17:90a:28f:b0:280:1d67:16a6 with SMTP id
 w15-20020a17090a028f00b002801d6716a6mr23968240pja.34.1699254132969; 
 Sun, 05 Nov 2023 23:02:12 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 50/71] hw/s390x: Constify VMState
Date: Sun,  5 Nov 2023 22:58:06 -0800
Message-Id: <20231106065827.543129-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
 hw/s390x/ccw-device.c     |  2 +-
 hw/s390x/css.c            | 36 ++++++++++++++++++------------------
 hw/s390x/event-facility.c |  8 ++++----
 hw/s390x/ipl.c            |  8 ++++----
 hw/s390x/sclpquiesce.c    |  2 +-
 hw/s390x/virtio-ccw.c     |  4 ++--
 6 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 95f269ab44..fb8c1acc64 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -66,7 +66,7 @@ const VMStateDescription vmstate_ccw_dev = {
     .name = "s390_ccw_dev",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_POINTER(sch, CcwDevice, vmstate_subch_dev, SubchDev),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 95d1b3a3ce..e7119f7fb2 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -32,7 +32,7 @@ static const VMStateDescription vmstate_crw = {
     .name = "s390_crw",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(flags, CRW),
         VMSTATE_UINT16(rsid, CRW),
         VMSTATE_END_OF_LIST()
@@ -43,7 +43,7 @@ static const VMStateDescription vmstate_crw_container = {
     .name = "s390_crw_container",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(crw, CrwContainer, 0, vmstate_crw, CRW),
         VMSTATE_END_OF_LIST()
     },
@@ -59,7 +59,7 @@ static const VMStateDescription vmstate_chp_info = {
     .name = "s390_chp_info",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(in_use, ChpInfo),
         VMSTATE_UINT8(type, ChpInfo),
         VMSTATE_UINT8(is_virtual, ChpInfo),
@@ -77,7 +77,7 @@ static const VMStateDescription vmstate_scsw = {
     .name = "s390_scsw",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(flags, SCSW),
         VMSTATE_UINT16(ctrl, SCSW),
         VMSTATE_UINT32(cpa, SCSW),
@@ -92,7 +92,7 @@ static const VMStateDescription vmstate_pmcw = {
     .name = "s390_pmcw",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(intparm, PMCW),
         VMSTATE_UINT16(flags, PMCW),
         VMSTATE_UINT16(devno, PMCW),
@@ -113,7 +113,7 @@ static const VMStateDescription vmstate_schib = {
     .name = "s390_schib",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(pmcw, SCHIB, 0, vmstate_pmcw, PMCW),
         VMSTATE_STRUCT(scsw, SCHIB, 0, vmstate_scsw, SCSW),
         VMSTATE_UINT64(mba, SCHIB),
@@ -127,7 +127,7 @@ static const VMStateDescription vmstate_ccw1 = {
     .name = "s390_ccw1",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(cmd_code, CCW1),
         VMSTATE_UINT8(flags, CCW1),
         VMSTATE_UINT16(count, CCW1),
@@ -140,7 +140,7 @@ static const VMStateDescription vmstate_ciw = {
     .name = "s390_ciw",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(type, CIW),
         VMSTATE_UINT8(command, CIW),
         VMSTATE_UINT16(count, CIW),
@@ -152,7 +152,7 @@ static const VMStateDescription vmstate_sense_id = {
     .name = "s390_sense_id",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(reserved, SenseId),
         VMSTATE_UINT16(cu_type, SenseId),
         VMSTATE_UINT8(cu_model, SenseId),
@@ -168,7 +168,7 @@ static const VMStateDescription vmstate_orb = {
     .name = "s390_orb",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(intparm, ORB),
         VMSTATE_UINT16(ctrl0, ORB),
         VMSTATE_UINT8(lpm, ORB),
@@ -188,7 +188,7 @@ static const VMStateDescription vmstate_schdev_orb = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmstate_schdev_orb_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(orb, SubchDev, 1, vmstate_orb, ORB),
         VMSTATE_END_OF_LIST()
     }
@@ -207,7 +207,7 @@ const VMStateDescription vmstate_subch_dev = {
     .minimum_version_id = 1,
     .post_load = subch_dev_post_load,
     .pre_save = subch_dev_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_EQUAL(cssid, SubchDev, "Bug!"),
         VMSTATE_UINT8_EQUAL(ssid, SubchDev, "Bug!"),
         VMSTATE_UINT16(migrated_schid, SubchDev),
@@ -223,7 +223,7 @@ const VMStateDescription vmstate_subch_dev = {
         VMSTATE_UINT8(ccw_no_data_cnt, SubchDev),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_schdev_orb,
         NULL
     }
@@ -264,12 +264,12 @@ static int pre_save_ind_addr(void *opaque)
     return 0;
 }
 
-const VMStateDescription vmstate_ind_addr_tmp = {
+static const VMStateDescription vmstate_ind_addr_tmp = {
     .name = "s390_ind_addr_tmp",
     .pre_save = pre_save_ind_addr,
     .post_load = post_load_ind_addr,
 
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(len, IndAddrPtrTmp),
         VMSTATE_UINT64(addr, IndAddrPtrTmp),
         VMSTATE_END_OF_LIST()
@@ -278,7 +278,7 @@ const VMStateDescription vmstate_ind_addr_tmp = {
 
 const VMStateDescription vmstate_ind_addr = {
     .name = "s390_ind_addr_tmp",
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_WITH_TMP(IndAddr*, IndAddrPtrTmp, vmstate_ind_addr_tmp),
         VMSTATE_END_OF_LIST()
     }
@@ -293,7 +293,7 @@ static const VMStateDescription vmstate_css_img = {
     .name = "s390_css_img",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /* Subchannel sets have no relevant state. */
         VMSTATE_STRUCT_ARRAY(chpids, CssImage, MAX_CHPID + 1, 0,
                              vmstate_chp_info, ChpInfo),
@@ -330,7 +330,7 @@ static const VMStateDescription vmstate_css = {
     .name = "s390_css",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_QTAILQ_V(pending_crws, ChannelSubSys, 1, vmstate_crw_container,
                          CrwContainer, sibling),
         VMSTATE_BOOL(sei_pending, ChannelSubSys),
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 6891e3cd73..f9829de953 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -367,7 +367,7 @@ static const VMStateDescription vmstate_event_facility_mask64 = {
     .version_id = 0,
     .minimum_version_id = 0,
     .needed = vmstate_event_facility_mask64_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(receive_mask_pieces[RECV_MASK_LOWER], SCLPEventFacility),
         VMSTATE_END_OF_LIST()
      }
@@ -378,7 +378,7 @@ static const VMStateDescription vmstate_event_facility_mask_length = {
     .version_id = 0,
     .minimum_version_id = 0,
     .needed = vmstate_event_facility_mask_length_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(mask_length, SCLPEventFacility),
         VMSTATE_END_OF_LIST()
      }
@@ -388,11 +388,11 @@ static const VMStateDescription vmstate_event_facility = {
     .name = "vmstate-event-facility",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(receive_mask_pieces[RECV_MASK_UPPER], SCLPEventFacility),
         VMSTATE_END_OF_LIST()
      },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_event_facility_mask64,
         &vmstate_event_facility_mask_length,
         NULL
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 515dcf51b5..63fa6b0a7a 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -60,7 +60,7 @@ static const VMStateDescription vmstate_iplb_extended = {
     .version_id = 0,
     .minimum_version_id = 0,
     .needed = iplb_extended_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(reserved_ext, IplParameterBlock, 4096 - 200),
         VMSTATE_END_OF_LIST()
     }
@@ -70,13 +70,13 @@ static const VMStateDescription vmstate_iplb = {
     .name = "ipl/iplb",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(reserved1, IplParameterBlock, 110),
         VMSTATE_UINT16(devno, IplParameterBlock),
         VMSTATE_UINT8_ARRAY(reserved2, IplParameterBlock, 88),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_iplb_extended,
         NULL
     }
@@ -86,7 +86,7 @@ static const VMStateDescription vmstate_ipl = {
     .name = "ipl",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(compat_start_addr, S390IPLState),
         VMSTATE_UINT64(compat_bios_start_addr, S390IPLState),
         VMSTATE_STRUCT(iplb, S390IPLState, 0, vmstate_iplb, IplParameterBlock),
diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
index a641089929..14936aa94b 100644
--- a/hw/s390x/sclpquiesce.c
+++ b/hw/s390x/sclpquiesce.c
@@ -72,7 +72,7 @@ static const VMStateDescription vmstate_sclpquiesce = {
     .name = TYPE_SCLP_QUIESCE,
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(event_pending, SCLPEvent),
         VMSTATE_END_OF_LIST()
      }
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 80453718a3..b4676909dd 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -87,7 +87,7 @@ const VMStateDescription vmstate_virtio_ccw_dev_tmp = {
     .name = "s390_virtio_ccw_dev_tmp",
     .pre_save = virtio_ccw_dev_tmp_pre_save,
     .post_load = virtio_ccw_dev_tmp_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(config_vector, VirtioCcwDeviceTmp),
         VMSTATE_END_OF_LIST()
     }
@@ -98,7 +98,7 @@ const VMStateDescription vmstate_virtio_ccw_dev = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = virtio_ccw_dev_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CCW_DEVICE(parent_obj, VirtioCcwDevice),
         VMSTATE_PTR_TO_IND_ADDR(indicators, VirtioCcwDevice),
         VMSTATE_PTR_TO_IND_ADDR(indicators2, VirtioCcwDevice),
-- 
2.34.1


