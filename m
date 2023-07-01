Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64975744784
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 09:02:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUcP-0007Xa-9w; Sat, 01 Jul 2023 03:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFUcN-0007X3-Ae
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 03:02:03 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFUcL-0000l0-LI
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 03:02:03 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b7541d885cso2313089a34.3
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 00:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688194920; x=1690786920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RgH91GA1gaWvFQByNsH0yzA9IIim4f6UGgM6Gv3rCI=;
 b=0QjaeIMVAWgnc4u9M8lhJJHwlcaDLyD+iCct15Iz7nKtsynsFn+FKvnVVUud668Kfe
 gsvM3eULY+wE5PPpFHF0pz3Wl6BqPBvqFODZ3VWQT7vSbrM5W/GaghSGLhHSb+JHArss
 mN8KILguVREIT9MSabcuXxojNG78qkYfIWmgBdQrIWP/xPw80LhjsAegerCoYqTARKgx
 KnjE0IPnPyxI7tWo9JOCRM4k3ykHRANEr2/D2ODOpZrNSAg6i/SJaCRF4Sq3arko+fMe
 b4tKlpYWHTBQKtB5NPv6zgaOW8EfOQELyYWgnK/htpWko5kzZXeM+LiJNT1Zppp4YR+v
 lFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194920; x=1690786920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RgH91GA1gaWvFQByNsH0yzA9IIim4f6UGgM6Gv3rCI=;
 b=TwiWMHiikhYCnBXpqLG9oY/wKBeWiClUHBSIJDbO/MaG+tjY8Rv76L5HygLZQEYZAZ
 Nu/G1EyG748tfNoLg2PyQXqlzSJMG35iSRlLjOastbRLE5FM0QKS7LmMyy1BJrF1risx
 VDcUAZER7BZhKaeEDfsalfNIC7R3U19RK/QHdb9yI1wbS22EKDkMcsL7KJjJ5++PKwQK
 1eXq2iJdpOYxk6AB4k6EmFtKx7gizdRz7PIvOP/SqnlqOq+JjO2YrTRo04sBfe71Ib/s
 k62bV0BhLlT8GBRZomF8A+U4hTTf0L3yMRhjVO+c8yXdskS0SwtBUYuLwclqCDwo9VVh
 KzMQ==
X-Gm-Message-State: AC+VfDxZ7/mx3klWTUNZM4hYvz3/lm5VuPyxk4woHYdOeb0oObsWqpmc
 4gIrt3MFUr/HdloVzjvCfY4lpM86lE/q9btZbi8=
X-Google-Smtp-Source: ACHHUZ4XDsw5p0b9L3kABCaZFDbZ8/2Ed6cLnRs6NnotJ513K9paBSE5K9mUBLrjLGzWh9S/G1MZlQ==
X-Received: by 2002:a05:6830:c4:b0:6b7:470c:931f with SMTP id
 x4-20020a05683000c400b006b7470c931fmr5682561oto.1.1688194920587; 
 Sat, 01 Jul 2023 00:02:00 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 jd4-20020a170903260400b001b1920cffdasm5592452plb.204.2023.07.01.00.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Jul 2023 00:02:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 3/4] igb: Fix ARI next function numbers
Date: Sat,  1 Jul 2023 16:01:21 +0900
Message-ID: <20230701070133.24877-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230701070133.24877-1-akihiko.odaki@daynix.com>
References: <20230701070133.24877-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x329.google.com
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

Fixes: 3a977deebe ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/igb_core.h | 3 +++
 hw/net/igb.c      | 4 +---
 hw/net/igbvf.c    | 5 ++++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index 9cbbfd516b..e1dab76995 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -49,6 +49,9 @@
 #define IGB_NUM_QUEUES          (16)
 #define IGB_NUM_VM_POOLS        (8)
 
+#define IGB_VF_OFFSET           (0x80)
+#define IGB_VF_STRIDE           (2)
+
 typedef struct IGBCore IGBCore;
 
 enum { PHY_R = BIT(0),
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 1c989d7677..543ca0114a 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -81,8 +81,6 @@ struct IGBState {
 };
 
 #define IGB_CAP_SRIOV_OFFSET    (0x160)
-#define IGB_VF_OFFSET           (0x80)
-#define IGB_VF_STRIDE           (2)
 
 #define E1000E_MMIO_IDX     0
 #define E1000E_FLASH_IDX    1
@@ -431,7 +429,7 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
         hw_error("Failed to initialize AER capability");
     }
 
-    pcie_ari_init(pci_dev, 0x150, 1);
+    pcie_ari_init(pci_dev, 0x150, IGB_VF_OFFSET);
 
     pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
         IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 284ea61184..bf2f237ab5 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -240,6 +240,9 @@ static const MemoryRegionOps mmio_ops = {
 static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
 {
     IgbVfState *s = IGBVF(dev);
+    uint16_t nextvfn = pcie_sriov_vf_number(dev) + 1;
+    uint16_t nextfn = nextvfn < IGB_MAX_VF_FUNCTIONS ?
+                      IGB_VF_OFFSET + nextvfn * IGB_VF_STRIDE : 0;
     int ret;
     int i;
 
@@ -270,7 +273,7 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
         hw_error("Failed to initialize AER capability");
     }
 
-    pcie_ari_init(dev, 0x150, 1);
+    pcie_ari_init(dev, 0x150, nextfn);
 }
 
 static void igbvf_pci_uninit(PCIDevice *dev)
-- 
2.41.0


