Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EBD779546
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:53:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVLu-0005lA-K1; Fri, 11 Aug 2023 12:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLq-0005jc-2z
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:02 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLn-0001M7-SS
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:01 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-26b1adbd655so803821a91.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691772658; x=1692377458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePVxotW82jMDrWJ+ESk2twixLo2Priek8MjmEOc4z70=;
 b=S/5bRopbca9klFqAItm/gifsMChV/8vThrgzVyOEaRiOqCHzAN0tkEkPghqOb0XKwQ
 wX+G/GPV3mssho23nIN3UYP4cpIddOiJGiJp3UJd1mdZECWwSzXIv87+CebmSSuIs81O
 wn2H10JSvqYmHdJmSbUmFY9qMr137O+JLoG/3C+uSTKt6hTYoQI63cxI9coxufO7Up34
 MQWoN4INO/gRBeq/AARHxUPDyvMzo5+u9+sIF8Nhvm33Vy62VXXXcu5UMhrUsrTiivDv
 A42fr6rHNfJKmsVhD3RjZlWCDwCMS2krSlg6clcu3dSiQ1eZURVfaC9rITH9nZ7wq/Cc
 Zw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691772658; x=1692377458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ePVxotW82jMDrWJ+ESk2twixLo2Priek8MjmEOc4z70=;
 b=DmZYRbPpnQb8M6ltCqszV8zAHICB1edjmDhRn+IoA+uhTOezRQI/F6RQU1Nm/OAJw/
 MAkAdBkkh9w6c41tl537+JY1TJXbX+4z+RL32H1LclmMwJaJxWuJxi+lHns3ANk9xJJq
 YTprzR5xDqxhzSj7sTjEIRMTUbxaGb9HAotsSsb4Uv5Idbgu9SE6mvo/2mdOVem5Z5YD
 yMMzoL2gIP27f3zL8W/HJlLV2IhoYkJRUMLMDtAOPX3i2lwE8AVJbqHYPnJlnB7N/O7A
 YRBFlZkIglCtDjmQyHyDFdgkYfBetpt38V5miISjX5IdPJ6B1upcLFROa0gGa957JB/6
 Rm+g==
X-Gm-Message-State: AOJu0YyA0pTqvVIrLlpuitj2Iq50+HvUV2bSIyhYwvVRaSHoMMpMmCiv
 RVkopj/mFXo2ZtQg/DGCLTdqNNSW2Gmn8DbpoZQ=
X-Google-Smtp-Source: AGHT+IFcoT57+UXJAo6N6aGFRlHcjIGHXq6RiNHyI/PSujS/3gkpvjgFMV5aJy5ojtNVElJPunGZaQ==
X-Received: by 2002:a17:90b:3503:b0:268:105b:ca1c with SMTP id
 ls3-20020a17090b350300b00268105bca1cmr1750761pjb.32.1691772658441; 
 Fri, 11 Aug 2023 09:50:58 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a19d600b00263d3448141sm3803713pjj.8.2023.08.11.09.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:50:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH v3 05/15] linux-user: Use ImageSource in load_symbols
Date: Fri, 11 Aug 2023 09:50:42 -0700
Message-Id: <20230811165052.161080-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811165052.161080-1-richard.henderson@linaro.org>
References: <20230811165052.161080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Aside from the section headers, we're unlikely to hit the
ImageSource cache on guest executables.  But the interface
for imgsrc_read_* is better.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 87 ++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f3511ae766..19d3cac039 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2048,7 +2048,8 @@ static inline void bswap_mips_abiflags(Mips_elf_abiflags_v0 *abiflags) { }
 #ifdef USE_ELF_CORE_DUMP
 static int elf_core_dump(int, const CPUArchState *);
 #endif /* USE_ELF_CORE_DUMP */
-static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias);
+static void load_symbols(struct elfhdr *hdr, const ImageSource *src,
+                         abi_ulong load_bias);
 
 /* Verify the portions of EHDR within E_IDENT for the target.
    This can be performed before bswapping the entire header.  */
@@ -3293,7 +3294,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
     }
 
     if (qemu_log_enabled()) {
-        load_symbols(ehdr, src->fd, load_bias);
+        load_symbols(ehdr, src, load_bias);
     }
 
     debuginfo_report_elf(image_name, src->fd, load_bias);
@@ -3384,19 +3385,20 @@ static int symcmp(const void *s0, const void *s1)
 }
 
 /* Best attempt to load symbols from this ELF object. */
-static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
+static void load_symbols(struct elfhdr *hdr, const ImageSource *src,
+                         abi_ulong load_bias)
 {
     int i, shnum, nsyms, sym_idx = 0, str_idx = 0;
-    uint64_t segsz;
-    struct elf_shdr *shdr;
+    g_autofree struct elf_shdr *shdr = NULL;
     char *strings = NULL;
-    struct syminfo *s = NULL;
-    struct elf_sym *new_syms, *syms = NULL;
+    struct elf_sym *syms = NULL;
+    struct elf_sym *new_syms;
+    uint64_t segsz;
 
     shnum = hdr->e_shnum;
-    i = shnum * sizeof(struct elf_shdr);
-    shdr = (struct elf_shdr *)alloca(i);
-    if (pread(fd, shdr, i, hdr->e_shoff) != i) {
+    shdr = imgsrc_read_alloc(hdr->e_shoff, shnum * sizeof(struct elf_shdr),
+                             src, NULL);
+    if (shdr == NULL) {
         return;
     }
 
@@ -3414,31 +3416,33 @@ static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
 
  found:
     /* Now know where the strtab and symtab are.  Snarf them.  */
-    s = g_try_new(struct syminfo, 1);
-    if (!s) {
-        goto give_up;
-    }
 
     segsz = shdr[str_idx].sh_size;
-    s->disas_strtab = strings = g_try_malloc(segsz);
-    if (!strings ||
-        pread(fd, strings, segsz, shdr[str_idx].sh_offset) != segsz) {
+    strings = g_try_malloc(segsz);
+    if (!strings) {
+        goto give_up;
+    }
+    if (!imgsrc_read(strings, shdr[str_idx].sh_offset, segsz, src, NULL)) {
         goto give_up;
     }
 
     segsz = shdr[sym_idx].sh_size;
-    syms = g_try_malloc(segsz);
-    if (!syms || pread(fd, syms, segsz, shdr[sym_idx].sh_offset) != segsz) {
-        goto give_up;
-    }
-
     if (segsz / sizeof(struct elf_sym) > INT_MAX) {
-        /* Implausibly large symbol table: give up rather than ploughing
-         * on with the number of symbols calculation overflowing
+        /*
+         * Implausibly large symbol table: give up rather than ploughing
+         * on with the number of symbols calculation overflowing.
          */
         goto give_up;
     }
     nsyms = segsz / sizeof(struct elf_sym);
+    syms = g_try_malloc(segsz);
+    if (!syms) {
+        goto give_up;
+    }
+    if (!imgsrc_read(syms, shdr[sym_idx].sh_offset, segsz, src, NULL)) {
+        goto give_up;
+    }
+
     for (i = 0; i < nsyms; ) {
         bswap_sym(syms + i);
         /* Throw away entries which we do not need.  */
@@ -3463,10 +3467,12 @@ static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
         goto give_up;
     }
 
-    /* Attempt to free the storage associated with the local symbols
-       that we threw away.  Whether or not this has any effect on the
-       memory allocation depends on the malloc implementation and how
-       many symbols we managed to discard.  */
+    /*
+     * Attempt to free the storage associated with the local symbols
+     * that we threw away.  Whether or not this has any effect on the
+     * memory allocation depends on the malloc implementation and how
+     * many symbols we managed to discard.
+     */
     new_syms = g_try_renew(struct elf_sym, syms, nsyms);
     if (new_syms == NULL) {
         goto give_up;
@@ -3475,20 +3481,23 @@ static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
 
     qsort(syms, nsyms, sizeof(*syms), symcmp);
 
-    s->disas_num_syms = nsyms;
-#if ELF_CLASS == ELFCLASS32
-    s->disas_symtab.elf32 = syms;
-#else
-    s->disas_symtab.elf64 = syms;
-#endif
-    s->lookup_symbol = lookup_symbolxx;
-    s->next = syminfos;
-    syminfos = s;
+    {
+        struct syminfo *s = g_new(struct syminfo, 1);
 
+        s->disas_strtab = strings;
+        s->disas_num_syms = nsyms;
+#if ELF_CLASS == ELFCLASS32
+        s->disas_symtab.elf32 = syms;
+#else
+        s->disas_symtab.elf64 = syms;
+#endif
+        s->lookup_symbol = lookup_symbolxx;
+        s->next = syminfos;
+        syminfos = s;
+    }
     return;
 
-give_up:
-    g_free(s);
+ give_up:
     g_free(strings);
     g_free(syms);
 }
-- 
2.34.1


