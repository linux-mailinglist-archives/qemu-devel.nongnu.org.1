Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3228AB0029
	for <lists+qemu-devel@lfdr.de>; Thu,  8 May 2025 18:18:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD3wI-0000qU-R9; Thu, 08 May 2025 12:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD3vl-0000CX-Ll
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD3vk-0007nB-2e
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746721022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zvYIrVIVSLJaAlAqe9SHyPChFnu6E1biirLk7L5CoFk=;
 b=iGuWp6CHW29tKzKTrrhLLDwzPU74zE/HWp12hsGX9/JiilBM5VTR26cOWLSwOIvXF/trt7
 +hO+LDxTEQsPbqQChY5u1o8N4uptSbDdalohCEnB0eUHt/qvcWV4+o0UKnf1b6u4Aam7r5
 F0Ti0iOswEI0fwW4Lvcf3uF/CAjz+PY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-_O8JvQd3Ojm2xgM9_loRVQ-1; Thu,
 08 May 2025 12:16:38 -0400
X-MC-Unique: _O8JvQd3Ojm2xgM9_loRVQ-1
X-Mimecast-MFC-AGG-ID: _O8JvQd3Ojm2xgM9_loRVQ_1746720961
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8B131955DDA; Thu,  8 May 2025 16:15:59 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4DB65180049D; Thu,  8 May 2025 16:15:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, devel@lists.libvirt.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 3/6] include/hw/boards: cope with dev/rc versions in
 deprecation checks
Date: Thu,  8 May 2025 17:15:33 +0100
Message-ID: <20250508161536.865866-4-berrange@redhat.com>
In-Reply-To: <20250508161536.865866-1-berrange@redhat.com>
References: <20250508161536.865866-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When VERSION is set to a development snapshot (micro >= 50), or a release
candidate (micro >= 90) we have an off-by-1 in determining deprecation
and deletion thresholds for versioned machine types. In such cases we need
to use the next major/minor version in threshold checks.

This adapts the deprecation macros to do "next version" prediction when
seeing a dev/rc version number.

This ensures users of release candidates get an accurate view of machines
that will be deprecated/deleted in the final release.

This requires hardcoding our current release policy of 3 releases per
year, with a major bump at the start of each year, and that dev/rc
versions have micro >= 50.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/boards.h | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 74a8e96b2e..a6784fe984 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -650,11 +650,42 @@ struct MachineState {
     " years old are subject to deletion after " \
     stringify(MACHINE_VER_DELETION_MAJOR) " years"
 
-#define _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor) \
+#define _MACHINE_VER_IS_CURRENT_EXPIRED(cutoff, major, minor) \
     (((QEMU_VERSION_MAJOR - major) > cutoff) || \
      (((QEMU_VERSION_MAJOR - major) == cutoff) && \
       (QEMU_VERSION_MINOR - minor) >= 0))
 
+#define _MACHINE_VER_IS_NEXT_MINOR_EXPIRED(cutoff, major, minor) \
+    (((QEMU_VERSION_MAJOR - major) > cutoff) || \
+     (((QEMU_VERSION_MAJOR - major) == cutoff) && \
+      ((QEMU_VERSION_MINOR + 1) - minor) >= 0))
+
+#define _MACHINE_VER_IS_NEXT_MAJOR_EXPIRED(cutoff, major, minor) \
+    ((((QEMU_VERSION_MAJOR + 1) - major) > cutoff) ||            \
+     ((((QEMU_VERSION_MAJOR + 1) - major) == cutoff) &&          \
+      (0 - minor) >= 0))
+
+/*
+ * - The first check applies to formal releases
+ * - The second check applies to dev snapshots / release candidates
+ *   where the next major version is the same.
+ *   e.g. 9.0.50, 9.1.50, 9.0.90, 9.1.90
+ * - The third check applies to dev snapshots / release candidates
+ *   where the next major version will change.
+ *   e.g. 9.2.50, 9.2.90
+ *
+ * NB: this assumes we do 3 minor releases per year, before bumping major,
+ * and dev snapshots / release candidates are numbered with micro >= 50
+ * If this ever changes the logic below will need modifying....
+ */
+#define _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor) \
+    ((QEMU_VERSION_MICRO < 50 && \
+      _MACHINE_VER_IS_CURRENT_EXPIRED(cutoff, major, minor)) || \
+     (QEMU_VERSION_MICRO >= 50 && QEMU_VERSION_MINOR < 2 && \
+      _MACHINE_VER_IS_NEXT_MINOR_EXPIRED(cutoff, major, minor)) || \
+     (QEMU_VERSION_MICRO >= 50 && QEMU_VERSION_MINOR == 2 && \
+      _MACHINE_VER_IS_NEXT_MAJOR_EXPIRED(cutoff, major, minor)))
+
 #define _MACHINE_VER_IS_EXPIRED2(cutoff, major, minor) \
     _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor)
 #define _MACHINE_VER_IS_EXPIRED3(cutoff, major, minor, micro) \
-- 
2.49.0


