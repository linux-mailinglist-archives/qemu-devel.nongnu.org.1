Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C6D81AD55
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:24:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9eq-000831-Au; Wed, 20 Dec 2023 22:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9eo-0007oe-3H
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:34 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9em-0006z8-1B
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:33 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-67f0d22e4faso1789626d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129011; x=1703733811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gK5oTDGLtKYZ0K+fiWTbXWbg9VJWX0FjKrNmUIXbQg4=;
 b=dHK+6HdqanEQRmUpm/0R8x+q4WzQmdockJg8bRqiyNLTWRby3yfU02njIg3g2twpuX
 YOXzAO0bHh1eEZROyU8RCXpckRLNdUYZOo0xH/1D/BwXuOckTzyS0EdvLgN8QAWAT1yx
 fRErznWWIor66ZlkQjFwYmR3Rz3xI8bX3GBd9uFRNXnMa9ECWSeur6HDWw0cgoKq0Ht8
 WK+yhXs942LMaI9AsypMDFPFQ4xdml7fgeP1Lmr2hk2YX89kNLdVvxfEuzN1K66TUYv1
 hKsqkXsr75KOO5EUZGfZKrL6l5cRCfQVeBa3UehdaXR94wR3bF4clad+Sqh1adbFHseg
 qtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129011; x=1703733811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gK5oTDGLtKYZ0K+fiWTbXWbg9VJWX0FjKrNmUIXbQg4=;
 b=UvvVU869LuRecdJ4IRsxQGThclZItR9l38AP70EpC5Ni/dkGaUMrTSroZUKMRDA6X6
 hUnfDhGsgUp2ym8x7knsHkUWwYVC3Pl1a/y2N5VRSk3rHqAUetKwFpEu19IJjMemHdLL
 bg2XTCaKHFT2+TmAwi+yIj8DKBQe09czadRP2k6tAQgeZpqzzX3Kd9zIVCDcsuHax9Q1
 hk9wAEPM+5I492G7BaTG0q2QK2qlolC3S6pWRkk0w3jfAykpAoPhDKtO5N5XWxE6YI1x
 i4A3wvNcCYske8CI8YFRQbCoNLLm0EdCe8sduFLLw+I5SF3AMokcJ0w/ojvT+GzeG0oO
 bVoA==
X-Gm-Message-State: AOJu0Yy/9qNpOj5puV2x6htbTga5I39oSDJHLXF1l4mbdKhoOscIZ8+b
 PHSrEG8WO6KmYWe69U0OYJvN8vSILGOkwM7nH4antW5b
X-Google-Smtp-Source: AGHT+IG4sFUE2wlSl1w9Mdysn6z4+s7cVoja6KzlnEHcuyZo1lt74xaOAn1Red6C4OqhHMVOPeme4A==
X-Received: by 2002:a05:6214:2509:b0:67f:2b5:b96a with SMTP id
 gf9-20020a056214250900b0067f02b5b96amr20628447qvb.51.1703129011053; 
 Wed, 20 Dec 2023 19:23:31 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.23.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:23:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 50/71] hw/s390x: Constify VMState
Date: Thu, 21 Dec 2023 14:16:31 +1100
Message-Id: <20231221031652.119827-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2d.google.com
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
index bcedec2fc8..295530963a 100644
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
index 62182d81a0..76110e8f58 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -59,7 +59,7 @@ static const VMStateDescription vmstate_iplb_extended = {
     .version_id = 0,
     .minimum_version_id = 0,
     .needed = iplb_extended_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(reserved_ext, IplParameterBlock, 4096 - 200),
         VMSTATE_END_OF_LIST()
     }
@@ -69,13 +69,13 @@ static const VMStateDescription vmstate_iplb = {
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
@@ -85,7 +85,7 @@ static const VMStateDescription vmstate_ipl = {
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


