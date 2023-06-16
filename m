Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D83BD732B81
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 11:28:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA5jl-0004z8-4K; Fri, 16 Jun 2023 05:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5jj-0004yb-LL
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5ji-0000HZ-3M
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686907637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odcrL41tL0J76rDneIgWHoMsdg/15Ub++D/5ea+DdKw=;
 b=H3yj68dUX4vW/ea9vXF9HdCm8VXaUuc+KganOlGbaOgxi+qG5+4TuvRQETQakOBuKuAzqH
 Vl4afsWA/IPY7QuN6h118oWVxh4TZwm8w0+HqokFe9TUUx55tLHK5c0+gFT3q5NO3Pesu3
 Atnm5CWRAvg8XJ7GGasldzpjGUVtgoA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418--8SSEMSJPJicBGTms1NJEw-1; Fri, 16 Jun 2023 05:27:15 -0400
X-MC-Unique: -8SSEMSJPJicBGTms1NJEw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 524D885A58A;
 Fri, 16 Jun 2023 09:27:15 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 983681121314;
 Fri, 16 Jun 2023 09:27:12 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 02/15] kvm: Add stub for kvm_get_max_memslots()
Date: Fri, 16 Jun 2023 11:26:41 +0200
Message-Id: <20230616092654.175518-3-david@redhat.com>
In-Reply-To: <20230616092654.175518-1-david@redhat.com>
References: <20230616092654.175518-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We'll need the stub soon from memory device context.

While at it, use "unsigned int" as return value and place the
declaration next to kvm_get_free_memslots().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/kvm/kvm-all.c    | 2 +-
 accel/stubs/kvm-stub.c | 5 +++++
 include/sysemu/kvm.h   | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7679f397ae..94d672010e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -174,7 +174,7 @@ void kvm_resample_fd_notify(int gsi)
     }
 }
 
-int kvm_get_max_memslots(void)
+unsigned int kvm_get_max_memslots(void)
 {
     KVMState *s = KVM_STATE(current_accel());
 
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 5d2dd8f351..506bc8c9e4 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -108,6 +108,11 @@ int kvm_irqchip_remove_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
     return -ENOSYS;
 }
 
+unsigned int kvm_get_max_memslots(void)
+{
+    return UINT_MAX;
+}
+
 bool kvm_has_free_slot(MachineState *ms)
 {
     return false;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 88f5ccfbce..7a999eff52 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -213,6 +213,7 @@ typedef struct KVMRouteChange {
 
 /* external API */
 
+unsigned int kvm_get_max_memslots(void);
 bool kvm_has_free_slot(MachineState *ms);
 bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
@@ -559,7 +560,6 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *source);
  */
 int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
 struct ppc_radix_page_info *kvm_get_radix_page_info(void);
-int kvm_get_max_memslots(void);
 
 /* Notify resamplefd for EOI of specific interrupts. */
 void kvm_resample_fd_notify(int gsi);
-- 
2.40.1


