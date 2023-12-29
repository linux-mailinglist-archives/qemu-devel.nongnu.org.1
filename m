Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 684A58201E2
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:33:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKPa-00068l-QH; Fri, 29 Dec 2023 16:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPX-0005j0-C8
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:55 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPV-0000Lp-3u
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:55 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so2216034b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885332; x=1704490132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OqU6sg9g0ESWhn8ACzHLMCxFbvZWow6DbzojmlPanzM=;
 b=o7yW7E00YXeiSyNsUzcFSMpJ5M5fIPQ7FQN4gav5Wp8bxUT97piLO8nETifu/5TV9i
 SnN54R4genxiUc/LGyFyZJwSougcQTQsL6F0xnY8WVXLc0fONDxM6HG+Cn6X3ud7cFxy
 BAYZoDN8Ai8EfL+YJ0Irc/aF50C2SUoLn59G/6Vwt6SQjWtBY4//h3VVk8D7PQ2+7YKy
 BbkgVkrJT+N0FgICQrcGCnJ006Zcvkf4CipChOAHhLeK91sddLOEdOUThSfnPwxsrPxK
 j7OYozSZlorYsVAS81QUOqeXtI9b6w4BTisQCHytoCPOCjI87btvEiQn81gKhauLIFBO
 wvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885332; x=1704490132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OqU6sg9g0ESWhn8ACzHLMCxFbvZWow6DbzojmlPanzM=;
 b=fDP+n+m6MMoeA7gC0TjALfQIVBgGg6Z3g7e97EkYdhdN2SyddyOC16IFgemEqmkyUN
 lolh3aSdwJ8Q+uqFFv87AR/Ib/7/wM9ec9UGVG2KJS9TeZXUnHTMNR1J7XggAZfnCdoc
 8HDUbsoO5RAUadcQfFY4qMSqW/WjzmPIpopjPvD42DiK15ZOJVgJK3CSGilYmCmHWy7L
 Bvlvs1rW5IBMIF0hlCNFlYSmmEls6S17GizznH6OC2OUEuBjFzB11S3sWp+P6ye5c9Tz
 zxOwKrqp1O5+XlqmHAr4I8b4KR7s/ANWAHQQq0oojOjWgWhE9+L2M5RGAh6r1e8GmIzW
 7/Xg==
X-Gm-Message-State: AOJu0YzYmqCTBS9c5EwgcYtGYeX/vIPM3RelvqfCukbXlEAXlsrmP68j
 V3O7aLfMKcIQr1k1rpLNvsM1EA2YWVcbYAYxpgkSXzU27gQHqw==
X-Google-Smtp-Source: AGHT+IHQjzYwx78PPReg0DB+9MdFcHFrnrgYN/XVhFGAGSPh2OBoz91V7SjxAw7c/rhAbO9xeeQ+Zw==
X-Received: by 2002:a05:6a00:464a:b0:6d9:396d:730b with SMTP id
 kp10-20020a056a00464a00b006d9396d730bmr13614192pfb.27.1703885331738; 
 Fri, 29 Dec 2023 13:28:51 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.28.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:28:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/71] hw/s390x: Constify VMState
Date: Sat, 30 Dec 2023 08:23:25 +1100
Message-Id: <20231229212346.147149-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
Message-Id: <20231221031652.119827-51-richard.henderson@linaro.org>
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


