Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B73F681C714
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 10:02:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGbP4-0005Bd-I1; Fri, 22 Dec 2023 04:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1rGbP2-0005BU-Ol
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:01:08 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1rGbP1-0002VB-3V
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:01:08 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6d2350636d6so1535857b3a.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 01:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703235665; x=1703840465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=boKgDX4Lvl1vtOxGhAvwh9bjFCyA3++fBUjABFhAblo=;
 b=e/Ekofny4Zju95KkGLTyOfC/WKHN3geqraR5mowJw/5NdiPlnYx2YrPPTRXUenQr1l
 IiryBGKoINqJcBSxLmu0fjQl4LghNAflH8DnHPT2LuEgR/Q9V00SsNBvKBRMDO2sQvwo
 r3a0fO5l0FXhexCSJ0Aa68yeEVhE5c+Yv2UGqtGGJxqukGEAjBuUPSETbQNT1cr6g59k
 EUH67g7XGRRejkx3DtLYpDURMEKAGEnLh+Bitq3KTUcWi/oA596aMZ0Vahit3vcmjY2p
 GnmW8KHuPH4yGpKUZKDMbvRgQXuTQ7nl/FHWteafbrT8pI6EW2LbuXd2ssyRhieNqAdT
 2c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703235665; x=1703840465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=boKgDX4Lvl1vtOxGhAvwh9bjFCyA3++fBUjABFhAblo=;
 b=XbGtCsA3f7xEq4UeedGEAwoQH6QoVAkEtmEOC5YAJDhUoG/ZrwQ+yJQJ1xpiCgJ3gq
 +5/5kkeekahDfOfVDTMq02fMU/h8Ay6qiEZnksiXiWQP2ImPAZb/EjMc3mggmFaaHFEk
 bFs5AQ2mV8p9/zPGVcrfuY3AVtHlhHlnhWjS7mk6eJTSaSriz4B8ml0fJnJVkHS8203h
 xwCPJ7RD0jsMwd+T4oi7/kLL15GTtNjNpwGawlHDegH+bw9FFYQHgRYiwzyoaiWbs4pB
 MpfQ2Z8rKHy36YRjbfNFjrchXfolxtjJLeummU+PL7uDl8rVvZbvM2DpXLmcKEUEF3mO
 Xxrw==
X-Gm-Message-State: AOJu0YwFJG3aRp1oUFKBntZh9k6QC6udxNsAuN4o3Hoza1CZ3EjMgXU5
 JXvxdsD/U8RYvzyZfmKZii0=
X-Google-Smtp-Source: AGHT+IETskAy68zOVeR/Q/Oxdx5/PrTDs3S/QqTI7jdFInnq4s3g5TIrI8rTadDT8T3mGuNny9GHng==
X-Received: by 2002:aa7:84d0:0:b0:6d9:5d0f:bee8 with SMTP id
 x16-20020aa784d0000000b006d95d0fbee8mr1106915pfn.10.1703235665406; 
 Fri, 22 Dec 2023 01:01:05 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a056a000b1700b006d990040342sm400560pfu.155.2023.12.22.01.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 01:01:04 -0800 (PST)
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] hw/cxl/device: read from register values in
 mdev_reg_read()
Date: Fri, 22 Dec 2023 18:00:49 +0900
Message-Id: <20231222090051.3265307-3-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-pf1-x434.google.com
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

In the current mdev_reg_read() implementation, it consistently returns
that the Media Status is Ready (01b). This was fine until commit
25a52959f99d ("hw/cxl: Add support for device sanitation") because the
media was presumed to be ready.

However, as per the CXL 3.0 spec "8.2.9.8.5.1 Sanitize (Opcode 4400h)",
during sanitation, the Media State should be set to Disabled (11b). The
mentioned commit correctly sets it to Disabled, but mdev_reg_read()
still returns Media Status as Ready.

To address this, update mdev_reg_read() to read register values instead
of returning dummy values.

Fixes: commit 25a52959f99d ("hw/cxl: Add support for device sanitation")
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
 include/hw/cxl/cxl_device.h |  4 +++-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 29de298117..ba3f80e6e7 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -229,12 +229,9 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
 
 static uint64_t mdev_reg_read(void *opaque, hwaddr offset, unsigned size)
 {
-    uint64_t retval = 0;
-
-    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
-    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MBOX_READY, 1);
+    CXLDeviceState *cxl_dstate = opaque;
 
-    return retval;
+    return cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
 }
 
 static void ro_reg_write(void *opaque, hwaddr offset, uint64_t value,
@@ -371,7 +368,15 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
     cxl_dstate->mbox_msi_n = msi_n;
 }
 
-static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
+static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
+{
+    uint64_t memdev_status_reg;
+
+    memdev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
+    memdev_status_reg = FIELD_DP64(memdev_status_reg, CXL_MEM_DEV_STS,
+                                   MBOX_READY, 1);
+    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = memdev_status_reg;
+}
 
 void cxl_device_register_init_t3(CXLType3Dev *ct3d)
 {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index b2cb280e16..b318d94b36 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -408,7 +408,9 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 {
     uint64_t dev_status_reg;
 
-    dev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
+    dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
+    dev_status_reg = FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS,
+                                val);
     cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
 }
 #define cxl_dev_disable_media(cxlds)                    \
-- 
2.39.3


