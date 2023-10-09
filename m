Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6E07BE762
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 19:09:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qptjn-00012j-L6; Mon, 09 Oct 2023 13:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qptjl-0000zr-G3
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 13:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qptjg-000061-UI
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 13:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696871284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KDWuNECjxZQe7tH9w734/m/IFbVLLWaMNZcXVnndXYk=;
 b=PVRN1KepCKfaS65ngGJEWPMq6OgmgF7l4A6ZT9ZG+Lr5h0F4DI1aZvRMgYEISOHNCd1zTQ
 nsms7Fao/ACF0dFjEriLBd7M+4y9+zWhmwTHWQOh0L27bkR2gbS6gXD7QU5kWFXPbWTZdD
 ZtLXA8dnEfglCt2cJ7exXXHgLhv9sRc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-1NSif-FOP0iKi3UqGhVFDw-1; Mon, 09 Oct 2023 13:07:49 -0400
X-MC-Unique: 1NSif-FOP0iKi3UqGhVFDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 219EC101A598;
 Mon,  9 Oct 2023 17:07:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E009E40C6EA8;
 Mon,  9 Oct 2023 17:07:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clegoate@redhat.com>
Subject: [PATCH v2 1/2] target/s390x/kvm: Turn KVM_CAP_SYNC_REGS into a hard
 requirement
Date: Mon,  9 Oct 2023 19:07:44 +0200
Message-ID: <20231009170745.63446-2-thuth@redhat.com>
In-Reply-To: <20231009170745.63446-1-thuth@redhat.com>
References: <20231009170745.63446-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since we already require at least kernel 3.15 in the s390x KVM code,
we can assume that the KVM_CAP_SYNC_REGS capability is always there.
Thus turn this into a hard requirement now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/kvm/kvm.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index bc5c56a305..b3e2eaa2eb 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -337,21 +337,29 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
+    int required_caps[] = {
+        KVM_CAP_DEVICE_CTRL,
+        KVM_CAP_SYNC_REGS,
+    };
+
+    for (int i = 0; i < ARRAY_SIZE(required_caps); i++) {
+        if (!kvm_check_extension(s, required_caps[i])) {
+            error_report("KVM is missing capability #%d - "
+                         "please use kernel 3.15 or newer", required_caps[i]);
+            return -1;
+        }
+    }
+
     object_class_foreach(ccw_machine_class_foreach, TYPE_S390_CCW_MACHINE,
                          false, NULL);
 
-    if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
-        error_report("KVM is missing capability KVM_CAP_DEVICE_CTRL - "
-                     "please use kernel 3.15 or newer");
-        return -1;
-    }
     if (!kvm_check_extension(s, KVM_CAP_S390_COW)) {
         error_report("KVM is missing capability KVM_CAP_S390_COW - "
                      "unsupported environment");
         return -1;
     }
 
-    cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
+    cap_sync_regs = true;
     cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
     cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
     cap_mem_op_extension = kvm_check_extension(s, KVM_CAP_S390_MEM_OP_EXTENSION);
-- 
2.41.0


