Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B3D73D797
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:10:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfFH-0005JH-MR; Mon, 26 Jun 2023 01:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEe-0003h8-0J; Mon, 26 Jun 2023 01:58:00 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEc-0007bM-5v; Mon, 26 Jun 2023 01:57:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHFH3XJ6z4wb4;
 Mon, 26 Jun 2023 15:57:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHFD6ncmz4wb3;
 Mon, 26 Jun 2023 15:57:52 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 20/30] target/ppc: Fix sc instruction handling of LEV field
Date: Mon, 26 Jun 2023 07:56:37 +0200
Message-ID: <20230626055647.1147743-21-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626055647.1147743-1-clg@kaod.org>
References: <20230626055647.1147743-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

The top bits of the LEV field of the sc instruction are to be treated as
as a reserved field rather than a reserved value, meaning LEV is
effectively the bottom bit. LEV=0xF should be treated as LEV=1 and be
a hypercall, for example.

This changes the instruction execution to just set lev from the low bit
of the field. Processors which don't support the LEV field will continue
to ignore it.

ISA v3.1 defines LEV to be 2 bits, in order to add the 'sc 2' ultracall
instruction. TCG does not support Ultravisor, so don't worry about
that bit.

Suggested-by: "Harsh Prateek Bora" <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/translate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 1ade06361679..8f74a864e48e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4429,7 +4429,12 @@ static void gen_sc(DisasContext *ctx)
 {
     uint32_t lev;
 
-    lev = (ctx->opcode >> 5) & 0x7F;
+    /*
+     * LEV is a 7-bit field, but the top 6 bits are treated as a reserved
+     * field (i.e., ignored). ISA v3.1 changes that to 5 bits, but that is
+     * for Ultravisor which TCG does not support, so just ignore the top 6.
+     */
+    lev = (ctx->opcode >> 5) & 0x1;
     gen_exception_err(ctx, POWERPC_SYSCALL, lev);
 }
 
-- 
2.41.0


