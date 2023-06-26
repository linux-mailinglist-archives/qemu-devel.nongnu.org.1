Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7584873E467
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:14:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoqi-0007s3-IA; Mon, 26 Jun 2023 12:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDoqf-0007l7-9j
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDoqd-0002uV-Ml
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687796030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFaGSHVuQ/MJdrogUY2Zw/pcgRXL686O5bdoo9qhITc=;
 b=OrZKg5A3IIuEjZYPottAbxQml/3gBTvol6Q1NTNTSCJ1B/3+SUnwOTFgVi8LOtic0pClvl
 6UftNMk85BzlJexops6r28JqZloXQjOUc0f4plU1+bCVqcNQJpOm8zCZRJmeWyRb8ZyqWX
 SlyRDgeVtipVtMMK7HjuLBINnoNbel0=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-JLhwaNfYOzOYwLx_v8bK_w-1; Mon, 26 Jun 2023 12:13:47 -0400
X-MC-Unique: JLhwaNfYOzOYwLx_v8bK_w-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1b0179af273so2397463fac.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687796025; x=1690388025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFaGSHVuQ/MJdrogUY2Zw/pcgRXL686O5bdoo9qhITc=;
 b=Qoz7oveki2bCO5MS/qNFUzPAt9zxhtRAY9xPhLWroj/jSXfLRuGmhwILns+vmtTb7l
 jK9exOE1+AvaoG6ZeJ6AMeic38wQAip9Q5UAH6dwJKanYwFTQiDSVOowrnGe+Q3W3qNn
 zDS0i43Wl6XOfAWbN2ybjLXQkssRFfqVwjVIF80WFTa96Sw7Bu9Q3RVGe4b+hCouCoxh
 +mrYZglMz94/eB7nCUnA5vwty7ttG1COaiZM3zsbzyfmiHs9gOYavl4066e1TKpS/MPQ
 ITz1KBP0/1eRZX9FH/1zhOlhrZCS6qD2TxAFoXo4sDxKIf8aqTAnGVWgoSObxdYe2kt7
 03Ww==
X-Gm-Message-State: AC+VfDwOAFiHJz5aCKDNE9cEIDobN5zGvlxzqgOGBgBkPNtbxrXLGGV0
 Aok1EgKTw91tOpiPRYTwvSaY93vbXm6T90sTxNdKXdok6pXhqY9EFruA8PiE0z2Tsg8z9bR3Wbp
 Y4rH44r67odEyC2ol0yO3tJ/Mn+E/SmLw7kh0IUhj6byMQ8qqUpuFMcdMnYKRNeAooUIzY9twEU
 Y=
X-Received: by 2002:a05:6870:e295:b0:1a2:c149:99cc with SMTP id
 v21-20020a056870e29500b001a2c14999ccmr24000450oad.24.1687796024828; 
 Mon, 26 Jun 2023 09:13:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6p8AQMpD5NOJ/OkUNwmHq8pWlPBvDzJUIB1fVDVCZ1a5X5s5JLUsrv43atVjPMcr95jU0PKw==
X-Received: by 2002:a05:6870:e295:b0:1a2:c149:99cc with SMTP id
 v21-20020a056870e29500b001a2c14999ccmr24000431oad.24.1687796024544; 
 Mon, 26 Jun 2023 09:13:44 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 q5-20020a631f45000000b0051b7d83ff22sm4318745pgm.80.2023.06.26.09.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:13:44 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	jusual@redhat.com,
	imammedo@redhat.com
Subject: [RESEND PATCH v5 5/5] hw/pci: ensure PCIE devices are plugged into
 only slot 0 of PCIE port
Date: Mon, 26 Jun 2023 21:42:44 +0530
Message-Id: <20230626161244.4145-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230626161244.4145-1-anisinha@redhat.com>
References: <20230626161244.4145-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

PCI Express ports only have one slot, so PCI Express devices can only be
plugged into slot 0 on a PCIE port. Enforce it.

CC: jusual@redhat.com
CC: imammedo@redhat.com
Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Julia Suvorova <jusual@redhat.com>
---
 hw/pci/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index bf38905b7d..426af133b0 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -64,6 +64,7 @@ bool pci_available = true;
 static char *pcibus_get_dev_path(DeviceState *dev);
 static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset(BusState *qbus);
+static bool pcie_has_upstream_port(PCIDevice *dev);
 
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
@@ -1189,6 +1190,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                    name);
 
        return NULL;
+    } else if (pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
+        error_setg(errp, "PCI: slot %d is not valid for %s,"
+                   " parent device only allows plugging into slot 0.",
+                   PCI_SLOT(devfn), name);
+        return NULL;
     }
 
     pci_dev->devfn = devfn;
-- 
2.39.1


