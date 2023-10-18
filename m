Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5125F7CDCC1
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:09:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6IK-0007F3-Nk; Wed, 18 Oct 2023 09:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HO-0004YU-Og
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HI-00080o-Mx
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oQAUStExdwPZFM614DvnkC/Yix30Ravls5bcvZOKzk8=;
 b=H+DQXkza2DDBxOssAXbx63ulHhjX4Bx3qy3wnqPz1so8YN6S20FW5kzCrdPqyVSBzOCOPE
 bArX+xTuzjXd03ukQIDwU36WYMHmQlHpMxQGzWeFayusFQQyavfku77K0kdaKfLIHfJjV7
 JcXGkbYTdZgBecH6271zRElsYXIPFMk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-zr7iORA8PPi2Q-_WSYLg4w-1; Wed, 18 Oct 2023 09:07:58 -0400
X-MC-Unique: zr7iORA8PPi2Q-_WSYLg4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA0781020203;
 Wed, 18 Oct 2023 13:07:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE26220268C8;
 Wed, 18 Oct 2023 13:07:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 23/25] target/s390x/kvm: Turn KVM_CAP_SYNC_REGS into a hard
 requirement
Date: Wed, 18 Oct 2023 15:07:14 +0200
Message-ID: <20231018130716.286638-24-thuth@redhat.com>
In-Reply-To: <20231018130716.286638-1-thuth@redhat.com>
References: <20231018130716.286638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Since we already require at least kernel 3.15 in the s390x KVM code,
we can assume that the KVM_CAP_SYNC_REGS capability is always there.
Thus turn this into a hard requirement now.

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20231011080538.796999-2-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/kvm/kvm.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 2e43dc746f..068e9826e1 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -338,21 +338,29 @@ int kvm_arch_get_default_type(MachineState *ms)
 
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


