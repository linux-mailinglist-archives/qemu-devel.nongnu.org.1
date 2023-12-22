Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB7081C715
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 10:02:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGbP7-0005CO-ME; Fri, 22 Dec 2023 04:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1rGbP5-0005C1-SL
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:01:11 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1rGbP4-0002VN-58
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:01:11 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5cd86e3a9afso1137891a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 01:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703235669; x=1703840469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pze2Cv/T1AorC9TH3ggyhouTOliDmqm2cL056dpXiT8=;
 b=fCcmmmjXC3Ch8x+uAeGgSA0Jqtwc4oldQ3nAAilXa1EWBzuYreMEcieE9Ghl4lpjkE
 d3DjHVDrH2bRjJiqQM4UrHmypwQFHDy1B2lVD9rcgb6NtEulD1LMMLgO8hxLtMsJMte/
 +KOY1NvCsmeA6KBG2djJ/10ZI+f94Ys+Z/mXI4qSr6y7jSWkX6AFqW+Yar/+oM4RMAmd
 BvAmQQFzZ1SkW1nmPQa1zHZHQVD4tR2aONALr0IKB6ywYIhJqeoxcc/lMasO6JX6ZUBN
 sKePe+lDlRqs6b/vNY9lUxvh8l5NSB350oAi8wnK2CVNbkyFmlYwu45oRKmpV6Hl5YsU
 tvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703235669; x=1703840469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pze2Cv/T1AorC9TH3ggyhouTOliDmqm2cL056dpXiT8=;
 b=aWiJkoHalXT+ZSHh7w3AZxLNPcpF2AhUc8XjrxBrlsoM2qoZUJ5OXsz7sP66E+TZNz
 hCwHWhdjwQXrFa+fWVVlwq9UeqDiCG14pn9yGnG9cGHdySPDKqIf2dEuZ7FcrLMX4gnd
 GbIJPOA0FmKK0AV87AVC8NFCq/7xhvijw3WwzgT5nkVuKZ2MJzqL4nZR12uat7XZ3vJJ
 DfkV/8LG9NkvNE+K/EZhLF6emK4QS5ymTVo+qTKMlCM4ESlwVUOxo4i5qsCFrWEYoM3V
 skeAADfg4NR7bBnWFZvPabqDbLgUuD2iZckwbZmVYnnIrDExIfE7uZEcxVFNxKDVhs9M
 aBWQ==
X-Gm-Message-State: AOJu0YxmEUnViir6hUqSn+tdEUGTail2pNi21uM/nPF2koYzb8VQsgmh
 fiZwjlwDPgsekBJHyF7ceYQ=
X-Google-Smtp-Source: AGHT+IFugj/FMKrijP+kRxUM50nlGrQTcMl7Fd4knps99Pd2Lf7vMloX5ys0XXcnF4fFb4l4YI2U5g==
X-Received: by 2002:a05:6a20:8814:b0:194:ffaa:a2c3 with SMTP id
 c20-20020a056a20881400b00194ffaaa2c3mr966439pzf.1.1703235668571; 
 Fri, 22 Dec 2023 01:01:08 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a056a000b1700b006d990040342sm400560pfu.155.2023.12.22.01.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 01:01:07 -0800 (PST)
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] hw/cxl/mbox: replace sanitize_running() with
 cxl_dev_media_disabled()
Date: Fri, 22 Dec 2023 18:00:50 +0900
Message-Id: <20231222090051.3265307-4-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The spec states that reads/writes should have no effect and a part of
commands should be ignored when the media is disabled, not when the
sanitize command is running.

Introduce cxl_dev_media_disabled() to check if the media is disabled and
replace sanitize_running() with it.

Make sure that the media has been correctly disabled during sanitation
by adding an assert to __toggle_media(). Now, enabling when already
enabled or vice versa results in an assert() failure.

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  6 ++++--
 hw/mem/cxl_type3.c          |  4 ++--
 include/hw/cxl/cxl_device.h | 11 ++++++-----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 11ec8b648b..efeb5f8174 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2248,6 +2248,8 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
     int ret;
     const struct cxl_cmd *cxl_cmd;
     opcode_handler h;
+    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->intf)->cxl_dstate;
+
 
     *len_out = 0;
     cxl_cmd = &cci->cxl_cmd_set[set][cmd];
@@ -2268,8 +2270,8 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
         return CXL_MBOX_BUSY;
     }
 
-    /* forbid any selected commands while overwriting */
-    if (sanitize_running(cci)) {
+    /* forbid any selected commands while the media is disabled */
+    if (cxl_dev_media_disabled(cxl_dstate)) {
         if (h == cmd_events_get_records ||
             h == cmd_ccls_get_partition_info ||
             h == cmd_ccls_set_lsa ||
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 85fc08f118..ecb525a608 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1286,7 +1286,7 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&ct3d->cci)) {
+    if (cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
         qemu_guest_getrandom_nofail(data, size);
         return MEMTX_OK;
     }
@@ -1314,7 +1314,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&ct3d->cci)) {
+    if (cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
         return MEMTX_OK;
     }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index b318d94b36..5618061ebe 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -411,6 +411,7 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
     dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
     dev_status_reg = FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS,
                                 val);
+    assert(dev_status_reg != cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS]);
     cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
 }
 #define cxl_dev_disable_media(cxlds)                    \
@@ -418,14 +419,14 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 #define cxl_dev_enable_media(cxlds)                     \
         do { __toggle_media((cxlds), 0x1); } while (0)
 
-static inline bool scan_media_running(CXLCCI *cci)
+static inline bool cxl_dev_media_disabled(CXLDeviceState *cxl_dstate)
 {
-    return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
+    uint64_t dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
+    return FIELD_EX64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS) == 0x3;
 }
-
-static inline bool sanitize_running(CXLCCI *cci)
+static inline bool scan_media_running(CXLCCI *cci)
 {
-    return !!cci->bg.runtime && cci->bg.opcode == 0x4400;
+    return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
 }
 
 typedef struct CXLError {
-- 
2.39.3


