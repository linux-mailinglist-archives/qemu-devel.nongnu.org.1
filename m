Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFAD7E47E9
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:11:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QXF-0004aU-NK; Tue, 07 Nov 2023 13:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1r0QXC-0004Xb-7W
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:42 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1r0QWv-0002kQ-Ju
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:41 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6b2018a11efso6109427b3a.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699380622; x=1699985422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUVbPa2RXh5sULa717dlwLdK6nK0VOlZVO7MX7gSRww=;
 b=eKlNEv12fdPHqW6ll3fCfK7NwsPsfSa3Mx9o29w92D6MFUGqZ00xhRVDyzW7ho4IgM
 80imsGxcCWRWx/UsHdb8MiHPUQE6W8MDFZLx1OT1wMP3oWSBT+MwiaB+1ttg/1EC+rB0
 6jrEsKQfPr9t9hsL+md6nTnoFbpcdeCmkpx3y6XQryXAEno/GpPqUiPO90VRVl/I7LQW
 avc53sXtF84/0yHQqWt1q0TIN5cUJzVEsliBIRJihKr6hkeDlCC1oDCHYIxXc5QZ4O5U
 /qGP9eLquLLViTqNwdCKzkcUTa9HcJlnee+K9l8cYKR+bQH3KPtzw9LiRVeI9Q2D2eSi
 jHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380622; x=1699985422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nUVbPa2RXh5sULa717dlwLdK6nK0VOlZVO7MX7gSRww=;
 b=r3CFyOeAx4hK8w1IAEQJg5Jamzc7mQKyq1cmcvn9mkeoR2y2yCFWoOJPk62XQx5lJS
 IxMhUGFBLem7KOo/zQezEXYo5Aad47qJQRCZFCwwTk6I7jySwQgCBi+v/thKXu4S7BPL
 OFxe3D2ufMSVkdURpIKigYex/AvO0scBIlVpvempTRj7kIg442MoCShgA+e2dcEelKYk
 qWx+cHuTvPIa9dJSMgdhHJwrcZWGTrg0EKxz5PVkxUcAMhCCCzS+3wu+uKqqkPm7QCD5
 07vfUOsoS9QSC5EXdhp27fZwCX8m694BfxPVabKQxFtBdR2juw1Ra2PX5aSgfugnzW1E
 3aJw==
X-Gm-Message-State: AOJu0YxjHQJwWRloV/hQDHs9p+idW+3FSgLzws4EPG6BFJOnYpeG3WX1
 qT4l20MfClgWLNEs+tdtH9ODCUxqRgA=
X-Google-Smtp-Source: AGHT+IHbIav+SSkCelT+QQDr+/PZe04ppInU4J8uSOtgCzMCmlf2Dg5sNGz15p4xGCJORRfIXBtO/A==
X-Received: by 2002:a05:6a20:3d82:b0:16b:9886:7eda with SMTP id
 s2-20020a056a203d8200b0016b98867edamr38574558pzi.35.1699380622013; 
 Tue, 07 Nov 2023 10:10:22 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net.
 [71.202.158.162]) by smtp.gmail.com with ESMTPSA id
 az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:10:21 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v3 6/9] hw/mem/cxl_type3: Add DC extent list representative
 and get DC extent list mailbox support
Date: Tue,  7 Nov 2023 10:07:10 -0800
Message-ID: <20231107180907.553451-7-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107180907.553451-1-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Fan Ni <fan.ni@samsung.com>

Add dynamic capacity extent list representative to the definition of
CXLType3Dev and add get DC extent list mailbox command per
CXL.spec.3.0:.8.2.9.8.9.2.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 73 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h | 23 ++++++++++++
 3 files changed, 97 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1f512b3e6b..56f4aa237a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -82,6 +82,7 @@ enum {
         #define CLEAR_POISON           0x2
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
+        #define GET_DYN_CAP_EXT_LIST   0x1
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1286,6 +1287,75 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.0 section 8.2.9.8.9.2:
+ * Get Dynamic Capacity Extent List (Opcode 4810h)
+ */
+static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
+                                               uint8_t *payload_in,
+                                               size_t len_in,
+                                               uint8_t *payload_out,
+                                               size_t *len_out,
+                                               CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    struct get_dyn_cap_ext_list_in_pl {
+        uint32_t extent_cnt;
+        uint32_t start_extent_id;
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_ext_list_out_pl {
+        uint32_t count;
+        uint32_t total_extents;
+        uint32_t generation_num;
+        uint8_t rsvd[4];
+        CXLDCExtentRaw records[];
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_ext_list_in_pl *in = (void *)payload_in;
+    struct get_dyn_cap_ext_list_out_pl *out = (void *)payload_out;
+    uint16_t record_count = 0, i = 0, record_done = 0;
+    CXLDCDExtentList *extent_list = &ct3d->dc.extents;
+    CXLDCDExtent *ent;
+    uint16_t out_pl_len;
+    uint32_t start_extent_id = in->start_extent_id;
+
+    if (start_extent_id > ct3d->dc.total_extent_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.total_extent_count - start_extent_id);
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    /* May need more processing here in the future */
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    memset(out, 0, out_pl_len);
+    stl_le_p(&out->count, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (i++ < start_extent_id) {
+                continue;
+            }
+            stq_le_p(&out->records[record_done].start_dpa, ent->start_dpa);
+            stq_le_p(&out->records[record_done].len, ent->len);
+            memcpy(&out->records[record_done].tag, ent->tag, 0x10);
+            stw_le_p(&out->records[record_done].shared_seq, ent->shared_seq);
+            record_done++;
+            if (record_done == record_count) {
+                break;
+            }
+        }
+    }
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1333,6 +1403,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
     [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
         cmd_dcd_get_dyn_cap_config, 2, 0 },
+    [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
+        "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
+        8, 0 },
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 152a51306d..c9d792a725 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -811,6 +811,7 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
 
         region_base += region->len;
     }
+    QTAILQ_INIT(&ct3d->dc.extents);
 
     return 0;
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 3dc6928bc5..5738c6f434 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -420,6 +420,25 @@ typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 
 #define DCD_MAX_REGION_NUM 8
 
+typedef struct CXLDCDExtentRaw {
+    uint64_t start_dpa;
+    uint64_t len;
+    uint8_t tag[0x10];
+    uint16_t shared_seq;
+    uint8_t rsvd[0x6];
+} QEMU_PACKED CXLDCExtentRaw;
+
+typedef struct CXLDCDExtent {
+    uint64_t start_dpa;
+    uint64_t len;
+    uint8_t tag[0x10];
+    uint16_t shared_seq;
+    uint8_t rsvd[0x6];
+
+    QTAILQ_ENTRY(CXLDCDExtent) node;
+} CXLDCDExtent;
+typedef QTAILQ_HEAD(, CXLDCDExtent) CXLDCDExtentList;
+
 typedef struct CXLDCDRegion {
     uint64_t base;
     uint64_t decode_len; /* aligned to 256*MiB */
@@ -470,6 +489,10 @@ struct CXLType3Dev {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
         uint64_t total_capacity; /* 256M aligned */
+        CXLDCDExtentList extents;
+
+        uint32_t total_extent_count;
+        uint32_t ext_list_gen_seq;
 
         uint8_t num_regions; /* 0-8 regions */
         CXLDCDRegion regions[DCD_MAX_REGION_NUM];
-- 
2.42.0


