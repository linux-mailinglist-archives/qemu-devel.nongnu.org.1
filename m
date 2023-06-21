Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45024737959
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 04:49:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBnth-0000Mq-KE; Tue, 20 Jun 2023 22:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qBnte-0000M0-HS
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 22:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qBntd-0008WN-35
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 22:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687315716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uiA+TvVu+6/EfH42Nu+lb93pVw8bjcjdn1c2LL6TFiQ=;
 b=G6Q77is5dz7WYNWHvSNqP9mB4kYahDHv7rDkGaPjBLPg0u7DM0I+fzJqvhlZj1me4PTJkK
 p3bqF6yrBobNbSC/20Nf2TANrMtYNkTpy0lyaWeKf/nZNY4BBb5PQb8mOXrcJe/frp7Ug6
 BDBadofsdkLcSO8y2fi7IJqzLwubMkM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-1UqCzw0tN_WIWEjEwFmR8Q-1; Tue, 20 Jun 2023 22:48:33 -0400
X-MC-Unique: 1UqCzw0tN_WIWEjEwFmR8Q-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-66897edaafbso989231b3a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 19:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687315712; x=1689907712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uiA+TvVu+6/EfH42Nu+lb93pVw8bjcjdn1c2LL6TFiQ=;
 b=lvM6itszDKJyK2NEPTf+nE5AcY1YDkJmq4pup9KZrd6v7i0dPFu/lb8aEC3kp2PaI6
 XImhE38RCecnWJOOOj90j/sx1w20s8URiwGPyR5V3K7bi4got4BshIOWZ5dyXSJAltbb
 ow+BqrwYYYL1yyH3fJmbSuB3H1dBN2zte3iEqmVKmPC8UptGiSp/rNFZcACtrJDxc3jn
 GHBnmdeUfO2bjLDtCI9pxSsyXeD7QyfHNAtxYjAbrpkv8154slGSTfiR1sqd98wUp567
 gkp3ov36JOLZ67f5InCK01Wf0gP7RTpmk7MMBM1EnGYMvqn4C3igEz+PDYa4JkZsmtHM
 7/Aw==
X-Gm-Message-State: AC+VfDwkN52Ei6tI752XHShwsR40dlSpeFApHyo1pdlp79fzws6T2PTT
 BHilvKN/9nQrEiYrCLSgqKgSEv80Jra0Bk1KAexFXart71rqNw3VGzYMaa9YuR4DrOOlmzuMozH
 9VOwWoLa5R69X/KU=
X-Received: by 2002:a05:6a00:3a24:b0:668:98a1:5e9d with SMTP id
 fj36-20020a056a003a2400b0066898a15e9dmr5178929pfb.6.1687315712174; 
 Tue, 20 Jun 2023 19:48:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4qNwLf01xeZyXgEqcUhn7ugHfZbZHwvfVz6OVCybVt/+XrbxlkjOy76atPNEyak+ehJ3W61w==
X-Received: by 2002:a05:6a00:3a24:b0:668:98a1:5e9d with SMTP id
 fj36-20020a056a003a2400b0066898a15e9dmr5178911pfb.6.1687315711717; 
 Tue, 20 Jun 2023 19:48:31 -0700 (PDT)
Received: from localhost.localdomain ([115.96.199.101])
 by smtp.googlemail.com with ESMTPSA id
 j22-20020aa78016000000b0064d6f4c8b05sm1949587pfi.93.2023.06.20.19.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 19:48:31 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2] hw/pci: add comment explaining the reason for checking
 function 0 in hotplug
Date: Wed, 21 Jun 2023 08:18:24 +0530
Message-Id: <20230621024824.3779-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
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

This change is cosmetic. A comment is added explaining why we need to check for
the availability of function 0 when we hotplug a device.

CC: mst@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/pci/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

changelog:
v2: moved comment location as per mst suggestion.

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index bf38905b7d..459c7123a8 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1179,7 +1179,13 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                    PCI_SLOT(devfn), PCI_FUNC(devfn), name,
                    bus->devices[devfn]->name, bus->devices[devfn]->qdev.id);
         return NULL;
-    } else if (dev->hotplugged &&
+    }
+    /*
+     * Populating function 0 triggers a scan from the guest that
+     * exposes other non-zero functions. Hence we need to ensure that
+     * function 0 wasn't added yet.
+     */
+    else if (dev->hotplugged &&
                !pci_is_vf(pci_dev) &&
                pci_get_function_0(pci_dev)) {
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
-- 
2.39.1


