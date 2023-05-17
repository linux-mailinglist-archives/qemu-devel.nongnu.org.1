Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DEA706FED
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:50:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDg-00072O-Bz; Wed, 17 May 2023 13:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDZ-00070J-TG
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDY-00041t-Bc
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B1pz9pdYr7Ol3IJlNK5x42XWKbQZW+4OcYJ5orhyp1E=;
 b=RXCExR40qDqnJ5rXQF2MkrHWe8NTdXN4oVmjlHKBgQF69C0LOJlufDxzuk9PxvW5N5BGwI
 B77UTI42ZX7u6Mz9tMMi4OnUSON6E01P6GUsuu9ssJ8LroTeR4SRh9bdpEiw7vUDrqeKtO
 j2Gl5VSEOqOSBoVSEminY52lZ1K279M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-lCwAIA9mOQSS8bvQJDC3hQ-1; Wed, 17 May 2023 13:45:38 -0400
X-MC-Unique: lCwAIA9mOQSS8bvQJDC3hQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f419a053c5so1702415e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345537; x=1686937537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B1pz9pdYr7Ol3IJlNK5x42XWKbQZW+4OcYJ5orhyp1E=;
 b=IEy2vUmdpnP7i4bIg7Cn/W5+Gr+jA9PLoBJLChAiYQJrc0IF7P0aiEMmFh47wmNzJB
 OOlduCFl4+tbpgXSKOdzQW2LU/3RlgiV8szUIaWXILtL5iCmIVqQ2zeL44ROSuc64/A6
 KgoYdJKmDJ43hQh3/+/53z0jZWlDYhXxcJYd40vTJXVqWKkSxf5tSfhQlabG9BY7SuDX
 YBjknXYhG1EZXtPPxNkdMF05Lbvok0pqeLGLHPs9Ablx7S+1kHxvQTGOefRL1yG0lGL7
 tGkhf/M9K3yR9XVtb9q4XgUwQyfTonUUOJZ/afKl+dEBeBGrP8i9/a0jUHTH+KWad8X2
 1u3g==
X-Gm-Message-State: AC+VfDwr5QwKKKI7b0wiFg+0mUuVKKM3LS87QW+31TkJ90PVNIcSwvgL
 MkIMjQz0Rr6BOabxe+3KyYs3bGMV1tkT36ejscS5F539qJXo2DAj/+vyt7bbNel5KUQxh0oONXv
 xFm8SxrekhVj6QHuOmjqacWV+RbhDH/Hn5DtPhLU4oRIhkhm4I/gXd2kE3SS21krytx5GLBFDVa
 8=
X-Received: by 2002:a1c:cc12:0:b0:3f5:e29:bcde with SMTP id
 h18-20020a1ccc12000000b003f50e29bcdemr2187519wmb.17.1684345536843; 
 Wed, 17 May 2023 10:45:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4xxfQvWStseqcwO5EIP6FJshv5wC/azrrHcS1voG3xNuGoxsIZ0Ec2ptsTuY3olXLMYDT0Gw==
X-Received: by 2002:a1c:cc12:0:b0:3f5:e29:bcde with SMTP id
 h18-20020a1ccc12000000b003f50e29bcdemr2187507wmb.17.1684345536432; 
 Wed, 17 May 2023 10:45:36 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a1c7210000000b003f19b3d89e9sm2802768wmc.33.2023.05.17.10.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ricky Zhou <ricky@rzhou.org>
Subject: [PULL 08/68] target/i386: Fix exception classes for MOVNTPS/MOVNTPD.
Date: Wed, 17 May 2023 19:44:20 +0200
Message-Id: <20230517174520.887405-9-pbonzini@redhat.com>
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

Before this change, MOVNTPS and MOVNTPD were labeled as Exception Class
4 (only requiring alignment for legacy SSE instructions). This changes
them to Exception Class 1 (always requiring memory alignment), as
documented in the Intel manual.
Message-Id: <20230501111428.95998-3-ricky@rzhou.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 1a789201f740..46afd9960bb1 100644
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
2.40.1


