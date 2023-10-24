Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0BB7D5699
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:35:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJR5-0008N4-OW; Tue, 24 Oct 2023 11:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qvJQF-0006WW-SW; Tue, 24 Oct 2023 11:34:24 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qvJQ8-0005lS-M7; Tue, 24 Oct 2023 11:34:23 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 03372757290;
 Tue, 24 Oct 2023 17:34:09 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DA6CE75728F; Tue, 24 Oct 2023 17:34:08 +0200 (CEST)
Message-Id: <675f2c7e36b2deb0062c74e98d4b4d543567ac77.1698158152.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1698158152.git.balaton@eik.bme.hu>
References: <cover.1698158152.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 7/8] target/ppc: Clean up ifdefs in excp_helper.c, part 2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 24 Oct 2023 17:34:08 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove check for !defined(CONFIG_USER_ONLY) as this is already within
an #ifndef CONFIG_USER_ONLY block.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/excp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 4f0d5c39f0..1eecec0919 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2607,7 +2607,7 @@ void helper_hrfid(CPUPPCState *env)
 }
 #endif /* TARGET_PPC64 */
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+#ifdef TARGET_PPC64
 void helper_rfebb(CPUPPCState *env, target_ulong s)
 {
     target_ulong msr = env->msr;
@@ -2682,7 +2682,7 @@ void raise_ebb_perfm_exception(CPUPPCState *env)
 
     do_ebb(env, POWERPC_EXCP_PERFM_EBB);
 }
-#endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
+#endif /* TARGET_PPC64 */
 
 /*****************************************************************************/
 /* Embedded PowerPC specific helpers */
-- 
2.30.9


