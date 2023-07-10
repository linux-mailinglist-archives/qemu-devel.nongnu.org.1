Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE47674E1E8
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:08:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwf-0003YZ-81; Mon, 10 Jul 2023 19:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwU-0003Bl-HH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwS-0004pO-T7
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=epa7wwkAgwMEyNmrkfxcZV2wLqeDQswBEeLehQ/hP44=;
 b=NjVpQO4ArYtOGZbsbw1uIACboxw7X9OE/tmzrljckP9NmQ8cQTozJ4cfooQVzjL+JNJ+El
 +T6j4fXbHpXHNJqb2Z9X5u7pA/qK7jNIWKUteKWB4g5BcQL+brdddR7vj4kRcdoJt++Nqr
 oEJd4nhEl9jKOO0t2r/Qb4Ik2/K/KLU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-oqsZ6bI8PUCt0SJP-_obtQ-1; Mon, 10 Jul 2023 19:05:14 -0400
X-MC-Unique: oqsZ6bI8PUCt0SJP-_obtQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fc00d7d62cso21843865e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030312; x=1691622312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=epa7wwkAgwMEyNmrkfxcZV2wLqeDQswBEeLehQ/hP44=;
 b=fPZ0RLgRWwxcwTVW4HFeOI8xzLPkkDp5zKRwCfh9wPeugwTBSu0JhFJRq/lKtgfs7z
 0lReIhIEjwqwpcM3yVW7/Mi8kPj3Fhwma7bKuUEf+ODaS0tO6HGdzO4t0aCNLGq3Tr20
 uvn8fH28KCg8M3n1SUtLsxKayPbXXSeWgwgaxQKUag5UwMfXubaP3vmYzWqDrHfgGIN9
 /ZxiA3ltyhkieFhrvgjKZJ4TzP9y7ENGZfQH8L08kPE17B1yMiDOT3Eopb6MaxLPhJMY
 pRI4f0dEqlMJxXJzQivB45VQEoUoT86SxAVn8hAR5UzpXH70hULLmSYHd7o5luTHVT71
 TjtA==
X-Gm-Message-State: ABy/qLauYp3SDmnFUzmP9+yJ1XAnpN1mwzuVybPnlU88U2dLuYl4moSA
 5SaJr/78YXjFgovbwO1DYbvNTkNjFXAV/G0klMGD4j+K2rivO5/C4eKcrhZl53KAX/rQPk0PdtC
 3jxXIxrgLLhfqjSjfRme56Cljf/5UAMPXoYFzhrRTTmeJZDbJ3qMd2fyi8Az1O54ZDX5l
X-Received: by 2002:a7b:c7d9:0:b0:3f5:146a:c79d with SMTP id
 z25-20020a7bc7d9000000b003f5146ac79dmr12859754wmk.15.1689030312203; 
 Mon, 10 Jul 2023 16:05:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxMBKJXilRpzMNn6lh3y5L0zn+yCSFEnhOgpIz4IUJcqtOQyqAl5Jkv+0ifeqDymjR3jKkGA==
X-Received: by 2002:a7b:c7d9:0:b0:3f5:146a:c79d with SMTP id
 z25-20020a7bc7d9000000b003f5146ac79dmr12859732wmk.15.1689030311889; 
 Mon, 10 Jul 2023 16:05:11 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c470a00b003f9b3829269sm21830452wmo.2.2023.07.10.16.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:05:11 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:05:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 57/66] pcie: Specify 0 for ARI next function numbers
Message-ID: <7c228c5f3301113ffd7cfee7f982e7ae04c8ffda.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

The current implementers of ARI are all SR-IOV devices. The ARI next
function number field is undefined for VF according to PCI Express Base
Specification Revision 5.0 Version 1.0 section 9.3.7.7. The PF still
requires some defined value so end the linked list formed with the field
by specifying 0 as required for any ARI implementation according to
section 7.8.7.2.

For migration, the field will keep having 1 as its value on the old
QEMU machine versions.

Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
Fixes: 44c2c09488 ("hw/nvme: Add support for SR-IOV")
Fixes: 3a977deebe ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20230710153838.33917-3-akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h | 2 ++
 hw/core/machine.c    | 1 +
 hw/pci/pci.c         | 2 ++
 hw/pci/pcie.c        | 2 +-
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index ab2bd65a3a..abdc1ef103 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -209,6 +209,8 @@ enum {
     QEMU_PCIE_CAP_CXL = (1 << QEMU_PCIE_CXL_BITNR),
 #define QEMU_PCIE_ERR_UNC_MASK_BITNR 11
     QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
+#define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
+    QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
 };
 
 typedef struct PCIINTxRoute {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 46f8f9a2b0..f0d35c6401 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,7 @@
 
 GlobalProperty hw_compat_8_0[] = {
     { "migration", "multifd-flush-after-each-section", "on"},
+    { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
 };
 const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4b14f31859..784c02a182 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -83,6 +83,8 @@ static Property pci_props[] = {
     DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
     DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
+    DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
+                    QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 6075ff5556..6db0cf69cd 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1041,7 +1041,7 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
 /* ARI */
 void pcie_ari_init(PCIDevice *dev, uint16_t offset)
 {
-    uint16_t nextfn = 1;
+    uint16_t nextfn = dev->cap_present & QEMU_PCIE_ARI_NEXTFN_1 ? 1 : 0;
 
     pcie_add_capability(dev, PCI_EXT_CAP_ID_ARI, PCI_ARI_VER,
                         offset, PCI_ARI_SIZEOF);
-- 
MST


