Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 077B374E1D0
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:06:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzvd-0008H0-Jd; Mon, 10 Jul 2023 19:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvV-0007wO-3P
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvT-0004Tf-Js
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DsnG6X5s9gl0JGqrN3ljzYWE2z5sJ0pUx0PXwD0gJHI=;
 b=Tf0d8m6s6kXv6gWx7xzFv7SAgwpiYKhVdUyr/G3+nrPMwjemoW/N2a7kXmkcbOWINuTn1A
 DfoK3GDvrOeY4BSu8EyDprclvw1NkPB6Tu5Hky21vtUXaJldKmOB1AfJaGHET/YJHEq/0S
 i5vhkzvtx5xm5Sieftcw0fBtFVjwtxo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-0lRwuUoWMv2eRDRWZyNIpw-1; Mon, 10 Jul 2023 19:04:13 -0400
X-MC-Unique: 0lRwuUoWMv2eRDRWZyNIpw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-314291caa91so2830055f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030252; x=1691622252;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DsnG6X5s9gl0JGqrN3ljzYWE2z5sJ0pUx0PXwD0gJHI=;
 b=DQs9B6TCtIMq37E/OGZaATguMyjqWaWN0mUkwwWYrE+2dXC4lUzJV3BsxmVSXzzzkg
 5w2WBiQGt0XVN8rm6gGL4Jfu9PbjtDNBCfA9o0PEhsX5G1Ay0Lbw/uxaS2YcRWr11vi9
 i40yw8sbD9oAf9WsGLQ3Ttq8gZ0PbC+adRKr2PjhjHjvVR2QZGmPG8Hpw5daXkn5+EQj
 JDiQ+s8MI0jvRuUB5yrz7A7HYjOY3OIWh7QE9gO7tx5WHjl8UttOwlWnBV1OJu2w1MrR
 3CKDIGoN/OYzEXy+lxu+kuoi18ERtg7ArLYv39WiinyLMaKoMaYTJH3Pe9MnE1pNdEY6
 3Eqw==
X-Gm-Message-State: ABy/qLaL+EswmGkTMEWhOqSz+HJrLnbVDLjYTCOlkN6Rs0rv2kkILRRp
 flWR6+JhhDQebt7z/hSt5+fZt3T5YRsPjFJpGJa2ivsOfDvQlH9q0lyXCelPruz5zUrpktKeEH2
 N1LRT3/fpJVpykVQyzRRxjqYRdv+XiMuoJXIiPJv26ku5X98ujD4LcINpALJXx8m7KLnb
X-Received: by 2002:a05:6000:1b86:b0:314:34dd:aaec with SMTP id
 r6-20020a0560001b8600b0031434ddaaecmr13486286wru.8.1689030252275; 
 Mon, 10 Jul 2023 16:04:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGYMv9RdHe2vGbh2EP7bm8yf+2GKK3I6ZmwMeoiVOYWEUri7/dHpLViUI8VDKgLllGIu089cw==
X-Received: by 2002:a05:6000:1b86:b0:314:34dd:aaec with SMTP id
 r6-20020a0560001b8600b0031434ddaaecmr13486265wru.8.1689030251961; 
 Mon, 10 Jul 2023 16:04:11 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 x6-20020a5d6506000000b003143b14848dsm562689wru.102.2023.07.10.16.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:11 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 36/66] pcie: Release references of virtual functions
Message-ID: <08f632848008544b7e1ab8a8aa50df02c39a26a1.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

pci_new() automatically retains a reference to a virtual function when
registering it so we need to release the reference when unregistering.

Fixes: 7c0fa8dff8 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230411090408.48366-1-akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/pci/pcie_sriov.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index aa5a757b11..76a3b6917e 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -211,6 +211,7 @@ static void unregister_vfs(PCIDevice *dev)
             error_free(local_err);
         }
         object_unparent(OBJECT(vf));
+        object_unref(OBJECT(vf));
     }
     g_free(dev->exp.sriov_pf.vf);
     dev->exp.sriov_pf.vf = NULL;
-- 
MST


