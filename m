Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CC0709A85
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:53:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Tk-0006s7-8J; Fri, 19 May 2023 10:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01TZ-0006lQ-Gd
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01TV-0003sh-4u
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jxcwPV6SSLXLk1OvKnmW9oDhQMoLFlaPkAVdYBMH5QI=;
 b=KupWILlPyJfkUgQ2Q6a8W/hyVC8R6zwF3UOKLJNasQ3zh0pVHi6g3AwlISROY0YPGggxTx
 JogycKOQweL1cjKaQFZvClPVXBUJMGqZGNTOgxPrJoqaQX2vB9/wfb/UuRyaNWgThRT6r4
 YDMEVM4c/Qx4g3hZGHzipGC60fCQqLs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-dpFdiKNtOqicgQa2bp-e-g-1; Fri, 19 May 2023 10:52:55 -0400
X-MC-Unique: dpFdiKNtOqicgQa2bp-e-g-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2af1fd4d30bso6238101fa.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507973; x=1687099973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxcwPV6SSLXLk1OvKnmW9oDhQMoLFlaPkAVdYBMH5QI=;
 b=R8XafMoGTPNuQTaZqu6ke4f8rolWag88FF5Dp2t9i28uIjdk9gF6bAE1tiQsMeUnJe
 fPooL9iSO3pwlmrj6QjJiSW7Wz7Jif/8A/kA57GCnS20PaVN4xZkfG3fuxQDjsuCRMMr
 EFeRnzJ9PyMAv4cd+YPoNVYBRfB15OXo/wRctIOdn1NhPMDPmUh0BNxtuDzs23Y3jW1+
 kQfd9tFfETZRI+BhWy2aOtbfbhxSz8j7AFqZteWzcotmAXhSG+4Lo6n54zyQBtir8Jlg
 C7xHN5hbCtRbI1z7qOOmyNwfxvWKHgdUZj2z+m5gW1TkLnoIh9+qE/4sjqpdbjy8GDsk
 K1+w==
X-Gm-Message-State: AC+VfDz/Z1Q3QRkv7zv0O5J3SDoXSRFPijBLGh3le+7HRDZ0SL51UUNp
 +TOSAX0SVaqcSaWbDgpp9sfxN21SDRr8kdQiKRlow/CQQu831B6h8S22ReUXGRySAV00u9DWfTI
 jgHDXQ0Zs+LLc67wfUgBYgEb00/z1amYUBnzyxGfK72RPN5KpgHCqa2/4O+1CqZlYFg3j
X-Received: by 2002:a2e:9b08:0:b0:2a9:fa39:235e with SMTP id
 u8-20020a2e9b08000000b002a9fa39235emr696627lji.26.1684507973463; 
 Fri, 19 May 2023 07:52:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6KY2S36KGGI76DxiPhy3v16ZCcEto17PLnoSYX5HVqrnrSWbvj2ktMb19Gszk4uswVr9ZHjQ==
X-Received: by 2002:a2e:9b08:0:b0:2a9:fa39:235e with SMTP id
 u8-20020a2e9b08000000b002a9fa39235emr696617lji.26.1684507973107; 
 Fri, 19 May 2023 07:52:53 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 l25-20020a2e8699000000b002a9f1b23604sm858101lji.93.2023.05.19.07.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:52:52 -0700 (PDT)
Date: Fri, 19 May 2023 10:52:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Ott <sebott@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 36/40] hw/pci-bridge: make building pcie-to-pci bridge
 configurable
Message-ID: <6a36a4ced803838cbba5f90b1b765d8ef6255115.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Sebastian Ott <sebott@redhat.com>

Introduce a CONFIG option to build the pcie-to-pci bridge. No
functional change since it's enabled per default for PCIE_PORT=y.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
Message-Id: <72b6599d-6b27-00b5-aac5-2ebc16a2e023@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-bridge/Kconfig     | 5 +++++
 hw/pci-bridge/meson.build | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/Kconfig b/hw/pci-bridge/Kconfig
index 02614f49aa..67077366cc 100644
--- a/hw/pci-bridge/Kconfig
+++ b/hw/pci-bridge/Kconfig
@@ -3,6 +3,11 @@ config PCIE_PORT
     default y if PCI_DEVICES
     depends on PCI_EXPRESS && MSI_NONBROKEN
 
+config PCIE_PCI_BRIDGE
+    bool
+    default y if PCIE_PORT
+    depends on PCIE_PORT
+
 config PXB
     bool
     default y if Q35 || ARM_VIRT
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index fe92d43de6..0edc6c7cbf 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -2,7 +2,8 @@ pci_ss = ss.source_set()
 pci_ss.add(files('pci_bridge_dev.c'))
 pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))
 pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
-pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c', 'pcie_pci_bridge.c'))
+pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c'))
+pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('pcie_pci_bridge.c'))
 pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'),
                                if_false: files('pci_expander_bridge_stubs.c'))
 pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
-- 
MST


