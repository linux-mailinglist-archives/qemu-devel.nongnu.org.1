Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BF87AB57B
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:05:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjidn-0006VU-AM; Fri, 22 Sep 2023 12:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qjidf-0006IP-32
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qjidc-0007FO-5g
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695398655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kf0foY1Gy5qsta4Pkg2F0eVSKWnU8thhFkaCRDbG8Xk=;
 b=R6dq0FOpanVXEG2a8nusZgjLW5PF5XwngaAEjyNDFl5g0PilFzCS4E8Gpl01wVkOi8q8dG
 X5zEi4dpAa602ZvvO+xyQx1RiVJ3IikY2kCrFSOimrfCLOH+KICQ03+4qnZfMOhc5ALbsa
 5tm4h7JF7cZS0AxTdkK9hlLo2xVPaww=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-cHt8rBowOAO5IiTDu77Jsw-1; Fri, 22 Sep 2023 12:04:14 -0400
X-MC-Unique: cHt8rBowOAO5IiTDu77Jsw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4122119722eso2568881cf.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 09:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695398653; x=1696003453;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kf0foY1Gy5qsta4Pkg2F0eVSKWnU8thhFkaCRDbG8Xk=;
 b=ewJukak+iJh1ZhZGgY6kOeghgwwjHEAXa+n9jv8VIvba9KuGZOkUVQXhawL5NMt/pr
 nn3hqYmaRCGXfYxFG26k31vJgZLCX8iaKn6B9ELuyswb8GVJfZpsXFYvvYtbqWv63wHZ
 RlkN5jI8TwFYcHVRpwkE7vS3kP/2K2/gAYWX9W5nClSTC4dLdnP80Z2rJIg2lxn49I4e
 AfB9wa5o98VBAx1KBXhYYm2+UW1QPO9k//AbysFMPQK+3vPR5FgyZsUoJlwLj7FxLdXt
 tMAmCpaA0yTGFmhGxOi9oNRLcGzeI3mJZ17zgqHc9hJuzfcjz1o0BdZMHAhH5TvfZmU+
 vujg==
X-Gm-Message-State: AOJu0YxNojXVjNbtyDRZEf5PrAJSnD+t4A109TPI2vQbIl8k+VyUyQBI
 A9jDlrj7Vf3+8L4fOTATOKmjm/aA0CQ2YO2dpbeWsCrtN+9pOUDmJqtidEDOCVftWMcLcxeHViy
 IMxVLorrplCgUVWduKOFtlw5Dx0kXdOnTtXV2Bqslmu0StU8qwll50CNmX1OWBb9JKHrMA8n2
X-Received: by 2002:ac8:5a95:0:b0:412:1c5f:4781 with SMTP id
 c21-20020ac85a95000000b004121c5f4781mr9020851qtc.4.1695398653491; 
 Fri, 22 Sep 2023 09:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTsV+YiuJzloc7ms4clPyfkiPyjufI0khKqE2X8//r8wtRUnUBckwfstARf5XwEKtBQixOrA==
X-Received: by 2002:ac8:5a95:0:b0:412:1c5f:4781 with SMTP id
 c21-20020ac85a95000000b004121c5f4781mr9020813qtc.4.1695398652973; 
 Fri, 22 Sep 2023 09:04:12 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a05622a105300b0041519ba589fsm1564723qte.6.2023.09.22.09.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 09:04:12 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Jason Wang <jasowang@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] intel_iommu: Fix shadow local variables on "size"
Date: Fri, 22 Sep 2023 12:04:10 -0400
Message-ID: <20230922160410.138786-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

This patch fixes the warning of shadowed local variable:

../hw/i386/intel_iommu.c: In function ‘vtd_address_space_unmap’:
../hw/i386/intel_iommu.c:3773:18: warning: declaration of ‘size’ shadows a previous local [-Wshadow=compatible-local]
 3773 |         uint64_t size = mask + 1;
      |                  ^~~~
../hw/i386/intel_iommu.c:3747:12: note: shadowed declaration is here
 3747 |     hwaddr size, remain;
      |            ^~~~

Cc: Jason Wang <jasowang@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c9961ef752..ae30c2b469 100644
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
2.41.0


