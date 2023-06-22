Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3C3739E98
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 12:34:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCHdg-00031i-2O; Thu, 22 Jun 2023 06:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qCHdb-00030z-Hq
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qCHda-0008Ir-0X
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687430041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOMtOW9aGVkJgeNXBS62ZUidbXLWxpBbe4rWHMT6PRs=;
 b=KCpbQEIHNT5U6kR7yAvLTGSqZxyj9BajsYo0DUesWcBwZf1LsonbLbjnHruRlcIKkwO7Ba
 4lcgQInFXIukXmeRCOd1ikYh3cSuTOPVHwSp1GaHEuI5qZjtzKPGTDsU6XW8/Zmhd6NfPw
 3NbTrBoE/SPbHdzFyiDWVcTXLWz4G5w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-P-1zOxpvPKOzvZrX38DFOw-1; Thu, 22 Jun 2023 06:34:00 -0400
X-MC-Unique: P-1zOxpvPKOzvZrX38DFOw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-25efb82179dso2438435a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 03:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687430039; x=1690022039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jOMtOW9aGVkJgeNXBS62ZUidbXLWxpBbe4rWHMT6PRs=;
 b=WrpgzXKqe67+tAWPpTkA6KTO3Xt21WZBUGdmtWd/J8K2H6vawjJePAy6Dxey7w0lB4
 F/NTJJYD9Q799Pz5iX3cpuMz5EZVbH8haLwCVv6fW5et6cv2iyQyvY+PX9UO9tNiVbh+
 KdxcdEIIq9aE2Fg53C1oM8680uIcnPkNjoCEE5IWz1zQSJKUT79GfrIMSbOmaTKaDcb5
 KKsRQx14sqZh7VyG6P8cCDsRLqJzmYW2xy4aGUeW+cXxCzkpaCSyW/MwPVfgSsKpIAb1
 LEzPFGpDkNtXBpRIyb7d0RCKWvK2ncGFV2pDSk4moEgRV2zdCjgtHGRs7mt9cBOqbVoD
 f1yQ==
X-Gm-Message-State: AC+VfDz97IX0FWeSGrNY0cgHf2ZjBjbymaMxKLBWmVp+LeucIJYZOMdG
 lAtCoqgXR52ln/86ETP5P+pD8m5rvQkqjOua01olB+Gr3MHGISGTff6mpidhXV8MKcj3slUAAx4
 B43kC06y5LHoeQZ7ICmPpVaH2PcslPLzKykVJJwywmKpxJDIWwvj5hS/si55p1eSqEHddSvS6c2
 U=
X-Received: by 2002:a17:90a:d908:b0:260:afef:7b6d with SMTP id
 c8-20020a17090ad90800b00260afef7b6dmr7503622pjv.39.1687430038797; 
 Thu, 22 Jun 2023 03:33:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5oVV3+ccHUqlABGtyk7LqNKSHIdiGX+rgX3yOVzPBvzyOSXqr4DJyvhuif0XY77WK7SPaRcg==
X-Received: by 2002:a17:90a:d908:b0:260:afef:7b6d with SMTP id
 c8-20020a17090ad90800b00260afef7b6dmr7503600pjv.39.1687430038411; 
 Thu, 22 Jun 2023 03:33:58 -0700 (PDT)
Received: from localhost.localdomain ([115.96.105.213])
 by smtp.googlemail.com with ESMTPSA id
 29-20020a17090a035d00b0025eb3b237b4sm11004872pjf.44.2023.06.22.03.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 03:33:57 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	jusual@redhat.com,
	imammedo@redhat.com
Subject: [PATCH v2 5/5] hw/pci: ensure PCIE devices are plugged into only slot
 0 of PCIE port
Date: Thu, 22 Jun 2023 16:02:55 +0530
Message-Id: <20230622103255.267289-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230622103255.267289-1-anisinha@redhat.com>
References: <20230622103255.267289-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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
---
 hw/pci/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index bf38905b7d..5f25ab9f5e 100644
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
+                   " PCI express devices can only be plugged into slot 0.",
+                   PCI_SLOT(devfn), name);
+        return NULL;
     }
 
     pci_dev->devfn = devfn;
-- 
2.39.1


