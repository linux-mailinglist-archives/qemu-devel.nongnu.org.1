Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB247B0576
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 15:32:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlUd5-00029C-Ml; Wed, 27 Sep 2023 09:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlUcd-00026Y-Nm
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlUcb-00058z-P5
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695821430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4kfcPFXwofOoo+Vys8gvZZqqEnhg1MRZPtXNhAw1bEs=;
 b=Hu6yL502hUpvnUxRKDt6vddAniJuQqWHypkjarCOGJOPbT18XsMLWisO9x9giJs3bNM4oR
 sigCOK+iOq8Z2BGeXIIB2rTBKP4efRDrIdpLNuxJzUfyb/4emYD7w5Sw3/XfxbgL+bYlhh
 kK6enVKFq8I0UcGaprhiJ5FTsb5VP+I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-rBJwfrLIONemkrjK1lNwRQ-1; Wed, 27 Sep 2023 09:30:25 -0400
X-MC-Unique: rBJwfrLIONemkrjK1lNwRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A5B1185A797;
 Wed, 27 Sep 2023 13:30:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F400D215670B;
 Wed, 27 Sep 2023 13:30:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Zhijian Li <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 libvir-list@redhat.com, Juan Quintela <quintela@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] hw/rdma: Deprecate the pvrdma device and the rdma subsystem
Date: Wed, 27 Sep 2023 15:30:19 +0200
Message-ID: <20230927133019.228495-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

This subsystem is said to be in a bad shape (see e.g. [1], [2]
and [3]), and nobody seems to feel responsible to pick up patches
for this and send them via a pull request. For example there is
a patch for a CVE-worthy bug posted more than half a year ago [4]
which has never been merged.

Quoting Markus: "Given the shape it is in, I wouldn't let friends
use it in production" - we shouldn't expose this to our users in
the current state. Thus let's mark it as deprecated and finally
remove it unless somebody steps up and improves the code quality
and adds proper regression tests.

[1] https://lore.kernel.org/qemu-devel/20230918144206.560120-1-armbru@redhat.com/
[2] https://lore.kernel.org/qemu-devel/ZQnojJOqoFu73995@redhat.com/
[3] https://lore.kernel.org/qemu-devel/1054981c-e8ae-c676-3b04-eeb030e11f65@tls.msk.ru/
[4] https://lore.kernel.org/qemu-devel/20230301142926.18686-1-yuval.shaia.ml@gmail.com/
[5] https://lore.kernel.org/qemu-devel/8734z9f086.fsf@pond.sub.org/

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS               | 2 +-
 docs/about/deprecated.rst | 8 ++++++++
 hw/rdma/vmw/pvrdma_main.c | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 355b1960ce..ca42b89ef8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3815,7 +3815,7 @@ F: docs/block-replication.txt
 PVRDMA
 M: Yuval Shaia <yuval.shaia.ml@gmail.com>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
-S: Maintained
+S: Odd Fixes
 F: hw/rdma/*
 F: hw/rdma/vmw/*
 F: docs/pvrdma.txt
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dc4da95329..f0c7addb1f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -365,6 +365,14 @@ QEMU's ``vhost`` feature, which would eliminate the high latency costs under
 which the 9p ``proxy`` backend currently suffers. However as of to date nobody
 has indicated plans for such kind of reimplementation unfortunately.
 
+``-device pvrdma`` and the rdma subsystem (since 8.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The pvrdma device and the whole rdma subsystem are in a bad shape and
+without active maintenance. The QEMU project intends to remove this
+device and subsystem from the code base in a future release without
+replacement unless somebody steps up and improves the situation.
+
 
 Block device options
 ''''''''''''''''''''
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 4fc6712025..ed49ce1e72 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -601,6 +601,8 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
     bool ram_shared = false;
     PCIDevice *func0;
 
+    warn_report_once("pvrdma is deprecated and will be removed in a future release");
+
     rdma_info_report("Initializing device %s %x.%x", pdev->name,
                      PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
 
-- 
2.41.0


