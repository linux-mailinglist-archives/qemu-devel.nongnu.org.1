Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E36DD7DBE1D
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 17:39:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVHq-0000WT-8R; Mon, 30 Oct 2023 12:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxVHo-0000Vw-LP
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxVHn-0003cN-3v
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698683922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6CA2KTK6we1i56B8hC4xn3lmbHIkFYFY9NPngwzvu4A=;
 b=aW3GnS9Qt14bh9Xt3OWu2g+z2Rv7zIcNCc2dBt4RouFN99HLJolrQOfS6g1h7Q9TvyeLxG
 /wQlYRm4djIRL1XEFG6elMFoJd/0vz7WzzWQzTUCu6nfzQ6tFmwahVJG1+KcWuEgVOypg3
 kQJpnIskv0vSwtdjJyOBGNd3HyJBPec=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-s2ul7LyePYyezZE6TN28tA-1; Mon,
 30 Oct 2023 12:38:37 -0400
X-MC-Unique: s2ul7LyePYyezZE6TN28tA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C256B1C38270;
 Mon, 30 Oct 2023 16:38:36 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58B2640C6EBA;
 Mon, 30 Oct 2023 16:38:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH] ppc: qtest already exports qtest_rtas_call()
Date: Mon, 30 Oct 2023 17:38:34 +0100
Message-ID: <20231030163834.4638-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Having two functions with the same name is a bad idea.  As spapr only
uses the function locally, made it static.

When you compile with clang, you get this compilation error:

/usr/bin/ld: tests/qtest/libqos/libqos.fa.p/.._libqtest.c.o: in function `qtest_rtas_call':
/scratch/qemu/clang/full/all/../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:1195: multiple definition of `qtest_rtas_call'; libqemu-ppc64-softmmu.fa.p/hw_ppc_spapr_rtas.c.o:/scratch/qemu/clang/full/all/../../../../../mnt/code/qemu/full/hw/ppc/spapr_rtas.c:536: first defined here
clang-16: error: linker command failed with exit code 1 (use -v to see invocation)
ninja: build stopped: subcommand failed.
make: *** [Makefile:162: run-ninja] Error 1

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/hw/ppc/spapr_rtas.h | 10 ----------
 hw/ppc/spapr_rtas.c         |  4 ++--
 2 files changed, 2 insertions(+), 12 deletions(-)
 delete mode 100644 include/hw/ppc/spapr_rtas.h

diff --git a/include/hw/ppc/spapr_rtas.h b/include/hw/ppc/spapr_rtas.h
deleted file mode 100644
index 383611f10f..0000000000
--- a/include/hw/ppc/spapr_rtas.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef HW_SPAPR_RTAS_H
-#define HW_SPAPR_RTAS_H
-/*
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-uint64_t qtest_rtas_call(char *cmd, uint32_t nargs, uint64_t args,
-                         uint32_t nret, uint64_t rets);
-#endif /* HW_SPAPR_RTAS_H */
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 26c384b261..cec01b2c92 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -531,8 +531,8 @@ target_ulong spapr_rtas_call(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_PARAMETER;
 }
 
-uint64_t qtest_rtas_call(char *cmd, uint32_t nargs, uint64_t args,
-                         uint32_t nret, uint64_t rets)
+static uint64_t qtest_rtas_call(char *cmd, uint32_t nargs, uint64_t args,
+                                uint32_t nret, uint64_t rets)
 {
     int token;
 
-- 
2.41.0


