Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D41E7B7AD2
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:55:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxXr-000264-Uq; Wed, 04 Oct 2023 04:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWe-0000St-Se
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxWI-0002Wz-Ss
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dXZPD0CN1EMknhNwzhqLjrYqmgqO9D2C6C8XhFWkRR0=;
 b=XbOT4XI/HzOU+c1casmeAEyTJw+nBXzA2woMbZUcxbuRqePEntqmMzufZ4b47eMGDfIliY
 TXSWCYBuKPadCIc8dpCr9DNxOteLDU6Z8fweDVohIgK1eiedpvX76fb3SJBJ7DzFJRIqWS
 dgne2k2sVxW6huzhlMLAzpOB250sYK8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-Er3aKm8MMOegII-JxDfbsQ-1; Wed, 04 Oct 2023 04:46:11 -0400
X-MC-Unique: Er3aKm8MMOegII-JxDfbsQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-321f75cf2bdso1333367f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409169; x=1697013969;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dXZPD0CN1EMknhNwzhqLjrYqmgqO9D2C6C8XhFWkRR0=;
 b=cq5JiQceqAHjMKMTiQTTPFSjynLWVgUZfJPlKUxtg9ZccYS6OJ7I/EJJNPVhr7I7bz
 4A+sjPXO44Fgch900WHvR17ggk95+ApZBYlfMbEqwLv5AzPR4uf0WLC0+zH7yCeRy7kO
 WkeoG+bnjJssjilRCZ0RWX4LMExi7Cb/k0fahhV4svqI6yZwktk50Dpa+s1EJnTNybFy
 86xJ85icgxk9iXRuMzAE4i+LP/bSvaEtb1hdweCFpFZVLB5gvzq1POXOAAER6VORgGRU
 8QdqTSPucN8jMU6EB7vlXvOg1OwB6m1PVP+hEAhYB5gkWFqeVrHy4141rzZM/2e+gCN8
 o1DQ==
X-Gm-Message-State: AOJu0YzKyUCtLcqtSiwRys8sP5RSr+6u4Arb4IuEc89viRl+clv4iQO1
 cDJkyOQVmZDWrrYLMe204PisN7wFZA46kjiJzTVxhlB2i0H+UTio8MgczZVYiAcfazGH+CZ1Uww
 G88ic+V56WazjpzY7caAxkqYs1lfUEKOjP27XtH+vC9nZitI71T5SZzAyP7b7o3VoQ11p
X-Received: by 2002:adf:db12:0:b0:323:1d8a:3d87 with SMTP id
 s18-20020adfdb12000000b003231d8a3d87mr1601310wri.4.1696409169201; 
 Wed, 04 Oct 2023 01:46:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgU4vzBtvmtGIMANsrrNskvDIHp8yfvmhj+Udy0VNscaS7ga+GE1g/Z/mWZraCLULSXn83VQ==
X-Received: by 2002:adf:db12:0:b0:323:1d8a:3d87 with SMTP id
 s18-20020adfdb12000000b003231d8a3d87mr1601294wri.4.1696409168883; 
 Wed, 04 Oct 2023 01:46:08 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 r5-20020adfce85000000b00315af025098sm3444581wrn.46.2023.10.04.01.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:46:08 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:46:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 55/63] pcie_sriov: unregister_vfs(): fix error path
Message-ID: <28d8e88d3dd3fe78c7441e38a1c08fa1ae5fc51a.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

local_err must be NULL before calling object_property_set_bool(), so we
must clear it on each iteration. Let's also use more convenient
error_reportf_err().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20230925194040.68592-8-vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 76a3b6917e..5ef8950940 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -196,19 +196,16 @@ static void register_vfs(PCIDevice *dev)
 
 static void unregister_vfs(PCIDevice *dev)
 {
-    Error *local_err = NULL;
     uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
     uint16_t i;
 
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
+        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        object_property_set_bool(OBJECT(vf), "realized", false, &local_err);
-        if (local_err) {
-            fprintf(stderr, "Failed to unplug: %s\n",
-                    error_get_pretty(local_err));
-            error_free(local_err);
+        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
+            error_reportf_err(err, "Failed to unplug: ");
         }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
-- 
MST


