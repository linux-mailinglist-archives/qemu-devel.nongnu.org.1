Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBD4AC06C6
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 10:14:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI13D-0007Ud-Iu; Thu, 22 May 2025 04:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1uI139-0007U8-CS
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:13:11 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1uI137-0003No-OS
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:13:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 04BFB44F40;
 Thu, 22 May 2025 08:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D06C4CEE4;
 Thu, 22 May 2025 08:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747901586;
 bh=3xq4wlfIvy9OM7kxdwoakK4Cms1/XS4ZMH0xxD790tQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Zro/PgbrhMzOxujAEbjrFQsyBAAew3CoA7aquy3EBkmkTS/v/4ls9ldkLf2xLriQq
 OSi/CWRQMDPFgHNACZywoaLDKDVguqTZ7RXMTmPKdB16ATAeEI6LXQManKNEY+n9MF
 PQPUciK0Nn8oTW7G6X3Wcn2pP7f2XKdtrnQaz8sjpuyqnHV9G1j1yNBvQDeJJ8McFX
 xhF9/DYNnCIahHMKsKdlq1jqfjARFpt1tD2wts2hyN0pfen5A4qAacAIOGmdvvZcQY
 ifCrHYket1WfTjxyNu/XfwwYc/+DPuzsYANOb0DitbOfTB0zZ4XDM4++3SZ6YaiH3/
 1iRvkxqRPtsCw==
From: deller@kernel.org
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 1/3] target/hppa: Copy instruction code into fr1 on FPU assist
 fault
Date: Thu, 22 May 2025 10:12:55 +0200
Message-ID: <20250522081257.3409-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250522081257.3409-1-deller@kernel.org>
References: <20250522081257.3409-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Helge Deller <deller@gmx.de>

The hardware stores the instruction code in the lower bits of the FP
exception register #1 on FP assist traps.
This fixes the FP exception handler on Linux, as the Linux kernel uses
the value to decide on the correct signal which should be pushed into
userspace (see decode_fpu() in Linux kernel).

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/int_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 7d48643bb6..191ae19404 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -177,6 +177,10 @@ void hppa_cpu_do_interrupt(CPUState *cs)
                     }
                 }
                 env->cr[CR_IIR] = ldl_phys(cs->as, paddr);
+                if (i == EXCP_ASSIST) {
+                    /* stuff insn code into bits of FP exception register #1 */
+                    env->fr[0] |= (env->cr[CR_IIR] & 0x03ffffff);
+                }
             }
             break;
 
-- 
2.47.0


