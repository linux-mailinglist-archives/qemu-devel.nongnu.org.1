Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA42801B47
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:02:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9KwR-0004Uw-I5; Sat, 02 Dec 2023 03:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KwK-0004T1-8s
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:28 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KwH-000570-R0
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:28 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-58dd3528497so1797595eaf.3
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504080; x=1702108880;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EJKlP980j1vymql3ZbAFDs9X/sipZ2vUntUb8CsD+hw=;
 b=qzztkFsMiZXicgKfZAErMlb45/Ek14P59Fk0lqXcPsmP8bJ5YQgL49mOk3e/UzbeeA
 PRivRHWsdaPGPsnPlltX30aVl2JSX9z7xA95aA0Qj8PtcdDQXKM82XdGqvS5GzXUhTkr
 k5w0PIK/VotXO8qRm3ZvoMK/pq3sS7yU+ZbpJdZTEnt8BM/lK5sMScC5MkNhHoeTZCa3
 /U4dGp7ZKIfTTEbeBr49FXPdA2IcHSA625Oo44kAk8iF4+MecIm3F1tEsAmFILAGJdjf
 8h3UEMJTu5uh7+rv7A2/vkulpEzGMa0KAgS2ma1ttJJFZ4NWQeZc+1Xpby70R8VaNzkc
 4VTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504080; x=1702108880;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJKlP980j1vymql3ZbAFDs9X/sipZ2vUntUb8CsD+hw=;
 b=YYIBSFGZzDRSDn+rowFLmwhP6772DzPHS+h527SaAmtJ4f/YN9n+E0xXEWfuyWghcB
 21opVpuRMqFyoEPqzl2upA5k5YCYzxbHyRk6/khLhe4wmZ/Z/zorMuuJfWLmUtIq7iSu
 htzTO2OVJk7Q0dXpmexUdbEU4kQUieGc7HTr4vLSHQtNujMHpKVX7gpri89eCfU3CUKu
 Nv3yN8UD/abhIYiurVcVBsXPprbX8rgB09JDJjviAmgQwVbAru/azwFR42kdcQtB1RkJ
 Vdp3e0QMPGDEy5DHG4nC1q/nDWSgm3AN6LryzqbQCSAYkCtlPaqN3zP2lhN9NlyBL2kU
 7QhQ==
X-Gm-Message-State: AOJu0Yz0CtPGQbPdtiVJmeKCyxgsSApD3XyMX0ApWgLRY2ee87ernfGa
 c8IN/mBaRPMM/BT3vLgLnLTXvw==
X-Google-Smtp-Source: AGHT+IGl1xSaOUVIStAYcsjT9z1wwbZHHdfzfiQI1mWTWFnzs+CqB5eJ7dLu+B0vvqwtuVmVo5I4XA==
X-Received: by 2002:a05:6358:524d:b0:170:17ea:f4de with SMTP id
 c13-20020a056358524d00b0017017eaf4demr1029361rwa.43.1701504080606; 
 Sat, 02 Dec 2023 00:01:20 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 h2-20020a170902f7c200b001d0695106c4sm1260063plw.105.2023.12.02.00.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:01:20 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 02 Dec 2023 17:00:33 +0900
Subject: [PATCH 10/14] msix: Call pcie_sriov_vf_register_bar() for SR-IOV
 VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-sriov-v1-10-32b3570f7bd6@daynix.com>
References: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
In-Reply-To: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A SR-IOV VF needs to use pcie_sriov_vf_register_bar() instead of
pci_register_bar().

Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/msix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index ab8869d9d0..3b94ce389f 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -421,8 +421,12 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
         return ret;
     }
 
-    pci_register_bar(dev, bar_nr, PCI_BASE_ADDRESS_SPACE_MEMORY,
-                     &dev->msix_exclusive_bar);
+    if (pci_is_vf(dev)) {
+        pcie_sriov_vf_register_bar(dev, bar_nr, &dev->msix_exclusive_bar);
+    } else {
+        pci_register_bar(dev, bar_nr, PCI_BASE_ADDRESS_SPACE_MEMORY,
+                         &dev->msix_exclusive_bar);
+    }
 
     return 0;
 }

-- 
2.43.0


