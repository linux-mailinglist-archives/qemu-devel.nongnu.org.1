Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9389D4561
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Nov 2024 02:48:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHu-0001d3-GM; Wed, 20 Nov 2024 20:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHs-0001cW-Qt
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:16 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHr-0004Yh-FL
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=unJIN5P7Zmya2tPh5Ef9TFV6DCQ9eVjum3FXEj+KWf4=; b=hg44Pm/3H03AIcO
 u9ZsqHrLVbm6+bCAOwH8miu34gY1d85fnOnSXpbEIDBKiXKoN8vCLFWlUZBwxEhzNSfCRPB5uyX2e
 sE4HGk8FPlzkXhCAijHa0OqoZqHmICruu7PjdXPdNyuCXRWFTZOaUvkY3YHOc3NAFHDlbJ5nBUY/s
 TA=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 19/43] helper-to-tcg: Pipeline, run optimization pass
Date: Thu, 21 Nov 2024 02:49:23 +0100
Message-ID: <20241121014947.18666-20-anjo@rev.ng>
In-Reply-To: <20241121014947.18666-1-anjo@rev.ng>
References: <20241121014947.18666-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Run a standard LLVM -Os optimization pass, which makes up the bulk of
optimizations in helper-to-tcg.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/pipeline/Pipeline.cpp | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/subprojects/helper-to-tcg/pipeline/Pipeline.cpp b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
index dde3641ab3..a26b7a7350 100644
--- a/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
+++ b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
@@ -188,5 +188,17 @@ int main(int argc, char **argv)
         MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
     }
 
+    //
+    // Run a -Os optimization pass.  In general -Os will prefer loop
+    // vectorization over unrolling, as compared to -O3.  In TCG, this
+    // translates to more utilization of gvec and possibly smaller TBs.
+    //
+
+    // Optimization passes
+    MPM.addPass(PB.buildModuleSimplificationPipeline(
+        compat::OptimizationLevel::Os, compat::LTOPhase));
+    MPM.addPass(
+        PB.buildModuleOptimizationPipeline(compat::OptimizationLevel::Os));
+
     return 0;
 }
-- 
2.45.2


