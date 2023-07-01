Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC67E744785
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 09:03:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUcM-0007WC-GQ; Sat, 01 Jul 2023 03:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFUcL-0007Vf-26
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 03:02:01 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFUcJ-0000kR-KE
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 03:02:00 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34574014304so12596585ab.2
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 00:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688194918; x=1690786918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zsb2EYoYtxi+hLo7fouc8vYS/YOxaACOuCfNLuemkEQ=;
 b=iZY7kq6aeR/PgC7qI3f7TcEMIxZR2ybdEGv4MOhRUBV0XemoJnimyY3ogg9DfK9VRv
 GLPSVvh7AwEyvJqx7zZjsa2+298ennzbJoJzfQyKaciCUwMrjiKF4TNcpeRqCbnPyebk
 m8hTndB49lxkL60HEIUnF0kWgBGe1Y1LLNRyENJx2Yro4w6keU/UBlO5TllwFjhxQmz1
 IApSs7Ms/w4kOVQLuKs09wEZmj7pXVZoauk08mFRLUVioUMgz8VCxW//ZW28ouZ0rn1w
 V02qzQLC67wpkIulB2bWPkX1HsxRFXX4PyQDVRy9DQs4gPTlv5DypC4ZPzY9ZDk8YUgt
 S4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194918; x=1690786918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zsb2EYoYtxi+hLo7fouc8vYS/YOxaACOuCfNLuemkEQ=;
 b=UixAb9Cmde/rO5+6I7QCOkITRunP5v68tUxLhoW/STwQePu6wQj4hwW+sCa6+k98SI
 64CoyOt9NhiPzn1WqXsRrn0biRIySD7f786uDGepZAsxX2AXLUAYNH1lRdQ25zx0yiKU
 bVEZgdMIthlLQ+b46pss9AZoMcjs0NHL5UqfifITHekO8UaLxowpM/15j56KThQNkiPF
 WysUd8n6ex0ZoR74ulJW6YYKMOTUoREm5D7jLbkD47uarCpMi2cSR9kzUzUZE73DoUt3
 9IpSkYnjxFJZBpXLgvMMI1pohlpkOPVzvPhEUHg/KmFtdNfqjDHHwUEH0iQH2DdO4J9R
 a7aQ==
X-Gm-Message-State: ABy/qLb5dp21sjXw1m7ptQvcgkUqF9VuOKw5OtQpObVyWSGf7MmzCPYQ
 U+Ur2ue98UGyHglyEUujlrOBC9VC0PJRkkHozN0=
X-Google-Smtp-Source: APBJJlFlZ35B0rIZQzKfg3jTelGySVWGLopojw53KLoqCITw5ZsL2UZZX0SuJOz+DVy5uNgawZdFdg==
X-Received: by 2002:a05:6e02:5d0:b0:345:b97e:6ba5 with SMTP id
 l16-20020a056e0205d000b00345b97e6ba5mr4380053ils.4.1688194918067; 
 Sat, 01 Jul 2023 00:01:58 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 jd4-20020a170903260400b001b1920cffdasm5592452plb.204.2023.07.01.00.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Jul 2023 00:01:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 2/4] hw/nvme: Fix ARI next function numbers
Date: Sat,  1 Jul 2023 16:01:20 +0900
Message-ID: <20230701070133.24877-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230701070133.24877-1-akihiko.odaki@daynix.com>
References: <20230701070133.24877-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::131;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x131.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The next function numbers are expected to form a linked list ending with
0.

Fixes: 44c2c09488 ("hw/nvme: Add support for SR-IOV")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/nvme/ctrl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index fd917fcda1..12500dc80b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8088,7 +8088,12 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     pcie_endpoint_cap_init(pci_dev, 0x80);
     pcie_cap_flr_init(pci_dev);
     if (n->params.sriov_max_vfs) {
-        pcie_ari_init(pci_dev, 0x100, 1);
+        uint16_t nextvfn = pci_is_vf(pci_dev) ?
+                           pcie_sriov_vf_number(pci_dev) + 1 : 0;
+        uint16_t nextfn = nextvfn < n->params.sriov_max_vfs ?
+                          NVME_VF_OFFSET + nextvfn * NVME_VF_STRIDE : 0;
+
+        pcie_ari_init(pci_dev, 0x100, nextfn);
     }
 
     /* add one to max_ioqpairs to account for the admin queue pair */
-- 
2.41.0


