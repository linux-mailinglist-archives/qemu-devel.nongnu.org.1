Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A4FB1E8F8
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Aug 2025 15:13:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLot-0006cv-9x; Fri, 08 Aug 2025 08:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnd-0004Hr-CS
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:02:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnb-0007CP-Hc
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754654534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TjsEiU6idgYODMC5HW9snh3H7FKlCoSoz/xZ8Ri2Fo=;
 b=iedkf7y8Jx38y2ymDsbNqqLFF4XMTiMlPeG+0hUC0QTiy4PxQ5XHzOYSyM6v78wUoQxmZ5
 HjS1RKE4oo0be+eT7XE2mVeKUQirgkrW7OfEy/SKBKDqnRg1PcSn1JjSbwvsrrUVBWTn2M
 MLC9P1oCH7a2sRevTSwRFRBmAxs5SmA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-89tdTXCqMRSY6zuAZuSwWg-1; Fri,
 08 Aug 2025 08:02:11 -0400
X-MC-Unique: 89tdTXCqMRSY6zuAZuSwWg-1
X-Mimecast-MFC-AGG-ID: 89tdTXCqMRSY6zuAZuSwWg_1754654530
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88C931800297; Fri,  8 Aug 2025 12:02:10 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E63DC19560B0; Fri,  8 Aug 2025 12:02:07 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, mtosatti@redhat.com
Subject: [PATCH v3 10/10] tcg: move interrupt caching and single step masking
 closer to user
Date: Fri,  8 Aug 2025 14:01:37 +0200
Message-ID: <20250808120137.2208800-11-imammedo@redhat.com>
In-Reply-To: <20250808120137.2208800-1-imammedo@redhat.com>
References: <20250808120137.2208800-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

in cpu_handle_interrupt() the only place where cached interrupt_request
might have effect is when CPU_INTERRUPT_SSTEP_MASK applied and
cached interrupt_request handed over to cpu_exec_interrupt() and
need_replay_interrupt().

Simplify code by moving interrupt_request caching and CPU_INTERRUPT_SSTEP_MASK
masking into the block where it actually matters and drop reloading cached value
from CPUState:interrupt_request as the rest of the code directly uses
CPUState:interrupt_request.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 accel/tcg/cpu-exec.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 1269c2c6ba..82867f456c 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -779,13 +779,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
 
     if (unlikely(cpu_test_interrupt(cpu, ~0))) {
-        int interrupt_request;
         bql_lock();
-        interrupt_request = cpu->interrupt_request;
-        if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
-            /* Mask out external interrupts for this step. */
-            interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
-        }
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_DEBUG)) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_DEBUG;
             cpu->exception_index = EXCP_DEBUG;
@@ -804,6 +798,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             return true;
         } else {
             const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+            int interrupt_request = cpu->interrupt_request;
 
             if (cpu_test_interrupt(cpu, CPU_INTERRUPT_RESET)) {
                 replay_interrupt();
@@ -812,6 +807,11 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
                 return true;
             }
 
+            if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
+                /* Mask out external interrupts for this step. */
+                interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
+            }
+
             /*
              * The target hook has 3 exit conditions:
              * False when the interrupt isn't processed,
@@ -836,9 +836,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
                 cpu->exception_index = -1;
                 *last_tb = NULL;
             }
-            /* The target hook may have updated the 'cpu->interrupt_request';
-             * reload the 'interrupt_request' value */
-            interrupt_request = cpu->interrupt_request;
         }
 #endif /* !CONFIG_USER_ONLY */
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_EXITTB)) {
-- 
2.47.1


