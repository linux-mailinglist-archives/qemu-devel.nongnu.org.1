Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E446EA21E18
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Jan 2025 14:46:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td8NV-0007jt-Nk; Wed, 29 Jan 2025 08:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8NS-0007iG-GP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:45:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8NQ-0008Nn-Tj
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738158307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50Bv2/qDBPtZJ13SGpMTxWLEPlXbmYPo0SPJLjJs8L4=;
 b=DkfKmelNdPQKQihF/ciJkAiRvmcAEaJVj2vDlDcmwxmFLkuyeXC4Ttmo2hrTrVyPeFL+4F
 esak963QS6HWQfHuWgpyrGUpAwMR02x6TYTBpehZv6sGVb9zBcsdwcj7xAMfVoYQY+GLHj
 QEqASnc8D3eJRLAMiyo7cmh91NSeP5A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-dkrflmNMNTCih589BaxNYw-1; Wed,
 29 Jan 2025 08:45:03 -0500
X-MC-Unique: dkrflmNMNTCih589BaxNYw-1
X-Mimecast-MFC-AGG-ID: dkrflmNMNTCih589BaxNYw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4A38180035E; Wed, 29 Jan 2025 13:45:01 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97CFD1800951; Wed, 29 Jan 2025 13:44:59 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 imp@bsdimp.com, kevans@freebsd.org, gaosong@loongson.cn, laurent@vivier.eu
Subject: [PATCH 6/6] tcg: drop cpu->created check
Date: Wed, 29 Jan 2025 14:44:36 +0100
Message-ID: <20250129134436.1240740-7-imammedo@redhat.com>
In-Reply-To: <20250129134436.1240740-1-imammedo@redhat.com>
References: <20250129134436.1240740-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

previous commits fixed 2 remaining cases where vcpu might
have had 'cpu->created == false' during 1st vcpu reset (at realize time)
that leads to call chain
      tcg_cpu_reset_hold() => tlb_flush_by_mmuidx()

remove not need anymore check, with cpu->created always being true.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 accel/tcg/cputlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index db1713b3ca..f4f3965518 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -75,7 +75,7 @@
 } while (0)
 
 #define assert_cpu_is_self(cpu)                             \
-    tcg_debug_assert(!(cpu)->created || qemu_cpu_is_self(cpu))
+    tcg_debug_assert(qemu_cpu_is_self(cpu))
 
 /* run_on_cpu_data.target_ptr should always be big enough for a
  * vaddr even on 32 bit builds
@@ -416,7 +416,7 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
     tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
 
-    if (cpu->created && !qemu_cpu_is_self(cpu)) {
+    if (!qemu_cpu_is_self(cpu)) {
         async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
                          RUN_ON_CPU_HOST_INT(idxmap));
     } else {
-- 
2.43.0


