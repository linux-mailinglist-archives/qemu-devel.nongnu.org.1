Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 310957DAA4B
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 02:47:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwtwc-0008JN-9K; Sat, 28 Oct 2023 20:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1qwtvw-0008Gd-MG; Sat, 28 Oct 2023 20:45:51 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1qwtvu-0005J1-Lk; Sat, 28 Oct 2023 20:45:40 -0400
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9CD013F6C3; 
 Sun, 29 Oct 2023 00:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698540331;
 bh=1KO0+EesrUry2uIn5zxpVo15Dx/knQ2PZoaGu1sXa8c=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=YqJVUU7nayO3FXeUSIqqrvVs0ovOwK+ITshW4J8Xj+Cas8AnDacB0Avlpxz9k9t8I
 Kw4K8I1tchcjv8hEVXkaWGJQvOaBRotjTFhAu2bkEe5bBJe/gqpV09R9tKJCHBGw59
 KlY57j1wK5IHiMYrpycnnIBJQJFJ0vWuF0AgdxXkEXrzd3UdpmRSlAT0kdi/a9y7Dq
 JpCK/55v2tDQyQ7vSOG9IoXqSIviXY2qYh5OMqhgyVRHzu8lFxQRNbbcaWYQlvDsLK
 UEniM2Y5d17R0VvGepI/KVSynJQUFlFvy+PBmzZl5FPFaJtKoNxurVO28NlOTYWDMG
 S26RHnXWakbTQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] target/riscv: correct csr_ops[CSR_MSECCFG]
Date: Sun, 29 Oct 2023 02:42:47 +0200
Message-Id: <20231029004247.21217-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.120;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-canonical-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The CSR register mseccfg is used by multiple extensions: Smepm and Zkr.

Consider this when checking the existence of the register.

Fixes: 77442380ecbe ("target/riscv: rvk: add CSR support for Zkr")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 target/riscv/csr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4b4ab56c40..07c0cfb7d8 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -523,11 +523,14 @@ static RISCVException pmp(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
-static RISCVException epmp(CPURISCVState *env, int csrno)
+static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
 {
     if (riscv_cpu_cfg(env)->epmp) {
         return RISCV_EXCP_NONE;
     }
+    if (riscv_cpu_cfg(env)->ext_zkr) {
+        return RISCV_EXCP_NONE;
+    }
 
     return RISCV_EXCP_ILLEGAL_INST;
 }
@@ -4379,7 +4382,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSIPH]       = { "vsiph",       aia_hmode32, NULL, NULL, rmw_vsiph },
 
     /* Physical Memory Protection */
-    [CSR_MSECCFG]    = { "mseccfg",  epmp, read_mseccfg, write_mseccfg,
+    [CSR_MSECCFG]    = { "mseccfg",   have_mseccfg, read_mseccfg, write_mseccfg,
                          .min_priv_ver = PRIV_VERSION_1_11_0           },
     [CSR_PMPCFG0]    = { "pmpcfg0",   pmp, read_pmpcfg,  write_pmpcfg  },
     [CSR_PMPCFG1]    = { "pmpcfg1",   pmp, read_pmpcfg,  write_pmpcfg  },
-- 
2.40.1


