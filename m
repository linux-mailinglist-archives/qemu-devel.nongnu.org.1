Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DF5A23EA5
	for <lists+qemu-devel@lfdr.de>; Fri, 31 Jan 2025 14:48:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdrMj-0008Af-FJ; Fri, 31 Jan 2025 08:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tdrMh-0008AW-Tg
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 08:47:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tdrMf-0003n9-SE
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 08:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738331237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jvNbNCWnD/06MZnGY9GwwM9r1LyNWPvpGuSHwNQxZ6w=;
 b=iFqNr0v0JrCMhUCDbkQyVVZX1AusqM5jnZxvMtO40CLj8ZeoH8E9IAj2NOqk7NtBMn+gom
 4jz0N5eTngTJjHLsowkMGxv+azIgJreRo43Dyluac5eu/Wyp1CkxAPaLerutBwekits4lL
 KcDpS6IQhz9ymzTpHgB5fFeZjLe7Lss=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-EUPDuw-YOa6mU7v--NdIfg-1; Fri,
 31 Jan 2025 08:47:14 -0500
X-MC-Unique: EUPDuw-YOa6mU7v--NdIfg-1
X-Mimecast-MFC-AGG-ID: EUPDuw-YOa6mU7v--NdIfg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BFC418009B8; Fri, 31 Jan 2025 13:47:13 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 168E0180142F; Fri, 31 Jan 2025 13:47:11 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com
Subject: [PATCH v2 4/6] tcg:tlb: use tcg_debug_assert() in assert_cpu_is_self()
Date: Fri, 31 Jan 2025 14:47:09 +0100
Message-ID: <20250131134709.1306195-1-imammedo@redhat.com>
In-Reply-To: <20250129134436.1240740-5-imammedo@redhat.com>
References: <20250129134436.1240740-5-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

that will enable assert_cpu_is_self when QEMU is configured with
   --enable-debug
without need for manual patching DEBUG_TLB_GATE define.

Need to manually path DEBUG_TLB_GATE define to enable assert,
let regression caused by [1] creep in unnoticed.

1) 30933c4fb4f3d ("tcg/cputlb: remove other-cpu capability from TLB flushing")
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
---
v2: revert DEBUG_TLB_GATE/DEBUG_TLB_LOG_GATE to 0 as it used to be
---
 accel/tcg/cputlb.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b4ccf0cdcb..7380b29da3 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -74,11 +74,8 @@
     } \
 } while (0)
 
-#define assert_cpu_is_self(cpu) do {                              \
-        if (DEBUG_TLB_GATE) {                                     \
-            g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));   \
-        }                                                         \
-    } while (0)
+#define assert_cpu_is_self(cpu)                             \
+    tcg_debug_assert(!(cpu)->created || qemu_cpu_is_self(cpu))
 
 /* run_on_cpu_data.target_ptr should always be big enough for a
  * vaddr even on 32 bit builds
-- 
2.43.0


