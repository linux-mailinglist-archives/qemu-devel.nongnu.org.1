Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64404838D83
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:34:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSF2D-0008RZ-Rv; Tue, 23 Jan 2024 06:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSF2A-0008RB-EG
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:33:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSF28-000899-RH
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706009616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pFTbjmGJ9y6Siy5C7p3AP0TmLytJqbrRdXMBSmF2znU=;
 b=T34FjXkFgch1rSYEeCJSaH5Q7mEZMLivNmCZrP/qKKiH1o00vBRxyA4a9rVg7Z1JvntFxl
 hT/b9NtNcBc4Co3tQ+MEu1rciVLVJ2hx/yTqQ5Ztaa62i0Ek9M4tHbnzx/LXKWSzlUz1aG
 Z/rYeDW/kGfqe/M/H12ahZjUx/TQkNg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-TkXATqegNxKRNdRc6je_Fw-1; Tue, 23 Jan 2024 06:33:35 -0500
X-MC-Unique: TkXATqegNxKRNdRc6je_Fw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5596f90d5c8so1994810a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 03:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706009613; x=1706614413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pFTbjmGJ9y6Siy5C7p3AP0TmLytJqbrRdXMBSmF2znU=;
 b=KpKvrHPBOdYzTpEYS7QMVSGVoCr8es2YS3QFN1qvAMZY23Fzp9oHpM0YArtYroNFb+
 xrymFm9RwPGLiNyCPHPg3IB0kYgJt+UXdel5Yg+3hIpKM+i4LXGk/gYBJenB6ggD+Qmq
 MriGukyOCEmIzOEIZleMoeeib2/+38qUFaVUjUn5b+gkHSx1ARVt4ASCE/QIR/j9zlhh
 3Gw55CLz5y3h7SWzG9VDQXj2P+/sr0NBJHhAZCtYFrXk4x29YKxfPr3QniyUnzmxBw/4
 t15tVk2Sv+SDHGj3TOzDTnCBvVZSzcV0QuLllLeAWp5fCQfpumhsKrax+h6PTeC+ngt5
 bz5Q==
X-Gm-Message-State: AOJu0YyVJEzZixK/zD4qnSPdFOeSBOFXvl5W1SGR2ZG0nzpSJcDFf8j/
 zdHfImkqe2Q68PY8dKvSIlzfGcfUa8sWqb3VzRhHGIeEGSlBE3vO+UJLVgyLOky4mrhntve0yRp
 EMnJQNTTS+NnOyVYzTK7ga+UeczHtGjuNjIy6Vye7RqckAsGtCnJy7V7bhcnmlzQZO4zXHgqcn+
 JMnIPxPkP4EUk84fV/FRqKud/XqlPwRwFotsVV
X-Received: by 2002:a05:6402:50d:b0:55c:3072:2167 with SMTP id
 m13-20020a056402050d00b0055c30722167mr731262edv.78.1706009613022; 
 Tue, 23 Jan 2024 03:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF85tlsj5AIHwtw3iJA6RtwHVBBWTqsBdlZWG4v5pMBCOX7DOCQmmO1Tia+oK1hkC+PlPu67g==
X-Received: by 2002:a05:6402:50d:b0:55c:3072:2167 with SMTP id
 m13-20020a056402050d00b0055c30722167mr731254edv.78.1706009612590; 
 Tue, 23 Jan 2024 03:33:32 -0800 (PST)
Received: from [192.168.122.1] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 fd4-20020a056402388400b0055864f99f78sm15213310edb.20.2024.01.23.03.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 03:33:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 8.1] accel/tcg: Revert mapping of PCREL translation block to
 multiple virtual addresses
Date: Tue, 23 Jan 2024 12:33:31 +0100
Message-ID: <20240123113331.432891-1-pbonzini@redhat.com>
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

This is causing regressions that have not been analyzed yet.  Revert the
change on stable branches.

Cc: qemu-stable@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Related: https://gitlab.com/qemu-project/qemu/-/issues/2092
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c      | 4 ++--
 accel/tcg/tb-maint.c      | 6 +++---
 accel/tcg/translate-all.c | 4 +---
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c724e8b6f10..d10c8eb9560 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -182,7 +182,7 @@ static bool tb_lookup_cmp(const void *p, const void *d)
     const TranslationBlock *tb = p;
     const struct tb_desc *desc = d;
 
-    if ((tb_cflags(tb) & CF_PCREL || tb->pc == desc->pc) &&
+    if (tb->pc == desc->pc &&
         tb_page_addr0(tb) == desc->page_addr0 &&
         tb->cs_base == desc->cs_base &&
         tb->flags == desc->flags &&
@@ -232,7 +232,7 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, vaddr pc,
         return NULL;
     }
     desc.page_addr0 = phys_pc;
-    h = tb_hash_func(phys_pc, (cflags & CF_PCREL ? 0 : pc),
+    h = tb_hash_func(phys_pc, pc,
                      flags, cs_base, cflags);
     return qht_lookup_custom(&tb_ctx.htable, &desc, h, tb_lookup_cmp);
 }
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 85684f2b3d8..5c7a76bf885 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -46,7 +46,7 @@ static bool tb_cmp(const void *ap, const void *bp)
     const TranslationBlock *a = ap;
     const TranslationBlock *b = bp;
 
-    return ((tb_cflags(a) & CF_PCREL || a->pc == b->pc) &&
+    return (a->pc == b->pc &&
             a->cs_base == b->cs_base &&
             a->flags == b->flags &&
             (tb_cflags(a) & ~CF_INVALID) == (tb_cflags(b) & ~CF_INVALID) &&
@@ -916,7 +916,7 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
 
     /* remove the TB from the hash list */
     phys_pc = tb_page_addr0(tb);
-    h = tb_hash_func(phys_pc, (orig_cflags & CF_PCREL ? 0 : tb->pc),
+    h = tb_hash_func(phys_pc, tb->pc,
                      tb->flags, tb->cs_base, orig_cflags);
     if (!qht_remove(&tb_ctx.htable, tb, h)) {
         return;
@@ -983,7 +983,7 @@ TranslationBlock *tb_link_page(TranslationBlock *tb)
     tb_record(tb);
 
     /* add in the hash table */
-    h = tb_hash_func(tb_page_addr0(tb), (tb->cflags & CF_PCREL ? 0 : tb->pc),
+    h = tb_hash_func(tb_page_addr0(tb), tb->pc,
                      tb->flags, tb->cs_base, tb->cflags);
     qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index b2d4e22c17d..678ddeff371 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -326,9 +326,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
     gen_code_buf = tcg_ctx->code_gen_ptr;
     tb->tc.ptr = tcg_splitwx_to_rx(gen_code_buf);
-    if (!(cflags & CF_PCREL)) {
-        tb->pc = pc;
-    }
+    tb->pc = pc;
     tb->cs_base = cs_base;
     tb->flags = flags;
     tb->cflags = cflags;
-- 
2.43.0


