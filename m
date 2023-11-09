Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 467657E6BFF
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:05:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15dV-0005iY-Ss; Thu, 09 Nov 2023 09:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15bK-0008Lj-LK; Thu, 09 Nov 2023 09:01:42 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15bI-0006Ef-Jt; Thu, 09 Nov 2023 09:01:42 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E962631BCE;
 Thu,  9 Nov 2023 16:59:55 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id F3F8F34507;
 Thu,  9 Nov 2023 16:59:47 +0300 (MSK)
Received: (nullmailer pid 1462850 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ricky Zhou <ricky@rzhou.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 24/62] target/i386: Fix exception classes for
 MOVNTPS/MOVNTPD.
Date: Thu,  9 Nov 2023 16:58:52 +0300
Message-Id: <20231109135933.1462615-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ricky Zhou <ricky@rzhou.org>

Before this change, MOVNTPS and MOVNTPD were labeled as Exception Class
4 (only requiring alignment for legacy SSE instructions). This changes
them to Exception Class 1 (always requiring memory alignment), as
documented in the Intel manual.
Message-Id: <20230501111428.95998-3-ricky@rzhou.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 8bf171c2d126aea6b60b818f1cee7e0e9eef0390)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 8c477c1bab..8a8d353b32 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -750,8 +750,9 @@ static void decode_0F2A(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 static void decode_0F2B(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     static const X86OpEntry opcodes_0F2B[4] = {
-        X86_OP_ENTRY3(MOVDQ,      M,x,  None,None, V,x, vex4), /* MOVNTPS */
-        X86_OP_ENTRY3(MOVDQ,      M,x,  None,None, V,x, vex4), /* MOVNTPD */
+        X86_OP_ENTRY3(MOVDQ,      M,x,  None,None, V,x, vex1), /* MOVNTPS */
+        X86_OP_ENTRY3(MOVDQ,      M,x,  None,None, V,x, vex1), /* MOVNTPD */
+        /* AMD extensions */
         X86_OP_ENTRY3(VMOVSS_st,  M,ss, None,None, V,x, vex4 cpuid(SSE4A)), /* MOVNTSS */
         X86_OP_ENTRY3(VMOVLPx_st, M,sd, None,None, V,x, vex4 cpuid(SSE4A)), /* MOVNTSD */
     };
-- 
2.39.2


