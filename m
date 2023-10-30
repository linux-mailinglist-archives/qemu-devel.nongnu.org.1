Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F467DC1BE
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:19:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZeU-0001Xo-OE; Mon, 30 Oct 2023 17:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdp-000102-Oi
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:51 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdj-0006Uf-Ea
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:42 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5ab94fc098cso3157490a12.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700657; x=1699305457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUbTkt+bHKCfFZB4ZVLzwdrSKYldCzNwa+BNdD8suqc=;
 b=SddCGK5docu2PHXJXMuFcKlafnQxywt3i0VKE7uYHHQ5QHpVqExSlBInFmhUk7SiDL
 rfN/C2ezeTdHL5csntPGbAWN0E3DeQBNCQrPxO4Dh9b5UD9g20x1Z3LK8f/HXCaZobRN
 oA8kQkkL6LURHwrhWPGwMMg8N7gPkA1k+Bkq4ksKwYzbqMdVtTv9F2gWZeyb5RzHdDxf
 WXAbTi8ST6SjdLZB0vF6PNRPJUyPK1c2FpEYx6veV+7aBtdl0VacyrtjqcAQY28UqJ8U
 s7Om+znRrUYHACJ7FC+V429r8OOOPT+JEBy2mqV3bT2WGDsNowq6HBGtj/A6gHGsDEwE
 BTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700657; x=1699305457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUbTkt+bHKCfFZB4ZVLzwdrSKYldCzNwa+BNdD8suqc=;
 b=KLj1soD8B6TED7HG3hw7z8Bqc9/Kx4BayuQKDXbyZA5uh+LPrvvWJYn4AcD+48DJSB
 cvcyy64zOs4sF9LkWyXvsffr5z9GjfPiE08J7R92IprxRTj6W4ztu42B3mpneziXTqil
 A9zYKMRz5R4jPR+wA9uggUmgdAK4I7m98tjrXdQoPVM4WbqQhy2oDGfnzIeU0GUZIc0J
 oBALEiozKWfInzp/3g3HStA6isbYoqIikYjTvqcsZ6rE8jBJPG8qvlsYohwTBaSILCSz
 9Z15ivzsECTUPTX0Iypb5zRRPKMexnFPAj1dhk78Bte4L62dcujKWpF9JU9BgjX6HUqo
 LhLQ==
X-Gm-Message-State: AOJu0YwoIxi0FBilVSnXYPZOlgRanNBWc+KhPux2sfvKXjmu2LlhSoWv
 H+bafhDa3yeSfXxLOA98DrgEmdcRYRuXJEoxEgI=
X-Google-Smtp-Source: AGHT+IF0QKrm8odu9BJ4AOapStGue1j5AJyBEKdppbIVDKU/hCK6SenU+0JydLmQF5xFPC6zTzE05A==
X-Received: by 2002:a17:903:68d:b0:1c9:e0f9:a676 with SMTP id
 ki13-20020a170903068d00b001c9e0f9a676mr7164836plb.6.1698700656783; 
 Mon, 30 Oct 2023 14:17:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/21] linux-user: Add gen-vdso tool
Date: Mon, 30 Oct 2023 14:17:15 -0700
Message-Id: <20231030211727.165090-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

This tool will be used for post-processing the linked vdso image,
turning it into something that is easy to include into elfload.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/gen-vdso.c          | 223 ++++++++++++++++++++++++
 linux-user/gen-vdso-elfn.c.inc | 307 +++++++++++++++++++++++++++++++++
 linux-user/meson.build         |   6 +-
 3 files changed, 535 insertions(+), 1 deletion(-)
 create mode 100644 linux-user/gen-vdso.c
 create mode 100644 linux-user/gen-vdso-elfn.c.inc

diff --git a/linux-user/gen-vdso.c b/linux-user/gen-vdso.c
new file mode 100644
index 0000000000..31e333be80
--- /dev/null
+++ b/linux-user/gen-vdso.c
@@ -0,0 +1,223 @@
+/*
+ * Post-process a vdso elf image for inclusion into qemu.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdlib.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <endian.h>
+#include <unistd.h>
+#include "elf.h"
+
+
+#define bswap_(p)  _Generic(*(p), \
+                            uint16_t: __builtin_bswap16,       \
+                            uint32_t: __builtin_bswap32,       \
+                            uint64_t: __builtin_bswap64,       \
+                            int16_t: __builtin_bswap16,        \
+                            int32_t: __builtin_bswap32,        \
+                            int64_t: __builtin_bswap64)
+#define bswaps(p) (*(p) = bswap_(p)(*(p)))
+
+static void output_reloc(FILE *outf, void *buf, void *loc)
+{
+    fprintf(outf, "    0x%08tx,\n", loc - buf);
+}
+
+static const char *sigreturn_sym;
+static const char *rt_sigreturn_sym;
+
+static unsigned sigreturn_addr;
+static unsigned rt_sigreturn_addr;
+
+#define N 32
+#define elfN(x)  elf32_##x
+#define ElfN(x)  Elf32_##x
+#include "gen-vdso-elfn.c.inc"
+#undef N
+#undef elfN
+#undef ElfN
+
+#define N 64
+#define elfN(x)  elf64_##x
+#define ElfN(x)  Elf64_##x
+#include "gen-vdso-elfn.c.inc"
+#undef N
+#undef elfN
+#undef ElfN
+
+
+int main(int argc, char **argv)
+{
+    FILE *inf, *outf;
+    long total_len;
+    const char *prefix = "vdso";
+    const char *inf_name;
+    const char *outf_name = NULL;
+    unsigned char *buf;
+    bool need_bswap;
+
+    while (1) {
+        int opt = getopt(argc, argv, "o:p:r:s:");
+        if (opt < 0) {
+            break;
+        }
+        switch (opt) {
+        case 'o':
+            outf_name = optarg;
+            break;
+        case 'p':
+            prefix = optarg;
+            break;
+        case 'r':
+            rt_sigreturn_sym = optarg;
+            break;
+        case 's':
+            sigreturn_sym = optarg;
+            break;
+        default:
+        usage:
+            fprintf(stderr, "usage: [-p prefix] [-r rt-sigreturn-name] "
+                    "[-s sigreturn-name] -o output-file input-file\n");
+            return EXIT_FAILURE;
+        }
+    }
+
+    if (optind >= argc || outf_name == NULL) {
+        goto usage;
+    }
+    inf_name = argv[optind];
+
+    /*
+     * Open the input and output files.
+     */
+    inf = fopen(inf_name, "rb");
+    if (inf == NULL) {
+        goto perror_inf;
+    }
+    outf = fopen(outf_name, "w");
+    if (outf == NULL) {
+        goto perror_outf;
+    }
+
+    /*
+     * Read the input file into a buffer.
+     * We expect the vdso to be small, on the order of one page,
+     * therefore we do not expect a partial read.
+     */
+    fseek(inf, 0, SEEK_END);
+    total_len = ftell(inf);
+    fseek(inf, 0, SEEK_SET);
+
+    buf = malloc(total_len);
+    if (buf == NULL) {
+        goto perror_inf;
+    }
+
+    errno = 0;
+    if (fread(buf, 1, total_len, inf) != total_len) {
+        if (errno) {
+            goto perror_inf;
+        }
+        fprintf(stderr, "%s: incomplete read\n", inf_name);
+        return EXIT_FAILURE;
+    }
+    fclose(inf);
+
+    /*
+     * Write out the vdso image now, before we make local changes.
+     */
+
+    fprintf(outf,
+            "/* Automatically generated from linux-user/gen-vdso.c. */\n"
+            "\n"
+            "static const uint8_t %s_image[] = {",
+            prefix);
+    for (long i = 0; i < total_len; ++i) {
+        if (i % 12 == 0) {
+            fputs("\n   ", outf);
+        }
+        fprintf(outf, " 0x%02x,", buf[i]);
+    }
+    fprintf(outf, "\n};\n\n");
+
+    /*
+     * Identify which elf flavor we're processing.
+     * The first 16 bytes of the file are e_ident.
+     */
+
+    if (buf[EI_MAG0] != ELFMAG0 || buf[EI_MAG1] != ELFMAG1 ||
+        buf[EI_MAG2] != ELFMAG2 || buf[EI_MAG3] != ELFMAG3) {
+        fprintf(stderr, "%s: not an elf file\n", inf_name);
+        return EXIT_FAILURE;
+    }
+    switch (buf[EI_DATA]) {
+    case ELFDATA2LSB:
+        need_bswap = BYTE_ORDER != LITTLE_ENDIAN;
+        break;
+    case ELFDATA2MSB:
+        need_bswap = BYTE_ORDER != BIG_ENDIAN;
+        break;
+    default:
+        fprintf(stderr, "%s: invalid elf EI_DATA (%u)\n",
+                inf_name, buf[EI_DATA]);
+        return EXIT_FAILURE;
+    }
+
+    /*
+     * We need to relocate the VDSO image.  The one built into the kernel
+     * is built for a fixed address.  The one we built for QEMU is not,
+     * since that requires close control of the guest address space.
+     *
+     * Output relocation addresses as we go.
+     */
+
+    fprintf(outf, "static const unsigned %s_relocs[] = {\n", prefix);
+
+    switch (buf[EI_CLASS]) {
+    case ELFCLASS32:
+        elf32_process(outf, buf, need_bswap);
+        break;
+    case ELFCLASS64:
+        elf64_process(outf, buf, need_bswap);
+        break;
+    default:
+        fprintf(stderr, "%s: invalid elf EI_CLASS (%u)\n",
+                inf_name, buf[EI_CLASS]);
+        return EXIT_FAILURE;
+    }
+
+    fprintf(outf, "};\n\n");   /* end vdso_relocs. */
+
+    fprintf(outf, "static const VdsoImageInfo %s_image_info = {\n", prefix);
+    fprintf(outf, "    .image = %s_image,\n", prefix);
+    fprintf(outf, "    .relocs = %s_relocs,\n", prefix);
+    fprintf(outf, "    .image_size = sizeof(%s_image),\n", prefix);
+    fprintf(outf, "    .reloc_count = ARRAY_SIZE(%s_relocs),\n", prefix);
+    fprintf(outf, "    .sigreturn_ofs = 0x%x,\n", sigreturn_addr);
+    fprintf(outf, "    .rt_sigreturn_ofs = 0x%x,\n", rt_sigreturn_addr);
+    fprintf(outf, "};\n");
+
+    /*
+     * Everything should have gone well.
+     */
+    if (fclose(outf)) {
+        goto perror_outf;
+    }
+    return EXIT_SUCCESS;
+
+ perror_inf:
+    perror(inf_name);
+    return EXIT_FAILURE;
+
+ perror_outf:
+    perror(outf_name);
+    return EXIT_FAILURE;
+}
diff --git a/linux-user/gen-vdso-elfn.c.inc b/linux-user/gen-vdso-elfn.c.inc
new file mode 100644
index 0000000000..7034c36d5e
--- /dev/null
+++ b/linux-user/gen-vdso-elfn.c.inc
@@ -0,0 +1,307 @@
+/*
+ * Post-process a vdso elf image for inclusion into qemu.
+ * Elf size specialization.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+static void elfN(bswap_ehdr)(ElfN(Ehdr) *ehdr)
+{
+    bswaps(&ehdr->e_type);            /* Object file type */
+    bswaps(&ehdr->e_machine);         /* Architecture */
+    bswaps(&ehdr->e_version);         /* Object file version */
+    bswaps(&ehdr->e_entry);           /* Entry point virtual address */
+    bswaps(&ehdr->e_phoff);           /* Program header table file offset */
+    bswaps(&ehdr->e_shoff);           /* Section header table file offset */
+    bswaps(&ehdr->e_flags);           /* Processor-specific flags */
+    bswaps(&ehdr->e_ehsize);          /* ELF header size in bytes */
+    bswaps(&ehdr->e_phentsize);       /* Program header table entry size */
+    bswaps(&ehdr->e_phnum);           /* Program header table entry count */
+    bswaps(&ehdr->e_shentsize);       /* Section header table entry size */
+    bswaps(&ehdr->e_shnum);           /* Section header table entry count */
+    bswaps(&ehdr->e_shstrndx);        /* Section header string table index */
+}
+
+static void elfN(bswap_phdr)(ElfN(Phdr) *phdr)
+{
+    bswaps(&phdr->p_type);            /* Segment type */
+    bswaps(&phdr->p_flags);           /* Segment flags */
+    bswaps(&phdr->p_offset);          /* Segment file offset */
+    bswaps(&phdr->p_vaddr);           /* Segment virtual address */
+    bswaps(&phdr->p_paddr);           /* Segment physical address */
+    bswaps(&phdr->p_filesz);          /* Segment size in file */
+    bswaps(&phdr->p_memsz);           /* Segment size in memory */
+    bswaps(&phdr->p_align);           /* Segment alignment */
+}
+
+static void elfN(bswap_shdr)(ElfN(Shdr) *shdr)
+{
+    bswaps(&shdr->sh_name);
+    bswaps(&shdr->sh_type);
+    bswaps(&shdr->sh_flags);
+    bswaps(&shdr->sh_addr);
+    bswaps(&shdr->sh_offset);
+    bswaps(&shdr->sh_size);
+    bswaps(&shdr->sh_link);
+    bswaps(&shdr->sh_info);
+    bswaps(&shdr->sh_addralign);
+    bswaps(&shdr->sh_entsize);
+}
+
+static void elfN(bswap_sym)(ElfN(Sym) *sym)
+{
+    bswaps(&sym->st_name);
+    bswaps(&sym->st_value);
+    bswaps(&sym->st_size);
+    bswaps(&sym->st_shndx);
+}
+
+static void elfN(bswap_dyn)(ElfN(Dyn) *dyn)
+{
+    bswaps(&dyn->d_tag);              /* Dynamic type tag */
+    bswaps(&dyn->d_un.d_ptr);         /* Dynamic ptr or val, in union */
+}
+
+static void elfN(search_symtab)(ElfN(Shdr) *shdr, unsigned sym_idx,
+                                void *buf, bool need_bswap)
+{
+    unsigned str_idx = shdr[sym_idx].sh_link;
+    ElfN(Sym) *sym = buf + shdr[sym_idx].sh_offset;
+    unsigned sym_n = shdr[sym_idx].sh_size / sizeof(*sym);
+    const char *str = buf + shdr[str_idx].sh_offset;
+
+    for (unsigned i = 0; i < sym_n; ++i) {
+        const char *name;
+
+        if (need_bswap) {
+            elfN(bswap_sym)(sym + i);
+        }
+        name = str + sym[i].st_name;
+
+        if (sigreturn_sym && strcmp(sigreturn_sym, name) == 0) {
+            sigreturn_addr = sym[i].st_value;
+        }
+        if (rt_sigreturn_sym && strcmp(rt_sigreturn_sym, name) == 0) {
+            rt_sigreturn_addr = sym[i].st_value;
+        }
+    }
+}
+
+static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
+{
+    ElfN(Ehdr) *ehdr = buf;
+    ElfN(Phdr) *phdr;
+    ElfN(Shdr) *shdr;
+    unsigned phnum, shnum;
+    unsigned dynamic_ofs = 0;
+    unsigned dynamic_addr = 0;
+    unsigned symtab_idx = 0;
+    unsigned dynsym_idx = 0;
+    unsigned first_segsz = 0;
+    int errors = 0;
+
+    if (need_bswap) {
+        elfN(bswap_ehdr)(ehdr);
+    }
+
+    phnum = ehdr->e_phnum;
+    phdr = buf + ehdr->e_phoff;
+    if (need_bswap) {
+        for (unsigned i = 0; i < phnum; ++i) {
+            elfN(bswap_phdr)(phdr + i);
+        }
+    }
+
+    shnum = ehdr->e_shnum;
+    shdr = buf + ehdr->e_shoff;
+    if (need_bswap) {
+        for (unsigned i = 0; i < shnum; ++i) {
+            elfN(bswap_shdr)(shdr + i);
+        }
+    }
+    for (unsigned i = 0; i < shnum; ++i) {
+        switch (shdr[i].sh_type) {
+        case SHT_SYMTAB:
+            symtab_idx = i;
+            break;
+        case SHT_DYNSYM:
+            dynsym_idx = i;
+            break;
+        }
+    }
+
+    /*
+     * Validate the VDSO is created as we expect: that PT_PHDR,
+     * PT_DYNAMIC, and PT_NOTE located in a writable data segment.
+     * PHDR and DYNAMIC require relocation, and NOTE will get the
+     * linux version number.
+     */
+    for (unsigned i = 0; i < phnum; ++i) {
+        if (phdr[i].p_type != PT_LOAD) {
+            continue;
+        }
+        if (first_segsz != 0) {
+            fprintf(stderr, "Multiple LOAD segments\n");
+            errors++;
+        }
+        if (phdr[i].p_offset != 0) {
+            fprintf(stderr, "LOAD segment does not cover EHDR\n");
+            errors++;
+        }
+        if (phdr[i].p_vaddr != 0) {
+            fprintf(stderr, "LOAD segment not loaded at address 0\n");
+            errors++;
+        }
+        first_segsz = phdr[i].p_filesz;
+        if (first_segsz < ehdr->e_phoff + phnum * sizeof(*phdr)) {
+            fprintf(stderr, "LOAD segment does not cover PHDRs\n");
+            errors++;
+        }
+        if ((phdr[i].p_flags & (PF_R | PF_W)) != (PF_R | PF_W)) {
+            fprintf(stderr, "LOAD segment is not read-write\n");
+            errors++;
+        }
+    }
+    for (unsigned i = 0; i < phnum; ++i) {
+        const char *which;
+
+        switch (phdr[i].p_type) {
+        case PT_PHDR:
+            which = "PT_PHDR";
+            break;
+        case PT_NOTE:
+            which = "PT_NOTE";
+            break;
+        case PT_DYNAMIC:
+            dynamic_ofs = phdr[i].p_offset;
+            dynamic_addr = phdr[i].p_vaddr;
+            which = "PT_DYNAMIC";
+            break;
+        default:
+            continue;
+        }
+        if (first_segsz < phdr[i].p_vaddr + phdr[i].p_filesz) {
+            fprintf(stderr, "LOAD segment does not cover %s\n", which);
+            errors++;
+        }
+    }
+    if (errors) {
+        exit(EXIT_FAILURE);
+    }
+
+    /* Relocate the program headers. */
+    for (unsigned i = 0; i < phnum; ++i) {
+        output_reloc(outf, buf, &phdr[i].p_vaddr);
+        output_reloc(outf, buf, &phdr[i].p_paddr);
+    }
+
+    /* Relocate the DYNAMIC entries. */
+    if (dynamic_addr) {
+        ElfN(Dyn) *dyn = buf + dynamic_ofs;
+        __typeof(dyn->d_tag) tag;
+
+        do {
+
+            if (need_bswap) {
+                elfN(bswap_dyn)(dyn);
+            }
+            tag = dyn->d_tag;
+
+            switch (tag) {
+            case DT_HASH:
+            case DT_SYMTAB:
+            case DT_STRTAB:
+            case DT_VERDEF:
+            case DT_VERSYM:
+            case DT_PLTGOT:
+            case DT_ADDRRNGLO ... DT_ADDRRNGHI:
+                /* These entries store an address in the entry. */
+                output_reloc(outf, buf, &dyn->d_un.d_val);
+                break;
+
+            case DT_NULL:
+            case DT_STRSZ:
+            case DT_SONAME:
+            case DT_DEBUG:
+            case DT_FLAGS:
+            case DT_FLAGS_1:
+            case DT_SYMBOLIC:
+            case DT_BIND_NOW:
+            case DT_VERDEFNUM:
+            case DT_VALRNGLO ... DT_VALRNGHI:
+                /* These entries store an integer in the entry. */
+                break;
+
+            case DT_SYMENT:
+                if (dyn->d_un.d_val != sizeof(ElfN(Sym))) {
+                    fprintf(stderr, "VDSO has incorrect dynamic symbol size\n");
+                    errors++;
+                }
+                break;
+
+            case DT_REL:
+            case DT_RELSZ:
+            case DT_RELA:
+            case DT_RELASZ:
+                /*
+                 * These entries indicate that the VDSO was built incorrectly.
+                 * It should not have any real relocations.
+                 * ??? The RISC-V toolchain will emit these even when there
+                 * are no relocations.  Validate zeros.
+                 */
+                if (dyn->d_un.d_val != 0) {
+                    fprintf(stderr, "VDSO has dynamic relocations\n");
+                    errors++;
+                }
+                break;
+            case DT_RELENT:
+            case DT_RELAENT:
+            case DT_TEXTREL:
+                /* These entries store an integer in the entry. */
+                /* Should not be required; see above. */
+                break;
+
+            case DT_NEEDED:
+            case DT_VERNEED:
+            case DT_PLTREL:
+            case DT_JMPREL:
+            case DT_RPATH:
+            case DT_RUNPATH:
+                fprintf(stderr, "VDSO has external dependencies\n");
+                errors++;
+                break;
+
+            default:
+                /* This is probably something target specific. */
+                fprintf(stderr, "VDSO has unknown DYNAMIC entry (%lx)\n",
+                        (unsigned long)tag);
+                errors++;
+                break;
+            }
+            dyn++;
+        } while (tag != DT_NULL);
+        if (errors) {
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    /* Relocate the dynamic symbol table. */
+    if (dynsym_idx) {
+        ElfN(Sym) *sym = buf + shdr[dynsym_idx].sh_offset;
+        unsigned sym_n = shdr[dynsym_idx].sh_size / sizeof(*sym);
+
+        for (unsigned i = 0; i < sym_n; ++i) {
+            output_reloc(outf, buf, &sym[i].st_value);
+        }
+    }
+
+    /* Search both dynsym and symtab for the signal return symbols. */
+    if (dynsym_idx) {
+        elfN(search_symtab)(shdr, dynsym_idx, buf, need_bswap);
+    }
+    if (symtab_idx) {
+        elfN(search_symtab)(shdr, symtab_idx, buf, need_bswap);
+    }
+}
diff --git a/linux-user/meson.build b/linux-user/meson.build
index 7171dc60be..e4cb70ed2d 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -28,9 +28,13 @@ linux_user_ss.add(when: 'TARGET_HAS_BFLT', if_true: files('flatload.c'))
 linux_user_ss.add(when: 'TARGET_I386', if_true: files('vm86.c'))
 linux_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING', if_true: files('semihost.c'))
 
-
 syscall_nr_generators = {}
 
+gen_vdso_exe = executable('gen-vdso', 'gen-vdso.c',
+                          native: true, build_by_default: false)
+gen_vdso = generator(gen_vdso_exe, output: '@BASENAME@.c.inc',
+                     arguments: ['-o', '@OUTPUT@', '@EXTRA_ARGS@', '@INPUT@'])
+
 subdir('alpha')
 subdir('arm')
 subdir('hppa')
-- 
2.34.1


