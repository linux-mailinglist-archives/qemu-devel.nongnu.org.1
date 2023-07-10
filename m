Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8C374E1CA
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:05:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuy-0005Wj-I9; Mon, 10 Jul 2023 19:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuw-0005Lk-K3
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuu-0004Hk-1J
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=elYMoXg9QVwhRNFpbJN9zA3o30arH0LQPiAaoIJj+RU=;
 b=BjbQYZi+H1EH0O5m94QIVxpUE7mmrxR2zddcXbnO8wDuiJTK1Q6yvluiqzwdGyN5A6kQ3j
 N5r/mViKG+rcnRxksPgM+iF2n+Q3gpFecKqzYCvh1T1i5ZrmRwGQrrxp1f9qIh1h5EIFTJ
 VsOGUv5kkbhsPpcreJKW6hUwKzo95HY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-PN2x-NT3Nhyewapxr0s0lg-1; Mon, 10 Jul 2023 19:03:38 -0400
X-MC-Unique: PN2x-NT3Nhyewapxr0s0lg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31400956ce8so2831701f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030216; x=1691622216;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=elYMoXg9QVwhRNFpbJN9zA3o30arH0LQPiAaoIJj+RU=;
 b=jixDnGbjb49E3W4FFzn61AmNVvLDFDX0/YmDAJpDBCYz8J8uXNkG8/g96SutOTEQI9
 5Ppy8nzJu7TFSO7XGhN3x2CjzmpcJCt/CSjVdfqSHumQBl/h0sJa54shiEpq3/sivr6X
 JZ7rdqI7mPOV/ep74HOOiZBC0WKE+h8xa7TzsMa2g9u4LbZpUypf8vHjf+Wx1YpGmIbO
 jMpZdUJ5OZJY9KF/Ea32kWBh6sI2JFFadI+B35HmCgW+IOf9Nh9UI/vPrMuLblB23wbe
 4apWnc/2MqBexcOypv065alhsEw8MYh/qiRI86aehy3x2o5/r5WrW7WCaypY9P75JiMK
 suDA==
X-Gm-Message-State: ABy/qLYH+WGN2h/gYCuM7mWWZ3F8YzwjS6u0hVR3Ql3D8UjjbCG2PEZM
 RjgfdOUt1r4FD1LSJYWz/enTIp2JQuwmjq+fCsbSXO9/D8XEm2is8BZftolH8k4t2K7xMXTBhKN
 VghzJGYgLWef05F/PWkSRmuHtAuOoj4tPjxaWHfc52SHAxZnEFipcxJvWmpwb99/EGCL/
X-Received: by 2002:adf:ee4a:0:b0:30f:af19:81f3 with SMTP id
 w10-20020adfee4a000000b0030faf1981f3mr12565222wro.41.1689030216414; 
 Mon, 10 Jul 2023 16:03:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFelC4me9mv1dP6Ygmt2SzeoiSwkGn6CHefoVqsfb2sKglCfEs1JDWvEguBbVtgXx4qqwzk8A==
X-Received: by 2002:adf:ee4a:0:b0:30f:af19:81f3 with SMTP id
 w10-20020adfee4a000000b0030faf1981f3mr12565196wro.41.1689030216067; 
 Mon, 10 Jul 2023 16:03:36 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 d6-20020adfe846000000b0030fd03e3d25sm580551wrn.75.2023.07.10.16.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:35 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 24/66] hw/pci-host/i440fx: Add "i440fx" child property in
 board code
Message-ID: <f00f5e4b00e2cb414927b560cd6a82fad4dfc6e2.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

The parent-child relation is usually established near a child's qdev_new(). For
i440fx this allows for reusing the machine parameter, thus avoiding
qdev_get_machine() which relies on a global variable.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20230630073720.21297-9-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c    | 2 ++
 hw/pci-host/i440fx.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6a5b6dad2f..26e8473a4d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -202,6 +202,8 @@ static void pc_init1(MachineState *machine,
         memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
         rom_memory = pci_memory;
         i440fx_host = qdev_new(host_type);
+        object_property_add_child(OBJECT(machine), "i440fx",
+                                  OBJECT(i440fx_host));
         hole64_size = object_property_get_uint(OBJECT(i440fx_host),
                                                PCI_HOST_PROP_PCI_HOLE64_SIZE,
                                                &error_abort);
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 61e7b97ff4..d95d9229d3 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -259,7 +259,6 @@ PCIBus *i440fx_init(const char *pci_type,
     b = pci_root_bus_new(dev, NULL, pci_address_space,
                          address_space_io, 0, TYPE_PCI_BUS);
     s->bus = b;
-    object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     d = pci_create_simple(b, 0, pci_type);
-- 
MST


