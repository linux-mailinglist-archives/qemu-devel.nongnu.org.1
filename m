Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 995A781F809
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 13:07:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIp8u-0007SG-7V; Thu, 28 Dec 2023 07:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rIp8r-0007RP-GK
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 07:05:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rIp8p-0007AX-06
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 07:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703765133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H2DuMaeqTNy36yPJw/MhHDWnOw7tmyH2XF4C0J+27VA=;
 b=Kcni+lUTGdobq9DO3/abtCVGocb9o4meThPU9nc/jKUMsJIEzP5foD3zFCJ76PCwadPLk0
 YBlz2NwBozzdpWyERjC8LmTSBip1RhrvImv/L2KePJKDLOPfQQm2NXfVJ9aKPfJzvOckcj
 IS4fZ5h6BLC7TyTzrl5s+TwIqBG3HiU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-QTOFtcqzNTaMZwg2kSwRWQ-1; Thu, 28 Dec 2023 07:05:27 -0500
X-MC-Unique: QTOFtcqzNTaMZwg2kSwRWQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40d1ffbc3b8so57617325e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 04:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703765125; x=1704369925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H2DuMaeqTNy36yPJw/MhHDWnOw7tmyH2XF4C0J+27VA=;
 b=ViP75ywrKKBeU9fuRU3p9uSM/IBtBb3KheCaZUApg35z6MOUZ6KssW7swNnD84AraS
 l6OUxoLXY5STcrXZTJQSy3RMChyb+NY/f51WHq6D9wIFR1ZeJodjVyYrLxI8aoXtcA4U
 4NhHm3GRCGnYIC3iLvuJ9wRRuI7ekMMM8VcY6MFhQYmy5ZnUveoa0yMVm4m9fIsUphcW
 K5+pq+/xwKpiW/tAmZRdgHVJaPQjAuyJV6RwFnIgmaQXhx12E10l5Evmq5+tFspUD9zQ
 NUTM/EhM3RwOxpjNWbIYKuTGVpccbdNKqFGQ+rvzgCPVst4HJ90M3vi+rQBtN/qJhe3o
 BNQQ==
X-Gm-Message-State: AOJu0YxJYFIWHVbvIYhGZ1v999sBC+dGZJDnuI4WyAFTrdXdOCIExUzI
 qZ9vdtNQ7BEQw92jxCBiYF+7ew71Xb7WkNgiPmUh1/3cT1Ol1laEnAck3YRWasHIS5FogvBYNhp
 j3d4YykYOU7CoFgLCzyo5YXNMJlVpnkVn5F4UAXp6OU4O+FvmUxlkXt96HDOVyNAtbuCXhf2kFp
 m+QDstPrc=
X-Received: by 2002:a05:600c:4e11:b0:40d:6c73:b8c with SMTP id
 b17-20020a05600c4e1100b0040d6c730b8cmr180693wmq.367.1703765124447; 
 Thu, 28 Dec 2023 04:05:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElX7lCg1r81+3uWkpG6uxjTf4djKKphGFbDX2bDHAZSeqvkQoq6AHrhkw/4e5YYTTV685L8g==
X-Received: by 2002:a05:600c:4e11:b0:40d:6c73:b8c with SMTP id
 b17-20020a05600c4e1100b0040d6c730b8cmr180687wmq.367.1703765124030; 
 Thu, 28 Dec 2023 04:05:24 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c4fd400b004094d4292aesm27233670wmq.18.2023.12.28.04.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 04:05:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2] tcg/i386: convert add/sub of 128 to sub/add of -128
Date: Thu, 28 Dec 2023 13:05:14 +0100
Message-ID: <20231228120514.70205-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.755,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Extend the existing conditional that generates INC/DEC, to also swap an
ADD for a SUB and vice versa when the immediate is 128.  This facilitates
using OPC_ARITH_EvIb instead of OPC_ARITH_EvIz.

Best reviewed with "git diff -b".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/i386/tcg-target.c.inc | 40 +++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index a83f8aab304..1791b959738 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1316,23 +1316,31 @@ static void tgen_arithi(TCGContext *s, int c, int r0,
         c &= 7;
     }
 
-    /* ??? While INC is 2 bytes shorter than ADDL $1, they also induce
-       partial flags update stalls on Pentium4 and are not recommended
-       by current Intel optimization manuals.  */
-    if (!cf && (c == ARITH_ADD || c == ARITH_SUB) && (val == 1 || val == -1)) {
-        int is_inc = (c == ARITH_ADD) ^ (val < 0);
-        if (TCG_TARGET_REG_BITS == 64) {
-            /* The single-byte increment encodings are re-tasked as the
-               REX prefixes.  Use the MODRM encoding.  */
-            tcg_out_modrm(s, OPC_GRP5 + rexw,
-                          (is_inc ? EXT5_INC_Ev : EXT5_DEC_Ev), r0);
-        } else {
-            tcg_out8(s, (is_inc ? OPC_INC_r32 : OPC_DEC_r32) + r0);
+    if (!cf && (c == ARITH_ADD || c == ARITH_SUB)) {
+        /* ??? While INC is 2 bytes shorter than ADDL $1, they also induce
+           partial flags update stalls on Pentium4 and are not recommended
+           by current Intel optimization manuals.  */
+        if (val == 1 || val == -1) {
+            int is_inc = (c == ARITH_ADD) ^ (val < 0);
+            if (TCG_TARGET_REG_BITS == 64) {
+                /* The single-byte increment encodings are re-tasked as the
+                   REX prefixes.  Use the MODRM encoding.  */
+                tcg_out_modrm(s, OPC_GRP5 + rexw,
+                              (is_inc ? EXT5_INC_Ev : EXT5_DEC_Ev), r0);
+            } else {
+                tcg_out8(s, (is_inc ? OPC_INC_r32 : OPC_DEC_r32) + r0);
+            }
+            return;
         }
-        return;
-    }
-
-    if (c == ARITH_AND) {
+        if (val == 128) {
+            /*
+             * Facilitate using an 8-bit immediate.  Carry is inverted
+             * by this transformation, so do it only if cf == 0.
+             */
+            c ^= ARITH_ADD ^ ARITH_SUB;
+            val = -128;
+        }
+    } else if (c == ARITH_AND) {
         if (TCG_TARGET_REG_BITS == 64) {
             if (val == 0xffffffffu) {
                 tcg_out_ext32u(s, r0, r0);
-- 
2.43.0


