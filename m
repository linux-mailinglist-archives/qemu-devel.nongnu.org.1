Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C05DF744D0D
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 11:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFtfU-0003oE-Js; Sun, 02 Jul 2023 05:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFtfN-0003mc-2b
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 05:46:54 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFtfL-0007j1-KP
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 05:46:48 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-55b1238a013so2411218a12.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 02:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688291206; x=1690883206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P46Fz3KmMMoBs0YAqCjAY4+LmuCjaIetWje4x1NrkhE=;
 b=d3qQdDjR8S0Hnhn36eoNzp93CZjdAIkIMuphKMSAXl3JTy14soC+hQjE2cbrdDUf2h
 70bG6mDciTkSA3ZEz1u2bzYZvukBnhWESUC9Wmz2Pw+mXw4cSYbk6GAM71a+LRwk9xCp
 InYFpCciyr3iEbjjENn37HLBreRvTTJcgRn9QH9eG69Q0NY7Q9WDV4VrhBQuzS1G7YWs
 n8gkBYWAwQNqi09yPlxrx7RKm9l4312WZP3Yod4pwo/90ms8Q6DtlAJcFqtPF9vYY4M3
 hf8Z62vKskoNcTKtSveZQ5DIR7WUluadxh5aQZVpQVO/gCJ9iHP8n6UX3tUaCQ6DXty6
 3tvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688291206; x=1690883206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P46Fz3KmMMoBs0YAqCjAY4+LmuCjaIetWje4x1NrkhE=;
 b=dJBBzdzy0fEi1ZawLEbAJQL7F65PzoKo55d0+lPnC4kd9WlPlTJ3WoTOhFN1FAeOvh
 dKbJN6RSslvT8igbxuobofLiDrTEJuXeau+EfFB1zC9zv1EP53HYYZ3r/i5Ou/Mq8BA+
 B1FlohaGbzc5527t9mSEx3fKBL7K8xSJZ853bUKDefmKG4MLD85P9JHme+9nR7GfKo7Z
 OpdH8fcr/qIwcTSbhupBkaf9WiUYzKHdt/VtCrqPFQrwINprY4EIgcwWW+MnvybI75C9
 Jz8HzWjhO3mYQEFB1WiWstuBZcSSm4EgLpaTVvWDSZi/vSBo0/3TLe1RVvUBRoZ2XX2+
 QX8w==
X-Gm-Message-State: AC+VfDxUJMMrpClc1XBrSQXMEjp17ilw8bdJY8ysUcn2m5SjtTpDNidl
 XZaJcKuK0Cp7f2KSDEVEIO7KJTlJXlkV5JWio8w=
X-Google-Smtp-Source: ACHHUZ6Uf++OHPCnA2v76oL/AeCODLF+njIckP51dz9vHvgXneBO9bezUbEi0NrGrWUmTFA0VmTaQw==
X-Received: by 2002:a05:6a20:8f07:b0:122:a808:dbbe with SMTP id
 b7-20020a056a208f0700b00122a808dbbemr10254632pzk.29.1688291206198; 
 Sun, 02 Jul 2023 02:46:46 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 i1-20020a635841000000b005348af1b84csm12934067pgm.74.2023.07.02.02.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 02:46:45 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 3/4] igb: Fix ARI next function numbers
Date: Sun,  2 Jul 2023 18:46:27 +0900
Message-ID: <20230702094631.39111-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702094631.39111-1-akihiko.odaki@daynix.com>
References: <20230702094631.39111-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
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

The ARI next function number field is undefined for VF so the PF should
end the linked list formed with the field by specifying 0.

Fixes: 3a977deebe ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/core/machine.c | 3 ++-
 hw/net/igb.c      | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index f984a767a2..1f5aacd1dc 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,7 +41,8 @@
 
 GlobalProperty hw_compat_8_0[] = {
     { "migration", "multifd-flush-after-each-section", "on"},
-    { "nvme", "ari-nextfn-1", "on"},
+    { "igb", "ari-nextfn-1", "on" },
+    { "nvme", "ari-nextfn-1", "on" },
 };
 const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
 
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 1c989d7677..d37d43c155 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -78,6 +78,8 @@ struct IGBState {
     uint32_t ioaddr;
 
     IGBCore core;
+
+    bool ari_nextfn_1;
 };
 
 #define IGB_CAP_SRIOV_OFFSET    (0x160)
@@ -431,7 +433,7 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
         hw_error("Failed to initialize AER capability");
     }
 
-    pcie_ari_init(pci_dev, 0x150, 1);
+    pcie_ari_init(pci_dev, 0x150, s->ari_nextfn_1 ? 1 : 0);
 
     pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
         IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
@@ -582,6 +584,7 @@ static const VMStateDescription igb_vmstate = {
 
 static Property igb_properties[] = {
     DEFINE_NIC_PROPERTIES(IGBState, conf),
+    DEFINE_PROP_BOOL("ari-nextfn-1", IGBState, ari_nextfn_1, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


