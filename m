Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A30674E205
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:10:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuv-0005CZ-O4; Mon, 10 Jul 2023 19:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzus-0005BH-M7
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuh-0004Fb-NG
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=shxGVXAL5KDbHnl/hVylYQFlgdwxks2fBEctaqulL2A=;
 b=HOvfSAl1qetXjJAc12t83vG0dZrZ/TrMSWeo5oxBq+n7p2fAsK3qZwEY6E5AFPKen1FLLE
 j6oJAyCBiGqzbOdyFyLygfJRZxszKN+2q5fQcKybvXKOsyEzsafpfH4FoB5i3An8dTB3ww
 ygpa8719aZOQ76t0bHDtXQJR7qsiGIo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-QcTZZAkqMByEtjQubdwmWA-1; Mon, 10 Jul 2023 19:03:25 -0400
X-MC-Unique: QcTZZAkqMByEtjQubdwmWA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-315935c808bso908617f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030204; x=1691622204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shxGVXAL5KDbHnl/hVylYQFlgdwxks2fBEctaqulL2A=;
 b=JEQLLeZ+YPuOFe7QWjQ/VxWKD+6gOr2PWypcSV+VxMKiNl/5aDHAG5lKXObGWId3pm
 X/11Z8J1q74Itd8dasbq8eWnjG9LVIT39xKqSWQKy4xueCImSyVvBryMTSM+apgcgZWi
 7Ikj4BvWdkPkKG7Vu/LvMD9zif+P5U3mFrrlloPJSxX3Pw5aTsL5YPAXmq0bDG0QlFEx
 ModB+iWeQr0aR0aGBlioGkeOEmExWS+/x0LeZgW6I14BcWhQWY2qaJdiQ3y4amJh+8gN
 P1/osyaoV+xIqO8Zw6KZHOliANgU85EPUaahMBAS/SSIanCKmM/RLib32rbbRGhWmFFd
 Xbtw==
X-Gm-Message-State: ABy/qLY2iJTYkNG/xMC8HiEkmz88mhMGwmLyd60qhv+fm2Xb1MKuSi4f
 KdcnthOrx3PF6LEyr8psPiAOh+Jd0+7LjA839sr3tbdN5FX1dqmeYtASeEqN2K4ACpfoy9oLW00
 V4RuKlwDwf8lqCHmNg1qOZdzMSToyPERUl+tRtIqQEwZtlf+ieQZ6BvQalnvC+esixZ4Y
X-Received: by 2002:a05:6000:104d:b0:312:849d:acc8 with SMTP id
 c13-20020a056000104d00b00312849dacc8mr12624209wrx.9.1689030204178; 
 Mon, 10 Jul 2023 16:03:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHNx7UVKOZ90QkQPHHufjUTCikO1BER8KIApEK5O55lqCYI7Tx1iyDXJNS3ELlsVhXzxH7/AA==
X-Received: by 2002:a05:6000:104d:b0:312:849d:acc8 with SMTP id
 c13-20020a056000104d00b00312849dacc8mr12624198wrx.9.1689030203975; 
 Mon, 10 Jul 2023 16:03:23 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 o6-20020adfeac6000000b00314145e6d61sm613437wrn.6.2023.07.10.16.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:23 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 20/66] hw/pci/pci_host: Introduce PCI_HOST_BYPASS_IOMMU macro
Message-ID: <3b20f4ca59b53f10240d94cdb3f482c116640437.1689030052.git.mst@redhat.com>
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

From: Bernhard Beschow <shentey@gmail.com>

Introduce a macro to avoid copy and pasting strings which can easily
cause typos.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20230630073720.21297-5-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci_host.h | 2 ++
 hw/pci/pci_host.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index c6f4eb4585..e52d8ec2cd 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -31,6 +31,8 @@
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
+#define PCI_HOST_BYPASS_IOMMU "bypass-iommu"
+
 #define TYPE_PCI_HOST_BRIDGE "pci-host-bridge"
 OBJECT_DECLARE_TYPE(PCIHostState, PCIHostBridgeClass, PCI_HOST_BRIDGE)
 
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index dfd185bbb4..7af8afdcbe 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -232,7 +232,7 @@ const VMStateDescription vmstate_pcihost = {
 static Property pci_host_properties_common[] = {
     DEFINE_PROP_BOOL("x-config-reg-migration-enabled", PCIHostState,
                      mig_enabled, true),
-    DEFINE_PROP_BOOL("bypass-iommu", PCIHostState, bypass_iommu, false),
+    DEFINE_PROP_BOOL(PCI_HOST_BYPASS_IOMMU, PCIHostState, bypass_iommu, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
MST


