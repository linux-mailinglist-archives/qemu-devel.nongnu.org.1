Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 637C47F12C6
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 13:08:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r532u-0006Rz-NJ; Mon, 20 Nov 2023 07:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1r532r-0006QZ-AC; Mon, 20 Nov 2023 07:06:29 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1r532o-0004qX-Cc; Mon, 20 Nov 2023 07:06:29 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com BFF6EC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1700481984;
 bh=SXSNj1W7Kz+aSldUPo1hOHeLKsnFtMZxHNHcTs0zYJ4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=EMuVZWgfL8+IDTeK2LhmAiNV0Q4vRRAOXJ2f26AySZVm+ak98XH44KK/Qrm+3AlZl
 04Zx5bFQXI5Ge6sa6gekAJooHlQ7j1JgE5qSok4uBhBq1MruPZmVRiulq9rYc+Uhvw
 uUpYoAUMezwYgD0crlkMiCw2jjd0b7kBCgsEnldoLJ6uMRyqu3SypthLZm3+FAfDWp
 7yD32mv5nJ6kR/FtZCSI1wrALj8N3SqiRjsO1K+xXPP94VG7fjYWgB6vNlLlzymvXF
 x9npiqtngysunASwxMsbDY5QGgWlURTlHsy+By59BW9WwEEoapwUXrazKh1cveKJmf
 Ao++G8jOt+8wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1700481984;
 bh=SXSNj1W7Kz+aSldUPo1hOHeLKsnFtMZxHNHcTs0zYJ4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=r4G72BasqC83k2h+9Hv25MwotdVrGXQ8y7Ae/3cMwF4ZCEHl46xiO9cxWHCiqPL6O
 cEUd6gQOTYPZV8SM8gTq/woLaNBRYdrNxfPqnpQPpBXc73bt5BmghxgtIWwmjYWouw
 LsGUteXtK8eoU1ZMTdygif/iPxyDJ5IAE07CxVR1ZzbKUmIce09XmxufqE2MPdSJFJ
 CJsLS88iJfFyAx16II8eqPK77nPiypqAeDx0nW3W1diUpH05lV8ffTs+N9FZIuze/6
 qV8U+q+jHqxnfmeePkYlnoW+NmUnXcpE61C9q8CJVgk3XeJ55FgB8lNXwZJwmhv6SJ
 bR+LhslCAZxGg==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bin.meng@windriver.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [PATCH 2/2] target/riscv/cpu_helper.c: Fix mxr bit behavior
Date: Mon, 20 Nov 2023 15:06:09 +0300
Message-ID: <20231120120609.37960-3-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120120609.37960-1-ivan.klokov@syntacore.com>
References: <20231120120609.37960-1-ivan.klokov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=ivan.klokov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

According to RISCV Specification sect 9.5 on two stage translation when
V=1 the vsstatus(mstatus in QEMU's terms) field MXR, which makes
execute-only pages readable, only overrides VS-stage page protection.
Setting MXR at HS-level(mstatus_hs), however, overrides both VS-stage
and G-stage execute-only permissions.

The hypervisor extension changes the behavior of MXR\MPV\MPRV bits.
Due to RISCV Specification sect. 9.4.1 when MPRV=1, explicit memory
accesses are translated and protected, and endianness is applied, as
though the current virtualization mode were set to MPV and the current
nominal privilege mode were set to MPP. vsstatus.MXR makes readable
those pages marked executable at the VS translation stage.

Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
---
 target/riscv/cpu_helper.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9ff0952e46..e7e23b34f4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1032,13 +1032,29 @@ restart:
         prot |= PAGE_WRITE;
     }
     if (pte & PTE_X) {
-        bool mxr;
+        bool mxr = false;
 
-        if (first_stage == true) {
+        /*
+         * Use mstatus for first stage or for the second stage without
+         * virt_enabled (MPRV+MPV)
+         */
+        if (first_stage || !env->virt_enabled) {
             mxr = get_field(env->mstatus, MSTATUS_MXR);
-        } else {
-            mxr = get_field(env->vsstatus, MSTATUS_MXR);
         }
+
+        /* MPRV+MPV case, check VSSTATUS */
+        if (first_stage && two_stage && !env->virt_enabled) {
+            mxr |= get_field(env->vsstatus, MSTATUS_MXR);
+        }
+
+        /*
+         * Setting MXR at HS-level overrides both VS-stage and G-stage
+         * execute-only permissions
+         */
+        if (env->virt_enabled) {
+            mxr |= get_field(env->mstatus_hs, MSTATUS_MXR);
+        }
+
         if (mxr) {
             prot |= PAGE_READ;
         }
-- 
2.34.1


