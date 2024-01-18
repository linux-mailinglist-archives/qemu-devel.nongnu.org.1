Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C3B83158C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 10:12:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQOQJ-0006cr-HJ; Thu, 18 Jan 2024 04:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQOQC-0006ai-RU
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 04:10:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQOQB-0004gq-50
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 04:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705569046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2grxcxWrslwxTFmFJiHKe1MHiIBI0P3mUGva/9aKz7M=;
 b=QicfsohkSdKIE8W0kWCMyf/sRye+dH/Fohw+REMz1Z+YKJ8CXwlCCAdp1GDXp8AaVDUrN0
 Y8PE37qnQtNViSA34q2Q3pPSAgfqokbJJTnGgc7jXVo7yKbMGwVMFEtJ/4X/LfwReRFWok
 n/3ov93RfhVoGcIe22KLg5ZGMbf5h88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-cT3ng0XCNDSbWNBHv5Jbbw-1; Thu, 18 Jan 2024 04:10:42 -0500
X-MC-Unique: cT3ng0XCNDSbWNBHv5Jbbw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C531F85A58E;
 Thu, 18 Jan 2024 09:10:41 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12A05C15E61;
 Thu, 18 Jan 2024 09:10:37 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, peterx@redhat.com, eric.auger@redhat.com,
 Alex Williamson <alex.williamson@redhat.com>, zhenzhong.duan@intel.com,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH] MAINTAINERS: Drop myself as VT-d maintainers
Date: Thu, 18 Jan 2024 17:10:35 +0800
Message-ID: <20240118091035.48178-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

From: Peter Xu <peterx@redhat.com>

Due to my own limitation on bandwidth, I noticed that unfortunately I won't
have time to review VT-d patches at least in the near future.  Meanwhile I
expect a lot of possibilities could actually happen in this area in the
near future.

To reflect that reality, I decided to drop myself from the VT-d role.  It
shouldn't affect much since we still have Jason around like usual, and
Michael on top.  But I assume it'll always be good if anyone would like to
fill this role up.

I'll still work on QEMU.  So I suppose anyone can still copy me if one
thinks essential.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b406fb20c0..1c85b4bdad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3606,7 +3606,6 @@ F: tests/uefi-test-tools/
 
 VT-d Emulation
 M: Michael S. Tsirkin <mst@redhat.com>
-M: Peter Xu <peterx@redhat.com>
 R: Jason Wang <jasowang@redhat.com>
 S: Supported
 F: hw/i386/intel_iommu.c
-- 
2.43.0


