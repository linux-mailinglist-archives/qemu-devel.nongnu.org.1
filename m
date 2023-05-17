Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 030C9706FEE
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:50:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDa-00070Z-Ix; Wed, 17 May 2023 13:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDY-0006xj-9k
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDV-00041M-HL
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhnQyFkEi7XQRjxdO590qYoQQBcg/WwkKHz6f3W8ubI=;
 b=OIBjjjO93MpCUr+2S7/wv+U63JmEg60v1gkpFZ+qZQgHrzIhFUubjPtV71ShVSqbraccTy
 dXgLi8sohqlu42lk4mxNS9N1u4EerKRJgYDeDV2H7/mwcweTisOdkIkjFOstU6+RkSE3a3
 mdy9ddLxh6triRVBehfcheTvjdkK04g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-nJ5WhI6OO0um6GeDsmn6Zg-1; Wed, 17 May 2023 13:45:35 -0400
X-MC-Unique: nJ5WhI6OO0um6GeDsmn6Zg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f4245ffbb4so6568535e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345533; x=1686937533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mhnQyFkEi7XQRjxdO590qYoQQBcg/WwkKHz6f3W8ubI=;
 b=At/FTyDEAFt2wvwojyFFAqJo2dnTxcBhU7VqNQvtCxOA9Nn8hdklfbqiHIgej35wLa
 ttYnkYi3e5gfXGzgLYYcDfja/zZ6Fw2StMlk9yG1s4SpppJh4b86KSih9ixNsiDoD+Hx
 1aTWB1YFW5RO7vB/fvYYcVEzhZhDX6kNz9xzDdp8oBP0ANey7dYNKhfCSXDtNomyJbsZ
 eJZgU0NEj1E4tUw0UHu8JQllU7mGxhHwH39X22L8kxVfWAzVTWplr5jKOSMcD4mxSKV0
 +3Ru6L84wveIiz+h22+8sckVoBVZqIVelyRa7kfobpqNRDYmwCOOSzOxm/mdfWQrW90H
 vIpA==
X-Gm-Message-State: AC+VfDxNrpZpttVwNvaWv57v8v17FdCB1Ki7XpnDicEjhMcW2KqXWioT
 8p4w0txbVUer0D91tEmNokhO2915ZBMrh35cWwNdi9nmFEuvX12GbHplio1HK3EGcCfrcnKxrt0
 ewHWo0gRnrPZEjqLCyJfEOang9g5L+1TqHMaOszyW3JzJaFtqcJh/jfVMyHbGomAcSEeSBQ36VP
 A=
X-Received: by 2002:a7b:c3c9:0:b0:3f4:27db:d with SMTP id
 t9-20020a7bc3c9000000b003f427db000dmr26129130wmj.17.1684345533105; 
 Wed, 17 May 2023 10:45:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59QLteNdC587flmTqsEP56sKyqQHBMp92VGo9OPzps2kIxYgeGAjSnmMAFUIBhSkY77kVYGA==
X-Received: by 2002:a7b:c3c9:0:b0:3f4:27db:d with SMTP id
 t9-20020a7bc3c9000000b003f427db000dmr26129117wmj.17.1684345532801; 
 Wed, 17 May 2023 10:45:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a5d58ce000000b0030629536e64sm3383554wrf.30.2023.05.17.10.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ricky Zhou <ricky@rzhou.org>
Subject: [PULL 06/68] target/i386: Fix and add some comments next to SSE/AVX
 instructions.
Date: Wed, 17 May 2023 19:44:18 +0200
Message-Id: <20230517174520.887405-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Ricky Zhou <ricky@rzhou.org>

Adds some comments describing what instructions correspond to decoding
table entries and fixes some existing comments which named the wrong
instruction.
Message-Id: <20230501111428.95998-1-ricky@rzhou.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 48fefaffdf63..e0f25e7fd8ed 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -274,9 +274,9 @@ static void decode_0F78(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 {
     static const X86OpEntry opcodes_0F78[4] = {
         {},
-        X86_OP_ENTRY3(EXTRQ_i,       V,x, None,None, I,w,  cpuid(SSE4A)),
+        X86_OP_ENTRY3(EXTRQ_i,       V,x, None,None, I,w,  cpuid(SSE4A)), /* AMD extension */
         {},
-        X86_OP_ENTRY3(INSERTQ_i,     V,x, U,x, I,w,        cpuid(SSE4A)),
+        X86_OP_ENTRY3(INSERTQ_i,     V,x, U,x, I,w,        cpuid(SSE4A)), /* AMD extension */
     };
     *entry = *decode_by_prefix(s, opcodes_0F78);
 }
@@ -284,9 +284,9 @@ static void decode_0F78(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 static void decode_0F79(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     if (s->prefix & PREFIX_REPNZ) {
-        entry->gen = gen_INSERTQ_r;
+        entry->gen = gen_INSERTQ_r; /* AMD extension */
     } else if (s->prefix & PREFIX_DATA) {
-        entry->gen = gen_EXTRQ_r;
+        entry->gen = gen_EXTRQ_r; /* AMD extension */
     } else {
         entry->gen = NULL;
     };
@@ -660,15 +660,15 @@ static void decode_0F10(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 static void decode_0F11(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     static const X86OpEntry opcodes_0F11_reg[4] = {
-        X86_OP_ENTRY3(MOVDQ,   W,x,  None,None, V,x, vex4), /* MOVPS */
-        X86_OP_ENTRY3(MOVDQ,   W,x,  None,None, V,x, vex4), /* MOVPD */
+        X86_OP_ENTRY3(MOVDQ,   W,x,  None,None, V,x, vex4), /* MOVUPS */
+        X86_OP_ENTRY3(MOVDQ,   W,x,  None,None, V,x, vex4), /* MOVUPD */
         X86_OP_ENTRY3(VMOVSS,  W,x,  H,x,       V,x, vex4),
         X86_OP_ENTRY3(VMOVLPx, W,x,  H,x,       V,q, vex4), /* MOVSD */
     };
 
     static const X86OpEntry opcodes_0F11_mem[4] = {
-        X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4), /* MOVPS */
-        X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4), /* MOVPD */
+        X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4), /* MOVUPS */
+        X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex4), /* MOVUPD */
         X86_OP_ENTRY3(VMOVSS_st,  M,ss, None,None, V,x, vex4),
         X86_OP_ENTRY3(VMOVLPx_st, M,sd, None,None, V,x, vex4), /* MOVSD */
     };
@@ -850,9 +850,9 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x17] = X86_OP_ENTRY3(VMOVHPx_st,  M,q, None,None, V,dq, vex4 p_00_66),
 
     [0x50] = X86_OP_ENTRY3(MOVMSK,     G,y, None,None, U,x, vex7 p_00_66),
-    [0x51] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
-    [0x52] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex4_rep5 p_00_f3),
-    [0x53] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex4_rep5 p_00_f3),
+    [0x51] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2), /* sqrtps */
+    [0x52] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex4_rep5 p_00_f3), /* rsqrtps */
+    [0x53] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex4_rep5 p_00_f3), /* rcpps */
     [0x54] = X86_OP_ENTRY3(PAND,       V,x, H,x, W,x,  vex4 p_00_66), /* vand */
     [0x55] = X86_OP_ENTRY3(PANDN,      V,x, H,x, W,x,  vex4 p_00_66), /* vandn */
     [0x56] = X86_OP_ENTRY3(POR,        V,x, H,x, W,x,  vex4 p_00_66), /* vor */
@@ -890,7 +890,7 @@ static const X86OpEntry opcodes_0F[256] = {
 
     [0x58] = X86_OP_ENTRY3(VADD,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
     [0x59] = X86_OP_ENTRY3(VMUL,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
-    [0x5a] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
+    [0x5a] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2), /* CVTPS2PD */
     [0x5b] = X86_OP_GROUP0(0F5B),
     [0x5c] = X86_OP_ENTRY3(VSUB,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
     [0x5d] = X86_OP_ENTRY3(VMIN,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
-- 
2.40.1


