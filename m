Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A51E474E206
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:10:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuv-0005Bq-5f; Mon, 10 Jul 2023 19:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzus-0005BB-Fm
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzur-0004H9-0n
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YMNZW+4NKvO7+vAb7cE4MQSCw+g7Z2FKLuxYz0OIZhE=;
 b=aPEIqPCA+vsuODnPuB+GlKTlPuGIjFmmvRIydkM8TzXwxtDJPtrA8zKy3jQFpP2yb0qCy2
 bshaek3bW0MeKRUxT5J6p7gO+uwz6MHTEMQ5Q6x1PT0B3dSONpW094SFLTS+soCUekyd+X
 T+z/jwyo5FiDsWkq0plHDxD/qxts8d0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-E-WrnLCaNbeu380CeUXVOw-1; Mon, 10 Jul 2023 19:03:34 -0400
X-MC-Unique: E-WrnLCaNbeu380CeUXVOw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fc0855dcc5so15718115e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030213; x=1691622213;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YMNZW+4NKvO7+vAb7cE4MQSCw+g7Z2FKLuxYz0OIZhE=;
 b=LXKB9QKK1OOzND8F7bvrW1X7OuF2KfPLxpsJuNDR0cwBkV10y0AnGBdpP/qZgJx4lj
 OdUe9k/4zbk/BkX2a5izoBVZCGEEeFFU+Qq6KGnh+0SgdpFFgCWekabFOOJFs2cBv8zZ
 bJHo/HYzJy/D2K9ebPXrOr1mF8gaEeffQZUhRGmxdrg2pjWve1o3corG/jRl0UGyvEjk
 Ul4rb2BwtLOB7m+nlkISA9u42Yc+emnLfrUqzBBt+CtOM4zau8qm6RsGn0DzA5Y4OnBP
 g+M1jgmS2cEWqm9zfnKUjYgsc+L3A27bj/by/4FZ+6escuz20HmxGo7X1gqCLQ9S9BcF
 WH/A==
X-Gm-Message-State: ABy/qLbHtQ8Ct1U9u48GKNYNs/g0twA+EpOlXLih7LEWWyUFtXaD9TzV
 Y6GDX22s6ReUFXoDXb099+laNuxiom5F29SwHm6f97QDNeKEi/aKmJJrBxpVIbM+vMCMW44oUma
 6gKouN6V0AxSK1fBrz/lPOaC1pDYRHPJXeImb9uwwNQpsDkAMpfoZd8dePHuYyHcz0ite
X-Received: by 2002:a7b:c451:0:b0:3fb:b4fc:be62 with SMTP id
 l17-20020a7bc451000000b003fbb4fcbe62mr12489315wmi.17.1689030213549; 
 Mon, 10 Jul 2023 16:03:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEVNZ+BnLLxkBMCEZ9uDGv6zO7afQKFOT3DSF0pzGCLb2JpIJp/zWEzmnkJITDcfZifDBzhCQ==
X-Received: by 2002:a7b:c451:0:b0:3fb:b4fc:be62 with SMTP id
 l17-20020a7bc451000000b003fbb4fcbe62mr12489295wmi.17.1689030213271; 
 Mon, 10 Jul 2023 16:03:33 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 v3-20020a1cf703000000b003fbb5506e54sm935317wmh.29.2023.07.10.16.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:32 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 23/66] hw/i386/pc_piix: Turn some local variables into
 initializers
Message-ID: <b90d7bff18c48500df86a35db56fecfb59d85088.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Eliminates an else branch.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230630073720.21297-8-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_piix.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f9947fbc10..6a5b6dad2f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -122,11 +122,11 @@ static void pc_init1(MachineState *machine,
     BusState *idebus[MAX_IDE_BUS];
     ISADevice *rtc_state;
     MemoryRegion *ram_memory;
-    MemoryRegion *pci_memory;
-    MemoryRegion *rom_memory;
+    MemoryRegion *pci_memory = NULL;
+    MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
-    uint64_t hole64_size;
-    DeviceState *i440fx_host;
+    uint64_t hole64_size = 0;
+    DeviceState *i440fx_host = NULL;
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
@@ -205,11 +205,6 @@ static void pc_init1(MachineState *machine,
         hole64_size = object_property_get_uint(OBJECT(i440fx_host),
                                                PCI_HOST_PROP_PCI_HOLE64_SIZE,
                                                &error_abort);
-    } else {
-        pci_memory = NULL;
-        rom_memory = system_memory;
-        i440fx_host = NULL;
-        hole64_size = 0;
     }
 
     pc_guest_info_init(pcms);
-- 
MST


