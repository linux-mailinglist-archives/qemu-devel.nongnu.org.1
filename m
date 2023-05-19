Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A0C709A9A
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:55:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01TC-000564-DG; Fri, 19 May 2023 10:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Sv-0004sV-Nd
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01St-0003jt-DB
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERgWhut0Ar78W50hUKkDUqbaG/clkmwna7iN062IWeA=;
 b=DDqnzCYj/DVW5y4HCiXgRBQU2i/6gkf6MOCb3HkamjXeo4w6+rIdSPba0OhWhtZJjoo4q6
 WrnUjpel+CfY2LC4zYxE15ZRbPRxQVA5EVagr17sTOUZp+bAae/wQsiHTkKBNPHo2EUVfA
 IH0kNqln3Lqxm5v4tVVvxgnNTCPsh38=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-Ffdglf5VObqH2l8J2AfOXQ-1; Fri, 19 May 2023 10:52:16 -0400
X-MC-Unique: Ffdglf5VObqH2l8J2AfOXQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f020caac60so2235976e87.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507934; x=1687099934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERgWhut0Ar78W50hUKkDUqbaG/clkmwna7iN062IWeA=;
 b=AXDnjP992+CB2Xz4GI2P6JmkoiHGw4m7jnH+XUH8zxIVNtoCk19UWiXkuqMZN2d9PS
 YBToaiY//+CmD0n6TK1tZIV8XV+LkiK72s5lUpPjapYHXw04j4Q0IEBsnoxtsJ/2UDIP
 /oEhlJBE4yI5eI3xR33v2lAfrYxSccaMkFC30d3/5SEDDlgd+GmCMpcBNOIDXxVlAtec
 oJ4tNHi83Lr5/rUlOHkzMcNcrz2Sl0AVd+Ser70bfZaWcjoqvOW9uwKWsuywXkJll0/N
 mv6Hd9ztuKaeCJ/TLYrzQmZ2yTCUm4SID6SXUwdBp4jqsC+xhExlB9tooKrdiH7H/8a0
 yeSQ==
X-Gm-Message-State: AC+VfDwAW3WE9/44VZCD0B2LJ134fFdJmlQ7e6/SmsD4WLUVb42pfxaQ
 gc4Hmwv0md5UvXBpr7T8n3zpgQv0RWVcbrD7BYnm0zOR+17GnK8yP08ONxYhSa0CXvkY1J6w1cq
 WQjCvxo6I3Nf+t4EIvvsVKFpua+eiiCxXu+wTEokuV11043Z5+wiBVg/+N1oPb71hAR52
X-Received: by 2002:ac2:44d6:0:b0:4dd:ce0b:7692 with SMTP id
 d22-20020ac244d6000000b004ddce0b7692mr814825lfm.46.1684507933936; 
 Fri, 19 May 2023 07:52:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4j1ExbdBB4jyguSGtF/CvuI8waDeTLSOW100aHcOBft3PqT1QlcG5Cf3ZGBs+DUxpJGwcIGg==
X-Received: by 2002:ac2:44d6:0:b0:4dd:ce0b:7692 with SMTP id
 d22-20020ac244d6000000b004ddce0b7692mr814813lfm.46.1684507933550; 
 Fri, 19 May 2023 07:52:13 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 d7-20020ac244c7000000b004f11eb32f20sm633732lfm.13.2023.05.19.07.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:52:12 -0700 (PDT)
Date: Fri, 19 May 2023 10:52:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 29/40] hw/pci-host/q35: Inline sysbus_add_io()
Message-ID: <67b4a74a0743c4cdb78bf884cea2407645530af3.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
memory region s->mch.address_space_io which is set as an alias to
get_system_io() by the q35 machine.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230213162004.2797-3-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/q35.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 26390863d6..fa05844319 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -50,10 +50,12 @@ static void q35_host_realize(DeviceState *dev, Error **errp)
     Q35PCIHost *s = Q35_HOST_DEVICE(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    sysbus_add_io(sbd, MCH_HOST_BRIDGE_CONFIG_ADDR, &pci->conf_mem);
+    memory_region_add_subregion(s->mch.address_space_io,
+                                MCH_HOST_BRIDGE_CONFIG_ADDR, &pci->conf_mem);
     sysbus_init_ioports(sbd, MCH_HOST_BRIDGE_CONFIG_ADDR, 4);
 
-    sysbus_add_io(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, &pci->data_mem);
+    memory_region_add_subregion(s->mch.address_space_io,
+                                MCH_HOST_BRIDGE_CONFIG_DATA, &pci->data_mem);
     sysbus_init_ioports(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, 4);
 
     /* register q35 0xcf8 port as coalesced pio */
-- 
MST


