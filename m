Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD38FB593C9
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Sep 2025 12:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uySy6-0005Ch-PY; Tue, 16 Sep 2025 06:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uySy1-0005Bm-7F
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uySxw-0002Ci-9U
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758018671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HoLLtDqNGVTdiRisEdK/jURVkbxy+tmYmSz13Vku/6Y=;
 b=ALsQgthlB/zIWWCpQiCK3eD/ZDe9T9zP+JNr9F2koZePLUl/jxsyfZy5hzgvHJBKJJ4wKu
 zuGhGYKXodb5LK3121xsXyMij8wNLQLGoh3JJEfIT4h1ley6X4ctu/C/jnHIEzT5/oq9wb
 WDcnSRnVW48hL9k8jNWqxMCGjVpgZ4g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-VALydNDCNxyt0L8s6eUKiw-1; Tue,
 16 Sep 2025 06:31:07 -0400
X-MC-Unique: VALydNDCNxyt0L8s6eUKiw-1
X-Mimecast-MFC-AGG-ID: VALydNDCNxyt0L8s6eUKiw_1758018666
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E57D1956094; Tue, 16 Sep 2025 10:31:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.55])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E599819560B8; Tue, 16 Sep 2025 10:31:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8ABC71800D58; Tue, 16 Sep 2025 12:31:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/2] igvm: move igvm.h file to include/system
Date: Tue, 16 Sep 2025 12:31:02 +0200
Message-ID: <20250916103103.400662-2-kraxel@redhat.com>
In-Reply-To: <20250916103103.400662-1-kraxel@redhat.com>
References: <20250916103103.400662-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Prepare for arch-specific igvm code being added to the code base.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 {backends => include/system}/igvm.h | 0
 backends/igvm-cfg.c                 | 2 +-
 backends/igvm.c                     | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {backends => include/system}/igvm.h (100%)

diff --git a/backends/igvm.h b/include/system/igvm.h
similarity index 100%
rename from backends/igvm.h
rename to include/system/igvm.h
diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 45df63e06c1a..d00acf351249 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 
 #include "system/igvm-cfg.h"
-#include "igvm.h"
+#include "system/igvm.h"
 #include "qom/object_interfaces.h"
 
 static char *get_igvm(Object *obj, Error **errp)
diff --git a/backends/igvm.c b/backends/igvm.c
index 9ad41582ee5e..723d45b755a0 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -11,8 +11,8 @@
 
 #include "qemu/osdep.h"
 
-#include "igvm.h"
 #include "qapi/error.h"
+#include "system/igvm.h"
 #include "system/memory.h"
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
-- 
2.51.0


