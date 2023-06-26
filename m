Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8FC73E255
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:42:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlZq-0000FD-SS; Mon, 26 Jun 2023 08:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDlZI-0007fH-Ex
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDlZG-0006tU-MW
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687783421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFaGSHVuQ/MJdrogUY2Zw/pcgRXL686O5bdoo9qhITc=;
 b=QFzM/kWGQwqQU2GnCATxEnsxpzHIeNYE3dpuf9J/REzYFafpL58ZGMayrsBT8Rg++ZYr7D
 8mOVzKswuJ8l8aVu9FVxh96vLAN+4bNKQswDsOd71zd9ezIcA+PaxeucFg/nOKdlu7BU9Z
 wYkqDgdZSAgJQkbK1HPlENrsTAVPSC4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-yRDWorS2N7uoDxNIbWnTug-1; Mon, 26 Jun 2023 08:43:40 -0400
X-MC-Unique: yRDWorS2N7uoDxNIbWnTug-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1b508a0873eso14367865ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687783418; x=1690375418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFaGSHVuQ/MJdrogUY2Zw/pcgRXL686O5bdoo9qhITc=;
 b=EqdsGeObnBR1tTA2BkPStha2gKJjSSGgiNvFh6YD08J3DacZ6AaagTCYfQRoFYdmq2
 Jj7dwkfb/YILUfmjxHG0XzuezrjldjXZcSTIuRCpZgqIs4rYIpZem8pGvStfolcuhEsK
 55qx35+FeNtye67mMOhJTgL8h/m4nYp8KSXU34BvcAE1kRXY1EvgeYnjwJ9uFG7kv1/L
 ORBuiVj1WmkjS7oJRFUe59pa53SNCUouLJ96mg3yAW+H4bc2lKf1mlJ6Lc1zzh7fMJhD
 IkgWUmaXlzTbc8CssQPlyhm3qXQgd6eiEpWDdFYOx1KAkFuo4o09EQlSKeIdZ5oyEq8u
 dNIQ==
X-Gm-Message-State: AC+VfDwPGhain8gbcg3S/KgM6YRjQBc9XKvYJVP06AsukagRDbx2nxJq
 tMTbSsvyQVillg8GiV4JH4SaaVw+z3Ii00mK5LxQTnQTj34SNslIIqHF9E0IW+hg6iex6Jb2MRG
 q9AHVt8/P3iVUAdEV0VLJpf6tUxgkm9PKSQrvwnLn7P4wJtGg9RJBQjxMYKyGvGwv9H6bmQoh1j
 I=
X-Received: by 2002:a17:902:bb87:b0:1b8:535:57e2 with SMTP id
 m7-20020a170902bb8700b001b8053557e2mr1717526pls.69.1687783418632; 
 Mon, 26 Jun 2023 05:43:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5pxuHABGpn0cq0FCVDk6frUup04N3Qt7m7OKPdpV4EIKQiXeBDOZfr9j962nwv4G2pkMOPGQ==
X-Received: by 2002:a17:902:bb87:b0:1b8:535:57e2 with SMTP id
 m7-20020a170902bb8700b001b8053557e2mr1717512pls.69.1687783418288; 
 Mon, 26 Jun 2023 05:43:38 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 j22-20020a170902759600b001b3c892c367sm4111671pll.63.2023.06.26.05.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:43:37 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	jusual@redhat.com,
	imammedo@redhat.com
Subject: [PATCH v3 5/5] hw/pci: ensure PCIE devices are plugged into only slot
 0 of PCIE port
Date: Mon, 26 Jun 2023 18:13:06 +0530
Message-Id: <20230626124306.4572-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230626124306.4572-1-anisinha@redhat.com>
References: <20230626124306.4572-1-anisinha@redhat.com>
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


