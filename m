Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE2F8201AE
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:28:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLw-0000U2-Lq; Fri, 29 Dec 2023 16:25:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLt-0000Bw-H9
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:09 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLr-0007Vy-9J
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:09 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35fb96f3404so39393165ab.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885106; x=1704489906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wia1mwDSmhvHBc7XK8M+uSpbG5o3R0nD6ejibX0WzAE=;
 b=ZZ62eRgUm0vTsK1pJZF8eaS4j+I4HCQPSCumTb6kBcuNfAAX3bZr928TCHi5IMZNfN
 RCCqdNv4YL36a6fz2bcKmVEh1pZWdNtHTich7L965arfx7ZGP39l05sPucN1iXpJYfU0
 YwDyI5eXLTGTDjs/GmoXCjpuVpfgA9NUGXHOZGzLE/zDyua1KLP5PboeErCSfAQr6hRY
 lCBIFCs8+HLpTdguWPWFaOGspvjxPzAlbn4iGvCVgBzQm/ec7VyeoGj87MB/Zc6Yx4hD
 z+6uMf8lThenalJS2KEhXyztMo6AsX9eSyYr+QrpwQ0PkSjOGyg7ThRFUOf6UnHtSK86
 qNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885106; x=1704489906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wia1mwDSmhvHBc7XK8M+uSpbG5o3R0nD6ejibX0WzAE=;
 b=Ol4KgqG3bAEAUFHso9RS86l18uXTd3TMms23e1zwku0ovGdLW2EN5xphLW/tEsftsx
 Ux6NkZEm1ndFGtJJG85KI2voce2EI3lFweD4FZy4Z6soTcr7fla2/jI8Egc/3iu7CVdp
 fCmtnyU4LK8Rw8VNXOCJzXqmBELzy2BiTdKj5x6N08k4lC3lgAOG9n3/yhhF1vuJEKgq
 p/dc2Xx7h/WraTB7Y38M2ENhIH1hOGnaIKJVkzd+FOK5nrU/Z7DQCEzAVpg3zxY+/n59
 FkGsbZQmm1SF/PNFMQETbzHcHf0Jv+T4cI2iVUr3c9RAcNow8WPHKP6AqlAkTwySQ3wV
 ETtw==
X-Gm-Message-State: AOJu0Yylm6uDuBiyUHGnM91BnWmg+96tGQZjGXTCVXCvVahRBR9boENk
 doLy/a9oDozK34MHz0cb6JJ4nQMt+4K073xYfneG3YtObMK8Yg==
X-Google-Smtp-Source: AGHT+IGmZTqtRYuznCgsykxdrib7SXxotSBydE0RUC270ce5Z2FFf+wdQkywT+sEszJt7SS75Haxqg==
X-Received: by 2002:a05:6e02:180e:b0:35f:e1c5:b13c with SMTP id
 a14-20020a056e02180e00b0035fe1c5b13cmr22522749ilv.45.1703885106028; 
 Fri, 29 Dec 2023 13:25:06 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:25:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 31/71] hw/i386: Constify VMState
Date: Sat, 30 Dec 2023 08:23:06 +1100
Message-Id: <20231229212346.147149-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x133.google.com
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20231221031652.119827-32-richard.henderson@linaro.org>
---
 hw/i386/acpi-build.c       | 2 +-
 hw/i386/intel_iommu.c      | 2 +-
 hw/i386/kvm/clock.c        | 6 +++---
 hw/i386/kvm/xen_evtchn.c   | 4 ++--
 hw/i386/kvm/xen_gnttab.c   | 2 +-
 hw/i386/kvm/xen_overlay.c  | 2 +-
 hw/i386/kvm/xen_xenstore.c | 2 +-
 hw/i386/kvmvapic.c         | 6 +++---
 hw/i386/port92.c           | 2 +-
 hw/i386/vmmouse.c          | 2 +-
 hw/i386/xen/xen_platform.c | 2 +-
 hw/i386/xen/xen_pvdevice.c | 2 +-
 12 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 80db183b78..edc979379c 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2770,7 +2770,7 @@ static const VMStateDescription vmstate_acpi_build = {
     .name = "acpi_build",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(patched, AcpiBuildState),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5085a6fee3..ed5677c0ae 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3289,7 +3289,7 @@ static const VMStateDescription vtd_vmstate = {
     .minimum_version_id = 1,
     .priority = MIG_PRI_IOMMU,
     .post_load = vtd_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(root, IntelIOMMUState),
         VMSTATE_UINT64(intr_root, IntelIOMMUState),
         VMSTATE_UINT64(iq, IntelIOMMUState),
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index e756b0aa43..40aa9a32c3 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -245,7 +245,7 @@ static const VMStateDescription kvmclock_reliable_get_clock = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = kvmclock_clock_is_reliable_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(clock_is_reliable, KVMClockState),
         VMSTATE_END_OF_LIST()
     }
@@ -295,11 +295,11 @@ static const VMStateDescription kvmclock_vmsd = {
     .minimum_version_id = 1,
     .pre_load = kvmclock_pre_load,
     .pre_save = kvmclock_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(clock, KVMClockState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &kvmclock_reliable_get_clock,
         NULL
     }
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 02b8cbf8df..9a5f3caa24 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -240,7 +240,7 @@ static const VMStateDescription xen_evtchn_port_vmstate = {
     .name = "xen_evtchn_port",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(vcpu, XenEvtchnPort),
         VMSTATE_UINT16(type, XenEvtchnPort),
         VMSTATE_UINT16(u.val, XenEvtchnPort),
@@ -255,7 +255,7 @@ static const VMStateDescription xen_evtchn_vmstate = {
     .needed = xen_evtchn_is_needed,
     .pre_load = xen_evtchn_pre_load,
     .post_load = xen_evtchn_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(callback_param, XenEvtchnState),
         VMSTATE_UINT32(nr_ports, XenEvtchnState),
         VMSTATE_STRUCT_VARRAY_UINT32(port_table, XenEvtchnState, nr_ports, 1,
diff --git a/hw/i386/kvm/xen_gnttab.c b/hw/i386/kvm/xen_gnttab.c
index 0a24f53f20..a0cc30f619 100644
--- a/hw/i386/kvm/xen_gnttab.c
+++ b/hw/i386/kvm/xen_gnttab.c
@@ -127,7 +127,7 @@ static const VMStateDescription xen_gnttab_vmstate = {
     .minimum_version_id = 1,
     .needed = xen_gnttab_is_needed,
     .post_load = xen_gnttab_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(nr_frames, XenGnttabState),
         VMSTATE_VARRAY_UINT32(gnt_frame_gpas, XenGnttabState, nr_frames, 0,
                               vmstate_info_uint64, uint64_t),
diff --git a/hw/i386/kvm/xen_overlay.c b/hw/i386/kvm/xen_overlay.c
index 39fda1b72c..526f7a6077 100644
--- a/hw/i386/kvm/xen_overlay.c
+++ b/hw/i386/kvm/xen_overlay.c
@@ -139,7 +139,7 @@ static const VMStateDescription xen_overlay_vmstate = {
     .needed = xen_overlay_is_needed,
     .pre_save = xen_overlay_pre_save,
     .post_load = xen_overlay_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(shinfo_gpa, XenOverlayState),
         VMSTATE_BOOL(long_mode, XenOverlayState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 6e651960b3..c3633f7829 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -243,7 +243,7 @@ static const VMStateDescription xen_xenstore_vmstate = {
     .needed = xen_xenstore_is_needed,
     .pre_save = xen_xenstore_pre_save,
     .post_load = xen_xenstore_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(req_data, XenXenstoreState,
                             sizeof_field(XenXenstoreState, req_data)),
         VMSTATE_UINT8_ARRAY(rsp_data, XenXenstoreState,
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 43f8a8f679..f2b0aff479 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -802,7 +802,7 @@ static const VMStateDescription vmstate_handlers = {
     .name = "kvmvapic-handlers",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(set_tpr, VAPICHandlers),
         VMSTATE_UINT32(set_tpr_eax, VAPICHandlers),
         VMSTATE_UINT32_ARRAY(get_tpr, VAPICHandlers, 8),
@@ -815,7 +815,7 @@ static const VMStateDescription vmstate_guest_rom = {
     .name = "kvmvapic-guest-rom",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UNUSED(8),     /* signature */
         VMSTATE_UINT32(vaddr, GuestROMState),
         VMSTATE_UINT32(fixup_start, GuestROMState),
@@ -835,7 +835,7 @@ static const VMStateDescription vmstate_vapic = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = vapic_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(rom_state, VAPICROMState, 0, vmstate_guest_rom,
                        GuestROMState),
         VMSTATE_UINT32(state, VAPICROMState),
diff --git a/hw/i386/port92.c b/hw/i386/port92.c
index e1379a4f98..1070bfbf36 100644
--- a/hw/i386/port92.c
+++ b/hw/i386/port92.c
@@ -54,7 +54,7 @@ static const VMStateDescription vmstate_port92_isa = {
     .name = "port92",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(outport, Port92State),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 91320afa2f..a8d014d09a 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -277,7 +277,7 @@ static const VMStateDescription vmstate_vmmouse = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = vmmouse_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32_EQUAL(queue_size, VMMouseState, NULL),
         VMSTATE_UINT32_ARRAY(queue, VMMouseState, VMMOUSE_QUEUE_SIZE),
         VMSTATE_UINT16(nb_queue, VMMouseState),
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index ef7d3fc05f..708488af32 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -537,7 +537,7 @@ static const VMStateDescription vmstate_xen_platform = {
     .version_id = 4,
     .minimum_version_id = 4,
     .post_load = xen_platform_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCIXenPlatformState),
         VMSTATE_UINT8(flags, PCIXenPlatformState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index e62e06622b..ed621531d8 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -77,7 +77,7 @@ static const VMStateDescription vmstate_xen_pvdevice = {
     .name = "xen-pvdevice",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, XenPVDevice),
         VMSTATE_END_OF_LIST()
     }
-- 
2.34.1


