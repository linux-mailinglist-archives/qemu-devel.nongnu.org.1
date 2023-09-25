Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5A57ADA9F
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:52:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmuM-0002VO-UV; Mon, 25 Sep 2023 10:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmu0-0001xT-Lu
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmtt-0008Tf-5Z
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695653368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A/8G1UARPBIuebuj2iJPfjECiURXvIUFTSA9eEeTeKE=;
 b=DJMPvFusXC5iF2GrpRvEytPPj9UbytTNLRTaNYMPFEM65/LUJA+UY4ouT9zCPttVHFldpT
 DFDoAyRf+kO///mGNn6PZlT2ZStR52Q0AnGbUPqiYTlPmOhPLKYbys8Cy7cwhyTMy4gxSQ
 Rlgj6NWN1z0EPM/s7CNRsrD9oRkyQAw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-21yK4wWYPEWYvvl2TX8YOQ-1; Mon, 25 Sep 2023 10:49:26 -0400
X-MC-Unique: 21yK4wWYPEWYvvl2TX8YOQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3231f43fc5eso2356215f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653364; x=1696258164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A/8G1UARPBIuebuj2iJPfjECiURXvIUFTSA9eEeTeKE=;
 b=mfdSYz7jDOIhwmXik5vo65yOYBsi1kCiyFpOP8ajabw8goizFfDIwnAyBLV4AqEH6j
 W40yL4sWywJMF5Mf5TjFHkhP9E+2U9Gnc1AucK6is2kuF7RHfYzyOa1wGPnM8yf17q95
 OY04gwKZshh+i9+o7QiX24pCVumnXwOt32cVT3CVNhJBL+C/ymKmTzMt/Vq4v7A76vm+
 /BXRrUPKg/g8NkZoQr9mqJpppgwepEfRCFB2egK8/0mLo4RMEyFbNG0gPAd6BfGdYPRG
 J31uF+RPEpMEzpN7Gurz4WprqeRM0g2OtiF8stb390xNsGJRlYvKxNu5b60DQsUt4aIo
 iygQ==
X-Gm-Message-State: AOJu0YxquSULzoMkyUPvddW2/NF/dNwqcxd7ywjGCGvw04rKlQBQNR/Z
 uiU0sl4RRJv9eJ37eBraYm4uTuqjGStQ3wAjaTEaMvlQSJWEMXkZPQdYyShsTEJy+581fvJApXo
 CrXctLH+GM3wITYEKre2wnDwz1UONiaxZAuEAfyTW7Zi8rIpiJ3oiaK4J5AQfTcTupXkcBxnEd3
 M=
X-Received: by 2002:adf:f548:0:b0:313:dee2:e052 with SMTP id
 j8-20020adff548000000b00313dee2e052mr6002218wrp.26.1695653364583; 
 Mon, 25 Sep 2023 07:49:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO4innvccU8G7VFf1sX8WWa8eeyKeNGMcpDfEDXSo3kdS9be7fuuDTFeRqmgS/tRW3XmuDaw==
X-Received: by 2002:adf:f548:0:b0:313:dee2:e052 with SMTP id
 j8-20020adff548000000b00313dee2e052mr6002198wrp.26.1695653364122; 
 Mon, 25 Sep 2023 07:49:24 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 ay18-20020a5d6f12000000b003143cb109d5sm2930498wrb.14.2023.09.25.07.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:49:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH] target/i386/seg_helper: remove shadowed variable
Date: Mon, 25 Sep 2023 16:49:22 +0200
Message-ID: <20230925144922.529963-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Return the width of the new task directly from switch_tss_ra.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index b5198db82bc..2b92aee2073 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -245,10 +245,10 @@ static void tss_set_busy(CPUX86State *env, int tss_selector, bool value,
 #define SWITCH_TSS_IRET 1
 #define SWITCH_TSS_CALL 2
 
-/* XXX: restore CPU state in registers (PowerPC case) */
-static void switch_tss_ra(CPUX86State *env, int tss_selector,
-                          uint32_t e1, uint32_t e2, int source,
-                          uint32_t next_eip, uintptr_t retaddr)
+/* return 0 if switching to a 16-bit selector */
+static int switch_tss_ra(CPUX86State *env, int tss_selector,
+                         uint32_t e1, uint32_t e2, int source,
+                         uint32_t next_eip, uintptr_t retaddr)
 {
     int tss_limit, tss_limit_max, type, old_tss_limit_max, old_type, v1, v2, i;
     target_ulong tss_base;
@@ -502,13 +502,14 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
         cpu_x86_update_dr7(env, env->dr[7] & ~DR7_LOCAL_BP_MASK);
     }
 #endif
+    return type >> 3;
 }
 
-static void switch_tss(CPUX86State *env, int tss_selector,
-                       uint32_t e1, uint32_t e2, int source,
-                        uint32_t next_eip)
+static int switch_tss(CPUX86State *env, int tss_selector,
+                      uint32_t e1, uint32_t e2, int source,
+                      uint32_t next_eip)
 {
-    switch_tss_ra(env, tss_selector, e1, e2, source, next_eip, 0);
+    return switch_tss_ra(env, tss_selector, e1, e2, source, next_eip, 0);
 }
 
 static inline unsigned int get_sp_mask(unsigned int e2)
@@ -650,14 +651,11 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
         if (!(e2 & DESC_P_MASK)) {
             raise_exception_err(env, EXCP0B_NOSEG, intno * 8 + 2);
         }
-        switch_tss(env, intno * 8, e1, e2, SWITCH_TSS_CALL, old_eip);
+        shift = switch_tss(env, intno * 8, e1, e2, SWITCH_TSS_CALL, old_eip);
         if (has_error_code) {
-            int type;
             uint32_t mask;
 
             /* push the error code */
-            type = (env->tr.flags >> DESC_TYPE_SHIFT) & 0xf;
-            shift = type >> 3;
             if (env->segs[R_SS].flags & DESC_B_MASK) {
                 mask = 0xffffffff;
             } else {
-- 
2.41.0


