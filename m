Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D10307B668C
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 12:37:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnclN-00006N-Ne; Tue, 03 Oct 2023 06:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qnclL-00006B-VS
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qnclK-0008KP-BT
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696329381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=x+TQJXewnI7sC4wHhypRpibLdrTQLmcK7efhA8fxb3I=;
 b=HMdrlHhhuhamKaMRz2F1izGdxGdyLW6o83qOTZ0MSqe3kb2q6NbaMOgzzJ13QWTXqa/KmC
 56gDekfBczGlghXSPx4bghi2QR0uqOmBlMaX9YlIISPs0kojRCRF7CXkgenugNVPBvR2VA
 JBYgIznxtYzPyuq9R37WtuauIipd2/s=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-ntZRHVbMN_2b7GEQ1vb5Nw-1; Tue, 03 Oct 2023 06:36:19 -0400
X-MC-Unique: ntZRHVbMN_2b7GEQ1vb5Nw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-690f8b7058bso769579b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 03:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696329379; x=1696934179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x+TQJXewnI7sC4wHhypRpibLdrTQLmcK7efhA8fxb3I=;
 b=YOKAZvFdfz4irsi11zR/9bKW8XSKJwOcQ2XcVinqAVWbK1SbmOKOXZbB++uHkdVqsA
 VXo4klNiE+TbXsA9lMnZsMWPZ0ZfzbERyW9LoiF1Qjj/D+WvazLWhi431Xp5sT4USkjz
 M9IMRJ+0z2BZADU4Pzc/bhxk9g+GivBvYFgUBIuL9VD0HP6o6fhXLmOtXjkk3jdRJk/E
 c7vXARMC+AHx8l8KS/FSrukEYCzzhGayYhEUTpVaGdvGqDCAibQ3dFeRkvxQeHmONJ8h
 cTCENlVdacCrlwgyHfazPTa7Jy1z8Y7N0CLtxtaOb/0tfjItxD+D8AtYBMEzqxT2nJVa
 oRpg==
X-Gm-Message-State: AOJu0YyKYTHyL8U2WMHOESzaYSJlelOs+7+0ub3EA5B2BFNvDUkgHR0+
 hCJKxXXi7Pmx03KeAspjCLEmZ5ZRAWfjIBVMi5tzph0hpVWQO0ltvd+DNG1ZBUnc734EKZbOxu+
 lj0bN0MrRNtTp+Wc=
X-Received: by 2002:a05:6a20:5495:b0:153:a00b:dca0 with SMTP id
 i21-20020a056a20549500b00153a00bdca0mr14360168pzk.11.1696329378917; 
 Tue, 03 Oct 2023 03:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy3hDiuf+Q7tdWs8A3tQQYtbjytbU14ZFfRLllgqfKa5mwXQzieiQOo7fua8qkdOxWgZHKJQ==
X-Received: by 2002:a05:6a20:5495:b0:153:a00b:dca0 with SMTP id
 i21-20020a056a20549500b00153a00bdca0mr14360153pzk.11.1696329378597; 
 Tue, 03 Oct 2023 03:36:18 -0700 (PDT)
Received: from localhost.localdomain ([115.96.159.31])
 by smtp.googlemail.com with ESMTPSA id
 w9-20020a1709026f0900b001b895336435sm1191558plk.21.2023.10.03.03.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 03:36:18 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/i386/intel_iommu: changes towards enabling -Wshadow=local
Date: Tue,  3 Oct 2023 16:06:01 +0530
Message-ID: <20231003103601.6245-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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

Code changes that addresses all compiler complaints coming from enabling
-Wshadow flags. Enabling -Wshadow catches cases of local variables shadowing
other local variables or parameters. These makes the code confusing and/or adds
bugs that are difficult to catch.

See also

   Subject: Help wanted for enabling -Wshadow=local
   Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
   https://lore.kernel.org/qemu-devel/87r0mqlf9x.fsf@pond.sub.org

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

See also 
Peter's changes from
https://lore.kernel.org/r/20230922160410.138786-1-peterx@redhat.com.
This patch is same as above.

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c0ce896668..2c832ab68b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3744,7 +3744,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
-    hwaddr size, remain;
+    hwaddr total, remain;
     hwaddr start = n->start;
     hwaddr end = n->end;
     IntelIOMMUState *s = as->iommu_state;
@@ -3765,7 +3765,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     }
 
     assert(start <= end);
-    size = remain = end - start + 1;
+    total = remain = end - start + 1;
 
     while (remain >= VTD_PAGE_SIZE) {
         IOMMUTLBEvent event;
@@ -3793,10 +3793,10 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
                              VTD_PCI_SLOT(as->devfn),
                              VTD_PCI_FUNC(as->devfn),
-                             n->start, size);
+                             n->start, total);
 
     map.iova = n->start;
-    map.size = size - 1; /* Inclusive */
+    map.size = total - 1; /* Inclusive */
     iova_tree_remove(as->iova_tree, map);
 }
 
-- 
2.42.0


