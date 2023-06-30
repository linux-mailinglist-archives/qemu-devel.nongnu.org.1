Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C83A9743BDA
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 14:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFDDm-00006j-Ab; Fri, 30 Jun 2023 08:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qFDCY-0007iR-5W
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:26:14 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qFDCW-0007oe-9O
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=h+/U6vaIirLj+baNgCStDASbBVDN+6AEOutgWw246LE=; b=oDEj5Gf3E+SXwekEnOmKo6xM5s
 uSRWI6Ff0KhBYWdSMvIT+8/nWxHw4esP6Ud9rRQXL6BXikDzcdwIVhooqdqczQyzn047ESKxXycQi
 pPB7DDI31I6CCg8SQekyki4XOm2pqNEpsD9dp+AzvLA8P5p/yLIASTq2HqZxR5WQjSKg=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 peter.maydell@linaro.org, wangyanan55@huawei.com
Subject: [PATCH 4/9] include/hw: introduce CPU_MAX_NEGATIVE_ENV_OFFSET
Date: Fri, 30 Jun 2023 14:25:46 +0200
Message-ID: <20230630122551.21766-5-anjo@rev.ng>
In-Reply-To: <20230630122551.21766-1-anjo@rev.ng>
References: <20230630122551.21766-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

For reasons related to code-generation quality, the offset of
CPUTLBDescFast and IcountDecr from CPUArchState needs to fit within
11 bits of displacement (arm[32|64] and riscv addressing modes).

This commit introduces a new constant to store the maximum allowed
negative offset, so it can be statically asserted to hold later on.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/hw/core/cpu.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c226d7263c..0377f74d48 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -259,6 +259,17 @@ struct qemu_work_item;
 
 #define CPU_UNSET_NUMA_NODE_ID -1
 
+/*
+ * For reasons related to code-generation quality the fast path
+ * CPUTLBDescFast array and IcountDecr fields need to be located within a
+ * small negative offset of CPUArchState.  This requirement comes from
+ * host-specific addressing modes of arm[32|64] and riscv which uses 12-
+ * and 11 bits of displacement respectively.
+ */
+#define CPU_MIN_DISPLACEMENT_BITS 11
+#define CPU_MAX_NEGATIVE_ENV_OFFSET \
+    (-(1 << CPU_MIN_DISPLACEMENT_BITS))
+
 /**
  * CPUState:
  * @cpu_index: CPU index (informative).
-- 
2.41.0


