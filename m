Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4295744CC1
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 10:35:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFsXL-000896-SF; Sun, 02 Jul 2023 04:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFsXJ-00088V-Bs
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:34:25 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFsXH-0003DJ-Rz
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:34:25 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b82bf265b2so15112935ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 01:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688286862; x=1690878862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gwdt3uLuET3nmTG8rKh0TOme/CSaHT7BuAOTDi2xTjU=;
 b=4HfhOTFwo4ZQgObFVXb4DcQKtcYSW2ZP64gsVPFdgK+h6h3KNrxKgica+cEJbZ3hXw
 LrILMWBNYnIK3i7ga3H66ne50QsgA7jMTmfFnfz7j3e/SknhQ68shADA90i/pd+uG883
 oM+WJxKd4P1VWvxsk7v2PYZmRthe0TTCuqQrlCg4A8zQz4xzaGKNNME8gb16Wv/0wftF
 zY1rko79fzPqMUz5A1kdX/6uNYBZ/mmKp0IZePN+E/uGCeRiqzhvdcEdeRXA9CpTesE7
 UTd5BKclic8vYpx3xqj+qZtlC4u5RCYzOAkFLmMXIiEycRncSjcqlrSw/iRxe1yD9w/E
 mtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688286862; x=1690878862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gwdt3uLuET3nmTG8rKh0TOme/CSaHT7BuAOTDi2xTjU=;
 b=aJoekhdvzls1qtXreB8xyG25nYKOa8GcwiEkJjsy2/R/JgC0jqdOtdpxTUR1EW6L6B
 Wxae7eIwbDSKDGgZo17Kb/KSllvn7IAN6GYqzvOE1anYbSpIbkMoNT6rtlFbnFfA4OSg
 PDL6e3JzHAc453AVN6n/1El9oZwW8YbZK4s0I8BAu5HrWFa8ucSjcdwHboTrGRdMLI9I
 nGn7VodkXXp3t4WAfhCIoXC3le0iwwcG+v4qgJZexnLzNdKLBNXd2uMqLYJr/G0Bi/7i
 GVewm1N7xMxjQBLloKGCMEpb726Vw/rXXfM9d5IlICn3Sm4X3HT6hz+AAykWUhW6dVWc
 FTQA==
X-Gm-Message-State: ABy/qLYpJJldc05AZZBGJD001bb6tLNhRf+IFizU3yWLur5G2ndrDMLs
 C4/32+t33cfl+1t6gMGgi1Lakha8hS2QVI2p/D4=
X-Google-Smtp-Source: APBJJlG2da6S6HV896Ykkfh8xV524Sgf6JAYxpJLQThDAOvKC2WuvMv5udGJ46cKEOFjCm0t+XmA6Q==
X-Received: by 2002:a17:90a:1a13:b0:263:53be:5120 with SMTP id
 19-20020a17090a1a1300b0026353be5120mr5804162pjk.36.1688286862352; 
 Sun, 02 Jul 2023 01:34:22 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 18-20020a17090a199200b0024df6bbf5d8sm7563069pji.30.2023.07.02.01.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 01:34:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 2/3] hw/nvme: Fix ARI next function numbers
Date: Sun,  2 Jul 2023 17:33:55 +0900
Message-ID: <20230702083357.13517-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702083357.13517-1-akihiko.odaki@daynix.com>
References: <20230702083357.13517-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

The ARI next function number field is undefined for VF. The PF should
end the linked list formed with the field by specifying 0.

Fixes: 44c2c09488 ("hw/nvme: Add support for SR-IOV")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index fd917fcda1..6c4809b4f6 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8088,7 +8088,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     pcie_endpoint_cap_init(pci_dev, 0x80);
     pcie_cap_flr_init(pci_dev);
     if (n->params.sriov_max_vfs) {
-        pcie_ari_init(pci_dev, 0x100, 1);
+        pcie_ari_init(pci_dev, 0x100, 0);
     }
 
     /* add one to max_ioqpairs to account for the admin queue pair */
-- 
2.41.0


