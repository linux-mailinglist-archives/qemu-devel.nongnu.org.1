Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B25B84361
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Sep 2025 12:47:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzCA4-00073j-2U; Thu, 18 Sep 2025 06:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzC9z-000737-Tf
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzC9v-0003BV-VZ
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758192391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6SHIfbZaIUY0j7j4MKvKtCjFE4N3mHDUj/glz4a/TF0=;
 b=H2dXwetbjWq7waVvHvyxcG+AnjjjckFdyejKZrMqSOJYWe/OPL/RVowPvqKkKne2xlL7/0
 rRt1EbZW2VcGstJb1lMZX/9KZpe7kf+5wAMJkRxEk+zPMXzk7JdZUGS9RHloCi71EQ9mzD
 0ZBXxL041I7FPgaSiJvWWZ8Jcqfa2aw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-wwv55nv5OCitbUEuhj8NeA-1; Thu,
 18 Sep 2025 06:46:30 -0400
X-MC-Unique: wwv55nv5OCitbUEuhj8NeA-1
X-Mimecast-MFC-AGG-ID: wwv55nv5OCitbUEuhj8NeA_1758192389
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 499AC195608B; Thu, 18 Sep 2025 10:46:29 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.44.32.245])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F26AD300018D; Thu, 18 Sep 2025 10:46:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 57/60] i386/kvm: Drop KVM_CAP_X86_SMM check in kvm_arch_init()
Date: Thu, 18 Sep 2025 12:46:24 +0200
Message-ID: <20250918104624.441820-2-pbonzini@redhat.com>
In-Reply-To: <20250918104624.441820-1-pbonzini@redhat.com>
References: <20250918104624.441820-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

x86_machine_is_smm_enabled() checks the KVM_CAP_X86_SMM for KVM
case. No need to check KVM_CAP_X86_SMM in kvm_arch_init().

So just drop the check of KVM_CAP_X86_SMM to simplify the code.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250729062014.1669578-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 28012d2b578..6a3a1c1ed8e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3315,8 +3315,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
-    if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
-        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
+    if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
         x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
         smram_machine_done.notify = register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);
-- 
2.51.0


