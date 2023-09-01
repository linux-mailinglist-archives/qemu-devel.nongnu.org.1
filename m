Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BAB78F6C3
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 03:31:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbsyu-0003EZ-Ms; Thu, 31 Aug 2023 21:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qbsyh-00038V-Fa
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 21:29:42 -0400
Received: from mail-yw1-x1143.google.com ([2607:f8b0:4864:20::1143])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qbsyW-0007X3-7y
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 21:29:30 -0400
Received: by mail-yw1-x1143.google.com with SMTP id
 00721157ae682-5924093a9b2so15715057b3.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 18:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693531766; x=1694136566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGyDOe9YH+wHWF5Vb+pQ1xAEsSvo14grLJWUVd5BMeE=;
 b=KTjidGUzJnkqdhklCU2V/Ect10NdLfNxxx22cfGmiPVtfZ4OOc5DGi46D0H8fN2xcq
 VVc1hBnYyKHLyHPV8Q0LY20Saz0w6O1pHkl+WygvZEUnyzCbfCFc6QSqR1PB+GOn9ecn
 0qAP59q7I6X3+KdP0BiatSGjdRmHOWTv7itNe9bCBrnNPOSDyQNJKdjMaVCifAZo09np
 ZE3EyfQ2cWFHYANACnfSmIjL0AsiTibkySMCNb7iGPOF6V11YACsS5TZpglTaJ5ih/+K
 EB/w41XwC8CdE2S7JzlsWZrIAXVkANvq+nN9tIFPmkd+xJRFKhyIX+Gasq99RctLrXi0
 msYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693531766; x=1694136566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lGyDOe9YH+wHWF5Vb+pQ1xAEsSvo14grLJWUVd5BMeE=;
 b=Qji6CmZRuUhfKkF5Zm0JbCpoBOs0hizJrd0OUuDjYVXeeMf0e/x4GzFMVlmCdrEk0L
 4TJDVTvgSV+OQQsEpXUbv5i5piuaEiGoS1Gor4LDTeDZx7Zyvo62NFOSE+pPWg/oTLcR
 Q2RuuttnszZ7prURnCEsSBtwUZtRSHc0EkNyD5yXjgau19TvCrA3AjSONnG9PrqD0jfY
 3gNOhUGiqsaP+Cth0aRB/2r2VYfL9N62DHI/shdlJ73yDmkhdaqand0IsKU15ufD4EeS
 Uw5LiI6cJ76hQGN4uokbfCoqfNxP3JUInEDfwir59e5zjTnE5jtE+b07aq2Te9npZzMD
 jKOg==
X-Gm-Message-State: AOJu0YztmZKTqje9+b+JF+WmXxQe+HWITDnvlHoIJBc/kYPbnPs/9b8u
 10nO+2XCEd/44hm32yff5/f1mSnS9BgJ
X-Google-Smtp-Source: AGHT+IGo027K8zC4uZckAITLYpghGqKZwYmeHjA3c7jEoHtENn765YTn1e3HAVQXEB0XQRm9OWKS3Q==
X-Received: by 2002:a81:72c3:0:b0:595:9770:6910 with SMTP id
 n186-20020a8172c3000000b0059597706910mr965799ywc.52.1693531766304; 
 Thu, 31 Aug 2023 18:29:26 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 g186-20020a0df6c3000000b00559fb950d9fsm810447ywf.45.2023.08.31.18.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:29:26 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, junhee.ryu@sk.com,
 kwangjin.ko@sk.com, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 4/5] cxl/type3: add an optional mhd validation function for
 memory accesses
Date: Thu, 31 Aug 2023 21:29:13 -0400
Message-Id: <20230901012914.226527-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230901012914.226527-1-gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1143;
 envelope-from=gourry.memverge@gmail.com; helo=mail-yw1-x1143.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When memory accesses are made, some MHSLD's would validate the address
is within the scope of allocated sections.  To do this, the base device
must call an optional function set by inherited devices.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c          | 15 +++++++++++++++
 include/hw/cxl/cxl_device.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a8d4a12f3e..8e1565f2fc 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1034,6 +1034,10 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
             goto err_release_cdat;
         }
     }
+
+    /* Devices which inherit ct3d should initialize these after ct3_realize */
+    ct3d->mhd_access_valid = NULL;
+
     return;
 
 err_release_cdat:
@@ -1259,6 +1263,11 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
+    if (ct3d->mhd_access_valid &&
+        !ct3d->mhd_access_valid(d, dpa_offset, size)) {
+        return MEMTX_ERROR;
+    }
+
     if (sanitize_running(&ct3d->cci)) {
         qemu_guest_getrandom_nofail(data, size);
         return MEMTX_OK;
@@ -1279,6 +1288,12 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     if (res) {
         return MEMTX_ERROR;
     }
+
+    if (ct3d->mhd_access_valid &&
+        !ct3d->mhd_access_valid(d, dpa_offset, size)) {
+        return MEMTX_ERROR;
+    }
+
     if (sanitize_running(&ct3d->cci)) {
         return MEMTX_OK;
     }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 4ad38b689c..b1b39a9aa0 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -489,6 +489,9 @@ struct CXLType3Dev {
         uint8_t num_regions; /* 0-8 regions */
         CXLDCDRegion regions[DCD_MAX_REGION_NUM];
     } dc;
+
+    /* Multi-headed Device */
+    bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
-- 
2.39.1


