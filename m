Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE8278F6BF
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 03:30:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbsyl-00031L-Ez; Thu, 31 Aug 2023 21:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qbsyW-0002qs-1R
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 21:29:28 -0400
Received: from mail-yw1-x1143.google.com ([2607:f8b0:4864:20::1143])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qbsyT-0007Wv-RZ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 21:29:27 -0400
Received: by mail-yw1-x1143.google.com with SMTP id
 00721157ae682-58ca499456dso15518177b3.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 18:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693531765; x=1694136565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SK7n0aiJMN0SWoP8B2n02PHYDXpt98FoPoro/RkTgS8=;
 b=PJiMP9FomkJZuoenhx9N0lHUcoN2Safbi2QXlxDtJ+GjIS0KJiLvyQAizmcD8DwZK8
 TRQ2oROfBreZ7EfKI2HK+WJKI1/yvVMhuWU7iIFxR2MvFgZHu4K22HrQWpefqtfYbPPb
 fyJ5pSnfwbyYisTuC5wpuB8V6ltW/lQRIWRgmuoWYWGsGaVlRQw67mev4DHtQS8QwncD
 OXOxCSe1JiiHoQS3ddDBUgyKOscQSBnhbBMTjjX1llcNzCqoMeMYyrOdRsk3cxDz4uFU
 +7voBF1EPWxQnoZlxNvC2kd/6W8pm0Fa0Ym98DxarcUNalMqMBgyf8t1oSOKtZOvsCkM
 K7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693531765; x=1694136565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SK7n0aiJMN0SWoP8B2n02PHYDXpt98FoPoro/RkTgS8=;
 b=F/FO8MvrCMBRJsxlIjHb5zoQxUCjKsYbk8LbqsoiE+DAGxQ9wt5lpRmzH6fejN9ZNB
 kChXKKqfYBgSXO4W247rWJLPuW8meYtrcXJkpf3pMkIqqIXJXnsdBjtS8JmqzC4502Db
 c4bWLBuGSEsoyWDRjHo4RGI4T00eg8UmZBaChTfF0Aohw9Lrq7zInnXVAti7dg9bnY3s
 zX8Z5W4bZl/b6/PQjx3tO2PLpzfb8plh6gr8FV64vTN77S4HlFx7dkt0t3Lt9G/DWm7H
 8S0IZ2UxXaHJwysPdFmtxt8oNsU6Upzbp+RSqdVK1GaYmzeKriEkGwKqg8MrELARGrWJ
 FRlg==
X-Gm-Message-State: AOJu0Yw+UBqY1KnCvkwWPxfIpXpc1FSxZsp/jTkInGn69VINg5CyEoRb
 aHFTSEg6hF44YDqY0/CDdWTczF1XPb6M
X-Google-Smtp-Source: AGHT+IHopUFq0B9kgHdCiPSfXi9p4iJvI2XcsVjcI25l4AGICoAvGmt9VwQA2GIRpLzeMRkcsz5gYA==
X-Received: by 2002:a0d:e5c2:0:b0:595:b30:1dd8 with SMTP id
 o185-20020a0de5c2000000b005950b301dd8mr1394663ywe.18.1693531764903; 
 Thu, 31 Aug 2023 18:29:24 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 g186-20020a0df6c3000000b00559fb950d9fsm810447ywf.45.2023.08.31.18.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:29:24 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, junhee.ryu@sk.com,
 kwangjin.ko@sk.com, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 3/5] cxl/type3: Expose ct3 functions so that inheriters can
 call them
Date: Thu, 31 Aug 2023 21:29:12 -0400
Message-Id: <20230901012914.226527-4-gregory.price@memverge.com>
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

For devices built on top of ct3, we need the init, realize, and
exit functions exposed to correctly start up and tear down.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/mem/cxl_type3.c          | 8 ++++----
 include/hw/cxl/cxl_device.h | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 80d596ee10..a8d4a12f3e 100644
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
@@ -2081,7 +2081,7 @@ void qmp_cxl_release_dynamic_capacity(const char *path,
                                      errp);
 }
 
-static void ct3_class_init(ObjectClass *oc, void *data)
+void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index e824c5ade8..4ad38b689c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -524,6 +524,11 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs);
 
+void ct3_realize(PCIDevice *pci_dev, Error **errp);
+void ct3_exit(PCIDevice *pci_dev);
+void ct3d_reset(DeviceState *d);
+void ct3_class_init(ObjectClass *oc, void *data);
+
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
 
 void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num);
-- 
2.39.1


