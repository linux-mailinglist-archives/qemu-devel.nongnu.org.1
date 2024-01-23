Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC3E838D37
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:17:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSEmI-0001h9-Va; Tue, 23 Jan 2024 06:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSEm6-0001Xf-PL
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:17:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSEm3-0005O6-Po
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706008618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eMxv1caCp1E7sXnWcVde/bfphttusJifv9hCMLjq+k8=;
 b=XE1gaoK4HQ8/xzhnzSlAWJgseJRUM7V5WRdwUfQHrekz6FtXYumVq5wD8jJQ3fbVoJNftl
 cUWucc73+DCxTcaZj1o1/DKYKEmdolxgL7oY8Y4IlOtWUhj53c96oqcbOzEGJ5lCl4B9o3
 kDRyDk/pTqY6nuCzkxr3vf0Nqxy46C4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-8drZ2QkLOcWkxOrNLP1rPQ-1; Tue, 23 Jan 2024 06:16:57 -0500
X-MC-Unique: 8drZ2QkLOcWkxOrNLP1rPQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e478693bcso23408115e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 03:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706008615; x=1706613415;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eMxv1caCp1E7sXnWcVde/bfphttusJifv9hCMLjq+k8=;
 b=ELrFRvy3JOqATWpEyFIaGIKdi+3DK+DmGw1wJez4h5HBwhgexpnwog6x5FbzHzrbO6
 Ov+G1rsERG3pXV7zkBLoOsj8u1f4R2mc6lsbptC8TdRSiYCHzoqQ10MnNVrHQRXRRY2E
 lBs79ziQjpqyx72BvVckcpRQCvukzCXyui1Dxk8hKlfn7kjUeIaffx7TQs483lS3OI21
 LuAnncI2GTLuBZa9X3nV0WxU6VqfvGFGmGRrJ5PhGCOeAyRg90P2Mu3Utevp+BBuI9iH
 P8/9gg/k9xfP8RtYoE8EAK1vIjR9+n9sAj5SPfCiDZpivOhswfxJhFjZt1sUkVt3xmc8
 rmeQ==
X-Gm-Message-State: AOJu0Ywerd0pQ54aAONx0lJeRN8EYKFavR9eyfNfDlIQgyFbLQ4d9EIn
 Mw9tQALh0UU2RaVMt2lAiHKJRcbo3W6wU9dUGJ68HbhcPX7f9G2Kl2rH4+DIN/DOThV1fpSG4fm
 gV0Nr3PJeDN9fm+oGOQQU+1krpFrudRECZdR08iJ/FGprfTK6lSR+l3doVL39T/1Pq+nfQErJTe
 S1WULZKDidjj2Sgr9AIOMg+rGkZTpAuPEndhQ+
X-Received: by 2002:a05:600c:a45:b0:40e:4b48:afed with SMTP id
 c5-20020a05600c0a4500b0040e4b48afedmr18763wmq.128.1706008615227; 
 Tue, 23 Jan 2024 03:16:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/OkpVoC4G38bNqyFEGCMFJqNh0QFI6oZjNJps8jnOEsaepaguMjMXZU2IVj9Pcj0kCj0dBg==
X-Received: by 2002:a05:600c:a45:b0:40e:4b48:afed with SMTP id
 c5-20020a05600c0a4500b0040e4b48afedmr18749wmq.128.1706008614687; 
 Tue, 23 Jan 2024 03:16:54 -0800 (PST)
Received: from [192.168.122.1] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a05600c348100b0040ebff736d1sm964614wmq.14.2024.01.23.03.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 03:16:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 7.2] accel/tcg: Revert mapping of PCREL translation block to
 multiple virtual addresses
Date: Tue, 23 Jan 2024 12:16:52 +0100
Message-ID: <20240123111653.423783-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This is causing regressions that have not been analyzed yet.  Revert the
change on stable branches.

Cc: qemu-stable@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Related: https://gitlab.com/qemu-project/qemu/-/issues/2092
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/exec-all.h   | 6 ------
 accel/tcg/cpu-exec.c      | 4 ++--
 accel/tcg/tb-maint.c      | 6 +++---
 accel/tcg/translate-all.c | 2 --
 4 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 9b7bfbf09ac..db677c856b0 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -503,7 +503,6 @@ struct tb_tc {
 };
 
 struct TranslationBlock {
-#if !TARGET_TB_PCREL
     /*
      * Guest PC corresponding to this block.  This must be the true
      * virtual address.  Therefore e.g. x86 stores EIP + CS_BASE, and
@@ -518,7 +517,6 @@ struct TranslationBlock {
      * deposited into the "current" PC.
      */
     target_ulong pc;
-#endif
 
     /*
      * Target-specific data associated with the TranslationBlock, e.g.:
@@ -604,11 +602,7 @@ struct TranslationBlock {
 /* Hide the read to avoid ifdefs for TARGET_TB_PCREL. */
 static inline target_ulong tb_pc(const TranslationBlock *tb)
 {
-#if TARGET_TB_PCREL
-    qemu_build_not_reached();
-#else
     return tb->pc;
-#endif
 }
 
 /* Hide the qatomic_read to make code a little easier on the eyes */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 356fe348de1..68fef3e01f5 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -186,7 +186,7 @@ static bool tb_lookup_cmp(const void *p, const void *d)
     const TranslationBlock *tb = p;
     const struct tb_desc *desc = d;
 
-    if ((TARGET_TB_PCREL || tb_pc(tb) == desc->pc) &&
+    if (tb_pc(tb) == desc->pc &&
         tb_page_addr0(tb) == desc->page_addr0 &&
         tb->cs_base == desc->cs_base &&
         tb->flags == desc->flags &&
@@ -238,7 +238,7 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
         return NULL;
     }
     desc.page_addr0 = phys_pc;
-    h = tb_hash_func(phys_pc, (TARGET_TB_PCREL ? 0 : pc),
+    h = tb_hash_func(phys_pc, pc,
                      flags, cflags, *cpu->trace_dstate);
     return qht_lookup_custom(&tb_ctx.htable, &desc, h, tb_lookup_cmp);
 }
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 0cdb35548c1..9d9f651c78e 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -34,7 +34,7 @@ static bool tb_cmp(const void *ap, const void *bp)
     const TranslationBlock *a = ap;
     const TranslationBlock *b = bp;
 
-    return ((TARGET_TB_PCREL || tb_pc(a) == tb_pc(b)) &&
+    return (tb_pc(a) == tb_pc(b) &&
             a->cs_base == b->cs_base &&
             a->flags == b->flags &&
             (tb_cflags(a) & ~CF_INVALID) == (tb_cflags(b) & ~CF_INVALID) &&
@@ -269,7 +269,7 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
 
     /* remove the TB from the hash list */
     phys_pc = tb_page_addr0(tb);
-    h = tb_hash_func(phys_pc, (TARGET_TB_PCREL ? 0 : tb_pc(tb)),
+    h = tb_hash_func(phys_pc, tb_pc(tb),
                      tb->flags, orig_cflags, tb->trace_vcpu_dstate);
     if (!qht_remove(&tb_ctx.htable, tb, h)) {
         return;
@@ -459,7 +459,7 @@ TranslationBlock *tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
     }
 
     /* add in the hash table */
-    h = tb_hash_func(phys_pc, (TARGET_TB_PCREL ? 0 : tb_pc(tb)),
+    h = tb_hash_func(phys_pc, tb_pc(tb),
                      tb->flags, tb->cflags, tb->trace_vcpu_dstate);
     qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ac3ee3740cb..ed8ddee6e88 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -818,9 +818,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
     gen_code_buf = tcg_ctx->code_gen_ptr;
     tb->tc.ptr = tcg_splitwx_to_rx(gen_code_buf);
-#if !TARGET_TB_PCREL
     tb->pc = pc;
-#endif
     tb->cs_base = cs_base;
     tb->flags = flags;
     tb->cflags = cflags;
-- 
2.43.0


