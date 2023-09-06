Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D93796DBF
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 01:49:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe2Fx-0006Dz-2d; Wed, 06 Sep 2023 19:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qe2Fr-0006Cy-75
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 19:48:16 -0400
Received: from mail-yw1-x1141.google.com ([2607:f8b0:4864:20::1141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qe2Fi-0006bH-4Q
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 19:48:14 -0400
Received: by mail-yw1-x1141.google.com with SMTP id
 00721157ae682-594f8a7125cso4609917b3.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 16:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694044084; x=1694648884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9uQCHpegy+Oy5ZTt5LqLlsA06JmldqXw1wStxlifsWA=;
 b=pt64Oar1KzOoLybv6VGQxkdFllNWYL510cqNin/3+6a91MhI3UjX35KO6Oi+YAMUl0
 kT2RArw0Uijfpn5325Yd0VsEPvRLHvNyb9t8yOuR9BNCHM69r3VtmXDVKFapj/ReQrXG
 fbOW7YiuHejpPGPgEsIOLlt8d4XA1C4+kI2qeXstdLrUYyrHk1gNYGacR6EDfpXersVY
 udQMVRsVE3xF1y3eUuGsEP9vf03n7DOolR0HNbaHj4YQm91Jr0bRs55iSdiz8JmeOOk5
 bQF5gmsKozhmf/cXrfILXE4LQNLpT+5S/GR2ZiB3Nirq5U16QULrWQX9gzBLkMJIzvpr
 Slyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694044084; x=1694648884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uQCHpegy+Oy5ZTt5LqLlsA06JmldqXw1wStxlifsWA=;
 b=gfKUZXbrEdzTH9ITepPEYYlyLL+dcwGOTZwic9YgQUlN1nNd3yk2rVoSy+xs8h3EFR
 UH6rOId7n7TWC6Fw+qtQgOSKa7fyrHD3lUnhRMwWuKFJqbx91IsgIRux6EyF15TcMewe
 UzhowuNyHWTEff8VDQ2eGfvsVh4zAMLXianbuG4Tvfswv7QvKqX+1/8DxlspVhqo78fk
 lD7qWih16ZCTRBH8YUtVY3Zs9ECTNrV1XSNIM/4tZyEg7PIFb3bq3vwext6n+5/BPDxd
 U+o3nUt8P6fto9hwQjLsApAoLzlAFhF7nh0j9yu+S9ifPq4z3FJISbSoImCUeu6SQQTO
 sEhA==
X-Gm-Message-State: AOJu0YzlgJrlMdufYU2m6b2rha4VcxBEty/lDQAGFoajmNHpk1p+ZWcs
 XXC5+i0MUW2rbZpupR786Ct53YyXB/JP
X-Google-Smtp-Source: AGHT+IFMy7ES3j3wkZBhB84OxrmgRJ49qRnJ/3RREn/RM8HAdptZWVyJVzSNKZvrqdGYNDc9F4CBHg==
X-Received: by 2002:a0d:d3c1:0:b0:577:25dc:c1fc with SMTP id
 v184-20020a0dd3c1000000b0057725dcc1fcmr16551998ywd.0.1694044083835; 
 Wed, 06 Sep 2023 16:48:03 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 v191-20020a8148c8000000b005832fe29034sm332107ywa.89.2023.09.06.16.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 16:48:03 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, junhee.ryu@sk.com,
 kwangjin.ko@sk.com, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 4/6] cxl/type3: add an optional mhd validation function for
 memory accesses
Date: Tue,  5 Sep 2023 20:15:15 -0400
Message-Id: <20230906001517.324380-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230906001517.324380-1-gregory.price@memverge.com>
References: <20230906001517.324380-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1141;
 envelope-from=gourry.memverge@gmail.com; helo=mail-yw1-x1141.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 6e3309dc11..1fb3ffeca8 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1034,6 +1034,7 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
             goto err_release_cdat;
         }
     }
+
     return;
 
 err_release_cdat:
@@ -1249,6 +1250,7 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
                            unsigned size, MemTxAttrs attrs)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(d);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
@@ -1259,6 +1261,11 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
+    if (cvc->mhd_access_valid &&
+        !cvc->mhd_access_valid(d, dpa_offset, size)) {
+        return MEMTX_ERROR;
+    }
+
     if (sanitize_running(&ct3d->cci)) {
         qemu_guest_getrandom_nofail(data, size);
         return MEMTX_OK;
@@ -1270,6 +1277,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(d);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
@@ -1279,6 +1287,12 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     if (res) {
         return MEMTX_ERROR;
     }
+
+    if (cvc->mhd_access_valid &&
+        !cvc->mhd_access_valid(d, dpa_offset, size)) {
+        return MEMTX_ERROR;
+    }
+
     if (sanitize_running(&ct3d->cci)) {
         return MEMTX_OK;
     }
@@ -2106,6 +2120,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     cvc->get_lsa = get_lsa;
     cvc->set_lsa = set_lsa;
     cvc->set_cacheline = set_cacheline;
+    cvc->mhd_access_valid = NULL;
 }
 
 static const TypeInfo ct3d_info = {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 9c37a54699..37893f8626 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -506,6 +506,9 @@ struct CXLType3Class {
     void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
                     uint64_t offset);
     bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
+
+    /* Multi-headed Device */
+    bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
 };
 
 struct CSWMBCCIDev {
-- 
2.39.1


