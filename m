Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 618E174E1F6
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzvN-0007Yb-Qd; Mon, 10 Jul 2023 19:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvG-0007SY-KI
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvF-0004R9-13
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=llOwBCxIvdLIU1f6GwL+jt15mYCqzEo8OOqYTIZkV4k=;
 b=fihJ0ULEvYFhPt+uy18chmmqpxCE5D3g/zbQs/bTmR+Jg1G7SJzZtz3ysPNwPiPD+fClRL
 0c/9iSmq6xczp3cEdj8RPPfkvr5EIszqFnqrTbNQKyDFkxk5m5EhKZ2m/NGz8+8c+DKrpW
 /04qS/X0q0S2eqSOmT5g3QnzAAI4HDI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-RHr0tKztOUKAUV2f7KFEDQ-1; Mon, 10 Jul 2023 19:03:58 -0400
X-MC-Unique: RHr0tKztOUKAUV2f7KFEDQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-313e6020882so2727178f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030236; x=1691622236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llOwBCxIvdLIU1f6GwL+jt15mYCqzEo8OOqYTIZkV4k=;
 b=RHSOUch0gXCKHHdt+xRh2Qp6c/EpVKgVdtPzdCDErL3am48n7eggw/bCm3PNCxkI9+
 8Hd4ZSwhUNLYdpy7wxcDg5iW/c1YXr4zpk6VZnu5UTjtAy3XzKXnh+Xdl+SRpRvZThqk
 6FY9ftuYiiSOGI8wQryL2VXPnsn4Dwy3BrRAYx7Jg1FanbJ+I/O2GYuA8PwO04vJGJq1
 ELZfzHMdKcpOXgqXnKtKtSP71DZWI63pQt/1ZKHkpXSmgU35Mf+zTJ2wk2EPA/B+8m60
 nSPfuRGcFxZEfVLsosUK5RgHJSXUFzcCP5VZk+vubIZ4+Q9HROXx9+IVswzUJ7+hoL7A
 z6rA==
X-Gm-Message-State: ABy/qLZRwdZ2tqwrZCZ1TIIesG981hWuJhvMInx9yVsMH1bm6drqru3M
 sohxIM5co5+D7sp/Yi9h0RWa95fsuZVQDvkMhdMquXzhlzYLB1C1RiwjkKbmveRgbFIQeynkLOT
 V4Wpw4swy5ynD6WSlKV8/CxQz2c1KgSST43waTXEbSn18WFqokt90yqEgKZvNrNY4LyOp
X-Received: by 2002:a5d:44cb:0:b0:311:b18:9ca4 with SMTP id
 z11-20020a5d44cb000000b003110b189ca4mr15167514wrr.17.1689030236537; 
 Mon, 10 Jul 2023 16:03:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcIbFyf3ujImlDEA/oXkkjyMD0YxHOwR3xLLJ5toedmK+iSoOpXz1gbPqSURbPoa5+46b+4A==
X-Received: by 2002:a5d:44cb:0:b0:311:b18:9ca4 with SMTP id
 z11-20020a5d44cb000000b003110b189ca4mr15167503wrr.17.1689030236321; 
 Mon, 10 Jul 2023 16:03:56 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 o6-20020adfeac6000000b00314145e6d61sm614240wrn.6.2023.07.10.16.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:55 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 31/66] hw/pci-host/i440fx: Add I440FX_HOST_PROP_PCI_TYPE
 property
Message-ID: <ff0a8cc4bed6414ab09816b14e006a11140d0d73.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Bernhard Beschow <shentey@gmail.com>

I440FX needs a different PCI device model if the "igd-passthru" property is
enabled. The type name is currently passed as a parameter to i440fx_init(). This
parameter will be replaced by a property assignment once i440fx_init() gets
resolved.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20230630073720.21297-16-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci-host/i440fx.h | 2 ++
 hw/pci-host/i440fx.c         | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h
index 7e38456ebb..2d7bae5a45 100644
--- a/include/hw/pci-host/i440fx.h
+++ b/include/hw/pci-host/i440fx.h
@@ -15,6 +15,8 @@
 #include "hw/pci-host/pam.h"
 #include "qom/object.h"
 
+#define I440FX_HOST_PROP_PCI_TYPE "pci-type"
+
 #define TYPE_I440FX_PCI_HOST_BRIDGE "i440FX-pcihost"
 #define TYPE_I440FX_PCI_DEVICE "i440FX"
 
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 8731740a1b..c458987405 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -57,6 +57,8 @@ struct I440FXState {
     uint64_t pci_hole64_size;
     bool pci_hole64_fix;
     uint32_t short_root_bus;
+
+    char *pci_type;
 };
 
 #define I440FX_PAM      0x59
@@ -284,13 +286,14 @@ PCIBus *i440fx_init(const char *pci_type,
     s->ram_memory = ram_memory;
     s->below_4g_mem_size = below_4g_mem_size;
     s->above_4g_mem_size = above_4g_mem_size;
+    s->pci_type = (char *)pci_type;
 
     b = pci_root_bus_new(dev, NULL, s->pci_address_space,
                          s->io_memory, 0, TYPE_PCI_BUS);
     phb->bus = b;
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    d = pci_create_simple(b, 0, pci_type);
+    d = pci_create_simple(b, 0, s->pci_type);
     f = I440FX_PCI_DEVICE(d);
 
     range_set_bounds(&s->pci_hole, s->below_4g_mem_size,
@@ -389,6 +392,7 @@ static Property i440fx_props[] = {
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, I440FXState,
                      above_4g_mem_size, 0),
     DEFINE_PROP_BOOL("x-pci-hole64-fix", I440FXState, pci_hole64_fix, true),
+    DEFINE_PROP_STRING(I440FX_HOST_PROP_PCI_TYPE, I440FXState, pci_type),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
MST


