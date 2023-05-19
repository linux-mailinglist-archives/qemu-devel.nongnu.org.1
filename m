Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF292709AB4
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:58:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01TD-0005LF-NP; Fri, 19 May 2023 10:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Sv-0004sW-OI
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01St-0003jx-TG
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EcQNtufz3Fzfm9arp8K8qhgvENcT9nU1AXjN4pj1S3g=;
 b=g6bDKFox7l+vyM3bPD5DsPD9YriBdEOSVds0oTMt/Dc5poqjXUU4GrsAS1p9LameYVSTV7
 MkVr2Ig6oJ4tEDgwsgECa/j+dTZYCoLWdG5pHSX9IRUVIEXeI2TaxsJoIuXo41exW8ov7W
 dnKNLQR4iM+wJHOoicYffecMarchl9U=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-i8h5DMBYOoaTRyUIMyTWvQ-1; Fri, 19 May 2023 10:52:10 -0400
X-MC-Unique: i8h5DMBYOoaTRyUIMyTWvQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ac98a3d564so17926081fa.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507928; x=1687099928;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EcQNtufz3Fzfm9arp8K8qhgvENcT9nU1AXjN4pj1S3g=;
 b=BdGejDJsfwPQ/5/8zV8YJTCE1bAmLUNvWgg/PVQNIs04Xc6/X145Np5ronM1jb85XC
 tJLH70ehj90HYUB6HFOEbeykM/bCnuO0lwe2P2/X5eVv6f8VbicAhccrjZMBVlGDe05L
 j8eTGWx3yTiNQMBx96ffQrKzaw44zBCSV9vaiMVWqZp/goKQwL3CbuC8lvpPPutBTtBJ
 cwj1ciJ6c14cYuR8gdDr6eVrU+Q9IYwRivM+D9L321jfvMqeSBPLMdAJyhr857/Dm8Mc
 Q5MsBhRMzd1A8chND5yFi0f1oW8UPSSajVUXPAlf7W04mx6tbMcbcawsfR98+pkQgzzd
 ZPaQ==
X-Gm-Message-State: AC+VfDxH1kkPhb0KN9U+49hpx0LPsk37kayv+x8QkJa8rlfaCwVCNT26
 TmhR3yXHN9+lH27PGchmeZ/6VMezj1X1obZh7117zNQWe62VZNfYT5ssokMgZBaWcpnCKlPP+0U
 HOipuEY6OuKNABymlhN2flQuQeuxELx72wPKlJo7E+/2tAi4i8j5MUlVlSW3e6siju0Dr
X-Received: by 2002:a2e:2e0f:0:b0:2ad:95dd:8802 with SMTP id
 u15-20020a2e2e0f000000b002ad95dd8802mr884319lju.38.1684507927947; 
 Fri, 19 May 2023 07:52:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6cSILmhVP9fLJT9IRvkCEnpslQ18oM/Ojmi2vIUaLqVjoulPeBlh/k+YeZB3D3nad4lAtS5w==
X-Received: by 2002:a2e:2e0f:0:b0:2ad:95dd:8802 with SMTP id
 u15-20020a2e2e0f000000b002ad95dd8802mr884308lju.38.1684507927707; 
 Fri, 19 May 2023 07:52:07 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 e11-20020a2e984b000000b002a9ee18e9c7sm826862ljj.69.2023.05.19.07.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:52:07 -0700 (PDT)
Date: Fri, 19 May 2023 10:52:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 28/40] hw/pci-host/i440fx: Inline sysbus_add_io()
Message-ID: <273d65020b04f8a01e4b5cd543aeef1624b17001.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

sysbus_add_io() just wraps memory_region_add_subregion() while also
obscuring where the memory is attached. So use
memory_region_add_subregion() directly and attach it to the existing
memory region s->bus->address_space_io which is set as an alias to
get_system_io() by the pc machine.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230213162004.2797-2-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/i440fx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 262f82c303..9c6882d3fc 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -27,6 +27,7 @@
 #include "qemu/range.h"
 #include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci-host/i440fx.h"
 #include "hw/qdev-properties.h"
@@ -217,10 +218,10 @@ static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
     PCIHostState *s = PCI_HOST_BRIDGE(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    sysbus_add_io(sbd, 0xcf8, &s->conf_mem);
+    memory_region_add_subregion(s->bus->address_space_io, 0xcf8, &s->conf_mem);
     sysbus_init_ioports(sbd, 0xcf8, 4);
 
-    sysbus_add_io(sbd, 0xcfc, &s->data_mem);
+    memory_region_add_subregion(s->bus->address_space_io, 0xcfc, &s->data_mem);
     sysbus_init_ioports(sbd, 0xcfc, 4);
 
     /* register i440fx 0xcf8 port as coalesced pio */
-- 
MST


