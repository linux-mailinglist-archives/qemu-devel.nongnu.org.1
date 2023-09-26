Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFA87AF17C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:01:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBQ7-0002DW-9Q; Tue, 26 Sep 2023 13:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPa-00025q-Cd
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPY-0006gl-LR
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/8G1UARPBIuebuj2iJPfjECiURXvIUFTSA9eEeTeKE=;
 b=Se/O6ZOnvziygQJ5/uAAGGL4FtTVki2xaj5eeRxKKSyN4pLxcexiRjf4sT96gHxvS3LvKg
 Yf7H05OzIg57lLjrvycCqAA6GpV/4jYfLifD4d5fY7e/yQmULRp2ZKR8lA7M9Xc/KKP4M6
 5c9LWTeLrUaNpVypTB1gj4GmAFePeqs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-hKCqU3a2Pi6PtpfcBl_GQw-1; Tue, 26 Sep 2023 12:59:46 -0400
X-MC-Unique: hKCqU3a2Pi6PtpfcBl_GQw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40592bb4d11so43657495e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747585; x=1696352385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A/8G1UARPBIuebuj2iJPfjECiURXvIUFTSA9eEeTeKE=;
 b=v/nVN1ASaaifTssUD4LrDC5a8lcfJPeBuxQsyEjpNhQMlplIKlHRWtzLZyasc2YrMX
 f5dTcMLBZCb2/EKMYKSuBNRu8btq3AhIWNaxKZUEoEPrzkTm7ITQOGHyd5Ye/utsHcxN
 yVn117PGuAv1NKweqSOo6f9JYbAJXLwL5+S88ocVNrnDTby8JId72RG0oiSjxw8xFzeR
 wIWS/NKOdyPXzIdPhJgJ00Dd8lpcCh4lEy7aaXxz78KKyaXazYZv44pDVGGsqF/Cl1r1
 JzkU4/Ih4Qgz0sWNiWhuvvxihyhz5zFccC0TiO3l92FO0J45yhQuvXf9i7Em+nhOAOk3
 VPaw==
X-Gm-Message-State: AOJu0YyM94184/KklnVFRnVlxWytER0QppTC8Xp883SRHXy8vYnWvIQO
 QmXUNt3fO0vuo7qG51h2cVKuW9GoyQsURpQD7d2ourmiOPx8toGhBEavb1GkUaxa/H+zd9RI/LH
 z7LyI6AwcIONLJP6zDOZRxIck4JorWuK5o4aomDUBx9sQnswsJc17i1kKuc6DmojNHDRzun6JDL
 o=
X-Received: by 2002:a05:600c:141:b0:400:ce4f:f184 with SMTP id
 w1-20020a05600c014100b00400ce4ff184mr9189065wmm.41.1695747585133; 
 Tue, 26 Sep 2023 09:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJe5f3Zt5BwGD/JspfN3RvgrtxoJRV39ZsCxwiEvuXgXx4oMTQHoRE1cWyI9A2VMEAq6BXNA==
X-Received: by 2002:a05:600c:141:b0:400:ce4f:f184 with SMTP id
 w1-20020a05600c014100b00400ce4ff184mr9189052wmm.41.1695747584794; 
 Tue, 26 Sep 2023 09:59:44 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 3-20020a05600c234300b004013797efb6sm18762968wmq.9.2023.09.26.09.59.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/19] target/i386/seg_helper: remove shadowed variable
Date: Tue, 26 Sep 2023 18:59:11 +0200
Message-ID: <20230926165915.738719-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
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


