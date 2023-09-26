Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0223C7AF003
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:53:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAMo-0003fr-Nq; Tue, 26 Sep 2023 11:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlAMc-0003Zi-Qx
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlAMa-00068p-G8
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695743559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=T3LHuqksbZwzw7Cn18Hj3Q+SM4YvtWuPM3viqaQK8ko=;
 b=B6bQpILvG0T/VVqxxC/SKxP/t8F3Mf8R41PhvrEo0UebGI7eexNJkRZ33Uf+03FhS4W4y/
 wULNiPixkq2Re3qh+I6eBznRAL2KJ9ol+/KMRXn7Q1/EpP8y6m4TqPJz7ZrA9Whm0m2xdk
 4kMrWEA79Eg1CsAPHebzmjhgMCsY1Vw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-0UUOpFXDNM-UQkyFVWtNSA-1; Tue, 26 Sep 2023 11:52:37 -0400
X-MC-Unique: 0UUOpFXDNM-UQkyFVWtNSA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so82557245e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695743556; x=1696348356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T3LHuqksbZwzw7Cn18Hj3Q+SM4YvtWuPM3viqaQK8ko=;
 b=n/Xs6ADERhVMgi/2lyc9x1+ULxbXlUwNcqKATQYnx1dYse4qwWX/NFT3QN0IpUAMAp
 +CVWHILVPCd1kTDw7fTbffUUDXfDvyDk0Z5AP/5Eye9uCsdRG7b4vNwg1An3il08rheD
 WKfTt6c/PSZPvr8JSgkEuezcXbFibWYfN7OaYXfP+qc14bql5JuF5YO9fx9TvilyTESH
 oc4IWrd7u0sffBDOQOycf98aB9sR6SsceFq1vDdEKluMjEOhSlhbE0t4V1zU+C2/Isy/
 LMRhpSLnitp1NXxzXpSATer5gZClcpfGWtDpwX1+SXAu2m3Zw1IZbyu3/dHglmP9l6CD
 BR6w==
X-Gm-Message-State: AOJu0YylcppWLuHx40Db7wGkRp9LRcPTOZTYy6b7uJs0Ep74GYZNILLn
 +4bI6Lz/8w/E4G7WHc9yNDj96ESvcMWhNL7OVQmf0w/msVeDIm9aYfS/cT9IbXGq9hBHRnolSU+
 gjTzSjBdOGx+LCY0soXFNFMZVtwarY1Da+nMSoe4XOlzard5kh1JcXWzTXo53OwK6ixkG+McZyK
 c=
X-Received: by 2002:a05:600c:2101:b0:401:2ee0:754a with SMTP id
 u1-20020a05600c210100b004012ee0754amr9955426wml.13.1695743556001; 
 Tue, 26 Sep 2023 08:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcamQ10byzB1lF98NDMO2DdmYHtHVJ7V9m/obRdlTyws+tdUn4TjayZbc6CYtygy15Pww92w==
X-Received: by 2002:a05:600c:2101:b0:401:2ee0:754a with SMTP id
 u1-20020a05600c210100b004012ee0754amr9955408wml.13.1695743555682; 
 Tue, 26 Sep 2023 08:52:35 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a7bc4d4000000b0040588d85b3asm7009522wmk.15.2023.09.26.08.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 08:52:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com
Subject: [PATCH] pc: remove short_root_bus property
Date: Tue, 26 Sep 2023 17:52:27 +0200
Message-ID: <20230926155234.728965-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
        Requires the patch to remove pc-i440fx-1.4 to 1.7, which is
        going in a pull request as soon as testing finishes.

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


