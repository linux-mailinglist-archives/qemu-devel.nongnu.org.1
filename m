Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF3173D808
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:51:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDg2x-0006Af-Vv; Mon, 26 Jun 2023 02:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qDg2s-00069C-Gg
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 02:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qDg2n-0004Qh-A0
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 02:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687762188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Ltet2rZykILGRABaVJtvsAKFyyK8WBzxZAFNXdaFdQ=;
 b=bPIcQyY9FCTx3JshrteM1o+2ylXEilDdEE9cWsdguj/xGpgGGmUPVAciS7ap19MJ3TF0gl
 bdnjZM8gSsqViHMAZusxxDEubeeHXEFehz6DQScDk+VcArFj5/lgg82sltU6PFgb1orEcM
 J1jkbdbmaSfmO1D6iJ3ET71/oooqpdU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-AN71jvxLO92Vvc_ngPc2mg-1; Mon, 26 Jun 2023 02:49:43 -0400
X-MC-Unique: AN71jvxLO92Vvc_ngPc2mg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B58D1C07249;
 Mon, 26 Jun 2023 06:49:43 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com
 (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 526C1200C0CD;
 Mon, 26 Jun 2023 06:49:43 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: oliver.upton@linux.dev, salil.mehta@huawei.com, james.morse@arm.com,
 gshan@redhat.com, Shaoqin Huang <shahuang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v1 3/5] target/arm: make psci call can be used by kvm
Date: Mon, 26 Jun 2023 02:49:07 -0400
Message-Id: <20230626064910.1787255-4-shahuang@redhat.com>
In-Reply-To: <20230626064910.1787255-1-shahuang@redhat.com>
References: <20230626064910.1787255-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Now the psci call can only be used when tcg_enabled, we want to reuse it
when kvm_enabled, which will be used in subsequent patch which enable
the psci handling in userspace.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 target/arm/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d4bee43bd0..58063a92a6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11020,7 +11020,8 @@ void arm_cpu_do_interrupt(CPUState *cs)
                       env->exception.syndrome);
     }
 
-    if (tcg_enabled() && arm_is_psci_call(cpu, cs->exception_index)) {
+    if ((tcg_enabled() || kvm_enabled()) &&
+         arm_is_psci_call(cpu, cs->exception_index)) {
         arm_handle_psci_call(cpu);
         qemu_log_mask(CPU_LOG_INT, "...handled as PSCI call\n");
         return;
-- 
2.39.1


