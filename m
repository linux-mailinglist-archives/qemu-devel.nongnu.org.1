Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5528C80D7
	for <lists+qemu-devel@lfdr.de>; Fri, 17 May 2024 08:16:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7qtE-0008EI-Su; Fri, 17 May 2024 02:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7qt4-00084b-Os
 for qemu-devel@nongnu.org; Fri, 17 May 2024 02:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7qsp-00043A-J7
 for qemu-devel@nongnu.org; Fri, 17 May 2024 02:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715926558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qJwbcIxS3P84qeDAqfJAKw86XXMCDKPFSQAT2daNTTM=;
 b=dFB1hGTdeV0UFlmRl6HPp4ba/1pFRquapnkTGXyJnHFXFoOjbR4G8YMJV8qHt6RY97UVr7
 jxyr+ZH/Kobu+B6nKiwcpGxLoWZ5m1kkfG6DoQiApy1HvL7IzHmRt1uKkdwo8BblsZ5+S6
 iFK3uldkqwFlDZUz/Y6z47ENcgCyk/0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-HcKGsXo6Mx6wW9EgJTageA-1; Fri,
 17 May 2024 02:15:56 -0400
X-MC-Unique: HcKGsXo6Mx6wW9EgJTageA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7167D3815EE5;
 Fri, 17 May 2024 06:15:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DC9251BF;
 Fri, 17 May 2024 06:15:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] hw/intc/s390_flic: Fix crash that occurs when saving the
 machine state
Date: Fri, 17 May 2024 08:15:53 +0200
Message-ID: <20240517061553.564529-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

adapter_info_so_needed() treats its "opaque" parameter as a S390FLICState,
but the function belongs to a VMStateDescription that is attached to a
TYPE_VIRTIO_CCW_BUS device. This is currently causing a crash when the
user tries to save or migrate the VM state. Fix it by using s390_get_flic()
to get the correct device here instead.

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Fixes: 9d1b0f5bf5 ("s390_flic: add migration-enabled property")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/intc/s390_flic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 7f93080087..6771645699 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -459,7 +459,7 @@ type_init(qemu_s390_flic_register_types)
 
 static bool adapter_info_so_needed(void *opaque)
 {
-    S390FLICState *fs = S390_FLIC_COMMON(opaque);
+    S390FLICState *fs = s390_get_flic();
 
     return fs->migration_enabled;
 }
-- 
2.45.0


