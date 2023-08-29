Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD7B78CFE6
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:07:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nI-0000vf-4E; Tue, 29 Aug 2023 19:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nH-0002Nh-Os
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:41 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nE-00048X-UQ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:39 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34dea77cbe6so4264715ab.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346556; x=1693951356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xFPEtg96l7SmhuQ+kSd7xl3J9r3mzIhq+0WeXI+CaA=;
 b=DPFPaNc8i5fatVmwo7CpfxKA+RPXO1XKIbQh25WgUFUoPXhK4r4qiuh8ze+JePLBBI
 vvIuy+ZjxW6uW+Ki4rYGx+CW+FHhGw3n1uny+oXHQ79tkRK3GGImy8Nkf6hiPWlOUU6g
 dfJa/QKNS+52ZAkYjHrSbb7Px7uyPqqbhRBAx+wkMAZGHz2cuiDWeYs9iwYG2b4mpJpZ
 u+sQEMOdx/nlUJ+xz9KpTlUUfPvsLP9AWFwl1ZkVSI/5OhJ4KBtMj8nRRT4WLK1RJzAR
 W5TXRPgm9AvZzswQT8sJD6F+8mlIjjOeVKc13ef4VX852vwxhl/q6XAxPZSkzgysScGx
 2Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346556; x=1693951356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7xFPEtg96l7SmhuQ+kSd7xl3J9r3mzIhq+0WeXI+CaA=;
 b=ZVLxhPdKFL4gN0SE3lh1w5Kn4FSpO6bQHQ6r+e0QdW4cazNyambiBm1ROfCUM8QwC0
 BHbZe7/oxQwrEtrx+4Py2SPU0HtKor1lpsBcUaeX8naeO7mHwDs0v3id0GsXS268oh3z
 98W6enYWMcxFwPFV9OTtT52eCRCFbF9Fc1xrZrXje2XXPh0oXu6cmJRFhNPLcLctOLD2
 9OD7r73TqTfSFBJ0GONjVjnJ63dG7sTmvh1HKFgIWFWG1tMqW7c4Jgk0hg+/2PPXcmv3
 VwxNnWO2Woja5GdHvOTGgpD9Kf7K1Md4kOOY/Zfp8NOd8Kc1NQ3ATSgf1sFh87cwUNzi
 bZTw==
X-Gm-Message-State: AOJu0Ywmk4HbWLYBT8ayBr1qTa64/RQSIKNHhMcAk5vCsdVJ+br2wHs/
 Yc+yHwsoQxqTRBiHHfqqYK9EGjKcW+S00QW7Pq4=
X-Google-Smtp-Source: AGHT+IEJAUkvmVTXMeZ3D+d0ePlNiUa7670mvrt7epxbUCSdYXOkaV63BmOwkOmyOpCvXESVx7QSHA==
X-Received: by 2002:a05:6e02:1a6c:b0:345:af1c:29c4 with SMTP id
 w12-20020a056e021a6c00b00345af1c29c4mr763380ilv.25.1693346555817; 
 Tue, 29 Aug 2023 15:02:35 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 b28-20020a63715c000000b0056606274e54sm9538196pgn.31.2023.08.29.15.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 15:02:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 06/20] linux-user: Use ImageSource in load_symbols
Date: Tue, 29 Aug 2023 15:02:14 -0700
Message-Id: <20230829220228.928506-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829220228.928506-1-richard.henderson@linaro.org>
References: <20230829220228.928506-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12c.google.com
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
index 833c22da25..f34fb64c0c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2049,7 +2049,8 @@ static inline void bswap_mips_abiflags(Mips_elf_abiflags_v0 *abiflags) { }
 #ifdef USE_ELF_CORE_DUMP
 static int elf_core_dump(int, const CPUArchState *);
 #endif /* USE_ELF_CORE_DUMP */
-static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias);
+static void load_symbols(struct elfhdr *hdr, const ImageSource *src,
+                         abi_ulong load_bias);
 
 /* Verify the portions of EHDR within E_IDENT for the target.
    This can be performed before bswapping the entire header.  */
@@ -3294,7 +3295,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
     }
 
     if (qemu_log_enabled()) {
-        load_symbols(ehdr, src->fd, load_bias);
+        load_symbols(ehdr, src, load_bias);
     }
 
     debuginfo_report_elf(image_name, src->fd, load_bias);
@@ -3385,19 +3386,20 @@ static int symcmp(const void *s0, const void *s1)
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
 
@@ -3415,31 +3417,33 @@ static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
 
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
@@ -3464,10 +3468,12 @@ static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
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
@@ -3476,20 +3482,23 @@ static void load_symbols(struct elfhdr *hdr, int fd, abi_ulong load_bias)
 
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


