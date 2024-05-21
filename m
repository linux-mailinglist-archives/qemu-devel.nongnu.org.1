Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA06F8CB49E
	for <lists+qemu-devel@lfdr.de>; Tue, 21 May 2024 22:16:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Vtd-0000po-7B; Tue, 21 May 2024 16:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1s9Vta-0000lq-QB
 for qemu-devel@nongnu.org; Tue, 21 May 2024 16:15:38 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1s9VtY-00079Y-Nu
 for qemu-devel@nongnu.org; Tue, 21 May 2024 16:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=lbvYSLbCPQ1HQg6H+jUM6ipNX66a/4Z+ECU8F8fW2Zc=; b=wVSbU/xl7roNobi
 r+PJtPcueau5z8ptYVs9rkyVmme/haeElRBMMM8bqj74TEAyPQkWfkEFhgjMs1MRi9opWVn495MN+
 SoKuA+0rNtLhs6zn+1Lvl6PxvI5uog4QDF4aX3zeNO6guhMS5s7bUghBfKGVI8eIWbtWP1nv3Ewmw
 Qc=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	ltaylorsimpson@gmail.com,
	bcain@quicinc.com
Subject: [PATCH v3 1/4] target/hexagon: idef-parser remove unused defines
Date: Tue, 21 May 2024 22:16:51 +0200
Message-ID: <20240521201654.25851-2-anjo@rev.ng>
In-Reply-To: <20240521201654.25851-1-anjo@rev.ng>
References: <20240521201654.25851-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Before switching to GArray/g_string_printf we used fixed size arrays for
output buffers and instructions arguments among other things.

Macros defining the sizes of these buffers were left behind, remove
them.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/idef-parser/idef-parser.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/hexagon/idef-parser/idef-parser.h b/target/hexagon/idef-parser/idef-parser.h
index 3faa1deecd..8594cbe3a2 100644
--- a/target/hexagon/idef-parser/idef-parser.h
+++ b/target/hexagon/idef-parser/idef-parser.h
@@ -23,16 +23,6 @@
 #include <stdbool.h>
 #include <glib.h>
 
-#define TCGV_NAME_SIZE 7
-#define MAX_WRITTEN_REGS 32
-#define OFFSET_STR_LEN 32
-#define ALLOC_LIST_LEN 32
-#define ALLOC_NAME_SIZE 32
-#define INIT_LIST_LEN 32
-#define OUT_BUF_LEN (1024 * 1024)
-#define SIGNATURE_BUF_LEN (128 * 1024)
-#define HEADER_BUF_LEN (128 * 1024)
-
 /* Variadic macros to wrap the buffer printing functions */
 #define EMIT(c, ...)                                                           \
     do {                                                                       \
-- 
2.45.0


