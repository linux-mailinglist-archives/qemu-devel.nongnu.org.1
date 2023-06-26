Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 301D373E127
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:54:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmfC-0004zn-BR; Mon, 26 Jun 2023 09:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDmf9-0004y1-Im
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDmf7-000635-WD
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687787629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFaGSHVuQ/MJdrogUY2Zw/pcgRXL686O5bdoo9qhITc=;
 b=AcxTLy0dRE958U/kJBnMvco8LiqEKk3s4AC3uSoChnBQv1LVLaGPndh/+Kvu7aQfpfnawH
 1VCXIC9oacXujKqVoslF0WiigXr43V7St09zOmnDGwPZkV2Wp6wdvSzFzeugfCkcCaqCDo
 dbU4Av1XwMtQjjWO1c8jp0AkdMiizYQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-5iHjZ6niPEepNkXUruWkjw-1; Mon, 26 Jun 2023 09:53:48 -0400
X-MC-Unique: 5iHjZ6niPEepNkXUruWkjw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b7ef04ddfeso6879705ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687787626; x=1690379626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFaGSHVuQ/MJdrogUY2Zw/pcgRXL686O5bdoo9qhITc=;
 b=Ce8Zr4tzJ58CFfaXYPupVKTw3orS8FbMSkzQWrD6e86tmg7Da/NfCywwUKFydWJBrh
 AAbMGcVYkZRL1h/tCbnQuZZbHbaYSImzvU9FF64PRCvyBdbF0tB5i7twiqQbrDe7rgJT
 BqHdWk2XCChRTILbsP1Fk73aAckKrvt3UlrMsiG1bSauyUM1GgUQEt/40AuSh+UnoDEG
 2cvEGSeCwkGWdgc/GyehLbzWMxrDW7B6jAUMrL4fW1ZXCW0lQ4+JUKU6wGRUHn/BIRcS
 hIA3kmJZedO4NRrAr1FyFNynaLuTmi8E4auusyFhPGDkRMKgrEa6FENxMUzXokSLCFu7
 r/jw==
X-Gm-Message-State: AC+VfDxvtj+OiNbEUDM0eyz77t4MOHqWoE0jrmOOn/GIbw5TxvFAn18W
 nfCaH+8SPxAJ71ZrU6Qki0TsaKPqbO4LmDPgMAoWoft+7d715P1+sh4DqdZvemBFA2uBmcYP/iq
 yjXyl2ibP+0C5vZh1S989fONsAH01HnsRoOGF/kgxQoW6H6LCvXLoOzQcfEPcTurdkPpzXiotu7
 Q=
X-Received: by 2002:a17:902:cecd:b0:1b6:b4e5:24b with SMTP id
 d13-20020a170902cecd00b001b6b4e5024bmr5231326plg.10.1687787626725; 
 Mon, 26 Jun 2023 06:53:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ676ehQF9Gal4RdAMuJiHww6sHAbUBfFUA3oT8djIjQGgoYDnvgwKlhyOKYjsufZdz18JQ5Xw==
X-Received: by 2002:a17:902:cecd:b0:1b6:b4e5:24b with SMTP id
 d13-20020a170902cecd00b001b6b4e5024bmr5231312plg.10.1687787626405; 
 Mon, 26 Jun 2023 06:53:46 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 w7-20020a170902904700b001b809082a69sm1559621plz.235.2023.06.26.06.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:53:46 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	jusual@redhat.com,
	imammedo@redhat.com
Subject: [PATCH v4 5/5] hw/pci: ensure PCIE devices are plugged into only slot
 0 of PCIE port
Date: Mon, 26 Jun 2023 19:23:24 +0530
Message-Id: <20230626135324.10687-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230626135324.10687-1-anisinha@redhat.com>
References: <20230626135324.10687-1-anisinha@redhat.com>
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


