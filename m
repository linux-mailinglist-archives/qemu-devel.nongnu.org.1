Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FED07D2239
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:28:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUhu-0005Vn-JO; Sun, 22 Oct 2023 05:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhk-0005Gc-L0
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhi-0000dY-N1
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/7Z3H+51oJIJWzVgGhiU5HVqcfMDnbILXmSBJdNG3g=;
 b=Mwtx4HZHRUyRxQiQP44eJ7kSZKEckEjViWxO7DnVdgMoaHX8ieVMfBovVEDf6ULa9e1Xrv
 j5uoKFsjDuEv+WoRYfj4SPXCwoROK68bNcXgOph5Jr0tTlk+b+h9IU9U2gKfdxZSla0wzr
 MUSduJ0TT7UBHUrT3Qce3wSf22dfqJE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-iUgEZ1PuMRuAEDSqcRePIg-1; Sun, 22 Oct 2023 05:24:59 -0400
X-MC-Unique: iUgEZ1PuMRuAEDSqcRePIg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9be601277c2so138119066b.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966698; x=1698571498;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f/7Z3H+51oJIJWzVgGhiU5HVqcfMDnbILXmSBJdNG3g=;
 b=cDJD9XaKjjoX3gclm1INaIjloLkP/xwPjOKQM8F4ZKizMOKBBl9GK3SNJghuwTE6A7
 m4fJUCOcBi7s2106FFBb9tKNb8Kk3r/TA3CVhOREGTxpfqc6Ry3GFPmhdvXfggGSNR8A
 /6OWpHAETt7Z9sKm57I4b4uZchnjenF9uWnncZRN+vzto32E/bOiuidQJTyOJTfNg1k/
 lsTHi6Tys08B3ZwsvzhIFduCG50hzhUqzCcIBCXBu0F5hxN65JYEDunheIZyPm1fyXGd
 uMRm4QFSj32pHNTNYx47//4hE9TE77wbXRH+/YU+6kY30qY9f3dmBi78wEAhERP6zd3X
 TCiA==
X-Gm-Message-State: AOJu0YxQwCeAWq3Q+99i026+qM6+s+Th+4Op5E0Ed8jeZLOsVoW5XCK1
 P+Xswx5WaJGI0mMWS4FbOkNGvpDB6lNyR8dVYy5LuOvwDWO2YeCTPxg6Z5yKPhumUAEEJKvA7h0
 bBTLd95SGSFjo4+tYW0DnuIJDkDC5Yg74fYJl9vlEd29srMeAQjqh3a/rcXuEAtsbdZQ7
X-Received: by 2002:a17:907:9812:b0:9ae:5fe1:ef01 with SMTP id
 ji18-20020a170907981200b009ae5fe1ef01mr4485406ejc.37.1697966698279; 
 Sun, 22 Oct 2023 02:24:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9Yjg1ilFbq61FlHLXjJJbpAeg5BerCNPK6myi95maOSPM/mDu6sO5FWqwneO5+UpNyDLCkA==
X-Received: by 2002:a17:907:9812:b0:9ae:5fe1:ef01 with SMTP id
 ji18-20020a170907981200b009ae5fe1ef01mr4485389ejc.37.1697966697940; 
 Sun, 22 Oct 2023 02:24:57 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 x12-20020a5d650c000000b0032d9a1f2ec3sm5245632wru.27.2023.10.22.02.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:24:57 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:24:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Subject: [PULL v3 43/62] hw/isa/piix: Harmonize names of reset control memory
 regions
Message-ID: <f97479cad8447caa1d77c862a0890e6ff1a3acc6.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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

From: Bernhard Beschow <shentey@gmail.com>

There is no need for having different names here. Having the same name
further allows code to be shared between PIIX3 and PIIX4.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-23-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 270b8eb1f7..bd66fb7475 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -339,7 +339,7 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
     }
 
     memory_region_init_io(&d->rcr_mem, OBJECT(dev), &rcr_ops, d,
-                          "piix3-reset-control", 1);
+                          "piix-reset-control", 1);
     memory_region_add_subregion_overlap(pci_address_space_io(dev),
                                         PIIX_RCR_IOPORT, &d->rcr_mem, 1);
 
@@ -532,7 +532,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
                              "intr", 1);
 
     memory_region_init_io(&s->rcr_mem, OBJECT(dev), &rcr_ops, s,
-                          "reset-control", 1);
+                          "piix-reset-control", 1);
     memory_region_add_subregion_overlap(pci_address_space_io(dev),
                                         PIIX_RCR_IOPORT, &s->rcr_mem, 1);
 
-- 
MST


