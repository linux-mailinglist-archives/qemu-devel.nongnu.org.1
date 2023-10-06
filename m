Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C747BB13E
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 07:37:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qodV9-000205-RZ; Fri, 06 Oct 2023 01:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=XSv+=FU=kaod.org=clg@ozlabs.org>)
 id 1qodV6-0001xY-Ip; Fri, 06 Oct 2023 01:35:48 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=XSv+=FU=kaod.org=clg@ozlabs.org>)
 id 1qodV4-0001dR-9S; Fri, 06 Oct 2023 01:35:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S1xwQ0jVMz4xPy;
 Fri,  6 Oct 2023 16:35:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1xwM5Z5Qz4xF8;
 Fri,  6 Oct 2023 16:35:31 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] target/ppc: Clean up local variable shadowing in
 kvm_arch_*_registers()
Date: Fri,  6 Oct 2023 07:35:26 +0200
Message-ID: <20231006053526.1031252-1-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=XSv+=FU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

Remove extra 'i' variable to fix this warning :

  ../target/ppc/kvm.c: In function ‘kvm_arch_put_registers’:
  ../target/ppc/kvm.c:963:13: warning: declaration of ‘i’ shadows a previous local [-Wshadow=compatible-local]
    963 |         int i;
        |             ^
  ../target/ppc/kvm.c:906:9: note: shadowed declaration is here
    906 |     int i;
        |         ^
  ../target/ppc/kvm.c: In function ‘kvm_arch_get_registers’:
  ../target/ppc/kvm.c:1265:13: warning: declaration of ‘i’ shadows a previous local [-Wshadow=compatible-local]
   1265 |         int i;
        |             ^
  ../target/ppc/kvm.c:1212:9: note: shadowed declaration is here
   1212 |     int i, ret;
        |         ^

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/kvm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 51112bd3670d..d0e2dcdc7734 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -960,8 +960,6 @@ int kvm_arch_put_registers(CPUState *cs, int level)
     }
 
     if (cap_one_reg) {
-        int i;
-
         /*
          * We deliberately ignore errors here, for kernels which have
          * the ONE_REG calls, but don't support the specific
@@ -1262,8 +1260,6 @@ int kvm_arch_get_registers(CPUState *cs)
     }
 
     if (cap_one_reg) {
-        int i;
-
         /*
          * We deliberately ignore errors here, for kernels which have
          * the ONE_REG calls, but don't support the specific
-- 
2.41.0


