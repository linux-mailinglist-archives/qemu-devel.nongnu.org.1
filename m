Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEFF8FE677
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jun 2024 14:26:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFCBD-0005Hg-9i; Thu, 06 Jun 2024 08:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sFCBB-0005EU-4u
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:25:17 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sFCB9-0007Wf-Ar
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:25:16 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6ce533b643dso615214a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1717676713; x=1718281513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLkwjmAys5Ra1hLbRsNe5mSovRHzzADAGuNQz2QELRM=;
 b=aMu3//mFRMcffaePMPcA4w/A3MsGo5RPwgopwCCvHGhJYhBAP3ZgJS90cDGHGDrY4C
 qURogKnzMu19bW0aOz0aPz7+tD1kPkE+S9UlIUO5gcEffIyLLVM48RPsqEnI61GMF6FY
 SPg4cNxbfes2RDzs00oCGPWbpNLrSxO0Z6sVHQHO8hJ68K3IBes2kjCmUJn51VuxldTe
 +8hfR2wEEOTHRhmJwZEENHQjGSvw7Le1HGLyLRWEs/FK8sG7SSa2T7Duh8MKhgKqxrdI
 PmlaVatSkNyn43jY2nA4CdUD1oKM73J3EJspMwPxDaMwz/eRtCpuX9NXIv4Ej2viUUgY
 6voA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717676713; x=1718281513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLkwjmAys5Ra1hLbRsNe5mSovRHzzADAGuNQz2QELRM=;
 b=VnqGtCEaRIdCO8mRAznprqdpOXWFZqZlxh1t2ChpbwDK4h6SZIrh57z4u2jmNwbiq9
 WP/9DOb20tT9q4vLWlCQ024pVgXV5lNnMfvA+SW59BGT8t2+08PaGDT7YAvfMqF4+TRu
 bir1OYnppmOJX4uG3NXraBb5KVIAR6BqLGAp/kIb36JzrK0OV5A+eIHUKFGNAp3Rj/f+
 1Cjn/0HDnTZrMgAL9PFnjQ3/z+LoZpqTIrYyw1g4mrgLEldIpouavOr35KYttY4YZzPq
 jPSrMInEE4EE7409IDo7CJ7kPjGeNy9HHobeObQuzavdtlkxtR0lGW12EhfoNS1trjhi
 Qpkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXilk8Cc5xeGQefUSYcWyJ5ozaU3Sb//LPM4kPt1ptCTG8/zUT0MC+MKLl+4/qBpxFZntSBa4AfuFVLBl8T/Cddhw/2f3w=
X-Gm-Message-State: AOJu0YyPbZxa84xmBGhGZmwgMST9AbDoJOkGpAZR9i+H6CQ0ahHIMp4z
 ytHcSncYrCHPA6chrwTv2KzAjDstnmKHOP96O2Uiaxfl2JI9kUG1X6X90yBQ4Vo=
X-Google-Smtp-Source: AGHT+IExPLbYRNSnSGBw6IGENJnB9PwGNwhL2ulcu3NrJW0w2yqg5Z+fG5NR9UmXVDhjaKTjX9iLBg==
X-Received: by 2002:a05:6a20:3949:b0:1b2:6b27:5cac with SMTP id
 adf61e73a8af0-1b2b747e627mr6107724637.32.1717676713561; 
 Thu, 06 Jun 2024 05:25:13 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.142])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c29c20d7adsm1459396a91.9.2024.06.06.05.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 05:25:13 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v5 04/10] scsi/util: add helper functions for persistent
 reservation types conversion
Date: Thu,  6 Jun 2024 20:24:38 +0800
Message-Id: <20240606122444.2914576-5-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
References: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pg1-x52a.google.com
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

This commit introduces two helper functions
that facilitate the conversion between the
persistent reservation types used in the SCSI
protocol and those used in the block layer.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/scsi/utils.h |  8 +++++
 scsi/utils.c         | 81 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index d5c8efa16e..89a0b082fb 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -1,6 +1,8 @@
 #ifndef SCSI_UTILS_H
 #define SCSI_UTILS_H
 
+#include "block/block-common.h"
+#include "scsi/constants.h"
 #ifdef CONFIG_LINUX
 #include <scsi/sg.h>
 #endif
@@ -135,6 +137,12 @@ uint32_t scsi_data_cdb_xfer(uint8_t *buf);
 uint32_t scsi_cdb_xfer(uint8_t *buf);
 int scsi_cdb_length(uint8_t *buf);
 
+BlockPrType scsi_pr_type_to_block(SCSIPrType type);
+SCSIPrType block_pr_type_to_scsi(BlockPrType type);
+
+uint8_t scsi_pr_cap_to_block(uint16_t scsi_pr_cap);
+uint16_t block_pr_cap_to_scsi(uint8_t block_pr_cap);
+
 /* Linux SG_IO interface.  */
 #ifdef CONFIG_LINUX
 #define SG_ERR_DRIVER_TIMEOUT  0x06
diff --git a/scsi/utils.c b/scsi/utils.c
index 357b036671..0dfdeb499d 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -658,3 +658,84 @@ int scsi_sense_from_host_status(uint8_t host_status,
     }
     return GOOD;
 }
+
+BlockPrType scsi_pr_type_to_block(SCSIPrType type)
+{
+    switch (type) {
+    case SCSI_PR_WRITE_EXCLUSIVE:
+        return BLK_PR_WRITE_EXCLUSIVE;
+    case SCSI_PR_EXCLUSIVE_ACCESS:
+        return BLK_PR_EXCLUSIVE_ACCESS;
+    case SCSI_PR_WRITE_EXCLUSIVE_REGS_ONLY:
+        return BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY;
+    case SCSI_PR_EXCLUSIVE_ACCESS_REGS_ONLY:
+        return BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY;
+    case SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS:
+        return BLK_PR_WRITE_EXCLUSIVE_ALL_REGS;
+    case SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS:
+        return BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS;
+    }
+
+    return 0;
+}
+
+SCSIPrType block_pr_type_to_scsi(BlockPrType type)
+{
+    switch (type) {
+    case BLK_PR_WRITE_EXCLUSIVE:
+        return SCSI_PR_WRITE_EXCLUSIVE;
+    case BLK_PR_EXCLUSIVE_ACCESS:
+        return SCSI_PR_EXCLUSIVE_ACCESS;
+    case BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY:
+        return SCSI_PR_WRITE_EXCLUSIVE_REGS_ONLY;
+    case BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY:
+        return SCSI_PR_EXCLUSIVE_ACCESS_REGS_ONLY;
+    case BLK_PR_WRITE_EXCLUSIVE_ALL_REGS:
+        return SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS;
+    case BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS:
+        return SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS;
+    }
+
+    return 0;
+}
+
+
+uint8_t scsi_pr_cap_to_block(uint16_t scsi_pr_cap)
+{
+    uint8_t res = 0;
+
+    res |= (scsi_pr_cap & SCSI_PR_CAP_WR_EX) ?
+           BLK_PR_CAP_WR_EX : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_EX_AC) ?
+           BLK_PR_CAP_EX_AC : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_WR_EX_RO) ?
+           BLK_PR_CAP_WR_EX_RO : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_EX_AC_RO) ?
+           BLK_PR_CAP_EX_AC_RO : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_WR_EX_AR) ?
+           BLK_PR_CAP_WR_EX_AR : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_EX_AC_AR) ?
+           BLK_PR_CAP_EX_AC_AR : 0;
+
+    return res;
+}
+
+uint16_t block_pr_cap_to_scsi(uint8_t block_pr_cap)
+{
+    uint16_t res = 0;
+
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX) ?
+              SCSI_PR_CAP_WR_EX : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC) ?
+              SCSI_PR_CAP_EX_AC : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX_RO) ?
+              SCSI_PR_CAP_WR_EX_RO : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC_RO) ?
+              SCSI_PR_CAP_EX_AC_RO : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX_AR) ?
+              SCSI_PR_CAP_WR_EX_AR : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC_AR) ?
+              SCSI_PR_CAP_EX_AC_AR : 0;
+
+    return res;
+}
-- 
2.20.1


