Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 152D2B8B300
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Sep 2025 22:26:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzhea-0000gf-Ju; Fri, 19 Sep 2025 16:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1uzheW-0000gQ-14
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 16:24:20 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1uzheT-0007Sz-Sy
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 16:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=j0MfzhhPUmz52oqL0Q9SwP09DOBgpFy9f5XEcS9dKbA=; b=vTvAtfiXQx0yjSG
 Osc1lrV4JtlHgJ/GXEBGyA5R4LzSRMB2gKugYdsu1hr55usF54ZyyEUS2QJNEyJ2ZftNeHGQaT7ey
 XjhvIAm3Ok8s0s1BmbOjVAS5e3o5HXHg9gzfi/LmMsoZHIXn6qJzgH7Zd4zgXas4dBguV8cMT/9Bb
 X4=;
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2] target/mips: Fix msaregnames and mxuregnames off-by-one
Date: Fri, 19 Sep 2025 22:26:28 +0200
Message-ID: <20250919202628.3513-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The msaregnames and mxuregnames arrays contains strings of 7 bytes
("w10.d0", ...) and 5 bytes ("XR10", ...) in length including the
NULL byte.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/mips/tcg/msa_translate.c | 2 +-
 target/mips/tcg/mxu_translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 82b149922f..0e947125a0 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -32,7 +32,7 @@ static inline int plus_2(DisasContext *s, int x)
 /* Include the auto-generated decoder.  */
 #include "decode-msa.c.inc"
 
-static const char msaregnames[][6] = {
+static const char msaregnames[][7] = {
     "w0.d0",  "w0.d1",  "w1.d0",  "w1.d1",
     "w2.d0",  "w2.d1",  "w3.d0",  "w3.d1",
     "w4.d0",  "w4.d1",  "w5.d0",  "w5.d1",
diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 35ebb0397d..7e8cc8b06f 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -609,7 +609,7 @@ enum {
 static TCGv mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
 static TCGv mxu_CR;
 
-static const char mxuregnames[NUMBER_OF_MXU_REGISTERS][4] = {
+static const char mxuregnames[NUMBER_OF_MXU_REGISTERS][5] = {
     "XR1",  "XR2",  "XR3",  "XR4",  "XR5",  "XR6",  "XR7",  "XR8",
     "XR9",  "XR10", "XR11", "XR12", "XR13", "XR14", "XR15", "XCR",
 };
-- 
2.51.0


