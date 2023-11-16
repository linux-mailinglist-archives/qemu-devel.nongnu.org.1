Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1265B7EE669
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 19:07:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gkZ-0002St-0k; Thu, 16 Nov 2023 13:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkM-0002No-3o
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkK-000422-KR
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700157943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iRQrsg9JElMsYFARg6ZaoqvlXVxBOPdXlhFTERZzbH0=;
 b=deN+1OT0AFFP06tTJ0N2uvS63Y63UC1NcYjyx6hGyu/aVonjy5oPiC0GIgXWi1cVV8Q4VE
 T5FLs4VzIOxxAiPN/cbuLkj3TLzL1Dl4zUXBCGzaSBoYkKoACbCJga0Am5Z7Ez4GH7/abE
 8tlzkFPERl8lmHD5gWjyHcD9CC5ZNbM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-14uBFUXKO72gR4VFo--f1w-1; Thu,
 16 Nov 2023 13:05:41 -0500
X-MC-Unique: 14uBFUXKO72gR4VFo--f1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97A451C0BA46
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 18:05:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACAD71121306;
 Thu, 16 Nov 2023 18:05:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Subject: [PULL 04/10] tests/avocado/intel_iommu: Add asset hashes to avoid
 warnings
Date: Thu, 16 Nov 2023 19:05:28 +0100
Message-ID: <20231116180534.566469-5-thuth@redhat.com>
In-Reply-To: <20231116180534.566469-1-thuth@redhat.com>
References: <20231116180534.566469-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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

The intel_iommu test is currently succeeding with annoying warnings.
Add the proper asset hashes to avoid those.

Message-ID: <20231114143531.291820-1-thuth@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/intel_iommu.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/intel_iommu.py b/tests/avocado/intel_iommu.py
index 474d62f6bf..77635ab56c 100644
--- a/tests/avocado/intel_iommu.py
+++ b/tests/avocado/intel_iommu.py
@@ -54,9 +54,11 @@ def common_vm_setup(self, custom_kernel=None):
             return
 
         kernel_url = self.distro.pxeboot_url + 'vmlinuz'
+        kernel_hash = '5b6f6876e1b5bda314f93893271da0d5777b1f3c'
         initrd_url = self.distro.pxeboot_url + 'initrd.img'
-        self.kernel_path = self.fetch_asset(kernel_url)
-        self.initrd_path = self.fetch_asset(initrd_url)
+        initrd_hash = 'dd0340a1b39bd28f88532babd4581c67649ec5b1'
+        self.kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
 
     def run_and_check(self):
         if self.kernel_path:
-- 
2.41.0


