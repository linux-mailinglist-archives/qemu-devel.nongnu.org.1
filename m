Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DB07B6436
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:32:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaof-0003K8-FR; Tue, 03 Oct 2023 04:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoL-0002Mv-Kk
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoH-0000Ja-GV
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JEdULn8yExrQeLoHMh7eLE9pzVlfh7yoO+hxU9Gh7z4=;
 b=PaawNOM197D4uPqJ0hoEswE60Qw08E8o1zRhbMQu9biPQlkk5Md5llsHjUNrK3FgIYuPsk
 kCaySQWgnliW908cbl0MQHNRg6ZN8KtMhA5gKJM+6eLcMxs6D/rB1BwPJHZ+qa/hAY/Bha
 OafnN2naMyO5jLvj6qcxz6swraeelWk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-GnxxHiyfPLunmaAsLQyDsw-1; Tue, 03 Oct 2023 04:30:53 -0400
X-MC-Unique: GnxxHiyfPLunmaAsLQyDsw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-52f274df255so4774654a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321852; x=1696926652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JEdULn8yExrQeLoHMh7eLE9pzVlfh7yoO+hxU9Gh7z4=;
 b=rA1BmfhBdtN3EcggHdVacKA60hP8cB6ciDCRd/Wx28nGD1iBBAP51gNzPYwLDe1Fo8
 pnBtjcLLD7tl7FPR3ZO1Wm+Sad1svrr583lBjN0RKx3CUzgUHw7+IsoO4WwMztmklcNA
 NeOETw9udtlJh4PCCdoKy0FIJeYjWyqYFN/icEF+sBfPhy/GT01n9Wdfhgsfd/oBZYuj
 QefF1TnEqdDf/EkelDgG6R75tYsRtngkagTop/PP7ikdDtkr+lyEC4Vs8w8uxj9RHuMS
 Cx0LmzDswpcOxHtvvOQFi5AVkpCZCHYVG7ele6DV++Ofq5EUWZcKlakJrzRgqUZkw2Om
 7Eug==
X-Gm-Message-State: AOJu0YxTi9C3f4Or8u3YE70OCmh+Zc+B5KjTG8PznOs06T7wL6JrlZsv
 1s7hBu8gqyE6Krkl9qsV88TojoaBhd9ZoWNpcLMzGOe0f7Cgys/9cUzu34ov46/Ho/ggeuvWH4U
 jH6+cMPCI/JxsSeih2g1xwxm7M1u1McLsZZ5lovfLvTm0O75ddYwKwwDT5lj26t3dKLL05gMy4N
 g=
X-Received: by 2002:a17:906:cd2:b0:9a1:ca55:d0cb with SMTP id
 l18-20020a1709060cd200b009a1ca55d0cbmr1613725ejh.23.1696321851942; 
 Tue, 03 Oct 2023 01:30:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxGt0k+Ie97A7cXhiSulCvr4iyIOAlQOuKOzbvFhfILX75th3p/BL0RkTCaJ6G0V/446Z5Qw==
X-Received: by 2002:a17:906:cd2:b0:9a1:ca55:d0cb with SMTP id
 l18-20020a1709060cd200b009a1ca55d0cbmr1613710ejh.23.1696321851633; 
 Tue, 03 Oct 2023 01:30:51 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 kf1-20020a17090776c100b00992f2befcbcsm649242ejc.180.2023.10.03.01.30.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:30:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/24] pc: remove short_root_bus property
Date: Tue,  3 Oct 2023 10:30:21 +0200
Message-ID: <20231003083042.110065-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The property was only used on QEMU 1.6 machine types.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci-host/i440fx.c      | 8 --------
 hw/pci-host/q35.c         | 7 -------
 include/hw/pci-host/q35.h | 1 -
 3 files changed, 16 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 62d62876818..653cc3f1495 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -56,7 +56,6 @@ struct I440FXState {
     uint64_t above_4g_mem_size;
     uint64_t pci_hole64_size;
     bool pci_hole64_fix;
-    uint32_t short_root_bus;
 
     char *pci_type;
 };
@@ -351,19 +350,12 @@ static const TypeInfo i440fx_info = {
 static const char *i440fx_pcihost_root_bus_path(PCIHostState *host_bridge,
                                                 PCIBus *rootbus)
 {
-    I440FXState *s = I440FX_PCI_HOST_BRIDGE(host_bridge);
-
-    /* For backwards compat with old device paths */
-    if (s->short_root_bus) {
-        return "0000";
-    }
     return "0000:00";
 }
 
 static Property i440fx_props[] = {
     DEFINE_PROP_SIZE(PCI_HOST_PROP_PCI_HOLE64_SIZE, I440FXState,
                      pci_hole64_size, I440FX_PCI_HOST_HOLE64_SIZE_DEFAULT),
-    DEFINE_PROP_UINT32("short_root_bus", I440FXState, short_root_bus, 0),
     DEFINE_PROP_SIZE(PCI_HOST_BELOW_4G_MEM_SIZE, I440FXState,
                      below_4g_mem_size, 0),
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, I440FXState,
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 91c46df9ae3..08534bc7cc0 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -73,12 +73,6 @@ static void q35_host_realize(DeviceState *dev, Error **errp)
 static const char *q35_host_root_bus_path(PCIHostState *host_bridge,
                                           PCIBus *rootbus)
 {
-    Q35PCIHost *s = Q35_HOST_DEVICE(host_bridge);
-
-     /* For backwards compat with old device paths */
-    if (s->mch.short_root_bus) {
-        return "0000";
-    }
     return "0000:00";
 }
 
@@ -181,7 +175,6 @@ static Property q35_host_props[] = {
                         MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT),
     DEFINE_PROP_SIZE(PCI_HOST_PROP_PCI_HOLE64_SIZE, Q35PCIHost,
                      mch.pci_hole64_size, Q35_PCI_HOST_HOLE64_SIZE_DEFAULT),
-    DEFINE_PROP_UINT32("short_root_bus", Q35PCIHost, mch.short_root_bus, 0),
     DEFINE_PROP_SIZE(PCI_HOST_BELOW_4G_MEM_SIZE, Q35PCIHost,
                      mch.below_4g_mem_size, 0),
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, Q35PCIHost,
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index 1d98bbfe0dd..bafcbe67521 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -54,7 +54,6 @@ struct MCHPCIState {
     uint64_t below_4g_mem_size;
     uint64_t above_4g_mem_size;
     uint64_t pci_hole64_size;
-    uint32_t short_root_bus;
     uint16_t ext_tseg_mbytes;
 };
 
-- 
2.41.0


