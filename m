Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA690819B9D
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 10:44:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFt5C-0002aG-LC; Wed, 20 Dec 2023 04:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt54-0002VW-70
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt51-0005jZ-Q3
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703065290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hip78PPSSp5f0REv23boWvQ7T3AXTIegwEH73XCmsns=;
 b=OH/q+PcPyfgM0cwmxn8IppClJcNiBxeYMsvce2AabUQR5wgLEDiRHcKFPlPFtR4j4DE2z0
 5SQtBzxj22KYAMybEhi7x9Lyyu4RCw2NbLtJJmxqCl763h6St3WA62ZKZclvrn7Y/QP4tA
 RxX0B1HaJABQtMvhL1WiHyZhKJwj9Vw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-FFVyEYmuPGKu-otqr28czA-1; Wed, 20 Dec 2023 04:41:26 -0500
X-MC-Unique: FFVyEYmuPGKu-otqr28czA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DB4D863061;
 Wed, 20 Dec 2023 09:41:26 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA1302166B31;
 Wed, 20 Dec 2023 09:41:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/19] docs/system/arm: Fix for rename of type "xlnx.bbram-ctrl"
Date: Wed, 20 Dec 2023 10:40:55 +0100
Message-ID: <20231220094105.6588-10-thuth@redhat.com>
In-Reply-To: <20231220094105.6588-1-thuth@redhat.com>
References: <20231220094105.6588-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: Markus Armbruster <armbru@redhat.com>

Fixes: b65b4b7ae3c8 (xlnx-bbram: hw/nvram: Use dot in device type name)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
[thuth: Use longhand syntax to avoid problems with the "." in the name]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20231117114457.177308-2-thuth@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/arm/xlnx-versal-virt.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index d2d1b26692..9a4b2ff55f 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -194,7 +194,7 @@ To use a different index value, N, from default of 0, add:
 
 .. code-block:: bash
 
-  -global xlnx,bbram-ctrl.drive-index=N
+  -global driver=xlnx.bbram-ctrl,property=drive-index,value=N
 
 eFUSE File Backend
 """"""""""""""""""
-- 
2.43.0


