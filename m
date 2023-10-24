Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 815E67D54A5
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvIwi-00080j-4n; Tue, 24 Oct 2023 11:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvIwc-0007wH-8Y
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvIwZ-00085G-Du
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698159822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=43kKy8njh+vP12uKvSpvf55p3yy/HVCrEJ2YaK8snmo=;
 b=Rnn/ZKSLxFltSgQr/4JxompnawcKU7EdpWz4+qYjfwJsE9018lI2T/sJhMBU+Nac1fTKr3
 lqdMyBIPH0NBKbReMlfIEWckfgDxQmwjoLsT9LZ0wpCCKhEffTDpT205hQR+nwlVulUzY5
 xJen3JuOy0OTs4tI01F5ZtdbGvpeQP8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-4JghsOPHMGas2lCeJr0YfA-1; Tue, 24 Oct 2023 11:03:40 -0400
X-MC-Unique: 4JghsOPHMGas2lCeJr0YfA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFF6E811E7D;
 Tue, 24 Oct 2023 15:03:39 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 058BD25C0;
 Tue, 24 Oct 2023 15:03:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 1/1] migration: vmstate_register() check that instance_id
 is valid
Date: Tue, 24 Oct 2023 17:03:36 +0200
Message-ID: <20231024150336.89632-2-quintela@redhat.com>
In-Reply-To: <20231024150336.89632-1-quintela@redhat.com>
References: <20231024150336.89632-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/vmstate.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 9821918631..c48cd8bb68 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -28,6 +28,7 @@
 #define QEMU_VMSTATE_H
 
 #include "hw/vmstate-if.h"
+#include "qemu/error-report.h"
 
 typedef struct VMStateInfo VMStateInfo;
 typedef struct VMStateField VMStateField;
@@ -1226,6 +1227,11 @@ static inline int vmstate_register(VMStateIf *obj, int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *opaque)
 {
+    if (instance_id == VMSTATE_INSTANCE_ID_ANY) {
+        error_report("vmstate_register: Invalid device: %s instance_id: %d",
+                     vmsd->name, instance_id);
+        return -1;
+    }
     return vmstate_register_with_alias_id(obj, instance_id, vmsd,
                                           opaque, -1, 0, NULL);
 }
-- 
2.41.0


