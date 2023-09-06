Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A13796DB6
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 01:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe2Fz-0006EB-Qk; Wed, 06 Sep 2023 19:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qe2Fp-0006CY-8N
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 19:48:13 -0400
Received: from mail-yw1-x1141.google.com ([2607:f8b0:4864:20::1141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qe2Fg-0006b0-0A
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 19:48:06 -0400
Received: by mail-yw1-x1141.google.com with SMTP id
 00721157ae682-5920efd91c7so4332307b3.2
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 16:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694044083; x=1694648883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b2cy+GLqlTQ8dVdKP4BOlp5an3Yg4Ivxw3bTV+3I6Rc=;
 b=QwrQXgio/zJ6uUQ5YVGKTBuvA9DwjsnqB8EN1hxDHGZbJuPNhZLI1qjCkMpnBFRU1H
 Ole1t+ze5LWmVjQS/BI2172SLjBctPGmusobYmMnuYJFReieeKvGT0eUPyefy+UjvFPy
 rO2U+v5a6O9oi4QbdvrBwfkDT79PPIcj/3fuXGxkj/Iu7g27zPX3aJMEuw5hfH2So4Vn
 BB0k7TGRoiRV9kNShdG9++Ar8XFBnuxaKG5DKNH8ndk3yugTxkKtuzj/vSobntWZEC0x
 Y9+0mlMWXzHICPizB0wHBMJJ7y1LGdw+W1rWti4RCGIio7ILxlxqtpiEqyDBzfGB8JDs
 gRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694044083; x=1694648883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b2cy+GLqlTQ8dVdKP4BOlp5an3Yg4Ivxw3bTV+3I6Rc=;
 b=QUuAqnMqriZbefDhrswqVUvBjcDLWaklJKTVHZMSPDVxVkdw0TH0VNxE0lJeqaQa0T
 pGMl7X0x6FyyTfE79E6f6mBWmeSOuVoY67KhVo+oTgMyo9RO7YEhGaXAD5xPNyJFSRA4
 p96O5Sj5L2kvVhQcAuNO4Jjtr/m0T2MVMoFPG0bk/ACIy47SbCTlWtF9ATNCpwdk16UM
 RuuuDKb14TvhltwNy8/HsutOViFlNFWUUpQBTFM6lcaB3eHbbEJFml9JBjSSnAKZSbCB
 OBsxWlAvi3X5x2+xcGxFgL8FF3VYiunQZTtdmmmk1nFFBtIk2to7IOLZk4CsaFt44iGi
 oYmw==
X-Gm-Message-State: AOJu0YxYb7vgsZ8FLnNUUxnl6EjNj/LUQXX7HAc6Ct1MAOZLBXa8gRyD
 RFkdAnPrFHepDov+DxPaXOQ75kvQR+Mr
X-Google-Smtp-Source: AGHT+IESDAYo5PwejGWmAa/zJuBVeaLBycSjoUBB5CtYMOrj5c0JbFybviSnNXYCgPHTFNu2LuPikg==
X-Received: by 2002:a81:48ce:0:b0:58c:5299:8033 with SMTP id
 v197-20020a8148ce000000b0058c52998033mr17140659ywa.17.1694044082780; 
 Wed, 06 Sep 2023 16:48:02 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 v191-20020a8148c8000000b005832fe29034sm332107ywa.89.2023.09.06.16.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 16:48:02 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, junhee.ryu@sk.com,
 kwangjin.ko@sk.com, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 3/6] cxl/type3: Expose ct3 functions so that inheriters can
 call them
Date: Tue,  5 Sep 2023 20:15:14 -0400
Message-Id: <20230906001517.324380-4-gregory.price@memverge.com>
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

For devices built on top of ct3, we need the init, realize, and
exit functions exposed to correctly start up and tear down.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c          | 6 +++---
 include/hw/cxl/cxl_device.h | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 80d596ee10..6e3309dc11 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -950,7 +950,7 @@ static DOEProtocol doe_spdm_prot[] = {
     { }
 };
 
-static void ct3_realize(PCIDevice *pci_dev, Error **errp)
+void ct3_realize(PCIDevice *pci_dev, Error **errp)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
@@ -1054,7 +1054,7 @@ err_address_space_free:
     return;
 }
 
-static void ct3_exit(PCIDevice *pci_dev)
+void ct3_exit(PCIDevice *pci_dev)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
@@ -1285,7 +1285,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
-static void ct3d_reset(DeviceState *dev)
+void ct3d_reset(DeviceState *dev)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(dev);
     uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index e824c5ade8..9c37a54699 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -524,6 +524,10 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs);
 
+void ct3_realize(PCIDevice *pci_dev, Error **errp);
+void ct3_exit(PCIDevice *pci_dev);
+void ct3d_reset(DeviceState *d);
+
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
 
 void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num);
-- 
2.39.1


