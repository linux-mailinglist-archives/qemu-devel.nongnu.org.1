Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C31C97DEF1B
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 10:42:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUCW-0007WF-GY; Thu, 02 Nov 2023 05:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qyUCN-0007UA-LI; Thu, 02 Nov 2023 05:41:12 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qyUCK-0000b8-Ua; Thu, 02 Nov 2023 05:41:10 -0400
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3A29eg2w058830;
 Thu, 2 Nov 2023 17:40:42 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox.andestech.com (10.0.12.51) by
 ATCPCS16.andestech.com (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; 
 Thu, 2 Nov 2023 17:40:37 +0800
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <in.meng@windriver.com>,
 <liweiwei@iscas.ac.cn>, <dbarboza@ventanamicro.com>,
 <hiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>,
 <peterx@redhat.com>, <david@redhat.com>, Ethan Chen <ethan84@andestech.com>
Subject: [PATCH v2 1/4] exec/memattrs: Add iopmp source id, start address,
 end address to MemTxAttrs
Date: Thu, 2 Nov 2023 17:40:12 +0800
Message-ID: <20231102094015.208588-2-ethan84@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102094015.208588-1-ethan84@andestech.com>
References: <20231102094015.208588-1-ethan84@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.12.51]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3A29eg2w058830
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Signed-off-by: Ethan Chen <ethan84@andestech.com>
---
 include/exec/memattrs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index d04170aa27..fc15e5d7d3 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -64,6 +64,12 @@ typedef struct MemTxAttrs {
     unsigned int target_tlb_bit0 : 1;
     unsigned int target_tlb_bit1 : 1;
     unsigned int target_tlb_bit2 : 1;
+
+    /* IOPMP support up to 65535 sources */
+    unsigned int iopmp_sid:16;
+    /* Transaction infomation for IOPMP */
+    unsigned long long iopmp_start_addr;
+    unsigned long long iopmp_end_addr;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
-- 
2.34.1


