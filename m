Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E21F27DC1C6
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:21:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZeR-0001My-KW; Mon, 30 Oct 2023 17:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdj-0000z3-Mf
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:43 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdf-0006U8-Hu
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:39 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc3388621cso15939795ad.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700654; x=1699305454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kHG9dpDbo2QunqRCqU6AhR+zRVLjJJWJlLUD5rS4Pk=;
 b=zeRhZnKV4nCNE2MbksCCyh/aRl7RSeCZEKzZK0ON0O3ILEqiIhIDF/mRIDfmIBpJHk
 NdNP1h85RFA67IcYxGQOEYO7Oe2CfhnFstnnPJKCTlq8Oz3vvhijN06Ou9G2Hbv5Va6c
 MM04RM0M/3vbJaNV+y4BlqURsAUQAd2nHzAeNHXD1FfFJ9r9ZZE9lK3q/jPYKnbN9ywB
 eMEpQ54V1tRY4UVI/JLC7MIrWCrTi+W4LUgNL5E66K6jkiWKLWT8khyldwAOiY87l04n
 xcBRdc3lV4R8NRnO0GxSu4N30BQu8t+N37TRCvoF/vJHPsYRvXL3l/7BvYJWKlrvg/j4
 jXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700654; x=1699305454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7kHG9dpDbo2QunqRCqU6AhR+zRVLjJJWJlLUD5rS4Pk=;
 b=tFzyAa0VBzmSWIPhJFSiERHxh2/9HDBc4K+TqBc2DGKP53WEZHIYGGdqOXF/ElMGYk
 RXARROlBDByzICX3uIak7iQ1uSy/ssB4N4cJLiY0D0LFqLmZ1p4oFioonLNM/2KLkQLg
 hFmjJ3jorxbrly6kqREGX3n3DBOlqkjv6vldNTk7lNhrOXdpfUcHEoY5olJCIPR8+3qS
 RtzYXyy4mV0BcIPuGkCSRVLT7IxW8k7LhbEbFqLBzPu83ctAcpyOUfml3+y+Sq9aWbxU
 Z3MIFtQ68VQAT5f2fUggu9RounNbKJQ2M8rAX6+XRqeiYG0elamrVHOyQfL9SN2PNUt7
 fqEw==
X-Gm-Message-State: AOJu0Yx0M/Jwx23eFuyVlPmLyAM58eehx0b9rNJcDWchh90hdrOi4si/
 /npV50U4D20/QgxFzBTK6F8E9iOggX+arUd5axY=
X-Google-Smtp-Source: AGHT+IFkYUzPbQQ26RQ6xz/N7AcwccYTLTeor4TqyyTeObxYsqqTM0hA+ABpV9xns1DcAQrXGjc5/w==
X-Received: by 2002:a17:902:e74a:b0:1bc:1e17:6d70 with SMTP id
 p10-20020a170902e74a00b001bc1e176d70mr931741plf.24.1698700654172; 
 Mon, 30 Oct 2023 14:17:34 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/21] linux-user: Use ImageSource in load_symbols
Date: Mon, 30 Oct 2023 14:17:12 -0700
Message-Id: <20231030211727.165090-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 87 ++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d763cb855a..88c2b01402 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2201,7 +2201,8 @@ static inline void bswap_mips_abiflags(Mips_elf_abiflags_v0 *abiflags) { }
 #ifdef USE_ELF_CORE_DUMP
 static int elf_core_dump(int, const CPUArchState *);
 #endif /* USE_ELF_CORE_DUMP */
-static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias);
+static void load_symbols(struct elfhdr *hdr, const ImageSource *src,
+                         abi_ulong load_bias);
 
 /* Verify the portions of EHDR within E_IDENT for the target.
    This can be performed before bswapping the entire header.  */
@@ -3473,7 +3474,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
     }
 
     if (qemu_log_enabled()) {
-        load_symbols(ehdr, src->fd, load_bias);
+        load_symbols(ehdr, src, load_bias);
     }
 
     debuginfo_report_elf(image_name, src->fd, load_bias);
@@ -3564,19 +3565,20 @@ static int symcmp(const void *s0, const void *s1)
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
 
@@ -3594,31 +3596,33 @@ static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
 
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
@@ -3643,10 +3647,12 @@ static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
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
@@ -3655,20 +3661,23 @@ static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
 
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


