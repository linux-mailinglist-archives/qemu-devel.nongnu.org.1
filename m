Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B81777942F
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUqD-0001An-5x; Fri, 11 Aug 2023 12:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qUUq5-00019u-13
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qUUq3-0002uh-Iz
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691770690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wDyi34CPiY9sRWLlpPZ1XFJfj8vpMoJLeBIuoJ5wE/0=;
 b=TePZUnawkO2UzKH6CKMZ7d20dbzQgcG/lAea9pzzMbVe2ARSGudWLZaS8Lx4JS9Dl1Ebjs
 DQW2RgV57E/m5tavq8ivj9daVxTluU/OValz3ByGFqx49hxO/FIlHIY+o1fwmf0fIKpgLI
 lbOjS67Q5ZgjEqErfBmbN4qHxDjoyoA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-RN0NeuuUNd64E5aXkGIzVA-1; Fri, 11 Aug 2023 12:18:09 -0400
X-MC-Unique: RN0NeuuUNd64E5aXkGIzVA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4fe0f24e801so2123357e87.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691770687; x=1692375487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDyi34CPiY9sRWLlpPZ1XFJfj8vpMoJLeBIuoJ5wE/0=;
 b=kM7ZbGMgvX/9sATCsp5In7g5/RgVpg9Pvn5Iu4rp+IzFkG9n9Y4kZwS1biLw6xqB2U
 oCRDYbpwpFm4Edml0haYK42pNYvpGE6N5hpUmtiqbuVy71oIL3jMZX+x1IhFlNs+nlmR
 3b//N+GUYl8+aakP/bM3km90uqmu2f0fJ98Mh9aChQhpp3Gnr1lg9PZ6Au9iwXJ5R4gt
 BMSdkkQpX8EG5KAuwCPZ+CzXiZzH2RwekYuYOovk2UttahW9qd42ey83IwAMfAPQnN4f
 ty9xxr9WWN4kS10jrpkhOD3rfbtLbzPjC5USxhjArD2OvP4WC7PrzyaqknprMgPpUI+5
 KImg==
X-Gm-Message-State: AOJu0YziVYICWnksIQZ8wsMX64gCnEExENMgu9T5//rs1w8b68Y5YU/W
 ryU4qJxwgWMg7TfpMALfH+6MWcu0yYyXdZA4prXOyy9FazC9kigi0gSXqspXahodm3CYwe0FJrH
 Al2KDgDisQ9RcF+93iTR/YTuzmyAUFBFMBja6BSXEFeXgSl6tFos61IaYBAUuXsZzAWBG
X-Received: by 2002:a05:6512:3695:b0:4fe:2efa:b847 with SMTP id
 d21-20020a056512369500b004fe2efab847mr1603962lfs.23.1691770687218; 
 Fri, 11 Aug 2023 09:18:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3+xPnR9NXlkB7C6ERGYlfdHfeBkbhQor7cFGV8T/JBft6j7Y/q4uTDe9fdAFQZniWsDgZhQ==
X-Received: by 2002:a05:6512:3695:b0:4fe:2efa:b847 with SMTP id
 d21-20020a056512369500b004fe2efab847mr1603937lfs.23.1691770686741; 
 Fri, 11 Aug 2023 09:18:06 -0700 (PDT)
Received: from redhat.com ([2.55.42.146]) by smtp.gmail.com with ESMTPSA id
 ce11-20020a170906b24b00b0097073f1ed84sm2419803ejb.4.2023.08.11.09.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:18:06 -0700 (PDT)
Date: Fri, 11 Aug 2023 12:18:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jason Chien <jason.chien@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jason Wang <jasowang@redhat.com>, Chien@redhat.com, &lt@redhat.com,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 1/2] hw/pci-host: Allow extended config space access for
 Designware PCIe host
Message-ID: <3d449bc6030904ead784a4e4644c9640c2152796.1691770630.git.mst@redhat.com>
References: <cover.1691770630.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691770630.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jason Chien <jason.chien@sifive.com>

In pcie_bus_realize(), a root bus is realized as a PCIe bus and a non-root
bus is realized as a PCIe bus if its parent bus is a PCIe bus. However,
the child bus "dw-pcie" is realized before the parent bus "pcie" which is
the root PCIe bus. Thus, the extended configuration space is not accessible
on "dw-pcie". The issue can be resolved by adding the
PCI_BUS_EXTENDED_CONFIG_SPACE flag to "pcie" before "dw-pcie" is realized.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Message-Id: <20230809102257.25121-1-jason.chien@sifive.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Jason Chien &lt;<a href="mailto:jason.chien@sifive.com" target="_blank">jason.chien@sifive.com</a>&gt;<br>
---
 hw/pci-host/designware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 9e183caa48..388d252ee2 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -694,6 +694,7 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
                                      &s->pci.io,
                                      0, 4,
                                      TYPE_PCIE_BUS);
+    pci->bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
 
     memory_region_init(&s->pci.address_space_root,
                        OBJECT(s),
-- 
MST


